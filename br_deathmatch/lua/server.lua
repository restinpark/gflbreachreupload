AddCSLuaFile("client.lua")
include("shared.lua")
include("srv_tables.lua")
include("srv_player.lua")

util.AddNetworkString( "deathmatch_gunshot_sound" )
util.AddNetworkString( "deathmatch_command" )
util.AddNetworkString("deathmatch_requestfavoriteweapon")
util.AddNetworkString("deathmatch_sendfavoriteweapon")

function DM_GetModelForPlayer(ply)
  if IsValid(ply) and ply:IsPlayer() and ply.DM_Model and util.IsValidModel( ply.DM_Model ) then
    return ply.DM_Model
  end
  return table.Random(DEATHMATCH_MODELS)
end

--Unused
function UpdateFavorites(len, ply)
end
net.Receive( "deathmatch_sendfavoriteweapon", SendFavoriteWeapons )

function GetGhosts()
  local ghosts = {}
  for k,v in pairs(player.GetAll()) do
    if v:IsGhost() then
      ghosts = table.ForceInsert(ghosts, v)
    end
  end
  return ghosts
end

function HandleGhostDamage(tgt, dmg)
  if IsValid(tgt) and IsValid(dmg:GetAttacker()) then
    if not tgt:IsPlayer() and dmg:GetAttacker():IsPlayer() and dmg:GetAttacker():GetNClass() == ROLE_GHOST then
      return true
    end
    if tgt:IsPlayer() and dmg:GetAttacker():IsPlayer() then
      if not tgt.GetNClass then
        player_manager.RunClass( tgt, "SetupDataTables" )
      end
      if not dmg:GetAttacker().GetNClass then
        player_manager.RunClass( dmg:GetAttacker(), "SetupDataTables" )
      end
      --If tgt is ghost, but attacker is not
      if tgt:GetNClass() == ROLE_GHOST and dmg:GetAttacker():GetNClass() ~= ROLE_GHOST then
        return true
      --If tgt is not a ghost, but the attacker is
      elseif tgt:GetNClass() ~= ROLE_GHOST and dmg:GetAttacker():GetNClass() == ROLE_GHOST then
        return true
      --Let the hook be called normally, we're done here
      else end
    end
  end
end
hook.Add("EntityTakeDamage", "EntityTakeDamage_DEATHMATCH", HandleGhostDamage)

function JoinDM(len, ply)
  if not BR_GHOST_SPAWNS[game.GetMap()] then
	ply:PrintMessage(3, "This map is not currently setup for deathmatch")
	return
  end
  if not ply.LastDMCommand then
    ply.LastDMCommand = CurTime()
  elseif ply.LastDMCommand + 3 > CurTime() then
    ply:PrintMessage(3, "You cannot spam this command that fast!")
    return
  end
  ply.LastDMCommand = CurTime()
  if IsValid(ply) and ply:Team() == TEAM_SPEC and not ply:IsGhost() and not postround then
    ply:SetGhost()
    for k,v in pairs(player.GetAll()) do
      if v:Team() == TEAM_SPEC then
        v:PrintMessage(HUD_PRINTTALK, ply:Nick().. " has joined the deathmatch!")
      end
    end
  elseif IsValid(ply) and ply:Team() == TEAM_SPEC and ply:IsGhost() then
    ply:SetSpectator()
  end
end
net.Receive("deathmatch_command", JoinDM)

function GhostShouldDie(victim, inflictor, attacker)
  if victim:GetNClass() == ROLE_GHOST then
    victim:PrintMessage(HUD_PRINTTALK, "You will respawn in 5 seconds.")
    --game.RemoveRagdolls()
    local function dthink()
      if victim:Team() == TEAM_SPEC and not postround then
        victim:SetGhost()
      end
    end
    timer.Simple( 5, dthink )
    --Return so breach doesn't run its normal death logic
    if attacker:IsPlayer() and attacker:Health() <= 70 then
      attacker:SetHealth(attacker:Health() + 30)
    elseif attacker:Health() > 70 then
      attacker:SetHealth(attacker:GetMaxHealth())
    end
    return true
  end
end
hook.Add("PlayerDeath", "GHOST_RESPAWN_DEAD_GHOST", GhostShouldDie)

function RoundEnds_GHOST()
  for k,v in pairs(player.GetAll()) do
    if v:IsGhost() then
      v:SetSpectator()
    end
  end
end
hook.Add("BreachEndRound", "GHOST_ON_ROUND_END", RoundEnds_GHOST)


hook.Add("PlayerFootstep", "PlayerFootstep_Ghost", function(ply, pos, foot, sound, volume, rf)
	if ply:IsGhost() then
		return true
	end
end)
