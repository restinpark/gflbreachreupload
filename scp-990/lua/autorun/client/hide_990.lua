function SHOULD_DRAW_990(ply)
  if not ply.GetNClass then else
    if ply:GetNClass() == ROLE_SCP990 then
      if LocalPlayer():Team() == TEAM_SPEC or LocalPlayer():GetNClass() == ROLE_SCP990 then else
        if LocalPlayer():HasWeapon("weapon_dream") then
          local dream
          dream = LocalPlayer():GetWeapon("weapon_dream")
          if dream.IsOn then else return true end
        else
          return true
        end
      end
    end
  end
end
hook.Add("PrePlayerDraw", "SCP_CB_DRAWPLAYER_990", SHOULD_DRAW_990)
