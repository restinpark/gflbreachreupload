AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel("models/Gibs/HGIBS.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
end

function ENT:Pop()
	print(self.PopScale)
	print(self.PopEffect)
	local fx = EffectData()
	fx:SetOrigin(self:GetOwner():GetPos())
	fx:SetScale(self.PopScale)
	util.Effect(self.PopEffect,fx)
end

function ENT:OnRemove()
	if IsValid(self:GetOwner()) then
		self:Pop()
	end
end

function ENT:Think()
	local owner = self:GetOwner()
	if !IsValid(owner) then
		self:Remove()
	else
		self:SetPos(owner:GetPos())
	end
	return false
end