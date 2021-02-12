include('shared.lua')

local matBeamSub

ENT.RenderGroup = RENDERGROUP_BOTH
function ENT:Initialize()
	self.LifeTime = .5 * GetConVarNumber("bfx_lifetimemulti")/2
	self.delayRemove = CurTime() + self.LifeTime
	local posStart = self:GetAttachmentPos()
	local owner = self:GetOwner()
	matBeamSub = Material(owner:GetNWString("hardlight_tracer"))
	local tr
	if owner:IsPlayer() then tr = util.TraceLine(util.GetPlayerTrace(self:GetOwner()))
	else
		local endpos = self:GetBeamPositions()[2] || posStart
		tr = util.TraceLine({start = posStart, endpos = endpos, filter = owner})
	end
	
	self.nextUpdate = 0
	
	local iIndex = self:EntIndex()
	hook.Add("RenderScreenspaceEffects", "Effect_Hardlight" .. iIndex, function()
		if !IsValid(self) then
			hook.Remove("RenderScreenspaceEffects", "Effect_Hardlight" .. iIndex)
			return
		end
		
		local Owner = self:GetOwner()
		if !IsValid(Owner) then return end
		local StartPos = self:GetAttachmentPos()
		if CurTime() >= self.nextUpdate then self:RefreshBeam(StartPos); self.nextUpdate = CurTime() +0.02 end
		cam.Start3D(EyePos(), EyeAngles())
			render.SetMaterial(matBeamSub)
			render.StartBeam(table.Count(self.positions))
			for k, v in pairs(self.positions) do
				//render.AddBeam(v, 16 *self:GetNetworkedFloat("scale"), CurTime(), Color(255,255,255,255))
			end
			render.EndBeam()
			local posStart = self:GetAttachmentPos()
			local TexOffset = CurTime() *-1.2
			render.SetMaterial(matBeamSub)
			for i = 1, self:GetNetworkedInt("positions") do
				local posDest = self:GetNetworkedVector(i)
				local v = ( self.delayRemove - CurTime() ) / self.LifeTime
				//render.DrawBeam(posStart, posDest, 20 *self:GetNetworkedFloat("scale"), TexOffset *-0.4, TexOffset *-0.4 +posStart:Distance(posDest) /256, Color(255,255,255,255))
				render.DrawBeam(posStart, posDest, (v * 90), TexOffset *-0.4, TexOffset *-0.4 +posStart:Distance(posDest) /256, Color( 255, 255, 255, 222 ) )
				posStart = posDest
			end
		cam.End3D()
	end)
end

function ENT:Think()
	
end

function ENT:Draw()
end

function ENT:IsTranslucent()
	return true
end

function ENT:RefreshBeam(posStart)
	local amplitude = 0
	local tblVec = self:GetBeamPositions()
	self.positions = {posStart}
	for k, v in pairs(tblVec) do
		if k > 1 then
			local pos = tblVec[k -1]
			local posDest = v
			local normal = (posDest -pos):GetNormal()
			local ang = normal:Angle()
			local fDist = pos:Distance(posDest)
			local iSegments = math.Clamp(math.Round(fDist *0.05), 0, 100)
			local fDistEach = math.Round(fDist /iSegments)
			local _pos = pos
			for i = 1, iSegments -1 do
				if i < iSegments -1 then
					pos = _pos +ang:Forward() *fDistEach *i +ang:Up() *math.Rand(-amplitude, amplitude) +ang:Right() *math.Rand(-amplitude, amplitude)
				else pos = posDest end
				table.insert(self.positions, pos)
			end
		end
	end
end