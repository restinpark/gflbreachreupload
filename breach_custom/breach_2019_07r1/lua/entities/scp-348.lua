AddCSLuaFile()
ENT.PrintName = "SCP-348"
ENT.Author = "Aurora"
ENT.Type = "anim"

if SERVER then
    resource.AddWorkshop("184325061")
end

function ENT:Initialize()
    if SPAWNS_348 and istable(SPAWNS_348) then
        local pos = table.Random(SPAWNS_348)
        self:SetPos(pos)
    else
        SafeRemoveEntity(self)
        return
    end

    self:SetModel(Model("models/arskvshborsch/borsch.mdl"))
    self:PhysicsInit( SOLID_VPHYSICS )
    self:PhysWake()

end

local TATTLES = {}
--func should return a string that the soup will say to the user, takes the user as the argument
function SCP348_AddTattle(func)
    TATTLES[#TATTLES + 1] = func
end

hook.Add("InitPostEntity", "IPE_SCP348", function ()
    --Gives addons a chance to add their own tattles
    hook.Run("SCP348_TattleHook")
end)

--The fallback tattle tells you who the nearest player to you is

local function NPlayerTattle(ply)
    local lplay
    for k,v in pairs(player.GetAll()) do
        if v ~= ply and (not lplay or lplay:GetPos():Distance(ply:GetPos()) > v:GetPos():Distance(ply:GetPos())) then
            lplay = v
        end
    end

    if lplay and IsValid(lplay) then
        return lplay:Nick() .. " is the closest player to you. (" .. tostring(lplay:GetPos():Distance(ply:GetPos())) .. ")"
    else
        return "error 1"
    end
end

SCP348_AddTattle(function (ply)
    local scps = team.GetPlayers(TEAM_SCP)
    if table.Count(scps) < 1 then
        return NPlayerTattle(ply)
    end

    local c = table.Random(scps)

    return (IsValid(c) and c:Nick() or "INVALID PLAYER") .. " is " .. (IsValid(c) and c:GetNClass() or "INVALID CLASS")
end)

SCP348_AddTattle(NPlayerTattle)

function ENT:Use(a, ply)
    if ply:Team() ~= TEAM_SCP and ply:Team() ~= TEAM_SPEC and SERVER then
        ply:SetHealth(math.Clamp(ply:Health() + 50, 1, ply:GetMaxHealth()))
        ply:PrintMessage(3, "The soup says: " .. table.Random(TATTLES)(ply))
        SafeRemoveEntity(self)
        return
    end
end