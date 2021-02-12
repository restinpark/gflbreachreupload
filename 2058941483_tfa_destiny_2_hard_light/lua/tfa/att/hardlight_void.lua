if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Void"
ATTACHMENT.ShortName = "Element" --Abbreviation, 5 chars or less please
ATTACHMENT.Description = {TFA.Attachments.Colors["+"], "Hard Light Element" }
ATTACHMENT.Icon = "entities/hardlight_void.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Skin"] = 0
} --put replacements for your SWEP talbe in here e.g. ["Primary"] = {}

function ATTACHMENT:CanAttach(wep)
	return true --can be overridden per-attachment
end

function ATTACHMENT:Attach(wep)
	wep.Weapon:SetClip1(0)
	wep:Reload( true )
	wep:ChangeElement("void")
end

function ATTACHMENT:Detach(wep)
	
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end