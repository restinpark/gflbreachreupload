player_manager.AddValidModel("quakeguy", "models/player/quakeguy.mdl")

-- NPC weapons

local npcWeps = {
	["weapon_q1_shotgun"] = "Shotgun",
	["weapon_q1_supershotgun"] = "Super Shotgun",
	["weapon_q1_nailgun"] = "Nailgun",
	["weapon_q1_supernailgun"] = "Super Nailgun",
	["weapon_q1_grenadelauncher"] = "Grenade Launcher",
	["weapon_q1_rocketlauncher"] = "Rocket Launcher",
	["weapon_q1_lightninggun"] = "Thunderbolt"
}

for cl, name in pairs(npcWeps) do
	list.Add("NPCUsableWeapons", {class = cl, title = "Quake "..name})
end

-- ammo

local ammo = {
	{"Nails", "quake_nails", 200, DMG_BULLET},
	{"Shells", "quake_shells", 100, DMG_BUCKSHOT},
	{"Rockets", "quake_rockets", 50, DMG_BLAST},
	{"Cells", "quake_cells", 100, DMG_SHOCK},
	{"Lava Nails", "quake_lavanails", 200, DMG_BULLET},
	{"Multi Rockets", "quake_multirockets", 50, DMG_BLAST},
	{"Plasma Cells", "quake_plasma", 100, DMG_SHOCK}	
}

for _, v in pairs(ammo) do
	game.AddAmmoType({name = v[2], maxcarry = v[3], dmgtype = v[4]})
	if CLIENT then language.Add(v[2].."_ammo", v[1]) end
end