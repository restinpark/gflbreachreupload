ITEM.Name = "Tomato"
ITEM.Price = 1000
ITEM.AllowedUserGroups = { "member", "supporter", "vip", "operator", "developer", "admin", "trialadmin", "senioradmin", "superadmin"}
ITEM.Except = true
ITEM.Model = "models/foodnhouseholditems/tomato.mdl"
ITEM.SubCategory = "Member Items"
ITEM.WeaponClass = "weapon_tomato"
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
    ply:Give(self.WeaponClass) 
end

function ITEM:OnSell(ply)
    ply:StripWeapon(self.WeaponClass)
end