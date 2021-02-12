AddCSLuaFile()


SCP_610_TIMERS = {}
local function SCP610Cleanup()
    for k,v in pairs(SCP_610_TIMERS) do
        timer.Remove(v)
    end
    SCP_610_TIMERS = {}
    for k,v in pairs(player.GetAll()) do
        v:SetNWBool("SCP610_Infect", false)
        v:SetNWBool("SCP610_Rooted", false)
    end
    print("SCP-610: State has been cleared.")
end
hook.Add("BreachStartRound", "BRINITROUND610", SCP610Cleanup)
hook.Add("BreachEndRound", "BRCLEANROUND610", SCP610Cleanup)
hook.Add("PlayerDeath", "PlayerDeathCleanup610ATTR", function (ply)
    ply:SetNWBool("SCP610_Infect", false)
    ply:SetNWBool("SCP610_Rooted", false)
    ply:Freeze(false)
    for k,v in pairs(SCP_610_TIMERS) do
        if string.match(v, ply:SteamID64()) then
            SCP_610_TIMERS[k] = nil
        end
    end
end)