if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Run & Gun"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Allows to fire small arms while sprinting.",
	TFA.AttachmentColors["-"], "Can't aim down sights.",
}

ATTACHMENT.Icon = "entities/tfa_running_icon.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RnG"

ATTACHMENT.WeaponTable = {
	["AllowSprintAttack"] = true, -- tfa base doesnt read this variable from cached stats
}

local disable_is = function(self, ...) end

function ATTACHMENT:Attach(wep)
	wep.IronSightsBak = wep.IronSights
	wep.IronSights = disable_is
	if wep:GetStat("AllowSprintAttack") then
		wep.AllowSprintAttackBak = true
		return
	end
	wep.AllowSprintAttack = true
	wep:ClearStatCache()
end

function ATTACHMENT:Detach(wep)
	wep.IronSights = wep.IronSightsBak
	if wep:GetStat("AllowSprintAttackBak") then
		wep.AllowSprintAttackBak = nil
		return
	end
	wep.AllowSprintAttack = false
	wep:ClearStatCache()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end