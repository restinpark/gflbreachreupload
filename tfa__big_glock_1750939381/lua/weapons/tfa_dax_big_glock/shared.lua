SWEP.Base					= "tfa_gun_base"
SWEP.Category				= "TFA Daxble"
SWEP.Author					= "Daxble & Commando"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

// Generic Variables
SWEP.Manufacturer 			= "Hyper"
SWEP.PrintName				= "Big Glock"
SWEP.Slot					= 1
SWEP.Type 					= "Anti-materiel Pistol"

// Primary Sounds
SWEP.Primary.Sound 			= Sound("TFA_BIG_GLOCK.1")
SWEP.Primary.SilencedSound 	= Sound("TFA_BIG_GLOCK.2")

// Primary Stats
SWEP.Primary.Damage 			= 35
SWEP.Primary.NumShots 			= 1
SWEP.Primary.Automatic			= false
SWEP.Primary.RPM                	= 450

// Firemodes
SWEP.SelectiveFire 			= false
SWEP.DisableBurstFire 			= false
SWEP.OnlyBurstFire 			= false
SWEP.DefaultFireMode 			= ""
SWEP.FireModeName 			= nil

// Primary Ammo
SWEP.Primary.ClipSize 			= 17
SWEP.Primary.DefaultClip 		= 36
SWEP.Primary.Ammo 			= "pistol"
SWEP.DisableChambering 			= false

// Recoil
SWEP.Primary.KickUp 			= 9
SWEP.Primary.KickDown 			= 1
SWEP.Primary.KickHorizontal 		= 0.3
SWEP.Primary.StaticRecoilFactor	= 0.200
SWEP.Primary.Knockback = 150

// Spread
SWEP.Primary.Spread 			= .1
SWEP.Primary.SpreadMultiplierMax 	= 2
SWEP.Primary.SpreadIncrement		= 0.1
SWEP.Primary.SpreadRecovery 		= 1.2

// Accuracy
SWEP.Primary.IronAccuracy 		= .01

// Range
SWEP.Primary.Range 			= ( 750 * 3.282 ) * 16
SWEP.Primary.RangeFalloff 		= 0.8

// Move SPeed
SWEP.MoveSpeed 				= 0.75
SWEP.IronSightsMoveSpeed 		= SWEP.MoveSpeed  * 0.9

// Viewmodel
SWEP.ViewModel				= "models/weapons/daxble/c_dax_bigglock.mdl"
SWEP.UseHands 				= true
SWEP.ViewModelFOV				= 70

// Sensitivity
SWEP.IronSightsSensitivity 		= 1

// Ironsights
SWEP.IronSightsPos 			= Vector(-3.52, 4, 0.16)
SWEP.IronSightsAng 			= Vector(-0.84, 0, 2)
SWEP.Secondary.IronFOV 		= 70

// Sprint
SWEP.RunSightsPos 			= Vector(5, -2, 0)
SWEP.RunSightsAng 			= Vector(-12, 30, 0)

// Inspect ( C_Menu )
SWEP.InspectPos 				= Vector(5, -5, -2.787)
SWEP.InspectAng 				= Vector(22.386, 34.417, 5)

// Shell Eject
SWEP.LuaShellEject 			= true
SWEP.LuaShellEjectDelay 		= 0.05
SWEP.LuaShellEffect 			= "PistolShellEject"
SWEP.LuaShellScale = 3

// Attachments

if TFA.INS2 then

	SWEP.MuzzleAttachmentSilenced = 3

	SWEP.LaserSightModAttachment = 1
	SWEP.LaserSightModAttachmentWorld = 4

	SWEP.WElements = {
		["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_sil_pistol.mdl", bone = "root", rel = "", pos = Vector(0, -103.5, 45), angle = Angle(0, -90, 0), size = Vector(3, 3, 3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false }
	}

	SWEP.VElements = {
		["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_suppressor_pistol.mdl", bone = "root", rel = "", pos = Vector(0, 18.9, 6), angle = Angle(0, -90, 0), size = Vector(3, 3, 3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} , active = false },
		["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "root", rel = "", pos = Vector(0, 16.9, 2.39), angle = Angle(0, 270, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false }
	}

	SWEP.Attachments = {
		[1] = { offset = { 0, 0 }, atts = { "ins2_br_supp" }, order = 1 },
		[8] = { offset = { 0, 0 }, atts = { "ins2_ub_laser" }, order = 3 }
	}

end

// Worldmodel
SWEP.WorldModel				= "models/weapons/daxble/w_dax_bigglock.mdl"
SWEP.HoldType 				= "ar2"
SWEP.Offset = {
	Pos = {
		Up = -5,
		Right = 7,
		Forward = -15
	},
	Ang = {
		Up = 2,
		Right = -20,
		Forward = 180
	},
	Scale = 1.4
}

DEFINE_BASECLASS( SWEP.Base )
