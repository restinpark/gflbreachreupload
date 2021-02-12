function SHOULD_DRAW_020(ent)
  -- Don't return false here in case anyone else wants to use this hook
  if not ent.GetClass then else
    if ent:GetClass() == "ent_mold" then
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
hook.Add("PrePlayerDraw", "SCP_CB_DRAWPLAYER_020", SHOULD_DRAW_020)
