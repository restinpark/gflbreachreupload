AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-038 Affliction"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/weapons/w_bugbait.mdl"
SWEP.droppable = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Damage = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.UseHands = false
SWEP.Contact = "GFL Forums"
SWEP.Purpose = "You were grown from SCP-038 and may not last long..."
SWEP.ItemType = WEAPON_OTHER or 11

function SWEP:Deploy()
  	self.Owner:DrawViewModel( false )
  	if SERVER then self.Owner:DrawWorldModel( false ) end
end

function SWEP:Holster()
	return true
end

function SWEP:Initialize()
	self:SetHoldType("normal")
	if SERVER then
	timer.Create("038Death", 300, 0, function()
		self.Owner:Kill()
	end)
	end
end
 
function SWEP:Think()
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()
end
