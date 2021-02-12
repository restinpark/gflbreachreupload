ENT.Type = "anim"

ENT.PrintName = "SCP-458"

ENT.Spawnable = true
ENT.Author = "AverageDrink"
ENT.Instructions = "Press on the infinite PIZZA"
ENT.AdminOnly = true

--Need to add the shared file to the client's download list
AddCSLuaFile()
--Need to add the cl_init file to the client's download list
AddCSLuaFile("cl_init.lua")
