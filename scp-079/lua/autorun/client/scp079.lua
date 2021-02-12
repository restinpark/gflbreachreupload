--Hide SCP-079
hook.Add("PrePlayerDraw", "PrePlayerDraw_SCP079", function (ply)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP079 then
        return true
    end
end)