AddCSLuaFile()
AddCSLuaFile( "effects/fxbase.lua" )
include( "effects/fxbase.lua" )

EFFECT.Speed	= 13000
EFFECT.Length	= 64
EFFECT.Trace	= Material( "effects/gunshiptracer" )
EFFECT.Halo		= Material( "effects/combine_halo" )
EFFECT.FlyBy	= "weapons/neutrino/flyby.wav"

function EFFECT:Init( data )

	self.StartPos = self:GetTracerOrigin( data )
	self.EndPos = data:GetOrigin()
	self.Parent = data:GetEntity()
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

	local diff = ( self.EndPos - self.StartPos )
	
	self.Normal = diff:GetNormal()
	self.StartTime = 0
	self.LifeTime = ( diff:Length() + self.Length ) / self.Speed
	
	if ( IsValid( self.Parent ) and ( !self.Parent:IsWeapon() or !self.Parent:IsCarriedByLocalPlayer() ) ) then

		local dist, pos, time = util.DistanceToLine( self.StartPos, self.EndPos, EyePos() );
		if( dist <= 100 ) then
			EmitSound( self.FlyBy, pos, SOUND_FROM_WORLD, CHAN_STATIC, 1, 100, 0, math.random( 100, 150 ) );
		end

	end

end

function EFFECT:Render()

	local endDistance = self.Speed * self.StartTime
	local startDistance = endDistance - self.Length
	
	startDistance = math.max( 0, startDistance )
	endDistance = math.max( 0, endDistance )
	
	local startPos = self.StartPos + self.Normal * startDistance
	local endPos = self.StartPos + self.Normal * endDistance * 2
	
	ParticleEffect( "nio_tracer", endPos, Angle( 0, 0, 0 ), self.Entity )
	
	render.SetMaterial( self.Halo )
	render.DrawSprite( endPos, 18, 18, Color( 85, 255, 0, 255 ) )

	render.SetMaterial( self.Trace )
	render.DrawBeam( startPos, endPos, 64, 0, 1, Color( 85, 255, 0, 255 ) )
	
	local dlight = DynamicLight( self.Entity:EntIndex() )
	if ( dlight ) then
		dlight.pos = endPos
		dlight.r = 85
		dlight.g = 255
		dlight.b = 0
		dlight.brightness = 2
		dlight.Decay = 2048
		dlight.Size = 320
		dlight.DieTime = CurTime() + 1
	end

end