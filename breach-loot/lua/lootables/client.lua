local NAMES = {
    ["models/mishka/models/scp178.mdl"] = "SCP-178",
    ["models/mishka/models/scp513.mdl"] = "SCP-513",
    ["models/mishka/models/scp420.mdl"] = "SCP-420",
    ["models/mishka/models/rubber_duck.mdl"] = "Strange Duck",
    ["models/mishka/models/scp714.mdl"] = "SCP-714",
    ["models/mishka/models/gasmask.mdl"] = "SCP-1499",
    ["models/mishka/models/scp1123.mdl"] = "SCP-1123",
    ["models/mishka/models/metalpanel148.mdl"] = "SCP-148"
}

print("lootables clientside component loads, count OBJECTS = " .. tostring(table.Count(NAMES)))

hook.Add("HUDDrawTargetID", "DrawSCPObjects", function ()
    local trace = LocalPlayer():GetEyeTrace()
    local x = ScrW() / 2
    local y = ScrH() / 2 + 30
    if trace.Hit and trace.HitNonWorld then
        local t_ent = trace.Entity
        if t_ent and IsValid(t_ent) and t_ent:GetClass() == "ent_lootable" and LocalPlayer():GetPos():Distance(t_ent:GetPos()) <= 1000 then
            --print(t_ent:GetModel())
            draw.Text( {
                --The game can't seem to fucking decide
                text = NAMES[t_ent:GetModel()] or (NAMES["models/mishka/" .. t_ent:GetModel()] or "ENOINDEX"),
                pos = { x, y },
                font = "TargetID",
                color = Color(255,255,255),
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER,
            })
            if LocalPlayer():Team() == TEAM_CHAOS or LocalPlayer():Team() == TEAM_SCI or LocalPlayer():GetNClass() == ROLE_SERPENT then
                draw.Text( {
                    text = "Press +use to pickup",
                    pos = { x, y + 16 },
                    font = "TargetID",
                    color = Color(255,0,255),
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER,
                })
            end
            return true
        end
    end
end)