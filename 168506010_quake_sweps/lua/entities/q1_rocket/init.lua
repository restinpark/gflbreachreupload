AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = Model("models/items/quake1/missile.mdl")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetMoveType(MOVETYPE_FLY)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionBounds(Vector(), Vector())
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
end

function ENT:SetDamage(dmg, rad)
	self.Damage = dmg
	self.Radius = rad
end

function ENT:Touch(ent)
	if !ent:IsSolid() then return end

	if self.didHit then return end
	self.didHit = true
	
	local tr = self:GetTouchTrace()
	
	local start = tr.HitPos - tr.HitNormal
    local endpos = tr.HitPos + tr.HitNormal	
	if tr.HitWorld then
		util.Decal("Scorch", start, endpos)
	end

	local effectdata = EffectData()
	effectdata:SetOrigin(endpos)
	effectdata:SetNormal(tr.HitNormal)
	util.Effect("q1_exp", effectdata)

	local owner = IsValid(self.Owner) and self.Owner or self
	local dmg = DamageInfo()
	dmg:SetInflictor(self)
	dmg:SetAttacker(owner)
	dmg:SetDamage(self.Damage)
	dmg:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
	util.BlastDamageInfo(dmg, tr.HitPos, self.Radius)
	
	self:EmitSound("weapons/q1/r_exp3.wav", 100, math.random(95,105))
	self:Remove()
end