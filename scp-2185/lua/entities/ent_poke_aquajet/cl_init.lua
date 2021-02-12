include( "shared.lua" )

function ENT:Initialize()
	self:DrawShadow(false)
end

function ENT:Think()
	if IsValid(self:GetOwner()) then
		self:SetPos(self:GetOwner():GetPos())
	end
end

function ENT:Draw()
	cam.Start3D()
		render.SetMaterial( Material("poke/particles/bubble") )
		render.DrawSprite( self:GetOwner():GetPos()+Vector(0,0,32), 96, 96, Color(255,255,255,155) )
	cam.End3D()
end