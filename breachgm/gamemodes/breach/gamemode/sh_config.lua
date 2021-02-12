--Config file for the breach gamemode
--Stuff that can't/is hard to expose via convars

--------[MODELS]--------

--The default guard armor model
MTF_GUARD_MODEL = "models/fart/ragdolls/css/counter_gign_player.mdl"

--The default commander armor model
MTF_COMM_MODEL = "models/player/riot.mdl"

--The default nine tailed fox armor model
NTF_ARMOR = "models/fart/ragdolls/css/counter_sas_player.mdl"

--The default chaos insurgency armor model
CHAOS_ARMOR = "models/mw2/skin_04/mw2_soldier_04.mdl"

--The model that guards/ntf/chaos insurgents wear under their armor
GUARD_UNARMORED_MODEL = "models/player/guerilla.mdl"

--SCP 939's model
SCP_939_MODEL = "models/scp/939/unity/unity_scp_939.mdl"

--Spawn 2639A MTF Unit
ENABLE_2639A = true
--Enable pandora's box
ENABLE_PB = true
--Enable ep9
ENABLE_FB = true

--------[GAMERULES]--------

--'true' will enable additional rdm protections. NOTE: Guards can still kill guards and researchers can still kill guards
BR_PREVENT_RDM = false

--Allow the warhead to be detonated
BREACH_ENABLE_ALPHA_WARHEAD = true

-------[KARMA SYSTEM]-------

--Use karma? (def: true)
BR_KARMA_ENABLE = true

--Starting karma is always 1000

--Max Karma (def: 1000)
BR_KARMA_MAX = 1100

--Enable Karma Damage reduction (def: true)
--90th percentile (> 900 karma def) is 100% damage, 80th percentile is 90%, 70 is 80%, etc etc
--A percentile is min_f_perc = karma - ((perc * 0.1) * 1000)
BR_KARMA_DAMAGE = true

--Punishment for having low karma, 0 = No Punishment, 1 = Kick, 2 = Ban (def: 2)
BR_KARMA_PUNISHMENT = 0

--When a user gets below this number, they will be punished for having low karma. Doesn't effect anything if BR_KARMA_PUNISHMENT is < 1
BR_KARMA_MIN = 550

--Ban time if banning is enabled
BR_KARMA_BANTIME = 60
if SERVER then
BR_KARMA_BANFUNC = function (ply)
    local sid = ply:SteamID()
    RunConsoleCommand("ulx", "sban", "$" .. sid, tostring(BR_KARMA_BANTIME), "Karma below limit (" .. tostring(BR_KARMA_MIN) .. ")")
end
end
--ROLE SEL
RS_USE_PARTIES = false
RS_USE_BOOSTERS = true

--DIFFICULTY SETTINGS
--Give SCPs an advantage
BR_ENABLE_DIFFICULTY = true

--Deprecated, does nothing
BR_SCP_DAMAGE_MULT = 1

--Multiply SCP damage by this amount (to increase or reduce)
SCP_SCALEDAMAGE = 0.65

--Want death sounds?
WANT_DEATHSOUNDS = false


--List of weapons where SCP_SCALEDAMAGE is ignored
NO_SCP_SCALEDAMAGE = {
    ["tfa_ins2_volk"] = true,
    ["weapon_crowbar"] = true,
    ["weapon_stunstick"] = true,
    ["weapon_l4d2_crowbar"] = true,
    ["tfa_csgo_frag"] = true,
    ["weapon_ar2"] = true
}

--Multipliers for SCP health depending on player count
 
function BREACH_GetSCPHPMult(num_players)
    if num_players < 8 then
        return 1
    elseif num_players < 11 then
        return 1.0
    elseif num_players < 16 then
        return 1.0
    elseif num_players < 25 then
        return 1.1
    elseif num_players < 35 then
        return 1.2
    elseif num_players < 46 then
        return 1.3
    elseif num_players < 56 then
        return 1.4
    elseif num_players < 66 then
        return 1.5
    elseif num_players < 75 then
        return 1.6
    else
        return 1.7
    end
    return 1
end
