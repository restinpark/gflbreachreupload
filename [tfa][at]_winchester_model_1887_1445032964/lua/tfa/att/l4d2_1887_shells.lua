if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Shell Holder"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "25% faster reload",
	TFA.AttachmentColors["-"], "Blocks ironsights",
}
ATTACHMENT.Icon = "entities/tfa_l4d2_1887_shells.png"
ATTACHMENT.ShortName = "SHELLS"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {
		[2] = 1,
	},
	["Bodygroups_W"] = {
		[2] = 1,
	},
	["SequenceRateOverride"] = {
		-- no modifier for reload start anim because its scuffed af
		[ACT_VM_RELOAD] = 1.25,
		[ACT_SHOTGUN_RELOAD_FINISH] = 1.25,
		[ACT_VM_PULLBACK_HIGH] = 1.25,
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
