AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/gfx/vgui/xm1014")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Aurora"
SWEP.Contact		= "Steam"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 54
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "shotgun"
SWEP.ViewModel 		= "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel		= "models/weapons/w_shot_xm1014.mdl"
SWEP.PrintName		= "Shotgun"
SWEP.Base			= "weapon_breach_base"
SWEP.DrawCrosshair	= false
SWEP.Slot			= 3
SWEP.Spawnable		= true

--SWEP.betterone = "weapon_chaos_ak47"
SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Sound			= Sound("Weapon_XM1014.Single")
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"
SWEP.Primary.NumShots		= 8
SWEP.Primary.Recoil			= 7
SWEP.Primary.Cone			= 0.085
SWEP.Primary.Delay			= 0.8

SWEP.Secondary.Ammo			= "none"
SWEP.DeploySpeed			= 1
SWEP.Damage					= 7
SWEP.HeadshotMultiplier		= 1.6
SWEP.UseHands				= true

SWEP.CSMuzzleFlashes 		= true
SWEP.CSMuzzleX				= true

SWEP.droppable				= true
SWEP.teams					= {2, 3, 5, 6}
SWEP.IDK					= 90
SWEP.ZoomFov				= 90
SWEP.HasScope				= false
SWEP.DrawCustomCrosshair	= true


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	timer.Destroy("needtoscope" .. self.Owner:SteamID())
	self.IsReloading = false
	if self.HasSilencer then
		if self.IsSilenced then
			self.Weapon:EmitSound(self.Secondary.Sound, 50,100,0.5)
		else
			self.Weapon:EmitSound(self.Primary.Sound)
		end
	else
		self.Weapon:EmitSound(self.Primary.Sound)
	end
	local cone = 0.01
	if self.IsScoping then
		cone = self.Primary.Cone / 2
	else
		cone = self.Primary.Cone
	end
	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
	self:TakePrimaryAmmo( 1 )
	self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, cone )
end