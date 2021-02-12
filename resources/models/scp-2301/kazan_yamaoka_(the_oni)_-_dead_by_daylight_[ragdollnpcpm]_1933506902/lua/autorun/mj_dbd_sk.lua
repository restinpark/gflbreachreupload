player_manager.AddValidModel( "Kazan Yamaoka (The Oni)", 				"models/players/mj_dbd_sk.mdl" )
list.Set( "PlayerOptionsModel",  "Kazan Yamaoka (The Oni)",				"models/players/mj_dbd_sk.mdl" )
player_manager.AddValidHands(	"Kazan Yamaoka (The Oni)", 				"models/players/mj_dbd_sk_arms.mdl", 0, "00000000" )

local Category = "Dead by Daylight" 

local NPC = { Name = "Kazan Yamaoka (The Oni) - Friendly", 
Class = "npc_citizen", 
Model = "models/players/mj_dbd_sk_npc.mdl", 
Health = "100", 
KeyValues = { citizentype = 4 }, 
Category = Category} 

list.Set( "NPC", "mj_dbd_sk_npc", NPC ) 
 
local NPC = {   Name = "Kazan Yamaoka (The Oni) - Enemy", 
                Class = "npc_combine",
                Model = "models/players/mj_dbd_sk_enemy.mdl",
                Health = "100", 
                Category = Category }
                               
list.Set( "NPC", "mj_dbd_sk_enemy", NPC )
