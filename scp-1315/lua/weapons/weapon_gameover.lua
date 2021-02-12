AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "Game Code"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/vinrax/props/keycard.mdl"
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
SWEP.Purpose = "LMB to exit the game if all enemies have been defeated"
SWEP.IsOn = false

function SWEP:Deploy()
  	self.Owner:DrawViewModel( false )
  	if SERVER then self.Owner:DrawWorldModel( false ) end
	timer.Simple(120, function() self.Owner:Kill() end)
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
for k,v in pairs(player.GetAll()) do
	if v:GetNClass() == ROLE_PLAYER1 or v:GetNClass() == ROLE_PLAYER2 or v:GetNClass() == ROLE_PLAYER3 then return end
	end
	self.Owner:PrintMessage(3, "You win!")
	self.Owner:PrintMessage(3, "Seems the power has been cut to SCP-1315.")
	self.Owner:Kill()
	self.Owner:StripWeapon("weapon_game")
end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()
end
