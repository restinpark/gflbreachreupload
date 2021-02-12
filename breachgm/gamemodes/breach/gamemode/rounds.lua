if SERVER then
--function OldAssaultGamemode()
	--ULib.tsayColor( nil, false, Color(255, 0, 0), "This round is a special round. Type:",Color(0, 179, 0)," Team Deathmatch"	)
	--ULib.tsayColor( nil, false, Color(255, 0, 0), "Half of you are MTF and the other half are Chaos Insurgency members. Kill the other side before time runs out.")
	--roundisspecial = true
	--assault_respawn_mode = true
	--local all = GetActivePlayers()
	--for i=1, math.Round(#all / 2) do
		--local pl = table.Random(all)
		--pl:SetNTF()
		--pl:SetPos(SPAWN_GUARD_HALLWAY[i])
		--table.RemoveByValue(all, pl)
	--end
	--for k,v in ipairs(all) do
		--v:SetChaosInsurgency(4)
		--v:StripWeapon("weapon_slam")
		--v:SetPos(SPAWN_CLASSD[k])
	--end
--end

hook.Add("BreachOverrideWinners", "BreachOverrideWinners_Assault", function ()
	if GetGlobalString("round_type", "normal") == "tdm" or GetGlobalString("round_type") == "spies" then
		if team.NumPlayers(TEAM_GUARD) > team.NumPlayers(TEAM_CHAOS) then
			return {
				winner = TEAM_GUARD,
				pscp = 0,
				pcd = 0,
				pfd = 299
			}
		else
			return {
				winner = TEAM_CHAOS,
				pscp = 0,
				pcd = 299,
				pfd = 0
			}
		end
	end
end)

function SetupAssault()
	local all = GetActivePlayers()
	local num_scp = 3
	local num_guard = math.Round((#all - 3) * 0.3)
	local num_chaos = math.Round((#all - 3) * 0.3)
	local num_classd = math.Round((#all - 3) * 0.2)
	local num_scient = math.Round((#all - 3) * 0.1)
	local scps = table.Copy(SPCS)
	for i=1, num_scp do
		local ply = table.Random(all)
		local scp = table.Random(scps)
		table.RemoveByValue(scps, scp)
		table.RemoveByValue(all, ply)
		scp["func"](ply)
	end
	for i=1, num_guard do
		local ply = table.Random(all)
		ply:SetGuard()
		ply:SetPos(table.Random(SPAWN_GUARD))
		table.RemoveByValue(all, ply)
	end
	for i=1, num_chaos do
		local ply = table.Random(all)
		ply:SetChaosInsurgency(4)
		ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		ply:SetPos(table.Random(SPAWN_OUTSIDE))
		table.RemoveByValue(all, ply)
	end
	for i=1, num_classd do
		local ply = table.Random(all)
		ply:SetClassD()
		ply:SetPos(table.Random(SPAWN_CLASSD))
		table.RemoveByValue(all, ply)
	end
	for i=1, num_scient do
		local ply = table.Random(all)
		ply:SetScientist()
		ply:SetPos(table.Random(SPAWN_SCIENT))
		table.RemoveByValue(all, ply)
	end
	for k,v in pairs(all) do
		v:SetClassD()
		v:SetPos(table.Random(SPAWN_CLASSD))
	end
end

function ZombieGamemode()
	ULib.tsayColor( nil, false, Color(255, 0, 0), "This round is a special round. Type:",Color(0, 179, 0)," Zombie Plague"	)
	ULib.tsayColor( nil, false, Color(255, 0, 0), "After the round begins, some of you will become infected, the MTF Guards must prevent the spread of SCP-008.")
	local all = GetActivePlayers()
	zombieround = true
	roundisspecial = true
	local allspawns = {}
	table.Add(allspawns, SPAWN_GUARD_HALLWAY)
	//table.Add(allspawns, SPAWN_OUTSIDE)
	table.Add(allspawns, SPAWN_SCIENT)
	table.Add(allspawns, SPAWN_CLASSD)
	for i=1, #all do
		local pl = table.Random(all)
		local spawn = table.Random(allspawns)
		pl:SetGuard()
		pl:SetPos(spawn)
		table.RemoveByValue(allspawns, spawn)
		table.RemoveByValue(all, pl)
	end
end
--Requires like, idk 30?
function oh5ret()
	ULib.tsayColor( nil, false, Color(255, 0, 0), "This round is a special round. Type:",Color(0, 179, 0)," 05 Retrieval"	)
	ULib.tsayColor( nil, false, Color(255, 0, 0), "There is an 05 Command Member and a bunch of SCPs in the facility. The MTF Unit Red Right Hand must save the 05 member before the scps kill him.")
	oh5round = true
	local all = GetActivePlayers()
	--Allow duplicates
	local scp_count = math.Clamp((1 / 2) * #all, 1, 16)
	local counter = 0
	local spctab = table.Copy(SPCS)
	while counter < scp_count do
		if #spctab < 1 then
			print("Not enough scps, copying another table.")
			spctab = table.Copy(SPCS)
		end
		local ply = table.Random(all)
		local scp = table.Random(spctab)
		scp["func"](ply)
		table.RemoveByValue(spctab, scp)
		table.RemoveByValue(all, ply)
		counter = counter + 1
	end
	--Pick the 05 commander
	local o5 = table.Random(all)
	local spawn = table.Random(SPAWN_SCIENT)
	o5:Set05()
	o5:SetPos(spawn)
	table.RemoveByValue(all, o5)
	--Everyone else is RRH and spawn outside
	for k,v in pairs(all) do
		v:SetRRH()
		v:SetPos(table.Random(SPAWN_OUTSIDE))
	end
end

function SPCSetup()
	sclassrespawn = true
	local all = table.Copy(GetActivePlayers())
	local sharks = #all * ( 2 / 3)
	for i = 1, sharks do
		local pl = table.Random(all)
		pl:SetSClass()
		pl:SetPos(table.Random(SPAWN_CLASSD))
		table.RemoveByValue(all, pl)
	end
	for k,v in pairs(all) do
		v:SetSPCGuard()
		v:SetPos(table.Random(SPAWN_GUARD))
	end
end

function WarSetup()
	local all = table.Copy(GetActivePlayers())
	local union = #all * ( 1 / 2)
	for i = 1, union do
		local pl = table.Random(all)
		pl:SetUni()
		pl:SetPos(table.Random(SPAWN_GUARD))
		table.RemoveByValue(all, pl)
	end
	for k,v in pairs(all) do
		v:SetConf()
		v:SetPos(table.Random(SPAWN_CLASSD))
	end
end

function SetupEzDay()
	local all = table.Copy(GetActivePlayers())
	local classe = #all * ( 1 / 3)
	for i = 1, classe do
		local pl = table.Random(all)
		pl:SetClassE()
		pl:SetPos(table.Random(SPAWN_CLASSE))
		table.RemoveByValue(all, pl)
	end
	for k,v in pairs(all) do
		v:SetClassD()
		v:SetPos(table.Random(SPAWN_CLASSD))
	end
end

function SetupRandom()
	local all = table.Copy(GetActivePlayers())
	local rando = #all * ( 1 / 3)
	for i = 1, rando do
		local pl = table.Random(all)
		pl:SetRandom()
		pl:SetPos(table.Random(SPAWN_GUARD_HALLWAY))
		table.RemoveByValue(all, pl)
	end
	for k,v in pairs(all) do
		v:SetClassD()
		v:SetPos(table.Random(SPAWN_CLASSD))
	end
end

function SetupFFA()
	local all = table.Copy(GetActivePlayers())
	local a = #all * ( 1 / 3)
	for i = 1, a do
		local pl = table.Random(all)
		pl:SetChaosInsCom()
		pl:SetPos(table.Random(SPAWN_CLASSD))
		table.RemoveByValue(all, pl)
	end
	local b = #all * ( 1 / 3)
	for i = 1, b do
		local pl = table.Random(all)
		pl:SetRRH()
		pl:SetPos(table.Random(SPAWN_GUARD))
		table.RemoveByValue(all, pl)
	end
	local c = #all * ( 1 / 2)
	for i = 1, c do
		local pl = table.Random(all)
		pl:SetNobody()
		pl:SetPos(SPAWN_682)
		table.RemoveByValue(all, pl)
	end
	for k,v in pairs(all) do
		v:SetSerpentsHand()
		v:SetPos(SPAWN_096)
	end
end

function InfectPeople()
	local all = GetActivePlayers()
	for i=1, #all / 4 do
		local pl = table.Random(all)
		pl:SetSCP0082()
		table.RemoveByValue(all, pl)
	end
end
function Pandemic()

	roundisspecial = true
	local plys = GetActivePlayers()
	local scps
	local spawns = {
		SPAWN_173,
		SPAWN_049,
		SPAWN_066,
		SPAWN_966,
		SPAWN_035
	}
	local all = #plys
	if all < 8 then
		scps = 1
	elseif all > 7 and all < 16 then
		scps = 2
	elseif all > 15 and all < 33 then
		scps = 3
	elseif all > 32 and all < 51 then
		scps = 4
	elseif all > 50 then
		scps = 5
	end

	for i=1, scps do
		local pl = table.Random(plys)
		local spawn = table.Random(spawns)
		pl:SetSCP049()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( spawns, spawn)
		table.RemoveByValue( plys, pl )
	end

	local mtfspawns = table.Copy(SPAWN_GUARD)
	local dspawns = table.Copy(SPAWN_CLASSD)
	local scispawns = table.Copy(SPAWN_SCIENT)

	for i=1, math.ceil(all / 3) do
		local pl = table.Random(plys)
		local spawn = table.Random(mtfspawns)
		pl:SetGuard()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( mtfspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, math.ceil(all / 4) do
		local pl = table.Random(plys)
		local spawn = table.Random(scispawns)
		pl:SetScientist()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( scispawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, all do
		local pl = table.Random(plys)
		local spawn = table.Random(dspawns)
		pl:SetClassD()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( dspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
end
function Pandemic2()

	roundisspecial = true
	local plys = GetActivePlayers()
	local scps
	local spawns = {
		SPAWN_173,
		SPAWN_049,
		SPAWN_066,
		SPAWN_966,
		SPAWN_035
	}
	local all = #plys
	if all < 8 then
		scps = 1
	elseif all > 7 and all < 16 then
		scps = 2
	elseif all > 15 and all < 33 then
		scps = 3
	elseif all > 32 and all < 51 then
		scps = 4
	elseif all > 50 then
		scps = 5
	end

	for i=1, scps do
		local pl = table.Random(plys)
		local spawn = table.Random(spawns)
		pl:SetSCP049()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( spawns, spawn)
		table.RemoveByValue( plys, pl )
	end

	local mtfspawns = table.Copy(SPAWN_GUARD)
	local dspawns = table.Copy(SPAWN_CLASSD)
	local scispawns = table.Copy(SPAWN_SCIENT)

	for i=1, math.ceil(all / 3) do
		local pl = table.Random(plys)
		local spawn = table.Random(mtfspawns)
		pl:SetGuard()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( mtfspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, math.ceil(all / 4) do
		local pl = table.Random(plys)
		local spawn = table.Random(scispawns)
		pl:SetScientist()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( scispawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, all do
		local pl = table.Random(plys)
		local spawn = table.Random(dspawns)
		pl:SetClassD()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( dspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
end
function WeepAngels()

	roundisspecial = true
	local plys = GetActivePlayers()
	local scps
	local spawns = {
		SPAWN_173,
		SPAWN_049,
		SPAWN_066,
		SPAWN_966,
		SPAWN_035
	}
	local all = #plys
	if all < 8 then
		scps = 1
	elseif all > 7 and all < 16 then
		scps = 2
	elseif all > 15 and all < 33 then
		scps = 3
	elseif all > 32 and all < 51 then
		scps = 4
	elseif all > 50 then
		scps = 5
	end

	for i=1, scps do
		local pl = table.Random(plys)
		local spawn = table.Random(spawns)
		pl:SetSCP173()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( spawns, spawn)
		table.RemoveByValue( plys, pl )
	end

	local mtfspawns = table.Copy(SPAWN_GUARD)
	local dspawns = table.Copy(SPAWN_CLASSD)
	local scispawns = table.Copy(SPAWN_SCIENT)

	for i=1, math.ceil(all / 3) do
		local pl = table.Random(plys)
		local spawn = table.Random(mtfspawns)
		pl:SetGuard()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( mtfspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, math.ceil(all / 4) do
		local pl = table.Random(plys)
		local spawn = table.Random(scispawns)
		pl:SetScientist()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( scispawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, all do
		local pl = table.Random(plys)
		local spawn = table.Random(dspawns)
		pl:SetClassD()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( dspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
end

function Speedrun()

	roundisspecial = true
	local plys = GetActivePlayers()
	local scps
	local all = #plys
	if all < 8 then
		scps = 4
	elseif all > 7 and all < 16 then
		scps = 4
	elseif all > 15 and all < 33 then
		scps = 4
	elseif all > 32 and all < 51 then
		scps = 4
	elseif all > 50 then
		scps = 4
	end

	for i=1, scps do
		local pl = table.Random(plys)
		pl:SetSCP079()
		pl:SetPos(SPAWN_079)
		all = all - 1
		table.RemoveByValue( plys, pl )
	end

	local shspawns = table.Copy(SPAWN_GUARD)
	local dspawns = table.Copy(SPAWN_CLASSD)

	for i=1, math.ceil(all / 3) do
		local pl = table.Random(plys)
		local spawn = table.Random(shspawns)
		pl:SetSerpentsHand()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( shspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, all do
		local pl = table.Random(plys)
		local spawn = table.Random(dspawns)
		pl:SetClassD()
		pl:SetPos(spawn)
		pl:Give("keycard_fm")
		pl:Give("weapon_scp512")
		pl:Give("weapon_scp_500")
		pl:Give("weapon_bathwater")
		pl:Give("toybox_crowbar")
		pl:Give("tfa_csgo_revolver")
		pl:GiveAmmo(128, "Pistol", true)
		all = all - 1
		table.RemoveByValue( dspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
end

function Terminate()

	roundisspecial = true
	termrespawn = true
	local plys = GetActivePlayers()
	local scps
	local scpsr
	local all = #plys
	if all < 8 then
		scps = 1
	elseif all > 7 and all < 16 then
		scps = 1
	elseif all > 15 and all < 33 then
		scps = 1
	elseif all > 32 and all < 51 then
		scps = 1
	elseif all > 50 then
		scps = 1
	end
	
	if all < 8 then
		scpsr = 1
	elseif all > 7 and all < 16 then
		scpsr = 1
	elseif all > 15 and all < 33 then
		scpsr = 1
	elseif all > 32 and all < 51 then
		scpsr = 1
	elseif all > 50 then
		scpsr = 1
	end

	for i=1, scps do
		local pl = table.Random(plys)
		pl:SetSCP096T()
		pl:SetPos(SPAWN_096)
		all = all - 1
		table.RemoveByValue( plys, pl )
	end
	
	for i=1, scpsr do
		local pl = table.Random(plys)
		pl:SetSCP173T()
		pl:SetPos(table.Random(SPAWN_GUARD))
		all = all - 1
		table.RemoveByValue( plys, pl )
	end

	local trospawns = table.Copy(SPAWN_GUARD)
	local acdspawns = table.Copy(SPAWN_GUARD)

	for i=1, math.ceil(all / 2) do
		local pl = table.Random(plys)
		local spawn = table.Random(trospawns)
		pl:SetNu7()
		pl:SetPos(spawn)
		pl:Give("item_medkit")
		pl:GiveAmmo(1000, "AR2", true)
		all = all - 1
		table.RemoveByValue( trospawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, all do
		local pl = table.Random(plys)
		local spawn = table.Random(acdspawns)
		pl:SetNu7T()
		pl:SetPos(spawn)
		all = all - 1
		table.RemoveByValue( acdspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
end

function Zoo()

	roundisspecial = true
	local plys = GetActivePlayers()
	local scps
	local spawns = {
		SPAWN_173,
		SPAWN_049,
		SPAWN_066,
		SPAWN_966
	}
	local all = #plys
	if all < 8 then
		scps = 4
	elseif all > 7 and all < 16 then
		scps = 5
	elseif all > 15 and all < 33 then
		scps = 6
	elseif all > 32 and all < 51 then
		scps = 7
	elseif all > 50 then
		scps = 8
	end

	for i=1, scps do
		local pl = table.Random(plys)
		local spawn = table.Random(spawns)
		pl:SetSCPZoo()
		pl:SetPos(spawn)
		pl:SetTeam(TEAM_SCP)
		all = all - 1
		table.RemoveByValue( plys, pl )
	end

	local mtfspawns = table.Copy(SPAWN_GUARD)
	local dspawns = table.Copy(SPAWN_CLASSD)
	local scispawns = table.Copy(SPAWN_SCIENT)

	for i=1, math.ceil(all / 3) do
		local pl = table.Random(plys)
		local spawn = table.Random(mtfspawns)
		pl:SetGuardZoo()
		pl:SetPos(spawn)
		pl:SetTeam(TEAM_GUARD)
		all = all - 1
		table.RemoveByValue( mtfspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, math.ceil(all / 4) do
		local pl = table.Random(plys)
		local spawn = table.Random(scispawns)
		pl:SetFriendZoo()
		pl:SetPos(spawn)
		pl:SetTeam(TEAM_SCI)
		all = all - 1
		table.RemoveByValue( scispawns, spawn)
		table.RemoveByValue( plys, pl )
	end
	for i=1, all do
		local pl = table.Random(plys)
		local spawn = table.Random(dspawns)
		pl:SetClassD()
		pl:SetPos(spawn)
		pl:SetModel(pl:GetSciModel(TEAM_SCI))
		pl:Give("keycard_bs")
		all = all - 1
		table.RemoveByValue( dspawns, spawn)
		table.RemoveByValue( plys, pl )
	end
end


function SetupGravity()
	roundisspecial = false
	RunConsoleCommand("sv_gravity", "200")
	SetupPlayers( GetRoleTable(#GetActivePlayers()) )

end

function SetupFQSR()
	roundisspecial = false
	SetupPlayers( GetRoleTable(#GetActivePlayers()) )
		for k,v in pairs(player.GetAll()) do
			if v:Team() == TEAM_CLASSD or v:Team() == TEAM_GUARD or v:Team() == TEAM_SCI then
				v:Give("weapon_physcannon")
		end
	end
end
function ChangeRoundDurationTo8()
	SetGlobalFloat("br_round_end", CurTime() + (60 * 8))
end
function ResetGravity()
	RunConsoleCommand("sv_gravity", "600")
end
hook.Add("BreachEndRound", "ResetG_Breach", ResetGravity)

--Escort round

function InitializeEscort()
	local all = table.Copy(GetActivePlayers())
	local pcount = #all
	--Get amount of 035, roughly 8 would be ideal on a 45 player server
	local scp_count = math.Clamp(math.Round(pcount * 0.177777), 1, 15)

	--Copy spawn table
	local vip_spawn = table.Copy(SPAWN_CLASSD)

	--Pick the VIP
	local vip = table.Random(all)
	table.RemoveByValue(all, vip)

	--Pick the SCPs
	local counter = 0
	while counter < scp_count do
		local pick = table.Random(all)
		if pick and IsValid(pick) and pick:IsPlayer() then
			table.RemoveByValue(all, pick)
			pick:SetSCP035()
			pick:PrintMessage(2, "Escort the VIP at all costs!")
			pick:Give("item_medkit")
			local spawn
			if #vip_spawn <= 0 then
				ServerLog("Ran out of D class spawns during a escort round, please fix.\n")
				vip_spawn = table.Copy(SPAWN_CLASSD)
			end
			spawn = table.Random(vip_spawn)
			table.RemoveByValue(vip_spawn, spawn)
			pick:SetPos(spawn)
			counter = counter + 1
		end
		
	end
	if #vip_spawn <= 0 then
		ServerLog("Ran out of D class spawns during a escort round, please fix.\n")
		vip_spawn = table.Copy(SPAWN_CLASSD)
	end
	local vip_s = table.Random(vip_spawn)

	--Spawn the d class
	
	if vip and IsValid(vip) and vip:IsPlayer() then
		vip:SetClassD()
		vip:SetPos(vip_s)
	end

	--Spawn the guards

	for k,v in pairs(all) do
		if v and IsValid(v) and v:IsPlayer() then
			v:SetGuard()
			v:SetPos(table.Random(SPAWN_GUARD))
		end
	end

	--Install round timers and hooks

	--Custom win check
	if timer.Exists("EscortWinChecker") then
		timer.Remove("EscortWinChecker")
	end
	timer.Create("EscortWinChecker", 1, 0, function ()
		if roundtype.name != "Escort" then
			--Remove the round glitches or something
			if timer.Exists("EscortWinChecker") then
				timer.Remove("EscortWinChecker")
			end
			return
		end
		--Check if the VIP left, died, or is no longer class d.
		if not vip or not IsValid(vip) or not vip:IsPlayer() or vip:Team() != TEAM_CLASSD then
			--The 2 no longer does anything
			EndRound(2)
		end
	end)
	hook.Remove("BreachEndRound", "BreachEndRound_Escort")
	hook.Add("BreachEndRound", "BreachEndRound_Escort", function()
		if timer.Exists("EscortWinChecker") then
			timer.Remove("EscortWinChecker")
		end
		hook.Remove("BreachEndRound", "BreachEndRound_Escort")
	end)


end

end
normalround = {
	playersetup = function()
		roundisspecial = false
		SetupPlayers( GetRoleTable(#GetActivePlayers()) )
	end,
	name = "Containment breach",
	minplayers = 3,
	allowntfspawn = true,
	mtfandscpdelay = true,
	onroundstart = nil,
	spawnitems = true,
	roundrules = nil
}

ROUNDS_T = {
	--tdm = {
		--playersetup = OldAssaultGamemode,
		--name = "Team Deathmatch",
		--minplayers = 10,
		--allowntfspawn = false,
		--mtfandscpdelay = false,
		--onroundstart = ChangeRoundDurationTo8,
		--spawnitems = true,
		--Unused
		--roundrules = {"Wipe out the enemy team without harming any of your team."},
		--Unused
		--override_role_desc = {
			--["MTF Nine Tailed Fox"] = {
				--"You are an MTF Guard",
				--{
					--"Kill the other side before time runs out."
				--}
			--},
			--["Chaos Insurgency"] = {
				--"You are a CI Soldier",
				--{
					--"Kill the other side before time runs out."
				--}
			--}
		--}
	--},
	multiplebreaches = {
		playersetup = function()
			roundisspecial = false
			ULib.tsayColor( nil, false, Color(255, 0, 0), "This round is a special round. Type:",Color(0, 179, 0)," Multiple Breaches"	)
			ULib.tsayColor( nil, false, Color(255, 0, 0), "There are only Class Ds and more SCPs this round.")
			local pnum = #GetActivePlayers()
			if pnum < 7 then
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 1, 0, 0, 0, false))
			elseif pnum > 6 and pnum < 13 then
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 2, 0, 0, 0, false))
			elseif pnum > 12 and pnum < 32 then
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 3, 0, 0, 0, false))
			else
				SetupPlayers(GetRoleTableCustom(#GetActivePlayers(), 6, 0, 0, 0, false))
			end
		end,
		name = "Multiple breaches",
		minplayers = 10,
		allowntfspawn = true,
		mtfandscpdelay = true,
		onroundstart = nil,
		spawnitems = true
	},
	lowgr = {
		playersetup = SetupGravity,
		name = "Low Gravity",
		minplayers = 5,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	fqsr = {
		playersetup = SetupFQSR,
		name = "Fast Quick Slow Round",
		minplayers = 5,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	weep = {
		playersetup = WeepAngels,
		name = "Weeping Angels",
		minplayers = 25,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil,
	},
	speedrun = {
		playersetup = Speedrun,
		name = "Speedrun%",
		minplayers = 15,
		allowntfspawn = false,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil,
	},
	zoo = {
		playersetup = Zoo,
		name = "Human Zoo",
		minplayers = 10,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil,
	},
	terminate = {
		playersetup = Terminate,
		name = "Termination of SCP-096",
		minplayers = 10,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = false,
		onroundstart = nil,
		override_role_desc = {
			["MTF Nu-7"] = {
				"You are an MTF Guard",
				{
					"Your team has been sent in to terminate SCP-096.",
					"Half of your team is equipped with acid needles that will make SCP-096 more vulnerable.",
					"The needles will only be effective if SCP-173 has broken SCP-096's bones so be cautious."
				}
			},
			["SCP-173"] = {
				"You are SCP-173",
				{
					"You are being used by the Foundation to terminate SCP-096.",
					"Your mission is to break SCP-096's bones in order for the rest of the team to nullify him."
				}
			},
			["SCP-096"] = {
				"You are SCP-096",
				{
					"The Foundation has sent in two teams and SCP-173 to finally terminate you.",
					"Look out for SCP-173 if he breaks your bones you will be more vulnerable to the acid needles the MTF carry.",
					"Also if you take too much acid into your body you will be severly weakened and open to attack.",
					"Kill everyone that gets in your way and escape before you are killed."
				}
			},
		}
	},
	plague = {
		playersetup = Pandemic,
		name = "Pandemic",
		minplayers = 20,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	ezday = {
		playersetup = SetupEzDay,
		name = "Half-Life E",
		minplayers = 10,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	malpractice = {
		playersetup = Pandemic2,
		name = "Malpractice",
		minplayers = 20,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	rando = {
		playersetup = SetupRandom,
		name = "WTF IS GOING ON?!?",
		minplayers = 5,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	siege = {
		playersetup = SetupAssault,
		name = "Assault",
		minplayers = 20,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	terisim = {
		playersetup = SPCSetup,
		name = "SPC Breach",
		minplayers = 20,
		allowntfspawn = false,
		mtfandscpdelay = true,
		spawnitems = false,
		onroundstart = nil,
		roundrules = {"Wipe out the other team without harming any of yours."}
	},
	civilwar = {
		playersetup = WarSetup,
		name = "Civil Dispute",
		minplayers = 10,
		allowntfspawn = false,
		mtfandscpdelay = true,
		spawnitems = false,
		onroundstart = nil,
		roundrules = {"End the war once and for all."}
	},
	ffa = {
		playersetup = SetupFFA,
		name = "#squadgoals",
		minplayers = 10,
		allowntfspawn = false,
		mtfandscpdelay = true,
		spawnitems = false,
		onroundstart = nil,
		roundrules = {"Teams auto balanced!."}
	},
	oh5ret = {
		playersetup = oh5ret,
		name = "O5 Retrieval",
		minplayers = 25,
		allowntfspawn = false,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = nil
	},
	escort = {
		playersetup = InitializeEscort,
		name = "Escort",
		minplayers = 25,
		allowntfspawn = true,
		mtfandscpdelay = true,
		spawnitems = true,
		onroundstart = function ()
			for k,v in pairs(player.GetAll()) do
				if v:Team() == TEAM_GUARD then
					v:PrintMessage(3, "You must kill the VIP! (D Class)")
				elseif v:Team() == TEAM_SCP then
					v:PrintMessage(3, "You must defend the VIP! (D Class)")
				elseif v:Team() == TEAM_CLASSD then
					v:PrintMessage(3, "You are the VIP, you must escape. The 035s should defend you.")
				end
			end
		end,
	}
	
}

ROUNDS = {}
for k,v in pairs(ROUNDS_T) do
	if not v.blacklisted_maps or not v.blacklisted_maps[game.GetMap()] then
		ROUNDS[k] = v
	end
end
--