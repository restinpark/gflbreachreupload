AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = Model("models/items/quake1/spike.mdl")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetMoveType(MOVETYPE_FLY)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionBounds(Vector(), Vector())
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
end

function ENT:SetDamage(dmg)
	self.Damage = dmg
end

function ENT:Touch(ent)
	if !ent:IsSolid() then return end

	if self.didHit then return end
	self.didHit = true
	
	local tr = self:GetTouchTrace()

	ent:TakeDamage(self.Damage, self:GetOwner())
	if !(ent:IsNPC() or ent:IsPlayer()) then
		if math.random(1, 2) == 1 then self:EmitSound("weapons/q1/ric"..math.random(1,3)..".wav") end
		self:EmitSound("weapons/q1/tink1.wav", 80, 100)
	end
	
	self:ImpactEffect(tr)
	self:Remove()
end