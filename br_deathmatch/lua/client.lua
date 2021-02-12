include("shared.lua")

--Unused
function SendFavoriteWeapons()
  local weapons = net.ReadTable()
  net.Start( "deathmatch_sendfavoriteweapon", false )
  net.WriteString("weapon_bdm_mac10")
  net.WriteString("weapon_bdm_usp")
  net.WriteString("weapon_crowbar")
  net.SendToServer()
end
net.Receive( "deathmatch_requestfavoriteweapon", SendFavoriteWeapons )

--Ghost players cannot be seen, unless you're a ghost player (or maybe spectator)

function DrawGhostPlayer(ply)
  if not ply.GetNClass then
    player_manager.RunClass( ply, "SetupDataTables" )
  end
  if not LocalPlayer().GetNClass then
    player_manager.RunClass( LocalPlayer(), "SetupDataTables" )
  end
  if IsValid(ply) and ply:IsPlayer() then
    --If they're a ghost, but we're not, hide
    if ply:GetNClass() == ROLE_GHOST and LocalPlayer():GetNClass() ~= ROLE_GHOST then
      return true
    --If we're a ghost, but they're not, hide
    elseif ply:GetNClass() ~= ROLE_GHOST and LocalPlayer():GetNClass() == ROLE_GHOST then
      return true
    end
  end
end
hook.Add("PrePlayerDraw", "PRE_PLAYER_DRAW_DEATHMATCH", DrawGhostPlayer)

function PlayGunshot_DM()
  local sound = net.ReadString()
  local ent = net.ReadEntity()
  if not IsValid(ent) then return end
  local origin = ent:GetPos()
  EmitSound( sound, origin, ent:EntIndex(), CHAN_WEAPON, 1, 50, SND_NOFLAGS, 100 )
end
net.Receive( "deathmatch_gunshot_sound", PlayGunshot_DM )

function JoinDM()
  net.Start("deathmatch_command")
  net.SendToServer()
end
concommand.Add( "br_deathmatch", JoinDM, nil, nil, FCVAR_CLIENTCMD_CAN_EXECUTE )


hook.Add( "OnPlayerChat", "CheckChatFunctionsDM", function( ply, strText, bTeam, bDead )
	strText = string.lower( strText )

	if ( strText == "!dm" )  then
		if ply == LocalPlayer() then
		    JoinDM()
		end
		return true
	end
  if ( strText == "!deathmatch" )  then
		if ply == LocalPlayer() then
		    JoinDM()
		end
		return true
	end
end)
