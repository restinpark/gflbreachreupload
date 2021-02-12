function EFFECT:Init(data)
	local emit = ParticleEmitter(data:GetOrigin())
	local scale = data:GetScale()
	for i=0, 5 do
		local part = emit:Add ("sprites/glow04_noz",data:GetOrigin())
		part:SetVelocity(Vector(0,0,0))
		part:SetDieTime(0.2)
		part:SetStartAlpha(125)
		part:SetStartSize(1)
		part:SetColor(255,215,125) 
		part:SetEndSize(55)
		part:SetRoll(math.Rand(0,360))
	end
	for i=0, 15 do
		local part = emit:Add ("poke/particles/punch",data:GetOrigin()+VectorRand()*math.random(15,25))
		part:SetVelocity(VectorRand()*25)
		part:SetDieTime(0.5)
		part:SetStartAlpha(255)
		part:SetStartSize(math.random(5,15))
		part:SetColor(255,255,255) 
		part:SetEndSize(5)
		part:SetRoll(math.Rand(0,360))
	end
	emit:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end