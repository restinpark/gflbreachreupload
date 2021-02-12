AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * self.SpawnPos
	local ent = ents.Create(self.ClassName)
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
	
	if game.GetAmmoID(self.AmmoType) == -1 then
		PrintMessage(HUD_PRINTTALK, "Unable to register "..self.AmmoType.." ammo type! Expect issues!")
		self.AmmoType = self.AmmoTypeFallback
	end
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
	if IsValid(ent) and ent:IsPlayer() and ent:Alive() and self.Available then
		local ammoCount = ent:GetAmmoCount(self.AmmoType)
		if ammoCount >= self.MaxAmmo then return end
		self.Available = false
		self:SetNoDraw(true)
		if game.SinglePlayer() then
			self:Remove()
		else
			self.ReEnabled = CurTime() + 30
		end
		ent:EmitSound("weapons/q1/am_pkup.wav", 85, math.random(95,105))
		if ammoCount < self.MaxAmmo then
			ent:SetAmmo(math.min(ammoCount + self.AmmoAmount, self.MaxAmmo), self.AmmoType)
		end
	end
end