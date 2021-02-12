AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/gfx/vgui/scout")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Aurora"
SWEP.Contact		= "Steam"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 55
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "smg"
SWEP.ViewModel		= "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_scout.mdl"
SWEP.PrintName		= "Scout"
SWEP.Base			= "weapon_breach_base"
SWEP.DrawCrosshair	= false
SWEP.Slot			= 3
SWEP.Spawnable		= true

SWEP.betterone = "weapon_chaos_ak47"
SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Sound			= Sound("weapons/scout/scout_fire-1.wav")
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "AR2"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Recoil			= 2.55
SWEP.Primary.Cone			= 0.0175
SWEP.Primary.Delay			= 1
SWEP.Secondary.Sound = Sound("weapons/zoom.wav")
SWEP.Secondary.Ammo			= "none"
SWEP.DeploySpeed			= 1
SWEP.Damage					= 52
SWEP.HeadshotMultiplier		= 1.6
SWEP.UseHands				= true

SWEP.CSMuzzleFlashes 		= true
SWEP.CSMuzzleX				= true

SWEP.droppable				= true
SWEP.teams					= {2, 3, 5, 6}
SWEP.IDK					= 76
SWEP.ZoomFov				= 90
SWEP.HasScope				= true
SWEP.DrawCustomCrosshair	= true
SWEP.HasSilencer = false
SWEP.IsSilenced = false
