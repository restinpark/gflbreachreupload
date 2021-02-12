AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-350"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/props_c17/paper01.mdl"
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
SWEP.Purpose = "LMB to sign the contract. RMB to change the terms. Sever the contract at a price with RELOAD."
SWEP.droppable = false

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
	if SERVER then
		local ply = self.Owner
		if ply:Team() == TEAM_SCP then return end
			if ply:GetNWString("Sign", "unset") == "1" or ply:GetNWString("Sign", "unset") == "2" or ply:GetNWString("Sign", "unset") == "3" or ply:GetNWString("Sign", "unset") == "4" or ply:GetNWString("Sign", "unset") == "5" or ply:GetNWString("Sign", "unset") == "6" or ply:GetNWString("Sign", "unset") == "7" or ply:GetNWString("Sign", "unset") == "8" or ply:GetNWString("Sign", "unset") == "9" or ply:GetNWString("Sign", "unset") == "10" then
				ply:StripWeapon("weapon_scp_350")
				ply:SetNWString("350", "clear")
				ply:SetNWString("Sign", "clear")
				ply:SetHealth(1)
		end
	end
end

function SWEP:PrimaryAttack()
	if SERVER then
		local ply = self.Owner
		if ply:Team() == TEAM_SCP then return end
		if ply:GetNWString("Sign", "unset") == "1" or ply:GetNWString("Sign", "unset") == "2" or ply:GetNWString("Sign", "unset") == "3" or ply:GetNWString("Sign", "unset") == "4" or ply:GetNWString("Sign", "unset") == "5" or ply:GetNWString("Sign", "unset") == "6" or ply:GetNWString("Sign", "unset") == "7" or ply:GetNWString("Sign", "unset") == "8" or ply:GetNWString("Sign", "unset") == "9" or ply:GetNWString("Sign", "unset") == "10" then ply:PrintMessage(3, "Contract Sealed.") return end
			if ply:GetNWString("350", "unset") == "1" then
				ply:SetNWString("Sign", "1")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "2" then
				ply:SetNWString("Sign", "2")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "3" then
				ply:SetNWString("Sign", "3")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "4" then
				ply:SetNWString("Sign", "4")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "5" then
				ply:SetNWString("Sign", "5")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "6" then
				ply:SetNWString("Sign", "6")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "7" then
				ply:SetNWString("Sign", "7")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "8" then
				ply:SetNWString("Sign", "8")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "9" then
				ply:SetNWString("Sign", "9")
				ply:PrintMessage(3, "Contract Signed.")
			elseif ply:GetNWString("350", "unset") == "10" then
				ply:SetNWString("Sign", "10")
				ply:PrintMessage(3, "Contract Signed.")
			else
				ply:PrintMessage(3, "You must choose new terms for the contract.")
		end
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
		local ply = self.Owner
		if ply:Team() == TEAM_SCP then return end
		if ply:GetNWString("Sign", "unset") == "1" or ply:GetNWString("Sign", "unset") == "2" or ply:GetNWString("Sign", "unset") == "3" or ply:GetNWString("Sign", "unset") == "4" or ply:GetNWString("Sign", "unset") == "5" or ply:GetNWString("Sign", "unset") == "6" or ply:GetNWString("Sign", "unset") == "7" or ply:GetNWString("Sign", "unset") == "8" or ply:GetNWString("Sign", "unset") == "9" or ply:GetNWString("Sign", "unset") == "10" then ply:PrintMessage(3, "Contract Sealed.") return end
			if ply:GetNWString("350", "unset") == "1" then
				ply:SetNWString("350", "2")
				ply:PrintMessage(3, "Kill an SCP.")
			elseif ply:GetNWString("350", "unset") == "2" then
				ply:SetNWString("350", "3")
				ply:PrintMessage(3, "Cure 5 people of ailments.")
			elseif ply:GetNWString("350", "unset") == "3" then
				ply:SetNWString("350", "4")
				ply:PrintMessage(3, "Obtain SCP-005.")
			elseif ply:GetNWString("350", "unset") == "4" then
				ply:SetNWString("350", "5")
				ply:PrintMessage(3, "Use SCP-294 10 times.")
			elseif ply:GetNWString("350", "unset") == "5" then
				ply:SetNWString("350", "6")
				ply:PrintMessage(3, "Kill the TRO Commander.")
			elseif ply:GetNWString("350", "unset") == "6" then
				ply:SetNWString("350", "7")
				ply:PrintMessage(3, "Eat SCP-458 3 times.")
			elseif ply:GetNWString("350", "unset") == "7" then
				ply:SetNWString("350", "8")
				ply:PrintMessage(3, "Open or Close 15 keycard doors.")
			elseif ply:GetNWString("350", "unset") == "8" then
				ply:SetNWString("350", "9")
				ply:PrintMessage(3, "Drop your health below 10HP.")
			elseif ply:GetNWString("350", "unset") == "9" then
				ply:SetNWString("350", "10")
				ply:PrintMessage(3, "Use SCP-1425, 1025, and 216 in a single round.")
			else
				ply:SetNWString("350", "1")
				ply:PrintMessage(3, "Heal 5 people with Medkits.")
		end
	end
end

function SWEP:DrawHUD()
end

if SERVER then
hook.Add("DoPlayerDeath", "DoPlayerDeath_350-2", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCP and att:GetNWString("Sign", "unset") == "2" and ply and IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_SCP then
        att:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
		att:PrintMessage(3, "Contract Complete!")
		att:StripWeapon("weapon_scp_350")
		att:SetNWString("350", "clear")
		att:SetNWString("Sign", "clear")
		end
    end)
end

if SERVER then
timer.Create("350-4", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:HasWeapon("weapon_scp_350") and v:HasWeapon("weapon_scp_005") and v:GetNWString("Sign", "unset") == "4" then
		v:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
		v:PrintMessage(3, "Contract Complete!")
		v:StripWeapon("weapon_scp_350")
		v:SetNWString("350", "clear")
		v:SetNWString("Sign", "clear")
			end
		end
	end)
end

if SERVER then
hook.Add("DoPlayerDeath", "DoPlayerDeath_350-6", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCP and att:GetNWString("Sign", "unset") == "6" and ply and IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_GUARD and ply:GetNClass() == ROLE_MTFCOM then
        att:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
		att:PrintMessage(3, "Contract Complete!")
		att:StripWeapon("weapon_scp_350")
		att:SetNWString("350", "clear")
		att:SetNWString("Sign", "clear")
		end
    end)
end

if SERVER then
timer.Create("350-9", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:HasWeapon("weapon_scp_350") and v:GetNWString("Sign", "unset") == "9" and v:Health() < 10 then
		v:SetNWString("350", "clear")
		v:SetNWString("Sign", "clear")
		v:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
		v:PrintMessage(3, "Contract Complete!")
		v:StripWeapon("weapon_scp_350")
			end
		end
	end)
end

if SERVER then
timer.Create("350-10", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:GetNWString("Sign", "unset") == "10" and v:GetAmmoCount(12) > 2 then
		v:SetNWString("350", "clear")
		v:SetNWString("Sign", "clear")
		v:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
		v:PrintMessage(3, "Contract Complete!")
		v:StripWeapon("weapon_scp_350")
			end
		end
	end)
end
