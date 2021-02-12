
local mply = FindMetaTable( "Player" )

function mply:CLevelGlobal()
	local biggest = 1
	for k,wep in pairs(self:GetWeapons()) do
		if IsValid(wep) then
			if wep.clevel then
				if wep.clevel > biggest then
					biggest =  wep.clevel
				end
			end
		end
	end
	return biggest
end 

function mply:CLevel()
	local wep = self:GetActiveWeapon()
	if IsValid(wep) then
		if wep.clevel then
			return wep.clevel
		end
	end
	return 1
end 

function mply:GetKarma()
	return self:GetNWInt("breach_karma", 1000)
end

--Save value on disconnect, and reload them on reconnect
if SERVER then
	KARMA_SAVED_VALUES = {}
	hook.Add("PlayerDisconnected", "PlayerDisconnectedKarma", function(ply)
		if not ply.Ban then
			KARMA_SAVED_VALUES[ply:SteamID()] = ply:GetKarma()
		else
			KARMA_SAVED_VALUES[ply:SteamID()] = nil
		end
	end)
	hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn_BREACHKARMA", function (ply)
		if KARMA_SAVED_VALUES[ply:SteamID()] then
			ply:SetNWInt("breach_karma", KARMA_SAVED_VALUES[ply:SteamID()])
			KARMA_SAVED_VALUES[ply:SteamID()] = nil
		end
	end)
end

