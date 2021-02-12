ENT.Spawnable = true
ENT.AdminOnly = true

include('shared.lua')

game.AddParticles( "particles/wow_charge.pcf" )

function ENT:Initialize()

	if self:IsValid() == false then return end
	
	self:CreateParticleEffect( "chargedirt", 1, { 0, ent, Vector(0, 0, 50) } )
	self:CreateParticleEffect( "chargetrail", 1, { 0, ent, Vector(0, 0, 50) } )
	self:CreateParticleEffect( "chargetrail2", 1, { 0, ent, Vector(0, 0, 50) } )
	self:CreateParticleEffect( "chargetrail3", 1, { 0, ent, Vector(0, 0, 50) } )
	
end

function ENT:Think()
	if self.Owner:IsValid() == false then return end
	self.Entity:SetPos(self.Owner:GetPos())
end