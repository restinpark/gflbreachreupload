--What the player must type in
DRINK.id = "cola"

DRINK.Alias = {"aloe", "cactus", "health", "pepsi", "coke"}

--Color of the drink in-game
DRINK.color = Color(114, 13, 52)

--Function executed on player when they drink the stuff
DRINK.OnDrink = function (cup, ply)
    if ply:Health() + 15 > ply:GetMaxHealth() then
        ply:SetHealth(ply:GetMaxHealth())
    else
        ply:SetHealth(ply:Health() + 15)
    end
    ply:SetBleeding(false)
end

--Prevents the player from spawning it. Used for things like SCP-079's poison.
DRINK.RestrictPlayerSpawn = false