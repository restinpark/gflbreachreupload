hook.Add("BreachStartRound", "BreachClearLootables_SR", function ()
    for k,v in pairs(player.GetAll()) do
        v.lootableindex = {}
    end
end)

hook.Add("BreachEndRound", "BreachClearLootables_ER", function ()
    for k,v in pairs(player.GetAll()) do
        v.lootableindex = {}
    end
end)

local function BPE(ply, team)
    if ply and IsValid(ply) and ply.lootableindex and table.Count(ply.lootableindex) > 0 then
        ply:PrintMessage(HUD_PRINTTALK, "You escaped with " .. tostring(table.Count(ply.lootableindex)) .. " SCP Objects.")
        hook.Run("BreachSCPCollected", ply, table.Count(ply.lootableindex or {}))
        ply.lootableindex = {}
    end
end

hook.Add("BreachPlayerEscaped", "BreachPlayerEscaped_Lootables", BPE)
hook.Add("BreachPlayerEscaped_NDP", "BreachPlayerEscaped_NDP_Lootables", BPE)

hook.Add("BreachPlayerEscorted", "BreachPlayerEscorted_Lootables", function (pl, escorted)
    for _,ply in pairs(escorted) do
        if ply and IsValid(ply) and ply.lootableindex and table.Count(ply.lootableindex) > 0 then
            ply:PrintMessage(HUD_PRINTTALK, "You escaped with " .. tostring(table.Count(ply.lootableindex)) .. " SCP Objects.")
            hook.Run("BreachSCPCollected", ply, table.Count(ply.lootableindex or {}))
            ply.lootableindex = {}
        end
    end
end)

hook.Add("DoPlayerDeath", "DoPlayerDeath_DropSCPsOnDeath", function (ply)
    if ply and IsValid(ply) and ply.lootableindex and istable(ply.lootableindex) then
        for k,_ in pairs(ply.lootableindex) do
            local ent = ents.Create("ent_lootable")
            ent:SetPos(ply:GetPos())
            ent:SetModel(k)
            ent:FinishInit()
            ent:Spawn()
        end
        ply.lootableindex = {}
    end
end)

timer.Create("EnforceSCPObjectCarryRestrictions", 5, 0, function ()
    for _,v in pairs(player.GetAll()) do
        if v.lootableindex and istable(v.lootableindex) and table.Count(v.lootableindex) > 0 and (v:Team() != TEAM_CHAOS and v:Team() != TEAM_SCI and v:GetNClass() != ROLE_SERPENT) then
            for model,_ in pairs(v.lootableindex) do
                print("force drop " .. model)
                local ent = ents.Create("ent_lootable")
                ent:SetPos(v:GetPos())
                ent:SetModel(model)
                ent:FinishInit()
                ent:Spawn()
            end
            v.lootableindex = {}
        end
    end
end)

if file.Exists("lootables/maps/" .. game.GetMap() .. ".lua", "LSV") then
    include("lootables/maps/" .. game.GetMap() .. ".lua")
end

hook.Add("PostCleanupMap", "BreachExtensions.Lootables.Spawner", function ()
        if SPAWN_178_L then --There exists SPAWN_178 already
            local scp178 = ents.Create("ent_lootable")
            if IsValid(scp178) then
                scp178:SetPos(SPAWN_178_L)
                scp178:SetModel("models/mishka/models/scp178.mdl")
                scp178:FinishInit()
                scp178:Spawn()
            end
        end

        if SPAWN_513_L then --There exists SPAWN_513
            local scp513 = ents.Create("ent_lootable")
            if IsValid(scp513) then
                scp513:SetPos(SPAWN_513_L)
                scp513:SetModel("models/mishka/models/scp513.mdl")
                scp513:FinishInit()
                scp513:Spawn()
            end
        end

        if SPAWN_420J then
            local scp420j = ents.Create("ent_lootable")
            if IsValid(scp420j) then
                scp420j:SetPos(SPAWN_420J)
                scp420j:SetModel("models/mishka/models/scp420.mdl")
                scp420j:FinishInit()
                scp420j:Spawn()
            end
        end

        if SPAWN_DUCK then
            local duck = ents.Create("ent_lootable")
            if IsValid(duck) then
                duck:SetPos(SPAWN_DUCK)
                duck:SetModel("models/mishka/models/rubber_duck.mdl")
                duck:FinishInit()
                duck:Spawn()
            end
        end

        if SPAWN_714 then
            local scp714 = ents.Create("ent_lootable")
            if IsValid(scp714) then
                scp714:SetPos(SPAWN_714)
                scp714:SetModel("models/mishka/models/scp714.mdl")
                scp714:FinishInit()
                scp714:Spawn()
            end
        end

        if SPAWN_1499 then
            local scp1499 = ents.Create("ent_lootable")
            if IsValid(scp1499) then
                scp1499:SetPos(SPAWN_1499)
                scp1499:SetModel("models/mishka/models/gasmask.mdl")
                scp1499:FinishInit()
                scp1499:Spawn()
            end
        end

        if SPAWN_1123 then
            local scp1123 = ents.Create("ent_lootable")
            if IsValid(scp1123) then
                scp1123:SetPos(SPAWN_1123)
                scp1123:SetModel("models/mishka/models/scp1123.mdl")
                scp1123:FinishInit()
                scp1123:Spawn()
            end
        end

        if SPAWN_148 then
            local scp148 = ents.Create("ent_lootable")
            if IsValid(scp148) then
                scp148:SetPos(SPAWN_148)
                scp148:SetModel("models/mishka/models/metalpanel148.mdl")
                scp148:FinishInit()
                scp148:Spawn()
            end
        end
end)