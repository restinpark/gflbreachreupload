AddCSLuaFile()

ENT.PrintName = "SCP-1315"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Press E to Play."


function ENT:Initialize()
    self:SetModel("models/unconid/nes.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
	self:PhysWake()
	if SERVER then
        if SPAWN_SCP1315 then
            self:SetPos(SPAWN_SCP1315)
        else
            self:Remove()
        end
		if SPAWN_SCP1315_ANGLE and isangle(SPAWN_SCP1315_ANGLE) then
            self:SetAngles(SPAWN_SCP1315_ANGLE)
        end
    end
end


