ENT.Type = "anim"
ENT.Category = "SCPS"
ENT.PrintName = "SCP-216"
ENT.Author = "chan_man1"

AddCSLuaFile()

function ENT:Initialize()
	self:SetModel("models/vault/vault.mdl")
	self:SetSolid( SOLID_VPHYSICS )
    if SERVER then
        --For breach, we'll automatically set our position and angles according to the map config, if no such globals exist, we'll remove ourselves
        if SPAWN_SCP216 and isvector(SPAWN_SCP216) then
            self:SetPos(SPAWN_SCP216)
        else
            SafeRemoveEntity(self)
            return
        end
        --Angle override by the map config so that we spawn at a normal looking angle
        --Unlike position, this isn't required and we won't self-remove if there isn't an angle to set
        if SPAWN_SCP216_ANGLE and isangle(SPAWN_SCP216_ANGLE) then
            self:SetAngles(SPAWN_SCP216_ANGLE)
        end
    end
end

hook.Add("AllowPlayerPickup", "AllowPlayerPickup_SCP216", function (ply, ent)
    --You need to change the class name for this to work if you rename the file
    if IsValid(ent) and ent:GetClass() == "scp_216"then
        return false --Should prevent the player pickup
    end
end)