hook.Remove("DoPlayerDeath", "DoPlayerDeath_AbelRespawn")
function Abel_DoPlayerDeath( ply,  attacker,  dmg )
  if not ply.GetNClass then
    player_manager.RunClass(ply, "SetupDataTables")
  end
  if not ABEL_LIVES then
    ABEL_LIVES = 0
  end
  if ply:GetNClass() == ROLE_CLASSD9341 then
    if ABEL_LIVES < 1 then
      print("autorun/server/abel_respawn.lua: D-9341 is out of save files")
      return
    end
    if postround or preparing then
      return
    end
	  function doabel()
		ply:SetClassD9341()
		for k,v in pairs(ents.FindByClass("ent_sp")) do
		ply:SetPos(v:GetPos())
		v:Remove()
		end
		end
    timer.Simple(5, doabel)
    local cstr = "saves"
    
    ply:PrintMessage(HUD_PRINTTALK, "You have "..ABEL_LIVES.." "..cstr.." remaining.")
    ABEL_LIVES = ABEL_LIVES - 1
  end
end
hook.Add("DoPlayerDeath", "DoPlayerDeath_AbelRespawn", Abel_DoPlayerDeath)
