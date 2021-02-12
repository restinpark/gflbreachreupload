include('shared.lua')

function ENT:Initialize()
	self.Start = self:GetPos() + self:GetAngles():Up() * 5
end

function ENT:Draw()
	self.Entity:DrawModel()
	render.SetMaterial(Material("effects/laser_citadel1"))
	render.DrawBeam(self.Start, self.Start + -self:GetAngles():Forward() * 400000000, 10, 0, 2, self:GetColor())
end

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:Think()
end