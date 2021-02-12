if SERVER then
    AddCSLuaFile()
end

local ST = Material("hx/hx")

SWEP.PrintName = "Super Hexagun"
SWEP.Author = "SCP-914"
SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.Contact = ""
SWEP.Purpose = "Pain."
SWEP.Instructions = "Click left Mouse Button and watch."

SWEP.Base = "weapon_base"
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Category = "DOOM"

SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"
SWEP.UseHands = false
SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 75
SWEP.BobScale = 3
--SWEP.WepSelectIcon = ""

SWEP.Primary.Recoil = -1
SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic  = false
SWEP.Primary.Delay = 75/65
SWEP.Primary.sound = "weapons/doom/boom.wav"
SWEP.Primary.Ammo = "Buckshot"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:PrimaryAttack()

	if(self.Owner:GetAmmoCount( self.Primary.Ammo ) < 2)then
	return
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

				bullet = {}
				bullet.Num    = 150
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0.25, 0.25, 0)
				bullet.Tracer = 0
				bullet.AmmoType = self.Primary.Ammo
				bullet.Force  = 4
				bullet.Damage = 30
				bullet.Attacker = self.Owner

			self:FireBullets(bullet)
			self:ShootEffects()
			self:TakePrimaryAmmo(16)
			self:EmitSound(self.Primary.sound)
			self.Owner:ViewPunch(Angle(5, 0, 0))

			self:SetNWInt("anim", 1)
			timer.Simple( 3/35, function()
			self:SetNWInt("anim", 2)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 3)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 4)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 5)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 6)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 7)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 8)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 9)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 10)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 11)
     		timer.Simple( 1/35, function()
     		self:SetNWInt("anim", 12)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 13)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 14)
     		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 15)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 16)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 17)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 18)
     		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 19)
     		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 20)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 21)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 22)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 23)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 24)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 25)
      		timer.Simple( 1/35, function()
      		self:SetNWInt("anim", 26)
      		timer.Simple( 1/35, function()
			self:SetNWInt("anim", 27)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 28)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 29)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 30)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 31)
			timer.Simple( 1/35, function()
			self:SetNWInt("anim", 32)
			timer.Simple( 3/35, function()
			self:SetNWInt("anim", 33)
			timer.Simple( 3/35, function()
			self:SetNWInt("anim", 0)
	end )
    end )
	end )
	end )
	end )
	end )
	end )
	end )
	end )
	end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
    end )
	end )
	end )
	end )
	end )
	end )
	end )
	end )

end

function SWEP:Deploy()
	self:SetNWInt("anim", 0)
end

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:DrawHUD()

local frame = self:GetNWInt("anim")
surface.SetMaterial(ST)
ST:SetInt("$frame", frame)
surface.SetDrawColor(255, 255, 255, 255)
surface.DrawTexturedRectRotated( (ScrW()/2), (ScrH()-(ScrW()/7.8)), (ScrW()/1), (ScrW()/3.75), 0)

end
