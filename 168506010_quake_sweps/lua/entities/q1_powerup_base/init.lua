AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

util.AddNetworkString("QuakePowerupsClient")

ENT.PDuration = 30

function ENT:Initialize()
	self:SetModel(self.model)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetAngles(Angle(0,90,0))
	self:DrawShadow(true)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetTrigger(true)
	self:UseTriggerBounds(true, 24)
	self.PDuration = cvars.Number("q1_powerupduration")
end

function ENT:Touch(ent)
	if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
		if !ent.QuakePowerups then
			ent.QuakePowerups = {}
		end
		self:Pickup(ent)
	end
end

function ENT:Pickup(ply)
end

local function netBroadcast(ply, t)
	net.Start("QuakePowerupsClient")
	net.WriteEntity(ply)
	net.WriteTable(t)
	net.Broadcast()
end

function ENT:SendToClient(ply, t)
	netBroadcast(ply, t)
end

hook.Add("PlayerDeath", "QuakePlayerDeath", function(ply)
	if ply.QuakePowerups then
		table.Empty(ply.QuakePowerups)
	
		netBroadcast(ply, ply.QuakePowerups)
		
		ply.QuakePowerups = nil
	end
	if ply.inv3 then
		ply.inv3:Stop()
		ply.inv3 = nil
	end
end)