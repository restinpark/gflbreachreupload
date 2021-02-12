if SERVER then AddCSLuaFile() end

--TRACER ;V

sound.Add({
	name = 			"NOPE_SYLVEON.1",
	channel = 		CHAN_STATIC,
	volume = 		0.7,
	sound = 			"weapons/sylveongun/sylgun_fire.wav"
})

sound.Add({
	name = 			"NOPE_SYLVEON.DEPLOY",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/sylveongun/sylgun_deploy.wav"
})

sound.Add({
	name = 			"NOPE_SYLVEON.RELOAD",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/sylveongun/sylgun_reload.wav"
})

sound.Add({
	name = 			"NOPE_SYLVEON.RELOAD00",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/sylveongun/sylgun_reload00.wav"
})

sound.Add({
	name = 			"Pokedex_N.Draw",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/sylveongun/cloth4.wav"
})

sound.Add({
	name = 			"Pokedex_N.Slam",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/sylveongun/slam.wav"
})

sound.Add({
	name = 			"Pokedex_N.Press",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/sylveongun/button_press_boost_add.wav"
})