EFFECT.mat = Material("sprites/q1lightning")

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Position = data:GetOrigin()
	self.DieTime = .125
	
	local pos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self:SetRenderBoundsWS(pos, self.Position)
end

function EFFECT:Think()
	self.DieTime = self.DieTime - FrameTime()
	return self.DieTime > 0
end

function EFFECT:Render()
	local pos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	local rot = CurTime() * 2

	render.SetMaterial(self.mat)
	render.DrawBeam(pos, self.Position, 15, rot, rot -1, Color(255, 255, 255, 255))
	render.DrawBeam(pos, self.Position, 25, rot, rot -2, Color(255, 255, 255, 255))
end