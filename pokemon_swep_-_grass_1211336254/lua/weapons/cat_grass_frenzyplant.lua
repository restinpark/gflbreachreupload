AddCSLuaFile("cat_grass_frenzyplant.lua")
SWEP.Base = "cat_grasstype"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Grass - Frenzy Plant"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Floor Attack
---------------------------------------------------------------------------]]
config.FloorAttackDelay 		= 3   -- How long until you can use it again?
config.FloorAttackSpikes 		= 5   -- How many spikes will shoot out?
config.FloorAttackInterval 		= 0.3 -- Interval of time in between spikes.
config.FloorAttackRadius 		= 55
config.FloorAttackDistance 		= 50  -- Distance in between spikes.
config.FloorAttackDamageLow 	= 12
config.FloorAttackDamageHigh 	= 16
config.FloorAttackForce 		= 150 -- Upward force when hit.

config.FloorAttackSound = "npc/barnacle/neck_snap2.wav"
config.FloorAttackEffect = "fx_poke_grass"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = false
config.FloorAttackMessage 	= "Frenzy Plant!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Send forth a frenzy of plants and roots!"
SWEP.HoldType = "fist"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
SWEP.ShowWorldModel = false
SWEP.ShowViewModel = false
SWEP.UseHands = false
SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "none"
SWEP.Secondary.ClipSize       = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic      = false
SWEP.Secondary.Ammo           = "none"

--[[-------------------------------------------------------------------------
Default SWEP functions
---------------------------------------------------------------------------]]
function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.ShowViewModel = false
	self.UseHands = false
end
function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:FloorAttack()
end
function SWEP:SecondaryAttack() 

end
function SWEP:Think() end