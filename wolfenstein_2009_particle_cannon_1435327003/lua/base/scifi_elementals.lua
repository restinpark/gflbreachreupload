--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v17 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Global functions for elemental status functions		--
------------------------------------------------------------------
-- Auto-included in base.										--
------------------------------------------------------------------

AddCSLuaFile()

--[[

	Structure: ElementalInfo (emlinfo)
	emlinfo.Element		EML_ enum
	emlinfo.Target		Entity
	emlinfo.Duration	Float
	emlinfo.Attacker	Entity
	emlinfo.Inflictor	Entity (most likely a weapon)
	emlinfo.Origin		Vector
	emlinfo.Range		Float
	emlinfo.Ticks		Int

	DoElementalEffect( table = emlinfo )

	Note: You don't need all of these vars for every elemental effect. See the examples below.
	
	Example:
	
				local MyEml = {}
				MyEml.Element = EML_FIRE
				MyEml.Target = Entity( 1 )
				MyEml.Duration = 2
				MyEml.Attacker = Entity( 0 )
				
				DoElementalEffect( MyEml )
				
		Works the same way as:

				DoElementalEffect( { Element = EML_FIRE, Target = Entity( 1 ), Duration = 2, Attacker = Entity( 0 ) } )
				
	This would ignite the player for 2 seconds.
	You can optionally define an attacker here. The attacker is obligatory for most of the other elements, 
	however when used with fire, the attacker won't be able to ignite neither himself nor owned entities, like currently equipped weapons.
	The elements fire, ice and entangling blight share the same syntax (element, target, duration, attacker). 
	Shock elemental only requires the target. It doesn't have any duration and also doesn't need an attacker.
	Note: If you know, you're going to spam the elemental info at one || more targets, consider the first solution and have the ElementalInfo table precached, if possible, so you don't drawn the garbage collector.

				DoElementalEffect( { Element = EML_CORROSIVE, Target = Entity( 1 ), Attacker = Entity( 1 ), Inflictor = Entity( 1 ):GetActiveWeapon() } )
				
	This would cause the player to corrode himself with the weapon, they're currently using.
	Duration is obsolete for this element, as the corrosive damage source has a capped life-time of 5 seconds.

				DoElementalEffect( { Element = EML_FIRE, Target = v, Duration = 5, Attacker = self.Owner } )
				DoElementalEffect( { Element = EML_SHOCK, Target = v } )
				DoElementalEffect( { Element = EML_BLIGHT_ENT, Target = v, Duration = 5, Attacker = self.Owner } )
				
	These are lines used in a ents.FindInSphere() context, in the scifi_projectile's base XPlode() function, which is triggered on every hit.
	In this case "v" equals each element of the returned table and therefore an entity within a set radius.
	self.Owner is obvious.
	Note: Unless you work around owner-issue otherwise, I'd recommend using self:GetValidOwner() instead of self.Owner, to avoid NULL Entity errors, if the projectile outlives its creator.
	
	For dissolve effects, you'll need to define the initial position emlinfo.Origin, range and optionally the maximum amount of scan-ticks.
	In addition, you can force the function to use cheap particles, by setting emlinfo.ForceCheapFX to true. This is recommended, if you're planning to cover a large area with a dissolving elemental effect.
	Effects will automatically forced to cheap, if the limit from sfw_fx_maxexpensive is reached.
	
	Example: (like in sfw_seraphim)
	
				DoElementalEffect( { Element = EML_DISSOLVE_HWAVE, Attacker = self.Owner, Range = 64, Ticks = 25, Indextype = 0, ForceCheapFX = false } )
				
	Note: Everything in the line above is obligatory for dissolve elements to work. Only ticks are optional.
	Also keep in mind that the origin for indextype 1 is always the attackers shoot pos.

]]--

local NotiColor	= Color( 80, 255, 175 )

local function DevNotice( msg )

	local bDevmode = GetConVar( "developer" ):GetBool()

	if ( !bDevmode ) then return end
	
	MsgC( NotiColor, msg .. "\n" )

end

DMG_SF_PULSE 				= 102				-- Impulse damage. Suffers vs. armor. Hurts helicopters.
DMG_SF_HWAVE				= 132				-- Plasma/Slash combo. Ignores light/medium armor.One-hits headcrabs.
DMG_SF_PHASEBLADE 			= 8324				-- Same as the above, but more effective.
DMG_SF_ICE 					= 536875136			-- Suffers vs. armor. 
DMG_SF_ICE_SHRED 			= 536875012			-- No armor reduction except for fortified synth armor (striders).
DMG_SF_CORROSIVE_DART 		= 65538				-- Corrosive/Bullet combo.
DMG_SF_CORROSIVE 			= 393216			-- Corrosive/Toxin combo, similar to antlion worker's acid spit.
DMG_SF_CORROSIVE_ENERGY 	= 536940544			-- Just corrosive damage. Suffers from actual armor, but hurts 2.5x more when the target is corroding.
DMG_SF_BLAST 				= 33554496			-- Blast/Airboat combo. Hurts everything. No armor reduction.
DMG_SF_ENERGYBULLET 		= 4098				-- Energy projectile. Obeys default armor rules.
DMG_SF_ENERGYBLADE 			= 5120				-- Energy/Slash/Impact combo. Ignores light/medium armor. One-hits headcrabs.
DMG_SF_ENERGY 				= 33554560			-- Energy. Ignores light/medium armor.
DMG_SF_ENERGYSHOCKWAVE 		= 536875008			-- Energy damamge...
DMG_SF_VAPOR 				= 9216				-- Good effectivity. Ignores light/medium armor.
DMG_SF_VAPOR_OP 			= 33559552			-- Supreme effectivity. Ignores all kinds of armor.
DMG_SF_BLIGHT 				= 33554432			-- No effectivities/resistanes. Ignores light/medium armor.
DMG_SF_RADIANTFIRE 			= 33540137 			-- ???
DMG_SF_RADIANTSHOCK 		= 33826816			-- Mana damage. It's like weird radiation. Very unhealthy.
DMG_SF_DARK 				= 33591300				-- A very unhealthy curse.
DMG_BURN_DPS 				= 268435464 		-- Appearently the damage type used for roasting a headcrab until it's done.

EML_FIRE 					= 2					-- Pretty obvious. It's fire and stuff... Don't confuse this with HL2's ignition. This fire will NOT spread naturally.
EML_CORROSIVE				= 4					-- Corrosive damage. Small DOT + increased damage from all sources and even more increased bullet damage.
EML_ICE 					= 8					-- Cryo damage. Freezes the target in place.
EML_ICE_LEGACY 				= 12				-- The same as above but at terrible performance.
EML_SHOCK 					= 16				-- Heavily drains player's shields and stuns NPCs, ultimately cancels and/or resets their scheduled actions. Causes ragdolls to spazzer.
EML_BLIGHT 					= 32				-- Blight damage. Usually, ineffective vs. objects.
EML_BLIGHT_ENT 				= 64				-- Entangling blight damage. Freezes the target in place and causes NPCs to panic upon breaking free.
EML_DARK 					= 128				-- Dark status. Increases incoming dark damage.
EML_DISSOLVE_HWAVE 			= 1024				-- Dissolves props and ragdolls with orange light effects and particles.
EML_DISSOLVE_VAPOR 			= 2048 				-- Dissolves props and ragdolls with blue light effects and particles.
EML_DISSOLVE_CORROSIVE 		= 4096 				-- Dissolves and shrinks down a ragdoll with green goo around it.
EML_DISSOLVE_DARK			= 8192 				-- Transition effect for bodies to eventually become corrupted mass.
EML_DISSOLVE_HWAVE_ADVANCED = 16384 			-- Clientside ragdoll dissolve... prediction messed that one up.
EML_DISSOLVE_CELESTWRATH 	= 32768 			-- Fear the wrath...

local antlion 				= 100 	-- 99		-- Antlions, workers and grubs
local flesh 				= 40				-- Combine infantry, players, citizens, stalkers, uncommon zombies and all humanoid NPCs from Half-Life: Source
local alienflesh  			= 42				-- Headcrabs, Vortigaunts, Barnacles and basically all Xenians from Half-Life: Source
local zombieflesh 			= 103 	-- 102		-- Zombies, uncommon zombies (partially!), all zombie enemies from Half-Life: Source (needs confirmation due to inconsistency)
local machine 				= 70				-- Scanners
local metal 				= 3					-- Helicopters, Mines, Rollers, Cameras, Turrets, Gargantuas
local wood 					= 14				-- Mostly world targets, i.e. func_breakable, prop_physics and item_item_crate.
local alloyarmor 			= 94				-- Vehicles
local synthflesh 			= 86 	-- 85		-- Hunters
local syntharmor 			= 99 	-- 98		-- Striders, Gunships

local sfw_allow_advanceddamage_bias = CreateConVar( "sfw_allow_advanceddamage_bias", "1", FCVAR_NONE, "How literal the effectivity multiplier should be taken..." )

local Effectivities = {
	[ DMG_BULLET ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 1.1, 	[ alienflesh ] = 0.85, 	[ zombieflesh ] = 1.15, [ machine ] = 0.7, 	[ metal ] = 0.7, 	[ wood ] = 1.75, 	[ alloyarmor ] = 0.7, 	[ synthflesh ] = 0.8, 	[ syntharmor ] = 0.8 	},
	[ DMG_BUCKSHOT ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 0.85, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.7, 	[ wood ] = 1.25, 	[ alloyarmor ] = 0.65, 	[ synthflesh ] = 0.85, 	[ syntharmor ] = 0.8 	},
	[ DMG_CLUB ] 				= { [ antlion ] = 1.1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.2, 	[ zombieflesh ] = 1.25, [ machine ] = 1.5, 	[ metal ] = 1.2, 	[ wood ] = 2, 		[ alloyarmor ] = 0.8, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5	},
	[ DMG_PHYSGUN ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1,  	[ wood ] = 2,	 	[ alloyarmor ] = 1.1,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.8 	},
	[ DMG_SLASH ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 1.2, 	[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 0.9, 	[ metal ] = 0.8, 	[ wood ] = 1.2, 	[ alloyarmor ] = 0.8, 	[ synthflesh ] = 1, 	[ syntharmor ] = 0.75 	},
	[ DMG_VEHICLE ] 			= { [ antlion ] = 2, 	[ flesh ] = 1.5, 	[ alienflesh ] = 1.5, 	[ zombieflesh ] = 1.25, [ machine ] = 1, 	[ metal ] = 1, 	 	[ wood ] = 1, 		[ alloyarmor ] = 1,		[ synthflesh ] = 1.25, 	[ syntharmor ] = 1 		},
	[ DMG_CRUSH ] 				= { [ antlion ] = 2, 	[ flesh ] = 1, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 2, 	[ metal ] = 1,  	[ wood ] = 2,	 	[ alloyarmor ] = 1,		[ synthflesh ] = 2, 	[ syntharmor ] = 1 		},
	[ DMG_ENERGYBEAM ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 0.8, 	[ zombieflesh ] = 1, 	[ machine ] = 2, 	[ metal ] = 1.1, 	[ wood ] = 1, 		[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.25, 	[ syntharmor ] = 1.1 	},
	[ DMG_AIRBOAT ] 			= { [ antlion ] = 2, 	[ flesh ] = 1.5, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1.5, 	[ machine ] = 1.25, [ metal ] = 1.15, 	[ wood ] = 4,  		[ alloyarmor ] = 2,		[ synthflesh ] = 1, 	[ syntharmor ] = 1 		},
	[ DMG_DISSOLVE ] 			= { [ antlion ] = 2, 	[ flesh ] = 2, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 1, 	[ metal ] = 1, 	 	[ wood ] = 4, 		[ alloyarmor ] = 2,		[ synthflesh ] = 2, 	[ syntharmor ] = 1 		},
	[ DMG_SHOCK ] 				= { [ antlion ] = 0.8, 	[ flesh ] = 0.8, 	[ alienflesh ] = 0.75, 	[ zombieflesh ] = 0.75, [ machine ] = 2, 	[ metal ] = 1.5,  	[ wood ] = 0.25, 	[ alloyarmor ] = 2.2,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1 		},
	[ DMG_RADIATION ] 			= { [ antlion ] = 0.8, 	[ flesh ] = 1, 		[ alienflesh ] = 0.8, 	[ zombieflesh ] = 0.8, 	[ machine ] = 2, 	[ metal ] = 1.15, 	[ wood ] = 1,  		[ alloyarmor ] = 2,		[ synthflesh ] = 1.25, 	[ syntharmor ] = 1.1 	},
	[ DMG_ACID ] 				= { [ antlion ] = 1.25, [ flesh ] = 1.1, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 1.1, 	[ machine ] = 1.15, [ metal ] = 1.2,   	[ wood ] = 1.25,	[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.15	},
	[ DMG_BURN ] 				= { [ antlion ] = 1.5, 	[ flesh ] = 1, 		[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.25, [ machine ] = 0.75, [ metal ] = 0.75,   [ wood ] = 2,		[ alloyarmor ] = 0.2,	[ synthflesh ] = 0.5, 	[ syntharmor ] = 0.5	},
	[ DMG_BURN_DPS ] 			= { [ antlion ] = 1.5, 	[ flesh ] = 1, 		[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.25, [ machine ] = 0.75, [ metal ] = 0.75,   [ wood ] = 2,		[ alloyarmor ] = 0.2,	[ synthflesh ] = 0.5, 	[ syntharmor ] = 0.5	},
	
	[ DMG_SF_PULSE ]			= { [ antlion ] = 0.85, [ flesh ] = 0.85, 	[ alienflesh ] = 0.8, 	[ zombieflesh ] = 1, 	[ machine ] = 1.2, 	[ metal ] = 1.2,   	[ wood ] = 1.5,  	[ alloyarmor ] = 0.8,	[ synthflesh ] = 0.8, 	[ syntharmor ] = 1.15 	},
	[ DMG_SF_HWAVE ]			= { [ antlion ] = 1, 	[ flesh ] = 1.2, 	[ alienflesh ] = 1.1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 0.9, 	[ metal ] = 0.95,   [ wood ] = 1.5, 	[ alloyarmor ] = 0.8,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.8 	},
	[ DMG_SF_PHASEBLADE ] 		= { [ antlion ] = 1.2, 	[ flesh ] = 1.25, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1.25, [ machine ] = 1, 	[ metal ] = 0.95,   [ wood ] = 2,  		[ alloyarmor ] = 1,		[ synthflesh ] = 0.85, 	[ syntharmor ] = 0.95 	},
	[ DMG_SF_ENERGY ] 			= { [ antlion ] = 1, 	[ flesh ] = 1.1, 	[ alienflesh ] = 0.9, 	[ zombieflesh ] = 1, 	[ machine ] = 0.85, [ metal ] = 0.9,    [ wood ] = 1, 		[ alloyarmor ] = 1.2,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_ENERGYBLADE ] 		= { [ antlion ] = 1.15, [ flesh ] = 1.15, 	[ alienflesh ] = 1.15, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.75,   [ wood ] = 2,  		[ alloyarmor ] = 1.2,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_ENERGYBULLET ] 	= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1.1, 	[ machine ] = 1.15, [ metal ] = 1, 	   	[ wood ] = 1.5, 	[ alloyarmor ] = 1.1,	[ synthflesh ] = 0.8, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_ENERGYSHOCKWAVE ] 	= { [ antlion ] = 1.15, [ flesh ] = 1.15, 	[ alienflesh ] = 1.15, 	[ zombieflesh ] = 1.25, [ machine ] = 0.8, 	[ metal ] = 0.75,   [ wood ] = 1.5,  	[ alloyarmor ] = 1.2,	[ synthflesh ] = 1, 	[ syntharmor ] = 0.5 	},
	[ DMG_SF_CORROSIVE ] 		= { [ antlion ] = 1.5, 	[ flesh ] = 0.95, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 0.8, 	[ machine ] = 1.2, 	[ metal ] = 1.2,   	[ wood ] = 1.25,	[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1 	},
	[ DMG_SF_CORROSIVE_DART ] 	= { [ antlion ] = 1.5, 	[ flesh ] = 0.8, 	[ alienflesh ] = 0.75, 	[ zombieflesh ] = 0.8, 	[ machine ] = 1.2, 	[ metal ] = 1.2,    [ wood ] = 1.25, 	[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1 	},
	[ DMG_SF_CORROSIVE_ENERGY ] = { [ antlion ] = 1.25, [ flesh ] = 0.85, 	[ alienflesh ] = 0.85, 	[ zombieflesh ] = 0.85, [ machine ] = 1.15, [ metal ] = 1.15,   [ wood ] = 1,  		[ alloyarmor ] = 1.4,	[ synthflesh ] = 1.15, 	[ syntharmor ] = 1 		},
	[ DMG_SF_ICE ] 				= { [ antlion ] = 0.85, [ flesh ] = 0.9, 	[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.1,    [ wood ] = 0.7,	 	[ alloyarmor ] = 0.7,	[ synthflesh ] = 1.1, 	[ syntharmor ] = 1.1 	},
	[ DMG_SF_ICE_SHRED ] 		= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.2,    [ wood ] = 1,		[ alloyarmor ] = 0.75,	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.2 	},
	[ DMG_SF_VAPOR_OP ] 		= { [ antlion ] = 2, 	[ flesh ] = 2, 		[ alienflesh ] = 2, 	[ zombieflesh ] = 2, 	[ machine ] = 1, 	[ metal ] = 1,    	[ wood ] = 2,		[ alloyarmor ] = 2,		[ synthflesh ] = 2, 	[ syntharmor ] = 1.5 	},
	[ DMG_SF_VAPOR ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 0.9,   	[ wood ] = 1,  		[ alloyarmor ] = 1,		[ synthflesh ] = 1, 	[ syntharmor ] = 0.9 	},
	[ DMG_SF_BLIGHT ] 			= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1, 	   	[ wood ] = 1,		[ alloyarmor ] = 2,		[ synthflesh ] = 1, 	[ syntharmor ] = 1 		},
	[ DMG_SF_DARK ] 			= { [ antlion ] = 1.5, 	[ flesh ] = 0.9, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 1, 	[ machine ] = 2, 	[ metal ] = 2, 	   	[ wood ] = 2,		[ alloyarmor ] = 3,		[ synthflesh ] = 3, 	[ syntharmor ] = 2 		},
	[ DMG_SF_BLAST ] 			= { [ antlion ] = 1.15, [ flesh ] = 1.1, 	[ alienflesh ] = 1, 	[ zombieflesh ] = 1.2, 	[ machine ] = 1.5, 	[ metal ] = 1.25,   [ wood ] = 2,		[ alloyarmor ] = 2, 	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.25 	},
	[ DMG_SF_RADIANTFIRE ] 		= { [ antlion ] = 5, 	[ flesh ] = 5, 		[ alienflesh ] = 5, 	[ zombieflesh ] = 5, 	[ machine ] = 5, 	[ metal ] = 5, 	   	[ wood ] = 5,		[ alloyarmor ] = 4,		[ synthflesh ] = 5, 	[ syntharmor ] = 5 		},
	[ DMG_SF_RADIANTSHOCK ] 	= { [ antlion ] = 1, 	[ flesh ] = 1, 		[ alienflesh ] = 1.25, 	[ zombieflesh ] = 1, 	[ machine ] = 1, 	[ metal ] = 1.2,    [ wood ] = 2,		[ alloyarmor ] = 0.75,	[ synthflesh ] = 1.2, 	[ syntharmor ] = 1.2 	}
}

local tModels = {
	["models/combine_soldier.mdl"] = true,
	["models/zombie/classic.mdl"] = true,
	["models/zombie/zombie_soldier.mdl"] = true
}

local tRemains = {
	["models/combine_soldier.mdl"] = "models/zombie/zombie_soldier_torso.mdl",
	["models/zombie/classic.mdl"] = "models/zombie/classic_torso.mdl",
	["models/zombie/zombie_soldier.mdl"] = "models/zombie/zombie_soldier_torso.mdl"
}

local tGibs = {
	["models/combine_soldier.mdl"] = "models/zombie/zombie_soldier_legs.mdl",
	["models/zombie/classic.mdl"] = "models/zombie/classic_legs.mdl",
	["models/zombie/zombie_soldier.mdl"] = "models/zombie/zombie_soldier_legs.mdl"
}

local tGibSounds = {
	"player/damage1.wav",
	"player/damage2.wav",
	"player/damage3.wav",
	"player/damage4.wav",
	"physics/body/body_medium_break2.wav",
	"physics/body/body_medium_break3.wav",
	"physics/body/body_medium_break4.wav"
}

for k,v in pairs( tGibSounds ) do
	sound.Add( {
		name = "scifi.gibs.flesh." .. k ,
		channel = CHAN_STATIC,
		volume = 1,
		level = 80,
		pitch = {98, 102},
		sound = v
	} )
	
--	util.PrecacheSound( v )
end

local decal = "Blood"
local splats = 6

local funcGibCollide = function( gEntity, pCollisionData ) 
	local gOrigin = gEntity:GetPos()
	local trOrigin, trNormal = pCollisionData.HitPos, pCollisionData.HitNormal
	
	for i = 0, splats do
		local rng = VectorRand() * math.random( -10, 10 )
		
		util.Decal( decal, gOrigin + rng * i,trOrigin + trNormal * -i, { gEntity } )
		util.Decal( decal, gOrigin, gOrigin + rng, { tEntity } )
	end
end

hook.Add( "EntityTakeDamage", "0_SciFiDamageEffectivity", function( tEntity, dmgInfo )
	
	local cmd_advdmg = GetConVar( "sfw_allow_advanceddamage" ):GetInt()
	
	if ( cmd_advdmg < 1 ) then return end
	
--	dmgInfo:ScaleDamage( 0.75 )

	local dmgType = dmgInfo:GetDamageType()
	local dmgAtt = dmgInfo:GetAttacker()
	local dmgInf = dmgInfo:GetInflictor()
	local dmgPos = dmgInfo:GetDamagePosition()

	local trData = { start = dmgPos, endpos = tEntity:GetPos(), filter = function( ent ) if ( ent == tEntity ) then return true else return false end end, ignoreworld = true }
	local tr = util.TraceEntity( trData, tEntity )

	local mul = 1

	if ( tr.Hit ) then
		local effect = Effectivities[ dmgType ]
		if ( !effect ) then
			if ( cmd_advdmg == 2 ) then 
				DevNotice( "@SciFiDamage : Error. Failed to derive effectivity data for damage-type " .. dmgType .. " \n" )
			end
			
			return 1 
		end
		
		local tSurface = tr.SurfaceProps
		if ( !tSurface ) then return 1 end 

		local scale  = effect[ tSurface ]
		if ( !scale ) then
			scale = 1
		
			if ( cmd_advdmg == 2 ) then 
				DevNotice( "@SciFiDamage : Failed to get damage multiplier. Defaulting! (" .. dmgType .. " vs. " .. util.GetSurfacePropName( tSurface ) .. " / " .. tSurface .. ")\n" )
			end
			
			return scale
		end
		
		local cmdBias = sfw_allow_advanceddamage_bias:GetFloat()
		local bias = 1
		
		if ( cmdBias && cmdBias >= 1 ) then
			if ( scale < 1 ) then
				bias = bias / cmdBias
			elseif ( scale > 1 ) then
				bias = bias * cmdBias
			end
			
			bias = math.Round( bias, 2 )
		end
	
		mul = scale * bias
		
		if ( cmd_advdmg == 2 ) then 
			DevNotice( "@SciFiDamage : " .. "Using damage type '" .. dmgType .. "' vs. target (" .. util.GetSurfacePropName( tSurface ) .. " / " .. tSurface .. ") with an effectivity of " .. ( mul * 100 ) .. "%.\n" )
		end
	
		local tModel = tEntity:GetModel()
		if ( tEntity:IsNPC() ) && ( tModels[ tModel ] ) then 
			local trHead = util.TraceLine( { start = dmgPos, endpos = tEntity:EyePos() + tEntity:EyeAngles():Forward()*-4, filter = {}, ignoreworld = true } )
			local hgroup = trHead.HitGroup
			
			local iDamage = dmgInfo:GetDamage()
			local iTargetHealth = tEntity:Health()
			local iOverKill = iTargetHealth - iDamage
			
--			print( iOverKill, hgroup, bit.band( dmgType, DMG_SLASH ) == DMG_SLASH )

			if ( hgroup == HITGROUP_HEAD ) then
				if ( tModel == "models/combine_soldier.mdl" ) && ( iOverKill < -12 ) then
					tEntity:SetModel( "models/zombie/zombie_soldier.mdl" )
					tEntity:SetSequence( "Idle01" )

					local gib = ents.Create( "prop_ragdoll" )
					gib:SetModel( "models/infected/limbs/limb_male_head01.mdl" )
					gib:SetPos( dmgPos )
					gib:SetAngles( tEntity:EyeAngles() )
					gib:Spawn()
					
					local physGib = gib:GetPhysicsObject()
					physGib:ApplyForceCenter( dmgInfo:GetDamageForce() / 4 )
					
					gib:AddCallback( "PhysicsCollide", funcGibCollide )
					
					ParticleEffectAttach( "blood_zombie_split_spray", PATTACH_ABSORIGIN_FOLLOW, gib, 0 )
					ParticleEffectAttach( "blood_headsplat", PATTACH_ABSORIGIN_FOLLOW, gib, 0 )
					ParticleEffect( "blood_headsplat_cheap", dmgPos, trHead.Normal:Angle(), NULL )
					
					gib:EmitSound( "wraith.magic.finisher" )
					EmitSound( tGibSounds[ math.random( 1, 4 ) ], dmgPos, -1, CHAN_STATIC, 1, 100, 0, 100 )
					dmgAtt:EmitSound( tGibSounds[ math.random( 1, 4 ) ], dmgPos, -1, CHAN_STATIC, 1, 100, 0, 100 )
			
					util.Decal( "blood", trHead.HitPos, tEntity:GetPos() - Vector( 0, 0, 4 ), { tEntity } )
					util.Decal( "blood", trHead.HitPos, trHead.HitPos + tr.Normal * 16, { tEntity } )
				end
			else
				if ( iOverKill < -12 ) && ( hgroup == HITGROUP_CHEST || ( bit.band( dmgType, DMG_SLASH ) == DMG_SLASH ) || ( bit.band( dmgType, DMG_BLAST ) == DMG_BLAST ) ) then
					tEntity:SetModel( tRemains[ tModel ] )
					tEntity:SetSequence( "Idle01" )

					local gib2 = ents.Create( "prop_ragdoll" )
					gib2:SetModel( tGibs[ tModel ] )
					gib2:SetPos( tEntity:GetPos() + Vector( 0, 0, 4 ) )
					gib2:SetAngles( tEntity:EyeAngles() )
					gib2:Spawn()
					
					local physGib = gib2:GetPhysicsObject()
					physGib:ApplyForceCenter( dmgInfo:GetDamageForce() * 0.05 )
					
					gib2:AddCallback( "PhysicsCollide", funcGibCollide )

					ParticleEffectAttach( "blood_zombie_split_spray", PATTACH_ABSORIGIN_FOLLOW, gib2, 0 )
					ParticleEffectAttach( "blood_headsplat", PATTACH_ABSORIGIN_FOLLOW, gib2, 0 )
					ParticleEffect( "blood_headsplat_cheap", dmgPos, trHead.Normal:Angle(), NULL )
					
					gib2:EmitSound( tGibSounds[ math.random( 1, 7 ) ] ) --"Watermelon.Impact" )
					EmitSound( tGibSounds[ math.random( 5, 7 ) ], dmgPos, -1, CHAN_STATIC, 1, 80, 0, 100 )
					dmgAtt:EmitSound( tGibSounds[ math.random( 5, 7 ) ], dmgPos, -1, CHAN_STATIC, 1, 80, 0, 100 )
			
					util.Decal( "blood", trHead.HitPos, tEntity:GetPos() - Vector( 0, 0, 4 ), { tEntity } )
					util.Decal( "blood", trHead.HitPos, trHead.HitPos + tr.Normal * 16, { tEntity } )
				end
			end
		end
	end

	if ( mul ) then
		dmgInfo:ScaleDamage( mul )
	end	
	
	local IsCorroding = tEntity:GetNWBool( "edmg_corrosive" )
	
	if ( dmgType == DMG_SF_CORROSIVE || dmgType == DMG_SF_CORROSIVE_DART ) && ( IsCorroding ) then
		dmgInfo:ScaleDamage( 2 )
	end

	if ( dmgType == DMG_SF_HWAVE || dmgType == DMG_SF_HWAVE_DISSOLVE ) && ( tEntity:IsPlayer() && tEntity:Armor() > 0 ) then
		dmgInfo:ScaleDamage( 0.8 )
	end
	
end )

hook.Add( "EntityTakeDamage", "SciFiDamageElementalEffects", function( ent, dmginfo )

	local iscorroding = ent:GetNWBool( "edmg_corrosive" )
	local dmgamt = dmginfo:GetDamage()
	local dmgtype = dmginfo:GetDamageType()
	local attacker = dmginfo:GetAttacker()

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		if ( iscorroding ) && ( dmgtype ~= DMG_ENERGYBEAM ) then
			dmginfo:ScaleDamage( 2 )
			if ( dmginfo:IsBulletDamage() ) then
				dmginfo:AddDamage( 4 )
			end

			if ( ( ent:Health() - dmgamt ) <= 0 ) then
				DoElementalEffect( { Element = EML_DISSOLVE_CORROSIVE, Attacker = attacker, Origin = ent:GetPos(), Range = 64, Ticks = 8 } )
			end
		end
		
		if ( ent:GetNWBool( "bliz_frozen" )  ) && ( dmginfo:GetDamageType() == DMG_CLUB || dmginfo:GetDamageType() == DMG_SLASH ) then
			dmginfo:ScaleDamage( 1.5 )
		end
	end

end )

local mat_dslv_hwave 	= "models/elemental/burned"
local mat_dslv_vapor 	= "models/elemental/vapored"
local mat_stun_ice 		= "models/elemental/frozen"

local snd_dslv_hwave 	= Sound( "scifi.hwave.dissolve" )
local snd_dslv_wrath 	= Sound( "scifi.wrath.dissolve" )
local snd_dslv_wscream 	= Sound( "scifi.vapor.dissolve.scream" )
local snd_dslv_vapor 	= Sound( "scifi.vapor.dissolve" )
local snd_stun_ice 		= Sound( "scifi.bliz.breakfree" )
local snd_stun_ice_2 	= Sound( "scifi.cryo.freeze" )
local snd_stun_shock 	= Sound( "scifi.Blade.Hit.Electric03" )
local snd_stun_ebl		= Sound( "scifi.stinger.attach" )

local function GetFXStressCount()

	local entities = ents.GetAll()
	local valids = {}
	
	for k,v in pairs( entities ) do
		if ( v:GetNWBool( "IsVaporizing" ) ) then
			table.insert( valids, v )
		end
	end

	return #valids
	
end

local function CanUseExpensive()

	local cmd_fx_maxexpensive = GetConVar( "sfw_fx_maxexpensive" ):GetInt()
	
	if ( GetFXStressCount() <= cmd_fx_maxexpensive ) || ( cmd_fx_maxexpensive < 0 ) then
		return true
	else
		DevNotice( "@SciFiElementals : !Warning; Can't create more low-perf effects!" )
		return false
	end
	
end

local function HwaveDissolve( v, vPhys, vPos )

	if ( !vPos ) then
		vPos = v:GetPos()
	end

	v:SetNWBool( "IsVaporizing", true )

	if ( IsValid( phys ) && vClass == "prop_ragdoll" ) then
		vPhys:SetMass( 1 )
		vPhys:EnableDrag( true ) 
		vPhys:SetDragCoefficient( 16384 )
		vPhys:SetAngleDragCoefficient( 16384 )
		vPhys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 2 )
		
		local bones = v:GetPhysicsObjectCount()
		
		for  i=0, bones-1 do
			local grav = v:GetPhysicsObjectNum( i )
			if ( IsValid( grav ) ) then
				grav:EnableGravity( false )
			end
		end

		vPhys:EnableDrag( true )
	end

	v:DrawShadow( false )
	v:SetNoDraw( false )
	
	local ed = EffectData()
	ed:SetOrigin( vPos )
	ed:SetEntity( v )
	util.Effect( "hwave_dissolve", ed )
	
	v:SetMaterial( mat_dslv_hwave )
	v:SetColor( Color( 100, 20, 0, 255 ) )
	v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
	v:EmitSound( snd_dslv_hwave )
	
	if ( SERVER ) then
		v:Fire( "kill", "", 1.4 )
	else
		timer.Simple( 1.4, function() v:Remove() end )
	end
	
end

local TargetClasses = {
	prop_ragdoll = true,
	prop_physics = true,
--	prop_dynamic = true,
	gib = true --,
--	prop_door_rotating = true
}

local RagdollMgr = {}
local Ragdolls = {}
local RagdollOwners = {}

function RagdollMgr:Filter( inputtable )

	local outputtable = {}

	for k,v in pairs ( inputtable ) do
		if ( self:IsValidRagdoll( v ) ) then
			table.insert( outputtable, v )
		end
	end
	
	return outputtable

end

function RagdollMgr:AddRagdoll( entity )

	if ( !IsValid( entity ) || !entity:IsRagdoll() ) then
		return 
	else
		table.insert( Ragdolls, entity )
	end

end

function RagdollMgr:IsValidRagdoll( entity )

	if ( IsValid( entity ) && ( entity:IsRagdoll() ) ) then
		return true
	else
		return false
	end

end

--[[
if ( SERVER ) then
	util.AddNetworkString( "OnKilledDissolve" )
end
	
hook.Add( "OnNPCKilled", "DissolveOnKilled", function( pTarget, pAttacker, pInflictor )

	net.Start( "OnKilledDissolve" )
	--	table.insert( RagdollOwners, pTarget )
	net.WriteEntity( pTarget )
	net.Send( pAttacker )

end )

local rdOwner
net.Receive( "OnKilledDissolve", function( len, ply )

	local pEntity = net.ReadEntity()
--	print( pEntity )
	rdOwner = pEntity
	
end )

hook.Add( "OnEntityCreated", "GetAllTheRagdolls", function( entity )

	if ( entity:IsRagdoll() ) then
	print( entity, entity:GetRagdollOwner(), rdOwner )
		if ( entity:GetRagdollOwner() == rdOwner ) then
	--	if ( RagdollOwners[ entity:GetRagdollOwner() ] &&  ) then
			HwaveDissolve( entity )
		end
	end

end )

local EML = {}

function EML:DoCorrosive()

end
]]--
function DoElementalEffect( emlinfo )
	
	if ( !emlinfo || !istable( emlinfo ) || emlinfo == nil ) then DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! No data given!" ) return end
	
	local element 				= emlinfo.Element 						-- Enum
	local target 				= emlinfo.Target						-- Entity
	local duration 				= emlinfo.Duration 						-- Float
	local attacker 				= emlinfo.Attacker						-- Entity
	local inflictor 			= emlinfo.Inflictor 					-- Entity
	local origin 				= emlinfo.Origin						-- Vector
	local range 				= emlinfo.Range							-- Float
	local indextype 			= emlinfo.IndexType 					-- Integer
	local ticks 				= emlinfo.Ticks							-- Integer
	local dissolvemasstolerance = emlinfo.DslvMaxMass					-- Integer (actually, it's a float but it's very, very unlikely to find floating points in mass values)
	local forcecheapfx 			= emlinfo.ForceCheapFX					-- Boolean
	local damage 				= emlinfo.Damage 						-- Float
	local amp 					= GetConVar( "sfw_damageamp" ):GetFloat()	-- Float (fake bool)
	local cmd_debug_showemlinfo = GetConVar( "sfw_debug_showemlinfo" ):GetInt()
	local cmd_fx_particles 		= GetConVar( "sfw_fx_particles" ):GetBool()
	local cmd_allow_dissolve 	= GetConVar( "sfw_allow_dissolve" ):GetBool()
	
	if ( element == nil ) then DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! No or invalid element!" ) return end
	
	if ( cmd_debug_showemlinfo >= 1 ) then
		if ( isvector( origin ) ) then
			debugoverlay.Text( origin, "origin", 5, true ) 
			debugoverlay.Cross( origin, 4, 3, Color( 255, 20, 40, 255 ), true )
			debugoverlay.Sphere( origin, range, 3, Color( 80, 255, 175, 4 ), false )
		end
	end
	
	if ( cmd_debug_showemlinfo == 2 ) then
		DevNotice( table.ToString( emlinfo, "emlinfo @ "..CurTime(), true ).."\n" )
	end
	
	if ( element == EML_DISSOLVE_HWAVE_ADVANCED ) then
		if ( !IsValid( attacker ) ) then
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! 'NULL' attacker." ) 
			return 
		end
		
		if ( ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then 
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! Failed to setup index. Obligatory data was not given. " ) 
			return 
		end

		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
		
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), 128, 0 )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			local vRagdolls = RagdollMgr:Filter( index )

			for k, v in pairs ( vRagdolls ) do
				if ( !IsValid( v ) ) then return end
				if ( v:GetNWBool( "IsVaporizing" ) ) then return end
				local vPhys = v:GetPhysicsObject()
				local vPos = v:GetPos()
				
				if ( !cmd_allow_dissolve ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( !IsValid( v ) ) then return end
				if ( v:WaterLevel() >= 2 ) then return end
				
				HwaveDissolve( v, vPhys, vPos )

				if ( cmd_fx_particles ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then 
					ParticleEffectAttach( "pyro_dissolve", 1, v, -1 ) 
				else
					ParticleEffectAttach( "pyro_dissolve_cheap", 1, v, -1 ) 
					ParticleEffectAttach( "pyro_dissolve_ash_cheap", 1, v, 1 )
				end
			end
			
			for k, v in pairs ( index ) do
				if ( !IsValid( v ) ) then return end
				
				local vClass = v:GetClass()
				local vPhys = v:GetPhysicsObject()
				local vPos = v:GetPos()
				
				if ( !cmd_allow_dissolve ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( ( v == NULL ) || ( vPhys == NULL ) ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				if ( v:WaterLevel() >= 2 ) then return end
				if ( IsValid( vPhys ) ) && ( ( TargetClasses[ vClass ] && vPhys:GetMass() <= 45 * (amp * 2) ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					HwaveDissolve( v, vPhys, vPos )
					
					if ( cmd_fx_particles ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then 
						ParticleEffectAttach( "pyro_dissolve", 1, v, -1 )
						
						local dslfx = ents.Create( "light_dynamic" )
						if ( !IsValid( dslfx ) ) then return end
						dslfx:SetKeyValue( "_light", "255 90 10 255" )
						dslfx:SetKeyValue( "brightness", 3 )
						dslfx:SetKeyValue( "style", 1 )
						dslfx:SetPos( vPos )
						dslfx:SetParent( v )
						dslfx:Spawn()
						DLightFade( dslfx, 0, 320, 5, 2 )
						dslfx:Fire( "kill", "", 2 )
					else
						ParticleEffectAttach( "pyro_dissolve_cheap", 1, v, -1 ) 
						ParticleEffectAttach( "pyro_dissolve_ash_cheap", 1, v, 1 )
					end
				end
			end
			timer.Remove( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end
	
	if ( element == EML_DISSOLVE_HWAVE ) then
		if ( !IsValid( attacker ) ) then
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! 'NULL' attacker." ) 
			return 
		end
		
		if ( ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then 
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! Failed to setup index. Obligatory data was not given. " ) 
			return 
		end
		
		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end

		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), 128, 0 )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			for k, v in pairs ( index ) do
				if ( !cmd_allow_dissolve ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) || ( v:GetPhysicsObject() == NULL ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				if ( v:WaterLevel() >= 2 ) then return end
				
				local phys = v:GetPhysicsObject()

				if ( IsValid( phys ) ) && ( ( RagdollMgr:IsValidRagdoll( v ) && phys:GetMass() <= 30 * amp ) || ( TargetClasses[ v:GetClass() ] && phys:GetMass() <= dissolvemasstolerance * (amp * 2) ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					v:SetNWBool( "IsVaporizing", true )
					v:Extinguish()
					local vpos = v:GetPos()
					if ( !IsValid( phys ) ) then v:Remove() return end
					if ( v:IsRagdoll() ) then
						phys:SetMass( 1 )
						phys:EnableDrag( true ) 
						phys:SetDragCoefficient( 16384 )
						phys:SetAngleDragCoefficient( 16384 )
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 2 )
					else
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 1 )
					end

					local bones = v:GetPhysicsObjectCount()

					for  i=0, bones-1 do
						local grav = v:GetPhysicsObjectNum( i )
						if ( IsValid( grav ) ) then
							grav:EnableGravity( false )
						end
					end
				
					phys:EnableDrag( true )
					
					v:DrawShadow( false )
					v:SetNoDraw( false )
					
					local ed = EffectData()
					ed:SetOrigin( vpos )
					ed:SetEntity( v )
					util.Effect( "hwave_dissolve", ed, true, true )
					
					v:SetMaterial( mat_dslv_hwave )
					v:SetColor( Color( 100, 20, 0, 255 ) )
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( snd_dslv_hwave )
					v:Fire( "kill", "", 1.4 )

					if ( cmd_fx_particles ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then 
						ParticleEffectAttach( "pyro_dissolve", 1, v, -1 )
					else
						ParticleEffectAttach( "pyro_dissolve_cheap", 1, v, -1 ) 
						ParticleEffectAttach( "pyro_dissolve_ash_cheap", 1, v, 1 )
					end
				end
			end
			timer.Remove( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end
	
	if ( element == EML_DISSOLVE_CELESTWRATH ) then
		if ( !IsValid( attacker ) ) then
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! 'NULL' attacker." ) 
			return 
		end
		
		if ( ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then 
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! Failed to setup index. Obligatory data was not given. " ) 
			return 
		end
		
		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
		
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), 128, 0 )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			for k, v in pairs ( index ) do
				if ( !cmd_allow_dissolve ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) || ( v:GetPhysicsObject() == NULL ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				if ( v:WaterLevel() >= 2 ) then return end
				
				local vClass = v:GetClass()
				local phys = v:GetPhysicsObject()
				
				if ( IsValid( phys ) ) && ( ( RagdollMgr:IsValidRagdoll( v ) && phys:GetMass() <= 30 * amp ) || ( TargetClasses[ vClass ] && phys:GetMass() <= dissolvemasstolerance * (amp * 2) ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					v:SetNWBool( "IsVaporizing", true )
					v:Extinguish()
					
					local vpos = v:GetPos()
					
					if ( !IsValid( phys ) ) then v:Remove() return end
					if ( RagdollMgr:IsValidRagdoll( v ) ) then
						phys:SetMass( 1 )
						phys:EnableDrag( true ) 
						phys:SetDragCoefficient( 16384 )
						phys:SetAngleDragCoefficient( 16384 )
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 2 )
					else
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 1 )
					end

					local bones = v:GetPhysicsObjectCount()
					
					for  i=0, bones-1 do
						local grav = v:GetPhysicsObjectNum( i )
						if ( IsValid( grav ) ) then
							grav:EnableGravity( false )
						end
					end
				
					phys:EnableDrag( true )
					
					v:DrawShadow( false )
					v:SetNoDraw( false )
					
					local ed = EffectData()
					ed:SetOrigin( vpos )
					ed:SetEntity( v )
					util.Effect( "celest_dissolve_wrath", ed, true, true )
					
					v:SetColor( Color( 80, 80, 80, 255 ) )
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( snd_dslv_wrath )
					v:Fire( "kill", "", 2 )
				
					ParticleEffectAttach( "celest_wrath_dissolve", 1, v, -1 )
				end
			end
			timer.Remove( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end
	
	if ( element == EML_DISSOLVE_VAPOR ) then
		if ( !IsValid( attacker ) ) then
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! 'NULL' attacker." ) 
			return 
		end
		
		if ( ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then 
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! Failed to setup index. Obligatory data was not given. " ) 
			return 
		end
		
		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
	
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), range, range )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			for k, v in pairs ( index ) do
				if ( !cmd_allow_dissolve ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) || ( v:GetPhysicsObject() == NULL ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				
				local phys = v:GetPhysicsObject()
				
				if ( IsValid( phys ) ) && ( ( RagdollMgr:IsValidRagdoll( v ) && phys:GetMass() <= dissolvemasstolerance * amp ) || ( TargetClasses[ v:GetClass() ] && phys:GetMass() <= dissolvemasstolerance * (amp * 2) ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
					v:SetNWBool( "IsVaporizing", true )
					v:Extinguish()
					
					if ( !IsValid( phys ) ) then v:Remove() return end
					if ( v:IsRagdoll() ) then
						phys:SetMass( 1 )
						phys:EnableDrag( true ) 
						phys:SetDragCoefficient( 16384 )
						phys:SetAngleDragCoefficient( 16384 ) -- 4294967296 8589934592 ?
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 8 )
					else
						phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 8 )
					end

					local bones = v:GetPhysicsObjectCount()

					for  i=0, bones-1 do
						local grav = v:GetPhysicsObjectNum( i )
						if ( IsValid( grav ) ) then
							grav:EnableGravity( false )
						end
					end
					
					v:DrawShadow( false )
					v:SetNoDraw( false )
					
					local vpos = v:GetPos()
					local ed = EffectData()
					ed:SetOrigin( vpos )
					ed:SetEntity( v )
					util.Effect( "vp_dissolve", ed, true, true )
					
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( snd_dslv_vapor )
					v:Fire( "kill", "", 1 )
				end
			end
			timer.Remove( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end
	
	if ( element == EML_DISSOLVE_CORROSIVE ) then
		if ( !IsValid( attacker ) ) then
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! 'NULL' attacker." ) 
			return 
		end
		
		if ( ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then 
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! Failed to setup index. Obligatory data was not given. " ) 
			return 
		end
		
		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
	
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = ents.FindInSphere( origin, range )
			
			for k, v in pairs ( index ) do
				if ( !cmd_allow_dissolve ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) || ( v:GetPhysicsObject() == NULL ) then return end
				if ( v ~= NULL ) && ( v:GetOwner():IsPlayer() ) && ( v:GetOwner() ~= attacker ) then return end
				
				local phys = v:GetPhysicsObject()
				
				if ( IsValid( phys ) ) && ( ( RagdollMgr:IsValidRagdoll( v ) && phys:GetMass() <= dissolvemasstolerance * amp ) ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then
					v:SetNWBool( "IsVaporizing", true )
					
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( snd_dslv_hwave )
					v:Fire( "kill", "", 2 )
					
					local ed = EffectData()
					ed:SetOrigin( v:GetPos() )
					ed:SetEntity( v )
					util.Effect( "crsv_dissolve", ed, true, true )
					
					if ( cmd_fx_particles ) && ( !forcecheapfx ) && ( CanUseExpensive() ) then
						ParticleEffectAttach( "crsv_dissolve", 1, v, 1 )
					else
						ParticleEffectAttach( "crsv_dissolve_cheap", 1, v, 1 )
					end
				end
			end
			timer.Remove( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end	
	
	if ( element == EML_DISSOLVE_DARK ) then
		if ( !IsValid( attacker ) ) then
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! 'NULL' attacker." ) 
			return 
		end
		
		if ( ( !isvector( origin ) && indextype ~= 1 ) || !isnumber( range ) ) then 
			DevNotice( "@SciFiElementals : !Error; Failed to create elemental damage! Failed to setup index. Obligatory data was not given. " ) 
			return 
		end
		
		if ( !dissolvemasstolerance ) then 
			dissolvemasstolerance = 40 
		end
	
		timer.Create( "dissolve" .. attacker:EntIndex(), 0.01, ticks, function() 
			local index = {}

			if ( indextype && indextype == 1 ) then
				index = ents.FindInCone( attacker:GetShootPos(), attacker:GetAimVector(), range, range )
			else
				index = ents.FindInSphere( origin, range )
			end
			
			for k, v in pairs ( index ) do
				if ( !cmd_allow_dissolve ) then return end
				if ( !IsValid( attacker ) || attacker == NULL ) then return end
				if ( v == NULL ) then return end
				if ( !v:IsRagdoll() ) then continue end
				
				local phys = v:GetPhysicsObject()
				
				if ( !phys || !IsValid( phys ) ) then
					v:Remove()
					return 
				end
				
				local physMass = phys:GetMass()
				
				if ( physMass <= dissolvemasstolerance * amp ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then
					v:SetNWBool( "IsVaporizing", true )
					v:Extinguish()

					phys:SetMass( physMass * 0.2 )
					phys:EnableDrag( true ) 
					phys:SetDragCoefficient( 16384 )
					phys:SetAngleDragCoefficient( 16384 )
					
					v:DrawShadow( false )
					v:SetNoDraw( false )
					
					local vpos = v:GetPos()
					local ed = EffectData()
					ed:SetOrigin( vpos )
					ed:SetEntity( v )
					util.Effect( "dark_succumb", ed, true, true )
					
					v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
					v:EmitSound( "scifi.dark.succumb" )
					v:Fire( "kill", "", 3 )
				end
			end
			timer.Remove( "dissolve" .. attacker:EntIndex() )
		end )
		return
	end

	if ( target == nil || !IsValid( target ) ) then DevNotice( "@SciFiElementals : !Error; Invalid or no target." ) return end
	
	if ( element == EML_FIRE ) then
		if ( !duration ) then duration = 5 end
		
		local tClass = target:GetClass()
		
		if ( target:IsWeapon() && IsValid( target:GetOwner() ) ) then DevNotice( "@SciFiElementals : !PanicEnt; '" .. tostring( target ) .. "' can't be set on fire... Ignoring!" ) return end
		if ( tClass == "predicted_viewmodel" ) then DevNotice( "@SciFiElementals : !PanicEnt; '" .. tostring( target ) .. "' can't be set on fire... Ignoring!" ) return end
		if ( tClass == "gmod_hands" ) then DevNotice( "@SciFiElementals : !PanicEnt; '" .. tostring( target ) .. "' can't be set on fire... Ignoring!" ) return end
		if ( attacker == nil ) then
			target:Ignite( duration )
		else 
			if ( target ~= attacker && target:GetOwner() ~= attacker ) then
				target:Ignite( duration )
			end
		end
		return
	end

	if ( element == EML_CORROSIVE ) then
		if ( !IsValid( target ) ) then return end
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error; No attacker." ) return end
		if ( !IsValid( inflictor ) ) then DevNotice( "@SciFiElementals : !Warning; No inflictor." ) inflictor = attacker:GetActiveWeapon() return end
		
		if ( SERVER ) && ( target:IsNPC() || target:IsPlayer() ) then
			if ( target:GetNWBool( "edmg_corrosive" ) ~= true ) then
				target:SetNWBool( "edmg_corrosive", true )
				local dps = ents.Create( "dmg_corrosion" )
				dps:SetPos( target:EyePos() + Vector( 0, 0, 1024 ) )
				dps:SetOwner( attacker )
				dps:SetParent( target )

				if ( duration ) then
					dps.LifeTime = duration
				end
				
				dps:Spawn()
				dps:Activate()
			end
		end
	
		return
	end

	if ( element == EML_ICE ) then
		if ( !IsValid( target ) ) then return end
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error; No attacker." ) return end
		
		if ( target:GetNWBool( "bliz_frozen" ) ) then return end

		if ( SERVER ) then
			if ( target:IsNPC() || target:IsPlayer() ) && ( target:GetMaxHealth() < 200 ) then
				target:SetNWBool( "bliz_frozen", true )
				local dps = ents.Create( "dmg_freezing" )
				dps:SetPos( target:EyePos() + Vector( 0, 0, 1024 ) )
				dps:SetOwner( attacker )
				dps:SetParent( target )

				if ( duration ) then
					dps.LifeTime = duration
				end
				
				dps:Spawn()
				dps:Activate()
				return
			end
		--[[	
			if ( target:IsRagdoll() ) then
				if ( target.StatueInfo ) then
					DoShatterRagdolls( target:GetPos() )
				else
					DoFreezeRagdolls( target:GetPos() )
				end
			end
		]]--
		end
		return
	end

	if ( element == EML_ICE_LEGACY ) then
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error, No attacker." ) return end
		if ( !duration ) then duration = 2 end
		
		if ( !IsValid( target ) ) || ( !SERVER ) then return end
		if ( target:GetNWBool( "bliz_frozen" ) ) then return end
		
		if ( ( target:IsNPC() && !target:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) || target:IsPlayer() ) && ( target:GetMaxHealth() < 150 ) then
			if ( target:IsNPC() ) then
				target:SetSchedule( SCHED_NPC_FREEZE )
				target:SetNWBool( "bliz_frozen", true )
			elseif ( target:IsPlayer() ) then
				target:AddFlags( FL_FROZEN )
				target:SetNWBool( "bliz_frozen", true )
			end
			
			if ( target:IsNPC() || target:IsPlayer() ) then
				local ed = EffectData()
				ed:SetOrigin( target:GetPos() )
				ed:SetEntity( target )
				ed:SetScale( duration )
				util.Effect( "cryon_frozen", ed, true, true )
				
				ParticleEffectAttach( "ice_freezing_shortlt", 1, target, 1 )
			end
			
			target:EmitSound( snd_stun_ice )
			
			timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 60 * duration, function()
				if ( IsValid( target ) ) && ( target:Health() <= 1 && target:GetNWBool( "bliz_frozen" )  ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "bliz_frozen", false )
					if ( target:IsNPC() ) then
						target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif ( target:IsPlayer() ) then
						target:RemoveFlags( FL_FROZEN )
					end
					
					ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
					target:EmitSound( snd_stun_ice_2 )
					
					if ( IsValid( attacker ) && IsValid( attacker:GetActiveWeapon() ) ) then
						target:TakeDamage( 5, attacker, attacker:GetActiveWeapon() )
						
						if ( target:Health() <= target:GetMaxHealth() * -0.25 ) then
							DoShatterRagdolls( target:EyePos() )
						else
							DoFreezeRagdolls( target:EyePos() )
						end
					end
				end
			end )
			
			timer.Simple( duration, function()
				timer.Remove( "FakeFrozenThink"..target:EntIndex() )
			end )

			timer.Simple( duration, function()
				if ( IsValid( target ) ) && ( SERVER ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "bliz_frozen", false )
					if ( target:IsNPC() ) then
						target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif( target:IsPlayer() ) then
						target:RemoveFlags( FL_FROZEN )
					end
					ParticleEffectAttach( "ice_freezing_release", 1, target, 1 )
					target:EmitSound( snd_stun_ice )
				end
			end )
		end
		return
	end

	if ( element == EML_SHOCK ) then
		if ( CLIENT ) then return end
		
		if ( !isnumber( damage ) ) then 
			damage = 20
		end
		
		if ( !IsValid( target ) ) then return end
		
		if ( target:IsPlayer() ) then
			if ( !target:HasGodMode() ) then
				target:SetArmor( target:Armor() - ( damage * amp ) )
				target:ScreenFade( SCREENFADE.IN, Color( 200, 230, 255, 127 ), 0.5, 0.01 )
			end
			
			local vmEntity = target:GetViewModel()
			if ( IsValid( vmEntity ) ) then
				ParticleEffectAttach( "eml_dps_shock", PATTACH_ABSORIGIN_FOLLOW, vmEntity, 0 )
			end
		end
		
		if ( target:IsNPC() && target:GetMaxHealth() < 250 ) then
			target:SetSchedule( SCHED_FAIL )
		end
		
		if ( target:IsRagdoll() ) then
			target:Fire( "StartRagdollBoogie", "", 0 )
		end

		target:EmitSound( snd_stun_shock )
		ParticleEffectAttach( "eml_dps_shock", PATTACH_ABSORIGIN_FOLLOW, target, 0 )
	end
	
	if ( element == EML_DARK ) then
		if ( !IsValid( target ) ) then return end
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error; No attacker." ) return end
		
		if ( target:GetNWBool( "dark_haunted" ) ) then 
			local iStacks = target:GetNWInt( "dark_haunted_stacks" )
			target:SetNWInt( "dark_haunted_stacks", iStacks + 1 )
			
			ParticleEffectAttach( "umbra_darken_stackup", PATTACH_ABSORIGIN_FOLLOW, target, 1 )
				
			return 
		end

		if ( SERVER ) then
			if ( target:IsNPC() || target:IsPlayer() ) then
				target:SetNWBool( "dark_haunted", true )
				local dps = ents.Create( "dmg_dark" )
				dps:SetPos( target:EyePos() + Vector( 0, 0, 1024 ) )
				dps:SetOwner( attacker )
				dps:SetParent( target )
				
				dps:Spawn()
				dps:Activate()
			end
		end

		return
	end
	
	if ( element == EML_BLIGHT_ENT ) then
		if ( !IsValid( attacker ) ) then DevNotice( "@SciFiElementals : !Error, No attacker." ) return end
		if ( duration == nil ) then duration = 5 end
		
		if ( ( target:IsNPC() && !target:IsCurrentSchedule( SCHED_NPC_FREEZE ) ) || target:IsPlayer() ) && ( target:GetMaxHealth() < 1000 && target:GetNWBool( "fstar_entangled" ) == false ) then
			if ( target:IsNPC() ) then
				target:SetSchedule( SCHED_NPC_FREEZE )
				target:SetNWBool( "fstar_entangled", true )
				target:SetNPCState( NPC_STATE_IDLE )
			elseif ( target:IsPlayer() ) then
				target:AddFlags( FL_FROZEN )
				target:ScreenFade( SCREENFADE.IN, Color( 210, 240, 255, 80 ), duration / 2, duration / 2 )
				target:SetDSP( 32, false )
				target:SetNWBool( "fstar_entangled", true )
			end
			
			if ( target:IsNPC() || target:IsPlayer() ) && ( duration >= 2 ) then
				ParticleEffectAttach( "fstar_freeze_catch", 1, target, 1 )
			end
			
			timer.Create( "FakeFrozenThink"..target:EntIndex(), 0, 1024, function()
				if ( IsValid( target ) ) && ( target:Health() <= 1 && target:GetNWBool( "fstar_entangled" )  ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "fstar_entangled", false )
					if ( target:IsNPC() ) then
					target:SetSchedule( SCHED_WAKE_ANGRY )
					elseif ( target:IsPlayer() ) then
					target:RemoveFlags( FL_FROZEN )
					end
					
					ParticleEffectAttach( "fstar_freeze_release", 1, target, 1 )
					target:EmitSound( snd_stun_ebl )
					
					if ( IsValid( attacker ) && IsValid( attacker:GetActiveWeapon() ) ) then
						target:TakeDamage( 5, attacker, attacker:GetActiveWeapon() )
					end
				end
			end )
			
			timer.Simple( duration, function()
				timer.Remove( "FakeFrozenThink"..target:EntIndex() )
			end )

			timer.Simple( duration, function()
				if ( IsValid( target ) ) && ( SERVER ) && ( target:IsNPC() || target:IsPlayer() ) then
					target:SetNWBool( "fstar_entangled", false )
					if ( target:IsNPC() ) then
					target:SetSchedule( SCHED_FEAR_FACE )
					target:SetSchedule( SCHED_MOVE_AWAY )
					target:SetSchedule( SCHED_BACK_AWAY_FROM_ENEMY )
					target:SetSchedule( SCHED_RUN_FROM_ENEMY )
					elseif( target:IsPlayer() ) then
					target:RemoveFlags( FL_FROZEN )
					end
					ParticleEffectAttach( "fstar_freeze_release", 1, target, 1 )
					target:EmitSound( snd_stun_ebl )
				end
			end )
		end
		return
	end

end

function DoFreezeRagdolls( pos )

	for k, v in pairs ( ents.FindInSphere( pos, 16 ) ) do
		if ( v:IsRagdoll() && v:GetNWBool( "IsStatue" ) == false ) then
			local bones = v:GetPhysicsObjectCount()
			v.StatueInfo = {}
			for bone = 1, bones-1 do
				local constraint = constraint.Weld( v, v, 0, bone, 0 )
				
				if ( constraint ) then
						v.StatueInfo[bone] = constraint
				end
				
				local effectdata = EffectData()
				effectdata:SetOrigin( v:GetPhysicsObjectNum( bone ):GetPos() )
				effectdata:SetScale( 1 )
				effectdata:SetMagnitude( 1 )
				util.Effect( "GlassImpact", effectdata, true, true )
			end		
			
			if ( cmd_fx_particles ) then
				ParticleEffectAttach( "ice_freezing", 1, v, 1 )
			end
				
	--		v:EmitSound( snd_stun_ice_2 )
			v:SetMaterial( mat_stun_ice )
			v:SetNWBool( "IsStatue", true )

			local vPhys = v:GetPhysicsObject()
			
			if ( IsValid( vPhys ) ) then
				vPhys:AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				
				construct.SetPhysProp( nil, v, v:EntIndex(), vPhys, { GravityToggle = 1, Material = "concrete_block" } )
			end
		end
		
		if ( TargetClasses[ v:GetClass() ] || v:IsPlayer() ) then
			if ( cmd_fx_particles ) then
				ParticleEffectAttach( "ice_freezing_shortlt", 1, v, 1 )
			end
		end
	end

end

local icegibs = {
	"models/props_wasteland/rockgranite03b.mdl",
	"models/props_wasteland/rockgranite03c.mdl",
	"models/props_wasteland/rockgranite03a.mdl",
	"models/props_wasteland/rockgranite02c.mdl",
	"models/props_wasteland/rockgranite02b.mdl",
	"models/props_wasteland/rockgranite02a.mdl",
}

function DoShatterRagdolls( pos )

	if ( !GetConVar( "sfw_allow_propcreation" ):GetBool() ) then return end
	
	local cmd_particles = GetConVar( "sfw_fx_particles" ):GetBool()

	for k, v in pairs ( ents.FindInSphere( pos, 16 ) ) do
		if ( v:IsRagdoll() ) then
			v:SetNWBool( "IsVaporizing", true )
			
			if ( !CanUseExpensive() ) then return end
			
			local bones = v:GetPhysicsObjectCount()
			local sMin, sMax = v:GetModelBounds()
			local bMax = math.min( GetConVar( "sfw_fx_maxexpensive" ):GetInt(), bones )
			
			ParticleEffectAttach( "ice_freezing_release", 1, v, 1 )
		--	v:EmitSound( snd_stun_ice_2 )

			for bone = 1, bMax do
				local bOrigin, bRotation = v:GetBonePosition( bone )
				
				if ( !bOrigin || !bRotation ) then continue end
				
				local rng1 = math.random( 1, #icegibs )
				local rng2 = math.random( 5, 20 )
				local gibScale = Vector( 0.01, 0.01, 0.01 )
				local gibScaleFactor = ( sMin - sMax ):Length() * ( bone / 10 ) / ( bMax / 8 )
				local gibScaleFinal = math.max( gibScaleFactor / 200, 0.1 )
		--		print( gibScaleFactor, gibScaleFinal )

				local gib = ents.Create( "prop_physics_multiplayer" )
				gib:SetModel( icegibs[ rng1 ] )
				gib:SetPos( bOrigin + Vector( 0, 0, 16 ) )
				gib:SetAngles( bRotation )
				gib:SetMaterial( mat_stun_ice )
				gib:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				gib:SetModelScale( gibScaleFinal )
				gib:SetCollisionBounds( gibScale * -1, gibScale )
				gib:Spawn()
				
				gib:Activate()
				gib:Fire( "kill", "", rng2 )
				
				local gPhys = gib:GetPhysicsObject()
				if ( !IsValid( gPhys ) ) then
					gib:Remove()
					return 
				end
				
				gPhys:SetMass( 50 )
				gPhys:SetDragCoefficient( 16 )
				gPhys:ApplyForceOffset( bRotation:Forward() * ( 512 + bone * 2048 ) + bRotation:Up() * ( 1024 + bone * 512 ), pos )
				
				if ( cmd_particles ) then
					ParticleEffectAttach( "cryo_ragshatter", 1, gib, 1 )
						
					if ( rng1 > 3 ) then
						ParticleEffectAttach( "ice_freezing_shortlt", 1, gib, 1 )
					end
					
					if ( rng1 > 4 ) then
						ParticleEffectAttach( "cryo_ragshatter_frags_crystals", 1, gib, 1 )
					end
					
					if ( rng1 * 2 > rng2 ) then
						ParticleEffectAttach( "cryo_ragshatter_frags", 1, gib, 1 )
					end
					
					local effectdata = EffectData()
					effectdata:SetOrigin( gib:GetPos() )
					effectdata:SetScale( 2 )
					effectdata:SetMagnitude( 2 )
					util.Effect( "GlassImpact", effectdata, true, true )
				end
			end

			v:Fire( "kill", "", 0.02 )
		end
	end

end