if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("models/scp/keycard5/keycardu")
	SWEP.BounceWeaponIcon = false
end


SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/c_keycard5.mdl"
SWEP.WorldModel		= "models/props/sl/keycard5.mdl"
SWEP.PrintName		= "O5 Keycard"
SWEP.Slot = 0
SWEP.SlotPos = 5
SWEP.ItemType = WEAPON_KEYCARD or 2
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.UseHands = true
SWEP.AdminSpawnable	= false
SWEP.Category = "Breach"
SWEP.Purpose = "Level 5 Keycard"
function SWEP:GetBetterOne()
	local r = math.random(1,3)
	if r == 3 then
		return "weapon_scp_005"
	else
		return "keycard_5"
	end
end
SWEP.droppable				= true
SWEP.clevel					= 5
SWEP.teams					= {2,3,5,6}

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

function SWEP:Deploy()
	self.Owner:DrawViewModel( true )
end
function SWEP:DrawWorldModel()
	if !IsValid(self.Owner) then
		self:DrawModel()
	end
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end
function SWEP:Think()
end
function SWEP:Reload()
end
function SWEP:PrimaryAttack()
end
function SWEP:SecondaryAttack()
end
function SWEP:CanPrimaryAttack()
end
