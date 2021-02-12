
--Nothing should collide with SCP-990
hook.Add("ShouldCollide", "SC_SCP990", function (ent1, ent2)
    if (ent1 and IsValid(ent1) and ent1:IsPlayer() and ent1:GetNClass() == ROLE_SCP990) or (ent2 and IsValid(ent2) and ent2:IsPlayer() and ent2:GetNClass() == ROLE_SCP990) then
        return false
    end
end)

--Prevents the engine from crashing, collision rules suck and vphysics needs to be replaced.
hook.Add("Tick", "SCP990_Tick", function ()
    for _, v in pairs(player.GetAll()) do
        if not v.WasSCP990LastTick then
            v.WasSCP990LastTick = false
        end

        if v:GetNClass() == ROLE_SCP990 and not v.WasSCP990LastTick then
            print("CollisionRulesChanged (SCP-990)")
            v.WasSCP990LastTick = true
            v:CollisionRulesChanged()
        elseif v:GetNClass() ~= ROLE_SCP990 and v.WasSCP990LastTick then
            print("CollisionRulesChanged (SCP-990)")
            v.WasSCP990LastTick = false
            v:CollisionRulesChanged()
        end
    end
end)

--Enable the buggy hell known as CollisionCheck
hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn_SCP990CC", function (ply)
    ply:SetCustomCollisionCheck(true)
end)