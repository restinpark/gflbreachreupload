
if SERVER then

	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
	CreateConVar("q1_playersounds", 1, FCVAR_ARCHIVE, "If the Quakeguy playermodel is selected, enable Quake player sounds")
	CreateConVar("q1_powerupduration", 30)
	CreateConVar("q1_unlimitedammo", 0, FCVAR_NOTIFY, "Unlimited ammo for everyone")

else

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 90
	SWEP.ViewModelFlip		= false
	SWEP.BobScale			= 0
	SWEP.SwayScale			= 0
	
	CreateClientConVar("q1_viewbob", 0)
	CreateClientConVar("q1_bobstyle", 1)

	CreateClientConVar("q1_crosshair", 1)
	CreateClientConVar("q1_firelight", 1)
	CreateClientConVar("q1_software", 0)
	
end

SWEP.Author					= "Upset"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.Category				= "Quake 1"
SWEP.Spawnable				= false

SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	if SERVER then
		self:SetNPCMinBurst(5)
		self:SetNPCMaxBurst(10)
		self:SetNPCFireRate(self.Primary.Delay)
		self:SetNPCMinRest(0.5)
		self:SetNPCMaxRest(2)
	end
	self:SetHoldType(self.HoldType)
	
	local ammo = self.Primary.Ammo
	if ammo != "none" and game.GetAmmoID(ammo) == -1 then
		if IsValid(self.Owner) and self.Owner:IsPlayer() then
			self.Owner:PrintMessage(HUD_PRINTTALK, "Unable to register "..ammo.." ammo type! Expect issues!")
		end
		self.Primary.Ammo = self.Primary.AmmoFallback
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Attack")
	self:NetworkVar("Bool", 1, "Left")
	self:NetworkVar("Float", 0, "HolsterDelay")
	self:NetworkVar("Float", 1, "AnimDelay")
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + .1)
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:SecondaryAttack()	
end

function SWEP:Reload()
end

function SWEP:TakeAmmo(num)
	num = num or 1
	if !self.Owner:IsNPC() and !cvars.Bool("q1_unlimitedammo") then
		self:TakePrimaryAmmo(num)
	end
end

function SWEP:SuperDamageSound()
	if self.Owner.QuakePowerups and self.Owner.QuakePowerups.QuadDamage and self.Owner.QuakePowerups.QuadDamage > CurTime() then
		self:EmitSound("Weapon_Quake1Quad")
	end
end

function SWEP:Think()
	if game.SinglePlayer() and CLIENT then return end

	local holsterDelay = self:GetHolsterDelay()
	if holsterDelay > 0 and holsterDelay <= CurTime() then
		self:SetHolsterDelay(0)
		if CLIENT and IsFirstTimePredicted() or game.SinglePlayer() then
			local wep = self.NewWeapon
			if IsValid(self.Owner) and self.Owner:Alive() and self.Owner:GetActiveWeapon() == self then
				if SERVER then
					self.Owner:SelectWeapon(wep:GetClass())
					if !self:GetAttack() then
						self:SetNextPrimaryFire(CurTime() + .1)
					end
				else
					input.SelectWeapon(wep)
				end
			end
		end
	end
	self:SpecialThink()
end

function SWEP:OnRemove()
	if self.firesound then self.firesound:Stop() end
	self:SetAttack(nil)
end

function SWEP:Holster(wep)
	if self == wep then
		return
	end
	
	if !IsValid(wep) then
		self:OnRemove()
		return true
	end

	local nextAttack = self:GetNextPrimaryFire()
	if nextAttack > CurTime() or self:GetAttack() then
		if IsValid(wep) then
			self.NewWeapon = wep
			self:SetHolsterDelay(nextAttack)
		end
		return false
	end

	self:OnRemove()
	return true
end

function SWEP:SpecialThink()
end

function SWEP:ShootBullet(dmg, recoil, numbul, cone)
	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01

	local bullet = {}
	bullet.Num 		= numbul
	bullet.Src 		= self.Owner:GetShootPos()
	bullet.Dir 		= self.Owner:GetAimVector()
	bullet.Spread 	= Vector(cone, cone, 0)
	bullet.Tracer	= 4
	bullet.Force	= 4
	bullet.Damage	= dmg
	
	self.Owner:FireBullets(bullet)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:CanPrimaryAttack(num)
	if !self.Owner:IsNPC() then
		if self.Owner:GetAmmoCount(self.Primary.Ammo) <= num then	 
			self:SetNextPrimaryFire(CurTime() + 0.2)
			return false	 
		end
	end
	return true
end

function SWEP:FireLight()
	if IsFirstTimePredicted() then
		local pos = self.Owner:GetShootPos()
		local ang = self.Owner:GetAimVector():Angle()
		pos = pos +ang:Forward() *30 +ang:Up() *self.LightUp
		local effectdata = EffectData()
		effectdata:SetStart(pos)
		effectdata:SetOrigin(pos)
		util.Effect("q1_muzzle", effectdata)
	end
end

local quakeguy = "models/player/quakeguy.mdl"

hook.Add("PlayerHurt", "QuakePlayerHurt", function(ply)
	if ply:GetModel() == quakeguy and ply:Health() > 0 and cvars.Bool("q1_playersounds") then
		if !ply.SoundDelay then
			ply.SoundDelay = CurTime()
		end

		if ply.SoundDelay and ply.SoundDelay <= CurTime() then	
			if ply:WaterLevel() == 3 then
				ply:EmitSound("Player_Quake1.drown")
			else
				ply:EmitSound("Player_Quake1.pain")
			end
			ply.SoundDelay = CurTime() + 0.5
		end
	end
end)

hook.Add("EntityTakeDamage", "quakefallsound", function(ply, dmginfo)
	if ply:IsPlayer() and ply:GetModel() == quakeguy and ply:Health() > 0 and cvars.Bool("q1_playersounds") then
		if dmginfo:IsFallDamage() then
			ply:EmitSound("Player_Quake1.land2")
		end
	end
end)

hook.Add("PlayerDeath", "quakedeathsound", function(ply)
	if ply:GetModel() == quakeguy and cvars.Bool("q1_playersounds") then
		ply:EmitSound("player/q1/death"..math.random(1,5)..".wav", 80, 100)
	end
end)

hook.Add("SetupMove", "quakejumpsound", function(ply, move)
	if ply:GetModel() != quakeguy or !cvars.Bool("q1_playersounds") then return end
	if bit.band(move:GetButtons(), IN_JUMP) ~= 0 and bit.band(move:GetOldButtons(), IN_JUMP) == 0 and ply:OnGround() and ply:WaterLevel() < 2 and ply:Alive() and !ply:InVehicle() then
		if CLIENT then return end
		if !ply.JumpSoundDelay then
			ply.JumpSoundDelay = CurTime()
		end

		if ply.JumpSoundDelay and ply.JumpSoundDelay <= CurTime() then
			ply:EmitSound("Player_Quake1.jump")
			ply.JumpSoundDelay = CurTime() + .2
		end
	end
end)

hook.Add("OnPlayerHitGround", "quakelanding", function(ply, inwater, floater, vel)
	if CLIENT then return end
	if ply:GetModel() == quakeguy and ply:Health() > 0 and cvars.Bool("q1_playersounds") then
		if !inwater and vel > 270 and vel < 700 then
			ply:EmitSound("Player_Quake1.land")
		end
	end
end)

if CLIENT then
	function SWEP:PreDrawViewModel(vm)
		if cvars.Bool("q1_software") and vm:GetSkin() != 1 then
			vm:SetSkin(1)
		end
	end

	function SWEP:ViewModelDrawn(vm)
		if vm:GetSkin() == 1 then
			vm:SetSkin(0)
		end
	end

	function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
		surface.SetDrawColor(255, 255, 255, 245)
		surface.SetTexture(self.WepSelectIcon)

		y = y + 10
		x = x + 50
		wide = wide - 100

		surface.DrawTexturedRect(x, y, wide, wide)
	end

	function SWEP:DrawHUD()

		local x, y = ScrW() / 2, ScrH() / 2

		if ( self.Owner == LocalPlayer() && self.Owner:ShouldDrawLocalPlayer() ) then

			local tr = util.GetPlayerTrace( self.Owner )
			local trace = util.TraceLine( tr )
			
			local coords = trace.HitPos:ToScreen()
			x, y = coords.x, coords.y

		end
		
		local cvar = cvars.Number("q1_crosshair")
		
		if cvar == 1 then
			local scale = math.Round(ScrH() / 320)
			local length = 4 * scale
			local width = 1 * scale
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawRect(x - (width + length) / 2, y - width / 2, width + length, width)
			surface.DrawRect(x - width / 2, y - (width + length) / 2, width, width + length)
		elseif cvar == 2 then
			surface.SetDrawColor( 255, 255, 255, 255 )
			local scale = .2
			local gap = 40 * scale
			local length = gap + 20 * scale
			surface.DrawLine( x - length, y, x - gap, y )
			surface.DrawLine( x + length, y, x + gap, y )
			surface.DrawLine( x, y - length, x, y - gap )
			surface.DrawLine( x, y + length, x, y + gap )
		end
	end

	function SWEP:CalcBob()
		local cl_bob = 0.02
		local cl_bobcycle = 0.6
		local cl_bobup = 0.5
		
		if self.Owner:ShouldDrawLocalPlayer() then return 0 end

		local cltime = CurTime()
		local cycle = cltime - math.floor(cltime/cl_bobcycle)*cl_bobcycle
		cycle = cycle / cl_bobcycle
		if (cycle < cl_bobup) then
			cycle = math.pi * cycle / cl_bobup
		else
			cycle = math.pi + math.pi*(cycle-cl_bobup)/(1.0 - cl_bobup)
		end

		local velocity = self.Owner:GetVelocity()

		local bob = math.sqrt(velocity[1]*velocity[1] + velocity[2]*velocity[2]) * cl_bob
		bob = bob*0.3 + bob*0.7*math.sin(cycle)
		if (bob > 4) then
			bob = 4
		elseif (bob < -7) then
			bob = -7
		end
		
		return bob
	end

	function SWEP:CalcView(ply, pos, ang)
		local calcbob = self:CalcBob()
		if ply:OnGround() and cvars.Bool("q1_viewbob") then
			pos[3] = pos[3] + calcbob
		end
		return pos, ang
	end

	local ct = CurTime()
	local ct1 = CurTime()

	function SWEP:GetViewModelPosition(pos, ang)
		local calcbob = self:CalcBob()
		local vec = Vector(0, 0, 2)
		if self.Owner:OnGround() and cvars.Bool("q1_viewbob") then pos[3] = pos[3] + calcbob end
		if cvars.Number("q1_bobstyle") == 1 then
			pos = pos + ang:Forward() * calcbob * .4 - 1 * ang:Up() + vec
		elseif cvars.Number("q1_bobstyle") == 2 then
			local vel = self.Owner:GetVelocity():Length2D()
		
			local bspeed
			local bob
			local s
			local t
			
			local cl_bobmodel_side = .15
			local cl_bobmodel_up = .06
			local cl_bobmodel_speed = 7
			local cl_viewmodel_scale = 1

			local xyspeed = math.Clamp(vel, 0, 400)

			s = CurTime() * cl_bobmodel_speed
			if self.Owner:IsOnGround() then
				ct = CurTime()
				t = math.min((CurTime() - ct1)*3, 1)
			else
				t = math.max(1 - (CurTime() - ct)*3, 0)
				ct1 = CurTime()
			end

			bspeed = xyspeed * 0.01
			bob = bspeed * cl_bobmodel_side * cl_viewmodel_scale * math.sin (s) * t
			pos = pos + ang:Right() * bob
			bob = bspeed * cl_bobmodel_up * cl_viewmodel_scale * math.cos (s * 2) * t
			pos = pos + ang:Up() * bob
		end

		return pos, ang
	end
end

if CLIENT then return end
function SWEP:NPCShoot_Primary(ShootPos, ShootDir)
	if !IsValid(self.Owner) then return end
	self:PrimaryAttack()
end

AccessorFunc(SWEP, "fNPCMinBurst",		"NPCMinBurst")
AccessorFunc(SWEP, "fNPCMaxBurst",		"NPCMaxBurst")
AccessorFunc(SWEP, "fNPCFireRate",		"NPCFireRate")
AccessorFunc(SWEP, "fNPCMinRestTime",	"NPCMinRest")
AccessorFunc(SWEP, "fNPCMaxRestTime",	"NPCMaxRest")