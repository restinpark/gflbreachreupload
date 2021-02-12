EFFECT.mat = Material("sprites/doom3/plasma_mflash")
local exists = file.Exists("materials/sprites/doom3/plasma_mflash.vmt", "GAME")

function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Time = 0
	self.Size = 32
	
	if cvars.Bool("doom3_firelight") then
		local dynlight = DynamicLight(self:EntIndex())
		dynlight.Pos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
		dynlight.Size = 128
		dynlight.Decay = 1024
		dynlight.R = 0
		dynlight.G = 255
		dynlight.B = 140
		dynlight.Brightness = 2
		dynlight.DieTime = CurTime()+.1
	end
end

function EFFECT:Think()
	self.Time = self.Time + FrameTime()
	return self.Time < .25
end

function EFFECT:Render()
	local Muzzle = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	if !self.WeaponEnt or !IsValid(self.WeaponEnt) or !Muzzle then return end
	self:SetRenderBoundsWS(Muzzle, Muzzle)
	render.SetMaterial(self.mat)
	if exists then
		self.mat:SetInt("$frame", math.Clamp(math.floor(self.Time * 128), 0, 31))
	end
	render.DrawSprite(Muzzle, self.Size, self.Size)
end