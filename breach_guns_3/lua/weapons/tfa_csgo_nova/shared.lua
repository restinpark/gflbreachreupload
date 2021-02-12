-- Variables that are used on both client and server
SWEP.Gun = ("tfa_csgo_nova")					-- must be the name of your swep
SWEP.Category				= "TFA CS:GO"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Nova"		-- Weapon name (Shown on HUD)	
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
SWEP.HoldType 				= "shotgun"		-- how others view you carrying the weapon
SWEP.UseHands = true

SWEP.Type					= "Shotgun"
SWEP.Type_Displayed			= "Cancelled"

SWEP.ViewModelFOV		= 56
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_shot_nova.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_nova.mdl"	-- Weapon world model
SWEP.Base				= "tfa_csgo_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("TFA_CSGO_NOVA.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 68.18 			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 8		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 1.0	-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.7		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.7		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "buckshot"
SWEP.NearlyEmpty_ClipSize = 1

SWEP.Shotgun = true
SWEP.ShellTime = 0.35

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 7		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 14	-- Base damage per bullet
SWEP.Primary.Spread		= .05	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .04 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector(-4.27, -4, 2.71)
SWEP.IronSightsAng = Vector(-0.185, 0, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)

SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 12/30
SWEP.LuaShellEffect = "ShotgunShellEject" --Defaults to blowback

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

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -3,
		Right = 1,
		Forward = 9,
	},
	Ang = {
		Up = 0,
		Right = 80,
		Forward = 178
	},
	Scale = 0.9
}

SWEP.Blowback_Shell_Effect = "ShotgunShellEject"

SWEP.BlowbackEnabled = false

SWEP.Skins = { }

SWEP.MoveSpeed = 220/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 220/260*0.8 --Multiply the player's movespeed by this when sighting.

SWEP.ShootWhileDraw=false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw=false --Can you reload while draw anim plays?
SWEP.SightWhileDraw=false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster=false --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster=false --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster=false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload=true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting=false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall=false --Can you reload when close to a wall and facing it?

SWEP.BoltTimerOffset = 0.1
SWEP.BoltAction_Forced = true
SWEP.FireModeName = "Pump-Action"

function SWEP:GetBetterOne()
	local r = math.random(1,100)
	if r < 100 then
		return "super_hexagun"
	else
		return "super_hexagun"
	end
end