ROLE_SCP035 = ROLE_SCP035 or "SCP-035"

hook.Add("DoPlayerDeath", "DoPlayerDeathMask", function (ply)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP035 then
        local mask = ents.Create("ent_scp_035")
        if IsValid(mask) then
            mask:SetPos(ply:GetPos() + Vector(0, 0, 10))
            mask:Spawn()
        end
    end
end)