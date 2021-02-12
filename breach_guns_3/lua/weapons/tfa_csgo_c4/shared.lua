SWEP.Base				= "tfa_csgo_base"
SWEP.Category				= "TFA CS:GO" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= false		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "C4 Explosive"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 4				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.BeepTimer = CurTime()

SWEP.NoStattrak = true

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = nil -- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 1600.0 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = nil --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.RPM = 60 -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi = nil -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst = nil -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = false

--Miscelaneous Sounds
SWEP.IronInSound = nil --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = nil --Sound to play when ironsighting out?  nil for default
--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = false --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = "" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it
--Ammo Related
SWEP.Primary.ClipSize = 0 -- This is the size of a clip
SWEP.Primary.DefaultClip = 0 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "none" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = 1 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = 1 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = nil--How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = nil --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = nil--How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 4 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.8 --Multiply the player's movespeed by this when sighting.
--[[PROJECTILES]]--
SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/tfa_csgo/c_ied.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 56		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands	 = true --Use gmod c_arms system.
SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
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
SWEP.WorldModel			= "models/weapons/tfa_csgo/w_ied.mdl" -- Weapon world model path
SWEP.Bodygroups_W = nil --{
--[0] = 1,
--[1] = 4,
--[2] = etc.
--}

SWEP.HoldType = "slam" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -2,
		Right = -1	,
		Forward = 2
	},
	Ang = {
		Up = -1,
		Right = 90,
		Forward = 178
	},
	Scale = 1
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
	SWEP.Secondary.ScopeTable = nil --[[
		{
			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
			dottex = surface.GetTextureID("scope/gdcw_acogcross")
		}
	]]--
end
--[[SHOTGUN CODE]]--
SWEP.Shotgun = false --Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim = false --Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell = true --Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime = .35 -- For shotguns, how long it takes to insert a shell.
--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(0, 0, 0) --Change this, using SWEP Creation Kit preferably
SWEP.RunSightsAng = Vector(-10, 0, 0) --Change this, using SWEP Creation Kit preferably
--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 0 --Enable Ironsights
SWEP.Secondary.IronFOV = 70 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(0, 0, 0) --Change this, using SWEP Creation Kit preferably
SWEP.IronSightsAng = Vector(0, 0, 0) --Change this, using SWEP Creation Kit preferably
--[[INSPECTION]]--
SWEP.InspectPos = nil--Vector(0,0,0) --Replace with a vector, in style of ironsights position, to be used for inspection
SWEP.InspectAng = nil--Vector(0,0,0) --Replace with a vector, in style of ironsights angle, to be used for inspection
--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
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

SWEP.StatusLengthOverride = {} --Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
SWEP.SequenceLengthOverride = {} --Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride = {} --Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled = {} --Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.0
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-40, -30, 10)

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
--MDL Animations Below
SWEP.IronAnimation = {
}

SWEP.SprintAnimation = {
}
--[[EFFECTS]]--
--Attachments
SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = nil --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false --Disable automatic ejection smoke
--Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = nil --The effect used for shell ejection; Defaults to that used for blowback
--Tracer Stuff
SWEP.TracerName 		= nil 	--Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 3 	--0 disables, otherwise, 1 in X chance
--Impact Effects
SWEP.ImpactEffect = nil--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal
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
--[[ATTACHMENTS]]--
SWEP.VElements = nil --Export from SWEP Creation Kit.  For each item that can/will be toggled, set active=false in its individual table
SWEP.WElements = nil --Export from SWEP Creation Kit.  For each item that can/will be toggled, set active=false in its individual table
SWEP.Attachments = {
	--[MDL_ATTACHMENT] = = { offset = { 0, 0 }, atts = { "si_eotech" }, sel = 0 }
	--Sorry for kind-of copying your syntax, Spy, but it makes it easier on the users and you did an excellent job.  The internal code's all mine anyways.
	--sel allows you to have an attachment pre-selected, and is used internally by the base to show which attachment is selected in each category.
}
SWEP.AttachmentDependencies = {}--{["si_acog"] = {"bg_rail"}}
SWEP.AttachmentExclusions = {}--{ ["si_iron"] = {"bg_heatshield"} }
--[[MISC INFO FOR MODELERS]]--
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

]]--

SWEP.MoveSpeed = 250/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 250/260*0.8 --Multiply the player's movespeed by this when sighting.

DEFINE_BASECLASS( SWEP.Base )

function SWEP:PrimaryAttack()
	if self:GetStatus() ~= TFA.GetStatus("idle") then return end
	--if self:GetOwner():GetVelocity():Length() > 10 then return end
	self:SendViewModelAnim( ACT_VM_PRIMARYATTACK )
	self:SetStatus(TFA.GetStatus("shooting"))
	self:SetStatusEnd(CurTime() + self:GetActivityLength())
	--[[
	self:GetOwner():AnimRestartGesture( GESTURE_SLOT_CUSTOM, self.SurrenderGesture, true )
	if game.SinglePlayer() then
		self:CallOnClient("Gesture",tostring( self.SurrenderGesture ) )
	end
	]]--
	self.CanPlaceC4 = true
end

function SWEP:Think2( ... )
	if self:GetStatus() == TFA.GetStatus("shooting") or self:GetStatus() == TFA.GetStatus("bashing") then
		self.MoveSpeed = 0.01
	else
		self.MoveSpeed = 1
	end
	self:ClearStatCache()
	local ply = self:GetOwner()
	if self:GetStatus() == TFA.GetStatus("shooting") then
		if ply:KeyDown(IN_ATTACK) then--and ply:GetVelocity():Length() < 10 then
			if CurTime() > self:GetStatusEnd() then
				self:SendViewModelAnim( ACT_VM_SECONDARYATTACK )
				self:SetStatus(TFA.GetStatus("bashing"))
				self:SetStatusEnd(CurTime() + self:GetActivityLength())
			end
		else
			-- self:SetStatus(TFA.GetStatus("idle"))
			-- self:SetStatusEnd(-1)
			-- self:SendViewModelAnim(ACT_VM_IDLE)
			-- self:ChooseIdleAnim()
			self:Deploy()
		end
	elseif self:GetStatus() == TFA.GetStatus("bashing") and CurTime() > self:GetStatusEnd() then
		timer.Simple(0, function()
			if IsValid(self) and IsValid(ply) and ply.StripWeapon then
				ply:StripWeapon(self:GetClass())
			end
		end)
		if SERVER and self.CanPlaceC4 then
			local tdi = math.min( ply:GetEyeTrace().HitPos:Distance( ply:GetShootPos() ), 32 )
			local hpos = ply:GetShootPos() + ply:EyeAngles():Forward() * tdi
			local ent = ents.Create("tfa_csgo_c4_ent")
			ent:SetPos(hpos)
			ent:SetAngles( Angle( 0, ply:EyeAngles().y, 0 ) )
			ent:Spawn()
			ent:Activate()
			ent:SetNWEntity("owner",self.Owner)
			ent.Damage = self.Primary.Damage
			self.CanPlaceC4  = false
		end
			self:EmitSound("tfa_CSGO_c4.1")
		return
	end
	return BaseClass.Think2( self, ... )
end

function SWEP:SecondaryAttack()
end

local function DrawScreen(self)
	if not CLIENT then return end
	self.ScreenText = self.ScreenText or ""

	draw.NoTexture()
	draw.SimpleText(self.ScreenText, "TFA_CSGO.C4FontView", 0, 0, color_black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

SWEP.VElements = {
	["screen"] = { type = "Quad", bone = "v_weapon.c4", rel = "", pos = Vector(-4.75, -1.65, 1.5), angle = Angle(0, 180, 90), size = 0.0075, draw_func = DrawScreen, active = true},
}

function SWEP:FireAnimationEvent(pos, ang, event, options)
	if event == 7001 then
		self.ScreenText = options
		return true
	end

	return BaseClass.FireAnimationEvent(self, pos, ang, event, options)
end

SWEP.WElements = {
	["dummy_particle"] = { 
	type = "Model", 
	model = "models/dav0r/hoverball.mdl", 
	bone = "ValveBiped.Bip01_R_Hand", 
	rel = "", 
	pos = Vector(1.299, 4.96, -4.237), 
	angle = Angle(0, 0, 0), 
	size = Vector(0.009, 0.009, 0.009), 
	color = Color(255, 255, 255, 255), 
	surpresslightning = false, 
	material = "", 
	skin = 0, 
	bodygroup = {}, 
	particledummy = true }
}

function SWEP:DrawWorldModel( ... )

   if not self:IsValid() then return end
   local owner = self:GetOwner()
   
	if IsValid(owner) then
		if not self.ParticleHolding and self.BeepTimer <= CurTime() then
			local att = self:LookupAttachment("led")
			if att then
				ParticleEffectAttach("c4_timer_light_held",PATTACH_POINT_FOLLOW,self,att)
				self.ParticleHolding = true
			end
		end
	else
		if not self.Particle and self.BeepTimer <= CurTime() then
			local att = self:LookupAttachment("led")
			if att then
				ParticleEffectAttach("c4_timer_light_dropped",PATTACH_POINT_FOLLOW,self,att)
				self.Particle = true
			end
		end
	end
	
	if CurTime() > self.BeepTimer then
		self.BeepTimer = CurTime() + 3
		self.Particle = false
		self.ParticleHolding = false
	end
 
    return BaseClass.DrawWorldModel( self, ... )
end

-- function SWEP:Think(...)
	
	-- self.BeepTimer = CurTime() + 3
	
	-- if CurTime() > self.BeepTimer then
		-- self.BeepTimer = CurTime() + 3
		-- self.Particle = false
		-- self.ParticleHolding = false
	-- else
		-- self.Particle = true
		-- self.ParticleHolding = true
	-- end
	
	-- return BaseClass.Think( self, ... )
-- end

function SWEP:Gesture( ges )
	self:GetOwner():AnimRestartGesture( GESTURE_SLOT_CUSTOM, tonumber(ges), true )
end

function SWEP:ShootBulletInfo()
	return false
end