ITEM.Name = "Eye"
ITEM.Price = 25000
ITEM.Model = "models/terr/models/enemy/en_demon_eye_dial.mdl"
ITEM.AllowedUserGroups = {"supporter", "vip", "developer", "admin", "operator", "senioradmin", "superadmin"}
ITEM.Attachment = "eyes"

function ITEM:OnEquip(ply, modifications)
    if ply:Team() != TEAM_SCP and ply:Team() != TEAM_SPEC then
        ply:PS_AddClientsideModel(self.ID)
    end
end

function ITEM:OnHolster(ply)
    ply:PS_RemoveClientsideModel(self.ID)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
    model:SetModelScale(0.35, 0)
    pos = pos + (ang:Right() * 18) + (ang:Forward() * -18)
    return model, pos, ang
end

function ITEM:PlayerSpawn(ply)
    ply:PS_RemoveClientsideModel(self.ID)
    timer.Simple(0.33, function ()
        if ply and IsValid(ply) then
            self:OnEquip(ply)
        end
    end)
end