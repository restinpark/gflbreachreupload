include( "shared.lua" )

function ENT:Initialize()
	self:DrawShadow(false)
	self.bubbuild = 0
end

function ENT:Draw()
	self.bubbuild = self.bubbuild+2
	cam.Start3D()
		render.SetMaterial( Material("poke/particles/bubble") )
		render.DrawSprite( self:GetPos(), math.Clamp(self.bubbuild,0,48), math.Clamp(self.bubbuild,0,48), Color(255,255,255,math.Clamp(self.bubbuild*2,0,215)) )
	cam.End3D()
end