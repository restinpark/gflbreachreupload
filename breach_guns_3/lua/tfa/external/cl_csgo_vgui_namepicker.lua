local bgcolor = Color(0, 0, 0, 255 * 0.78)
local btntextcol = Color(255, 255, 255, 255 * 0.9)

local NamePickerFrame

local ScrW, ScrH = ScrW, ScrH
local string_TrimLeft = string.TrimLeft

local function ScreenScale(num)
	assert(type(num) == "number", "NOT A NUMBER")

	return num * (ScrH() / 480)
end

local function CreateNamePicker(ply)
	if IsValid(NamePickerFrame) then return end -- we're open please don't do shit

	if not IsValid(ply) then return end

	local wep = ply:GetActiveWeapon()

	if not IsValid(wep) or not wep.IsTFACSGOWeapon or wep.NoNametag then return end

	local wepClass = wep:GetClass()

	local scale = ScreenScale(1)

	surface.CreateFont("TFA_CSGO_NamePicker_Text", {
		font = "Roboto",
		size = 32 * scale
	})

	surface.CreateFont("TFA_CSGO_NamePicker_Button", {
		font = "Roboto",
		size = 18 * scale
	})

	NamePickerFrame = vgui.Create("DFrame")

	NamePickerFrame:SetSkin("Default")

	NamePickerFrame:SetSize(640 * scale, 280 * scale)
	NamePickerFrame:Center()

	NamePickerFrame:SetTitle(string.format("Name Picker (%s)", wep:GetPrintName()))
	NamePickerFrame:SetVisible(true)
	NamePickerFrame:SetDraggable(false)
	NamePickerFrame:SetSizable(false)
	NamePickerFrame:SetScreenLock(true)
	NamePickerFrame:ShowCloseButton(true)
	NamePickerFrame.btnMaxim:Hide(true)
	NamePickerFrame.btnMinim:Hide(true)

	NamePickerFrame.startTime = SysTime()

	NamePickerFrame:MakePopup()

	NamePickerFrame.Paint = function(myself, wv, hv)
		local x, y = myself:GetPos()

		render.SetScissorRect(x, y, x + wv, y + hv, true)
		Derma_DrawBackgroundBlur(myself)
		render.SetScissorRect(0, 0, 0, 0, false)

		draw.NoTexture()
		surface.SetDrawColor(bgcolor)
		surface.DrawRect(0, 0, wv, hv)
	end

	local textEntryName = vgui.Create("DTextEntry", NamePickerFrame)
	textEntryName:SetSize(480 * scale, 32 * scale)

	textEntryName:DockMargin(80 * scale, 24 * scale, 80 * scale, 8 * scale)
	textEntryName:Dock(TOP)

	textEntryName:SetFont("TFA_CSGO_NamePicker_Text")
	textEntryName:SetPaintBorderEnabled(false)
	textEntryName:SetAllowNonAsciiCharacters(false)

	textEntryName:SetText(TFA.CSGO.GetNameTag(wepClass, wep:GetPrintName()))

	textEntryName:SetTextColor(btntextcol)
	textEntryName:SetCursorColor(btntextcol)
	textEntryName.Paint = function(pnl, w, h)
		draw.NoTexture()
		surface.SetDrawColor(bgcolor)
		surface.DrawRect(0, 0, w, h)

		pnl:DrawTextEntryText( pnl:GetTextColor(), pnl:GetHighlightColor(), pnl:GetCursorColor() )

		return true
	end

	textEntryName:SetUpdateOnType(true)
	textEntryName.OnValueChange = function(self, newText)
		if newText:len() > 20 then
			newText = string.sub(string_TrimLeft(newText), 0, 20)

			self:SetText(newText)
			self:SetCaretPos(newText:len())
		end
	end

	textEntryName.AllowInput = function(self, value)
		if #self:GetText() >= 20 then
			return true
		end

		return false
	end

	textEntryName.OnEnter = function(self)
		if wepClass then
			TFA.CSGO.SetNameTag(wepClass, string_TrimLeft(textEntryName:GetValue()))
		end
	end

	local panelBtnHolder = vgui.Create("DPanel", NamePickerFrame)
	panelBtnHolder:SetTall(32 * scale)

	panelBtnHolder:DockMargin(80 * scale, 4 * scale, 80 * scale, 4 * scale)
	panelBtnHolder:Dock(TOP)
	panelBtnHolder.Paint = emptyFunc

	local btnApply = vgui.Create("DButton", panelBtnHolder)

	btnApply:SetWide(240 * scale)
	btnApply:Dock(RIGHT)

	btnApply:SetFont("TFA_CSGO_NamePicker_Button")
	btnApply:SetTextColor(btntextcol)
	btnApply.Paint = emptyFunc

	btnApply:SetText("Apply")
	btnApply.DoClick = function(self)
		if IsValid(textEntryName) and wepClass then
			TFA.CSGO.SetNameTag(wepClass, string_TrimLeft(textEntryName:GetValue()))
		end

		NamePickerFrame:Close()
	end

	local btnRemove = vgui.Create("DButton", panelBtnHolder)

	btnRemove:SetWide(120 * scale)
	btnRemove:DockMargin(60, 0, 60, 0)
	btnRemove:Dock(LEFT)

	btnRemove:SetFont("TFA_CSGO_NamePicker_Button")
	btnRemove:SetTextColor(btntextcol)
	btnRemove.Paint = emptyFunc

	btnRemove:SetText("Reset")
	btnRemove:SetTooltip("This will reset the name tag for your weapon!")
	btnRemove.DoClick = function(self)
		if IsValid(ply) and wepClass then
			TFA.CSGO.ResetNameTag(wepClass)
		end

		NamePickerFrame:Close()
	end

	local pnlTagPreview = vgui.Create("DModelPanel", NamePickerFrame)
	pnlTagPreview:SetTall(160 * scale)
	pnlTagPreview:Dock(BOTTOM)
	pnlTagPreview:SetModel("models/weapons/tfa_csgo/uid.mdl")
	pnlTagPreview:SetCursor("arrow")

	function pnlTagPreview:LayoutEntity(Entity)
		-- local ang = Angle(0, 270, 12.5)

		local x, y = input.GetCursorPos()
		local w, h = ScrW(), ScrH()

		local ang = Angle(0, 258.75 + 22.5 * (x / w), 12.5 - 25 * (y / h))

		Entity:SetAngles(ang)
		self:SetFOV(24)

		if IsValid(Entity) and IsValid(textEntryName) then
			Entity.TFA_CSGO_NameOverride = textEntryName:GetText()
		end
	end

	local bonePos = pnlTagPreview:GetEntity():GetBonePosition(0)

	pnlTagPreview:SetLookAt(bonePos)

	pnlTagPreview:SetCamPos(bonePos + Vector(8, 0, 0))
end

concommand.Add("cl_tfa_csgo_vgui_namepicker", CreateNamePicker)