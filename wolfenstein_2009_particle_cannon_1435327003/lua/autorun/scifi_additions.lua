--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v17 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: RPG functions and not required and additional stuff --
-- cvars and so on...											--
------------------------------------------------------------------
-- Initialized via autorun.										--
------------------------------------------------------------------

--AddCSLuaFile()

local fams = {
	[ "mtm" ] = { "sfw_grinder", "sfw_hellfire", "sfw_acidrain", "sfw_neutrino" },
	[ "hwave" ] = { "sfw_ember", "sfw_hwave", "sfw_phoenix", "sfw_seraphim" },
	[ "vprtec" ] = { "sfw_eblade", "sfw_fallingstar", "sfw_saphyre", "sfw_storm", "sfw_vapor" },
	[ "nxs" ] = { "sfw_pulsar", "sfw_stinger", "sfw_trace", "sfw_hornet" },
	[ "t3i" ] = { "sfw_blizzard", "sfw_cryon", "sfw_thunderbolt", "sfw_pandemic" },
	[ "dev" ] = { "sfw_custom", "sfw_ignis", "sfw_meteor", "sfw_powerfist", "sfw_hwave_tx", "sfw_pyre" },
	[ "ancient" ] = { "sfw_phasma", "sfw_alchemy", "sfw_prisma", "sfw_vectra", "sfw_astra", "sfw_supra", "sfw_zeala" }
}

local function GiveWeapon( ply, cmd, args )

	local input = args[1]
	local position = args[2]
	local mobdrop = args[3]
	
	if ( table.HasValue( table.GetKeys( fams ), input ) ) then
		for k,v in pairs ( fams[ input ] ) do 
			if ( position == "setpos" ) then
				local ent = ents.Create( v )
				if ( !IsValid( ent ) ) then return end	
				ent:SetPos( ply:GetEyeTrace().HitPos )
				ent:Spawn()
				ent:Activate()
				if ( mobdrop == "1" ) then
					ent:SetNWBool( "MobDrop", true )
				end
			else
				ply:Give( v )
			end
		end
	else
		MsgC( Color( 255, 80, 80 ), "@SciFiWeapons : !Error, Unknown family type.\n" )
	end

end

local function AutoComplete( cmd, stringargs )

	stringargs = string.Trim( stringargs )
	stringargs = string.lower( stringargs )

	local tbl = {}

	for k, v in pairs( table.GetKeys( fams ) ) do
		local set = v
		if string.find( string.lower( set ), stringargs ) then
			set = cmd.." "..set
			table.insert( tbl, set )
		end
	end

	return tbl
	
end

concommand.Add( 
	"sfw_give", 
	
	GiveWeapon, -- callback

	AutoComplete, -- autocomplete

	"Gives the player a certain pack of weapons depending on the given weapon family. Type 'setpos' behind the family to spawn the weapons where you're looking at and '1' at the end, to force it to drop in rng mode.", -- helptext
	
	0 -- cvar enums
)

local function ForceChaos()

	for k,v in pairs( ents.GetAll() ) do 
		if ( v:IsNPC() ) then 
			for k,x in pairs( ents.FindInSphere( v:GetPos(), 1024) ) do
				if ( x:IsNPC() ) then
					v:AddEntityRelationship( x, D_HT, 99 )
				end
				if ( x:IsPlayer() ) then
					v:AddEntityRelationship( x, D_NU, 1 )
				end
				v:SetSchedule( SCHED_WAKE_ANGRY )
			end 
		--	v:Fire( "setsquad", "", 0 )
		--	v:Fire( "updateenemymemory", "", 0 )
		end
	end

end

concommand.Add( 
	"sfw_forcechaos", 
	
	ForceChaos, -- callback

	nil, -- autocomplete

	"Causes a rampage...", -- helptext
	
	0 -- cvar enums
)

CreateClientConVar( "vh_campaign", "0", true, false )

local actions = { 
"add",
"remove",
"clear",
"print"
}

local function Loadout( ply, cmd, args )

	local action = args[1]
	local classname = args[2]
	local cmdmsgclr = Color( 200, 175, 255 )
	
	if ( !table.HasValue( actions, action ) ) then
		MsgC( Color( 255, 80, 80 ), "!Error; Unknown action!\n" )
		return
	end
		
	if ( action == "print" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = file.Read( "vh_loadout.txt", "DATA" )
			local tab = util.JSONToTable( content ) 
			
			MsgC( cmdmsgclr, "DATA/vh_loadout.txt: \n" )
			if ( tab ) then
				for k,v in pairs ( tab ) do
					print( v )
				end
			else
				MsgC( cmdmsgclr, "!Warning, Save file contains no data." )
			end
		else
			MsgC( cmdmsgclr, "!Error, failed to locate save file!\n" )
		end
	end

	if ( action == "clear" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = file.Read( "vh_loadout.txt", "DATA" )

			file.Write( "vh_loadout.txt", "" )
			
			MsgC( cmdmsgclr, "!Warning; DATA/vh_loadout.txt has been cleared!\n" .. content .. "\n" )
		else
			MsgC( cmdmsgclr, "!Error; failed to locate save file!\n" )
		end
	end
	
	if ( action == "add" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = util.JSONToTable( file.Read( "vh_loadout.txt", "DATA" ) )

			MsgC( cmdmsgclr, "Saving loadout...\n" )
			
			if ( content == nil ) then
				content = {}
			end
			
			if ( !table.HasValue( content, classname ) ) then
				table.Add( content, { classname } )

				file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
				
				MsgC( cmdmsgclr, "Done!\n" )
			else
				MsgC( cmdmsgclr, "!Error; Weapon is already listed in save file.\n" )
			end
		else
			MsgC( cmdmsgclr, "!Error, failed to locate save file. Creating new one...\n" )
			MsgC( cmdmsgclr, "Saving loadout...\n" )
			
			file.Write( "vh_loadout.txt", classname )
			
			MsgC( cmdmsgclr, "Done!\n" )
		end
	end
	
	if ( action == "remove" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = util.JSONToTable( file.Read( "vh_loadout.txt", "DATA" ) )

			
			if ( content == nil ) then
				MsgC( cmdmsgclr, "!Error, Save file contains no data.\n" )
			else
				MsgC( cmdmsgclr, "Saving loadout...\n" )
				
				table.RemoveByValue( content, classname )

				file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
				
				MsgC( cmdmsgclr, "Done!\n" )
				MsgC( cmdmsgclr, "Removed " .. classname .. " from loadout save!\n" )
			end
		else
			MsgC( cmdmsgclr, "!Error, failed to locate save file!\n" )
		end
	end

end

local function GetLoadout()
	local cmdmsgclr = Color( 200, 175, 255 )
	
	if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
		local content = file.Read( "vh_loadout.txt", "DATA" )
		local tab = util.JSONToTable( content ) 
		
		MsgC( cmdmsgclr, "DATA/vh_loadout.txt: \n" )
		
		return tab
	else
		MsgC( cmdmsgclr, "!Error, failed to locate save file!\n" )
		local tab = { "sfw_basetest", "sfw_frag" }
		return tab
	end
end

concommand.Add( 
	"vh_campaign_loadout", 
	Loadout,
	nil, 
	"Change the loadout that is auto-given to the player on spawn. Actions are: 'add', 'remove', 'clear' and 'print'. Structure is: *action* *classname*. Print will just dump the current save data's contents to the console. Note, that if the file is not present yet, you'll need to use 'add' in order to create a new one.", 
	{ FCVAR_DONTRECORD }
)

concommand.Add( 
	"vh_campaign_loadout_give", 
	function( player, command, arguments, args )
		local cmd_storymode = GetConVar( "vh_campaign" ):GetBool()
		local cmdmsgclr = Color( 200, 175, 255 )
		
		if ( cmd_storymode ) then
			local content = file.Read( args .. ".txt", "DATA" )

			if ( !content ) then
				MsgC( cmdmsgclr, "!Error; Loadout save not found!\n" )
				return
			end
			
			local loadout = util.JSONToTable( content ) 
			
			MsgC( cmdmsgclr, "DATA/" .. args .. ".txt: \n" )
	
			if ( loadout ) then
				for i, weapon in pairs( loadout ) do
					player:Give( weapon )
				end
			end
		else
			MsgC( "!Error; Game not running in story mode!\n" )
		end
	end, 
	nil, 
	"", 
	{ FCVAR_DONTRECORD }
)

CreateClientConVar( "vh_campaign_loadout_autocompose", "0", true, false )
 
concommand.Add( 
	"vh_campaign_removegear", 
	function( player, command, arguments, args )
		local cmd_storymode = GetConVarNumber( "vh_campaign" )
		local cmdmsgclr = Color( 200, 175, 255 )
		
		if ( cmd_storymode >= 1 ) then
			player:StripWeapons()
			MsgC( cmdmsgclr, "Done!\n" )
		else
			MsgC( "!Error; Game not running in story mode!\n" )
		end
	end, 
	nil, 
	"Disarms the player.", 
	{ FCVAR_DONTRECORD }
)

concommand.Add( 
	"vh_campaign_holsterweapon", 
	function( player, command, arguments, args )
		if ( !player:Alive() ) then return end
		
		local wep = player:GetActiveWeapon()
		if ( IsValid( wep ) ) then
			player:SetActiveWeapon( "" )
		end
		
		player:DrawViewModel( false, 0 )
	end, 
	nil, 
	"Disarms the player.", 
	{ FCVAR_DONTRECORD }
)

concommand.Add( 
	"vh_campaign_dropweapon", 
	function( player, command, arguments, args )
		local cmd_storymode = GetConVarNumber( "vh_campaign" )
		local cmdmsgclr = Color( 200, 175, 255 )
		
		if ( !player:Alive() ) then return end
		
		local wep = player:GetActiveWeapon()
		if ( !IsValid( wep ) ) then return end
		
		player:DropWeapon( wep )

		if ( arguments[1] == "keep" ) && ( !player:KeyDown( IN_USE ) ) then return end

		if ( cmd_storymode >= 1 ) then
			local content = util.JSONToTable( file.Read( "vh_loadout.txt", "DATA" ) )

			if ( content == nil ) then
				MsgC( cmdmsgclr, "!Error, Save file contains no data.\n" )
			else
				MsgC( cmdmsgclr, "Saving loadout...\n" )
				
				local classname = wep:GetClass()
				
				content[ classname ] = nil
				
				local notify = {
					MessageType = 0,
					id = "update",
					Message = classname .. " has been removed from the inventory",
					Color = Color( 240, 160, 20, 180 )
				}

				net.Start( "mana_challenge_notify" )
				net.WriteTable( notify )
				net.Send( player )

				file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
				
				MsgC( cmdmsgclr, "Done!\n" )
				MsgC( cmdmsgclr, "Removed " .. classname .. " from loadout save!\n" )
			end
		else
			MsgC( "!Error; Game not running in story mode!\n" )
		end
	end, 
	nil, 
	"Drops the weapon currently held by the player and removes it from the invetory (add 'keep' as an argument, if you want to maintain it in your inventory).", 
	{ FCVAR_DONTRECORD }
)

hook.Add( "PlayerSpawn", "OnSpawnApplyStoryLoadout", function( ply )

	local cmd_storymode = GetConVarNumber( "vh_campaign" )
	
	if ( cmd_storymode >= 1 ) then
		if ( SERVER ) then
			ply.LastSpawn = CurTime()
		
			timer.Simple( 0.2, function() 
				ply:StripWeapons()
				
				local loadout = GetLoadout()
				if ( loadout ) then
					for i, weapon in pairs( loadout ) do
						local pWeapon = ply:Give( weapon.Class )

						if ( weapon.Component ) then
							if ( !IsValid( pWeapon ) ) then return end
							
							pWeapon.Component.FirstTime = -1
							pWeapon.Component = weapon.Component
							pWeapon.Component.FirstTime = -1
						end
					end
				end
			end )
		end
	end

end )

CreateClientConVar( "vh_rtlight_maxprojextures", "10", true, false )
CreateClientConVar( "vh_rtlight_brightness", "1", true, false )
CreateClientConVar( "vh_rtlight_color", "255 255 255 255", true, false )

concommand.Add( 
	"vh_rtlight_overridespotlights", 
	function( player, command, arguments, args )
		if ( SERVER ) then
			
			local cmdmsgclr = Color( 200, 175, 255 )
			
			local counter = 0
			local cmd_limit = GetConVarNumber( "vh_rtlight_maxprojextures" )
			local cmd_color = GetConVarString( "vh_rtlight_color" )
			local cmd_brightness = GetConVarNumber( "vh_rtlight_brightness" )	
		
			local colormod = string.ToColor( cmd_color )

			local color = Format( "%i %i %i 255", colormod.r * cmd_brightness, colormod.g * cmd_brightness, colormod.b * cmd_brightness )

			local targetclass = "point_spotlight" 

			if ( args == "uselegacy" ) then
				targetclass = "light"
			end
			
			local targets = ents.FindByClass( targetclass )
			local checkback = ents.FindByName( "realtimelight" )
			
			MsgC( cmdmsgclr, "Fetching spotlights ... " .. #targets .. " found.\n" )
			
			if ( #checkback > 0 ) then
				for k, v in pairs ( checkback ) do
					v:Remove()
				end
				MsgC( cmdmsgclr, "!Warning; Detected already existing realtimelights... removing!\n" )
			end
			
			for k, v in pairs ( targets ) do
				if ( cmd_limit > counter ) then
					local spotvars = v:GetKeyValues()
					
					if ( !spotvars.SpotlightWidth ) then
						spotvars.SpotlightWidth = 50
					end
					
					if ( !spotvars.SpotlightLength ) then
						spotvars.SpotlightLength = 1
					end
					
					local realtime = ents.Create( "env_projectedtexture" )
					realtime:SetKeyValue( "targetname", "realtimelight" )
					realtime:SetPos( v:GetPos() )
					realtime:SetAngles( v:GetAngles() )	
					realtime:SetParent( v )		
					realtime:SetKeyValue( "lightfov", spotvars.SpotlightWidth * 1.5 )
					realtime:SetKeyValue( "lightworld", 1 )	
					realtime:SetKeyValue( "lightcolor", color )
					realtime:SetKeyValue( "enableshadows", 1 )
					realtime:SetKeyValue( "farz", 1768 + spotvars.SpotlightLength )
					realtime:SetKeyValue( "nearz", 16 )
					realtime:Fire( "SpotlightTexture", "effects/flashlight/hard", 0 )
					
					v:SetKeyValue( "rendercolor", "0 0 0" )
					v:Fire( "TurnOff", "", 0 )
					
					local flare = ents.Create( "env_lensflare" )
					flare:SetPos( v:GetPos() + realtime:GetAngles():Forward() * 2 )
					flare:SetAngles( v:GetAngles() )	
					flare:SetParent( realtime )
					flare:Spawn()
			--		ParticleEffectAttach( "flare_halo_0", 1, realtime, -1 )
					counter = counter + 1
				end
			end
			
			MsgC( cmdmsgclr, counter .. " realtimelights have been created.\n" )
			
			if ( #targets > counter ) then
				MsgC( cmdmsgclr, "!Error; Can't create more realtimelights! Limit exceeding!\n" )
			end
		end
	end, 
	nil, 
	"", 
	{ FCVAR_DONTRECORD }
)

-- local candrop = true

local function GetInventory( pEntity )

	local pInventory = pEntity:GetWeapons()
	local pIList = {}
	
	for i = 1, #pInventory do 
		local iEntity = pInventory[ i ]
		
		if ( !IsValid( iEntity ) ) then continue end
		local slot = iEntity:GetClass()
		
		table.insert( pIList, i, slot )
	end
	
	return pIList

end

local function GetInventorySlots( pEntity )

	local pInventory = pEntity:GetWeapons()
	local pSlots = {}
	
	for i = 1, #pInventory do 
		local iEntity = pInventory[ i ]
		
		if ( !IsValid( iEntity ) ) then continue end
		local slot = iEntity:GetSlot()
		
		table.insert( pSlots, i, slot )
	end
	
	return pSlots

end

local offset = 0
local iAlpha = 0

local function InvetoryDrawItem( PosX, PosY, entity, alpha )

	local CurX, CurY = input.GetCursorPos()
	CurX = CurX / 256
	CurY = CurY / 256

	if ( !alpha ) then
		alpha = 220
	end
	
	local clrBG = Color( 20, 20, 20, alpha )
	local clrFG = Color( 220, 10, 40, alpha / 2 )
	local clrTX = Color( 200, 200, 200, 255 )
	local name = ""

	if ( !entity ) then
		clrFG = Color( 110, 110, 110, alpha / 2 )
		name = "(empty)"
	else
		name = entity:GetPrintName()
	end
	
	if ( !name ) || ( !isstring( name ) ) then 
		name = "[PLACEHOLDER]"
	end
	
	local sizemod = 0
	
	if ( isstring( name ) ) then
		sizemod = math.min( string.len( name ) * 16, 72, 64 )
	end

	draw.RoundedBoxEx( 2, PosX, PosY, 100 + ( sizemod ), 20, clrBG, false, true, false, true ) 
	draw.RoundedBoxEx( 2, PosX - 32, PosY, 32, 20, clrFG, true, false, true, false )
	draw.DrawText( name, "DermaDefaultBold", PosX + 8, PosY + 4, clrTX )
	
	if ( entity ) then
		local ammo = LocalPlayer():GetAmmoCount( entity:GetPrimaryAmmoType() )
		draw.RoundedBox( 2, PosX + 200, PosY, 64, 20, clrBG )
		draw.DrawText( ammo, "DermaDefaultBold", PosX + 210, PosY + 4, clrTX )
	
		killicon.Draw( PosX - 32 - CurX, PosY - CurY, entity:GetClass(), alpha * 2 )
	end
	
	surface.SetDrawColor( clrBG )
	draw.NoTexture()

end

local cmdRestrictMenu = CreateConVar( "sfw_debug_preventautoequip_showinv", "0", bit.bor( FCVAR_LUA_CLIENT, FCVAR_USERINFO, FCVAR_ARCHIVE ), "" )

local function MyInventory()

	if ( !CLIENT ) then return end
	
	local cmdRestrictEquip = GetConVar( "sfw_debug_preventautoequip" )
	if ( !cmdRestrictEquip:GetBool() ) then return end

	if ( !cmdRestrictMenu:GetBool() ) then return end

	local w, h = ScrW(), ScrH()
	local ply = LocalPlayer()
	
	if ( !ply:KeyDown( IN_USE ) ) then
		if ( iAlpha > 0 ) then
			iAlpha = math.Approach( iAlpha, 0, FrameTime() * 2048 )
		end
		
		return
	end
			
	iAlpha = math.Approach( iAlpha, 255, FrameTime() * 2048 )
	local pos = Vector( 0 + ( w * 0.1 ) + math.abs( ply:EyeAngles().pitch / 8 ), 0 + ( h * 0.35 ) - ply:EyeAngles().pitch / 2 )

	pos.y = pos.y - offset / 4
	
	local inv =  ply:GetWeapons()

	draw.RoundedBoxEx( 2, pos.x - 64, pos.y - 32, 420, offset + 52, Color( 20, 20, 20, 120 ), false, true, false, true ) 
	offset = 0
	
	local tab = {}
	
	if ( #inv < 7 ) then
		for k,v in pairs( inv ) do
			table.insert( tab, v:GetSlot() + 1, v )
		end
	else
		tab = inv
	end
	
	for i=1, math.max( #tab, 6 ) do
		local v = tab[i]

		InvetoryDrawItem( pos.x + 64, pos.y + offset, v, iAlpha )
		draw.RoundedBox( 2, pos.x - 32, pos.y + offset, 32, 20, Color( 20, 20, 20, iAlpha ) ) 
		draw.DrawText( i, "DermaDefaultBold", pos.x - 24, pos.y + 4 + offset, Color( 220, 220, 220, iAlpha ) )
		
		offset = offset + 36
	end

	draw.RoundedBox( 2, pos.x - 32, pos.y - 32, 32, 20, Color( 20, 20, 20, iAlpha ) ) 
	draw.DrawText( tostring(#inv) .. " / 6", "DermaDefaultBold", pos.x - 30, pos.y - 30, Color( 220, 220, 220, iAlpha ) )
--[[
	cam.Start3D2D( pos, Angle( 0, 0, 180 ), 1 )
		draw.RoundedBoxEx( 2, 12, 12, 420, offset + 52, Color( 20, 20, 20, 120 ), false, true, false, true ) 
		offset = 0
		
		local tab = {}
		
		if ( #inv < 7 ) then
			for k,v in pairs( inv ) do
				table.insert( tab, v:GetSlot() + 1, v )
			end
		else
			tab = inv
		end
		
		for i=1, math.max( #tab, 6 ) do
			local v = tab[i]

			InvetoryDrawItem( 64, offset, v, iAlpha )
			draw.RoundedBox( 2, -32, offset, 32, 20, Color( 20, 20, 20, iAlpha ) ) 
			draw.DrawText( i, "DermaDefaultBold", 24, 4 + offset, Color( 220, 220, 220, iAlpha ) )
			
			offset = offset + 36
		end

		draw.RoundedBox( 2, -32, -32, 32, 20, Color( 20, 20, 20, iAlpha ) ) 
		draw.DrawText( tostring(#inv) .. " / 6", "DermaDefaultBold", -30, -30, Color( 220, 220, 220, iAlpha ) )
	cam.End3D2D()
]]--
end

hook.Add( "HUDPaint", "catahudSciFiInventory", MyInventory )

local function InventoryManage( pEntity, wEntity )
	local cmdmsgclr = Color( 200, 175, 255 )
	local classname = wEntity:GetClass()

	if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
		local content = util.JSONToTable( file.Read( "vh_loadout.txt", "DATA" ) )
		
		if ( content == nil ) then
			content = {}
		end
		
		if ( !content[ classname ] ) then
			local cache = {}

			cache.Class = classname
			
			if ( wEntity.Component && istable( wEntity.Component ) ) then
				cache.Component = wEntity.Component
				cache.Component.FirstTime = -1
			end
			
			content[ classname ] = cache

			local notify = {
				MessageType = 0,
				id = "update",
				Message = classname .. " has been added to the inventory",
				Color = Color( 240, 160, 20, 180 )
			}

			net.Start( "mana_challenge_notify" )
			net.WriteTable( notify )
			net.Send( pEntity )

			file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
			
			MsgC( cmdmsgclr, "Added " .. classname .. " to loadout save.\n" )
		else
			MsgC( cmdmsgclr, "!Error; Weapon is already listed in save file.\n" )
		end
	else
		MsgC( cmdmsgclr, "!Error, failed to locate save file. Creating new one...\n" )
		MsgC( cmdmsgclr, "Saving loadout...\n" )
		
		file.Write( "vh_loadout.txt", classname )
		
		MsgC( cmdmsgclr, "Done!\n" )
	end

end

hook.Add( "PlayerCanPickupWeapon", "rpPreventAutoEquip", function( pEntity, wEntity )

	local cmd_campaign = GetConVar( "vh_campaign" )
	local cmdRestrictEquip = GetConVar( "sfw_debug_preventautoequip" )
	local cmd_autocompose = GetConVar( "vh_campaign_loadout_autocompose" )

	if ( !cmdRestrictEquip:GetBool() ) && ( cmd_campaign:GetBool() ) then
		if ( cmd_autocompose:GetBool() ) && ( !pEntity.LastSpawn || pEntity.LastSpawn + 0.3 < CurTime() ) then
			InventoryManage( pEntity, wEntity )
		end
		
		return true
	end
	
	if ( cmdRestrictEquip:GetBool() ) && ( !pEntity.LastSpawn ||  pEntity.LastSpawn + 0.3 < CurTime() ) then
		if ( pEntity:KeyDown( IN_USE ) ) then
			local pInvent = GetInventory( pEntity )
			local invSize = table.Count( pInvent )
			local wClass = wEntity:GetClass()
			local IsOwned = table.HasValue( pInvent, wClass )

			if ( IsOwned ) then
				return true
			end
			
			if ( invSize < 6 ) then
				local invSlots = GetInventorySlots( pEntity )
				local wSlot = wEntity:GetSlot()
				local IsUsedSlot = table.HasValue( invSlots, wSlot )

				if ( IsUsedSlot && !IsOwned ) then 
					DevMsg( "@Inventory : Slot " .. wSlot .. " is blocked!" )
					return false
				else
					if ( cmd_autocompose:GetBool() ) && ( !pEntity.LastSpawn || pEntity.LastSpawn + 0.3 < CurTime() ) then
						InventoryManage( pEntity, wEntity )
					end
					
					return true
				end
			else
				DevMsg( "@Inventory : Inventory is full! (" .. invSize .. "/6)" ) 
				return false
			end
		else
			return false
		end
	end
	
end )