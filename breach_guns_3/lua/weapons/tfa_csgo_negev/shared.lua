SWEP.Category = "TFA CS:GO"
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.MuzzleAttachment = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName = "Negev" -- Weapon name (Shown on HUD)
SWEP.Slot = 3
SWEP.SlotPos = 10
SWEP.ItemType = WEAPON_GUN or 6
SWEP.DrawAmmo = true -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon = false -- Should the weapon icon bounce?
SWEP.DrawCrosshair = false -- set false if you want no crosshair
SWEP.Weight = 30 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType = "ar2" -- how others view you carrying the weapon
SWEP.UseHands = true
SWEP.ViewModelFOV = 56
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/tfa_csgo/c_mach_negev.mdl" -- Weapon view model
SWEP.WorldModel = "models/weapons/tfa_csgo/w_negev.mdl" -- Weapon world model
SWEP.Base = "tfa_csgo_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.FiresUnderwater = false
SWEP.Primary.Sound = Sound("TFA_CSGO_NEGEV.1") -- Script that calls the primary fire sound
SWEP.Primary.RPM = 800 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize = 150 -- Size of a clip
SWEP.Primary.DefaultClip = 0 -- Bullets you start with
SWEP.Primary.KickUp = 0.2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.025 -- Maximum up recoil (stock)
SWEP.Primary.Automatic = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo = "ar2"
SWEP.NearlyEmpty_ClipSize = 29
SWEP.Secondary.IronFOV = 60 -- How much you 'zoom' in. Less is more!
SWEP.data = {} --The starting firemode
SWEP.data.ironsights = 1
SWEP.Primary.NumShots = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage = 11 -- Base damage per bullet
SWEP.Primary.Spread = .01 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .005 -- Ironsight accuracy, should be the same for shotguns
-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-7.9, -4, 2.32)
SWEP.IronSightsAng = Vector(-0.538, -0.43, -1.5)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)
--SWEP.InspectPos = Vector(0,0,0)
--SWEP.InspectAng = Vector(0,0,0)
SWEP.DisableIdleAnimations = false
SWEP.ForceDryFireOff = true
SWEP.ForceEmptyFireOff = false
SWEP.FidgetLoop = false --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.Primary.Range = 0.5 / 0.305 * 16 * 1000
SWEP.Primary.SpreadIncrement = 0.6
SWEP.Primary.SpreadRecovery = 3
SWEP.Primary.SpreadMultiplierMax = 4
SWEP.CustomMuzzleFlash = true
SWEP.AutoDetectMuzzleAttachment = false
SWEP.MuzzleFlashEffect = "tfa_csgo_muzzle_para_negev"

SWEP.TracerParticleName = "weapon_tracers_mach"

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 115 / 30
}

SWEP.Offset = {
	Pos = {
		Up = 0.5,
		Right = 1,
		Forward = 3
	},
	Ang = {
		Up = 4,
		Right = -3,
		Forward = 180
	},
	Scale = 1
}

SWEP.LuaShellEject = true --Entity to shoot's model
SWEP.LuaShellEffect = "RifleShellEject" --Defaults to blowback
SWEP.Blowback_Shell_Effect = "RifleShellEject"
SWEP.BlowbackEnabled = true
SWEP.BlowbackVector = Vector(0, -3, 0)

SWEP.BlowbackBoneMods = {
	["v_weapon.bullet_00"] = {
		scale = Vector(1, 1, 1),
		pos = Vector(-0.181, -0.181, 0.18),
		angle = Angle(0, -3.254, 0)
	}
}

SWEP.MoveSpeed = 230/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 150/260*0.8 --Multiply the player's movespeed by this when sighting.
DEFINE_BASECLASS(SWEP.Base)
SWEP.ShootWhileDraw = false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw = false --Can you reload while draw anim plays?
SWEP.SightWhileDraw = false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster = false --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster = false --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster = false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload = true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting = false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall = false --Can you reload when close to a wall and facing it?
SWEP.ShootingResetDelay = -1
SWEP.BulletCount = 0
SWEP.BulletCountClamp = 20
SWEP.BulletCountCapReleased = 15
SWEP.BulletCountRecovery = 20
SWEP.BulletCountRecoveryPeak = 0.8
SWEP.BulletCountRecoveryPower = 0.66
SWEP.BulletSpreadPowerFactor = 10
SWEP.BulletSpreadQuadraticPower = 0.5
SWEP.BulletSpreadCubicPower = -0.4
SWEP.BulletSpreadRootPower = 0.005

SWEP.Animations = {
	["empty_reload"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_EMPTY
	},
	["empty_idle"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_EMPTY
	},
	["empty_shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_EMPTY
	}
}

SWEP.MagModel = Model("models/weapons/tfa_csgo/w_mach_negev_mag.mdl")
SWEP.EmptyMagModel = Model("models/weapons/tfa_csgo/w_mach_negev_mag_empty.mdl")

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{
			["time"] = 0,
			["type"] = "lua",
			["value"] = function(wep, vm)
				local clip = wep:Clip1()

				if clip <= 0 or wep:GetNW2Bool("IsEmpty", true) then
					for i = 1, 22 do
						wep:SetBodyGroupVM(i, 1)
					end
				else
					for i = 1, math.Clamp(clip, 0, 22) do
						wep:SetBodyGroupVM(i, 0)
					end
				end
			end,
			["client"] = true,
			["server"] = true
		}
	},
	[ACT_VM_IDLE_EMPTY] = {
		{
			["time"] = 0,
			["type"] = "lua",
			["value"] = function(wep, vm)
				for i = 1, 22 do
					wep:SetBodyGroupVM(i, 1)
				end

				wep:SetNW2Bool("IsEmpty", true)
			end,
			["client"] = true,
			["server"] = true
		}
	},
	[ACT_VM_PRIMARYATTACK] = {
		{
			["time"] = 0,
			["type"] = "lua",
			["value"] = function(wep, vm)
				local clip = wep:Clip1()

				if clip < 22 then
					wep:SetBodyGroupVM(clip, 1)
				end
			end,
			["client"] = true,
			["server"] = true
		}
	},
	[ACT_VM_PRIMARYATTACK_EMPTY] = {
		{
			["time"] = 0,
			["type"] = "lua",
			["value"] = function(wep, vm)
				for i = 1, 22 do
					wep:SetBodyGroupVM(i, 1)
				end

				wep:SetNW2Bool("IsEmpty", true)
			end,
			["client"] = true,
			["server"] = true
		}
	},
	[ACT_VM_RELOAD] = {
		{
			time = 50 / 30,
			type = "lua",
			value = function(wep, vm)
				local clip = wep:Clip1()

				if clip <= 0 then
					wep.MagModel = wep.EmptyMagModel
				end

				wep:DropMag()
			end,
			client = true,
			server = true
		},
		{
			["time"] = 52 / 30,
			["type"] = "lua",
			["value"] = function(wep, vm)
				local nextclip = wep:Ammo1()

				for i = 1, math.Clamp(nextclip, 0, 22) do
					wep:SetBodyGroupVM(i, 0)
				end
			end,
			["client"] = true,
			["server"] = true
		},
		{
			["time"] = 115 / 30,
			["type"] = "lua",
			["value"] = function(wep, vm)
				wep:SetNW2Bool("IsEmpty", false)
			end,
			["client"] = true,
			["server"] = true
		}
	}
}

function SWEP:Initialize(...)
	self.SetNW2Bool = self.SetNW2Bool or self.SetNWBool
	self:SetNW2Bool("IsEmpty", false)
	BaseClass.Initialize(self, ...)
end

function SWEP:Think2(...)
	local clip = self:Clip1()

	if self:GetStatus() ~= TFA.GetStatus("shooting") then
		if self.ShootingResetDelay == -1 then
			self.ShootingResetDelay = CurTime() + 0.05
		elseif CurTime() > self.ShootingResetDelay then
			self.BulletCount = math.Clamp(self.BulletCount - FrameTime() * self.BulletCountRecovery * (self.BulletCountRecoveryPeak + math.pow(self.BulletCount / self.BulletCountClamp, self.BulletCountRecoveryPower) * (1 - self.BulletCountRecoveryPeak)), 0, self.BulletCountCapReleased)
		end
	else
		self.ShootingResetDelay = -1
	end

	if clip <= 0 then
		self:SetNW2Bool("IsEmpty", true)
	end

	BaseClass.Think2(self, ...)
end

local fire_sound_normie = Sound("TFA_CSGO_NEGEV.1")
local fire_sound_cap = Sound("TFA_CSGO_NEGEV.2")

function SWEP:PrimaryAttack(...)
	self.Primary.Sound = (self.BulletCount > self.BulletCountClamp - 1) and fire_sound_cap or fire_sound_normie
	local clip = self:Clip1()

	if clip < 21 then
		self:SetBodyGroupVM(clip, 1)
	end

	return BaseClass.PrimaryAttack(self, ...)
end

function SWEP:ShootBullet(...)
	if game.SinglePlayer() then
		self:CallOnClient("IncrementBulletCount", "")
	end

	self.BulletCount = math.min(self.BulletCount + 1, self.BulletCountClamp)

	return BaseClass.ShootBullet(self, ...)
end

function SWEP:IncrementBulletCount()
	self.BulletCount = math.min(self.BulletCount + 1, self.BulletCountClamp)
end

function SWEP:CalculateConeRecoil(...)
	self.SpreadRatio = 1
	local cone, recoil = BaseClass.CalculateConeRecoil(self, ...)
	cone = cone + math.max(0, math.pow(self.BulletCount / self.BulletSpreadPowerFactor, 2) * self.BulletSpreadQuadraticPower + math.pow(self.BulletCount / self.BulletSpreadPowerFactor, 3) * self.BulletSpreadCubicPower) + math.sqrt(self.BulletCount) * self.BulletSpreadRootPower

	return cone, recoil
end
-- function SWEP:FireAnimationEvent(pos, ang, event, options)
-- local clip = self:Clip1()
-- local ammo = self:Ammo1()
-- local stat = self:GetStatus()
-- local vm = self.OwnerViewModel
-- local nextclip = 0
-- --print(event,options)
-- if event == 57 or event == 58 then
-- for i = 0, math.Clamp(clip, 1, 20) do
-- self:SetBodyGroupVM(i,0)
-- end
-- if clip < 21 then
-- self:SetBodyGroupVM( math.Clamp(clip, 1, 20) ,1)
-- end
-- end
-- if event == 59 then
-- nextclip = self:Ammo1()
-- for i = 1, math.Clamp(nextclip , 1, 20) do
-- self:SetBodyGroupVM(i,0)
-- end
-- end
-- return BaseClass.FireAnimationEvent and BaseClass.FireAnimationEvent(self, pos, ang, event, options) or true
-- end