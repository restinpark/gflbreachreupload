local function CreditsBox(panel)
	panel:Help("")
	panel:Help("TFA CS:GO")
	panel:Help("Made by TheForgottenArchitect")
	panel:Help("Maintained by Matsilagi and YuRaNnNzZZ")

	local btn_gitlab = panel:Button("GitLab")
	btn_gitlab.DoClick = function() gui.OpenURL("https://gitlab.com/tfa-devs/tfa-csgo") end
end

local function tfaOptionClientGO(panel)
	--Here are whatever default categories you want.
	local tfaOptionCL = {
		Options = {},
		CVars = {},
		Label = "#Presets",
		MenuButton = "1",
		Folder = "TFA CSGO Settings Client"
	}

	tfaOptionCL.Options["#Default"] = {
		cl_tfa_csgo_stattrack = 1,
		cl_tfa_csgo_nametag = 1,
	}

	panel:AddControl("ComboBox", tfaOptionCL)

	panel:AddControl("CheckBox", {
		Label = "Drop Magazines on Reload",
		Command = "cl_tfa_csgo_magdrop"
	})

	panel:AddControl("Slider", {
		Label = "Dropped Magazine Life",
		Command = "cl_tfa_csgo_maglife",
		Type = "Integer",
		Min = "0",
		Max = "60"
	})

	panel:AddControl("CheckBox", {
		Label = "Use Particle Shells",
		Command = "cl_tfa_csgo_2dshells"
	})

	panel:AddControl("CheckBox", {
		Label = "Show Stattrack",
		Command = "cl_tfa_csgo_stattrack"
	})

	panel:AddControl("CheckBox", {
		Label = "Show NameTag",
		Command = "cl_tfa_csgo_nametag"
	})

	local b = vgui.Create("DButton")
	b:SizeToContents()

	b.DoClick = function()
		local f = file.Find("tfa_csgo/tfa_csgo_*_kills.txt", "DATA", "nameasc")

		if f then
			for k, v in pairs(f) do
				file.Delete("tfa_csgo/" .. v)
			end
		end

		local weps = LocalPlayer():GetWeapons()

		if weps then
			for k, v in pairs(weps) do
				if v.IsTFAWeapon and v.IsTFACSGOWeapon then
					v.Kills = 0
				end
			end
		end
	end

	b:SetText("Reset Stattrack")
	panel:AddItem(b)

	local b2 = vgui.Create("DButton")
	b2:SizeToContents()

	b2.DoClick = function()
		local f = file.Find("tfa_csgo/tfa_csgo_*.txt", "DATA", "nameasc")

		if f then
			for k, v in pairs(f) do
				file.Delete("tfa_csgo/" .. v)
			end
		end

		local weps = LocalPlayer():GetWeapons()

		if weps then
			for k, v in pairs(weps) do
				if v.IsTFAWeapon and v.IsTFACSGOWeapon then
					v.Skin = ""
					v:SetNWString("skin", "")

					if v.UpdateSkin then
						v:UpdateSkin()
					end

					v.MaterialTable = {}
					v.MaterialCache = nil
					v.MaterialCached = nil
					v.MaterialsCache = nil
					v.MaterialsCached = nil
				end
			end
		end
	end

	b2:SetText("Reset Skin Selection")
	panel:AddItem(b2)

	local b3 = vgui.Create("DButton")
	b3:SizeToContents()

	b3.DoClick = function()
		if TFA.CSGO and TFA.CSGO.ResetNameTags then TFA.CSGO.ResetNameTags() end -- make sure that gmod wouldnt went full retard on this
	end

	b3:SetText("Reset Nametags")
	panel:AddItem(b3)

	CreditsBox(panel)
end

local function tfaOptionServerGO(panel)
	local tfaOptionSV = {
		Options = {},
		CVars = {},
		Label = "#Presets",
		MenuButton = "1",
		Folder = "TFA SWEP Settings Server"
	}

	tfaOptionSV.Options["#Default"] = {
		sv_tfa_csgo_c4_defuse_time = 10,
		sv_tfa_csgo_c4_defuse_removekitondeath = 1,
	}

	panel:AddControl("ComboBox", tfaOptionSV)

	panel:NumSlider("C4 Defuse Time", "sv_tfa_csgo_c4_defuse_time", 0.05, 60, 2)
	panel:CheckBox("Remove Defuse Kit On Death", "sv_tfa_csgo_c4_defuse_removekitondeath")

	CreditsBox(panel)
end

local function tfaCSGOAddOption()
	spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "tfaOptionCSGO_Cl", "CSGO Clientside", "", "", tfaOptionClientGO)
	spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "tfaOptionCSGO_Sv", "CSGO Serverside", "", "", tfaOptionServerGO)
end

hook.Add("PopulateToolMenu", "tfaCSGOAddOption", tfaCSGOAddOption)