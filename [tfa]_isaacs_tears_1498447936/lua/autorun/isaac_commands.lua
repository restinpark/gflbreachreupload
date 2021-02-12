local function CreateReplConVar(cvarname, cvarvalue, description)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description)
end

if GetConVar("sv_isaac_itemsmenu") == nil then
	CreateReplConVar("sv_isaac_itemsmenu", 1, "Enable item menu?")
end

if CLIENT then
	if GetConVar("cl_isaac_expensiveeffects") == nil then
		CreateClientConVar("cl_isaac_expensiveeffects", 1, true, true, "Enable more demanding particle effects.")
	end
end

local function ClientSettings(panel)
	panel:CheckBox( "Toggle Expensive Effects", "cl_isaac_expensiveeffects")
end

local function ServerSettings(panel)
	panel:CheckBox( "Enable Items Menu", "sv_isaac_itemsmenu")
end

hook.Add("PopulateToolMenu", "isaac_toolsettings", function()
	spawnmenu.AddToolMenuOption("Options", "Isaac Tears", "isaac_toolsettings_client", "Client", "", "", ClientSettings)
	spawnmenu.AddToolMenuOption("Options", "Isaac Tears", "isaac_toolsettings_server", "Server", "", "", ServerSettings)
end)