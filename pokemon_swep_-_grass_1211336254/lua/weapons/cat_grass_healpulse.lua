AddCSLuaFile("cat_grass_healpulse.lua")
SWEP.Base = "cat_grasstype"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Psychic - Heal Pulse"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
AoE Heal
---------------------------------------------------------------------------]]
config.AoEHealDelay 	= 5   -- How long until you can use it again?
config.AoEHealSteps 	= 7   -- How many times does it send a heal wave?
config.AoEHealRadius 	= 256 -- The effective area (radius around you).
config.AoEHealInterval 	= 0.3 -- Time in between heals.
config.AoEHealAmount 	= 4   -- Amount of health gained each interval.

config.AoEHealSound = "weapons/physcannon/physcannon_charge.wav"
config.AoEHealEffect = "fx_poke_heal"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = false
config.AoEHealMessage = "Refresh!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Heal yourself and allies in a small aoe."
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
	self:AoEHeal()
end
function SWEP:SecondaryAttack() 

end
function SWEP:Think() end