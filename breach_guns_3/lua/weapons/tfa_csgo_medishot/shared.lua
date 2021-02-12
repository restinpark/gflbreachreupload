DEFINE_BASECLASS("tfa_csgo_base")

SWEP.Gun					= ("tfa_csgo_medishot") --Make sure this is unique.  Specically, your folder name.  
SWEP.Base				= "tfa_csgo_base"
SWEP.Category				= "TFA CS:GO" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep.
SWEP.Author				= "" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= false		-- Draw the crosshair?
SWEP.PrintName				= "Medi-Shot"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.AllowSprintAttack = true

SWEP.NoStattrak = true
SWEP.NoNametag = true

--[[WEAPON HANDLING]]--

--Firing related
SWEP.Primary.SuccessSound 		= Sound("TFA_CSGO_HealthShot.Success")				-- This is the sound of the weapon, when you shoot.
SWEP.Primary.DenySound			= Sound("WallHealth.Deny")
SWEP.FiresUnderwater = true

--Ammo Related

SWEP.Primary.ClipSize				= 1					-- This is the size of a clip
SWEP.Primary.DefaultClip			= 1					-- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo					= "csgo_medishot"					-- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.  
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.DisableChambering = true --Disable round-in-the-chamber

--Range Related
SWEP.Primary.Range = 0 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/tfa_csgo/c_healthshot.mdl" --Viewmodel path
SWEP.ViewModelFOV		= 56		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.

--[[WORLDMODEL]]--

SWEP.WorldModel			= "models/weapons/tfa_csgo/w_eq_healthshot.mdl" -- Weapon world model path

SWEP.HoldType 				= "slam"		-- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -2,
		Right = 0.8,
		Forward = 4.5,
	},
	Ang = {
		Up = 3,
		Right = 0,
		Forward = 178
	},
	Scale = 0.9
}

SWEP.MoveSpeed = 250/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 250/260*0.8 --Multiply the player's movespeed by this when sighting.

--[[IRONSIGHTS]]--

SWEP.data 				= {}
SWEP.data.ironsights	= 0 --Enable Ironsights

function SWEP:Deploy( ... )
	if self:Clip1() <= 0 then
		if self:Ammo1() <= 0 then
			timer.Simple(0, function()
				if CLIENT or not IsValid(self) or not self:OwnerIsValid() then return end
				self:GetOwner():StripWeapon(self:GetClass())
			end)
		else
			self:TakePrimaryAmmo(1, true)
			self:SetClip1(1)
		end
	end

	return BaseClass.Deploy( self, ... )
end

function SWEP:PrimaryAttack()
	if self:Clip1() > 0 then
		if self.Owner:Health() >= self.Owner:GetMaxHealth() then
			-- self:EmitSound(self.Primary.DenySound)
			self:SetNextPrimaryFire(CurTime() + 0.5)
			return false
		end

		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:SendViewModelAnim(ACT_VM_PRIMARYATTACK)

		self:SetStatus(TFA.Enum.STATUS_SHOOTING)

		self:SetStatusEnd( CurTime() + (self.SequenceLengthOverride[tanim] or self.OwnerViewModel:SequenceDuration()) )
		self:SetNextPrimaryFire(self:GetStatusEnd())
	end
end

function SWEP:Think2()
	if self:GetStatus() == TFA.Enum.STATUS_SHOOTING and CurTime() >= self:GetStatusEnd() then
		self:TakePrimaryAmmo(1)

		self:EmitSound(self.Primary.SuccessSound)
		self.Owner:SetHealth( math.min( self.Owner:GetMaxHealth(), self.Owner:Health() + 50 ) )

		self:Deploy()
	end

	return BaseClass.Think2(self)
end