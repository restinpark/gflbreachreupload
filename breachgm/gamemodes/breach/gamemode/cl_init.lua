local meta = FindMetaTable("Player")
function meta:GetNClass()
	return self:GetNWString("Breach_Role", "Spectator")
end
include("shared.lua")
include("fonts.lua")
include("class_default.lua")
include("sh_player.lua")
include("cl_mtfmenu.lua")
--include("cl_scoreboard.lua")
include( "cl_sounds.lua" )
include( "cl_targetid.lua" )
include("cl_headbob.lua")
include("cl_msgstack.lua")
surface.CreateFont( "173font", {
	font = "TargetID",
	extended = false,
	size = 22,
	weight = 700,
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
	outline = false,
} )
LAST_BLINK_TIME = 0
clang = nil
ALLLANGUAGES = {}


local files, dirs = file.Find(GM.FolderName .. "/gamemode/languages/*.lua", "LUA" )
for k,v in pairs(files) do
	local path = "languages/"..v
	if string.Right(v, 3) == "lua" then
		include( path )
		print("Loading language: " .. path)
	end
end

langtouse = CreateClientConVar( "br_language", "english", true, false ):GetString()
BREACH_SHOWROUNDINFO = CreateClientConVar( "br_showroundinfo", "1", true, false )

cvars.AddChangeCallback( "br_language", function( convar_name, value_old, value_new )
	langtouse = value_new
	if ALLLANGUAGES[langtouse] then
		clang = ALLLANGUAGES[langtouse]
	end
end )
hook.Add("PostCleanupMap", "PostCleanupMap_HideGlitchedRagdolls", function ()
	for _, ent in pairs(ents.FindByClass("prop_ragdoll")) do
		if IsValid(ent) and ent:GetNWString("player_nick", "") != "" then
		   ent:SetNoDraw(true)
		   ent:SetSolid(SOLID_NONE)
		   ent:SetColor(Color(0,0,0,0))
		   ent.NoTarget = true
		end
  end
end)
print("langtouse:")
print(langtouse)

//print("Alllangs:")
//PrintTable(ALLLANGUAGES)

if ALLLANGUAGES[langtouse] then
	clang = ALLLANGUAGES[langtouse]
else
	clang = ALLLANGUAGES.english
end

mapfile = "mapconfigs/" .. game.GetMap() .. ".lua"
//include(mapfile)
include("rounds.lua")
include("cl_hud.lua")

RADIO4SOUNDSHC = {
	{"chatter1", 39},
	{"chatter2", 72},
	{"chatter4", 12},
	{"franklin1", 8},
	{"franklin2", 13},
	{"franklin3", 12},
	{"franklin4", 19},
	{"ohgod", 25}
}

RADIO4SOUNDS = table.Copy(RADIO4SOUNDSHC)

disablehud = false
livecolors = false
current_mute_mode = 0
CreateClientConVar( "br_mtfntf_weapon", "random", true, true, "Preference of weapon for MTF/Nine Tailed Fox." )
CreateClientConVar( "br_ci_weapon", "random", true, true, "Preference of weapon for Chaos Insurgency." )
CreateClientConVar( "br_preventmtf", "0", true, true, "Tell role selection to avoid making you an MTF (Does not effect NTF/CI respawns)." )
CreateClientConVar( "br_preventscp", "0", true, true, "Tell role selection to avoid making you an SCP." )
CreateClientConVar( "br_mutemode", "0", false, false, "0 = hear specs + in range living, 1 = mute living, 2 = mute specs, 3 = mute all" )
CreateClientConVar( "br_spectator", "0", true, true, "1 will make you a spectator instead of spawning you." )
CreateClientConVar( "br_nvggreen", "1", true, true, "Enable NVG green color." )

CreateClientConVar( "br_fogenable", "0", true, false, "Enable the fog." )
net.Receive("BR_SPECTATOR_UPDATER", function ()
	local nm = net.ReadBool()
	if nm then
		RunConsoleCommand("br_spectator", "1")
	else
		RunConsoleCommand("br_spectator", "0")
	end
end)
net.Receive("BR_SendChatMessage", function ()
	local msg = net.ReadString()
	chat.AddText(Color(255,0,0), msg)
end)
function SendNewMuteMode(c, o, n)
	net.Start("PLAYER_UPDATE_MUTE_MODE")
	if tonumber(n) != nil then
		--current_mute_mode = n
		net.WriteInt(tonumber(n), 8)
	else
		--current_mute_mode = 0
		net.WriteInt(0, 8)
	end
	net.SendToServer()
end
function KillselfIfNeeded(c, o, n)
	if n == "1" then
		if LocalPlayer():Team() != TEAM_SPEC then
			net.Start("BR_EndMySuffering")
			net.SendToServer()
		end
	end
end
function NextMuteMode()
	if LocalPlayer():Team() != TEAM_SPEC then return end
	local cmode = GetConVar("br_mutemode"):GetInt()
	local nm = 1
	print(cmode)
	if cmode == 1 then
		nm = 2
		LocalPlayer():PrintMessage(HUD_PRINTTALK, "Spectators Muted.")
	elseif cmode == 2 then
		nm = 3
		LocalPlayer():PrintMessage(HUD_PRINTTALK, "Everyone Muted.")
	elseif cmode == 3 then
		nm = 0
		LocalPlayer():PrintMessage(HUD_PRINTTALK, "Nobody Muted.")
	else
		nm = 1
		LocalPlayer():PrintMessage(HUD_PRINTTALK, "Living Muted.")
	end
	RunConsoleCommand( "br_mutemode", tostring(nm) )
end
concommand.Add( "br_nextmutemode", NextMuteMode, nil, nil, 0 )
cvars.AddChangeCallback( "br_mutemode", SendNewMuteMode, "BR_MUTEMODE_CHANGED" )
cvars.AddChangeCallback( "br_spectator", KillselfIfNeeded, "BR_KILLMYSELFLOL_ENDME" )
function DropCurrentVest()
	if LocalPlayer():Alive() and LocalPlayer():Team() != TEAM_SPEC then
		net.Start("DropCurrentVest")
		net.SendToServer()
	end
end

concommand.Add( "br_spectate", function( ply, cmd, args )
	net.Start("SpectateMode")
	net.SendToServer()
end )

concommand.Add( "br_roundrestart_cl", function( ply, cmd, args )
	if ply:IsSuperAdmin() then
		net.Start("RoundRestart")
		net.SendToServer()
	end
end )

concommand.Add( "br_dropvest", function( ply, cmd, args )
	DropCurrentVest()
end )

concommand.Add( "br_disableallhud", function( ply, cmd, args )
	disablehud = !disablehud
end )

concommand.Add( "br_livecolors", function( ply, cmd, args )
	if livecolors then
		livecolors = false
		chat.AddText("livecolors disabled")
	else
		livecolors = true
		chat.AddText("livecolors enabled")
	end
end )

gamestarted = false
cltime = 0
drawinfodelete = 0
shoulddrawinfo = false
drawendmsg = nil
timefromround = 0

timer.Create("HeartbeatSound", 2, 0, function()
	if not LocalPlayer().Alive then return end
	if LocalPlayer():Alive() and LocalPlayer():Team() != TEAM_SPEC then
		if LocalPlayer():Health() < 30 then
			LocalPlayer():EmitSound("heartbeat.ogg")
		end
	end
end)

function OnUseEyedrops(ply) end

function StartTime()
	timer.Destroy("UpdateTime")
	TIMER_IS_SETUP_BREACH = true
	timer.Create("UpdateTime", 1, 0, function()
	cltime = GetGlobalFloat("br_round_end") - CurTime()
		if cltime < 0 then
			cltime = 0
		end
	end)
end

endinformation = {}
if not TIMER_IS_SETUP_BREACH then
	StartTime()
end


net.Receive( "UpdateTime", function( len )

	StartTime()
end)

net.Receive( "OnEscaped", function( len )
	local nri = net.ReadInt(4)
	local t = net.ReadFloat()
	hook.Run("BreachLocalplayerEscaped", nri, t)
	StartEndSound()
	SlowFadeBlink(7)
end)

net.Receive( "ForcePlaySound", function( len )
	local sound = net.ReadString()
	surface.PlaySound(sound)
end)

net.Receive( "UpdateRoundType", function( len )
	roundtype = net.ReadString()
	print("Current roundtype: " .. roundtype)
end)

function PlayerBindPressMM( ply, bind, pressed )
	if ( string.find( bind, "gm_showteam" ) ) and pressed then
		NextMuteMode()
		return true
	end

end
hook.Add("PlayerBindPress", "PlayerBindPressMM", PlayerBindPressMM)

function GetRoundState()
	return GetGlobalInt( "Round_State_Breach", ROUND_WAIT )
end

timer.Create("UpdateBreachRoundState", 1, 0, function ()
	local s = GetRoundState()
	if s == 0 or s == 1 then
		preparing = true
		postround = false
	elseif s == 2 then
		preparing = false
		postround = false
	elseif s == 3 then
		preparing = false
		postround = true
	end
end)


net.Receive( "PrepStart", function( len )
	cltime = net.ReadInt(8)
	local sound = net.ReadString()
	chat.AddText(string.Replace( clang.preparing,  "{num}", cltime ))
	StartTime()
	drawendmsg = nil
	--Kill any end round sounds that overstay their welcome.
	RunConsoleCommand("stopsound")
	hook457delete = CurTime() + 0.5
	hook.Add("Tick", "Stop457Sounds", function()
		if hook457delete != nil then
			if hook457delete < CurTime() then
				hook457delete = nil
				hook.Remove("Tick", "Stop457Sounds")
			end
			if LocalPlayer():GetNClass() == ROLE_SCP457 then
				RunConsoleCommand("stopsound")
			end
		end
	end)
	local function PlayRoundStartSound()
		SoundsOnRoundStart(sound)
	end
	timer.Remove("SoundsOnRoundStart")
	timer.Create("SoundsOnRoundStart", 1, 1, PlayRoundStartSound)
	timefromround = CurTime() + 10
	RADIO4SOUNDS = table.Copy(RADIO4SOUNDSHC)
end)

net.Receive( "RoundStart", function( len )
	cltime = net.ReadInt(12)
	chat.AddText(clang.round)
	StartTime()
	drawendmsg = nil
end)

net.Receive( "PostStart", function( len )
	cltime = net.ReadInt(6)
	win = net.ReadInt(8)
	local nextround = net.ReadFloat()
	local winners = net.ReadTable()
	hook.Run("BreachWinnerDeclared", win, nextround, winners)
	StartTime()
end)

hook.Add("BreachWinnerDeclared", "BreachWinnerDeclaredSound", function (win)
	if win == TEAM_CHAOS then
		surface.PlaySound("csgo/ciwin_tdm.wav")
	elseif win == TEAM_GUARD then
		if math.random(1, 100) == 5 then
			surface.PlaySound("gary/mtfwin_tdm_sp.wav")
		else
			surface.PlaySound("csgo/mtfwin_tdm.wav")
		end
	elseif win == TEAM_CLASSD then
		surface.PlaySound("kaito/classd_win.mp3")
	elseif win == TEAM_SCI then
		surface.PlaySound("kaito/foundation_win.mp3")
	elseif win == TEAM_SPEC then
		surface.PlaySound("kaito/draw.mp3")
	elseif win == TEAM_SCP then
		surface.PlaySound("gary/scp_win.ogg")
	elseif win == TEAM_CLASSE then
		surface.PlaySound("classe_win.mp3")
	elseif win == TEAM_GOC then
		surface.PlaySound("core/placeholder.mp3")
	else
		ErrorNoHalt("Unexpected value sent by the server for winner.\n")
	end
end)

hook.Add( "OnPlayerChat", "CheckChatFunctions", function( ply, strText, bTeam, bDead )
	strText = string.lower( strText )

	if ( strText == "dropvest" ) then
		if ply == LocalPlayer() then
			DropCurrentVest()
		end
		return true
	end
end)

// Blinking system

local brightness = 0
local f_fadein = 0.25
local f_fadeout = 0.000075


local f_end = 0
local f_started = false
function tick_flash()
	if LocalPlayer().Team == nil then return end
	if LocalPlayer():Team() != TEAM_SPEC then
		if GetGlobalVector( "POINT_OUTSIDESOUNDS", Vector(69,69,69) ) != Vector(69,69,69)  then
			for k,v in pairs(ents.FindInSphere(GetGlobalVector( "POINT_OUTSIDESOUNDS", Vector(69,69,69) ), 300)) do
				if v == LocalPlayer() then
					StartOutisdeSounds()
				end
			end
		end
	end
	if shoulddrawinfo then
		if CurTime() > drawinfodelete then
			shoulddrawinfo = false
			drawinfodelete = 0
		end
	end
	if f_started then
		LAST_BLINK_TIME = CurTime()
		if CurTime() > f_end then
			brightness = brightness + f_fadeout
			if brightness < 0 then
				f_end = 0
				brightness = 0
				f_started = false
				LAST_BLINK_TIME = CurTime()
			end
		else
			if brightness < 1 then
				brightness = brightness - f_fadein
			end
		end
	end
end
hook.Add( "Tick", "htickflash", tick_flash )

net.Receive("PlayerBlink", function(len)
	local time = net.ReadFloat()
	Blink(time)
end)

net.Receive("SlowPlayerBlink", function(len)
	local time = net.ReadFloat()
	Blink(time)
end)

function SlowFadeBlink(time)
	f_fadein = 0.0075
	f_fadeout = 0.0075
	f_started = true
	f_end = CurTime() + time
end

function Blink(time)
	f_fadein = 0.25
	f_fadeout = 0.000075
	f_started = true
	f_end = CurTime() + time
	//print("blink start")
end

local mat_color = Material( "pp/colour" )
hook.Add( "RenderScreenspaceEffects", "blinkeffects", function()
	//if f_started == false then return end

	local contrast = 1
	local colour = 1

	if livecolors then
		contrast = 1.1
		colour = 1.5
	end
	if LocalPlayer():Health() < 30 and LocalPlayer():Alive() then
		colour = math.Clamp((LocalPlayer():Health() / LocalPlayer():GetMaxHealth()) * 5, 0, 2)
	end
	render.UpdateScreenEffectTexture()


	mat_color:SetTexture( "$fbtexture", render.GetScreenEffectTexture() )

	mat_color:SetFloat( "$pp_colour_brightness", brightness )
	mat_color:SetFloat( "$pp_colour_contrast", contrast)
	mat_color:SetFloat( "$pp_colour_colour", colour )

	render.SetMaterial( mat_color )
	render.DrawScreenQuad()
end )

local debugcvar = GetConVar("br_debug")

hook.Add("PrePlayerDraw", function (ply)

	if ply:GetNClass() == ROLE_SCP378 and not ply:GetNWBool("SCP363_IsDisg", false) then
		cam.Start3D()
		local pos = ply:GetPos()
		render.Model({
			model = "models/tsbb/animals/giant_isopod.mdl",
			--model = "models/maxofs2d/balloon_classic.mdl",
			pos = Vector(pos.x, pos.y, pos.z),
			angle = ply:GetAngles()
		})
		cam.End3D()
			return true
	end
end)

local dropnext = 0
function GM:PlayerBindPress( ply, bind, pressed )
	if bind == "+menu" then
		if dropnext > CurTime() then return true end
		dropnext = CurTime() + 0.5
		local wep = LocalPlayer():GetActiveWeapon()
		if IsValid(wep) and wep.PreDrop then
			wep:PreDrop()
		end
		net.Start("DropWeapon")
		net.SendToServer()

		if LocalPlayer().channel != nil then
			LocalPlayer().channel:EnableLooping( false )
			LocalPlayer().channel:Stop()
			LocalPlayer().channel = nil
		end
		return true
	elseif bind == "+menu_context" then
		thirdpersonenabled = !thirdpersonenabled
	end
end

concommand.Add("br_requestescort", function()
	local team = LocalPlayer():Team()
	if roundtype == "Speedrun%" and LocalPlayer():GetNClass() == ROLE_SERPENT then return end
	if team == TEAM_CHAOS or team == TEAM_GUARD or LocalPlayer():GetNClass() == ROLE_SERPENT or LocalPlayer():GetNClass() == ROLE_NOBODY then
		net.Start("RequestEscorting")
		net.SendToServer()
	end
end)

concommand.Add("br_requestgatea", function()
	if !((LocalPlayer():Team() == TEAM_GUARD or LocalPlayer():Team() == TEAM_CHAOS) or LocalPlayer():Team() == TEAM_CHAOS) then return end
	if LocalPlayer():CLevelGlobal() < 4 then return end
	net.Start("RequestGateA")
	net.SendToServer()
end)

concommand.Add("br_sound_random", function()
	if (LocalPlayer():Team() == TEAM_GUARD or LocalPlayer():Team() == TEAM_CHAOS) and LocalPlayer():Alive() then
		net.Start("Sound_Random")
		net.SendToServer()
	end
end)

concommand.Add("br_sound_searching", function()
	if (LocalPlayer():Team() == TEAM_GUARD or LocalPlayer():Team() == TEAM_CHAOS) and LocalPlayer():Alive() then
		net.Start("Sound_Searching")
		net.SendToServer()
	end
end)

concommand.Add("br_sound_classd", function()
	if (LocalPlayer():Team() == TEAM_GUARD or LocalPlayer():Team() == TEAM_CHAOS) and LocalPlayer():Alive() then
		net.Start("Sound_Classd")
		net.SendToServer()
	end
end)

concommand.Add("br_sound_stop", function()
	if (LocalPlayer():Team() == TEAM_GUARD or LocalPlayer():Team() == TEAM_CHAOS) and LocalPlayer():Alive() then
		net.Start("Sound_Stop")
		net.SendToServer()
	end
end)

concommand.Add("br_sound_lost", function()
	if (LocalPlayer():Team() == TEAM_GUARD or LocalPlayer():Team() == TEAM_CHAOS) and LocalPlayer():Alive() then
		net.Start("Sound_Lost")
		net.SendToServer()
	end
end)

print("cl_init loads")

IS_FOG_ENABLED = GetConVar("br_fogenable")
function GM:SetupWorldFog()
	local cwep = LocalPlayer():GetActiveWeapon()
	if roundtype == "Bright in the Screen" and LocalPlayer():GetNClass() != ROLE_REDACTED and cwep and IsValid(cwep) and cwep:GetClass() == "tfa_csgo_deagle" then
		render.FogMode( 1 )
		render.FogStart( 1 )
		render.FogEnd( 100 )
		render.FogMaxDensity( 1)

		--local col = self:GetFogColor()
		render.FogColor( 0 * 255, 0 * 255, 0 * 255 )

		return true
	end

	if not IS_FOG_ENABLED:GetBool() then
		render.FogMode(1)
		render.FogStart(30000)
		render.FogEnd(10000)
		render.FogMaxDensity(0)
		return true
	end

	if not IS_FOG_ENABLED:GetBool() and game.GetMap() != "br_site05" and game.GetMap() != "br_area02_v3" and game.GetMap() != "br_site61_v2" then return true end
	render.FogMode( 1 )
	render.FogStart( 30000 )
	render.FogEnd( 10000 )
	render.FogMaxDensity( 0.80 )

	--local col = self:GetFogColor()
	render.FogColor( 0 * 255, 0 * 255, 0 * 255 )

	return true

end

function Team939(ply)
	if not ply.GetNClass then
		player_manager.RunClass( ply, "SetupDataTables" )
	end
	if IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP939 then
		return(team.GetColor(TEAM_SCI))
	end
end
hook.Add("GetTeamColor", "GetTeamColor_939", Team939)