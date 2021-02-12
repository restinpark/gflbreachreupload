local cv_timer = CreateConVar("sv_tfa_csgo_c4_defuse_time", "10", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "How much seconds it takes to defuse the C4?")
local cv_removedefuser = CreateConVar("sv_tfa_csgo_c4_defuse_removekitondeath", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Should defuser kit disappear on players death?")

if CLIENT then
	local ScrW, ScrH = ScrW, ScrH
	local draw, surface = draw, surface

	local function ScreenScale(size) -- scale by screen height instead of how gmod does it
		return size * (ScrH() / 1080)
	end

	surface.CreateFont("TFA_CSGO_DefuseTitle", {
		font = "StratumNo2",
		size = ScreenScale(24),
		shadow = true,
	})

	local color_bg = Color(0, 0, 0, 127)
	local color_fg = Color(255, 255, 255, 255)

	local posy = 0.55
	local boxw, boxh = 512, 8
	local bgoutline = 2

	local _ply, scrw, scrh, w, h, o
	local function DrawDefuseHUD()
		_ply = GetViewEntity()

		scrw, scrh = ScrW(), ScrH()
		w, h, o = ScreenScale(boxw), ScreenScale(boxh), ScreenScale(bgoutline)

		local target = _ply:GetNW2Entity("TFA_CSGO_DefuseTarget", NULL)
		if not IsValid(target) then return end

		local progress = _ply:GetNW2Float("TFA_CSGO_DefuseProgress", -1)
		if progress < 0 or progress > 1 then return end

		local haskit = _ply:GetNW2Bool("TFA_CSGO_HasDefuseKit", false)

		draw.SimpleText("Defuse Time:", "TFA_CSGO_DefuseTitle", scrw * .5 - w * .5 + o, scrh * posy - o, color_fg, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		draw.SimpleText(os.date("%M:%S", cv_timer:GetFloat() * (1 - progress) * (haskit and .5 or 1)), "TFA_CSGO_DefuseTitle", scrw * .5 + w * .5 - o, scrh * posy - o, color_fg, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

		if not haskit then
			draw.SimpleText("You are defusing the bomb without a kit.", "TFA_CSGO_DefuseTitle", scrw * .5 - w * .5 + o, scrh * posy + h, color_fg, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

		surface.SetDrawColor(color_bg)
		surface.DrawRect(scrw * .5 - o - w * .5, scrh * posy - o, w + o * 2, h + o * 2)

		surface.SetDrawColor(color_fg)
		surface.DrawRect(scrw * .5 - w * .5, scrh * posy, w * progress, h)
	end

	hook.Add("HUDPaint", "TFA_CSGO_DefuseProgress", DrawDefuseHUD)

	language.Add("tfa_csgo_item_defuser", "Defuse Kit")

	return
end

hook.Add("PlayerSpawn", "TFA_CSGO_DefuseLoadout", function(ply)
	if ply:GetNW2Bool("TFA_CSGO_HasDefuseKit", false) and cv_removedefuser:GetBool() then
		ply:SetNW2Bool("TFA_CSGO_HasDefuseKit", false)
	end
end)

hook.Add("KeyRelease", "TFA_CSGO_DefuseInterrupt", function(ply, key)
	if not IsValid(ply) or key ~= IN_USE then return end

	if IsValid(ply:GetNW2Entity("TFA_CSGO_DefuseTarget")) then
		ply:SetNW2Entity("TFA_CSGO_DefuseTarget", NULL)
		ply:SetNW2Float("TFA_CSGO_DefuseProgress", -1)
	end
end)

hook.Add("StartCommand", "TFA_CSGO_DefuseThink", function(ply, ucmd)
	if not IsValid(ply) then return end

	local target = ply:GetNW2Entity("TFA_CSGO_DefuseTarget")
	if IsValid(target) then
		ucmd:ClearMovement()

		local progress = ply:GetNW2Float("TFA_CSGO_DefuseProgress", 0)

		if progress >= 1 then
			ply:SetNW2Entity("TFA_CSGO_DefuseTarget", NULL)
			ply:SetNW2Float("TFA_CSGO_DefuseProgress", -1)

			target:EmitSound("TFA_CSGO_c4.disarmfinish")
			target:Remove()
		else
			local amount = math.max(cv_timer:GetInt(), 0.05)

			if ply:GetNW2Bool("TFA_CSGO_HasDefuseKit", false) then
				amount = amount * .5
			end

			ply:SetNW2Float("TFA_CSGO_DefuseProgress", progress + FrameTime() / amount)
		end
	end
end)