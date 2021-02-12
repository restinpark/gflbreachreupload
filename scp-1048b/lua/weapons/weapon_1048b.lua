AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "chan_man1"
SWEP.Contact		= "GFL Forums"
SWEP.Purpose		= "Build-A-Bear"
SWEP.Instructions	= "LMB to take ears off of people and destroy items made of metal, RMB to create a 1048-A instance, RMB+E to create a 1048-B instance, Reload to create a 1048-C instance"
SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-1048-B"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.AttackDelay			= 1.25
SWEP.ISSCP = true
SWEP.droppable				= false
SWEP.teams					= {1}
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Automatic	= false
SWEP.NextAttackW			= 0
SWEP.NextBearA				= 0
SWEP.BearADelay				= 60
SWEP.NextBearB				= 0
SWEP.BearBDelay				= 60
SWEP.NextBearC				= 0
SWEP.BearCDelay				= 60
function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:Think()
	if SERVER then
	local pos = Vector(self:GetPos())
		if self.Owner:Health() < 30 then
			self.Owner:SetSCP1048BR()
			self.Owner:SetPos(pos)
		end
	end
end

function SWEP:PrimaryAttack()
	//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if self.NextAttackW > CurTime() then return end
	self.NextAttackW = CurTime() + self.AttackDelay
	if SERVER then
		local ent = nil
		local tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 ),
			filter = self.Owner,
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			mask = MASK_SHOT_HULL
		} )
		ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					ent:TakeDamage(10, self.Owner, self.Owner)
					self.Owner:GiveAmmo(1, "AirboatGun", true)
				end
			end
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if ent:Health() > 10 then return end
					self.Owner:GiveAmmo(1, "HelicopterGun", true)
				end
			end
		if IsValid(ent) then
			if ent:IsPlayer() then return end
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				end
			end
		if IsValid(ent) then
			if ent:IsPlayer() then return end
				if ent:GetClass() == "func_breakable" or ent:GetClass() == "prop_dynamic" or ent:GetClass() == "prop_static" or ent:GetClass() == "func_door" or ent:GetClass() == "prop_door_rotating" or ent:GetClass() == "func_door_rotating" or ent:GetClass() == "item_medkit" or ent:GetClass() == "scp-348" or ent:GetClass() == "scp_1162" or ent:GetClass() == "ent_scp038" or ent:GetClass() == "scp_106_ent" or ent:GetClass() == "ent_scp330" or ent:GetClass() == "infinitepizzaent" or ent:GetClass() == "scp_1025" or ent:GetClass() == "scp_1425" or ent:GetClass() == "scp294" or ent:GetClass() == "weapon_scp_500" or ent:GetClass() == "item_foxammo" or ent:GetClass() == "weapon_scp668" then return end
				if BREACH_IsGateDoor(ent) then return end
					ent:Remove()
					self.Owner:GiveAmmo(1, "StriderMinigun", true)
				end
			end
		end
			
		

function SWEP:SecondaryAttack()
	if self:GetOwner():KeyDown(IN_USE) then
	if self.Owner:GetAmmoCount(22) > 3 then
	if self.NextBearB > CurTime() then return end
	self.NextBearB = CurTime() + self.BearBDelay
	if SERVER then
	local ply = table.Random(GetNotAFKSpecs())
	local pos = Vector(self:GetPos())
		if IsValid(ply) then
			ply:SetSCP1048B()
			ply:SetPos(pos)
			self.Owner:RemoveAmmo(2, "HelicopterGun")
		end
	end
end
end
	if self:GetOwner():KeyDown(IN_USE) then return end
	if self.Owner:GetAmmoCount(20) > 15 then
	if self.NextBearA > CurTime() then return end
	self.NextBearA = CurTime() + self.BearADelay
	if SERVER then
	local ply = table.Random(GetNotAFKSpecs())
	local pos = Vector(self:GetPos())
		if IsValid(ply) then
			ply:SetSCP1048A()
			ply:SetPos(pos)
			self.Owner:RemoveAmmo(8, "AirboatGun")
		end
	end
end
end

function SWEP:Reload()
	if self.Owner:GetAmmoCount(21) > 23 then
	if self.NextBearC > CurTime() then return end
	self.NextBearC = CurTime() + self.BearCDelay
	if SERVER then
	local ply = table.Random(GetNotAFKSpecs())
	local pos = Vector(self:GetPos())
		if IsValid(ply) then
			ply:SetSCP1048C()
			ply:SetPos(pos)
			self.Owner:RemoveAmmo(16, "StriderMinigun")
		end
	end
end
end


function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Need more ears!"
	local showcolor = Color(255,0,0)

	if self.Owner:GetAmmoCount(20) > 15 then
		showtext = "Build 1048-A? "
		showcolor = Color(0,255,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2.19, ScrH() - 75 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtextb = "Preparations Complete!"
	local showcolorb = Color(0,255,0)

	if self.NextBearA > CurTime() then
		showtextb = "Need to prepare.." .. math.Round(self.NextBearA - CurTime())
		showcolorb = Color(255,0,0)
	end

	draw.Text( {
		text = showtextb,
		pos = { ScrW() / 1.75, ScrH() - 75 },
		font = "173font",
		color = showcolorb,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtextc = "***"
	local showcolorc = Color(0,0,255)

	draw.Text( {
		text = showtextc,
		pos = { ScrW() / 1.98, ScrH() - 75 },
		font = "173font",
		color = showcolorc,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	if disablehud == true then return end

	local showtext2 = "Need more flesh!"
	local showcolor2 = Color(255,0,0)

	if self.Owner:GetAmmoCount(22) > 3 then
		showtext2 = "Build 1048-B? "
		showcolor2 = Color(0,255,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2.19, ScrH() - 50 },
		font = "173font",
		color = showcolor2,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext2b = "Preparations Complete!"
	local showcolor2b = Color(0,255,0)

	if self.NextBearB > CurTime() then
		showtext2b = "Need to prepare.." .. math.Round(self.NextBearB - CurTime())
		showcolor2b = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2b,
		pos = { ScrW() / 1.75, ScrH() - 50 },
		font = "173font",
		color = showcolor2b,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext2c = "***"
	local showcolor2c = Color(0,0,255)

	draw.Text( {
		text = showtext2c,
		pos = { ScrW() / 1.98, ScrH() - 50 },
		font = "173font",
		color = showcolor2c,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

if disablehud == true then return end

	local showtext3 = "Need more metal!"
	local showcolor3 = Color(255,0,0)

	if self.Owner:GetAmmoCount(21) > 23 then
		showtext3 = "Build 1048-C? "
		showcolor3 = Color(0,255,0)
	end

	draw.Text( {
		text = showtext3,
		pos = { ScrW() / 2.19, ScrH() - 25 },
		font = "173font",
		color = showcolor3,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext3b = "Preparations Complete!"
	local showcolor3b = Color(0,255,0)

	if self.NextBearC > CurTime() then
		showtext3b = "Need to prepare.." .. math.Round(self.NextBearC - CurTime())
		showcolor3b = Color(255,0,0)
	end

	draw.Text( {
		text = showtext3b,
		pos = { ScrW() / 1.75, ScrH() - 25 },
		font = "173font",
		color = showcolor3b,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext3c = "***"
	local showcolor3c = Color(0,0,255)

	draw.Text( {
		text = showtext3c,
		pos = { ScrW() / 1.98, ScrH() - 25 },
		font = "173font",
		color = showcolor3c,
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
