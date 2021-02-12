function EFFECT:Init(data)		
	local Startpos = data:GetOrigin()
		
	self.Emitter = ParticleEmitter(Startpos)
	
	for i = 1, 50 do
	
		local p = self.Emitter:Add("particles/flamelet" .. math.random(1, 5), Startpos)
		
		p:SetDieTime(math.Rand(0.5, 2))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(math.Rand(10, 20))
		p:SetEndSize(10)
		p:SetRoll(math.random(-6, 6))
		p:SetRollDelta(math.random(-6, 6))	
		p:SetVelocity(VectorRand():GetNormal() * 50)
		p:SetCollide(true)
		p:SetGravity(Vector(0, 0, -150))
		p:SetColor(0, 200, 255)
	end

	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end