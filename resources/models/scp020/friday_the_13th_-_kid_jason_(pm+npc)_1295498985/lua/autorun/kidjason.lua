if SERVER then
	AddCSLuaFile()
end

player_manager.AddValidModel("Kid Jason", "models/konnie/kidjason/kidjason.mdl")
player_manager.AddValidHands( "Kid Jason", "models/weapons/arms/v_arms_kidjason.mdl", 0, "00000000" )

local Category = "Friday the 13th"

local function AddNPC( t, class )
list.Set( "NPC", class or t.Class, t )
end

AddNPC( {
Name = "Kid Jason",
Class = "npc_citizen",
Category = Category,
Model = "models/konnie/kidjason/kidjason_f.mdl",
KeyValues = { citizentype = CT_UNIQUE, SquadName = "kidjasonnpc" }
}, "npc_kidjasonnpc_f" )
