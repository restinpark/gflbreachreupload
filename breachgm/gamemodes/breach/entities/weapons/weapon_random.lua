AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "chan_man1"
SWEP.Contact		= ""
SWEP.Purpose		= "Random"
SWEP.Instructions	= "LMB to commence randomification on a target, RMB to go a little faster, Reload to break glass and gates"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "Randominator"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.AttackDelay			= 10
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
SWEP.Secondary.Automatic	= false
SWEP.NextAttackW			= 0
SWEP.SFXCooldown = 0
SWEP.NextPrep				= 0
SWEP.PrepDelay				= 20

SWEP.NextSurg				= 0
SWEP.SurgDelay				= 45
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
	//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if self.NextAttackW > CurTime() then return end
	self.NextAttackW = CurTime() + self.AttackDelay
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
				if ent:Team() == TEAM_SPEC then return end
				if ent:GetNClass() == ROLE_RANDOM then return end
				if roundtype and roundtype.name and roundtype.name == "WTF IS GOING ON?!?" then
					table.Random(RAND)["func"](ent)
					ent:SetTeam(table.Random({TEAM_SCP, TEAM_GUARD, TEAM_SCI, TEAM_CLASSD, TEAM_CLASSE}))
					ent:SetPos(table.Random(SPAWN_SCIENT))
				end
				--SCP294: Prevent the coffee exploit
				ent.BR_HasSpeedBoost = false
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 1, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(2, 1), self.Owner, self.Owner )
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
if self.NextPrep > CurTime() then return
	end
	self.NextPrep = CurTime() + self.PrepDelay
	local ply = self.Owner

	ply:SetWalkSpeed(500)
	ply:SetRunSpeed(500)
	ply:SetMaxSpeed(500)
	ply:SetJumpPower(200)
	local function RemoveBuff()

		ply:SetWalkSpeed(260)
		ply:SetRunSpeed(260)
		ply:SetMaxSpeed(260)
		ply:SetJumpPower(200)
	end
	timer.Create("SCP_PLAYER_WILL_LOSE_BUFF" .. ply:SteamID(), 2, 1, RemoveBuff)
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext1 = "Ready to Attack"
	local showcolor1 = Color(0,255,0)

	if self.NextAttackW > CurTime() then
		showtext1 = "Next attack in " .. math.Round(self.NextAttackW - CurTime())
		showcolor1 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext1,
		pos = { ScrW() / 2, ScrH() - 75 },
		font = "173font",
		color = showcolor1,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext2 = "Speed Boost Ready!"
	local showcolor2 = Color(0,255,0)

	if self.NextPrep > CurTime() then
		showtext2 = "Preparing to go ham " .. math.Round(self.NextPrep - CurTime())
		showcolor2 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2, ScrH() - 50 },
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
