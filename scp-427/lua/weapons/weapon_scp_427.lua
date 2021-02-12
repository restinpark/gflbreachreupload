AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-427"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/scp_427_model/scp_427.mdl"
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
SWEP.Purpose = "LMB to open the locket. RMB to close the locket."
SWEP.IsOn = false
SWEP.ItemType = WEAPON_MEDICAL or 8

function SWEP:Deploy()
  	self.Owner:DrawViewModel( false )
  	if SERVER then self.Owner:DrawWorldModel( false ) end
end

function SWEP:Holster()
	return true
end

function SWEP:Initialize()
	self:SetHoldType("normal")
end
 
function SWEP:Think()
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
if SERVER then
	self.Owner:SetNWString("427", "on")
	self.Owner:PrintMessage(3, "You open the locket.")
	self.Owner:EmitSound("scp_427_loop.mp3")
		timer.Create("Heal", 1, 0, function()
			if self.Owner:GetNWString("427", "unset") == "on" then
				self.Owner:GiveAmmo(1, "StriderMinigun", true)
				self.Owner:SetHealth(math.Clamp(self.Owner:Health() + 10, 0, self.Owner:GetMaxHealth()))
			end
		end)
	end
end
function SWEP:SecondaryAttack()
if SERVER then
	self.Owner:SetNWString("427", "off")
	self.Owner:PrintMessage(3, "You close the locket.")
	end
end

function SWEP:DrawHUD()
end
