hook.Add("OnPlayerChat", "OnPlayerChat_BlockedPlayers", function (ply)
  if IsValid(ply) and ply:IsMuted() and not (ply:IsAdmin() or ply:IsUserGroup("operator") or ply:IsUserGroup("senioradmin")) then
    print(ply:Nick() .. " is muted locally, so his message was supressed.")
    return true
  elseif IsValid(ply) and ply:IsMuted() then
    print(ply:Nick() .. " is staff, so his message was not surpressed, despite being muted.")
  end
end)

