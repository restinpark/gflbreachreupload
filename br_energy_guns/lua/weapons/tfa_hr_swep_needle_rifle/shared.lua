if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
SWEP.WepSelectIcon		= surface.GetTextureID( "vgui/hud/hr_swep_needle_rifle" )
	
	killicon.Add( "tfa_hr_swep_needle_rifle", "vgui/hud/hr_swep_needle_rifle", color_white )
end
-- Variables that are used on both client and server
SWEP.Gun 					= ("tfa_hr_swep_needle_rifle") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "[TFA] Halo Reach"
SWEP.Author					= "Stan"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.MuzzleAttachment		= "1" 						-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment	= "2" 						-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Type-31 Needle Rifle"	-- Weapon name (Shown on HUD)	
SWEP.Slot					= 2							-- Slot in the weapon selection menu
SWEP.SlotPos				= 4							-- Position in the slot
SWEP.DrawAmmo				= true						-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false						-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false						-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true						-- Set false if you want no crosshair from hip
SWEP.Weight					= 30						-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true						-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true						-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true						-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false						-- Is this a bolt action rifle?
SWEP.HoldType 				= "ar2"						-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 40
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_needle_rifle_hr.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_shotgun.mdl"	-- Weapon world model
SWEP.ShowWorldModel         = false
SWEP.Base 					= "tfa_gun_base"

SWEP.ViewModelBoneMods = {
	["b_Barrel"] = { scale = Vector(1, 1, 1), pos = Vector(2, 1.169, -0.438), angle = Angle(0, 0, 0) }
}

SWEP.DisableChambering = true

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound				= nil		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 200		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 21		-- Size of a clip
SWEP.Primary.DefaultClip		= 120	-- Bullets you start with
SWEP.Primary.KickUp				= 0.5				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.151			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.1	-- Maximum up recoil (stock)
SWEP.Primary.StaticRecoilFactor = 0.3 		--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.Primary.Automatic			= true	-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.ShellTime			= .5

SWEP.Scoped 						= true

SWEP.data 							= {}
SWEP.data.ironsights				= 1

if CLIENT then
	SWEP.Secondary.ScopeTable = {
		scopetex = surface and surface.GetTextureID("needle_rifle_scope/needle_scope") or 0,
		reticletex = surface and surface.GetTextureID("crosshairs/needle_rifle_crosshairs") or 0
	}
	SWEP.ScopeScale 				= 0.8
	SWEP.ReticleScale 				= 0.2
end

SWEP.MuzzleFlashEffect = "needle_rifle_muzzle"
SWEP.ImpactEffect = "needle_rifle_beam_hit"

SWEP.TracerCount = 1
SWEP.TracerName = "needle_rifle_beam"

SWEP.Secondary.UseACOG				= false -- Choose one scope type
SWEP.Secondary.UseMilDot			= false	-- I mean it, only one
SWEP.Secondary.UseSVD				= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic			= false
SWEP.Secondary.UseElcan				= false
SWEP.Secondary.UseGreenDuplex		= false
SWEP.Secondary.UseAimpoint			= false
SWEP.Secondary.UseMatador			= false

SWEP.AmmoTypeStrings	= {["smg1"] = "Crystalline Explosive Projectiles"}
SWEP.Type = "Needle Rifle"

SWEP.Secondary.IronFOV			= 40		-- How much you 'zoom' in. Less is more! 

SWEP.Primary.NumShots			= 1		--how many bullets to shoot per trigger pull
SWEP.Primary.Damage				= 25	--base damage per bullet
SWEP.Primary.Spread				= 0.01	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy 		= 0.002 -- ironsight accuracy, should be the same for shotguns

SWEP.Primary.SpreadMultiplierMax 	= 3.8 		--How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement 		= 1.49 	--What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery 		= 3.103 		--How much the spread recovers, per second.

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector(-9.343, -20, 0.833)
SWEP.IronSightsAng = Vector(0, 0.086, 0)

SWEP.RunSightsPos = Vector(7.742, -5.271, 2.709)
SWEP.RunSightsAng = Vector(-11.58, 31.843, 0)

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/covenant/needlerrifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.874, 0.27, 1.121), angle = Angle(0, 83.916, -165.346), size = Vector(0.986, 0.986, 0.986), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

DEFINE_BASECLASS( SWEP.Base )
function SWEP:PrimaryAttack(...)
	if not self:CanPrimaryAttack() then return end
	if IsFirstTimePredicted() and not ( sp and CLIENT ) then
		if self:GetStat("Primary.SilencedSound") and self:GetSilenced() then
			self:EmitSound(self:GetStat("Primary.SilencedSound"))
		else
			self:EmitSound(Sound("pillar/needle_rifle_fire"..math.random(1,3)..".wav"))
		end
	end
	return BaseClass.PrimaryAttack(self,...)
end

DEFINE_BASECLASS( SWEP.Base )
function SWEP:Think()
	BaseClass.Think( self )
	if self.Owner:KeyPressed(IN_ATTACK2) and !self.Owner:KeyDown(IN_SPEED) and self:GetIronSights()==true then
		self.Weapon:EmitSound("pillar/needle_rifle_zoom_in.wav")
	end
	
	if self.Owner:KeyReleased(IN_ATTACK2) and !self.Owner:KeyDown(IN_SPEED) and self:GetIronSights()==false then
		self.Weapon:EmitSound("pillar/needle_rifle_zoom_out.wav")
	end	
end