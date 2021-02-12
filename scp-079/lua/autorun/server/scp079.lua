--Control what types of damage SCP-079 can take

hook.Add("EntityTakeDamage", "EntityTakeDamage_SCP079", function (target, dmginfo)
    if target and IsValid(target) and target:IsPlayer() and target:GetNClass() == ROLE_SCP079 and dmginfo:GetDamageType() ~= DMG_PHYSGUN then
        return true
    end

    local att = dmginfo:GetAttacker()
    local inf = dmginfo:GetInflictor()
    if att and IsValid(att) and att:IsPlayer() and att:GetNClass() == ROLE_SCP079 and inf and IsValid(inf) and inf:GetClass() == "tfa_csgo_thrownincen" then
        dmginfo:ScaleDamage(6)
    end

    if att and IsValid(att) and att:GetClass() == "npc_turret_ceiling" then
        local scp079
        for k,v in pairs(player.GetAll()) do
            if v:GetNClass() == ROLE_SCP079 then
                scp079 = v
                break
            end
        end
        if scp079 and IsValid(scp079) then
            dmginfo:SetAttacker(scp079)
        end
        dmginfo:ScaleDamage(2.5)
    end
end)

--Nothing should collide with SCP-079
hook.Add("ShouldCollide", "SC_SCP079", function (ent1, ent2)
    if (ent1 and IsValid(ent1) and ent1:IsPlayer() and ent1:GetNClass() == ROLE_SCP079) or (ent2 and IsValid(ent2) and ent2:IsPlayer() and ent2:GetNClass() == ROLE_SCP079) then
        return false
    end
end)

--Prevents the engine from crashing, collision rules suck and vphysics needs to be replaced.
hook.Add("Tick", "SCP079_Tick", function ()
    for _, v in pairs(player.GetAll()) do
        if not v.WasSCP079LastTick then
            v.WasSCP079LastTick = false
        end

        if v:GetNClass() == ROLE_SCP079 and not v.WasSCP079LastTick then
            print("CollisionRulesChanged (SCP-079)")
            v.WasSCP079LastTick = true
            v:CollisionRulesChanged()
        elseif v:GetNClass() ~= ROLE_SCP079 and v.WasSCP079LastTick then
            print("CollisionRulesChanged (SCP-079)")
            v.WasSCP079LastTick = false
            v:CollisionRulesChanged()
        end
    end
end)

--Enable the buggy hell known as CollisionCheck
hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn_SCP079CC", function (ply)
    ply:SetCustomCollisionCheck(true)
end)