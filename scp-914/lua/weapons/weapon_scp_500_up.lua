SWEP.Spawnable = true
SWEP.PrintName = "SCP-500-[REDACTED]"
SWEP.Author = ""
SWEP.Contact = "uhh"
SWEP.Purpose = "Maybe a cure"
SWEP.Instructions = "Primary fire uses them. "
SWEP.ViewModel = "models/props_lab/jar01b.mdl"
SWEP.WorldModel = "models/scp500model/scp500model.mdl"
if CLIENT then
  SWEP.BounceWeaponIcon = false
  SWEP.DrawAmmo = false
  SWEP.WepSelectIcon = surface.GetTextureID( "vgui/scp_500" )
end
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.ItemType = WEAPON_MEDICAL or 8
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
function SWEP:Deploy()
  self.Owner:DrawViewModel( false )
end
function SWEP:PrimaryAttack()
  self:SendWeaponAnim(ACT_USE)
	if SERVER then
		if self.Owner:GetNClass() == ROLE_SCP1360 then return end
		local x = math.random(1,5)
		if x == 1 then
			self.Owner:SetSCP427()
			self.Owner:SetHealth(100)
			self.Owner:SetMaxHealth(100)
		else
			self.Owner:SetHealth(25)
		end
	if self.Owner:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
    self.Owner:StripWeapon(self:GetClass())
	end
 end

function SWEP:SecondaryAttack()
end
