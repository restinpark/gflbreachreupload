AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "SCP-079 Hitbox"
--Good spot for 19: 3596.812500 -475.375000 -200.218750

function ENT:Initialize()
    --Encases the 079 monitor on site19
    self:SetModel("models/hunter/blocks/cube075x075x075.mdl")
	if game.GetMap() == "br_site61_v2" then
	self:SetMaterial("models/XQM//LightLinesGB")
	self:SetNoDraw(false)
	else
	self:SetNoDraw(true)
    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
        local pobj = self:GetPhysicsObject()
        if IsValid(pobj) then
            pobj:EnableMotion(false)
        end
    end
	end
end


function ENT:OnTakeDamage(dmginfo)
    --print("hit")
    local damageAmount = dmginfo:GetDamage()
    local attacker = dmginfo:GetAttacker()
    local inflictor = dmginfo:GetInflictor()
    if (attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:Team() ~= TEAM_SCP and attacker:Team() ~= TEAM_SPEC) then
        for k,v in pairs(player.GetAll()) do
            if v:GetNClass() == ROLE_SCP079 then
                local info = DamageInfo()
                info:SetDamage(damageAmount / 3)
                --DMG_PHYSGUN will be the only type of damage SCP-079 can take
                info:SetDamageType(DMG_PHYSGUN)
                info:SetAttacker(attacker)
                info:SetInflictor(inflictor)
                v:TakeDamageInfo(info)
            end
        end
    end
end