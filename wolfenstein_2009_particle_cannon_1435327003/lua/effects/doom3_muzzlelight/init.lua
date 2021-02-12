function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()	
	local pos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	
	if IsValid(self.WeaponEnt) and IsValid(self.WeaponEnt:GetOwner()) and (!self.WeaponEnt:IsCarriedByLocalPlayer() or LocalPlayer():ShouldDrawLocalPlayer()) then
		local emitter = ParticleEmitter(pos)
			for i = 1,2 do
				local particle = emitter:Add( "sprites/doom3/f_machinegun", pos )
				particle:SetVelocity( 60 * data:GetNormal() + self.WeaponEnt:GetOwner():GetVelocity() )
				particle:SetGravity( Vector(0,0,0) )
				particle:SetDieTime( .05 )
				particle:SetStartAlpha( 255 )
				particle:SetStartSize( 2 )
				particle:SetEndSize( 8 )
				particle:SetRoll( math.Rand( 180, 480 ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetColor( 255, 255, 255 )	
			end
		emitter:Finish()
	end
	
	self:SetRenderBoundsWS(pos, self.Position)

	if !cvars.Bool("doom3_firelight") then return end
	local dynlight = DynamicLight(self:EntIndex())
		dynlight.Pos = pos
		dynlight.Size = 128
		dynlight.Decay = 2048
		dynlight.R = 255
		dynlight.G = 200
		dynlight.B = 60
		dynlight.Brightness = 5
		dynlight.DieTime = CurTime()+.05
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end