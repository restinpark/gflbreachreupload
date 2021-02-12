--You know how when you compose functions it can get messy? That's basically what this is, a horrible combination of TTT and breach round code.

--TODO: Rewrite
--Or not

BREACH_VERSION = "v2.1.3"
-- Localise stuff we use often. It's like Lua go-faster stripes.
local math = math
local table = table
local net = net
local player = player
local timer = timer
local util = util

--Enums
ROUND_WAIT = 0
ROUND_PREP = 1
ROUND_ACTIVE = 2
ROUND_POST = 3

END_TIME = 0
END_SCPWIN = 1
END_FOUNDWIN = 2
END_CIWIN = 3
END_ERROR = 4
END_CANTCONTINUE = 5
--
//Every 10 rounds, do a map vote
MAPVOTE_RM = 999
SetGlobalFloat("br_round_end", -1)
SetGlobalInt("br_wintype", -1)

function SetRoundState(n)
	SetGlobalInt("Round_State_Breach", n )
end

function SetWinType(i)
	SetGlobalInt("br_wintype", i)
end

IS_FIRST_ROUND_OF_MAP = true

function GetRoundState()
	return GetGlobalInt( "Round_State_Breach", ROUND_WAIT )
end


---- Round mechanics
function INIT_ROUND_FUNCTIONS()


   -- Force friendly fire to be enabled. If it is off, we do not get lag compensation.
   --RunConsoleCommand("mp_friendlyfire", "1")


   SetRoundState(ROUND_WAIT)
   IsFirstRound = true



   -- For the paranoid
   math.randomseed(os.time())

   WaitForPlayers()

   if cvars.Number("sv_alltalk", 0) > 0 then
      ErrorNoHalt("BREACH WARNING: sv_alltalk is enabled. Dead players will be able to talk to living players. Breach will now attempt to set sv_alltalk 0.\n")
      RunConsoleCommand("sv_alltalk", "0")
   end


end

hook.Add("Initialize", "Breach_Round_functions", INIT_ROUND_FUNCTIONS)



local function EnoughPlayers()
   local ready = 0
   -- only count truly available players, ie. no forced specs
   for _, ply in pairs(player.GetAll()) do
      if IsValid(ply) and (not ply:IsAFK()) then
         ready = ready + 1
      end
   end
   return ready >= 2
end

-- Used to be in Think/Tick, now in a timer
function WaitingForPlayersChecker()
   if GetRoundState() == ROUND_WAIT then
      if EnoughPlayers() then
         timer.Create("wait2prep", 1, 1, PrepareRound)

         timer.Stop("waitingforply")
      end
   end
end

-- Start waiting for players
function WaitForPlayers()
   SetRoundState(ROUND_WAIT)

   if not timer.Start("waitingforply") then
      timer.Create("waitingforply", 2, 0, WaitingForPlayersChecker)
   end
end

-- When a player initially spawns after mapload, everything is a bit strange;
-- just making him spectator for some reason does not work right. Therefore,
-- we regularly check for these broken spectators while we wait for players
-- and immediately fix them.
function FixSpectators()
   for k, ply in pairs(player.GetAll()) do
      if ply:Team() == TEAM_SPEC and ply:Alive() and ply:GetMoveType() < MOVETYPE_NOCLIP then
         ply:Spectate(OBS_MODE_ROAMING)
      end
   end
end

function TotalLiving()
	local count = 0
	for k,v in pairs(player.GetAll()) do
		if v:Team() != TEAM_SPEC then
			count = count + 1
		end
	end
end





-- Used to be in think, now a timer
local function WinChecker()
   if GetRoundState() == ROUND_ACTIVE then
	if CurTime() > GetGlobalFloat("br_round_end", 0) then
		EndRound(END_TIME)
  end
	local scp26 = 0
	local scp999 = 0
	local scp990 = 0
	local scp1959 = 0
	for k,v in pairs(player.GetAll()) do
		if v.GetNClass and v:GetNClass() == ROLE_2639A then
			scp26 = scp26 + 1
		end
		if v.GetNClass and v:GetNClass() == ROLE_999 then
			scp999 = scp999 + 1
		end
		if v.GetNClass and v:GetNClass() == ROLE_SCP990 then
			scp990 = scp990 + 1
		end
		if v.GetNClass and v:GetNClass() == ROLE_SCP1959 then
			scp1959 = scp1959 + 1
		end
	end
    if #player.GetAll() < 2 then return end
	if preparing and zombieround then return end
	local endround = false
	local ds = team.NumPlayers(TEAM_CLASSD)
	local mtfs = team.NumPlayers(TEAM_GUARD)
	local res = team.NumPlayers(TEAM_SCI) - (scp999 + scp26 + scp990)
	local scps = team.NumPlayers(TEAM_SCP) - (scp1959)
	local classes = team.NumPlayers(TEAM_CLASSE)
	local gocs = team.NumPlayers(TEAM_GOC)
	--Neutrals don't delay the round
	--SCP-1959 wont delay the round
	local chaos = team.NumPlayers(TEAM_CHAOS)
	local all = #GetAlivePlayers() - (scp999 + scp26 + scp990 + scp1959)
	//print(ds)
	//print(mtfs)
	//print(res)
	//print(scps)
	//print(chaos)
	//print(all)
	local lr = END_ERROR
	if oh5round and res < 1 then
		endround = true
		lr = END_FOUNDWIN
	end
	--local nineninenine = 0
	--for k,v in pairs(GetAlivePlayers()) do
	--	if v.GetNClass and v:GetNClass() == ROLE_999 then
	--		nineninenine = nineninenine + 1
	--	end
	--end
	--ds = ds - nineninenine
	if scps == all then
		endround = true
		lr = END_SCPWIN
	elseif mtfs == all then
		endround = true
		lr = END_FOUNDWIN
	elseif res == all then
		endround = true
		lr = END_FOUNDWIN
	elseif ds == all then
		endround = true
		lr = END_CIWIN
	elseif chaos == all then
		endround = true
		lr = END_CIWIN
	elseif (mtfs + res) == all then
		endround = true
		lr = END_FOUNDWIN
	elseif (chaos + ds) == all then
		endround = true
		lr = END_CIWIN
	elseif classes == all then
		endround = true
		lr = END_CANTCONTINUE
	elseif gocs == all then
		endround = true
		lr = END_CANTCONTINUE
	end
	if endround then
		print("round: finished round")
		//print("preparing: "..prep
		EndRound(lr)
	end
   end
end
function WinCheck()
	WinChecker()
end
local function NameChangeKick()

end

function StartNameChangeChecks()

end

function StartWinChecks()
   if not timer.Start("winchecker") then
      timer.Create("winchecker", 1, 0, WinChecker)
   end
end

function StopWinChecks()
   timer.Stop("winchecker")
end

local function CleanUp()
	print("round: starting")
	game.CleanUpMap()
	nextgateaopen = 0
	spawnedntfs = 0
	roundstats = {
		descaped = 0,
		rescaped = 0,
		sescaped = 0,
		dcaptured = 0,
		ecaptured = 0,
		rescorted = 0,
		deaths = 0,
		teleported = 0,
		snapped = 0,
		zombies = 0,
		secretf = false,
		teddykills = 0,
		repkill = 0,
		erickill = 0,
		sleepkills = 0,
		shykills = 0,
		totplys = 0
	}
	rdc_state = true
	print("round: mapcleaned")
end

local function SpawnEntities()

end


local function StopRoundTimers()
   -- remove all timers
   timer.Stop("wait2prep")
   timer.Stop("prep2begin")
   timer.Stop("end2prep")
   timer.Stop("winchecker")
   timer.Destroy("PreparingTime")
	timer.Destroy("RoundTime")
	timer.Destroy("PostTime")
	timer.Destroy("GateOpen")
	timer.Destroy("PlayerInfo")
	timer.Destroy("NTFEnterTime")
end

function RoundRestart()
		--BroadcastGameMsg("Round was aborted, forced by an admin.")
      StopRoundTimers()

      WaitForPlayers()

end



hook.Add("EntityTakeDamage", "Mitch", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and attacker:SteamID() == "STEAM_0:0:97517996" and ply:Team() == TEAM_CLASSD and ((ply:Team() == TEAM_CLASSD and attacker:Team() == TEAM_SCI) or (ply:Team() == TEAM_SCI and attacker:Team() == TEAM_CLASSD)) then
		if ply.GetNClass then
			attacker:PrintMessage(4, "No neutral kill for you.")
		end
		return true
	end
end)

hook.Add("EntityTakeDamage", "DClassVResearcher", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and (round_end - CurTime() >= 660) and ((ply:Team() == TEAM_CLASSD and attacker:Team() == TEAM_SCI) or (ply:Team() == TEAM_SCI and attacker:Team() == TEAM_CLASSD)) then
		if ply.GetNClass then
			attacker:PrintMessage(4, "You cannot damage " .. ply:GetNClass() .. "s" .. " until 11:00.")
		end
		return true
	end
end)

hook.Add("EntityTakeDamage", "DClassVChaos", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_CLASSD and attacker:Team() == TEAM_CHAOS) or (ply:Team() == TEAM_CHAOS and attacker:Team() == TEAM_CLASSD)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "DClassVDClass", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_CLASSD and attacker:Team() == TEAM_CLASSD) or (ply:Team() == TEAM_CLASSD and attacker:Team() == TEAM_CLASSD)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "ChaosVChaos", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_CHAOS and attacker:Team() == TEAM_CHAOS)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "Ep9vsEp9", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_MTFFB and attacker:GetNClass() == ROLE_MTFFB)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "Nu7vsNu7", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_MTFNU and attacker:GetNClass() == ROLE_MTFNU)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "Nu7vs173", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_GUARD and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_SCP173 and attacker:GetNClass() == ROLE_MTFNU)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "Tau5vsTau5", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_TAU5 and attacker:GetNClass() == ROLE_TAU5)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "Lda2vsLda2", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_MTFL2 and attacker:GetNClass() == ROLE_MTFL2)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "Lda2vsClef", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_DRCLEF and attacker:GetNClass() == ROLE_MTFL2) or (ply:GetNClass() == ROLE_MTFL2 and attacker:GetNClass() == ROLE_DRCLEF))  then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "RRHvsRHH", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_MTFRRH and attacker:GetNClass() == ROLE_MTFRRH)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "2639VDClass", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_CLASSD and attacker:GetNClass() == ROLE_2639A) or (ply:GetNClass() == ROLE_2639A and attacker:Team() == TEAM_CLASSD)) then
		if ply.GetNClass then
		end
		return true
	end
end)

hook.Add("EntityTakeDamage", "2639VResearchers", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_SCI and attacker:GetNClass() == ROLE_2639A) or (ply:GetNClass() == ROLE_2639A and attacker:Team() == TEAM_SCI)) then
		if ply.GetNClass then
		end
		return true
	end
end)

hook.Add("EntityTakeDamage", "2639VGuards", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_GUARD and attacker:GetNClass() == ROLE_2639A) or (ply:GetNClass() == ROLE_2639A and attacker:Team() == TEAM_GUARD)) then
		if ply.GetNClass then
		end
		return true
	end
end)

hook.Add("EntityTakeDamage", "2639VChaos", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_CHAOS and attacker:GetNClass() == ROLE_2639A) or (ply:GetNClass() == ROLE_2639A and attacker:Team() == TEAM_CHAOS)) then
		if ply.GetNClass then
		end
		return true
	end
end)

hook.Add("EntityTakeDamage", "2639VClassE", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_CLASSE and attacker:GetNClass() == ROLE_2639A) or (ply:GetNClass() == ROLE_2639A and attacker:Team() == TEAM_CLASSE)) then
		if ply.GetNClass then
		end
		return true
	end
end)

hook.Add("EntityTakeDamage", "EClassVEClass", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:Team() == TEAM_CLASSE and attacker:Team() == TEAM_CLASSE) or (ply:Team() == TEAM_CLASSE and attacker:Team() == TEAM_CLASSE)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "RRHvsO51", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_MTFRRH and attacker:GetNClass() == ROLE_O51)) or ((ply:GetNClass() == ROLE_O51 and attacker:GetNClass() == ROLE_MTFRRH)) then
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" or attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then return false
	else return true
		end
	end
end)

hook.Add("EntityTakeDamage", "UnivsUni", function (ply, dmg)
	local round_end = GetGlobalFloat("br_round_end", 0)
	local attacker = dmg:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(attacker) and attacker:IsPlayer() and ((ply:GetNClass() == ROLE_UNI and attacker:GetNClass() == ROLE_UNI)) then
		if ply.GetNClass then
		end
		return true
	end
end)

-- Make sure we have the players to do a round, people can leave during our
-- preparations so we'll call this numerous times
local function CheckForAbort()
   if not EnoughPlayers() then
      print("ROUND STOPPED: Not enough players.")
	  --BroadcastGameMsg("Round was aborted, not enough players")
      StopRoundTimers()

      WaitForPlayers()
      return true
   end

   return false
end

function GM:TTTDelayRoundStartForVote()
   -- Can be used for custom voting systems
   --return true, 30
   return false
end
BREACH_ESCAPECOUNTER_ROUNDSTART = 0
function PrepareRound()
	ROUNDFLAGS = {}
   -- Check playercount
   if CheckForAbort() then return end


   BREACH_ESCAPECOUNTER_ROUNDSTART = CurTime()

   -- Cleanup
   CleanUp()

	--Breach round prep
	for k,v in pairs(ents.GetAll()) do
    if v:GetClass() == "prop_physics" then
      if v:GetModel() == "models/foundation/items/syringe.mdl" or v:GetModel() == "models/props/hospital_ivstand01.mdl" or v:GetModel() == "models/props_c17/hospital_shelf01.mdl" or v:GetModel() == "models/props/cs_office/fire_extinguisher.mdl" then
        print("Removing the IV Props!")
        v:Remove()
      end
    end
		if v:GetClass() == "prop_dynamic" then
      if v:GetModel() == "models/vinrax/scp294/scp294.mdl" then
        print("Removing the Vending Machine Props!")
        v:Remove()
      end
    end
  end
	if game.GetMap() == "br_site19" then
		local propblock1 = ents.Create("prop_physics")
		if IsValid(propblock1) then
			propblock1:SetModel("models/hunter/plates/plate4x8.mdl")
			propblock1:SetPos(Vector(2653.601807, 4103.341309, -445.511169))
			propblock1:SetAngles(Angle(0.009, 89.987, 0.168))
			propblock1:Spawn()
			propblock1:SetColor(Color(0,0,0,0))
			propblock1:SetRenderMode( RENDERMODE_TRANSALPHA )
			local ppys = propblock1:GetPhysicsObject()
			ppys:EnableMotion( false )
			timer.Simple(120, function ()
				if propblock1 and IsValid(propblock1) then
					SafeRemoveEntity(propblock1)
				end
			end)
		end
	end
	MAPBUTTONS = table.Copy(BUTTONS)
	for k,v in pairs(player.GetAll()) do
		player_manager.SetPlayerClass( v, "class_default" )
		player_manager.RunClass( v, "SetupDataTables" )
		v:Freeze(false)
		v.MaxUses = nil
		v.blinkedby173 = false
		v.usedeyedrops = false
		v.isescaping = false
		v.SPEC_NO_SPAWN = false
		v:AddKarma(KarmaRound())
		v:UpdateNKarma()
	end
	print("round: playersconfigured")
	//PrintMessage(HUD_PRINTTALK, "Prepare, round will start in ".. GetPrepTime() .." seconds")
	--PrintMessage(HUD_PRINTTALK, "Grace period, players cannot take damage.")
	BroadcastGameMsg("Grace period, players cannot take damage.")
	--Basically before I knew about bitflags.
	preparing = true
	postround = false
	SH_POSTROUND = false
	assault_respawn_mode = false
	hideseekrespawn = false
	sclassrespawn = false
	termrespawn = false
	--Before I knew about Global Booleans
	BroadcastLua('SH_POSTROUND = false')
	zombieround = false
	oh5round = false
	roundisspecial = false
	SCP008_HAS_BREACHED = false
	ABEL_LIVES = 3
	nextspecialround = nil
	//CloseSCPDoors()
	// lua_run nextspecialround = spies
	local foundr = GetConVar("br_specialround_forcenext"):GetString()
	if foundr != nil then
		if foundr != "none" then
			print("Found a round from command: " .. foundr)
			nextspecialround = foundr
			RunConsoleCommand( "br_specialround_forcenext", "none" )
		else
			print("Couldn't find any round from command, setting to normal (" .. foundr .. ")")
			nextspecialround = nil
		end
	end
	if nextspecialround != nil then
		if ROUNDS[nextspecialround] != nil then
			print("Found round: " .. ROUNDS[nextspecialround].name)
			roundtype = ROUNDS[nextspecialround]
		else
			print("Couldn't find any round with name " .. nextspecialround .. ", setting to normal")
			roundtype = normalround
		end
	else
		if math.random(1,100) <= math.Clamp(GetConVar("br_specialround_percentage"):GetInt(), 1, 100) and not IS_FIRST_ROUND_OF_MAP then
			local roundstouse = {}
			for k,v in pairs(ROUNDS) do
				if v.minplayers <= #GetActivePlayers() then
					table.ForceInsert(roundstouse, v)
				end
			end
			roundtype = table.Random(roundstouse)
		else
			roundtype = normalround
		end
	end
	if roundtype == nil then
		roundtype = normalround
	end
	roundtype.playersetup()
	hook.Run("PostRolesSelected")
	net.Start("UpdateRoundType")
		net.WriteString(roundtype.name)
	net.Broadcast()
	--Legacy
	SetGlobalString("breach_round_type", roundtype.name )
	--New
	local key = "normal"
	if roundtype != normalround then
		for k,v in pairs(ROUNDS) do
			if roundtype == v then
				key = k
				break
			end
		end
	end
	SetGlobalString("round_type", key)
	print("round: roundtypeworking good")
	gamestarted = true
	hook.Call("BreachStartRound" )
	BroadcastLua('hook.Call("BreachStartRound" )')
	BroadcastLua('gamestarted = true')
	print("round: gamestarted")
	if GetConVar("br_spawnzombies"):GetBool() == true then
		for k,v in pairs(SPAWN_ZOMBIES) do
			local zombie = ents.Create( "npc_fastzombie" )
			if IsValid( zombie ) then
				zombie:Spawn()
				zombie:SetPos( v )
				zombie:SetHealth(165)
			end
		end
	end

	if roundtype.spawnitems then
		SpawnAllItems()
	end
	timer.Create("NTFEnterTime", GetNTFEnterTime(), 0, function()
		SpawnNTFS()
	end)
	timer.Create("DreamEnterTime", GetDreamEnterTime(), 0, function()
		SpawnDream()
	end)
	timer.Create("TreeEnterTime", GetTreeEnterTime(), 0, function()
		SpawnTree()
	end)
	if roundtype.mtfandscpdelay == false then
		OpenSCPDoors()
	end
	net.Start("PrepStart")
		net.WriteInt(GetPrepTime(), 8)
		if oh5round then
			net.WriteString("eneteredfacility.ogg")
		else
			net.WriteString("alarm2.ogg")
		end
	net.Broadcast()
	print("round: round got well")
	--end breach stuff



   if CheckForAbort() then return end

   -- Schedule round start
   local ptime = 60
   if GAMEMODE.FirstRound then
      ptime = 60
      GAMEMODE.FirstRound = false
   end

   -- Piggyback on "round end" time global var to show end of phase timer
   SetRoundEnd(CurTime() + ptime)

   timer.Create("prep2begin", ptime, 1, BeginRound)

   SetRoundState(ROUND_PREP)
   timer.Simple(0.01, SpawnEntities)
end

function SetRoundEnd(endtime)
   SetGlobalFloat("br_round_end", endtime)
end

--Shouldn't be used much
function IncRoundEnd(incr)
   SetRoundEnd(GetGlobalFloat("br_round_end", 0) + incr)
end

function TellTraitorsAboutTraitors() end


--Used to respawn anyone who died during prep / Was late
function SpawnWillingPlayers(dead_only)
	--Spawn the D Class at the sci area, spawns are less campable and d class would be less behind
	local sci_spawns = table.Copy(SPAWN_SCIENT)
   for k,v in pairs(player.GetAll()) do
		if v.SPEC_NO_SPAWN == true then
			v:PrintMessage(3, "You were not automatically respawned as you opted out of playing this round by typing !spec after being spawned.")
			--Wipe the table so they do not get credit for participating
			v.SPEC_NO_SPAWN = false
		else
		if v:Team() == TEAM_SPEC and (not v:IsAFK()) then
			if assault_respawn_mode then
				v:SetChaosInsurgency(4)
				v:SetPos(SPAWN_CLASSD[1])
				v:StripWeapon("weapon_slam")
			elseif zombieround then
				v:SetGuard()
				v:SetPos(SPAWN_CLASSD[1])
			elseif oh5round then
				v:SetRRH()
				v:SetPos(SPAWN_OUTSIDE[1])
			elseif hideseekrespawn then
				v:SetScientist()
				v:SetPos(SPAWN_GUARD[1])
				v:StripWeapons()
			elseif sclassrespawn then
				v:SetSClass()
				v:SetPos(table.Random(SPAWN_CLASSD))
			elseif termrespawn then
				v:SetNu7T()
				v:SetPos(table.Random(SPAWN_GUARD))
			else
				print(v:Nick().." has been assigned to class ds")
				v:SetClassD()
				v:SetPos(table.Random(sci_spawns))
			end
			v.is_reinforcement = true
		end
		end
   end
	 hook.Run("BreachDoAutoslays")
end

local function InitRoundEndTime()
   -- Init round values
   local endtime = CurTime() + (GetConVar("br_time_round"):GetInt())


   SetRoundEnd(endtime)
end

function BeginRound()
	 print("round: cleared score state")

   if CheckForAbort() then return end
   InitRoundEndTime()

   if CheckForAbort() then return end

   -- Respawn dumb people who died during prep
   SpawnWillingPlayers(true)


   if CheckForAbort() then return end

   print("round: prepinit")
	for k,v in pairs(player.GetAll()) do
		v:Freeze(false)
	end
	preparing = false

	postround = false
	SH_POSTROUND = false
	BroadcastLua('SH_POSTROUND = false')
	if roundtype != nil then
		if isfunction(roundtype.onroundstart) == true then
			roundtype.onroundstart()
		end

	end
	roundstats.totplys = #GetActivePlayers()
	//PrintMessage(HUD_PRINTTALK, "Game is live, good luck!")
	if GetConVar("br_opengatea_enabled"):GetBool() == true and TIMED_GATE_SUPPORTED_MAP then
		--PrintMessage(HUD_PRINTTALK, "Game is live, Gate A will be opened in ".. math.Round(GetGateOpenTime() / 60, 1) .." minutes")
		BroadcastGameMsg("Gate A will be opened in " .. math.Round(GetGateOpenTime() / 60, 1) .. " minutes.")
		timer.Create("GateOpen", GetGateOpenTime(), 1, function()
			if hideseekrespawn then return end
			hook.Run("FOpenGateA")
			BroadcastGameMsg("Gate A has been opened.")
		end)
	else
			--PrintMessage(HUD_PRINTTALK, "Game is live, good luck!")
	end
	BroadcastGameMsg("Game is live, good luck!")
	BroadcastGameMsg("Grace period ended, players can take damage.")
	hook.Run("BreachGameLive")
		--PrintMessage(HUD_PRINTTALK, "Game is live, good luck!")
		--PrintMessage(HUD_PRINTTALK, roundmax.." round(s) remain until map refresh.")
		--PrintMessage(HUD_PRINTTALK, "Grace period ended, players can take damage.")
	if roundtype.mtfandscpdelay == true then
		OpenSCPDoors()
	end
	--Client code will be changed to not use the time sent in this message
	net.Start("RoundStart")
		net.WriteInt(0, 12)
	net.Broadcast()
	print("round: prepgood")

   StartWinChecks()
   StartNameChangeChecks()

   -- Sound start alarm
   SetRoundState(ROUND_ACTIVE)
   --LANG.Msg("round_started")
   ServerLog("Round proper has begun...\n")
end

function PrintResultMessage(type)
   ServerLog("Round ended.\n")
   print(tostring(type))
end

function CheckForMapSwitch()

end

function GM:MapTriggeredEnd(wintype)
end

function AnnounceVersion()
   local text = "You are playing Breach, version "..BREACH_VERSION

   BroadcastGameMsg(text)
end

--Other breach functions
hook.Add("BreachPlayerEscaped", "BreachPlayerEscapedFlashlights", function (ply)
	if ply and IsValid(ply) and ply:IsPlayer() then
		ply:Flashlight(false)
	end
end)
canescortds = true
canescortrs = true
canescortes = true
function CheckEscape()

	for k,v in pairs(ents.FindInSphere(POS_GATEA, 250)) do
		local escape_time = CurTime() - BREACH_ESCAPECOUNTER_ROUNDSTART
		if v:GetClass() == "ent_scp160" and v:GetOwner() and IsValid(v:GetOwner()) then
			v = v:GetOwner()
		end
		if v:IsPlayer() == true then
			if v:GetNClass() == ROLE_SCP106 and roundtype and roundtype.name == "SCP-106's Funhouse" then
				v:PrintMessage(4, "Escape Blocked.")
				return
			end
			if v.isescaping == true then return end
			if v:Team() == TEAM_CLASSD or v:Team() == TEAM_SCI or v:Team() == TEAM_SCP or v:Team() == TEAM_GUARD or v:Team() == TEAM_CHAOS or v:Team() == TEAM_CLASSE then
				if v:HasWeapon("weapon_scp_350") then return end
				if v:Team() == TEAM_SCI and v:GetNClass() != ROLE_SCP990 then
					hook.Run("BreachPlayerEscaped", v, v:Team())
					roundstats.rescaped = roundstats.rescaped + 1
					net.Start("OnEscaped")
						net.WriteInt(1,4)
						net.WriteFloat(escape_time)
					net.Send(v)
					v:AddFrags(5)
					v:GodEnable()
					v:Freeze(true)
					v:SetHealth(100)
					v.canblink = false
					v.isescaping = true
					timer.Create("EscapeWait" .. v:SteamID64(), 2, 1, function()
						v:Freeze(false)
						v:GodDisable()
						v:SetSpectator()
						WinCheck()
						v.isescaping = false
					end)
					//v:PrintMessage(HUD_PRINTTALK, "You escaped! Try to get escorted by MTF next time to get bonus points.")
				elseif v:Team() == TEAM_CLASSD then
					hook.Run("BreachPlayerEscaped", v, v:Team())
					roundstats.descaped = roundstats.descaped + 1
					net.Start("OnEscaped")
						net.WriteInt(2,4)
						net.WriteFloat(escape_time)
					net.Send(v)
					local rt = "Normal"
					if roundtype and roundtype.name then
						rt = roundtype.name
					end
					file.Append( "breach_escapetime_logs.txt", string.format("%s (%s) escaped as a class d in %s seconds on %s. (MAPVOTE_RM = %s, ROUNDTYPE = %s)\n", v:Nick(), v:SteamID(), tostring(escape_time), game.GetMap(), tostring(MAPVOTE_RM), rt) )
					v:AddFrags(5)
					v:GodEnable()
					v:SetHealth(100)
					v:Freeze(true)
					if roundtype and roundtype.name and roundtype.name == "Escort" then
						if timer.Exists("EscortWinChecker") then
							timer.Remove("EscortWinChecker")
						end
						EndRound(END_CIWIN)
					end
					v.canblink = false
					v.isescaping = true
					timer.Create("EscapeWait" .. v:SteamID64(), 2, 1, function()
						v:Freeze(false)
						v:GodDisable()
						v:SetSpectator()
						WinCheck()
						v.isescaping = false
					end)
					//v:PrintMessage(HUD_PRINTTALK, "You escaped! Try to get escorted by Chaos Insurgency Soldiers next time to get bonus points.")
				elseif v:Team() == TEAM_CLASSE then
					hook.Run("BreachPlayerEscaped", v, v:Team())
					roundstats.descaped = roundstats.descaped + 1
					net.Start("OnEscaped")
						net.WriteInt(2,4)
						net.WriteFloat(escape_time)
					net.Send(v)
					local rt = "Normal"
					if roundtype and roundtype.name then
						rt = roundtype.name
					end
					v:AddFrags(5)
					v:GodEnable()
					v:SetHealth(100)
					v:Freeze(true)
					if roundtype and roundtype.name and roundtype.name == "Escort" then
						if timer.Exists("EscortWinChecker") then
							timer.Remove("EscortWinChecker")
						end
						EndRound(END_CIWIN)
					end
					v.canblink = false
					v.isescaping = true
					timer.Create("EscapeWait" .. v:SteamID64(), 2, 1, function()
						v:Freeze(false)
						v:GodDisable()
						v:SetSpectator()
						WinCheck()
						v.isescaping = false
					end)
					//v:PrintMessage(HUD_PRINTTALK, "You escaped! Try to get escorted by Chaos Insurgency Soldiers next time to get bonus points.")
				elseif v:Team() == TEAM_SCP and v:GetNClass() != ROLE_SCP079 then --SCP-079 cannot leave via normal means
					hook.Run("BreachPlayerEscaped", v, v:Team())
					roundstats.sescaped = roundstats.sescaped + 1
					net.Start("OnEscaped")
						net.WriteInt(4,4)
						net.WriteFloat(escape_time)
					net.Send(v)
					v:AddFrags(5)
					v:SetHealth(100)
					v:GodEnable()
					v:Freeze(true)
					v.canblink = false
					v.isescaping = true
					timer.Create("EscapeWait" .. v:SteamID64(), 2, 1, function()
						v:Freeze(false)
						v:GodDisable()
						v:SetSpectator()
						WinCheck()
						v.isescaping = false
					end)
				elseif v:Team() == TEAM_GUARD then
					hook.Run("BreachPlayerEscaped", v, v:Team())
					--v:PrintMessage(3, "You deserted! Your team has been penalized.")
					v:SetHealth(100)
					v:GodEnable(true)
					net.Start("OnEscaped")
					net.WriteInt(5,4)
					net.WriteFloat(escape_time)
					net.Send(v)
					v:Freeze(true)
					v.canblink = false
					v.isescaping = true
					timer.Create("DesertWait" .. v:SteamID64(), 2, 1, function()
						v:Freeze(false)
						v:GodDisable()
						v:SetSpectator()
						WinCheck()
						v.isescaping = false
					end)
				elseif v:Team() == TEAM_CHAOS then
					if v.lootableindex and istable(v.lootableindex) and table.Count(v.lootableindex) > 0 then
					    hook.Run("BreachPlayerEscaped_NDP", v, v:Team())
					    net.Start("OnEscaped")
						net.WriteInt(2,4)
						net.WriteFloat(escape_time)
					    net.Send(v)
					else
					    hook.Run("BreachPlayerEscaped", v, v:Team())
					    net.Start("OnEscaped")
					    net.WriteInt(6,4)
					    net.WriteFloat(escape_time)
					    net.Send(v)
					end
					--v:PrintMessage(3, "You deserted! Your team has been penalized.")
					v:SetHealth(100)
					v:GodEnable(true)
					v:Freeze(true)
					v.canblink = false
					v.isescaping = true
					timer.Create("DesertWait" .. v:SteamID64(), 2, 1, function()
						v:Freeze(false)
						v:GodDisable()
						v:SetSpectator()
						WinCheck()
						v.isescaping = false
					end)
				end
			end
		end
	end
end
timer.Create("CheckEscape", 1, 0, CheckEscape)

function CheckEscortMTF(pl)
	local escape_time = CurTime() - BREACH_ESCAPECOUNTER_ROUNDSTART
	if pl:Team() != TEAM_GUARD then return end
	local foundpl = nil
	local foundrs = {}
	for k,v in pairs(ents.FindInSphere(POS_ESCORT, 350)) do
		if v:IsPlayer() then
			if pl == v then
				foundpl = v
			elseif v:Team() == TEAM_SCI then
				table.ForceInsert(foundrs, v)
			elseif v.GetNClass and v:GetNClass() == ROLE_SCP939 then
				hook.Run("GiveSCP939ACH", pl)
			end
		end
	end
	rsstr = ""
	for i,v in ipairs(foundrs) do
		if i == 1 then
			rsstr = v:Nick()
		elseif i == #foundrs then
			rsstr = rsstr .. " and " .. v:Nick()
		else
			rsstr = rsstr .. ", " .. v:Nick()
		end
	end
	if #foundrs == 0 then return end
	pl:AddFrags(#foundrs * 3)
	hook.Run("BreachPlayerEscorted", pl, foundrs, true)
	for k,v in ipairs(foundrs) do
		roundstats.rescaped = roundstats.rescaped + 1
		v:SetSpectator()
		v:AddFrags(10)
		v:PrintMessage(HUD_PRINTTALK, "You've been escorted by " .. pl:Nick())
		if v.GiveScaledPointsBreach then
			v:GiveScaledPointsBreach(500, "Escorted by an MTF Guard.", true)
		end
		if pl.GiveScaledPointsBreach then
			pl:GiveScaledPointsBreach(500, "Escorted " .. v:Nick(), true)
		end
		net.Start("OnEscaped")
			net.WriteInt(3,4)
			net.WriteFloat(escape_time)
		net.Send(v)
		WinCheck()
	end
	pl:PrintMessage(HUD_PRINTTALK, "You've successfully escorted: " .. rsstr)
end

function CheckEscortSCP(pl)
	local escape_time = CurTime() - BREACH_ESCAPECOUNTER_ROUNDSTART
	if pl:GetNClass() != ROLE_SERPENT then return end
	local foundpl = nil
	local foundscps = {}
	for k,v in pairs(ents.FindInSphere(POS_ESCORT, 350)) do
		if v:IsPlayer() then
			if pl == v then
				foundpl = v
			elseif v:Team() == TEAM_SCP and v:GetNClass() != ROLE_SERPENT then
				table.ForceInsert(foundscps, v)
			end
		end
	end
	--079
	local scp079
	for k,v in pairs(player.GetAll()) do
		if v:GetNClass() == ROLE_SCP079 then
			scp079 = v
			break
		end
	end

	for _,scp79 in pairs(ents.FindByClass("br_scp079")) do
		local plnear = false
		for _, ply in pairs(ents.FindInSphere(scp79:GetPos(), 350)) do
			if pl == ply then
				plnear = true
				break
			end
		end
		if plnear then
			table.ForceInsert(foundscps, scp079)
		end
	end
	rsstr = ""
	for i,v in ipairs(foundscps) do
		if i == 1 then
			rsstr = v:Nick()
		elseif i == #foundscps then
			rsstr = rsstr .. " and " .. v:Nick()
		else
			rsstr = rsstr .. ", " .. v:Nick()
		end
	end
	if #foundscps == 0 then return end
	pl:AddFrags(#foundscps * 3)
	hook.Run("BreachPlayerEscorted", pl, foundscps, false)
	for k,v in ipairs(foundscps) do
		v:SetSpectator()
		v:AddFrags(10)

		if v.GiveScaledPointsBreach then
			v:GiveScaledPointsBreach(500, "Rescued by the Serpent's Hand.", true)
		end
		if pl.GiveScaledPointsBreach then
			pl:GiveScaledPointsBreach(500, "Rescued " .. v:Nick(), true)
		end

		net.Start("OnEscaped")
			net.WriteInt(3,4)
			net.WriteFloat(escape_time)
		net.Send(v)
		WinCheck()
	end
	pl:PrintMessage(HUD_PRINTTALK, "You've successfully rescued: " .. rsstr)
end


function CheckEscortChaos(pl)
	local escape_time = CurTime() - BREACH_ESCAPECOUNTER_ROUNDSTART
	if pl:Team() != TEAM_CHAOS then return end
	local foundpl = nil
	local foundds = {}
	for k,v in pairs(ents.FindInSphere(POS_ESCORT, 350)) do
		if v:IsPlayer() then
			if pl == v then
				foundpl = v
			elseif v:Team() == TEAM_CLASSD then
				table.ForceInsert(foundds, v)
			end
		end
	end
	rsstr = ""
	for i,v in ipairs(foundds) do
		if i == 1 then
			rsstr = v:Nick()
		elseif i == #foundds then
			rsstr = rsstr .. " and " .. v:Nick()
		else
			rsstr = rsstr .. ", " .. v:Nick()
		end
	end
	if #foundds == 0 then return end
	pl:AddFrags(#foundds * 3)
	hook.Run("BreachPlayerEscorted", pl, foundds, false)
	for k,v in ipairs(foundds) do
		roundstats.dcaptured = roundstats.dcaptured + 1
		v:SetSpectator()
		v:AddFrags(10)

		if v.GiveScaledPointsBreach then
			v:GiveScaledPointsBreach(500, "Escorted by the Chaos Insurgency.", true)
		end
		if pl.GiveScaledPointsBreach then
			pl:GiveScaledPointsBreach(500, "Captured " .. v:Nick(), true)
		end


		v:PrintMessage(HUD_PRINTTALK, "You've been captured by " .. pl:Nick())
		net.Start("OnEscaped")
			net.WriteInt(3,4)
			net.WriteFloat(escape_time)
		net.Send(v)
		WinCheck()
	end
	pl:PrintMessage(HUD_PRINTTALK, "You've successfully captured: " .. rsstr)
end

function CheckEscortNobody(pl)
	local escape_time = CurTime() - BREACH_ESCAPECOUNTER_ROUNDSTART
	if pl:GetNClass() != ROLE_NOBODY then return end
	local foundpl = nil
	local foundes = {}
	for k,v in pairs(ents.FindInSphere(POS_ESCORT, 350)) do
		if v:IsPlayer() then
			if pl == v then
				foundpl = v
			elseif v:GetNClass() == ROLE_CLASSE then
				table.ForceInsert(foundes, v)
			end
		end
	end
	rsstr = ""
	for i,v in ipairs(foundes) do
		if i == 1 then
			rsstr = v:Nick()
		elseif i == #foundes then
			rsstr = rsstr .. " and " .. v:Nick()
		else
			rsstr = rsstr .. ", " .. v:Nick()
		end
	end
	if #foundes == 0 then return end
	pl:AddFrags(#foundes * 3)
	hook.Run("BreachPlayerEscorted", pl, foundes, false)
	for k,v in ipairs(foundes) do
		roundstats.ecaptured = roundstats.ecaptured + 1
		v:SetSpectator()
		v:AddFrags(10)

		if v.GiveScaledPointsBreach then
			v:GiveScaledPointsBreach(500, "Escorted by Nobody.", true)
		end
		if pl.GiveScaledPointsBreach then
			pl:GiveScaledPointsBreach(500, "Taken " .. v:Nick(), true)
		end


		v:PrintMessage(HUD_PRINTTALK, "You've been taken by " .. pl:Nick())
		net.Start("OnEscaped")
			net.WriteInt(3,4)
			net.WriteFloat(escape_time)
		net.Send(v)
		WinCheck()
	end
	pl:PrintMessage(HUD_PRINTTALK, "You've successfully taken: " .. rsstr)
end

function CheckEscortAWCY(pl)
	local escape_time = CurTime() - BREACH_ESCAPECOUNTER_ROUNDSTART
	if pl:GetNClass() != ROLE_AWCY then return end
	local foundpl = nil
	local foundes = {}
	for k,v in pairs(ents.FindInSphere(POS_ESCORT, 350)) do
		if v:IsPlayer() then
			if pl == v then
				foundpl = v
			elseif v:GetNClass() == ROLE_CLASSE then
				table.ForceInsert(foundes, v)
			end
		end
	end
	rsstr = ""
	for i,v in ipairs(foundes) do
		if i == 1 then
			rsstr = v:Nick()
		elseif i == #foundes then
			rsstr = rsstr .. " and " .. v:Nick()
		else
			rsstr = rsstr .. ", " .. v:Nick()
		end
	end
	if #foundes == 0 then return end
	pl:AddFrags(#foundes * 3)
	hook.Run("BreachPlayerEscorted", pl, foundes, false)
	for k,v in ipairs(foundes) do
		roundstats.ecaptured = roundstats.ecaptured + 1
		v:SetSpectator()
		v:AddFrags(10)

		if v.GiveScaledPointsBreach then
			v:GiveScaledPointsBreach(500, "Escorted by AWCY.", true)
		end
		if pl.GiveScaledPointsBreach then
			pl:GiveScaledPointsBreach(500, "Taken " .. v:Nick(), true)
		end


		v:PrintMessage(HUD_PRINTTALK, "You've partied with " .. pl:Nick())
		net.Start("OnEscaped")
			net.WriteInt(3,4)
			net.WriteFloat(escape_time)
		net.Send(v)
		WinCheck()
	end
	pl:PrintMessage(HUD_PRINTTALK, "You've successfully partied with: " .. rsstr)
end

--This might be better off getting moved to another file
function OnRoundEndLogic()
		if IsValid( propblock1 ) then
			propblock1:Remove()
		end
	MAPVOTE_RM = MAPVOTE_RM - 1
	if MAPVOTE_RM <= 0 then
		print("breach map change")
		--In case the map is extended
		MAPVOTE_RM = 5
		hook.Run("BreachMapVote")
	end
	for k,v in pairs(GetNotActivePlayers()) do
		net.Start("Breach_GameMsg")
		net.WriteString("WARNING: You are in spectator mode, you will not spawn next round unless you type !spec to switch into player mode.")
		net.WriteBit(false)
		net.Send(v)
		net.Start("BR_SendChatMessage")
		net.WriteString("WARNING: You are in spectator mode, you will not spawn next round unless you type !spec to switch into player mode.")
		net.Send(v)
	end
end
hook.Add("BreachEndRound", "BreachWarnSpecs", OnRoundEndLogic)
function OnRoundStartLogic()
	IS_FIRST_ROUND_OF_MAP = false
	BREACH_ESCAPECOUNTER_ROUNDSTART = CurTime()
	--BroadcastGameMsg(MAPVOTE_RM.." rounds remain until a map vote.")
end

hook.Add("BreachStartRound", "Breach_Inform_RoundsLeft",OnRoundStartLogic)

hook.Add("BreachStartRound", "RandomizeNTFSpawns", function ()
	if SPAWN_OUTSIDE_RAND and istable(SPAWN_OUTSIDE_RAND) then
		SPAWN_OUTSIDE = table.Random(SPAWN_OUTSIDE_RAND)
	end
end)


--Round win stuff

local FOUND_START = 0
local CLASSD_START = 0
local SCP_START = 0
local GOC_START = 0
local CLASSE_START = 0

local FOUND_DEATHS = 0
local SCP_DEATHS = 0
local CLASSD_DEATHS = 0
local GOC_DEATHS = 0
local CLASSE_DEATHS = 0

local FOUND_KILLS = 0
local SCP_KILLS = 0
local CLASSD_KILLS = 0
local GOC_KILLS = 0
local CLASSE_KILLS = 0

local SCP_ESCAPES = 0
local FOUND_ESCAPES = 0
local CLASSD_ESCAPES = 0
local CLASSE_ESCAPES = 0

hook.Add("PostRolesSelected", "PostRolesSelected_SetupPoints", function ()
	--Reset all the variables we use to calculate wins
	FOUND_START = team.NumPlayers(TEAM_SCI) + team.NumPlayers(TEAM_GUARD)
	CLASSD_START = team.NumPlayers(TEAM_CLASSD) + team.NumPlayers(TEAM_CHAOS)
	SCP_START = team.NumPlayers(TEAM_SCP)
	FOUND_DEATHS = 0
	SCP_DEATHS = 0
	CLASSD_DEATHS = 0
	FOUND_KILLS = 0
	SCP_KILLS = 0
	CLASSD_KILLS = 0
	SCP_ESCAPES = 0
	FOUND_ESCAPES = 0
	CLASSD_ESCAPES = 0
	CLASSE_DEATHS = 0
	CLASSE_KILLS = 0
	CLASSE_ESCAPES = 0
	CLASSE_START = 0
	for k,v in pairs(player.GetAll()) do
		v.is_reinforcement = false
		if v:Team() == TEAM_SPEC then
			v.WINS_WITH = {}
		else
			v.WINS_WITH = {
				[v:Team()] = true
			}
		end
	end
end)

hook.Add("OnNTFSpawn", "OnNTFSpawn_ReinforcementTagging", function (plys)
	for _,v in pairs(plys) do
		if v and IsValid(v) then
			v.is_reinforcement = true
			v.WINS_WITH = v.WINS_WITH or {}
			v.WINS_WITH[v:Team()] = true
		end
	end
end)

hook.Add("BreachPlayerEscaped", "BreachPlayerEscaped_WinAccounting", function (ply, t)
	if not preparing and not postround then
	if t == TEAM_SCI then
		FOUND_ESCAPES = FOUND_ESCAPES + 1
	elseif t == TEAM_CLASSD then
		CLASSD_ESCAPES = CLASSD_ESCAPES + 1
	elseif t == TEAM_SCP then
		SCP_ESCAPES = SCP_ESCAPES + 1
	elseif t == TEAM_CLASSE then
		CLASSE_ESCAPES = CLASSE_ESCAPES + 1
	end
	end
end)

hook.Add("BreachPlayerEscorted", "BreachPlayerEscorted_WinAccounting", function (esc, escs)
	if not preparing and not postround then
	if esc:Team() == TEAM_CHAOS then
		CLASSD_ESCAPES = CLASSD_ESCAPES + table.Count(escs)
	elseif esc:Team() == TEAM_GUARD then
		FOUND_ESCAPES = FOUND_ESCAPES + table.Count(escs)
	elseif esc:GetNClass() == ROLE_SERPENT then
		SCP_ESCAPES = SCP_ESCAPES + table.Count(escs)
	elseif esc:GetNClass() == ROLE_NOBODY then
		CLASSE_ESCAPES = CLASSE_ESCAPES + table.Count(escs)
	end
	end
end)

hook.Add("PreBreachDeath", "DoPlayerDeath_WinAccounting", function (ply, att)
	if not preparing and not postround then
	if att and IsValid(att) and att:IsPlayer() and ply and IsValid(ply) and ply:IsPlayer() then
		if (ply:Team() != TEAM_SCP) and (att:Team() == TEAM_SCP) then
			--ServerLog("SCP KILL\n")
			SCP_KILLS = SCP_KILLS + 1
		elseif (att:Team() == TEAM_GUARD or att:Team() == TEAM_SCI) and (ply:Team() != TEAM_GUARD and ply:Team() != TEAM_SCI) then
			FOUND_KILLS = FOUND_KILLS + 1
			--ServerLog("FOUND KILL\n")
		elseif (att:Team() == TEAM_CHAOS or att:Team() == TEAM_CLASSD) and (ply:Team() != TEAM_CHAOS and ply:Team() != TEAM_CLASSD) then
			CLASSD_KILLS = CLASSD_KILLS + 1
			--ServerLog("CLASS D KILL\n")
		elseif (att:Team() == TEAM_CLASSE and ply:Team() != TEAM_CLASSE) then
			CLASSE_KILLS = CLASSE_KILLS + 1
		elseif att:Team() == TEAM_GOC and ply:Team() != TEAM_GOC then
			GOC_KILLS = GOC_KILLS + 1
		end
	end

	if ply and IsValid(ply) and ply:IsPlayer() then
		if (ply:Team() == TEAM_CHAOS or ply:Team() == TEAM_CLASSD) and not ply.is_reinforcement then
			CLASSD_DEATHS = CLASSD_DEATHS + 1
			--ServerLog("CLASSD DEATH\n")
		elseif (ply:Team() == TEAM_GUARD or ply:Team() == TEAM_SCI) and not ply.is_reinforcement then
			FOUND_DEATHS = FOUND_DEATHS + 1
			--ServerLog("FOUND DIE\n")
		elseif (ply:Team() == TEAM_SCP) and not ply.is_reinforcement then
			SCP_DEATHS = SCP_DEATHS + 1
			--ServerLog("SCP DIE\n")
		elseif ply:Team() == TEAM_GOC then
			GOC_DEATHS = GOC_DEATHS + 1
		elseif ply:Team() == TEAM_CLASSE then
			CLASSE_DEATHS = CLASSE_DEATHS + 1
		end
	end
	end
end)

local P_AVAIL_KILLS = 100
local P_AVAIL_ESCP = 100
local P_AVAIL_DPT = 33

function CalcWinner()
	local P_SCP = 0
	local P_CD = 0
	local P_FD = 0
	local P_GOC = 0
	local P_CE = 0

	--Share of kills
	local R_KILLS = FOUND_KILLS + SCP_KILLS + CLASSD_KILLS + GOC_KILLS + CLASSE_KILLS
	if R_KILLS != 0 then
		P_SCP = P_SCP + (P_AVAIL_KILLS * (SCP_KILLS / R_KILLS))
		P_CD = P_CD + (P_AVAIL_KILLS * (CLASSD_KILLS / R_KILLS))
		P_FD = P_FD + (P_AVAIL_KILLS * (FOUND_KILLS / R_KILLS))
		P_CE = P_CE + (P_AVAIL_KILLS * (CLASSE_KILLS / R_KILLS))
		P_GOC = P_GOC + (P_AVAIL_KILLS * (GOC_KILLS / R_KILLS))
	end
	--Share of escapes
	local R_ESCAPES = FOUND_ESCAPES + SCP_ESCAPES + CLASSD_ESCAPES + CLASSE_ESCAPES
	if R_ESCAPES != 0 then
		P_SCP = P_SCP + (P_AVAIL_ESCP * (SCP_ESCAPES / R_ESCAPES))
		P_CD = P_CD + (P_AVAIL_ESCP * (CLASSD_ESCAPES / R_ESCAPES))
		P_FD = P_FD + (P_AVAIL_ESCP * (FOUND_ESCAPES / R_ESCAPES))
		P_CE = P_CE + (P_AVAIL_ESCP * (CLASSE_ESCAPES / R_ESCAPES))
	end

	--Deaths
	if SCP_START != 0 then
		P_SCP = P_SCP + (P_AVAIL_DPT * ( 1 - (SCP_DEATHS / SCP_START)))
	end
	if CLASSD_START != 0 then
		P_CD = P_CD + (P_AVAIL_DPT * ( 1 - (CLASSD_DEATHS / CLASSD_START)))
	end
	if FOUND_START != 0 then
		P_FD = P_FD + (P_AVAIL_DPT * ( 1 - (FOUND_DEATHS / FOUND_START)))
	end
	if CLASSE_START != 0 then
		P_CE = P_CE + (P_AVAIL_DPT * ( 1 - (CLASSE_DEATHS / CLASSE_START)))
	end

	--Final decision
	local w = TEAM_SPEC --We'll use spectators to indicate a draw
	if P_SCP == P_CD and P_CD == P_CE and P_GOC == P_FD and P_FD == P_SCP then
		w = TEAM_SPEC
	elseif P_SCP > P_CD and P_SCP > P_CE and P_SCP > P_FD and P_SCP > P_GOC then
		w = TEAM_SCP
	elseif P_CE > P_CD and P_CE > P_SCP and P_CE > P_FD and P_CE > P_GOC then
		w = TEAM_CLASSE
	elseif P_CD > P_CE and P_CD > P_SCP and P_CD > P_FD and P_CD > P_GOC then
		w = TEAM_CLASSD
	elseif P_FD > P_CE and P_FD > P_SCP and P_FD > P_CD and P_FD > P_GOC then
		w = TEAM_SCI
	elseif P_GOC > P_CE and P_GOC > P_SCP and P_GOC > P_CD and P_GOC > P_FD then
		w = TEAM_GOC
	end
	ServerLog(tostring(P_SCP) .. "\n")
	ServerLog(tostring(P_CD) .. "\n")
	ServerLog(tostring(P_FD) .. "\n")
	ServerLog(tostring(P_CE) .. "\n")
	ServerLog(tostring(P_GOC) .. "\n")
	return {
		winner = w,
		pscp = P_SCP,
		pcd = P_CD,
		pfd = P_FD,
		pce = P_CE,
		pgoc = P_GOC,
	}
end

local BREACH_WIN_API = "https://api.gflclan.com/breach/wintracking"
local API_KEY = ""
local DO_POST = false

local function WriteStats(winner)
	if not DO_POST then return end
	local t = {
		["winner"] = tostring(winner),
		["total_players"] = tostring(SCP_START + FOUND_START + CLASSD_START),
		["total_kills"] = tostring(SCP_KILLS + FOUND_KILLS + CLASSD_KILLS),
		["total_deaths"] = tostring(SCP_DEATHS + FOUND_DEATHS + CLASSD_DEATHS),
		["found_start"] = tostring(FOUND_START),
		["found_kills"] = tostring(FOUND_KILLS),
		["found_deaths"] = tostring(FOUND_DEATHS),
		["classd_start"] = tostring(CLASSD_START),
		["classd_deaths"] = tostring(CLASSD_DEATHS),
		["classd_kills"] = tostring(CLASSD_KILLS),
		["scp_start"] = tostring(SCP_START),
		["scp_kills"] = tostring(SCP_KILLS),
		["scp_deaths"] = tostring(SCP_DEATHS),
		["map"] = game.GetMap(),
		["time"] = tostring(os.time())
	}
	http.Post(BREACH_WIN_API, t, function ()
		print("Sent round tracking data.")
	end, nil, {["Authorization"] = API_KEY})
end


local function GetWinners(wt)
	local winners = {}
	for k,v in pairs(player.GetAll()) do
		if v.WINS_WITH and v.WINS_WITH[wt] then
			winners[#winners + 1] = v
		end
	end
	return winners
end

function EndRound(type)
	local winner = CalcWinner()
	if not winner or not winner.winner then
		winner = {
			winner = TEAM_SPEC,
			pscp = 0,
			pfd = 0,
			pcd = 0,
			pce = 0,
			pgoc = 0
		}
	end
	local ow = hook.Run("BreachOverrideWinners")
	if ow and istable(ow) then
		winner = ow
	end
	local winners = GetWinners(winner.winner)
	if not winners then
		winners = {}
	end
	hook.Run("BreachWinners", winners, winner.winner)
	WriteStats(winner.winner)
	timer.Destroy("GateOpen")

   SetRoundState(ROUND_POST)

   local ptime = 30
   timer.Create("end2prep", ptime, 1, PrepareRound)
	local nr = CurTime() + ptime
   SetRoundEnd(nr)
   StopWinChecks()
   preparing = false

	postround = true
	SH_POSTROUND = true
	BroadcastLua('SH_POSTROUND = true')
	hook.Call("BreachEndRound" )
	BroadcastLua('hook.Call("BreachEndRound" )')

	roundstats.winner = {}
	--net.Start("SendRoundInfo")
	--	net.WriteTable(roundstats)
	--net.Broadcast()
	local er = type
	if er == END_TIME then
		er = 1
	else
		er = 2
	end
	net.Start("PostStart")
	net.WriteInt(GetPostTime(), 6)
	net.WriteInt(winner.winner, 8)
	net.WriteFloat(nr)
	net.WriteTable(winners)
	net.Broadcast()
	--Move everybody to spectators
	for k,v in pairs(player.GetAll()) do
		v:SetSpectator()
		v.SPEC_NO_SPAWN = false
	end
end

hook.Add("BreachSCPCollected", "BreachSCPCollected_BreachLootSupport", function (ply, num)
	if ply.PS_GivePoints then
		--PS
		ply:PS_GivePoints(num * 500) --500 points per artifact
	end
	ply:AddFrags(num * 5) --5 frags per artifact
	if num > 0 then
		ply:PrintMessage(3, string.format("You were rewarded %d pointshop points and %d frags for collecting %s item(s).", num * 500, num * 5, num))
	end
	--Each artifact counts as 2 kills
	if ply:Team() == TEAM_SCP then
		SCP_KILLS = SCP_KILLS + (num * 2)
	elseif ply:Team() == TEAM_SCI then
		FOUND_KILLS = FOUND_KILLS + (num * 2)
	elseif ply:Team() == TEAM_CHAOS then
		CLASSD_KILLS = CLASSD_KILLS + (num * 2)
	end
end)
