ITEM.Name = "America's Hat"
ITEM.Price = 25000
ITEM.Model = "models/player/amrca/engineer/engineer_bill.mdl"
ITEM.AllowedUserGroups = {"supporter", "vip", "developer", "admin", "operator", "senioradmin", "superadmin"}
ITEM.Attachment = "eyes"
ITEM.NoPreview = false
--ITEM.Bone = "ValveBiped.Bip01_Head1"

function ITEM:OnEquip(ply, modifications)
	if ply:Team() != TEAM_SCP and ply:Team() != TEAM_SPEC then
		print("add model")
		ply:PS_AddClientsideModel(self.ID)
	end
end

function ITEM:OnHolster(ply)
	print("remove model")
	ply:PS_RemoveClientsideModel(self.ID)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1, 0)
	--pos = pos - Vector(0, 0, 70)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * -70)
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