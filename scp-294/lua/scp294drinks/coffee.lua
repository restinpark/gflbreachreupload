--What the player must type in
DRINK.id = "coffee"

DRINK.Alias = {"cocaine", "mocoa"}

--Color of the drink in-game
DRINK.color = Color(139, 69, 19)

--Function executed on player when they drink the stuff
DRINK.OnDrink = function (cup, ply)
	if ply.BR_HasSpeedBoost then
		return
	end
	ply.BR_HasSpeedBoost = true

	ply._294oldRunSpeed = ply:GetRunSpeed()
	ply._294oldWalkSpeed = ply:GetWalkSpeed()

	timer.Simple(30, function ()
		if IsValid(ply) and ply.BR_HasSpeedBoost then
			_scp294RemoveCoffee(ply)
		end
	end)

	ply:SetWalkSpeed(ply:GetWalkSpeed() * 1.3)
	ply:SetRunSpeed(ply:GetRunSpeed() * 1.3)
end

--Prevents the player from spawning it. Used for things like SCP-079's poison.
DRINK.RestrictPlayerSpawn = false

hook.Add("DoPlayerDeath", "BR_RemoveSpeedBoost", function (ply)
	ply.BR_HasSpeedBoost = false
end)

function _scp294RemoveCoffee(ply)
	if not ply.BR_HasSpeedBoost then return end

	ply.BR_HasSpeedBoost = false
	ply:SetWalkSpeed(ply._294oldWalkSpeed)
	ply:SetRunSpeed(ply._294oldRunSpeed)
end