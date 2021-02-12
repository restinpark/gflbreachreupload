if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Capacity Increase"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Increases the ammo capacity of the weapon.",
	TFA.AttachmentColors["-"], "25% less bullet damage due to smaller rounds",
}

ATTACHMENT.Icon = "entities/ins2_att_mag_ext_rifle_30rd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "EXT"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ClipSize"] = function ( wep, val ) return wep:GetStat("Primary.ClipSizeExt") or val * 1.25 end,
		["DefaultClip"] = function ( wep, val ) return wep:GetStat("Primary.DefaultClipExt") or wep:GetStat("Primary.ClipSize") * 6 end,
		["Damage"] = function ( wep, val ) return val * 0.75 end,
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