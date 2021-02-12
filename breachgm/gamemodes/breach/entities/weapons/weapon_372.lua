--Originally coded by AverageDrink for the LB Community
--Modified by Aurora for the GFL Community
--Double Modified by chan_man1 for the GFL Breach Server

AddCSLuaFile()

SWEP.Category 				= "SCP"
SWEP.PrintName      		= "SCP-372"
SWEP.Author        			= "AverageDrink, nFixed by Aurora, modified by chan_man1"
SWEP.Contact 				= ""
SWEP.Purpose 				= "Hiding"
SWEP.Instructions 			= "Left click to attack, right click to jump, right click against a wall to grab, reload to toggle cloak. Use E + LMB to uncloak at any given time. Must aim up when jumping. Use E+R to break Glass or Gates."
SWEP.ViewModel 				= "models/breach173.mdl" -- You will need http://steamcommunity.com/sharedfiles/filedetails/?id=245482078 for this not to show up as an error
SWEP.Slot 					= 0
SWEP.SlotPos 				= 1
SWEP.DrawWeaponInfoBox		= true
SWEP.Spawnable				= true

SWEP.WorldModel 			= "models/breach173.mdl" -- You will need http://steamcommunity.com/sharedfiles/filedetails/?id=245482078 for this not to show up as an error
SWEP.HoldType				="normal"


SWEP.canReload = 1
SWEP.Crouch = 0
SWEP.Crouch2 = 0

SWEP.Primary.ClipSize = -1

SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Damage = 34
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.SwingSound = "Weapon_Crowbar.Single"
SWEP.HitSound = "Weapon_Crowbar.Melee_Hit"
SWEP.droppable = false
SWEP.Kind = WEAPON_MELEE

SWEP.OnWall = false
/*
	local colorMofify = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}*/

SWEP.Delay=5
SWEP.Range=100
SWEP.Damage=0
SWEP.AutoSpawnable = false

local MatList = { }
MatList[67] = "concrete"
MatList[68] = "dirt"
MatList[71] = "chainlink"
MatList[76] = "tile"
MatList[77] = "metal"
MatList[78] = "dirt"
MatList[84] = "tile"
MatList[86] = "duct"
MatList[87] = "wood"

local CamoMat = Material("camo/camo_shade.vmt")
local CamoOverlayMat = "camo/camo_overlay.vmt"

function SWEP:cloak(on)
	self:SetNWBool("cloaked", on)
end
--Do not draw the world model
function SWEP:DrawWorldModel() end
function SWEP:Precache()
    	util.PrecacheSound("physics/flesh/flesh_squishy_impact_hard1.wav")
    	util.PrecacheSound("physics/flesh/flesh_squishy_impact_hard2.wav")
    	util.PrecacheSound("physics/flesh/flesh_squishy_impact_hard3.wav")
    	util.PrecacheSound("physics/flesh/flesh_squishy_impact_hard4.wav")
end

local function Draw372(ply)

	if IsValid(ply) and ply.GetNClass and ply:GetNClass() == ROLE_SCP372 and ply:HasWeapon("weapon_372") then
		local wep = ply:GetWeapon("weapon_372")
		if wep:GetNWBool("cloaked", false) then
			return true
		end
	end
end

hook.Add("PrePlayerDraw", "Make372InvisibleWhileCloaked", Draw372)


local function DrawInvisEffects()
	if LocalPlayer().GetNClass and LocalPlayer():GetNClass() == ROLE_SCP372 and LocalPlayer():HasWeapon("weapon_372") then
		if LocalPlayer():GetWeapon("weapon_372"):GetNWBool("cloaked", false) then
		--DrawColorModify(colorMofify)
			DrawMotionBlur(0.1, 0.5, 0.01)
			--DrawToyTown(2,ScrH()/2)
		end
	end
end
hook.Add("RenderScreenspaceEffects","ShowInvisEffects",DrawInvisEffects)



function SWEP:Initialize()
	if SERVER then
		self:SetNWBool("cloaked", false)
	end
if CLIENT then
/*
	local colorMofify = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}*/


	--local CamoOverlayID = surface.GetTextureID(CamoOverlayMat)
	local function DrawInvisItems()
		if LocalPlayer().GetNClass and LocalPlayer():GetNClass() == ROLE_SCP372 then
			if LocalPlayer():Alive() then
			
			end
		else
		hook.Remove("HUDPaint","DrawActiveInvisItems")
		end
	end
	hook.Add("HUDPaint","DrawActiveInvisItems",DrawInvisItems)
	end

    self:SetWeaponHoldType(self.HoldType)
	hook.Remove("GetFallDamage","372nofall")
	function disableFallDamage(ply)
		if ply.GetNClass and ply:GetNClass() == ROLE_SCP372 then
			return 0
		end
	end
	hook.Add("GetFallDamage","372nofall",disableFallDamage)
end

function SWEP:OnRemove()
	if (timer.Exists("372uncloak")) then
		timer.Destroy("372uncloak")
		end
		if (timer.Exists("372cloak")) then
		timer.Destroy("372cloak")
		end
		hook.Remove("RenderScreenspaceEffects","ShowInvisEffects")
		hook.Remove("HUDPaint","DrawActiveInvisItems")
	end

function SWEP:Deploy()
	self.Owner:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self.Owner:DrawViewModel(false)
	self:SetWeaponHoldType(self.HoldType)
	self:SetNWBool("cloaked", true)
end

SWEP.NextAttack = 0
SWEP.AttackCooldown = 0.25

function SWEP:PrimaryAttack()
	if self:GetOwner():KeyDown(IN_USE) then
		self:SetNWBool("cloaked", false)
	end
	if self:GetNWBool("cloaked", false) then
		if IsValid(self.Owner) and self.Owner:IsPlayer() then
			self.Owner:PrintMessage(4, "You must be uncloaked to attack!")
			return
		end
	end
	if not IsFirstTimePredicted() then return end
	if self.NextAttack > CurTime() then return end
	if self:GetOwner():KeyDown(IN_USE) then return end
	
	self.NextAttack = CurTime() + self.AttackCooldown
	local trace = util.TraceLine(
	{
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*140,
		filter = self.Owner
	})
	local i = trace.Entity
	if IsValid(i) and (SERVER && ((i:IsPlayer() and i:Team() != TEAM_SCP and i:Team() != TEAM_SPEC) || i:IsNPC() || i:GetClass() == "func_breakable")) then
	if i:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end

			i:TakeDamage(self.Primary.Damage, self.Owner, self)
			i:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(1,4)..".wav", 100, 150)
	end
end

function SWEP:SecondaryAttack()
	local t = {}
	t.start = self.Owner:GetPos() + Vector( 0, 0, 15 )
	t.endpos = self.Owner:GetPos() + self.Owner:EyeAngles():Forward() * 16384
	t.filter = function(ent) if ent:IsPlayer() then return false end end
	local tr = util.TraceEntity( t, self.Owner )

	local pos = tr.HitPos
	local distance = pos:Distance( self.Owner:GetPos() )
	if self.Owner:IsOnGround() or self.OnWall then
		self.Owner:SetLocalVelocity(self.Owner:GetAimVector()*600)--700)
		self.OnWall = false
		self.Owner:SetMoveType(MOVETYPE_WALK)
	else
		if distance < 32 && MatList[tr.MatType] then
			self.Owner:SetLocalVelocity( Vector( 0, 0, 300) )
			self.Owner:SetMoveType(MOVETYPE_WALK)
			self.OnWall = true
			self.Owner:SetMoveType(MOVETYPE_NONE)
		end
	end
end

function SWEP:Think()
return false
end

SWEP.NextCloakR = 0
SWEP.NextCloak = 30


function SWEP:Reload()
	if self:GetOwner():KeyDown(IN_USE) then
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
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
			if ent:GetClass() == "func_breakable" then
				if SERVER then
					ent:TakeDamage( 2, self.Owner, self.Owner )
				end
			elseif SERVER and BREACH_IsGateDoor(ent) then
				ent:TakeDamage( math.random(2, 3), self.Owner, self.Owner )
			end
		end
	end
	if self:GetOwner():KeyDown(IN_USE) then return end
	if not IsFirstTimePredicted() then return end
	if self.NextCloakR > CurTime() then return end
	self.NextCloakR = CurTime() + self.NextCloak
	if SERVER then
	if self:GetNWBool("cloaked", true) then
		return self:SetNWBool("cloaked", false)
	else
		self:SetNWBool("cloaked", true)
		end
	timer.Simple(10, function()
		self:SetNWBool("cloaked", false)
		end)
	end
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "You are uncloaked."
	local showcolor = Color(255,0,0)

	if self:GetNWBool("cloaked", false) then
		showtext = "You are cloaked."
		showcolor = Color(0,255,0)
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

	local showtext2 = "Ready to Cloak/Uncloak"
	local showcolor2 = Color(0,255,0)

	if self.NextCloakR > CurTime() then
		showtext2 = "Next Cloak/Uncloak in " .. math.Round(self.NextCloakR - CurTime())
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
