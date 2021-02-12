local function AddPlayerModel( name, model )

    list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
    player_manager.AddValidHands( "SCP_GIGN_GUARD", "models/fart/arms/c_arms_css_ct.mdl", 0, "00000000" )	
    player_manager.AddValidHands( "SCP_SAS_NTF", "models/fart/arms/c_arms_css_ct.mdl", 0, "00000000" )	
    player_manager.AddValidHands( "SCP_GIGN_GUARD_Nomask", "models/fart/arms/c_arms_css_ct.mdl", 0, "00000000" )	
    player_manager.AddValidHands( "SCP_SAS_NTF_Nomask", "models/fart/arms/c_arms_css_ct.mdl", 0, "00000000" )		
end

AddPlayerModel( "SCP_GIGN_GUARD", "models/fart/ragdolls/css/counter_gign_player.mdl" )
AddPlayerModel( "SCP_SAS_NTF", "models/fart/ragdolls/css/counter_sas_player.mdl" )
AddPlayerModel( "SCP_GIGN_GUARD_Nomask", "models/fart/ragdolls/css/counter_gign_nomask_player.mdl" )
AddPlayerModel( "SCP_SAS_NTF_Nomask", "models/fart/ragdolls/css/counter_sas_nomask_player.mdl" )

//list.Set( "PlayerOptionsAnimations", "SCP_GIGN_GUARD", { "idle_knife" } )
//list.Set( "PlayerOptionsAnimations", "SCP_SAS_NTF", { "idle_knife" } )
//list.Set( "PlayerOptionsAnimations", "SCP_GIGN_GUARD_Nomask", { "idle_knife" } )
//list.Set( "PlayerOptionsAnimations", "SCP_SAS_NTF_Nomask", { "idle_knife" } )
