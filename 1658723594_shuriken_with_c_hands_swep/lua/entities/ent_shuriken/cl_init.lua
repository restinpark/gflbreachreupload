include('shared.lua')

killicon.Add("ent_shuriken", "effects/killicons/ent_shuriken", color_white )

function ENT:Draw()
    self:DrawModel() -- Draws Model Client Side
end