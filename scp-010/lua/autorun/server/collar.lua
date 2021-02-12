ROLE_SCP010 = ROLE_SCP010 or "SCP-010-A"

hook.Add("DoPlayerDeath", "DoPlayerDeathCollar", function (ply)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP010 then
        local collar = ents.Create("weapon_scp_010")
        if IsValid(collar) then
            collar:SetPos(ply:GetPos() + Vector(0, 0, 10))
            collar:Spawn()
        end
    end
end)