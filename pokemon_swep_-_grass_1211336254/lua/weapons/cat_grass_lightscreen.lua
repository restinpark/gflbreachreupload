AddCSLuaFile("cat_grass_lightscreen.lua")
SWEP.Base = "cat_grasstype"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Psychic - Lightscreen"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Shield
---------------------------------------------------------------------------]]
config.ShieldDelay 		= 5    -- How long until you can use it again?
config.ShieldDistance 	= 55   -- How far away in front of you the shield is.
config.ShieldDuration 	= 8    -- How long does the shield last?
config.ShieldHealth 	= 1000  -- How much health does the shield have?
config.ShieldToggle 	= false -- Does the shield toggle or destroy on delay?
config.ShieldModel 		= "models/props_debris/metal_panel02a.mdl"
config.ShieldMaterial   = "models/props_combine/portalball001_sheet"

config.Shield2DToggle 	= true -- Whether or not to use a 2D sprite instead of the model.
config.Shield2DMaterial = "poke/overlay/lightscreen1.png"
config.Shield2DScale 	= 32
config.Shield2DColor = Color(255,255,5,155)

config.ShieldSound = "weapons/physcannon/energy_bounce2.wav"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = false
config.ShieldMessage 		= "Protect!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Instructions = "Primary- Activate Shield | Secondary- Toggle Shield"
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
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
SWEP.POKE_MoveType = "light"

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
	local offset = Vector(0,0,64)
	if IsValid(self.Shield) then
		if IsEntity(self.Shield) then
			self.Shield:SetPos(owner:GetPos()+owner:GetForward()*config.ShieldDistance+offset)
			self.Shield:SetAngles(owner:GetAngles())
		end
	end
end
function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:ActivateShield(false)
end
function SWEP:SecondaryAttack()
	if CLIENT then return end
	self:ActivateShield(true)
end