--fun function
local function cb363(victim, dmginfo, attacker)
    local name = victim:Nick()
    local role = victim:GetNClass()
    local wpns = victim:GetWeapons()
    local t = victim:Team()
    local wic = {}
    for k,v in pairs(wpns) do
        wic[#wic + 1] = v:GetClass()
    end
    attacker:SetModel(victim:GetModel())
    victim:KillSilent()
    attacker:SetNWString("SCP363_FakeRole", role)
    attacker:SetNWInt("SCP363_Team", t)
    attacker:SetNWFloat("SCP363_FakeHealth", 100)
    attacker:SetNWBool("SCP363_IsDisg", true)
    attacker:SetNWString("SCP363_FakeName", name)
    attacker.twepoverride = true
    for k,v in pairs(wic) do
        attacker:Give(v)
    end
    attacker.twepoverride = nil
    for k,v in pairs(wic) do
        local wt = weapons.GetStored(v)
        if wt and wt.Primary and wt.Primary.Ammo then
            attacker:GiveAmmo(200, wt.Primary.Ammo)
        end
    end
end

local function cb363_2(v)
    v:SetNWString("SCP363_FakeRole", "NULL")
    v:SetNWFloat("SCP363_FakeHealth", 0)
    v:SetNWBool("SCP363_IsDisg", false)
    v:SetNWBool("SCP363_FakeName", "NULL")
    v:SetNWInt("SCP363_Team", -1)
    v:SetModel(SCP_378_MODEL or "error.mdl")
    v:StripWeapons()
    v:Give("weapon_scp363")
end

timer.Create("DecreaseSCP363Health", 10, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:GetNClass() == ROLE_SCP378 and v:GetNWBool("SCP363_IsDisg", false) then
            v:GetNWFloat("SCP363_FakeHealth", v:GetNWFloat("SCP363_FakeHealth", 100) - math.random(2, 5))
            if v:GetNWBool("SCP363_FakeHealth", 100) <= 0 then
                cb363_2(v)
            end
        end
    end
end)

hook.Add("EntityTakeDamage", "HandlePlayerDeath_SCP363", function (victim, dmginfo)
    if victim and IsValid(victim) and victim:IsPlayer() and victim:Team() != TEAM_SCP and victim:Team() != TEAM_SPEC then
        local attacker = dmginfo:GetAttacker()
        if attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:GetNClass() == ROLE_SCP378 and not attacker:GetNWBool("SCP363_IsDisg", false) then
            local tdmg = dmginfo:GetDamage()
            if tdmg >= victim:Health() then
                --Fatal damage dealt, do the deed
                cb363(victim, dmginfo, attacker)
                return true
            end
        end
    elseif victim and IsValid(victim) and victim:IsPlayer() and victim:GetNClass() == ROLE_SCP378 and (dmginfo:GetDamageType() == DMG_SLOWBURN or dmginfo:GetDamageType() == DMG_BURN or dmginfo:GetDamageType() == DMG_SHOCK) and victim:GetNWBool("SCP363_IsDisg", false) then
        cb363_2(victim)
    elseif victim and IsValid(victim) and victim:IsPlayer() and victim:GetNClass() == ROLE_SCP378 then
        victim:SetNWFloat("SCP363_FakeHealth", victim:GetNWFloat("SCP363_FakeHealth", 100) - dmginfo:GetDamage())
        if victim:GetNWFloat("SCP363_FakeHealth", 100) <= 0 then
            cb363_2(victim)
        end
    end
end)