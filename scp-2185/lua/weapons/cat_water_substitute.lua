AddCSLuaFile("cat_water_substitute.lua")
SWEP.Base = "cat_water"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Normal - Substitute"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Substitute
---------------------------------------------------------------------------]]
config.SubstituteDelay 		= 5    -- How long until you can use it again?
config.SubstituteHealthMulti= 0.10 -- Multiplier of the doll health from user.
config.SubstituteManualReset= true -- If true, can disable substitute by using it again.
config.SubstituteModel = "models/substitute/substitute.mdl"

config.SubstituteSound = "vehicles/airboat/pontoon_impact_hard1.wav"
config.SubstituteEffect = "Explosion"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = true
config.SubstituteMessage 	= "Substitute!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Trade %10 of your current HP for the saftey of a doll."
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

-- POKE VARIABLES
SWEP.POKE_MoveType = "normal"

--[[-------------------------------------------------------------------------
Default SWEP functions
---------------------------------------------------------------------------]]
function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.ShowViewModel = false
	self.UseHands = false
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()
	if SERVER then self:Substitute() end
end

function SWEP:SecondaryAttack()
end
