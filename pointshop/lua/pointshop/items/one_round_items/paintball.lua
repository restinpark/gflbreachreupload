ITEM.Name = "Paintball Gun"
ITEM.Price = 1000
ITEM.AllowedUserGroups = {  "supporter", "vip", "operator", "developer", "admin", "trialadmin", "senioradmin", "superadmin"}
ITEM.Except = true
ITEM.Model = "models/weapons/w_blazer.mdl"
ITEM.SubCategory = "Donator Items"
ITEM.WeaponClass = "paintball_swep"
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
    ply:Give(self.WeaponClass) 
end

function ITEM:OnSell(ply)
    ply:StripWeapon(self.WeaponClass)
end