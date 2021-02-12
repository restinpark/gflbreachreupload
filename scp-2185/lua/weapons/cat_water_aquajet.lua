AddCSLuaFile("cat_water_aquajet.lua")
SWEP.Base = "cat_water"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "Water - Aqua Jet"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Aqua Jet
---------------------------------------------------------------------------]]
config.AquaJetDelay 	= 3    -- How long until you can use it again?
config.AquaJetDuration 	= 0    -- How long does it last?
config.AquaJetToggle 	= true -- Does the AquaJet toggle or destroy on delay?
config.AquaJetSpeed 	= 4    -- Multiplier of how much speed is gained.
config.AquaJetRange 	= 85   -- How far away to check for collision.
config.AquaJetRadius 	= 85   -- Splash radius.
config.AquaJetDamageMin = 20 
config.AquaJetDamageHigh= 25

config.AquaJetSound = "Physics.WaterSplash"
config.AquaJetPopEffect = "fx_poke_bubblepop"
config.AquaJetMaterial = "models/shadertest/shader3"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = true
config.AquaJetMessage 		= "Aqua Jet!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.Instructions = "Collide with players to deal damage!"
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
	local owner = self:GetOwner()
	if IsValid(owner) then
		if self.AquaJetEnabled == true then
			if owner:GetVelocity():Length() > 500 then
				local tr = util.TraceHull({
					start = owner:GetPos()+Vector(0,0,32),
					endpos = owner:GetPos()+Vector(0,0,32)+owner:GetForward()*config.AquaJetRange,
					mins = Vector( -16, -16, 16 ),
					maxs = Vector( 16, 16, 16 ),
					filter = owner
				})

				if tr.Hit then
					self:AquaJetExplode(tr.HitPos)
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if SERVER then self:ActivateAquaJet() end
end

function SWEP:SecondaryAttack()
end