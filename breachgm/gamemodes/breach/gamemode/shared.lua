// Shared file

GM.Name 	= "Breach"
GM.Author 	= "Kanade"
GM.Email 	= ""
GM.Website 	= ""

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

WEAPON_HOLSTER = 1
WEAPON_KEYCARD = 2
WEAPON_MELEE = 3
WEAPON_SNAV = 4
WEAPON_SIDEARM = 5
WEAPON_GUN = 6
WEAPON_RADIO = 7
WEAPON_MEDICAL = 8
WEAPON_NVG = 9
WEAPON_NADE = 10
WEAPON_OTHER = 11
WEAPON_SCP = 12
WEAPON_DM = 13

SH_POSTROUND = false
TEAM_SCP = 1
TEAM_GUARD = 2
TEAM_CLASSD = 3
TEAM_SPEC = 4
TEAM_SCI = 5
TEAM_CHAOS = 6
TEAM_CLASSE = 7
TEAM_GOC = 8

MINPLAYERS = 2

--Enums for the round status
ROUND_WAITING = 0
ROUND_PREPARING = 1
ROUND_IN_PROGRESS = 2
ROUND_POSTROUND = 3

--Enums used by the end screen

ROUND_TYPE_NORMAL = 0
ROUND_TYPE_ASSAULT = 1

// Team setup
team.SetUp( TEAM_SCP, "SCPs", Color(237, 28, 63) )
team.SetUp( TEAM_GUARD, "MTF Guards", Color(0, 100, 255) )
team.SetUp( TEAM_CLASSD, "Class Ds", Color(255, 130, 0) )
team.SetUp( TEAM_CLASSE, "Class Es", Color(112, 17, 112) )
team.SetUp(TEAM_GOC, "Global Occult Coalition", Color(0, 0, 255))
team.SetUp( TEAM_SPEC, "Spectators", Color(141, 186, 160) )
team.SetUp( TEAM_SCI, "Scientists", Color(66, 188, 244) )
team.SetUp( TEAM_CHAOS, "Chaos Insurgency", Color(0, 100, 255) )

--This is pretty bad, but i'll keep doing it because it will break some of kanade's shit probably if i dont
function GetLangRole(rl)
	if clang == nil then return rl end
	if rl == ROLE_SCP173 then return clang.ROLE_SCP173 end
	if rl == ROLE_SCP106 then return clang.ROLE_SCP106 end
	if rl == ROLE_SCP049 then return clang.ROLE_SCP049 end
	if rl == ROLE_SCP457 then return clang.ROLE_SCP457 end
	if rl == ROLE_SCP0492 then return clang.ROLE_SCP0492 end
	if rl == ROLE_MTFGUARD then return "Tactical Response Officer" end
	if rl == ROLE_MTFCOM then return "TRO Commander" end
	if rl == ROLE_MTFNTF then return clang.ROLE_MTFNTF end
	if rl == ROLE_CHAOS then return clang.ROLE_CHAOS end
	if rl == ROLE_CLASSD then return clang.ROLE_CLASSD end
	if rl == ROLE_RES then return clang.ROLE_RES end
	if rl == ROLE_SPEC then return clang.ROLE_SPEC end
	if rl == ROLE_SCP096 then return "SCP-096" end
	if rl == ROLE_SCP682 then return "SCP-682" end
	if rl == ROLE_SCP1048A then return "SCP-1048-A" end
	if rl == ROLE_SCP035 then return "SCP-035" end
	if rl == ROLE_SCP066 then return "SCP-066" end
	if rl == ROLE_SCP966 then return "SCP-966" end
	if rl == ROLE_MTFRRH then return "MTF Red Right hand" end
	if rl == ROLE_SCP939 then return "SCP-939" end
	if rl == ROLE_SCP0762 then return "SCP-076-02" end
	if rl == ROLE_999 then return "SCP-999" end
	if rl == ROLE_05 then return "05 Command" end
	if rl == ROLE_1048 then return "SCP-1048" end
	if rl == ROLE_178 then return "SCP-178-1" end
	if rl == ROLE_SCP1048B then return "SCP-1048-B" end
	if rl == ROLE_SCP017 then return "SCP-017" end
	if rl == ROLE_2639A then return "SCP-2639-A" end
	if rl == ROLE_SCP079 then return "SCP-079" end
	if rl == ROLE_SCP372 then return "SCP-372" end
	if rl == ROLE_SCP082 then return "SCP-082" end
	if rl == ROLE_SCP0762PB then return "SCP-073" end
	if rl == ROLE_MTFFB then return "MTF Epsilon-9" end
	if rl == ROLE_DRCLEF then return "Doctor Clef" end
	if rl == ROLE_MTFL2 then return "MTF Lambda-2" end
	if rl == ROLE_SCP1471 then return "SCP-1471" end
	if rl == ROLE_SERPENT then return "Serpent's Hand Member" end
	if rl == ROLE_SCP2521 then return "SCP-2521" end
	if rl == ROLE_SPCGUARD then return "SPC Guard" end
	if rl == ROLE_SCLASS then return "S Class" end
	if rl == ROLE_SCP610 then return "SCP-610" end
	if rl == ROLE_SCP610B then return "SCP-610-B" end
	if rl == ROLE_MTFNU then return "MTF Nu-7" end
	if rl == ROLE_MTFGUARDSNIPER then return "Tactical Response Sniper" end
	if rl == ROLE_MTFGUARDHEAVY then return "Tactical Response Heavy" end
	if rl == ROLE_MTFGUARDPYRO then return "Tactical Response Pyro" end
	if rl == ROLE_MTFGUARDMEDIC then return "Tactical Response Medic" end
	if rl == ROLE_212 then return "SCP-212-5" end
	if rl == ROLE_REDACTED then return "[REDACTED]" end
	if rl == ROLE_SCP2845 then return "SCP-2845" end
	if rl == ROLE_SCP334 then return "SCP-334" end
	if rl == ROLE_SCP795 then return "SCP-795" end
	if rl == ROLE_SCP689 then return "SCP-689" end
	if rl == ROLE_TAU5 then return "MTF Tau-5" end
	if rl == ROLE_SCP323 then return "SCP-323" end
	if rl == ROLE_CLASSE then return "Class E Personnel" end
	if rl == ROLE_SCP079 then return "SCP-079" end
	if rl == ROLE_SCP011 then return "SCP-011" end
	if rl == ROLE_SCP3331 then return "SCP-3331" end
	if rl == ROLE_SCP160 then return "SCP-160" end
	if rl == ROLE_SCP020 then return "SCP-020" end
	if rl == ROLE_SCP607 then return "SCP-607" end
	if rl == ROLE_SCP1959 then return "SCP-1959" end
	if rl == ROLE_O51 then return "O5-1" end
	if rl == ROLE_UNI then return "Union Soldier" end
	if rl == ROLE_CONF then return "Confederate Soldier" end
	if rl == ROLE_NOBODY then return "" end
	if rl == ROLE_SCP3199 then return "SCP-3199" end
	if rl == ROLE_SCP3199B then return "SCP-3199-A" end
	if rl == ROLE_MTFSIG then return "MTF Sigma-66" end
	if rl == ROLE_AWCY then return "Are We Cool Yet?" end
	if rl == ROLE_SCP2953 then return "SCP-2953" end
	if rl == ROLE_RANDOM then return "Randy Rando" end
	if rl == ROLE_DRBRIGHT then return "Dr. Bright" end
	if rl == ROLE_SCP4715 then return "SCP-4715" end
	if rl == ROLE_SCPWW then return "Writer on the Walls" end
	if rl == ROLE_SCP1048C then return "SCP-1048-C" end
	if rl == ROLE_SCP1048BR then return "SCP-1048-[REDACTED]" end
	if rl == ROLE_SCP990 then return "SCP-990" end
	if rl == ROLE_PLAYER1 then return "Shadow Catcher" end
	if rl == ROLE_PLAYER2 then return "The Hunter" end
	if rl == ROLE_PLAYER3 then return "Freeman" end
	if rl == ROLE_SCP1315A then return "Dark Shadow" end
	if rl == ROLE_SCP1315B then return "Crazed Beast" end
	if rl == ROLE_SCP1315C then return "Metro Cop" end
	if rl == ROLE_SCP038A then return "SCP-038-A" end
	if rl == ROLE_SCP1360 then return "SCP-1360" end
	if rl == ROLE_LH then return "MTF Alpha-9" end
	if rl == ROLE_SCP1861B then return "SCP-1861-B" end
	if rl == ROLE_CLASSD9341 then return "D-9341" end
	if rl == ROLE_CLASSD11424 then return "D-11424" end
	if rl == ROLE_SCP181 then return "SCP-181" end
	if rl == ROLE_SCP2301 then return "SCP-2301" end
	if rl == ROLE_MTFGUARD2301 then return "Containment Team Alpha" end
	if rl == ROLE_MTFGUARDENG then return "Tactical Response Engineer" end
	if rl == ROLE_SCP817 then return "SCP-817" end
	if rl == ROLE_SCP2953UP then return "Protogen" end
	if rl == ROLE_SCP427 then return "Flesh Beast" end
	if rl == ROLE_SCP2953D then return "SCP-2953-D" end
	if rl == ROLE_SCP2953C then return "SCP-2953-C" end
	if rl == ROLE_SCP2953L then return "SCP-2953-L" end
	if rl == ROLE_SCP2953M then return "SCP-2953-M" end
	if rl == ROLE_SCP2953G then return "SCP-2953-G" end
	if rl == ROLE_SCP010 then return "SCP-010-A" end
	return rl
end

--
ROLE_MTFGUARDSNIPER = "Tactical Response Sniper"
ROLE_MTFGUARDHEAVY = "Tactical Response Heavy"
ROLE_MTFGUARDPYRO = "Tactical Response Pyro"
ROLE_212 = "SCP-212-5"
ROLE_SCP173 = "SCP-173"
ROLE_SCP106 = "SCP-106"
ROLE_SCP049 = "SCP-049"
ROLE_SCP457 = "SCP-457"
ROLE_SCP0492 = "SCP-049-2"
ROLE_SCP0082 = "SCP-008-2"
ROLE_MTFGUARD = "Tactical Response Officer"
ROLE_MTFCOM = "TRO Commander"
ROLE_MTFNTF = "MTF Nine Tailed Fox"
ROLE_CHAOS = "Chaos Insurgency"
ROLE_CHAOSCOM = "CI Special Forces"
ROLE_SITEDIRECTOR = "Site Director"
ROLE_CLASSD = "Class D Personnel"
ROLE_RES = "Researcher"
ROLE_SPEC = "Spectator"
ROLE_SCP096 = "SCP-096"
ROLE_SCP682 = "SCP-682"
ROLE_SCP1048A = "SCP-1048-A"
ROLE_SCP035 = "SCP-035"
ROLE_SCP066 = "SCP-066"
ROLE_SCP966 = "SCP-966"
ROLE_SCP939 = "SCP-939"
ROLE_MTFRRH = "MTF Red Right Hand"
ROLE_SCP0762 = "SCP-076-02"
ROLE_999 = "SCP-999"
ROLE_05 = "05 Command"
ROLE_1048 = "SCP-1048"
ROLE_178 = "SCP-178-1"
ROLE_SCP1048B = "SCP-1048-B"
ROLE_SCP017 = "SCP-017"
ROLE_2639A = "SCP-2639-A"
ROLE_SCP079 = "SCP-079"
ROLE_SCP372 = "SCP-372"
ROLE_SCP082 = "SCP-082"
ROLE_SCP0762PB = "SCP-073"
ROLE_MTFFB = "MTF Epsilon-9"
ROLE_DRCLEF = "Doctor Clef"
ROLE_MTFL2 = "MTF Lambda-2"
ROLE_SCP1471 = "SCP-1471"
ROLE_SERPENT = "Serpent's Hand Member"
ROLE_SCP2521 = "SCP-2521"
ROLE_SPCGUARD = "SPC Guard"
ROLE_SCLASS = "S Class"
ROLE_SCP610 = "SCP-610"
ROLE_SCP610B = "SCP-610-B"
ROLE_MTFNU = "MTF Nu-7"
ROLE_REDACTED = "[REDACTED]"
ROLE_MTFGUARDMEDIC = "Tactical Response Medic"
ROLE_SCP2845 = "SCP-2845"
ROLE_SCP334 = "SCP-334"
ROLE_SCP795 = "SCP-795"
ROLE_SCP689 = "SCP-689"
ROLE_TAU5 = "MTF Tau-5"
ROLE_SCP323 = "SCP-323"
ROLE_CLASSE = "Class E Personnel"
ROLE_SCP079 = "SCP-079"
ROLE_SCP011 = "SCP-011"
ROLE_SCP3331 = "SCP-3331"
ROLE_SCP160 = "SCP-160"
ROLE_SCP020 = "SCP-020"
ROLE_SCP607 = "SCP-607"
ROLE_SCP1959 = "SCP-1959"
ROLE_O51 = "O5-1"
ROLE_UNI = "Union Soldier"
ROLE_CONF = "Confederate Soldier"
ROLE_NOBODY = ""
ROLE_SCP3199 = "SCP-3199"
ROLE_SCP3199B = "SCP-3199-A"
ROLE_MTFSIG = "MTF Sigma-66"
ROLE_AWCY = "Are We Cool Yet?"
ROLE_SCP2953 = "SCP-2953"
ROLE_RANDOM = "Randy Rando"
ROLE_DRBRIGHT = "Dr. Bright"
ROLE_SCP4715 = "SCP-4715"
ROLE_SCPWW = "Writer on the Walls"
ROLE_SCP1048C = "SCP-1048-C"
ROLE_SCP1048BR = "SCP-1048-[REDACTED]"
ROLE_SCP990 = "SCP-990"
ROLE_PLAYER1 = "Shadow Catcher"
ROLE_PLAYER2 = "The Hunter"
ROLE_PLAYER3 = "Freeman"
ROLE_SCP1315A = "Dark Shadow"
ROLE_SCP1315B = "Crazed Beast"
ROLE_SCP1315C = "Metro Cop"
ROLE_SCP038A = "SCP-038-A"
ROLE_SCP1360 = "SCP-1360"
ROLE_LH = "MTF Alpha-9"
ROLE_SCP1861B = "SCP-1861-B"
ROLE_CLASSD9341 = "D-9341"
ROLE_CLASSD11424 = "D-11424"
ROLE_SCP181 = "SCP-181"
ROLE_SCP2301 = "SCP-2301"
ROLE_MTFGUARD2301 = "Containment Team Alpha"
ROLE_MTFGUARDENG = "Tactical Response Engineer"
ROLE_SCP817 = "SCP-817"
ROLE_SCP2953UP = "Protogen"
ROLE_SCP427 = "Flesh Beast"
ROLE_SCP2953D = "SCP-2953-D"
ROLE_SCP2953C = "SCP-2953-C"
ROLE_SCP2953L = "SCP-2953-L"
ROLE_SCP2953M = "SCP-2953-M"
ROLE_SCP2953G = "SCP-2953-G"
ROLE_SCP010 = "SCP-010-A"
if !ConVarExists("br_roundrestart") then CreateConVar( "br_roundrestart", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Restart the round" ) end
if !ConVarExists("br_time_preparing") then CreateConVar( "br_time_preparing", "60", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Set preparing time" ) end
if !ConVarExists("br_time_round") then CreateConVar( "br_time_round", "780", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Set round time" ) end
if !ConVarExists("br_time_postround") then CreateConVar( "br_time_postround", "30", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Set postround time" ) end
if !ConVarExists("br_time_gateopen") then CreateConVar( "br_time_gateopen", "480", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Set gate open time" ) end
if !ConVarExists("br_time_ntfenter") then CreateConVar( "br_time_ntfenter", "300", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Time that NTF units will enter the facility" ) end
if !ConVarExists("br_time_blink") then CreateConVar( "br_time_blink", "0.25", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Blink timer" ) end
if !ConVarExists("br_time_blinkdelay") then CreateConVar( "br_time_blinkdelay", "5", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Delay between blinks" ) end
if !ConVarExists("br_opengatea_enabled") then CreateConVar( "br_opengatea_enabled", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Do you want to force opening gate A after x seconds?" ) end
if !ConVarExists("br_spawn_level4") then CreateConVar( "br_spawn_level4", "2", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "How many keycards level 4 you want to spawn?" ) end
if !ConVarExists("br_specialround_percentage") then CreateConVar( "br_specialround_percentage", "10", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Set percentage of special rounds" ) end
if !ConVarExists("br_specialround_forcenext") then CreateConVar( "br_specialround_forcenext", "none", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Force the next round to be a special round" ) end
if !ConVarExists("br_spawnzombies") then CreateConVar( "br_spawnzombies", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Do you want zombies?" ) end
if !ConVarExists("br_karma") then CreateConVar( "br_karma", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Do you want to enable karma system?" ) end
if !ConVarExists("br_karma_max") then CreateConVar( "br_karma_max", "1200", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Max karma" ) end
if !ConVarExists("br_karma_starting") then CreateConVar( "br_karma_starting", "1000", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Starting karma" ) end
if !ConVarExists("br_karma_save") then CreateConVar( "br_karma_save", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Do you want to save the karma?" ) end
if !ConVarExists("br_karma_round") then CreateConVar( "br_karma_round", "100", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "How much karma to add after a round" ) end
if !ConVarExists("br_karma_reduce") then CreateConVar( "br_karma_reduce", "15", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "How much karma to reduce after damaging someone" ) end
if !ConVarExists("br_karma_test") then CreateConVar( "br_karma_test", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Do you want to enable test karma system?" ) end
if !ConVarExists("br_karma_max_test") then CreateConVar( "br_karma_max_test", "1100", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Max karma for the test system" ) end
if !ConVarExists("br_karma_starting_test") then CreateConVar( "br_karma_starting_test", "1000", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Starting karma (test)" ) end
if !ConVarExists("br_karma_save_test") then CreateConVar( "br_karma_save_test", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Do you want to save the karma? (test)" ) end
if !ConVarExists("br_karma_baseheal_test") then CreateConVar( "br_karma_baseheal_test", "5", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "How much karma to heal after a round(base, additional healing for clean rounds, test)" ) end
if !ConVarExists("br_karma_killpen_test") then CreateConVar( "br_karma_killpen_test", "15", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "How much karma should be penalized for a kill? (TEST)" ) end
if !ConVarExists("br_karma_ratio_test") then CreateConVar("br_karma_ratio_test", "0.001", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "The ratio of the damage that is used to compute how much of the victim's karma is subtracted from the attacker's") end
if !ConVarExists("br_karma_clean_bonus") then CreateConVar( "br_karma_clean_bonus", "30", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Karma bonus for playing clean rounds" ) end
if !ConVarExists("br_karma_nordm_dmg_ratio") then CreateConVar( "br_karma_nordm_dmg_ratio", "0.0003", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Like br_karma_ratio, but for the karma reward for damaging someone you're supposed to damage. " ) end
if !ConVarExists("br_karma_nordm_kill") then CreateConVar( "br_karma_nordm_kill", "40", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Bonus for killing someone you're supposed to kill " ) end
if !ConVarExists("br_karma_ban") then CreateConVar( "br_karma_ban", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Enable karma bans " ) end
if !ConVarExists("br_karma_ban_time") then CreateConVar( "br_karma_ban_time", "1440", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "How long should karma bans be?" ) end
if !ConVarExists("br_scoreboardranks") then CreateConVar( "br_scoreboardranks", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "" ) end
if !ConVarExists("br_defaultlanguage") then CreateConVar( "br_defaultlanguage", "english", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "" ) end
if !ConVarExists("br_friendlyfire") then CreateConVar( "br_friendlyfire", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "" ) end
--if !ConVarExists("br_tfagunspawns") then CreateConVar( "br_tfagunspawns", "0", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "" ) end
FRIENDLY_FIRE_STATUS = GetConVar("br_friendlyfire")

if game.GetMap() == "gm_site19_v6" then
	--include("sh_079.lua")
end

function KarmaReduce()
	return GetConVar("br_karma_reduce"):GetInt()
end

function KarmaRound()
	return GetConVar("br_karma_round"):GetInt()
end

function SaveKarma()
	return GetConVar("br_karma_save"):GetInt()
end

function MaxKarma()
	return GetConVar("br_karma_max"):GetInt()
end

function StartingKarma()
	return GetConVar("br_karma_starting"):GetInt()
end

function KarmaEnabled()
	return GetConVar("br_karma"):GetBool()
end

function GetPrepTime()
	return GetConVar("br_time_preparing"):GetInt()
end

function GetRoundTime()
	return GetConVar("br_time_round"):GetInt()
end

function GetPostTime()
	return GetConVar("br_time_postround"):GetInt()
end

function GetGateOpenTime()
	return GetConVar("br_time_gateopen"):GetInt()
end

function GetNTFEnterTime()
	return 300 --HARD CODE
end

function GetDreamEnterTime()
	return 120 --HARD CODE
end

function GetTreeEnterTime()
	return 30 --HARD CODE
end

function IsTFAGun()
	return BR_TFA_GUNS_ENABLED
end

function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf )
	if not ply.GetNClass then
		player_manager.RunClass( ply, "SetupDataTables" )
	end
	if not ply.GetNClass then return end
	if ply:GetNClass() == ROLE_SCP173 then
		if ply.steps == nil then ply.steps = 0 end
		ply.steps = ply.steps + 1
		if ply.steps > 6 then
			ply.steps = 1
			if SERVER then
				ply:EmitSound( "173sound"..math.random(1,3)..".ogg", 300, 100, 1 )
			end
		end
		return true
	end
	return false
end

function Is457InRound()
	for k,v in pairs(player.GetAll()) do
		if v.GetNClass and v:GetNClass() == ROLE_SCP457 then return true end
	end
	return false
end

function GM:EntityTakeDamage( target, dmginfo )

	if preparing then
		return true
	end
	local at = dmginfo:GetAttacker()
	if IsValid(at) and at:IsPlayer() and at.Team and at:Team() == TEAM_SCP and dmginfo:GetDamage() < 100 and (IsValid(target) and target:IsPlayer() and target.GetNClass and target:GetNClass() == ROLE_999) then
		dmginfo:ScaleDamage(13)
	end
	local att = dmginfo:GetAttacker()
	local inf
	if att and IsValid(att) and att:IsPlayer() then
		inf = att:GetActiveWeapon()
	end
	if IsValid(inf) and inf:GetClass() == "tfa_kf2rr_flamethrower" and IsValid(target) and target.GetNClass and target:GetNClass() == ROLE_SCP457 then
		return true
	end
	if target and IsValid(target) and target:IsPlayer() and target:GetNClass() == ROLE_SCP0762PB and math.random(1,3) == 3 and att and IsValid(att) and att:IsPlayer() then
		att:TakeDamage(math.Clamp(dmginfo:GetDamage(), 0, 200))
		return true
	end
	if at:IsNPC() then
		if at:GetClass() == "npc_fastzombie" then
			dmginfo:ScaleDamage( 4 )
		end
	elseif target:IsPlayer() then
		if target.GetNClass and target:GetNClass() == ROLE_SCP939 and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker():Team() != TEAM_SPEC and dmginfo:GetAttacker():Team() != TEAM_SCP and SERVER and target:HasWeapon("scp939") and target:GetWeapon("scp939"):GetNWBool("IsDisguised", true) then
			target:SetModel(SCP_939_MODEL)
			if target:HasWeapon("scp939") then
				target:GetWeapon("scp939"):SetNWBool("IsDisguised", false)
			end
			target:PrintMessage(4, "You have been exposed!")
			if IsValid(at) and at:IsPlayer() and at:Team() != TEAM_SPEC and at:Team() != TEAM_SCP then
				hook.Run("PlayerRevealSCP939", at)
			end
			if target:GetNClass() == ROLE_SPCGUARD and at:GetNClass() == ROLE_SPCGUARD then
				return true
			elseif target:GetNClass() == ROLE_SCLASS and at:GetNClass() == ROLE_SCLASS then
				return true
			end
		end
		if target:Alive() then
			local dmgtype = dmginfo:GetDamageType()
			if dmgtype == 268435464 or dmgtype == 8 then
				if target:Team() == TEAM_SCP and Is457InRound() then
					dmginfo:SetDamage( 0 )
					return true
				elseif target.UsingArmor == "armor_fireproof" then
					dmginfo:ScaleDamage(0.75)
				end
			end
		end
	end
end
--TEST
function FuckingGracePeriod(tar, dmg)
	if preparing then
		return true
	end
end
hook.Add("EntityTakeDamage", "BreachGracePeriod", FuckingGracePeriod)
--END

hook.Add("EntityTakeDamage", "BreachPreventRDM", function (target, dmg)
	if IsValid(target) and target:IsPlayer() and BR_PREVENT_RDM then
		local at = dmg:GetAttacker()
		--If a player's damage is blocked, then it will return here
		if IsValid(at) and at:IsPlayer() then
			if (at.GetNClass and at:GetNClass() == ROLE_2639A and target:Team() != TEAM_SCP) or (target.GetNClass and target:GetNClass() == ROLE_2639A and at:Team() != TEAM_SCP)  then
				return true
			end
			if target.GetNClass and target:GetNClass() == ROLE_999 then
				//Let damage go through
			elseif at:Team() == TEAM_CLASSD and target:Team() == TEAM_CLASSD then
				return true
			elseif at:Team() == TEAM_SCI and target:Team() == TEAM_SCI then
				return true
			elseif at:Team() == TEAM_CHAOS and target:Team() == TEAM_CHAOS then
				return true
			elseif (at:Team() == TEAM_CLASSD and target.GetNClass and target:GetNClass() == ROLE_SCP035 and roundtype and roundtype.name and roundtype.name != "Multiple breaches") or (at.GetNClass and at:GetNClass() == ROLE_SCP035 and target:Team() == TEAM_CLASSD and roundtype and roundtype.name and roundtype.name != "Multiple breaches") then
				return true
			elseif (at:Team() == TEAM_GUARD and target:Team() == TEAM_GUARD and roundtype and roundtype.name and roundtype.name == "Assault") then
				return true
			end
		end
	end
	local rdm = false
	--Block damage was returned
	local at = dmg:GetAttacker()
	if IsValid(target) and target:IsPlayer() and IsValid(at) and at:IsPlayer() and target != at then
		if (at.GetNClass and at:GetNClass() == ROLE_2639A and target:Team() != TEAM_SCP) or (target.GetNClass and target:GetNClass() == ROLE_2639A and at:Team() != TEAM_SCP)  then
			rdm = true
		end
		if target.GetNClass and target:GetNClass() == ROLE_999 then
			//Depends
		elseif at:Team() == TEAM_CLASSD and target:Team() == TEAM_CLASSD then
			rdm = true
		elseif at:Team() == TEAM_SCI and target:Team() == TEAM_SCI then
			rdm = true
		elseif at:Team() == TEAM_CHAOS and target:Team() == TEAM_CHAOS then
			rdm = true
		elseif (at:Team() == TEAM_CLASSD and target.GetNClass and target:GetNClass() == ROLE_SCP035 and roundtype and roundtype.name and roundtype.name != "Multiple breaches") or (at.GetNClass and at:GetNClass() == ROLE_SCP035 and target:Team() == TEAM_CLASSD and roundtype and roundtype.name and roundtype.name != "Multiple breaches") then
			rdm = true
		elseif (at:Team() == TEAM_GUARD and target:Team() == TEAM_GUARD) then
			rdm = true
		elseif (at:Team() == TEAM_GUARD and target:Team() == TEAM_SCI) then
			rdm = true
		elseif (at:Team() == TEAM_SCI and target:Team() == TEAM_GUARD) then
			rdm = true
		elseif at:Team() == TEAM_CLASSE and target:Team() == TEAM_CLASSE then
			rdm = true
		end
	end

	if SERVER and rdm and not preparing and not postround and IsValid(at) and at:IsPlayer() and IsValid(target) and target:IsPlayer() then
		--at:PrintMessage(4, "Do not attack allies!")
		if not at.KarmaHits then at.KarmaHits = 0 end
                at.KarmaHits = at.KarmaHits + 1
	end
end)

hook.Add("BreachStartRound", "BreachStartRound_ResetKarma", function ()

	 for k,v in pairs(player.GetAll()) do
		v.KarmaHits = 0
		v.KarmaKills = 0
	 end
end)
--kek
hook.Add("BreachEndRound", "BreachEndRound_ResetKarma", function () 
	if SERVER then
	for k,v in pairs(player.GetAll()) do
		local net_karma = 25
		if BR_KARMA_ENABLE then
			if not v.KarmaHits then v.KarmaHits = 0 end
			if not v.KarmaKills then v.KarmaKills = 0 end
                        if isnumber(v.KarmaHits) and v.KarmaHits > 1 then
                                net_karma = -15
                                net_karma = net_karma - ((v.KarmaHits - 1) * 5)
                        elseif isnumber(v.KarmaHits) and v.KarmaHits == 1 then
                                net_karma = -15
			end
                        local loss_kills = 0
			if v.KarmaKills then
                                if isnumber(v.KarmaKills) and v.KarmaKills > 1 then
                                        loss_kills = 20
                                        loss_kills = loss_kills + ((v.KarmaKills - 1) * 25)
                                elseif isnumber(z) then
                                        loss_kills = 20
                                end
			end
                        net_karma = net_karma - loss_kills
		end
		local new_karma = v:GetKarma() + net_karma
		if new_karma > BR_KARMA_MAX then
			new_karma = BR_KARMA_MAX
		end
		v:SetNWInt("breach_karma", new_karma)
		v.KarmaHits = 0
		v.KarmaKills = 0
	end
	end
end)

hook.Add("PlayerDeath", "PlayerDeath_Karma", function (target, inf, at)
	if SERVER and not postround and not preparing and ply and at and IsValid(target) and target:IsPlayer() and IsValid(at) and at:IsPlayer() and at != target then
		local rdm = false
		if (at.GetNClass and at:GetNClass() == ROLE_2639A and target:Team() != TEAM_SCP) or (target.GetNClass and target:GetNClass() == ROLE_2639A and at:Team() != TEAM_SCP)  then
			rdm = true
		end
		if target.GetNClass and target:GetNClass() == ROLE_999 then
			//Depends
		elseif at:Team() == TEAM_CLASSD and target:Team() == TEAM_CLASSD then
			rdm = true
		elseif at:Team() == TEAM_SCI and target:Team() == TEAM_SCI then
			rdm = true
		elseif at:Team() == TEAM_CHAOS and target:Team() == TEAM_CHAOS then
			rdm = true
		elseif (at:Team() == TEAM_CLASSD and target.GetNClass and target:GetNClass() == ROLE_SCP035 and roundtype and roundtype.name and roundtype.name != "Multiple breaches") or (at.GetNClass and at:GetNClass() == ROLE_SCP035 and target:Team() == TEAM_CLASSD and roundtype and roundtype.name and roundtype.name != "Multiple breaches") then
			rdm = true
		elseif (at:Team() == TEAM_GUARD and target:Team() == TEAM_GUARD) then
			rdm = true
		elseif (at:Team() == TEAM_GUARD and target:Team() == TEAM_SCI) then
			rdm = true
		elseif (at:Team() == TEAM_SCI and target:Team() == TEAM_GUARD) then
			rdm = true
		elseif at:Team() == TEAM_CLASSE and target:Team() == TEAM_CLASSE then
			rdm = true
		end
		if rdm then
			at:PrintMessage(4, "Do not kill allies!")
			if not at.KarmaKills then
				at.KarmaKills = 0
			end
        	at.KarmaKills = at.KarmaKills + 1
		end
	end
end)
function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	/*
	if SERVER then
		local at = dmginfo:Getat()
		if ply:Team() == at:Team() then
			at:TakeDamage( 25, at, at )
		end
	end
	*/
	--print("a")
	local at = dmginfo:GetAttacker()
	local mul = 1
	local armormul = 1
	if SERVER then
		local rdm = false
		if at != ply then
			if at:IsPlayer() then
				if dmginfo:IsDamageType( DMG_BULLET ) then
					if ply.UsingArmor != nil then
						if ply.UsingArmor != "armor_fireproof" then
							armormul = 0.85
						end
						--nu, duh
						if ply.UsingArmor == "armor_nu" then
							armormul = 0.6
						end
					end
				end
			end
		end
	end

	if (hitgroup == HITGROUP_HEAD) then
		mul = 1
	end
	if (hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM) then
		mul = 0.9
	end
	if (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) then
		mul = 0.9
	end
	if (hitgroup == HITGROUP_GEAR) then
		mul = 0.75
	end
	if (hutgroup == HITGROUP_STOMACH) then
		mul = 1
	end
	if SERVER then
		if at:IsPlayer() then
			if at.GetKarma then
				mul = mul * math.Clamp(math.Round(at:GetKarma() / 1000, 1), 0.5, 1)
			end
		end
		mul = mul * armormul
		if ply and IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_SCP and ply:GetNClass() != ROLE_SERPENT then
			local wep = dmginfo:GetInflictor()
			if wep and IsValid(wep) and (wep:GetClass() == "weapon_er2" or wep:GetClass() == "doom3_plasma" or wep:GetClass() == "tfa_ins2_volk") then
				mul = mul * 1
			else
				mul = mul * 1
			end
		end
		//mul = math.Round(mul)
		//print("mul: " .. mul)
		dmginfo:ScaleDamage(mul)
	end
end
hook.Add("BreachStartRound", "InformPlayersAboutKarma", function ()
	if SERVER then
	for k,v in pairs(player.GetAll()) do
		if v.GetKarma and v:GetKarma() < 1000 then
			v:PrintMessage(3, "You have " .. tostring(v:GetKarma()) .. " karma. You will deal " .. tostring(math.Clamp(math.Round(v:GetKarma() / 1000, 1), 0.5, 1) * 100 ) .. "% damage this round.")
		end
	end
	end
	for k,v in pairs(player.GetAll()) do
		v.did_escape = false
	end
end)

hook.Add("DoPlayerDeath", "CorrectPlayerViewModelsOnDeath", function (ply)
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and wep.PreDrop then
		wep:PreDrop()
	end
end)

local death_sounds = {
	"phase_1/deaths/death1.ogg",
	"phase_1/deaths/death2.ogg",
	"phase_1/deaths/death3.ogg",
	"phase_1/deaths/death4.ogg",
	"phase_1/deaths/death5.ogg",
	"phase_1/deaths/death6.ogg",
	"phase_1/deaths/death7.ogg",
	"phase_1/deaths/death8.ogg",
	"phase_1/deaths/death9.ogg",
	"phase_1/deaths/death10.ogg",
}

if SERVER then
	hook.Add("DoPlayerDeath", "DoPlayerDeath_PlayDeathSound", function (ply, att)
	    local shouldSupress = false
	    if att and IsValid(att) and att:IsPlayer() and att:GetActiveWeapon() and IsValid(att:GetActiveWeapon()) and att:GetActiveWeapon():GetClass() == "weapon_scp668" then
            shouldSupress = true
		end
		
		if WANT_DEATHSOUNDS and not shouldSupress and ply and IsValid(ply) and ply:Team() != TEAM_SPEC and ply:Team() != TEAM_SCP then
			ply:EmitSound(table.Random(death_sounds), SNDLVL_90dB, 100, 1)
		end
	end)

	hook.Add("ScalePlayerDamage", "ScalePlayerDamage_ScaleSCPDamage", function (ply, hg, dmginfo)
		if ply and IsValid(ply) and ply:Team() == TEAM_SCP then
	
			local should_ignore = false
			local inf = dmginfo:GetInflictor()
	
			if inf and IsValid(inf) and NO_SCP_SCALEDAMAGE[inf:GetClass()] then
				should_ignore = true
			end
	
			if not should_ignore then
				dmginfo:ScaleDamage(SCP_SCALEDAMAGE)
			end
		end
	end)
end