-- sv_force.lua

util.AddNetworkString("MV.FORCEVOTE");
util.AddNetworkString("MV.FORCEVOTE.NOPE");
util.AddNetworkString("MV.FORCEVOTE.ALREADY");

local voters = {}
local canVote = EXCL_MAPVOTE.ForceVoteWaitTime;
local function doRTV(p)
	if not IsValid(p) then
		return
	elseif CurTime() < canVote then 
		net.Start("MV.FORCEVOTE.NOPE");
		net.WriteInt(math.ceil(canVote-CurTime()),8)
		net.Send(p);
		return
	end

	local needed = math.Round(#player.GetAll()*EXCL_MAPVOTE.PlayerPercentage);

	if not voters[p:UniqueID()] then
		voters[p:UniqueID()] = true;
		net.Start("MV.FORCEVOTE");
		net.WriteEntity(p);
		net.WriteInt(math.Clamp(needed-table.Count(voters),0,1000),8);
		net.Broadcast();
	else
		net.Start("MV.FORCEVOTE.ALREADY");
		net.WriteInt(math.Clamp(needed-table.Count(voters),0,1000),8)
		net.Send(p);
	end

	if table.Count(voters) >= needed then
		for k,v in pairs(player.GetAll()) do
			if not DID_ANNOUNCE then
				v:PrintMessage(3, "The vote has been rocked, the mapvote will start when the current round ends")
				DID_ANNOUNCE = true
			end
		end
		MAPVOTE_RM = 0
	else
		DID_ANNOUNCE = false
	end
end

-- Apparently some systems use 'rtv' and 'forcemap', so we'll add those phrases as well.
hook.Add("PlayerSay","MAPVOTE.HandleForceVote",function(p,tx)
	local t = string.lower(tx);
	if t == "mapvote" or t == "!mapvote" or t == "rtv" or t == "!rtv" or t == "!forcemap" or t == "forcemap" then
		doRTV(p)
		return false;
	end
end)
