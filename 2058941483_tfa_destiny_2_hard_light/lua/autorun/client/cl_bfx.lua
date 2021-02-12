

CreateClientConVar("bfx_bulletcolor_r", "255", true, true)
CreateClientConVar("bfx_bulletcolor_g", "220", true, true)
CreateClientConVar("bfx_bulletcolor_b", "120", true, true)

CreateClientConVar("bfx_energycolor_r", "255", true, true)
CreateClientConVar("bfx_energycolor_g", "0", true, true)
CreateClientConVar("bfx_energycolor_b", "0", true, true)

CreateClientConVar("bfx_lasercolor_r", "60", true, true)
CreateClientConVar("bfx_lasercolor_g", "255", true, true)
CreateClientConVar("bfx_lasercolor_b", "40", true, true)

CreateClientConVar("bfx_gausscolor_r", "255", true, true)
CreateClientConVar("bfx_gausscolor_g", "185", true, true)
CreateClientConVar("bfx_gausscolor_b", "30", true, true)

CreateClientConVar("bfx_toolcolor_r", "220", true, true)
CreateClientConVar("bfx_toolcolor_g", "230", true, true)
CreateClientConVar("bfx_toolcolor_b", "255", true, true)

CreateClientConVar("bfx_widthmulti", "2", true, true)
CreateClientConVar("bfx_lifetimemulti", "1", true, true)
CreateClientConVar("bfx_alphamulti", "1", true, true)



if CLIENT then
local function BFX_Menu(panel)
   
	panel:AddControl( "Slider", { Label = "Tracer Width", Command = "bfx_widthmulti", Type = "Integer", Min = "0.5", Max = "10" }  )
	panel:AddControl( "Slider", { Label = "Tracer Lifetime", Command = "bfx_lifetimemulti", Type = "Integer", Min = "0.5", Max = "10" }  )
	panel:AddControl( "Slider", { Label = "Tracer Brightness", Command = "bfx_alphamulti", Type = "Integer", Min = "0.5", Max = "5" }  )
	
	panel:AddControl( "Color", { Label = "Bullet Color", Red = "bfx_bulletcolor_r", Green = "bfx_bulletcolor_g", Blue = "bfx_bulletcolor_b", ShowAlpha = "0", ShowHSV = "1", ShowRGB = "1" }  )
	panel:AddControl( "Color", { Label = "AR2 Energy Color", Red = "bfx_energycolor_r", Green = "bfx_energycolor_g", Blue = "bfx_energycolor_b", ShowAlpha = "0", ShowHSV = "1", ShowRGB = "1" }  )
	panel:AddControl( "Color", { Label = "Laser Color", Red = "bfx_lasercolor_r", Green = "bfx_lasercolor_g", Blue = "bfx_lasercolor_b", ShowAlpha = "0", ShowHSV = "1", ShowRGB = "1" }  )
	panel:AddControl( "Color", { Label = "Gauss Laser Color", Red = "bfx_gausscolor_r", Green = "bfx_gausscolor_g", Blue = "bfx_gausscolor_b", ShowAlpha = "0", ShowHSV = "1", ShowRGB = "1" }  )
	panel:AddControl( "Color", { Label = "Toolgun Laser Color", Red = "bfx_toolcolor_r", Green = "bfx_toolcolor_g", Blue = "bfx_toolcolor_b", ShowAlpha = "0", ShowHSV = "1", ShowRGB = "1" }  )
end

hook.Add("PopulateToolMenu","BFX_Menu", function()
	spawnmenu.AddToolMenuOption("Utilities","FX","Realistic Bullet FX","Realistic Bullet FX","","",BFX_Menu)
end)
end

