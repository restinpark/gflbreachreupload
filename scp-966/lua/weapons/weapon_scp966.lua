AddCSLuaFile()
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/scp_966_wep")
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-966"
SWEP.Author = "Aurora"
SWEP.Category = "Aurora's SWEPs"
SWEP.Instructions = "Primary to disorient, Secondary to attack"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
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
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = false
SWEP.Contact = "https://goo.gl/mHAu1j"
SWEP.Purpose = "Kill Humans"
SWEP.NextAttackH = 0
SWEP.NextAttackT = 0
SWEP.AttackDelay = 15
SWEP.NextAttackW = 0
SWEP.AttackDelay2 = 1
SWEP.AttackDelay3 = 0
SWEP.nexteric = CurTime() + 20
function SWEP:Initialize()
	util.PrecacheSound( "breach/966/near.ogg" )
	util.PrecacheSound( "breach/966/horror1.ogg" )
	util.PrecacheSound( "breach/966/horror2.ogg" )

end
function SWEP:Deploy()
  self.Owner:DrawViewModel( false )
  self.Owner:DrawWorldModel( false )
end
function SWEP:Holster()
	return true
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end
function SWEP:Think()
	if self.NextAttackT > CurTime() then return end
	if not IsFirstTimePredicted() then return end
	self.NextAttackT = CurTime() + math.random(8, 20)
	if IsValid(self.Owner) then
		self.Owner:EmitSound("breach/966/near.ogg", SNDLVL_85dB, 100, 1, CHAN_AUTO)
	end
end
function SWEP:Reload()
end


function SWEP:PrimaryAttack()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if (CurTime() < self.NextAttackH) then return end
	self.NextAttackH = CurTime() + 0.5
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
				if SERVER then
					if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					if ent:Team() == TEAM_SCP or ent:Team() == TEAM_SPEC then else
					ent:TakeDamage( 34, self.Owner, self.Owner )
					self.NextAttackH = CurTime() + 1.5
				end
				end
			end
			if ent:GetClass() == "func_breakable" then
				if SERVER then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				end
			elseif SERVER and BREACH_IsGateDoor(ent) then
				ent:TakeDamage( math.random(25, 100), self.Owner, self.Owner )
			end
		end
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	if self.NextAttackW > CurTime() then return end
	self.NextAttackW = CurTime() + 10

	self.Owner:EmitSound("breach/966/horror"..math.random(1, 2)..".ogg", SNDLVL_130dB, 100, 1, CHAN_AUTO)
	if SERVER then
		local targetplys = {}
		local findents = ents.FindInSphere( self.Owner:GetPos(), 350 )
		for k,ent in pairs(findents) do
			if ent:IsPlayer() and IsValid(ent) then
				if ent:Team() ~= TEAM_SPEC and ent:Team() ~= TEAM_SCP then
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					table.ForceInsert(targetplys, ent)
				end
			end
		end
		for k,v in pairs(targetplys) do
			--ULib.slap( v, 0 )
			--v:SetEyeAngles( AngleRand() )
			v:TakeDamage(math.random(7	, 40), self.Owner, self)
			if v:HasWeapon("weapon_nvg") then
				local nvg = v:GetWeapon("weapon_nvg")
				if nvg.IsOn then
					nvg.IsOn = false
				end
			end
		end
	end
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to attack"
	local showcolor = Color(0,255,0)

	if self.NextAttackW > CurTime() then
		showtext = "Next attack in " .. math.Round(self.NextAttackW - CurTime())
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
