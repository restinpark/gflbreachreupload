function EFFECT:Init(data)
	local emit = ParticleEmitter(data:GetOrigin())
	local dir = data:GetOrigin()+(data:GetAngles():Forward()*data:GetRadius())
	local scale = data:GetScale()
	for i=0, 7 do
		local part = emit:Add ("sprites/glow04_noz",data:GetOrigin()+(VectorRand()*(scale/4)))
		part:SetVelocity(data:GetAngles():Forward()*data:GetRadius()*2+VectorRand()*155)
		part:SetDieTime(.4)
		part:SetStartSize(1)
		part:SetStartAlpha(215)
		part:SetColor(155,215,255) 
		part:SetEndSize(scale*3)
		part:SetRoll(math.Rand(0,360))
		part:SetAirResistance(2)
		part:SetCollide(true)
		part:SetBounce(0.2)
	end
	for i=0, 3 do
		local part = emit:Add ("poke/particles/bubblespray",data:GetOrigin()+(VectorRand()*2))
		part:SetVelocity(data:GetAngles():Forward()*data:GetRadius()*2)
		part:SetDieTime(.4)
		part:SetStartAlpha(215)
		part:SetStartSize(math.random(5,15))
		part:SetColor(235,245,255) 
		part:SetEndSize(scale*3)
		part:SetRoll(math.Rand(0,360))
		part:SetCollide(true)
		part:SetBounce(0.2)
	end
	emit:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end