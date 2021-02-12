--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v17 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Hud displays and custom IHL							--
------------------------------------------------------------------
-- Has to be included by a weapon via AddCSLuaFile()			--
------------------------------------------------------------------

AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )
AddCSLuaFile( "base/scifi_render.lua" )
include( "base/scifi_render.lua" )

local blur_mat = Material( "pp/bokehblur" )

local function DrawBokehDOF( size, focus, radius )

	render.UpdateScreenEffectTexture()

	blur_mat:SetTexture( "$BASETEXTURE", render.GetScreenEffectTexture() )
	blur_mat:SetTexture( "$DEPTHTEXTURE", render.GetResolvedFullFrameDepth() )

	blur_mat:SetFloat( "$size", size )
	blur_mat:SetFloat( "$focus", focus )
	blur_mat:SetFloat( "$focusradius", radius )

	render.SetMaterial( blur_mat )
	render.DrawScreenQuad()

end

local showstats = 0

function SWEP:AddVStatsDisp()

	--if ( GetConVarNumber( "sfw_debug_enable_hlr" ) ~= 1 )  then return end
	
	if ( !self.ViewModelInspectable ) then return end

	local cmd_kb_inspect = GetConVar( "sfw_kb_inspect" ):GetInt()
	local cmd_fx_inspectblur = GetConVar( "sfw_fx_inspectblur" )
	
	if ( !cmd_kb_inspect ) then return end
	
	if ( input.IsKeyDown( cmd_kb_inspect ) || input.IsMouseDown( cmd_kb_inspect ) ) then
		showstats = math.Approach( showstats, 100, FrameTime() * 512 )
		
		if ( cmd_fx_inspectblur:GetBool() ) then
			local cmd_power = GetConVar( "sfw_fx_inspectblur_strength" )
			local fScale = showstats / 100
			DrawBokehDOF( cmd_power:GetInt() * fScale, 1 * fScale, 2.2 - 1 * fScale )
		end
	else
		if ( showstats > 0 ) then
			showstats = math.Approach( showstats, 0, FrameTime() * 128 )
		end
	end
		
	if ( showstats > 0 ) then
		local laser_color = Color( 255, 255, 255, 225 )
		local alpha = 240 * ( showstats / 100 )
		
		if ( self:IsFamily( "vtec" ) ) then
			laser_color = Color( 20, 180, 255, 220 )
		elseif ( self:IsFamily( "hwave" ) ) then
			laser_color = Color( 255, 120, 10, 220 )
		elseif ( self:IsFamily( "elemental" ) ) then
			laser_color = Color( 180, 255, 0, 220 )
		elseif ( self:IsFamily( "custom" ) ) then
			laser_color = Color( 255, 170, 220, 220 )
		end
		
		local text_pos = Vector( ScrW() * 0.06, ScrH() * 0.3 )
		
		cam.Start2D( text_pos, Angle( 0, 0, 0 ), 1 )
			self:DrawRpgStats( text_pos, laser_color, alpha, alpha )
		cam.End2D()
	end

end

function SWEP:AddRPGAcc()

	if ( self.Owner == NULL ) and ( self:GetNWBool( "MobDrop" )  || GetConVarNumber( "sfw_debug_force_itemhalo" ) == 1 ) then -- omg, dat borderlands ref --
	if ( CLIENT ) && ( steamworks.IsSubscribed( 525131036 ) || GetConVarNumber( "ihl_enabled" ) == 0 ) && ( GetConVarNumber( "sfw_debug_force_itemhalo" ) ~= 1 )  then return end 

		local laser_color = Color( 255, 255, 255, 225 )
		local distance = LocalPlayer():GetPos():Distance( self:GetPos() )
		local alpha = math.Clamp( 1024 - ( distance * 3.75 ), 0, 200 )
		local alpha2 = math.Clamp( 512 - ( LocalPlayer():GetEyeTrace().HitPos:Distance( self:GetPos() ) * 16 ), 0, 240 )
		local alpha3 = math.Clamp( 1024 - ( distance * 2 ), 0, 200 )
		
		if ( self:IsFamily( "vtec" ) ) then
			laser_color = Color( 20, 180, 255, 220 )
		elseif ( self:IsFamily( "hwave" ) ) then
			laser_color = Color( 255, 120, 10, 220 )
		elseif ( self:IsFamily( "elemental" ) ) then
			laser_color = Color( 180, 255, 0, 220 )
		elseif ( self:IsFamily( "custom" ) ) then
			laser_color = Color( 255, 170, 220, 220 )
		end

		local poslight = util.TraceLine( {
			start = self:GetPos(),
			endpos = self:GetPos() + Vector( 0, 0, 32 ),		
			filter = function( ent ) if ( ent == self ) then return false else return true end end,
			mask = MASK_SHOT
		} )
		
		if ( distance <= 1024 ) then
			render.SetMaterial( self.mat_laser_glow )
			render.DrawSprite( poslight.StartPos, 12, 12, laser_color )
		end
		
		if ( distance <= 512 ) then
			render.SetMaterial( self.mat_laser_haze )
			render.DrawBeam( poslight.StartPos, poslight.HitPos, 0.75, 0, 1, Color( laser_color.r, laser_color.g, laser_color.b, alpha3 ) )
		end
		
		if ( LocalPlayer():GetEyeTrace().Entity == self ) && ( distance <= 512 ) then
			render.SetMaterial( self.mat_laser_glow )
			render.DrawSprite( poslight.StartPos, 32, 32, Color( laser_color.r, laser_color.g, laser_color.b, laser_color.a / 3 ) )
		end
		
		local text_pos = poslight.HitPos:ToScreen()
		
		if ( distance <= 256 ) then
			cam.Start2D( poslight.HitPos, Angle( 0, 0, 0 ), 0.25 )
				self:DrawRpgStats( text_pos, laser_color, alpha, alpha2 )
			cam.End2D()
		end
		
	end

end

function SWEP:DrawRpgStats( pos, clr, a1, a2 )

	local textcolor = Color( clr.r + 35, clr.g + 35, clr.b + 35, a1 )
	offset = 32
	
	surface.SetTexture( self.WepSelectIcon )
	surface.SetDrawColor( 255, 255, 255, a2 )
	surface.DrawTexturedRect( pos.x - 64, pos.y - 16, 64, 64 )
	
	draw.WordBox( 6, pos.x, pos.y, self.PrintName, "DermaDefaultBold", Color( 80, 80, 80, a1 ), textcolor )

	if ( self.SciFiWorldStats ~= nil ) then
		for k,v in SortedPairs( self.SciFiWorldStats ) do 
			if ( v.text == nil || v.color == nil ) then 
				DevMsg( "@"..self:GetClass().." : !Error; Check your stats table!" )
			else
				draw.WordBox( 4, pos.x, pos.y + offset, v.text, "DermaDefault", Color( 80, 80, 80, a2 ), Color( v.color.r, v.color.g, v.color.b, a2 ) )
				offset = offset + 24
			end
		end
	else
		draw.WordBox( 4, pos.x, pos.y + offset, self.Purpose, "DermaDefault", Color( 80, 80, 80, a2 ), Color( 180, 180, 180, a2 ) )
		offset = offset + 24
		draw.WordBox( 4, pos.x, pos.y + offset, self.Instructions, "DermaDefault", Color( 80, 80, 80, a2 ), Color( 180, 180, 180, a2 ) )
	end

end