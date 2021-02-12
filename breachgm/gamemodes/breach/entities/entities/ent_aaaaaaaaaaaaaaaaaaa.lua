AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model( "models/vinrax/props/scp035/035_mask.mdl" )

function ENT:Initialize()
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetPos(self:GetPos() + Vector(0,0,30))
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	if SERVER then
		if roundstats != nil then
			roundstats.secretf = true
		end
	end
end

ENT.LastSound = 0
function ENT:OnTakeDamage( damage )
	if self.LastSound > CurTime() then return end
	self.LastSound = CurTime() + 20
	if !damage:GetAttacker():IsPlayer() then return end
	net.Start("ForcePlaySound")
		net.WriteString("096_2.ogg")
	net.Send(damage:GetAttacker())
	damage:GetAttacker():PrintMessage(HUD_PRINTCENTER, "You shouldn't do that")
	hook.Run("SecretFound", damage:GetAttacker())
	if damage:GetAttacker().GiveAchievement then
		damage:GetAttacker():GiveAchievement("aaa")
	end
end
