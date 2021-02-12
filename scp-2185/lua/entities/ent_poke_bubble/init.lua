AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel("models/Gibs/HGIBS.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetColor(Color(255,255,255,0))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetGravity(0)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)

	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )

	self:SetNWString("sprite","poke/particles/bubble")

	if SERVER then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
			phys:EnableGravity(false)
		end
	end

	-- failsafe
	timer.Simple(120,function()
		if IsValid(self) then
			self:Remove()
		end
	end)

	self.dmglow = 2
	self.dmghigh = 3
	self.dmgforce = 5
	self.dmgradius = 55
	self.drunken = false
	self.PopSound = "ambient/water/water_splash3.wav"
	self.Effect = "fx_poke_bubblepop"
end

function ENT:SetStats(dmglow,dmghigh,dmgforce,dmgradius,drunken)
	self.dmglow = dmglow
	self.dmghigh = dmghigh
	self.dmgforce = dmgforce
	self.dmgradius = dmgradius
	self.drunken = drunken
end

function ENT:DeathTimer(time)
	timer.Simple(time,function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end

function ENT:Think()
	if self.drunken == true then
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:AddVelocity(VectorRand()*25)
		end
	end
	return false
end

function ENT:Explode()
	for _, v in ipairs(ents.FindInSphere(self:GetPos(),self.dmgradius)) do
		if v != self:GetOwner() then
			local dmginfo = DamageInfo()
			dmginfo:SetAttacker(self:GetOwner())
			dmginfo:SetInflictor(self)
			dmginfo:SetDamage(math.random(self.dmglow,self.dmghigh))
			v:TakeDamageInfo(dmginfo)
			local diff = (self:GetPos()-v:GetPos())+Vector(0,0,-32)
			v:SetVelocity(Vector(0,0,self.dmgforce/2))
			v:SetVelocity(-diff*2)
		end
	end

	sound.Play(self.PopSound,self:GetPos())

	timer.Simple(0.1,function() if IsValid(self) then self:Remove() end end)
end

function ENT:PhysicsCollide(data,phys)
	self:Explode()
end

function ENT:OnRemove()
	local fx = EffectData()
	fx:SetOrigin(self:GetPos())
	fx:SetScale(self.dmgradius)
	util.Effect(self.Effect,fx)
end