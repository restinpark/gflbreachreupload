AddCSLuaFile()
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_106")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Destroy"
SWEP.Instructions	= "LMB to send a player to PD, RMB to use a Destructive AOE, Reload to put down a portal."

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-106"
SWEP.Category 		= "SCP"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.AttackDelay			= 0.25
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
SWEP.NextAttackW			= 0
SWEP.PortalPlace 			= 0
SWEP.PortalDelay 			= 20
SWEP.NextAttackD			= 0
SWEP.AttackDelay2			= 45

game.AddDecal("portal", "TTT_FOUNDATION/106_STAIN_01")

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
	if self.PortalPlace > CurTime() then return end
	self.PortalPlace = CurTime() + self.PortalDelay
if SERVER then 
	local create = ents.Create("portaltrap")
	create:SetPos(self.Owner:GetPos())
    create:Spawn()
	create:EmitSound("laugh.ogg", 100, 100)
end
local start = self.Owner:GetPos()
    local btr = util.TraceLine({start=start, endpos=(start + Vector(0,0,-1000)), filter = ignore})
    util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
	util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
	util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
	util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
	util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
	util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
	util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
	util.Decal("Scorch", btr.HitPos, btr.HitPos-btr.HitNormal)
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
				if ent:GetNClass() == ROLE_SCP990 then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				local pos = GetPocketPos()
				if pos then
					roundstats.teleported = roundstats.teleported + 1
					--self.Owner:SetHealth(self.Owner:Health() + 100)
					if ent.GetNClass and ent:GetNClass() == ROLE_999 then
						ent:TakeDamage( 30, self.Owner, self.Owner )
					elseif ent.SetBleeding and game.GetMap() != "br_area14_v3" then
						ent:SetBleeding(true)
					elseif game.GetMap() == "br_area14_v3" then
						//Do nothing
					else
						ent:TakeDamage( 30, self.Owner, self.Owner )
					end
					
					ent:SetPos(pos)
					ent:AddFrags(-2)
					--self.Owner:PS2_AddStandardPoints(200, "Captured " .. ent:Nick() .. " to the pocket realm.", true)
				end
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(25, 100), self.Owner, self.Owner )
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if self.NextAttackD > CurTime() then return end
	self.NextAttackD = CurTime() + self.AttackDelay2
	if SERVER then
	self.Owner:TakeDamage()
	self.Owner:EmitSound("laugh.ogg", 100, 100)
		for k, v in pairs(ents.FindInSphere(self:GetPos(),400)) do
			if v:IsPlayer() then
				if v:Team() != TEAM_SCP and v:Team() != TEAM_SPEC and self.Owner and IsValid(self.Owner) then
		local
		self = v:GetActiveWeapon()if
		self&&self.ISSCP
			then
			continue
		end
	v:SetDecomposing(true) end
end
end
end
local effectdata = EffectData()
		effectdata:SetOrigin(self.Owner:GetPos())
		util.Effect( "StriderBlood", effectdata )
		util.Effect( "HunterDamage", effectdata )
		util.Effect( "BloodImpact", effectdata )
		util.Effect( "bloodspray", effectdata )
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to Destroy"
	local showcolor = Color(0,255,0)

	if self.NextAttackD > CurTime() then
		showtext = "Next destruction in " .. math.Round(self.NextAttackD - CurTime())
		showcolor = Color(255,0,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext2 = "Ready to place portal"
	local showcolor2 = Color(0,255,0)

	if self.PortalPlace > CurTime() then
		showtext2 = "Next portal in " .. math.Round(self.PortalPlace - CurTime())
		showcolor2 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor2,
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