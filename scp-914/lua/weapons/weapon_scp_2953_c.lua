AddCSLuaFile()
SWEP.PrintName = "SCP-2953-C"
SWEP.Author = ""
SWEP.Purpose = "Rip and Tear"
SWEP.Instructions = "Primary Fire - Attack"
SWEP.droppable = false



function SWEP:Think()
end

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    local owner = self.Owner
    timer.Simple(0, function ()
        if owner and IsValid(owner) and owner:IsPlayer() then
            owner:DrawViewModel(false)
        end
    end)
end

function SWEP:DrawWorldModel() end

SWEP.NextPrimaryAttack = 0

SWEP.PrimaryCooldown = 0.5

SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

--Attack the target
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
            ent:TakeDamage(30, self.Owner, self)
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