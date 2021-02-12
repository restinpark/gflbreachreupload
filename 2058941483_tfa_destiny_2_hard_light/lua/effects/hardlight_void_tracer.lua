local Tracer = Material( "tracer/hardlight_void_tracer" )
local Tracer2 = Material( "trails/Sleeper_tracertile2" )
local Width = 25
local Width2 = 110

function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self:SetRenderBoundsWS( self.StartPos, self.EndPos )

	self.Dir = ( self.EndPos - self.StartPos ):GetNormalized()
	self.Dist = self.StartPos:Distance( self.EndPos )
	
	self.LifeTime = .3 * GetConVarNumber("bfx_lifetimemulti")/2
	self.DieTime = CurTime() + self.LifeTime

end

function EFFECT:Think()

	if ( CurTime() > self.DieTime ) then return false end
	return true

end

function EFFECT:Render()

	local r = GetConVarNumber("bfx_energycolor_r")
	local g = GetConVarNumber("bfx_energycolor_g")
	local b = GetConVarNumber("bfx_energycolor_b")
	
	
	local v = ( self.DieTime - CurTime() ) / self.LifeTime

	render.SetMaterial( Tracer )
	render.DrawBeam( self.StartPos, self.EndPos, (v * Width)*GetConVarNumber("bfx_widthmulti")/2, 0, (self.Dist/10)*math.Rand(-2,2), Color( 255, 255, 255, 222 ) )
	
end
