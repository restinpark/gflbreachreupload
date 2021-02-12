if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Full Metal Jacket"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "This mod will replace the rounds with ",
	TFA.AttachmentColors["="], "FMJ rounds to increase penetration and damage",
	TFA.AttachmentColors["+"], "25% more bullet penetration",
	TFA.AttachmentColors["+"], "10% more bullet damage because of larger rounds",
	TFA.AttachmentColors["-"], "-1 magazine capacity"
}

ATTACHMENT.Icon = "entities/tfa_att_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FMJ"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ClipSize"] = function ( wep, val ) return wep:GetStat("Primary.ClipSizeFmj") or val * 0.75 end,
		["DefaultClip"] = function ( wep, val ) return wep:GetStat("Primary.DefaultClipFmj") or wep:GetStat("Primary.ClipSize") * 6 end,
		["PenetrationMultiplier"] = 1.25,
		["Damage"] = function ( wep, val ) return val * 1.1 end,
	}
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