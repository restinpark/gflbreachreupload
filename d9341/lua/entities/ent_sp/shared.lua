AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "D-9341 Save Point"


function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    if SERVER then
        local pobj = self:GetPhysicsObject()
        if IsValid(pobj) then
            pobj:EnableMotion(false)
        end
    end
end

function ENT:Draw()
    --Invisible entity
end
