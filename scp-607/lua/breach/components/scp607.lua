--hook.Add("EntityTakeDamage", "SCP607_entityTakeDamage", function (target, dmginfo)
--    if target and IsValid(target) and target:IsPlayer() and target:GetNClass() == ROLE_SCP607 and target:HasWeapon("weapon_scp607") then
--        local wep = target:GetWeapon("weapon_scp607")
--        if wep and IsValid(wep) then
--            local dev = wep:GetNWEntity("Devotion")
--            if dev and IsValid(dev) and dev:IsPlayer() and dev:Team() ~= TEAM_SCP and dev:Team() ~= TEAM_SPECz then
--                dev:TakeDamage(dmginfo:GetDamage(), target, wep)
--            end
--        end
--    end
--end)

hook.Add("DoPlayerDeath", "DoPlayerDeath_SCP607", function (ply, att, dmg)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP607 and ply:HasWeapon("weapon_scp607") then
        local wep = ply:GetWeapon("weapon_scp607")
        if wep and IsValid(wep) then
            local dev = wep:GetNWEntity("Devotion")
            if dev and IsValid(dev) and dev:IsPlayer() and dev:Team() ~= TEAM_SCP and dev:Team() ~= TEAM_SPEC then
                dev:TakeDamage(9999, ply, wep)
                dev:PrintMessage(3, "You were killed by SCP-607's binding ability. (You let yourself be bound to SCP-607's life force and it died)")
                wep:SetNWEntity("Devotion", NULL)
                timer.Simple(3, function ()
                    if ply and IsValid(ply) then
                        ply:SetSCP607()
                    end
                end)
            end
        end
    elseif ply and IsValid(ply) and ply:IsPlayer() then
        for k,v in pairs(player.GetAll()) do
            if v:GetNClass() == ROLE_SCP607 then
                local wep = v:GetWeapon("weapon_scp607")
                if wep and IsValid(wep) and wep:GetNWEntity("Devotion", NULL) == ply then
                    wep:SetNWEntity("Devotion", NULL)
                    v:SetSCPHealth(400)
                    --v:PrintMessage(3, "The person who was bound to you died on their own accord.")
                end
            end
        end
    end
end)

timer.Create("EnforceDevotionValidity", 1, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:GetNClass() == ROLE_SCP607 then
            local wep = v:GetWeapon("weapon_scp607")
            if wep and IsValid(wep) then
                local dev = wep:GetNWEntity("Devotion", NULL)
                if not dev or not IsValid(dev) or not dev:IsPlayer() or dev:Team() == TEAM_SCP or dev:Team() == TEAM_SPEC then
                    wep:SetNWEntity("Devotion", NULL)
                   -- v:SetHealth(400)
                    --v:SetMaxHealth(400)
                    --v:PrintMessage(1, "Server forcefully reset SCP-607 state because the player you were bound to is no longer valid.")
                end
            end
        end
    end
end)