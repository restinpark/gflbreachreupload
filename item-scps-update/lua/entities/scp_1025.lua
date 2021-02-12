ENT.Type = "anim"
ENT.Category = "Aurora's entities"
ENT.PrintName = "SCP-1025"
ENT.Author = "Aurora"

AddCSLuaFile()

--name = displayed to player
--func = function called to infect a player
--weight = higher weight means that it has a higher chance of being selected
--Generally, helpful effects are slightly more likely to be selected to encourage use of the book
local SCP_1025_DISEASES = {
    {
        --Real life condition which can cause internal bleeding.
        name = "Hemophilia",
        func = function (ply)
            ply:SetBleeding(true)
        end,
        weight = 2 * 20,
        harmful = true
    },
    {
        --Name means "healing plague"
        name = "Sanitatem pestis",
        func = function (ply)
            ply:SetHealth(ply:GetMaxHealth())
        end,
        weight = 3 * 20,
        harmful = false
    },
    {
        --Real life condition that causes weakness in the legs
        name = "Muscular Dystrophy",
        func = function (ply)
			ply:SetNWString("bad", "md")
            --They can only run slightly faster than they can walk
            ply:SetWalkSpeed(ply:GetRunSpeed() + 45)
        end,
        weight = 2 * 20,
        harmful = true
    },
    {
        --Real life condition that weakens your immune system, in-game it just weakens you.
        name = "AIDS",
        func = function (ply)
            ply:SetMaxHealth(75)
            ply:SetHealth(math.Clamp((ply:Health() / 100) * 75, 1, 75))
        end,
        weight = 2 * 20,
        harmful = true
    },
	{
        --Too many bones.
        name = "Osteopetrosis",
        func = function (ply)
            ply:SetArmor(100)
        end,
        weight = 2 * 20,
        harmful = false
    },
	{
        --Just built different.
        name = "Mors Praematura",
        func = function (ply)
			timer.Create("Heart", 1, 0, function()
			if ply:Health() == 0 or ply:Health() < 0 or ply:Team() == TEAM_SPEC then
			timer.Remove("Heart") end
			timer.Create("Beat", 1, 0, function()
			if ply:Health() == 5 or ply:Health() < 5 then
			ply:GodEnable()
			else
			ply:GodDisable()
			timer.Create("Blood", 60, 1, function()
			timer.Remove("Heart")
			timer.Remove("Beat")
			ply:GodDisable() 
			end)
			end
			end)
			end)
        end,
        weight = 2 * 10,
        harmful = false
    },
	{
        --Light pockets.
        name = "Alzheimer's",
        func = function (ply)
			timer.Create("Craze" .. ply:SteamID(), 60, 0, function()
			if ply:Health() == 0 or ply:Health() < 0 or ply:Team() == TEAM_SPEC then
			timer.Remove("Craze" .. ply:SteamID()) end
			if math.random(1, 2) == 2 then return end
			if ply:HasWeapon("keycard_fm") or ply:HasWeapon("keycard_lt") or ply:HasWeapon("item_medkit") or ply:HasWeapon("weapon_scp_500") then
			ply:PrintMessage(3, "Am I missing something?")
			ply:StripWeapon("keycard_fm")
			ply:StripWeapon("keycard_lt")
			ply:StripWeapon("item_medkit")
			ply:StripWeapon("weapon_scp_500")
			end
			end)
        end,
        weight = 2 * 25,
        harmful = true
    },
	{
        --Makes a person stronger beyond belief.
        name = "Myostatin",
        func = function (ply)
            ply:SetMaxHealth(150)
            ply:SetHealth(math.Clamp((ply:Health() / 100) * 150, 1, 150))
        end,
        weight = 2 * 10,
        harmful = false
    },
	{
        --Heart Attacker.
        name = "Cardiac Arrest",
        func = function (ply)
            ply:SetHealth(1)
			if math.random(1, 2) == 2 then
			ply:Kill() end
        end,
        weight = 2 * 20,
        harmful = false
    },
	{
        --Where am I?.
        name = "Glaucoma",
        func = function (ply)
			ply:SetNWString("bad", "g")
			ply:ScreenFade( SCREENFADE.MODULATE, Color( 255, 0, 0, 128 ), 5000, 5500 )
        end,
        weight = 2 * 20,
        harmful = true
    },
	{
        --Which way is up?.
        name = "Metamorphopsia",
        func = function (ply)
			timer.Create("Focus" .. ply:SteamID(), 5, 1, function()
			if ply:Health() == 0 or ply:Health() < 0 or ply:Team() == TEAM_SPEC then
			timer.Remove("Focus" .. ply:SteamID()) end
			ply:SetEyeAngles( AngleRand() )
			timer.Create("Eyed" .. ply:SteamID(), 1, 0, function() end)
			end)
        end,
        weight = 2 * 10,
        harmful = true
    },
	{
        --Better Regeneration.
        name = "Provectus Regeneratione",
        func = function (ply)
			timer.Create("Regen", 1, 0, function()
			if ply:Health() == 100 or ply:Health() > 100 then return end
			if ply:Health() == 0 or ply:Health() < 0 or ply:Team() == TEAM_SPEC then
			timer.Remove("Regen" .. ply:SteamID()) end
			ply:SetHealth(ply:Health() + 1) end)
        end,
        weight = 2 * 5,
        harmful = false
    },
    {
        --Name means "muscular strength"
        name = "Muscularis fortitudo",
        func = function (ply)
            ply:SetWalkSpeed(ply:GetWalkSpeed() + math.random(25, 40))
        end,
        weight = 3 * 20,
        harmful = false
    },
	{
        --Splash Zone.
        name = "SCP-081",
        func = function (ply)
            timer.Create("Boom" .. ply:SteamID(), 120, 1, function()
			if ply:Health() == 0 or ply:Health() < 0 or ply:Team() == TEAM_SPEC then
			timer.Remove("Boom" .. ply:SteamID()) end
			local ent = ents.Create( "env_explosion" )
			ent:SetPos( ply:GetPos() )
			ent:Spawn()
			ent:SetKeyValue( "iMagnitude", "50" )
			ent:Fire( "Explode", 0, 0 )
			ent:EmitSound( "BaseExplosionEffect.Sound", 100, 100 )
			for k,v in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
			local ent = ents.Create( "env_explosion" )
			ent:SetPos( v:GetPos() )
			ent:Spawn()
			ent:SetKeyValue( "iMagnitude", "50" )
			ent:Fire( "Explode", 0, 0 )
			ent:EmitSound( "BaseExplosionEffect.Sound", 100, 100 )
			end
			end)				
        end,
        weight = 1 * 10,
        harmful = true
    },
	{
        --Power to da legs
        name = "Secondary Polycythemia",
        func = function (ply)
            ply:SetWalkSpeed(ply:GetWalkSpeed() + math.random(50, 60))
			ply:SetJumpPower(ply:GetJumpPower() + math.random(100, 150))
        end,
        weight = 2 * 20,
        harmful = false
    },
    --Real life disease, causes fever, coughing, and eventual death.
    {
        name = "Pneumonic plague",
        func = function (ply)
            local p = ply
            timer.Simple(15, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(45, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(90, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(100, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(120, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(150, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(160, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(164, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(170, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            timer.Simple(175, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('cough.wav')")
                end
            end)
            hook.Add("BreachStartRound", "RemoveSCP1025Effects_" .. ply:SteamID(), function ()
                if IsValid(p) then
                    timer.Remove("SCP1025_KILL_" .. p:SteamID())
                    hook.Remove("BreachStartRound", "RemoveSCP1025Effects_" .. p:SteamID())
                end
                
            end)
            hook.Add("DoPlayerDeath", "RemoveSCP1025Effects_" .. ply:SteamID(), function (pl)
                if IsValid(p) and pl == p then
                    timer.Remove("SCP1025_KILL_" .. p:SteamID())
                    hook.Remove("DoPlayerDeath", "RemoveSCP1025Effects_" .. p:SteamID())
                end
                
            end)
            timer.Create("SCP1025_KILL_" .. ply:SteamID(), 180, 1, function ()
                if IsValid(p) then
                    p:SendLua("surface.PlaySound('gary.wav')")
                    p:Kill()
                    p:PrintMessage(3, "You died of the plague.")
                end
            end)
        end,
        weight = 1 * 20,
        harmful = true
    },
    {
        --Homage to LBGaming, new and improved!
        name = "Asthma",
        func = function (pl)
            if IsValid(pl) then
			pl:SetNWString("bad", "ass")
			timer.Create("Ass" .. pl:SteamID(), 5, 0, function()
			if pl:Health() == 0 or pl:Health() < 0 or pl:Team() == TEAM_SPEC then
			timer.Remove("Ass" .. pl:SteamID()) end
                pl:SetWalkSpeed(table.Random({250, 300, 90, 122, 521, 30, 111, 455, 55}))
				end)
                pl:PrintMessage(3, "yOu wOUldN'T uNDerStaNd.")
            end
        end,
        weight = 1,
        harmful = false
    },
	{
        --Big F
        name = "Kidney Failure",
        func = function (pl)
            if IsValid(pl) then
				pl:SetNWString("bad", "kf")
				pl:SetMaxHealth(1)
                pl:PrintMessage(3, "Just like your kidneys, you are also a failure.")
            end
        end,
        weight = 1 * 20,
        harmful = false
    }

}



resource.AddFile("models/mishka/models/scp1025.mdl")
resource.AddFile("materials/models/mishka/props/1025.vmt")
--resource.AddFile("sound/cough.wav")
--resource.AddFile("sound/gary.wav")
util.PrecacheModel("models/mishka/models/scp1025.mdl")
function ENT:Initialize()
    self:SetModel("models/mishka/models/scp1025.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:PhysWake()
    if SERVER then
        --For breach, we'll automatically set our position and angles according to the map config, if no such globals exist, we'll remove ourselves
        if SPAWN_SCP1025 and isvector(SPAWN_SCP1025) then
            self:SetPos(SPAWN_SCP1025)
        else
            SafeRemoveEntity(self)
            return
        end
        --Angle override by the map config so that we spawn at a normal looking angle
        --Unlike position, this isn't required and we won't self-remove if there isn't an angle to set
        if SPAWN_SCP1025_ANGLE and isangle(SPAWN_SCP1025_ANGLE) then
            self:SetAngles(SPAWN_SCP1025_ANGLE)
        end
        self:SetUseType( SIMPLE_USE )
    end
end

--Prevent the player from picking up the book
hook.Add("AllowPlayerPickup", "AllowPlayerPickup_SCP1025", function (ply, ent)
    --You need to change the class name for this to work if you rename the file
    if IsValid(ent) and ent:GetClass() == "scp_1025"then
        return false --Should prevent the player pickup
    end
end)

local function AddWeights()
    local num = 0
    for k,v in pairs(SCP_1025_DISEASES) do
        num = num + v.weight
    end
    return num
end

local function GetWeightedDisease()
    local total_of_weights = AddWeights()
    local random_number = math.random(1, total_of_weights)
	for k,v in pairs(SCP_1025_DISEASES) do
		random_number = random_number - v.weight
		if random_number <= 0 then
			return v --Return this player, it will eventually return
		end
    end
    
    --Unexpected condition
	for k,v in pairs(SCP_1025_DISEASES) do
		return v --Since we're in error territory, get out ASAP
	end
end

--When the player uses the enity
--I don't really care about activator, useType, or value
function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SPEC and caller:Team() ~= TEAM_SCP and caller:GetNWBool("CanUse1025", true) then
        if SERVER then
            caller:SetNWBool("CanUse1025", false)
			if SERVER and caller:GetNWString("Sign", "unset") == "10" then
			caller:GiveAmmo(1, "AlyxGun", true)
			end
            local disease = GetWeightedDisease()
            caller:PrintMessage(3, "You open SCP-1025 to a page about " .. disease.name .. ".")
            disease["func"](caller)
			if caller.GiveAchievement then
				caller:GiveAchievement("PlagueInc")
			end
        end
    elseif SERVER and not caller:GetNWBool("CanUse1025", true) then
        caller:PrintMessage(3, "You have already read the book.")
    end
end

hook.Add("BreachStartRound", "BreachStartRound_1025", function ()
    for k,v in pairs(player.GetAll()) do
        v:SetNWBool("CanUse1025", true)
    end
end)