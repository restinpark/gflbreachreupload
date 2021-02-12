player_manager.AddValidModel( 'Simon', 'models/wheatleymodels/soma/simon_divingsuit.mdl' )
player_manager.AddValidHands( 'Simon', 'models/weapons/c_arms_soma_simon.mdl', 0, '00000000' )

local NPC = {
	Name = 'Simon', 
	Class = 'npc_citizen',
	Model = 'models/wheatleymodels/soma/simon_divingsuit_citizen.mdl',
	Health = '100',
	KeyValues = { citizentype = 4 },
	Category = 'SOMA'
}

list.Set( 'NPC', 'npc_wheatley_soma_simon', NPC )

local NPC = {
	Name = 'Simon (Enemy)', 
	Class = 'npc_combine_s',
	Model = 'models/wheatleymodels/soma/simon_divingsuit_combine.mdl',
	Health = '100',
	KeyValues = { grenadecount = 0 },
	Category = 'SOMA'
}

list.Set( 'NPC', 'npc_wheatley_soma_simon_enemy', NPC )

if CLIENT then
	language.Add( 'npc_wheatley_soma_simon', 'Simon' )
	language.Add( 'npc_wheatley_soma_simon_enemy', 'Simon' )
end