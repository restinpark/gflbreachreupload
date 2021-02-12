AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_457")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Reload to implode and right click to split"
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-457"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.ISSCP = true
SWEP.droppable				= false
SWEP.teams					= {1}
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.FireSplit 				= 0
SWEP.FireSplitDelay 		= 20
SWEP.Implode 				= 2
SWEP.ImplodeDelay 			= 15

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false

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
		--self.Owner:Ignite(0.1,100)
		for k,v in pairs(ents.FindInSphere( self.Owner:GetPos(), 230 )) do
			if v:IsPlayer() then
				if v:Team() != TEAM_SCP and v:Team() != TEAM_SPEC and v:GetNClass() != ROLE_SCP990 and self.Owner and IsValid(self.Owner) and not self.Owner.SCP457_Wet then
					v:Ignite(3,50)
				end
			end
		end
	end
end

function SWEP:Reload()
if self.Implode > CurTime() then return end
	self.Implode = CurTime() + self.ImplodeDelay
	if SERVER then
	local k, v
    local ent = ents.Create( "env_explosion" )
    ent:SetPos( self.Owner:GetPos() )
    ent:SetOwner( self.Owner )
    ent:Spawn()
    ent:SetKeyValue( "iMagnitude", "80" )
    ent:Fire( "Explode", 0, 0 )
    ent:EmitSound( "BaseExplosionEffect.Sound", 100, 100 )
end
end

function SWEP:PrimaryAttack()
	//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if(ent:GetPos():Distance(self.Owner:GetPos()) < 125) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				//ent:SetSCP0492()
				//roundstats.zombies = roundstats.zombies + 1
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 1000, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(25, 100), self.Owner, self.Owner )
				end
			end
		end
	end
end
function SWEP:SecondaryAttack()
	if self.FireSplit > CurTime() then return end
	self.FireSplit = CurTime() + self.FireSplitDelay
	if SERVER then
	local create = ents.Create("firesplit")
	create:SetPos(self.Owner:GetPos())
    create:Spawn()
	create:EmitSound("Weapon_FlareGun.Burn", 100, 100)
end
end

function SWEP:CanPrimaryAttack()
	return true
end


if SERVER then
FIRE_ENT_LIST = {}
timer.Create("457CreateFireEffects", 0.05, 0, function ()

	for k,v in pairs(FIRE_ENT_LIST) do
		local ply = player.GetBySteamID(k)
		if not IsValid(ply) then
			if IsValid(FIRE_ENT_LIST[k]) then
				FIRE_ENT_LIST[k]:Remove()
			end
			FIRE_ENT_LIST[k] = nil
		elseif IsValid(ply) and ply.GetNClass and ply:GetNClass() != ROLE_SCP457 then
			if IsValid(FIRE_ENT_LIST[k]) then
				FIRE_ENT_LIST[k]:Remove()
			end
			FIRE_ENT_LIST[k] = nil
		else
			if !IsValid(FIRE_ENT_LIST[k]) then
				FIRE_ENT_LIST[k] = nil
			end
		end
	end
	for k,v in pairs(player.GetAll()) do
		if v.GetNClass and v:GetNClass() == ROLE_SCP457 and not FIRE_ENT_LIST[v:SteamID()] and not v.SCP457_Wet then
			FIRE_ENT_LIST[v:SteamID()] = ents.Create("env_fire")
			FIRE_ENT_LIST[v:SteamID()]:SetPos(v:GetPos() + v:GetAimVector() * 20)
			FIRE_ENT_LIST[v:SteamID()]:SetKeyValue("health", tostring(-1))
			FIRE_ENT_LIST[v:SteamID()]:SetKeyValue("firesize", tostring(512))
			FIRE_ENT_LIST[v:SteamID()]:SetKeyValue("fireattack", "0")
			FIRE_ENT_LIST[v:SteamID()]:SetKeyValue("damagescale", "0")
			FIRE_ENT_LIST[v:SteamID()]:SetKeyValue("ignitionpoint", "1200")
			FIRE_ENT_LIST[v:SteamID()]:SetKeyValue("spawnflags", tostring(20 + 128 + 1))
			FIRE_ENT_LIST[v:SteamID()]:SetParent(v)
			FIRE_ENT_LIST[v:SteamID()]:Spawn()
			FIRE_ENT_LIST[v:SteamID()]:Activate()
		end
	end

end)


	function _scp457_disable(ply, time)
		ply.SCP457_Wet = true

		if FIRE_ENT_LIST[ply:SteamID()] and IsValid(FIRE_ENT_LIST[ply:SteamID()]) then
			FIRE_ENT_LIST[ply:SteamID()]:Remove()
			FIRE_ENT_LIST[ply:SteamID()] = nil
		end

		BREACH_SetupEventTimer(ply, CurTime() + time, function () return false end, function (ply)
			if IsValid(ply) then
				ply.SCP457_Wet = false
			end
		end, "Extinguished!")
	end
end



function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext1 = "Ready to split"
	local showcolor1 = Color(0,255,0)

	if self.FireSplit > CurTime() then
		showtext1 = "Next split in " .. math.Round(self.FireSplit - CurTime())
		showcolor1 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext1,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor1,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	if disablehud == true then return end

	local showtext2 = "Ready to implode"
	local showcolor2 = Color(0,255,0)

	if self.Implode > CurTime() then
		showtext2 = "Next implosion at " .. math.Round(self.Implode - CurTime())
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

