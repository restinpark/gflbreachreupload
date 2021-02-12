ITEM.Name = "Popcorn"
ITEM.Price = 1000
ITEM.AllowedUserGroups = { "member", "supporter", "vip", "operator", "developer", "admin", "trialadmin", "senioradmin", "superadmin"}
ITEM.Except = true
ITEM.Model = "models/teh_maestro/popcorn.mdl"
ITEM.SubCategory = "Member Items"
ITEM.WeaponClass = "weapon_popcorn"
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
    ply:Give(self.WeaponClass) 
end

function ITEM:OnSell(ply)
    ply:StripWeapon(self.WeaponClass)
end