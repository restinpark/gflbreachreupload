AddCSLuaFile()

ENT.PrintName = "SCP-020"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Moldy."


function ENT:Initialize()
    self:SetModel("models/hunter/tubes/tube2x2x4.mdl")
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNoDraw(true)
end

function ENT:Touch( toucher )
    if ( toucher:IsValid() and toucher:IsPlayer() and toucher:Team() != TEAM_SPEC and toucher:GetNClass() != ROLE_SCP990 )then
		if toucher:Team() == TEAM_SCP then
			SafeRemoveEntity(self)
		end
		if math.random(1, 5) == 1 then
			toucher:SetNWString("020", "stage1")
			SafeRemoveEntity(self)
			timer.Simple(180, function()
			if toucher:GetNWString("020", "unset") == "stage1" then
			toucher:SetSCP020()
			toucher:EmitSound("physics/flesh/flesh_bloody_impact_hard1.wav", 100, 55)
			end
		end)
		else
			SafeRemoveEntity(self)
		end
    end
end

if SERVER then
    function ENT:Think()
        local affected = ents.FindInSphere(self:GetPos(), 200)
        for k,v in pairs(affected) do
            if v:IsPlayer() and v:Team() ~= TEAM_SCP and v:Team() ~= TEAM_SPEC and v:GetNClass() ~= ROLE_SCP990 then
				if v:HasWeapon("weapon_nvg") then
					local nvg
					nvg = v:GetWeapon("weapon_nvg")
					if nvg.IsOn then
						v:SetEyeAngles((self:GetPos() - v:GetShootPos()):Angle())
						v:PrintMessage(4, "There seems to be some sort of mold here.")
					else
						return end
				end
			end
		end
	end
end
