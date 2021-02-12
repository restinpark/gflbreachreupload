function EFFECT:Init( data )
	if data:GetEntity():IsValid() then
		self.HitAngle = data:GetEntity():GetAngles()
		self.ForwardAng = self.HitAngle:Forward()
		self.EndPos = data:GetOrigin() + ( self.ForwardAng*-20 )
		self.Mag = data:GetEntity():GetColor()
		self.Scale = data:GetScale()/6
		local tex = math.random(1, 2)
		self.Mat1 = Material( "effects/fleck_tile"..tex )
	end
end

function EFFECT:Render()	
	if GetConVar("cl_isaac_expensiveeffects"):GetBool() and self.ForwardAng then
		local emitter = ParticleEmitter( self.EndPos, true )

		local particle = emitter:Add( self.Mat1, self.EndPos )
		
		if (particle) then
			particle:SetLifeTime(1) 
			particle:SetDieTime(6) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(6*self.Scale) 
			particle:SetEndSize(2*self.Scale)
			particle:SetAngles( Angle(math.random( 0, 360 ),math.random( 0, 360 ),math.random( 0, 360 )) )
			particle:SetAngleVelocity( Angle(math.random( 0, 1 ),math.random( 0, 1 ),math.random( 0, 1 )) ) 
			particle:SetRoll(math.random( 0, 360 ))
			particle:SetColor(math.random(self.Mag["r"]/1.05,self.Mag["r"]),math.random(self.Mag["g"]/1.05,self.Mag["g"]),math.random(self.Mag["b"]/1.05,self.Mag["b"]),math.random(255,255))
			particle:SetGravity( Vector(0, 0, -200 ) ) 
			particle:SetVelocity( (VectorRand()*120)+(self.ForwardAng*-300) ) 
			particle:SetAirResistance(20)  
			particle:SetCollide(true)
			particle:SetBounce(0)
		end

		emitter:Finish()
	end
end