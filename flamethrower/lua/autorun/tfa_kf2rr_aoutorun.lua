--[[ AUTHORS ]]
// 	TFA KF2 Remake Remade Remastered (not really)
// 	Original TFA KF2 Remake addon by JFA aka Alex35ru
//	Models/Animations:	Tripwire Interactive
// 	Sounds: 			Tripwire Interactive
//	Particles: 			Matsilagi / Zool / NMRH Std.

--[[ PARTICLES ]]
game.AddParticles("particles/kf2_muzzleflash_test.pcf")
game.AddParticles("particles/matsilagi_muzzle_kf.pcf")
game.AddParticles("particles/kf2_flamethrower2.pcf")
game.AddParticles("particles/ef_flamer.pcf") 
game.AddParticles("particles/muzzleflashes_test.pcf")
game.AddParticles("particles/muzzleflashes_test_b.pcf")

--[[ FONTS ]]
resource.AddFile("resource/fonts/holo.ttf")
resource.AddFile("resource/fonts/holo_b.ttf")
if CLIENT then
surface.CreateFont('sight_holo',{font='Transponder AOE',size=100,antialias=true})
surface.CreateFont('sight_holo_b',{font='Transponder Grid AOE',size=100,antialias=true})
surface.CreateFont('sight_holo_r',{font='Transponder AOE',size=60,antialias=true})
surface.CreateFont('sight_holo_rb',{font='Transponder Grid AOE',size=60,antialias=true})
end --stolen from alex's remake xddddddddd



// FLAMETHROWER
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.ClipOut",
	channel = 		CHAN_USER_BASE+11,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/clipout.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.ClipIn",
	channel = 		CHAN_USER_BASE+11,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/trapper/NapalmCannonIn.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.BoltBack",
	channel = 		CHAN_USER_BASE+11,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/trapper/FlameOut.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.BoltForward",
	channel = 		CHAN_USER_BASE+11,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/trapper/FlameIn.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Start",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1,
	pitch = {98,100},
	sound = 			"weapons/kf2/flamethrower/trapper/FlamerStart.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Loop",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1,
	pitch = {98,100},
	sound = 			"weapons/kf2/flamethrower/trapper/FlamerLoop.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.End",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1,
	pitch = {98,100},
	sound = 			"weapons/kf2/flamethrower/trapper/FlamerStop.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Equip",
	channel = 		CHAN_USER_BASE+11,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/boltforward.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Holster",
	channel = 		CHAN_USER_BASE+10,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/boltback.wav"
})
