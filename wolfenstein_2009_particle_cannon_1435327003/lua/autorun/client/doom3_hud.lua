surface.CreateFont("DOOM3FONT", {
font = "Waukegan LDO",
size = ScrH()/20,
weight = 0,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = true,
additive = false,
outline = false
})

surface.CreateFont("DOOM3FONTsmall", {
font = "Waukegan LDO Extended",
size = ScrH()/32,
weight = 0,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = true,
additive = false,
outline = false
})

local health = surface.GetTextureID("doom3hud/lbg1")
local healthborder = surface.GetTextureID("doom3hud/lborder1a")
local hptx = surface.GetTextureID("doom3hud/llines21")

local armor = surface.GetTextureID("doom3hud/llines11")
local armornone = surface.GetTextureID("doom3hud/llines11")

local ammo = surface.GetTextureID("doom3hud/lbg1a1")
local ammoborder = surface.GetTextureID("doom3hud/lborder1a1")
local amtx = surface.GetTextureID("doom3hud/llines2a1_ammo")
local amtx1 = surface.GetTextureID("doom3hud/llines1a1_ammo")

local llines1a2 = surface.GetTextureID("doom3hud/llines1a2")
local lborder1c = surface.GetTextureID("doom3hud/lborder1c")

function doom3hud()
	if !cvars.Bool("doom3_hud") then return end
	local client = LocalPlayer()
	local actwep = client:GetActiveWeapon()
	if actwep == "Camera" then return end

	local hp = client:Health()
	
	//local wx = ScrW() -256
	//local hy = ScrH() -64
	
	local ww = ScrW()/2.5
	local hh = ScrH()/7.5
	
	//local sw = ScrW()/.835 -254
	//local sh = ScrH()/.5765 -64
	
	local wxww = ScrW()*.6 //-wx+ww +sw
	local hyhh = ScrH()*.867 //-hy+hh +sh

	local lhudx, lhudy, lhudw, lhudh = 0, hyhh, ww, hh
	local rhudx, rhudy, rhudw, rhudh = wxww, hyhh, ww, hh
	
	local bordercolR, bordercolG, bordercolB, bordercolA = 64, 115, 100, 100
	local bgcolR, bgcolG, bgcolB, bgcolA = 25, 65, 65, 120
	local lines1colR, lines1colG, lines1colB, lines1colA = 75, 205, 180, 40

	surface.SetTexture(healthborder)
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawTexturedRect(lhudx+1, lhudy+1, lhudw, lhudh)
	surface.SetTexture(healthborder)
	surface.SetDrawColor(bordercolR, bordercolG, bordercolB, bordercolA)
	surface.DrawTexturedRect(lhudx, lhudy, lhudw, lhudh)
	
	surface.SetTexture(health)
	surface.SetDrawColor(bgcolR, bgcolG, bgcolB, bgcolA)
	surface.DrawTexturedRect(lhudx, lhudy, lhudw, lhudh)
	
	surface.SetTexture(hptx)
	surface.SetDrawColor(lines1colR, lines1colG, lines1colB, lines1colA)
	surface.DrawTexturedRect(lhudx, lhudy, lhudw, lhudh)
	
	draw.SimpleText(hp, "DOOM3FONT", ScrW()/5.75, ScrH()/1.09, Color(255, 255, 255, 125), TEXT_ALIGN_CENTER)

// armor

	local ap = client:Alive() and client:Armor() or 0
	
	surface.SetTexture(armor)
	surface.SetDrawColor(lines1colR, lines1colG, lines1colB, lines1colA)
	surface.DrawTexturedRect(lhudx, lhudy, lhudw, lhudh)
	
	/*surface.SetTexture(armor)
	surface.SetDrawColor(255, 165, 25, math.sin(CurTime() * 2.5) *20)
	surface.DrawTexturedRect(lhudx, lhudy, lhudw, lhudh)*/

	draw.SimpleText(ap, "DOOM3FONTsmall", ScrW()/14, ScrH()/1.076, Color(70, 90, 90, 255), TEXT_ALIGN_CENTER)

// ammo
	
	
	if actwep == NULL then return end

	local getclass = actwep:GetClass()
	if getclass == "weapon_doom3_machinegun" or getclass == "weapon_doom3_chaingun" or getclass == "weapon_faton" or getclass == "weapon_doom3_plasmagun" or getclass == "weapon_doom3_bfg" then return end
	
	local amx = ScrW() - 521
	local amxtext = ScrW() - 90
	local tamp = client:GetAmmoCount(actwep:GetPrimaryAmmoType())
	local curammo = actwep:Clip1()
	if actwep:GetPrimaryAmmoType() == -1 then return end

	if curammo == -1 then

		surface.SetTexture(llines1a2)
		surface.SetDrawColor(lines1colR, lines1colG, lines1colB, lines1colA)
		surface.DrawTexturedRect(rhudx, rhudy, rhudw, rhudh)
		
		surface.SetTexture(lborder1c)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawTexturedRect(rhudx+1, rhudy+1, rhudw, rhudh)
		surface.SetTexture(lborder1c)
		surface.SetDrawColor(bordercolR, bordercolG, bordercolB, bordercolA)
		surface.DrawTexturedRect(rhudx, rhudy, rhudw, rhudh)
		
	else

		surface.SetTexture(ammo)
		surface.SetDrawColor(bgcolR, bgcolG, bgcolB, bgcolA)
		surface.DrawTexturedRect(rhudx, rhudy, rhudw, rhudh)
		
		surface.SetTexture(ammoborder)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawTexturedRect(rhudx+1, rhudy+1, rhudw, rhudh)
		surface.SetTexture(ammoborder)
		surface.SetDrawColor(bordercolR, bordercolG, bordercolB, bordercolA)
		surface.DrawTexturedRect(rhudx, rhudy, rhudw, rhudh)
		
		surface.SetTexture(amtx1)
		surface.SetDrawColor(lines1colR, lines1colG, lines1colB, lines1colA)
		surface.DrawTexturedRect(rhudx, rhudy, rhudw, rhudh)
		
		surface.SetTexture(amtx)
		surface.SetDrawColor(lines1colR, lines1colG, lines1colB, lines1colA)
		surface.DrawTexturedRect(rhudx, rhudy, rhudw, rhudh)
		
	end

	draw.SimpleText(tamp, "DOOM3FONTsmall", ScrW()/1.065, ScrH()/1.076, Color(70, 90, 90, 255), TEXT_ALIGN_CENTER)
	if actwep:Clip1() > -1 then
		draw.SimpleText(curammo, "DOOM3FONT", ScrW()/1.175, ScrH()/1.09, Color(255, 255, 255, 125), TEXT_ALIGN_CENTER)
	end
end
hook.Add("HUDPaint", "doom3hud", doom3hud)

local tohide = {
["CHudHealth"] = true,
["CHudBattery"] = true,
["CHudAmmo"] = true,
["CHudSecondaryAmmo"] = true
}
local function HUDShouldDraw(name)
	if cvars.Bool("doom3_hud") then
		if (tohide[name]) then
			return false
		end
	end
end
hook.Add("HUDShouldDraw", "doom3hud", HUDShouldDraw)