AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

    self:SetModel( "models/hunter/tubes/circle4x4.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetTrigger(true)
    local phys = self:GetPhysicsObject()
    self:SetCollisionGroup(1)
    self:SetMaterial("models/shadertest/predator")
    self:SetNoDraw(false)
    if phys:IsValid() then
        phys:Wake()
        phys:EnableMotion(false)
    end
    timer.Create("106portaldeath", 20, 1, function()
    self:Remove() 
    end)
end

function ENT:Touch( toucher )
    if ( toucher:IsValid() and toucher:IsPlayer() and toucher:Team() != TEAM_SCP and toucher:Team() != TEAM_SPEC and toucher:GetNClass() != ROLE_SCP990 )then
        toucher:SetPos( GetPocketPos() )
		toucher:AddFrags(-3)
    end
end

