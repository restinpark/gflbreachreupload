hook.Add("PlayerDeath", "playerdeath82", function (ply, inf, at)
    if IsValid(at) and at:IsPlayer() and at.GetNClass and at:GetNClass() == ROLE_SCP082 then
        at:SetHealth(math.Clamp(at:Health() + 150, 1, at:GetMaxHealth()))
    end
end)