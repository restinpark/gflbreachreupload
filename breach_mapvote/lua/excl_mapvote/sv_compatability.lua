-- Here we detect which gamemode the server is running, and then adapt to this gamemode.
-- If you are using a remake of a gamemode or an unofficial version, you should make sure your gamemode is compatable, and if not add compatabily stuff in this file.

print("GFL Breach Mapvoting init")
hook.Add("BreachMapVote", "EXCL_MAPVOTE.Compat.StartVote", function ()
	EXCL_MAPVOTE:Start()
end)
