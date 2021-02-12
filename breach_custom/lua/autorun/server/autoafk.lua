util.AddNetworkString("BreachAFKSpec")
util.AddNetworkString("BreachReturnFromAFK")

net.Receive("BreachAFKSpec", function( len, ply )
  if not ply:IsAFK() then
		if ply:Alive() and ply:Team() != TEAM_SPEC then
      ply:Kill()
			ply:SetSpectator()
      ULib.tsay( nil, ply:Nick().." has been automatically moved to spectators because they were AFK." )
		end
		ply:SetAFK(true)
		ply:PrintMessage(HUD_PRINTTALK, "You have been automatically moved to spectators for being AFK.")
  end
	CheckStart()
end )
net.Receive("BreachReturnFromAFK", function( len, ply )
	if ply:IsAFK() then
		ply:SetAFK(false)
		ply:PrintMessage(HUD_PRINTTALK, "Changed mode to player")
	end
	CheckStart()
end )
