util.AddNetworkString("SCP294_RequestDrinkSpawn")
util.AddNetworkString("BREACH_294_DRUNK")

net.Receive("SCP294_RequestDrinkSpawn", function (length, ply)
    local drink = net.ReadString()

    if ply and IsValid(ply) then
        if ply:Team() == TEAM_SPEC then
            ServerLog(string.format("%s (%s) tried to spawn a drink from scp294 while dead.\n", ply:Nick(), ply:SteamID64()))
            return
        end

        --The original addon requires that we trust the player to provide the correct 294 entity, we don't.
        local canidates = ents.FindInSphere(ply:GetPos(), 200)

        local scp294 = nil

        for k,v in pairs(canidates) do
            if v and IsValid(v) and v:GetClass() == "scp294" then
                scp294 = v
                break
            end
        end

        if not scp294 or not IsValid(scp294) then
            return
        end

        if scp294.NextCupSpawn and scp294.NextCupSpawn > CurTime() then
            scp294:EmitSound("scp294/outofrange.ogg")
            return
        end

        if not DRINKINDEX[drink] then
            scp294:EmitSound("scp294/outofrange.ogg")
            return
        end

        if DRINKINDEX[drink].RestrictPlayerSpawn then
            scp294:EmitSound("scp294/outofrange.ogg")
            return
        end


        local scp294_angles = scp294:GetAngles()
        local cup_pos = scp294:GetPos() + scp294_angles:Right() * 9 + scp294_angles:Up() * 32 + scp294_angles:Forward() * 13

        local cup = ents.Create( "scp294cup" )
        if cup and IsValid(cup) then
            cup:SetPos(cup_pos)
            cup:Spawn()

            scp294.NextCupSpawn = CurTime() + 10

            if IS_294_POISONED then
                if not DRINKINDEX["poison"] then
                    ServerLog("No such drink 'poison'! SCP-079's poison ability is not functioning correctly!\n")
                    cup:SetDrink(drink)
                    hook.Run("Breach_SCP294Use", drink, drink)
                    return
                end
                cup:SetDrink("poison")
                hook.Run("Breach_SCP294Use", drink, "poison")
            else
                cup:SetDrink(drink)
                hook.Run("Breach_SCP294Use", drink, drink)
            end
        end
    end
end)


DRINKINDEX = {}

local files, _ = file.Find("scp294drinks/*.lua", "LUA" )
local OLD_DRINK = DRINK
for _, v in pairs(files) do
	local path = "scp294drinks/" .. v
    if string.Right(v, 3) == "lua" then
        DRINK = {}
        include( path )
        print("scp294: register drink " .. DRINK.id)
        DRINKINDEX[DRINK.id] = DRINK
        if DRINK.Alias then
            for _, alias in pairs(DRINK.Alias) do
                print("scp294: alias " .. alias .. " to " .. DRINK.id)
                DRINKINDEX[alias] = DRINK
            end
        end
	end
end
DRINK = OLD_DRINK

hook.Add("SCP294_ConsumeDrink", "SCP294_ConsumeDrink_Logging", function (drink, ply)
    print(string.format("scp294: %s (%s) drank %s", ply:Nick(), ply:SteamID64(), drink.id))
end)