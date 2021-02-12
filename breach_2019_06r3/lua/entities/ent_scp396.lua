AddCSLuaFile()
ENT.Type = "anim"
ENT.Author = "Aurora"
ENT.PrintName = "SCP-396"

local VALID_ITEMS = {
    {
        model = "models/props/sl/keycard5.mdl",
        weight = 1,
        class = "keycard_5"
    },
    {
        model = "models/props/sl/keycardbg.mdl",
        weight = 10,
        class = "keycard_bg"
    },
    {
        model = "models/props/sl/keycardbs.mdl",
        weight = 20,
        class = "keycard_bs"
    },
    {
        model = "models/props/sl/keycarden.mdl",
        weight = 10,
        class = "keycard_en"
    },
    {
        model = "models/props/sl/keycardfm.mdl",
        weight = 5,
        class = "keycard_fm"
    },
    {
        model = "models/mishka/models/snav.mdl",
        weight = 10,
        class = "item_snav_ultimate"
    },
    {
        model = "models/mishka/models/snav.mdl",
        weight = 20,
        class = "item_snav_300"
    },
    {
        model = "models/mishka/models/radio.mdl",
        weight = 20,
        class = "item_radio"
    },
    {
        model = "models/vinrax/props/eyedrops.mdl",
        weight = 1, --fuck these tbh
        class = "item_eyedrops"
    },
    {
        model = "models/mishka/models/nvg.mdl",
        weight = 20,
        class = "weapon_nvg"
    },
    {
        model = "models/weapons/tfa_csgo/w_cz75.mdl",
        weight = 5,
        class = "tfa_csgo_cz75"
    },
    {
        model = "models/weapons/tfa_csgo/w_molotov.mdl",
        weight = 10,
        class = "tfa_csgo_molly"
    },
    {
        model = "models/weapons/tfa_csgo/w_frag.mdl",
        weight = 10,
        class = "tfa_csgo_frag"
    },
    {
        model = "models/weapons/tfa_csgo/w_flash.mdl",
        weight = 10,
        class = "tfa_csgo_flash"
    },
    {
        model = "models/weapons/tfa_csgo/w_fiveseven.mdl",
        weight = 10,
        class = "tfa_csgo_fiveseven"
    },
    {
        model = "models/umbrella.mdl",
        weight = 1,
        class = "weapon_scp512"
    },
    {
        model = "models/weapons/tfa_nmrih/w_me_kitknife.mdl",
        weight = 1,
        class = "weapon_scp668"
    },
    {
        model = "models/weapons/tfa_csgo/w_decoy.mdl",
        weight = 1,
        class = "weapon_saturnalia"
    }
}

function ENT:Initialize()
    --I know I put a weight field in, but I really want to try just randomly picking these, mostly because its less work
    local _, k = table.Random(VALID_ITEMS)
    self:SetModel(Model("models/props_c17/chair02a.mdl"))
    if SERVER then
        self:SetUseType(SIMPLE_USE)
        self:PhysicsInit(SOLID_VPHYSICS)
        local pobj = self:GetPhysicsObject()
        if pobj and IsValid(pobj) then
            pobj:EnableMotion(false)  
        end
        self:SetNWBool("HasItem", true)
        self:SetNWInt("Item", k)
    end
end

function ENT:Use()
    if SERVER and self:GetNWBool("HasItem", false) then
        self:SetNWBool("HasItem", false)
        local c_item = VALID_ITEMS[self:GetNWInt("Item", 1)]
        local item = ents.Create(c_item.class)
        if IsValid(item) then
            item:SetPos(self:GetPos() + Vector(0, 0, 30))
            item:Spawn()
            item:PhysWake()
        end
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
        local c_item = self:GetNWInt("Item", 1)
        local item = VALID_ITEMS[c_item]
        if self:GetNWBool("HasItem", false) then
        if not self.CachedModel or not IsValid(self.CachedModel) then
            self.CachedModel = ClientsideModel(item.model)
        end

        render.Model({
            model = item.model,
            pos = self:GetPos() + Vector(15, 5, 10),
            angle = Angle(0, math.sin(CurTime()) * 360, 0)
        }, self.CachedModel)
        end
    end
end

if game.GetMap() == "br_site19" then
 SPAWNS_SCP396 = {
    Vector(938.604614, 2229.036377, 15.102960),
    Vector(1563.449219, 1947.635132, 14.979135),
    Vector(2841.284180, 759.219299, 15.109101),
    Vector(2826.078613, 128.481583, 14.949167),
    Vector(1724.502563, 201.495651, 15.110741),
    Vector(792.677002, -696.458801, 14.932648),
    Vector(904.275879, -2030.771118, 15.130920),
    Vector(3148.933838, -1135.941162, -17.013586),
    Vector(5825.074219, -99.244041, 15.120751),
    Vector(5489.841309, 512.615540, -496.964600),
    Vector(4152.802246, 2320.257324, 15.071796),
    Vector(833.286316, 4475.877930, 14.976664),
    Vector(-1309.854980, 2648.691406, 14.959421)
 }
end

if SERVER then
hook.Add("BreachStartRound", "SpawnSCP396", function ()
    if SPAWNS_SCP396 then
        local e = ents.Create("ent_scp396")
        if IsValid(e) then
            e:SetPos(table.Random(SPAWNS_SCP396))
            e:Spawn()
        end
    end
end)
end