timer.Create("SCP011_EnsureCorrectMaterials", 5, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:GetNClass() == ROLE_SCP011 then
            v:SetMaterial("scp011/coppertext")
        else
            v:SetMaterial("")
        end
    end
end)
