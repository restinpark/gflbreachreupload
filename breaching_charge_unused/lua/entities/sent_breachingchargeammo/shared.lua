////////////////////////////////////////////////////////////////
//  Breaching Charge, Ammo Entity
//  Programmed by Sevan Buechele
//  @   Copyright 2018 © Sevan Buechele
//  @   All Rights Reserved.
/////////////////////////////////////////////////////////////

/*|Entity Configuration|*/
ENT.Type		= "anim"
ENT.Base		= "base_anim"
ENT.Category	= "Sevan's Ammo"
ENT.PrintName	= "Breaching Charges"
ENT.Author		= "Sevan Buechele"
ENT.Contact		= "STEAM_0:1:65313765"
ENT.Spawnable	= true
ENT.AdminOnly	= true
AddCSLuaFile()

/*|Entity Initialization|*/
function ENT:Initialize()
	self:SetModel("models/Items/item_item_crate.mdl")
	self:SetModelScale(1,0)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.physicsobj = self:GetPhysicsObject()
	if IsValid(self.physicsobj) then
		self.physicsobj:Wake()
	end
	self:Activate()
	self:DrawShadow(true)
	self:SetUseType(SIMPLE_USE)
end

/*|Use Function|*/
function ENT:Use(activator,caller,usetype)
	if caller:IsPlayer() then
		caller:GiveAmmo(1,"ammo_breachingcharge")
		self:Remove()
	end
end

/*|Spawn Function|*/
function ENT:SpawnFunction(ply,tr,cname)
	if (!tr.Hit) then return end
	local pos = tr.HitPos + tr.HitNormal
	local ang = ply:EyeAngles()
	ang.p = 0
	local ent = ents.Create(cname)
	ent.Owner = ply
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:Spawn()
	return ent
end

/*|Entity VFX|*/
if CLIENT then
	function ENT:Initialize()
	end
	function ENT:Think()
	end
	function ENT:Draw()
		self:DrawModel()
	end
	function ENT:OnRemove()
	end
end