function ENT:StartTouch(entity)
    if entity and IsValid(entity) and entity:IsPlayer() and entity:Team() ~= TEAM_SCP and entity:Team() ~= TEAM_SPEC then
        entity.AllowNewTouch = entity.AllowNewTouch or 0
        if entity.AllowNewTouch and entity.AllowNewTouch < CurTime() then
            entity:TakeDamage(10, self.Owner or self, self)
            entity.AllowNewTouch = CurTime() + 0
        end
    end
end

function ENT:Touch(entity)
    if entity and IsValid(entity) and entity:IsPlayer() and entity:Team() ~= TEAM_SCP and entity:Team() ~= TEAM_SPEC then
        entity.AllowNewTouch = entity.AllowNewTouch or 0
        if entity.AllowNewTouch and entity.AllowNewTouch < CurTime() then
            entity:TakeDamage(math.random(3, 6), self.Owner or self, self)
            entity.AllowNewTouch = CurTime() + 0.1
        end
    end
end

function ENT:S_INIT()
    self:SetTrigger(true)
    local e = self
    timer.Simple(45, function ()
        if e and IsValid(e) then
            SafeRemoveEntity(e)
        end
    end)
end

include("shared.lua")