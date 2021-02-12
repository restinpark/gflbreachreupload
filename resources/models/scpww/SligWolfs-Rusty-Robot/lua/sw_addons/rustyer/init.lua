local Class_enemy = "npc_combine_s"
local Class_friendly = "npc_citizen"

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

SW_ADDON.NetworkaddonID = "SW_"..SW_ADDON.Addonname



SW_ADDON:AddPlayerModel("SW Rustyer Normal", "models/sligwolf/rustyrobot/rustyer.mdl", "models/sligwolf/rustyrobot/c_arms_rustyer.mdl")
SW_ADDON:Add_Items("sw_rustyer_128", "Robot-Rustyer", "models/sligwolf/rustyrobot/rustyer.mdl", "prop_ragdoll" )



local NPC = { 	
	Name = "Evil - Rustyer 1", 
	Class = Class_enemy,
	Model = "models/sligwolf/rustyrobot/rustyer_combine.mdl",
	Weapons = { "weapon_shotgun", "weapon_smg1", "weapon_ar2" },
	KeyValues = { 
		SquadName = "overwatch", 
		Numgrenades = 5,
	},
	
	SW_Custom = {
		Accuracy = WEAPON_PROFICIENCY_PERFECT,
		Blood = BLOOD_COLOR_MECH,
		Health = 100,
	},
}
SW_ADDON:Add_NPC("sw_rustyer_combine", NPC)

local NPC = { 	
	Name = "Good - Rustyer 1", 
	Class = Class_friendly,
	Model = "models/humans/group03/rustyer_rebel.mdl",
	Weapons = { "weapon_shotgun", "weapon_smg1", "weapon_ar2" },
	KeyValues = { 
		citizentype = CT_REBEL,
	},
	
	SW_Custom = {
		Accuracy = WEAPON_PROFICIENCY_PERFECT,
		Blood = BLOOD_COLOR_MECH,
		Health = 100,
	},
}
SW_ADDON:Add_NPC("sw_rustyer_rebel", NPC)