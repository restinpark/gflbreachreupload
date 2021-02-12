ITEM.Name = "Blue Guy"
ITEM.Price = 25000
ITEM.Model = "models/player/blueguy/vr_blueguyv2.mdl"
ITEM.AllowedUserGroups = {"supporter", "vip", "operator", "developer", "admin", "trialadmin", "senioradmin", "superadmin"}
ITEM.Except = true
ITEM.SubCategory = "Donator Models"

function ITEM:PlayerSpawn(ply)
    timer.Simple(0.33, function ()
        if ply and IsValid(ply) and ply:GetNClass() == ROLE_RES then
            ply:SetModel(self.Model)
        end
    end)
end

function ITEM:OnEquip(ply)
    self:PlayerSpawn(ply)
end

function ITEM:OnHolster(ply)
    timer.Simple(0.33, function ()
        if ply and IsValid(ply) and ply:GetNClass() == ROLE_RES then
            ply:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
        end
    end)
end