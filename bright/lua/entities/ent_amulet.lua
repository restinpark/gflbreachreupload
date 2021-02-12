AddCSLuaFile()

ENT.PrintName = "Bright's Amulet"
ENT.Author = "chan_man1"
ENT.Type = "anim"

function ENT:Initialize()
    self:SetModel("models/props_c17/SuitCase001a.mdl")
	self:SetMaterial( "models/props_canal/canal_bridge_railing_01b", false )
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
        if self.Owner and IsValid(self.Owner) then
            self.Owner:SetBright()
            net.Start("RolesSelected")
            net.Send(self.Owner)
            self.Owner:SetPos(p)
            SafeRemoveEntityDelayed(self, 0.1)
		if self.Owner.GiveAchievement then
			self.Owner:GiveAchievement("Bright")
			end
            if IsValid(touching) then
                touching:TakeDamage(10000, self, self.Owner)
            end
        end
    end
end