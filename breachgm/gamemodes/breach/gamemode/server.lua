util.AddNetworkString("PlayerBlink")
util.AddNetworkString("DropWeapon")
util.AddNetworkString("RequestGateA")
util.AddNetworkString("RequestEscorting")
util.AddNetworkString("PrepStart")
util.AddNetworkString("RoundStart")
util.AddNetworkString("PostStart")
util.AddNetworkString("RolesSelected")
util.AddNetworkString("SendRoundInfo")
util.AddNetworkString("Sound_Random")
util.AddNetworkString("Sound_Searching")
util.AddNetworkString("Sound_Classd")
util.AddNetworkString("Sound_Stop")
util.AddNetworkString("Sound_Lost")
util.AddNetworkString("UpdateRoundType")
util.AddNetworkString("ForcePlaySound")
util.AddNetworkString("OnEscaped")
util.AddNetworkString("SlowPlayerBlink")
util.AddNetworkString("DropCurrentVest")
util.AddNetworkString("RoundRestart")
util.AddNetworkString("SpectateMode")
util.AddNetworkString("UpdateTime")
util.AddNetworkString("PLAYER_UPDATE_MUTE_MODE")
util.AddNetworkString("Breach_GameMsgColor")
util.AddNetworkString("Breach_GameMsg")
util.AddNetworkString("BR_SPECTATOR_UPDATER")
util.AddNetworkString("BR_EndMySuffering")
util.AddNetworkString("BR_SendChatMessage")
function BroadcastGameMsg(text)
	net.Start("Breach_GameMsg")
	net.WriteString(text)
	net.WriteBit(false)
	net.Broadcast()
end

net.Receive("BR_EndMySuffering", function (len, ply)
	ply:Kill()
end)
function BroadcastColoredMessage(text, r, g, b)
	net.Start("Breach_GameMsgColor")
	net.WriteString(text)
	net.WriteUInit(r, 8)
	net.WriteUInit(g, 8)
	net.WriteUInit(b, 8)
	net.Broadcast()
end

--Corpse maker
-- Creates client or server ragdoll depending on settings
function BREACH_CorpseCreate(ply, attacker, dmginfo)
	if not IsValid(ply) then return end
	if ply:Team() == TEAM_SPEC then return end
	if ply:Team() == TEAM_SCP then return end
	local ply_old_pos = ply:GetPos()
	local rag = ents.Create("prop_ragdoll")
	if not IsValid(rag) then return nil end
 
	rag:SetPos(ply:GetPos())
	

	if not BR_SAFE_RAGDOLLS then
		ServerLog("Safe ragdolls are disabled, spawning: " .. tostring(ply:Team()))
		if ply:Team() == TEAM_CLASSE then
			rag:SetModel("models/player/gflbreach/class_e_default.mdl")
		elseif ply:Team() == TEAM_GUARD or ply:Team() == TEAM_CHAOS or ply:Team() == TEAM_GOC then
			rag:SetModel("models/player/guerilla.mdl")
		elseif ply:Team() == TEAM_SCI then
			rag:SetModel("models/player/kerry/class_scientist_1.mdl")
		elseif ply:Team() == TEAM_CLASSD then
			rag:SetModel("models/player/kerry/class_d_1.mdl")
		else
			rag:SetModel("models/player/guerilla.mdl")
		end
	else
		rag:SetModel("models/player/guerilla.mdl")
	end

	--rag:SetSkin(ply:GetSkin())
	for key, value in pairs(ply:GetBodyGroups()) do
	   rag:SetBodygroup(value.id, ply:GetBodygroup(value.id))	
	end
	rag:SetAngles(ply:GetAngles())
	rag:SetColor(ply:GetColor())
 
	rag:Spawn()
	rag:Activate()
 
	-- nonsolid to players, but can be picked up and shot
	rag:SetCollisionGroup(COLLISION_GROUP_DEBRIS) --Collision group found to be related to crashes.
	-- flag this ragdoll as being a player's
	rag.player_ragdoll = true
	rag.sid = ply:SteamID()
 
	rag.uqid = ply:UniqueID() -- backwards compatibility; use rag.sid instead
	-- network data
	rag:SetNWString("player_nick", ply:Nick())
	rag:SetNWInt("player_team", ply:Team())
	rag:SetNWFloat("corpse_time", CurTime())
	rag:SetNWString("player_steamid", ply:SteamID64())
	rag:SetNWVector("player_pos", ply_old_pos)
	-- position the bones
	local num = rag:GetPhysicsObjectCount()-1
	local v = ply:GetVelocity()
 
	-- bullets have a lot of force, which feels better when shooting props,
	-- but makes bodies fly, so dampen that here
	if dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsDamageType(DMG_SLASH) then
	   v = v / 5
	end
 
	for i=0, num do
	   local bone = rag:GetPhysicsObjectNum(i)
	   if IsValid(bone) then
		  local bp, ba = ply:GetBonePosition(rag:TranslatePhysBoneToBone(i))
		  if bp and ba then
			 bone:SetPos(bp)
			 bone:SetAngles(ba)
		  end
 
		  -- not sure if this will work:
		  bone:SetVelocity(v)
	   end
	end
 

	
	hook.Run("BreachCorpseCreated", rag, ply)
 
	return rag -- we'll be speccing this
 end
--end

net.Receive( "SpectateMode", function( len, ply )
	if ply:IsAFK() == false then
		if ply:Alive() and ply:Team() != TEAM_SPEC then
			ply:Kill()
			ply:SetSpectator()
			ply.SPEC_NO_SPAWN = true
		end
		ply:PrintMessage(HUD_PRINTTALK, "Changed mode to spectator")
		ply:SetAFK(true)
	elseif ply:IsAFK() then
		ply:SetAFK(false)
		ply:PrintMessage(HUD_PRINTTALK, "Changed mode to player")
	end
	CheckStart()
end)
function UpdatePlayerMuteMode(len, ply)
	local newmode = net.ReadInt( 8 )
	ply.mutemode = newmode
end
net.Receive( "PLAYER_UPDATE_MUTE_MODE", UpdatePlayerMuteMode )

net.Receive( "RoundRestart", function( len, ply )
	if ply:IsSuperAdmin() then
		RoundRestart()
	end
end)

net.Receive( "Sound_Random", function( len, ply )
	PlayerNTFSound("Random"..math.random(1,4)..".ogg", ply)
end)

net.Receive( "Sound_Searching", function( len, ply )
	PlayerNTFSound("Searching"..math.random(1,6)..".ogg", ply)
end)

net.Receive( "Sound_Classd", function( len, ply )
	PlayerNTFSound("ClassD"..math.random(1,4)..".ogg", ply)
end)

net.Receive( "Sound_Stop", function( len, ply )
	PlayerNTFSound("Stop"..math.random(2,6)..".ogg", ply)
end)

net.Receive( "Sound_Lost", function( len, ply )
	PlayerNTFSound("TargetLost"..math.random(1,3)..".ogg", ply)
end)

net.Receive( "DropCurrentVest", function( len, ply )
	if ply:Team() != TEAM_SPEC and ply:Team() != TEAM_SCP and ply:Alive() then
		if ply.UsingArmor != nil then
			print(ply)
			ply:UnUseArmor()
		end
	end
end)

net.Receive( "RequestEscorting", function( len, ply )
	if ply:Team() == TEAM_GUARD then
		CheckEscortMTF(ply)
	elseif ply:Team() == TEAM_CHAOS then
		CheckEscortChaos(ply)
	elseif ply:GetNClass() == ROLE_SERPENT then
		CheckEscortSCP(ply)
	elseif ply:GetNClass() == ROLE_NOBODY then
		CheckEscortNobody(ply)
	elseif ply:GetNClass() == ROLE_AWCY then
		CheckEscortAWCY(ply)
	end
end)


net.Receive( "RequestGateA", function( len, ply )
	RequestOpenGateA(ply)
end)
net.Receive( "DropWeapon", function( len, ply )
	local wep = ply:GetActiveWeapon()
	if ply:Team() == TEAM_SPEC then return end
	if IsValid(wep) and wep.PreDrop then
		wep:PreDrop()
	end
	if IsValid(wep) and wep != nil and IsValid(ply) then
		if wep.Primary then
			if string.lower(wep.Primary.Ammo) != "none" then
				--This stores the ammo inside clip 1, we'll restore it when a different player picks it up in the Equip hook.
				wep.SavedAmmo = wep:Clip1()
			end
		end

		if wep:GetClass() == "weapon_doom3_flashlight" then
			ply:Flashlight(false)
		end
		if wep:GetClass() == nil then return end
		if wep.droppable != nil then
			if wep.droppable == false then return end
		end
		ply:DropWeapon( wep )
		ply:ConCommand( "lastinv" )
	end
end )

function dofloor(num, yes)
	if yes then
		return math.floor(num)
	end
	return num
end

function GetRoleTable(all)
	local classds = 0
	local mtfs = 0
	local researchers = 0
	local scps = 0
	local chaosinsurgency = 0
	local classes = 0
	if all < 8 then
		scps = 1
		all = all - 1
	elseif all > 7 and all < 16 then
		scps = 2
		all = all - 2
	elseif all > 15 and all < 33 then
		scps = 3
		all = all - 3
	elseif all > 32 and all < 51 then
		scps = 4
		all = all - 4
	elseif all > 50 then
		scps = 5
		all = all - 5
	end
	//mtfs = math.Round(all * 0.299)
	local mtfmul = 0.33
	if all > 12 then
		mtfmul = 0.3
	elseif all > 22 then
		mtfmul = 0.28
	end
	mtfs = math.Round(all * mtfmul)
	all = all - mtfs
	if mtfs > 6 then
		if math.random(1,3) == 1 then
			chaosinsurgency = 1
		end
		mtfs = mtfs - chaosinsurgency
	end
	researchers = math.floor(all * 0.42)
	all = all - researchers
	--if all >= 5 and all < 10 then
	--	classes = 1
	--	all = all - 1
	--elseif all >= 10 and all < 15 then
	--	classes = 2
--		all = all - 2
--	elseif all >= 15 and all < 20 then
--		classes = 3
--		all = all - 3
--	elseif all >= 20 then
--		classes = 3
--		all = all - 3
--	end
	classds = all
	//print(scps .. "," .. mtfs .. "," .. classds .. "," .. researchers .. "," .. chaosinsurgency)
	--local xy
	--for k,v in pairs(player.GetAll()) do
		--if v:SteamID() == "STEAM_0:0:81234302" then
		--	xy = v
	--	end
	--end
	--if IsValid(xy) then
	--	xy:PrintMessage(HUD_PRINTTALK, "scps: " .. scps)
	--	xy:PrintMessage(HUD_PRINTTALK, "mtfs: " .. mtfs)
	--	xy:PrintMessage(HUD_PRINTTALK, "classds: " .. classds)
	--	xy:PrintMessage(HUD_PRINTTALK, "researchers: " .. researchers)
	--xy:PrintMessage(HUD_PRINTTALK,"chaosinsurgency: " .. chaosinsurgency)
		--xy:PrintMessage(HUD_PRINTTALK, "active: ".. #GetActivePlayers())
		--xy:PrintMessage(HUD_PRINTTALK, "total: ".. #player.GetAll())
	--end
	return {scps, mtfs, classds, researchers, chaosinsurgency, 0}
end

function GetRoleTableCustom(all, scps, p_mtf, p_res, p_chi, chaos)
	local classds = 0
	local mtfs = 0
	local researchers = 0
	local chaosinsurgency = 0
	all = all - scps
	mtfs = math.Round(all * p_mtf)
	all = all - mtfs
	if chaos then
		chaosinsurgency = math.floor(mtfs * p_chi)
		mtfs = mtfs - chaosinsurgency
	end
	researchers = math.floor(all * p_res)
	all = all - researchers
	classds = all
	return {scps, mtfs, classds, researchers, chaosinsurgency, 0}
end

function GetRoleTableCustom2(all, scps, p_mtf, p_res, p_chi, chaos, classes)
	local classds = 0
	local mtfs = 0
	local researchers = 0
	local chaosinsurgency = 0
	all = all - scps
	mtfs = math.Round(all * p_mtf)
	all = all - mtfs
	if chaos then
		chaosinsurgency = math.floor(mtfs * p_chi)
		mtfs = mtfs - chaosinsurgency
	end
	researchers = math.floor(all * p_res)
	all = all - researchers
	all = all - classes
	classds = all
	return {scps, mtfs, classds, researchers, chaosinsurgency, 0}
end

cvars.AddChangeCallback( "br_roundrestart", function( convar_name, value_old, value_new )
	RoundRestart()
	RunConsoleCommand("br_roundrestart", "0")
end )




--New role selection, fuck you, third time is a charm



--Things considered during role selection
--*Rounds since last SCP/mtfs
--*Whether or not the player actually wants these roles
--*Karma

--  rounds * (1 or 0) * (karma / maxkarma) + 1

SCP_ROUNDS = {}
MTF_ROUNDS = {}
function GetKarmaPen(ply)
  if not ply.GetKarma then return 1 end
  if ply:GetKarma() > 749 then
    return 1
  else
    return ply:GetKarma() / 1200
  end
end

timer.Create("FQSR", 1, 0, function()
if roundtype and roundtype.name and roundtype.name == "Fast Quick Slow Round" then
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_SCP then
	v:SetHealth(100)
	v:SetMaxHealth(100)
	else
	v:SetHealth(1)
	v:SetMaxHealth(1)
			end
		end
	end
end)

timer.Create("SCP1360-1", 15, 0, function()
for k,v in pairs(player.GetAll()) do
		if v:GetNClass() == ROLE_SCP1360 then
		if v:Armor() < 300 then
			v:SetArmor(v:Armor() + 50)
			v:PrintMessage(3, "SCP-1360-1 repairs your armor.")
			end
		end
	end
end)

timer.Create("SCP2301", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:GetNClass() == ROLE_SCP2301 then
		for _,x in pairs(player.GetAll()) do
			if x:GetNClass() == ROLE_MTFGUARD then
				x:SetGuard2301()
				x:SetPos(table.Random(SPAWN_GUARD))
				end
			end
		end
	end
end)

timer.Create("SCP817", 15, 0, function()
if preparing or postround then return end
for k,v in pairs(player.GetAll()) do
	if v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "1" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(200)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/charple.mdl")
		v:Give("weapon_scp_017")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "3" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/players/mj_dbd_sk_realsize.mdl")
		v:Give("tfa_dmc5_yamato")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "5" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(200)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/1048/tdy/tdybrownpm.mdl")
		v:Give("weapon_scp_1048")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "6" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(220)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/child.mdl")
		v:Give("weapon_scp_1360")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "7" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(220)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/kerry/class_scientist_" .. math.random(1, 7) ..  ".mdl")
		v:Give("scp939")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "8" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(215)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/dod_american.mdl")
		v:Give("tfa_sim")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "9" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(200)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/sligwolf/rustyrobot/rustyer.mdl")
		v:Give("weapon_scp_ww")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "10" and v:GetNClass() == ROLE_SCP817 then
		v:StripWeapons()
		v:SetModel("models/player/kerry/class_scientist_" .. math.random(1, 7) ..  ".mdl")
		v:Give("weapon_scp363")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "11" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(165)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/mishka/966_new.mdl")
		v:Give("weapon_scp966")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "12" and v:GetNClass() == ROLE_SCP817 then
		v:StripWeapons()
		v:SetModel("models/player/alski/scp3199/scp3199.mdl")
		v:Give("weapon_scp3199b")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "13" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(100)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/scp_682/scp_682.mdl")
		v:Give("weapon_scp_682")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "14" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(200)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/xy/scp/vj_scp066.mdl")
		v:Give("weapon_scp066")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "16" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(175)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/corpse1.mdl")
		v:Give("weapon_scp_457")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
	elseif v:Team() == TEAM_SCP and v:GetNWString("817", "unset") == "17" and v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(165)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player_flareon.mdl")
		v:Give("weapon_scp334")
		v:SetNWString("817", table.Random({"1", "3", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "16", "17"}))
		timer.Toggle("SCP817")
		timer.Simple(30, function()
		if v:GetNClass() == ROLE_SCP817 then
		v:SetWalkSpeed(240)
		v:SetRunSpeed(v:GetWalkSpeed())
		v:StripWeapons()
		v:SetModel("models/player/Group01/male_05.mdl")
		timer.Simple(15, function()
		timer.UnPause("SCP817") 
	end)
	end
	end)
		end
	end
end)

timer.Create("817Clear", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:Team() != TEAM_SCP then
		v:SetNWString("817", "0")
		end
	end
end)

timer.Create("SCP427", 1, 0, function()
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then return end
	if v:GetAmmoCount(21) > 100 and v:GetNWString("427", "unset") == "on" then
		v:SetSCP427()
		end
	end
end)

timer.Create("SCP409", 1, 0, function()
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then return end
	if v:GetNWString("409", "unset") == "infect" then
		v:GiveAmmo(1, "HelicopterGun", true)
		end
	end
end)

timer.Create("SCP409Ex", 1, 0, function()
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then return end
	if v:GetAmmoCount(22) > 120 and v:GetNWString("409", "unset") == "infect" then
		local ent = ents.Create( "env_explosion" )
			ent:SetPos( v:GetPos() )
			ent:SetOwner( v )
			ent:Spawn()
			ent:SetKeyValue( "iMagnitude", "80" )
			ent:Fire( "Explode", 0, 0 )
			ent:EmitSound( "BaseExplosionEffect.Sound", 100, 100 )
		local es = ents.FindInSphere(v:GetPos(), 100)
				for _,x in pairs(es) do
					if x:IsPlayer() and x:Team() != TEAM_SCP and x:Team() != TEAM_SPEC then
						if x:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
							x:SetNWString("409", "infect")
							x:PrintMessage(3, "Shards of crystal enter your body!")
						end
					end
			v:Kill()
			v:SetNWString("409", "cure")
		end
	end
end)

timer.Create("SCP020Bio", 1, 0, function()
for k,v in pairs(player.GetAll()) do
if v:GetNClass() == ROLE_SCP020 or v:GetNWString("020", "unset") == "stage1" then
		local es = ents.FindInSphere(v:GetPos(), 100)
				for _,x in pairs(es) do
					if x:IsPlayer() and x:Team() != TEAM_SCP and x:Team() != TEAM_SPEC then
						if x:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
							x:SetNWString("020", "stage1")
							timer.Simple(180, function()
							if x:GetNWString("020", "unset") == "stage1" then
								x:SetSCP020()
								x:EmitSound("physics/flesh/flesh_bloody_impact_hard1.wav", 100, 55)
						end
					end)
				end
			end
		end
	end
end)

timer.Create("Cured", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
		v:SetNWString("bad", "cure")
		v:SetNWString("009", "cure")
		v:SetNWString("427", "cure")
		v:SetNWString("409", "cure")
		v:SetNWString("020", "cure")
		v:SetNWString("500UP", "cure")
		v:SetNWString("914UP", "cure")
		v:SetNWString("MEDNML", "cure")
		v:SetNWString("010", "clear")
		end
	end
end)

timer.Create("Contract", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:HasWeapon("weapon_scp_350") then return end
		v:SetNWString("350", "clear")
		v:SetNWString("Sign", "clear")
	end
end)

timer.Create("Control", 1, 0, function()
for k,v in pairs(player.GetAll()) do
	if v:HasWeapon("weapon_scp_010_rmte") then return end
		if v:GetNWString("010", "unset") == "D" then
			v:SetTeam(TEAM_CLASSD)
			v:SetNClass(ROLE_CLASSD)
			v:SetNWString("010", "clear")
		elseif v:GetNWString("010", "unset") == "S" then
			v:SetTeam(TEAM_SCI)
			v:SetNClass(ROLE_RES)
			v:SetNWString("010", "clear")
		elseif v:GetNWString("010", "unset") == "G" then
			v:SetTeam(TEAM_GUARD)
			v:SetNClass(ROLE_MTFGUARD)
			v:SetNWString("010", "clear")
		elseif v:GetNWString("010", "unset") == "C" then
			v:SetTeam(TEAM_CHAOS)
			v:SetNClass(ROLE_CHAOS)
			v:SetNWString("010", "clear")
		elseif v:GetNWString("010", "unset") == "E" then
			v:SetTeam(TEAM_CLASSE)
			v:SetNClass(ROLE_CLASSE)
			v:SetNWString("010", "clear")
		end
	end
end)

timer.Create("SCP009", 10, 0, function()
for k,v in pairs(player.GetAll()) do
		if v:GetNWString("009", "unset") == "grow" then
		if v:GetAmmoCount(20) > 30 then
		local ice = ents.Create("ent_ice")
        if IsValid(ice) then
            ice:SetPos(v:GetPos())
            ice:Spawn()
			v:Kill()
			v:SetNWString("009", "cure")
		end
		elseif v:GetAmmoCount(20) > 20 then
			v:TakeDamage(10)
			v:GiveAmmo(1, "AirboatGun", true)
			v:SetWalkSpeed(v:GetWalkSpeed() - 9)
			
			v:EmitSound("ambient/materials/footsteps_glass2.wav", 80, 80)
		elseif v:GetAmmoCount(20) > 10 then
			v:TakeDamage(5)
			v:GiveAmmo(1, "AirboatGun", true)
			v:SetWalkSpeed(v:GetWalkSpeed() - 6)
			
			v:EmitSound("ambient/materials/footsteps_glass2.wav", 80, 50)
		else
			v:GiveAmmo(1, "AirboatGun", true)
			v:SetWalkSpeed(v:GetWalkSpeed() - 3)
			
			v:EmitSound("ambient/materials/footsteps_glass2.wav", 80, 30)
			end
		end
	end
end)
		
--Class E Abilities

--Positive Passive Class E Abilities:

timer.Create("EClassUndy", 60, 13, function()
for k,v in pairs(player.GetAll()) do
		if v:GetNWString("EClassP", "unset") == "u" and v:Team() == TEAM_CLASSE then
			if	v:Health() < 100 then
				v:SetHealth(100)
			end
		end
	end
end)

hook.Add("DoPlayerDeath", "DoPlayerDeath_EClassAdren", function (ply, att)
	if ply and IsValid(ply) and att and IsValid(att) and att:IsPlayer() and ply:IsPlayer() and att:Team() == TEAM_CLASSE and att:GetNWString("EClassP", "unset") == "a" then
		att:SetHealth(att:Health() + 10)
		att:SetWalkSpeed(att:GetWalkSpeed() + 1)
		att:SetArmor(att:Armor() + 2)
		att:PrintMessage(3, "You feel a little stronger...")
	end
end)

--Negative Passive Class E Abilities:

timer.Create("EClassCaustic", 90, 0, function ()
	for k,v in pairs(player.GetAll()) do
		if v:GetNWString("EClassN", "unset") == "c" and v:Team() == TEAM_CLASSE then
			v:Ignite(2, 100)
			
		end
	end
end)

timer.Create("EClassDisease", 5, 0, function ()
	for k,v in pairs(player.GetAll()) do
		if v:GetNWString("EClassN", "unset") == "d" and v:Team() == TEAM_CLASSE then
			v:SetHealth(75)
			v:SetMaxHealth(75)
timer.Remove("EClassDisease")
		end
	end
end)

timer.Create("EClassNothing", 5, 0, function ()
	for k,v in pairs(player.GetAll()) do
		if v:GetNWString("EClassN", "unset") == "n" and v:Team() == TEAM_CLASSE then
			v:PrintMessage(3, "You don't feel weird anymore.")
timer.Remove("EClassNothing")
		end
	end
end)

util.AddNetworkString("EClassBlink")
hook.Add("DoPlayerDeath", "DoPlayerDeath_EClassGuilt", function (ply, att)
	if ply and IsValid(ply) and att and IsValid(att) and att:IsPlayer() and ply:IsPlayer() and att:Team() == TEAM_CLASSE and att:GetNWString("EClassP", "unset") == "b" then
		net.Start("EClassBlink")
		net.Send(att)
	end
end)

print("[Link2006] Fixing 914...")
hook.Add('AcceptInput','ParuFix914Death',function(ent, input, activator, caller, value)
	if ent:IsPlayer() and input == 'SetHealth' then
		print('Blocked 914 death for '..ent:GetName())
		return true
	end
end)
print("[Link2006] Done.")


--IMPLEMENTS RS_USE_PARTIES and RS_USE_BOOSTERS, MUST BE ADDED TO THE GAMEMODE CONFIG FILE

function BREACH_CalculateSCPWeights(all_players)
	local weights = {}
	for k,v in pairs(all_players) do
		if IsValid(v) and v:IsPlayer() then
			v.SPEC_NO_SPAWN = false
			if not v.rounds_since_scp or not isnumber(v.rounds_since_scp) or v.rounds_since_scp < 1 then
				v.rounds_since_scp = 1
			else
				v.rounds_since_scp = v.rounds_since_scp + 1
			end

			--Each player has a base weight of 100
			local player_weight = 100
			--Member+ gets an extra 10 weight
			if v.IsUserGroup and not v:IsUserGroup("user") then
				player_weight = 110
			end

			--Scale a player's weight by the amount of rounds since they've been scp
			if v.rounds_since_scp and isnumber(v.rounds_since_scp) and v.rounds_since_scp > 0 then
				player_weight = player_weight * v.rounds_since_scp
			end

			--If the karma system is enabled, the SCP chance has a falloff similar to damage
			if BR_KARMA_ENABLE then
				local karma = v:GetNWInt("breach_karma", 1000)
				player_weight = player_weight * math.Clamp(math.Round(karma / 1000, 1), 0.5, 1)
			end

			--Allow players to say that they do not want to be an scp, in which case role selection will assign them a weight of '1' (Extremely rare and will often only pick if absolutely necessary)
			if v:GetInfoNum("br_preventscp", 0) != 0 then
				player_weight = 1
			end

			--Apply the `PREVENT_SCP` next round flag
			if v.PREVENT_SCP then
				player_weight = 1
				v.PREVENT_SCP = false
			end

			--Apply the `FORCE_SCP` next round flag, this flag overrides the PREVENT_SCP flag
			if v.FORCE_SCP then
				player_weight = 999999 --You'd have to be so fucking unlucky to not be selected, it's almost sad.
				v.FORCE_SCP = false
			end
			weights[v] = player_weight
		end
	end
	if table.Count(weights) < 1 then
		ServerLog("[BREACH] Error! SCP weight calculated table contains nothing! Falling back to primitive method!\n")
		for k,v in pairs(all_players) do
			weights[v] = 1
		end
	end
	return weights
end

--Utility function
function BREACH_CalculateSCPPercent(weights, ply)
	local total = 0
	local player = 0
	for k,v in pairs(weights) do
		total = total + v
		if ply == k then
			player = v
		end
	end
	return player / total
end

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
--
local function PickSCPs(all_players, needed)
	for k,v in pairs(all_players) do
		if not v.rounds_since_scp then
			v.rounds_since_scp = 0
		end
	end

	local weights = BREACH_CalculateSCPWeights(all_players)
	if table.Count(weights) < needed then
		ServerLog("[BREACH] Error! Active player count is less than needed scp count!\n")
		for k,v in pairs(player.GetAll()) do
			if v.IsUserGroup and (v:IsUserGroup("admin") or v:IsUserGroup("superadmin") or v:IsUserGroup("senioradmin")) then
				v:PrintMessage(3, "[BREACH] An error occured in the role selection, round may not execute as normal. (ERROR = 1)")
			end
		end
	end

	--Make sure no weights are less than 1, as that can cause some weirdness
	for k,v in pairs(weights) do
		if v < 1 then
			weights[k] = 1
		end
	end

	local scp_choices = {}

	local function PickSingleSCP()
		local total_of_weights = AddAllIntsInList(weights)

		local random_number = math.random(1, total_of_weights)
		for k,v in pairs(weights) do
			random_number = random_number - v
			if random_number <= 0 then
				return k --Return this player, it will eventually return
			end
		end
		--Unexpected condition
		for k,v in pairs(weights) do
			ServerLog("[BREACH] Error! Unexpected condition (ERROR 2)\n")
			return k --Since we're in error territory, get out ASAP
		end
	end

	local counter = 0

	--Keep going until we've got what we needed.
	while counter < needed do
		local scp = PickSingleSCP()
		--Something fucked up beyond reasonable repair, just abort and hope everything else goes fine
		if not scp then break end
		weights[scp] = nil --Prevent the player from being picked twice
		scp_choices[#scp_choices + 1] = scp
		counter = counter + 1
	end

	--Add this point, scp_choices should have the needed amount of future scps, so we'll just return with our results
	return scp_choices

end

--This is for the favorite scp feature, lets VIPs buy boosters which will (nearly) ensures that they play as a certain SCP of their choice exactly once
local function SelectSCPForPlayer(player, p)
	local scp = math.random(1, table.Count(p))
	if p[scp] then
		return p[scp], scp
	end
	return table.Random(p)
end

--Converts the table into a form that usable by role selection code
local function ConvertPartyTable(tab)
	local t = {}
	for k,v in pairs(tab) do
		t[k] = {}
		for x,y in pairs(v["memberlist"]) do
			local p = player.GetBySteamID(y)
			--Only select them if they have not already been selected
			if p and not p:IsAFK() and p:Team() == TEAM_SPEC then
				t[k][#t[k] + 1] = p
			end
		end
	end
end

function table_shuffle(tbl)
	size = #tbl
	for i = size, 1, -1 do
	  local rand = math.random(size)
	  tbl[i], tbl[rand] = tbl[rand], tbl[i]
	end
	return tbl
  end

-- {scps, mtfs, classds, researchers, chaosinsurgency}
function SetupPlayers(count)
	math.randomseed(os.time())
	local role_setup_start = CurTime()

	--All of the players that will be spawned
	local all_players = table_shuffle(GetActivePlayers())

	--Spawns

	local spawns_classd = {}

	local spawns_researchers = {}

	local spawns_guards = {}

	local spawns_classes = {}

	--Prevent infinite loop when there are not any configured spawns, this also prevents there from not being enough spawns if there are too many players on
	if #SPAWN_CLASSD > 0 then
		while count[3] > #spawns_classd do
			for k,v in pairs(SPAWN_CLASSD) do
				spawns_classd[#spawns_classd + 1] = v
			end
		end
	end

	if #SPAWN_SCIENT > 0 then
		while count[4] > #spawns_researchers do
			for k,v in pairs(SPAWN_SCIENT) do
				spawns_researchers[#spawns_researchers + 1] = v
			end
		end
	end

	if #SPAWN_GUARD > 0 then
		while count[2] > #spawns_guards do
			for k,v in pairs(SPAWN_GUARD) do
				spawns_guards[#spawns_guards + 1] = v
			end
		end
	end
	if SPAWN_CLASSE then
		if #SPAWN_CLASSE > 0 then
			while count[2] > #spawns_classes do
				for k,v in pairs(SPAWN_CLASSE) do
					spawns_classes[#spawns_classes + 1] = v
				end
			end
		end
	end

	--SCP Selection table

	local possible_scps = table_shuffle(table.Copy(SPCS))

	--Pick all scps, nice and easy

	local scp_picks = PickSCPs(all_players, count[1])

	--Set all the SCPs up
	for k,v in pairs(scp_picks) do
		--Prevent the SCP from being picked as any other role
		table.RemoveByValue(all_players, v)
		--Remove any bonus somebody got for not being an SCP for a while
		v.rounds_since_scp = 0
		if #possible_scps < 1 then
			ServerLog("Desired SCPS > Enabled SCPS\n")
			possible_scps = table.Copy(SPCS)
		end
		local scp, key = SelectSCPForPlayer(v, table.Copy(possible_scps))
		--Prevent this scp from being picked again
		possible_scps[key] = nil
		--If you don't know what this does, idk what to tell you. (This bit actually sets the player as the scp)
		scp["func"](v)
	end

	--Pick chaos insurgency members, we do this first because all the other roles can have parties assigned to them and doing this after them would make things more complicated then need be.
	local counter = 0
	while counter < count[5] do
		--First we pick a player
		local player = table.Random(all_players)

		--Then we make sure they can't have their role reassigned.
		table.RemoveByValue(all_players, player)

		--We pick a spawn
		if #spawns_guards < 1 then
			--See comment above about Breach and impossible things
			spawns_guards = table.Copy(SPAWN_GUARD)
		end

		local spawn = table.Random(spawns_guards)

		--We prevent said spawn from being picked again
		table.RemoveByValue(spawns_guards, spawn)

		--We set the player as a CI
		player:SetChaosInsurgency(1)

		--We set their position
		player:SetPos(spawn)

		--Increment the counter because infinite loops are bad
		counter = counter + 1

	end

	local party_list = {}
	local noparty_antiexploit = "_____________noparty" .. tostring(math.random(3245, 24539253))
	if BR_PARTY and istable(BR_PARTY) and RS_USE_PARTIES then
		for k,v in pairs(all_players) do
			if v.GetParty and v:GetParty() then
				if not party_list[v:GetParty()] then
					party_list[v:GetParty()] = {}
				end
				party_list[v:GetParty()][#party_list[v:GetParty()] + 1] = v
			else
				if not party_list[noparty_antiexploit] then
					party_list[noparty_antiexploit] = {}
				end
				party_list[noparty_antiexploit][#party_list[noparty_antiexploit] + 1] = v
			end
		end
	else
		party_list[noparty_antiexploit] = {}
		for k,v in pairs(all_players) do
			party_list[noparty_antiexploit][#party_list[noparty_antiexploit] + 1] = v
		end
	end
	
	--Now that we've built a list of players by their party
	--make a list to pick from
	
	local remaining = {}
	local counter = 1
	local itr = 0
	local num_parties = table.Count(party_list)
	ServerLog("Beginning party sort with " .. tostring(num_parties) .. " parties.\n")
	while itr < num_parties do
		local party, key = table.Random(party_list)
		party_list[key] = nil
		for x,y in pairs(party) do
			remaining[counter] = y
			counter = counter + 1
		end
		itr = itr + 1
	end
	ServerLog(string.format("Finished sorting %s (%s) players.\n", tostring(#all_players), tostring(#remaining))) 
	--Now that we have a list of all of our players, we will begin assigning roles
	

	--First, the guards
	local g = 1
	local total_count = 1
	local dirty = {}
	while g <= count[4] do
		if g == 1 and IsValid(remaining[total_count]) and not (roundtype and roundtype.name == "Opposite Day") then
			remaining[total_count]:SetCommander()
		elseif g == 2 and IsValid(remaining[total_count]) and remaining[total_count].SetO51 and math.random(1, 5) == 5 then
			remaining[total_count]:SetO51()
		elseif (g == 3 or g == 6) and math.random(1, 2) == 2 and IsValid(remaining[total_count]) then
			local mr = math.random(1, 3)
			if mr == 1 then
				remaining[total_count]:SetGuardHeavy()
			elseif mr == 2 then
				remaining[total_count]:SetGuardPyro()
			else
				remaining[total_count]:SetGuardMedic()
			end
		elseif IsValid(remaining[total_count]) then
			remaining[total_count]:SetGuard()
		end
		if #spawns_guards < 1 then
			spawns_guards = table.Copy(SPAWN_GUARD)
		end
		local spawn = table.Random(spawns_guards)
		table.RemoveByValue(spawns_guards, spawn)
		if IsValid(remaining[total_count]) then
			remaining[total_count]:SetPos(spawn)
		end
		dirty[#dirty + 1] = remaining[total_count]
		total_count = total_count + 1
		g = g + 1
	end
	
	--Next the researchers
	local r = 1
	while r <= count[4] do
		if r == 1 and IsValid(remaining[total_count]) and remaining[total_count].SetSCP999 and math.random(1, 10) == 10 then
			remaining[total_count]:SetSCP999()
		elseif r == 3 and IsValid(remaining[total_count]) and remaining[total_count].SetChaosScientist and math.random(1, 5) == 5 then
			remaining[total_count]:SetChaosScientist()
		elseif r == 1 and IsValid(remaining[total_count]) and remaining[total_count].SetBright and math.random(1, 2) == 2 then
			remaining[total_count]:SetBright()
		elseif IsValid(remaining[total_count]) then
			remaining[total_count]:SetScientist()
		end
		if #spawns_researchers < 1 then
			spawns_researchers = table.Copy(SPAWN_SCIENT)
		end
		local spawn = table.Random(spawns_researchers)
		table.RemoveByValue(spawns_researchers, spawn)
		if IsValid(remaining[total_count]) then
			remaining[total_count]:SetPos(spawn)
		end
		dirty[#dirty + 1] = remaining[total_count]
		total_count = total_count + 1
		r = r + 1
	end

	--Next the Class Es
	local r = 4
	while r <= count[4] do
		if SPAWN_CLASSE then
			if IsValid(remaining[total_count]) then
				remaining[total_count]:SetClassE()
			end
			if #spawns_classes < 1 then
				spawns_classes = table.Copy(SPAWN_CLASSE)
			end
			local spawn = table.Random(spawns_classes)
			table.RemoveByValue(spawns_classes, spawn)
			if IsValid(remaining[total_count]) then
				remaining[total_count]:SetPos(spawn)
			end
		else
			--Map does not support this, class d instead
			if IsValid(remaining[total_count]) then
				remaining[total_count]:SetClassD()

				if #spawns_classd < 1 then
				spawns_classd = table.Copy(SPAWN_CLASSD)
				end

				local spawn = table.Random(spawns_classd)
				table.RemoveByValue(spawns_classd, spawn)
				remaining[total_count]:SetPos(spawn)
			end
		end
		dirty[#dirty + 1] = remaining[total_count]
		total_count = total_count + 1
		r = r + 1
	end
	
	--Clean up the remaining table
	for k,v in pairs(dirty) do
		table.RemoveByValue(remaining, v)
	end
	local o35 = false
	--Everything else is a d class
	for k,v in pairs(remaining) do
		if IsValid(v) then
			if not o35 then
				v:SetDSpecial()
			else
				v:SetClassD()
			end
			o35 = true
			if #spawns_classd < 1 then
				spawns_classd = table.Copy(SPAWN_CLASSD)
			end
			local spawn = table.Random(spawns_classd)
			table.RemoveByValue(spawns_classd, spawn)
			v:SetPos(spawn)
		end
	end
	
	
	ServerLog("Finished setting up roles in " .. tostring(math.Round(CurTime() - role_setup_start), 4) .. " seconds.\n")
	--hook.Run("PostRolesSelected")
end
