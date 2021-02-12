AddCSLuaFile()

ENT.PrintName = "Cognitohazard"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.hp = 200

function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetMaterial("models/XQM//LightLinesGB")
    self:SetMoveType( MOVETYPE_NOCLIP )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_WORLD ) 
    self:PhysWake()
    if SERVER then
        self:SetTrigger(true)
		timer.Simple(60, function ()
				SafeRemoveEntity(self)
				self:StopSound("ambient/machines/combine_shield_loop3.wav")
		end)
    end
    self.ActiveIn = CurTime() + 3
end

if SERVER then
    function ENT:Think()
        local affected = ents.FindInSphere(self:GetPos(), 150)
        for k,v in pairs(affected) do
            if v:IsPlayer() and v:Team() ~= TEAM_SCP and v:Team() ~= TEAM_SPEC and v:GetNClass() ~= ROLE_SCP990 then
			if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
                v:SetEyeAngles((self:GetPos() - v:GetShootPos()):Angle())
				v:Ignite(2)
            end
        end
    end
end

function ENT:OnTakeDamage( dmginfo )
	local damage = dmginfo:GetDamage()
		if(self.hp <= 0) then
			SafeRemoveEntity(self)
		else
			self.hp = self.hp - damage 
	end
end

