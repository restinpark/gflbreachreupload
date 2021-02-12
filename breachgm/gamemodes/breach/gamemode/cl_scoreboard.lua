--This is all currently being overriden by ascoreboard and is not being maintained (and hasn't been since 2017)
--If you want to use either of these, you will need to fix them

USE_NEW_SB = true

function IsResOk()
	return (ScrH() > 900 and ScrW() > 1600)
end

local def = "1"

if not IsResOk() then
	def = "0"
end

CreateClientConVar( "br_usesb", def, true, false, "" )
local hjadjs = GetConVar("br_usesb")
if not hjadjs:GetBool() then
	USE_NEW_SB = false
end

if not Frame then
	Frame = nil
end

surface.CreateFont("sb_names", {font = "Trebuchet18", size = 14, weight = 700})

function RanksEnabled()
	return GetConVar("br_scoreboardranks"):GetBool()
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function role_GetPlayers(role)
	local all = {}
	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
			if not v.GetNClass then
				player_manager.RunClass( v, "SetupDataTables" )
			end

			if v.GetNClass then
				if v:GetNClass() == role then
					table.ForceInsert(all, v)
				end
			end
		end
	end
	return all
end

function ShowScoreBoard()
	local ply = LocalPlayer()
	local allplayers = {}
	table.Add(allplayers, player.GetAll())

	local mtfs = {}
	table.Add(mtfs, role_GetPlayers(ROLE_MTFGUARD))
	table.Add(mtfs, role_GetPlayers(ROLE_MTFCOM))
	table.Add(mtfs, role_GetPlayers(ROLE_MTFNTF))
	local scps = {}
	for k,v in pairs(player.GetAll()) do
		if v:Team() == TEAM_SCP and v:GetNClass() != ROLE_SCP939 then
			table.ForceInsert(scps, v)
		end
	end
	local sci = {}
	for k,v in pairs(player.GetAll()) do
		if v:Team() == TEAM_SCI then
			table.ForceInsert(sci, v)
		end
	end
	local ds = {}
	for k,v in pairs(player.GetAll()) do
		if v:Team() == TEAM_CLASSD then
			table.ForceInsert(ds, v)
		end
	end
	local playerlist = {}

	table.ForceInsert(playerlist, {
		name = "SCPs",
		list = scps,
		color = team.GetColor( TEAM_SCP ),
		color2 = color_white
	})
	table.ForceInsert(playerlist,{
		name = "Mobile Task Force",
		list = mtfs,
		color = team.GetColor( TEAM_GUARD ),
		color2 = color_white
	})
	table.ForceInsert(playerlist,{
		name = "Chaos Insurgency",
		list = role_GetPlayers(ROLE_CHAOS),
		color = Color(29, 81, 56),
		color2 = color_white
	})
	table.ForceInsert(playerlist,{
		name = "Class D Personell",
		list = ds,
		color = team.GetColor( TEAM_CLASSD ),
		color2 = color_white
	})
	table.ForceInsert(playerlist,{
		name = "Scientists",
		list = sci,
		color = team.GetColor( TEAM_SCI ),
		color2 = color_white
	})
	table.ForceInsert(playerlist,{
		name = "Spectators",
		list = team.GetPlayers( TEAM_SPEC ),
		color = color_white,
		color2 = color_black
	})

	// Sort all
	table.sort( playerlist[1].list, function( a, b ) return a:Frags() > b:Frags() end )
	table.sort( playerlist[3].list, function( a, b ) return a:Frags() > b:Frags() end )
	table.sort( playerlist[4].list, function( a, b ) return a:Frags() > b:Frags() end )

	local color_main = 45

	Frame = vgui.Create( "DFrame" )
	Frame:Center()
	Frame:SetSize(ScrW(), ScrH() )
	Frame:SetTitle( "" )
	Frame:SetVisible( true )
	Frame:SetDraggable( true )
	Frame:SetDeleteOnClose( true )
	Frame:SetDraggable( false )
	Frame:ShowCloseButton( false )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) end


	local width = 25

	local mainpanel = vgui.Create( "DPanel", Frame )
	mainpanel:SetSize(ScrW() / 1.5, ScrH() / 1.3)
	mainpanel:CenterHorizontal( 0.5 )
	mainpanel:CenterVertical( 0.5 )
	mainpanel.Paint = function( self, w, h )
		//draw.RoundedBox( 0, 0, 0, w, h, Color( color_main, color_main, color_main, 240 ) )
	end

	local panel_backg = vgui.Create( "DPanel", mainpanel )
	panel_backg:Dock( FILL )
	panel_backg:DockMargin( 8, 50, 8, 8 )
	panel_backg.Paint = function( self, w, h )
		//draw.RoundedBox( 0, 0, 0, w, h, Color( color_main, color_main, color_main, 180 ) )
	end

	local DScrollPanel = vgui.Create( "DScrollPanel", panel_backg )
	DScrollPanel:Dock( FILL )

	local color_dark = Color( 35, 35, 35, 180 )
	local color_light = Color(80,80,80,180)

	local panelname_backg = vgui.Create( "DPanel", DScrollPanel )
	panelname_backg:Dock( TOP )
	//if i != 1 then
	//	panelname_backg:DockMargin( 0, 15, 0, 0 )
	//end
	panelname_backg:SetSize(0,width)
	panelname_backg.Paint = function( self, w, h )
		//draw.RoundedBox( 0, 0, 0, w, h, color_dark )
	end

	local panelwidth = 55

	local sbpanels = {
		{
			name = "Ping",
			size = panelwidth
		},
		{
			name = "Deaths",
			size = panelwidth
		},
		{
			name = "Score",
			size = panelwidth
		}
	}
	if KarmaEnabled() then
		table.ForceInsert(sbpanels, {
			name = "Karma",
			size = panelwidth
		})
	end
	if RanksEnabled() then
		table.ForceInsert(sbpanels, {
			name = "Group",
			size = panelwidth * 2
		})
	end


	local MuteButtonFix = vgui.Create( "DPanel", panelname_backg )
	MuteButtonFix:Dock(RIGHT)
	MuteButtonFix:SetSize( width - 2, width - 2 )
	MuteButtonFix.Paint = function() end
	for i,pnl in ipairs(sbpanels) do
		local ping_panel = vgui.Create( "DLabel", panelname_backg )
		ping_panel:Dock( RIGHT )
		if i == 1 then
			ping_panel:DockMargin( 0, 0, 25, 0 )
		end
		ping_panel:SetSize(pnl.size, 0)
		ping_panel:SetText(pnl.name)
		ping_panel:SetFont("sb_names")
		ping_panel:SetTextColor(Color(255,255,255,255))
		ping_panel:SetContentAlignment(5)
		ping_panel.Paint = function( self, w, h )end
		drawb = !drawb
	end

	local i = 0
	for key,tab in pairs(playerlist) do
		i = i + 1
		if #tab.list > 0 then

			// players
			local panelwidth = 55
			local dark = true
			for k,v in pairs(tab.list) do
				local panels = {
					{
						name = "Ping",
						text = v:Ping(),
						color = color_white,
						size = panelwidth
					},
					{
						name = "Deaths",
						text = v:Deaths(),
						color = color_white,
						size = panelwidth
					},
					{
						name = "Frags",
						text = v:Frags(),
						color = color_white,
						size = panelwidth
					},
				}
				if KarmaEnabled() then
					local tkarma = v:GetKarma()
					if tkarma == nil then tkarma = 999 end
					table.ForceInsert(panels, {
						name = "Karma",
						text = v:GetKarma(),
						color = color_white,
						size = panelwidth
					})
				end
				local rank = v:GetUserGroup()
				rank = firstToUpper(rank)
				if RanksEnabled() then
					table.ForceInsert(panels, {
						name = "Group",
						text = rank,
						color = color_white,
						size = panelwidth * 2
					})
				end
				local scroll_panel = vgui.Create( "DPanel", DScrollPanel )
				scroll_panel:Dock( TOP )
				scroll_panel:DockMargin( 0,5,0,0 )
				scroll_panel:SetSize(0,width)
				//scroll_panel.clr = team.GetColor(v:Team())
				scroll_panel.clr = tab.color
				if not v.GetNClass then
					player_manager.RunClass( v, "SetupDataTables" )
				end
				scroll_panel.Paint = function( self, w, h )
					if !IsValid(v) or not v then
						Frame:Close()
						return
					end
					local txt = "ERROR"
					if not v.GetNClass then
						player_manager.RunClass( v, "SetupDataTables" )
					else
						txt = GetLangRole(v:GetNClass())
					end
					local tcolor = scroll_panel.clr
					if LocalPlayer():Team() == TEAM_CHAOS or LocalPlayer():Team() == TEAM_CLASSD then
						if v:Team() == TEAM_CHAOS then
							txt = GetLangRole(ROLE_CHAOS)
							tcolor = Color(29, 81, 56)
						end
					end

					if v:Team() == TEAM_SCP then
						txt = v:GetNClass()
					end
					if LocalPlayer():Team() == TEAM_SCP and v:GetNClass() == ROLE_SCP939 then
						txt = "SCP-939"
						tcolor = team.GetColor(TEAM_SCP)
					elseif LocalPlayer():Team() != TEAM_SCP and v:GetNClass() == ROLE_SCP939 then
						txt = "Researcher"
					end
					draw.RoundedBox( 0, 0, 0, w, h, tcolor )
					draw.Text( {
						text = string.sub(v:Nick(), 1, 16),
						pos = { width + 2, h / 2 },
						font = "sb_names",
						color = tab.color2,
						xalign = TEXT_ALIGN_LEFT,
						yalign = TEXT_ALIGN_CENTER
					})
					draw.RoundedBox( 0, width + 150, 0, 125, h, Color(0,0,0,120) )
					draw.Text( {
						text = txt,
						pos = { width + 212, h / 2 },
						font = "sb_names",
						color = tab.color2,
						xalign = TEXT_ALIGN_CENTER,
						yalign = TEXT_ALIGN_CENTER
					})
					local panel_x = w / 1.1175
					local panel_w = w / 14
				end

				local MuteButton = vgui.Create( "DButton", scroll_panel )
				MuteButton:Dock(RIGHT)
				MuteButton:SetSize( width - 2, width - 2 )
				MuteButton:SetText( "" )
				MuteButton.DoClick = function()
					v:SetMuted( !v:IsMuted() )
				end
				MuteButton.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, Color(255,255,255,255) )
				end

				local MuteIMG = vgui.Create( "DImage", MuteButton )
				MuteIMG.img = "icon32/unmuted.png"
				MuteIMG:SetPos( MuteButton:GetPos() )
				MuteIMG:SetSize( MuteButton:GetSize() )
				MuteIMG:SetImage( "icons32/unmuted.png" )
				MuteIMG.Think = function( self, w, h )
					if !IsValid(v) then return end
					if v:IsMuted() then
						self.img = "icon32/muted.png"
					else
						self.img = "icon32/unmuted.png"
					end
					self:SetImage( self.img )
				end

				local drawb = true
				for i,pnl in ipairs(panels) do
					local ping_panel = vgui.Create( "DLabel", scroll_panel )
					ping_panel:Dock( RIGHT )
					if i == 1 then
						ping_panel:DockMargin( 0, 0, 25, 0 )
					end
					ping_panel:SetSize(pnl.size, 0)
					ping_panel:SetText(pnl.text)
					ping_panel:SetFont("sb_names")
					ping_panel:SetTextColor(tab.color2)
					ping_panel:SetContentAlignment(5)
					if drawb then
						ping_panel.Paint = function( self, w, h )
							ping_panel:SetText(pnl.text)
							draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,120) )
						end
					end
					drawb = !drawb
				end

				local Avatar = vgui.Create( "AvatarImage", scroll_panel )
				Avatar:SetSize( width, width )
				Avatar:SetPos( 0, 0 )
				Avatar:SetPlayer( v, 32 )
			end
		end
	end
end


















surface.CreateFont( "ScoreboardDefault", {
	font	= "Helvetica",
	size	= 16,
	weight	= 800
} )

surface.CreateFont( "ScoreboardDefault2", {
	font	= "Helvetica",
	size	= 22,
	weight	= 600
} )


surface.CreateFont( "ScoreboardDefaultTitle", {
	font	= "Helvetica",
	size	= 32,
	weight	= 800
} )

--
-- This defines a new panel type for the player row. The player row is given a player
-- and then from that point on it pretty much looks after itself. It updates player info
-- in the think function, and removes itself when the player leaves the server.
--
local PLAYER_LINE = {
	Init = function( self )

		self.AvatarButton = self:Add( "DButton" )
		self.AvatarButton:Dock( LEFT )
		self.AvatarButton:SetSize( 32, 32 )
		self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

		self.Avatar = vgui.Create( "AvatarImage", self.AvatarButton )
		self.Avatar:SetSize( 32, 32 )
		self.Avatar:SetMouseInputEnabled( false )

		self.Name = self:Add( "DLabel" )
		self.Name:Dock( FILL )
		self.Name:SetFont( "ScoreboardDefault2" )
		self.Name:SetTextColor( Color( 255, 255, 255 ) )
		self.Name:DockMargin( 8, 0, 0, 0 )

		self.Mute = self:Add( "DImageButton" )
		self.Mute:SetSize( 32, 32 )
		self.Mute:Dock( RIGHT )

		self.Ping = self:Add( "DLabel" )
		self.Ping:Dock( RIGHT )
		self.Ping:SetWidth( 50 )
		self.Ping:SetFont( "ScoreboardDefault2" )
		self.Ping:SetTextColor( Color( 255, 255, 255 ) )
		self.Ping:SetContentAlignment( 5 )



		self.Kills = self:Add( "DLabel" )
		self.Kills:Dock( RIGHT )
		self.Kills:SetWidth( 50 )
		self.Kills:SetFont( "ScoreboardDefault2" )
		self.Kills:SetTextColor( Color( 255, 255, 255 ) )
		self.Kills:SetContentAlignment( 5 )

    self.Deaths = self:Add( "DLabel" )
		self.Deaths:Dock( RIGHT )
		self.Deaths:SetWidth( 50 )
		self.Deaths:SetFont( "ScoreboardDefault2" )
		self.Deaths:SetTextColor( Color( 255, 255, 255 ) )
		self.Deaths:SetContentAlignment( 5 )

    self.Group = self:Add( "DLabel" )
		self.Group:Dock( RIGHT )
		self.Group:SetWidth( 150 )
		self.Group:SetFont( "ScoreboardDefault2" )
		self.Group:SetTextColor( Color( 255, 255, 255 ) )
		self.Group:SetContentAlignment( 5 )

		self.Class = self:Add( "DLabel" )
		self.Class:Dock( RIGHT )
		self.Class:SetWidth( 250 )
		self.Class:SetFont( "ScoreboardDefault2" )
		self.Class:SetTextColor( Color( 255, 255, 255 ) )
		self.Class:SetContentAlignment( 5 )
		self:Dock( TOP )
		self:DockPadding( 3, 3, 3, 3 )
		self:SetHeight( 32 + 3 * 2 )
		self:DockMargin( 2, 0, 2, 2 )

	end,

	Setup = function( self, pl )

		self.Player = pl

		self.Avatar:SetPlayer( pl )

		self:Think( self )

		--local friend = self.Player:GetFriendStatus()
		--MsgN( pl, " Friend: ", friend )

	end,

	Think = function( self )

		if ( !IsValid( self.Player ) ) then
			self:SetZPos( 9999 ) -- Causes a rebuild
			self:Remove()
			return
		end

		if ( self.PName == nil || self.PName != self.Player:Nick() ) then
			self.PName = self.Player:Nick()
			self.Name:SetText( self.PName )
		end

		if ( self.NumKills == nil || self.NumKills != self.Player:Frags() ) then
			self.NumKills = self.Player:Frags()
			self.Kills:SetText( self.NumKills )
		end

		if ( self.NumDeaths == nil || self.NumDeaths != self.Player:GetKarma() ) then
			self.NumDeaths = self.Player:GetKarma()
			self.Deaths:SetText( self.NumDeaths )
		end

		if ( self.NumPing == nil || self.NumPing != self.Player:Ping() ) then
			self.NumPing = self.Player:Ping()
			self.Ping:SetText( self.NumPing )
		end
    if ( self.StrGroup == nil || self.StrGroup != self.Player:GetUserGroup() ) then
			self.StrGroup = self.Player:GetUserGroup()
			self.Group:SetText( self.StrGroup )
		end
		if not self.Player.GetNClass then
				player_manager.RunClass( self.Player, "SetupDataTables" )
		end
		if ( self.StrClass == nil || self.StrClass != self.Player:GetNClass() ) then
			if self.Player:Team() == TEAM_CHAOS and (LocalPlayer():Team() == TEAM_CHAOS or LocalPlayer():Team() == TEAM_CLASSD) then
				self.StrClass = "Chaos Insurgency"
			else
				self.StrClass = self.Player:GetNClass()
			end
			if self.Player:GetNClass() == ROLE_SCP939 and LocalPlayer():Team() != TEAM_SCP then
				self.StrClass = "Researcher"
			else
				self.StrClass = self.Player:GetNClass()
			end
			self.Class:SetText( self.StrClass )
		end
		--
		-- Change the icon of the mute button based on state
		--
		if ( self.Muted == nil || self.Muted != self.Player:IsMuted() ) then

			self.Muted = self.Player:IsMuted()
			if ( self.Muted ) then
				self.Mute:SetImage( "icon32/muted.png" )
			else
				self.Mute:SetImage( "icon32/unmuted.png" )
			end

			self.Mute.DoClick = function() self.Player:SetMuted( !self.Muted ) end

		end

		--
		-- Connecting players go at the very bottom
		--
		if ( self.Player:Team() == TEAM_CONNECTING ) then
			self:SetZPos( 2000 + self.Player:EntIndex() )
			return
		end

		--
		-- This is what sorts the list. The panels are docked in the z order,
		-- so if we set the z order according to kills they'll be ordered that way!
		-- Careful though, it's a signed short internally, so needs to range between -32,768k and +32,767
		--
    local p = 0
    if self.Player:Team() == TEAM_SCP and !(self.Player:GetNClass() == ROLE_SCP939) then
      p = 650
    elseif self.Player:Team() == TEAM_GUARD or (self.Player:Team() == TEAM_CHAOS  and self.Player:GetNClass() != ROLE_CHAOS) then
      p = 600
    elseif self.Player:Team() == TEAM_CHAOS and self.Player.GetNClass and self.Player:GetNClass() == ROLE_CHAOS then
      p = 500
    elseif self.Player:Team() == TEAM_SCI or self.Player:GetNClass() == ROLE_SCP939 then
      p = 400
    elseif self.Player:Team() == TEAM_CLASSD then
      p = 300
    else
      p = 0
    end
		self:SetZPos( ( p * -50 ) + self.NumKills + self.Player:EntIndex() )

	end,

	Paint = function( self, w, h )

		if ( !IsValid( self.Player ) ) then
			return
		end

		--
		-- We draw our background a different colour based on the status of the player
		--

		local tva = team.GetColor(self.Player:Team())
    local tva2 = Color(tva.r, tva.g, tva.b, 200)
		if self.Player:GetNClass() == ROLE_CHAOS then
			tva2 = Color(29, 81, 56, 200)
		end
		if self.Player:Team() == TEAM_CHAOS and LocalPlayer():Team() == TEAM_CHAOS then
			tva2 = Color(29, 81, 56, 200)
		end
		if self.Player:Team() == TEAM_CHAOS and LocalPlayer():Team() == TEAM_CLASSD then
			tva2 = Color(29, 81, 56, 200)
		end
		if LocalPlayer():Team() != TEAM_SCP and self.Player:GetNClass() == ROLE_SCP939 then
			tva2 = Color(66, 188, 244, 200)
		end
    draw.RoundedBox( 0, 0, 0, w, h, tva2 )

		draw.RoundedBox( 0, 0, 0, w, h, tva2)

	end
}

--
-- Convert it from a normal table into a Panel Table based on DPanel
--
PLAYER_LINE = vgui.RegisterTable( PLAYER_LINE, "DPanel" )




--
-- Here we define a new panel table for the scoreboard. It basically consists
-- of a header and a scrollpanel - into which the player lines are placed.
--
local SCORE_BOARD = {
	Init = function( self )

		self.Header = self:Add( "Panel" )
		self.Header:Dock( TOP )
		self.Header:SetHeight( 44 )

		--self.Name = self.Header:Add( "DLabel" )
		--self.Name:SetFont( "ScoreboardDefault" )
		--self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
		--self.Name:Dock( LEFT )
		--self.Name:SetHeight( 40 )
		--self.Name:SetContentAlignment( 5 )
		--self.Name:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		self.Ping = self.Header:Add("DLabel")
		self.Ping:SetFont("ScoreboardDefault")
		self.Ping:SetTextColor(Color(255,255,255,255))
		self.Ping:Dock(RIGHT)
		self.Ping:SetContentAlignment(5)
		self.Ping:SetText("Ping")
		self.Ping:DockMargin( 0, 0, 32, 0 )
		self.Ping:SetWidth(50)

		self.Frag = self.Header:Add("DLabel")
		self.Frag:SetFont("ScoreboardDefault")
		self.Frag:SetTextColor(Color(255,255,255,255))
		self.Frag:Dock(RIGHT)
		self.Frag:SetContentAlignment(5)
		self.Frag:SetText("Frags")
		self.Frag:SetWidth(50)
		--self.Frag:DockMargin( 0, 0, -14, 0 )

		self.Karma = self.Header:Add("DLabel")
		self.Karma:SetFont("ScoreboardDefault")
		self.Karma:SetTextColor(Color(255,255,255,255))
		self.Karma:Dock(RIGHT)
		self.Karma:SetContentAlignment(5)
		self.Karma:SetText("Karma")
		self.Karma:DockMargin(0,0,5,0)
		self.Karma:SetWidth(50)

		self.Group = self.Header:Add("DLabel")
		self.Group:SetFont("ScoreboardDefault")
		self.Group:SetTextColor(Color(255,255,255,255))
		self.Group:Dock(RIGHT)
		self.Group:SetContentAlignment(5)
		self.Group:SetText("Group")
		self.Group:DockMargin(0,0,3,0)
		self.Group:SetWidth(150)

		self.Class = self.Header:Add("DLabel")
		self.Class:SetFont("ScoreboardDefault")
		self.Class:SetTextColor(Color(255,255,255,255))
		self.Class:Dock(RIGHT)
		self.Class:SetContentAlignment(5)
		self.Class:DockMargin(0,0,20,0)
		self.Class:SetText("Role")
		self.Class:SetWidth(200)
		--self.Karma:DockMargin( 0, 0, -14, 0 )
		--self.NumPlayers = self.Header:Add( "DLabel" )
		--self.NumPlayers:SetFont( "ScoreboardDefault" )
		--self.NumPlayers:SetTextColor( Color( 255, 255, 255, 255 ) )
		--self.NumPlayers:SetPos( 0, 100 - 30 )
		--self.NumPlayers:SetSize( 300, 30 )
		--self.NumPlayers:SetContentAlignment( 4 )

		self.Scores = self:Add( "DScrollPanel" )
		self.Scores:Dock( FILL )
		self.Header:DockMargin(0,0,self.Header:GetWide() - self.Scores:InnerWidth(), 0)
		self.Header:Dock(TOP)
		--self.Header:DockMargin(0,0,self.Scores:GetWide() - self.Scores:InnerWidth(),0)
	end,

	PerformLayout = function( self )

		--self:SetSize( 1200, ScrH() - 200 )
		--self:SetPos( ScrW() / 2 - 600, 100 )
		self:SetSize( ScrW() / 1.6 , ScrH() - 200 )
		self:SetPos( ScrW() / 2 - ((ScrW() / 1.6) / 2), 100 )

	end,

	Paint = function( self, w, h )

		--draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

	end,

	Think = function( self, w, h )

		--self.Name:SetText( GetHostName() )

		--
		-- Loop through each player, and if one doesn't have a score entry - create it.
		--
		local plyrs = player.GetAll()
		for id, pl in pairs( plyrs ) do

			if ( IsValid( pl.ScoreEntry ) ) then continue end

			pl.ScoreEntry = vgui.CreateFromTable( PLAYER_LINE, pl.ScoreEntry )
			pl.ScoreEntry:Setup( pl )

			self.Scores:AddItem( pl.ScoreEntry )
			self.Header:DockMargin(0,0,self.Header:GetWide() - self.Scores:InnerWidth(), 0)
			self.Header:Dock(TOP)
		end

	end
}

SCORE_BOARD = vgui.RegisterTable( SCORE_BOARD, "EditablePanel" )

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardShow( )
	Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()
	for k,v in pairs(player.GetAll()) do
		if not v.GetNClass then
			player_manager.RunClass( v, "SetupDataTables" )
		end
	end
	if USE_NEW_SB then
	if ( !IsValid( g_Scoreboard ) ) then
		g_Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
	end

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Show()
		g_Scoreboard:MakePopup()
		g_Scoreboard:SetKeyboardInputEnabled( false )
	end
	else
		ShowScoreBoard()
	end
end

function HandleUpdate(c, n, o)
	if USE_NEW_SB then
	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Hide()
	end
	else
	if IsValid(Frame) then
		Frame:Close()
	end
	end
	if o == "1" then
		USE_NEW_SB = true
	else
		USE_NEW_SB = false
	end
end

cvars.AddChangeCallback( "br_usesb", HandleUpdate, "REEEEEEEEEEEEEEEEEEEEEE" )
--[[---------------------------------------------------------
	Name: gamemode:ScoreboardHide( )
	Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()
	if USE_NEW_SB then
	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Hide()
	end
	else
	if IsValid(Frame) then
		Frame:Close()
	end
	end

end

--[[---------------------------------------------------------
	Name: gamemode:HUDDrawScoreBoard( )
	Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()
end
