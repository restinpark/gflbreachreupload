AddCSLuaFile()

ENT.PrintName = "SCP-035"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Press E to Use."


function ENT:Initialize()
    self:SetModel("models/vinrax/props/scp035/035_mask.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	if SERVER then
		self:SetUseType( SIMPLE_USE )
    end
end

function ENT:Use(activator, caller)
    if SERVER and caller and IsValid(caller) and caller:IsPlayer() and caller:Team() == TEAM_CLASSD and caller:GetNClass() != ROLE_SCP035 then
	if caller.GiveAchievement then
		caller:GiveAchievement("Comedian")
	end
		caller:SetSCP035()
		caller:SetPos(self:GetPos())
		self:Remove()
	end
end



