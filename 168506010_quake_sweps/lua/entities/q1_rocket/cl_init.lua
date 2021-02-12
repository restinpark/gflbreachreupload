include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	
	if FrameTime() == 0 then return end
	
	local pos = self:GetPos()

	if !self.emitter and !IsValid(self.emitter) then
		self.emitter = ParticleEmitter(pos)
	end
	if IsValid(self.emitter) then
		local particleMat = "sprites/qparticle"
		local particleMatScale = 1
		if cvars.Bool("q1_software") then
			particleMat = "sprites/qpixel"
			particleMatScale = .5
		end
		
		local col = math.random(60, 180)
		local smoke = self.emitter:Add(particleMat, pos + VectorRand() * 2)
		smoke:SetGravity(Vector(0, 0, math.Rand(60, 100)))
		smoke:SetDieTime(math.Rand(.7, 1))
		smoke:SetStartAlpha(255)
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(2 * particleMatScale)
		smoke:SetEndSize(2 * particleMatScale)
		smoke:SetColor(col, col, col)

		self.emitter:Draw()
	end
end

function ENT:OnRemove()
	if self.emitter and IsValid(self.emitter) then
		self.emitter:Finish()
	end
end