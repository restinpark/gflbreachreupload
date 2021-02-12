local bgcolor = Color(0, 0, 0, 255 * 0.78)
local bordercol = Color(10, 10, 10, 255)
local scrollbar_buttoncol = Color(96, 96, 96, 255 * 0.8)
local scrollbar_gripcol = Color(162, 162, 162, 255 * 0.8)
local btntextcol = Color(255, 255, 255, 255 * 0.9)
local divcolor = Color(225, 225, 225, 225 * 0.8)
local panelscale = 0.7

local ScrW, ScrH = ScrW, ScrH

--[[ local function ScreenScale(num)
	assert(type(num) == "number", "NOT A NUMBER")

	return num * (ScrH() / 480)
end--]] 

surface.CreateFont("TFA_CSGO_SKIN", {
	font = "Roboto",
	size = 48,
	weight = 500,
})

local SkinPickerFrame

local function CreateSkinPicker(ply)
	if IsValid(SkinPickerFrame) then return end

	if not IsValid(ply) then return end

	local wep = ply:GetActiveWeapon()

	if not IsValid(wep) or not wep.IsTFACSGOWeapon then return end

	SkinPickerFrame = vgui.Create("DFrame")

	SkinPickerFrame:SetSkin("Default")

	local scrollpanel = vgui.Create("DScrollPanel")

	local sbar = scrollpanel:GetVBar()

	function sbar:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, bgcolor)
	end

	function sbar.btnUp:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, scrollbar_buttoncol)
	end

	function sbar.btnDown:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, scrollbar_buttoncol)
	end

	function sbar.btnGrip:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, scrollbar_gripcol)
	end

	local scrw, scrh = ScrW(), ScrH()
	local w, h = scrw * panelscale, scrw * panelscale * (scrh / scrw) --790, 790*9/16

	SkinPickerFrame:SetSize(w, h)
	SkinPickerFrame:Center()
	SkinPickerFrame:SetTitle("Skin Picker")
	SkinPickerFrame:SetVisible(true)
	SkinPickerFrame:SetDraggable(true)
	SkinPickerFrame:SetSizable(true)
	SkinPickerFrame:SetScreenLock(true)
	SkinPickerFrame:ShowCloseButton(true)
	SkinPickerFrame:MakePopup()
	SkinPickerFrame:SetBackgroundBlur(true)
	SkinPickerFrame.btnMaxim:Hide(true)
	SkinPickerFrame.btnMinim:Hide(true)

	SkinPickerFrame.Paint = function(myself, wv, hv)
		local x, y = myself:GetPos()

		render.SetScissorRect(x, y, x + wv, y + hv, true)
		Derma_DrawBackgroundBlur(myself)
		render.SetScissorRect(0, 0, 0, 0, false)

		draw.NoTexture()
		surface.SetDrawColor(bgcolor)
		surface.DrawRect(0, 0, wv, hv)
	end

	SkinPickerFrame:Center()
	local div2 = vgui.Create("DPanel")
	div2:SetParent(SkinPickerFrame)
	div2:SetSize(w, 2)
	div2:Dock(TOP)

	div2.Paint = function(myself, wv, hv)
		draw.NoTexture()
		surface.SetDrawColor(divcolor)
		surface.DrawRect(0, 0, wv, hv)
	end

	scrollpanel:SetParent(SkinPickerFrame)
	scrollpanel:Dock(FILL)
	scrollpanel.w = w
	keys = table.GetKeys(wep.Skins)

	table.sort(keys, function(a, b)
		local namea = wep.Skins[a].name
		local nameb = wep.Skins[b].name
		local aval = string.lower(language.GetPhrase(namea or tostring(a)))
		local bval = string.lower(language.GetPhrase(nameb or tostring(b)))

		return aval < bval
	end)

	table.RemoveByValue(keys, "Stock")
	table.insert(keys, 1, "Stock")

	if not wep.Skins["Stock"] then
		wep.Skins["Stock"] = {
			["name"] = "Stock",
			["tbl"] = {}
		}
	end

	table.RemoveByValue(keys, "BaseClass")
	local yy = 0
	local div

	for i = 1, #keys do
		local k = keys[i]
		local v = wep.Skins[k]
		local tmpw = scrollpanel.w

		if not tmpw then
			tmpw = scrollpanel:GetSize()
		end

		local dbtn = vgui.Create("DButton")
		dbtn:SetParent(scrollpanel)
		local name = v.name and v.name or k

		if v.image then
			isimage = true
			dbtn:SetText("")
		else
			dbtn:SetText(name)
		end

		dbtn:SetPos(30, yy + 2)
		dbtn:SetSize(100, 100)
		yy = yy + 100 + 2
		dbtn.skin = k
		dbtn:SetTextColor(btntextcol)

		dbtn.DoClick = function(self2)
			if IsValid(wep) and wep.IsTFACSGOWeapon and wep.Skins and self2.skin and wep.Skins[self2.skin] and wep.Skins[self2.skin].tbl then
				wep.Skin = self2.skin
				wep:UpdateSkin()
				wep:SyncToServerSkin()
				wep:SaveSkin()
			end
		end

		dbtn.Paint = function(self2, wv, hv)
			draw.NoTexture()

			if not self2.mat then
				self2.mat = Material(v.image or "vgui/tfa_csgo/default_flat")
			end

			surface.SetMaterial(self2.mat)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(0, 0, wv, hv)

			surface.SetDrawColor(bordercol)
			draw.NoTexture()

			surface.DrawRect(0, 0, 2, hv)
			surface.DrawRect(wv - 2, 0, 2, hv)
			surface.DrawRect(0, 0, wv, 2)
			surface.DrawRect(0, hv - 2, wv, 2)
		end

		--end
		local dlbl = vgui.Create("DLabel")
		dlbl:SetParent(scrollpanel)
		dlbl:SetFont("TFA_CSGO_SKIN")
		local xpos = 30 + 100 + 2 + 32
		dlbl:SetPos(xpos, yy - 100)
		dlbl:SetSize(tmpw - xpos - 30, 100)
		dlbl:SetText(name)
		dlbl.skin = k

		dlbl.DoClick = function(self2)
			if IsValid(wep) and wep.IsTFACSGOWeapon and wep.Skins and self2.skin and wep.Skins[self2.skin] and wep.Skins[self2.skin].tbl then
				wep.Skin = self2.skin
				wep:UpdateSkin()
				wep:SaveSkin()
				wep:SyncToServerSkin()
			end
		end

		local extrapadding = 4
		div = vgui.Create("DPanel")
		div:SetParent(scrollpanel)
		div:SetSize(tmpw / 2, 2)
		div:SetPos(0, yy + 2 + extrapadding)

		div.Paint = function(self2, wv, hv)
			if not self2.img then
				self2.img = Material("vgui/spellkaster/divgrad")
			end

			draw.NoTexture()
			surface.SetDrawColor(divcolor)
			surface.SetMaterial(self2.img)
			surface.DrawTexturedRect(0, 0, wv, hv)
		end

		yy = yy + 4 + extrapadding * 2
	end

	if div and div.Remove then
		div:Remove()
	end
end

concommand.Add("cl_tfa_csgo_vgui_skinpicker", CreateSkinPicker)