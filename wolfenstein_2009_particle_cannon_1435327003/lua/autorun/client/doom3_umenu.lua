function Doom3_SettingsPanel(Panel)
	Panel:AddControl("Label", {Text = "Server"})
	
	local combobox = {}
	combobox.Label = "Damage Values"
	combobox.MenuButton = 0
	combobox.Options = {}
	combobox.Options["Multiplayer"] = {doom3_sk_pistol_damage = 15, doom3_sk_shotgun_damage = 15, doom3_sk_machinegun_damage = 12, doom3_sk_chaingun_damage = 25, doom3_sk_rocketlauncher_damage = 100, doom3_sk_rocketlauncher_radius = 125, doom3_sk_grenade_damage = 75, doom3_sk_plasmagun_damage = 30, doom3_sk_plasmagun_ammocapacity = 30}
	combobox.Options["Singleplayer"] = {doom3_sk_pistol_damage = 14, doom3_sk_shotgun_damage = 14, doom3_sk_machinegun_damage = 9, doom3_sk_chaingun_damage = 20, doom3_sk_rocketlauncher_damage = 170, doom3_sk_rocketlauncher_radius = 175, doom3_sk_grenade_damage = 150, doom3_sk_plasmagun_damage = 16, doom3_sk_plasmagun_ammocapacity = 50}
	Panel:AddControl("ComboBox", combobox)
	Panel:AddControl("CheckBox", {Label = "Only Doom Flashlight", Command = "doom3_onlydoomflashlight"})
	Panel:AddControl("CheckBox", {Label = "Restrict BFG", Command = "doom3_restrictbfg"})
	
	Panel:AddControl("Label", {Text = "Client"})
	Panel:AddControl("CheckBox", {Label = "Auto Reload", Command = "doom3_autoreload"})
	Panel:AddControl("CheckBox", {Label = "HUD", Command = "doom3_hud"})
	Panel:AddControl("CheckBox", {Label = "Fire Lighting", Command = "doom3_firelight"})
	Panel:AddControl("CheckBox", {Label = "Smoke Effect", Command = "doom3_smokeeffect"})
	//Panel:AddControl("CheckBox", {Label = "Viewmodel Sway", Command = "doom3_sway"})
	Panel:AddControl("Slider", {Label = "Crosshair", Command = "doom3_crosshair", Type = "Integer", Min = 0, Max = 2})
end

function Doom3_PopulateToolMenu()
	spawnmenu.AddToolMenuOption("Utilities", "Doom 3", "Doom 3 SWEPs", "Settings", "", "", Doom3_SettingsPanel)
end

hook.Add("PopulateToolMenu", "Doom3_PopulateToolMenu", Doom3_PopulateToolMenu)