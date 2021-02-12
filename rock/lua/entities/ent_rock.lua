AddCSLuaFile()

ENT.PrintName = "Rock"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = "Aurora"
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Touch and you die."

function ENT:Initialize()
    self:SetModel( "models/props_combine/breenbust_chunk06.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    self:SetNoDraw(false)
    if phys:IsValid() then
        phys:Wake()
        phys:EnableMotion(true)
    end
end

function ENT:Touch( toucher )
    if ( toucher:IsValid() and toucher:IsPlayer() and toucher:Team() != TEAM_SCP and toucher:Team() != TEAM_SPEC and toucher:GetNClass() != ROLE_SCP990 )then
        toucher:Kill()
		local ent = ents.Create( "env_explosion" )
			ent:SetPos( toucher:GetPos() )
			ent:SetOwner( toucher )
			ent:Spawn()
			ent:SetKeyValue( "iMagnitude", "80" )
			ent:Fire( "Explode", 0, 0 )
			ent:EmitSound( "BaseExplosionEffect.Sound", 100, 100 )
    end
end

