AddCSLuaFile()

if SERVER then
    include("server.lua")
    AddCSLuaFile("client.lua")
    AddCSLuaFile("achievements.lua")
else
    include("client.lua")
end