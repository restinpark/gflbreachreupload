AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "SCP-3199 Egg"
ENT.Spawnable = false
ENT.State = false
Model("models/player/alski/scp3199/egg.mdl")
ENT.Health = 1200
ENT.NextActivation = nil
function ENT:Initialize()
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
    self:SetModel(Model("models/player/alski/scp3199/egg.mdl"))
    self:PhysicsInit(SOLID_VPHYSICS)
end

function ENT:SetState(bool)
    self.State = bool
    self:StateUpdated(bool)
end

function ENT:StateUpdated(b)
    if b then
        self.NextActivation = CurTime() + 29.5
    else
        self.NextActivation = nil
    end
end

function ENT:Think()
    if self.NextActivation and CurTime() > self.NextActivation and SERVER then
        self.NextActivation = CurTime() + 30
        local ed = EffectData()
        ed:SetOrigin(self:GetPos())
        ed:SetRadius(300)
        ed:SetEntity(self)
        util.Effect("AntlionGib", ed , false, true)
	self:EmitSound(Sound("weapons/bugbait/bugbait_impact1.wav"), 100, 50, 1, CHAN_AUTO)
	 local ply = table.Random(GetNotAFKSpecs())
	 local egg = Vector(self:GetPos())
        for k,v in pairs(player.GetAll(ply)) do
			ply:SetSCP3199b()
			ply:SetPos(egg)
            end
        end
    end
