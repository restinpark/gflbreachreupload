--What the player must type in
DRINK.id = "gary"

--Color of the drink in-game
DRINK.color = Color(0, 0, 0)

--Function executed on player when they drink the stuff
DRINK.OnDrink = function (cup, ply)
    ply:SetBleeding(true)
    ply:PrintMessage(3, "No")
    ULib.slap(ply)
end

--Prevents the player from spawning it. Used for things like SCP-079's poison.
DRINK.RestrictPlayerSpawn = false