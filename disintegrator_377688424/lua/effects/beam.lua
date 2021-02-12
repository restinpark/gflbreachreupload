

EFFECT.Mat = Material( "sprites/rollermine_shock" )

--[[---------------------------------------------------------
   Init( data table )
-----------------------------------------------------------]]
function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	-- Keep the start and end pos - we're going to interpolate between them
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()

	
	self.Alpha = 255
	self.Life = 0.0;

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
	self.Offset = 3
end


--[[---------------------------------------------------------
   THINK
-----------------------------------------------------------]]
function EFFECT:Think( )

	self.Life = self.Life + FrameTime() /0.25;
	self.Alpha = 255 * ( 1 - self.Life )
	
	return (self.Life < 1)

end

--[[---------------------------------------------------------
   Draw the effect
-----------------------------------------------------------]]
function EFFECT:Render( )
	if ( self.Alpha < 1 ) then return end
		
	render.SetMaterial( self.Mat )
	local texcoord = self.Life * -0.5 *2
	local norm = (self.StartPos - self.EndPos) * self.Life /2

	self.Length = norm:Length() *4
	
	

	render.DrawBeam( self.StartPos,
						self.EndPos,
						math.Rand(2,8),
						texcoord,
						texcoord + self.Length / 1024,
						Color( 255, 255, 255, 255 * ( 1 - self.Life ) )	)
						
	render.DrawBeam( self.StartPos,
						self.EndPos,
						math.Rand(2,8),
						texcoord,
						texcoord + self.Length / 1024,
						Color( 255, 255, 255, 255 * ( 1 - self.Life ) )	)

end
