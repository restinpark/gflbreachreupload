ROLE_DRBRIGHT = ROLE_DRBRIGHT or "Dr. Bright"

hook.Add("DoPlayerDeath", "DoPlayerDeathBright", function (ply)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_DRBRIGHT then
        local amulet = ents.Create("ent_amulet")
        if IsValid(amulet) then
            amulet:SetPos(ply:GetPos() + Vector(0, 0, 10))
            amulet.Owner = ply
            amulet:Spawn()

            ply:PrintMessage(HUD_PRINTTALK, "[Dr. Bright] You will be respawned if someone touches SCP-963.")
        end
    end
end)