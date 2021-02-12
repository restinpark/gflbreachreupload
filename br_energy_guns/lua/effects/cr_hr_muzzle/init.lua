/*---------------------------------------------------------
	EFFECT:Init(data)
---------------------------------------------------------*/
function EFFECT:Init(data)

	self.WeaponEnt 		= data:GetEntity()
	self.Attachment 		= data:GetAttachment()
	
	self.Position 		= self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.Forward 		= data:GetNormal()
	self.Angle 			= self.Forward:Angle()
	self.Right 			= self.Angle:Right()
	self.Up 			= self.Angle:Up()
	
//	local AddVel 		= self.WeaponEnt:GetOwner():GetVelocity()
	
	local emitter 		= ParticleEmitter(self.Position)
		if math.random(1, 2) == 1 then
			local particle = emitter:Add("effects/concussion_muzzle_hr"..math.random(1, 4), self.Position + 8 * self.Forward)
				if not IsValid(data:GetEntity()) or not IsValid(self.WeaponEnt:GetOwner()) then return end
				particle:SetVelocity(0 * self.Forward + 1.1 * self.WeaponEnt:GetOwner():GetVelocity())
				particle:SetAirResistance(0)
				particle:SetDieTime(0)
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(0)
				particle:SetEndSize(0)
				particle:SetRoll(math.Rand(0, 0))
				particle:SetRollDelta(math.Rand(0, 0))
				particle:SetColor(255, 157, 240)
				particle:SetCollide(false)				
			end
			
		local particle = emitter:Add("effects/concussion_muzzle_hr", self.Position + 8 * self.Forward)
			if not IsValid(data:GetEntity()) or not IsValid(self.WeaponEnt:GetOwner()) then return end
			particle:SetVelocity(0 * self.Forward + 8 * VectorRand()) // + AddVel)
			particle:SetAirResistance(0)
			particle:SetGravity(Vector(0, 0, math.Rand(250, 100)))
			particle:SetDieTime(math.Rand(0.1, 0.1))
			particle:SetStartAlpha(math.Rand(245, 255))
			particle:SetEndAlpha(0)
			particle:SetStartSize(math.Rand(50, 50))
			particle:SetEndSize(math.Rand(15, 20))
			particle:SetRoll(math.Rand(-25, 25))
			particle:SetRollDelta(math.Rand(-0.05, 0.05))
			particle:SetColor(255, 157, 240)
			particle:SetCollide(false)
			
				local particle = emitter:Add("effects/concussion_muzzle_hr", self.Position - 8 * self.Forward)
			if not IsValid(data:GetEntity()) or not IsValid(self.WeaponEnt:GetOwner()) then return end
			particle:SetVelocity(0 * self.Forward + 8 * VectorRand()) // + AddVel)
			particle:SetAirResistance(0)
			particle:SetGravity(Vector(0, 0, math.Rand(250, 100)))
			particle:SetDieTime(math.Rand(0.1, 0.1))
			particle:SetStartAlpha(math.Rand(245, 255))
			particle:SetEndAlpha(0)
			particle:SetStartSize(math.Rand(50, 50))
			particle:SetEndSize(math.Rand(15, 20))
			particle:SetRoll(math.Rand(-25, 25))
			particle:SetRollDelta(math.Rand(-0.05, 0.05))
			particle:SetColor(255, 157, 240)
			particle:SetCollide(false)
	emitter:Finish()
end

/*---------------------------------------------------------
	EFFECT:Think()
---------------------------------------------------------*/
function EFFECT:Think()

	return false
end

/*---------------------------------------------------------
	EFFECT:Render()
---------------------------------------------------------*/
function EFFECT:Render()
end