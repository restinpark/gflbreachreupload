AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "Pound of Flesh"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/weapons/w_bugbait.mdl"
SWEP.droppable = true
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
SWEP.Purpose = "Press LMB on SCP-038 to copy yourself."
SWEP.ItemType = WEAPON_OTHER or 11

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
				if ent:GetClass() == "ent_scp038" then
					local flesh = table.Random(GetNotAFKSpecs())
						flesh:SetSCP038A()
						flesh:SetTeam(self.Owner:Team())
						flesh:SetModel(self.Owner:GetModel())
						flesh:SetPos(self.Owner:GetPos())
						flesh:Give("weapon_scp_038")
					end
					end
						self.Owner:StripWeapon("weapon_flesh")
	end
end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()
end
