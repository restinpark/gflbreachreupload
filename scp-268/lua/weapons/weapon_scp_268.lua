AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-268"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = ""
SWEP.WorldModel = "models/thenextscp/scp268/berret.mdl"
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
SWEP.Purpose = "LMB to become invisible."
SWEP.IsIn = false

function SWEP:Deploy()
  	self.Owner:DrawViewModel( false )
  	if SERVER then self.Owner:DrawWorldModel( false ) end
end

function SWEP:Holster()
timer.Stop("268")
	return true
end

function SWEP:Initialize()
	self:SetHoldType("normal")
	if SERVER then
		self:SetNWBool("invis", false)
	end
end
 
function SWEP:Think()
if SERVER then
if self.Owner:Health() == 0 or self.Owner:Health() < 0 then 
	self.Owner:Kill() 
end
	local wep = self.Owner:GetWeapon("weapon_scp_268")
	if wep:GetNWBool("invis", false) then return end
		timer.Create("268", 1, 0, function()
			self.Owner:SetHealth(self.Owner:Health() - 3)
		end)
	end
end
function SWEP:Reload()
end

function SWEP:invis(on)
	self:SetNWBool("invis", on)
end

hook.Add("PrePlayerDraw", "PrePlayerDraw_Ply", function (ply)
   if IsValid(ply) and ply:HasWeapon("weapon_scp_268") then
		local wep = ply:GetWeapon("weapon_scp_268")
		if wep:GetNWBool("invis", false) then
			return true
		end
    end
end)

function SWEP:PrimaryAttack()
if SERVER then
	self:SetNWBool("invis", !self:GetNWBool("invis", false))
	if IsValid(self.Owner) and wep:GetNWBool("invis", false) then
	self.Owner:PrintMessage(3, "You put the hat on.")
	else
	self.Owner:PrintMessage(3, "You take off the hat.")
		end
	end
end

function SWEP:SecondaryAttack()

end



function SWEP:DrawHUD()
end
