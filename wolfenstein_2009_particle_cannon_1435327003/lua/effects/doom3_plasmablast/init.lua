function EFFECT:Init(data)
	local Pos = data:GetOrigin()
	
	local emitter = ParticleEmitter(Pos)
	
	for i = 1,1 do		 
		local particle = emitter:Add("sprites/doom3/plasmablast", Pos)
			particle:SetVelocity(Vector(0,0,0))
			particle:SetAirResistance(400)
			particle:SetGravity(Vector(0, 0, 100))
			particle:SetDieTime(1)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(16)
			particle:SetEndSize(32)
			particle:SetRoll(math.Rand(-90, 90))
			particle:SetRollDelta(math.Rand(-0.05, 0.05))
			particle:SetColor(120, 200, 255)
	end
	emitter:Finish()		
end

function EFFECT:Think()		
	return false
end

function EFFECT:Render()
	return false
end