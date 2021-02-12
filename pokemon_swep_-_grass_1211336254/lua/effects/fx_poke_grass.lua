function EFFECT:Init(data)
	local emit = ParticleEmitter(data:GetOrigin())
	local scale = data:GetScale()
	for i=0, 3 do
		local splitpos = data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),0)
		for i=0, 25 do
			local part = emit:Add ("sprites/glow04_noz",splitpos)
			part:SetVelocity(Vector(0,0,math.random(20,scale*5)))
			part:SetDieTime(0.4)
			part:SetStartSize(1)
			part:SetStartAlpha(55)
			part:SetColor(155,255,115) 
			part:SetEndSize(15)
			part:SetRoll(math.Rand(0,360))
			part:SetAirResistance(100)
			part:SetGravity(Vector(0,0,-60))
		end
	end
	for i=0, 15 do
		local part = emit:Add ("poke/particles/vine",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),8))
		part:SetVelocity(Vector(0,0,0))
		part:SetDieTime(0.3)
		part:SetStartAlpha(215)
		part:SetStartSize(math.random(1,2))
		part:SetColor(155,215,55) 
		part:SetEndSize(25)
	end
	for i=0, 35 do
		local part = emit:Add ("poke/particles/leaf",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),8))
		part:SetVelocity(VectorRand()*(scale/2)+Vector(0,0,math.random(scale,scale*2)))
		part:SetDieTime(1)
		part:SetStartAlpha(175)
		part:SetStartSize(math.random(5,15))
		part:SetColor(155,215,125) 
		part:SetEndSize(25)
		part:SetRoll(math.Rand(0,360))
		part:SetGravity(Vector(0,0,-55))
	end
	emit:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end