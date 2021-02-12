

AddCSLuaFile()

if ( CLIENT ) && ( !steamworks.IsSubscribed( 420970650 ) ) then
	MsgC( Color( 220, 20, 40 ), "@SciFiWeapons : Tried to init Sci-Fi base without having the addon mounted\n" )
end

if ( SERVER ) then
--	local devkey = file.Find( "mana_unlocks_*", "DATA" )
	
--	if ( !devkey[1] ) then	
--		MsgC( Color( 220, 20, 40 ), "@SciFiWeapons : caching...\n" )
		resource.AddWorkshop( 420970650 )
--	else
--		MsgC( Color( 120, 130, 255 ), "@SciFiWeapons : found developer notice\n" )
--	end
end

-- Particles --

game.AddParticles( "particles/faton_fx.pcf" )


-- Particle systems --

PrecacheParticleSystem( "faton_beam" )
PrecacheParticleSystem( "faton_tracer" )
PrecacheParticleSystem( "faton_muzzle" )
PrecacheParticleSystem( "faton_impact" )
PrecacheParticleSystem( "faton_dissolve" )
PrecacheParticleSystem( "faton_dissolve_cheap" )
PrecacheParticleSystem( "faton_charge" )



