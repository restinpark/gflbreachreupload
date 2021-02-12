if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "5 Round Burst"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "This mode converts the Battle Rifle's burst fire",
	TFA.AttachmentColors["="], "rate to five rounds per shot.",
	TFA.AttachmentColors["+"], "Weapon fires five rounds per burst",
	TFA.AttachmentColors["-"], "-1 increased magazine capacity"
}

ATTACHMENT.Icon = "entities/tfa_att_5rnd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "5RB"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ClipSize"] = 35,
		["DefaultClip"] = 250,
		["SoundTest"] = "h2an/br/br_5rnd_burst.mp3",
	}
}

local firemode = "5Burst"

function ATTACHMENT:Attach(wep)
	wep:Unload()
	
	for k,v in pairs(wep:GetStat("FireModes")) do
		if v:EndsWith("Burst") then
			wep.BurstBakIndex = k
			wep.BurstBakName = v

			wep.FireModes[k] = firemode

			wep.FireModeCache = {}
			wep.BurstCountCache = {}
			wep:CreateFireModes()

			break
		end
	end
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
	
	if wep.BurstBakIndex and wep.BurstBakName then
		wep.FireModes[wep:GetStat("BurstBakIndex")] = wep:GetStat("BurstBakName")

		wep.FireModeCache = {}
		wep.BurstCountCache = {}
		wep:CreateFireModes()

		wep.BurstBakIndex = nil
		wep.BurstBakName = nil
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end