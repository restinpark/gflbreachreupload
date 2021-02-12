AddCSLuaFile("cat_grass_machpunch.lua")
SWEP.Base = "cat_grasstype"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Fighting - Mach Punch"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Melee Attack
---------------------------------------------------------------------------]] 
config.MeleeAttackDelay 		= 1   -- Time in between punches.
config.MeleePunchRange 			= 135  -- Distance between you and the target.
config.MeleeDamageLow 			= 15
config.MeleeDamageHigh 			= 25
config.MeleePunchForce 			= 20 -- How much force to apply to targets?
config.MeleeToggleDelay 		= 2   -- How long until you can toggle again?

config.MeleeSwingSound = Sound( "WeaponFrag.Throw" )
config.MeleePunchSound = Sound( "Flesh.ImpactHard" )
config.MeleeEffect = "fx_poke_melee"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = false
config.MeleeAttackMessage 	= "Mach Punch!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Punch foes at high speed and send them flying!"
SWEP.HoldType = "fist"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
SWEP.ShowWorldModel = false
SWEP.ShowViewModel = true
SWEP.UseHands = true
SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "none"
SWEP.Secondary.ClipSize       = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic      = false
SWEP.Secondary.Ammo           = "none"

-- POKE VARIABLES
SWEP.POKE_MoveType = "normal"

--[[-------------------------------------------------------------------------
Default SWEP functions
---------------------------------------------------------------------------]]
function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end
function SWEP:Think()
	local owner = self:GetOwner()
	-- Fist SWEP stuff
	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()
	if (idletime > 0 && CurTime() > idletime) then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_idle_0"..math.random(1,2)))
		self:UpdateNextIdle()
	end
	if (self.MeleeAttacked > 0) then
		self:DealDamage()
		self.MeleeAttacked = 0
	end
	if (SERVER && CurTime() > self:GetNextPrimaryFire() + 0.1) then
		self:SetCombo(0)
	end
end
function SWEP:PrimaryAttack()
	self:MeleeAttack()
end
function SWEP:SecondaryAttack()
	self:MeleeAttack()
end