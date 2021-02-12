--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v17 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Base content and shared functions.					--
-- Basic information.											--
-- Initialize function can be by overridden by the entity. 		--
-- Reaktion on water via Think().								--
-- Damage dealing functions.									--
-- Entity initialization auto-calls SubInit().					--
-- Does the base init. and entity authoring.					--
-- I basically tried to put as much as possible in the header. 	--
-- Custom function SubInit() will always be called on the server--
------------------------------------------------------------------
-- Has to be included by a fake entity.							--
------------------------------------------------------------------

AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )
AddCSLuaFile( "base/scifi_elementals.lua" )
include( "base/scifi_elementals.lua" )

local m_random 			= math.random
local m_tan 			= math.tan
local m_Clamp 			= math.Clamp

local cmd_debug_dmgranges			= GetConVar( "sfw_debug_showdmgranges" )
local cmd_debug_legacydeathevent 	= GetConVar( "sfw_debug_legacydeathevent" )
local cmd_debug_forcenewhitmechanic = GetConVar( "sfw_debug_forcenewhitmechanic" )
local cmd_fx_bloomstyle	 			= GetConVar( "sfw_fx_bloomstyle" )
local cmd_fx_bloomscale 			= GetConVar( "sfw_fx_bloomscale" )
local cmd_fx_particles				= GetConVar( "sfw_fx_particles" )
local cmd_fx_sprites				= GetConVar( "sfw_fx_sprites" )
local cmd_fx_lights 				= GetConVar( "sfw_fx_lightemission" )
local cmd_fx_lights_forcelegacy 	= GetConVar( "sfw_fx_lightemission_force_legacy" )
local cmd_fx_lights_projextures 	= GetConVar( "sfw_fx_projexturelighting" )
local cmd_meteor_ignoreallies		= GetConVar( "sfw_meteor_ignoreallies" )
local cmd_projexturelighting 		= GetConVar( "sfw_fx_projexturelighting" )

PROJECTILE_RULE_IGNORE		= 0
PROJECTILE_RULE_KILLME		= 1
PROJECTILE_RULE_XPLODE		= 2
PROJECTILE_RULE_PHXCOLLIDE	= 3

local NotiColor	= Color( 255, 80, 175 )

local bloomstyle_0 = Material( "bloom/halo_static" )
local bloomstyle_1 = Material( "sprites/light_ignorez" )
local bloomstyle_2 = Material( "bloom/halo_static_2" )
--local bloomstyle_3 = ...

local function GetBloomStyle()

	local iStyle = cmd_fx_bloomstyle:GetInt()

	if ( iStyle <= 0 || iStyle > 2 || !iStyle ) then
		return bloomstyle_0
	end
	
	if ( iStyle == 1 ) then
		return bloomstyle_1
	end
	
	if ( iStyle == 2 ) then
		return bloomstyle_2
	end

end

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName 		= "SciFi Projectile"
ENT.Author 			= "Darken217"
ENT.Spawnable 		= false											-- Don't show this entity in the spawn menu. IHL also checks for this when labelling SENTs. 
ENT.AdminSpawnable 	= false											-- No, not even for admins.
ENT.DisableDuplicator =	true										-- Thou shallt not dupeth my entities.

ENT.NewHitMechanic 	= false											-- Use a hull-trace impact detection instead of physics based collision events. Requires ENT.SvThinkDelay to be as low as possible (i.e. 0).
ENT.NewHitMechanicOnWorld = false									-- Unless set to true, projectiles will use classic collision events on world objects, instead of trace based detection.
ENT.CollisionProxySize = Vector( 16, 8, 8 )							-- Sizes of the impact detection hull used by NewHitMechanic. Does NOT interefer with actual physics. If not set to a vector, an aproximation of the physics size will be used.
ENT.SvThinkDelay	= 0.12											-- The entity's SERVER SIDED think delay. Lower delay = higher think rate = more accuracy, Higher delay = less networking = better performance
ENT.ClThinkDelay 	= 0												-- The same as above, but CLIENT SIDED.
ENT.LagCompensated 	= false 										-- Lag compensation. Allows the entity to be lag compensated during Player:LagCompensation().

ENT.RShadow 		= false 										-- Render shadows?
ENT.RMdl 			= "models/dav0r/hoverball.mdl"					-- Placeholder model
ENT.RMat 			= "vgui/white" 										-- Placeholder material

ENT.Phx 			= SOLID_BBOX									-- Solidity.
ENT.PhxStatic		= false											-- Set this to true, if the entity should NEVER move.
ENT.PhxMaxVelocity  = 5120											-- Global rule for physical maximum velocity.
ENT.PhxFlag			= FSOLID_NOT_STANDABLE							-- You can't walk or stand on this thingy.
ENT.PhxMType 		= MOVETYPE_FLYGRAVITY -- bit.bor( MOVETYPE_FLY, MOVETYPE_CUSTOM ) ?
ENT.PhxMColl		= MOVECOLLIDE_FLY_CUSTOM 						-- Just ... just accept this, ok? Alternatively:  MOVECOLLIDE_FLY_BOUNCE
ENT.PhxCGroup 		= COLLISION_GROUP_PROJECTILE  					-- Collision group. This determines, what can collide with the entity. Alternatively: COLLISION_GROUP_NONE
ENT.PhxSSize		= 5 											-- Set this to nil, if you want to use the model's collision mesh.
ENT.PhxSProp 		= "default_silent"								-- The entity's surface prop. This also effects collision sounds and underwater behaviour (only, if gravity is enabled!) 
ENT.PhxMass 		= 1												-- Physical mass.
ENT.PhxGrav			= false											-- Gravity?
ENT.PhxDrag			= false											-- Drag?
ENT.PhxDragAmount	= 1												-- Drag???
ENT.PhxElastic		= 4294967296									-- dem bounces...
ENT.PhxBuoyancy 	= 0 											-- The entities buoyancy, reaching from 0 to 1.
ENT.PhxUseFlags		= false											-- Use flags to give this entity an optimized place in the game's physics. Disable this, if you're planning to create an item or something, the player should be able to grab.

ENT.LifeTime		= 2.5											-- The entities life time. Once expired, the entity will be removed automatically.
ENT.KillSilentDelay = 0.005											-- Duration of the death event. This can be overriden without changing this particular value and won't be used at all, if the legacy death event is used.
ENT.OnWater			= PROJECTILE_RULE_XPLODE						-- Simplified behaviour rules on a certain event. Those can be either ignored or overridden, of cause. There are things like call Xplode on event or pretend, it's a physical collision and stuff.
ENT.OnDamaged		= PROJECTILE_RULE_IGNORE

ENT.FxTracerNew	 	= false											-- Use the new method to attach particles to a projectile. This is forced client-side and more adjustable, but may cause issues in multiplayer.
ENT.FxTracer 		= "ngen_core_small"								-- Particle effect attached on spawn.
ENT.FxAttachType 	= PATTACH_ABSORIGIN_FOLLOW
ENT.FXAttachId		= 0
ENT.FxOffset		= Vector( 0, 0, 0 )

ENT.LightEmit		= true											-- Emit dynamic light. This works pretty much the same as the standard gmod_light entity.
ENT.LightOrigin 	= nil											-- Place the light origin on a given attachment point, if available. Set this to the desired attachment ID, if you intend on using it. Does NOT work with legacy lights.
ENT.LightColor		= "220 200 255 255"
ENT.LightSpotRadius	= 240
ENT.LightDistance	= 280
ENT.LightBrightness	= 1
ENT.LightXplode 	= 2 											-- Brightness multiplier to fake a bright explosion without adding a new light source. Does only apply while self:GetXPlode() returns true. Also effects light distance by 50%.
ENT.LightStyle 		= 0
ENT.LightDecay		= 2048
ENT.LightDieTime	= 1
ENT.LightRealistic  = false											-- Enables the use of env_projectedtexture based lighting, which is by far more realistic then default lighting but burns performance. You should avoid using this.
ENT.LightFlare		= true											-- Draw a fake bloom effect around a glowing entity?
ENT.LightFlareMat 	= GetBloomStyle()								-- Effect texture. This will be derived from the internal system, unless overridden. ToDo: Not-additive FX texture?
ENT.LightFlareColor = nil											-- Effect color can be overridden manually and is otherwise derived from the set or default self.LightColor, excluding the alpha value. -- Color( 255, 255, 255 )
ENT.LightFlareAlpha	= 4												-- Transparency. The effect itself will be rendered additively, so you should be careful with higher alpha values.
ENT.LightFlareAdd 	= false 										-- Fake self-additive rendering. The LightFlare should be always be additive regardless. This enables to render it twice with different sizes simultaniously to create a glowing effect outside a particle.
ENT.LightFlareSize 	= 0.52											-- Effect size scaling. The glow's size is computed of self.LightDistance * self.LightFlareSize.
ENT.LightFlarePos 	= nil 											-- Offset along the entity's z-axis, given the y-axis is the top direction. This offset is relative to the entity's position in the world.
ENT.LensFlare 		= false											-- Draw a lense-flare effect. This will be the size of the light flare +60%. It also follows the same rules for positioning and computation. Note, that this effect can't be colored.
ENT.LensFlareMat 	= Material( "bloom/lflare_default" )			-- The lens-flare material to be used.

ENT.SndImpact 		= "cat.ca3.hit"									-- Sound played by the XPlode() function.
ENT.SoundEmit		= false											-- Emit a sound on Think(). This can be used for faked fly-by sounds.
ENT.SoundFile		= ""											-- The sound ID to play. For example "scifi.dmg.acidburn".
ENT.SoundRate 		= 0												-- Delay in seconds until the next sound is played. Keep in mind, that the minimum of this is equal to the entity's think rate.
ENT.SoundNext 		= 0
ENT.SoundDistance 	= 160

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "MTarLocked" ) 	-- Meteor targeting. Is a target locked?
	self:NetworkVar( "Bool", 1, "XPloding" ) 	-- Is the XPlode() function running or was it triggered?
--	self:NetworkVar( "Int", 0, "LifeTime" )
--	self:NetworkVar( "Vector", 0, "Pos" )

end

function ENT:SetupLighting()

	if ( !self.LightEmit ) then return end
	local iProjections = cmd_projexturelighting:GetInt()
	local bLights = cmd_fx_lights:GetBool()
	local bLightsLegacy = cmd_fx_lights_forcelegacy:GetBool()

	if ( bLights ) && ( bLightsLegacy ) then
		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx2 ) ) then return end
		fx2:SetKeyValue( "_light", self.LightColor )
		fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius )
		fx2:SetKeyValue( "distance", self.LightDistance )
		fx2:SetKeyValue( "brightness", self.LightBrightness )
		fx2:SetPos( self:GetPos() )
		fx2:SetParent( self )
		fx2:Spawn()
		--fx2:Fire( "kill", "", self.LifeTime )
	end
	
	if ( iProjections == 1 && self.LightRealistic ) || ( iProjections == 2 ) then
		local pos = self:GetPos() 
		local ang = self:GetAngles()
		local clr = self.LightColor
		
		if ( self.LightOrigin ) then
			local att = self:GetAttachment( self.LightOrigin )
			pos = att.Pos
		end

		if ( !isstring( clr ) ) then
			clr = clr.r .. " " .. clr.g .. " " .. clr.b .. " " .. clr.a
		end

		local sides = {
			["up"] = { dir = ang:Up() },
			["dn"] = { dir = ang:Up() * -1 },
			["rt"] = { dir = ang:Right() },
			["lf"] = { dir = ang:Right() * -1 },
			["fw"] = { dir = ang:Forward() },
			["bk"] = { dir = ang:Forward() * -1 }
		}

		for k,v in pairs ( sides ) do
			local realtime = ents.Create( "env_projectedtexture" )
			realtime:SetPos( pos )
			realtime:SetAngles( v.dir:Angle() )	
			realtime:SetParent( self )		
			realtime:SetKeyValue( "lightfov", 90 )
			realtime:SetKeyValue( "lightworld", 1 )	
			realtime:SetKeyValue( "lightcolor", clr )
			realtime:SetKeyValue( "enableshadows", 1 )
			realtime:SetKeyValue( "farz", self.LightDistance * 1 )
			realtime:SetKeyValue( "nearz", 8 )
			realtime:SetKeyValue( "Ambient", self.LightStyle )
			realtime:Fire( "SpotlightTexture", "vgui/white", 0 )
			realtime:Fire( "Ambient", self.LightStyle, 0 )
		end
	end
		
end

function ENT:Initialize()

	self.DieTime = CurTime() + self.LifeTime
	
	local bForceTraceDetection = cmd_debug_forcenewhitmechanic:GetBool()
	if ( bForceTraceDetection ) then
		self.NewHitMechanic = true
		self.ClThinkDelay = 0
		self.SvThinkDelay = 0
	end

	local size = self.PhxSSize
	
	if ( self.Phx ~= SOLID_NONE ) then self:PhysicsInit( self.Phx ) end
	if ( self.PhxFlag ~= "" ) then self:SetSolidFlags( self.PhxFlag ) end
	
	if ( self.PhxStatic  ) then
		self:PhysicsInitShadow( false, false )
	end
	
	if ( SERVER ) then
		self:NextThink( CurTime() + self.SvThinkDelay )
	
		if ( self.LagCompensated ) then
			self:SetLagCompensated( true ) 
		end
		
		self:SetNoDraw( false )
		self:DrawShadow( self.RShadow )
		
		if ( self.Type == "anim" ) then
			if ( self.RMdl && self.RMdl ~= "" ) && ( util.IsValidModel( self.RMdl ) ) then
				self:SetModel( self.RMdl )
			else
				self:SetModel( "models/dav0r/hoverball.mdl" )
			end
		end
		
		if ( self.RMat ~= "" ) then
			self:SetMaterial( self.RMat )
		else
			self:SetMaterial( "vgui/white" )
		end
		
		if ( self.Phx == SOLID_VPHYSICS ) then
			self:SetMoveType( MOVETYPE_VPHYSICS )
		else
			self:SetMoveType( self.PhxMType )
			self:SetMoveCollide( self.PhxMColl )
		end
	
		if ( size ~= nil && isnumber( size ) ) then
			self:PhysicsInitSphere( size, self.PhxSProp )
			self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
		else
			self:PhysicsInit( SOLID_VPHYSICS )
			self:SetSolid( SOLID_VPHYSICS )
			self:SetCollisionGroup( COLLISION_GROUP_NONE )
			self:SetCollisionBounds( self:GetModelBounds() )
		end
		
		self:SetCollisionGroup( self.PhxCGroup )
		self:SetElasticity( self.PhxElastic )
		
		local phys = self:GetPhysicsObject()
		if ( !IsValid( phys ) ) then DevMsg( "@"..self:GetClass().." : !Error; Invalid physics object. Removing! " ) self:Remove() return end
		phys:SetMass( self.PhxMass )
		phys:EnableGravity( self.PhxGrav )
		phys:EnableDrag( self.PhxDrag )
		phys:SetBuoyancyRatio( self.PhxBuoyancy )
		if ( self.PhxDrag ) then
			phys:SetDragCoefficient( self.PhxDragAmount )
		end
		phys:Wake()
		
		if ( self.PhxUseFlags ) then
			self:AddFlags( FL_FLY )
			self:AddFlags( FL_OBJECT )
			self:AddFlags( FL_BASEVELOCITY )
			self:AddEFlags( EFL_NO_WATER_VELOCITY_CHANGE )
		end

		phys:AddGameFlag( FVPHYSICS_WAS_THROWN )
		phys:AddGameFlag( FVPHYSICS_NO_NPC_IMPACT_DMG )

		if ( self.LifeTime > 0 ) then
		--	self:SetLifeTime( self.LifeTime )
			self:SetPhysicsAttacker( self.Owner, self.LifeTime )
		end
		
		self:SetupLighting()
		
		local velo_global = physenv.GetPerformanceSettings() -- One does not simple adjust global settings...
		velo_global.MaxVelocity = self.PhxMaxVelocity 
		physenv.SetPerformanceSettings( velo_global )
	end
	
	local bSprites = cmd_fx_sprites:GetBool()
	if ( CLIENT ) && ( bSprites ) then
		self.PixVis = util.GetPixelVisibleHandle()
	end
	
	if ( !self.FxTracerNew ) && ( self.FxTracer ~= nil ) && ( ( !game.SinglePlayer() && CLIENT ) || SERVER ) then
		ParticleEffectAttach( self.FxTracer, self.FxAttachType, self, self.FXAttachId )
	end

	if ( self.FxTracerNew ) && ( self.FxTracer ~= nil ) && ( CLIENT ) then
		CreateParticleSystem( self, self.FxTracer, self.FxAttachType, self.FXAttachId, self.FxOffset ) 
	end
	
	if ( IsValid( self ) ) then
		self:SubInit( self, self:GetPhysicsObject() )
	end

end

function ENT:CanEmitLight()

	local bLights = cmd_fx_lights:GetBool()
	local bLightsLegacy = cmd_fx_lights_forcelegacy:GetBool()
	local iProjextures = cmd_fx_lights_projextures:GetInt()

	if ( !bLights ) then 
		return false
	end
	
	if ( bLightsLegacy ) then
		return false
	end
	
	if ( iProjextures == 2 ) then
		return false
	end

	if ( self.LightEmit && self.LightRealistic && iProjextures == 0 ) then 
		return true
	end
	
	if ( self.LightEmit ) then
		return true
	else
		return false
	end
	
end

function ENT:OnThinkLighting()

	local dlight = DynamicLight( self:EntIndex() )
	local clr = self.LightColor
	if ( isstring( self.LightColor ) ) then
		clr = string.ToColor( clr )
	end
	
	local brt = self.LightBrightness
	local dist = self.LightDistance
	if ( self:GetXPloding() ) then
		brt = brt * self.LightXplode
		dist = dist * ( self.LightXplode / 2 )
	end
	
	local pos = self:GetPos()
	if ( self.LightOrigin ) then
		local att = self:GetAttachment( self.LightOrigin )
		if( !att || !att.Pos ) then
			pos = nil
		end
		
		if ( !isvector( pos ) ) then
			pos = self:GetPos()
			DevMsg( "@" .. self:GetClass() .. " : !Error, Failed to get attachment position (" .. self.LightOrigin.. "). Defaulting to entity origin..." )
		end
	end
	
	if ( dlight ) then
		dlight.pos = pos
		dlight.r = clr.r
		dlight.g = clr.g
		dlight.b = clr.b
		dlight.brightness = brt
		dlight.Decay = self.LightDecay
		dlight.Size = dist
		dlight.Style = self.LightStlye
		dlight.DieTime = CurTime() + self.LightDieTime
		dlight.noworld = false
		dlight.nomodel = false
	end

end

function ENT:OnThinkRules()

 	if ( self.OnWater ~= PROJECTILE_RULE_IGNORE ) || ( self.OnWater == nil ) then
		if ( self:WaterLevel() > 0 ) then
			if ( self.OnWater == PROJECTILE_RULE_KILLME ) then
				if ( SERVER ) then
					local bParticle = cmd_fx_particles:GetBool()
					if ( bParticle ) && ( m_random( 0, 100 ) < 20 ) then
						ParticleEffect( "event_onwater_remove", self:GetPos(), self:GetAngles(), fx )
					end
					self:Remove()
				end
			elseif ( self.OnWater == PROJECTILE_RULE_PHXCOLLIDE ) then
				self:PhysicsCollide()
			elseif ( self.OnWater == PROJECTILE_RULE_XPLODE ) then
				self:XPlode()
			end
		end
	end

end

--hook.Add( "SciFiProjectileLighting", ENT, ENT.OnThinkLighting )
--hook.Add( "SciFiProjectileRules", ENT, ENT.OnThinkRules )

function ENT:OnThinkCollisionProxy()
	
	local eOrigin = self:GetPos()
	local eAngles = self:GetAngles()
	local eOffset = eAngles:Forward()

	local trData = {}
	local trResult = {}

	trData.start 		= eOrigin - eOffset * 4
	trData.endpos 		= eOrigin + eOffset * 4
	trData.filter 		= function( ent ) 	
							if !( ent || IsValid( ent ) ) then 
								return false
							end
							
							if ( ent:GetClass() == self.ClassName ) then
								return false
							end
							
							if ( ent == self || ent == self.Owner || ent:GetOwner() == self.Owner ) then 
								return false
							end

							return true 
						end
	
	trData.mins 		= self.CollisionProxySize * -1
	trData.maxs 		= self.CollisionProxySize
	trData.mask 		= MASK_SHOT_HULL
	trData.ignoreworld 	= true
	trData.output 		= trResult

	util.TraceHull( trData )

	local lnData = {}
	local lnResult = {}

	lnData.start 		= eOrigin - eOffset * 64
	lnData.endpos 		= eOrigin + eOffset * 64
	lnData.filter 		= trData.filter
	lnData.mask 		= MASK_SHOT_HULL
	lnData.ignoreworld 	= true
	lnData.output 		= lnResult
	
	util.TraceLine( lnData )
	
	if ( SERVER ) && ( trResult.HitSky || lnResult.HitSky ) && ( !self:GetXPloding() ) then
		self:SetXPloding( true )
		self:Remove()
	end

	if ( SERVER ) && ( lnResult.Hit || trResult.Hit ) && ( !self:GetXPloding() ) then
		local data
		if ( trResult.Hit ) then
			data = trResult
		--	print( "Hit via hull-trace " .. tostring(data), trResult.Entity )
		else
			data = lnResult
		--	print( "Hit via line-trace " .. tostring(data), lnResult.Entity )
		end

		self:XPlode( data )
	end
	
end

local bLighting = false
local iSoundDistance = 0
function ENT:Think()

	self:OnThinkRules()
	
	if ( self.NewHitMechanic ) then
		self:OnThinkCollisionProxy()
	end

	bLighting = self:CanEmitLight()
	if ( CLIENT ) && ( self:CanEmitLight() ) then
		self:OnThinkLighting()
	end
	
	if ( CLIENT ) && ( self.SoundEmit  ) then
		local vOrigin = EyePos()
		local eOrigin = self:GetPos()
		
		local vDist = vOrigin:Distance( eOrigin )
		
		if ( vDist < self.SoundDistance && iSoundDistance > self.SoundDistance ) then
			self:EmitSound( self.SoundFile )
		end
		
		iSoundDistance = vDist
	end
	
	self:SubThink( self )
	
	if ( CLIENT ) then
		self:SetNextClientThink( self.ClThinkDelay )
	end
	
	if ( SERVER ) then
		self:NextThink( CurTime() + self.SvThinkDelay )
		
		if ( IsValid( self ) ) && ( self.LifeTime > 0 ) && ( self.DieTime <= CurTime() ) then
			self:Remove()
		end
	end
	
	return true 

end

function ENT:SubInit( ent, phys )
 -- will be ran on Initialize().
end

function ENT:SubThink( ent )
 -- can be overridden by the child-entity, to do things per Think() without actually overriding the Think() function.
end

function ENT:Draw()

	self:DrawModel()
	
	local bSprites = cmd_fx_sprites:GetBool()

	if ( bSprites ) && ( self.LightEmit && self.LightFlare ) && ( self.LightFlareMat ~= nil ) then
		local ply = GetViewEntity() --LocalPlayer()
		local pos = self:GetPos()
		local origin = pos

		if ( self.LightFlarePos ) && ( !self.Owner:IsNPC() ) then
			local ang = self:GetAngles()
			local fw = ang:Forward()
	
			origin = pos + fw * self.LightFlarePos
		end
		
		if ( !self.PixVis || self.PixVis == nil ) then DevMsg( "@"..self:GetClass().." : !Error;  Failed to create PixVis handle! Check your init!" ) return end
		local isvisible	= util.PixelVisible( origin, 4, self.PixVis )	
	
		if ( !isvisible || isvisible < 0.1 ) then return end
		local color_1
		local alpha = self.LightFlareAlpha * ( isvisible )
		local bscale = cmd_fx_bloomscale:GetFloat()
		
		local plyview = ply:EyeAngles():Forward()
		local entview = origin - ply:EyePos() + Vector( self.LightFlareSize )
		local iscale = m_Clamp( m_tan( plyview:Dot( ( entview ):GetNormalized() ) ) - 0.4, 0, 1 )

		if ( self.LightFlareColor ) then
			color_1 = self.LightFlareColor
		else
			if ( isstring( self.LightColor ) ) then
				color_1 = string.ToColor( self.LightColor )
			else
				color_1 = self.LightColor
			end
		end

		if ( self:GetOwner() ~= LocalPlayer() ) then
			alpha = self.LightFlareAlpha * 1.4 -- magic number?
		end
		
		render.SetMaterial( self.LightFlareMat )
		local size = ( self.LightDistance * self.LightFlareSize ) * ( isvisible ) * ( ( bscale / 10 + 1 ) * ( iscale ) )
		local color = Color( color_1.r, color_1.g, color_1.b, alpha * bscale * iscale )
		
		if ( self.LightFlareAdd ) then
			local color2 = Color( color_1.r, color_1.g, color_1.b, ( alpha * bscale * iscale ) / 2 )

			render.DrawSprite( origin, size * 0.6, size * 0.6, color )
			render.DrawSprite( origin, size * 1.4, size * 1.4, color2 )
		else
			render.DrawSprite( origin, size, size, color )
		end
		
		if ( self.LensFlare ) then
			local color3 = Color( 255, 255, 255, ( alpha * bscale * iscale ) / 3 )
			render.SetMaterial( self.LensFlareMat )
			render.DrawSprite( origin, ( self.LightDistance * self.LightFlareSize ) * 1.6, ( self.LightDistance * self.LightFlareSize ) * 1.6, color3 )
		end
	end

end

function ENT:OnTakeDamage( CTakeDamageInfo )

	if ( self.OnDamaged ~= PROJECTILE_RULE_IGNORE ) then
		if ( self.OnDamaged == PROJECTILE_RULE_KILLME ) then
			if ( SERVER ) then
				self:KillSilent()
			end
		elseif ( self.OnDamaged == PROJECTILE_RULE_XPLODE ) then
			self:XPlode()
		end
	end

end

function ENT:PhysicsCollide( pCollisionData, pPhysicsObject )

	local IsXploding = self:GetXPloding()

	if ( !self.NewHitMechanic ) && ( !IsXploding ) then
		self:XPlode( pCollisionData )
	end
	
	if ( self.NewHitMechanic && !self.NewHitMechanicOnWorld ) && ( pCollisionData.HitEntity:IsWorld() ) && ( !IsXploding ) then
		self:XPlode( pCollisionData )
	end
		
end

function ENT:XPlode( pCollisionData )

	local amp = GetConVar( "sfw_damageamp" ):GetFloat()
	
	if ( SERVER ) then
		self:DealPointDamage( DMG_GENERIC, 8 * amp, self:GetPos(), 128 )
		self:DealAoeDamage( DMG_GENERIC, 16 * amp, self:GetPos(), 64 )
		
		for k,v in pairs ( ents.FindInSphere( self:GetPos(), 16 ) ) do
			if ( v ~= self && v:GetOwner() ~= self.Owner ) then
				DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 5, Attacker = self.Owner } )
				DoElementalEffect( { Element = EML_CORROSIVE, Target = v, Attacker = self.Owner, Inflictor = self } )
				DoElementalEffect( { Element = EML_SHOCK, Target = v, Attacker = self.Owner } )
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 5, Attacker = self.Owner } )
			end
		end
		
		local fx2 = ents.Create( "light_dynamic" )
		if ( !IsValid( fx2 ) ) then return end
		fx2:SetKeyValue( "_light", self.LightColor )
		fx2:SetKeyValue( "spotlight_radius", self.LightSpotRadius * 1.2 )
		fx2:SetKeyValue( "distance", self.LightDistance * 1.2 )
		fx2:SetKeyValue( "brightness", 2 )
		fx2:SetPos( self:GetPos() )
		fx2:SetAngles( self:GetAngles() )
		fx2:Spawn()
		fx2:Fire( "kill", "", 0.115 )

		ParticleEffect( "ngen_hit", fx2:GetPos(), self:GetAngles(), fx )

		util.ScreenShake( fx2:GetPos(), 2, 4, 0.25, 256 )
		self:EmitSound( self.SndImpact )
	end
	
end

function ENT:KillSilent( evForce, evDelay )

	if ( !IsValid( self ) ) then return end
	if ( CLIENT ) then return end
	
	local bLegacydeath = cmd_debug_legacydeathevent:GetBool()

	if ( bLegacydeath ) || ( evForce ) then
		self:Remove()
	else
		local delay = self.KillSilentDelay
		if ( evDelay ) then	
			delay = evDelay
		end
		
--		self:StopSound( self.SoundFile )
		self:StopParticles()
		self:Fire( "kill", "", delay )
	end

end

function ENT:GetValidOwner()

	if ( self.Owner == NULL ) then
		return self
	else
		return self.Owner
	end

end

function ENT:DealAoeDamage( dmgtype, dmgamt, src, range, attacker, forcemul ) -- I've no chance but notice, that my explosion based damaging system is kinda unreliable and difficult to handle.
	
	if ( !forcemul ) then
		forcemul = 1
	end
	
	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( !attacker || !IsValid( attacker ) ) then
		dmg:SetAttacker( self:GetValidOwner() )
	else
		dmg:SetAttacker( attacker )
	end
	dmg:SetInflictor( self )
	dmg:SetDamageForce( Vector( 0, 0, 1 ) * forcemul )
	dmg:SetDamage( dmgamt )
	
	util.BlastDamageInfo( dmg, src, range )
	
	local iDebug = cmd_debug_dmgranges:GetInt()
	
	if ( iDebug >= 1 ) then
		debugoverlay.Sphere( src, range, 0.5, Color( 255, 100, 100, 20 ), false )
		debugoverlay.Sphere( src, range / 2, 0.5, Color( 255, 50, 50, 25 ), false ) 
	end
	
	if ( iDebug >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units." )
	end
	
	if ( iDebug == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units.\n" )
	end

end

function ENT:DealAoeDamageOverTime( dmgtype, dmgamt, src, range, lifetime, tickdelay, parent )

	if ( !parent || !IsValid( parent ) ) then
		parent = self
	end
	
	if ( !tickdelay ) then
		tickdelay = self.SvThinkDelay
	end

	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( !attacker || !IsValid( attacker ) ) then
		dmg:SetAttacker( self:GetValidOwner() )
	else
		dmg:SetAttacker( attacker )
	end
	dmg:SetInflictor( self )
	dmg:SetDamageForce( Vector( 0, 0, 1 ) )
	dmg:SetDamage( dmgamt )
	
	local iDebug = cmd_debug_dmgranges:GetInt()
	
	if ( iDebug >= 1 ) then
		debugoverlay.Sphere( src, range, lifetime, Color( 200, 175, 80, 10 ), false ) 
		debugoverlay.Sphere( src, range / 2, lifetime, Color( 255, 205, 120, 25 ), false ) 
	end
	
	if ( iDebug >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds." )
	end
	
	if ( iDebug == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds.\n" )
	end
	
	if ( !IsValid( parent ) ) then return end

	timer.Create( "hurt" .. parent:EntIndex(), tickdelay, 300, function()
		util.BlastDamageInfo( dmg, src, range )
	end )
	
	timer.Create( "SafeRemoveTimer".. parent:EntIndex(), lifetime, 0, function()
		timer.Remove( "hurt" .. parent:EntIndex() )
		timer.Remove( "SafeRemoveTimer" .. parent:EntIndex() )
	end )

end

function ENT:GetCritMultiplier( hgroup )

	local mul = 1

	if ( hgroup == HITGROUP_HEAD ) then
		mul = 1
	end

	return mul

end

function ENT:DealPointDamage( dmgtype, dmgamt, src, range, dmgforce, hullsize ) -- Alternatively, you can make the projectile shoot a classic bullet on Xplode. This way, you can deal damage the old-fashioned way, while having physical projectiles.

	if ( !dmgforce ) then
		dmgforce = 1
	end
	
	if ( !hullsize ) then
		hullsize = 6
	end
	
	local pOwner = self:GetValidOwner()
	local vDirection = self:GetAngles():Forward()

	local dmg = {}
	dmg.Attacker = pOwner
	dmg.Num = 1
	dmg.Src = src
	dmg.Dir = vDirection
	dmg.Distance = range
	dmg.Tracer = 0
	dmg.Force = dmgforce
	dmg.HullSize = hullsize
	dmg.Damage = dmgamt
--	dmg.AmmoType = "pistol"
	dmg.Callback = function( attacker, tr, dmginfo )
		local iCrit = 1
		
		-- mad hax to avoid stupid bullet time mods from breaking --
		if ( self.GetCritMultiplier ) then
			iCrit = self:GetCritMultiplier( tr.HitGroup )
		end
	
		dmginfo:SetDamageType( dmgtype )
		dmginfo:SetDamage( dmginfo:GetDamage() * iCrit )
	end
	
	pOwner:FireBullets( dmg, false )
	
	local iDebug = cmd_debug_dmgranges:GetInt()
	
	if ( iDebug >= 1 ) then
		debugoverlay.Cross( src, 4, 0.5, Color( 75, 255, 50, 25 ), false ) 
	end
	
	if ( iDebug >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, at a trace result position." )
	end
	
	if ( iDebug == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, at a trace result position.\n" )
	end

end

function ENT:DealDirectDamage( dmgtype, dmgamt, target, attacker, dmgforce, accurateforce ) -- Or, you know, just make it boring by just applying damage.

	if ( !IsValid( target ) ) then return end
	
	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( !attacker || !IsValid( attacker ) ) then
		dmg:SetAttacker( self:GetValidOwner() )
	else
		dmg:SetAttacker( attacker )
	end
	dmg:SetInflictor( self )
	if ( !dmgforce || !isvector( dmgforce ) ) then
		local dmgforce = target:GetPos() - self:GetPos()
		dmgforce:Normalize()
		dmg:SetDamageForce( dmgforce )
	else
		dmg:SetDamageForce( dmgforce )
	end
	dmg:SetDamage( dmgamt )
	
--	if ( target:IsPlayer() || target:IsNPC() ) then
		target:TakeDamageInfo( dmg ) 
--	end
	
	if ( accurateforce ) then
		self:DealAccurateDamageForce( target, dmgforce, dmgamt * 10 )
	end
	
	local iDebug = cmd_debug_dmgranges:GetInt()
	
	if ( iDebug >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring( self ).." dealt "..tostring( dmgamt ).." ("..tostring( dmgtype )..") damage vs. "..tostring( target ) )
	end
	
	if ( iDebug == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring( self ).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage vs. "..tostring( target ).."\n" )
	end
	
end

function ENT:DealAccurateDamageForce( tEntity, vForceDirection, vForceAmount )

	local tPhys = tEntity:GetPhysicsObject()
	local tBones = tEntity:GetPhysicsObjectCount()
	
	local eOffset = self:GetAngles():Forward()
	local vForce = eOffset + vForceDirection
	
	if ( !isnumber( bones ) ) then return end
	for  i=0, bones-1 do
		local tPhysNum = tEntity:GetPhysicsObjectNum( i )
		if ( IsValid( tPhysNum ) ) then
			tPhysNum:ApplyForceOffset( vForceDirection, vForceDirection * -vForceAmount )
		end
	end
	
end

function ENT:MeteorTargeting( scanrange, selfdestruct, selfdestructrange, velomul )

	if ( self.Owner:IsNPC() ) then return end
	if ( !IsValid( self.Owner ) ) then return end

	if ( SERVER ) then
		local scanr = scanrange / 2
		local phys = self:GetPhysicsObject()
		local mpos = self:GetPos()
		local tr = self.Owner:GetEyeTrace()
		
		if ( !velomul ) then velomul = 1.5 end
			
		local tr = util.TraceHull( {
			start = tr.StartPos,
			endpos = tr.HitPos,
			filter = function( ent ) if ( IsValid( ent ) && ( ent:IsNPC() || ( ent:IsPlayer() && ent ~= self.Owner ) ) ) then return true end end,
			mins = Vector( -scanr, -scanr, -scanr ),
			maxs = Vector( scanr, scanr, scanr ),
			mask = MASK_SHOT_HULL,
			ignoreworld = true
		} )

		local tars = ents.FindInSphere( tr.HitPos, scanrange )
		
		if ( tr.Entity:IsValid() && ( tr.Entity ~= NULL && !tr.Entity:IsWorld() && tr.Entity:GetClass() ~= "npc_bullseye" ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) ) then
			table.insert( tars, 1, tr.Entity )
		end

		for k, v in pairs( tars ) do
			if ( IsValid( v ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) ) then
				local bIgnoreAllies = cmd_meteor_ignoreallies:GetBool()
				
				if ( bIgnoreAllies && ( v:IsNPC() && v:Disposition( self.Owner ) ~= D_LI ) || bIgnoreAllies ) || ( v:IsPlayer() ) then
					local tarpos = v:GetPos()

					if ( v:EyePos() ) then
						tarpos = v:EyePos()
					else
						tarpos = v:GetPos()
					end

					if ( IsValid( v ) ) && ( v:IsNPC() || ( v:IsPlayer() && v ~= self.Owner ) ) then
					--	phys:ApplyForceCenter( ( tarpos - mpos ) * ( velomul * ( mpos:Distance( tarpos ) ) ) )
						phys:ApplyForceOffset( ( ( tarpos - mpos ) * mpos:Distance( tarpos ) ) * velomul, mpos )
						self:SetMTarLocked( true )
					end
					
					if ( !v:IsNPC() && !v:IsPlayer() ) || ( !IsValid( v ) ) then 
						self:SetMTarLocked( false )
					end
				end
			end
		end
		
		if ( selfdestruct  && selfdestructrange ~= nil ) && ( mpos:Distance( self.Owner:GetPos() ) > 256 ) then
			for k, v in pairs( ents.FindInSphere( mpos, selfdestructrange ) ) do
				if ( v:IsNPC() ) && ( mpos:Distance( v:GetPos() ) <= selfdestructrange ) then
					self:XPlode()
				end
			end
		end
	end

end

-------------------------------------
------------###--------------###-----
--------------##---------------##----
-----##########-------##########-----
------##----##---------##----##------
-----##--##--##-------##--##--##-----
------##----##---------##----##------
-------######-----------######-------
-------------------------------------
---------------#######---------------
-------------------------------------