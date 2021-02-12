function EFFECT:Init(data)
	local emit = ParticleEmitter(data:GetOrigin())
	local scale = data:GetScale()
	for i=0, 5 do
		local part = emit:Add ("sprites/glow04_noz",data:GetOrigin())
		part:SetVelocity(VectorRand()*scale*5)
		part:SetDieTime(0.7)
		part:SetStartSize(1)
		part:SetStartAlpha(215)
		part:SetColor(175,215,255) 
		part:SetEndSize(scale/4)
		part:SetRoll(math.Rand(0,360))
		part:SetAirResistance(5)
		part:SetGravity(Vector(0,0,-225))
	end
	for i=0, 1 do
		local part = emit:Add ("poke/particles/bubblepop",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),8))
		part:SetVelocity(Vector(0,0,0))
		part:SetDieTime(0.15)
		part:SetStartAlpha(255)
		part:SetStartSize(math.random(1,2))
		part:SetColor(255,255,255) 
		part:SetEndSize(scale*2)
	end
	for i=0, 3 do
		local part = emit:Add ("poke/particles/bubblespray",data:GetOrigin()+Vector(math.random(-scale,scale),math.random(-scale,scale),8))
		part:SetVelocity(VectorRand()*(scale/2)+Vector(0,0,math.random(scale,scale*2)))
		part:SetDieTime(0.5)
		part:SetStartAlpha(115)
		part:SetStartSize(math.random(5,15))
		part:SetColor(235,245,255) 
		part:SetEndSize(scale*2)
		part:SetGravity(Vector(0,0,-60))
		part:SetRoll(math.Rand(0,360))
	end
	emit:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end