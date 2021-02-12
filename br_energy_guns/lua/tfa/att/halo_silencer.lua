if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Silencer"
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "This mod reduces the firing noise and muzzle",
	TFA.AttachmentColors["="], "flash of the weapon, making it ideal for taking",
	TFA.AttachmentColors["="], "your enemies by surprise.",
	TFA.AttachmentColors["+"], "Reduced sound and muzzle flash",
	TFA.AttachmentColors["-"], "5% less damage"
}

ATTACHMENT.Icon = "entities/tfa_br_supp.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SIL"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["halo_silencer"] = {
			["active"] = true
		},
		["halo_silencer+"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["halo_silencer"] = {
			["active"] = true
		},
		["halo_silencer+"] = {
			["active"] = true
		},
	},
	["Primary"] = {
		--["Sound"] = "h2an/smg/suppressed_smg3.mp3",
		["Damage"] = function(wep,stat) return stat * 0.95 end
	},
	["MuzzleAttachmentMod"] = 1,
	["MuzzleFlashEffect"] = ""
}

function ATTACHMENT:Attach(wep)
	if !wep:GetSilenced() then
		wep:SetSilenced( true )
		return
	end
	wep:ClearStatCache()
end

function ATTACHMENT:Detach(wep)
	if wep:GetSilenced() then
		wep:SetSilenced( false )
		return
	end
	wep:ClearStatCache()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end