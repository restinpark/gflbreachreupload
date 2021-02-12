if SERVER then
	AddCSLuaFile()
end

if CLIENT then
	language.Add("molotov_ammo", "Molotovs")
end

sound.Add({name = "Weapon_NMRiH_Molotov.Draw", channel = CHAN_ITEM, volume = 0.4, level = 75, sound = {"nmrih/player/weapon_draw_01.wav","nmrih/player/weapon_draw_02.wav","nmrih/player/weapon_draw_03.wav","nmrih/player/weapon_draw_04.wav","nmrih/player/weapon_draw_05.wav"} })
sound.Add({name = "Weapon_NMRiH_Molotov.Shove", channel = CHAN_WEAPON, volume = 0.75, level = 100, pitch = {97,100}, sound = {"nmrih/player/shove_01.wav","nmrih/player/shove_02.wav","nmrih/player/shove_03.wav","nmrih/player/shove_04.wav","nmrih/player/shove_05.wav" } })
sound.Add({name = "Weapon_NMRiH_Molotov.Ignite_Rag", channel = CHAN_WEAPON, volume = 1, level = 75, sound = "nmrih/weapons/firearms/exp_molotov/molotov_rag_ignite_01.wav"})
sound.Add({name = "Weapon_NMRiH_Molotov.Rag_Loop", channel = CHAN_WEAPON, volume = 1, level = 75, sound = "nmrih/weapons/firearms/exp_molotov/molotov_rag_fire_loop_01.wav"})
sound.Add({name = "Weapon_NMRiH_Molotov.Explode", channel = CHAN_WEAPON, volume = 1, level = 75, sound = "nmrih/weapons/firearms/exp_molotov/molotov_explode_01.wav"})
sound.Add({name = "Weapon_NMRiH_Molotov.Fire_Loop", channel = CHAN_WEAPON, volume = 1, level = 75, sound = "nmrih/weapons/firearms/exp_molotov/molotov_fire_loop_01.wav"})
sound.Add({name = "Weapon_NMRiH_Zippo.Open", channel = CHAN_AUTO, volume = 1, level = 75, sound = {"nmrih/weapons/tools/zippo/zippo_open_01.wav","nmrih/weapons/tools/zippo/zippo_open_02.wav" } })
sound.Add({name = "Weapon_NMRiH_Zippo.Close", channel = CHAN_AUTO, volume = 1, level = 75, sound = { "nmrih/weapons/tools/zippo/zippo_close_01.wav", "nmrih/weapons/tools/zippo/zippo_close_02.wav" } })
sound.Add({name = "Weapon_NMRiH_Zippo.Strike_Fail", channel = CHAN_AUTO, volume = 1, level = 75, sound = { "nmrih/weapons/tools/zippo/zippo_strike_fail_01.wav", "nmrih/weapons/tools/zippo/zippo_strike_fail_02.wav", "nmrih/weapons/tools/zippo/zippo_strike_fail_03.wav"} })
sound.Add({name = "Weapon_NMRiH_Zippo.Strike_Success", channel = CHAN_AUTO, volume = 1, level = 75, sound = "nmrih/weapons/tools/zippo/zippo_strike_success_01.wav"})

game.AddParticles("particles/nmrih_explosion_tnt.pcf")
game.AddParticles("particles/nmrih_explosions.pcf")
game.AddParticles("particles/nmrih_gasoline.pcf")

game.AddAmmoType({
	name = "molotov",
	dmgtype = DMG_BURN,
	tracer = TRACER_NONE,
	plydmg = 5,
	npcdmg = 5,
	force = 0,
	minsplash = 10,
	maxsplash = 10,
	maxcarry = 8
})

SWEP.Base				= "weapon_base"

SWEP.PrintName			= "Molotov"	
SWEP.ClassName			= "weapon_nmrih_molotov"			
SWEP.Author				= "Anya O'Quinn"
SWEP.Category			= "Slade Xanthas"
SWEP.Instructions		= "Left click to throw and burn the infidels."
SWEP.Slot = 1
SWEP.SlotPos = 3
SWEP.ItemType = WEAPON_NADE or 10
SWEP.BobScale 			= 0
SWEP.SwayScale 			= 1
		
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.ViewModelFOV		= 50
SWEP.ViewModelFlip		= false

SWEP.HoldType			= "grenade"

SWEP.Spawnable			= true
SWEP.AdminOnly			= false

SWEP.ViewModel			= "models/nmrih/weapons/exp_molotov/v_exp_molotov.mdl"
SWEP.WorldModel			= "models/nmrih/weapons/exp_molotov/w_exp_molotov.mdl"

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Delay				= 0.75

SWEP.Primary.ClipSize			= 1
SWEP.Primary.DefaultClip		= 2
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo				= "molotov"

SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo				= "none"

SWEP.NextThrow = CurTime()
SWEP.NextAnimation = CurTime()
SWEP.Throwing = false
SWEP.StartThrow = false
SWEP.ResetThrow = false
SWEP.ThrowVel = 1000

PrecacheParticleSystem("nmrih_molotov_explosion")

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()

	if game.SinglePlayer() then
		self:CallOnClient("Deploy", "")
	end
	
	self.Idle = true

	self.StartThrow = false
	self.Throwing = false
	self.ResetThrow = false

	if not self.Throwing then
	
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		if IsValid(self.Owner) then
			if IsValid(self.Owner:GetViewModel()) then
				self.Weapon:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())
				self.Weapon:SetNextSecondaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())
				self.NextThrow = CurTime() + self.Owner:GetViewModel():SequenceDuration()
				self.StartIdle = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			end
			
			if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 and self:Clip1() <= 0 then
				self.Owner:RemoveAmmo(1, self.Primary.Ammo)
				self:SetClip1(self:Clip1()+1)
			end
		end
		
	end
	
	return true	
	
end

function SWEP:Holster()

	if game.SinglePlayer() then
		self:CallOnClient("Holster", "")
	end

	self.StartThrow = false
	self.Throwing = false
	self.ResetThrow = false
	
	return true
	
end

function SWEP:OnRemove()
	if game.SinglePlayer() then
		self:CallOnClient("OnRemove", "")
	end
end

function SWEP:OnDrop()
	if game.SinglePlayer() then
		self:CallOnClient("OnDrop", "")
	end
	
	if IsValid(self.Weapon) then
		self.Weapon:Remove()
	end
end

function SWEP:CreateGrenade()

	if IsValid(self.Owner) and IsValid(self.Weapon) then

		if (SERVER) then
		
			local ent = ents.Create("rj_molotov")
			if not ent then return end
			ent.Owner = self.Owner
			ent.Inflictor = self.Weapon
			ent:SetOwner(self.Owner)		
			local eyeang = self.Owner:GetAimVector():Angle()
			local right = eyeang:Right()
			local up = eyeang:Up()
			ent:SetPos(self.Owner:GetShootPos()+right*6+up*-2)
			ent:SetAngles(self.Owner:GetAngles())
			ent:SetPhysicsAttacker(self.Owner)
			ent:Spawn()
				
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:SetVelocity(self.Owner:GetAimVector() * self.ThrowVel + (self.Owner:GetVelocity() * 0.5))
				phys:ApplyForceOffset(ent:GetUp()*math.random(-25,-50),ent:GetPos()+ent:GetRight()*math.random(-5,5))
			end
			local ent2 = self
			timer.Simple(0, function ()
				if ent2 and IsValid(ent2) then
					SafeRemoveEntity(ent2)
				end
			end)
		end
	
	end
	
end

local bobtime = 10
local bobscale = 0.0125
local xoffset = 0
local yoffset = 0

function SWEP:Think()

	
	
end

function SWEP:CanPrimaryAttack()

end

function SWEP:PrimaryAttack()
	self:CreateGrenade(self.Owner, self.Weapon)
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
end

function SWEP:ShouldDropOnDie()
	return false
end

local ENT = {}

ENT.PrintName = "Molotov"
ENT.Type = "anim"  
ENT.Base = "base_anim"

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end

if SERVER then

	function ENT:Initialize()

		self.Hit = false
		self.LastShout = CurTime()
		self.CurrentPitch = 100
		self.SpawnDelay = CurTime() + 0.5

		self:SetModel("models/nmrih/weapons/exp_molotov/w_exp_molotov.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
		
		local phys = self:GetPhysicsObject()  	
		if (phys:IsValid()) then 
			phys:Wake()
			phys:EnableDrag(false)
			phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
			phys:SetBuoyancyRatio(0)
		end
		
		self.Fear = ents.Create("ai_sound")
		self.Fear:SetPos(self:GetPos())
		self.Fear:SetParent(self)
		self.Fear:SetKeyValue("SoundType", "8|1")
		self.Fear:SetKeyValue("Volume", "500")
		self.Fear:SetKeyValue("Duration", "1")
		self.Fear:Spawn()
		
		self.BurnSound = CreateSound(self, "Weapon_NMRiH_Molotov.Rag_Loop")
		self.BurnSound:Play()
		
		self:Fire("kill", 1, 10)

	end
	
	function ENT:Think()
	
		if self.LastShout < CurTime() then
			if IsValid(self.Fear) then
				self.Fear:Fire("EmitAISound")
			end
			self.LastShout = CurTime() + 0.25
		end
	
		if self.HitData and not hull then
		
			if self.Dud then 
				self:NextThink(CurTime() + 300)
				self:Remove()
				return false
			end
		
			local hull = ents.Create("rj_molotov_hull")
			if !hull then return end
			hull:SetPos(self.HitData.HitPos + self.HitData.HitNormal * 40)
			hull:SetAngles(self.HitData.HitNormal:Angle() + Angle(90,0,0))
			hull:SetOwner(self.Owner)
			hull.Owner = self.Owner
			hull.Inflictor = self.Weapon
			hull:Spawn()

			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			self:SetMoveType(MOVETYPE_NONE)
			self:Remove()

		end
		
		self:NextThink(CurTime())
		
	end
	
	function ENT:OnRemove()
		if self.BurnSound then self.BurnSound:Stop() end
		if IsValid(self.Fear) then self.Fear:Fire("kill") end
	end
	
	function ENT:PhysicsCollide(data,phys)	
		if self:IsValid() and not self.Hit then
		
			self:SetNoDraw(true)
			
			local trdata = {}
			trdata.start = data.HitPos
			trdata.endpos = data.HitPos + data.HitNormal
			local tr = util.TraceLine(trdata)
			
			if tr.Hit then		
			
				self.HitData = tr
				self.Hit = true
				
				if self:WaterLevel() > 0 then 
					self.Dud = true 
					self:EmitSound("physics/glass/glass_bottle_break"..math.random(1,2)..".wav",90,100)
					return false 
				end
				
				if IsValid(self.Owner) then
					util.BlastDamage(self, self.Owner, self:GetPos(), 200, 40) 
				else
					util.BlastDamage(self, self, self:GetPos(), 200, 40) 
				end
				
				ParticleEffect("nmrih_molotov_explosion",tr.HitPos,tr.HitNormal:Angle() + Angle(90,0,0))
				self:EmitSound("Weapon_NMRiH_Molotov.Explode")
				
			end
			
		end	
	end
	
end

scripted_ents.Register(ENT, "rj_molotov", true)

local HULL = {}

HULL.PrintName = "Molotov Point Hurt"
HULL.Type = "anim"
HULL.Base = "base_anim"

if SERVER then

	function HULL:Initialize()
	
		self:SetModel("models/hunter/blocks/cube4x4x2.mdl")
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		self:SetNoDraw(true)
		self:SetTrigger(true)
		self.NextHurt = CurTime()
		self:Fire("kill",1,20)

		self.BurnSound = CreateSound(self, "ambient/fire/fire_small_loop1.wav")
		self.BurnSound:PlayEx(1,98)
		self.BurnSound:SetSoundLevel(80)
		
	end
	
	function HULL:Touch(victim)
	
		if self.NextHurt < CurTime() then
	
			local attacker = self:GetOwner() or self.Owner or self
			local inflictor = self.Inflictor or self
			if !IsValid(attacker) then return end
			
			local dmg = DamageInfo()
			dmg:SetDamage(5)
			dmg:SetDamageType(DMG_SHOCK)
			dmg:SetDamagePosition(self:GetPos())
			dmg:SetDamageForce(Vector(0,0,0))
			dmg:SetAttacker(attacker)
			dmg:SetInflictor(inflictor)
			
			if IsValid(victim) then
				victim:TakeDamageInfo(dmg)
				victim:Ignite(1,10)
			end
			
			self.NextHurt = CurTime() + 0.25
		
		end	
		
	end
	
	function HULL:Think()
		self:NextThink(CurTime())
	end
	
	function HULL:OnRemove()
		if self.BurnSound then self.BurnSound:Stop() end
	end

end

scripted_ents.Register(HULL, "rj_molotov_hull", true)