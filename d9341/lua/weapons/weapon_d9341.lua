AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "D-9341"
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
SWEP.Purpose = "LMB to save your position in the game. RMB to delete your save file in the game. If no save file is set the game will be reset."


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
	for k,v in pairs(ents.GetAll()) do
	if v:GetClass() == "ent_sp" then return end
	end
	local create = ents.Create("ent_sp")
	create:SetPos(self.Owner:GetPos())
    create:Spawn()
	timer.Create("Save", 1, 1, function()
	self.Owner:PrintMessage(3, "Game Saved!")
	end)
	end
end

function SWEP:SecondaryAttack()
if SERVER then
	for k,v in pairs(ents.GetAll()) do
	if v:GetClass() == "ent_sp" then
	v:Remove()
	timer.Create("Delete", 1, 1, function()
	self.Owner:PrintMessage(3, "Save File Deleted!")
	end)
	end
	end
	end
end

function SWEP:DrawHUD()
end
