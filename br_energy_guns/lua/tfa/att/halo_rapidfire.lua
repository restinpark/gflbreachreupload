if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Rapid Fire"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "Allows weapon to fire faster",
	TFA.AttachmentColors["+"], "+15% increased RPM",
	TFA.AttachmentColors["-"], "+25% max bullet spread",
	TFA.AttachmentColors["-"], "+15% vertical recoil",
	TFA.AttachmentColors["-"], "+10% bullet spread per shot increase",
}

ATTACHMENT.Icon = "entities/tfa_att_5rnd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RPD"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["SpreadMultiplierMax"] = function ( wep, val ) return val * 1.25 end,
		["KickUp"] = function ( wep, val ) return val * 1.15 end,
		["SpreadIncrement"] = function ( wep, val ) return val * 1.1 end,
		["RPM"] = function ( wep, val ) return val * 1.15 end,
	}
}

function ATTACHMENT:Attach(wep)
	
end

function ATTACHMENT:Detach(wep)
	
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end