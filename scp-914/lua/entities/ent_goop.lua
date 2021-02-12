AddCSLuaFile()

ENT.PrintName = "Rough"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Goopy."


function ENT:Initialize()
    self:SetModel("models/hunter/tubes/circle4x4.mdl")
	self:SetMaterial("models/props_lab/Tank_Glass001")
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNoDraw(false)
	timer.Simple(30, function()
		SafeRemoveEntity(self)
	end)
end

function ENT:Touch( toucher )
    if ( toucher:IsValid() and toucher:IsPlayer() and toucher:Team() != TEAM_SPEC and toucher:GetNClass() != ROLE_SCP990 )then
		toucher:SetDecomposing(true)
		toucher:SetBleeding(true)
    end
end

