if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName = "Morrowind Shortsword"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Category = "SCP-076-02"
SWEP.Author			= "Doug Tyrrell + Mad Cow (Revisions by Neotanks) For LUA (Models, Textures, ect. By: Hellsing/JJSteel)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.droppable = false
SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel      = "models/morrowind/dwemer/shortsword/v_dwemer_shortsword.mdl"
SWEP.WorldModel   = "models/morrowind/dwemer/shortsword/w_dwemer_shortsword.mdl"

SWEP.Primary.Damage		= 33
SWEP.Primary.NumShots		= 0
SWEP.Primary.Delay 		= 0.50

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

function SWEP:Precache()
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_deploy1.wav")
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_hitwall1.wav")
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_hit.wav")
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("melee2")
	self.Hit = {
	Sound( "weapons/shortsword/morrowind_shortsword_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/shortsword/morrowind_shortsword_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/shortsword/morrowind_shortsword_deploy1.wav")
	return true
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Owner:EmitSound( Sound("weapons/shortsword/morrowind_shortsword_slash.wav") )
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.Melee = 1
	timer.Simple( 0.15, function()
	if self.Melee == 1 then
	self.Owner:LagCompensation( true )
	local tr = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 125,
	filter = self.Owner,
	mask = MASK_SHOT_HULL,
	} )
	if !IsValid( tr.Entity ) then
	tr = util.TraceHull( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 125,
	filter = self.Owner,
	mins = Vector( -16, -16, 0 ),
	maxs = Vector( 16, 16, 0 ),
	mask = MASK_SHOT_HULL,
	} )
	end
	if SERVER and tr.Hit and !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) then
	self.Owner:EmitSound( Sound( "weapons/shortsword/morrowind_shortsword_hitwall1.wav" ) )
	end
	if SERVER and IsValid( tr.Entity ) then
	local dmginfo = DamageInfo()
	local attacker = self.Owner
	if !IsValid( attacker ) then
	attacker = self
	end
	dmginfo:SetAttacker( attacker )
	dmginfo:SetInflictor( self )
	dmginfo:SetDamage( self.Primary.Damage )
	dmginfo:SetDamageForce( self.Owner:GetForward() * 10000 )
	tr.Entity:TakeDamageInfo( dmginfo )
	if tr.Hit then
	if tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 then
	self.Owner:EmitSound( Sound("weapons/shortsword/morrowind_shortsword_hit.wav") )
	end
	if !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) then
	self.Owner:EmitSound( Sound( "weapons/shortsword/morrowind_shortsword_hitwall1.wav" ) )
	end
	end
	end
	self.Owner:ViewPunchReset()
	self.Owner:ViewPunch( Angle( 10 * 0.5, -5 * 0.5, 5 * 0.5 ) )
	self.Melee = 0
	end
	end )
end

function SWEP:Holster()
	if self:GetNextPrimaryFire() > CurTime() then return end
	return true
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	--if true then return end
	self.Weapon:EmitSound("weapons/shortsword/morrowind_shortsword_slash.wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)

	if (SERVER) then
		timer.Simple(0.25, function()
			if !self.Owner then return end
			local knife = ents.Create("ent_mor_shortsword")
			if IsValid(knife) then
				knife:SetAngles(self.Owner:EyeAngles())
				local pos = self.Owner:GetShootPos()
				pos = pos + self.Owner:GetForward() * 5
				pos = pos + self.Owner:GetRight() * 9
				pos = pos + self.Owner:GetUp() * -5
				knife:SetPos(pos)
				knife:SetOwner(self.Owner)
				knife.Weapon = self		-- Used to se the axe's model and the weapon it gives when used.
				knife:SetModel("models/morrowind/dwemer/shortsword/w_dwemer_shortsword.mdl")
				knife:Spawn()
				knife:Activate()
				local phys = knife:GetPhysicsObject()
				phys:SetVelocity(self.Owner:GetAimVector() * 1500)
				phys:AddAngleVelocity(Vector(0, 500, 0))
				self:Remove()
			end
			self.Owner:SetAnimation(PLAYER_ATTACK1)

		end)

	end
end
