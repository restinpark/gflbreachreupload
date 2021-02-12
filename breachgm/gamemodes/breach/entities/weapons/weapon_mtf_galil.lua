AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/gfx/vgui/galil")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Aurora"
SWEP.Contact		= "Steam"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 55
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "ar2"
SWEP.ViewModel		= "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_galil.mdl"
SWEP.PrintName		= "Galil"
SWEP.Base			= "weapon_breach_base"
SWEP.DrawCrosshair	= false
SWEP.Slot			= 3
SWEP.Spawnable		= true

SWEP.betterone = "weapon_chaos_ak47"
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Sound			= Sound("weapons/galil/galil-1.wav")
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Recoil			= 2.55
SWEP.Primary.Cone			= 0.0175
SWEP.Primary.Delay			= 0.08
SWEP.Secondary.Sound = Sound("weapons/galil/galil-1.wav")
SWEP.Secondary.Ammo			= "none"
SWEP.DeploySpeed			= 1
SWEP.Damage					= 8
SWEP.HeadshotMultiplier		= 1.6
SWEP.UseHands				= true

SWEP.CSMuzzleFlashes 		= true
SWEP.CSMuzzleX				= true

SWEP.droppable				= true
SWEP.teams					= {2, 3, 5, 6}
SWEP.IDK					= 76
SWEP.ZoomFov				= 90
SWEP.HasScope				= false
SWEP.DrawCustomCrosshair	= true
SWEP.HasSilencer = false
SWEP.IsSilenced = false