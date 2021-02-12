local function Setup079Button(pos, delay, func, range, desc)
    local scp079btn = ents.Create("br_079btn")
    if IsValid(scp079btn) then
        scp079btn:Spawn()
        function scp079btn:UseFunc(ply)
            func(self, ply)
        end
        scp079btn:SetDelay(delay)
        scp079btn:SetPos(pos)
        scp079btn:SetUsableRange(range)
        scp079btn:SetDescription(desc)
    end
end

timer.Create("Update079EntityRelationships", 5, 0, function ()
    for _,turret in pairs(ents.FindByClass("npc_turret_ceiling")) do
        for _, v in pairs(player.GetAll()) do
            if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                turret:AddEntityRelationship(v, D_FR, 999)
            else
                turret:AddEntityRelationship(v, D_HT, 999)
            end
        end
    end
end)

function SpawnSCP079Buttons()
    for k,v in pairs(ents.FindByClass("br_079btn")) do
        if IsValid(v) then
            SafeRemoveEntity(v)
        end
    end
    if game.GetMap() == "br_site19" then

        local t_index = {
            [1] = {
                pos = Vector(3714.787354, -902.571960, -0.031250),
                ang = Angle(0.000, 90.291, 0.000)
            },
            [2] = {
                pos = Vector(3618.229492, -456.121307, 78.947968),
                ang = Angle(0.000, -35.074, 0.000)
            },
            [3] = {
                pos = Vector(2122.963135, -277.210663, 255.968750),
                ang = Angle(0.000, 90, 0.000)
            },
            [4] = {
                pos = Vector(4268.340332, 504.182312, 127.968750),
                ang = Angle(0, -160, 0)
            },
            [5] = {
                pos = Vector(3029.105713, 2199.007812, 127.968735),
                ang = Angle(0.000, 160, 0.000)
            },
            [6] = {
                pos = Vector(2711.993408, 2229.818604, 127.525551),
                ang = Angle(0.000, 70.983, 0.000)
            },
            [7] = {
                pos = Vector(2748.680908, 2518.489502, 127.968773),
                ang = Angle(0.000, -45, 0.000)
            },
            [8] = {
                pos = Vector(3035.713867, 2506.239502, 127.968765),
                ang = Angle(0.000, -127.716, 0.000)
            },
            [9] = {
                pos = Vector(181.313278, 4155.384277, 255.968750),
                ang = Angle(0, -90, 0)
            },
            [10] = {
                pos = Vector(-2984.345215, 3783.926270, 383.968750),
                ang = Angle(0, 60, 0)
            },
            [11] = {
                pos = Vector(-3343.906250, 2422.875000, 2836.968750),
                ang = Angle(0,0,0)
            },
            [12] = {
                pos = Vector(-6535.906250, -704.281250, 2240.750000),
                ang = Angle(0.264, 85.869, 0.439)
            }
        }

        local g_index = {
            [1] = Vector(3349.134277, -195.611206, 56.311119),
            [2] = Vector(3546.053955, -202.846832, 60.794956),
            [3] = Vector(3701.536865, -196.471588, 53.028957),
            [4] = Vector(635.157532, -1295.571533, 48.755192),
            [5] = Vector(628.450073, -1461.939819, 56.854511),
            [6] = Vector(679.686829, -1663.247192, 53.255875),
            [7] = Vector(575.961670, -1681.868652, 59.096874),
            [8] = Vector(4802.033203, 1831.128418, 66.053856),
            [9] = Vector(4803.313965, 1601.486694, 66.494141),
            [10] = Vector(-1764.708984, 2738.580078, -63.064457),
            [11] = Vector(-1944.029053, 2767.911865, -63.447781),
            [12] = Vector(-1930.961914, 2568.558350, -63.775620),
            [13] = Vector(-1507.515259, 2731.956543, -63.604645),
            [14] = Vector(-1532.646973, 2557.333740, -63.987026),
            [15] = Vector(1481.191650, -832.476990, 63.714855),
            [16] = Vector(1485.219727, -634.558899, 63.369133),
            [17] = Vector(1452.327515, -1037.025635, 63.208103),
			[18] = Vector(4170.454590, 3013.298828, 63.842773),
            [19] = Vector(4158.831543, 3633.576172, 63.136124),
            [20] = Vector(3467.185791, 3654.691650, 65.019821)
        }

        Setup079Button(Vector(3545.395508, -473.014191, -192.189835), 25, function (btn, ply)
            ply:TakeDamage(100, game.GetWorld(), game.GetWorld())
            util.BlastDamage(ply, ply, Vector(3545.395508, -473.014191, -192.189835), 225, 500)
        end, 600, "Trigger an explosion")

        Setup079Button(Vector(3624.485352, -1339.630371, -25.340597), 30, function (btn, ply)
            local incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(3791.948486, -1305.480347, -15.958650))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Burst the gas pipe")

        Setup079Button(Vector(3714.787354, -902.571960, -0.031250), 90, function (btn, ply)
            for i = 1, 2 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetAngles(t_index[i].ang)
                    turret:SetKeyValue("spawnflags", "32")
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 999)
                        else
                            turret:AddEntityRelationship(v, D_HT, 999)
                        end
                    end
                    turret:AddEntityRelationship(ply, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600, "Activate defense turrets")

        Setup079Button(Vector(3536.123779, -192.643509, 141.030899), 65, function (btn, ply)
            for i = 1, 3 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600, "Release gas from the vents")

        Setup079Button(Vector(2122.963135, -277.210663, 255.968750), 90, function (btn, ply)
            local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                turret:SetPos(t_index[3].pos)
                turret:SetAngles(t_index[3].ang)
                turret:SetKeyValue("spawnflags", "32")
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(ply, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600, "Activate turret")

        Setup079Button(Vector(2278.797363, -2274.476807, 64.749474), 30, function (btn, ply)
            local incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(2186.477295, -2330.236328, 61.682743))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end

            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(2349.951660, -2216.078369, 60.673489))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Fire")

        Setup079Button(Vector(688.934509, -1275.600952, 79.157303), 60, function (btn, ply)
            --Close the doors
            for k,v in pairs(ents.FindByClass("func_door")) do
                if v and IsValid(v) and v.GetName and (v:GetName() == "lcz_door_2_47" or v:GetName() == "lcz_door_1_47") then
                    v:Fire("Close")
                    v:Fire("Lock")
                end
            end

            --Spawn gas
            timer.Simple(3, function ()
                for i = 4, 7 do
                    local gas = ents.Create("ent_scp079_gas")
                    if IsValid(gas) then
                        gas:SetPos(g_index[i])
                        gas.Owner = ply
                        gas:Spawn()
                    end
                end
            end)

            --Unlock doors
            timer.Simple(50, function ()
                for k,v in pairs(ents.FindByClass("func_door")) do
                    if v and IsValid(v) and v.GetName and (v:GetName() == "lcz_door_2_47" or v:GetName() == "lcz_door_1_47") then
                        v:Fire("Unlock")
                        v:Fire("Open")
                    end
                end
            end)
        end, 600, "Activate decontaimination proceedure.")

        Setup079Button(Vector(1691.098022, 887.380127, 84.727432), 30, function (btn, ply)
            timer.Create("FragGrenadeTimer_079", 1, 4, function ()
                local nade = ents.Create("tfa_csgo_thrownfrag")
                if IsValid(nade) then
                    nade:SetPos(Vector(1670.120117, 889.751038, 166.396347))
                    nade.Owner = ply
                    nade:Spawn()
                    nade:SetNoDraw(true)
                    nade:GetPhysicsObject():Wake()
                end
            end)
        end, 600, "Do what atomic did to gary's minecraft house")

        Setup079Button(t_index[4].pos, 90, function (btn, ply)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[4].pos)
                turret:SetAngles(t_index[4].ang)
                turret:SetKeyValue("spawnflags", "32")
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(ply, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600, "Activate Warhead Turrets")

        Setup079Button(Vector(3518.551270, 1098.868408, 115.221878), 25, function (btn, ply)
            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(3518.551270, 1098.868408, 115.221878))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end

        end, 600, "Burst fuel line")

        Setup079Button(Vector(4799.465820, 1746.464111, 126.616943), 55, function (btn, ply)
            for i = 8, 9 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600, "Gas")

        Setup079Button(Vector(2863.609619, 2361.484619, 66.951538), 90, function (btn, ply)
            for i = 5, 8 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetAngles(t_index[i].ang)
                    turret:SetKeyValue("spawnflags", "32")
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(ply, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600, "Activate Turrets")

        local r_index = {
            [1] = Vector(2893.937256, 3269.604980, 37.957806),
            [2] = Vector(2882.901611, 2966.234619, 115.317749),
            [3] = Vector(2864.408447, 2736.690674, 60.354424)
        }

        Setup079Button(Vector(2882.901611, 2966.234619, 115.317749), 360, function (btn, ply)
            for i = 1, 3 do
                local mine = ents.Create("npc_rollermine")
                if IsValid(mine) then
                    mine:SetPos(r_index[i])
                    mine:Spawn()
                end
            end
        end, 600, "Summon rollermines")

        Setup079Button(Vector(-443.606049, 3661.543213, 243.514450), 35, function (btn, ply)
            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(-443.606049, 3661.543213, 243.514450))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Drop firenade")

        Setup079Button(Vector(823.038574, 3653.491211, 250.990784), 35, function (btn, ply)
            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(823.038574, 3653.491211, 250.990784))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Drop firenade")

        Setup079Button(Vector(96.000000, 3100.000000, -128.000000), 60, function (btn, ply)
            IS_294_POISONED = true

            timer.Simple(30, function ()
                IS_294_POISONED = false
            end)
        end, 600, "Poison SCP-294")

        Setup079Button(Vector(181.313278, 4155.384277, 255.968750), 90, function (btn, ply)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[9].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[9].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(ply, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600, "Spawn turret")

        Setup079Button(Vector(-828.474609, 2577.830566, 47.236263), 90, function (btn, scp079)
            for _,v in pairs(ents.FindByClass("ent_scp330")) do
                local n_ct = {}
                for _, ply in pairs(player.GetAll()) do
                    n_ct[ply] = 2
                end
                v.CANDY_TAKERS = n_ct

                timer.Simple(30, function ()
                    v.CANDY_TAKERS = {}
                end)
            end
        end, 600, "Rig candy")

        Setup079Button(Vector(-2984.345215, 3783.926270, 383.968750), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[10].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[10].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600, "Spawn Turrets")

        Setup079Button(Vector(-3343.906250, 2422.875000, 2836.968750), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[11].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[11].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(t_index[12].pos, 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_floor")
            if IsValid(turret) then
                turret:SetPos(t_index[12].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[12].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn CampTurret9000")

        local n_index = {
            Vector(-6557.218750, 2064.343750, 2704.968750),
            Vector(-6326.468750, 2078.000000, 2707.250000),
            Vector(-6091.031250, 2072.656250, 2687.000000),
            Vector(-5914.343750, 2087.812500, 2710.937500),
            Vector(-5721.343750, 2090.593750, 2685.656250),
            Vector(204.418716, 4066.686035, 23.099586),
            Vector(117.825233, 3348.083740, 56.694664),
            Vector(151.429916, 3628.853516, 110.406036),
            Vector(-446.858856, 5170.801758, 156.525467),
            Vector(-481.659149, 5009.744141, 105.168839),
            Vector(-594.305603, 5137.063965, 85.907593),
            Vector(-435.601349, 5271.833496, 76.250992),
            Vector(-297.877655, 6925.077148, 2560.714844)
        }
        Setup079Button(n_index[3], 45, function (btn, ply)
            for i = 1, 5 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[i])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 6, "Drop firenade")

        --SetSerpentsHand
        Setup079Button(Vector(573.093750, 6980.750000, 2092.406250), 360, function (btn)
            for i = 1, 3 do
                local ply = table.Random(GetNotAFKSpecs()) --Once a assign a player to SH, they are no longer a spec, thus not in this table
                if IsValid(ply) then
                    ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
                end
            end
        end, 600 * 6, "Spawn SH Squad")

        Setup079Button(Vector(1222.135376, -804.393005, -695.063904), 300, function (btn)
            local ply = table.Random(GetNotAFKSpecs())
            ply:SetSCP939()
            ply:SetPos(Vector(1222.135376, -804.393005, -745.063904))
            ply:SetHealth(ply:Health() / 2)
        end, 1800, "Breach SCP-939")
		
		Setup079Button(Vector(2037.255615, 1853.598267, 54.983707), 300, function (btn)
            local pl = table.Random(GetNotAFKSpecs())
            pl:SetSCP0082()
            pl:SetPos(Vector(2084.575439, 1724.279297, 55.081654))
        end, 1800, "Breach SCP-008")
        --Activte SCP-001? Sun thing
        print("Finished spawning scp079 buttons")

        Setup079Button(n_index[8], 45, function (btn, ply)
            for i = 6, 8 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[i])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 3, "Drop firenade")

        Setup079Button(n_index[9], 45, function (btn, ply)
            for i = 9, 12 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[i])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 3, "Drop firenade")

        Setup079Button(n_index[13], 45, function (btn, ply)
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[13])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
        end, 600 * 6, "Drop firenade")

        Setup079Button(g_index[12], 55, function (btn, ply)
            for i = 10, 14 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")

        Setup079Button(g_index[16], 55, function (btn, ply)
            for i = 15, 17 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")
		Setup079Button(g_index[19], 55, function (btn, ply)
            for i = 18, 20 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
    elseif game.GetMap() == "br_site65" then

        local g_index = {
            Vector(1824.317383, -2085.081787, -11191.453125),
            Vector(1820.853882, -1937.401611, -11190.564453),
            Vector(1784.839111, -1829.389648, -11195.886719),
            Vector(1698.623779, -1829.613770, -11194.930664),
            Vector(1678.345337, -1927.297607, -11189.466797),
            Vector(1679.304810, -1987.076416, -11188.612305),
            Vector(1566.109863, -2108.577393, -11190.090820),
            Vector(1677.395630, -2131.035889, -11190.691406),
            Vector(1558.670654, -2086.660889, -11197.863281),
            Vector(1540.452271, -1921.371582, -11199.166992),
            Vector(1542.186157, -1801.939209, -11189.978516),
            --12
            Vector(1059.261108, 317.982422, -10982.346680),
            Vector(1254.411011, 311.662048, -10980.217773),
            Vector(1382.921509, 312.275635, -10983.814453),
            Vector(1458.749023, 309.819641, -10980.463867),
            Vector(1617.171753, 309.464325, -10980.920898),
            Vector(1759.160889, 304.866302, -10992.239258),
            Vector(1856.973877, 301.698486, -10992.850586),
            Vector(1943.212158, 298.905151, -10985.356445),
        }

        Setup079Button(Vector(1690.927612, -1936.025513, -11119.503906), 60, function (btn, ply)
            for i = 1, 11 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")

        local t_index = {
            {
                ang = Angle(0.000000, 142.031250, 0.000000),
                pos = Vector(1888.619629, -1678.665527, -10975.031250)
            },
            {
                ang = Angle(0.000000, 43.549805, 0.000000),
                pos = Vector(1502.424194, -1672.221680, -10975.031250)
            },
            {
                pos =  Vector(1523.836914, -675.857361, -11180.246094),
                ang =  Angle(0.280151, 51.696167, 0.192261)
            },
            --4
            {
                pos = Vector(3078.739014, 87.923531, -10716.031250),
                ang = Angle(0.000000, 65.115967, 0.000000)
            },
            {
                pos = Vector(3083.298828, 546.609192, -10716.031250),
                ang = Angle(0.000000, -18.792114, 0.000000)
            },
            {
                pos = Vector(3567.506104, 543.239380, -10716.031250),
                ang = Angle(0.000000, -143.168335, 0.000000)
            },
            {
                pos = Vector(3571.079102, 96.046669, -10716.031250),
                ang = Angle(0.000000, 120.206909, 0.000000)
            }
            
        }

        Setup079Button(Vector(1720.646973, -1556.806030, -11074.468750), 90, function (btn, scp079)
            for i = 1, 2 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(Vector(1669.237183, -556.255493, -11126.911133), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_floor")
            if IsValid(turret) then
                turret:SetPos(t_index[3].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[3].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turret")

        Setup079Button(Vector(1488.899292, 304.653046, -10960.490234), 55, function (btn, scp079)
            for i = 12, 19 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(g_index[i])
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 4, "Firebomb")

        Setup079Button(Vector(3341.242920, 287.160126, -10830.116211), 90, function (btn, scp079)
            for i = 4, 7 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(SPAWN_330, 90, function (btn, scp079)
            for _,v in pairs(ents.FindByClass("ent_scp330")) do
                local n_ct = {}
                for _, ply in pairs(player.GetAll()) do
                    n_ct[ply] = 2
                end
                v.CANDY_TAKERS = n_ct

                timer.Simple(30, function ()
                    v.CANDY_TAKERS = {}
                end)
            end
        end, 600, "Rig candy")

        Setup079Button(SPAWN_SCP_294, 60, function (btn, ply)
            IS_294_POISONED = true

            timer.Simple(30, function ()
                IS_294_POISONED = false
            end)
        end, 600, "Poison SCP-294")

        Setup079Button(Vector(2937.546387, -6010.630859, -11015.830078), 300, function (btn)
            local ply = table.Random(GetNotAFKSpecs())
            if not ply then return end
            ply:SetSCP939()
            ply:SetPos(SPAWN_939)
            ply:SetHealth(ply:Health() / 2)
        end, 1800, "Breach SCP-939")

        Setup079Button(Vector(-5481.885254, 6981.372559, -5754.372070), 360, function (btn)
            for i = 1, 3 do
                local ply = table.Random(GetNotAFKSpecs()) --Once a assign a player to SH, they are no longer a spec, thus not in this table
                if IsValid(ply) then
                    ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
                end
            end
        end, 600 * 6, "Spawn SH Squad")

        local mining_gases = {
            Vector(608.664368, 766.983276, -10988.419922),
            Vector(613.476685, 838.158508, -10989.174805),
            Vector(612.209961, 969.139709, -10995.255859),
            Vector(609.373230, 1198.697388, -10983.927734),
            Vector(608.953308, 1385.892212, -10991.043945),
            Vector(610.571777, 1579.197754, -10996.468750),
            Vector(606.596497, 1761.433960, -10998.048828),
            Vector(619.513123, 1898.838257, -11003.194336)
        }

        Setup079Button(Vector(608.953308, 1385.892212, -10991.043945), 70, function (btn)
            for k,v in pairs(mining_gases) do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(v)
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 6, "Gas Leak")
        --0
        Setup079Button(Vector(1810.799927, -3315.484863, -11019.031250), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(1810.799927, -3315.484863, -11019.031250))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(0.000000, -94.031982, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Checkpoint Turrets")
        

        --1
        Setup079Button(Vector(5270.938477, -2920.220459, -10883.031250), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(5270.938477, -2920.220459, -10883.031250))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(0.000000, -159.087524, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Checkpoint Turrets")
        --2
        
        Setup079Button(Vector(4991.458984, 201.842926, -10883.031250), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(4991.458984, 201.842926, -10883.031250))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(0.000000, 83, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Checkpoint Turrets")
        --3
        
        Setup079Button(Vector(-263.286224, 2529.590088, -10883.031250), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-263.286224, 2529.590088, -10883.031250))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(0.000000, -94.031982, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Checkpoint Turrets")

        local incends1 = {
            Vector(4038.120361, -4516.818848, -10964.450195),
            Vector(4039.505615, -4374.904785, -10978.316406),
            Vector(4041.103271, -4211.063477, -10987.158203),
            Vector(4042.866943, -4030.193604, -10997.087891),
            Vector(4044.427490, -3870.261475, -10966.770508),
            Vector(4045.979980, -3711.186768, -10980.081055),
            Vector(4276.494141, -4093.780273, -10979.456055),
            Vector(4487.446777, -4105.986816, -11008.645508),
            Vector(3784.802002, -4070.872070, -10987.859375),
            Vector(3632.126953, -4067.554688, -10955.330078)
        }

        Setup079Button(Vector(4034.391357, -4015.562744, -10962.101563), 55, function (btn, scp079)
            for k, v in pairs(incends1) do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(v)
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 6, "Fire")

        local a = {
            {
                pos = Vector(-5973.143555, 2521.795898, -10649.031250),
                ang = Angle(0.000000, 48.098145, 0.000000)
            },
            {
                pos = Vector(-5341.623535, 2458.843018, -10649.031250),
                ang = Angle(0.000000, 120.959473, 0.000000)
            },
            {
                pos = Vector(-5217.636719, 3455.324951, -10649.031250),
                ang = Angle(0.000000, -127.633667, 0.000000)
            },
            {
                pos = Vector(-5983.970215, 3553.687012, -10649.031250),
                ang = Angle(0.000000, -64.627075, 0.000000)
            }
        }

        Setup079Button(Vector(-5667.221680, 3249.979736, -10784.238281), 90, function (btn, scp079)
            for k, v in pairs(a) do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(v.pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(v.ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")


        Setup079Button(Vector(-2956.017090, 3870.055908, -10865.031250), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-2956.017090, 3870.055908, -10865.031250))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(0.000000, -88.033447, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turrets")
		Setup079Button(Vector(3534.904297, 2646.442139, -11024.991211), 300, function (btn)
            local pl = table.Random(GetNotAFKSpecs())
            pl:SetSCP0082()
            pl:SetPos(Vector(3336.564209, 2600.022217, -11007.929688))
        end, 1800, "Breach SCP-008")
		local ice_index = {
            [18] = Vector(2524.453613, -1181.168945, -10967.991211),
            [19] = Vector(2568.989258, -830.546692, -10968.026367),
            [20] = Vector(2538.055420, -390.959473, -10969.811523)
        }
		Setup079Button(Vector(2568.989258, -830.546692, -10968.026367), 55, function (btn, ply)
            for i = 18, 20 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(ice_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
	elseif game.GetMap() == "br_site05_v2" then

        local g_index = {
            Vector(-1682.225098, 8737.339844, -1884.226929),
            Vector(-1685.789307, 8514.208008, -1882.563477),
            Vector(-1693.053955, 8059.442383, -1884.481445),
            Vector(-1693.226074, 7481.747070, -2013.551758),
            Vector(-3625.779053, 8760.235352, -2700.325684),
            Vector(-3625.924072, 8385.281250, -2700.445068),
            Vector(-3622.770020, 7960.337402, -2698.942627),
            Vector(-3619.956299, 7581.717285, -2698.666504),
            Vector(-3639.232422, 7191.870117, -2698.618164),
            Vector(-1672.769165, 7383.379395, -2700.033936),
            Vector(-1676.395630, 7388.923340, -3082.452881),
            --12
            Vector(-3531.131592, 4310.597656, -3082.305664),
            Vector(-3511.203857, 3239.587646, -3083.906006),
            Vector(-4190.976563, 3196.596680, -3084.371826),
            Vector(-4672.677734, 3222.685303, -3082.492920),
            Vector(-4667.744141, 3893.361328, -3083.909668),
            Vector(-4624.820313, 4321.146484, -3083.602783),
            Vector(-3972.170898, 4331.393555, -3083.801514),
            Vector(-3489.449463, 3729.220703, -3082.562988),
        }

        Setup079Button(Vector(-2670.457520, 8148.531250, -2255.775635), 60, function (btn, ply)
            for i = 1, 11 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")

        local t_index = {
            {
                ang = Angle(22.272409, 41.422462, 0.000000),
                pos = Vector(-2818.827637, 6104.408203, -2624.593750)
            },
            {
                ang = Angle(36.135307, 52.912189, 0.000000),
                pos = Vector(-1822.461670, 6142.853027, -2622.730713)
            },
            {
                pos =  Vector(-1620.031250, 11356.768555, -1883.548828),
                ang =  Angle(7.241627, -136.856705, 0.000000)
            },
            --4
            {
                pos = Vector(-4939.607910, 384.716827, -1683.371094),
                ang = Angle(34.064068, 41.035530, 0.000000)
            },
            {
                pos = Vector(-4927.146973, 1391.576904, -1671.672607),
                ang = Angle(40.262524, -50.103302, 0.000000)
            },
            {
                pos = Vector(-488.621735, 1400.076050, -1671.394287),
                ang = Angle(41.673645, -141.141922, 0.000000)
            },
            {
                pos = Vector(-477.799744, 407.753754, -1672.245728),
                ang = Angle(39.818096, 140.191605, 0.000000)
            }
            
        }

        Setup079Button(Vector(-2413.950195, 6203.364258, -2697.973389), 90, function (btn, scp079)
            for i = 1, 2 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(Vector(-1705.366455, 11279.591797, -1882.862793), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_floor")
            if IsValid(turret) then
                turret:SetPos(t_index[3].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[3].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turret")

        Setup079Button(Vector(-3531.131592, 4310.597656, -3082.305664), 55, function (btn, scp079)
            for i = 12, 19 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(g_index[i])
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 4, "Firebomb")

        Setup079Button(Vector(-2625.804688, 905.937439, -2042.587280), 90, function (btn, scp079)
            for i = 4, 7 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(SPAWN_330, 90, function (btn, scp079)
            for _,v in pairs(ents.FindByClass("ent_scp330")) do
                local n_ct = {}
                for _, ply in pairs(player.GetAll()) do
                    n_ct[ply] = 2
                end
                v.CANDY_TAKERS = n_ct

                timer.Simple(30, function ()
                    v.CANDY_TAKERS = {}
                end)
            end
        end, 600, "Rig candy")

        Setup079Button(SPAWN_SCP_294, 60, function (btn, ply)
            IS_294_POISONED = true

            timer.Simple(30, function ()
                IS_294_POISONED = false
            end)
        end, 600, "Poison SCP-294")

        Setup079Button(Vector(530.550598, 3999.433594, -3165.468018), 300, function (btn)
            local ply = table.Random(GetNotAFKSpecs())
            if not ply then return end
            ply:SetSCP939()
            ply:SetPos(SPAWN_939)
            ply:SetHealth(ply:Health() / 2)
        end, 1800, "Breach SCP-939")

        Setup079Button(Vector(-4962.216797, -6267.098145, -1890.605591), 360, function (btn)
            for i = 1, 3 do
                local ply = table.Random(GetNotAFKSpecs()) --Once a assign a player to SH, they are no longer a spec, thus not in this table
                if IsValid(ply) then
                    ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
                end
            end
        end, 600 * 6, "Spawn SH Squad")

        local mining_gases = {
            Vector(-2538.246826, 5429.960449, -3082.471436),
            Vector(-1995.828857, 5449.948730, -3083.236328),
            Vector(-2150.550049, 5421.513184, -3082.418213),
            Vector(-2346.303467, 5433.716309, -3083.250977),
            Vector(-3019.788574, 5437.275879, -3082.763672),
            Vector(-2732.618408, 5448.747070, -3083.061768)
        }

        Setup079Button(Vector(-2538.246826, 5429.960449, -3082.471436), 70, function (btn)
            for k,v in pairs(mining_gases) do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(v)
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 6, "Gas Leak")
		
		local r_index = {
            [1] = Vector(-2380.542725, 3870.472412, -2698.463135),
            [2] = Vector(-2864.973145, 3843.825195, -2699.030518),
            [3] = Vector(-2616.484619, 3915.223389, -3082.288086)
        }

        Setup079Button(Vector(-2616.484619, 3915.223389, -3082.288086), 360, function (btn, ply)
            for i = 1, 3 do
                local mine = ents.Create("npc_rollermine")
                if IsValid(mine) then
                    mine:SetPos(r_index[i])
                    mine:Spawn()
                end
            end
        end, 600, "Release Rollermines")
        --0
        Setup079Button(Vector(-2956.958008, -3683.024902, -1883.512207), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-2351.989502, -3442.310059, -1685.134399))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(39.290508, -136.582016, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")
        

        --1
        Setup079Button(Vector(-1297.086548, 4564.203125, -2697.823730), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-1300.024048, 4288.969238, -2518.542236))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(38.268421, 91.080605, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")
        --2
        
        Setup079Button(Vector(-3789.814941, 4280.218262, -2698.865967), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-3790.200195, 4007.843262, -2519.765137))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(34.464397, 89.950012, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")
        --3
        
        Setup079Button(Vector(-757.628845, 4505.442871, -3083.560791), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-452.729523, 4502.899902, -3006.549805))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(19.275356, -179.904999, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")

        local incends1 = {
            Vector(274.599976, 11257.826172, -2780.783447),
            Vector(145.936661, 11829.050781, -2780.729004),
            Vector(445.187225, 12565.400391, -2778.977783),
            Vector(1322.511841, 12579.995117, -2779.465088),
            Vector(1495.751343, 11851.970703, -2780.449951),
            Vector(1363.276978, 11307.193359, -2779.077393),
            Vector(757.144165, 13041.048828, -2750.855469),
            Vector(815.515137, 12159.012695, -2255.336182),
            Vector(1620.280884, 12913.327148, -1884.497803),
            Vector(-0.010138, 13000.501953, -1884.624146)
        }

        Setup079Button(Vector(806.466492, 13356.565430, -1883.192383), 55, function (btn, scp079)
            for k, v in pairs(incends1) do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(v)
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 6, "Fire")

        local a = {
            {
                pos = Vector(-6653.210449, -6290.827148, -1362.389282),
                ang = Angle(23.351870, 144.105911, 0.000000)
            },
            {
                pos = Vector(-6647.154297, -5637.534180, -1359.842529),
                ang = Angle(32.915073, -130.638306, 0.000000)
            }
        }

        Setup079Button(Vector(-6769.263672, -5978.061035, -1561.053345), 90, function (btn, scp079)
            for k, v in pairs(a) do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(v.pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(v.ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Gate A Turrets")
		
		Setup079Button(Vector(-2732.629150, 6200.616211, -2671.761475), 25, function (btn, ply)
            ply:TakeDamage(100, game.GetWorld(), game.GetWorld())
            util.BlastDamage(ply, ply, Vector(-2732.629150, 6200.616211, -2671.761475), 225, 500)
        end, 600, "Trigger an explosion")

		Setup079Button(Vector(-3313.034912, 14179.955078, -1883.518188), 30, function (btn, ply)
            timer.Create("FragGrenadeTimer_079", 1, 4, function ()
                local nade = ents.Create("tfa_csgo_thrownfrag")
                if IsValid(nade) then
                    nade:SetPos(Vector(-3313.034912, 14179.955078, -1883.518188))
                    nade.Owner = ply
                    nade:Spawn()
                    nade:SetNoDraw(true)
                    nade:GetPhysicsObject():Wake()
                end
            end)
        end, 600, "Carpet Bombem")

        Setup079Button(Vector(-3653.529053, 12771.658203, -1884.441284), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-3701.490723, 12812.291016, -1703.758667))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(40.323284, -42.771393, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turret")
		Setup079Button(Vector(-2149.102783, 4715.792480, -2686.009277), 300, function (btn)
            local pl = table.Random(GetNotAFKSpecs())
            pl:SetSCP0082()
            pl:SetPos(Vector(-2014.301514, 5051.205566, -2750.009521))
        end, 1800, "Breach SCP-008")
		local ice_index = {
            [18] = Vector(-3671.612305, 10282.121094, -1883.953735),
            [19] = Vector(-3661.365479, 10960.375977, -1882.793701),
            [20] = Vector(-3565.375488, 9767.199219, -1882.916870)
        }
		Setup079Button(Vector(-3677.923828, 10543.981445, -1884.357788), 55, function (btn, ply)
            for i = 18, 20 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(ice_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
	elseif game.GetMap() == "br_site61_v2" then

        local g_index = {
            Vector(-1666.353516, 1078.980225, -7999.139160),
            Vector(-2071.749756, 1081.507202, -8000.707031),
            Vector(-2088.520264, 914.506287, -7999.060547),
            Vector(-1631.067017, 911.915588, -8191.334961),
            Vector(-1753.380737, 473.458344, -8256.968750),
            Vector(-2290.593994, 919.521912, -8254.994141),
            Vector(-2410.115234, 1855.973877, -8012.640137),
            Vector(-2638.687988, 529.621826, -8008.874512),
            Vector(-2867.582764, 678.438354, -8008.091797),
            Vector(-2867.290771, 421.491302, -8008.605469),
            Vector(-2542.894287, 1334.950684, -8007.313477),
            --12
            Vector(1223.525635, -2145.272949, -8128.487305),
            Vector(1240.301392, -1439.775391, -8127.087402),
            Vector(1234.824707, -856.164856, -8128.080566),
            Vector(1233.882690, -199.430496, -8127.809570),
            Vector(1225.712646, 439.918213, -8128.773926),
            Vector(1229.145996, 1109.968018, -8128.904785),
            Vector(1240.992798, 1841.358276, -8128.438965),
            Vector(1245.130615, 2531.031738, -8128.477539),
        }

        Setup079Button(Vector(-1918.007324, 482.064484, -8087.650391), 60, function (btn, ply)
            for i = 1, 11 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")

        local t_index = {
            {
                ang = Angle(40.437447, -178.690460, 0.000000),
                pos = Vector(235.457443, 2490.019043, -7943.741211)
            },
            {
                ang = Angle(42.208828, 1.972931, 0.000000),
                pos = Vector(337.077972, 2498.798828, -7941.567383)
            },
            {
                pos =  Vector(501.531830, -318.433167, -7942.240723),
                ang =  Angle(38.571461, 49.498669, 0.00)
            },
            --4
            {
                pos = Vector(1605.918091, 2344.853516, -7939.672363),
                ang = Angle(47.449409, 55.262741, 0.000000)
            },
            {
                pos = Vector(2227.531006, 2243.066895, -6996.891602),
                ang = Angle(13.329668, 104.131462, 0.000000)
            },
            {
                pos = Vector(2128.312256, 2474.688477, -5637.053223),
                ang = Angle(48.252277, -90.671181, 0.00)
            },
            {
                pos = Vector(2118.597412, 2510.500244, -5642.453125),
                ang = Angle(60.973969, 96.400574, 0.0)
            }
            
        }

        Setup079Button(Vector(0.259006, 2504.274170, -8117.501465), 90, function (btn, scp079)
            for i = 1, 2 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(Vector(630.480408, -196.143173, -8110.358887), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[3].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[3].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turret")

        Setup079Button(Vector(1226.716797, 879.714844, -8127.098633), 55, function (btn, scp079)
            for i = 12, 19 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(g_index[i])
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 4, "Firebomb")

        Setup079Button(Vector(2053.072754, 2492.403076, -8066.828125), 90, function (btn, scp079)
            for i = 4, 7 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(SPAWN_330, 90, function (btn, scp079)
            for _,v in pairs(ents.FindByClass("ent_scp330")) do
                local n_ct = {}
                for _, ply in pairs(player.GetAll()) do
                    n_ct[ply] = 2
                end
                v.CANDY_TAKERS = n_ct

                timer.Simple(30, function ()
                    v.CANDY_TAKERS = {}
                end)
            end
        end, 600, "Rig candy")

        Setup079Button(SPAWN_SCP_294, 60, function (btn, ply)
            IS_294_POISONED = true

            timer.Simple(30, function ()
                IS_294_POISONED = false
            end)
        end, 600, "Poison SCP-294")

        Setup079Button(Vector(6460.832031, -881.038086, -11487.663086), 300, function (btn)
            local ply = table.Random(GetNotAFKSpecs())
            if not ply then return end
            ply:SetSCP939()
            ply:SetPos(SPAWN_939)
            ply:SetHealth(ply:Health() / 2)
        end, 1800, "Breach SCP-939")

        Setup079Button(Vector(-657.503906, -1735.900635, 561.436646), 360, function (btn)
            for i = 1, 3 do
                local ply = table.Random(GetNotAFKSpecs()) --Once a assign a player to SH, they are no longer a spec, thus not in this table
                if IsValid(ply) then
                    ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
                end
            end
        end, 600 * 6, "Spawn SH Squad")

        local mining_gases = {
            Vector(-698.973145, 3551.824707, -7104.938477),
            Vector(-702.630066, 2841.585449, -7103.097168),
            Vector(-48.902199, 2844.340576, -7103.342773),
            Vector(-1420.631348, 2839.619141, -7104.497070),
            Vector(-676.225281, 2142.515381, -7104.016113),
            Vector(-704.115967, 1570.253052, -7104.964844)
        }

        Setup079Button(Vector(-702.630066, 2841.585449, -7103.097168), 70, function (btn)
            for k,v in pairs(mining_gases) do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(v)
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 6, "Gas Leak")
		
		local r_index = {
            [1] = Vector(-62.701366, 4746.794434, -7104.548340),
            [2] = Vector(-65.078133, 5422.220215, -7104.214844),
            [3] = Vector(499.709076, 5397.166504, -7104.766602),
			[4] = Vector(-3640.955566, 4337.335938, -7246.969727),
            [5] = Vector(-4034.244141, 4338.426270, -7248.891113),
            [6] = Vector(-4035.334229, 4845.613281, -7248.917969),
            [7] = Vector(-3637.235596, 4864.559082, -7247.418457)
        }

        Setup079Button(Vector(-65.078133, 5422.220215, -7104.214844), 360, function (btn, ply)
            for i = 1, 3 do
                local mine = ents.Create("npc_rollermine")
                if IsValid(mine) then
                    mine:SetPos(r_index[i])
                    mine:Spawn()
                end
            end
        end, 600, "Release Rollermines")
		Setup079Button(Vector(-3831.498047, 4727.715820, -7247.878418), 360, function (btn, ply)
            for i = 4, 7 do
                local mine = ents.Create("npc_rollermine")
                if IsValid(mine) then
                    mine:SetPos(r_index[i])
                    mine:Spawn()
                end
            end
        end, 600, "Release Rollermines")
        --0
        Setup079Button(Vector(-2236.203857, 3900.720215, -7048.559082), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-2236.203857, 3900.720215, -7048.559082))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(24.959923, 43.797920, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")
        

        --1
        Setup079Button(Vector(-2615.030029, 5411.050293, -7076.941895), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-2719.099365, 5503.435059, -6919.754395))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(57.877232, -40.825191, 0.00))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")
        --2
        
        Setup079Button(Vector(-695.232361, 4779.860352, -7102.805664), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-694.106750, 4995.675781, -7019.918457))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(29.404896, -90.554825, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")
        --3
        
        Setup079Button(Vector(609.624084, 1564.752441, -7084.987793), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(493.125916, 1654.806885, -6921.749023))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(52.574684, -40.897945, 0.00))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Tunnel Turret")

        local incends1 = {
            Vector(524.768677, 4397.352539, -6063.928711),
            Vector(262.404938, 4122.270996, -6076.985840),
            Vector(317.679993, 3550.330811, -6078.632324),
            Vector(290.380096, 2935.018799, -6078.746094),
            Vector(292.878113, 2343.869141, -6077.251465),
            Vector(-318.753815, 4175.437500, -6078.968750),
            Vector(-927.157532, 4135.440430, -6077.977051),
            Vector(-921.403015, 2326.104248, -6078.669434),
            Vector(-314.005646, 2322.904297, -6078.768066),
            Vector(-919.958923, 3552.527344, -6079.784180)
        }

        Setup079Button(Vector(310.089783, 3567.682373, -6077.507813), 55, function (btn, scp079)
            for k, v in pairs(incends1) do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(v)
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 6, "Activate Ring of Fire")

        local a = {
            {
                pos = Vector(341.531799, -1433.608154, -5637.208984),
                ang = Angle(49.852619, 131.127884, 0.00)
            },
            {
                pos = Vector(156.559479, -563.551636, -5643.214844),
                ang = Angle(46.559734, -115.250298, 0.00)
            }
        }

        Setup079Button(Vector(100.737984, -800.040527, -6035.545410), 90, function (btn, scp079)
            for k, v in pairs(a) do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(v.pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(v.ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Gate A Turrets")
		
		Setup079Button(Vector(-3840.809814, 4900.337402, -7261.602051), 25, function (btn, ply)
            ply:TakeDamage(100, game.GetWorld(), game.GetWorld())
            util.BlastDamage(ply, ply, Vector(-3840.809814, 4900.337402, -7261.602051), 225, 500)
        end, 600, "Trigger an explosion")

		Setup079Button(Vector(834.813660, 872.611572, -8117.790039), 30, function (btn, ply)
            timer.Create("FragGrenadeTimer_079", 1, 4, function ()
                local nade = ents.Create("tfa_csgo_thrownfrag")
                if IsValid(nade) then
                    nade:SetPos(Vector(834.813660, 872.611572, -8117.790039))
                    nade.Owner = ply
                    nade:Spawn()
                    nade:SetNoDraw(true)
                    nade:GetPhysicsObject():Wake()
                end
            end)
        end, 600, "Carpet Bombem")

        Setup079Button(Vector(-3834.437500, 4351.625977, -7109.065430), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(-3835.591797, 4895.348633, -7028.173828))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(35.420353, -88.638420, 0.0))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Defense Turret")
		Setup079Button(Vector(-1493.008911, 4849.858887, -7103.890137), 300, function (btn)
            local pl = table.Random(GetNotAFKSpecs())
            pl:SetSCP0082()
            pl:SetPos(Vector(-1493.008911, 4849.858887, -7113.890137))
        end, 1800, "Breach SCP-008")
		local ice_index = {
            [18] = Vector(-312.504364, 4510.425781, -6079.012207),
            [19] = Vector(-360.859161, 5410.644043, -6079.413574),
            [20] = Vector(439.491638, 5401.576172, -6078.189453),
			[21] = Vector(2734.969727, 1102.915649, -6077.170898),
            [22] = Vector(2114.759521, 1104.093872, -6077.009277),
            [23] = Vector(1491.257935, 1119.301270, -6077.566895),
        }
		Setup079Button(Vector(-360.859161, 5410.644043, -6079.413574), 55, function (btn, ply)
            for i = 18, 20 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(ice_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
		Setup079Button(Vector(2114.759521, 1104.093872, -6077.009277), 55, function (btn, ply)
            for i = 21, 23 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(ice_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
	elseif game.GetMap() == "br_area02_v3" then

        local g_index = {
            Vector(5895.480957, 312.617493, -63.501656),
            Vector(6315.560547, 318.047363, -127.878731),
            Vector(6872.021973, 304.706726, -126.991188),
            Vector(7201.220215, 710.991699, -126.976593),
            Vector(7561.095215, 305.265320, -128.195053),
            Vector(7179.802734, -58.745670, -127.868553),
            Vector(6942.232422, -509.762085, -128.616302),
            Vector(6949.778320,-1217.238892, -128.964264),
            Vector(6940.304199, 1028.064453, -128.069214),
            Vector(6946.141602, 1567.435059, -128.725113),
            Vector(6951.344238, 2041.704346, -127.395828),
            --12
            Vector(3734.343750, 827.785522, 57.135010),
            Vector(4289.122070, 305.756744, 55.477287),
            Vector(3698.728760, -196.139954, 55.234818),
            Vector(2952.216309, 63.936123, 55.972607),
            Vector(2170.432129, -181.258469, 56.885349),
            Vector(1592.715820, 325.980713, 56.387115),
            Vector(2197.071533, 824.482239, 56.159088),
            Vector(2943.190430, 581.534668, 56.944023),
        }

        Setup079Button(Vector(7134.318848, 283.672455, -81.990685), 60, function (btn, ply)
            for i = 1, 11 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")

        local t_index = {
            {
                ang = Angle(28.902594, 11.789015, 0.000000),
                pos = Vector(7253.659668, -701.648865, -20.944742)
            },
            {
                ang = Angle(28.205956, -149.539642, 0.000000),
                pos = Vector(8905.846680, -578.404968, -22.059999)
            },
            {
                pos =  Vector(9401.181641, -1597.546997, -135.971558),
                ang =  Angle(3.958830, -178.870316, 0.000000)
            },
            --4
            {
                pos = Vector(5303.899902, 1940.277344, 25.918806),
                ang = Angle(42.512005, 90.663445, 0.000000)
            },
            {
                pos = Vector(4628.647949, 2521.500488, 12.420966),
                ang = Angle(43.205860, -0.387125, 0.000000)
            },
            {
                pos = Vector(5321.356934, 3060.582520, -44.251850),
                ang = Angle(27.882395, -37.264122, 0.000000)
            },
            {
                pos = Vector(5743.813965, 2712.484619, 54.640461),
                ang = Angle(38.275871, 38.605583, 0.000000)
            },
			--8
			{
                pos = Vector(6629.583008, 5204.100586, -1155.151489),
                ang = Angle(9.521268, 3.321981, 0.000000)
            },
            {
                pos = Vector(6631.380859, 5164.100098, -1158.239990),
                ang = Angle(14.641539, -179.927017, 0.000000)
            },
            {
                pos = Vector(7537.334473, 4722.396973, -1095.893311),
                ang = Angle(38.203964, 47.581421, 0.000000)
            },
            {
                pos = Vector(8117.188477, 5337.986816, -1100.598999),
                ang = Angle(38.234837, -130.130020, 0.000000)
            }
            
        }

        Setup079Button(Vector(8669.041016, -649.981445, -128.712082), 90, function (btn, scp079)
            for i = 1, 2 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Hall Turrets")

        Setup079Button(Vector(2925.444336, 305.066803, 95.672058), 55, function (btn, scp079)
            for i = 12, 19 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(g_index[i])
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 4, "Firebomb")

        Setup079Button(Vector(5524.813965, 3072.655518, -128.968018), 90, function (btn, scp079)
            for i = 4, 7 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        Setup079Button(SPAWN_330, 90, function (btn, scp079)
            for _,v in pairs(ents.FindByClass("ent_scp330")) do
                local n_ct = {}
                for _, ply in pairs(player.GetAll()) do
                    n_ct[ply] = 2
                end
                v.CANDY_TAKERS = n_ct

                timer.Simple(30, function ()
                    v.CANDY_TAKERS = {}
                end)
            end
        end, 600, "Rig candy")

        Setup079Button(SPAWN_SCP_294, 60, function (btn, ply)
            IS_294_POISONED = true

            timer.Simple(30, function ()
                IS_294_POISONED = false
            end)
        end, 600, "Poison SCP-294")

        Setup079Button(Vector(3380.799805, 3763.809570, -1215.995728), 300, function (btn)
            local ply = table.Random(GetNotAFKSpecs())
            if not ply then return end
            ply:SetSCP939()
            ply:SetPos(SPAWN_939)
            ply:SetHealth(ply:Health() / 2)
        end, 1800, "Breach SCP-939")

        Setup079Button(Vector(-2909.959229, -2150.770508, 359.056885), 360, function (btn)
            for i = 1, 3 do
                local ply = table.Random(GetNotAFKSpecs()) --Once a assign a player to SH, they are no longer a spec, thus not in this table
                if IsValid(ply) then
                    ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
                end
            end
        end, 600 * 6, "Spawn SH Squad")

        local mining_gases = {
            Vector(-2909.959229, -2150.770508, 359.056885),
            Vector(3919.225098, 3454.486816, -1216.942627),
            Vector(4153.278320, 3816.288574, -1215.058716),
            Vector(3914.467773, 4150.631348, -1216.846313),
            Vector(4369.760254, 4425.026367, -1215.028931),
            Vector(4716.235352, 4663.490234, -1215.754639),
			Vector(5174.033203, 4444.494629, -1216.761719)
        }

        Setup079Button(Vector(4366.410156, 4536.752930, -1215.673096), 70, function (btn)
            for k,v in pairs(mining_gases) do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(v)
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 6, "Gas Leak")
		
		local r_index = {
            [1] = Vector(3642.798340, 1804.467651, -1438.974365),
            [2] = Vector(4812.970703, 1670.539307, -1440.609009),
            [3] = Vector(3835.692139, 1008.008606, -1440.955444),
			[4] = Vector(7813.312988, 3928.751221, -1216.781616),
            [5] = Vector(7812.512695, 4349.326660, -1216.908569)
        }

        Setup079Button(Vector(4048.560547, 1869.565063, -1440.084473), 360, function (btn, ply)
            for i = 1, 3 do
                local mine = ents.Create("npc_rollermine")
                if IsValid(mine) then
                    mine:SetPos(r_index[i])
                    mine:Spawn()
                end
            end
        end, 600, "Release Rollermines")
		
		Setup079Button(Vector(7812.512695, 4349.326660, -1216.908569), 360, function (btn, ply)
            for i = 4, 5 do
                local mine = ents.Create("npc_rollermine")
                if IsValid(mine) then
                    mine:SetPos(r_index[i])
                    mine:Spawn()
                end
            end
        end, 600, "Release Rollermines")
		
        Setup079Button(Vector(7085.362305, 5239.622070, -1215.310547), 90, function (btn, scp079)
            for i = 8, 11 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(t_index[i].ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Spawn Turrets")

        local incends1 = {
            Vector(3652.196533, 2682.313965, -1311.575806),
            Vector(3241.604736, 2593.690430, -1311.292847),
            Vector(2693.772217, 2633.410889, -1311.286377),
            Vector(1978.745605, 2614.743164, -1311.119019),
            Vector(2161.834229, 2179.493408, -1311.316650),
            Vector(1877.004639, 1880.446533, -1312.755737),
            Vector(2170.613281, 1609.796265, -1310.969604)
        }

        Setup079Button(Vector(2313.138428, 2625.238037, -1311.170288), 55, function (btn, scp079)
            for k, v in pairs(incends1) do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(v)
                    incen.Owner = scp079
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 6, "Fire")

        local a = {
            {
                pos = Vector(-440.515961, 325.632721, 429.962341),
                ang = Angle(46.460083, -0.985802, 0.000000)
            },
            {
                pos = Vector(924.203247, 321.315399, 186.688217),
                ang = Angle(29.205299, -178.717361, 0.000000)
            }
        }

        Setup079Button(Vector(271.010345, 325.516541, 64.030190), 90, function (btn, scp079)
            for k, v in pairs(a) do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(v.pos)
                    turret:SetKeyValue("spawnflags", "32")
                    turret:SetAngles(v.ang)
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(scp079, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600 * 6, "Gate A Turrets")
		
		Setup079Button(Vector(7806.854980, 4010.451172, -1216.117554), 25, function (btn, ply)
            ply:TakeDamage(100, game.GetWorld(), game.GetWorld())
            util.BlastDamage(ply, ply, Vector(7806.854980, 4010.451172, -1216.117554), 225, 500)
        end, 600, "Trigger an explosion")

		Setup079Button(Vector(6694.420410, -857.662354, -128.036667), 30, function (btn, ply)
            timer.Create("FragGrenadeTimer_079", 1, 4, function ()
                local nade = ents.Create("tfa_csgo_thrownfrag")
                if IsValid(nade) then
                    nade:SetPos(Vector(6694.420410, -857.662354, -128.036667))
                    nade.Owner = ply
                    nade:Spawn()
                    nade:SetNoDraw(true)
                    nade:GetPhysicsObject():Wake()
                end
            end)
        end, 600, "Carpet Bombem")

        Setup079Button(Vector(9059.525391, -1596.084839, -126.982117), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(Vector(9381.167969, -1603.662842, 18.781988))
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(Angle(31.166433, -179.519699, 0.000000))
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turret")
		
		Setup079Button(Vector(5670.225098, 1263.573486, -1423.436768), 300, function (btn)
            local pl = table.Random(GetNotAFKSpecs())
            pl:SetSCP0082()
            pl:SetPos(Vector(5528.157227, 1282.087524, -1600.638550))
        end, 1800, "Breach SCP-008")
		local ice_index = {
            [18] = Vector(6522.436035, 2235.315430, -1216.768188),
            [19] = Vector(6530.503906, 868.417053, -1215.947510),
            [20] = Vector(6890.477539, -169.644409, -1215.660034),
			[21] = Vector(8449.387695, 4735.206055, -1215.646484),
            [22] = Vector(8858.677734, 4740.497559, -1215.575195),
            [23] = Vector(8853.504883, 5508.548828, -1216.801514)
        }
		Setup079Button(Vector(6530.503906, 868.417053, -1215.947510), 55, function (btn, ply)
            for i = 18, 20 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(ice_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
		Setup079Button(Vector(8858.677734, 4740.497559, -1215.575195), 55, function (btn, ply)
            for i = 21, 23 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(ice_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
	elseif game.GetMap() == "br_area96" then

        local t_index = {
            [1] = {
                pos = Vector(-4222.714844, 950.244263, 237.144150),
                ang = Angle(46.067532, 50.215839, 0.000000)
            },
            [2] = {
                pos = Vector(-3917.207520, 1264.991333, 240.163483),
                ang = Angle(38.148590, -133.549515, 0.000000)
            },
            [3] = {
                pos = Vector(-3769.744141, -1939.877930, 138.729889),
                ang = Angle(23.582790, 178.287262, 0.000000)
            },
            [4] = {
                pos = Vector(4268.340332, 504.182312, 127.968750),
                ang = Angle(0, -160, 0)
            },
            [5] = {
                pos = Vector(2313.872314, -1489.389648, 160.646423),
                ang = Angle(35.355312, -179.563644, 0.000000)
            },
            [6] = {
                pos = Vector(2711.950439, -1103.977173, 157.829193),
                ang = Angle(30.764589, 89.213150, 0.000000)
            },
            [7] = {
                pos = Vector(3113.002686, -1490.019409, 159.858276),
                ang = Angle(30.937321, 1.147321, 0.000000)
            },
            [8] = {
                pos = Vector(2699.100342, -1864.569336, 168.082458),
                ang = Angle(36.380939, -91.266205, 0.000000)
            },
            [9] = {
                pos = Vector(3765.636719, 1086.318970, 133.193237),
                ang = Angle(34.210331, -179.982285, 0.000000)
            },
            [10] = {
                pos = Vector(3419.138428, 2326.882568, 390.822937),
                ang = Angle(69.983505, 127.238411, 0.000000)
            },
            [11] = {
                pos = Vector(3950.005859, 2717.463135, 138.710464),
                ang = Angle(35.508274, -37.052856, 0.000000)
            },
            [12] = {
                pos = Vector(6145.988770, 2291.384766, 250.602417),
                ang = Angle(37.546936, 90.475967, 0.000000)
            }
        }

        local g_index = {
            [1] = Vector(-2264.467529, -176.750549, 80.735451),
            [2] = Vector(-1937.800049, -175.476852, 95.354721),
            [3] = Vector(-1704.048218, -175.380615, 77.202599),
            [4] = Vector(635.157532, -1295.571533, 48.755192),
            [5] = Vector(628.450073, -1461.939819, 56.854511),
            [6] = Vector(679.686829, -1663.247192, 53.255875),
            [7] = Vector(575.961670, -1681.868652, 59.096874),
            [8] = Vector(59.387680, -166.090454, 87.008820),
            [9] = Vector(1392.490845, -168.492249, 85.121559),
            [10] = Vector(2042.953857, -4087.589600, 82.044731),
            [11] = Vector(1364.258423, -4106.082520, 81.886742),
            [12] = Vector(618.561707, -4096.368652, 83.582527),
            [13] = Vector(33.427212, -4095.101074, 82.272636),
            [14] = Vector(2692.332764, -4078.364990, 81.675674),
            [15] = Vector(4014.689941, -3447.120361, 81.652786),
            [16] = Vector(4023.180664, -4112.597656, 83.221298),
            [17] = Vector(4715.926758, -4107.252441, 81.964600),
			[18] = Vector(-1406.617065, -2783.803955, 82.227776),
            [19] = Vector(-540.300354, -2780.257080, 82.078331),
            [20] = Vector(37.311005, -2777.891846, 82.460861)
        }

        Setup079Button(Vector(-4176.921875, 1026.019897, 90.095016), 25, function (btn, ply)
            ply:TakeDamage(100, game.GetWorld(), game.GetWorld())
            util.BlastDamage(ply, ply, Vector(-4176.921875, 1026.019897, 90.095016), 225, 500)
        end, 600, "Trigger an explosion")

        Setup079Button(Vector(-3657.984619, -186.098450, 84.898949), 30, function (btn, ply)
            local incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(-3657.984619, -186.098450, 84.898949))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Burst the gas pipe")

        Setup079Button(Vector(-3956.297363, 1212.634521, 96.349869), 90, function (btn, ply)
            for i = 1, 2 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetAngles(t_index[i].ang)
                    turret:SetKeyValue("spawnflags", "32")
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 999)
                        else
                            turret:AddEntityRelationship(v, D_HT, 999)
                        end
                    end
                    turret:AddEntityRelationship(ply, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600, "Activate defense turrets")

        Setup079Button(Vector(-1937.800049, -175.476852, 95.354721), 65, function (btn, ply)
            for i = 1, 3 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600, "Release gas into the hall")

        Setup079Button(Vector(-3845.616455, -1944.194946, 78.915634), 90, function (btn, ply)
            local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                turret:SetPos(t_index[3].pos)
                turret:SetAngles(t_index[3].ang)
                turret:SetKeyValue("spawnflags", "32")
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(ply, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600, "Activate turret")

        Setup079Button(Vector(-4145.420410, -1164.069946, -44.115997), 30, function (btn, ply)
            local incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(-4145.420410, -1164.069946, -44.115997))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end

            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(-4733.214355, -1144.024902, 84.614151))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Fire")

        Setup079Button(Vector(-3648.706055, 1513.601318, 84.648483), 30, function (btn, ply)
            timer.Create("FragGrenadeTimer_079", 1, 4, function ()
                local nade = ents.Create("tfa_csgo_thrownfrag")
                if IsValid(nade) then
                    nade:SetPos(Vector(-3648.706055, 1513.601318, 84.648483))
                    nade.Owner = ply
                    nade:Spawn()
                    nade:SetNoDraw(true)
                    nade:GetPhysicsObject():Wake()
                end
            end)
        end, 600, "Stop anyone near SCP-1162 for good")

        Setup079Button(Vector(-1858.470093, -1415.974609, 83.769684), 25, function (btn, ply)
            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(-1858.470093, -1415.974609, 83.769684))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end

        end, 600, "Burst fuel line")

        Setup079Button(Vector(900.886414, -171.733292, 85.435211), 55, function (btn, ply)
            for i = 8, 9 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600, "Gas")

        Setup079Button(Vector(2685.681396, -1472.135620, 95.253838), 90, function (btn, ply)
            for i = 5, 8 do
                local turret = ents.Create("npc_turret_ceiling")
                if IsValid(turret) then
                    turret:SetPos(t_index[i].pos)
                    turret:SetAngles(t_index[i].ang)
                    turret:SetKeyValue("spawnflags", "32")
                    for k,v in pairs(player.GetAll()) do
                        if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                            turret:AddEntityRelationship(v, D_FR, 888)
                        else
                            turret:AddEntityRelationship(v, D_HT, 888)
                        end
                    end
                    turret:AddEntityRelationship(ply, D_FR, 999)
                    timer.Simple(60, function ()
                        if turret and IsValid(turret) then
                            turret:Remove()
                        end
                    end)
                    turret:Spawn()
                end
            end
        end, 600, "Activate Turret Security")

        local r_index = {
            [1] = Vector(42.813980, -4080.540039, 83.463753),
            [2] = Vector(45.425053, -5434.478027, 82.126137),
            [3] = Vector(-1273.370850, -5414.445801, 82.586494)
        }

        Setup079Button(Vector(45.425053, -5434.478027, 82.126137), 360, function (btn, ply)
            for i = 1, 3 do
                local mine = ents.Create("npc_rollermine")
                if IsValid(mine) then
                    mine:SetPos(r_index[i])
                    mine:Spawn()
                end
            end
        end, 600, "Summon rollermines")

        Setup079Button(Vector(2694.280029, -2782.068604, 81.648903), 35, function (btn, ply)
            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(2694.280029, -2782.068604, 81.648903))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Drop firenade")

        Setup079Button(Vector(4043.781738, -1479.338989, 82.631836), 35, function (btn, ply)
            incen = ents.Create("tfa_csgo_thrownincen")
            if IsValid(incen) then
                incen:SetPos(Vector(4043.781738, -1479.338989, 82.631836))
                incen.Owner = ply
                incen:Spawn()
                incen:SetNoDraw(true)
                incen:GetPhysicsObject():Wake()
            end
        end, 600, "Drop firenade")

        Setup079Button(Vector(2468.944580, 3839.347412, -190.276581), 60, function (btn, ply)
            IS_294_POISONED = true

            timer.Simple(30, function ()
                IS_294_POISONED = false
            end)
        end, 600, "Poison SCP-294")

        Setup079Button(Vector(3745.539795, 1080.389160, 81.080589), 90, function (btn, ply)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[9].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[9].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(ply, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600, "Spawn turret")

        Setup079Button(Vector(3631.909424, 911.220459, 78.737442), 90, function (btn, scp079)
            for _,v in pairs(ents.FindByClass("ent_scp330")) do
                local n_ct = {}
                for _, ply in pairs(player.GetAll()) do
                    n_ct[ply] = 2
                end
                v.CANDY_TAKERS = n_ct

                timer.Simple(30, function ()
                    v.CANDY_TAKERS = {}
                end)
            end
        end, 600, "Rig candy")

        Setup079Button(Vector(3297.921875, 2485.052490, -147.562958), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[10].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[10].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600, "Spawn Turret")

        Setup079Button(Vector(4097.230957, 2579.065430, 84.314476), 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_ceiling")
            if IsValid(turret) then
                turret:SetPos(t_index[11].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[11].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn Turret")

        Setup079Button(t_index[12].pos, 90, function (btn, scp079)
            local turret = ents.Create("npc_turret_floor")
            if IsValid(turret) then
                turret:SetPos(t_index[12].pos)
                turret:SetKeyValue("spawnflags", "32")
                turret:SetAngles(t_index[12].ang)
                for k,v in pairs(player.GetAll()) do
                    if v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC then
                        turret:AddEntityRelationship(v, D_FR, 888)
                    else
                        turret:AddEntityRelationship(v, D_HT, 888)
                    end
                end
                turret:AddEntityRelationship(scp079, D_FR, 999)
                timer.Simple(60, function ()
                    if turret and IsValid(turret) then
                        turret:Remove()
                    end
                end)
                turret:Spawn()
            end
        end, 600 * 6, "Spawn CampTurret9000")

        local n_index = {
            Vector(4034.918457, 2178.549316, 83.030457),
            Vector(4053.914795, 1819.961914, 82.989197),
            Vector(4047.398438, 1471.600952, 83.938789),
            Vector(4045.262939, 1100.112671, 83.864456),
            Vector(4040.923096, 382.163971, 82.752586),
            Vector(-316.544220, -6747.685547, 81.687477),
            Vector(-1275.917236, -6752.540039, 81.643501),
            Vector(-1270.002563, -6034.015625, 82.599655),
            Vector(1684.358643, 2359.970459, -173.573669),
            Vector(2228.814697, 2350.768555, -171.980515),
            Vector(2898.698975, 2361.178223, -171.968826),
            Vector(3357.634033, 3157.849609, -45.863251),
            Vector(4026.215820, -2776.666260, 82.921799)
        }
        Setup079Button(n_index[3], 45, function (btn, ply)
            for i = 1, 5 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[i])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 6, "Drop firenade")

        --SetSerpentsHand
        Setup079Button(Vector(7444.256348, 782.632507, 144.334747), 360, function (btn)
            for i = 1, 3 do
                local ply = table.Random(GetNotAFKSpecs()) --Once a assign a player to SH, they are no longer a spec, thus not in this table
                if IsValid(ply) then
                    ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
                end
            end
        end, 600 * 6, "Spawn SH Squad")

        Setup079Button(Vector(3296.197998, -4089.526367, 82.126160), 300, function (btn)
            local furry = table.Random(GetNotAFKSpecs())
            furry:SetSCP939()
            furry:SetPos(Vector(3296.197998, -4089.526367, 70.126160))
            furry:SetHealth(furry:Health() / 2)
        end, 1800, "Breach SCP-939")
		
		Setup079Button(Vector(5444.381836, -2945.768311, 76.454720), 300, function (btn)
            local p = table.Random(GetNotAFKSpecs())
            p:SetSCP0082()
            p:SetPos(Vector(5291.502930, -2869.523193, 71.749550))
        end, 1800, "Breach SCP-008")
        --Activte SCP-001? Sun thing
        print("Finished spawning scp079 buttons")

        Setup079Button(n_index[8], 45, function (btn, ply)
            for i = 6, 8 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[i])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 3, "Drop firenade")

        Setup079Button(n_index[9], 45, function (btn, ply)
            for i = 9, 12 do
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[i])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
            end
        end, 600 * 3, "Drop firenade")

        Setup079Button(n_index[13], 45, function (btn, ply)
                incen = ents.Create("tfa_csgo_thrownincen")
                if IsValid(incen) then
                    incen:SetPos(n_index[13])
                    incen.Owner = ply
                    incen:Spawn()
                    incen:SetNoDraw(true)
                    incen:GetPhysicsObject():Wake()
                end
        end, 600 * 6, "Drop firenade")

        Setup079Button(g_index[12], 55, function (btn, ply)
            for i = 10, 14 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")

        Setup079Button(g_index[16], 55, function (btn, ply)
            for i = 15, 17 do
                local gas = ents.Create("ent_scp079_gas")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Gas")
		Setup079Button(g_index[19], 55, function (btn, ply)
            for i = 18, 20 do
                local gas = ents.Create("ent_scp079_009")
                if IsValid(gas) then
                    gas:SetPos(g_index[i])
                    gas.Owner = ply
                    gas:Spawn()
                end
            end
        end, 600 * 2, "Breach SCP-009")
    end
end

hook.Add("PostCleanupMap", "Postcleanupworld_SCP079", SpawnSCP079Buttons)