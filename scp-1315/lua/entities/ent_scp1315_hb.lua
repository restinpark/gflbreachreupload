AddCSLuaFile()

ENT.PrintName = "SCP-1315"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Press E to Play."


function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNoDraw(true)
	if SERVER then
        if SPAWN_SCP1315HB then
            self:SetPos(SPAWN_SCP1315HB)
        else
            self:Remove()
        end
		if SPAWN_SCP1315HB_ANGLE and isangle(SPAWN_SCP1315HB_ANGLE) then
            self:SetAngles(SPAWN_SCP1315HB_ANGLE)
        end
		self:SetUseType( SIMPLE_USE )
    end
end

function ENT:Use(activator, caller)
    if SERVER and caller and IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SCP and caller:Team() ~= TEAM_SPEC and caller:GetNClass() ~= ROLE_999 then
	for k,v in pairs(player.GetAll()) do
	if v:GetNClass() == ROLE_PLAYER1 or v:GetNClass() == ROLE_PLAYER2 or v:GetNClass() == ROLE_PLAYER3 then return end
	end
	if caller.GiveAchievement then
		caller:GiveAchievement("Game")
	end
	if game.GetMap() == "br_site19" then 
		if caller:HasWeapon("weapon_cartridge_shadow") then
			caller:SetPlayer1()
			caller:SetPos(Vector(1788.442383, -1947.385132, -733.186279))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(1177.844727, 31.001118, -733.988770)
				if IsValid(ply) then
					ply:SetSCP1315A()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_hunter") then
			caller:SetPlayer2()
			caller:SetPos(Vector(1788.442383, -1947.385132, -733.186279))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(1177.844727, 31.001118, -733.988770)
				if IsValid(ply) then
					ply:SetSCP1315B()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_freeman") then
			caller:SetPlayer3()
			caller:SetPos(Vector(1788.442383, -1947.385132, -733.186279))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(1177.844727, 31.001118, -733.988770)
				if IsValid(ply) then
					ply:SetSCP1315C()
					ply:SetPos(pos)
				end
			end
		end
	if game.GetMap() == "br_area02_v3" then 
		if caller:HasWeapon("weapon_cartridge_shadow") then
			caller:SetPlayer1()
			caller:SetPos(Vector(-8304.471680, -4251.117188, -119.323235))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(-9854.427734, -2691.410889, -161.088379)
				if IsValid(ply) then
					ply:SetSCP1315A()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_hunter") then
			caller:SetPlayer2()
			caller:SetPos(Vector(-8304.471680, -4251.117188, -119.323235))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(-9854.427734, -2691.410889, -161.088379)
				if IsValid(ply) then
					ply:SetSCP1315B()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_freeman") then
			caller:SetPlayer3()
			caller:SetPos(Vector(-8304.471680, -4251.117188, -119.323235))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(-9854.427734, -2691.410889, -161.088379)
				if IsValid(ply) then
					ply:SetSCP1315C()
					ply:SetPos(pos)
				end
			end
		end
	if game.GetMap() == "br_site61_v2" then 
		if caller:HasWeapon("weapon_cartridge_shadow") then
			caller:SetPlayer1()
			caller:SetPos(Vector(6073.485352, -117.254219, -11500.642578))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(6701.356445, -2015.186768, -11500.642578)
				if IsValid(ply) then
					ply:SetSCP1315A()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_hunter") then
			caller:SetPlayer2()
			caller:SetPos(Vector(6073.485352, -117.254219, -11500.642578))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(6701.356445, -2015.186768, -11500.642578)
				if IsValid(ply) then
					ply:SetSCP1315B()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_freeman") then
			caller:SetPlayer3()
			caller:SetPos(Vector(6073.485352, -117.254219, -11500.642578))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(6701.356445, -2015.186768, -11500.642578)
				if IsValid(ply) then
					ply:SetSCP1315C()
					ply:SetPos(pos)
				end
			end
		end
	if game.GetMap() == "br_site65" then 
		if caller:HasWeapon("weapon_cartridge_shadow") then
			caller:SetPlayer1()
			caller:SetPos(Vector(-8381.426758, 8752.696289, -5769.033691))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(-8667.680664, 6854.010742, -5744.979492)
				if IsValid(ply) then
					ply:SetSCP1315A()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_hunter") then
			caller:SetPlayer2()
			caller:SetPos(Vector(-8381.426758, 8752.696289, -5769.033691))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(-8667.680664, 6854.010742, -5744.979492)
				if IsValid(ply) then
					ply:SetSCP1315B()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_freeman") then
			caller:SetPlayer3()
			caller:SetPos(Vector(-8381.426758, 8752.696289, -5769.033691))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(-8667.680664, 6854.010742, -5744.979492)
				if IsValid(ply) then
					ply:SetSCP1315C()
					ply:SetPos(pos)
				end
			end
		end
	if game.GetMap() == "br_site05_v2" then 
		if caller:HasWeapon("weapon_cartridge_shadow") then
			caller:SetPlayer1()
			caller:SetPos(Vector(7759.713867, -2999.849609, -1414.321899))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(7744.812012, -1998.041870, -1413.961914)
				if IsValid(ply) then
					ply:SetSCP1315A()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_hunter") then
			caller:SetPlayer2()
			caller:SetPos(Vector(7759.713867, -2999.849609, -1414.321899))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(7744.812012, -1998.041870, -1413.961914)
				if IsValid(ply) then
					ply:SetSCP1315B()
					ply:SetPos(pos)
			end
		end
		if caller:HasWeapon("weapon_cartridge_freeman") then
			caller:SetPlayer3()
			caller:SetPos(Vector(7759.713867, -2999.849609, -1414.321899))
			local ply = table.Random(GetNotAFKSpecs())
			local pos = Vector(7744.812012, -1998.041870, -1413.961914)
				if IsValid(ply) then
					ply:SetSCP1315C()
					ply:SetPos(pos)
				end
			end
		else
			caller:PrintMessage(3, "ERROR#1315! No Game Detected!")
		end
	end
end



