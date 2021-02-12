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
    self:SetMaterial("models/gibs/woodgibs/woodgibs01")
    self:SetNoDraw(true)
	self:Ignite(20, 50)
    if phys:IsValid() then
        phys:Wake()
        phys:EnableMotion(false)
    end
    timer.Create("457extinguish", 20, 1, function()
    self:Remove()
	self:StopSound("Weapon_FlareGun.Burn")
    end)
end

function ENT:Touch( toucher )
    if ( toucher:IsValid() and toucher:IsPlayer() and toucher:Team() != TEAM_SCP and toucher:Team() != TEAM_SPEC and toucher:GetNClass() != ROLE_SCP990 )then
	if toucher:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
        toucher:Ignite(5, 50)
		toucher:TakeDamage(0.2)
    end
end
