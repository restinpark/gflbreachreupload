AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-076-2"
SWEP.Author = "chan_man1"
SWEP.Category = ""
SWEP.Instructions = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/vinrax/props/keycard.mdl"
SWEP.WorldModel = "models/vinrax/props/keycard.mdl"
SWEP.droppable = false
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
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.UseHands = false
SWEP.Contact = "GFL Forums"
SWEP.Purpose = "LMB to take a random blade out of your personal dimension."
SWEP.NextAttackH = 0
SWEP.AttackDelay1 = 5


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
 
function SWEP:Think()
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
if self.NextAttackH > CurTime() then return end
	self.NextAttackH = CurTime() + self.AttackDelay1
if SERVER then
	self.Owner:StripWeapon("weapon_goodsword")
	self.Owner:StripWeapon("weapon_shuriken")
	self.Owner:StripWeapon("weapon_mor_silver_shortsword")
	self.Owner:StripWeapon("weapon_thehiddenblade")
	self.Owner:Give(table.Random({"weapon_goodsword", "weapon_shuriken", "weapon_mor_silver_shortsword", "weapon_thehiddenblade"}))
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to use subspace"
	local showcolor = Color(0,255,0)

	if self.NextAttackH > CurTime() then
		showtext = "Next use in " .. math.Round(self.NextAttackH - CurTime())
		showcolor = Color(255,0,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 30 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( 0, 255, 0, 255 )

	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
end


