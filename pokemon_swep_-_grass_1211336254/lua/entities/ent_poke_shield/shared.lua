ENT.Type = "anim"
ENT.PrintName		= "Shield"
ENT.Author			= "Demonkush"
function ENT:Initialize()
	self:SetModel("models/props_debris/metal_panel02a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	if SERVER then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then phys:Wake() end
	end
end