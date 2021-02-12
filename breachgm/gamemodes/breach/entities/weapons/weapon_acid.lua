AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "chan_man1"
SWEP.Contact		= ""
SWEP.Purpose		= "Stop SCP-096"
SWEP.Instructions	= "LMB to inject acid into SCP-096."

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/props_lab/jar01b.mdl"
SWEP.WorldModel		= "models/Items/CrossbowRounds.mdl"
SWEP.PrintName		= "Acid Needle"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.AttackDelay			= 10
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Automatic	= false
SWEP.NextAttackW			= 0
SWEP.SFXCooldown = 0
function SWEP:Deploy()
end
function SWEP:Initialize()
	self:SetHoldType("Pistol")
end

function SWEP:Think()
end

function SWEP:Reload()

end
function SWEP:PrimaryAttack()
	//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
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
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP and ent:GetNClass() == ROLE_SCP096 then
					if ent:GetAmmoCount(20) > 0 then
						ent:GiveAmmo(1, "HelicopterGun", true)
						ent:TakeDamage(300)
						ent:PrintMessage(3, "You have been injected with acid!")
					else
						ent:TakeDamage(50)
					end
				end
			end
		end
		self.Owner:StripWeapon(self:GetClass())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
end
