AddCSLuaFile()

if CLIENT then
    print("CLIENT: Loaded breach.components.malo")
    hook.Add("PrePlayerDraw", "PrePlayerDraw_SCP1471", function (ply)
        if (LocalPlayer():Team() == TEAM_SCP or LocalPlayer():Team() == TEAM_SPEC or LocalPlayer():GetNClass() == ROLE_SCP990) and ply:GetNClass() == ROLE_SCP1471 then
        elseif (LocalPlayer():GetNClass() == ROLE_SCP1471) and ply:Team() == TEAM_SCP then
        elseif ply:GetNClass() == ROLE_SCP1471 and not LocalPlayer():GetNWBool("MaloInfected", false) then
            return true
        elseif LocalPlayer():GetNClass() == ROLE_SCP1471 and not ply:GetNWBool("MaloInfected", false) then
            return true
        end
    end)
end

--Might as well download required content
if SERVER then
    resource.AddWorkshop("1085224127")
end