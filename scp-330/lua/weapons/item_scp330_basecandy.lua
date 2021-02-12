AddCSLuaFile()

SWEP.PrintName = "ERROR"
SWEP.Author = "Aurora / Ralsei"
SWEP.Instructions = "Report this to Aurora, you're not supposed to have this."
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Secondary = SWEP.Primary

SWEP.Spawnable = false

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    local o = self.Owner
    timer.Simple(0, function ()
        if o and IsValid(o) then
            o:DrawViewModel(false, 0)
        end
    end)
end

function SWEP:Reload()

end

function SWEP:PrimaryAttack()
    if IsValid(self.Owner) then
	if self.Owner:GetNClass() == ROLE_SCP1360 then return end
        self.Owner:SetHealth(math.Clamp(self.Owner:Health() + 45, 0, self.Owner:GetMaxHealth()))
        self.Owner:ConCommand("lastinv")
        self:Remove()
    end
end

function SWEP:SecondaryAttack() end