local mply = FindMetaTable( "Player" )

function mply:GetFavoriteWeapons()
  local tab = {
    ["pri"] = self:GetPData("bdm_primary_favorite", "weapon_bdm_mac10"),
    ["sec"] = self:GetPData("bdm_secondary_favorite", "weapon_bdm_usp"),
    ["mel"] = self:GetPData("bdm_melee_favorite", "weapon_crowbar")
  }

  return tab
end
function mply:GiveDMSWEPS()
  self:Give(table.Random(DEATHMATCH_WEAPONS_PRIMARY))
  self:Give(table.Random(DEATHMATCH_WEAPONS_SECONDARY))
end
function deathmatch_on_player_authed(ply, steamid, uniqueid)
  local localweaponstable = {
    ["pri"] = DEATHMATCH_WEAPONS_PRIMARY,
    ["sec"] = DEATHMATCH_WEAPONS_SECONDARY,
    ["mel"] = DEATHMATCH_WEAPONS_MELEE
  }
  print("Requesting weapons data for "..ply:Nick().."("..steamid..")")
  net.Start("deathmatch_requestfavoriteweapon")
  net.WriteTable(localweaponstable)
  net.Send(ply)
end
hook.Add("PlayerAuthed", "deathmatch_on_player_connect", deathmatch_on_player_authed)

function mply:SetGhost()
  self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SPEC)
	self:SetModel(DM_GetModelForPlayer(self))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(300)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(300)
  self:SetShouldServerRagdoll( false )
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_GHOST)
  self:SetBloodColor(DONT_BLEED)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( false )
	self:SetNoTarget( true )
	self.BaseStats = nil
	self.UsingArmor = nil
  self:GiveDMSWEPS()
  self:SetPos(table.Random(BR_GHOST_SPAWNS[game.GetMap()]))
end
