ITEM.Name = "SCP-527"
ITEM.Price = 100000
ITEM.Model = "models/scp_527/scp_527.mdl"
ITEM.AllowedUserGroups = { "member", "supporter", "vip", "operator", "developer", "admin", "trialadmin", "senioradmin", "superadmin"}
ITEM.Except = true
ITEM.SubCategory = "Member Models"

function ITEM:PlayerSpawn(ply)
    timer.Simple(0.33, function ()
        if ply and IsValid(ply) and ply:GetNClass() == ROLE_CLASSD then
            ply:SetModel(self.Model)
			ply:SetBodygroup(2,1)
            ply:SetBodygroup(1,1)			
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
ply:SetBodygroup(2,0)
ply:SetBodygroup(1,0)
        end
    end)
end
