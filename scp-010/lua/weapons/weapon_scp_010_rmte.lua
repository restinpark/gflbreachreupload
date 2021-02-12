AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-010-1"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
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
SWEP.Purpose = "LMB to make a person wearing SCP-010 do an action or change their shape. RMB to change the input."
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
		for k,v in pairs(player.GetAll()) do
			if v:GetNWString("010", "unset") == "D" or v:GetNWString("010", "unset") == "S" or v:GetNWString("010", "unset") == "G" or v:GetNWString("010", "unset") == "C" or v:GetNWString("010", "unset") == "E" then
			if self.Owner:GetNWString("R", "unset") == "1" then
			v:SetJumpPower(1000)
				end
			if self.Owner:GetNWString("R", "unset") == "2" then
			for _, wep in ipairs( v:GetWeapons() ) do
			v:DropWeapon( wep )
					end
				end
			if self.Owner:GetNWString("R", "unset") == "3" then
			v:SetPos(v:GetPos() + Vector(0,0,10))
			v:SetVelocity(v:GetAimVector() * 750 )
				end
			if self.Owner:GetNWString("R", "unset") == "4" then
			v:Freeze(true)
				end
			if self.Owner:GetNWString("R", "unset") == "5" then
			v:Freeze(false)
				end
			if self.Owner:GetNWString("R", "unset") == "6" then
			local ent = ents.Create( "env_explosion" )
			ent:SetPos( v:GetPos() )
			ent:SetOwner( v )
			ent:Spawn()
			ent:SetKeyValue( "iMagnitude", "80" )
			ent:Fire( "Explode", 0, 0 )
			ent:EmitSound( "BaseExplosionEffect.Sound", 100, 100 )
			v:SetDecomposing(true)
				end
			if self.Owner:GetNWString("R", "unset") == "7" then
			v:SetBleeding(true)
			v:SetWalkSpeed(350)
				end
			if self.Owner:GetNWString("R", "unset") == "8" then
			local ent = ents.Create( "weapon_scp_500" )
			ent:SetPos( v:GetPos() + Vector(0, 0, 10))
			ent:SetOwner( v )
			ent:Spawn()
			v:Kill()
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
		if self.Owner:GetNWString("R", "unset") == "1" then
			self.Owner:SetNWString("R", "2")
			self.Owner:PrintMessage(3, "Drop Inventory")
		elseif self.Owner:GetNWString("R", "unset") == "2" then
			self.Owner:SetNWString("R", "3")
			self.Owner:PrintMessage(3, "Jump")
		elseif self.Owner:GetNWString("R", "unset") == "3" then
			self.Owner:SetNWString("R", "4")
			self.Owner:PrintMessage(3, "Stop")
		elseif self.Owner:GetNWString("R", "unset") == "4" then
			self.Owner:SetNWString("R", "5")
			self.Owner:PrintMessage(3, "Move")
		elseif self.Owner:GetNWString("R", "unset") == "5" then
			self.Owner:SetNWString("R", "6")
			self.Owner:PrintMessage(3, "Explode")
		elseif self.Owner:GetNWString("R", "unset") == "6" then
			self.Owner:SetNWString("R", "7")
			self.Owner:PrintMessage(3, "Bleed")
		elseif self.Owner:GetNWString("R", "unset") == "7" then
			self.Owner:SetNWString("R", "8")
			self.Owner:PrintMessage(3, "Take Life")
		else
			self.Owner:SetNWString("R", "1")
			self.Owner:PrintMessage(3, "Extend Legs")
		end
	end
end

function SWEP:DrawHUD()
end
