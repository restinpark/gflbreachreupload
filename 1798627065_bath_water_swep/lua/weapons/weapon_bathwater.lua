SWEP.PrintName = "Dumb Bitch Juice"
SWEP.Purpose = "The Goddess\'s Elixir. Drink it to reach enlightenment!"
SWEP.Instructions = "Primary: Drink"
SWEP.Author = "\nChev: Coding, partial modelling\nDr. Manndarinchik (GB): Modelling/texturing"

SWEP.Category = "Chev\'s Weapons"
SWEP.Spawnable = true
SWEP.Slot = 1

local bathwatermodel = Model("models/manndarinchik/ggbathwater.mdl")

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel	= bathwatermodel
SWEP.WorldModel	= bathwatermodel
SWEP.HoldType = "pistol"
SWEP.DrawAmmo = false

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack() --drink dumb bitch juice
	self:EmitSound("chev/ggbathwater/bathwater_drink.ogg")
	if SERVER then
		local ply = self.Owner
		local timername = "BathwaterPoison"..ply:SteamID()
			if IsValid(ply) and ply:Alive() then
				ply:ViewPunch(Angle(math.random(-1, -2), 0, 0))
				ply:SetWalkSpeed(ply:GetWalkSpeed() + 150)
				if ply:Health() + 15 > ply:GetMaxHealth() then
					ply:SetHealth(ply:GetMaxHealth())
				else
					ply:SetHealth(ply:Health() + 50)
				end
					ply:SetBleeding(false)
				self.Owner:StripWeapon("weapon_bathwater")
			end
		end
end

function SWEP:SecondaryAttack()
end

if CLIENT then
	function SWEP:DrawWorldModel()
		local ply = self:GetOwner()

	    if IsValid(ply) then
	        local opos = self:GetPos()
	        local oang = self:GetAngles()
	        local bon = ply:LookupBone("ValveBiped.Bip01_R_Hand")
		    local bp, ba = ply:GetBonePosition(bon or 0)

	        if bp then opos = bp end
	        if ba then oang = ba end

        	opos = opos + oang:Right() * 3.4
      	  	opos = opos + oang:Forward() * 6.9
      		opos = opos + oang:Up() * 0
	        oang:RotateAroundAxis(oang:Right(), 180)
	        self:SetupBones()

	        local mrt = self:GetBoneMatrix(0)
	        if mrt then
		        mrt:SetTranslation(opos)
		        mrt:SetAngles(oang)

		        self:SetBoneMatrix(0, mrt)
	        end
	    end

		self:DrawModel()
	end

	function SWEP:GetViewModelPosition(p, a)
		local bpos = Vector(10, 27, -9)
		local bang = Vector(-20, 180, 0)

		local right = a:Right()
		local up = a:Up()
		local forward = a:Forward()

		a:RotateAroundAxis(right, bang.x)
		a:RotateAroundAxis(up, bang.y)
		a:RotateAroundAxis(forward, bang.z)

		p = p + bpos.x * right
		p = p + bpos.y * forward
		p = p + bpos.z * up

		return p, a
	end
end
