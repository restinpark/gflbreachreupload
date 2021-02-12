hook.Remove("DoPlayerDeath", "DoPlayerDeath_AbelRespawn")
function Abel_DoPlayerDeath( ply,  attacker,  dmg )
  if not ply.GetNClass then
    player_manager.RunClass(ply, "SetupDataTables")
  end
  if not ABEL_LIVES then
    ABEL_LIVES = 0
  end
  if ply:GetNClass() == ROLE_SCP0762 then
    if ABEL_LIVES < 1 then
      print("autorun/server/abel_respawn.lua: Abel has no more lives")
      return
    end
    if postround or preparing then
      return
    end
	  function doabel()
		  ply:SetSCP0762()
	  end
    timer.Simple(5, doabel)
    local cstr = "lives"
    
    ply:PrintMessage(HUD_PRINTTALK, "You have "..ABEL_LIVES.." "..cstr.." remaining.")
    ABEL_LIVES = ABEL_LIVES - 1
  end
end
hook.Add("DoPlayerDeath", "DoPlayerDeath_AbelRespawn", Abel_DoPlayerDeath)
hook.Remove("EntityTakeDamage", "SCP_TEAM_DAMAGE")
function Abel_PreventRDM(ply, dmg)
	local at = dmg:GetAttacker()
	if IsValid(at) and IsValid(ply) and ply:IsPlayer() and at:IsPlayer() then
		if at:Team() == TEAM_SCP and ply:Team() == TEAM_SCP then
			dmg:ScaleDamage(0)
		end
	end
end
hook.Add("EntityTakeDamage", "SCP_TEAM_DAMAGE", Abel_PreventRDM)