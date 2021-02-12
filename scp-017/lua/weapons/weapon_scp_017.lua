AddCSLuaFile("poke_ghost_phantomforce.lua")
SWEP.Base = "poke_ghosttype"
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "SCP-017"
SWEP.droppable = false
SWEP.Author = "Cat and Demonkush"
config.ActionDelay = 10 -- Time in between each action.
--[[-------------------------------------------------------------------------
Phantom Force
---------------------------------------------------------------------------]]
config.PhantomForceDelay = 13 -- How long until you can use it again after attack?
config.PhantomForceDuration = 7 -- How long can you use this for?
config.PhantomForceRadius = 90 -- Radius around the player shadow to deal damage?
config.PhantomForceDamageLow = 95
config.PhantomForceDamageHigh = 120
config.PhantomForceDamageForce = 50000 -- Force applied on damage.

config.PhantomForceSound = "weapons/airboat/airboat_gun_energy1.wav"
config.PhantomForceStartSound = "weapons/underwater_explode4.wav"
config.PhantomForceSoundPitch = 75
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = false
config.PhantomForceMessage = "Phantom Force!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Category = "Breach"
SWEP.Instructions = "Become the shadow and attack an enemy at will!"
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
function SWEP:Think()
	local owner = self:GetOwner()
	if self.PhantomForceEnabled then
		if self.NextFX < CurTime() then
			local shadow = EffectData()
			shadow:SetOrigin(self:GetOwner():GetPos())
			shadow:SetNormal(Vector(0,0,1))
			shadow:SetScale(55)
			util.Effect("fx_poke_shadow",shadow)

			self.NextFX = CurTime() + self.FXDelay
		end
	end
end
 
function SWEP:PrimaryAttack()
	if SERVER then self:PhantomForceStart() end
	if CLIENT then
		self.NextAction = CurTime() + 6
	end
end
function SWEP:SecondaryAttack()
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to attack"
	local showcolor = Color(0,255,0)

	if self:GetNWFloat("nextattack", 0) > CurTime() then
		showtext = "Next attack in " .. math.Round(self:GetNWFloat("nextattack", 0) - CurTime())
		showcolor = Color(255,0,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 30 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( 0, 255, 0, 255 )

	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
end
