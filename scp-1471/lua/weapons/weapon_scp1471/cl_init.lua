--Purpose: Clientside only content for weapon_scp1471

SWEP.WepSelectIcon = surface.GetTextureID("breach/scp1471/swep")

function SWEP:ResetSpecialCounter()
	--Dec
end
function SWEP:FixSpecial()
	--Dec
end

function SWEP:DrawHUD()
	if disablehud == true then return end
	
    local inf_count = 0
    for k,v in pairs(player.GetAll()) do
        if v:GetNWBool("MaloInfected", false) then
            inf_count = inf_count + 1
        end
    end
	
	draw.Text( {
		text = inf_count .. " player(s) infected with Mal0.",
		pos = { ScrW() / 2, ScrH() - 30 },
		font = "173font",
		color = Color(0,0,255),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
    })

    local next = math.Round(self:GetNWInt("NextSpecial", 0) - CurTime())
    local text2, color2
    if next > -1 then
        text2 = "Special in " .. next .. " seconds."
        color2 = Color(255,0,0)
    else
        text2 = "Special is ready."
        color2 = Color(0,255,0)
    end
    
    draw.Text( {
		text = text2,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = color2,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
end
include("shared.lua")