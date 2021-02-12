-- Variables that are used on both client and server
SWEP.Gun = ("scp_127")					-- must be the name of your swep
SWEP.Category				= "TFA CS:GO"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "SCP-127"		-- Weapon name (Shown on HUD)	
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
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.DefaultHoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.UseHands = true


SWEP.ViewModelFOV		= 53
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_smg_mp5sd.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_smg_mp5sd.mdl"	-- Weapon world model
SWEP.Base				= "tfa_csgo_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = true --Silenced by default?

SWEP.Primary.Sound			= Sound("TFA_CSGO_MP5SD.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 750 			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 60		-- Size of a clip
SWEP.Primary.DefaultClip		= 60		-- Bullets you start with
SWEP.Primary.KickUp				= 0.1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.1		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= ""
SWEP.NearlyEmpty_ClipSize = 5

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 20	-- Base damage per bullet
SWEP.Primary.Spread		= .025	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .015 -- Ironsight accuracy, should be the same for shotguns

SWEP.SelectiveFire		= true

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.203, -4, 1.6)
SWEP.IronSightsAng = Vector(0.415, 0.005, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)
--SWEP.InspectPos = Vector(0,0,0)
--SWEP.InspectAng = Vector(0,0,0)
SWEP.DisableIdleAnimations = false
SWEP.FidgetLoop = false --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.Primary.Range = 0.3/0.305*16*1000
SWEP.Primary.SpreadIncrement = 0.3
SWEP.Primary.SpreadRecovery = 2
SWEP.Primary.SpreadMultiplierMax = 2.5
 
SWEP.Offset = {
        Pos = {
        Up = 0.5,
        Right = 1,
        Forward = 3,
        },
        Ang = {
        Up = 0,
        Right = 3,
        Forward = 180,
        },
		Scale = 1.2
}

SWEP.ViewModelBoneMods = {
	--["v_weapon.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -0.746), angle = Angle(0, 0, 0) }
}

SWEP.LuaShellEject = true --Entity to shoot's model
SWEP.LuaShellEffect = "ShellEject" --Defaults to blowback

SWEP.BlowbackEnabled = true
SWEP.Blowback_Shell_Effect = "ShellEject"
SWEP.BlowbackVector = Vector(0, -6, 0)
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_csgo_muzzle_assaultrifle_silenced"

SWEP.ShellEffectName = "tfa_shell_smg_csgo"
 	--Change to a string of your tracer name.  Can be custom.

SWEP.Skins = { }

SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 69 / 35
}

SWEP.MagModel = Model("models/weapons/tfa_csgo/w_smg_mp5sd_mag.mdl")
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ time = 40 / 30, type = "lua", value = function(wep,vm) wep:DropMag() end, client = true, server = true },
	}
}

SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 1 --Multiply the player's movespeed by this when sighting.


function SWEP:GetBetterOne()
	local r = math.random(1,100)
	if r < 100 then
		return "nope_sylveon_swep"
	else
		return "nope_sylveon_swep"
	end
end