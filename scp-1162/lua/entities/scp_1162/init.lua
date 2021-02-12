--Coded by artistic

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/hunter/blocks/cube1x1x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NOCLIP)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
		phys:EnableMotion(false)
	end

	local defaultpos = Vector(1777.695068, 881.130493, 43.745945)
	if SPAWN_1162 then
		defaultpos = SPAWN_1162
	end
	local defaultang = Angle(-90, 0, 180)
	phys:SetAngles(defaultang)
	self:SetAngles(defaultang)
	phys:SetPos(defaultpos)
	self:SetPos(defaultpos)

	self:SetUseType(SIMPLE_USE)

	self:SetNoDraw(true)
end

// Add anything else in the Use function
function ENT:Use(c, a)
	if preparing then return end
	if IsValid( c ) and c:IsPlayer() and c:Alive() and c:Team() != TEAM_SPEC then
		local chance = math.random(1,100)
		local choose = math.random(1,4)
		local weapon = "none"
		if tostring(c:GetActiveWeapon()) != "[NULL Entity]"  then
			weapon = c:GetActiveWeapon():GetClass()
		else
			c:EmitSound( "1162/trade.ogg", 75, 100, 1, CHAN_AUTO )
		end
		//c:PrintMessage(HUD_PRINTTALK, weapon)
		// Incorrect: tostring(c:GetActiveWeapon())
		if c:GetActiveWeapon().clevel and c:GetActiveWeapon().clevel == 2 then
			if chance < 30 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_zm")
			elseif chance < 60 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("item_snav_300")
			else
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("item_eyedrops")
			end
		elseif c:GetActiveWeapon().clevel and c:GetActiveWeapon().clevel == 3 then
			if chance < 10 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_fm")
			elseif chance < 60  then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_ms")
			else
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				if choose == 1 then c:Give("item_snav_ultimate")
				elseif choose == 2 then c:Give("item_radio")
				else c:Give("item_medkit")
				end
			end
		elseif c:GetActiveWeapon().clevel and c:GetActiveWeapon().clevel == 4 then
			if chance < 10 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_5")
			elseif chance < 40 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_fm")
			else
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				if choose == 1 then c:Give("item_medkit")
				elseif choose == 2 then c:Give("weapon_nvg")
				else c:Give("item_snav_ultimate")
				end
			end
		elseif weapon == "keycard_level5" then
			--Prevent player from accidentally passing lv5
		elseif weapon == "keycard_omni" then
			--prevent player from passing omni
		//elseif tostring(c:GetActiveWeapon()) == "[NULL Entity]" then
		elseif weapon == "none" then
			c:EmitSound( "1162/horror"..math.random(1, 4)..".ogg", 75, 100, 1, CHAN_AUTO )
			c:TakeDamage(30, self, self)
			c:PrintMessage(HUD_PRINTTALK, "You reach into the hole with nothing in your hand. You feel extremely sick...")
			if chance < 30 then
				c:Give("keycard_bs")
			elseif chance < 45 then
				c:Give("keycard_zm")
			else
				if choose == 1 then c:Give("item_snav_300")
				elseif choose == 2 then c:Give("item_eyedrops")
				else c:Give("item_radio")
				end
			end
		elseif weapon == "item_radio" then
			if chance < 50 then
				c:StripWeapon("item_radio")
				c:Give("item_snav_300")
			else
				c:StripWeapon("item_radio")
				c:Give("weapon_nvg")
			end
		elseif weapon == "item_snav_300" then
			if chance < 50 then
				c:StripWeapon("item_snav_300")
				c:Give("weapon_nvg")
			else
				c:StripWeapon("item_snav_300")
				c:Give("keycard_bs")
			end
		elseif weapon == "item_snav_ultimate" then
			if chance < 50 then
				c:StripWeapon("item_snav_ultimate")
				c:Give("keycard_zm")
			else
				c:StripWeapon("item_snav_ultimate")
				c:Give("item_medkit")
			end
		elseif weapon == "item_eyedrops" then
			if chance < 50 then
				c:StripWeapon("item_eyedrops")
				c:Give("item_radio")
			else
				c:StripWeapon("item_eyedrops")
				c:Give("weapon_nvg")
			end
		elseif weapon == "weapon_nvg" then
			if chance < 50 then
				c:StripWeapon("weapon_nvg")
				c:Give("item_snav_300")
			else
				c:StripWeapon("weapon_nvg")
				c:Give("item_radio")
			end
		elseif weapon == "item_radio" then
			if chance < 50 then
				c:StripWeapon("item_radio")
				c:Give("item_snav_300")
			else
				c:StripWeapon("item_radio")
				c:Give("weapon_nvg")
			end
		elseif weapon == "item_medkit" then
			if chance < 50 then
				c:StripWeapon("item_medkit")
				c:Give("keycard_zm")
			else
				c:StripWeapon("item_medkit")
				c:Give("weapon_l4d2_crowbar")
			end
		elseif weapon == "item_radio" then
			if chance < 50 then
				c:StripWeapon("item_radio")
				c:Give("item_snav_300")
			else
				c:StripWeapon("item_radio")
				c:Give("weapon_nvg")
			end
		elseif weapon == "weapon_l4d2_crowbar" then
			if chance < 50 then
				c:StripWeapon("weapon_l4d2_crowbar")
				c:Give("keycard_zm")
			else
				c:StripWeapon("weapon_l4d2_crowbar")
				c:Give("item_medkit")
			end
		elseif weapon == "weapon_stunstick" then
			if chance < 20 then
				c:StripWeapon("weapon_stunstick")
				c:Give("keycard_fm")
			else
				c:StripWeapon("weapon_stunstick")
				c:Give("keycard_zm")
			end
		else
			//c:PrintMessage(HUD_PRINTTALK,"Invalid input for SCP-1162")
			//c:PrintMessage(weapon)
		end
	end
	if IsValid( c ) and c:IsPlayer() and c:Alive() and c:Team() != TEAM_SPEC and c:GetNClass() == ROLE_SCP181 then
		local chance = math.random(1,25)
		local choose = math.random(1,2)
		local weapon = "none"
		if tostring(c:GetActiveWeapon()) != "[NULL Entity]"  then
			weapon = c:GetActiveWeapon():GetClass()
		else
			c:EmitSound( "1162/trade.ogg", 75, 100, 1, CHAN_AUTO )
		end
		//c:PrintMessage(HUD_PRINTTALK, weapon)
		// Incorrect: tostring(c:GetActiveWeapon())
		if c:GetActiveWeapon().clevel and c:GetActiveWeapon().clevel == 2 then
			if chance < 30 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_zm")
			elseif chance < 60 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("item_snav_300")
			else
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("item_eyedrops")
			end
		elseif c:GetActiveWeapon().clevel and c:GetActiveWeapon().clevel == 3 then
			if chance < 10 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_fm")
			elseif chance < 60  then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_ms")
			else
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				if choose == 1 then c:Give("item_snav_ultimate")
				elseif choose == 2 then c:Give("item_radio")
				else c:Give("item_medkit")
				end
			end
		elseif c:GetActiveWeapon().clevel and c:GetActiveWeapon().clevel == 4 then
			if chance < 10 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_5")
			elseif chance < 40 then
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				c:Give("keycard_fm")
			else
				c:StripWeapon(c:GetActiveWeapon():GetClass())
				if choose == 1 then c:Give("item_medkit")
				elseif choose == 2 then c:Give("weapon_nvg")
				else c:Give("item_snav_ultimate")
				end
			end
		elseif weapon == "keycard_level5" then
			--Prevent player from accidentally passing lv5
		elseif weapon == "keycard_omni" then
			--prevent player from passing omni
		//elseif tostring(c:GetActiveWeapon()) == "[NULL Entity]" then
		elseif weapon == "none" then
			c:EmitSound( "1162/horror"..math.random(1, 4)..".ogg", 75, 100, 1, CHAN_AUTO )
			if c:GetNClass() == ROLE_SCP181 and math.random(1, 2) then return end
			c:TakeDamage(30, self, self)
			c:PrintMessage(HUD_PRINTTALK, "You reach into the hole with nothing in your hand. You feel extremely sick...")
			if chance < 30 then
				c:Give("keycard_bs")
			elseif chance < 45 then
				c:Give("keycard_zm")
			else
				if choose == 1 then c:Give("item_snav_300")
				elseif choose == 2 then c:Give("item_eyedrops")
				else c:Give("item_radio")
				end
			end
		elseif weapon == "item_radio" then
			if chance < 50 then
				c:StripWeapon("item_radio")
				c:Give("item_snav_300")
			else
				c:StripWeapon("item_radio")
				c:Give("weapon_nvg")
			end
		elseif weapon == "item_snav_300" then
			if chance < 50 then
				c:StripWeapon("item_snav_300")
				c:Give("weapon_nvg")
			else
				c:StripWeapon("item_snav_300")
				c:Give("keycard_bs")
			end
		elseif weapon == "item_snav_ultimate" then
			if chance < 50 then
				c:StripWeapon("item_snav_ultimate")
				c:Give("keycard_zm")
			else
				c:StripWeapon("item_snav_ultimate")
				c:Give("item_medkit")
			end
		elseif weapon == "item_eyedrops" then
			if chance < 50 then
				c:StripWeapon("item_eyedrops")
				c:Give("item_radio")
			else
				c:StripWeapon("item_eyedrops")
				c:Give("weapon_nvg")
			end
		elseif weapon == "weapon_nvg" then
			if chance < 50 then
				c:StripWeapon("weapon_nvg")
				c:Give("item_snav_300")
			else
				c:StripWeapon("weapon_nvg")
				c:Give("item_radio")
			end
		elseif weapon == "item_radio" then
			if chance < 50 then
				c:StripWeapon("item_radio")
				c:Give("item_snav_300")
			else
				c:StripWeapon("item_radio")
				c:Give("weapon_nvg")
			end
		elseif weapon == "item_medkit" then
			if chance < 50 then
				c:StripWeapon("item_medkit")
				c:Give("keycard_zm")
			else
				c:StripWeapon("item_medkit")
				c:Give("weapon_l4d2_crowbar")
			end
		elseif weapon == "item_radio" then
			if chance < 50 then
				c:StripWeapon("item_radio")
				c:Give("item_snav_300")
			else
				c:StripWeapon("item_radio")
				c:Give("weapon_nvg")
			end
		elseif weapon == "weapon_l4d2_crowbar" then
			if chance < 50 then
				c:StripWeapon("weapon_l4d2_crowbar")
				c:Give("keycard_zm")
			else
				c:StripWeapon("weapon_l4d2_crowbar")
				c:Give("item_medkit")
			end
		elseif weapon == "weapon_stunstick" then
			if chance < 20 then
				c:StripWeapon("weapon_stunstick")
				c:Give("keycard_fm")
			else
				c:StripWeapon("weapon_stunstick")
				c:Give("keycard_zm")
			end
		else
			//c:PrintMessage(HUD_PRINTTALK,"Invalid input for SCP-1162")
			//c:PrintMessage(weapon)
		end
	end
end
