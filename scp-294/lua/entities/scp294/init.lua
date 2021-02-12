AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

util.AddNetworkString("OpenSCP294Panel")

function ENT:Initialize()
	self:SetModel( "models/vinrax/scp294/scp294_lg.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	end
end

function ENT:Use( ply, caller )
	if ply:Team() ~= TEAM_SCP and ply:Team() ~= TEAM_SPEC then
		net.Start("OpenSCP294Panel")
		net.Send(ply)
	end
end

function ENT:Think() end

