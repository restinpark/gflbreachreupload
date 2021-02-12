AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "Game Controller"
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
SWEP.Purpose = "LMB if all enemies are dead and you wish to exit the game."
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
	if v:GetNClass() == ROLE_SCP1315A or v:GetNClass() == ROLE_SCP1315B or v:GetNClass() == ROLE_SCP1315C then return end
	end
	if self.Owner:Team() == TEAM_CLASSD then
			self.Owner:SetNClass(ROLE_CLASSD)
		elseif self.Owner:Team() == TEAM_CLASSE then
			self.Owner:SetNClass(ROLE_CLASSE)
		elseif self.Owner:Team() == TEAM_SCI then
			self.Owner:SetNClass(ROLE_RES)
		elseif self.Owner:Team() == TEAM_GUARD then
			self.Owner:SetNClass(ROLE_MTFGUARD)
		end
	self.Owner:PrintMessage(3, "You win!")
	self.Owner:PrintMessage(3, "Seems the power has been cut to SCP-1315.")
	if game.GetMap() == "br_site19" then
	self.Owner:SetPos(Vector(-2477.330078, 1674.155518, 163.027313))
	end
	if game.GetMap() == "br_area02_v3" then
	self.Owner:SetPos(Vector(9115.825195, -1888.330444, -100.553177))
	end
	if game.GetMap() == "br_site05_v2" then
	self.Owner:SetPos(Vector(-458.294525, 6290.910645, -2730.111572))
	end
	if game.GetMap() == "br_site61_v2" then
	self.Owner:SetPos(Vector(386.818512, 268.392670, -8160.496582))
	end
	if game.GetMap() == "br_site65" then
	self.Owner:SetPos(Vector(7447.786133, -1773.877075, -10860.622070))
	end
	self.Owner:Give("keycard_5")
	self.Owner:Give("weapon_scp_500")
	self.Owner:AddFrags(3)
	self.Owner:StripWeapon("weapon_game")
	end
end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()
end
