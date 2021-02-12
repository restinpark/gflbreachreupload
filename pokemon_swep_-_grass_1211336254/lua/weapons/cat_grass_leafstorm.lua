AddCSLuaFile("cat_grass_leafstorm.lua")
SWEP.Base = "cat_grasstype"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Grass - Leaf Storm"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
AoE Damage
---------------------------------------------------------------------------]]
config.AoEDamageDelay 		= 5    -- How long until you can use it again?
config.AoEDamageSteps 		= 15   -- How many times will the AoE deal damage?
config.AoEDamageRadius 		= 135  -- The effective area (radius around you).
config.AoEDamageInterval 	= 0.3  -- Time in between damage.
config.AoEDamageLow 		= 10 
config.AoEDamageHigh 		= 15 

config.AoEDamageSound = "vehicles/airboat/pontoon_impact_hard1.wav"
config.AoEDamageEffect = "fx_poke_leaf"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = false
config.AoEDamageMessage = "Leaf Storm!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Surround yourself an aoe and damage foes."
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
	self:AoEDamage()
end
function SWEP:SecondaryAttack() 

end
function SWEP:Think() end