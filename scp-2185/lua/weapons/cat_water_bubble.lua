AddCSLuaFile("cat_water_bubble.lua")
SWEP.Base = "cat_water"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Water - Bubble"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Bubble
---------------------------------------------------------------------------]]
config.BubbleDelay 		= 4   -- How long until you can use it again?
config.BubbleLife 		= 5   -- How long in seconds do the bubbles last?
config.BubbleInterval 	= 0.1 -- Time in between bubbles.
config.BubbleSpeed		= 512 -- How fast do the bubbles move?
config.BubbleSpread 	= 10
config.BubbleSpews 		= 15  -- How many bubbles will shoot out?
config.BubbleDrunken 	= true -- Does the bubble constantly add random velocity?
config.BubbleDamageLow 	= 3
config.BubbleDamageHigh = 6
config.BubbleRadius 	= 55  -- Bubble size and pop size.
config.BubbleForce 		= 55 -- Bubble pop force.

config.BubbleShootSound = "ambient/water/water_spray1.wav"
config.BubblePopSound = "ambient/water/water_splash3.wav"
config.BubbleEffect = "fx_poke_bubblepop"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = true
config.BubbleMessage 		= "Bubble!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Summon an army of bubbles."
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

function SWEP:Think()
end

function SWEP:PrimaryAttack()
	if SERVER then self:Bubble() end
end

function SWEP:SecondaryAttack()

end