AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	
	if SERVER then
		self:SetModel( "models/weapons/tfa_csgo/w_eq_decoy_thrown.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_NONE )
		self:DrawShadow( false )
	end
	
	self.particleCreated = false
	
	self:EmitSound("TFA_CSGO_Decoy.Throw")
	
	timer.Simple(15,function()
		if IsValid(self) then self.active = false self:Explode() self:Remove() end
	end)
	self:Think()
end

 function ENT:Think()
	
	if !self.lasttick then self.lasttick = CurTime()-0.1 end
	if self:GetVelocity():Length()<5 then
		self.active = true
		if self.ParticleCreated ~= true then
			local ground = ents.Create( "info_particle_system" )
			ground:SetKeyValue( "effect_name", "weapon_decoy_ground_effect" )
			ground:SetOwner( self )
			ground:SetPos(self:GetAttachment(1).Pos)
			ground:SetParent(self)
			ground:Spawn()
			ground:Activate()
			ground:Fire( "start", "", 0 )
			ground:Fire( "kill", "", 15 )
			self.ParticleCreated = true
		end
		if math.random(1,1/(CurTime()-self.lasttick)*2)==1 and IsValid(self.Owner) then
			local bul = {}
			bul.Attacker = self.Owner
			bul.Inflictor = self
			bul.Damage = 0
			bul.Force = 0.1
			bul.Dir = Vector(0,0,-1)
			bul.Tracer = 0
			bul.Spread = vector_origin
			bul.Src = self:GetPos()
			self.Owner:FireBullets(bul,true)
			local fsound = Sound("weapons/tfa_csgo/ak47/ak47-1-distant.wav")
			if self.Owner.GetActiveWeapon then
				local wep = self.Owner:GetActiveWeapon()
				if IsValid(wep) and wep.Primary and wep.Primary.Sound then
					fsound = wep.Primary.Sound
				end
			end
			self:EmitSound(fsound)
			local shot = ents.Create( "info_particle_system" )
			shot:SetKeyValue( "effect_name", "weapon_decoy_ground_effect_shot" )
			shot:SetOwner( self )
			shot:SetPos( self:GetAttachment(1).Pos )
			shot:SetParent(self)
			shot:Spawn()
			shot:Activate()
			shot:Fire( "start", "", 0 )
			shot:Fire( "kill", "", 0.001 )
		end
	end
	
	self.lasttick=CurTime()
	self:NextThink(CurTime())
	return true
end

function ENT:Explode()
if SERVER then
		local explode = ents.Create( "info_particle_system" )
		explode:SetKeyValue( "effect_name", "explosion_hegrenade_brief" )
		explode:SetOwner( self.Owner )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:Activate()
		explode:Fire( "start", "", 0 )
		explode:Fire( "kill", "", 15 )
		local explode2 = ents.Create( "info_particle_system" )
		explode2:SetKeyValue( "effect_name", "explosion_hegrenade_interior" )
		explode2:SetOwner( self.Owner )
		explode2:SetPos( self:GetPos() )
		explode2:Spawn()
		explode2:Activate()
		explode2:Fire( "start", "", 0 )
		explode2:Fire( "kill", "", 15 )
	self:EmitSound( "TFA_CSGO_BaseGrenade.Explode" )
end
	util.BlastDamage( self, self.Owner, self:GetPos(), 354, 7 )
	local spos = self:GetPos()
	local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-32), filter=self})
	util.Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


function ENT:StartTouch( otherent )
	self:ResolveFlyCollisionCustom( self:GetTouchTrace() , self:GetVelocity() )
end

function ENT:Touch( otherent )
	if otherent == self:GetThrower() then
		return
	end
	
	self:BounceSound()
end

local function PhysicsClipVelocity( inv, normal, out, overbounce )
	local	backoff
	local	change = 0
	local	angle
	local	i
	
	local STOP_EPSILON = 0.1
	
	angle = normal.z
	
	backoff = inv:DotProduct( normal ) * overbounce
	
	for i = 1 , 3 do
		change = normal[i] * backoff
		out[i] = inv[i] - change
		if out[i] > -STOP_EPSILON and out[i] < STOP_EPSILON then
			out[i] = 0
		end
	end
end


local function PhysicsCheckSweep( pEntity, vecAbsStart, vecAbsDelta, pTrace )
	local mask = MASK_SOLID 	--Jvs: fuck, no binding for it pEntity->PhysicsSolidMaskForEntity()
	
	
	local vecAbsEnd = vecAbsStart + vecAbsDelta
	-- Set collision type
	if not pEntity:IsSolid() then --|| pEntity->IsSolidFlagSet( FSOLID_VOLUME_CONTENTS) )
		if IsValid( pEntity:GetMoveParent() ) then
			pTrace.Fraction = 1
			pTrace.FractionLeftSolid = 0
			return
		end
	end
	--[[
	UTIL_TraceEntity( pBaseEntity, vecAbsStart, vecAbsEnd, mask, pTrace )
	]]
end


function ENT:PhysicsPushEntity( push, pTrace )
	-- NOTE: absorigin and origin must be equal because there is no moveparent
	local prevOrigin = self:GetPos() * 1
	PhysicsCheckSweep( self, prevOrigin, push, pTrace )

	if pTrace.Fraction == 1 then
		self:SetPos( pTrace.HitPos )

		-- FIXME(ywb):  Should we try to enable this here
		-- WakeRestingObjects()
	end
end

local function IsStandable( ent )
	return ent:GetSolid() == SOLID_BSP or ent:GetSolid() == SOLID_VPHYSICS or ent:GetSolid() == SOLID_BBOX
end

function ENT:ResolveFlyCollisionCustom( trace , vecVelocity )
	
	--Assume all surfaces have the same elasticity
	local flSurfaceElasticity = 1

	--Don't bounce off of players with perfect elasticity
	if IsValid( trace.Entity ) and trace.Entity:IsPlayer() then
		flSurfaceElasticity = 0.3
	end

	-- if its breakable glass and we kill it, don't bounce.
	-- give some damage to the glass, and if it breaks, pass 
	-- through it.
	local breakthrough = false

	if IsValid( trace.Entity ) and trace.Entity:GetClass() == "func_breakable" then
		breakthrough = true
	end

	if IsValid( trace.Entity ) and trace.Entity:GetClass() == "func_breakable_surf" then
		breakthrough = true
	end
	--[[
	if breakthrough then
		local info = DamageInfo()
		info:SetAttacker( self )
		info:SetInflictor( self )
		info:SetDamageForce( vecVelocity )
		info:SetDamagePosition( self:GetPos() )
		info:SetDamageType( DMG_CLUB )
		info:SetDamage( 10 )
		trace.Entity:DispatchTraceAttack( info , trace , vecVelocity )
		
		if trace.Entity:Health() <= 0 then
			-- slow our flight a little bit
			local vel = vecVelocity
			vel = vel * 0.4
			self:SetVelocity( vel )
			return
		end
	end
	]]
	
	local flTotalElasticity = self:GetElasticity() * flSurfaceElasticity
	flTotalElasticity = math.Clamp( flTotalElasticity, 0, 0.9 )

	-- NOTE: A backoff of 2.0f is a reflection
	local vecAbsVelocity = Vector()
	PhysicsClipVelocity( vecVelocity, trace.Normal, vecAbsVelocity, 2.0 )
	vecAbsVelocity = vecAbsVelocity * flTotalElasticity

	-- Get the total velocity (player + conveyors, etc.)
	--VectorAdd( vecAbsVelocity, GetBaseVelocity(), vecVelocity )
	local flSpeedSqr = vecVelocity:DotProduct( vecVelocity )

	-- Stop if on ground.
	if trace.Normal.z > 0.7 then			-- Floor
		-- Verify that we have an entity.
		local pEntity = trace.Entity
		
		self:SetVelocity( vecAbsVelocity )
		if flSpeedSqr < ( 30 * 30 ) then
			if IsStandable( pEntity ) then
				self:SetGroundEntity( pEntity )
			end

			-- Reset velocities.
			self:SetVelocity( vector_origin )
			self:SetLocalAngularVelocity( angle_zero )

			--align to the ground so we're not standing on end
			local angle = trace.Normal:Angle()

			-- rotate randomly in yaw
			angle[1] = math.random( 0, 360 )

			-- TODO: rotate around trace.plane.normal
			
			self:SetAngles( angle )			
		
		else
		
			
			local vecDelta = vecVelocity - vecAbsVelocity	
			local vecBaseDir = vecVelocity
			vecBaseDir:Normalize()
			
			local flScale = vecDelta:Dot( vecBaseDir )
			
			local ft = ( 1.0 - trace.Fraction ) * FrameTime()
			
			vecVelocity = vecAbsVelocity * ft
			
			vecVelocity = vecVelocity + ( vecDelta * flScale ) * ft
			
			self:PhysicsPushEntity( vecVelocity, trace )
			
		end
		
		
	else
		-- If we get *too* slow, we'll stick without ever coming to rest because
		-- we'll get pushed down by gravity faster than we can escape from the wall.
		if flSpeedSqr < ( 30 * 30 ) then
			-- Reset velocities.
			self:SetVelocity( vector_origin )
			self:SetLocalAngularVelocity( angle_zero )
		else
			self:SetVelocity( vecAbsVelocity )
		end
	end
	
	self:BounceSound()

end