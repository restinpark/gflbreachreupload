function EFFECT:Init(data)
	
	if not IsValid(data:GetEntity()) then return end
	
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	if self.WeaponEnt == nil or self.WeaponEnt:GetOwner() == nil or self.WeaponEnt:GetOwner():GetVelocity() == nil then 
		return
	else
	
	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	
	local AddVel = self.WeaponEnt:GetOwner():GetVelocity()
	
	local emitter = ParticleEmitter(self.Position)
	if emitter != nil then	
		local particle = emitter:Add( "effects/concussion_muzzle_hr", self.Position - self.Forward * 5 )
		if particle != nil then
	
			particle:SetVelocity( 20 * self.Forward + 20 * VectorRand() + 1.05 * AddVel )
			particle:SetGravity( Vector( 0, 0, 10 ) )
			particle:SetAirResistance( 160 )

			particle:SetDieTime( math.Rand( 0.1, 0.1 ) )

			particle:SetStartSize( math.random( 0, 0 ) )
			particle:SetEndSize( 40 )

			particle:SetRoll( math.Rand( 180, 480 ) )
			particle:SetRollDelta( math.Rand( -1, 1 ) )
			
			particle:SetColor( 220, 0, 255 )
		
		for i = 1,4 do
			local particle = emitter:Add( "effects/concussion_muzzle_hr", self.Position )

				particle:SetVelocity( 120 * i * self.Forward + 5 * VectorRand() + AddVel )
				particle:SetAirResistance( 400 )
				particle:SetGravity( Vector(0, 0, math.Rand(0, 0) ) )

				particle:SetDieTime( math.Rand( 0.5, 0.1 ) )

				particle:SetStartAlpha( math.Rand( 25, 70 ) )
				particle:SetEndAlpha( 0 )

				particle:SetStartSize( math.Rand( 3, 7 ) )
				particle:SetEndSize( math.Rand( 20, 50 ) )

				particle:SetRoll( math.Rand( -25, 25 ) )
				particle:SetRollDelta( math.Rand( -0.05, 0.05 ) )

				particle:SetColor( 0, 0, 0 )
		end
		
		if math.random( 1, 2 ) == 1 then

			for j = 1,2 do

				for i = -1,1,2 do 

					local particle = emitter:Add( "effects/muzzleflash"..math.random( 1, 4 ), self.Position - 3 * self.Forward + 2 * j * i * self.Right)

						particle:SetVelocity( 60 * j * i * self.Right + AddVel )
						particle:SetGravity( AddVel )

						particle:SetDieTime( 0.1 )

						particle:SetStartAlpha( 150 )

						particle:SetStartSize( 10 )
						particle:SetEndSize( 4 * j )

						particle:SetRoll( math.Rand( 180, 480 ) )
						particle:SetRollDelta( math.Rand( -1, 1 ) )

						particle:SetColor(  220, 0, 255 )	
				end
			end

			for i = 1,2 do 

				local particle = emitter:Add( "effects/muzzleflash"..math.random( 1, 4 ), self.Position + 8 * self.Forward )

					particle:SetVelocity( 350 * self.Forward + 1.1 * AddVel )
					particle:SetAirResistance( 160 )

					particle:SetDieTime( 0.1 )

					particle:SetStartAlpha( 160 )
					particle:SetEndAlpha( 0 )

					particle:SetStartSize( 10 )
					particle:SetEndSize( 5 * i )

					particle:SetRoll( math.Rand( 180, 480 ) )
					particle:SetRollDelta( math.Rand( -1, 1) )

					particle:SetColor(  220, 0, 255 )	
			end
		end
		end
	emitter:Finish()
	end
	end
end


function EFFECT:Think()

	return false
end


function EFFECT:Render()
end