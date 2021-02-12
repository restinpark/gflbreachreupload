--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v17 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Dem hooks, bro												--
-- Auto-derived by scifi_base.lua								--
-- Also see scifi_globals.lua									--
-- Acc math, item and weapon drops as well as 					--
-- sfw_saphyre's life steal.									--
-- sfw_powerfist's damage protection.							--	
------------------------------------------------------------------

AddCSLuaFile()

hook.Add( "PlayerDeath", "AutoExtinguish_0", function( player )
	
	for k,v in pairs ( ents.FindInSphere( player:GetPos(), 128 ) ) do
		if ( v:GetOwner() == player || v == player ) then 
			v:Extinguish()
		end
	end

end )

local cmd_fx_firelight = GetConVar( "sfw_allow_firelightemission" )

hook.Add( "Think", "scififirefx", function()
	if ( !CLIENT ) then return end
	
	local bFire = cmd_fx_firelight:GetBool()
	
	if ( bFire ) then
		local index = ents.GetAll()
		
		for k, ent in pairs( index ) do 
			local bOnFire = ent:IsOnFire()
			
			if ( !bOnFire ) then continue end
		
			local pos = ent:GetPos()
			
			local iIndex = ent:EntIndex()
			
			local dlight = DynamicLight( iIndex )
			if ( dlight ) then
				dlight.pos = pos
				dlight.r = 255
				dlight.g = 90
				dlight.b = 25
				dlight.brightness = 1.4
				dlight.Decay = 2048
				dlight.Style = 1
				dlight.DieTime = CurTime() + 1
				
				local phys = ent:GetPhysicsObject()
				
				if ( IsValid( phys ) ) then
					local size = phys:GetMass()
					dlight.Size = 18 * size
				else
					dlight.Size = 320
				end
			end
		end
	end
end )

hook.Add( "EntityTakeDamage", "0_ScifiDamage", function( ent, dmginfo )

	local dmgAttacker = dmginfo:GetAttacker()
	local bBuffed = dmgAttacker:GetNWBool( "SciFiDmgBuff" )
	local dmgOrigin =  dmginfo:GetDamagePosition()
	
	if ( bBuffed ) then
		--if ( SERVER ) then
			dmginfo:ScaleDamage( 5 )
			dmginfo:SetDamageBonus( dmginfo:GetDamageBonus() * 5 )
			if ( GetConVar( "sfw_fx_particles" ):GetBool() ) then
				ParticleEffect( "vh_hit", dmgOrigin, Angle( 0, 0, 0 ), ent )
			end
		--end
	end
	
	local bDarkened = ent:GetNWBool( "dark_haunted" )
	if ( bDarkened ) then
		local dmgType = dmginfo:GetDamageType()
		
		if !( dmgType == DMG_SF_DARK ) then return end
		
		local iDarkStacks = ent:GetNWInt( "dark_haunted_stacks" )
		iDarkStacks = math.max( iDarkStacks, 1 )
		
		dmginfo:ScaleDamage( iDarkStacks )
		
		local aWeapon = dmginfo:GetInflictor()
		if ( aWeapon.CanLeechFromDark ) then
			local iHealth = dmgAttacker:Health()
			local iHealthMax = dmgAttacker:GetMaxHealth()
			
			local fHealBoost = 0.5 + math.max( ( 2 - ( iHealth / iHealthMax ) * 2 ), 0 )

			if ( iHealth > iHealthMax ) then
				dmgAttacker:SetHealth( iHealth + ( iDarkStacks * fHealBoost ) )
			else
				dmgAttacker:SetHealth( math.min( iHealth + ( iDarkStacks * fHealBoost ), iHealthMax ) )
			end
		end
		
		local iTargetHealth = ent:Health()
		local iDamage = dmginfo:GetDamage()
		if ( iTargetHealth - iDamage <= 0 ) || ( ent:IsPlayer() && !ent:Alive() ) then
			local eOrigin = ent:GetPos()
			local eEyePos = ent:EyePos()

			local vDropOrigin = ( eEyePos - eOrigin ) * 0.5
			vDropOrigin = vDropOrigin + eOrigin
			
			DoElementalEffect( { Element = EML_DISSOLVE_DARK, Attacker = dmgAttacker, Origin = vDropOrigin, Range = 16, Ticks = 12, DslvMaxMass = 500 } )
		
			if ( iDarkStacks > 2 ) then
				local iRange = 16 * ( 1 + iDarkStacks )
				for k,v in pairs( ents.FindInSphere( vDropOrigin, iRange ) ) do
					if !( v:IsNPC() || v:IsPlayer() ) then continue end
					if ( v == dmgAttacker ) then continue end
					
					DoElementalEffect( { Element = EML_DARK, Target = v, Attacker = dmgAttacker || Entity(0) } )
				end
				
				local fx = EffectData()
				fx:SetOrigin( vDropOrigin )
				fx:SetAngles( Angle( 0, 0, 0 ) )
				fx:SetRadius( 2.4 * ( 1 + iDarkStacks ) )
				fx:SetScale( 0.1 + 0.1 * iDarkStacks  )
				fx:SetEntity( self )
				fx:SetNormal( Vector( 1.2, 0.1, -0.1 ) )
				util.Effect( "scifi_aftershock", fx )
			end

			local iTargetMaxHealth = ent:GetMaxHealth()
			local iMax = math.max( iTargetMaxHealth * 0.02, 0 )
			
			for i=0, iMax do
				vDropOrigin = vDropOrigin + VectorRand() * ( 1 + iMax )
				
				local eDrop = ents.Create( "item_ammo_inferiant" )
				eDrop:SetPos( vDropOrigin )
				eDrop:Spawn()
			end
		end
	end

end )

hook.Add( "EntityTakeDamage", "SaphLifeSteal", function( ent, dmginfo )

	local attacker 	= dmginfo:GetAttacker()
	local saphyre 	= dmginfo:GetInflictor()
	
	if ( !IsValid( saphyre ) || saphyre:GetClass() ~= "saph_pfire" ) then return end
	local owner 	= saphyre:GetOwner()
	
	if ( SERVER ) then

	if ( ent ~= NULL && saphyre ~= NULL ) and ( ent ~= owner && dmginfo:GetDamageType() == bit.bor( DMG_RADIATION, DMG_GENERIC ) ) then

		if ( IsValid( owner ) ) && ( ent:IsNPC() || ent:IsPlayer() ) then
		
			local healthamt = math.Clamp( attacker:Health() + dmginfo:GetDamage() / math.random( 0.45, 2.8 ), 0 , attacker:GetMaxHealth() )
			
			if ( healthamt > 0 && attacker:Health() <= attacker:GetMaxHealth() ) then
			attacker:SetHealth( healthamt )
			end
			
			if ( GetConVar( "sfw_fx_particles" ):GetBool() ) then
				util.ParticleTracerEx( 
					"saphyre_absorb",
					saphyre:GetPos(),
					owner:EyePos() - Vector( 0, 0, 10 ),
					false,
					0,
					-1
				)
			end
			
		end
		
	end
	
	end

end )