ITEM.Name = "Snowball"
ITEM.Price = 1000
ITEM.AllowedUserGroups = { "member", "supporter", "vip", "operator", "developer", "admin", "trialadmin", "senioradmin", "superadmin"}
ITEM.Except = true
ITEM.Model = "models/weapons/w_snowball.mdl"
ITEM.SubCategory = "Member Items"
ITEM.WeaponClass = "snowball_thrower_nodamage"
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
    ply:Give(self.WeaponClass) 
end

function ITEM:OnSell(ply)
    ply:StripWeapon(self.WeaponClass)
end