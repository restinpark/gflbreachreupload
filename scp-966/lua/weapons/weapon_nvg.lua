AddCSLuaFile()
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/nvg_wep")
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "Night Vision Goggles"
SWEP.Author = "Aurora"
SWEP.Category = "Aurora's SWEPs"
SWEP.Instructions = "Primary fire to turn NVG ON, Secondary to turn NVG OFF."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/mishka/models/nvg.mdl"
SWEP.droppable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Damage = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.ItemType = WEAPON_NVG or 9
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.UseHands = false
SWEP.Contact = "https://goo.gl/mHAu1j"
SWEP.Purpose = "See in the dark"
SWEP.NextAttackH = 0
SWEP.NextAttackW = 0
SWEP.NextAttackR = 0
SWEP.AttackDelay1 = 3
SWEP.AttackDelay2 = 3
SWEP.AttackDelay3 = 3
SWEP.IsOn = false
function SWEP:Initialize()

end
function SWEP:OwnerChanged()
	if BATTERY_ENABLE then
		self.NextDrain = CurTime() + self.DrainCooldown
	end
end
function SWEP:Deploy()
  	self.Owner:DrawViewModel( false )
  	if SERVER then self.Owner:DrawWorldModel( false ) end
end
function SWEP:Holster()
	return true
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end

SWEP.DrainCooldown = 15
SWEP.NextDrain = 0
 
function SWEP:Think()
	if BATTERY_ENABLE and  self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() and self.Owner:GetNetworkedInt("scp_battery_power", 0) <= 0 then
		self.IsOn = false
	end
	if BATTERY_ENABLE and SERVER and self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() and self.Owner.DrainBattery then
		if self.NextDrain < CurTime() then
			self.NextDrain = CurTime() + self.DrainCooldown
			--Drain once every 15 seconds, meaning NVG can be used for 6 minutes
			self.Owner:DrainBattery(1)
		end
	end
end

function SWEP:Reload()
end
function SWEP:PrimaryAttack()
	self.IsOn = true
end

function SWEP:SecondaryAttack()
	self.IsOn = false
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local msgtext = ""
	local showcolor = Color(255,0,0)
	if self.IsOn then
		msgtext = "Night vision enabled"
		showcolor = Color(0,255,0)
	else
		msgtext = "Night vision disabled"
		showcolor = Color(255,0,0)
	end
	if BATTERY_ENABLE then
		if LocalPlayer():GetNetworkedInt("scp_battery_power", 0) <= 0 then
			msgtext = "Battery needed!"
			showcolor = Color(255,0,0)
		end
	end
	draw.Text( {
		text = msgtext,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
end
