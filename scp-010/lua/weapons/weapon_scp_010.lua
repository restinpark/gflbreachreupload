AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-010"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/props_phx/wheels/magnetic_small.mdl"
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
SWEP.Purpose = "LMB to put onto a person."
SWEP.IsOn = false

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
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if ent:GetNClass() == ROLE_SCP990 then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				if ent:Team() == TEAM_CLASSD then
					ent:SetNWString("010", "D")
					ent:SetSCP010()
					ent:SetTeam(self.Owner:Team())
					ent:PrintMessage(3, "A collar has been fastened to your neck!")
					self.Owner:Give("weapon_scp_010_rmte")
					self.Owner:StripWeapon(self:GetClass())
				elseif ent:Team() == TEAM_SCI then
					ent:SetNWString("010", "S")
					ent:SetSCP010()
					ent:SetTeam(self.Owner:Team())
					ent:PrintMessage(3, "A collar has been fastened to your neck!")
					self.Owner:Give("weapon_scp_010_rmte")
					self.Owner:StripWeapon(self:GetClass())
				elseif ent:Team() == TEAM_GUARD then
					ent:SetNWString("010", "G")
					ent:SetSCP010()
					ent:SetTeam(self.Owner:Team())
					ent:PrintMessage(3, "A collar has been fastened to your neck!")
					self.Owner:Give("weapon_scp_010_rmte")
					self.Owner:StripWeapon(self:GetClass())
				elseif ent:Team() == TEAM_CHAOS then
					ent:SetNWString("010", "C")
					ent:SetSCP010()
					ent:SetTeam(self.Owner:Team())
					ent:PrintMessage(3, "A collar has been fastened to your neck!")
					self.Owner:Give("weapon_scp_010_rmte")
					self.Owner:StripWeapon(self:GetClass())
				elseif ent:Team() == TEAM_CLASSE then
					ent:SetNWString("010", "E")
					ent:SetSCP010()
					ent:SetTeam(self.Owner:Team())
					ent:PrintMessage(3, "A collar has been fastened to your neck!")
					self.Owner:Give("weapon_scp_010_rmte")
					self.Owner:StripWeapon(self:GetClass())
				end
			end
		end
		--self.Owner:SetSCP010()
		--self.Owner:SetNWString("010", "E")
	end
end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()
end
