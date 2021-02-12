AddCSLuaFile()
local d = {}
d.Base = "armor_base"
d.PrintName = "Hazmat Suit"
d.ArmorType = "armor_hazmat"
d.stats = 0.95
d.model = "models/materials/humans/group03m/male_09.mdl"
function d:Initialize()
    self.Entity:SetModel("models/myproject/hazmat_bag.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	//self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_BBOX)
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end

	//local phys = self.Entity:GetPhysicsObject()

	//if phys and phys:IsValid() then phys:Wake() end
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end
scripted_ents.Register(d, "armor_hazmat")

local e = {}
e.Base = "armor_base"
e.PrintName = "Tau-5 Armor"
e.ArmorType = "armor_tau"
e.stats = 0.95
e.model = "models/player/urban.mdl"
scripted_ents.Register(e, "armor_tau")

ENT.Base		= "armor_base"
ENT.PrintName	= "Chaos Insurgency Vest"
ENT.ArmorType	= "armor_chaosins"
ENT.Stats		= 0.95
ENT.model		= CHAOS_ARMOR