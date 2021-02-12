if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Marksman"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "This mod will increase the damage of the",
	TFA.AttachmentColors["="], "DMR, but decrease its ADS time and ROF",
	TFA.AttachmentColors["+"], "30% more bullet damage",
	TFA.AttachmentColors["-"], "10% slower ADS time",
	TFA.AttachmentColors["-"], "50% slower ROF"
}

ATTACHMENT.Icon = "entities/tfa_att_longscope.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MSK"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["RPM"] = function ( wep, val ) return val * 0.5 end,
		["Damage"] = function ( wep, val ) return val * 1.3 end,
	},
	["IronSightTime"] = function ( wep, stat ) return stat * 0.9 end
}

function ATTACHMENT:Attach(wep)
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end