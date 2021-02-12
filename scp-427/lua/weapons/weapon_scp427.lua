AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "Flesh Beast"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/scp_427_model/scp_427.mdl"
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
SWEP.Purpose = "LMB to attack people."
SWEP.IsOn = false
SWEP.NextPrimaryAttack = 0
SWEP.PrimaryCooldown = 0.5

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
 if not IsFirstTimePredicted() then return end
    if self.NextPrimaryAttack > CurTime() then return end
    self.NextPrimaryAttack = CurTime() + self.PrimaryCooldown
    if SERVER then
        local ent = nil
        local tr = util.TraceHull( {
            start = self.Owner:GetShootPos(),
            endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 ),
            filter = self.Owner,
            mins = Vector( -10, -10, -10 ),
            maxs = Vector( 10, 10, 10 ),
            mask = MASK_SHOT_HULL
        } )
        ent = tr.Entity
        if ent and IsValid(ent) and ent:IsPlayer() and ent:Team() != TEAM_SPEC then
            ent:TakeDamage(60, self.Owner, self)
        elseif ent and IsValid(ent) and ent:GetClass() == "func_breakable" then
            ent:TakeDamage(125, self.Owner, self)
        elseif ent and IsValid(ent) and BREACH_IsGateDoor(ent) then
            ent:TakeDamage(math.random(20, 100), self.Owner, self)
        end
    end
end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()
end
