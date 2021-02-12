AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Lootable"
ENT.Spawnable = false

function ENT:FinishInit()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    local pobj = self:GetPhysicsObject()
    if IsValid(pobj) then
        pobj:Wake()
    end
end

function ENT:Use(ply)
    if ply and IsValid(ply) and (ply:Team() == TEAM_CHAOS or ply:Team() == TEAM_SCI or ply:GetNClass() == ROLE_SERPENT) then
        ply.lootableindex = ply.lootableindex or {}
        ply.lootableindex[self:GetModel()] = true
        ply:PrintMessage(HUD_PRINTTALK, "You are now carrying " .. tostring(table.Count(ply.lootableindex)) .. " SCP Object(s).")
        SafeRemoveEntity(self)
    end
end