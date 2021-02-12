EFFECT.Mat1 = Material( "effects/blood2" )
EFFECT.Mat2 = Material( "isaactears/effects/beam" )
EFFECT.Mat3 = Material( "isaactears/effects/ball" )

function EFFECT:Init( data )
	self.EndPos = data:GetOrigin()-Vector(0,0,20)
	self.Scale = data:GetScale()
	self.Life = 0
	self.Mag = data:GetEntity():GetColor()
	self.Ent = data:GetEntity()
	self.MaxLife = data:GetMagnitude()*6
end

function EFFECT:Think()
	self.Life = self.Life + FrameTime() * 6
	return ( self.Life < self.MaxLife )
end


function EFFECT:Render()	
	render.SetMaterial( self.Mat2 )
	for i = 1, 3 do
		render.DrawSphere( 
			self.EndPos,
			self.Scale - (self.Scale*(math.Clamp(self.Life,0,5))),
			50, 
			50,
			self.Mag,
			true 
		)
	end
	render.SetMaterial( self.Mat3 )
	render.DrawSphere( 
		self.EndPos,
		self.Scale*(math.Clamp(self.Life,0,5)),
		50,
		50,
		self.Mag
	)

	if GetConVar("cl_isaac_expensiveeffects"):GetBool() then
		local emitter = ParticleEmitter( self.EndPos, false )

		local particle = emitter:Add( self.Mat1, self.EndPos + Vector( math.random(-32,32),math.random(-32,32),math.random(-64,32) ) ) 
		
		if (particle) then
			particle:SetLifeTime(4) 
			particle:SetDieTime(8) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(35) 
			particle:SetEndSize(0)
			particle:SetAngles( Angle(math.random( 0, 360 ),math.random( 0, 360 ),math.random( 0, 360 )) )
			particle:SetAngleVelocity( Angle(math.random( 0, 5 ),math.random( 0, 5 ),math.random( 0, 5 )) ) 
			particle:SetRoll(math.random( 0, 360 ))
			particle:SetColor(math.random(self.Mag["r"]/1.2,self.Mag["r"]),math.random(self.Mag["g"]/1.2,self.Mag["g"]),math.random(self.Mag["b"]/1.2,self.Mag["b"]),math.random(255,255))
			particle:SetGravity( Vector(0, 0, -400 ) ) 
			particle:SetVelocity( VectorRand()*-200 ) 
			particle:SetAirResistance(20)  
			particle:SetCollide(true)
			particle:SetBounce(0.2)
		end

		emitter:Finish()
	end
end