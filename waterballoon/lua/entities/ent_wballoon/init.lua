AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel("models/maxofs2d/balloon_classic.mdl") 
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	self.Entity:DrawShadow( true )
	self.Entity:SetCollisionGroup( SOLID_VPHYSICS )
	self.Entity:SetModelScale( 0.5, 0 )
end

function ENT:PhysicsCollide()
	self:Explosion()		
end

function ENT:Explosion()

	pos = self.Entity:GetPos()
	local splash = EffectData()
	splash:SetOrigin(pos)
	splash:SetEntity(self.Owner)
	splash:SetScale(10)
	util.Effect("watersplash", splash)
	for id, prop in pairs( ents.FindInSphere( pos, 80 ) ) do
		if ( prop:GetPos():Distance( self:GetPos() ) < 256 ) then
			if ( prop:IsValid() ) then
				--if ( prop:IsOnFire() ) then prop:Extinguish() end

				local class = prop:GetClass()
				if ( string.find( class, "ent_minecraft_torch" ) and prop:GetWorking() ) then
					prop:SetWorking( false )
				--elseif ( string.find( class, "env_fire" ) ) then
				--	prop:Fire( "Extinguish" )
				elseif ( string.find( class, "npc_manhack") or string.find( class, "npc_combine_camera") or string.find( class, "npc_cscanner") or string.find( class, "npc_rollermine") or string.find( class, "npc_clawscanner") or string.find( class, "npc_turret_floor") or string.find( class, "npc_turret_ceiling")) then
					local sparks = EffectData()
					sparks:SetOrigin(prop:GetPos())
					sparks:SetEntity(prop)
					sparks:SetScale(10)
					util.Effect("ManhackSparks", sparks)
					prop:EmitSound( Sound( "ambient/energy/zap1.wav" ), 50)
					prop:TakeDamage( 12, prop, prop )
					timer.Simple(1.66,function() if not IsValid(prop) then return end sparks:SetOrigin(prop:GetPos()) util.Effect("ManhackSparks", sparks)
					prop:EmitSound( Sound( "ambient/energy/zap1.wav" ), 50) prop:TakeDamage( 12, prop, prop ) end)
					timer.Simple(3.33,function() if not IsValid(prop) then return end sparks:SetOrigin(prop:GetPos()) util.Effect("ManhackSparks", sparks)
					prop:EmitSound( Sound( "ambient/energy/zap1.wav" ), 50) prop:TakeDamage( 12, prop, prop ) end)
					timer.Simple(5,function() if not IsValid(prop) then return end prop:TakeDamage( 99, prop, prop ) end)
					timer.Simple(5.5,function() if not IsValid(prop) then return end sparks:SetOrigin(prop:GetPos()) util.Effect("Explosion", sparks) prop:Remove() end)
				elseif SERVER and prop:IsPlayer() and prop:GetNClass() == ROLE_SCP457 and _scp457_disable then
					_scp457_disable(prop, 7.5)
				end
			end
		end
	end
	timer.Simple(0.01,function() self.Entity:Remove() self.Entity:EmitSound("garrysmod/balloon_pop_cute.wav") end) --Gay workaround to stopping spam on console
end