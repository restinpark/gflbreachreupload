// Serverside file for all player related functions
//Localize enums
local TEAM_SCP = 1
local TEAM_GUARD = 2
local TEAM_CLASSD = 3
local TEAM_SPEC = 4
local TEAM_SCI = 5
local TEAM_CHAOS = 6
local TEAM_CLASSE = 7
local TEAM_GOC = 8
//
function CheckStart()
	if MINPLAYERS == nil then MINPLAYERS = 2 end
	if gamestarted == false and #GetActivePlayers() >= MINPLAYERS then
		RoundRestart()
	end
	if #GetActivePlayers() == MINPLAYERS then
		RoundRestart()
	end
	if gamestarted then
		BroadcastLua( 'gamestarted = true' )
	end
end

function GM:PlayerInitialSpawn( ply )
	ply:SetCanZoom( false )
	ply:SetNoDraw(true)
	ply.Active = false
	ply.freshspawn = true
	ply.isblinking = false
	ply.ActivePlayer = true
	ply.Karma = StartingKarma() or 1000
	if timer.Exists( "RoundTime" ) == true then
		net.Start("UpdateTime")
			net.WriteString(tostring(timer.TimeLeft( "RoundTime" )))
		net.Send(ply)
	end
	player_manager.SetPlayerClass( ply, "class_default" )
	CheckStart()
	if gamestarted then
		ply:SendLua( 'gamestarted = true' )
	end
	if not ply.GetNClass then
		player_manager.RunClass( ply, "SetupDataTables" )
	end
end

function GM:PlayerAuthed( ply, steamid, uniqueid )
	ply.Active = false
	ply.Leaver = "none"
	if prepring then
		ply:SetClassD()
	else
		ply:SetSpectator()
	end
end

function GM:PlayerSpawn( ply )
	ply.Leaver = "none"
	ply:SetupHands()
	ply:SetNoCollideWithTeammates(true)
	if prepring == false then
		ply:SetSpectator()
	end
	if ply.freshspawn then
		ply:SetSpectator()
		ply.freshspawn = false
	end
	ply:SetupHands()
	if not ply.GetNClass then
		player_manager.SetPlayerClass( ply, "class_default" )
		player_manager.RunClass( ply, "SetupDataTables" )
	end
	if not ply.GetNClass then
		player_manager.RunClass( ply, "SetupDataTables" )
	end
end

function GM:PlayerSetHandsModel( ply, ent )
	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		if ply.handsmodel != nil then
			info = ply.handsmodel
		end
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end
end

function GM:PlayerDeathThink( ply )
	if ply.nextspawn == nil then
		ply.nextspawn = CurTime() + 5
	end
	if (CurTime() >= ply.nextspawn) then
		ply:Freeze(false)
		ply:Spawn()
		ply:SetSpectator()
		ply.nextspawn = CurTime() + 1
	end
end

hook.Add("EntityTakeDamage", "BlockElevatorDamage", function (ply, dmginfo)
	if game.GetMap() == "br_area02_v2" or game.GetMap() == "br_area14_v3" then
		local att = dmginfo:GetAttacker()
		if att and IsValid(att) and (att:GetClass() == "func_door" or att:GetClass() == "func_movelinear") then
			return true
		end
	end
end)

//Override
--function GM:DoPlayerDeath(ply, attacker, dmginfo)
 --   local doBody = true
   -- if attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:GetActiveWeapon() and IsValid(attacker:GetActiveWeapon()) and -attacker:GetActiveWeapon():GetClass() == "weapon_scp668" then
    --    doBody = false  
    --end
	--if BREACH_CorpseCreate and doBody then
		--BREACH_CorpseCreate(ply, attacker, dmginfo)
	--	ply:CreateRagdoll()
	--end
--	if attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:GetNClass() != ROLE_SCP2845 then
--		ply:CreateRagdoll()
--	end
--	ply:AddDeaths( 1 )
--end
function GM:PlayerHurt(victim, attacker)
	if victim:GetNClass() == ROLE_SCP4715 then
	if victim:GetWalkSpeed() == 255 then return end
		victim:SetRunSpeed(victim:GetRunSpeed() + 1)
		victim:SetWalkSpeed(victim:GetRunSpeed())
		victim:SetMaxSpeed(victim:GetRunSpeed())
	else
	if attacker:GetActiveWeapon():GetClass() == "weapon_stunstick" then
	if victim:Team() == TEAM_SCP then return end
	if victim:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
		victim:TakeDamage(30)
	else
	if attacker:GetActiveWeapon():GetClass() == "svn_kar98k" then
	if victim:Team() == TEAM_SCP then return end
	if victim:GetNClass() == ROLE_SCP035 then return end
	if victim:GetNClass() == ROLE_SCP2953 then return end
	if victim:GetNClass() == ROLE_SCP990 then return end
	if victim:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
        victim:SetSCP2953()
	else
	if attacker:GetActiveWeapon():GetClass() == "weapon_scp_2953_upper" then
	if victim:Team() == TEAM_SCP then return end
	if victim:GetNClass() == ROLE_SCP035 then return end
	if victim:GetNClass() == ROLE_SCP2953 then return end
	if victim:GetNClass() == ROLE_SCP990 then return end
	if victim:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
        victim:SetSCP2953UPPER()
	else
	if attacker:GetActiveWeapon():GetClass() == "tfa_ins2_k98" and attacker:GetNClass() == ROLE_SCP1861B then
	if victim:Team() == TEAM_SCP then return end
	if victim:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
		victim:Freeze(true)
	timer.Create("Freezing", 5, 1, function()
		victim:Freeze(false)
	end)
	else
	if attacker:GetActiveWeapon():GetClass() == "weapon_jackssword" then
	if victim:Team() == TEAM_SCP and victim:GetNClass() == ROLE_SCP2301 then
		victim:TakeDamage(200)
	else
	return end
	end
	end
	end
	end
	end
	end
end
function GM:PlayerDeath( victim, inflictor, attacker )
	hook.Run("PreBreachDeath", victim, attacker)
	for k,v in pairs(player.GetAll()) do
		if v.CurSpec and v.CurSpec == victim:SteamID() then
		--	v:SetSpectator()
			v.CurSpec = nil
		end
	end
	victim.nextspawn = CurTime() + 5
	if attacker:IsPlayer() then
		print("[KILL] " .. attacker:Nick() .. " [" .. attacker:GetNClass() .. "] killed " .. victim:Nick() .. " [" .. victim:GetNClass() .. "]")
	end
	if victim.GetNClass and victim:GetNClass() == ROLE_05 then
		EndRound(1)
	end
	victim:SetNClass(ROLE_SPEC)
	if attacker != victim and postround == false and attacker:IsPlayer() then
		if attacker:IsPlayer() then
			if attacker:Team() == TEAM_GUARD then
				victim:PrintMessage(HUD_PRINTTALK, "You were killed by an MTF Guard: " .. attacker:Nick())
				if victim:Team() == TEAM_SCP then
					attacker:AddFrags(10)
				elseif victim:Team() == TEAM_CHAOS then
					attacker:AddFrags(5)
				elseif victim:Team() == TEAM_CLASSD then
					attacker:AddFrags(2)
				end
			elseif attacker:Team() == TEAM_CHAOS then
				victim:PrintMessage(HUD_PRINTTALK, "You were killed by a Chaos Insurgency Soldier: " .. attacker:Nick())
				if victim:Team() == TEAM_GUARD then
					attacker:AddFrags(2)
				elseif victim:Team() == TEAM_SCI then
					attacker:AddFrags(2)
				elseif victim:Team() == TEAM_SCP then
					attacker:AddFrags(10)
				elseif victim:Team() == TEAM_CLASSD then
					attacker:PrintMessage(HUD_PRINTTALK, "Don't kill Class Ds!")
					--attacker:AddFrags(1)
				end
			elseif attacker:Team() == TEAM_SCP then
				victim:PrintMessage(HUD_PRINTTALK, "You were killed by an SCP: " .. attacker:Nick())
				attacker:AddFrags(2)
			elseif attacker:Team() == TEAM_CLASSD then
				victim:PrintMessage(HUD_PRINTTALK, "You were killed by a Class D: " .. attacker:Nick())
				if victim:Team() == TEAM_GUARD then
					attacker:AddFrags(4)
				elseif victim:Team() == TEAM_SCI then
					--attacker:PrintMessage(HUD_PRINTTALK, "You've been awarded with 2 points for killng a Researcher!")
					--attacker:PS_GivePoints(2)
					--attacker:AddFrags(2)
				elseif victim:Team() == TEAM_SCP then
					attacker:AddFrags(10)
				elseif victim:Team() == TEAM_CHAOS then
					attacker:AddFrags(2)
				end
			elseif attacker:Team() == TEAM_SCI then
				victim:PrintMessage(HUD_PRINTTALK, "You were killed by a Researcher: " .. attacker:Nick())
				if victim:Team() == TEAM_SCP then
					attacker:AddFrags(10)
				elseif victim:Team() == TEAM_CHAOS then
					attacker:AddFrags(5)
				elseif victim:Team() == TEAM_CLASSD then
					--attacker:PrintMessage(HUD_PRINTTALK, "You've been awarded with 2 points for killing a Class D Personell!")
					--attacker:PS_GivePoints(2)
					--attacker:AddFrags(2)
				end
			elseif attacker:Team() == TEAM_CLASSE then
				victim:PrintMessage(HUD_PRINTTALK, "You were killed by a Class E: " .. attacker:Nick())
				if victim:Team() == TEAM_SCP then
					attacker:AddFrags(10)
				elseif victim:Team() == TEAM_CHAOS then
					attacker:AddFrags(8)
				elseif victim:Team() == TEAM_GUARD then
					attacker:AddFrags(8)
				elseif victim:Team() == TEAM_CLASSD then
					attacker:AddFrags(2)
				elseif victim:Team() == TEAM_SCI then
					attacker:AddFrags(4)
				end
			end
		end
	end
	roundstats.deaths = roundstats.deaths + 1
	if math.random(1, 30) == 15 then
	victim:Give("weapon_flesh")
	end
	victim:SetTeam(TEAM_SPEC)
	if #victim:GetWeapons() > 0 then
		local pos = victim:GetPos()
		for k,v in pairs(victim:GetWeapons()) do
			local candrop = true
			if v.droppable != nil then
				if v.droppable == false then
					candrop = false
				end
			end

			if candrop then
				local wep = ents.Create( v:GetClass() )
				if IsValid( wep ) then
					wep:SetPos( pos )
					wep:Spawn()
					wep:SetClip1(v:Clip1())
					if v.Primary and v.Primary.Ammo and string.lower(v.Primary.Ammo) != "none" then
						wep.StoredAmmo = victim:GetAmmoCount( v.Primary.Ammo )
					end
				end
			end
		end
	end
	WinCheck()
end

function GM:PlayerDisconnected( ply )
	 ply:SetTeam(TEAM_SPEC)
	 if #player.GetAll() < MINPLAYERS then
		BroadcastLua('gamestarted = false')
		gamestarted = false
	 end
	 ply:SaveKarma()
	 WinCheck()
end

function HaveRadio(pl1, pl2)
	if pl1:HasWeapon("item_radio") then
		if pl2:HasWeapon("item_radio") then
			local r1 = pl1:GetWeapon("item_radio")
			local r2 = pl2:GetWeapon("item_radio")
			if !IsValid(r1) or !IsValid(r2) then return false end
			/*
			print(pl1:Nick() .. " - " .. pl2:Nick())
			print(r1.Enabled)
			print(r1.Channel)
			print(r2.Enabled)
			print(r2.Channel)
			*/
			if r1.Enabled == true then
				if r2.Enabled == true then
					if r1.Channel == r2.Channel then
						if r1.Channel > 4 then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

local haveRadioLocal = HaveRadio

function GM:PlayerCanHearPlayersVoice( listener, talker )
	--SCPs have global voice chat among themselves
	if listener:Team() == TEAM_SCP and talker:Team() == TEAM_SCP then return true end
	--SCP-1360 can not talk using voice chat
	if talker:GetNClass() == ROLE_SCP1360 then return false end
	--990 can only talk to his host
	if talker:GetNClass() == ROLE_SCP990 then
		if listener:HasWeapon("weapon_dream") then
			return true
		else
			return false
		end
	end
	--Set MM if not already set
	if not listener.mutemode then
		listener.mutemode = 0
	end
	--Check basic things
	if talker:Team() == TEAM_SCP and listener:Team() != TEAM_SCP and talker:GetNClass() != ROLE_SCP939 then
		return false
	elseif talker:GetNClass() == ROLE_SCP990 and listener:HasWeapon() != "weapon_dream" then
		return false
	elseif talker:Team() == TEAM_SPEC and listener:Team() != TEAM_SPEC then
		return false
	elseif talker:Team() == TEAM_SPEC and (talker.mutemode == 2 or talker.mutemode == 3) then
		return false
	end
	if talker.INT_IsTalking and talker:Team() != TEAM_SPEC and talker:Team() != TEAM_SCP then
		return true, false
	end
	--Check if somebody has their sound muted
	if listener:Team() == TEAM_SPEC then
		if talker:Team() != TEAM_SPEC and listener.mutemode == 1 then
			return false
		elseif talker:Team() == TEAM_SPEC and listener.mutemode == 2 then
			return false
		elseif listener.mutemode == 3 then
			return false
		elseif talker:Team() == TEAM_SPEC then
			return true
		end
	end

	if haveRadioLocal(listener, talker) == true then
		return true
	end
	if talker:GetPos():Distance(listener:GetPos()) < 750 then
		return true, true
	else
		return false
	end
end

function GM:PlayerCanSeePlayersChat( text, teamOnly, listener, talker )
	if teamOnly then
		if talker:Team() == TEAM_SCP and listener:Team() == TEAM_SCP then return true end
		if talker:GetPos():Distance(listener:GetPos()) < 750 then
			return (listener:Team() == talker:Team())
		else
			return false
		end
	end
	if talker:Team() == TEAM_SPEC then
		if listener:Team() == TEAM_SPEC then
			return true
		else
			return false
		end
	end
	if talker:GetNClass() == ROLE_SCP990 then
		if listener:HasWeapon("weapon_dream") then
			return true
		else
			return false
		end
	end
	if HaveRadio(listener, talker) == true then
		return true
	end
	return (talker:GetPos():Distance(listener:GetPos()) < 750)
end

function GM:PlayerDeathSound()
	return true
end

local function HasWeaponType(ply, t)
	for k,v in pairs(ply:GetWeapons()) do
		if v.ItemType == t then
			return true
		end
	end
	return false
end

local scp049_whitelist = {
["nope_sylveon_swep"] = true,
["tfa_csgo_127"] =  true,
["tfa_csgo_ak47"] = true,
["tfa_csgo_aug"] = true,
["tfa_csgo_awp"] = true,
["tfa_csgo_bizon"] = true,
["tfa_csgo_c4"] = true,
["tfa_csgo_cz75"] = true,
["tfa_csgo_deagle"] = true,
["tfa_csgo_decoy"] = true,
["tfa_csgo_elite"] = true,
["tfa_csgo_famas"] = true,
["tfa_csgo_fiveseven"] = true,
["tfa_csgo_flash"] = true,
["tfa_csgo_frag"] = true,
["tfa_csgo_g3sg1"] = true,
["tfa_csgo_galil"] = true,
["tfa_csgo_glock18"] = true,
["tfa_csgo_incen"] = true,
["tfa_csgo_m249"] = true,
["tfa_csgo_m4a1"] = true,
["tfa_csgo_m4a4"] = true,
["tfa_csgo_mac10"] = true,
["tfa_csgo_mag7"] = true,
["tfa_csgo_medishot"] = true,
["tfa_csgo_molly"] = true,
["tfa_csgo_mp5sd"] = true,
["tfa_csgo_mp7"] = true,
["tfa_csgo_mp9"] = true,
["tfa_csgo_nevgev"] = true,
["tfa_csgo_nova"] = true,
["tfa_csgo_p2000"] = true,
["tfa_csgo_p250"] = true,
["tfa_csgo_p90"] = true,
["tfa_csgo_revolver"] = true,
["tfa_csgo_sawedoff"] = true,
["tfa_csgo_scar20"] = true,
["tfa_csgo_sg556"] = true,
["tfa_csgo_smoke"] = true,
["tfa_csgo_sonarbomb"] = true,
["tfa_csgo_ssg08"] = true,
["tfa_csgo_tec9"] = true,
["tfa_csgo_ump45"] = true,
["tfa_csgo_usp"] = true,
["tfa_csgo_xm1014"] = true,
["tfa_csgo_zeus"] = true,
["item_eyedrops"] = true,
["item_medkit"] = true,
["item_radio"] = true,
["item_snav_300"] = true,
["item_snav_301"] = true,
["item_snav_ultimate"] = true,
["keycard_level1"] = true,
["keycard_level2"] = true,
["keycard_level3"] = true,
["keycard_level4"] = true,
["keycard_level5"] = true,
["keycard_omni"] = true,
["weapon_scp668"] = true,
["weapon_saturnalia"] = true,
["weapon_scp268"] = true,
["tfa_kf2rr_flamethrower"] = true,
["keycard_5"] = true,
["keycard_bg"] = true,
["keycard_bs"] = true,
["keycard_cg"] = true,
["keycard_en"] = true,
["keycard_fm"] = true,
["keycard_j"] = true,
["keycard_lt"] = true,
["keycard_ms"] = true,
["keycard_sg"] = true,
["keycard_zm"] = true,
["weapon_l4d2_crowbar"] = true,
["weapon_scp_500"] = true,
["item_scp330_blue"] = true,
["item_scp330_red"] = true,
["item_scp330_yellow"] = true
}
	
function GM:PlayerCanPickupWeapon( ply, wep )
	if ply.twepoverride and ply:GetNClass() == ROLE_SCP378 then return true end
	--if wep.IDK != nil or wep.Base == "tfa_csgo_base" or wep.Base == "tfa_3dcsgo_base" or wep.Base == "tfa_gun_base" or wep.Base == "tfa_bash_base" then
	--	for k,v in pairs(ply:GetWeapons()) do
	--		if wep.Slot == v.Slot then return false end
	--	end
	--end
	--if wep.clevel != nil then
	--	for k,v in pairs(ply:GetWeapons()) do
	--		if v.clevel then return false end
	--	end
	--end

	--if wep.IsSNAV then
	--	for k,v in pairs(ply:GetWeapons()) do
	--		if v.IsSNAV then return false end
	--	end
	--end
	if not wep.ItemType then
		wep.ItemType = WEAPON_OTHER or 11
	end
	if (wep.ItemType == WEAPON_DM or wep.ItemType == 13) and (ply.IsGhost and ply:IsGhost()) then
		return true
	end
	if ply:Team() == TEAM_SCP then
		if ply:GetNClass() == ROLE_SCP173 then
			return wep:GetClass() == "weapon_scp_173" or wep:GetClass() == "weapon_scp_173t"
		elseif ply:GetNClass() == ROLE_SCP106 then
			return wep:GetClass() == "weapon_scp_106"
		elseif ply:GetNClass() == ROLE_SCP049 then
			return wep:GetClass() == "weapon_scp_049"
		elseif ply:GetNClass() == ROLE_SCP0492 then
			return wep:GetClass() == "weapon_br_zombie"
		elseif ply:GetNClass() == ROLE_SCP457 then
			return wep:GetClass() == "weapon_scp_457"
		elseif ply:GetNClass() == ROLE_SCP817 then
			return wep:GetClass() == "weapon_scp_817" or wep:GetClass() == "weapon_scp_173" or wep:GetClass() == "weapon_scp_457" or wep:GetClass() == "weapon_scp096" or wep:GetClass() == "weapon_scp_682" or wep:GetClass() == "weapon_scp_1048" or wep:GetClass() == "weapon_scp066" or wep:GetClass() == "weapon_scp_1360" or wep:GetClass() == "weapon_scp966" or wep:GetClass() == "scp939" or wep:GetClass() == "weapon_scp_017" or wep:GetClass() == "weapon_372" or wep:GetClass() == "weapon_scp334" or wep:GetClass() == "weapon_scp363" or wep:GetClass() == "tfa_sim" or wep:GetClass() == "weapon_scp3199b" or wep:GetClass() == "tfa_dmc5_yamato" or wep:GetClass() == "weapon_scp_ww"
		elseif ply:GetNClass() == ROLE_SCP0082 then
			return wep:GetClass() == "weapon_br_zombie_infect"
		elseif ply:GetNClass() == ROLE_SCP096 then
			return wep:GetClass() == "weapon_scp096" or wep:GetClass() == "weapon_scp096t"
		elseif ply:GetNClass() == ROLE_SCP682 then
			return wep:GetClass() == "weapon_scp_682"
		elseif ply:GetNClass() == ROLE_SCP1048A then
			return wep:GetClass() == "weapon_scp_1048a"
		elseif ply:GetNClass() == ROLE_SCP066 then
			return wep:GetClass() == "weapon_scp066"
		elseif ply:GetNClass() == ROLE_SCP323 then
			return wep:GetClass() == "weapon_scp323"
		elseif ply:GetNClass() == ROLE_SCP607 then
			return wep:GetClass() == "weapon_scp607"
		elseif ply:GetNClass() == ROLE_SCP035 then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_SERPENT then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_SCP1861B then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_SCP1360 then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_MTFRRH and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_MTFSIG and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_MTFL2 and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_DRCLEF and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_MTFNU and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_MTFTAU5 and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_MTFNTF and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_MTFCOM and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_O51 and roundtype and roundtype.name and roundtype.name == "Human Zoo" then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		elseif ply:GetNClass() == ROLE_SCP2521 then
			return wep:GetClass() == "weapon-2521"
		elseif ply:GetNClass() == ROLE_SCP966 then
			return wep:GetClass() == "weapon_scp966"
		elseif ply:GetNClass() == ROLE_SCP939 then
			return wep:GetClass() == "scp939"
		elseif ply:GetNClass() == ROLE_SCP0762 then
			return wep:GetClass() == "weapon_scp_0762" or wep:GetClass() == "weapon_goodsword" or wep:GetClass() == "weapon_shuriken" or wep:GetClass() == "weapon_mor_silver_shortsword" or wep:GetClass() == "weapon_thehiddenblade"
		elseif ply:GetNClass() == ROLE_999 then
			return wep:GetClass() == "weapon_999"
		elseif ply:GetNClass() == ROLE_SCP427 then
			return wep:GetClass() == "weapon_scp427"
		elseif ply:GetNClass() == ROLE_SCP990 then
			return wep:GetClass() == "weapon_scp_990"
		elseif ply:GetNClass() == ROLE_212 then
			return wep:GetClass() == "weapon_212"	
		elseif ply:GetNClass() == ROLE_1048 then
			return wep:GetClass() == "weapon_scp_1048"
		elseif ply:GetNClass() == ROLE_178 then
			return wep:GetClass() == "weapon_178-1"
		elseif ply:GetNClass() == ROLE_SCP1048B then
			return wep:GetClass() == "weapon_1048b"
		elseif ply:GetNClass() == ROLE_SCP1048BR then
			return wep:GetClass() == "weapon_1048br"
		elseif ply:GetNClass() == ROLE_SCP1048C then
			return wep:GetClass() == "weapon_1048c"
		elseif ply:GetNClass() == ROLE_SCP1315A then
			return wep:GetClass() == "weapon_scp_1315a" or wep:GetClass() == "weapon_gameover"
		elseif ply:GetNClass() == ROLE_SCP1315B then
			return wep:GetClass() == "weapon_scp_1315b" or wep:GetClass() == "weapon_gameover"
		elseif ply:GetNClass() == ROLE_SCP1315C then
			return wep:GetClass() == "weapon_pistol" or wep:GetClass() == "weapon_stunstick" or wep:GetClass() == "weapon_smg1" or wep:GetClass() == "weapon_gameover"
		elseif ply:GetNClass() == ROLE_SCP017 then
			return wep:GetClass() == "weapon_scp_017"
		elseif ply:GetNClass() == ROLE_SCP610 then
			return wep:GetClass() == "weapon_scp610"
		elseif ply:GetNClass() == ROLE_SCP610B then
			return wep:GetClass() == "weapon_scp610b"
		elseif ply:GetNClass() == ROLE_SCP372 then
			return wep:GetClass() == "weapon_372"
		elseif ply:GetNClass() == ROLE_SCP082 then
			return wep:GetClass() == "tfa_nmrih_cleaver"
		elseif ply:GetNClass() == ROLE_SCP1471 then
			return wep:GetClass() == "weapon_scp1471"
		elseif ply:GetNClass() == ROLE_REDACTED then
			return wep:GetClass() == "weapon_redacted"
		elseif ply:GetNClass() == ROLE_SCP2845 then
			return wep:GetClass() == "weapon_scp2845"
		elseif ply:GetNClass() == ROLE_SCP334 then
			return wep:GetClass() == "weapon_scp334"
		elseif ply:GetNClass() == ROLE_SCP689 then
			return wep:GetClass() == "weapon_scp689"
		elseif ply:GetNClass() == ROLE_SCP378 then
			return wep:GetClass() == "weapon_scp363"
		elseif ply:GetNClass() == ROLE_SCP079 then
			return wep:GetClass() == "weapon_scp079"
		elseif ply:GetNClass() == ROLE_SCP011 then
		    return wep:GetClass() == "tfa_sim"
		elseif ply:GetNClass() == ROLE_SCP3331 then
			return wep:GetClass() == "tf2_combo_fists"
		elseif ply:GetNClass() == ROLE_SCP1959 then
			return wep:GetClass() == "weapon_scp1959"
		elseif ply:GetNClass() == ROLE_SCP3199 then
			return wep:GetClass() == "weapon_scp3199"
		elseif ply:GetNClass() == ROLE_SCP3199B then
			return wep:GetClass() == "weapon_scp3199b"
		elseif ply:GetNClass() == ROLE_SCP2301 then
			return wep:GetClass() == "tfa_dmc5_yamato"
		elseif ply:GetNClass() == ROLE_SCP2953 then
			return wep:GetClass() == "weapon_scp2953"
		elseif ply:GetNClass() == ROLE_SCP2953D then
			return wep:GetClass() == "swep_flamethrower_d2k"
		elseif ply:GetNClass() == ROLE_SCP2953C then
			return wep:GetClass() == "weapon_scp_2953_c"
		elseif ply:GetNClass() == ROLE_SCP2953L then
			return wep:GetClass() == "cat_grasstype"
		elseif ply:GetNClass() == ROLE_SCP2953M then
			return wep:GetClass() == "weapon_scp_2953_m"
		elseif ply:GetNClass() == ROLE_SCP2953G then
			return wep:GetClass() == "weapon_scp_2953_g"
		elseif ply:GetNClass() == ROLE_RANDOM then
			return wep:GetClass() == "weapon_random"
		elseif ply:GetNClass() == ROLE_SCP4715 then
			return wep:GetClass() == "weapon_scp4715"
		elseif ply:GetNClass() == ROLE_SCPWW then
			return wep:GetClass() == "weapon_scp_ww"
		elseif ply:GetNClass() == ROLE_SCP160 then
			return false
		elseif ply:GetNClass() == ROLE_SCP020 then
			if wep:GetClass() == "weapon_slam" then
				wep.ItemType = 11
				wep.Slot = 5
				wep.SlotPos = 2
			end
			if wep:GetClass() == "weapon_stunstick" then
				wep.ItemType = 3
				wep.Slot = 0
				wep.SlotPos = 2
			end
		
			if wep.ItemType and (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
				return false
			else
				return true
			end
		else
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP173 then
		if wep:GetClass() == "weapon_scp_173" or wep:GetClass() == "weapon_scp_173t" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP378 then
		if wep:GetClass() == "weapon_scp363" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP2521 then
		if wep:GetClass() == "weapon-2521" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP2845 then
		if wep:GetClass() == "weapon_scp2845" then
			return false
		end
	end

	if ply:GetNClass() != ROLE_SCP323 then
		if wep:GetClass() == "weapon_scp323" then
			return false
		end
	end
	--
	if ply:GetNClass() != ROLE_SCP082 then
		if wep:GetClass() == "tfa_nmrih_cleaver" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP106 then
		if wep:GetClass() == "weapon_scp_106" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP049 then
		if wep:GetClass() == "weapon_scp_049" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_REDACTED then
		if wep:GetClass() == "weapon_redacted" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP0492 then
		if wep:GetClass() == "weapon_br_zombie" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP334 then
		if wep:GetClass() == "weapon_scp334" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP096 then
		if wep:GetClass() == "weapon_scp096" or wep:GetClass() == "weapon_scp096t" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP607 then
		if wep:GetClass() == "weapon_scp607" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP682 then
		if wep:GetClass() == "weapon_scp_682" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP1048A then
		if wep:GetClass() == "weapon_scp_1048a" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP066 then
		if wep:GetClass() == "weapon_scp066" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP1471 then
		if wep:GetClass() == "weapon_scp1471" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP017 then
		if wep:GetClass() == "weapon_scp_017" then
			return false
		end
	end
 	if ply:GetNClass() != ROLE_SCP966 then
		if wep:GetClass() == "weapon_scp966" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP610 then
		if wep:GetClass() == "weapon_scp610" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP610B then
		if wep:GetClass() == "weapon_scp610b" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP939 then
		if wep:GetClass() == "scp939" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_178 then
		if wep:GetClass() == "weapon_178-1" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP0762 then
		if wep:GetClass() == "weapon_scp_0762" or wep:GetClass() == "weapon_goodsword" or wep:GetClass() == "weapon_shuriken" or wep:GetClass() == "weapon_mor_silver_shortsword" or wep:GetClass() == "weapon_thehiddenblade" then
			return false
		end
	end
	if ply:GetNClass() == ROLE_999 then
		return wep:GetClass() == "weapon_999"
	end
	if ply:GetNClass() == ROLE_SCP427 then
		return wep:GetClass() == "weapon_scp427"
	end
	if ply:GetNClass() == ROLE_SCP049 then
		return wep:GetClass() == "weapon_scp_049"
	end
	if ply:GetNClass() == ROLE_SCP939 then
		return wep:GetClass() == "scp939"
	end
	if ply:GetNClass() == ROLE_SCP079 then
		return wep:GetClass() == "weapon_scp079"
	end
	if ply:GetNClass() == ROLE_SCP173 then
		return wep:GetClass() == "weapon_scp_173t" or wep:GetClass() == "weapon_scp_173"
	end
	if ply:GetNClass() == ROLE_SCP990 then
		return wep:GetClass() == "weapon_scp_990"
	end
	if ply:GetNClass() == ROLE_SCP2953 then
		return wep:GetClass() == "weapon_scp2953"
	end
	if ply:GetNClass() == ROLE_SCP2953D then
		return wep:GetClass() == "swep_flamethrower_d2k"
	end
	if ply:GetNClass() == ROLE_SCP2953C then
		return wep:GetClass() == "weapon_scp_2953_c"
	end
	if ply:GetNClass() == ROLE_SCP2953L then
		return wep:GetClass() == "cat_grasstype"
	end
	if ply:GetNClass() == ROLE_SCP2953M then
		return wep:GetClass() == "weapon_scp_2953_m"
	end
	if ply:GetNClass() == ROLE_SCP2953G then
		return wep:GetClass() == "weapon_scp_2953_g"
	end
	if ply:GetNClass() == ROLE_2639A then
		return wep:GetClass() == "weapon_q1_shotgun" or wep:GetClass() == "weapon_q1_rocketlauncher" or wep:GetClass() == "weapon_q1_nailgun" or wep:GetClass() == "weapon_q1_lightninggun" or wep:GetClass() == "weapon_q1_grenadelauncher"
	end
	if ply:GetNClass() != ROLE_2639A then
		if wep:GetClass() == "weapon_q1_shotgun" or wep:GetClass() == "weapon_q1_rocketlauncher" or wep:GetClass() == "weapon_q1_nailgun" or wep:GetClass() == "weapon_q1_lightninggun" or wep:GetClass() == "weapon_q1_grenadelauncher" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_999 then
		if wep:GetClass() == "weapon_999" then
			return false
		end
    end
	if ply:GetNClass() != ROLE_SCP427 then
		if wep:GetClass() == "weapon_scp427" then
			return false
		end
    end
	if ply:GetNClass() != ROLE_SCP990 then
		if wep:GetClass() == "weapon_scp_990" then
			return false
		end
    end
    if ply:GetNClass() != ROLE_212 then
		if wep:GetClass() == "weapon_212" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_1048 then
		if wep:GetClass() == "weapon_scp_1048" then
			return false
		end
	end

	if ply:GetNClass() != ROLE_SCP1048B then
		if wep:GetClass() == "weapon_1048b" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP1048BR then
		if wep:GetClass() == "weapon_1048br" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP1048C then
		if wep:GetClass() == "weapon_1048c" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP1315A then
		if wep:GetClass() == "weapon_scp_1315a" or wep:GetClass() == "weapon_gameover" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP1315B then
		if wep:GetClass() == "weapon_scp_1315b" or wep:GetClass() == "weapon_gameover" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP1315C then
		if wep:GetClass() == "weapon_pistol" or wep:GetClass() == "weapon_smg1" or wep:GetClass() == "weapon_gameover" then
			return false
		end
	end
	if ply:GetNClass() != ROLE_SCP372 then
		if wep:GetClass() == "weapon_372" then
			return false
		end
	end

	if ply:GetNClass() != ROLE_SCP689 then
		if wep:GetClass() == "weapon_scp689" then
			return false
		end
	end

	if ply:GetNClass() != ROLE_SCP079 then
		if wep:GetClass() == "weapon_scp079" then
			return false
		end
	end

    if ply:GetNClass() != ROLE_SCP3331 then
        if wep:GetClass() == "tf2_combo_fists" then
            return false
        end
	end
	
	if ply:GetNClass() != ROLE_SCP1959 then
        if wep:GetClass() == "weapon_scp1959" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP817 then
        if wep:GetClass() == "weapon_scp_817" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP3199 then
        if wep:GetClass() == "weapon_scp3199" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP3199B then
        if wep:GetClass() == "weapon_scp3199b" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP2953 then
        if wep:GetClass() == "weapon_scp2953" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP2953D then
        if wep:GetClass() == "swep_flamethrower_d2k" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP2953C then
        if wep:GetClass() == "weapon_scp_2953_c" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP2953L then
        if wep:GetClass() == "cat_grasstype" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP2953M then
        if wep:GetClass() == "weapon_scp_2953_m" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP2953G then
        if wep:GetClass() == "weapon_scp_2953_g" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_RANDOM then
        if wep:GetClass() == "weapon_random" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP2301 then
        if wep:GetClass() == "tfa_dmc5_yamato" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCP4715 then
        if wep:GetClass() == "weapon_scp4715" then
            return false
		end
	end
	
	if ply:GetNClass() != ROLE_SCPWW then
        if wep:GetClass() == "weapon_scp_ww" then
            return false
		end
	end

    if ply:GetNClass() != ROLE_SCP011 then
       if wep:GetClass() == "tfa_sim" then return false end
    end

	if wep:GetClass() == "weapon_slam" then
		wep.ItemType = 11
		wep.Slot = 5
		wep.SlotPos = 2
	end
	if wep:GetClass() == "weapon_stunstick" then
		wep.ItemType = 3
		wep.Slot = 0
		wep.SlotPos = 2
	end

	if (wep.ItemType > 0 and wep.ItemType < 11) and HasWeaponType(ply, wep.ItemType) then
		return false
	end

	if ply:Team() != TEAM_SPEC then
		for k,v in pairs(ply:GetWeapons()) do
			if v:GetClass() == wep:GetClass() then
				return false
			end
		end
		--First, get ready to restore the SavedAmmo that we saved earlier. This is handled in base.
		ply.gettingammo = wep.SavedAmmo
		--Any StoredAmmo is given back to the player
		if wep.StoredAmmo and wep.Primary and wep.Primary.Ammo and wep.Primary.Ammo != "none" and wep.Primary.Ammo != "None" then
			ply:GiveAmmo(wep.StoredAmmo, wep.Primary.Ammo, true)
			wep.StoredAmmo = 0

		end
		return true
	else
		if wep:GetClass() == "weapon_bdm_ak47" or wep:GetClass() == "weapon_bdm_deagle" or wep:GetClass() == "weapon_bdm_mac10" or wep:GetClass() == "weapon_bdm_tmp" or wep:GetClass() == "weapon_bdm_usp" then return true else return false end
		return false
	end
end

function GM:PlayerCanPickupItem( ply, item )
	return !(ply:Team() == TEAM_SPEC)
end

function GM:AllowPlayerPickup( ply, ent )
	return !(ply:Team() == TEAM_SPEC or ply:Team() == TEAM_CLASSD or ply:Team() == TEAM_CLASSE or ply:Team() == TEAM_SCI or ply:Team() == TEAM_CHAOS or ply:Team() == TEAM_GUARD or ply:Team() == TEAM_SCP)
end
// usesounds = true,
function GM:PlayerUse( ply, ent )
	--print("ENT USED: "..ent:GetClass().." "..tostring(ent:GetPos()))
	if ply:Team() == TEAM_SPEC then return false end
	if ply:GetNClass() == ROLE_SCP990 or ply:GetNClass() == ROLE_PLAYER1 or ply:GetNClass() == ROLE_PLAYER2 or ply:GetNClass() == ROLE_PLAYER3 or ply:GetNClass() == ROLE_SCP1315A or ply:GetNClass() == ROLE_SCP1315B or ply:GetNClass() == ROLE_SCP1315C then return false end
	if ply.lastuse == nil then ply.lastuse = 0 end
	if ply.lastuse > CurTime() then return false end
	for k,v in pairs(MAPBUTTONS) do
		if v["pos"] == ent:GetPos() then
			//print("Found a button: " .. v["name"])
			if roundtype and roundtype.name == "Hide and Seek" then
				if v.blockhns then
					ply.lastuse = CurTime() + 1
					ply:PrintMessage(HUD_PRINTCENTER, "This door is disabled for this round type.")
					return false
				else
					return true
				end
			end
			if v.iscpdoor and preparing then
				ply.lastuse = CurTime() + 1
				ply:PrintMessage(HUD_PRINTCENTER, "Please wait until the round begins.")
				return false
			end
			if v.clevel != nil then
				--SCP-079 has level 3 access
				if ply:GetNClass() == ROLE_SCP079 and v.clevel <= 3 then
					return true
				end
				--SCP-1360 has level 2 access
				if ply:GetNClass() == ROLE_SCP1360 and v.clevel <= 2 and ply:GetActiveWeapon():GetClass() == "weapon_scp_1360" then
					return true
				end
				--SCP-181 has a chance of opening any door no matter the card access
				if ply:GetNClass() == ROLE_SCP181 and v.clevel <= 5 and math.random(1, 20) == 1 then
					ply:GiveAchievement("Locksmith")
					return true
				end
				--For SCP-350
				if ply:GetNWString("350", "unset") == "8" then
					if ply:GetAmmoCount(12) > 14 then
					ply:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
					ply:PrintMessage(3, "Contract Complete!")
					ply:StripWeapon("weapon_scp_350")
					ply:SetNWString("350", "clear")
					ply:SetNWString("Sign", "clear")
					else
					ply:GiveAmmo(1, "AlyxGun", true)
				end
			end
				if ply:CLevel() >= v.clevel then
					if v.usesounds == true then
						ply:EmitSound("KeycardUse1.ogg")
					end
					ply.lastuse = CurTime() + 1
					ply:PrintMessage(HUD_PRINTCENTER, "Access granted to " .. v["name"])
					if v["name"] == "Gate A" then
					if ply:HasWeapon("weapon_scp_005") then
					hook.Run("FOpenGateA")
					end
					end
					if v["name"] == "Gate B" then
					if ply:HasWeapon("weapon_scp_005") then
					hook.Run("OpenGateB")
					end
					end
					if v["name"] == "SCP-079" then
					if ply:HasWeapon("weapon_scp_005") then
					SetRDCState(false)
					hook.Run("Open079")
					end
					end
					return true
				else
					if v.usesounds == true then
						ply:EmitSound("KeycardUse2.ogg")
					end
					ply.lastuse = CurTime() + 1
					ply:PrintMessage(HUD_PRINTCENTER, "You need to have " .. v.clevel .. " clearance level to open this door.")
					return false
				end
			end
			if v.canactivate != nil then
				local canactivate = v.canactivate(ply, ent)
				if canactivate then
					if v.usesounds == true then
						ply:EmitSound("KeycardUse1.ogg")
					end
					ply.lastuse = CurTime() + 1
					ply:PrintMessage(HUD_PRINTCENTER, "Access granted to " .. v["name"])
					return true
				else
					if v.usesounds == true then
						ply:EmitSound("KeycardUse2.ogg")
					end
					ply.lastuse = CurTime() + 1
					if v.customdenymsg then
						ply:PrintMessage(HUD_PRINTCENTER, v.customdenymsg)
					else
						ply:PrintMessage(HUD_PRINTCENTER, "Access denied")
					end
					return false
				end
			end
		end
	end
	return true
end

function GM:CanPlayerSuicide( ply )
	return false
end
CreateConVar( "br_disablebhop", "0", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Allow/Disallow bhop" )
hook.Add("OnPlayerHitGround", "BreachAntiBhop", function (ply)
	if GetConVar("br_disablebhop"):GetBool() then
		local vel = ply:GetVelocity()
		ply:SetVelocity( Vector( -( vel.x / 2 ), -( vel.y / 2 ), 0 ) )
	end
end)