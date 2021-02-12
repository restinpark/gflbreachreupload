AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.RespTime = 30

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create(self.EntName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self:SetModel(self.model)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetAngles(Angle(0,90,0))
	self:DrawShadow(true)
	self.Available = true
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetTrigger(true)
	self:UseTriggerBounds(true, 20)
end

function ENT:Think()
	if self.ReEnabled and CurTime() >= self.ReEnabled then
		self.ReEnabled = nil
		self.Available = true
		self:SetNoDraw(false)
		self:EmitSound("items/q1/itembk2.wav")
	end
end

function ENT:Touch(ent)
	if IsValid(ent) and ent:IsPlayer() and ent:Alive() and self.Available and ent:Health() < self.MaxHealth then
		self.Available = false
		self:SetNoDraw(true)
		if game.SinglePlayer() then
			self:Remove()
		else
			self.ReEnabled = CurTime() + self.RespTime
		end
		ent:EmitSound(self.Hsound, 85, math.random(99,101))
		ent:SetHealth(math.min(ent:Health() + self.Hamount, self.MaxHealth))
	end
end