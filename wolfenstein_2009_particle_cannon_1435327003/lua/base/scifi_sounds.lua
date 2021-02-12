--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v17 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Initilizes sounds using the engine sound system.	--
------------------------------------------------------------------
-- Is called by autorun/scifi_init.lua							--
------------------------------------------------------------------

-- shared --
sound.Add( {
	name = "scifi.dmg.acidburn",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 70,
	pitch = {90, 110},
	sound = "elemental/acidburn.wav"
} )

sound.Add( {
	name = "scifi.dark.linger",
	channel = CHAN_AUTO,
	volume = 1,
	level = 70,
	pitch = { 95, 105 },
	sound = "weapons/umbra/growth.wav"
} )

sound.Add( {
	name = "scifi.dark.haunt.1",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = { 95, 105 },
	sound = "elemental/dark_haunt_1.wav"
} )

sound.Add( {
	name = "scifi.dark.haunt.2",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = { 95, 105 },
	sound = "elemental/dark_haunt_2.wav"
} )

sound.Add( {
	name = "scifi.dark.haunt.3",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = { 95, 105 },
	sound = "elemental/dark_haunt_3.wav"
} )

sound.Add( {
	name = "scifi.dark.haunt.4",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = { 95, 105 },
	sound = "elemental/dark_haunt_4.wav"
} )

sound.Add( {
	name = "scifi.dark.haunt.5",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = { 95, 105 },
	sound = "elemental/dark_haunt_5.wav"
} )

sound.Add( {
	name = "scifi.dark.haunt.6",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = { 95, 105 },
	sound = "elemental/dark_haunt_6.wav"
} )

sound.Add( {
	name = "scifi.dark.haunt.7",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = { 95, 105 },
	sound = "elemental/dark_haunt_7.wav"
} )

sound.Add( {
	name = "scifi.dark.release",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 70,
	pitch = {90, 110},
	sound = "weapons/umbra/growth.wav"
} )

sound.Add( {
	name = "scifi.dark.stackup",
	channel = CHAN_STATIC,
	volume = 1,
	level = 70,
	pitch = { 95, 105 },
	sound = "weapons/umbra/whisper.wav"
} )

sound.Add( {
	name = "scifi.dark.succumb",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = { 95, 105 },
	sound = "weapons/umbra/devour.wav"
} )

sound.Add( {
	name = "scifi.dark.snack",
	channel = CHAN_AUTO,
	volume = 1,
	level = 60,
	pitch = { 95, 110 },
	sound = "weapons/umbra/snack.wav"
} )

sound.Add( {
	name = "scifi.melee.swing.light", 
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 70,
	pitch = {95, 105},
	sound = "weapons/misc/melee_swing_light.wav"
} )

sound.Add( {
	name = "scifi.melee.swing.medium", 
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 70,
	pitch = {95, 105},
	sound = "weapons/misc/melee_swing_medium.wav"
} )

sound.Add( {
	name = "scifi.melee.swing.heavy", 
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 70,
	pitch = {95, 105},
	sound = "weapons/misc/melee_swing_heavy.wav"
} )

sound.Add( {
	name = "scifi.melee.hit.world", 
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 85,
	pitch = {95, 105},
	sound = "weapons/misc/melee_hit_world.wav"
} )

sound.Add( {
	name = "scifi.melee.hit.body", 
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 85,
	pitch = {95, 105},
	sound = "weapons/misc/melee_hit_body.wav"
} )

sound.Add( {
	name = "scifi.ngen.explosion",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 100,
	pitch = {95, 105},
	sound = "weapons/misc/ngen_explosion.wav"
} )

-- trace --
sound.Add( {
	name = "scifi.trace.fire1", 
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 85,
	pitch = {95, 110},
	sound = "weapons/trace/trace_fire_mono.wav"
} )

-- thunderbolt --
sound.Add( {
	name = "scifi.tbolt.throw", 
	channel = CHAN_WEAPON, 
	volume = 0.4, 
	level = 50, 
	pitch = {100, 120},
	sound = "weapons/tbolt/tbolt_fire.wav"
} )

sound.Add( {
	name = "scifi.tbolt.hold", 
	channel = CHAN_WEAPON, 
	volume = 0.4, 
	level = 50, 
	pitch = {100, 120},
	sound = "weapons/tbolt/tbolt_fx2.wav"
} )

-- storm --
sound.Add( {
	name = "scifi.storm.fire", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = 90, 
	pitch = {97, 103},
	sound = "weapons/storm/storm_fire_new.wav"
} )

sound.Add( {
	name = "scifi.storm.hit",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {96, 104},
	sound = "weapons/storm/storm_hit.wav"
} )

sound.Add( {
	name = "scifi.storm.reload.start",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 40,
	pitch = {99, 101},
	sound = "weapons/storm/storm_reload.wav"
} )

sound.Add( {
	name = "scifi.storm.reload.finish",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 50,
	pitch = {99, 101},
	sound = "weapons/storm/storm_reload_finish.wav"
} )

sound.Add( {
	name = "scifi.storm.dryfire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 40,
	pitch = {99, 101},
	sound = "weapons/storm/storm_dryfire.wav"
} )

-- pulsar --
sound.Add( {
	name = "scifi.pulsar.fire", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = 100, 
	pitch = {97, 103},
	sound = "weapons/pulsar/pulsar_fire.wav"
} )

sound.Add( {
	name = "scifi.pulsar.echo",
	channel = CHAN_STATIC, 
	volume = 0.64, 
	level = 100, 
	pitch = {97, 103},
	sound = "weapons/pulsar/pulsar_echo.wav"
} )

sound.Add( {
	name = "scifi.pulsar.altfire", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = SNDLVL_GUNFIRE, 
	pitch = {110, 150},
	sound = "weapons/pulsar/pulsar_altfire.wav"
} )

sound.Add( {
	name = "scifi.pulsar.charge.increase", 
	channel = CHAN_ITEM, 
	volume = 1.0, 
	level = SNDLVL_120dB, 
	pitch = 100,
	sound = "weapons/pulsar/pulsar_charge.wav"
} )

sound.Add( {
	name = "scifi.pulsar.charge.decrease", 
	channel = CHAN_ITEM, 
	volume = 1.0, 
	level = SNDLVL_120dB, 
	pitch = 100,
	sound = "weapons/pulsar/pulsar_charge_fail.wav"
} )

-- hellfire --
sound.Add( {
	name = "scifi.hfire.fire1", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = SNDLVL_GUNFIRE, 
	pitch = {98, 102},
	sound = "weapons/hfire/fire.wav"
} )

sound.Add( {
	name = "scifi.hfire.hit", 
	channel = CHAN_STATIC, 
	volume = 1.0, 
	level = SNDLVL_GUNFIRE, 
	pitch = {95, 105},
	sound = "weapons/hfire/hit_small.wav"
} )

sound.Add( {
	name = "scifi.hfire.altfirehit", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = SNDLVL_GUNFIRE, 
	pitch = 100,
	sound = "weapons/hfire/hit_large.wav"
} )

-- vapor --
sound.Add( {
	name = "scifi.vapor.dissolve",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "effects/vapor_dissolve.wav"
} )

sound.Add( {
	name = "scifi.vapor.reload",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_85dB,
	pitch = 100,
	sound = "weapons/vapor/vapor_reload_new.wav"
} )
	

sound.Add( {
	name = "scifi.vapor.fire1", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = SNDLVL_GUNFIRE, 
	pitch = {100, 108},
	sound = "weapons/vapor/pfire_fire.wav"
} )

sound.Add( {
	name = "scifi.vapor.hit", 
	channel = CHAN_STATIC, 
	volume = 1.0, 
	level = 85, 
	pitch = {100, 108},
	sound = "weapons/vapor/pfire_hit.wav"
} )

sound.Add( {
	name = "scifi.vapor.idleloop",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_135dB,
	pitch = {95, 105},
	sound = "weapons/vapor/idleloop.wav"
} )

sound.Add( {
	name = "scifi.vapor.altfirecharge",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = PITCH_NORM,
	sound = "weapons/vapor/secfire_charge.wav"
} )

sound.Add( {
	name = "scifi.vapor.altfireshoot",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 90,
	pitch = PITCH_NORM,
	sound = "weapons/vapor/sfire_fire.wav"
} )

sound.Add( {
	name = "scifi.vapor.altfireboom", 
	channel = CHAN_STATIC, 
	volume = 1.0, 
	level = 80, 
	pitch =	PITCH_NORM,
	sound = "weapons/vapor/secfire_hit.wav"
} )

sound.Add( {
	name = "scifi.vapor.altfireecho",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 100,
	pitch = PITCH_NORM,
	sound = "weapons/vapor/secfire_echo.wav"
} )

sound.Add( {
	name = "scifi.vapor.nade.launch", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = 75, 
	pitch =	PITCH_NORM,
	sound = "weapons/vapor/vapornade_launch.wav"
} )

sound.Add( {
	name = "scifi.vapor.nade.explo", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = 90, 
	pitch =	PITCH_NORM,
	sound = "weapons/vapor/vapornade_explode.wav"
} )

sound.Add( { 
	name = "scifi.aquam.pfire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = {96,104},
	sound = "weapons/vapor/aq_fire.wav"
} )

-- grinder --
sound.Add( {
	name = "scifi.grinder.pfire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = {97, 103},
	sound = "weapons/grinder/fire.wav"
} )

-- falling star --
sound.Add( {
	name = "scifi.fstar.fire1", 
	channel = CHAN_WEAPON, 
	volume = 1.0, 
	level = SNDLVL_GUNFIRE, 
	pitch = {98, 108},
	sound = "weapons/vapor/fstar_pfire.wav"
} )

sound.Add( {
	name = "scifi.fstar.altfirecharge",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = PITCH_NORM,
	sound = "weapons/vapor/fstar_charge.wav"
} )

sound.Add( {
	name = "scifi.fstar.altfireshoot",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = PITCH_NORM,
	sound = "weapons/vapor/fstar_sfire.wav"
} )

sound.Add( {
	name = "scifi.fstar.altfireboom", 
	channel = CHAN_STATIC, 
	volume = 1.0, 
	level = 100, 
	pitch =	PITCH_NORM,
	sound = "weapons/vapor/fstar_sfire_echo.wav"
} )

-- vk21 --
sound.Add( {
	name = "cat.vk21.pfire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {97, 103},
	sound = "weapons/catalyst/vk21_fire.wav"
} )

sound.Add( {
	name = "cat.vk21.pfire.silent",
	channel = CHAN_WEAPON,
	volume = 0.4,
	level = 40,
	pitch = {97, 103},
	sound = "weapons/catalyst/vk21_fire.wav"
} )

sound.Add( {
	name = "cat.vk21he.pfire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = {95, 105},
	sound = "weapons/catalyst/vk21_he_fire.wav"
} )

sound.Add( {
	name = "cat.vk21hv.pfire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = {95, 105},
	sound = "weapons/catalyst/vk21_hv_fire.wav"
} )

sound.Add( {
	name = "cat.ca3.hit",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = { 95, 100 },
	sound = "effects/ca3_hit.wav"
} )

-- pds-h --
sound.Add( {
	name = "cat.pest.pfire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {98, 102},
	sound = "weapons/catalyst/pest_fire.wav"
} )

sound.Add( {
	name = "cat.pest.hit",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = { 95, 100 },
	sound = "effects/pest_hit.wav"
} )

-- hlk --
sound.Add( {
	name = "cat.hlk.pfire", 
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = {94, 100},
	sound = "weapons/catalyst/hlk_fire.wav"
} )

-- cryo --
sound.Add( {
	name = "scifi.cryo.explode",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 92,
	pitch = {95, 105},
	sound = "weapons/misc/cryo_explo.wav"
} )

sound.Add( {
	name = "scifi.cryo.freeze", 
	channel = CHAN_STATIC,
	volume = 1,
	level = SNDLVL_GUNFIRE, --SNDLVL_85dB,
	pitch = {95, 105},
	sound = "elemental/freeze.wav"
} )

sound.Add( {
	name = "scifi.bliz.freeze", 
	channel = CHAN_STATIC,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = {95, 105},
	sound = "elemental/freeze_short.wav"
} )

sound.Add( {
	name = "scifi.bliz.breakfree",
	channel = CHAN_STATIC,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = {95, 105},
	sound = "elemental/freeze_breakfree.wav"
} )

sound.Add( {
	name = "scifi.bliz.shatter",
	channel = CHAN_STATIC,
	volume = 1,
	level = 110,
	pitch = {95, 105},
	sound = "elemental/freeze_shatter.wav"
} )

sound.Add( {
	name = "scifi.bliz.hit",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {95, 105},
	sound = "effects/ice_hit.wav"
} )

-- neutrino --
sound.Add( {
	name = "scifi.neutrino.charge",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "weapons/neutrino/charge.wav"
} )

sound.Add( {
	name = "scifi.neutrino.fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "weapons/neutrino/fire1.wav"
} )

sound.Add( {
	name = "scifi.neutrino.flyby",
	channel = CHAN_STATIC,
	volume = 1,
	level = SNDLV_85dB,
	pitch = {95, 105},
	sound = "weapons/neutrino/flyby.wav"
} )

sound.Add( {
	name = "scifi.neutrino.impact",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 70,
	pitch = {92, 108},
	sound = "weapons/neutrino/impact.wav"
} )

sound.Add( {
	name = "scifi.neutrino.dissolve",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "effects/nio_dissolve.wav"
} )

-- stinger --
sound.Add( {
	name = "scifi.stinger.fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "weapons/stinger/sting_fire1.wav"
} )

sound.Add( {
	name = "scifi.stinger.rearm",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "weapons/umbra/umbra_bback.wav"
} )

sound.Add( {
	name = "scifi.stinger.attach",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "weapons/stinger/sting_attach.wav"
} )

sound.Add( {
	name = "scifi.stinger.explode",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 85,
	pitch = {92, 108},
	sound = "weapons/stinger/sting_explode.wav"
} )

-- meteor --
sound.Add( {
	name = "scifi.mtmmissile.beep.idle",
	channel = CHAN_ITEM,
	volume = 0.8,
	level = SNDLVL_85dB,
	pitch = {100, 105},
	sound = "weapons/misc/missilebeep.wav"
} )

sound.Add( {
	name = "scifi.mtmmissile.beep.hunting",
	channel = CHAN_ITEM,
	volume = 1,
	level = SNDLVL_105dB,
	pitch = {130, 135},
	sound = "weapons/misc/missilebeep.wav"
} )

sound.Add( {
	name = "scifi.mtmmissile.loop",
	channel = CHAN_STATIC,
	volume = 1,
	level = 70,
	pitch = {130, 135},
	sound = "weapons/misc/missileloop.wav"
} )

-- heatwave --
sound.Add( {
	name = "scifi.hwave.fire1",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {96, 104},
	sound = "weapons/hwave/hwave_fire1.wav"
} )

sound.Add( {
	name = "scifi.hwave.flyby",
	channel = CHAN_STATIC,
	volume = 0.6,
	level = 60,
	pitch = {120, 180},
	sound = "weapons/hwave/hwave_flyby.wav"
} )

sound.Add( {
	name = "scifi.hwave.hit",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {98, 102},
	sound = "weapons/hwave/hwave_hit.wav"
} )

sound.Add( {
	name = "scifi.hwave.reload",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = {98, 102},
	sound = "weapons/hwave/hwave_reload.wav"
} )

sound.Add( {
	name = "scifi.hwave.reload_new",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = {98, 102},
	sound = "weapons/hwave/hwave_reload_new.wav"
} )

sound.Add( {
	name = "scifi.hwave.switchmode",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = 100,
	sound = "weapons/hwave/hwave_switchmode.wav"
} )

-- sapphire --
sound.Add( {
	name = "scifi.saph.fire1",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {96, 104},
	sound = "weapons/hwave/saph_fire.wav"
} )

sound.Add( {
	name = "scifi.saph.fire2",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {96, 104},
	sound = "weapons/hwave/saph_fire_finish.wav"
} )

-- phoenix --
sound.Add( {
	name = "scifi.pele.fire1",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {97, 103},
	sound = "weapons/hwave/pele_fire_.wav"
} )

sound.Add( {
	name = "scifi.pele.fire2",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = {97, 103},
	sound = "weapons/hwave/pele_fire.wav"
} )

sound.Add( {
	name = "scifi.pele.bback",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = SNDLVL_85dB,
	pitch = 100,
	sound = "weapons/hwave/pele_bback.wav"
} )

-- seraphim --
sound.Add( {
	name = "scifi.seraph.fire1",
	channel = CHAN_STATIC,
	volume = 0.8,
	level = 92,
	pitch = {97, 103},
	sound = "weapons/misc/phaz_heavy.wav"
} )

sound.Add( {
	name = "scifi.hwave.dissolve",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {92, 108},
	sound = "effects/hwave_dissolve.wav"
} )

-- ember --
sound.Add( {
	name = "scifi.ember.laser.start",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {96, 104},
	sound = "weapons/hwave/ember_start.wav"
} )

sound.Add( {
	name = "scifi.ember.laser.off",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {96, 104},
	sound = "weapons/hwave/ember_off.wav"
} )

sound.Add( {
	name = "scifi.ember.laser.burn",
	channel = CHAN_STATIC,
	volume = 0.2,
	level = SNDLVL_GUNFIRE,
	pitch = {96, 104},
	sound = "weapons/hwave/ember_burn.wav"
} )

sound.Add( {
	name = "scifi.ember.laser",
	channel = CHAN_STATIC,
	volume = 0.2,
	level = SNDLVL_GUNFIRE,
	pitch = 100,
	sound = "weapons/hwave/ember_noise_loop.wav"
} )

-- draco --
sound.Add( {
	name = "scifi.drake.fire1",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 90,
	pitch = {94, 106},
	sound = "weapons/hwave/drake_fire.wav"
} )

-- pandemic --
sound.Add( {
	name = "scifi.pandemic.pfire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = {97, 103},
	sound = "weapons/corro/panda_pfire.wav"
} )

-- behemoth --
sound.Add( {
	name = "scifi.behemoth.reload",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 60,
	pitch = PITCH_NORM,
	sound = "weapons/moby/reload.wav"
} )

sound.Add( {
	name = "scifi.behemoth.reload_break",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 60,
	pitch = PITCH_NORM,
	sound = "weapons/moby/reload_break.wav"
} )

sound.Add( {
	name = "scifi.behemoth.spinup",
	channel = CHAN_ITEM,
	volume = 1,
	level = 60,
	pitch = PITCH_NORM,
	sound = "weapons/moby/spinup.wav"
} )

sound.Add( {
	name = "scifi.behemoth.spindn",
	channel = CHAN_ITEM,
	volume = 0.4,
	level = 60,
	pitch = PITCH_NORM,
	sound = "weapons/moby/spindn.wav"
} )

-- hornet --
sound.Add( {
	name = "scifi.hornet.pfire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = {97, 103},
	sound = "weapons/hornet/hornet_fire1.wav"
} )

sound.Add( {
	name = "scifi.hornet.sfire",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = {97, 103},
	sound = "weapons/hornet/hornet_fire2.wav"
} )

sound.Add( {
	name = "scifi.hornet.reload",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = PITCH_NORM,
	sound = "weapons/hornet/hornet_reload.wav"
} )

sound.Add( {
	name = "scifi.hornet.dart.charge",
	channel = CHAN_ITEM,
	volume = 1,
	level = 80,
	pitch = {97, 103},
	sound = "weapons/hornet/flech_charge.wav"
} )

sound.Add( {
	name = "scifi.hornet.dart.explode",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = {97, 103},
	sound = "weapons/hornet/flech_explode.wav"
} )

-- celestial's  shared --
sound.Add( {
	name = "scifi.ancient.sight.turnon",
	channel = CHAN_ITEM,
	volume = 1,
	level = 40,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/celest_scope_enable.wav"
} )

sound.Add( {
	name = "scifi.ancient.sight.turnoff",
	channel = CHAN_ITEM,
	volume = 1,
	level = 40,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/celest_scope_disable.wav"
} )

sound.Add( {
	name = "scifi.ancient.fmchange",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/celest_fm_change.wav"
} )

sound.Add( {
	name = "scifi.ancient.bshock",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/blight_shock.wav"
} )

sound.Add( {
	name = "scifi.ancient.overheat",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/overheat.wav"
} )

-- spectra --
sound.Add( {
	name = "scifi.spectra.fire1",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = {97, 103},
	sound = "weapons/ancient/spectra_fire_silent.wav"
} )

sound.Add( {
	name = "scifi.spectra.fire1.nosilence",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = {97, 103},
	sound = "weapons/ancient/spectra_fire.wav"
} )

sound.Add( {
	name = "scifi.spectra.fire2",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = {97, 103},
	sound = "weapons/ancient/alchemy_fire1.wav"
} )

sound.Add( {
	name = "scifi.spectra.fm.up",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 50,
	pitch = {97, 103},
	sound = "weapons/ancient/spectra_fm_up.wav"
} )

sound.Add( {
	name = "scifi.spectra.fm.dn",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 50,
	pitch = {97, 103},
	sound = "weapons/ancient/spectra_fm_dn.wav"
} )

sound.Add( {
	name = "scifi.spectra.hit",
	channel = CHAN_STATIC,
	volume = 1,
	level = 75,
	pitch = {92, 108},
	sound = "weapons/ancient/spectra_hit.wav"
} )

-- supra --
sound.Add( {
	name = "scifi.supra.fire1",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = {97, 103},
	sound = "weapons/ancient/supra_fire1.wav"
} )

sound.Add( {
	name = "scifi.supra.parent.hit",
	channel = CHAN_STATIC,
	volume = 1,
	level = 80,
	pitch = {97, 103},
	sound = "weapons/ancient/supra_p_hit.wav"
} )

sound.Add( {
	name = "scifi.supra.child.arm",
	channel = CHAN_ITEM,
	volume = 1,
	level = 80,
	pitch = {97, 103},
	sound = "weapons/ancient/supra_c_arm.wav"
} )

sound.Add( {
	name = "scifi.supra.child.hit",
	channel = CHAN_ITEM,
	volume = 1,
	level = 95,
	pitch = {97, 103},
	sound = "weapons/ancient/supra_c_hit.wav"
} )

-- astra --
sound.Add( {
	name = "scifi.astra.zoomin",
	channel = CHAN_ITEM,
	volume = 1,
	level = 40,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/astra_to_sniper.wav"
} )

sound.Add( {
	name = "scifi.astra.zoomout",
	channel = CHAN_ITEM,
	volume = 1,
	level = 40,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/astra_to_carbine.wav"
} )

sound.Add( {
	name = "scifi.astra.lightfire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 60,
	pitch = {95, 105},
	sound = "weapons/ancient/astra_fire_normal.wav"
} )

sound.Add( {
	name = "scifi.astra.heavyfire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 85,
	pitch = {95, 105},
	sound = "weapons/ancient/astra_fire_heavy.wav"
} )

-- vectra --
sound.Add( {
	name = "scifi.vectra.fire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 85,
	pitch = {95, 105},
	sound = "weapons/ancient/vectra_fire.wav"
} )

-- zeala --
sound.Add( {
	name = "scifi.zeala.fire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/zeala_fire1.wav"
} )

sound.Add( {
	name = "scifi.zeala.vortex",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = {92, 108},
	sound = "weapons/ancient/zeala_suck.wav"
} )

sound.Add( {
	name = "scifi.zeala.burst.intro", 
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = PITCH_NORM,
	sound = "weapons/vapor/fstar_sfire.wav"
} )

sound.Add( {
	name = "scifi.zeala.burst",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/zeala_burst.wav"
} )

-- phasma --
sound.Add( {
	name = "scifi.phasma.blade.turnon",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 60,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/phasma_blade_turnon.wav"
} )

sound.Add( {
	name = "scifi.phasma.blade.turnoff",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 60,
	pitch = PITCH_NORM,
	sound = "weapons/ancient/phasma_blade_turnoff.wav"
} )

sound.Add( {
	name = "scifi.phasma.blade.swing",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = {92, 108},
	sound = "weapons/ancient/phasma_swing.wav"
} )

sound.Add( {
	name = "scifi.phasma.blade.stab",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
--	pitch = {92, 108},
	sound = "weapons/ancient/phasma_stab.wav"
} )

sound.Add( {
	name = "scifi.phasma.blade.scratch",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {92, 108},
	sound = "weapons/neutrino/flyby.wav"
} )

sound.Add( {
	name = "scifi.phasma.absorb",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = 100,
	sound = "weapons/ancient/phasma_absorb.wav"
} )

-- wrath -- 
sound.Add( {
	name = "scifi.wrath.dissolve",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {90, 110},
	sound = "effects/celestwrath.wav"
} )

sound.Add( {
	name = "scifi.wrath.dissolve.scream",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {90, 110},
	sound = "vo/os_neardeath_scream.wav"
} )

-- jotunn --
sound.Add( {
	name = "scifi.jotunn.deploy",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {97, 103},
	sound = "weapons/jotunn/deploy.wav"
} )

sound.Add( {
	name = "scifi.jotunn.holster",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {97, 103},
	sound = "weapons/jotunn/holster.wav"
} )

sound.Add( {
	name = "scifi.jotunn.charge",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 60,
	pitch = {92, 108},
	sound = "weapons/jotunn/charge.wav"
} )

sound.Add( {
	name = "scifi.jotunn.fire",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {92, 108},
	sound = "weapons/jotunn/fire.wav"
} )

-- fenris --
sound.Add( {
	name = "Scifi.Blade.Idle",
	channel = CHAN_ITEM,
	volume = 1,
	level = SNDLVL_70dB,
	pitch = 100,
	sound = "weapons/eblade/eblade_idle.wav"
} )

sound.Add( {
	name = "Scifi.Blade.Hit.Electric01",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = {80, 120},
	sound = "weapons/eblade/eblade_shock_01.wav"
} )

sound.Add( {
	name = "Scifi.Blade.Hit.Electric02",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = {80, 120},
	sound = "weapons/eblade/eblade_shock_02.wav"
} )

sound.Add( {
	name = "Scifi.Blade.Hit.Electric03",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {90, 110},
	sound = "weapons/eblade/eblade_shock_02.wav"
} )

sound.Add( {
	name = "Scifi.Blade.Hit",
	channel = CHAN_STATIC,
	volume = 1,
	level = 80,
	pitch = {90, 110},
	sound = "weapons/eblade/eblade_hit.wav"
} )

sound.Add( {
	name = "Scifi.Blade.Swing01",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = {97, 103},
	sound = "weapons/eblade/eblade_swing_01.wav"
} )

sound.Add( {
	name = "Scifi.Blade.Swing02",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = {97, 103},
	sound = "weapons/eblade/eblade_swing_02.wav"
} )

sound.Add( {
	name = "Scifi.Blade.Swing03",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_85dB,
	pitch = {97, 103},
	sound = "weapons/eblade/eblade_swing_03.wav"
} )

-- fathom --
sound.Add( {
	name = "scifi.fathom.explode",
	channel = CHAN_STATIC,
	level = 90,
	pitch = {90, 110},
	sound = "weapons/fathom/explode.wav"
} )

sound.Add( {
	name = "scifi.fathom.idle",
	channel = CHAN_ITEM,
	level = 60,
	pitch = {98, 102},
	sound = "weapons/fathom/idle.wav"
} )

-- ASA-6 --
sound.Add( {
	name = "scifi.asa6.fire1",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 85,
	pitch = {98, 102},
	sound = "weapons/asa/asa6_fire1.wav"
} )

sound.Add( {
	name = "scifi.asa6.fire1.echo",
	channel = CHAN_STATIC,
	volume = 0.55,
	level = 100,
	pitch = {98, 102},
	sound = "weapons/asa/asa6_fire1_echo.wav"
} )

sound.Add( {
	name = "scifi.asa6.reload.bback",
	channel = CHAN_STATIC,
	volume = 1,
	level = 40,
	pitch = {98, 102},
	sound = "weapons/asa/asa6_bback.wav"
} )

sound.Add( {
	name = "scifi.hybridammo.fire1",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = {98, 102},
	sound = "weapons/asa/hybridammo_fire.wav"
} )

sound.Add( {
	name = "scifi.hybridsniper.fire.default",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = {98, 102},
	sound = "weapons/asa/hybridsniper_default.wav"
} )

sound.Add( {
	name = "scifi.hybridsniper.fire.silent",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = {98, 102},
	sound = "weapons/asa/hybridsniper_silent.wav"
} )

-- mamba --
sound.Add( {
	name = "scifi.mamba.fire.silent0",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 50,
	pitch = {98, 102},
	sound = "weapons/asa/rev_silent.wav"
} )

sound.Add( {
	name = "scifi.mamba.fire.silent1",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {98, 102},
	sound = "weapons/asa/rev_silent_echo.wav"
} )

sound.Add( {
	name = "scifi.mamba.fire.default0",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = {98, 102},
	sound = "weapons/asa/rev_nosilent.wav"
} )

sound.Add( {
	name = "scifi.mamba.fire.default1",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = {98, 102},
	sound = "weapons/asa/rev_nosilent_echo.wav"
} )

sound.Add( {
	name = "scifi.mamba.zoomin",
	channel = CHAN_ITEM,
	volume = 1,
	level = 40,
	pitch = {98, 102},
	sound = "weapons/asa/rev_enable.wav"
} )

sound.Add( {
	name = "scifi.mamba.zoomout",
	channel = CHAN_ITEM,
	volume = 1,
	level = 40,
	pitch = {98, 102},
	sound = "weapons/asa/rev_disable.wav"
} )

sound.Add( {
	name = "scifi.atype.fire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = {98, 102},
	sound = "weapons/asa/atypethree_fire.wav"
} )

sound.Add( {
	name = "scifi.atype.fire.echo",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = {98, 102},
	sound = "weapons/asa/atypethree_fire_echo.wav"
} )

sound.Add( {
	name = "scifi.talon.fire",
	channel = CHAN_WEAPON,
	level = 80,
	pitch = {98, 102},
	sound = "weapons/asa/talon_fire.wav"
} )

sound.Add( {
	name = "scifi.wraithshot.fire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_GUNFIRE,
	pitch = {90, 110},
	sound = "weapons/asa/wraithshot_fire.wav"
} )

sound.Add( {
	name = "scifi.wraithshot.fire.echo",
	channel = CHAN_STATIC,
	volume = 1,
	level = 80,
	pitch = {98, 102},
	sound = "weapons/asa/wraithshot_echo.wav"
} )

sound.Add( {
	name = "scifi.wraithshot.fire.charged",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 80,
	pitch = {90, 110},
	sound = "weapons/asa/wraithshot_fire_charged.wav"
} )

sound.Add( {
	name = "scifi.wraithshot.hit",
	channel = CHAN_ITEM,
	volume = 1,
	level = 60,
	pitch = {98, 102},
	sound = "weapons/asa/wraithshot_flyby.wav"
} )

sound.Add( {
	name = "scifi.wraithshot.flyby",
	channel = CHAN_ITEM,
	volume = 1,
	level = 60,
	pitch = {98, 102},
	sound = "weapons/asa/wraithshot_hit.wav"
} )

-- umbra --
sound.Add( {
	name = "scifi.umbra.growl",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 60,
	pitch = 100,
	sound = "weapons/umbra/growl.wav"
} )

sound.Add( {
	name = "scifi.umbra.hunt",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = 100,
	sound = "weapons/umbra/hunt.wav"
} )

sound.Add( {
	name = "scifi.umbra.rest",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 70,
	pitch = 100,
	sound = "weapons/umbra/rest.wav"
} )

-- items --
sound.Add( {
	name = "scifi.item.orb.bounce",
	channel = CHAN_ITEM,
	volume = 1,
	level = SNDLVL_105dB,
	pitch = {90, 110},
	sound = "items/orb_bounce.wav"
} )

sound.Add( {
	name = "cat.dart.flyby",
	channel = CHAN_STATIC,
	volume = 1,
	level = SNDLV_85dB,
	pitch = {90, 110},
	sound = "weapons/misc/dart_flyby.wav"
} )