ITEM.Name = "Advanced Hazmat"
ITEM.Price = 25000
ITEM.Model = "models/hlvr/characters/worker/worker_player.mdl"
ITEM.AllowedUserGroups = {"supporter", "vip", "operator", "developer", "admin", "trialadmin", "senioradmin", "superadmin"}
ITEM.Except = true
ITEM.SubCategory = "Donator Models"

function ITEM:PlayerSpawn(ply)
    timer.Simple(0.33, function ()
        if ply and IsValid(ply) and ply:GetNClass() == ROLE_CLASSD then
            ply:SetModel(self.Model)
			ply:SetBodygroup(0,1)
        end
    end)
end

function ITEM:OnEquip(ply)
    self:PlayerSpawn(ply)
end

function ITEM:OnHolster(ply)
    timer.Simple(0.33, function ()
        if ply and IsValid(ply) and ply:GetNClass() == ROLE_CLASSD then
ply:SetModel("models/player/kerry/class_d_"..math.random(1,7)..".mdl")
ply:SetBodygroup(0,0)
        end
    end)
end
