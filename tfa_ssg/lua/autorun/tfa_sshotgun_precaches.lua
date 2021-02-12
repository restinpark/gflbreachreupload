game.AddParticles("particles/tfa_dshotgun_muzzle.pcf")

PrecacheParticleSystem("tfa_shotgun_muzzle") --SShotgun Muzzle, Hooray!

PrecacheParticleSystem("tfa_shotgun_muzzle_fire")

PrecacheParticleSystem("tfa_shotgun_muzzle_flash")

PrecacheParticleSystem("tfa_shotgun_muzzle_fsmoke")

PrecacheParticleSystem("tfa_shotgun_muzzle_shockwave")

PrecacheParticleSystem("tfa_shotgun_muzzle_smoke")

PrecacheParticleSystem("tfa_shotgun_muzzle_sparks")

hook.Add("EntityTakeDamage","TFADoomSSGMP",function(ent,dmg)
	local inf = dmg:GetInflictor()
	if not IsValid(inf) then return end
	if inf.GetActiveWeapon then inf = inf:GetActiveWeapon() end
	if not IsValid(inf) or not inf:IsWeapon() then return end
	if inf:GetClass() == "tfa_doom_ssg" and ent.Health and not ent:IsPlayer() then
		dmg:ScaleDamage( inf.Primary.Damage_NPC / inf.Primary.Damage )
		dmg:SetDamage( math.min(dmg:GetDamage(),700 ) )
	end
end)