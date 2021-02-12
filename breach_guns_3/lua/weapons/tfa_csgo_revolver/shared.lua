DEFINE_BASECLASS("tfa_csgo_base")
SWEP.Gun = ("tfa_csgo_deagle") --Make sure this is unique.  Specically, your folder name.  

SWEP.Base = "tfa_csgo_base"
SWEP.Category = "TFA CS:GO" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep.
SWEP.Author = "" --Author Tooltip
SWEP.Contact = "" --Contact Info Tooltip
SWEP.Purpose = "" --Purpose Tooltip
SWEP.Instructions = "" --Instructions Tooltip
SWEP.Spawnable = true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable = true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair = false -- Draw the crosshair?
SWEP.PrintName = "R8 Revolver" -- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 10			-- Position in the slot
SWEP.ItemType = WEAPON_SIDEARM or 5
SWEP.DrawAmmo = true -- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon = false -- Should the weapon icon bounce?
SWEP.AutoSwitchTo = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom = true -- Auto switch from if you pick up a better weapon
SWEP.Weight = 30 -- This controls how "good" the weapon is for autopickup.
--[[WEAPON HANDLING]]
--
--Firing related
SWEP.Primary.Sound = Sound("TFA_CSGO_REVOLVER.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 40 -- Damage, in standard damage points.
SWEP.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.NearlyEmpty_ClipSize = 1
SWEP.Primary.Delay = 0.2
SWEP.Primary.RPM = 120 -- This is in Rounds Per Minute / RPM
SWEP.Secondary.RPM = 150
SWEP.Primary.RPM_Semi = nil -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.FiresUnderwater = false
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = false --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = "" --Default to auto or whatev
--Ammo Related
SWEP.Primary.ClipSize = 6 -- This is the size of a clip
SWEP.Primary.DefaultClip = 0 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "pistol" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.  
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.Revolver = true --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.5 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.5 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .03 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .0001 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.Spread_Charge = .01 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy_Charge = .005 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.Spread_Normal = .03 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy_Normal = .02 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 4.0 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 2.0 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.
--Range Related
SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 4 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier = 0.65 --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier = 1.3 --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier = 1.1 --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
SWEP.ChangeStateRecoilMultiplier = 1.3 --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.ChangeStateAccuracyMultiplier = 1.5 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.JumpAccuracyMultiplier = 2 --Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.WalkAccuracyMultiplier = 1.35 --Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.IronSightTime = 0.3 --The time to enter ironsights/exit it.
SWEP.NearWallTime = 0.25 --The time to pull up  your weapon or put it back down
SWEP.ToCrouchTime = 0.05 --The time it takes to enter crouching state
SWEP.WeaponLength = 40 --Almost 3 feet Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.95 --Multiply the player's movespeed by this when sighting.
SWEP.SprintFOVOffset = 3.75 --Add this onto the FOV when we're sprinting.
--[[PROJECTILES]]
--
SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.LuaShellEject = false --Entity to shoot's model
--[[VIEWMODEL]]
--
SWEP.ViewModel = "models/weapons/tfa_csgo/c_pist_revolver.mdl" --Viewmodel path
SWEP.ViewModelFOV = 56 -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip = false -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(0, 0, 0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position. 
SWEP.VMAng = Vector(0, 0, 0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle. 
--[[WORLDMODEL]]
--
SWEP.WorldModel = "models/weapons/tfa_csgo/w_revolver.mdl" -- Weapon world model path
SWEP.HoldType = "revolver" -- This is how others view you carrying the weapon. Options include:

-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -3,
		Right = 0.8,
		Forward = 8
	},
	Ang = {
		Up = 3,
		Right = 0,
		Forward = 178
	},
	Scale = 0.9
}

--Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SCOPES]]
--
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
--[[SHOTGUN CODE]]
--
SWEP.Shotgun = false --Enable shotgun style reloading.
SWEP.ShellTime = .35 -- For shotguns, how long it takes to insert a shell.
--[[SPRINTING]]
--
SWEP.RunSightsPos = Vector(-0.202, -12.457, -7.447)
SWEP.RunSightsAng = Vector(64.723, 0, 0)
--[[IRONSIGHTS]]
--
SWEP.data = {}
SWEP.data.ironsights = 0 --Enable Ironsights
SWEP.Secondary.IronFOV = 60 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-3.76, -5.628, 0.38)
SWEP.IronSightsAng = Vector(0.68, 0.30, 0)
--[[INSPECTION]]
--
--SWEP.InspectPos = Vector(0,0,0) --Replace with a vector, in style of ironsights position, to be used for inspection
--SWEP.InspectAng = Vector(0,0,0) --Replace with a vector, in style of ironsights angle, to be used for inspection
SWEP.FidgetLoop = false --Setting false will cancel inspection once the animation is done.  CS:GO style.
--[[VIEWMODEL ANIMATION HANDLING]]
--
SWEP.ShootWhileDraw = false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw = false --Can you reload while draw anim plays?
SWEP.SightWhileDraw = false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster = false --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster = false --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster = false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload = true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting = false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall = false --Can you reload when close to a wall and facing it?
SWEP.SprintBobMult = 1.5 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.
SWEP.IronBobMult = 0 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting, 0 to outright disable.
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS!!!!11111oneONEELEVEN
--[[VIEWMODEL BLOWBACK]]
--
SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0, -3, 0.05) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones

SWEP.BlowbackBoneMods = {
	["v_weapon.deagle_slide"] = {
		scale = Vector(1, 1, 1),
		pos = Vector(0, 0, -1.89309),
		angle = Angle(0, 0, 0)
	}
}

SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true
SWEP.Blowback_Shell_Effect = "ShellEject"
--[[HOLDTYPES]]
--
SWEP.IronSightHoldTypeOverride = "" --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride = "" --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
--[[ANIMATION]]
--
SWEP.ForceDryFireOff = true --Disables dryfire.  Set to false to enable them.
SWEP.DisableIdleAnimations = false --Disables idle animations.  Set to false to enable them.
SWEP.ForceEmptyFireOff = true --Disables empty fire animations.  Set to false to enable them.
--If you really want, you can remove things from SWEP.actlist and manually enable animations and set their lengths.
SWEP.SequenceEnabled = {} --Self explanitory.  This can forcefully enable or disable a certain ACT_VM
SWEP.SequenceLength = {} --This controls the length of a certain ACT_VM
SWEP.SequenceLengthOverride = {} --Override this if you want to change the length of a sequence but not the next idle 

SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 59 / 30
}

--[[EFFECTS]]
--
--Muzzle Smoke

--These are particle effects INSIDE a pcf file, not PCF files, that are played when you shoot.
--Muzzle Flash
SWEP.MuzzleAttachment = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
--SWEP.MuzzleAttachmentRaw = 1 --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.ShellAttachment = "2" -- Should be "2" for CSS models or "shell" for hl2 models
SWEP.DoMuzzleFlash = true --Do a muzzle flash?
SWEP.CustomMuzzleFlash = true --Disable muzzle anim events and use our custom flashes?
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_csgo_muzzle_assaultrifle"

--[[EVENT TABLE]]
--
SWEP.EventTable = {} --Event Table, used for custom events when an action is played.  This can even do stuff like playing a pump animation after shooting.
--example:
--SWEP.EventTable = {
--	[ACT_VM_RELOAD] = {
--		{ ['time'] = 0.1, ['type'] = "lua", ['value'] = examplefunction, ['client'] = true, ['server'] = false  },
--		{ ['time'] = 0.2, ['type'] = "sound", ['value'] = Sound("ExampleGun.Sound1", ['client'] = true, ['server'] = false ) }
--	}
--}
--[[RENDER TARGET]]
--
SWEP.RTMaterialOverride = nil -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque = false -- Do you want your render target to be opaque?
SWEP.RTCode = function(self) return end --This is the function to draw onto your rendertarget
--[[AKIMBO]]
--
SWEP.Akimbo = false --Akimbo gun?  Alternates between primary and secondary attacks.
SWEP.AnimCycle = 0 -- Start on the right
--[[TTT]]
--
local gm = engine.ActiveGamemode()

if string.find(gm, "ttt") or string.find(gm, "terrorist") then
	SWEP.Kind = WEAPON_HEAVY
	SWEP.AutoSpawnable = false
	SWEP.AllowDrop = true
	SWEP.AmmoEnt = "item_ammo_smg1_ttt"
end

--[[MISC INFO FOR MODELERS]]
--
--[[

Used Animations (for modelers):

ACT_VM_DRAW - Draw
ACT_VM_DRAW_EMPTY - Draw empty
ACT_VM_DRAW_SILENCED - Draw silenced, overrides empty

ACT_VM_IDLE - Idle
ACT_VM_IDLE_SILENCED - Idle empty, overwritten by silenced
ACT_VM_IDLE_SILENCED - Idle silenced

ACT_VM_PRIMARYATTACK - Shoot
ACT_VM_PRIMARYATTACK_EMPTY - Shoot last chambered bullet
ACT_VM_PRIMARYATTACK_SILENCED - Shoot silenced, overrides empty
ACT_VM_PRIMARYATTACK_1 - Shoot ironsights, overriden by everything besides normal shooting
ACT_VM_DRYFIRE - Dryfire

ACT_VM_RELOAD - Reload / Tactical Reload / Insert Shotgun Shell
ACT_SHOTGUN_RELOAD_START - Start shotgun reload, unless ACT_VM_RELOAD_EMPTY is there.
ACT_SHOTGUN_RELOAD_FINISH - End shotgun reload.
ACT_VM_RELOAD_EMPTY - Empty mag reload, chambers the new round.  Works for shotguns too, where applicable.
ACT_VM_RELOAD_SILENCED - Silenced reload, overwrites all

ACT_VM_HOLSTER - Holster
ACT_VM_HOLSTER_SILENCED - Holster empty, overwritten by silenced
ACT_VM_HOLSTER_SILENCED - Holster silenced

]]
--
--[[Stuff you SHOULD NOT touch after this]]
--
--Allowed VAnimations.  These are autodetected, so not really needed except as an extra precaution.  Do NOT change these, unless absolutely necessary.
SWEP.CanDrawAnimate = true
SWEP.CanDrawAnimateEmpty = false
SWEP.CanDrawAnimateSilenced = false
SWEP.CanHolsterAnimate = true
SWEP.CanHolsterAnimateEmpty = false
SWEP.CanIdleAnimate = true
SWEP.CanIdleAnimateEmpty = false
SWEP.CanIdleAnimateSilenced = false
SWEP.CanShootAnimate = true
SWEP.CanShootAnimateSilenced = false
SWEP.CanReloadAnimate = true
SWEP.CanReloadAnimateEmpty = false
SWEP.CanReloadAnimateSilenced = false
SWEP.CanDryFireAnimate = false
SWEP.CanDryFireAnimateSilenced = false
SWEP.CanSilencerAttachAnimate = false
SWEP.CanSilencerDetachAnimate = false
--Misc
SWEP.ShouldDrawAmmoHUD = false --THIS IS PROCEDURALLY CHANGED AND SHOULD NOT BE TWEAKED.  BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.DefaultFOV = 90 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
--Disable secondary crap
SWEP.Secondary.ClipSize = 0 -- Size of a clip
SWEP.Secondary.DefaultClip = 0 -- Default ammo to give...
SWEP.Secondary.Automatic = false -- Automatic/Semi Auto
SWEP.Secondary.Ammo = "none" -- Self explanitory, ammo type.
--Convar support
SWEP.ConDamageMultiplier = 1
SWEP.Base = "tfa_csgo_base"
SWEP.Skins = {}

SWEP.SequenceRateOverride = {} --Like above but scales animation length rather than being absolute

-- 1 = Cyl Bullets
-- 2 = Loader

SWEP.EventTable = {
	[ACT_VM_IDLE] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,0)
			wep:SetBodyGroupVM(2,0)
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_RELOAD] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,2)
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 31/30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,1)
			wep:SetBodyGroupVM(2,1)
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 47/30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,0)
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 48/30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(2,2)
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 53/30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(2,0)
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_DRAW] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			wep.Bodygroups_V[2] = 0
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_PULLBACK] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,0)
			wep:SetBodyGroupVM(2,0)
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_PRIMARYATTACK] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,0)
			wep:SetBodyGroupVM(2,0)
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_SECONDARYATTACK] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,0)
			wep:SetBodyGroupVM(2,0)
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_DRYFIRE] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			wep:SetBodyGroupVM(1,0)
			wep:SetBodyGroupVM(2,0)
		end, ["client"] = true, ["server"] = true }
	}
}

function SWEP:Deploy()
	self:CancelPullback()

	return BaseClass.Deploy(self)
end

function SWEP:SendDefaultAnim()
	self:SendViewModelAnim(ACT_VM_IDLE)
end

function SWEP:CanPullBack()
	return self:CanPrimaryAttack()
end

function SWEP:CancelPullback()
	self:SetNW2Float("LastPullback", math.huge)
	self:SetNW2Bool("IsPullingBack", false)
	self:SetStatus(TFA.Enum.STATUS_IDLE)
end

function SWEP:PrimaryShoot(ifp)
	if not self:OwnerIsValid() then return end
	self:CancelPullback()
	self:UpdateConDamage()

	if self.FiresUnderwater == false and self.Owner:WaterLevel() >= 3 then
		if self:CanPrimaryAttack() then
			self.Weapon:EmitSound("Weapon_AR2.Empty")
		end

		return
	end

	--if self.Owner:IsPlayer() then
	if not self:GetSprinting() then
		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

		if self:GetMaxBurst() > 1 then
			self:SetBurstCount(math.max(1, self:GetBurstCount() + 1))
		end

		self:SetStatus(TFA.Enum.STATUS_SHOOTING)
		self:SetStatusEnd(self:GetNextPrimaryFire())
		self:ToggleAkimbo()
		self:ChooseShootAnim()
		self.Owner:SetAnimation(PLAYER_ATTACK1)

		if self.Primary.Sound and IsFirstTimePredicted() and not (sp and CLIENT) then
			if self.Primary.SilencedSound and self:GetSilenced() then
				self:EmitSound(self.Primary.SilencedSound)
			else
				self:EmitSound(self.Primary.Sound)
			end
		end

		self:TakePrimaryAmmo(self.Primary.AmmoConsumption)
		self:ShootBulletInformation()
		local _, CurrentRecoil = self:CalculateConeRecoil()
		self:Recoil(CurrentRecoil, IsFirstTimePredicted())

		if sp and SERVER then
			self:CallOnClient("Recoil", "")
		end

		if self.MuzzleFlashEnabled and not self.AutoDetectMuzzleAttachment then
			self:ShootEffectsCustom()
		end

		if self.EjectionSmoke and IsFirstTimePredicted() and not (self.LuaShellEject and self.LuaShellEjectDelay > 0) then
			self:EjectionSmoke()
		end

		self:DoAmmoCheck()
	end
	--and self:GetReloading()==false then
	--end
end

function SWEP:PrimaryAttack()
	if not self:OwnerIsValid() then return end
	if not self:CanPullBack() then return end
	local vm = self.Owner:GetViewModel()
	local act = vm:GetSequenceActivity(vm:GetSequence())
	local cyc = vm:GetCycle()
	if CurTime() < self:GetNextPrimaryFire() then return end

	if self:CanPrimaryAttack() then
		self:SendViewModelAnim( ACT_VM_PULLBACK )
		self:SetNW2Float("LastPullback", CurTime())
		self:SetNW2Bool("IsPullingBack", true)
		self:SetStatus(TFA.Enum.STATUS_BASHING)
		self:SetStatusEnd(CurTime() + self:GetActivityLength() )
	end
end

function SWEP:R8Think(ifp)
	if not self:OwnerIsValid() then return end
	local newspread = self:GetNW2Bool("IsPullingBack", false) and self.Primary.Spread_Charge or self.Primary.Spread_Normal
	local newiacc = self:GetNW2Bool("IsPullingBack", false) and self.Primary.IronAccuracy_Charge or self.Primary.IronAccuracy_Normal
	self.Primary.Spread = math.Approach(self.Primary.Spread, newspread, (newspread - self.Primary.Spread) * FrameTime() * 20)
	self:ClearStatCache("Primary.Spread")
	self.Primary.IronAccuracy = math.Approach(self.Primary.IronAccuracy, newiacc, (newspread - self.Primary.Spread) * FrameTime() * 20)
	self:ClearStatCache("Primary.IronAccuracy")

	if self:GetNW2Bool("IsPullingBack", false) then
		if game.SinglePlayer() and CLIENT then return end

		if not self.Owner:KeyDown(IN_ATTACK) then
			self:CancelPullback()

			if ifp then
				self:SendDefaultAnim()
			end

			self:EmitSound("TFA_CSGO_REVOLVER.Hammer")
			--end

			return
		end

		if CurTime() > self:GetNW2Float("LastPullback", math.huge) + self.Primary.Delay then
			if self:Clip1() > 0 then
				self:PrimaryShoot(ifp)
				--end
			else
				if ifp then
					self:SendDefaultAnim()
				end

				self:EmitSound("TFA_CSGO_REVOLVER.Hammer")
				self:SetNextPrimaryFire(CurTime() + 60 / self.Primary.RPM)
				self:CancelPullback()
			end
		end
	end
end

function SWEP:Think2()
	local ifp = (SERVER or (CLIENT and IsFirstTimePredicted())) or game.SinglePlayer()
	self:R8Think(ifp)

	if SERVER and game.SinglePlayer() then
		self:CallOnClient("R8Think", "")
	end

	BaseClass.Think2(self)
end

function SWEP:SecondaryShoot()
	if not self:OwnerIsValid() then return end
	self:CancelPullback()
	self.Primary.Spread = self.Primary.Spread_Normal
	self:ClearStatCache("Primary.Spread")
	self.Primary.IronAccuracy = self.Primary.IronAccuracy_Normal
	self:ClearStatCache("Primary.IronAccuracy")
	self:UpdateConDamage()

	if self.FiresUnderwater == false and self.Owner:WaterLevel() >= 3 then
		if self:CanPrimaryAttack() then
			self.Weapon:EmitSound("Weapon_AR2.Empty")
		end

		return
	end

	--if self.Owner:IsPlayer() then
	if not self:GetSprinting() then
		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

		if self:GetMaxBurst() > 1 then
			self:SetBurstCount(math.max(1, self:GetBurstCount() + 1))
		end

		self:SetStatus(TFA.Enum.STATUS_SHOOTING)
		self:SetStatusEnd(self:GetNextPrimaryFire())
		self:ToggleAkimbo()
		self:SendViewModelAnim(ACT_VM_SECONDARYATTACK)
		self.Owner:SetAnimation(PLAYER_ATTACK1)

		if self.Primary.Sound and IsFirstTimePredicted() and not (sp and CLIENT) then
			if self.Primary.SilencedSound and self:GetSilenced() then
				self:EmitSound(self.Primary.SilencedSound)
			else
				self:EmitSound(self.Primary.Sound)
			end
		end

		self:TakePrimaryAmmo(self.Primary.AmmoConsumption)
		self:ShootBulletInformation()
		local _, CurrentRecoil = self:CalculateConeRecoil()
		self:Recoil(CurrentRecoil, IsFirstTimePredicted())

		if sp and SERVER then
			self:CallOnClient("Recoil", "")
		end

		if self.MuzzleFlashEnabled and not self.AutoDetectMuzzleAttachment then
			self:ShootEffectsCustom()
		end

		if self.EjectionSmoke and IsFirstTimePredicted() and not (self.LuaShellEject and self.LuaShellEjectDelay > 0) then
			self:EjectionSmoke()
		end

		self:DoAmmoCheck()
	end
	--and self:GetReloading()==false then
	--end
end

function SWEP:SecondaryAttack()
	if not self:OwnerIsValid() then return end
	if CurTime() < self:GetNextPrimaryFire() then return end
	if not self:CanPullBack() then return end

	if self:Clip1() > 0 then
		self:SecondaryShoot()
	end
end

-- function SWEP:FireAnimationEvent(pos, ang, event, options)
	-- --SetBodygroup == 38 --Event
	
	-- if event == 38 then
		-- local splitted = string.Split(options, " ")
		-- self:SetBodyGroupVM(self:FindBodygroupByName(splitted[1]),tonumber(splitted[2]))
	-- end
	
    -- return BaseClass.FireAnimationEvent and BaseClass.FireAnimationEvent(self, pos, ang, event, options) or true
-- end