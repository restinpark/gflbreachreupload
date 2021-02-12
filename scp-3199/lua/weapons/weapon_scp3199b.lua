--Dogshit
AddCSLuaFile()

SWEP.PrintName = "SCP-3199-A"
SWEP.Author = "chan_man1"
SWEP.Instructions = "Primary attack will hurt your target. Secondary attack will lay an egg. Reload to spit acid."
SWEP.ItemType = WEAPON_SCP or 12
SWEP.droppable = false

function SWEP:Equip(newowner)
    local e = newowner
    timer.Simple(0, function ()
        if e and IsValid(e) and e:IsPlayer() then
            e:DrawViewModel(false)
        end
    end)
end

function SWEP:DrawWorldModel() end

function SWEP:Initialize()
	self:SetHoldType("melee")
    util.PrecacheSound("acid/vomit.wav")
	util.PrecacheSound("npc/antlion/antlion_burst1.wav")
    util.PrecacheSound("npc/antlion/antlion_burst2.wav")
	util.PrecacheModel("models/spitball_large.mdl")
	util.PrecacheModel("models/spitball_medium.mdl")
	util.PrecacheModel("models/spitball_small.mdl")
end 
SWEP.Spit = 0
SWEP.SpitDelay = 15

function SWEP:Reload() return end

SWEP.NextAttack1 = 0
SWEP.AttackDelay1 = 0.1
function SWEP:PrimaryAttack()
	if self.NextAttack1 > CurTime() then return end
	self.NextAttack1 = CurTime() + self.AttackDelay1
	if SERVER then
		local ent = nil
		local tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 ),
			filter = self.Owner,
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			mask = MASK_SHOT_HULL
		} )
		ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				ent:TakeDamage(20)
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(100, 200), self.Owner, self.Owner )
				end
			end
		end
	end
end
function SWEP:SecondaryAttack()
if self.Spit > CurTime() then return end
	self.Spit = CurTime() + self.SpitDelay
	if SERVER then
    self.Owner:EmitSound("acid/vomit.wav")
	if IsValid(self) and IsValid(self.Owner) then
	self.Owner:SetNetworkedFloat("vomit_time", 2.0 + CurTime())
	if SERVER then
    self.Owner:SendLua("util.ScreenShake( LocalPlayer():GetPos() ,1.4,4,1,2)")
	end
	local SpitTypes = {
            "models/spitball_large.mdl",
            "models/spitball_medium.mdl",
            "models/spitball_small.mdl"
    }
	for i=1,5 do
	local acid = ents.Create("grenade_spit")
	acid:SetPos(self.Owner:GetShootPos() + Vector(math.Rand(5,-5),math.Rand(5,-5),0))
	acid:SetAngles(self.Owner:GetAngles())
	acid:Spawn()
	acid:SetOwner(self.Owner)
	acid:SetNWBool("ScriptedAcid",true)
	acid:SetVelocity(self.Owner:GetAimVector()*500 + VectorRand()*50)
	acid:SetModel(table.Random(SpitTypes))
	end
	end
	end
	end

hook.Add("EntityTakeDamage", "Scale3199Damage", function (entity, info)
    if IsValid(entity) and entity:IsPlayer() and entity:GetNClass() == ROLE_SCP3199 and entity:GetNWBool("SCP3199_Rooted", false) then
        info:ScaleDamage(0.3)
    end
end)

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext1 = "Ready to spit"
	local showcolor1 = Color(0,255,0)

	if self.Spit > CurTime() then
		showtext1 = "Next acid spit in " .. math.Round(self.Spit - CurTime())
		showcolor1 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext1,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor1,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( 0, 255, 0, 255 )

	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
end

