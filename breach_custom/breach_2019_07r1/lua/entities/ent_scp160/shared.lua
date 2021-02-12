ENT.Type = "anim"
ENT.PrintName = "SCP-160"
ENT.Author = "Aurora"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

print("SCP-160 Init")

function ENT:GetOwner()
    return self:GetNWEntity("owner", NULL)
end