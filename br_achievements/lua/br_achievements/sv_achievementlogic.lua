ACH_ROUND_METADATA = {}

--There's probably some weird fucking bugs in this file.

hook.Add("BreachStartRound", "BreachStartRound_METADATACLEARACH", function ()
    ACH_ROUND_METADATA = {}
    for k,v in pairs(player.GetAll()) do
        v.HasHealed = false
        v.QMTWI = false
        v.QGB = true
        v.SubstanceAbuseCount = 0
        v.Heal939 = 0
        v.AlreadySaid = false
    end
end)

hook.Add("DoPlayerDeath", "DoPlayerDeath_ResetAchVars", function (ply)
    if ply and IsValid(ply) then
        ply.QGB = true
        ply.SubstanceAbuseCount = 0
    end
end)

//PrecisionShot

hook.Add("SCP076SwordHitPlayer", "SCP076SwordHitPlayer_Achievement", function (ply)
    if IsValid(ply) and ply:IsPlayer() and ( ply:GetNClass() == ROLE_SCP0762 or ply:GetNClass() == ROLE_SCP0762PB ) then
        ply.scp076trickkills = ply.scp076trickkills or 0
        ply.scp076trickkills = ply.scp076trickkills + 1
        if ply.scp076trickkills >= 5 then
            ply:GiveAchievement("PrecisionShot")
        end
    end
end)


//PoliceBrutality

hook.Add("DoPlayerDeath", "DoPlayerDeath_PoliceBrutAchievement", function (ply, att, dmg)
    local a = dmg:GetInflictor()
    if att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCP and ply and IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_SCP and a and IsValid(a) and a:GetClass() == "weapon_stunstick" then
        att:AddAchievementProgress("PoliceBrutality", 1)
    end
end)

hook.Add("BreachWinners", "BreachWinnersAchievements", function (winners, winner)
	for k,v in pairs(winners) do
		if v and IsValid(v) then
			ServerLog(v:Nick() .. " won!\n")
		end
	end
end)

//Tech

hook.Add("On079Escort", "On079Escort_Achievement", function (ply, p079)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SERPENT then
        ply:GiveAchievement("Tech")
    end
end)

//AbelandCain
hook.Add("DoPlayerDeath", "DoPlayerDeath_AbelandCain", function (ply, att, dmg)
    if IsValid(ply) and IsValid(att) and ply:IsPlayer() and att:IsPlayer() and ((ply:GetNClass() == ROLE_SCP0762 and att:GetNClass() == ROLE_SCP0762PB ) or (ply:GetNClass() == ROLE_SCP0762PB and att:GetNClass() == ROLE_SCP0762)) then
        ply:GiveAchievement("AbelandCain")
    end
end)

//TheATeam

hook.Add("BreachStartRound", "BreachStartRound_TheATeamSetup", function ()
    timer.Simple(1, function ()
        ACH_ROUND_METADATA.starting_scps = {}
        for k,v in pairs(player.GetAll()) do
            if v:Team() == TEAM_SCP then
                ACH_ROUND_METADATA.starting_scps[#ACH_ROUND_METADATA.starting_scps + 1] = v
            end
        end
        ACH_ROUND_METADATA.original_starting_scps = #ACH_ROUND_METADATA.starting_scps
    end)
end)

local function IsInTab(t, p)
    if not t then return false end
    for k,v in pairs(t) do
        if v == p then
            return true
        end
    end
    return false
end

hook.Add("DoPlayerDeath", "DoPlayerDeath_ATEAM", function (ply)
    if ply:Team() == TEAM_SCP and IsInTab(ACH_ROUND_METADATA.starting_scps, ply) then
        for k,v in pairs(ACH_ROUND_METADATA.starting_scps) do
            if ply == v then
                ACH_ROUND_METADATA.starting_scps[k] = nil
            end
        end
    end
end)

hook.Add("BreachEndRound", "BreachEndRound_ATeam", function ()
    if ACH_ROUND_METADATA.original_starting_scps == table.Count(ACH_ROUND_METADATA.starting_scps or {}) then
        for k,v in pairs(ACH_ROUND_METADATA.starting_scps or {}) do
            if v and IsValid(v) then
                v:GiveAchievement("TheATeam")
            end
        end
    end
end)

//DramaticEscape
hook.Add("BreachPlayerHealed", "BreachPlayerHealed_DramaticEscape", function (ply, ply2)
    if ply == ply2 then
        ply.HasHealed = true
    end
end)

hook.Add("BreachPlayerEscaped", "BreachPlayerEscaped_DramaticEscape", function (ply)
    if ply and IsValid(ply) and ply:GetNClass() == ROLE_SCP035 and not ply.HasHealed then
        ply:GiveAchievement("DramaticEscape")
    end
end)

//MTWI

hook.Add("OnNTFSpawn", "OnNTFSpawn_MTWI", function (ply)
    local e = GetGlobalFloat("br_round_end", CurTime() + 1000)
    if e - CurTime() <= 130 then
        if plys and istable(plys) then
            for k,v in pairs(plys) do
                if v and IsValid(v) and v:IsPlayer() and v:Team() != TEAM_SCP and v:Team() != TEAM_SPEC then
                    v.QMTWI = true
                end
            end
        end
    end
end)

hook.Add("DoPlayerDeath", "DoPlayerDeath_MTWI", function (ply, att, dmg)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_SCP and att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SPEC and att:Team() != TEAM_SCP and att.QMTWI and (att:Team() == TEAM_CHAOS or att:Team() == TEAM_GUARD) then
        att:GiveAchievement("MTWI")
    end
end)

//DroppinHammer

hook.Add("DoPlayerDeath", "DoPlayerDeath_Nu7Ach", function (ply, att, dmg)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_MTFNU and att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCI and att:Team() != TEAM_GUARD then
        att:AddAchievementProgress("DroppinHammer", 1)
    end
end)

//Nemesis

hook.Add("DoPlayerDeath", "DoPlayerDeath_Nemesis", function (ply, att, dmg)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_DRBRIGHT and att and IsValid(att) and att:IsPlayer() and att:Team() == TEAM_CHAOS and att:GetNClass() == ROLE_RES then
        att:AddAchievementProgress("Nemesis", 1)
    end
end)

//ShipSinker

hook.Add("DoPlayerDeath", "DoPlayerDeath_Ship", function (ply, att, dmg)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP1861B and att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCI and att:Team() != TEAM_GUARD then
        att:AddAchievementProgress("ShipSinker", 1)
    end
end)

//Mitch

hook.Add("DoPlayerDeath", "DoPlayerDeath_Mitch", function (ply, att, dmg)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:SteamID() == "STEAM_0:0:97517996" and att and IsValid(att) and att:IsPlayer() then
        att:AddAchievementProgress("Mitch", 1)
    end
end)

//Ghostbusters

hook.Add("EntityTakeDamage", "EntityTakeDamage_Ghostbusters", function (ply, dmg)
    local att = dmg:GetAttacker()
    if att and IsValid(att) and att:IsPlayer() and att:GetNClass() == ROLE_SCP966 and ply and IsValid(ply) and ply:IsPlayer() then
        ply.QGB = false
    end
    if att and IsValid(att) and att:IsPlayer() and ply and IsValid(ply) and ply:IsPlayer() and ply != att and att.QGB and ply:GetNClass() == ROLE_SCP966 and not att:HasWeapon("weapon_nvg")  then
        att:GiveAchievement("Ghostbusters")
    end
end)

//Assassin

hook.Add("DoPlayerDeath", "DoPlayerDeath_Assassin", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:GetNClass() == ROLE_MTFGUARD and att:Team() == TEAM_CHAOS and ply and IsValid(ply) and ply:IsPlayer() and (ply:Team() == TEAM_GUARD or ply:Team() == TEAM_SCI) then
        att:AddAchievementProgress("Assassin", 1)
    end
end)

//Debug


hook.Add("DoPlayerDeath", "DoPlayerDeath_ForScience", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and (att:Team() == TEAM_GUARD or att:Team() == TEAM_SCI or att:Team() == TEAM_SCP) and ply and IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_CLASSD then
        att:AddAchievementProgress("ForScience", 1)
    end
end)

//Conkreter


hook.Add("DoPlayerDeath", "DoPlayerDeath_Conkreter", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and (att:GetNClass() == ROLE_SCP173) and ply and IsValid(ply) and ply:IsPlayer() then
        att:AddAchievementProgress("Conkreter", 1)
    end
end)

//SubstanceAbuse

hook.Add("BreachPlayerHealed", "BreachPlayerHealed_Substanceabuse", function (p1, p2)
    if p1 and p2 and p1 == p2 and IsValid(p1) and p1:IsPlayer() then
        if not p1.SubstanceAbuseCount then
            p1.SubstanceAbuseCount = 0
        end
        p1.SubstanceAbuseCount = p1.SubstanceAbuseCount + 1
    end
    if p1.SubstanceAbuseCount >= 3 then
        p1:GiveAchievement("SubstanceAbuse")
    end
end)

//TheCure

hook.Add("SCP049Cure", "SCP049Cure_Achievement", function (p)
    if p and IsValid(p) and p:IsPlayer() then
        p:AddAchievementProgress("TheCure", 1)
    end
end)

//Debug

hook.Add("DoPlayerDeath", "DoPlayerDeath_Debug", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCP and ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP372 then
        att:AddAchievementProgress("Debug", 1)
    end
end)

//EFC

hook.Add("DoPlayerDeath", "DoPlayerDeath_EFC", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCP and att:GetActiveWeapon():GetClass() == "tfa_kf2rr_flamethrower" and ply and IsValid(ply) and ply:IsPlayer() and (ply:GetNClass() == ROLE_SCP3199 or ply:GetNClass() == ROLE_SCP3199B) then
        att:AddAchievementProgress("Debug", 1)
    end
end)

//Spaced

hook.Add("DoPlayerDeath", "DoPlayerDeath_Spaced", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCP and ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP1959 then
        att:AddAchievementProgress("Spaced", 1)
    end
end)

//BlueScreen

hook.Add("DoPlayerDeath", "DoPlayerDeath_BlueScreen", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:Team() != TEAM_SCP and ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP079 then
        att:GiveAchievement("BlueScreen")
    end
end)

//FactoryReset

hook.Add("DoPlayerDeath", "DoPlayerDeath_FactoryReset", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and ply and IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP1360 then
        att:AddAchievementProgress("FactoryReset", 1)
    end
end)

//Spy


hook.Add("PlayerRevealSCP939", "PlayerRevealSCP939_Achievement", function (ply)
    if ply and IsValid(ply) and ply:IsPlayer() then
        ply:AddAchievementProgress("Spy", 1)
    end
end)

//In order to earn the world traveler achievement

local ACHMAPS = string.Split(file.Read("excl_mapvote.txt", "DATA"), "\n")

hook.Add("BreachPlayerEscaped", "BreachPlayerEscaped_Achievemnt", function (ply)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:GetAchievementMetadata("WorldTraveler", game.GetMap(), "false") == "false" then
        ply:AddAchievementMetadata("WorldTraveler", game.GetMap(), "true") 
    end
    local f = true
    for k,v in pairs(ACHMAPS) do
        if ply:GetAchievementMetadata("WorldTraveler", v, "false") == "false" then
            f = false
        end
    end
    if f then
        ply:GiveAchievement("WorldTraveler")
    end
end)

//CandyMania


timer.Create("CandyManiaChecker", 5, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:HasWeapon("item_scp330_red") and v:HasWeapon("item_scp330_blue") and v:HasWeapon("item_scp330_yellow") then
            v:GiveAchievement("CandyMania")
        end
    end
end)

//CopyMe


timer.Create("CopyMeChecker", 5, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:HasWeapon("weapon_scp_038") then
            v:GiveAchievement("CopyMe")
        end
    end
end)

//UnlimitedPower


timer.Create("UnlimitedPowerChecker", 5, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:HasWeapon("keycard_5") then
            v:GiveAchievement("UnlimitedPower")
        end
    end
end)

//InfinitePower


timer.Create("InfinitePowerChecker", 5, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:HasWeapon("weapon_scp_005") then
            v:GiveAchievement("InfinitePower")
        end
    end
end)

//Dreamer


timer.Create("DreamerChecker", 5, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:HasWeapon("weapon_dream") then
            v:GiveAchievement("Dreamer")
        end
    end
end)

//SCPEnthusiast


timer.Create("SCPEnthusiastChecker", 5, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:HasWeapon("weapon_scp_005") and v:HasWeapon("weapon_scp_500") and v:HasWeapon("weapon_scp512") and v:HasWeapon("weapon_scp668") and v:HasWeapon("svn_kar98k") and v:HasWeapon("novoice") and v:HasWeapon("weapon_scp_1290") then
            v:GiveAchievement("SCPEnthusiast")
        end
    end
end)

//DoneRight

hook.Add("DoPlayerDeath", "DoPlayerDeath_DoneRight", function (ply, att)
    if att and IsValid(att) and att:IsPlayer() and att:Team() == TEAM_SCI and ply and IsValid(ply) and ply:IsPlayer() and ply:Team() == TEAM_SCP then
        att:GiveAchievement("DoneRight")
    end
end)

//MedicalDoctor

hook.Add("939HealPlayer", "939HealPlayer_A", function (p)
    if p and IsValid(p) and p:IsPlayer() then
        p.Heal939 = p.Heal939 + 5
    end
end)

hook.Add("BreachEndRound", "BreachEndRound_MedicalDoctor", function ()
    for k,v in pairs(player.GetAll()) do
        if v.Heal939 then
            v:AddAchievementProgress("MedicalDoctor", v.Heal939)
        end
    end
end)

//DeathFromBehind
local function IsLookingAt( att, ply )
	local yes = ply:GetAimVector():Dot( ( att:GetPos() - ply:GetPos() + Vector( 70 ) ):GetNormalized() )
	return (yes > 0.39)
end
hook.Add("DoPlayerDeath", "DoPlayerDeath_DEATHPACITO", function (ply, att)
    if ply and IsValid(ply) and ply:IsPlayer() and ply:Team() != TEAM_SCP and att and IsValid(att) and att:IsPlayer() and att:GetNClass() == ROLE_SCP173 and not IsLookingAt(att, ply) then
        v:AddAchievementProgress("DeathFromBehind", 1)
    end
end)

//bbq


hook.Add("DoPlayerDeath", "DoPlayerDeath_DEATHPACITO", function (ply, att, info)
    if not att.molokills then
        att.molokills = 0
    end
    local w = info:GetInflictor()
    if att and IsValid(att) and att:IsPlayer() and w and IsValid(w) and string.match(w:GetClass(), "molotov", 1) then
        att.molokills = att.molokills + 1
        local a = att
        timer.Simple(20, function ()
            if a and IsValid(a) and a:IsPlayer() then
                a.molokills = 0
            end
        end)
        if att.molokills >= 3 then
            att:GiveAchievement("bbq")
        end
    end
end)

//CursedWords

hook.Add("2521Said", "2521Said_Ach", function (ply)
    local is2521 = false
    for k,v in pairs(player.GetAll()) do
        if v:GetNClass() == ROLE_SCP2521 then
            is2521 = true
        end
    end
    if ply and IsValid(ply) and ply:IsPlayer() and is2521 and ply.AlreadySaid then
        ply:AddAchievementProgress("CursedWords", 1)
        ply.AlreadySaid = true
    end
end)

hook.Add("BreachWinners", "VictoryRoyaleAchievement", function (winners, winner)
    for k,v in pairs(winners) do
        if v and IsValid(v) and winner != TEAM_SPEC then
            v:AddAchievementProgress("VictoryRoyale", 1)
            if winner == TEAM_CLASSD then
                v:AddAchievementProgress("DDay", 1)
            elseif winner == TEAM_SCP then
                v:AddAchievementProgress("SCPWin", 1)
				v:AddAchievementProgress("SCPGod", 1)
            elseif winner == TEAM_CLASSE then
                v:GiveAchievement("EzWin", 10)
            end
        end
    end
end)

hook.Add("BreachSCPCollected", "BRSCPCOLLECTACH", function (ply, count)
    if count and count == 8 and ply and IsValid(ply) then
        ply:GiveAchievement("MrCollector")  
    end
end)

//NothingCanSaveYou

//Done in 049 and 610 files

//DimensionalDrift

//Done in 0762 file

