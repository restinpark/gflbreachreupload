if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Variable Choke"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["+"], "Choke your gun for improved accuracy", TFA.AttachmentColors["="], "Occupies secondary attack" }
ATTACHMENT.Icon = "entities/tfa_doom_ssg.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Vc"

ATTACHMENT.WeaponTable = {
	["data"] = { ["ironsights"] = 1 }
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