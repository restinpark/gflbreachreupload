include( "shared.lua" )

function ENT:Initialize()
	self:DrawShadow(false)
end

function ENT:Think()
	return false
end

function ENT:Draw()
	if self:GetNWBool("2DToggle") == false then return end
	local abc = self:GetNWAngle("2DColor")
	local alpha = self:GetNWInt("2DAlpha")
	local color = Color(abc.p,abc.y,abc.r,alpha)
	local sprite = self:GetNWString("2DMaterial") or "sprites/glow04_noz"
	local scale = self:GetNWInt("2DScale")
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local up, down, left, right = ang:Up(), -ang:Up(), -ang:Right(), ang:Right()

	render.SetMaterial(Material(sprite))
	render.DrawQuad( 
		pos+( up*scale )-( right*scale ), 
		pos+( up*scale )-( left*scale ), 
		pos+( down*scale )+( right*scale ),
		pos+( down*scale )+( left*scale ),
		color
	)
	render.DrawQuad( 
		pos+( up*scale )+( right*scale ), 
		pos+( up*scale )+( left*scale ), 
		pos+( down*scale )-( right*scale ),
		pos+( down*scale )-( left*scale ),
		color
	)
end