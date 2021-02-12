--Dogshit
AddCSLuaFile()

SWEP.PrintName = "SCP-3199"
SWEP.Author = "chan_man1"
SWEP.Instructions = "Primary attack will hurt your target. Secondary attack will lay an egg."
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
end

function SWEP:Reload() end
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
SWEP.NextAttack2 = 0
SWEP.AttackDelay2 = 120
function SWEP:SecondaryAttack()
    if preparing or postround then return end
    if not IsFirstTimePredicted() then return end
    if self.NextAttack2 > CurTime() then return end
    self.NextAttack2 = CurTime() + self.AttackDelay2
    if SERVER then
        self.Owner:SetNWBool("SCP3199_Rooted", true)
        self.Owner:Freeze(true)
        local e2 = self
        local tid = tostring(self.Owner:SteamID64()) .. "_SCP3199Unroot_" .. tostring(math.random(1, 10000))
        timer.Create(tid, 5, 1, function ()
            local nest = ents.Create("ent_scp_3199_egg")
            if IsValid(nest) then
                nest:SetPos(e2.Owner:GetPos())
                nest:Spawn()
                nest:SetState(true)
                timer.Simple(30, function ()
                    if nest and IsValid(nest) then
                    SafeRemoveEntity(nest)
                    end
                end)
            end
            e2.Owner:SetNWBool("SCP3199_Rooted", false)
            e2.Owner:Freeze(false)
        end)
    end
end

hook.Add("EntityTakeDamage", "Scale3199Damage", function (entity, info)
    if IsValid(entity) and entity:IsPlayer() and entity:GetNClass() == ROLE_SCP3199 and entity:GetNWBool("SCP3199_Rooted", false) then
        info:ScaleDamage(0.3)
    end
end)

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to lay an egg"
	local showcolor = Color(0,255,0)

	if self.NextAttack2 > CurTime() then
		showtext = "Next egg in " .. math.Round(self.NextAttack2 - CurTime())
		showcolor = Color(255,0,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 30 },
		font = "173font",
		color = showcolor,
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
