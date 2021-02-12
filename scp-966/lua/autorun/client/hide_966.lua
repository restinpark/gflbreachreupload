function SHOULD_DRAW_966(ply)
  -- Don't return false here in case anyone else wants to use this hook
  --print(ROLE_SCP966)
  if not ply.GetNClass then else
    if ply:GetNClass() == ROLE_SCP966 then
      if LocalPlayer():Team() == TEAM_SCP or LocalPlayer():Team() == TEAM_SPEC then else
        if LocalPlayer():HasWeapon("weapon_nvg") then
          local nvg
          nvg = LocalPlayer():GetWeapon("weapon_nvg")
          if nvg.IsOn then else return true end
        else
          return true
        end
      end
    end
  end
end
hook.Add("PrePlayerDraw", "SCP_CB_DRAWPLAYER_966", SHOULD_DRAW_966)
