--What the player must type in
DRINK.id = "alcohol"

DRINK.Alias = {"rum", "beer", "spirit", "spirits", "vodka", "whisky"}

--Color of the drink in-game
DRINK.color = Color(255, 204, 0)

--Function executed on player when they drink the stuff
DRINK.OnDrink = function (cup, ply)
    net.Start("BREACH_294_DRUNK")
	net.WriteInt(5, 8)
	net.Send(ply)
end

--Prevents the player from spawning it. Used for things like SCP-079's poison.
DRINK.RestrictPlayerSpawn = false