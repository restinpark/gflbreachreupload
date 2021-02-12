hook.Add( "PlayerSpray", "DisablePlayerSpray", function( ply )
	return true //Use spraymesh
	--
	--if ply:GetPData("banned_from_spray", "false") == "true" then
	--	ply:PrintMessage(3, "You are banned from spraying.")
	--	return true
	--end
	--local i = ply:EyeAngles()
	--if (i.pitch <= 90 and i.pitch > 20) or (i.pitch >= 90 and i.pitch < 160) then
	--	return true
	--else
	--	return !((ply:IsAdmin() or ply:IsUserGroup("senioradmin") or ply:IsUserGroup("trialadmin") or ply:IsUserGroup("operator") or ply:IsUserGroup("developer") or ply:IsUserGroup("vip") or ply:IsUserGroup("supporter") or ply:IsUserGroup("member")) and ply:Team() != TEAM_SPEC)
	--end
end )


hook.Add( "PlayerSprayMesh", "DisablePlayerSpray2", function( ply )
	if ply:GetPData("banned_from_spray", "false") == "true" then
		ply:PrintMessage(3, "You are banned from spraying.")
		return true
	end
	--I don't remember why there is a second check for this. Probably from the first time I added spraymesh. I just forgot to remove it. That being said, I don't want to break anything before I yeet outta here so imma leave it
	if ply:GetPData("spraymesh_isbanned", "false") == "true" then
		return true
	end
	local i = ply:EyeAngles()
	if (i.pitch <= 90 and i.pitch > 20) or (i.pitch >= 90 and i.pitch < 160) then
		return true
	else
		return !((ply:IsAdmin() or ply:IsUserGroup("senioradmin") or ply:IsUserGroup("trialadmin") or ply:IsUserGroup("operator") or ply:IsUserGroup("developer") or ply:IsUserGroup("vip") or ply:IsUserGroup("supporter") or ply:IsUserGroup("member")) and ply:Team() != TEAM_SPEC)
	end
end )
