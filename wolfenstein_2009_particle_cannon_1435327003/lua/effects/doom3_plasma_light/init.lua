function EFFECT:Init(data)
	if !cvars.Bool("doom3_firelight") then return end
		local dynlight = DynamicLight(self:EntIndex())
		dynlight.Pos = data:GetOrigin()
		dynlight.Size = 128
		dynlight.Decay = 256
		dynlight.R = 0
		dynlight.G = 100
		dynlight.B = 225
		dynlight.Brightness = 5
		dynlight.DieTime = CurTime()+.4
end

function EFFECT:Think()
end

function EFFECT:Render()
end