SWEP.PrintName = "SCP-1290"
SWEP.Author = "chan_man1"
SWEP.Instructions = "Primary to TELEPORT, Secondary to SET TELEPORT. WARNING: Teleportation device is unstable use at own risk!"
AddCSLuaFile()
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Secondary = SWEP.Primary
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/props_lab/reciever01d.mdl"
SWEP.ItemType = WEAPON_OTHER or 11
SWEP.DrawCrosshair = true
--Breach stuff
SWEP.droppable = true

local TELEPORT_DELAY = 0
SWEP.NextTeleportAction = 0

function SWEP:DrawWorldModel()
	if !IsValid(self.Owner) then
		self:DrawModel()
	end
end

function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end

--Teleport to the set position
function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    if self.NextTeleportAction > CurTime() then return end

   if self.TP_Target and IsValid(self.Owner) then
        self.NextTeleportAction = CurTime() + TELEPORT_DELAY
        if SERVER then
            self.Owner:SetPos(self.TP_Target)
			self.Owner:SetPos(self.Owner:GetPos() + Vector(0,0,10))
			self.Owner:SetVelocity(self.Owner:GetAimVector() * table.Random({2800, -2800}))
			if self.Owner:GetNClass() == ROLE_SCP181 and math.random(1, 2) then return end
			self.Owner:TakeDamage(table.Random({0, 10, 25}))
			self.Owner:EmitSound("ambient/machines/teleport1.wav", 100, 80)
        end
   elseif SERVER then
        self.Owner:PrintMessage(3, "You must set a teleport position before teleporting!")
   end
end

SWEP.NextSecondary = 0

--Set a position to teleport to
function SWEP:SecondaryAttack()
    if not IsFirstTimePredicted() then return end
    if self.NextSecondary > CurTime() then return end
    self.NextSecondary = CurTime() + 0.5
    self.TP_Target = self.Owner:GetPos()
end


function SWEP:Reload()
end

if CLIENT then
    --Draw cooldown information on the bottom of the screen
    function SWEP:DrawHUD()
        if disablehud then return end
        local t = "Teleport ready!"
        local c = Color(0, 255, 0)

        if self.NextTeleportAction > CurTime() then
            t = string.format("Next teleport in %d.", math.Round(self.NextTeleportAction - CurTime()))
            c = Color(255, 0, 0)
        end

        draw.Text( {
            text = t,
            pos = { ScrW() / 2, ScrH() - 50 },
            font = "173font",
            color = c,
            xalign = TEXT_ALIGN_CENTER,
            yalign = TEXT_ALIGN_CENTER
        })
    end
end