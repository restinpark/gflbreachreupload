function EFFECT:Init(data)
	local emit = ParticleEmitter(data:GetOrigin())
	local scale = data:GetScale()
	for i=0, 25 do
		local part = emit:Add ("poke/particles/leaf",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),math.random(0,64)))
		part:SetVelocity((VectorRand()*1)*250)
		part:SetDieTime(1)
		part:SetStartAlpha(255)
		part:SetStartSize(0)
		part:SetColor(125,math.random(155,255),125) 
		part:SetEndSize(15)
		part:SetRoll(math.Rand(0,360))
		part:SetAirResistance(150)
		part:SetNextThink( CurTime()+0.01 )
		part:SetThinkFunction( function(pa) 
			local posdiff = (pa:GetPos() - data:GetOrigin()):Angle():Right()
			pa:SetVelocity(posdiff:GetNormal()*300)
			pa:SetNextThink(CurTime()+0.01)
		end)
	end
	for i=0, 5 do
		local part = emit:Add ("sprites/glow04_noz",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),math.random(0,64)))
		part:SetVelocity((VectorRand()*1)*250)
		part:SetDieTime(1)
		part:SetStartAlpha(255)
		part:SetStartSize(0)
		part:SetColor(215,215,215) 
		part:SetEndSize(5)
		part:SetRoll(math.Rand(0,360))
		part:SetAirResistance(150)
		part:SetNextThink( CurTime()+0.01 )
		part:SetThinkFunction( function(pa) 
			local posdiff = (pa:GetPos() - data:GetOrigin()):Angle():Right()
			pa:SetVelocity(posdiff:GetNormal()*300)
			pa:SetNextThink(CurTime()+0.01)
		end)
	end
	for i=0, 5 do
		local part = emit:Add ("poke/particles/vine",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),0))
		part:SetVelocity((VectorRand()*1)*250)
		part:SetDieTime(1)
		part:SetStartAlpha(155)
		part:SetStartSize(15)
		part:SetColor(155,215,55) 
		part:SetEndSize(0)
		part:SetRoll(math.Rand(0,360))
		part:SetAirResistance(55)
		part:SetNextThink( CurTime()+0.01 )
		part:SetThinkFunction( function(pa) 
			local posdiff = (pa:GetPos() - data:GetOrigin()):Angle():Right()
			pa:SetVelocity(posdiff:GetNormal()*300+Vector(0,0,64))
			pa:SetNextThink(CurTime()+0.01)
		end)
	end
	emit:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end