AddCSLuaFile()

if SERVER then
  util.AddNetworkString("Modify096Shitlist")
  hook.Add("PlayerDeath", "RemovePlayerFrom096Shitlist", function (vic)
    for k,v in pairs(player.GetAll()) do
      if v:HasWeapon("weapon_scp096") then
        v:GetWeapon("weapon_scp096").ShitList[vic:SteamID()] = nil
        net.Start("Modify096Shitlist")
        net.WriteInt(2, 8)
        net.WriteString(vic:SteamID())
        net.Send(v)
      end
    end
  end)
else
  SCP_096_CLIENT_SHITLIST = {}
  net.Receive("Modify096Shitlist", function ()
    local op = net.ReadInt(8)
    local arg = net.ReadString()
    if not LocalPlayer():HasWeapon("weapon_scp096") then return end
    --Add
    if op == 1 then
      local ply = player.GetBySteamID(arg)
      SCP_096_CLIENT_SHITLIST[arg] = ply

    elseif op == 2 then
      SCP_096_CLIENT_SHITLIST[arg] = nil
    elseif op == 3 then
      SCP_096_CLIENT_SHITLIST = {}
    end
  end)
end
