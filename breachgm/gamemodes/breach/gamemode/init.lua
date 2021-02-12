--Favored over old way as this seems to be significantly faster
local meta = FindMetaTable("Player")
function meta:SetNClass(str)
	self:SetNWString("Breach_Role", str)
end
function meta:GetNClass()
	return self:GetNWString("Breach_Role", "Spectator")
end
// Initialization file
AddCSLuaFile("sh_config.lua")
include("sh_config.lua")
//AddCSLuaFile( "class_default.lua" )
AddCSLuaFile( "fonts.lua" )
AddCSLuaFile( "class_default.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "cl_mtfmenu.lua" )
AddCSLuaFile( "sh_player.lua" )
AddCSLuaFile("cl_headbob.lua")
AddCSLuaFile("cl_msgstack.lua")
SCP008_HAS_BREACHED = false
ABEL_LIVES = 0
ROUND_SCORES = {}
mapfile = "mapconfigs/" .. game.GetMap() .. ".lua"
//AddCSLuaFile(mapfile)
ALLLANGUAGES = {}
clang = nil
local files, dirs = file.Find(GM.FolderName .. "/gamemode/languages/*.lua", "LUA" )
for k,v in pairs(files) do
	local path = "languages/"..v
	if string.Right(v, 3) == "lua" then
		AddCSLuaFile( path )
		include( path )
		print("Language found: " .. path)
	end
end
AddCSLuaFile( "rounds.lua" )
AddCSLuaFile( "cl_sounds.lua" )
AddCSLuaFile( "cl_targetid.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "server.lua" )
include( "rounds.lua" )
include( "class_default.lua" )
include( "shared.lua" )
include( mapfile )
include("sv_nuke.lua")
if OUTSIDESOUNDS and isvector(OUTSIDESOUNDS) then
	SetGlobalVector( "POINT_OUTSIDESOUNDS",OUTSIDESOUNDS)
end
include( "sh_player.lua" )
include( "sv_player.lua" )
include( "player.lua" )
include( "sv_round.lua" )

resource.AddFile( "sound/radio/chatter1.ogg" )
resource.AddFile( "sound/radio/chatter2.ogg" )
resource.AddFile( "sound/radio/chatter3.ogg" )
resource.AddFile( "sound/radio/chatter4.ogg" )
resource.AddFile( "sound/radio/franklin1.ogg" )
resource.AddFile( "sound/radio/franklin2.ogg" )
resource.AddFile( "sound/radio/franklin3.ogg" )
resource.AddFile( "sound/radio/franklin4.ogg" )
resource.AddFile( "sound/radio/radioalarm.ogg" )
resource.AddFile( "sound/radio/radioalarm2.ogg" )
resource.AddFile( "sound/radio/scpradio0.ogg" )
resource.AddFile( "sound/radio/scpradio1.ogg" )
resource.AddFile( "sound/radio/scpradio2.ogg" )
resource.AddFile( "sound/radio/scpradio3.ogg" )
resource.AddFile( "sound/radio/scpradio4.ogg" )
resource.AddFile( "sound/radio/scpradio5.ogg" )
resource.AddFile( "sound/radio/scpradio6.ogg" )
resource.AddFile( "sound/radio/scpradio7.ogg" )
resource.AddFile( "sound/radio/scpradio8.ogg" )
resource.AddFile( "sound/radio/ohgod.ogg" )

SPCS = {}
SPCS_P = {
	{name = "SCP 049",
	func = function(pl)
		pl:SetSCP049()
	end},
	{name = "SCP 096",
	func = function(pl)
		pl:SetSCP096()
	end},
	{name = "SCP 106",
	func = function(pl)
		pl:SetSCP106()
	end},
	{name = "SCP 682",
	func = function(pl)
		pl:SetSCP682()
	end},
	{name = "SCP 457",
	func = function(pl)
		pl:SetSCP457()
	end},
	{name = "SCP 066",
	func = function(pl)
		pl:SetSCP066()
	end},
	{name = "SCP 966",
	func = function(pl)
		pl:SetSCP966()
	end},
	{name = "SCP 076-02",
	func = function(pl)
		pl:SetSCP0762()
	end},
	{name = "SCP 939",
	func = function(pl)
		pl:SetSCP939()
	end},
	{name = "SCP 1048B",
	func = function(pl)
		pl:SetSCP1048B()
	end},
	{name = "SCP 178",
	func = function(pl)
		pl:SetSCP017()
	end},
	{name = "SCP 372",
	func = function(pl)
		pl:SetSCP372()
	end},
	{
	name = "SCP 1048",
	func = function(pl)
		pl:SetSCP1048()
	end
	},
	{
	name = "SCP WW",
	func = function(pl)
		pl:SetSCPWW()
	end
	},
	{
	name = "SCP 079",
	func = function(pl)
		pl:SetSCP079()
	end
	},
	{name = "SCP 173",
	func = function(pl)
		pl:SetSCP173()
	end}
}

RAND = {}
RAND_P = {
	{name = "Class D",
	func = function(pl)
		pl:SetClassD()
	end},
	{name = "Class E",
	func = function(pl)
		pl:SetClassE()
	end},
	{name = "Nobody",
	func = function(pl)
		pl:SetNobody()
	end},
	{name = "AWCY",
	func = function(pl)
		pl:SetAWCY()
	end},
	{name = "SCP 999",
	func = function(pl)
		pl:SetSCP999()
	end},
	{name = "SCP 2953",
	func = function(pl)
		pl:SetSCP2953()
	end},
	{name = "CIS",
	func = function(pl)
		pl:SetChaosScientist()
	end},
	{name = "SCI",
	func = function(pl)
		pl:SetScientist()
	end},
	{name = "Commander",
	func = function(pl)
		pl:SetCommander()
	end},
	{name = "Guard",
	func = function(pl)
		pl:SetGuard()
	end},
	{name = "Heavy",
	func = function(pl)
		pl:SetGuardHeavy()
	end},
	{name = "Medic",
	func = function(pl)
		pl:SetGuardMedic()
	end},
	{name = "Pyro",
	func = function(pl)
		pl:SetGuardPyro()
	end},
	{name = "SPCG",
	func = function(pl)
		pl:SetSPCGuard()
	end},
	{name = "S Class",
	func = function(pl)
		pl:SetSClass()
	end},
	{name = "NTF",
	func = function(pl)
		pl:SetNTF()
	end},
	{name = "TAU5",
	func = function(pl)
		pl:SetTau5()
	end},
	{name = "Clef",
	func = function(pl)
		pl:SetClef()
	end},
	{name = "Sigma1",
	func = function(pl)
		pl:SetSigma1()
	end},
	{name = "SCP 1959",
	func = function(pl)
		pl:SetSCP1959()
	end},
	{name = "SCP 2639A",
	func = function(pl)
		pl:SetSCP2639A()
	end},
	{name = "RRH",
	func = function(pl)
		pl:SetRRH()
	end},
	{name = "SCP 017",
	func = function(pl)
		pl:SetSCP017()
	end},
	{name = "SH",
	func = function(pl)
		pl:SetSerpentsHand()
	end},
	{name = "Random",
	func = function(pl)
		pl:SetRandom()
	end},
	{name = "O51",
	func = function(pl)
		pl:SetO51()
	end},
	{name = "SCP 073",
	func = function(pl)
		pl:SetSCP073()
	end},
	{name = "UNI",
	func = function(pl)
		pl:SetUni()
	end},
	{name = "CONF",
	func = function(pl)
		pl:SetConf()
	end},
	{name = "SCP 378",
	func = function(pl)
		pl:SetSCP378()
	end},
	{name = "SCP 3199b",
	func = function(pl)
		pl:SetSCP3199b()
	end},
	{name = "SCP 035",
	func = function(pl)
		pl:SetSCP035()
	end},
	{name = "SCP 0492",
	func = function(pl)
		pl:SetSCP0492()
	end},
	{name = "SCP 049",
	func = function(pl)
		pl:SetSCP049()
	end},
	{name = "SCP 096",
	func = function(pl)
		pl:SetSCP096()
	end},
	{name = "SCP 106",
	func = function(pl)
		pl:SetSCP106()
	end},
	{name = "SCP 682",
	func = function(pl)
		pl:SetSCP682()
	end},
	{name = "SCP 457",
	func = function(pl)
		pl:SetSCP457()
	end},
	{name = "SCP 066",
	func = function(pl)
		pl:SetSCP066()
	end},
	{name = "SCP 966",
	func = function(pl)
		pl:SetSCP966()
	end},
	{name = "SCP 076-02",
	func = function(pl)
		pl:SetSCP0762()
	end},
	{name = "SCP 939",
	func = function(pl)
		pl:SetSCP939()
	end},
	{name = "SCP 1048B",
	func = function(pl)
		pl:SetSCP1048B()
	end},
	{name = "SCP 372",
	func = function(pl)
		pl:SetSCP372()
	end},
	{name = "SCP 173",
	func = function(pl)
		pl:SetSCP173()
	end}
}
--
MAP_EXCLUDES = {
	["SCP 173"] = "173",
	["SCP 049"] = "049",
	["SCP 096"] = "096",
	["SCP 106"] = "106",
	["SCP 682"] = "682",
	["SCP 035"] = "035",
	["SCP 457"] = "457",
	["SCP 066"] = "066",
	["SCP 966"] = "966",
	["SCP 076-02"] = "0762",
	["SCP 939"] = "939",
	["SCP 1048"] = "1048",
	["SCP 1048B"] = "1048B",
	["SCP 178"] = "178",
	["SCP 372"] = "372",
	["SCP 082"] = "082",
	["SCP 1471"] = "1471",
	["SCP 2845"] = "2845",
	["SCP 160"] = "160"
}
for k,v in pairs(SPCS_P) do
	local is_disabled = false
	if DISABLED_SCPS then
		for x,y in pairs(MAP_EXCLUDES) do
			if v.name == x then
				for a,b in pairs(DISABLED_SCPS) do
					if b == y then
						is_disabled = true
						print("init game settings: disable  "..x)
					end
				end
			end
		end
	end
	if not is_disabled then
		SPCS[#SPCS + 1] = v
		ServerLog("init game settings enable: " .. v.name .. "\n")
	end
end
for k,v in pairs(RAND_P) do
	local is_disabled = false
	if DISABLED_RAND then
		for x,y in pairs(MAP_EXCLUDES) do
			if v.name == x then
				for a,b in pairs(DISABLED_RAND) do
					if b == y then
						is_disabled = true
						print("init game settings: disable  "..x)
					end
				end
			end
		end
	end
	if not is_disabled then
		RAND[#RAND + 1] = v
		ServerLog("init game settings enable: " .. v.name .. "\n")
	end
end

/*
Names = {
	researchers = {
		"Dr. Django Bridge",
		"Dr. Jack Bright",
		"Dr. Jeremiah Cimmerian",
		"Dr. Alto Clef",
		"Researcher Jacob Conwell",
		"Dr. Kain Crow",
		"Dr. Chelsea Elliott",
		"Dr. Charles Gears",
		"Dr. Simon Glass",
		"Dr. Frederick Heiden",
		"Dr. Everett King",
		"Dr. Zyn Kiryu",
		"Dr. Mark Kiryu",
		"Dr. Adam Leeward",
		"Dr. Everett Mann",
		"Dr. Riven Mercer",
		"Dr. Johannes Sorts",
		"Dr. Thaddeus Xyank"
	}
}
*/

// Variables
gamestarted = false
preparing = false
postround = false
roundcount = 0
MAPBUTTONS = table.Copy(BUTTONS)

function GM:PlayerSpray( sprayer )
	return sprayer:Team() != TEAM_SPEC
end

function GetActivePlayers()
	local tab = {}
	for k,v in pairs(player.GetAll()) do
		--if v.ActivePlayer == nil then v.ActivePlayer = true end
		if ( not v:IsAFK()) then
			table.ForceInsert(tab, v)
		end
	end
	return tab
end
function GetNotAFKSpecs()
	local tab = {}
	for k,v in pairs(player.GetAll()) do
		--if v.ActivePlayer == nil then v.ActivePlayer = true end
		if not v:IsAFK() and v:Team() == TEAM_SPEC then
			table.ForceInsert(tab, v)
		end
	end
	return tab
end
function GetNotActivePlayers()
	local tab = {}
	for k,v in pairs(player.GetAll()) do
		--if v.ActivePlayer == nil then v.ActivePlayer = true end
		if v:IsAFK() then
			table.ForceInsert(tab, v)
		end
	end
	return tab
end

function RestockAmmo()
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "item_pistolammo" or v:GetClass() == "item_rifleammo" or v:GetClass() == "item_shotgunammo" or v:GetClass() == "smgammo" then
			SafeRemoveEntity(v)
		end
	end
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "scp-348" then
			SafeRemoveEntity(v)
		end
	end
	if SPAWNS_348 then
		local soup_scp = ents.Create("scp-348")
		if IsValid(soup_scp) then
			soup_scp:Spawn()
		end
	end
	local offset = Vector(0,0,-25)
	if MAP_NOCANCERMODE then
		offset = Vector(0,0,0)
	end
	for k,v in pairs(SPAWN_AMMO_RIFLE) do
		local wep = ents.Create( "item_rifleammo" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset )
		end
	end
	for k,v in pairs(SPAWN_AMMO_SMG) do
		local wep = ents.Create( "item_smgammo" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset )
		end
	end
	for k,v in pairs(SPAWN_AMMO_PISTOL) do
		local wep = ents.Create( "item_pistolammo" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset )
		end
	end
end


function GM:ShutDown()
	for k,v in pairs(player.GetAll()) do
		v:SaveKarma()
	end
end

function WakeEntity(ent)
	local phys = ent:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
		phys:SetVelocity(Vector(0,0,25))
	end
end

function PlayerNTFSound(sound, ply)
	if (ply:Team() == TEAM_GUARD or ply:Team() == TEAM_CHAOS) and ply:Alive() then
		if ply.lastsound == nil then ply.lastsound = 0 end
		if ply.lastsound > CurTime() then
			ply:PrintMessage(HUD_PRINTTALK, "You must wait " .. math.Round(ply.lastsound - CurTime()) .. " seconds to do this.")
			return
		end
		//ply:EmitSound( "Beep.ogg", 500, 100, 1 )
		ply.lastsound = CurTime() + 3
		//timer.Create("SoundDelay"..ply:SteamID64() .. "s", 1, 1, function()
			ply:EmitSound( sound, 450, 100, 1 )
		//end)
	end
end

function OnUseEyedrops(ply)
	if ply.usedeyedrops == true then
		ply:PrintMessage(HUD_PRINTTALK, "Don't use them that fast!")
		return
	end
	ply.usedeyedrops = true
	ply:StripWeapon("item_eyedrops")
	ply:PrintMessage(HUD_PRINTTALK, "Used eyedrops, you will not be blinking for 10 seconds")
	timer.Create("Unuseeyedrops" .. ply:SteamID64(), 10, 1, function()
		ply.usedeyedrops = false
		ply:PrintMessage(HUD_PRINTTALK, "You will be blinking now")
	end)
end

timer.Create("BlinkTimer", GetConVar("br_time_blinkdelay"):GetInt(), 0, function()
	local time = GetConVar("br_time_blink"):GetFloat()
	if time >= 5 then return end
	for k,v in pairs(player.GetAll()) do
		if v.blinkedby173 == nil then
			v.blinkedby173 = false
		end
		if v.usedeyedrops == nil then
			v.usedeyedrops = false
		end
		if v.canblink == nil then
			v.canblink = !(v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC)
		end
		if v.canblink and v.blinkedby173 == false and v.usedeyedrops == false then
			net.Start("PlayerBlink")
				net.WriteFloat(time)
			net.Send(v)
			v.isblinking = true
		end

	end
	timer.Create("UnBlinkTimer", time + 0.2, 1, function()
		for k,v in pairs(player.GetAll()) do
			if v.blinkedby173 == false then
				v.isblinking = false
			end
		end
	end)
end)






nextgateaopen = 0
function RequestOpenGateA(ply)
	hook.Run("BreachMap_RequestGateA", ply)
end

local lastpocketd = 0
function GetPocketPos()
	if lastpocketd > #POS_POCKETD then
		lastpocketd = 0
	end
	lastpocketd = lastpocketd + 1
	return POS_POCKETD[lastpocketd]
end

--Legacy
function SpawnTFAGuns()
	print("WARNING! SpawnTFAGuns() is deprecated and will be removed in a future version.")
	SpawnDefGuns()
end

function SpawnDefGuns()

	local offset = Vector(0,0,0)
	if not MAP_NOCANCERMODE then
		offset = Vector(0,0,-25)
	end
	for k,v in pairs(SPAWN_PISTOLS) do
		local wep = ents.Create( table.Random({"tfa_csgo_deagle", "tfa_csgo_glock18"}) )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset )
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end
	local int = ents.Create("ent_intercom")
	if IsValid(int) then
		int:Spawn()
	end
	for k,v in pairs(SPAWN_SMGS) do
		local wep = ents.Create( table.Random({"tfa_csgo_p90", "tfa_csgo_ump45"}) )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset )
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end
	if MAP_SHOTGUNS_SUPPORTED then
		for k,v in pairs(SPAWN_SHOTGUNS) do
			local sg = ents.Create(table.Random({"tfa_csgo_sawedoff", "tfa_csgo_xm1014", "tfa_csgo_mag7"}))
			if IsValid(sg) then
				sg:Spawn()
				sg:SetPos(v)
				sg.SavedAmmo = sg.Primary.ClipSize
				WakeEntity(sg)
			end
		end
	end
	local DIDSPAWN127 = true
	local wep
	for k,v in pairs(SPAWN_RIFLES) do
		if not DIDSPAWN127 and math.random(1, 5) == 3 then
			if not IsValid(wep) then
				if math.random(1, 20) == 5 then
					wep = ents.Create(table.Random({"tfa_csgo_m4a1", "tfa_csgo_scar20"}))
				else
					wep = ents.Create( table.Random({"tfa_csgo_m4a1", "tfa_csgo_scar20"}) )
				end
			end
		else
			if math.random(1, 20) == 5 then
				wep = ents.Create(table.Random({"tfa_csgo_m4a1", "tfa_csgo_scar20"}))
			else
				wep = ents.Create( table.Random({"tfa_csgo_m4a1", "tfa_csgo_scar20"}) )
			end
		end
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset )
			wep.SavedAmmo = wep.Primary.ClipSize
			WakeEntity(wep)
		end
	end
end

function SpawnAllItems()
	local offset1 = Vector(0,0,-5)
	if MAP_NOCANCERMODE then
		offset1 = Vector(0,0,-5)
	end
	local scp_1162 = ents.Create("scp_1162")
	scp_1162:Spawn()
	for k,v in pairs(SPAWN_FIREPROOFARMOR) do
		local vest = ents.Create( table.Random({"armor_fireproof", "armor_hazmat"}) )
		if IsValid( vest ) then
			vest:Spawn()
			vest:SetPos( v + offset1 )
			WakeEntity(vest)
		end
	end

	if SPAWN_038 then
		local scp038 = ents.Create("ent_scp038")
		if IsValid(scp038) then
			scp038:SetPos(SPAWN_038)
			scp038:Spawn()
		end
	end


    --the following is a dumb way to do this, I don't know a better way though I tried a lot already. SORRY THAT IT LOOKS SHIT 
	if SPAWN_106_ENTITY1 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY1)
		end
	end
	if SPAWN_106_ENTITY2 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY2)
		end
	end
	if SPAWN_106_ENTITY3 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY3)
		end
	end
	if SPAWN_106_ENTITY4 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY4)
		end
	end
	if SPAWN_106_ENTITY5 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY5)
		end
	end
	if SPAWN_106_ENTITY6 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY6)
		end
	end
	if SPAWN_106_ENTITY7 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY7)
		end
	end
	if SPAWN_106_ENTITY8 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY8)
		end
	end
	if SPAWN_106_ENTITY9 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY9)
		end
	end
	if SPAWN_106_ENTITY10 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY10)
		end
	end
	if SPAWN_106_ENTITY11 then
		local scp_106_ent = ents.Create("tpkill")
		if IsValid(scp_106_ent) then
			scp_106_ent:Spawn()
			scp_106_ent:SetPos(SPAWN_106_ENTITY11)
		end
	end


	if SPAWN_WATER_BALLOONS then
		for k,v in pairs(SPAWN_WATER_BALLOONS) do
			local e = ents.Create("weapon_waterballoon")
			if IsValid(e) then
				e:SetClip1(1)
				e:SetPos(v)
				e:Spawn()
			end
		end
	end

	if SPAWN_330 then
		local scp_330 = ents.Create("ent_scp330")
		if scp_330 and IsValid(scp_330) then
			scp_330:Spawn()
		end
	end
	if SPAWN_SCP1315 then
		local scp_1315 = ents.Create("ent_scp1315")
		if scp_1315 and IsValid(scp_1315) then
			scp_1315:Spawn()
		end
	end
	if SPAWN_SCP1315HB then
		local scp_1315hb = ents.Create("ent_scp1315_hb")
		if scp_1315hb and IsValid(scp_1315hb) then
			scp_1315hb:Spawn()
		end
	end
	if SPAWN_NUKE then
		local nuke = ents.Create("ent_nuke")
		if nuke and IsValid(nuke) then
			nuke:Spawn()
		end
	end
	if SPAWN_GRAVE then
		local grave = ents.Create("ent_grave")
		if grave and IsValid(grave) then
			grave:Spawn()
		end
	end
	local offset2 = Vector(0,0,-15)
	if MAP_NOCANCERMODE then
		offset2 = Vector(0,0,0)
	end
	for k,v in pairs(SPAWN_ARMORS) do
		local vest = ents.Create( "armor_mtfguard" )
		if IsValid( vest ) then
			vest:Spawn()
			vest:SetPos( v + offset2 )
			WakeEntity(vest)
		end
	end
	if SPAWN_458 then
		local scp458 = ents.Create("infinitepizzaent")
		if IsValid(scp458) then
			scp458:SetPos(SPAWN_458)
			scp458:Spawn()
		end
	end
	if SPAWN_SCP1025 then
		local scp1025 = ents.Create("scp_1025")
		if IsValid(scp1025) then
			scp1025:Spawn()
		end
	end
	if SPAWN_SCP1425 then
		local scp1425 = ents.Create("scp_1425")
		if IsValid(scp1425) then
			scp1425:SetPos(SPAWN_SCP1425)
			scp1425:Spawn()
		end
	end
	if SPAWN_SCP216 then
		local scp216 = ents.Create("scp_216")
		if IsValid(scp216) then
			scp216:SetPos(SPAWN_SCP216)
			scp216:Spawn()
		end
	end
	if SPAWN_SCP216HB then
		local scp216hb = ents.Create("scp_216_hb")
		if IsValid(scp216hb) then
			scp216hb:SetPos(SPAWN_SCP216HB)
			scp216hb:Spawn()
		end
	end
	
	local scp294 = ents.Create( "scp294" )
	if IsValid( scp294 ) then
			scp294:Spawn()
			scp294:SetPos( SPAWN_SCP_294 )
			scp294:SetAngles(Angle(0.000, 90.000, 0.000))
			if SPAWN_SCP_294_ANG then
				scp294:SetAngles(SPAWN_SCP_294_ANG)
			end
			local l = scp294:GetPhysicsObject()
			if l and l:IsValid() then
				l:EnableMotion(false)
				print("Disabled motion")
			end
			WakeEntity(scp294)
	end
	if not BR_TFA_GUNS_ENABLED then
		SpawnDefGuns()
	else
		SpawnTFAGuns()
	end
	local offset3 = Vector(0,0,-25)
	if MAP_NOCANCERMODE then	
		offset3 = Vector(0,0,0)
	end
	for k,v in pairs(SPAWN_AMMO_RIFLE) do
		local wep = ents.Create( "item_rifleammo" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	if MAP_SHOTGUNS_SUPPORTED then
		for k,v in pairs(SPAWN_AMMO_SHOTGUN) do
			local sga = ents.Create("item_shotgunammo")
			if IsValid(sga) then
				sga:Spawn()
				sga:SetPos(v)
				WakeEntity(sga)
			end
		end
	end
	for k,v in pairs(SPAWN_500) do
		local wep = ents.Create( "weapon_scp_500" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP127) do
		local wep = ents.Create( "scp_127" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP512) do
		local wep = ents.Create( "weapon_scp512" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP668) do
		local wep = ents.Create( "weapon_scp668" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP268) do
		local wep = ents.Create( "weapon_scp_268" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP2953) do
		local wep = ents.Create( "svn_kar98k" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP154) do
		local wep = ents.Create( "novoice" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP1290) do
		local wep = ents.Create( "weapon_scp_1290" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_SCP005) do
		local wep = ents.Create( "weapon_scp_005" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	if math.random(1, 4) == 4 then
	BroadcastGameMsg("SCP-020 has breached!")
	for k,v in pairs(SPAWN_SCP020) do
		local scp = ents.Create(table.Random({ "ent_mold" }))
		if IsValid( scp ) then
			scp:Spawn()
			scp:SetPos( v + offset3 )
		end
	end
end
	for k,v in pairs(SPAWN_FLASH) do
		local wep = ents.Create(table.Random({ "tfa_csgo_decoy", "tfa_csgo_flash", "tfa_csgo_frag", "tfa_csgo_incen", "tfa_csgo_molly", "tfa_csgo_smoke", "tfa_csgo_sonarbomb", "weapon_saturnalia", "weapon_scp_409"}))
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos(v)
		end
	end
	if roundtype and roundtype.name and roundtype.name == "Fast Quick Slow Round" then
	for k,v in pairs(SPAWN_FLASH) do
		local scp = ents.Create("ent_rock")
		if IsValid( scp ) then
			scp:Spawn()
			scp:SetPos( v + offset3 )
		end
	end
end
	if roundtype and roundtype.name and roundtype.name == "Fast Quick Slow Round" then
	for k,v in pairs(SPAWN_NVG) do
		local scp = ents.Create("ent_rock")
		if IsValid( scp ) then
			scp:Spawn()
			scp:SetPos( v + offset3 )
		end
	end
end
	if roundtype and roundtype.name and roundtype.name == "Fast Quick Slow Round" then
	for k,v in pairs(SPAWN_ARMORS) do
		local scp = ents.Create("ent_rock")
		if IsValid( scp ) then
			scp:Spawn()
			scp:SetPos( v + offset3 )
		end
	end
end
	for k,v in pairs(SPAWN_AMMO_SMG) do
		local wep = ents.Create( "item_smgammo" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	for k,v in pairs(SPAWN_NVG) do
		local wep = ents.Create( table.Random( {"weapon_nvg","weapon_nvg","weapon_nvg","weapon_nvg","weapon_nvg", "weapon_nvg", "weapon_nvg", "weapon_nvg", "item_medkit", "item_radio", "item_eyedrops", "item_snav_300", "item_snav_ultimate", "weapon_l4d2_crowbar", "tfa_csgo_molly", "tfa_csgo_frag", "tfa_csgo_flash", "tfa_csgo_smoke", "item_scp207", "item_scp207", "item_foxammo", "weapon_cartridge_shadow", "weapon_cartridge_hunter", "weapon_cartridge_freeman", "weapon_scp_690", "weapon_scp_350", "weapon_scp_010"} ) )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v )
		end
	end

	for k,v in pairs(SPAWN_AMMO_PISTOL) do
		local wep = ents.Create( "item_pistolammo" )
		if IsValid( wep ) then
			wep:Spawn()
			wep:SetPos( v + offset3 )
		end
	end
	local LV2_TO_SPAWN_PER_AREA = 7
	local LV3_TO_SPAWN_PER_AREA = 5
	local lv2_spawns = table.Copy(SPAWN_KEYCARD2)
	for k,v in pairs(SPAWN_KEYCARD2) do
		local area_spawns = table.Copy(v)
		for i = 1, LV2_TO_SPAWN_PER_AREA do
			local item = ents.Create( table.Random({"keycard_bs", "keycard_j", "keycard_ms"}) )
			if IsValid( item ) then
				local card_spawn = table.Random(area_spawns)
				item:Spawn()
				item:SetPos( card_spawn )
				--print(card_spawn)
				table.RemoveByValue(area_spawns, card_spawn)
			end
		end
	end


	for k,v in pairs(SPAWN_KEYCARD3) do
		local area_spawns = table.Copy(v)
		for i = 1, LV3_TO_SPAWN_PER_AREA do
			local item = ents.Create( table.Random({"keycard_bg", "keycard_en", "keycard_zm"}) )
			if IsValid( item ) then
				local card_spawn = table.Random(area_spawns)
				item:Spawn()
				item:SetPos( card_spawn )
				table.RemoveByValue(area_spawns, card_spawn)
			end
		end
	end

	if SPAWN_KEYCARD5 and #SPAWN_KEYCARD5 > 0 then
		local spawn = table.Random(SPAWN_KEYCARD5)
		local item = ents.Create( "keycard_5" )
		item:Spawn()

		item:SetPos(spawn)
	end

	for k,v in pairs(SPAWN_KEYCARD4) do
		local item = ents.Create( table.Random({"keycard_lt", "keycard_sg", "keycard_fm"}) )
		if IsValid( item ) then
			item:Spawn()
			item:SetPos( table.Random(v) )
		end
	end

	local resps_items = table.Copy(SPAWN_MISCITEMS)
	local resps_melee = table.Copy(SPAWN_MELEEWEPS)
	local resps_medkits = table.Copy(SPAWN_MEDKITS)

	local item = ents.Create( "item_medkit" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_medkits)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_medkits, spawn4)
	end

	local item = ents.Create( "item_medkit" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_medkits)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_medkits, spawn4)
	end
	local item = ents.Create( "item_medkit" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_medkits)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_medkits, spawn4)
	end
	local item = ents.Create( "item_medkit" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_medkits)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_medkits, spawn4)
	end
	local item = ents.Create( "item_radio" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_items)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_items, spawn4)
	end

	local item = ents.Create( "item_eyedrops" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_items)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_items, spawn4)
	end

	local item = ents.Create( "item_snav_300" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_items)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_items, spawn4)
	end

	local item = ents.Create( "item_snav_ultimate" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_items)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_items, spawn4)
	end

	local item = ents.Create( "weapon_l4d2_crowbar" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_melee)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_melee, spawn4)
	end

	local item = ents.Create( "weapon_l4d2_crowbar" )
	if IsValid( item ) then
		local spawn4 = table.Random(resps_melee)
		item:Spawn()
		item:SetPos( spawn4 )
		table.RemoveByValue(resps_melee, spawn4)
	end

end

function GetSCPLeavers()
	local tab = {}
	for k,v in pairs(team.GetPlayers(TEAM_SPEC)) do
		if v.Leaver == "scp" then
			table.ForceInsert(tab, v)
		end
	end
	print("giving scp leavers with count: " .. #tab)
	return tab
end

function GetClassDLeavers()
	local tab = {}
	for k,v in pairs(team.GetPlayers(TEAM_SPEC)) do
		if v.Leaver == "classd" then
			table.ForceInsert(tab, v)
		end
	end
	print("giving class d leavers with count: " .. #tab)
	return tab
end

function GetSciLeavers()
	local tab = {}
	for k,v in pairs(team.GetPlayers(TEAM_SPEC)) do
		if v.Leaver == "sci" then
			table.ForceInsert(tab, v)
		end
	end
	print("giving sci leavers with count: " .. #tab)
	return tab
end
spawnedntfs = 0

ejkfjekjefwjewfjkfew = {
	["mtf_status"] = function ()
		return math.Clamp(#team.GetPlayers(TEAM_GUARD), 0, 8)
	end,
	["commander_alive"] = function ()
		for k,v in pairs(player.GetAll()) do
			if v:GetNClass() == ROLE_MTFCOM or "TRO Commander" then
				return 2
			end
		end
		return -4
	end,
	["457_active"] = function ()
		for k,v in pairs(player.GetAll()) do
			if v:GetNClass() == ROLE_SCP457 then
				return -3
			end
		end
		return 0
	end,
	["scp_status"] = function ()
		return math.Clamp(#team.GetPlayers(TEAM_SCP), 0, 4)
	end,
	["079_active"] = function ()
		for k,v in pairs(player.GetAll()) do
			if v:GetNClass() == ROLE_SCP079 then
				return 1
			end
		end
		return 0
	end,
	["researcher_status"] = function ()
		return math.Clamp(#team.GetPlayers(TEAM_SCI), 0, 2)
	end,
	["dclass_status"] = function ()
		return math.Clamp(#team.GetPlayers(TEAM_CLASSD), 0, 2)
	end,
	["eclass_status"] = function ()
		return math.Clamp(#team.GetPlayers(TEAM_CLASSE), 0, 2)
	end,
	["181_status"] = function ()
		for k,v in pairs(player.GetAll()) do
			if v:GetNClass() == ROLE_SCP181 then
				return 1
			end
		end
		return 0
	end,
	["rng"] = function ()
		return math.random(1,3)
	end

}

local function lazy(a)
	return math.Clamp(a, 1, 1000)
end
local ac = ejkfjekjefwjewfjkfew
local SQUADS = {
	--Failover is ntf
	["ntf"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetNTF()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			return lazy(ac["mtf_status"]() + (ac["commander_alive"]() * -1) + (2 - ac["researcher_status"]()) + 1 + math.random(1, 12) )
		end,
		snd = "newntfsound.ogg",
		display = "MTF Unit Nine Tailed Fox has entered the facility."
	},
	["chaos"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetChaosInsurgency(3)
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			return lazy((ac["mtf_status"]() * 1.2) + (ac["commander_alive"]() * -1) + (1 - ac["researcher_status"]()) + 1 ) + (ac["181_status"]() * 3)
		end,
		snd = "newntfsound.ogg",
		display = "MTF Unit Nine Tailed Fox has entered the facility."
	},
	["scrubs"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetSCP2639A()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			return lazy((ac["mtf_status"]() * -0.5) + (ac["commander_alive"]() * 0.5) +  ac["researcher_status"]() + 1 )
		end,
		snd = "scrubs.ogg",
		display = "MTF Unit Omega-9, the scrubs, has entered the facility."
	},
	["fire_eaters"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetEp9()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			--Less importance on researchers because the foundation wants to avoid accidental injury
			return lazy((ac["mtf_status"]() * -0.8) + (ac["commander_alive"]() * 0.8) +  (ac["researcher_status"]() * 0.5) + 1 + ac["457_active"]() )
		end,
		snd = "fire_eaters.ogg",
		display = "MTF Unit Epsilon-9, the fire eaters, has entered the facility."
	},
	["pandoras_box"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				if itr == 1 then
					v:SetSCP0762PB()
				else
					v:SetNTF()
				end
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			return lazy((ac["mtf_status"]() * -0.35) + (ac["commander_alive"]() * 0.35) +  (ac["researcher_status"]() * -0.2) + 1 )
		end,
		snd = "pandorasbox.ogg",
		display = "MTF Unit Omega-7, Pandora's box, has entered the facility."
	},
	["sixteen_tons"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				if itr == 1 then
					v:SetSigma1()
				else
					v:SetSigma2()
				end
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			return lazy((ac["mtf_status"]() * -0.35) + (ac["commander_alive"]() * -0.35) +  (ac["researcher_status"]() * -0.2) + 1 )
		end,
		snd = "",
		display = "MTF Unit Sigma-66, Sixteen Tons, has entered the facility."
	},
	["stripper_squad"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				if itr == 1 then
					v:SetClef()
				else
					v:SetLambda2()
				end
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			--Less likely to send clef in if too many scps
			return lazy((ac["mtf_status"]() * -0.1) + (ac["commander_alive"]() * -1) +  (2-ac["researcher_status"]()) + 1 + (ac["scp_status"]() * -1) )
		end,
		snd = "lambda2.ogg",
		display = "MTF Unit Lambda-2 has entered the facility. It wasn't very effective..."
	},
	["serpents_hand"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetSerpentsHand()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			--Less common than CI
			return lazy((ac["mtf_status"]() * 1.3) + (ac["commander_alive"]() * -1) + (1 - ac["researcher_status"]()) + -2 + (ac["079_active"]() * 3) )
		end,
		snd = "tro_sh.mp3",
		display = "*WARNING* A hostile unit has entered the facility!"
	},
	["scp1861"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetSCP1861B()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			return lazy((ac["mtf_status"]() * -0.1) + (ac["commander_alive"]() * -0.1) +  (ac["dclass_status"]() * 0.2) + (ac["researcher_status"]() * 0.2) + 1 + (ac["scp_status"]() * -1.5) )
		end,
		snd = "tro_sh.mp3",
		display = "*WARNING* SCP-1861 has surfaced nearby!"
	},
	["scp1959"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				if itr == 1 then
					v:SetSCP1959()
				else
					v:SetSpectator()
				end
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			--Less likely to send 1959 in if too many scps but increases chances if more foundation memebers are alive
			return lazy((ac["mtf_status"]() * 0.5) + (ac["commander_alive"]() * 1) +  (ac["dclass_status"]() * -1.5) + (ac["researcher_status"]() * 0.1) + 1 + (ac["scp_status"]() * -1.5) )
		end,
		snd = "1959.ogg",
		display = "*WARNING* An unknown entity has entered the facility!"
	},
	["nu7"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetNu7()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			--Due to the nature of Nu-7, they are slightly more likely to respond if the commander is dead
			return lazy((ac["mtf_status"]() * -1.1) + (ac["commander_alive"]() * -0.2) +  (ac["researcher_status"]()) + 1 + ac["457_active"]() + ac["scp_status"]() )
		end,
		snd = "nuenter.ogg",
		display = "MTF Unit Nu-7, hammer down, has entered the facility."
	},
	["tau5"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetTau5()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			--Due to the nature of Tau-7, they are slightly more likely to respond if the commander is dead
			return lazy((ac["mtf_status"]() * -1.1) + (ac["commander_alive"]() * -0.2) +  (ac["researcher_status"]()) + 1 + ac["457_active"]() + ac["scp_status"]() )
		end,
		snd = "kaito_tau5.mp3",
		display = "MTF Unit Tau-5, Samsara, has entered the facility."
	},
	["awcy"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				v:SetAWCY()
				v:SetPos(SPAWN_OUTSIDE[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			--More likely to appear if Class E is alive
			return lazy((ac["mtf_status"]() * 0.3) + (ac["commander_alive"]() * -1) + (1 - ac["researcher_status"]()) + -2.5 + (ac["eclass_status"]() * 3) )
		end,
		snd = "",
		display = "*WARNING* Prepare to be tagged!"
	}
}

local DREAM = {
	["dream"] = {
		func = function (plys)
			local itr = 1
			for k,v in pairs(plys) do
				if itr == 1 then
				for k,v in pairs(player.GetAll()) do
				if v:GetNClass() == ROLE_SCP990 then return end
				end
				if math.random(1, 5) == 5 then
					v:SetSCP990()
				else
					return
				end
				end
				v:SetPos(SPAWN_SCIENT[itr])
				itr = itr + 1
			end
		end,
		calc_fav = function ()
			return lazy((ac["mtf_status"]() * 0.5) + (ac["commander_alive"]() * 1) +  (ac["dclass_status"]() * -1.5) + (ac["researcher_status"]() * 0.1) + 1 + (ac["scp_status"]() * -1.5) )
		end,
		display = "*WARNING* Prepare to be tagged!"
	}
}

--local TREE = {
	--["tree"] = {
		--func = function (plys)
			--local itr = 1
			--for k,v in pairs(plys) do
				--if itr == 1 then
				--for k,v in pairs(ents.GetAll()) do
					--if v:GetClass() == "ent_scp2536" then return end
				--end
				--if math.random(1, 3) == 3 then
					--local ent = ents.Create( "ent_scp2536" )
						--ent:SetPos( v:GetPos() + Vector(0, 0, 5) )
						--ent:SetOwner( v )
						--ent:Spawn()
						--ent:EmitSound("ambient/levels/canals/windchine1.wav", 50, 100)
						--v:PrintMessage(3, "Christmas music is playing nearby...")
				--else
					--return
					--end
				--end
				--itr = itr + 1
			--end
		--end,
		--calc_fav = function ()
			--return lazy((ac["mtf_status"]() * 0.5) + (ac["commander_alive"]() * 1) +  (ac["dclass_status"]() * -1.5) + (ac["researcher_status"]() * 0.1) + 1 + (ac["scp_status"]() * -1.5) )
		--end,
		--display = "*WARNING* Prepare to be tagged!"
	--}
--}

local function AddAllIntsInList(list)
	local t = 0
	for k,v in pairs(list) do
		if isnumber(v) then
			t = t + v
		else
			print("Key " .. tostring(k) .. " does not have an integer value!")
		end
	end
	return t
end

timer.Create("RegenerateSamsura", 1, 0 , function ()
	for k,v in pairs(player.GetAll()) do
		if v:GetNClass() == ROLE_TAU5 then
			v:SetHealth(math.Clamp(v:Health() + 2, 0, v:GetMaxHealth()))
		end
	end
end)

hook.Add("EntityTakeDamage", "SamsuraTakeDamage", function (v, dmg)
	if v and IsValid(v) and v:IsPlayer() and v:GetNClass() == ROLE_TAU5 then
		dmg:ScaleDamage(0.90)
	end
end)



local function ChooseKeyWeight(t)
	local a = {}
	for k,v in pairs(t) do
		if v > 0 then
			a[k] = math.ceil(v)
		end
	end
	local sum = AddAllIntsInList(a)
	local rand = math.random(1, sum)
	for k,v in pairs(a) do
		rand = rand - v
		if rand <= 0 then
			return k --Return this squad id
		end
	end
	ServerLog("[BREACH] Error in init.lua, unexpected condition in function ChooseKeyWeight!\n")
	return "ntf"
end

local function CalcRespawnAmt()
	if #player.GetAll() <= 20 then
		return 3
	elseif #player.GetAll() <= 30 then
		return 4
	else
		return 5
	end
end

function SpawnNTFS()
	BroadcastGameMsg("Ammo has been restocked!")
	RestockAmmo()
	if roundtype.allowntfspawn == false then return end
	--if spawnedntfs > 6 then return end
	local tab = {}
	for k,v in pairs(SQUADS) do
		local f = math.ceil(v["calc_fav"]())
		if f >= 1 then
			tab[k] = f
		end
	end
	local sq = ChooseKeyWeight(tab)
	local deb = ""
	for k,v in pairs(tab) do
		deb = deb .. tostring(v) .. " "
	end
	deb = deb .. " -> " .. (sq or "err_ntf")
	ServerLog("[BREACH] Task Force: " .. deb .. "\n")
	local plys = {}
	local allspecs = GetNotAFKSpecs()
	local num = math.Clamp(#allspecs, 0, CalcRespawnAmt())
	for i = 1, num do
		local x = table.Random(allspecs)
		plys[#plys + 1] = x
		table.RemoveByValue(allspecs, x)

	end
	local so = SQUADS[sq or "ntf"] or SQUADS["ntf"]
	if so then
		so["func"](plys)
		--TODO, use net library here
		hook.Run("OnNTFSpawn", plys)
		BroadcastLua('surface.PlaySound("'.. so["snd"] ..'")')
		BroadcastGameMsg(so["display"])
	else
		ServerLog("Fatal error in init.lua, task force spawn aborted.")
	end
end

function SpawnDream()
	if roundtype.allowntfspawn == false then return end
	local tab = {}
	for k,v in pairs(DREAM) do
		local f = math.ceil(v["calc_fav"]())
		if f >= 1 then
			tab[k] = f
		end
	end
	local sq = ChooseKeyWeight(tab)
	local deb = ""
	for k,v in pairs(tab) do
		deb = deb .. tostring(v) .. " "
	end
	deb = deb .. " -> " .. (sq or "err_ntf")
	ServerLog("[BREACH] Task Force: " .. deb .. "\n")
	local plys = {}
	local allspecs = GetNotAFKSpecs()
	local num = math.Clamp(#allspecs, 0, CalcRespawnAmt())
	for i = 1, num do
		local x = table.Random(allspecs)
		plys[#plys + 1] = x
		table.RemoveByValue(allspecs, x)

	end
	local so = DREAM[sq or "ntf"] or DREAM["ntf"]
	if so then
		so["func"](plys)
	else
		ServerLog("Fatal error in init.lua, task force spawn aborted.")
	end
end

--function SpawnTree()
	--if roundtype.allowntfspawn == false then return end
	--local tab = {}
	--for k,v in pairs(TREE) do
		--local f = math.ceil(v["calc_fav"]())
		--if f >= 1 then
			--tab[k] = f
		--end
	--end
	--local sq = ChooseKeyWeight(tab)
	--local deb = ""
	--for k,v in pairs(tab) do
		--deb = deb .. tostring(v) .. " "
	--end
	--deb = deb .. " -> " .. (sq or "err_ntf")
	--ServerLog("[BREACH] Task Force: " .. deb .. "\n")
	--local plys = {}
	--local allply = GetAlivePlayers()
	--local num = math.Clamp(#allply, 0, CalcRespawnAmt())
	--for i = 1, num do
		--local x = table.Random(allply)
		--plys[#plys + 1] = x
		--table.RemoveByValue(allply, x)

	--end
	--local so = TREE[sq or "ntf"] or TREE["ntf"]
	--if so then
		--so["func"](plys)
	--else
		--ServerLog("Fatal error in init.lua, task force spawn aborted.")
	--end
--end

function OldSpawnNTFS()
	SpawnNTFS()
end

function ForceUse(ent, on, int)
	for k,v in pairs(player.GetAll()) do
		if v:Alive() then
			ent:Use(v,v,on, int)
		end
	end
end
function SetRDCState(desired)
	hook.Run("BreachMap_SetRDCState", desired)
end
function OpenGateA()
	hook.Run("BreachMap_ToggleGateA")
end

buttonstatus = 0
lasttime914b = 0
function Use914B(activator, ent)
	if CurTime() < lasttime914b then return end
	lasttime914b = CurTime() + 1.3
	ForceUse(ent, 1, 1)
	if buttonstatus == 0 then
		buttonstatus = 1
		activator:PrintMessage(HUD_PRINTTALK, "Changed to coarse")
	elseif buttonstatus == 1 then
		buttonstatus = 2
		activator:PrintMessage(HUD_PRINTTALK, "Changed to 1:1")
	elseif buttonstatus == 2 then
		buttonstatus = 3
		activator:PrintMessage(HUD_PRINTTALK, "Changed to fine")
	elseif buttonstatus == 3 then
		buttonstatus = 4
		activator:PrintMessage(HUD_PRINTTALK, "Changed to very fine")
	elseif buttonstatus == 4 then
		buttonstatus = 0
		activator:PrintMessage(HUD_PRINTTALK, "Changed to rough")
	end
end

lasttime914 = 0
function Use914(ent)
	if CurTime() < lasttime914 then return end
	print("use 914")
	lasttime914 = CurTime() + 20
	ForceUse(ent, 0, 1)
	local pos = ENTER914
	local pos2 = EXIR914
	timer.Create("914Use", 1, 1, function()
		for k,v in pairs(ents.FindInSphere( pos, 100 )) do
			if v.betterone != nil or v.GetBetterOne != nil then
				local useb
				if v.betterone then useb = v.betterone end
				if v.GetBetterOne then useb = v:GetBetterOne() end
				local betteritem = ents.Create( useb )
				if IsValid( betteritem ) then
					betteritem:SetPos( pos2 )
					betteritem:Spawn()
					WakeEntity(betteritem)
					v:Remove()
				end
			end
		end
	end)
	timer.Create("914Use2953", 3, 1, function()
		for k,v in pairs(ents.FindInSphere( pos, 50 )) do
			if v:IsPlayer() and v:GetNClass() == ROLE_SCP2953 then
				v:SetSCP2953UP()
			end
		end
	end)
	timer.Create("914Use2953", 10, 1, function()
		for k,v in pairs(ents.FindInSphere( pos, 50 )) do
			if v:IsPlayer() and v:GetNClass() != ROLE_SCP2953 and v:Team() != TEAM_SCP and buttonstatus == 4 then
				v:SetNWString("914UP", "4")
				v:SetWalkSpeed(500)
				timer.Simple(100, function()
				if v:GetNWString("914UP", "unset") == "4" then
				v:Kill()
					end
				end)
			elseif v:IsPlayer() and v:GetNClass() != ROLE_SCP2953 and v:Team() != TEAM_SCP and buttonstatus == 3 then
				v:SetNWString("914UP", "3")
				v:SetWalkSpeed(250)
				timer.Simple(200, function()
				if v:GetNWString("914UP", "unset") == "3" then
				v:Kill()
					end
				end)
			elseif v:IsPlayer() and v:GetNClass() != ROLE_SCP2953 and v:Team() != TEAM_SCP and buttonstatus == 2 then
				if v:Team() == TEAM_CLASSD and v:GetNClass() != ROLE_SCP035 then
					v:SetModel(v:GetSciModel(TEAM_CLASSD))
				elseif v:Team() == TEAM_SCI then
					v:SetModel(v:GetSciModel(TEAM_SCI))
				end
			elseif v:IsPlayer() and v:GetNClass() != ROLE_SCP2953 and v:Team() != TEAM_SCP and buttonstatus == 1 then
				v:SetBleeding(true)
			elseif v:IsPlayer() and v:GetNClass() != ROLE_SCP2953 and v:Team() != TEAM_SCP and buttonstatus == 0 then
				v:Kill()
			end
		end
	end)
end

function CloseSCPDoors()
	hook.Run("Breach_CloseSCPDoors")
end

function OpenSCPDoors()
	hook.Run("BreachMap_OpenSCPDoors")
end

function GetAlivePlayers()
	local plys = {}
	for k,v in pairs(player.GetAll()) do
		if v:Team() != TEAM_SPEC then
			if v:Alive() then
				table.ForceInsert(plys, v)
			end
		end
	end
	return plys
end

function GM:GetFallDamage( ply, speed )
	--return ( speed / 6 )
	return math.max( 0, math.ceil( 0.2418 * speed - 141.75 ) )
end

--This seems silly
function PlayerCount()
	return #player.GetAll()
end

function CheckPLAYER_SETUP()
	local si = 1
	for i=3, #PLAYER_SETUP do
		local v = PLAYER_SETUP[si]
		local num = v[1] + v[2] + v[3] + v[4]
		if i != num then
			print(tostring(si) .. " is not good: " .. tostring(num) .. "/" .. tostring(i))
		else
			print(tostring(si) .. " is good: " .. tostring(num) .. "/" .. tostring(i))
		end
		si = si + 1
	end
end


function CheckThings()
end

function GM:OnEntityCreated( ent )
	ent:SetShouldPlayPickupSound( false )
end

timer.Create("Bleeding:DamagePlayers", 1.5, 0, function ()
	for k,v in pairs(player.GetAll()) do
		if v:GetNWBool("is_bleeding", false) then
			v:TakeBleedDamage(math.random(1,2))
		end
	end
end)

timer.Create("Decomposing:DamagePlayers", 1.5, 0, function ()
	for k,v in pairs(player.GetAll()) do
		if v:GetNWBool("is_decomposing", false) then
			v:TakeDecompDamage(math.random(5,7))
		end
	end
end)
