SWEP.Gun							= ("rw_sw_dc15a")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_gun_base"
SWEP.Category						= "Destiny Weapons"
SWEP.Manufacturer 					= ""
SWEP.Author							= "Delta"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "Invective"
SWEP.Type							= "'I tried to talk them down. They made a grab for my Ghost. After that it was a short conversation.' —Ikora Rey"
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 75
SWEP.Slot							= 3
SWEP.SlotPos						= 100

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.DoMuzzleFlash 					= true
SWEP.DisableChambering 				= false
SWEP.ShellEjectAttachment			= "shell" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.MuzzleAttachment				= "Muzzle"
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0.65 --The delay to actually eject things	 


SWEP.Primary.ClipSize				= 4
SWEP.Primary.DefaultClip			= 80
SWEP.Primary.RPM					= 164
SWEP.Primary.Ammo					= "buckshot"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.RangeFalloff = 0.1
SWEP.Primary.Range = 100
SWEP.Primary.NumShots				= 2
SWEP.Primary.Automatic				= true
SWEP.Primary.RPM_Semi				= 140
SWEP.Primary.Delay				    = 1
SWEP.Primary.Sound 					= Sound ("TFA_INVECTIVE_FIRE.1");
SWEP.Primary.PenetrationMultiplier 	= 1
SWEP.Primary.Damage					= 1
SWEP.Primary.HullSize 				= 1
SWEP.DamageType 					= DMG_BUCKSHOT
SWEP.Shotgun = true
SWEP.ForceEmptyFireOff = false
SWEP.ShellTime = 0.6 -- For shotguns, how long it takes to insert a shell.

SWEP.DoMuzzleFlash 					= true
SWEP.CustomMuzzleFlash = true
SWEP.MuzzleFlashEnabled = true

SWEP.FireModes = {
	"Single",
}


SWEP.IronRecoilMultiplier			= 0.5
SWEP.CrouchRecoilMultiplier			= 0.85
SWEP.JumpRecoilMultiplier			= 2
SWEP.WallRecoilMultiplier			= 1.1
SWEP.ChangeStateRecoilMultiplier	= 1.2
SWEP.CrouchAccuracyMultiplier		= 0.8
SWEP.ChangeStateAccuracyMultiplier	= 1
SWEP.JumpAccuracyMultiplier			= 10
SWEP.WalkAccuracyMultiplier			= 1.8
SWEP.NearWallTime 					= 0.5
SWEP.ToCrouchTime 					= 0.25
SWEP.WeaponLength 					= 35
SWEP.SprintFOVOffset 				= 2
SWEP.ProjectileVelocity 			= 9

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel						= "models/weapons/c_invective.mdl"
--SWEP.WorldModel						= "models/weapons/c_thorn.mdl"
SWEP.ViewModelFOV					= 54
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "crossbow"
SWEP.ReloadHoldTypeOverride 		= "crossbow"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= false
SWEP.BlowbackVector 				= Vector(0, -1.5, 0)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 0
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= true
SWEP.Blowback_PistolMode 			= false
SWEP.Blowback_Shell_Enabled 		= false
SWEP.Blowback_Shell_Effect 			= "ShotgunShellEject" -- ShotgunShellEject shotgun or ShellEject for a SMG    

SWEP.Tracer							= 0
SWEP.TracerName 					= nil
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0
//SWEP.ImpactDecal 					= "SmallScorch"

SWEP.IronSightTime 					= 0.35
SWEP.Primary.KickUp					= 1.6
SWEP.Primary.KickDown				= 1
SWEP.Primary.KickHorizontal			= 0.08
SWEP.Primary.StaticRecoilFactor 	= 0.5
SWEP.Primary.Spread					= 0.12
SWEP.Primary.IronAccuracy 			= 0.13
SWEP.Primary.SpreadMultiplierMax 	= 1.5
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 0.9
SWEP.IronSightsMoveSpeed 			= 0.75

SWEP.IronSightsPos = Vector(-4.915, -4, 1.2)
SWEP.IronSightsAng = Vector(-1, 0, 0)
SWEP.RunSightsPos = Vector(4.019, -5.226, -0.805)
SWEP.RunSightsAng = Vector(-14.07, 34.472, -11.256)
SWEP.InspectPos = Vector(5.427, -6.433, -4.422)
SWEP.InspectAng = Vector(23.215, 28.141, 5.627)

SWEP.Attachments = {
	//[1] = { offset = { 0, 0 }, atts = { "shotguncalus", "shotgunchrome" }, order = 1 },
	//[2] = { offset = { 0, 0 }, atts = { "seraph_extended_mag" }, order = 1 }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(-2.779, 0.185, -0.187), angle = Angle(0, -3, 0) },
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-16.667, 7.777, 0) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.111, 0, 0) }
}

SWEP.WElements = {
	["world"] = { type = "Model", model = "models/weapons/c_invective.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-9.5, 5, -7.901), angle = Angle(0, 0, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{time = 0.1, type = "sound", value = Sound("TFA_INVECTIVE_SHELL.1")},
	},
	[ACT_SHOTGUN_RELOAD_START] = {
		//{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm) wep:EventShell() end, ["client"] = true, ["server"] = true },
		{time = 0, type = "sound", value = Sound("TFA_INVECTIVE_RELOADSTART.1")}
	},
	[ACT_VM_PRIMARYATTACK] = {
		//{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm) wep:EventShell() end, ["client"] = true, ["server"] = true },
		{time = 0.4, type = "sound", value = Sound("TFA_INVECTIVE_PUMP.1")}
	},
	[ACT_VM_PRIMARYATTACK_1] = {
		//{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm) wep:EventShell() end, ["client"] = true, ["server"] = true },
		{time = 0.4, type = "sound", value = Sound("TFA_INVECTIVE_PUMP.1")}
	},
	[ACT_SHOTGUN_RELOAD_FINISH] = {
		//{ ["time"] = 0.15, ["type"] = "lua", ["value"] = function(wep, vm) wep:EventShell() end, ["client"] = true, ["server"] = true },
		{time = 0.15, type = "sound", value = Sound("TFA_INVECTIVE_RELOADEND.1")}
	}
}

DEFINE_BASECLASS( SWEP.Base )

function SWEP:PrimaryAttack(...)
	if self:CanPrimaryAttack(true) then
		ParticleEffectAttach("hl2mmod_muzzleflash_smg1", 4, self.OwnerViewModel, self.OwnerViewModel:LookupAttachment("muzzle"))
		ParticleEffectAttach("hl2mmod_muzzleflash_smg1", 4, self.OwnerViewModel, self.OwnerViewModel:LookupAttachment("muzzle"))
	end
	return BaseClass.PrimaryAttack(self, ...)
end

local MaxTimer				= 300
local CurrentTimer			= 0

function SWEP:Think2(...)
	if (self:Clip1() < 4) and SERVER then
		if (CurrentTimer >= 700) then 
			CurrentTimer = 0
			self:SetClip1( self:Clip1() + 1 )
		else
			CurrentTimer = CurrentTimer + 1
		end
	end
	if self:Clip1() == 1 then
		self.Primary.Damage = 80
		self.Primary.Sound = Sound ("TFA_INVECTIVE_FIREFINAL.1");
		self:ClearStatCache("Primary.Damage")
		self:ClearStatCache("Primary.Sound")
	end
	if self:Clip1() > 1 then
		self.Primary.Damage = 40
		self.Primary.Sound = Sound ("TFA_INVECTIVE_FIRE.1");
		self:ClearStatCache("Primary.Damage")
		self:ClearStatCache("Primary.Sound")
	end
	return BaseClass.Think2(self, ...)
end