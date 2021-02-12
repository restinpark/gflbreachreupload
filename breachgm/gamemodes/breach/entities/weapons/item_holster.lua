AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_keycard1")
	SWEP.BounceWeaponIcon = false
  surface.CreateFont("HolsterWeaponFont", { font="Roboto", weight="500", size=ScreenScale(25),antialiasing=true,additive=true })

end

SWEP.Author			= "Kanade"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Holster"
SWEP.Instructions	= "Use to hold nothing."

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/breach/keycard.md"
SWEP.WorldModel		= "models/breach/keycard.mdl"
SWEP.PrintName		= "Holster"
SWEP.Slot			= 0
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= false
SWEP.ItemType = WEAPON_HOLSTER or 1
SWEP.UseHands = false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.droppable				= false
SWEP.teams					= {2,3,5,6}

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end


function SWEP:DrawWorldModel()

end
function SWEP:Initialize()
	self:SetHoldType("normal")
end
function SWEP:Think()
end
function SWEP:Reload()
end
function SWEP:PrimaryAttack()
end
function SWEP:SecondaryAttack()
end
function SWEP:CanPrimaryAttack()
end


function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	draw.SimpleText( "Holster", "HolsterWeaponFont", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )

	draw.SimpleText( "Holster", "HolsterWeaponFont", x + wide/2 + math.Rand(-4, 4), y + tall*0.2+ math.Rand(-14, 14), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )
	draw.SimpleText( "Holster", "HolsterWeaponFont", x + wide/2 + math.Rand(-4, 4), y + tall*0.2+ math.Rand(-9, 9), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )

end
