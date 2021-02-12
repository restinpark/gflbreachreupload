-- Variables that are used on both client and server
SWEP.Gun = ("tfa_csgo_mag7")					-- must be the name of your swep
SWEP.Category				= "TFA CS:GO"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "MAG-7"		-- Weapon name (Shown on HUD)	
SWEP.Slot = 3
SWEP.SlotPos = 10
SWEP.ItemType = WEAPON_GUN or 6
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.DefaultHoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.UseHands = true


SWEP.ViewModelFOV		= 56
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_shot_mag7.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_mag7.mdl"	-- Weapon world model
SWEP.Base				= "tfa_csgo_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = true

SWEP.Primary.Sound			= Sound("TFA_CSGO_MAG7.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 70.59  			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 5		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 0.8	-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.8		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.7		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "buckshot"
SWEP.NearlyEmpty_ClipSize = 0

SWEP.Shotgun = false

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 6		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 7	-- Base damage per bullet
SWEP.Primary.Spread		= .04	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .035 -- Ironsight accuracy, should be the same for shotguns

SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 5/30
SWEP.LuaShellEffect = "ShotgunShellEject" --Defaults to blowback

-- Enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector(-6.375, -4, 3.168)
SWEP.IronSightsAng = Vector(0.385, 0, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)
--SWEP.InspectPos = Vector(0,0,0)
--SWEP.InspectAng = Vector(0,0,0)

SWEP.DisableIdleAnimations = false
SWEP.ForceDryFireOff = true
SWEP.ForceEmptyFireOff = true
SWEP.FidgetLoop = false --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.Primary.Range = 500

SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 1
SWEP.Primary.SpreadMultiplierMax = 2

SWEP.CustomMuzzleFlash = true
SWEP.AutoDetectMuzzleAttachment = false
SWEP.MuzzleFlashEffect = "tfa_csgo_muzzle_autoshotgun"


SWEP.TracerParticleName = "weapon_tracers_shot"

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3.2,
        Right = 1.0,
        Forward = 6,
        },
        Ang = {
        Up = 3,
        Right = 82,
        Forward = 178
        },
		Scale = 1.3
}

SWEP.Blowback_Shell_Effect = "ShotgunShellEject"

SWEP.BlowbackEnabled = false

SWEP.Skins = { }

SWEP.ViewModelBoneMods = {
	["v_weapon.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0.2, -0.201, 0), angle = Angle(0, 0, 0) }
}

SWEP.MoveSpeed = 225/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 225/260*0.8 --Multiply the player's movespeed by this when sighting.
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 32 / 30
}

SWEP.MagModel = Model("models/weapons/tfa_csgo/w_shot_mag7_mag.mdl")
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ time = 21 / 30, type = "lua", value = function(wep,vm) wep:DropMag() end, client = true, server = true },
	}
}