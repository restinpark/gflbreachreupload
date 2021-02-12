local SCP020_MODEL = "models/konnie/kidjason/kidjason.mdl"
local ROLE_SCP020 = "SCP-020"

resource.AddWorkshop("1295498985")

local function get_scp_020_count()
    local i_scp020instances = 0
    for k,v in pairs(player.GetAll()) do
        if v:GetNClass() == ROLE_SCP020 then
            i_scp020instances = i_scp020instances + 1
        end
    end
    return i_scp020instances
end

local meta = FindMetaTable("Player")

function meta:SetSCP020()
    self:SetBleeding(false)
    self.handsmodel = nil
    self:UnSpectate()
    self:GodDisable()
    hook.Run("ResetPlayerBattery", self)
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    self:SetTeam(TEAM_SCP)
    self:SetNClass(ROLE_SCP020)
    self:SetModel(SCP020_MODEL)
    self:SetHealth(100)
    self:SetMaxHealth(100)
    self:SetArmor(0)
    self:SetWalkSpeed(240)
    self:SetRunSpeed(120)
    self:SetMaxSpeed(240)
    self:SetJumpPower(200)
    self:SetNoDraw(false)
    self:SetNoCollideWithTeammates(true)
    self.Active = true
    self:SetupHands()
    self.canblink = false
    self:AllowFlashlight( false )
    self.WasTeam = TEAM_SCP
    self:SetNoTarget( true )
    self.BaseStats = nil
    self.UsingArmor = nil
    net.Start("RolesSelected")
    net.Send(self)

    self:SetNWBool("SCP020_HasSCP020", false)
    self:SetNWFloat("SCP020_InfStart", CurTime() + 99999999)
    self:SetNWFloat("SCP020_TurnTime", CurTime() + 99999999)
end

timer.Create("SCP020_Tick", 1, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v and IsValid(v) and (v:GetNClass() == ROLE_SCP020 or (v:GetNWFloat("SCP020_InfStart", CurTime() + 120) < CurTime() and v:GetNWBool("SCP020_HasSCP020", false)))  then
            local nearby = ents.FindInSphere(v:GetPos(), 180)
            for _, ply in pairs(nearby) do
                if ply and IsValid(ply) and ply:IsPlayer() and ply:Team() ~= TEAM_SCP and ply:Team() ~= TEAM_SPEC and ply ~= v and math.random(1, 10) == 5 and not (ply.UsingArmor and ply.UsingArmor == "armor_hazmat") and not ply:GetNWBool("SCP020_HasSCP020", false) then
                    ply:SetNWBool("SCP020_HasSCP020", true)
                    ply:SetNWFloat("SCP020_InfStart", CurTime() + 30)
                    --If there is already an 020 instance, then we want a little bit shorter infection time than regular
                    local timesec = (get_scp_020_count() > 0 and 180 or 240)
                    ply:SetNWFloat("SCP020_TurnTime", CurTime() + timesec)
                    ply:SetNWBool("SCP020_CanCure", true)
                    timer.Simple(timesec, function ()
                        if ply and IsValid(ply) then
                            ply.is_reinforcement = true
                        end
                    end)
                end
            end
        end
    end
end)

--Prevent SCP-020 states from persisting between rounds
local function ResetAllSCP020Vars()
    print("scp020.lua: Clearing scp020 state")
    for k,v in pairs(player.GetAll()) do
        v:SetNWBool("SCP020_HasSCP020", false)
        v:SetNWFloat("SCP020_InfStart", CurTime() + 99999999) --Probably wont be reached in normal play
        v:SetNWFloat("SCP020_TurnTime", CurTime() + 99999999)
        v:SetNWBool("SCP020_CanCure", true)
    end
end

hook.Add("BreachEndRound", "BreachEndRound_SCP020", ResetAllSCP020Vars)
--BreachStartRound is called too late, so the only hook that is called earlier in round init is this.
hook.Add("PostCleanupMap", "PostCleanupMap_SCP020", ResetAllSCP020Vars)

--20% chance of scp020 being given to a random MTF guard
local function PickInitialSCP020()
    if math.random(1, 5) == 5 and ((roundtype and roundtype == normalround) or (ROUNDFLAGS and ROUNDFLAGS["SCP020_ENABLED"])) then
        print("scp020.lua: executing round code")
        local choice = table.Random(team.GetPlayers(TEAM_GUARD))
        if choice and IsValid(choice) then
            choice:SetNWBool("SCP020_HasSCP020", true)
            choice:SetNWFloat("SCP020_InfStart", CurTime() + 120)
            choice:SetNWFloat("SCP020_TurnTime", CurTime() + 300)
            choice:SetNWBool("SCP020_CanCure", false)
            choice.WINS_WITH = {[TEAM_SCP] = true}
            choice.is_reinforcement = false
            print("scp020.lua: setup scp020, choice = " .. choice:Nick())
        end
    end
end

hook.Add("BreachStartRound", "BreachStartRound_SetupSCP020", PickInitialSCP020)

--Remove stuff on death
local function OnPlayerDeath(ply)
    if ply and IsValid(ply) then
        ply:SetNWBool("SCP020_HasSCP020", false)
        ply:SetNWFloat("SCP020_InfStart", CurTime() + 99999999)
        ply:SetNWFloat("SCP020_TurnTime", CurTime() + 99999999)
        ply:SetNWBool("SCP020_CanCure", true)
    end
end

hook.Add("PlayerDeath", "PlayerDeath_SCP020", OnPlayerDeath)

--Handle when an scp-020 should turn
timer.Create("SCP020_ShouldTurn", 1, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:GetNWBool("SCP020_HasSCP020", false) and CurTime() > v:GetNWFloat("SCP020_TurnTime", CurTime() + 999) and v:GetNClass() ~= ROLE_SCP020 then
            v:SetSCP020()
            print("scp020.lua: SCP020_TurnTime has expired for " .. v:Nick())
        end
    end
end)

hook.Add("SCP348_TattleHook", "SCP020_AddTattle", function ()
    SCP348_AddTattle(function (ply)
        for k,v in pairs(player.GetAll()) do
            if v:GetNClass() == ROLE_SCP020 or v:GetNWBool("SCP020_HasSCP020", false) then
                return "SCP-020 is present in the current round."
            end
        end
        return "SCP-020 is not active this round."
    end)

    SCP348_AddTattle(function (ply)
        local pick = table.Random(GetActivePlayers())
        if pick and IsValid(pick) then
            local is_scp020 = pick:GetNClass() == ROLE_SCP020 or pick:GetNWBool("SCP020_HasSCP020", false)
            if is_scp020 then
                return pick:Nick() .. " is infected with SCP-020."
            else
                return pick:Nick() .. " is not infected with SCP-020."
            end
        else
            return "error 2"
        end
    end)
end)