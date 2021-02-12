-- Variables that are used on both client and server
SWEP.Gun = ("tfa_csgo_aug")					-- must be the name of your swep
SWEP.Category				= "TFA CS:GO"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "AUG"		-- Weapon name (Shown on HUD)
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
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_rif_aug.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_aug.mdl"	-- Weapon world model
SWEP.Base				= "tfa_csgo_base"
SWEP.Scoped = false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("TFA_CSGO_AUG.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 400			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 0.35		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.35		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"
SWEP.NearlyEmpty_ClipSize = 5

SWEP.IronInSound = Sound("TFA_CSGO_AUG.ZoomIn") --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound("TFA_CSGO_AUG.ZoomOut") --Sound to play when ironsighting out?  nil for default

--SWEP.Secondary.ScopeZoom = 90 / 45
SWEP.Secondary.IronFOV			= 45		-- How much you 'zoom' in. Less is more!

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 30	-- Base damage per bullet
SWEP.Primary.Spread		= .0001	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .003 -- Ironsight accuracy, should be the same for shotguns

SWEP.BoltAction		= false

SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= false	-- I mean it, only one
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false
SWEP.Secondary.UseAimpoint		= true
SWEP.Secondary.UseMatador		= false

-- Enter iron sight info and bone mod info below

SWEP.VElements = {
	["scopemask"] = { type = "Model", model = "models/weapons/tfa_csgo/v_rif_aug_scopelensmask.mdl", bone = "v_weapon.aug_Parent", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true },
	["reticle"] = { type = "Quad", bone = "v_weapon.aug_Parent", rel = "", pos = Vector(0, -6.395, 0), angle = Angle(180, 0, 0), size = 0.05, draw_func_outer = function(wep, p, a, s) TFA.CSGO.DrawScopeReticle(wep, p, a, s, "scopemask") end},
}

SWEP.IronSightsPos = Vector(-3.6, 0, 0.25)
SWEP.IronSightsAng = Vector(-0.88, -0.02, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)
--SWEP.InspectPos = Vector(0,0,0)
--SWEP.InspectAng = Vector(0,0,0)
SWEP.DisableIdleAnimations = false
SWEP.FidgetLoop = false --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.Primary.Range = 0.8/0.305*16*1000

SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 12
SWEP.Primary.SpreadMultiplierMax = 9

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -4.5,
		Right = 0.9,
		Forward = 3.5,
	},
	Ang = {
		Up = 2,
		Right = 80,
		Forward = 178
	},
	Scale = 1.2
}

SWEP.RTMaterialOverride = nil
SWEP.ScopeAngleTransforms = {
	{"P",90.1},
	{"R",131},
	{"P",-0.15},
}

SWEP.ScopeReticule_CrossCol = true
SWEP.ScopeReticule_Scale = {0.2,0.2}
SWEP.ScopeReticule = "scope/csgo_dot"
SWEP.ScopeOverlayTransforms = {-5, -25}

SWEP.BlowbackEnabled = true
SWEP.BlowbackVector = Vector(0,-1,0)
SWEP.Blowback_Shell_Effect = "RifleShellEject"
SWEP.BlowbackBoneMods = {
	["v_weapon.aug_Bolt"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -0.2), angle = Angle(0, 0, 0) }
}

SWEP.LuaShellEject = true --Entity to shoot's model
SWEP.LuaShellEffect = "RifleShellEject" --Defaults to blowback

SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_csgo_muzzle_assaultrifle"

--Tracer Stuff
SWEP.TracerCount 		= 3 	--0 disables, otherwise, 1 in X chance

SWEP.MoveSpeed = 220/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 150/260*0.8 --Multiply the player's movespeed by this when sighting.

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
	[ACT_VM_RELOAD] = 46 / 30
}

SWEP.MagModel = Model("models/weapons/tfa_csgo/w_rif_aug_mag.mdl")
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ time = 26 / 30, type = "lua", value = function(wep,vm) wep:DropMag() end, client = true, server = true }
	}
}

SWEP.AllowIronSightsDoF = false