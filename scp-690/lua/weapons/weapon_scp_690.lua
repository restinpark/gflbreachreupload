AddCSLuaFile()
--Requires SCP-607 (or at the very least the extensions that come with it)
if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade/chan_man1"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Bandage yourself or other people"
SWEP.Instructions	= [[Primary - bandage yourself
Secondary - bandage others]]

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/firstaidkit.mdl"
SWEP.WorldModel		= "models/props_interiors/toiletpaperroll.mdl"
SWEP.PrintName		= "SCP-690"
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
			BREACH_SetupEventTimer(self.Owner, CurTime() + 3, function ()
				if not self then
				    return true
				end
				if not IsValid(self) then
				    return true
				end
				if not self.Owner then
				    return true
				end
				if not IsValid(self.Owner) then
				    return true
				end
				if not self.Owner:HasWeapon("weapon_scp_690") then
				    return true  
				end
				return false
			end, function (ply)
				if ply and IsValid(ply) and ply:Team() ~= TEAM_SCP and ply:Team() ~= TEAM_SPEC then
					if ply:GetNClass() == ROLE_SCP378 then
						ply:SetDecomposing(true)
					end
					hook.Run("BreachPlayerHealed", ply, ply)
					ply:SetDecomposing(true)
					if self.Owner.GiveAchievement then
					self.Owner:GiveAchievement("Genius")
				end
					if ply:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					ply:StripWeapon("weapon_scp_690")
				end
			end, "Using Bandage")
		end
	else
		if SERVER then
			self.Owner:PrintMessage(HUD_PRINTTALK, "You don't need healing yet")
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
					ent:SetDecomposing(true)
					if self.Owner.GiveAchievement then
					self.Owner:GiveAchievement("Miss")
				end
					hook.Run("BreachPlayerHealed", self.Owner, ent)
					if self.Owner:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					self.Owner:StripWeapon("weapon_scp_690")
				else
					self.Owner:PrintMessage(HUD_PRINTTALK, ent:Nick() .. " doesn't need healing yet")
				end
			end
		end
	end
end
function SWEP:CanPrimaryAttack() end