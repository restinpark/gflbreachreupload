AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

util.AddNetworkString( "Popcorn_Explosion" )

function ENT:Initialize()

	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( true )
    self:SetCollisionGroup(1)
	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:Wake()
	end
end

local break_sounds = {
	Sound("physics/cardboard/cardboard_box_impact_hard1.wav"),
	Sound("physics/cardboard/cardboard_box_impact_hard2.wav"),
	Sound("physics/cardboard/cardboard_box_impact_hard3.wav"),
	Sound("physics/cardboard/cardboard_box_impact_hard4.wav"),
	Sound("physics/cardboard/cardboard_box_impact_hard5.wav"),
	Sound("physics/cardboard/cardboard_box_impact_hard6.wav"),
	Sound("physics/cardboard/cardboard_box_impact_hard7.wav")
}

function ENT:PhysicsCollide(colData,collider)

	self.exploded = true

	local sound = break_sounds[math.random(1,table.Count(break_sounds))]
	self:EmitSound(sound)
	local entid = self:EntIndex()
	net.Start("Popcorn_Explosion")
		net.WriteVector(self:GetPos())
		net.WriteVector(colData.HitNormal)
		net.WriteVector(colData.OurOldVelocity)
		net.WriteFloat(entid)
	net.Broadcast()
	timer.Create("kill_kt"..entid,0.25,2,function ()
		for _,v in pairs(player.GetAll()) do
			v:SendLua("timer.Destroy('kernel_timer"..entid.."')")
		end
	end)
	SafeRemoveEntity( self )
end