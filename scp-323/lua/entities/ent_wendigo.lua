AddCSLuaFile()

ENT.PrintName = "Wendigo's Skull"
ENT.Author = "Aurora"
ENT.Type = "anim"

function ENT:Initialize()
    self:SetModel("models/props_2fort/bullskull001.mdl")
    self:SetAngles(Angle(-89.709, 2.873, 108.232))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:PhysWake()
    if SERVER then
        self:SetTrigger(true)
    end
    self.ActiveIn = CurTime() + 3
end

function ENT:Touch(touching)
    if SERVER and self.ActiveIn < CurTime() and touching and IsValid(touching) and touching:IsPlayer() and touching:Team() ~= TEAM_SPEC and touching:Team() ~= TEAM_SCP then
        local p = touching:GetPos()
        self.ActiveIn = CurTime() + 999
        if self.Owner and IsValid(self.Owner) then
            self.Owner:SetSCP323()
            if self.Owner:HasWeapon("weapon_scp323") then
                self.Owner:GetWeapon("weapon_scp323"):SetNWInt("NextStarvation", CurTime() + 120)
            end
            net.Start("RolesSelected")
            net.Send(self.Owner)
            self.Owner:SetPos(p)
            SafeRemoveEntityDelayed(self, 0.1)
            if IsValid(touching) then
                touching:TakeDamage(10000, self, self.Owner)
            end
        end
    end
end
if SERVER then
    function ENT:Think()
        local affected = ents.FindInSphere(self:GetPos(), 175)
        for k,v in pairs(affected) do
            if v:IsPlayer() and v:Team() ~= TEAM_SCP and v:Team() ~= TEAM_SPEC then
                v:SetEyeAngles((self:GetPos() - v:GetShootPos()):Angle())
            end
        end
    end
end