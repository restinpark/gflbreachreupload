if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Short Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["-"], "15% more vertical recoil",
	TFA.AttachmentColors["-"], "10% aim accuracy decrease",
	TFA.AttachmentColors["+"], "25% faster holster time",
}
ATTACHMENT.Icon = "entities/tfa_l4d2_1887_short.png"
ATTACHMENT.ShortName = "SHORT"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {
		[1] = 1,
	},
	["Bodygroups_W"] = {
		[1] = 1,
	},
	["Primary"] = {
		["KickUp"] = function(wep, stat) return stat * 1.15 end,
		["KickDown"] = function(wep, stat) return stat * 1.15 end,
		["Spread"] = function(wep, stat) return stat * 1.1 end,
		["IronAccuracy"] = function(wep, stat) return stat * 1.1 end,
	},
	["ProceduralHolsterTime"] = function(wep, stat) return stat * 0.75 end,
	["Animations"] = {
		["draw"] = {
			["value"] = ACT_VM_DEPLOY,
		},
		["reload_shotgun_finish"] = {
			["value"] = ACT_VM_PULLBACK_HIGH,
		},
	},
	["MuzzleAttachmentMod"] = 2,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
