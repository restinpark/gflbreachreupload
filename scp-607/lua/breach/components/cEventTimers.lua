C_EVENTTIMER = C_EVENTTIMER or nil

--The newest event timer always takes priority
net.Receive("BREACH_SetupEventTimer", function ()
    local id = net.ReadUInt(32)
    local t = net.ReadFloat()
    local s = net.ReadString()

    print("CEventTimers.lua: server setup an event timer: " .. s)
    C_EVENTTIMER = {
        e_Id = id,
        expires = t,
        i_duration = t - CurTime(),
        prompt = s
    }
end)

net.Receive("BREACH_RemoveEventTimer", function ()
    local id = net.ReadUInt(32)
    print("cEventTimers.lua: server wants to remove " .. tostring(id))
    if C_EVENTTIMER and id == C_EVENTTIMER.e_Id then
        C_EVENTTIMER = nil
    end
end)

surface.CreateFont("Breach_EventTimerFont", {
    font = "Roboto",
    extended = true,
    size = ScreenScale(16),
    weight = 500,
    antialias = true
})

--Boring hud display stuff

hook.Add("HUDPaint", "DrawEventTimers", function ()
    if C_EVENTTIMER != nil && C_EVENTTIMER.expires > CurTime() then
        local x, y
        local ws = ScrW() / 1920
        local hs = ScrH() / 1080
        x = (ScrW() / 2) - (75 * ws)
        y = ScrH() - (300 * hs)

        draw.DrawText(C_EVENTTIMER.prompt, Breach_EventTimerFont, x, y, Color( 255, 255, 255, 180 ), TEXT_ALIGN_LEFT)
        draw.DrawText(string.ToMinutesSeconds(math.Clamp(C_EVENTTIMER.expires - CurTime(), 0, 5999)) , Breach_EventTimerFont, x + (150 * ws), y, Color( 255, 255, 255, 180 ), TEXT_ALIGN_RIGHT)

        surface.SetDrawColor(255, 255, 255, 180)
        surface.DrawRect(x, y + (hs * 40), math.Round(((C_EVENTTIMER.expires - CurTime()) / C_EVENTTIMER.i_duration) * (150 * ws)), 14 * hs)
    end
end)