AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = Model("models/items/quake1/grenade.mdl")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_BBOX)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:AddAngleVelocity(Vector(300,300,300))
	end
end

function ENT:SetExplodeDelay(flDelay)
	self.delayExplode = CurTime() +flDelay
end

function ENT:SetDamage(dmg, rad)
	self.Damage = dmg
	self.Radius = rad
end

function ENT:PhysicsCollide(data,phys)
	self:EmitSound("weapons/q1/bounce.wav")
	
	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)
end

function ENT:Think()
	if !self.delayExplode || CurTime() < self.delayExplode then return end
	self.delayExplode = nil
	self:Explode()
end

function ENT:Explode(pos)
	pos = pos or self:GetPos()
	util.BlastDamage( self, self:GetOwner(), pos, self.Radius, self.Damage )
	self:EmitSound("weapons/q1/r_exp3.wav", 100, 100)
	self:Remove()	
	
	local spos = self:GetPos()
	local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-32), filter=self})
	util.Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      
end

function ENT:StartTouch( ent )
	if ( ent:IsValid() and ent:Team() == TEAM_SCP and ent:IsPlayer() or ent:IsNPC() ) then
 		self:Explode(ent:GetPos())
	end
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end