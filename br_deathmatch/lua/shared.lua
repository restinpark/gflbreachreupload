AddCSLuaFile()
ROLE_GHOST = "Ghost DM"
local meta = FindMetaTable( "Player" )

function meta:IsGhost()
  if not self.GetNClass then
    player_manager.RunClass( self, "SetupDataTables" )
  end
  return self:GetNClass() == ROLE_GHOST
end
--Copied from Tommy's DM for TTT
hook.Add("ShouldCollide", "ShouldCollide_DEATHMATCH", function(ent1, ent2)
	if not IsValid(ent1) or not IsValid(ent2) then return end
	if ent1:IsPlayer() and (ent1.IsGhost and ent1:IsGhost()) and not (ent2:IsPlayer() and (ent2.IsGhost and ent2:IsGhost())) then
		return false
	end
	if ent2:IsPlayer() and (ent2.IsGhost and ent2:IsGhost()) and not (ent1:IsPlayer() and (ent1.IsGhost and ent1:IsGhost())) then
		return false
	end
end)
--End copied code
hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn_DEATHMATCH", function(ply)
  ply:SetCustomCollisionCheck(true)
end)
