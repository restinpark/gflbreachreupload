if SERVER then
  include('lootables/server.lua')
  AddCSLuaFile('lootables/client.lua')
else
  include('lootables/client.lua')
end
