AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-1861-B"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = "Use LMB when near a person to begin converting them. After 10 seconds they will be free from the rain."
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
SWEP.Purpose = "Save people from the rain."

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
timer.Create("Kidnap", 10, 0, function()
for k,v in pairs(ents.FindInSphere(self:GetPos(),100)) do
	if v:IsPlayer() then
		if v:Team() != TEAM_SCP and v:Team() != TEAM_SPEC then
		if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
			v:SetSCP1861B()
			v:SetPos(self.Owner:GetPos())
end
end
end
end)
end
end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()
end
