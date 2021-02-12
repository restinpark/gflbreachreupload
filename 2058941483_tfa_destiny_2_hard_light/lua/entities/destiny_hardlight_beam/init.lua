
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetSolid(SOLID_NONE)
	self.LifeTime = .3 * GetConVarNumber("bfx_lifetimemulti")/2
	self.delayRemove = CurTime() + self.LifeTime
	if self:GetScale() == 0 then self:SetScale(0) end
end

function ENT:SetScale(flScale)
	self:SetNetworkedFloat("scale", flScale)
end

function ENT:GetScale()
	return self:GetNetworkedFloat("scale")
end

function ENT:Think()
		//if CurTime() < self.delayRemove then self:NextThink(CurTime()); return true end
		//self.delayRemove = nil
		timer.Simple(0.5, function() if IsValid(self) then self:Remove() end end)
		//self:Remove()
end

function ENT:AddPosition(vecPos)
	local iPos = self:GetNetworkedInt("positions") +1
	self:SetNetworkedInt("positions", iPos)
	self:SetNetworkedVector(iPos, vecPos)
end