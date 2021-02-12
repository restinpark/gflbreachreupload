AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.model = "models/items/quake1/invisibl.mdl"
ENT.LoopSound = Sound("items/q1/inv3.wav")

local function PowerupActive(ply)
	return ply.QuakePowerups and ply.QuakePowerups.Invisibility
end

function ENT:Pickup(ent)
	if PowerupActive(ent) then return end
	
	local duration = CurTime() + self.PDuration

	ent.QuakePowerups.Invisibility = duration
	if self.PDuration >= 3 then
		ent.QuakePowerups.InvisibilityOut = duration - 3
	end
	
	ent:EmitSound("items/q1/inv1.wav", 500, 100)
	ent.inv3 = CreateSound(ent, self.LoopSound)
	ent.inv3:SetSoundLevel(40)
	ent.inv3:Play()

	ent:DrawViewModel(false)
	ent:SetNoDraw(true)
	ent:SetNoTarget(true)
	self:SendToClient(ent, ent.QuakePowerups)
	
	self:Remove()
end

hook.Add("PlayerSwitchWeapon", "QuakePowerups_Invisibility", function(ply)
	if !PowerupActive(ply) then return end
	timer.Simple(0, function()
		if IsValid(ply) and PowerupActive(ply) then
			ply:DrawViewModel(false)
		end
	end)
end)

hook.Add("PlayerPostThink", "QuakePowerups_Invisibility", function(ply)
	if !PowerupActive(ply) then return end
	
	if ply.QuakePowerups.InvisibilityOut and ply.QuakePowerups.InvisibilityOut <= CurTime() then
		ply.QuakePowerups.InvisibilityOut = nil
		ply:EmitSound("items/q1/inv2.wav", 90, 100)
		if ply.inv3 then ply.inv3:Stop() end
	end	
	
	if ply.QuakePowerups.Invisibility <= CurTime() then
		ply.QuakePowerups.Invisibility = nil
		ply:DrawViewModel(true)
		ply:SetNoDraw(false)
		ply:SetNoTarget(false)
		if ply.inv3 then
			ply.inv3:Stop()
			ply.inv3 = nil
		end
	end
end)