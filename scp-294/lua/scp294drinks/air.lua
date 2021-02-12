--What the player must type in
DRINK.id = "air"

DRINK.Alias = {"nothing", "cup", "emptiness", "void", "vacuum", "halflifethree", "hl3", "no", "nil"}

--Color of the drink in-game
DRINK.color = Color(255, 255, 255)

--Function executed on player when they drink the stuff
DRINK.OnDrink = function (cup, ply)
    ply:PrintMessage(3, "This cup is empty.")
end

--Prevents the player from spawning it. Used for things like SCP-079's poison.
DRINK.RestrictPlayerSpawn = false