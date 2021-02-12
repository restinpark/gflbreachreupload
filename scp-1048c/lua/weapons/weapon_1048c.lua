AddCSLuaFile()



if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Aurora/chan_man1"
SWEP.Contact		= "GFL Forums"
SWEP.Purpose		= "Lunge"
SWEP.Instructions	= "Primary to attack, Secondary to lunge, Reload to Attach."
SWEP.Category = "Aurora's SWEPs"
SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_357.mdl"
SWEP.WorldModel		= "models/weapons/v_357.mdl"
SWEP.PrintName		= "SCP-1048-C"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= false

SWEP.AttackDelay			= 0.25
SWEP.droppable				= false
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.NextAttack = 0
SWEP.Primary.Delay = 0.4

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Automatic	= false
SWEP.Secondary.NextAttack = 0
SWEP.Secondary.Delay = 10
SWEP.NextAttackW = 0
SWEP.AttackDelay = 2
SWEP.NextAttach = 0
SWEP.AttachDelay = 10
SWEP.Primary.Delay = 2
SWEP.Primary.Damage = 20
SWEP.oldv = 60
SWEP.AttackIsActive = false
function SWEP:Initialize()
	self:SetHoldType("melee")
end
function SWEP:Deploy()
	self.Owner:DrawViewModel( false )

	--self.Owner:SetViewOffset(Vector(0,0,30))
end
function SWEP:DrawWorldModel() end
function SWEP:Holster()
	--self.Owner:SetViewOffset(Vector(0,0,60))
	return true
end
function SWEP:PrimaryAttack()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if self.NextAttackW > CurTime() then return end
	self.NextAttackW = CurTime() + self.AttackDelay
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
			if ent:IsPlayer() and ent:Team() != TEAM_SCP and ent:Team() != TEAM_SPEC then
				local effectdata = EffectData()
				effectdata:SetOrigin( ent:GetPos() + Vector(0,0,30) )
				self.Owner:EmitSound(Sound("1048b.wav"), 75, 100, 1, CHAN_AUTO)
				util.Effect( "BloodImpact", effectdata )
				if SERVER then
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end

					ent:TakeDamage(table.Random({25, 30, 35, 40, 45, 50}), self.Owner, self.Owner )

				end
			end
			if ent:GetClass() == "func_breakable" then
				if SERVER then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				end
			elseif SERVER and BREACH_IsGateDoor(ent) then
				ent:TakeDamage( math.random(25, 100), self.Owner, self.Owner )
			end
		end
end
function SWEP:SecondaryAttack()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if (CurTime() < self.Secondary.NextAttack) then return end
	self.Secondary.NextAttack = CurTime() + self.Secondary.Delay
	self.Owner:SetPos(self.Owner:GetPos() + Vector(0,0,10))
	self.Owner:SetVelocity(self.Owner:GetAimVector() * 750 )
end

function SWEP:Reload()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if self.NextAttach > CurTime() then return end
	self.NextAttach = CurTime() + self.AttachDelay
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
				if SERVER then
				local pos = Vector(ent:GetPos())
					self.Owner:SetPos(pos)
					ent:TakeDamage(table.Random({5, 10, 15, 20}), self.Owner, self.Owner )
					ent:TakeDamage(table.Random({5, 10, 15, 20}), self.Owner, self.Owner )
					ent:TakeDamage(table.Random({5, 10, 15, 20}), self.Owner, self.Owner )
					ent:TakeDamage(table.Random({5, 10, 15, 20}), self.Owner, self.Owner )
					ent:TakeDamage(table.Random({5, 10, 15, 20}), self.Owner, self.Owner )
			end
		end
	end
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Lunge is ready!"
	local showcolor = Color(0,255,0)

	if self.Secondary.NextAttack > CurTime() then
		showtext = "Next lunge in " .. math.Round(self.Secondary.NextAttack - CurTime())
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

	local showtext2 = "Attach is ready!"
	local showcolor2 = Color(0,255,0)

	if self.NextAttach > CurTime() then
		showtext2 = "Next attach in " .. math.Round(self.NextAttach - CurTime())
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



