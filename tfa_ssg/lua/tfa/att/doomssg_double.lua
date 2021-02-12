if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Double Trouble"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["+"], "Single-barrel attack", TFA.AttachmentColors["="], "Double occupies secondary" }
ATTACHMENT.Icon = "entities/tfa_doom_ssg.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Dt"

ATTACHMENT.WeaponTable = {
	["Double"] = true
	--[[
	["Primary"] = {
		["NumShots"] = function(wep,stat) return stat * 2 end,
		["AmmoConsumption"] = function(wep,stat) return stat * 2 end
	}
	]]--
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end