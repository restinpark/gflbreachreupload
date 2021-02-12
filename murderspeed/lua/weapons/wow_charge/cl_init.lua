include('shared.lua')

local version = "1.1" -- Current version

SWEP.WepSelectIcon		= surface.GetTextureID("wow_charge")
SWEP.BounceWeaponIcon	= false

SWEP.PrintName = "Charge"
SWEP.Contact = "\n[...]/id/_mailer/"
SWEP.Author = "\nMailer\n"
SWEP.Purpose = "Self-casts a buff to charge towards a target"
SWEP.Instructions = "LMB to cast"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.base = "weapon_base"
SWEP.Category = "[World of Warcraft] Spells"
SWEP.DrawCrosshair = false
SWEP.HoldType = "melee"
SWEP.FiresUnderwater = true

SWEP.Weight = 3
SWEP.Slot = 1
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.ShowViewModel = false
SWEP.UseHands = false
SWEP.ViewModelFOV = 90
SWEP.ViewModelFlip = false

SWEP.ShowWorldModel = false

function SWEP:Initialize()
	self:SetHoldType( "melee" )
end