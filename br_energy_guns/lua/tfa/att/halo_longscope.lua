if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Longzoom Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "Larger zoom multiplier to shoot targets at longer distance",
	TFA.AttachmentColors["+"], "25% longer zoom",
	TFA.AttachmentColors["-"], "25% longer ADS time"
}

ATTACHMENT.Icon = "entities/tfa_att_longscope.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "LZC"

ATTACHMENT.WeaponTable = {
	["Secondary"] = {
		["IronFOV"] = function ( wep, stat ) return stat * 0.75 end
	},
	["IronSightTime"] = function ( wep, stat ) return stat * 1.25 end
}

function ATTACHMENT:Attach(wep)
	wep.SequenceRateOverride[ACT_VM_DEPLOY] = 0.75
	wep.SequenceRateOverride[ACT_VM_UNDEPLOY] = 0.75
end

function ATTACHMENT:Detach(wep)
	wep.SequenceRateOverride[ACT_VM_DEPLOY] = 1
	wep.SequenceRateOverride[ACT_VM_UNDEPLOY] = 1
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end