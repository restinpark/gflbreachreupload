AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel("models/props_debris/metal_panel02a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetColor(Color(0,0,0,255))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	if SERVER then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		end
	end

	self:SetNWBool("2DToggle",true)
	self:SetNWString("2DMaterial","sprites/glow04_noz")
	self:SetNWInt("2DScale",1)
end
function ENT:ChangeSettings(toggle,material,scale,color)
	self:SetNWBool("2DToggle",toggle)
	self:SetNWString("2DMaterial",material)
	self:SetNWInt("2DScale",scale)
	self:SetNWInt("2DAlpha",color.a)
	self:SetNWAngle("2DColor",Angle(color.r,color.g,color.b))
end
function ENT:OnTakeDamage(dmg)
	self:SetHealth(self:Health()-dmg:GetDamage())
	if self:Health() < 1 then
		self:Remove()
		if IsValid(self:GetOwner()) then
			timer.Remove("POKENATURESHIELD"..self:GetOwner():SteamID())
		end
	end
end
function ENT:OnRemove()
end