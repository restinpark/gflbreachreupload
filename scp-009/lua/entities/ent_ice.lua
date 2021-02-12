AddCSLuaFile()

ENT.PrintName = "SCP-009"
ENT.Author = "chan_man1"
ENT.Type = "anim"

function ENT:Initialize()
    self:SetModel("models/Gibs/wood_gib01a.mdl")
	self:SetMaterial( "models/weapons/v_crowbar/crowbar_cyl", false )
	self:PhysicsInit(SOLID_VPHYSICS)
    self:PhysWake()
    if SERVER then
        self:SetTrigger(true)
    end
    self.ActiveIn = CurTime() + 3
end

function ENT:Touch(touching)
    if SERVER and self.ActiveIn < CurTime() and touching and IsValid(touching) and touching:IsPlayer() and touching:Team() ~= TEAM_SPEC and touching:Team() ~= TEAM_SCP then
	if touching:GetNClass() == ROLE_SCP990 then return end
	if touching:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
        local p = touching:GetPos()
        self.ActiveIn = CurTime() + 999
            if IsValid(touching) then
                touching:SetNWString("009", "grow")
        end
    end
end
