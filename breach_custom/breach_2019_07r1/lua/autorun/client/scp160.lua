hook.Add("CalcView", "CalcView_AAA454554AAAAA", function (ply, origin, angles, fov, znear, zfar)
    if IsValid(ply) and ply:GetNClass() == ROLE_SCP160 then
        local drone
        for k,v in pairs(ents.FindByClass("ent_scp160")) do
            if IsValid(v) and v:GetOwner() == ply then
                drone = v
                break
            end
        end

        if drone and IsValid(drone) then
            local o = drone:GetPos()

            local ViewHullMins = Vector(-8, -8, -8)
            local ViewHullMaxs = Vector(8, 8, 8)
            local view = {}
            local filter = player.GetAll()
            table.ForceInsert(filter, drone)
		    local tr = util.TraceHull({start = o, endpos = o - angles:Forward() * math.max(56, drone:BoundingRadius()), mask = MASK_SHOT, filter = filter, mins = ViewHullMins, maxs = ViewHullMaxs})
		    view.origin = tr.HitPos + tr.HitNormal * 3
		    view.angles = ply:EyeAngles() + Angle( 1, 1, 0 )
            view.fov = fov

            return view
        end
    end
end)