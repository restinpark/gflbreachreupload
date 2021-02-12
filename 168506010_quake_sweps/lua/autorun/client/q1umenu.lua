local function Q1_SettingsPanel(Panel)
	Panel:AddControl("Label", {Text = "Server"})
	Panel:AddControl("CheckBox", {Label = "Player Sounds", Command = "q1_playersounds"})
	Panel:AddControl("CheckBox", {Label = "Unlimited Ammo", Command = "q1_unlimitedammo"})
	Panel:AddControl("Label", {Text = "Client"})
	Panel:AddControl("CheckBox", {Label = "View Bobbing", Command = "q1_viewbob"})
	Panel:AddControl("CheckBox", {Label = "Fire Lighting", Command = "q1_firelight"})
	Panel:AddControl("CheckBox", {Label = "Software skins", Command = "q1_software"})
	Panel:AddControl("Slider", {Label = "Bobbing style", Command = "q1_bobstyle", Type = "Integer", Min = 0, Max = 2})
	Panel:AddControl("Slider", {Label = "Crosshair", Command = "q1_crosshair", Type = "Integer", Min = 0, Max = 2})
end

local function Q1_PopulateToolMenu()
	spawnmenu.AddToolMenuOption("Utilities", "Quake", "Q1Settings", "Quake 1", "", "", Q1_SettingsPanel)
end

hook.Add("PopulateToolMenu", "Q1_PopulateToolMenu", Q1_PopulateToolMenu)