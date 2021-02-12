SWEP.Base				= "tfa_gun_base"
SWEP.Category				= "TFA Dead Space" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "Bread / Nopeful / TFA" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = true --Draw the crosshair in ironsights?
SWEP.PrintName				= "Plasma Cutter"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("plasma_cutter_n.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("plasma_cutter_n.1") -- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 30 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = bit.bor(DMG_ALWAYSGIB,DMG_BULLET,DMG_AIRBOAT) --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 1 --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 1 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.RPM = 300 -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Scoped = 60 / 0.3 -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi = nil -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst = nil -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = false

--Miscelaneous Sounds
SWEP.IronInSound = nil --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = nil --Sound to play when ironsighting out?  nil for default
--Silencing
SWEP.CanBeSilenced = true --Can we silence?  Requires animations.
SWEP.Silenced = true --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = false --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = "" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it
--Ammo Related
SWEP.Primary.ClipSize = 10 -- This is the size of a clip
SWEP.Primary.DefaultClip = 5 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "pistol" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = true --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.4 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.3 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.2 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.1 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .05 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .05 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 0.2 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 1--How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = 16 * 300 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 4 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.9 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.8 --Multiply the player's movespeed by this when sighting.
--[[PROJECTILES]]--
SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model

--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/c_plasma_cutter_n.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 54		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(1.5,0,0) --Vector(0.300,-7.02,0.603) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = true --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = nil --{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}

--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/n_plasmacutter_primary.mdl" -- Weapon world model path
SWEP.Bodygroups_W = nil --{
--[0] = 1,
--[1] = 4,
--[2] = etc.
--}
SWEP.HoldType = "pistol" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = 4,
		Right = 1,
		Forward = 8
	},
	Ang = {
		Up = -1,
		Right = -2,
		Forward = 178
	},
	Scale = 0.8
} --Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.

--[[SCOPES]]--
SWEP.IronSightsSensitivity = 1 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay
--GDCW Overlay Options.  Only choose one.
SWEP.Secondary.UseACOG = false --Overlay option
SWEP.Secondary.UseMilDot = false --Overlay option
SWEP.Secondary.UseSVD = false --Overlay option
SWEP.Secondary.UseParabolic = false --Overlay option
SWEP.Secondary.UseElcan = false --Overlay option
SWEP.Secondary.UseGreenDuplex = false --Overlay option
if surface then
	SWEP.Secondary.ScopeTable = {
	}
end

--[[SHOTGUN CODE]]--
SWEP.Shotgun = false --Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim = false --Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime = .35 -- For shotguns, how long it takes to insert a shell.

--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(1.92, 0, 1.5)
SWEP.RunSightsAng = Vector(-10.15, 7.5, -2.391)

--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 0 --Enable Ironsights
SWEP.Secondary.IronFOV = 90 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-0.2, -5, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)



--[[INSPECTION]]--
SWEP.InspectPos = Vector(7.44, 0, -2.481)
SWEP.InspectAng = Vector(12.977, 10.998, 26)


--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = false --Allow the view to sway based on weapon SWEP.Secondary while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-1,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "ShellEject"--Which shell effect to use

--[[VIEWMODEL PROCEDURAL ANIMATION]]--
SWEP.DoProceduralReload = false--Animate first person reload using lua?
SWEP.ProceduralReloadTime = 1 --Procedural reload time?

--[[HOLDTYPES]]--
SWEP.IronSightHoldTypeOverride = "" --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride = "" --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.

--[[ANIMATION]]--

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 1.5,
	[ACT_VM_RELOAD_SILENCED] = 1.5
} --Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
SWEP.SequenceLengthOverride = {} --Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride = {} --Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled = {} --Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.3
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-40, -30, 10)

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation

--[[EFFECTS]]--
--SWEP.Secondarys
SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "1" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw SWEP.Secondary number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper SWEP.Secondary?
SWEP.MuzzleFlashEffectSilenced = "tfa_muzzleflash_rifle"
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_rifle" --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle = "" --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false --Disable automatic ejection smoke
--Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject" --The effect used for shell ejection; Defaults to that used for blowback
--Tracer Stuff
SWEP.TracerName 		= nil 	--Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 0 	--0 disables, otherwise, 1 in X chance
--Impact Effects
SWEP.ImpactEffect = nil--Impact Effect
SWEP.ImpactDecal = "FadingScorch"--Impact Decal
--[[EVENT TABLE]]--
SWEP.EventTable = {} --Event Table, used for custom events when an action is played.  This can even do stuff like playing a pump animation after shooting.
--example:
--SWEP.EventTable = {
--	[ACT_VM_RELOAD] = {
--		{ ["time"] = 0.1, ["type"] = "lua", ["value"] = function( wep, viewmodel ) end, ["client"] = true, ["server"] = true},
--		{ ["time"] = 0.1, ["type"] = "sound", ["value"] = Sound("x") }
--	}
--}

--[[RENDER TARGET]]--
SWEP.RTMaterialOverride = nil -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque = false -- Do you want your render target to be opaque?
SWEP.RTCode = nil--function(self) return end --This is the function to draw onto your rendertarget

--[[AKIMBO]]--
SWEP.Akimbo = false --Akimbo gun?  Alternates between primary and secondary attacks.
SWEP.AnimCycle = 0 -- Start on the right

--[[SWEP.SecondaryS]]--
SWEP.VElements = {
	["laser1"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "twist_part", rel = "", pos = Vector(0, -3, 0), angle = Angle(0, 90, 0), size = Vector(1, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false},
	["laser2"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "twist_part", rel = "", pos = Vector(0, -3, 2), angle = Angle(0, 90, 0), size = Vector(1, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false},
	["laser3"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "twist_part", rel = "", pos = Vector(0, -3, -2), angle = Angle(0, 90, 0), size = Vector(1, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false},
	}

-- SWEP.ViewModelBoneMods = {
-- ["twist_part"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(90, 0, 0) }
-- }

SWEP.WElements = {
} --Export from SWEP Creation Kit.  For each item that can/will be toggled, set active=false in its individual table
SWEP.Attachments = {
	--[MDL_SWEP.Secondary] = = { offset = { 0, 0 }, atts = { "si_eotech" }, sel = 0 }
	--Sorry for kind-of copying your syntax, Spy, but it makes it easier on the users and you did an excellent job.  The internal code's all mine anyways.
	--sel allows you to have an SWEP.Secondary pre-selected, and is used internally by the base to show which SWEP.Secondary is selected in each category.
}

DEFINE_BASECLASS( SWEP.Base )

SWEP.LaserSightAttachment = 0

local TracerName
local cv_forcemult = GetConVar("sv_tfa_force_multiplier")

function SWEP:SecondaryAttack()
	if self:GetStatus() == TFA.GetStatus("idle") then
		self:ChooseSilenceAnim( not self:GetSilenced() )
		self:SetSilenced( not self:GetSilenced() )
		self.Silenced = self:GetSilenced()
	end
end

function SWEP:UpdateMuzzleAttachment()
end

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
	num_bullets = 3 --hardcoded hereqw
	damage = damage  / num_bullets
	aimcone = aimcone or 0

	if self.Tracer == 1 then
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	else
		TracerName = "Tracer"
	end

	self.MainBullet.PCFTracer = nil

	if self.TracerName and self.TracerName ~= "" then
		if self.TracerPCF then
			TracerName = nil
			self.MainBullet.PCFTracer = self.TracerName
			self.MainBullet.Tracer = 0
		else
			TracerName = self.TracerName
		end
	end

	self.MainBullet.Attacker = self:GetOwner()
	self.MainBullet.Inflictor = self
	self.MainBullet.Num = 1
	self.MainBullet.Src = self:GetOwner():GetShootPos()
	self.MainBullet.HullSize = self:GetStat("Primary.HullSize") or 0
	self.MainBullet.Spread.x = 0
	self.MainBullet.Spread.y = 0
	if self.TracerPCF then
		self.MainBullet.Tracer = 0
	else
		self.MainBullet.Tracer = self.TracerCount and self.TracerCount or 3
	end
	self.MainBullet.TracerName = TracerName
	self.MainBullet.PenetrationCount = 0
	self.MainBullet.AmmoType = self:GetPrimaryAmmoType()
	self.MainBullet.Force = damage / 6 * math.sqrt(self:GetStat("Primary.KickUp") + self:GetStat("Primary.KickDown") + self:GetStat("Primary.KickHorizontal")) * cv_forcemult:GetFloat() * self:GetAmmoForceMultiplier()
	self.MainBullet.Damage = damage
	self.MainBullet.HasAppliedRange = false

	if self.CustomBulletCallback then
		self.MainBullet.Callback2 = self.CustomBulletCallback
	end

	self.MainBullet.Callback = function(a, b, c)
		if IsValid(self) then
			if self.MainBullet.Callback2 then
				self.MainBullet.Callback2(a, b, c)
			end

			self.MainBullet:Penetrate(a, b, c, self)

			self:PCFTracer( self.MainBullet, b.HitPos or vector_origin )
		end
	end

	for i = 1, num_bullets do
		self.MuzzleAttachmentRaw = i
		local a = self.Owner:EyeAngles()
		if self:GetSilenced() then
			a:RotateAroundAxis(a:Right(), ( i - math.floor( num_bullets / 2 ) - 1 ) * ( aimcone * 125 ) / ( num_bullets - 1 ) )
		else
			a:RotateAroundAxis(a:Up(), ( i - math.floor( num_bullets / 2 ) - 1 ) * ( aimcone * 125 ) / ( num_bullets - 1 ) )
		end
		self.MainBullet.Dir = a:Forward()
		self:GetOwner():FireBullets(self.MainBullet)
		self:ShootEffectsCustom( IsFirstTimePredicted() or game.SinglePlayer() )
	end
end