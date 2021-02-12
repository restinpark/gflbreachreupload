if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/weapon_l4d2_crowbar" )
SWEP.DrawWeaponInfoBox	= false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_l4d2_crowbar", "vgui/hud/weapon_l4d2_crowbar", Color( 0, 0, 0, 255 ) )
end

SWEP.PrintName = "Crowbar"

SWEP.Category = "Left 4 Dead 2"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/weapons/melee/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip = false

SWEP.SwayScale = 0.5
SWEP.BobScale = 0.5

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 5
SWEP.Slot = 0
SWEP.SlotPos = 2
SWEP.ItemType = WEAPON_MELEE or 3

SWEP.UseHands = false
SWEP.HoldType = "melee"
SWEP.FiresUnderwater = true
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"

SWEP.WalkSpeed = 250
SWEP.RunSpeed = 500

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Melee = 0

SWEP.Primary.Sound = Sound( "Crowbar.Miss" )
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Damage = 25
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Delay = 0.33
SWEP.Primary.Force = 10000

SWEP.Secondary.Sound = Sound( "Weapon.Swing" )
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Damage = 10
SWEP.Secondary.Delay = 0.73
SWEP.Secondary.Force = 5000

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
self.Idle = 0
self.IdleTimer = CurTime() + 1
end

function SWEP:Deploy()
self:SetWeaponHoldType( self.HoldType )
self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.Melee = 0
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
--self.Owner:SetWalkSpeed( self.WalkSpeed )
--self.Owner:SetRunSpeed( self.RunSpeed )
end

function SWEP:Holster()
if self.Melee == 1 then return end
self.Idle = 0
self.IdleTimer = CurTime()
--:SetWalkSpeed( 200 )
--self.Owner:SetRunSpeed( 400 )
return true
end

function SWEP:PrimaryAttack()
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
self.Owner:SetAnimation( PLAYER_ATTACK1 )
self.Owner:EmitSound( self.Primary.Sound )
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Melee = 1
timer.Simple( 0.15, function()
if self.Melee == 1 then
self.Owner:LagCompensation( true )
local tr = util.TraceLine( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 80,
filter = self.Owner,
mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
tr = util.TraceHull( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 80,
filter = self.Owner,
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 0 ),
mask = MASK_SHOT_HULL,
} )
end
if SERVER and tr.Hit and !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) then
self.Owner:EmitSound( "Crowbar.ImpactWorld" )
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
dmginfo:SetDamageForce( self.Owner:GetForward() * self.Primary.Force )
tr.Entity:TakeDamageInfo( dmginfo )
if tr.Hit then
if tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 then
self.Owner:EmitSound( "Crowbar.ImpactFlesh" )
end
if !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) then
self.Owner:EmitSound( "Crowbar.ImpactWorld" )
end
end
end
self.Owner:ViewPunchReset()
self.Owner:ViewPunch( Angle( 10 * self.Primary.Recoil, -5 * self.Primary.Recoil, 5 * self.Primary.Recoil ) )
self.Melee = 0
end
end )
end

function SWEP:SecondaryAttack()
self.Owner:EmitSound( self.Secondary.Sound )
self.Owner:LagCompensation( true )
local tr = util.TraceLine( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
filter = self.Owner,
mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
tr = util.TraceHull( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
filter = self.Owner,
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 0 ),
mask = MASK_SHOT_HULL,
} )
end
if SERVER and tr.Hit and !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) then
self.Owner:EmitSound( "Weapon.HitWorld" )
end
if SERVER and IsValid( tr.Entity ) then
local dmginfo = DamageInfo()
local attacker = self.Owner
if !IsValid( attacker ) then
attacker = self
end
dmginfo:SetAttacker( attacker )
dmginfo:SetInflictor( self )
dmginfo:SetDamage( self.Secondary.Damage )
dmginfo:SetDamageForce( self.Owner:GetForward() * self.Secondary.Force )
tr.Entity:TakeDamageInfo( dmginfo )
if tr.Hit then
if tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 then
self.Owner:EmitSound( "Weapon.HitInfected" )
end
if !( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) then
self.Owner:EmitSound( "Weapon.HitWorld" )
end
end
end
self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND )
self:SetNextPrimaryFire( CurTime() + self.Secondary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Reload()
end

function SWEP:Think()
if self.Idle == 0 and self.IdleTimer > CurTime() and self.IdleTimer < CurTime() + 0.1 then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
self.Idle = 1
end
end

function SWEP:GetBetterOne()
	local r = math.random(1,100)
	if r < 100 then
		return "toybox_crowbar"
	else
		return "toybox_crowbar"
	end
end