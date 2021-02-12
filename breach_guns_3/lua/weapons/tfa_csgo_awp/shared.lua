-- Variables that are used on both client and server
SWEP.Gun = ("tfa_csgo_awp")					-- must be the name of your swep
SWEP.Category				= "TFA CS:GO"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "AWP"		-- Weapon name (Shown on HUD)	
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
SWEP.UseHands = true

SWEP.ViewModelFOV		= 56
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_snip_awp.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_awp.mdl"	-- Weapon world model
SWEP.Base				= "tfa_csgo_base"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("TFA_CSGO_AWP.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 41.24 			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 50		-- Bullets you start with
SWEP.Primary.KickUp				= 1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"
SWEP.NearlyEmpty_ClipSize = 0

SWEP.IronInSound = Sound("TFA_CSGO_AWP.Zoom") --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound("TFA_CSGO_AWP.Zoom") --Sound to play when ironsighting out?  nil for default

--SWEP.Secondary.ScopeZoom = 90 / 45
SWEP.Secondary.IronFOV	= 15		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 45	-- Base damage per bullet
SWEP.Primary.Spread		= .01	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .001 -- Ironsight accuracy, should be the same for shotguns

SWEP.BoltAction = true
--SWEP.BoltAction		= false

SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= false	-- I mean it, only one	
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	
SWEP.Secondary.UseAimpoint		= false
SWEP.Secondary.UseMatador		= false
SWEP.Secondary.ScopeTable = {
	["ScopeMaterial"] =  Material("tfa_csgo/scope_lens.png", "smooth"),
	["ScopeBorder"] = color_black,
	["ScopeCrosshair"] = { ["r"] = 0, ["g"]  = 0, ["b"] = 0, ["a"] = 255, ["s"] = 1 }
}

-- Enter iron sight info and bone mod info below
SWEP.Scoped = true --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.75 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.6 --Scale of the scope overlay
SWEP.ReticleScale = 0.5 --Scale of the reticle overlay

SWEP.IronSightsPos = Vector(-4.975, -4, 1.05)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)
--SWEP.InspectPos = Vector(0,0,0)
--SWEP.InspectAng = Vector(0,0,0)
SWEP.DisableIdleAnimations = false
SWEP.FidgetLoop = false --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.Primary.Range = 0.8/0.305*16*1000
SWEP.Primary.SpreadIncrement = 0.3
SWEP.Primary.SpreadRecovery = 2
SWEP.Primary.SpreadMultiplierMax = 2.5
 
SWEP.Offset = {
        Pos = {
        Up = -2.5,
        Right = 1,
        Forward = 5.5,
        },
        Ang = {
        Up = 0,
        Right = -9,
        Forward = 180,
        },
		Scale = 1.0
}

SWEP.RTMaterialOverride = nil

SWEP.RTScopeOffset = {11,2}
SWEP.RTScopeScale = {1,1}
SWEP.ScopeAngleTransforms = {
	{"P",90.3},
	{"Y",0.9}
}
SWEP.ScopeOverlayTransforms = {-5, 5}

SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 23/30
SWEP.LuaShellEffect = "RifleShellEject" --Defaults to blowback
SWEP.ShellParticleName = "weapon_shell_casing_50cal_fallback"

SWEP.FireModeName = "Bolt-Action"
SWEP.DisableChambering = true

SWEP.Skins = { }

SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_csgo_muzzle_awp"

--Tracer Stuff
SWEP.TracerCount 		= 0 	--0 disables, otherwise, 1 in X chance

SWEP.MoveSpeed = 200/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 100/260 --Multiply the player's movespeed by this.

DEFINE_BASECLASS(SWEP.Base)

SWEP.Secondary.ScopeScreenScale = 610/1080

SWEP.ShootWhileDraw=false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw=false --Can you reload while draw anim plays?
SWEP.SightWhileDraw=false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster=false --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster=false --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster=false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload=true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting=false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall=false --Can you reload when close to a wall and facing it?

SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 60 / 30
}

SWEP.MagModel = Model("models/weapons/tfa_csgo/w_snip_awp_mag.mdl")
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ time = 24 / 30, type = "lua", value = function(wep,vm) wep:DropMag() end, client = true, server = true }
	}
}