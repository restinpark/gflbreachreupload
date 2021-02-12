local hdr_convar = GetConVar("mat_hdr_level")

timer.Simple(10, function ()

  local hdr_enabled = false

  if hdr_convar and hdr_convar:GetInt() == 2 then
    hdr_enabled = true
  end

  if CLIENT and cookie.GetNumber("AskedAboutHDR", -1) == -1 or (not hdr_enabled and GetGlobalBool("BREACH_RECHDR", false)) then
    Derma_Query( "Some maps look better with HDR enabled, would you like to enable HDR?", "Enable HDR?", "Yes", function ()
      cookie.Set("AskedAboutHDR", "1")
      RunConsoleCommand("mat_hdr_level", "2")
      RunConsoleCommand("retry")
    end, "No", function ()
      cookie.Set("AskedAboutHDR", "1")
    end, "Maybe Later", nil)
  end
end)