--Visible event timers, similar to the ones in CS:GO when defusing the bomb

AddCSLuaFile("cEventTimers.lua")
util.AddNetworkString("BREACH_SetupEventTimer")
util.AddNetworkString("BREACH_RemoveEventTimer")

--Both of these are not local to protect against auto refresh, but they should not be used outside of this file
--The following comment is just a thing im testing with my build scripts (builds a server hierachy for breach and all of its content packs in one go).
--@br_build: server: WarnExternalUse(EVENT_TIMERS, HIGHEST_TIMER_ID_TO_DATE)
EVENT_TIMERS = EVENT_TIMERS or {}
HIGHEST_TIMER_ID_TO_DATE = HIGHEST_TIMER_ID_TO_DATE or 0--Using table.Count will result in us overwritting removed / expired timers, so this will ensure we always get a unique id for our timers

--ply can also be a table of player objects
--target_time is time relative to CurTime()
--disrupt_event is a function that returns true when the timer should be disrupted, nil if timer should never be disrupted
--onSuccess is executed when the timer finishes without disruption, takes the initial player object as a parameter, make sure you check whether or not this is ply or ply[]
--prompt, can be nil. Basically a brief description of what the timer is for. (i.e. reviving target, etc)
function BREACH_SetupEventTimer(ply, target_time, disrupt_event, onSuccess, prompt)
    local c_tid = HIGHEST_TIMER_ID_TO_DATE + 1
    EVENT_TIMERS[c_tid] = {
        players = ply,
        expires = target_time,
        disrupt = disrupt_event,
        success = onSuccess,
    }

    net.Start("BREACH_SetupEventTimer")
    net.WriteUInt(c_tid, 32)
    net.WriteFloat(target_time)
    net.WriteString(prompt or "")
    net.Send(ply)

    return c_tid
end

timer.Create("BREACH_CHECKEVENTTIMERS", 0.1, 0, function ()
    for k,v in pairs(EVENT_TIMERS) do
        --Timer is expired, remove it
        if v["disrupt"]() then
            net.Start("BREACH_RemoveEventTimer")
            net.WriteUInt(k, 32)
            net.Broadcast()
            EVENT_TIMERS[k] = nil
        elseif v.expires < CurTime() then
            v["success"](v.players)
            net.Start("BREACH_RemoveEventTimer")
            net.WriteUInt(k, 32)
            net.Broadcast()
            EVENT_TIMERS[k] = nil
        end
    end
end)