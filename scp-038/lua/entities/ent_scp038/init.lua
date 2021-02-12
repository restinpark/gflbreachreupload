AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Configuration stuff
local TIME_GROW = 15
local PERC_FAIL = 10
local GROWABLE_ITEMS = {
    ["item_medkit"] = true,
    ["weapon_scp_500"] = true,
    ["tfa_csgo_bizon"] = true,
    ["tfa_csgo_glock18"] = true,
    ["tfa_csgo_deagle"] = true,
    ["tfa_csgo_cz75"] = true,
    ["tfa_csgo_ak47"] = true,
    ["tfa_csgo_aug"] = true,
    ["tfa_csgo_elite"] = true,
    ["tfa_csgo_famas"] = true,
    ["tfa_csgo_fiveseven"] = true,
    ["tfa_csgo_galil"] = true,
    ["tfa_csgo_m4a1"] = true,
    ["tfa_csgo_m4a4"] = true,
    ["tfa_csgo_m249"] = true,
    ["weapon_l4d2_crowbar"] = true,
    ["tfa_csgo_mac10"] = true,
    ["tfa_csgo_mag7"] = true,
    ["tfa_csgo_mp5sd"] = true,
    ["tfa_csgo_mp7"] = true,
    ["tfa_csgo_mp9"] = true,
    ["tfa_csgo_negev"] = true,
    ["tfa_csgo_nova"] = true,
    ["tfa_csgo_p90"] = true,
    ["tfa_csgo_p250"] = true,
    ["tfa_csgo_p2000"] = true,
    ["tfa_csgo_revolver"] = true,
    ["tfa_csgo_sawedoff"] = true,
    ["tfa_csgo_sg556"] = true,
    ["tfa_csgo_ssg08"] = true,
    ["tfa_csgo_tec9"] = true,
    ["tfa_csgo_ump45"] = true,
    ["tfa_csgo_usp"] = true,
    ["tfa_csgo_xm1014"] = true,
    ["tfa_csgo_127"] = true,
    ["tfa_csgo_smoke"] = true,
    ["tfa_csgo_flash"] = true,
    ["tfa_csgo_frag"] = true,
    ["tfa_csgo_incen"] = true,
    ["tfa_csgo_molly"] = true,
    ["tfa_csgo_decoy"] = true,
    ["nope_sylveon_swep"] = true,
    ["item_radio"] = true,
    ["weapon_nvg"] = true,
    ["item_snav_300"] = true,
    ["item_snav_ultimate"] = true,
    ["item_eyedrops"] = true,
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
    ["weapon_scp512"] = true,
    ["weapon_scp268"] = true,
    ["item_scp207"] = true,
}

--Utility table
local _keycardTiers = {
    [1] = {"keycard_j"}, --Is technically tier 2, but we have no tier one cards
    [2] = {"keycard_j", "keycard_ms", "keycard_bs"},
    [3] = {"keycard_bg", "keycard_zm", "keycard_en"},
    [4] = {"keycard_sg", "keycard_fm", "keycard_lt", "keycard_cg"},
    [5] = {"keycard_5"}
}

local function _getNewItem(weapon, class)
    --This is a keycard
    if weapon.clevel ~= nil and isnumber(weapon.clevel) then
        local lower = weapon.clevel - 1
        return table.Random(_keycardTiers[lower] or _keycardTiers[1])
    else --This is not a keycard
        return class
    end
end

--Make a weapon randomly fly out of a player's hands
local function _patchWeapon(wep)
    local _oldPrimaryAttack = wep.PrimaryAttack
    wep.PrimaryAttack = function (self)
        if math.random(0, 100) < PERC_FAIL then
            local owner = wep.Owner
            if IsValid(owner) then
                owner:DropWeapon(wep)
            end
            return false
        end
        return _oldPrimaryAttack(self)
    end
end


function ENT:Initialize()

    self:SetModel("models/props_foliage/tree_springers_01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableMotion(false)
    end
    self:SetModelScale(0.7)
end

ENT.LEventID = 0

function ENT:Use(ply)
    --Player should be valid but just in case
    if not ply or not IsValid(ply) then return end

    local wep = ply:GetActiveWeapon()

    --Player doesn't have anything in their hand
    if not wep or not IsValid(wep) then return end

    local wc = wep:GetClass()

    --Can't grow this
    if not GROWABLE_ITEMS[wc] then return end

    --We're already growing something...
    if EVENT_TIMERS[self.LEventID] then return end

    self.LEventID = BREACH_SetupEventTimer(ply, CurTime() + TIME_GROW, function () return false end, function ()
        local fruit = ents.Create(_getNewItem(wep, wc))
        if IsValid(fruit) then
            fruit:SetPos(self:GetPos() + Vector(0, 25, 50))
            fruit:Spawn()
            fruit.SCP038_PRODUCT = true

            --Put bullets in the gun too
            if fruit and fruit.SetClip1 and fruit.GetMaxClip1 then
                fruit:SetClip1(fruit:GetMaxClip1())
            end

            _patchWeapon(fruit)
        end
    end, "Growing " .. (wep.PrintName or wc))
end