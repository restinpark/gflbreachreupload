--What the player must type in
DRINK.id = "poison"

--Color of the drink in-game
DRINK.color = Color(255, 0, 0)

--Function executed on player when they drink the stuff
DRINK.OnDrink = function (cup, ply)
    ply:SetBleeding(true)
    ply:PrintMessage(3, "You have been poisoned by SCP-079")
end

--Prevents the player from spawning it. Used for things like SCP-079's poison.
DRINK.RestrictPlayerSpawn = true