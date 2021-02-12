AddCSLuaFile()

ENT.Type = "anim"
ENT.Category = "TFA CS:GO"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Defuse Kit"

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	self:SetModel("models/weapons/tfa_csgo/w_defuser_display.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:UseTriggerBounds(true, 12)

	if SERVER then
		self:SetTrigger(true)
	end

	self:PhysWake()
end

function ENT:StartTouch(ent)
	if not IsValid(ent) or not ent:IsPlayer() then return end

	if hook.Run("PlayerCanPickupItem", ent, self) == false then return end

	if ent:GetNW2Bool("TFA_CSGO_HasDefuseKit", false) then return end

	SafeRemoveEntity(self)

	ent:SendLua([[hook.Run("HUDItemPickedUp", "]] .. self:GetClass() .. [[")]])
	ent:EmitSound("items/ammo_pickup.wav", 60, 100)

	ent:SetNW2Bool("TFA_CSGO_HasDefuseKit", true)
end