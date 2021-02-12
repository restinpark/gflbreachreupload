local hide = {
    CHudHealth = true,
    CHudBattery = true,
    CHudAmmo = true,
    CHudSecondaryAmmo = true,
    --CHudWeaponSelection = true,
    CHudDeathNotice = true,
    CHudWeapon = true,
    CHudSuitPower = true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
    if ( hide[ name ] ) then return false end
end )

function DrawInfo(pos, txt, clr)
    pos = pos:ToScreen()
    draw.TextShadow( {
        text = txt,
        pos = { pos.x, pos.y },
        font = "HealthAmmo",
        color = clr,
        xalign = TEXT_ALIGN_CENTER,
        yalign = TEXT_ALIGN_CENTER,
    }, 2, 255 )
end

--This allows us to take a ROLE_* enum and return the index for starttexts
function Getrl(rl)
    if LocalPlayer():Team() == TEAM_CHAOS then
        if roundtype == "Trouble in SCP Town" then
            return 12
        elseif roundtype == "Team Deathmatch" then
            return 13
        else
            return 11
        end
    end
    if rl == ROLE_RES and LocalPlayer():Team() == TEAM_CHAOS then return 48 end
    if rl == ROLE_SCP173 then return 1 end
    if rl == ROLE_SCP106 then return 2 end
    if rl == ROLE_SCP049 then return 3 end
    if rl == ROLE_SCP457 then return 15 end
    if rl == ROLE_MTFGUARD then
        if roundtype == "Trouble in SCP Town" then
            return 5
        elseif roundtype == "Zombie Plague" then
            return 16
        else
            return 4
        end
    end
    if rl == ROLE_MTFCOM then return 6 end
    if rl == ROLE_MTFNTF then return 7 end
    if rl == ROLE_CLASSD then return 8 end
    if rl == ROLE_RES then return 9 end
    if rl == ROLE_SCP0492 then return 10 end
    if rl == ROLE_SPEC then return 14 end
    if rl == ROLE_SCP0082 then return 17 end
    if rl == ROLE_SCP096 then return 18 end
    if rl == ROLE_SCP682 then return 19 end
    if rl == ROLE_SCP1048A then return 20 end
    if rl == ROLE_SCP035 then return 21 end
    if rl == ROLE_SCP066 then return 22 end
    if rl == ROLE_SCP966 then return 23 end
    if rl == ROLE_MTFRRH then return 24 end
    if rl == ROLE_SCP939 then return 25 end
    if rl == ROLE_SCP0762 then return 26 end
    if rl == ROLE_999 then return 27 end
    if rl == ROLE_05 then return 28 end
    if rl == ROLE_1048 then return 29 end
    if rl == ROLE_178 then return 30 end
    if rl == ROLE_SCP1048B then return 31 end
    if rl == ROLE_SCP017 then return 32 end
    if rl == ROLE_2639A then return 33 end
    if rl == ROLE_SCP372 then return 35 end
    if rl == ROLE_SCP082 then return 36 end
    if rl == ROLE_SCP0762PB then return 37 end
    if rl == ROLE_MTFFB then return 39 end
    if rl == ROLE_DRCLEF or rl == ROLE_MTFL2 then return 40 end
    if rl == ROLE_SCP1471 then return 41 end
    if rl == ROLE_SERPENT then return 42 end
    if rl == ROLE_SCP2521 then return 43 end
    if rl == ROLE_SPCGUARD then return 44 end
    if rl == ROLE_SCLASS then return 45 end
    if rl == ROLE_SCP610 then return 46 end
    if rl == ROLE_SCP610B then return 47 end
    if rl == ROLE_MTFNU then return 49 end
    if rl == ROLE_MTFGUARDSNIPER then return 50 end
    if rl == ROLE_MTFGUARDHEAVY then return 51 end
    if rl == ROLE_MTFGUARDPYRO then return 52 end
    if rl == ROLE_REDACTED then return 53 end
    if rl == ROLE_MTFGUARDMEDIC then return 54 end
    if rl == ROLE_SCP2845 then return 55 end
    if rl == ROLE_SCP334 then return 56 end
    if rl == ROLE_SCP795 then return 57 end
    if rl == ROLE_SCP689 then return 58 end
    if rl == ROLE_TAU5 then return 59 end
    if rl == ROLE_SCP378 then return 61 end
    if rl == ROLE_SCP607 then return 64 end
    if rl == ROLE_SCP323 then return 63 end
    if rl == ROLE_CLASSE then return 65 end
    if rl == ROLE_SCP079 then return 66 end
    if rl == ROLE_SCP011 then return 67 end
    if rl == ROLE_SCP3331 then return 68 end
    if rl == ROLE_SCP160 then return 69 end
    if rl == ROLE_SCP020 then return 70 end
    if rl == ROLE_GUARD212 then return 71 end
	if rl == ROLE_SCP1959 then return 72 end
	if rl == ROLE_O51 then return 73 end
	if rl == ROLE_UNI then return 74 end
	if rl == ROLE_CONF then return 75 end
	if rl == ROLE_NOBODY then return 76 end
	if rl == ROLE_SCP3199 then return 77 end
	if rl == ROLE_SCP3199B then return 78 end
	if rl == ROLE_MTFSIG then return 79 end
	if rl == ROLE_AWCY then return 80 end
	if rl == ROLE_SCP2953 then return 81 end
	if rl == ROLE_RANDOM then return 82 end
	if rl == ROLE_DRBRIGHT then return 83 end
	if rl == ROLE_SCP4715 then return 84 end
	if rl == ROLE_SCPWW then return 85 end
	if rl == ROLE_SCP1048C then return 86 end
	if rl == ROLE_SCP1048BR then return 87 end
	if rl == ROLE_SCP990 then return 88 end
	if rl == ROLE_PLAYER1 then return 89 end
	if rl == ROLE_PLAYER2 then return 90 end
	if rl == ROLE_PLAYER3 then return 91 end
	if rl == ROLE_SCP1315A then return 92 end
	if rl == ROLE_SCP1315B then return 93 end
	if rl == ROLE_SCP1315C then return 94 end
	if rl == ROLE_SCP038A then return 95 end
	if rl == ROLE_SCP1360 then return 96 end
	if rl == ROLE_LH then return 97 end
	if rl == ROLE_SCP1861B then return 98 end
	if rl == ROLE_CLASSD9341 then return 99 end
	if rl == ROLE_CLASSD11424 then return 100 end
	if rl == ROLE_SCP181 then return 101 end
	if rl == ROLE_SCP2301 then return 102 end
	if rl == ROLE_MTFGUARD2301 then return 103 end
	if rl == ROLE_MTFGUARDENG then return 104 end
	if rl == ROLE_SCP817 then return 105 end
	if rl == ROLE_SCP2953UP then return 106 end
	if rl == ROLE_SCP427 then return 107 end
	if rl == ROLE_SCP2953D then return 108 end
	if rl == ROLE_SCP2953C then return 109 end
	if rl == ROLE_SCP2953L then return 110 end
	if rl == ROLE_SCP2953M then return 111 end
	if rl == ROLE_SCP2953G then return 112 end
	if rl == ROLE_SCP010 then return 113 end
    return 14 --Fallback to spectator
end

--General variables for the HUD to use

local draw_hud = CreateClientConVar("br_drawhud", "1", true, false, "Should breach draw the hud?")
local draw_crosshair = CreateClientConVar("br_drawcrosshair", "1", true, false, "Enable/Disable the drawing of the crosshair.")
local draw_roleinfo = CreateClientConVar("br_drawroleinfo", "1", true, false, "Enable/Disable the drawing of the role info")

local function init_hud_fonts()
    surface.CreateFont( "BR_RoundInfo", {font = "Roboto", size = 26, antialias = true} )
    surface.CreateFont("ImpactBig", {font = "Impact", size = 45, weight = 700})
    surface.CreateFont("ImpactSmall", {font = "Impact", size = 30, weight = 700})
    surface.CreateFont("BR_RoleName", {font = "Roboto", size = 30, antialias = true, weight = 600})
    surface.CreateFont("ImpactSmaller", {font = "Courier New", size = 25, weight = 700})
    surface.CreateFont( "RadioFont", {font = "Impact", extended = false, size = 26, weight = 600, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false, } )
    surface.CreateFont("BR_RoleName_New", {font = "Roboto", size = 84, antialias = true, weight = 600})
    surface.CreateFont("BR_RoleName_Smaller", {font = "Coolvetica", size = 40, antialias = true, weight = 500})
    surface.CreateFont("BR_RoleDetails", {font = "Roboto", size = 28, antialias = true, weight = 500})
    surface.CreateFont("BR_Winners", {font = "Coolvetica", size = 84, antialias = true, weight = 500, extended = true})
    surface.CreateFont("BR_Winners_Small", {font = "Coolvetica", size = 28, antialias = true, weight = 500, extended = true, italics = true, italic = true})
    surface.CreateFont("BR_Winners_Small2", {font = "Coolvetica", size = 28, antialias = true, weight = 500, extended = true})
end

init_hud_fonts()

--Crosshair

function DrawCrosshair()
    local weapon = LocalPlayer():GetActiveWeapon()
    if weapon and IsValid(weapon) then
        if weapon.Base != "tfa_csgo_base" and weapon.Base != "tfa_3dcsgo_base" and weapon.Base != "tfa_gun_base" then return end

        local sights = false
        local x = math.floor(ScrW() / 2.0)
        local y = math.floor(ScrH() / 2.0)
        local scale = 0.4

        local LastShootTime = weapon:LastShootTime()
        scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

        local alpha = 1
        local bright = 1
        local tr, tg, tb
        tr = team.GetColor(LocalPlayer():Team()).r
        tg = team.GetColor(LocalPlayer():Team()).g
        tb = team.GetColor(LocalPlayer():Team()).b
        surface.SetDrawColor(tr * bright, tg * bright, tb * bright, 255 * alpha)

        local gap = math.floor(20 * scale * (sights and 0.8 or 1))
        local length = math.floor(gap + (25 * scale))
        surface.DrawLine( x - length, y, x - gap, y )
        surface.DrawLine( x + length, y, x + gap, y )
        surface.DrawLine( x, y - length, x, y - gap )
        surface.DrawLine( x, y + length, x, y + gap )
    end
end

--Health, Ammo, Blink, Role

local bar1 = Material("vgui/breach_hud/bar1.png", "unlitgeneric" )
local bar2 = Material("vgui/breach_hud/bar2.png", "unlitgeneric" )
--local bar3 = Material("vgui/breach_hud/bar3.png", "unlitgeneric" )
local blinkico = Material("vgui/breach_hud/blink.png", "unlitgeneric" )
local healthico = Material("vgui/breach_hud/health.png", "unlitgeneric" )
local blink_delay = GetConVar("br_time_blinkdelay")

local function DrawProgBar(x, y, bar, perc)
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawRect(x, y, 183, 18)
    surface.SetDrawColor( 0, 0, 0, 255 )
    surface.DrawRect(x + 1, y + 1, 180, 16)
    local bx = x + 3
    --local by = x + 2
    local bc = math.ceil( perc / 5)
    for i = 1, bc do
        surface.SetDrawColor( 255, 255, 255, 255 )
        render.SetMaterial(bar)
        render.DrawScreenQuadEx( bx, y + 2, 8, 14 )
        bx = bx + 9
    end
end

function DrawPrimaryHUD()
    --Player
    local c = LocalPlayer():GetObserverTarget()
    if not c or not IsValid(c) or not c:IsPlayer() then
        c = LocalPlayer()
    else
        --obs is good, so we can draw their name to the top
        draw.TextShadow( {
            text = c:Nick(),
            pos = {ScrW() / 2, 0},
            font = "BR_RoleName",
            color = Color(255,255,255),
            xalign = TEXT_ALIGN_CENTER,
            yalign = TEXT_ALIGN_LEFT,
        }, 2, 255 )
    end

    --Fix the CI Team Color
    local role = c:GetNClass()
    local color = team.GetColor(c:Team())
    if c != LocalPlayer() and c:Team() == TEAM_CHAOS and (c:GetNClass() == ROLE_MTFGUARD or c:GetNClass() == ROLE_MTFNTF) then
        color = team.GetColor(TEAM_GUARD)
    elseif c != LocalPlayer() and c:Team() == TEAM_CHAOS and c:Team() == TEAM_CHAOS and c:GetNClass() == ROLE_RES then
        color = team.GetColor(TEAM_SCI)
    elseif c:Team() == TEAM_CHAOS then
        color = Color(29, 81, 56)
        if c:GetNClass() == ROLE_RES then
            role = "Dr.Maynard"
        else
            role = "Chaos Insurgency"
        end
    end

    --Blink meter
    local blink_percent = math.Clamp(1 - ((CurTime() - LAST_BLINK_TIME) / blink_delay:GetFloat()), 0, 1)
    if LocalPlayer():Team() == TEAM_SCP or LocalPlayer():Team() == TEAM_SPEC then
        blink_percent = 1
    end
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawRect(24,ScrH() - 101, 32, 32)
    render.SetMaterial(blinkico)
    render.DrawScreenQuadEx(25, ScrH() - 100, 30, 30)
    DrawProgBar(65, ScrH() - 94, bar1, blink_percent * 100)


    --Health meter
    local health_percent = math.Clamp(LocalPlayer():Health() / LocalPlayer():GetMaxHealth(), 0, 1)
    surface.SetDrawColor(255,255,255,255)
    surface.DrawRect(24,ScrH() - 46, 32, 32)
    render.SetMaterial(healthico)
    render.DrawScreenQuadEx(25, ScrH() - 45, 30, 30)
    DrawProgBar(65, ScrH() - 39, bar2, health_percent * 100)

    --Health Text

    draw.TextShadow( {
        text = c:Health() .. " / " .. c:GetMaxHealth(),
        pos = { 65, ScrH() - 55 },
        font = "DebugFixed",
        color = Color(255,255,255),
        xalign = TEXT_ALIGN_TOP,
        yalign = TEXT_ALIGN_TOP,
    }, 2, 255 )

    --Ammo Text
    local atxt = ""
    if c:GetActiveWeapon() != nil then
        local c_wep = c:GetActiveWeapon()
        if c_wep and c_wep.Clip1 and c_wep:Clip1() > -1 then
            atxt = tostring(c_wep:Clip1()) .. " + " .. tostring(c:GetAmmoCount(c_wep:GetPrimaryAmmoType()))
        end
    end

    draw.TextShadow( {
        text = atxt,
        pos = { 248, ScrH() - 55 },
        font = "DebugFixed",
        color = Color(255,255,255),
        xalign = TEXT_ALIGN_RIGHT,
        yalign = TEXT_ALIGN_LEFT,
    }, 2, 255 )

    --Role
    draw.TextShadow( {
        text = string.upper(role),
        pos = { ScrW() - 25, ScrH() - 46 },
        font = "BR_RoleName",
        color = color,
        xalign = TEXT_ALIGN_RIGHT,
        yalign = TEXT_ALIGN_LEFT,
    }, 2, 255 )

    --Time
    draw.TextShadow( {
        text = tostring(string.ToMinutesSeconds( math.Clamp(GetGlobalFloat("br_round_end") - CurTime(), 0, 99999) )),
        pos = { 65, ScrH() - 126 },
        font = "TimeLeft",
        color = tclr,
        xalign = TEXT_ALIGN_TOP,
        yalign = TEXT_ALIGN_TOP,
    }, 2, 255 )
end

--The spawn messages

local ROUND_START_TIME = -999
local REAL_START_TIME = -999

hook.Add("BreachStartRound", "BreachStartRound_UpdateHUDVariables", function ()
    ROUND_START_TIME = CurTime()
    REAL_START_TIME = CurTime()
end)

--The only thing ROUND_START_TIME is used for is drawing the start text, so we can safely do this without fucking with anything else
--This is so that SCP-049-2 and SCP-610-B can see role info
net.Receive( "RolesSelected", function()
    ROUND_START_TIME = CurTime()
end)

local function OVERRIDE(ply)
    if ply:Team() == TEAM_CHAOS and ply:GetNClass() != ROLE_RES then
        return "you are a member of the"
    elseif ply:GetNClass() == ROLE_SERPENT then
        return "you are a"
    end
end

function DrawRoleInfo()
    local nc = LocalPlayer():GetNClass()
    local p = (math.Clamp(CurTime() - ROUND_START_TIME, 0, 3)) / 3
    local rt
    if GetGlobalString("round_type", "normal") == "normal" then
        rt = normalround
    elseif ROUNDS[GetGlobalString("round_type", "normal")] then
        rt = ROUNDS[GetGlobalString("round_type", "normal")]
    end
    --Figure out what article we need to use for an SCP

    --We can override the first sentence in the function above
    local o
    o = OVERRIDE(LocalPlayer())
    if not o then
        o = "you are"
    end

    --Allow overriding the actual name based on the round
    if rt.override_role_names and rt.override_role_names[LocalPlayer():GetNClass()] then
        nc = rt.override_role_names[LocalPlayer():GetNClass()]
    end

    local desc
    --Allow overriding the text based on round type
    if rt.override_role_desc and rt.override_role_desc[LocalPlayer():GetNClass()] then
        desc = rt.override_role_desc[LocalPlayer():GetNClass()]
    else
        desc = clang.starttexts[Getrl(LocalPlayer():GetNClass())] or {
            "Error",
            {
                "Cannot find index " .. Getrl(LocalPlayer():GetNClass()),
                "in the starttext table",
                "please screenshot this and send it to Aurora"
            }
        }
    end

    --Draw
    local tcolor = team.GetColor(LocalPlayer():Team())
    if LocalPlayer():Team() == TEAM_CHAOS then
        tcolor = Color(29, 81, 56)
        nc = "Chaos Insurgency"
    end
    surface.SetFont("BR_RoleName_Smaller")
    local ts1, ts2 = surface.GetTextSize(string.upper(o))
    surface.SetFont("BR_RoleName_New")
    local ts3, ts4 = surface.GetTextSize(string.upper(nc))
    local x1 = (ScrW() / 2) - (ts3 / 2)
    local y1 = (ScrH() / 2) - (ts4 / 2)
    local x2 = (ScrW() / 2) - (ts1 / 2)
    local y2 = (y1 - 50) - (ts2 / 2)

    draw.TextShadow( {
        text = string.upper(o),
        pos = { x2, y2 - 200},
        font = "BR_RoleName_Smaller",
        color = Color(255 * p, 255 * p, 255 * p, 255 * p),
        xalign =  TEXT_ALIGN_LEFT ,
        yalign =  TEXT_ALIGN_LEFT ,
    }, 2, 255 )

    draw.TextShadow( {
        text = string.upper(nc),
        pos = { x1, y1 - 200 },
        font = "BR_RoleName_New",
        color = Color(tcolor.r * p, tcolor.g * p, tcolor.b * p, tcolor.a * p),
        xalign =  TEXT_ALIGN_LEFT ,
        yalign =  TEXT_ALIGN_LEFT ,
    }, 2, 255 )

    local itxt = (ScrH() / 2) + 100

    for i,txt in ipairs(desc[2]) do
        surface.SetFont("BR_RoleDetails")
        local tsv, tsw = surface.GetTextSize(txt)
        local x8 = (ScrW() / 2) - (tsv / 2)
        draw.TextShadow( {
            text = txt,
            pos = { x8, (itxt + ((i - 1) * (tsw + 5))) - 200},
            font = "BR_RoleDetails",
            color = Color(255 * p, 255 * p, 255 * p, 255 * p),
            xalign =  TEXT_ALIGN_LEFT,
            yalign =  TEXT_ALIGN_LEFT,
        }, 2, 255 )
    end
end


--Screenspace effects

SHOULD_DRAW_MOTION_BLUR = false

function GM:DrawDeathNotice( x,  y ) end

function GM:RenderScreenspaceEffects()
    if SHOULD_DRAW_MOTION_BLUR then
        DrawMotionBlur( 0.4, 0.8, 0.01 )
    elseif SHOULD_DRAW_MOTION_BLUR2 then
        DrawMotionBlur(0.5, 1, 0.19)
    end
end

function PLAYER_GET_DRUNK_LOL()
    SHOULD_DRAW_MOTION_BLUR = true
    local ti = net.ReadInt(8)
    timer.Simple(ti, function ()
        SHOULD_DRAW_MOTION_BLUR = false
    end)
end
net.Receive("BREACH_294_DRUNK", PLAYER_GET_DRUNK_LOL)


function PLAYER_GET_DRUNK_LOL2()
    SHOULD_DRAW_MOTION_BLUR2 = true
    local ti = net.ReadInt(8)
    timer.Simple(ti, function ()
        SHOULD_DRAW_MOTION_BLUR2 = false
    end)
end
net.Receive("BREACH_294_DRUNK2", PLAYER_GET_DRUNK_LOL2)

--Winner announcement / Round Infos

local DrawWinnersUntil = -999
local WINNER = -1
local WINNERS = -1
local scpm = ""
local cdm = ""
local cedm = ""
local gdm = ""
local fdm = ""


local SCP_WIN_MSG = {
    "*Crunching noises*",
    "I am the cure.",
    "You do not recognize the bodies in the water.",
    "CLASS-D EXPENDABLE, FEED THEM TO THE SCPS",
	"Five Five Five Five",
	"Ethical felines are to be detained. Leave their faces in containment chamber",
	"LISTEN… LISTEN! COME IN! COME IN… COME IN…"
}

local CD_WIN_MSG = {
    "Wow.",
    "You know too much to let them get you. You're coming with us.",
    "And now, the blade out of their reach, the blade silently strikes its old wielder.",
    "The Foundation will crumble on its corrupt and rotten foundation.",
    "The needs of the many make null and void the survival of the few.",
	"A phone is ringing...",
	"The greatest mistake was believing you had a choice at all."
}

local SCI_WIN_MSG = {
    "Without morals, are we truly any better than the things we've set ourselves to contain?",
    "You've done horrible, awful things while working for the Foundation - don't try to deny it, Doctor.",
    "If the Foundation expects me to keep working like this, they’ll have to start paying me a lot more than they do.",
    "Your actions have been, by your own admission, unethical.",
    "You want happy endings? Fuck you.",
    "We die in the dark so that you can live in the light.",
	"Old swords resharpened for battles to come"
}

local CLASSE_WIN_MSG = {
    "Here, have a snickers. You're not you when you're hungry... or under the influence of a meme.",
	"[insertnamehere], wins again!",
	"Well that was easy.",
	"Sure hope they don't remove me again..",
	"Oh man my tum tum has a rum rum.",
	"See ya suckers I've escaped with the script to the Rollnaway x Carthing fanfiction!"
}

local GOC_WIN_MSG = {
    "Placeholder"
}

hook.Add("BreachWinnerDeclared", "BreachWinnerDeclared_HUD", function (winner, nr, winners)
    DrawWinnersUntil = nr
    WINNER = winner
    WINNERS = winners
    scpm = SCP_WIN_MSG[math.random(1, table.Count(SCP_WIN_MSG))]
    fdm = SCI_WIN_MSG[math.random(1, table.Count(SCI_WIN_MSG))]
    cdm = CD_WIN_MSG[math.random(1, table.Count(CD_WIN_MSG))]
    gdm = GOC_WIN_MSG[math.random(1, table.Count(GOC_WIN_MSG))]
    cedm = CLASSE_WIN_MSG[math.random(1, table.Count(CLASSE_WIN_MSG))]
    SlowFadeBlink(5)
end)

net.Receive("EClassBlink", function ()
    SlowFadeBlink(5)
end)

function DrawRoundResult()

    local t1, t2, color
    if WINNER == TEAM_SCP then
        t1 = "The SCP Objects Win"
        t2 = scpm
        color = team.GetColor(TEAM_SCP)
    elseif WINNER == TEAM_CLASSD then
        t1 = "The D Class Win"
        t2 = cdm
        color = team.GetColor(TEAM_CLASSD)
    elseif WINNER == TEAM_CHAOS then
        t1 = "The Chaos Insurgency Wins"
        t2 = cdm
        color = Color(29, 81, 56)
    elseif WINNER == TEAM_SCI or WINNER == TEAM_GUARD then
        t1 = "The Foundation Wins"
        t2 = fdm
        color = team.GetColor(TEAM_SCI)
    elseif WINNER == TEAM_CLASSE then
        t1 = "The Class E Win"
        t2 = cedm
        color = team.GetColor(TEAM_CLASSE)
    elseif WINNER == TEAM_GOC then
        t1 = "The GOC Wins"
        t2 = gdm
        color = Color(0,0,255)
    elseif WINNER == TEAM_SPEC then
        t1 = "Stalemate!"
        t2 = "You're all losers!"
        color = Color(169, 169, 169)
    else
        t1 = "Unexpected Value"
        t2 = "I'll do better next time, I promise!"
        color = Color(255, 0, 0)
    end
    surface.SetFont("BR_Winners")
    local t1w, t1h = surface.GetTextSize(t1)
    surface.SetFont("BR_Winners_Small")
    local t2w, _ = surface.GetTextSize(t2)
    draw.TextShadow( {
            text = t1,
            pos = { (ScrW() / 2) - (t1w / 2) ,(ScrH() / 2) - (t1h / 2)},
            font = "BR_Winners",
            color = color,
            xalign =  TEXT_ALIGN_LEFT,
            yalign =  TEXT_ALIGN_LEFT,
     }, 2, 255 )
     draw.TextShadow( {
            text = t2,
            pos = { (ScrW() / 2) - (t2w / 2), (ScrH() / 2) + t1h},
            font = "BR_Winners_Small",
            color = Color(255, 255, 255),
            xalign =  TEXT_ALIGN_LEFT,
            yalign =  TEXT_ALIGN_LEFT,
    }, 2, 255 )
end

--Escape Info

local DrawEscapeUntil = -999
local DrawEscapeType = -1
ESCAPE_TIME = -1

hook.Add("BreachLocalplayerEscaped", "BreachLocalplayerEscaped_HUD", function (escape_type, t)
    DrawEscapeUntil = CurTime() + 10
    DrawEscapeType = escape_type
    ESCAPE_TIME = t
end)

function DrawEscapeInfo()
    if DrawEscapeType == -1 or DrawEscapeUntil == -999 then return end
    local t1, t2, color
    local t = string.ToMinutesSecondsMilliseconds(ESCAPE_TIME)
    if DrawEscapeType == 1 or DrawEscapeType == 2 or DrawEscapeType == 4 then
        t1 = "You Escaped."
        t2 = "It's like 10 feet and it took you " .. tostring(t) .. "? You should work out more."
    elseif DrawEscapeType == 3 then
        t1 = "You were escorted."
        t2 = "Your sorry ass was saved in " .. t
    elseif DrawEscapeType == 5 or DrawEscapeType == 6 then
        t1 = "You Deserted."
        t2 = "Either that or you were trying to camp the exit."
    else
        t1 = "You found a feature."
        t2 = "There are no bugs in breach, only features."
    end

    if DrawEscapeType == 4 or DrawEscapeType < 1 or DrawEscapeType > 6 then
        color = team.GetColor(TEAM_SCP)
    elseif DrawEscapeType == 1 then
        color = team.GetColor(TEAM_SCI)
    elseif DrawEscapeType == 2 then
        color = team.GetColor(TEAM_CLASSD)
    elseif DrawEscapeType == 3 then
        color = team.GetColor(TEAM_SPEC)
    elseif DrawEscapeType == 5 then
        color = team.GetColor(TEAM_GUARD)
    elseif DrawEscapeType == 6 then
        color = Color(29, 81, 56)
    else
        color = Color(255, 255, 255)
    end

    surface.SetFont("BR_Winners")
    local t1w, t1h = surface.GetTextSize(t1)
    surface.SetFont("BR_Winners_Small2")
    local t2w, _ = surface.GetTextSize(t2)
    draw.TextShadow( {
            text = t1,
            pos = { (ScrW() / 2) - (t1w / 2) ,(ScrH() / 2) - (t1h / 2)},
            font = "BR_Winners",
            color = color,
            xalign =  TEXT_ALIGN_LEFT,
            yalign =  TEXT_ALIGN_LEFT,
     }, 2, 255 )
     draw.TextShadow( {
            text = t2,
            pos = { (ScrW() / 2) - (t2w / 2), (ScrH() / 2) + t1h},
            font = "BR_Winners_Small",
            color = Color(255, 255, 255),
            xalign =  TEXT_ALIGN_LEFT,
            yalign =  TEXT_ALIGN_LEFT,
    }, 2, 255 )
end

function DrawRoundName()
    local t = ROUNDS[GetGlobalString("round_type", "tdm")].name or "Containment Breach"
    surface.SetFont("BR_Winners_Small2")
    local t1w, t1h = surface.GetTextSize(t)
    draw.TextShadow( {
        text = t,
        pos = { (ScrW() / 2) - (t1w / 2), (ScrH()) - t1h - 5},
        font = "BR_Winners_Small2",
        color = Color(255, 255, 255),
        xalign =  TEXT_ALIGN_LEFT,
        yalign =  TEXT_ALIGN_LEFT,
    }, 2, 255 )
end

--General

hook.Add("HUDPaint", "DrawBreachHUD", function ()
    if draw_hud:GetBool() then
        if draw_crosshair:GetBool() then
            DrawCrosshair()
        end

        DrawPrimaryHUD()

        if draw_roleinfo:GetBool() and CurTime() - ROUND_START_TIME <= 20 then
            DrawRoleInfo()
        end

        if postround and DrawWinnersUntil > CurTime() and WINNER != -1 and WINNERS != -1 then
            DrawRoundResult()
        elseif DrawEscapeUntil > CurTime() and DrawEscapeType != -1 then
            DrawEscapeInfo()
        end

        if GetGlobalString("round_type", "normal") != "normal" and ROUNDS[GetGlobalString("round_type", "tdm")] then
            DrawRoundName()
        end

        MSTACK:Draw(LocalPlayer())
    end
end)