--Purpose: Shared content for weapon_scp1471
SWEP.PrintName = "SCP-1471"
SWEP.Author = "Aurora"
SWEP.Insturctions = "Primary fire to attack and Alternate fire to teleport to a random infected user."
SWEP.Purpose = "Stalk"
--Special SWEP key for the breach gamemode telling the gamemode that the user should not be allowed to drop this item, nor should they drop it on death
SWEP.droppable = false
SWEP.Category = "Breach"
SWEP.Spawnable = false
SWEP.AdminOnly = false
--Errors occur if you set nothing as the models, so just hide these using other functions
SWEP.WorldModel = "models/breach/keycard.mdl"
SWEP.ViewModel = "models/breach/keycard.mdl"

SWEP.DrawAmmo = false
SWEP.BounceWeaponIcon = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Damage = 45
SWEP.AttackCooldown = 0.4
SWEP.NextAttack = 0

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.m_bPlayPickupSound = false

--Surpress world model rendering
function SWEP:DrawWorldModel() end

function SWEP:PrimaryAttack()
    if self.NextAttack > CurTime() then return end
    self.NextAttack = CurTime() + self.AttackCooldown
    if SERVER then
        self:DoAttack()
    end
end

SWEP.SpecialCooldown = 60

function SWEP:SecondaryAttack()
    if self:GetNWInt("NextSpecial", 0) > CurTime() then return end
    self:SetNWInt("NextSpecial",CurTime() + self.SpecialCooldown)
    if SERVER then
        self:DoSpecial()
    end
end

function SWEP:Reload() end

function SWEP:Initialize()
    self:SetHoldType("normal")
    if SERVER then
        self:SetNWInt("NextSpecial", CurTime() + 120)
    end
end