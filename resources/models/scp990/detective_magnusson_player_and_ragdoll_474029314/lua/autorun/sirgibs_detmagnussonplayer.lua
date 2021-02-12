local function AddPlayerModel( name, model )

    list.Set( "PlayerOptionsModel", name, model )
    player_manager.AddValidModel( name, model )
--    player_manager.AddValidHands( "DetectiveMagnusson", "models/weapons/c_arms_gor.mdl", 0, "00000000" )
	
end

AddPlayerModel( "detectivemagnusson", "models/sirgibs/ragdolls/detective_magnusson_player.mdl" )