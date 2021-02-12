
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("models/scp/keycarden/keycardu")
	SWEP.BounceWeaponIcon = false
end


SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/c_keycarden.mdl"
SWEP.WorldModel		= "models/props/sl/keycarden.mdl"
SWEP.PrintName		= "Containment Engineer Keycard"
SWEP.Slot = 0
SWEP.SlotPos = 5
SWEP.ItemType = WEAPON_KEYCARD or 2
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.UseHands = true
SWEP.Purpose = "Level 3 Keycard"
SWEP.AdminSpawnable	= false
SWEP.Category = "Breach"
function SWEP:GetBetterOne()
	local r = math.random(1,2)
	if r == 1 then
		return table.Random({"keycard_en", "keycard_sg", "keycard_bg", "keycard_zm"})
	else
		return table.Random({"keycard_fm", "keycard_cg", "keycard_lt"})
	end
end
SWEP.droppable				= true
SWEP.clevel					= 3
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
