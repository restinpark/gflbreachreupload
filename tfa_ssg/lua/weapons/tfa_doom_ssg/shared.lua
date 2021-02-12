SWEP.Base = "tfa_bash_base"
SWEP.Category = "TFA DOOM"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.VMPos = Vector(0.5, 0, -0.5)
SWEP.VMPos_Additive = false
SWEP.Slot = 3
SWEP.SlotPos = 10
SWEP.ItemType = WEAPON_GUN or 6
SWEP.PrintName = "SSG Prototype 13"
SWEP.Manufacturer = "The SCP Foundation"
SWEP.Type = "Shotgun"
SWEP.ViewModel = "models/weapons/tfa_doom/c_ssg.mdl" --Viewmodel path
SWEP.ViewModelFOV = 56
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/tfa_doom/w_ssg.mdl" --Viewmodel path
SWEP.DefaultHoldType = "shotgun"
SWEP.HoldType = "shotgun"
SWEP.Scoped = false
SWEP.Shotgun = false
SWEP.Primary.AmmoConsumption = 1--2
--SWEP.Primary.ClipSize = -1
SWEP.DisableChambering = true
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Sound = Sound( "TFA_DOOM_SSG.2" )
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 600
SWEP.Primary.Damage = 7
SWEP.Primary.Damage_NPC = 70
SWEP.Primary.DamageTypeHandled = false --true will handle damagetype in base
SWEP.Primary.HullSize = 1
SWEP.Primary.DamageType = bit.bor(DMG_ALWAYSGIB, DMG_BULLET, DMG_AIRBOAT)
SWEP.Primary.NumShots = 6--16
SWEP.Primary.Spread = .08 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .05 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.KickUp = 1.25 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 1.0 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.8 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.4 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.Primary.Knockback = 60
SWEP.Primary.MaxPenetration = 2
SWEP.Primary.PenetrationMultiplier = 4
SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 4

SWEP.FireModeName = "Break-Action"

SWEP.data = {}
SWEP.data.ironsights = 0
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-1.56 + 0.5 , 0, 1.159 - 0.5)
SWEP.IronSightsAng = Vector(0.6, 0.219, 0.127)

SWEP.CenteredPos = Vector(-1.55, -1, -1.04)
SWEP.CenteredAng = Vector(-1.5, 0.2, 0)

SWEP.RunSightsPos = Vector(0,0,0) + SWEP.VMPos
SWEP.RunSightsAng = Vector(-10,0,0) + ( SWEP.VMAng or vector_origin )
SWEP.DrawCrosshairIS = true
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA

SWEP.Idle_Mode = TFA.Enum.IDLE_LUA --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA

SWEP.Attachments = {

}

SWEP.SmokeParticle = ""
SWEP.MuzzleFlashEffect = "tfa_doomssg_muzzle"

SWEP.EventTable = {
	[ACT_VM_PRIMARYATTACK] = {
		--[[
		{
			["time"] = 0.2,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) then
					wep:SetNW2Bool("NeedsReload",true)
				end
			end
		},
		{
			["time"] = 0.3,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) and wep.Reload then
					wep:ChooseReloadAnim()
				end
			end
		}
		]]--
		{
			["time"] = 0.3,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) and wep.Reload and wep:Clip1() < 0.1 then
					wep:Reload( true )
				end
			end
		}
	},
	[ACT_VM_RELOAD] = {
		{
			["time"] = 15 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.EjectGear"
		},
		{
			["time"] = 17.5 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.ReloadOpen"
		},
		{
			["time"] = 20.5 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.EjectTube"
		},
		{
			["time"] = 21 / 60,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) and wep.EjectionSmoke then
					wep.EjectionSmokeEnabled = true
					wep:EjectionSmoke(true)
					wep.EjectionSmokeEnabled = false
				end
			end
		},
		{
			["time"] = 50 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.Insert"
		},--[[
		{
			["time"] = 51 / 60,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) then
					wep:SetNW2Bool("NeedsReload",false)
				end
			end
		},]]--
		{
			["time"] = 71 / 60 - 0.28,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.ReloadClose"
		}
	}
}

SWEP.AllowSprintAttack = true
SWEP.EjectionSmokeEnabled = false
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 21 / 60 --The delay to actually eject things
SWEP.LuaShellEffect = "" --The effect used for shell ejection; Defaults to that used for blowback

SWEP.Secondary.BashDelay = 0.1
SWEP.Secondary.BashDamage = 25
SWEP.Secondary.BashInterrupt = true
SWEP.Secondary.BashSound = Sound("TFA_DOOM_SSG.Bash")

SWEP.InspectPos = Vector(8.6, -5.5, -2.58)
SWEP.InspectAng = Vector(29, 44, 20)

SWEP.StatusLengthOverride = {}
SWEP.StatusLengthOverride[ACT_VM_RELOAD] = 50 / 60
SWEP.StatusLengthOverride[ACT_VM_HITCENTER] = 0.7

SWEP.SequenceLengthOverride = {}
SWEP.SequenceLengthOverride[ACT_VM_RELOAD] = 1.3
SWEP.SequenceLengthOverride[ACT_VM_HITCENTER] = 0.6
SWEP.SequenceLengthOverride[ACT_VM_DRAW] = 0.3

SWEP.SequenceRateOverrideScaled = {}
SWEP.SequenceRateOverrideScaled[ACT_VM_DRAW] = 1.5

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.2
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-60, -50, 20)


SWEP.Double = false

DEFINE_BASECLASS(SWEP.Base)

function SWEP:Deploy( ... )
	self:CompleteReload()
	return BaseClass.Deploy(self,...)
end


function SWEP:PrimaryAttack( skip_parse, ... )
	if not self:GetStat("Double") then
		self.Primary.DefaultNumShots = self.Primary.NumShots
		self.Primary.DefaultAmmoConsumption = self.Primary.AmmoConsumption
		self.Primary.DefaultKickUp = self.Primary.KickUp
		self.Primary.DefaultKickDown = self.Primary.KickDown

		self.Primary.NumShots = self.Primary.NumShots * 2
		self.Primary.AmmoConsumption = self.Primary.AmmoConsumption * 2
		self.Primary.KickUp = self.Primary.KickUp * 2
		self.Primary.KickDown = self.Primary.KickDown * 2

		BaseClass.PrimaryAttack( self, true, ... )

		self.Primary.NumShots = self.Primary.DefaultNumShots
		self.Primary.AmmoConsumption = self.Primary.DefaultAmmoConsumption
		self.Primary.KickUp = self.Primary.DefaultKickUp
		self.Primary.KickDown = self.Primary.DefaultKickDown
	else
		return BaseClass.PrimaryAttack( self, true, ... )
	end
end
function SWEP:SecondaryAttack( ... )
	if self:GetStat("data.ironsights") == 0 and self:GetStat("Double") then
		if self:Clip1() > 1 then
			self.Primary.DefaultNumShots = self.Primary.NumShots
			self.Primary.DefaultAmmoConsumption = self.Primary.AmmoConsumption
			self.Primary.DefaultKickUp = self.Primary.KickUp
			self.Primary.DefaultKickDown = self.Primary.KickDown

			self.Primary.NumShots = self.Primary.NumShots * 2
			self.Primary.AmmoConsumption = self.Primary.AmmoConsumption * 2
			self.Primary.KickUp = self.Primary.KickUp * 2
			self.Primary.KickDown = self.Primary.KickDown * 2

			BaseClass.PrimaryAttack( self, true, ... )

			self.Primary.NumShots = self.Primary.DefaultNumShots
			self.Primary.AmmoConsumption = self.Primary.DefaultAmmoConsumption
			self.Primary.KickUp = self.Primary.DefaultKickUp
			self.Primary.KickDown = self.Primary.DefaultKickDown
		else
			return BaseClass.PrimaryAttack( self, true, ... )
		end
		return
	elseif self:GetStat("data.ironsights") == 0 then
		return BaseClass.SecondaryAttack( self, ... )
	end
end

--[[
function SWEP:Think2( ... )
	self.SetNW2Bool = self.SetNW2Bool or self.SetNWBool
	self.GetNW2Bool = self.GetNW2Bool or self.GetNWBool
	if self:GetNW2Bool("NeedsReload") and self:GetStatus() == TFA.GetStatus("idle") then
		local _, tanim = self:ChooseReloadAnim()
		self:SetStatus(TFA.GetStatus("reloading"))
		self:SetStatusEnd( CurTime() + self:GetActivityLength( tanim ) )
	end
	return BaseClass.Think2(self,...)
end
]]--