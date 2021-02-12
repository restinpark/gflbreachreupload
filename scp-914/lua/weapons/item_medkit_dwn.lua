AddCSLuaFile()
--Requires SCP-607 (or at the very least the extensions that come with it)
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_medkit")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade/chan_man1"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Heal yourself or other people"
SWEP.Instructions	= [[Primary - heal yourself
Secondary - heal others]]

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/firstaidkit.mdl"
SWEP.WorldModel		= "models/vinrax/props/firstaidkit.mdl"
SWEP.PrintName		= "Old Medkit"
SWEP.Slot			= 1
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false
SWEP.ItemType = WEAPON_MEDICAL or 8
SWEP.droppable				= true
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
	self.Owner:DrawViewModel( false )
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
    if not IsFirstTimePredicted() then return end
	if self.Owner:Health() / self.Owner:GetMaxHealth() <= 0.8 then
		if SERVER then
		if self.Owner:GetNClass() == ROLE_SCP1360 then return end
			local ply = self.Owner
				if ply and IsValid(ply) and ply:Team() ~= TEAM_SCP and ply:Team() ~= TEAM_SPEC then
					ply:SetHealth(ply:Health() + 50)
					end
					if ply:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					ply:StripWeapon("item_medkit_dwn")
		end
	end			
end

function SWEP:SecondaryAttack()
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if ent:IsPlayer() then
			if ent:Team() == TEAM_SCP then return end
			if ent:Team() == TEAM_SPEC then return end
			if (ent:GetPos():Distance(self.Owner:GetPos()) < 95) then
				if ent:Health() / ent:GetMaxHealth() <= 0.8 then
					ent:SetHealth(ent:Health() + 50)
					if SERVER and self.Owner:GetNWString("Sign", "unset") == "1" then
					if self.Owner:GetAmmoCount(12) > 4 then
					self.Owner:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
					self.Owner:PrintMessage(3, "Contract Complete!")
					self.Owner:StripWeapon("weapon_scp_350")
					self.Owner:SetNWString("350", "clear")
					self.Owner:SetNWString("Sign", "clear")
					else
					self.Owner:GiveAmmo(1, "AlyxGun", true)
				end
			end
					hook.Run("BreachPlayerHealed", self.Owner, ent)
					if self.Owner:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					self.Owner:StripWeapon("item_medkit_dwn")
				else
					self.Owner:PrintMessage(HUD_PRINTTALK, ent:Nick() .. " doesn't need healing yet")
				end
			end
		end
	end
end
function SWEP:CanPrimaryAttack() end
