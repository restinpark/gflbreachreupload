--What the player must type in
DRINK.id = "buckettruck"

--Color of the drink in-game
DRINK.color = Color(0, 255, 0)

--Function executed on player when they drink the stuff
DRINK.OnDrink = function (cup, ply)
    ply:PrintMessage(3, "That's not food...")
    ply:Kill()
end

--Prevents the player from spawning it. Used for things like SCP-079's poison.
DRINK.RestrictPlayerSpawn = false