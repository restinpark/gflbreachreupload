ENT.Type = "anim"
ENT.Category = "SCPS"
ENT.PrintName = "SCP-1425"
ENT.Author = "chan_man1"

AddCSLuaFile()

function ENT:Initialize()
  self:SetModel("models/props_lab/bindergreen.mdl")
 self:PhysicsInit(SOLID_VPHYSICS)
    self:PhysWake()
    if SERVER then
        --For breach, we'll automatically set our position and angles according to the map config, if no such globals exist, we'll remove ourselves
        if SPAWN_SCP1425 and isvector(SPAWN_SCP1425) then
            self:SetPos(SPAWN_SCP1425)
        else
            SafeRemoveEntity(self)
            return
        end
        --Angle override by the map config so that we spawn at a normal looking angle
        --Unlike position, this isn't required and we won't self-remove if there isn't an angle to set
        if SPAWN_SCP1425_ANGLE and isangle(SPAWN_SCP1425_ANGLE) then
            self:SetAngles(SPAWN_SCP1425_ANGLE)
        end
        self:SetUseType( SIMPLE_USE )
    end
end

hook.Add("AllowPlayerPickup", "AllowPlayerPickup_SCP1425", function (ply, ent)
    --You need to change the class name for this to work if you rename the file
    if IsValid(ent) and ent:GetClass() == "scp_1425"then
        return false --Should prevent the player pickup
    end
end)

local SCP_1425_STORIES = {
	{
        --A page about wanting to be a hero.
        name = "wanting to play the hero for once",
        func = function (ply)
            ply:SetMaxHealth(500)
			ply:SetHealth(500)
			ply:SetWalkSpeed(ply:GetWalkSpeed() + math.random(25, 40))
			ply:Give("weapon_scp_1425")
			ply:SetModel("models/dizcordum/knight_set.mdl")
        end,
        weight = 3,
        harmful = false
    },
	{
        --A page about a man without a care in the world.
        name = "pushing forward no matter what happens",
        func = function (ply)
			ply:Give("keycard_zm")
	    	ply:Give(table.Random({"tfa_doom_gauss", "deika_blundergat", "weapon_plasmacutter_bread", "weapon_beam"}))
			ply:Give("tfa_csgo_glock18")
			ply:GiveAmmo(120, "Pistol")
			ply:SetNWString("EClassF", table.Random({"a", "u", "b", "d", "c", "n"}))
            ply:SetMaxHealth(100)
			ply:SetHealth(100)
			ply:SetTeam(TEAM_CLASSE)
			ply:SetNClass(ROLE_CLASSE)
			ply:SetModel("models/player/gflbreach/class_e_default.mdl")
			ply:SetNoCollideWithTeammates(true)
			ply:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			ply.WasTeam = TEAM_CLASSE
        end,
        weight = 1,
        harmful = false
    },
	{
        --A page about a man foolish enough to end up in jail.
        name = "paying for your crimes with passion",
        func = function (ply)
            ply:SetMaxHealth(100)
			ply:SetHealth(100)
			ply:SetTeam(TEAM_CLASSD)
			ply:SetNClass(ROLE_CLASSD)
			ply:SetModel(ply:GetSciModel(TEAM_CLASSD))
			ply:SetNoCollideWithTeammates(true)
			ply:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			ply.WasTeam = TEAM_CLASSD
        end,
        weight = 10,
        harmful = false
    },
	{
        --A page about a man with greed beyond measure.
        name = "turning your back on others to gain enlightenment",
        func = function (ply)
            ply:SetMaxHealth(100)
			ply:SetHealth(100)
			ply:SetTeam(TEAM_CHAOS)
			ply:SetNClass(ROLE_RES)
			ply:SetModel(ply:GetSciModel(TEAM_SCI))
			ply:SetNoCollideWithTeammates(true)
			ply:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			ply.WasTeam = TEAM_SCI
        end,
        weight = 6,
        harmful = false
    },
	{
        --A page about pursuing dreams you never thought you had.
        name = "finding what makes the world go round",
        func = function (ply)
            ply:SetMaxHealth(100)
			ply:SetHealth(100)
			ply:SetTeam(TEAM_SCI)
			ply:SetNClass(ROLE_RES)
			ply:SetModel(ply:GetSciModel(TEAM_SCI))
			ply:SetNoCollideWithTeammates(true)
			ply:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			ply.WasTeam = TEAM_SCI
        end,
        weight = 8,
        harmful = false
    },
	{
        --A page about healing old wounds.
        name = "curing what ails you",
        func = function (ply)
			timer.Simple( 15, function() ply:Give("item_medkit") end  )
			timer.Simple( 15, function() ply:Give("item_scp207") end  )
        end,
        weight = 15,
        harmful = false
    },
	{
        --A page about finding salvation.
        name = "how to possibly escape from this situation",
        func = function (ply)
			timer.Simple( 60, function() ply:Give("item_snav_ultimate") end  )
			timer.Simple( 60, function() ply:Give("keycard_5") end  )
			timer.Simple( 60, function() ply:Give("tfa_csgo_deagle") end  )
			timer.Simple( 60, function() ply:GiveAmmo(120, "Pistol") end )
        end,
        weight = 11,
        harmful = false
    },
	{
        --A page about finding people to put your trust in.
        name = "how to make friends in this era",
        func = function (ply)
			timer.Simple( 10, function() ply:Give("item_radio") end  )
			timer.Simple( 10, function() ply:Give("keycard_zm") end  )
        end,
        weight = 20,
        harmful = false
    },
	{
        --A page about shooting for the moon.
        name = "looking at things from a different perspective",
        func = function (ply)
			timer.Simple( 5, function() ply:Give("weapon_nvg") end  )
			timer.Simple( 5, function() ply:Give("item_eyedrops") end  )
        end,
        weight = 30,
        harmful = false
    },
	{
        --A page with nothing to tell.
        name = "seeing the stars",
        func = function (ply)
        end,
        weight = 2 * 35,
        harmful = false
    }
}

local function AddWeights()
    local num = 0
    for k,v in pairs(SCP_1425_STORIES) do
        num = num + v.weight
    end
    return num
end

local function GetWeightedStories()
    local total_of_weights = AddWeights()
    local random_number = math.random(1, total_of_weights)
	for k,v in pairs(SCP_1425_STORIES) do
		random_number = random_number - v.weight
		if random_number <= 0 then
			return v --Return this player, it will eventually return
		end
    end
    
    --Unexpected condition
	for k,v in pairs(SCP_1425_STORIES) do
		return v --Since we're in error territory, get out ASAP
	end
end

--When the player uses the enity
--I don't really care about activator, useType, or value
function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SPEC and caller:Team() ~= TEAM_SCP and caller:GetNWBool("CanUse1425", true) then
        if SERVER then
            caller:SetNWBool("CanUse1425", false)
			if caller:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then
			caller:SetNWBool("CanUse216_HB", true) end
			if SERVER and caller:GetNWString("Sign", "unset") == "10" then
			caller:GiveAmmo(1, "AlyxGun", true)
			end
            local story = GetWeightedStories()
            caller:PrintMessage(3, "You open SCP-1425 to a page about " .. story.name .. ".")
            story["func"](caller)
			if caller.GiveAchievement then
				caller:GiveAchievement("Inspired")
			end
        end
    elseif SERVER and not caller:GetNWBool("CanUse1425", true) then
        caller:PrintMessage(3, "You already feel inspired to do something...")
    end
end

hook.Add("BreachStartRound", "BreachStartRound_1425", function ()
    for k,v in pairs(player.GetAll()) do
        v:SetNWBool("CanUse1425", true)
    end
end)
