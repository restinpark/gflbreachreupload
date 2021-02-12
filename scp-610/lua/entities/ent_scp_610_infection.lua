AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "SCP-610 Infection Point"
ENT.Spawnable = false
ENT.State = false
Model("models/next/nest.mdl")
ENT.Health = 1200
ENT.NextActivation = nil
function ENT:Initialize()
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
    self:SetModel(Model("models/nest/nest.mdl"))
    self:PhysicsInit(SOLID_VPHYSICS)
end

function ENT:SetState(bool)
    self.State = bool
    self:StateUpdated(bool)
end

function ENT:StateUpdated(b)
    if b then
        self.NextActivation = CurTime() + 5
    else
        self.NextActivation = nil
    end
end

function ENT:Think()
    if self.NextActivation and CurTime() > self.NextActivation and SERVER then
        self.NextActivation = CurTime() + 5
        local ed = EffectData()
        ed:SetOrigin(self:GetPos())
        ed:SetRadius(300)
        ed:SetEntity(self)
        util.Effect("AntlionGib", ed , false, true)
	self:EmitSound(Sound("weapons/bugbait/bugbait_squeeze2.wav"), 100, 100, 1, CHAN_AUTO)
        local aoe = ents.FindInSphere(self:GetPos(), 300)
        for k,v in pairs(aoe) do
            local infchance = math.random(1,5) == 3
            local allowed = true
            if v.UsingArmor and v.UsingArmor == "armor_hazmat" and infchance then
                allowed = false
            end
            if math.random(1, 10) == 1 and IsValid(v) and v:IsPlayer() and v:Team() ~= TEAM_SCP and v:Team() ~= TEAM_SPEC and not v:GetNWBool("SCP610_Infect", false) and allowed then
                v:SetNWBool("SCP610_Infect", true)
                local tid = tostring(v:SteamID64()) .. "_SCP610Convert_" .. tostring(math.random(1, 10000))
                timer.Create(tid, math.random(45, 70), 1, function ()
                    if v and IsValid(v) and v:IsPlayer() and v:GetNWBool("SCP610_Infect", false) then
                        v:SetSCP610B()
                        v:SetNWBool("SCP610_Infect", false)

                        --Prevent crack / cocaine zombies
                        v.BR_HasSpeedBoost = false
                    end
                end)
                SCP_610_TIMERS[#SCP_610_TIMERS + 1] = tid
            end
        end
    end
end
