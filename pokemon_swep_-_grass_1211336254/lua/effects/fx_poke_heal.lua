function EFFECT:Init(data)
	local emit = ParticleEmitter(data:GetOrigin())
	local scale = data:GetScale()
	for i=0, 75 do
		local part = emit:Add ("poke/particles/sparkle",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),0))
		part:SetVelocity(Vector(0,0,math.random(2,15)))
		part:SetDieTime(1)
		part:SetStartAlpha(175)
		part:SetRoll(math.random(0,360))
		part:SetStartSize(3)
		part:SetEndSize(3)
		part:SetColor(155,255,55) 
	end
	emit:Finish()

	self.dir = math.random(-1,1)
	self.pos = data:GetOrigin()
	self.scale = scale/2
	self.build = 1
	self.a = 115
end

function EFFECT:Think()
	self.a = self.a - (FrameTime()*100)
	self.build = self.build + (self.scale/(FrameTime()*50))
	if self.a < 1 then
		return false
	end
	return true
end

function EFFECT:Render()
	render.SetMaterial(Material("particle/particle_ring_wave_additive"))
	render.DrawQuadEasy( self.pos, Vector( 0, 0, 1 ), self.build, self.build, Color( 175, 255, 95, math.Clamp(self.a-25,1,255) ), ( CurTime() * (self.dir*50) ) % 360 )
end