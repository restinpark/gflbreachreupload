////////////////////////////////////////////////////////////////
//  Breaching Charge, Entity
//  Programmed by Sevan Buechele
//  @   Copyright 2018 © Sevan Buechele
//  @   All Rights Reserved.
/////////////////////////////////////////////////////////////

/*|Entity Configuration|*/
ENT.Type		= "anim"
ENT.Base		= "base_anim"
ENT.Category	= "Sevan's Entities"
ENT.PrintName	= "Breaching Charge"
ENT.Author		= "Sevan Buechele"
ENT.Contact		= "STEAM_0:1:65313765"
ENT.Spawnable	= false
ENT.AdminOnly	= true
AddCSLuaFile()

/*|Entity Initialization|*/
function ENT:Initialize()
	self:SetModel("models/minic23/csgo/breach_charge.mdl")
	self:SetModelScale(1,0)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self.physicsobj = self:GetPhysicsObject()
	if IsValid(self.physicsobj) then
		self.physicsobj:Wake()
		self.physicsobj:EnableMotion(false)
	end
	self:Activate()
	self:DrawShadow(true)
end

/*|Explode Function|*/
function ENT:Explode()
	local doortime = false
	local cvar1 = GetConVar("sv_breachingcharge_enabledoorbust")
	local cvar2 = GetConVar("sv_breachingcharge_enablepropunfreeze")
	cvar1 = cvar1:GetInt()
	cvar2 = cvar2:GetInt()
	if cvar1 == 1 then
		for k,v in pairs(ents.FindInSphere(self:GetPos(),40)) do
			if v:GetClass() == "func_door" || v:GetClass() == "prop_door_rotating" || v:GetClass() == "func_door_rotating" then
				v:Fire("lock","",0)
				v:Fire("Open","",0)
				v:SetNoDraw(true)
				v:SetCollisionGroup(COLLISION_GROUP_WORLD)
				v:CollisionRulesChanged()
				if !v.ent then
					v.ent = ents.Create("prop_physics")
					v.ent:SetModel(v:GetModel())
					if v:GetSkin() then
						v.ent:SetSkin(v:GetSkin())
					end
					v.ent:SetPos(v:GetPos()+self:GetUp()*-40)
					v.ent:SetAngles(v:GetAngles())
					v.ent:Spawn()
					v.ent:GetPhysicsObject():SetVelocityInstantaneous(self:GetUp()*-500)
				end
				timer.Simple(10,function()
					if v:IsValid() then
						v:SetCollisionGroup(COLLISION_GROUP_NONE)
						v:CollisionRulesChanged()
						v:Fire("unlock","",0)
						v:SetNoDraw(false)
						if v.ent:IsValid() then
							v.ent:Remove()
						end
					end
				end)
				doortime = true
			end
		end
	else
		for k,v in pairs(ents.FindInSphere(self:GetPos(),40)) do
			if v:GetClass() == "func_door" || v:GetClass() == "prop_door_rotating" || v:GetClass() == "func_door_rotating" then
				v:Fire("unlock","",0)
				v:Fire("Open","",0)
				doortime = true
			end
		end
	end
	for k,v in pairs(ents.FindInSphere(self:GetPos(),40)) do
		if v:GetClass() == "prop_physics" and v.isFadingDoor then
			v:fadeActivate()
			timer.Simple(4,function()
				if v:IsValid() then
					v:fadeDeactivate()
				end
			end)
			doortime = true
		elseif v:GetClass() == "prop_physics" and cvar2 == 1 then
			if v.isFadingDoor then return end
			v:GetPhysicsObject():EnableMotion(true)
		end
	end
	if doortime then
		util.BlastDamage(self,self,self:GetPos(),100,10)
	else
		util.BlastDamage(self,self,self:GetPos(),300,100)
	end
	self:Remove()
end

/*|Disarm Function|*/
function ENT:Disarm()
	self.disarm = true
	self:Remove()
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

/*|Think|*/
function ENT:Think()
	if self:GetParent() then
		local ent = self:GetParent()
		if ent:IsPlayer() then
			if !ent:Alive() then
				self:Explode()
			end
		end
	end
	self:NextThink(CurTime()+0.2)
end

/*|Entity VFX|*/
if CLIENT then
	function ENT:Initialize()
	end
	function ENT:Draw()
		self:DrawModel()
	end
	function ENT:OnRemove()
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		util.Effect("Explosion",effectdata)
		self:EmitSound("weapons/explode5.wav")
	end
end