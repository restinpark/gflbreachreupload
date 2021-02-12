local Category = "Resistance 2" --This is where the npc will show up
 
local NPC = {   Name = "Grim Friendly", 
                Class = "npc_citizen",
                Model = "models/player/r2_grim.mdl", 
                Health = "100", 
                KeyValues = { citizentype = 4 }, 
                Weapons = { "weapons_smg1" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_grim_ally", NPC )

local Category = "Resistance 2" --This is where the npc will show up
 
local NPC = {   Name = "Grim Hostile", 
                Class = "npc_combine",
                Model = "models/player/r2_grim.mdl", --Path to your model
                Health = "100", 
                Weapons = { "weapons_smg1" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_grim_hostile", NPC )