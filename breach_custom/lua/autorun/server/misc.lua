hook.Add("AllowPlayerPickup", "AllowPlayerPickup_PreventTurret", function (ply, ent)
    if ent and IsValid(ent) and ent:GetClass() == "npc_turret_floor" then
        return false
    end
end)

--Allow flashlight for scps on site13
--Also enforces spectator flashlights
timer.Create("SCPAllowFlashlights13", 5, 0, function ()
	if game.GetMap() == "br_scp1730_v2" then
		for k,v in pairs(player.GetAll()) do
			if v:Team() != TEAM_SPEC then
				v:AllowFlashlight(true)
			else
				v:AllowFlashlight(false)
				v:Flashlight(false)
			end
		end
	end
end)
