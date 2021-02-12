AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
ENT.IdleDrag = 0.25
ENT.MaxSpeed = 180
ENT.HoverSpeed = 40
ENT.HoverHeight = 92
ENT.HoverForce = 128
ENT.TurnSpeed = 55
ENT.Acceleration = 170
function ENT:SetOwner(ply)
    if IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP160 then
        self:SetNWEntity("owner", ply)
        self:SetMaxHealth(ply:GetMaxHealth())
        self:SetHealth(ply:Health())
    end
end

--Includes bits of code from ZS
function ENT:Initialize()
    self:SetModel("models/combine_scanner.mdl")

	self:PhysicsInitBox(Vector(-30, -17, -14.15), Vector(18.29, 11.86, 15))
	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMaterial("metal")
		phys:SetMass(75)
		phys:EnableDrag(false)
		phys:EnableMotion(true)
		phys:Wake()
		phys:SetBuoyancyRatio(0.8)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)

		local Constraint = ents.Create("phys_keepupright")
		Constraint:SetAngles(Angle(0, 0, 0))
		Constraint:SetKeyValue("angularlimit", 2)
		Constraint:SetPhysConstraintObjects(phys, phys)
		Constraint:Spawn()
		Constraint:Activate()
		self:DeleteOnRemove(Constraint)
	end

	self:StartMotionController()

    self:SetMaxHealth(1000)
    self:SetHealth(1000)

	self.LastThink = CurTime()

	self:SetSequence(2)
	self:SetPlaybackRate(1)
	self:UseClientSideAnimation(true)
	self:SetCustomCollisionCheck(true)
	self:CollisionRulesChanged()

	hook.Add("SetupPlayerVisibility", self, self.SetupPlayerVisibility)
end

function ENT:SetupPlayerVisibility(pl)
    if pl == self:GetOwner() then
	    AddOriginToPVS(self:GetPos())
        AddOriginToPVS(self:GetPos() + pl:GetAimVector() * 1024)
    end
end

function ENT:OnTakeDamage(dmginfo)
	if dmginfo:GetDamage() <= 0 then return end

	local attacker = dmginfo:GetAttacker()
	if IsValid(attacker) and attacker:IsPlayer() and attacker:Team() == TEAM_SCP then return end

	local owner = self:GetOwner()
	if owner and IsValid(owner) then
		owner:TakeDamage(dmginfo:GetDamage(), dmginfo:GetAttacker(), dmginfo:GetInflictor())
	end

	self:EmitSound("npc/scanner/scanner_pain"..math.random(2)..".wav", 65, math.Rand(120, 130))

	local effectdata = EffectData()
		effectdata:SetOrigin(self:NearestPoint(dmginfo:GetDamagePosition()))
		effectdata:SetNormal(VectorRand():GetNormalized())
		effectdata:SetMagnitude(4)
		effectdata:SetScale(1.33)
	util.Effect("sparks", effectdata)
	return
end

function ENT:PhysicsCollide(data, phys)
	self.HitData = data
	self:NextThink(CurTime())
end

function ENT:Think()
    if self.HitData then
        local ent = self.HitData.HitEntity
        if ent and IsValid(ent) and (not ent.HitImmunity or ent.HitImmunity < CurTime()) then
            if ent:IsPlayer() and ent:Team() ~= TEAM_SCP and ent:Team() ~= TEAM_SPEC then
                ent:TakeDamage(35, self:GetOwner(), self)
                ent:SetBleeding(true)
            elseif BREACH_IsGateDoor(ent) then
                ent:TakeDamage(math.random(20, 100), self:GetOwner(), self)
            elseif ent:GetClass() == "func_breakable" then
                ent:TakeDamage(100, self:GetOwner(), self)
            end
            ent.HitImmunity = CurTime() + 0.33
        end
    end
    return true
end

local meta = FindMetaTable("Player")
function meta:SyncAngles()
	local ang = self:EyeAngles()
	ang.pitch = 0
	ang.roll = 0
	return ang
end

local function ShouldUse(ent, owner)

	local pos = ent:GetPos()

	local f_btn = {}

	for k,v in pairs(MAPBUTTONS) do
		if v.pos == pos then
			f_btn = v
			break
		end
	end

	if f_btn ~= {} then
		if f_btn.clevel and f_btn.clevel > 2 then
			return false
		elseif f_btn.isscpdoor and preparing then
			return false
		elseif f_btn.canactivate then
			return f_btn.canactivate(owner, ent) == true
		end
	end

	return true
end

function ENT:PhysicsSimulate(phys, frametime)
    phys:Wake()
    
    if self.Destroyed then return end

	local owner = self:GetOwner()
	if not owner:IsValid() then return SIM_NOTHING end

	if owner and IsValid(owner) and not self.Destroyed then
		if owner:Health() <= 0 then
			self:Destroy()
			return SIM_NOTHING
		elseif owner:GetNClass() ~= ROLE_SCP160 then
			self:Destroy()
			return SIM_NOTHING
		elseif not owner:Alive() then
			self:Destroy()
			return SIM_NOTHING
		end
	elseif (not owner or not IsValid(owner)) and not self.Destroyed then
		self:Destroy()
		return SIM_NOTHING
	end

	local vel = phys:GetVelocity()
	local movedir = Vector(0, 0, 0)
	local eyeangles = owner:SyncAngles()
	local aimangles = owner:EyeAngles()

		if owner:KeyDown(IN_FORWARD) then
			movedir = movedir + aimangles:Forward()
		end
		if owner:KeyDown(IN_BACK) then
			movedir = movedir - aimangles:Forward()
		end
		if owner:KeyDown(IN_MOVERIGHT) then
			movedir = movedir + aimangles:Right()
		end
		if owner:KeyDown(IN_MOVELEFT) then
			movedir = movedir - aimangles:Right()
		end
		if owner:KeyDown(IN_BULLRUSH) then
			movedir = movedir + Vector(0, 0, 0.5)
		end
		if owner:KeyDown(IN_GRENADE1) then
			movedir = movedir - Vector(0, 0, 0.5)
		end
		if owner:KeyDown(IN_USE) then
			if not owner.LastUseCheck then
				owner.LastUseCheck = 0
			end

			if owner.LastUseCheck + 1 > CurTime() then return end
			owner.LastUseCheck = CurTime()

			local t = util.TraceHull({
				start = self:GetPos(),
				endpos = self:GetPos() + (self:GetAngles():Forward() * 200),
				maxs = Vector(50, 50, 50),
				mins = Vector(-50, -50, -50),
				filter = function (e)
					return e:GetClass() == "func_button"
				end,
				ignoreworld = true
			})

			--print("t")
			--PrintTable(t)

			if t and t.Entity and IsValid(t.Entity) then
				if t.Entity:IsPlayer() then
					--Do nothing atm
				elseif t.Entity:GetClass() == "func_button" then
					--print("hit")
					--Search for the button in the map table
					local douse = ShouldUse(t.Entity, owner)
					if douse then
						t.Entity:Fire("use")
					end
				end
			end
		end
		local angdiff = math.AngleDifference(eyeangles.yaw, phys:GetAngles().yaw)
		if math.abs(angdiff) > 4 then
			phys:AddAngleVelocity(Vector(0, 0, math.Clamp(angdiff, -64, 64) * frametime * 100 - phys:GetAngleVelocity().z * 0.95))
		end

		local cang = self:GetAngles()
		self:SetAngles(Angle(cang.pitch, owner:EyeAngles().yaw, cang.roll))

	if movedir == vector_origin then
		vel = vel * (1 - frametime * self.IdleDrag)
	else
		movedir:Normalize()

		vel = vel + frametime * self.Acceleration * math.Clamp((self:Health() / self:GetMaxHealth() + 1) / 2, 0.5, 1) * movedir
	end

	if vel:Length() > self.MaxSpeed then
		vel:Normalize()
		vel = vel * self.MaxSpeed
	end

	if movedir == vector_origin and vel:Length() <= self.HoverSpeed then
		local trace = {mask = MASK_HOVER, filter = self}
		trace.start = self:GetPos()
		trace.endpos = trace.start + Vector(0, 0, self.HoverHeight * -2)
		local tr = util.TraceLine(trace)

		local hoverdir = (trace.start - tr.HitPos):GetNormalized()
		local hoverfrac = (0.5 - tr.Fraction) * 2
		vel = vel + frametime * hoverfrac * self.HoverForce * hoverdir
	end

	phys:EnableGravity(false)
	phys:SetAngleDragCoefficient(20000)
	phys:SetVelocityInstantaneous(vel)

	self:SetPhysicsAttacker(owner)

	return SIM_NOTHING
end

function ENT:Destroy()
	if self.Destroyed then return end
	self.Destroyed = true

	local pos = self:LocalToWorld(self:OBBCenter())

	self:EmitSound("npc/scanner/scanner_explode_crash2.wav")

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetNormal(Vector(0, 0, 1))
		effectdata:SetMagnitude(5)
		effectdata:SetScale(1.5)
	util.Effect("sparks", effectdata)

    util.Effect("HelicopterMegaBomb", effectdata, true, true)
    
    SafeRemoveEntityDelayed(self, 0.5)
end