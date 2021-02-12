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
	
	timer.Simple(2,function()
		if IsValid(self) then self.active = false self:Explode() self:Remove() end
	end)
	self:Think()
end

function ENT:Think()
end

function ENT:Explode()
if SERVER then
	local ent = ents.Create("ent_acidnade")
	if IsValid(ent) then
			ent.HitPos = self:GetPos()
			ent:SetPos(self:GetPos())
			ent:Spawn()
			ent.Owner = self.Owner
			ent:SSetMiddleAndStart(self:GetPos())
			net.Start("DoHSplashAnim")
			net.WriteVector(self:GetPos())
			net.Broadcast()
	end
	SafeRemoveEntityDelayed(self, 0)
end
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