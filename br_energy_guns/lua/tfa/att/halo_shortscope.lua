if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Shortzoom Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "Fast transition into aiming down the sights.",
	TFA.AttachmentColors["+"], "25% faster ADS times",
	TFA.AttachmentColors["-"], "25% lower zoom"
}

ATTACHMENT.Icon = "entities/tfa_att_shortscope.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SZC"

ATTACHMENT.WeaponTable = {
	["Secondary"] = {
		["IronFOV"] = function ( wep, stat ) return stat * 1.25 end
	},
	["IronSightTime"] = function ( wep, stat ) return stat * 0.75 end
}

function ATTACHMENT:Attach(wep)
	wep.SequenceRateOverride[ACT_VM_DEPLOY] = 1.25
	wep.SequenceRateOverride[ACT_VM_UNDEPLOY] = 1.25
end

function ATTACHMENT:Detach(wep)
	wep.SequenceRateOverride[ACT_VM_DEPLOY] = 1
	wep.SequenceRateOverride[ACT_VM_UNDEPLOY] = 1
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end