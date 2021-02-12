--Prevents players from flooding the server with ulx psay (or any ulx command)
--I know mls isn't setup in an 'ideal' way but honestly fuck you this is easier
timer.Create("ResetMLSEachTick", 1, 0, function ()
    for k,v in pairs(player.GetAll()) do
        v.mls = 0
    end
end)

timer.Create("BanPlayersWhoAreBaddies", 1, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v.shouldgetbannednextframe and v.shouldgetbannednextframe == "lmao1" then
            RunConsoleCommand("ulx", "sbanid", v:SteamID(), "0", "BOOMER DETECTED")
            v.shouldgetbannednextframe = nil
        end  
    end
end)

hook.Add("ULibCommandCalled", "ULibCommandCalled_HackerCheck", function (ply, cmd)
    if IsValid(ply) then
        if not ply.mls then
            ply.mls = 0
        end
        ply.mls = ply.mls + 1
        if ply.mls > 15 then
            ply.shouldgetbannednextframe = "lmao1" 
        end
    end
end)
