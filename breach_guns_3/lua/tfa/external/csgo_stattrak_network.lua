TFA.CSGO = TFA.CSGO or {}

local CSGO = TFA.CSGO

local netStringName = "TFA_CSGO_StatTrak_IncrementKills"

if SERVER then
	util.AddNetworkString(netStringName)

	local function sendKillToPlayer(ply, wep)
		if not IsValid(ply) or not ply:IsPlayer() then return end

		if IsValid(wep) and wep:IsWeapon() and wep.IsTFACSGOWeapon then
			net.Start(netStringName)
			net.WriteString(wep:GetClass())
			net.Send(ply)
		end
	end

	hook.Add("OnNPCKilled", "TFA_CSGO_StatTrak_NPCKilled", function(npc, attacker, inflictor)
		if npc == attacker then return end

		sendKillToPlayer(attacker, inflictor)
	end)

	hook.Add("PlayerDeath", "TFA_CSGO_StatTrak_PlayerDeath", function(ply, inflictor, attacker)
		if ply == attacker then return end

		sendKillToPlayer(attacker, inflictor)
	end)
end

if CLIENT then
	net.Receive(netStringName, function()
		local class = net.ReadString()

		CSGO.IncrementKills(class)
	end)
end