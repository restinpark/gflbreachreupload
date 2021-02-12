ENT.Type = "anim"
ENT.Category = "SCPS"
ENT.PrintName = "SCP-216 HB"
ENT.Author = "chan_man1"

AddCSLuaFile()

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube1x1x1.mdl")
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNoDraw(true)
    if SERVER then
        --For breach, we'll automatically set our position and angles according to the map config, if no such globals exist, we'll remove ourselves
        if SPAWN_SCP216HB and isvector(SPAWN_SCP216HB) then
            self:SetPos(SPAWN_SCP216HB)
        else
            SafeRemoveEntity(self)
            return
        end
        self:SetUseType( SIMPLE_USE )
    end
end

hook.Add("AllowPlayerPickup", "AllowPlayerPickup_SCP216HB", function (ply, ent)
    --You need to change the class name for this to work if you rename the file
    if IsValid(ent) and ent:GetClass() == "scp_216_hb"then
        return false --Should prevent the player pickup
    end
end)

local SCP_216_HB_COMBOS = {
	{
       
        name = "37894702",
        func = function (ply)
			ply:Give("keycard_fm")
			ply:Give("tfa_l4d2_rocky_m500")
			ply:GiveAmmo(120, "Pistol")
			ply:Give("item_medkit")
			ply:PrintMessage(3, "It seems to be filled with some good stuff.")
        end,
        weight = 10,
        harmful = false
    },
	{
        
        name = "20394758473",
        func = function (ply)
			ply:Ignite(10)
			ply:PrintMessage(3, "Holy shit! It's full of fire!.")
        end,
        weight = 15,
        harmful = true
    },
	{
        
        name = "2983792",
        func = function (ply)
			ply:Give("item_medkit")
			ply:Give("item_snav_ultimate")
			ply:PrintMessage(3, "This could be useful.")
        end,
        weight = 20,
        harmful = false
    },
	{
        
        name = "09283738",
        func = function (ply)
			ply:PrintMessage(3, "Something flew out and stuck itself to me.")
			timer.Create("Gernade", 3, 1, function()
			local ent = ents.Create( "env_explosion" )
			ent:SetPos( ply:GetPos() )
			ent:Spawn()
			ent:SetKeyValue( "iMagnitude", "50" )
			ent:Fire( "Explode", 0, 0 )
			ent:EmitSound( "BaseExplosionEffect.Sound", 100, 100 )
			end)
        end,
        weight = 25,
        harmful = false
    },
	{
        
        name = "492383822",
        func = function (ply)
			ply:SetWalkSpeed(300)
			ply:SetRunSpeed(300)
			ply:SetMaxSpeed(300)
			ply:SetJumpPower(300)
			ply:PrintMessage(3, "Some sort of blue and orange liquid spilled onto me.")
        end,
        weight = 12,
        harmful = false
    },
	{
        
        name = "945784987",
        func = function (ply)
			ply:SetBleeding(true)
			ply:Give("weapon_scp668")
			ply:PrintMessage(3, "A bunch of knives spilled out!.")
        end,
        weight = 22,
        harmful = false
    },
	{
        
        name = "34667",
        func = function (ply)
			ply:Give("item_scp330_blue")
			ply:Give("item_scp330_red")
			ply:Give("item_scp330_yellow")
			ply:PrintMessage(3, "Looks like its full of candy.")
        end,
        weight = 28,
        harmful = false
    },
	{
        
        name = "934894",
        func = function (ply)
			ply:Give("tfa_csgo_bizon")
			ply:GiveAmmo(300, "SMG1")
			ply:PrintMessage(3, "Finally some serious firepower.")
        end,
        weight = 18,
        harmful = false
    },
	{
        
        name = "203938",
        func = function (ply)
			local ent = ents.Create( "armor_mtfguard" )
			ent:SetPos(ply:GetPos())
			ent:Spawn()
			ply:PrintMessage(3, "This outta keep me protected.")
        end,
        weight = 30,
        harmful = false
    },
	{
        
        name = "494833",
        func = function (ply)
			local ent = ents.Create( "ent_scp079_gas" )
			ent:SetPos(ply:GetPos())
			ent:Spawn()
			ply:PrintMessage(3, "I can't breathe!.")
        end,
        weight = 17,
        harmful = false
    },
	{
        
        name = "375854",
        func = function (ply)
			local ent = ents.Create( "infinitepizzaent" )
			ent:SetPos(ply:GetPos())
			ent:Spawn()
			ply:PrintMessage(3, "Smells good!")
        end,
        weight = 11,
        harmful = false
    },
	{
        
        name = "337372",
        func = function (ply)
			local ent = ents.Create( "ent_poke_ghostclaw" )
			ent:SetPos(ply:GetPos())
			ent:Spawn()
			ply:PrintMessage(3, "A black claw came out!")
        end,
        weight = 19,
        harmful = false
    },
	{
        
        name = "1892738974",
        func = function (ply)
			ply:Give("weapon_waterballoon")
			ply:PrintMessage(3, "What do I do with this?")
        end,
        weight = 35,
        harmful = false
    }
	
}

local function AddWeights()
    local num = 0
    for k,v in pairs(SCP_216_HB_COMBOS) do
        num = num + v.weight
    end
    return num
end

local function GetWeightedStories()
    local total_of_weights = AddWeights()
    local random_number = math.random(1, total_of_weights)
	for k,v in pairs(SCP_216_HB_COMBOS) do
		random_number = random_number - v.weight
		if random_number <= 0 then
			return v --Return this player, it will eventually return
		end
    end
    
    --Unexpected condition
	for k,v in pairs(SCP_216_HB_COMBOS) do
		return v --Since we're in error territory, get out ASAP
	end
end

--When the player uses the enity
--I don't really care about activator, useType, or value
function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SPEC and caller:Team() ~= TEAM_SCP and caller:GetNWBool("CanUse216_HB", true) then
        if SERVER then
            caller:SetNWBool("CanUse216_HB", false)
			if caller:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then
			caller:SetNWBool("CanUse216_HB", true) end
			if SERVER and caller:GetNWString("Sign", "unset") == "10" then
			caller:GiveAmmo(1, "AlyxGun", true)
			end
            local story = GetWeightedStories()
            caller:PrintMessage(3, "You open SCP-216 with the combination " .. story.name .. ".")
            story["func"](caller)
			if caller.GiveAchievement then
				caller:GiveAchievement("StorageWars")
			end
        end
    elseif SERVER and not caller:GetNWBool("CanUse216_HB", true) then
        caller:PrintMessage(3, "Its empty...")
    end
end

hook.Add("BreachStartRound", "BreachStartRound_216_HB", function ()
    for k,v in pairs(player.GetAll()) do
        v:SetNWBool("CanUse216_HB", true)
    end
end)
