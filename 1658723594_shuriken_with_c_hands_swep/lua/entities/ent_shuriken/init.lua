AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( "models/jaanus/shuriken_small.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetVar( "hit", false )
	util.PrecacheSound("physics/metal/sawblade_stick3.wav")
	util.PrecacheSound("physics/metal/sawblade_stick2.wav")
	util.PrecacheSound("physics/metal/sawblade_stick1.wav")
	util.PrecacheSound("weapons/shuriken/hit1.wav")
	util.PrecacheSound("weapons/shuriken/hit2.wav")
	util.PrecacheSound("weapons/shuriken/hit3.wav")
	self.Hit = { 
	Sound( "physics/metal/sawblade_stick1.wav" ),
	Sound( "physics/metal/sawblade_stick2.wav" ),
	Sound( "physics/metal/sawblade_stick3.wav" ) };
	self.FleshHit = { 
	Sound( "weapons/shuriken/hit1.wav" ),
	Sound( "weapons/shuriken/hit2.wav" ),
	Sound( "weapons/shuriken/hit3.wav" ) }

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(10)
	end	
end

function ENT:Touch( entity )
	if entity:IsNPC() or entity.Type == "nextbot" then
		if timer.TimeLeft( "barb_damage" ) == nil then
			entity:EmitSound( "weapons/shuriken/hit".. math.random( 1, 3 ) .. ".wav" )
			local dmgInfo = DamageInfo()
			dmgInfo:SetAttacker(self)
			dmgInfo:SetInflictor(self)
			dmgInfo:SetDamageType(DMG_SLASH)
			dmgInfo:SetDamage(math.random(10,15))
			dmgInfo:SetDamagePosition(self:GetPos())
			entity:TakeDamageInfo(dmgInfo)
			timer.Create( "barb_damage", 0.25, 1, function() end )	
		end
	end
end

if( SERVER ) then
	function ENT:Think()
		local parent = self:GetParent()
		
		if( parent:IsValid() ) then
			if( parent:IsPlayer() ) then
				if( parent:Health() <= 0 ) then
					self:Remove()
				end
			end
		end
	end

	function ENT:PhysicsUpdate( )
		if( !self:GetVar( "hit", NULL ) ) then
			if( self:GetVelocity():Length() < 1000 ) then
				self:SetVar( "hit", true )
				self:Fire( "Kill", "", 20 )
				local phys = self:GetPhysicsObject()
				phys:EnableGravity( true )
			end
		end
	end

	function ENT:PhysicsCollide( data, phys )
		if( !self:GetVar( "hit", NULL ) ) then
			if( data.Speed > 100 ) then
				local hitEnt = data.HitEntity
				
				if( hitEnt:GetClass() != "ent_shuriken_huge" && hitEnt != self.Owner ) then
					self:SetMoveType( MOVETYPE_NONE )
					self:SetPos( data.HitPos )
					self:SetSolid( SOLID_NONE )
					
					if( hitEnt:IsValid()) then
						local dmgInfo = DamageInfo()
						dmgInfo:SetAttacker(self.Owner)
						dmgInfo:SetInflictor(self)
						dmgInfo:SetDamageType(DMG_SLASH)
						dmgInfo:SetDamage(math.random(10,15))
						dmgInfo:SetDamagePosition(self:GetPos())
						hitEnt:TakeDamageInfo(dmgInfo)
						self:SetParent( hitEnt, -1 )
					end
					
					self:SetVar( "hit", true )
					self:Fire( "Kill", "", 20 )
					if hitEnt:IsPlayer() or hitEnt:IsNPC() or hitEnt.Type == "nextbot" or hitEnt:GetClass() == "prop_ragdoll" then
					sound.Play( Sound( "weapons/shuriken/hit" .. math.random(1, 3) .. ".wav" ), self:GetPos() )
					else
					sound.Play( Sound( "physics/metal/sawblade_stick" .. math.random(1, 3) .. ".wav" ), self:GetPos() )
					end
				end
			end
		end
	end
end