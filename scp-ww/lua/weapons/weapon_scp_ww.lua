AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "chan_man1"
SWEP.Contact		= ""
SWEP.Purpose		= "Write"
SWEP.Instructions	= "LMB to write a cognitohazard on any surface, RMB to open your eye and hurt all enemies close to you. Break Glass or Gates with Reload."

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "Writer on the Walls"
SWEP.Category 		= "SCP"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.AttackDelay			= 0.25
SWEP.ISSCP = true
SWEP.droppable				= false
SWEP.teams					= {1}
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.NextAttackW			= 0
SWEP.CognitoPlace			= 0
SWEP.CognitoDelay 			= 15
SWEP.Eye					= 0
SWEP.EyeDelay				= 25


function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:Think()
end

function SWEP:Reload()
if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
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
			if ent:GetClass() == "func_breakable" then
				if SERVER then
					ent:TakeDamage( 300, self.Owner, self.Owner )
				end
			elseif SERVER and BREACH_IsGateDoor(ent) then
				ent:TakeDamage( math.random(150, 200), self.Owner, self.Owner )
			end
		end
end

function SWEP:PrimaryAttack()
	if preparing or postround then return end
	if self.CognitoPlace > CurTime() then return end
	self.CognitoPlace = CurTime() + self.CognitoDelay
	if SERVER then 
	local t = util.GetPlayerTrace(self.Owner)
		t.mask = MASK_SOLID_BRUSHONLY
		local trace = util.TraceLine( t )
		local hp
		if trace.Hit then
			hp = trace.HitPos
			local ent = ents.Create("ent_cognito")
			ent.HitPos = hp
			ent:SetPos(hp)
			ent:Spawn()
			ent.Owner = self.Owner
			ent:EmitSound("ambient/machines/combine_shield_loop3.wav", 50, 100)
		else
			self.CognitoPlace = 0
			return
		end
	end
end

function SWEP:SecondaryAttack()
	if preparing or postround then return end
	if self.Eye > CurTime() then return end
	self.Eye = CurTime() + self.EyeDelay
		if SERVER then
			self.Owner:TakeDamage()
			self.Owner:EmitSound("ambient/machines/wall_move5.wav", 35, 80)
			for k, v in pairs(ents.FindInSphere(self.Owner:GetPos(),75)) do
				if v:IsPlayer() then
					if v:Team() != TEAM_SCP and v:Team() != TEAM_SPEC and self.Owner and IsValid(self.Owner) then
					if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					local
					self = v:GetActiveWeapon()if
					self&&self.ISSCP
					then
					continue
				end
					v:Ignite(10) 
					v:TakeDamage(20)
				end
			end
		end
	end	
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to Write"
	local showcolor = Color(0,255,0)

	if self.CognitoPlace > CurTime() then
		showtext = "Next writing in " .. math.Round(self.CognitoPlace - CurTime())
		showcolor = Color(255,0,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext2 = "Ready to Open Eye"
	local showcolor2 = Color(0,255,0)

	if self.Eye > CurTime() then
		showtext2 = "Next opening in " .. math.Round(self.Eye - CurTime())
		showcolor2 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor2,
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