AddCSLuaFile()
if CLIENT then
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "chan_man1"
SWEP.Contact		= "GFL Forums"
SWEP.Purpose		= "Help Others"
SWEP.Instructions	= "LMB to Teleport anywhere you aim, RMB to link yourself to a player, RELOAD to return to your host. Type in chat !exit990 to kill yourself if bored, and type in !return990 to get yourself unstuck."
SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-990"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false
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
SWEP.Teleport				= 0
SWEP.TeleportDelay			= 1

function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
  	if SERVER then self.Owner:DrawWorldModel( false ) end
	self.Owner:GodEnable()
end

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()
	if self.Teleport > CurTime() then return end
	self.Teleport = CurTime() + self.TeleportDelay
	local ply = self.Owner
	local t = {} 
		t.start = ply:GetPos() + Vector( 0, 0, 32 ) 
		t.endpos = ply:GetPos() + ply:EyeAngles():Forward() * 16384 
		t.filter = ply 
	local tr = util.TraceEntity( t, ply ) 
		ply:SetPos( tr.HitPos )
		self:SetNextPrimaryFire( CurTime() + 0 )
	if self.Transparency == 0 then
		self:ResetVis()
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
	for k,v in pairs(player.GetAll()) do
		if v:HasWeapon("weapon_dream") then return end
	end
		local ent = nil
		local tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 170 ),
			filter = self.Owner,
			mins = Vector( -20, -20, -20 ),
			maxs = Vector( 20, 20, 20 ),
			mask = MASK_SHOT_HULL
		} )
		ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if self.Owner.AddAchievementProgress then
				self.Owner:AddAchievementProgress("Helper", 1)
				end
					ent:Give("weapon_dream")
					ent:PrintMessage(3, "You've been linked to SCP-990.")
					self.Owner:PrintMessage(3, "You've been linked to a host.")
					self.Owner:EmitSound("scp990.ogg", 100, 100)
				end
			end
		end
	end

function SWEP:Reload()
if self:GetOwner():KeyDown(IN_USE) then
if SERVER then
	for k,v in pairs(player.GetAll()) do
		if v:HasWeapon("weapon_dream") then
		local ent = nil
		local tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 170 ),
			filter = self.Owner,
			mins = Vector( -20, -20, -20 ),
			maxs = Vector( 20, 20, 20 ),
			mask = MASK_SHOT_HULL
		} )
		ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
					ent:StripWeapon("weapon_dream")
					end
				end
			end
		end
	end
end
if self:GetOwner():KeyDown(IN_USE) then return end	
if SERVER then
	for k,v in pairs(player.GetAll()) do
		if v:HasWeapon("weapon_dream") then
			self.Owner:SetPos(v:GetPos())
			end
		end
	end
end


function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Not Linked to a Host!"
	local showcolor = Color(255,0,0)

	for k,v in pairs(player.GetAll()) do
		if v:HasWeapon("weapon_dream") then
		showtext = "Linked to a Host!"
		showcolor = Color(0,255,0)
		end
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	if disablehud == true then return end

	local showtext2 = "Ready to Teleport"
	local showcolor2 = Color(0,255,0)

	if self.Teleport > CurTime() then
		showtext2 = "Next teleport in " .. math.Round(self.Teleport - CurTime())
		showcolor2 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2, ScrH() - 50 },
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
