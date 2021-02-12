hook.Add("EntityTakeDamage","BlockBGORagDMG",function(ent,dmg)
	if ent:IsPlayer() and IsValid(dmg:GetInflictor()) and dmg:GetInflictor():GetClass() == "bgo_ragdoll" then
		return true
	end
end)

hook.Add("EntityTakeDamage","BlockGaussSelfDamage",function(ent,dmg)
	if ent:IsPlayer() and dmg:GetAttacker() == ent and IsValid(ent:GetActiveWeapon()) and ent:GetActiveWeapon():GetClass() == "tfa_doom_gauss" then
		return true
	end
end)

hook.Add("ScalePlayerDamage","BlockGaussSelfDamageScaled",function(ply,hitgroup,dmg)
	if IsValid(dmg:GetInflictor()) and dmg:GetInflictor():GetClass() == "tfa_doom_gauss" and dmg:GetInflictor().Owner == ply then
		return true
	end
end)









game.AddParticles("particles/tfa_gauss_particles.pcf")





PrecacheParticleSystem("gauss_expl_shockwave_xy")

PrecacheParticleSystem("gauss_expl_shockwave_xz")

PrecacheParticleSystem("gauss_expl_smoke")

PrecacheParticleSystem("gauss_expl_smoke2")

PrecacheParticleSystem("gauss_expl_sparks")

PrecacheParticleSystem("gauss_explosion")

PrecacheParticleSystem("gauss_muzzleflash")

PrecacheParticleSystem("gauss_pilot")

PrecacheParticleSystem("gauss_siege_charge_elec")

PrecacheParticleSystem("gauss_siege_charge_glow")

PrecacheParticleSystem("gauss_siege_charge_muzzle")

PrecacheParticleSystem("gauss_siege_charge_smoke")

PrecacheParticleSystem("gauss_siege_smoke")

PrecacheParticleSystem("gauss_siege_smoke_l")

PrecacheParticleSystem("gauss_siege_smoke_r")

PrecacheParticleSystem("gauss_sniper_flash")

PrecacheParticleSystem("gauss_sniper_shockwave")

PrecacheParticleSystem("gauss_sniper_muzzleflash")

PrecacheParticleSystem("weapon_gauss_beam")

PrecacheParticleSystem("weapon_gauss_rail")

PrecacheParticleSystem("weapon_gauss_rail_end")

PrecacheParticleSystem("weapon_gauss_rail_noise")

PrecacheParticleSystem("weapon_gauss_rings")

PrecacheParticleSystem("weapon_gauss_rail_siege") --Use this for the Siege firing

PrecacheParticleSystem("weapon_gauss_rail_precision") --Use this for Precision Firing

PrecacheParticleSystem("weapon_gauss_rail_normal") --Use this for uncharged fire









sound.Add({
	name = 			"TFA_Gauss.Fire",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		{"weapons/tfa_doom_gauss/gauss_fire1.wav","weapons/tfa_doom_gauss/gauss_fire2.wav","weapons/tfa_doom_gauss/gauss_fire3.wav","weapons/tfa_doom_gauss/gauss_fire4.wav"}
})

sound.Add({
	name = 			"TFA_Gauss.SiegeCharge",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/gauss_siege_start2.wav"
})

sound.Add({
	name = 			"TFA_Gauss.SiegeFire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		{"weapons/tfa_doom_gauss/gauss_siege_fire1.wav","weapons/tfa_doom_gauss/gauss_siege_fire2.wav","weapons/tfa_doom_gauss/gauss_siege_fire3.wav","weapons/tfa_doom_gauss/gauss_siege_fire4.wav"}
})

sound.Add({
	name = 			"TFA_Gauss.SiegeRelease",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		{"weapons/tfa_doom_gauss/gauss_siege_stop1.wav","weapons/tfa_doom_gauss/gauss_siege_stop2.wav","weapons/tfa_doom_gauss/gauss_siege_stop3.wav"}
})

sound.Add({
	name = 			"TFA_Gauss.SiegeHolster",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/GCSiegeDownSimpler.wav"
})

sound.Add({
	name = 			"TFA_Gauss.SiegeChargeIdle",
	channel = 		CHAN_AUTO,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/gauss_siege_loop.wav"
})

sound.Add({
	name = 			"TFA_Gauss.PrecisionCharge",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/gauss_precision_start_mixed.wav"
})

sound.Add({
	name = 			"TFA_Gauss.PrecisionFire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		{"weapons/tfa_doom_gauss/gauss_sniper_fire1.wav","weapons/tfa_doom_gauss/gauss_sniper_fire2.wav","weapons/tfa_doom_gauss/gauss_sniper_fire3.wav","weapons/tfa_doom_gauss/gauss_sniper_fire4.wav"}
})

sound.Add({
	name = 			"TFA_Gauss.PrecisionRelease",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/gauss_precision_stop1.wav"
})

sound.Add({
	name = 			"TFA_Gauss.PrecisionChargeIdle",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/gauss_precision_charge_idle.wav"
})

sound.Add({
	name = 			"TFA_Gauss.PrecisionHumIdle",
	channel = 		CHAN_AUTO,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/gauss_precision_charge_idle.wav"
})

sound.Add({
	name = 			"TFA_Gauss.Idle",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 		"weapons/tfa_doom_gauss/gauss_idle.wav"
})

sound.Add({
	name = 			"TFA_DOOM.Plasma_Ammo_Pickup",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"weapons/tfa_doom_gauss/AmmoPickup.wav"
})








if killicon and killicon.Add then
	killicon.Add( "tfa_doom_gauss", "vgui/killicon/tfa_doom_gauss", Color( 255, 255, 255, 255 ) )
end