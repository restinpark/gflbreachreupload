BREACH_ACHIEVEMENT = {}

local allschs = include("achievements.lua")

net.Receive("SendAchievementData", function ()
	local a = net.ReadUInt(32)
	BREACH_ACHIEVEMENT = util.JSONToTable(util.Decompress(net.ReadData(a)))
end)

net.Receive("NotifyAchievementUnlocked", function ()
	local x = net.ReadString()
	if BREACH_ACHIEVEMENT then
		BREACH_ACHIEVEMENT[x] = BREACH_ACHIEVEMENT[x] or {}
		BREACH_ACHIEVEMENT[x].status = "unlocked"
	end
end)

net.Receive("NotifyAchievementProgress", function ()
	local x = net.ReadString()
	local g = net.ReadUInt(32)
	local c = net.ReadUInt(32)
	if BREACH_ACHIEVEMENT then
		BREACH_ACHIEVEMENT[x] = BREACH_ACHIEVEMENT[x] or {}
		BREACH_ACHIEVEMENT[x].goal = g
		BREACH_ACHIEVEMENT[x].progress = c
	end
end)

--Most of the following is from the hide and seek gamemode

function OpenAchievementsList()
	AchieveLBase = AchieveLBase or NULL
	if AchieveLBase:IsValid() then return end
	AchieveLBase = vgui.Create("DFrame")
	AchieveLBase:SetPos(45,ScrH()/2-300)
	AchieveLBase:SetSize(600,600)
	AchieveLBase:SetTitle("Breach - Achievements")
	AchieveLBase:SetScreenLock(true)
	AchieveLBase:ShowCloseButton(false)
	AchieveLBase:MakePopup()
	local AchieveLListing = vgui.Create("DPanel",AchieveLBase)
	AchieveLListing:SetPos(10,33)
	AchieveLListing:SetSize(AchieveLBase:GetWide()-20,AchieveLBase:GetTall()-74)
	AchieveLListing.Paint = function()
		draw.RoundedBox(0,0,0,AchieveLListing:GetWide(),AchieveLListing:GetTall(),Color(50,50,50,255))
	end
	local AchieveLPanel = vgui.Create("DPanel",AchieveLListing)
	AchieveLPanel:SetPos(5,5)
	AchieveLPanel:SetSize(AchieveLListing:GetWide()-26,8000)
	AchieveLPanel.Paint = function()
		draw.RoundedBox(0,0,0,AchieveLPanel:GetWide(),AchieveLPanel:GetTall(),Color(0,0,0,0))
	end
	local _ = 0
	local achtotal = 0
	for k,v in pairs(allschs) do
		local AchieveLArea = vgui.Create("DPanel",AchieveLPanel)
		AchieveLArea:SetPos(24,24+(88*_))
		AchieveLArea:SetSize(AchieveLListing:GetWide()-74,80)
		AchieveLArea.Paint = function()
			if BREACH_ACHIEVEMENT[k] and BREACH_ACHIEVEMENT[k].status and BREACH_ACHIEVEMENT[k].status == "unlocked" then
				draw.RoundedBox(4,0,0,AchieveLArea:GetWide(),AchieveLArea:GetTall(),Color(120,180,120,255))
			else
				draw.RoundedBox(4,0,0,AchieveLArea:GetWide(),AchieveLArea:GetTall(),Color(140,140,140,255))
			end
		end
		local AchieveImage = (file.Exists("materials/br_achieve/icon_"..string.lower(k)..".png","GAME")) and "has_achieve/icon_"..string.lower(k)..".png" or "icon64/tool.png"
		local AchieveLLine1 = vgui.Create("DImage",AchieveLArea)
		AchieveLLine1:SetPos(8,8)
		AchieveLLine1:SetImage(AchieveImage)
		AchieveLLine1:SizeToContents()
		local AchieveLLine2a = vgui.Create("DLabel",AchieveLArea)
		AchieveLLine2a:SetPos(80,8)
		AchieveLLine2a:SetColor(Color(255,255,255,255))
		AchieveLLine2a:SetFont("Trebuchet24")
		AchieveLLine2a:SetText(allschs[k].name)
		AchieveLLine2a:SizeToContents()
		local AchieveLLine2b = vgui.Create("DLabel",AchieveLArea)
		AchieveLLine2b:SetPos(80,34)
		AchieveLLine2b:SetColor(Color(255,255,255,255))
		AchieveLLine2b:SetFont("DermaDefault")
		AchieveLLine2b:SetText(allschs[k].description)
		AchieveLLine2b:SizeToContents()
		if v.hasProg then
			if v.goal == nil then
				error("'"..k..".times' is a nil value. See the achievements table for '"..k.."'")
				surface.PlaySound("common/warning.wav")
				return
			end
			
			local AchieveLLine3a = vgui.Create("DLabel",AchieveLArea)
			AchieveLLine3a:SetPos(80,52)
			AchieveLLine3a:SetColor(Color(255,255,255,255))
			AchieveLLine3a:SetFont("DermaDefault")
			local prog = 0
			if BREACH_ACHIEVEMENT[k] then
				prog = BREACH_ACHIEVEMENT[k].progress or "0"
			else
				prog = "0"
			end
			AchieveLLine3a:SetText(math.Clamp(tonumber(prog),0,allschs[k].goal).."/"..allschs[k].goal)
			AchieveLLine3a:SizeToContents()
			local AchieveLLine3b = vgui.Create("DPanel",AchieveLArea)
			AchieveLLine3b:SetPos(150,52)
			AchieveLLine3b:SetSize(AchieveLArea:GetWide()-200,15)
			AchieveLLine3b.Paint = function()
				draw.RoundedBox(0,0,0,AchieveLLine3b:GetWide(),AchieveLLine3b:GetTall(),Color(50,50,50,255))
				draw.RoundedBox(0,0,0,(math.Clamp(tonumber(prog),0,allschs[k].goal)/allschs[k].goal*100)*(AchieveLLine3b:GetWide()/100),AchieveLLine3b:GetTall(),Color(200,240,200,255))
			end
		end
		_ = _+1
		local stat = "locked"
		if BREACH_ACHIEVEMENT[k] then
			stat = BREACH_ACHIEVEMENT[k].status or "locked"
		end
		achtotal = (stat == "unlocked") and achtotal+1 or achtotal
	end
	local AchieveLScroller = vgui.Create("DVScrollBar",AchieveLListing)
	AchieveLScroller:SetPos(AchieveLListing:GetWide()-18,2)
	AchieveLScroller:SetSize(16,AchieveLListing:GetTall()-4)
	AchieveLScroller:SetUp(1,(48+(88*_))-AchieveLListing:GetTall())
	AchieveLScroller:SetEnabled(true)
	AchieveLScroller.Think = function()
		AchieveLPanel:SetPos(5,AchieveLScroller:GetOffset()+2)
	end
	local AchieveLExit = vgui.Create("DButton",AchieveLBase)
	AchieveLExit:SetPos(8,AchieveLBase:GetTall()-34)
	AchieveLExit:SetSize(200,26)
	AchieveLExit:SetText("Close")
	AchieveLExit.DoClick = function()
		AchieveLBase:Close()
		surface.PlaySound("garrysmod/ui_click.wav")
	end
	local AchieveLInfo1 = vgui.Create("DLabel",AchieveLBase)
	AchieveLInfo1:SetPos(218,AchieveLBase:GetTall()-34)
	AchieveLInfo1:SetColor(Color(255,255,255,255))
	AchieveLInfo1:SetFont("Trebuchet24")
	AchieveLInfo1:SetText(achtotal.."/"..table.Count(allschs))
	AchieveLInfo1:SizeToContents()
	local cmbar = (LocalPlayer().IsAchMaster) and Color(240,240,190,255) or Color(200,240,200,255)
	local AchieveLInfo2 = vgui.Create("DPanel",AchieveLBase)
	AchieveLInfo2:SetPos(306,AchieveLBase:GetTall()-30)
	AchieveLInfo2:SetSize(AchieveLBase:GetWide()-316,15)
	AchieveLInfo2.Paint = function()
		draw.RoundedBox(0,0,0,AchieveLInfo2:GetWide(),AchieveLInfo2:GetTall(),Color(50,50,50,255))
		draw.RoundedBox(0,0,0,(achtotal/table.Count(allschs)*100)*(AchieveLInfo2:GetWide()/100),AchieveLInfo2:GetTall(),cmbar)
	end
	if LocalPlayer().IsAchMaster then
		local AchieveLGoodie1 = vgui.Create("DImage",AchieveLBase)
		AchieveLGoodie1:SetPos(AchieveLInfo2:GetPos()-6,AchieveLBase:GetTall()-25)
		AchieveLGoodie1:SetImage("icon16/star.png")
		AchieveLGoodie1:SizeToContents()
		local AchieveLGoodie2 = vgui.Create("DImage",AchieveLBase)
		AchieveLGoodie2:SetPos((AchieveLInfo2:GetPos()+AchieveLInfo2:GetWide())-10,AchieveLBase:GetTall()-25)
		AchieveLGoodie2:SetImage("icon16/star.png")
		AchieveLGoodie2:SizeToContents()
	end
end

net.Receive("AnnounceAchievement", function ()
	local a = net.ReadString()
	local b = net.ReadString()
	local c = allschs[a] or {}
	local d = "[ERROR]"
	if c != {} then
		d = c.name
	end
	chat.AddText(Color(255,91,91), b, Color(255,255,255), " has earned the achievement ", Color(91, 255, 107), d, Color(255,255,255), ".")
end)

function OpenMenuBind()
	if input.IsKeyDown( KEY_F1 ) then
		OpenAchievementsList()
	end
end

hook.Add("Think","OpenAchievementMenu",OpenMenuBind)

concommand.Add("br_achievements", OpenAchievementList, nil, nil, FCVAR_CLIENTCMD_CAN_EXECUTE)