AddCSLuaFile("cat_water_hydropump.lua")
SWEP.Base = "cat_water"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Water - Hydro Pump"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Hydro Pump
---------------------------------------------------------------------------]]
config.HydroPumpDelay 	= 5   -- How long until you can use it again?
config.HydroPumpTimer 	= 5   -- How long is it active? ( 0 = toggle, deactivates when key is released )
config.HydroPumpInterval 	= 0.1 -- Time in between damages.
config.HydroPumpForce 		= 115 -- Force of the beam ending.
config.HydroPumpMaxRange 	= 1155 -- How far the beam can go.
config.HydroPumpDamageLow 	= 2
config.HydroPumpDamageHigh 	= 4

config.HydroPumpSound = "Physics.WaterSplash"

config.HydroPumpScale 			= 25 -- Size of beam and water effects.
config.HydroPumpBeamEffect 		= "fx_poke_hydropump"
config.HydroPumpImpactEffect 	= "fx_poke_bubblepop"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = true
config.HydroPumpMessage 	= "Hydro Pump!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Send out high speed water at jet speed to damage foes."
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
SWEP.Primary.Automatic      = false
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
	local owner = self:GetOwner()
	if SERVER then
		if owner:KeyDown(IN_ATTACK) then
			self:HydroPumpActivate()
		end
		if owner:KeyReleased(IN_ATTACK) then
			if config.HydroPumpTimer <= 0 then
				self:HydroPumpRemove()
			end
		end
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end