AddCSLuaFile()

ENT.PrintName = "Nuke"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Press E to Use."


function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNoDraw(true)
	if SERVER then
        if SPAWN_NUKE then
            self:SetPos(SPAWN_NUKE)
        else
            self:Remove()
        end
		self:SetUseType( SIMPLE_USE )
    end
	if SERVER then
        self:SetNWInt("Nuke", CurTime() + 475)
    end
end
ENT.SpecialCooldown = 475
function ENT:Use(activator, caller)
	if self:GetNWInt("Nuke", 0) > CurTime() then return end
    self:SetNWInt("Nuke",CurTime() + self.SpecialCooldown)
    if SERVER and caller and IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SCP and caller:Team() ~= TEAM_SPEC and caller:GetNClass() ~= ROLE_999 then
	local clevel = caller:CLevelGlobal()
	if caller:GetNClass() == ROLE_MTFCOM or caller:GetNClass() == ROLE_O51 or caller:GetNClass() == ROLE_DRCLEF then
	if caller:HasWeapon("keycard_5") then
	if caller.GiveAchievement then
		caller:GiveAchievement("Nuke")
	end
	if timer.Exists("Siren") then return end
	BroadcastGameMsg("THE NUKE HAS BEEN ACTIVATED! ALL PERSONNEL HAVE T-MINUS 90 SECONDS TO REPORT TO NEARBY BLAST SHELTERS IMMEDIATELY!")
	BroadcastLua('surface.PlaySound("warhead.ogg")')
	timer.Create("Siren", 10, 0, function()
	BroadcastLua('surface.PlaySound("siren.ogg")') end)
	timer.Create("Warhead", 90, 1, function()
		for k,v in pairs(player.GetAll()) do
			if v:Alive() then
			if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then
			if v.GiveAchievement then
				v:GiveAchievement("Survivor")
				end return end
				v:Kill()
				timer.Remove("Siren")
				BroadcastLua('surface.PlaySound("nuke.ogg")')
			end
		end
	end)
end
	end
end
	if caller:GetNClass() != ROLE_MTFCOM and caller:GetNClass() != ROLE_O51 and caller:GetNClass() != ROLE_DRCLEF then
	if caller:HasWeapon("keycard_5") then
	if caller.GiveAchievement then
		caller:GiveAchievement("NukeFail")
	end
	if timer.Exists("Siren") then
	timer.Remove("Warhead")
	timer.Remove("Siren")
	BroadcastLua('surface.PlaySound("warheadfail.ogg")')
	BroadcastGameMsg("THE WARHEAD HAS BEEN STOPPED!")
			end
		end
	end
	hook.Add("BreachStartRound", "NukeReset", function ()
                    timer.Remove("Warhead")
					timer.Remove("Siren")
                    hook.Remove("BreachStartRound", "NukeReset")
      
                
    end)
end



