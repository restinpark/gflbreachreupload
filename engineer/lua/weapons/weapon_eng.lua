AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "chan_man1"
SWEP.Contact		= ""
SWEP.Purpose		= "Deploy Shield"
SWEP.Instructions	= "LMB to deploy your tactical shield. RMB to change the angle of the shield"
SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "TRO Engineering Shield"
SWEP.Category 		= "SCP"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false


function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end
function SWEP:DrawWorldModel()
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
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "force_shield" then
		self.Owner:PrintMessage(3, "Shield Generator Recharging!") return end
		end
			local ent = ents.Create("force_shield")
			ent:SetPos(self.Owner:GetPos())
			ent:Spawn()
			if self.Owner:GetNWString("shld", "unset") == "0" then
			ent:SetAngles(Angle(0,0,0))
			elseif self.Owner:GetNWString("shld", "unset") == "45" then
			ent:SetAngles(Angle(0,45,0))
			elseif self.Owner:GetNWString("shld", "unset") == "90" then
			ent:SetAngles(Angle(0,90,0))
			elseif self.Owner:GetNWString("shld", "unset") == "135" then
			ent:SetAngles(Angle(0,135,0))
		end
			ent.Owner = self.Owner
		else
			self.CognitoPlace = 0
			return
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:GetNWString("shld", "unset") == "0" then
		self.Owner:SetNWString("shld", "45")
	elseif self.Owner:GetNWString("shld", "unset") == "45" then
		self.Owner:SetNWString("shld", "90")
	elseif self.Owner:GetNWString("shld", "unset") == "90" then
		self.Owner:SetNWString("shld", "135")
	elseif self.Owner:GetNWString("shld", "unset") == "135" then
		self.Owner:SetNWString("shld", "0")
	else
		self.Owner:SetNWString("shld", "0")
	end
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
end