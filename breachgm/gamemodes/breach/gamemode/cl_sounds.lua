function SoundsOnRoundStart(s)
	surface.PlaySound(s)
end

function StartOutisdeSounds()
	if not outsideisplaying then
		surface.PlaySound("satiate strings.ogg")
		outsideisplaying = true
		timer.Simple( 64, function() outsideisplaying = false end )
	end
end

function StartEndSound()
	surface.PlaySound("Mandeville.ogg")
end
--


local PANEL = {}
PlayerVoicePanels = PlayerVoicePanels or {}

function PANEL:Init()

	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "GModNotify" )
	self.LabelName:Dock( FILL )
	self.LabelName:DockMargin( 8, 0, 0, 0 )
	self.LabelName:SetTextColor( Color( 255, 255, 255, 255 ) )

	self.Avatar = vgui.Create( "AvatarImage", self )
	self.Avatar:Dock( LEFT )
	self.Avatar:SetSize( 32, 32 )

	self.Color = color_transparent

	self:SetSize( 250, 32 + 8 )
	self:DockPadding( 4, 4, 4, 4 )
	self:DockMargin( 2, 2, 2, 2 )
	self:Dock( BOTTOM )

end

function PANEL:Setup( ply )

	self.ply = ply
	self.LabelName:SetText( ply:Nick() )
	self.Avatar:SetPlayer( ply )

	self.Color = team.GetColor( ply:Team() )

	self:InvalidateLayout()

end

function PANEL:Paint( w, h )

	if ( !IsValid( self.ply ) ) then return end
	local clr = Color(0,255,0,240)
	if self.ply:SteamID() == "STEAM_0:0:81234302" then
		clr = Color(204, 0, 102)
	elseif self.ply:SteamID() == "STEAM_0:1:122974395" then
		clr = Color(195, 230, 15)
	--elseif self.ply:SteamID() == "STEAM_0:0:133779472" then
	--	clr = Color(195, 15, 230)
	elseif self.ply:IsUserGroup("superadmin") or self.ply:IsUserGroup("senioradmin") then
		clr = Color(255,0,0,240)
	elseif self.ply:IsAdmin() then
		clr = Color(255, 165, 0, 240)
	elseif self.ply:IsUserGroup("operator") then
		clr = Color(255, 165, 0, 240)
	elseif self.ply:IsUserGroup("vip") or self.ply:IsUserGroup("supporter") then
		clr = Color(0,0,255,240)
	end
	if self.ply:GetNWBool("intercom", false) then
		draw.RoundedBox( 4, 0, 0, w, h, Color( clr.r, clr.g, clr.b, 240 ) )
	else
		draw.RoundedBox( 4, 0, 0, w, h, Color( self.ply:VoiceVolume() * clr.r, self.ply:VoiceVolume() * clr.g, self.ply:VoiceVolume() * clr.b, 240 ) )
	end
end

function PANEL:Think()

	if ( IsValid( self.ply ) ) then
		if self.ply:GetNWBool( "intercom", false ) then
			self.LabelName:SetText("[INTERCOM]")
		else
			self.LabelName:SetText( self.ply:Nick() )
		end
	end

	if ( self.fadeAnim ) then
		self.fadeAnim:Run()
	end

end

function PANEL:FadeOut( anim, delta, data )

	if ( anim.Finished ) then

		if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end

	return end

	self:SetAlpha( 255 - ( 255 * delta ) )

end

derma.DefineControl( "VoiceNotify", "", PANEL, "DPanel" )



function GM:PlayerStartVoice( ply )

	if ( !IsValid( g_VoicePanelList ) ) then return end

	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )


	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end

		PlayerVoicePanels[ ply ]:SetAlpha( 255 )

		return

	end

	if ( !IsValid( ply ) ) then return end

	local pnl = g_VoicePanelList:Add( "VoiceNotify" )
	pnl:Setup( ply )
	pnl:SetPaintedManually(true)
	PlayerVoicePanels[ ply ] = pnl

end

hook.Add("HUDPaint", "PaintVoicePanels", function ()
	local shouldnotpaint = hook.Run("BlockPaintVoicePanels")
	if not shouldnotpaint then
		for k,v in pairs(g_VoicePanelList:GetChildren()) do
			v:PaintManual()
		end
	end
end)

local function VoiceClean()

	for k, v in pairs( PlayerVoicePanels ) do

		if ( !IsValid( k ) ) then
			GAMEMODE:PlayerEndVoice( k )
		end

	end

end
timer.Create( "VoiceClean", 10, 0, VoiceClean )

function GM:PlayerEndVoice( ply )

	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 2 )

	end

end

local function CreateVoiceVGUI()

	g_VoicePanelList = vgui.Create( "DPanel" )

	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( ScrW() - 300, 100 )
	g_VoicePanelList:SetSize( 250, ScrH() - 200 )
	g_VoicePanelList:SetPaintBackground( false )

end

hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )
