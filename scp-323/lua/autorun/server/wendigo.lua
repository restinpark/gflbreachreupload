ROLE_SCP323 = ROLE_SCP323 or "SCP-323"

hook.Add("DoPlayerDeath", "DoPlayerDeathWendigo", function (ply)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP323 then
        local wendigo = ents.Create("ent_wendigo")
        if IsValid(wendigo) then
            wendigo:SetPos(ply:GetPos())
            wendigo.Owner = ply
            wendigo:Spawn()

            ply:PrintMessage(HUD_PRINTTALK, "[Wendigo] You will be respawned as SCP-323 if somebody touches your skull.")
        end
    end
end)