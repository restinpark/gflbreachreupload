local C = {
    ["name"] = "Malo",
    ["purpose"] = "Event Manager and Behavior for SCP-1471",
    ["realm"] = 1 --Exist only on server, a value of 2 makes it clientside only and 3 makes it shared.
}

if C["realm"] == 1 or C["realm"] == 3 or CLIENT then
    hook.Add("EntityTakeDamage", "EntityTakeDamageMalo", function (target, dmg)
        local attacker = dmg:GetAttacker()
        if attacker and IsValid(attacker) and attacker:IsPlayer() and attacker.GetNClass and attacker:GetNClass() == ROLE_SCP1471 and not target:GetNWBool("MaloInfected", false) then
            return true
        elseif attacker and IsValid(attacker) and attacker:IsPlayer() and not attacker:GetNWBool("MaloInfected", false) and target.GetNClass and target:GetNClass() == ROLE_SCP1471 then
            return true
        end
    end)
    
    hook.Add("BreachStartRound", "BreachStartRound_Malo", function ()
        print("malo: Running round start functions.")
        --Clear infected status
        Malo_FORCEINFECTMODE = false
        for k,v in pairs(player.GetAll()) do
            v:SetNWBool("MaloInfected", false)
        end
        if timer.Exists("MaloTimer") then 
            timer.Remove("MaloTimer")
        end
        timer.Remove("MaloInitPickInfected")
        timer.Remove("MaloTick")
        timer.Remove("MaloInfectRadios")
        timer.Remove("MaloInfectMoreRadios")
        timer.Remove("MaloInfectSNAVs")
        timer.Remove("MaloFinishNVGRadio")
        timer.Remove("MaloFinishElectronics")
        timer.Remove("MaloInfectNVGs")
        timer.Remove("MaloWOKE")
        timer.Create("MaloInitPickInfected", 5, 1, function ()
            local all = player.GetAll()
            --We're going to prefer guards here
            local target
            for k,v in pairs(all) do
                if v:Team() == TEAM_GUARD then
                    target = v
                    break
                end
            end
            if not target then
                for k,v in pairs(all) do
                    if v:Team() == TEAM_SPEC or v:Team() == TEAM_SCP or v:GetNClass() == ROLE_SCP990 then
                        table.remove(all, k)
                        all[k] = nil
                    end
                end
                target = table.Random(all)
            end
            if target and IsValid(target) and target:IsPlayer() then
                target:SetNWBool("MaloInfected", true)
            end
        end)
        --This should run forever, basically infect anybody who should be infected and disinfect anybody who needn't be.
        timer.Create("MaloTick", 1, 0, function ()
            for k,v in pairs(player.GetAll()) do
                if v:Team() == TEAM_SPEC or v:Team() == TEAM_SCP or v:GetNClass() == ROLE_SCP990 and v:GetNWBool("MaloInfected", true) then
                    v:SetNWBool("MaloInfected", false)
                elseif Malo_FORCEINFECTMODE and not v:GetNWBool("MaloInfected", false) and v:Team() != TEAM_SCP or v:GetNClass() != ROLE_SCP990 then
                    v:SetNWBool("MaloInfected", true)
                end
            end
        end)
        --First, we want 3 radio users
        timer.Create("MaloInfectRadios", 60, 1, function ()
            local radios = {}
            for k,v in pairs(player.GetAll()) do
                if v:HasWeapon("item_radio") and v:Team() != TEAM_SCP then
                    radios[#radios + 1] = v
                end
            end
            local picks = {}
            if #radios > 0 then
                for i=1, math.Clamp(#radios, 1, 3) do
                    picks[#picks + 1] = table.Random(radios)
                end
            end
            if #picks > 0 then
                for k,v in pairs(picks) do
                    if v and IsValid(v) and v:IsPlayer() and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP then
                        v:SetNWBool("MaloInfected", true)
                    end
                end
            end
        end)
        --Pick 3 more radio users
        timer.Create("MaloInfectMoreRadios", 120, 1, function ()
            local radios = {}
            for k,v in pairs(player.GetAll()) do
                if v:HasWeapon("item_radio") and not v:GetNWBool("MaloInfected", false) and v:Team() != TEAM_SCP then
                    radios[#radios + 1] = v
                end
            end
            local picks = {}
            if #radios > 0 then
                for i=1, math.Clamp(#radios, 1, 3) do
                    picks[#picks + 1] = table.Random(radios)
                end
            end
            if #picks > 0 then
                for k,v in pairs(picks) do
                    if v and IsValid(v) and v:IsPlayer() and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP then
                        v:SetNWBool("MaloInfected", true)
                    end
                end
            end
        end)
        --Now lets look at SNAV users, but only 300 and 301, as ultimates have a newer AV :3
        timer.Create("MaloInfectSNAVs", 180, 1, function ()
            --Variable kept the same for reusability
            local radios = {}
            for k,v in pairs(player.GetAll()) do
                if (v:HasWeapon("item_snav_300") or v:HasWeapon("item_snav_301")) and not v:GetNWBool("MaloInfected", false) and v:Team() != TEAM_SCP then
                    radios[#radios + 1] = v
                end
            end
            local picks = {}
            if #radios > 0 then
                for i=1, math.Clamp(#radios, 1, 3) do
                    picks[#picks + 1] = table.Random(radios)
                end
            end
            if #picks > 0 then
                for k,v in pairs(picks) do
                    if v and IsValid(v) and v:IsPlayer() and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP then
                        v:SetNWBool("MaloInfected", true)
                    end
                end
            end
        end)
        --OK, NVG users, but also get some radio users too, because sometimes NVGs don't spawn (due to lack of a 966)
        timer.Create("MaloInfectNVGs", 240, 1, function ()
            --Variable kept the same for reusability
            local radios = {}
            for k,v in pairs(player.GetAll()) do
                if (v:HasWeapon("item_radio") or v:HasWeapon("weapon_nvg")) and not v:GetNWBool("MaloInfected", false) and v:Team() != TEAM_SCP then
                    radios[#radios + 1] = v
                end
            end
            local picks = {}
            if #radios > 0 then
                for i=1, math.Clamp(#radios, 1, 3) do
                    picks[#picks + 1] = table.Random(radios)
                end
            end
            if #picks > 0 then
                for k,v in pairs(picks) do
                    if v and IsValid(v) and v:IsPlayer() and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP then
                        v:SetNWBool("MaloInfected", true)
                    end
                end
            end
        end)
        --Get the rest of the NVG/Radio users, going to start agressively infecting now
        timer.Create("MaloFinishNVGRadio", 300, 1, function ()
            for k,v in pairs(player.GetAll()) do
                if (v:HasWeapon("item_radio") or v:HasWeapon("weapon_nvg")) and v:Team() != TEAM_SCP and not v:GetNWBool("MaloInfected", false) then
                    v:SetNWBool("MaloInfected", true)
                end
            end
        end)
        --Catch all other electronic devices, the extra delay is so NTF get caught too
        timer.Create("MaloFinishElectronics", 361, 1, function ()
            for k,v in pairs(player.GetAll()) do
                if (v:HasWeapon("item_radio") or v:HasWeapon("weapon_nvg") or v:HasWeapon("item_snav_300") or v:HasWeapon("item_snav_301") or v:HasWeapon("item_snav_ultimate")) and v:Team() != TEAM_SCP and not v:GetNWBool("MaloInfected", false) then
                    v:SetNWBool("MaloInfected", true)
                end
            end
        end)
        timer.Create("MaloWOKE", 420, 1, function ()
            --Everyone is infected
            Malo_FORCEINFECTMODE = true
        end)
    end)
end

--This only matters if breach loads componenets, which unless its running the rewritten version, it won't
return C