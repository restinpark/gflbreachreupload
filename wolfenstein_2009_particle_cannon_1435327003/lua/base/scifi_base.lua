--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v17 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: Base content and shared functions like Reload().	--
-- All scifi weapons derive information from this base.			--
-- Note, that a weapon can override a derived function.			--
-- SciFiACC management and math									--
-- coded animations.											--
-- AimDownSights mechanics and viewmodel handling.				--
------------------------------------------------------------------
-- Has to be included by a weapon via AddCSLuaFile()			--
------------------------------------------------------------------
-- soon™														--
------------------------------------------------------------------

AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )
AddCSLuaFile( "base/scifi_hooks.lua" )
include( "base/scifi_hooks.lua" )
AddCSLuaFile( "base/scifi_dropmagic.lua" )
include( "base/scifi_dropmagic.lua" )
AddCSLuaFile( "base/scifi_render.lua" )
include( "base/scifi_render.lua" )
AddCSLuaFile( "base/scifi_hud.lua" )
include( "base/scifi_hud.lua" )
AddCSLuaFile( "base/scifi_damage_swep.lua" )
include( "base/scifi_damage_swep.lua" )
AddCSLuaFile( "base/scifi_elementals.lua" )
include( "base/scifi_elementals.lua" )

local m_random 			= math.random
local m_min 			= math.min
local m_max 			= math.max
local m_abs 			= math.abs
local m_pi 				= math.pi
local m_rad 			= math.rad
local m_sin 			= math.sin
local m_cos 			= math.cos
local m_tan 			= math.tan
local m_Round 			= math.Round
local m_Truncate 		= math.Truncate
local m_Clamp 			= math.Clamp
local m_Approach 		= math.Approach
local m_AngleDifference = math.AngleDifference

SWEP.Base 					= "weapon_base"
SWEP.SciFiState 			= false

SWEP.Author					= "Darken217"
SWEP.Category				= "Darken217's SciFi Armory"

SWEP.LastOwner 				= nil

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AdminOnly				= false
SWEP.UseHands				= true

SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= false
SWEP.DrawAmmo				= true
SWEP.DrawWeaponInfoBox		= true

SWEP.PrintName 				= "Yet another sci-fi weapon"
SWEP.Purpose				= "[PLACEHOLDER]"
SWEP.Instructions			= "[PLACEHOLDER]"

SWEP.ViewModel				= "models/weapons/c_smg1.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.HoldType 				= "smg"
SWEP.HoldTypeNPC 			= "smg"
SWEP.HoldTypeSprint 		= "passive"
SWEP.DeploySpeed 			= 3
SWEP.UseSCK 				= true

SWEP.SciFiSkin				= ""
SWEP.SciFiSkin_1			= ""
SWEP.SciFiSkin_2			= ""
SWEP.SciFiSkin_3			= ""
SWEP.SciFiSkin_4			= ""
SWEP.SciFiWorld 			= ""

SWEP.DefaultSwayScale		= 1.6
SWEP.DefaultBobScale		= 2.4
SWEP.SprintSwayScale		= 3.0
SWEP.SprintBobScale			= 5.0
SWEP.ViewModelFOV			= 54
SWEP.Weight					= 5

if ( CLIENT ) then
	SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_custom.vmt" )
end

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""

SWEP.VfxMuzzleAttachment 	= "muzzle"
SWEP.VfxMuzzleAttachment2 	= "muzzle"
SWEP.VfxMuzzleParticle 		= "ngen_muzzle"
SWEP.VfxMuzzleRule 			= 3
SWEP.VfxMuzzleColor 		= Color( 200, 170, 255, 220 )
SWEP.VfxMuzzleBrightness 	= 1
SWEP.VfxMuzzleFarZ 			= 540
SWEP.VfxMuzzleFOV 			= 140
SWEP.VfxMuzzleProjexture 	= "effects/mf_light"
SWEP.VfxHeatForce 			= false
SWEP.VfxHeatParticle 		= "nrg_heat" --"gunsmoke"
SWEP.VfxHeatThreshold 		= 0.75
SWEP.VfxHeatDelay 			= 0

SWEP.SciFiFamily			= { "base" }
SWEP.SciFiWorldStats		= nil --{ ["1"] = { text = "A scifi weapon", color = Color( 180, 180, 180 ) } }

SWEP.SciFiACC				= 2
SWEP.SciFiACCRecoverRate	= 0.2

SWEP.ProjectileOffset 		= Vector( 8, -10 ) -- Vector( 8, -8 )
SWEP.ProjectileOffsetNPC 	= Vector( -6, -6 )

SWEP.Charge 				= 0
SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 1
SWEP.ChargeDrain			= 1
SWEP.ChargeDeltaCompensate 	= false
SWEP.ChargeDeltaFactor 		= 1

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeRecoverTime 	= 0.32
SWEP.SciFiMeleeASpeed		= 0.6
SWEP.SciFiMeleeRange		= 60
SWEP.SciFiMeleeDamage		= 8
SWEP.SciFiMeleeDamageType	= bit.bor( DMG_CLUB, DMG_NEVERGIB )
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"
SWEP.SciFiMeleeHitWorld 	= "scifi.melee.hit.world"
SWEP.SciFiMeleeHitBody 		= "scifi.melee.hit.body"
SWEP.ScifiMeleeCharge 		= 0
SWEP.SciFiMeleeChargeMax	= 100

SWEP.CrouchRecoilMul 		= 0.8

SWEP.AdsPos 				= Vector( -2, 1, -1 )
SWEP.AdsAng 				= Vector( 0, 0, 0 )
SWEP.AdsFov					= 40
SWEP.AdsFovTransitionTime	= 0.16
SWEP.AdsFovCompensation 	= 0.2
SWEP.AdsRecoilMul			= 0.8
SWEP.AdsTransitionAnim		= true
SWEP.AdsTransitionSpeed		= 22
SWEP.AdsBlur 				= true
if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 3
	SWEP.AdsMSpeedScale			= GetConVar( "sfw_adsmspeedscale" ):GetFloat()
end
SWEP.AdsSounds 				= false
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"
SWEP.AdsRTScopeEnabled 		= false
SWEP.AdsRTDelta 			= false -- Do not override this one, it get's changed each time you zoom in/out anyway.
SWEP.AdsRTScopeCompensate 	= true
SWEP.AdsRTScopeSizeX 		= 256
SWEP.AdsRTScopeSizeY 		= 256
SWEP.AdsRTScopeScaling 		= false
SWEP.AdsRTScopeScaleX 		= 1
SWEP.AdsRTScopeScaleY 		= 1
SWEP.AdsRTScopeMaterial		= Material( "models/weapons/misc/rt_scope.vmt" )
SWEP.AdsRTScopeOffline		= "models/weapons/misc/rt_scope_offline_baset.vtf"
SWEP.AdsRTScopeTarget 		= "$basetexture"

SWEP.ViewModelIdleAnim 		= true
SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )
SWEP.ViewModelHomeAng		= Angle( 0, 0, 0 )
SWEP.ViewModelSprintPos		= Vector( 3, 0.2, 0.6 )
SWEP.ViewModelSprintAng		= Angle( -10, 38, -15 ) --Angle( -10, 35, -5 )
SWEP.ViewModelSprintSway 	= 1
SWEP.ViewModelDuckPos		= Vector( -1, 0, 1 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -5 )
SWEP.ViewModelMeleePos		= Vector( 18, 12, -6 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -90 )
SWEP.ViewModelInspectable 	= true
SWEP.ViewModelMenuPos		= Vector( 12, 3.2, -6 )
SWEP.ViewModelMenuAng		= Angle( 20, 35, -10 )
SWEP.ViewModelReloadAnim 	= false
SWEP.ViewModelReloadPos		= Vector( -1, -1, 0 )
SWEP.ViewModelReloadAng		= Angle( -2, 2, 0 )

SWEP.SprintAnim				= true
SWEP.SprintAnimIdle			= false -- currently ( june, 4th 2017 ) bugged as it resets to the last used sequence instead of the given one.
SWEP.SprintAnimSpeed		= 8

SWEP.ReloadOnTrigger 		= true
SWEP.ReloadRealisticClips 	= false
SWEP.ReloadTime				= 2.2
SWEP.ReloadSND				= "Weapon_SMG1.Reload"
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadPlaybackRate 	= 1
SWEP.ReloadAnimEndIdle 		= false
SWEP.ReloadModels 			= false
SWEP.ReloadGib 				= "models/dav0r/hoverball.mdl"
SWEP.ReloadGibMaterial 		= ""
SWEP.ReloadGibMass 			= nil
SWEP.ReloadGibSize 			= 1

SWEP.DepletedSND			= "Weapon_Pistol.Empty"

SWEP.mat_laser_line = Material( "effects/laser_line.vmt" )
SWEP.mat_laser_haze = Material( "effects/laser_haze.vmt" )
SWEP.mat_laser_glow = Material( "effects/blueflare1.vmt" )

local cmd_actualspawnoffset 		= GetConVar( "sfw_allow_actualspawnoffset" )
local cmd_advanims 					= GetConVar( "sfw_allow_advanims" )
local cmd_debug_showanimscaling 	= GetConVar( "sfw_debug_showanimscaling" )
local cmd_engine_fovdesired 		= GetConVar( "fov_desired" )
local cmd_fx_heat 					= GetConVar( "sfw_fx_heat" )
local cmd_fx_muzzlelights 			= GetConVar( "sfw_fx_muzzlelights" )
local cmd_fx_particles 				= GetConVar( "sfw_fx_particles" )
local cmd_fx_suppressonzoom 		= GetConVar( "sfw_fx_suppressonzoom" )
local cmd_kb_inspect 				= GetConVar( "sfw_kb_inspect" )
local cmd_legacyzoom 				= GetConVar( "sfw_allow_legacyzoom" )
local cmd_maxacc 					= GetConVar( "sfw_sk_maxacc" )
local cmd_viewbob 					= GetConVar( "sfw_allow_viewbob" )

local menu = 0
local sprint = 0
local crouch = 0
local melee = 0
local relanim = 0
local Mul = 0
	
function SWEP:GetAmmoNature()
	
	local aTypeP = self.Primary.Ammo
	
	if ( !isstring( aTypeP ) ) then
		return false
	end 
	
	if ( isnumber( aTypeP ) && aTypeP <= 0 ) then
		return false
	end
	
	if ( aTypeP == "" ) || ( aTypeP == "SciFiEnergy" ) then
		return false
	end
	
	return true
	
end

if ( CLIENT ) then

	local function Circle( x, y, radius, degrees, offset, startoffset )
		local segmentdist = 360 / ( 2 * m_pi * radius / 2 )
		
		if ( !startoffset ) then
			startoffset = 0
		end
		
		if ( !offset ) then
			offset = 0
		end

		for a = 0 + offset, ( -startoffset + m_abs( degrees ) + offset ) - segmentdist + startoffset, segmentdist do
			surface.DrawLine( x + m_cos( m_rad( a ) ) * radius, y - m_sin( m_rad( a ) ) * radius, x + m_cos( m_rad( a + segmentdist ) ) * radius, y - m_sin( m_rad( a + segmentdist ) ) * radius )
		end
	end

	local lensring = surface.GetTextureID("effects/sight_lens")
	local lenswarp = surface.GetTextureID("effects/sight_lens_refract") 
	local lensglass = surface.GetTextureID("effects/sight_glass")
	
	function SWEP.DrawScopeOverlay( pEntity, pWeapon )
		local midx, midy = pWeapon.AdsRTScopeSizeX / 2, pWeapon.AdsRTScopeSizeY / 2
		local plyETrace = pEntity:GetEyeTrace()
		local clrSight = Color( 200, 15, 10, 128 )
		local lines_start = Vector( midx, midy )
		
		cam.Start2D()
			draw.NoTexture()
			surface.SetDrawColor( 255, 10, 30, 255 )
			Circle( midx, midy, 1, 360 )
			
			render.DrawLine( lines_start - Vector( 0, 16 ), lines_start - Vector( 0, 46 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 0, 16 ), lines_start + Vector( 0, 46 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, 0 ), lines_start - Vector( 128, 0 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 0 ), lines_start + Vector( 128, 0 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, -16 ), lines_start - Vector( 64, -16 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 16 ), lines_start + Vector( 64, 16 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, -32 ), lines_start - Vector( 32, -32 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 32 ), lines_start + Vector( 32, 32 ), clrSight, false ) 
			
			surface.SetDrawColor( 1, 1, 1, 255 )
			surface.SetTexture( lenswarp )
			surface.DrawTexturedRect( 0, 0, pWeapon.AdsRTScopeSizeX, pWeapon.AdsRTScopeSizeY )
			
			if ( pWeapon.AdsRTScopeCompensate ) then
				local clrWorld = render.GetLightColor( plyETrace.HitPos ) * 100
				local brtWorld = clrWorld.r + clrWorld.g + clrWorld.b

				surface.SetDrawColor( 255 - brtWorld, 255 - brtWorld, 255 - brtWorld, 255 - brtWorld * 316 )
			end
			
			surface.SetTexture( lensglass )
			surface.DrawTexturedRect( 0, 0, pWeapon.AdsRTScopeSizeX, pWeapon.AdsRTScopeSizeY )
			surface.SetTexture( lensring )
			surface.DrawTexturedRect( 0, 0, pWeapon.AdsRTScopeSizeX, pWeapon.AdsRTScopeSizeY )
		cam.End2D()
	end

	local pEntity, pWeapon
	local function DrawRTScope()
		pEntity = LocalPlayer()
	
		if ( !pEntity ) || ( pEntity && !pEntity:Alive() ) then return end
		if ( pEntity:ShouldDrawLocalPlayer() ) then return end
		
		if ( IsValid( pEntity ) ) then
			pWeapon = pEntity:GetActiveWeapon()
		end
		
		if ( !IsValid( pWeapon ) ) then return end
		if ( !pWeapon.AdsRTScopeEnabled ) then return end
	
		local mat_scope = pWeapon.AdsRTScopeMaterial
		local IsAds = pWeapon.SciFiState == SCIFI_STATE_ADS

		if ( IsAds ) then
			local newrt = {}
	
			local ScopeRT = GetRenderTarget( "_rt_Scope", pWeapon.AdsRTScopeSizeX, pWeapon.AdsRTScopeSizeY, false )
					
			local x, y = ScrW(), ScrH()
		--	local old =  render.GetRenderTarget()
			render.PushRenderTarget( ScopeRT )
			
			local ang = pEntity:EyeAngles()
			ang:RotateAroundAxis( ang:Forward(), -1 )
			
			newrt.angles = ang
			newrt.origin = pEntity:GetShootPos()
			newrt.x = 0
			newrt.y = 0
			newrt.w = x
			newrt.h = y
			newrt.fov = pWeapon.AdsFov
			newrt.drawviewmodel = false
			newrt.drawhud = false
			newrt.dopostprocess = false
			newrt.bloomtone = true

		--	render.SetRenderTarget( ScopeRT )
			render.SetViewPort( 0, 0, pWeapon.AdsRTScopeSizeX, pWeapon.AdsRTScopeSizeY )
			render.Clear( 0, 0, 0, 255, false, false )
			
			render.RenderView( newrt )
			pWeapon.DrawScopeOverlay( pEntity, pWeapon )
			
			render.SetViewPort( 0, 0, x, y )
			render.PopRenderTarget()
		--	render.SetRenderTarget( old )
			
			if ( !pWeapon.AdsRTDelta && mat_scope ) then
				mat_scope:SetTexture( pWeapon.AdsRTScopeTarget, ScopeRT )
				
				if ( pWeapon.AdsRTScopeScaling ) then
					local ScaleX, ScaleY = pWeapon.AdsRTScopeScaleX, pWeapon.AdsRTScopeScaleY
				--	local Rotate = pWeapon.AdsRTScopeRotation
					local matrix = Matrix()
					
					matrix:Scale( Vector( ScaleX, ScaleY ) )
					
					mat_scope:SetMatrix( "$basetexturetransform", matrix )
				else
					mat_scope:SetUndefined( "$basetexturetransform" )
				end
			end
			
			pWeapon.AdsRTDelta = true
		else 
			if ( pWeapon.AdsRTDelta && mat_scope ) then
				mat_scope:SetTexture( "$basetexture", pWeapon.AdsRTScopeOffline )
			end
			
			pWeapon.AdsRTDelta = false
		end	
	end

	hook.Add( "RenderScene", "SciFiBaseDrawRTScope", DrawRTScope )

	function SWEP:CustomAmmoDisplay()

		self.AmmoDisplay = self.AmmoDisplay || {}
		self.AmmoDisplay.Draw = true
		
		if ( self.Primary.ClipSize > 0 ) && ( self:GetAmmoNature() ) then
			self.AmmoDisplay.PrimaryClip = self:Clip1()
			self.AmmoDisplay.PrimaryAmmo = self:Ammo1()
		else
			self.AmmoDisplay.PrimaryClip = self:Clip1()
			self.AmmoDisplay.PrimaryAmmo = -1
		end
			
		if ( self.Secondary.ClipSize > 0 ) && !( self.Primary.Ammo == "" || self.Primary.Ammo == "none" ) then
			self.AmmoDisplay.SecondaryClip = self:Clip2()
			self.AmmoDisplay.SecondaryAmmo = self:Ammo2()
		else
			self.AmmoDisplay.SecondaryClip = -1
			self.AmmoDisplay.SecondaryAmmo = -1
		end

		return self.AmmoDisplay
	end

end

if ( SERVER ) then

	function SWEP:GetCapabilities()
		return 1822960705 -- bit.bor( CAP_INNATE_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK2, CAP_WEAPON_RANGE_ATTACK1, CAP_WEAPON_RANGE_ATTACK2, CAP_MOVE_GROUND, CAP_MOVE_JUMP )
	end

end

function SWEP:SetupDataTables()

	self:NetworkVar( "Float", 0, "AnimNextIdle" )

end

function SWEP:Initialize()

	self:SetHoldType( self.HoldType )
	self:SetDeploySpeed( self.DeploySpeed )
	
	if( self.UseSCK ) then
		self:sckInit()
	end
	
	self:SubInit()
	
end

function SWEP:SubInit()

end

function SWEP:AddAcc()

end

function SWEP:AddWAcc()

end

local iFTRecent = 0
local iFTDelta = 0

function SWEP:Think()
	
	self:Anims()
	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	
end
	
function SWEP:SciFiMath()
	
	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end
	if ( self.Owner:IsNPC() ) then return end

	if ( self.ChargeDeltaCompensate ) && ( CLIENT ) then
		local iFTActual = FrameTime()

		iFTDelta = m_abs( iFTActual * 60 - iFTRecent )
		self.ChargeDeltaFactor = iFTDelta
		iFTRecent = iFTDelta
		
		if ( !game.SinglePlayer() ) then
			self.ChargeDeltaFactor = 1
		end
	end

	local fMaxAcc = cmd_maxacc:GetFloat()
	if ( self.SciFiACC > fMaxAcc ) then
		self.SciFiACC = fMaxAcc
	end
	
	if ( self.SciFiACC > 0 ) then
		self.SciFiACC = self.SciFiACC - self.SciFiACCRecoverRate
	end

	if ( self.SciFiACC < 0 ) then
		self.SciFiACC = 0 
	end

end

function SWEP:GetSciFiACC()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end
	local value = 0

	if ( SERVER && game.SinglePlayer() ) || ( CLIENT ) then
		value = self.SciFiACC
	end
	
	return value

end

function SWEP:SetSciFiACC( value )

	local fMaxAcc = cmd_maxacc:GetFloat()
	
	if ( SERVER && game.SinglePlayer() ) || ( CLIENT ) then
		if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end
		
		if ( value > ( fMaxAcc * 1.3 ) ) || ( value < 0 ) then
			DevMsg( "@"..self:GetClass().." : !Error; Tried to set an incorrect SciFiACC value ("..value..")! Maximum value is "..fMaxAcc..". Clamping!" )

			m_Clamp( value, 0, fMaxAcc )
		end
	end

end

function SWEP:AddSciFiACC( value, ignoreads )
	
	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end

	local fMaxAcc = cmd_maxacc:GetFloat()
	
	local IsAds = ( self.SciFiState == SCIFI_STATE_ADS )

	if ( self.Owner:IsNPC() ) then 
		self.SciFiACC = 0 

		return 
	end
	
	if ( self.Owner:Crouching() ) then
		value = value * self.CrouchRecoilMul
	end
	
	if ( value < ( fMaxAcc * 1.4 ) ) && ( value > 0 ) then
		if ( IsAds && !ignoreads ) then
			self.SciFiACC = m_Clamp( self.SciFiACC + ( value * self.AdsRecoilMul ), 0, fMaxAcc )
		else
			self.SciFiACC = m_Clamp( self.SciFiACC + value, 0, fMaxAcc )
		end
	else
		DevMsg( "@"..self:GetClass().." : !Error; Potential SciFiACC malformation ("..self.SciFiACC + value..")! Maximum value is "..fMaxAcc.."!" )
	end

end

function SWEP:IsFamily( tag )

	if ( table.HasValue( self.SciFiFamily, tag ) && self.SciFiFamily ~= nil ) then
		return true
	else
		return false
	end

end

function SWEP:GetViewModelEnt()

	local viewmodel

	if ( !IsValid( self.Owner ) ) then
		viewmodel = self
	end
	
	if ( self.Owner:IsPlayer() ) then
		viewmodel = self.Owner:GetViewModel()
	end
	
	if ( self.Owner:IsNPC() ) || ( !game.SinglePlayer() && !self.Owner ) then
		viewmodel = self.Owner:GetActiveWeapon()
	end
	
	if ( !IsValid( viewmodel ) ) then return end
	
	return viewmodel

end

function SWEP:GetProjectileSpawnPos( static )

	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end

	local cmdOffset 	= cmd_actualspawnoffset:GetBool() 
	
	if ( !isnumber( cmdOffset ) ) then
		cmdOffset = 1
	end
	
	local pOwnerAV		= self.Owner:GetAimVector()
	local pOwnerSP 		= self.Owner:GetShootPos()
	local pOwnerEyes	= self.Owner:EyePos()

	if ( cmdOffset == 1 ) then
		local rt = self.Owner:GetRight()
		local up = self.Owner:GetUp()
		
		local vmEntity = self:GetViewModelEnt()
		local vmAttach = vmEntity:LookupAttachment( "Muzzle" )

		if ( !vmAttach || vmAttach == 0 ) then
			vmAttach = vmEntity:LookupAttachment( "1" )
		end
		
		if ( !vmAttach ) then
			static = true
		end

		if ( static ) then
			local pos = pOwnerSP + ( rt * self.ProjectileOffset.x + up * self.ProjectileOffset.y )
			
			if ( self.Owner:IsNPC() ) then	
				pos = pOwnerSP + ( rt * self.ProjectileOffsetNPC.x + up * self.ProjectileOffsetNPC.y )
			end
			
			return pos
		else
			local pos = self:GetAttachment( vmAttach ).Pos
			return pos
		end		
	else
		local pos = pOwnerEyes + ( pOwnerAV * 20 )
		return pos
	end

end

function SWEP:Equip( NewOwner )

	if ( self.Owner:IsPlayer() && GetConVar( "cl_showhints" ):GetBool() ) then
		if ( !table.HasValue( self.Owner:GetWeapons(), "sfw_" ) ) then
			self.Owner:SendHint( "sfw_remi_dmgamp", 0.05 )
		end
		
		if ( !table.HasValue( self.Owner:GetWeapons(), "sfw_" ) ) then
			self.Owner:SendHint( "sfw_remi_melee", 0.45 )
		end
		
		if ( self:IsFamily( "modes_bfire" ) ) then
			self.Owner:SendHint( "sfw_bfire_equip_1", 0.05 )
		end
		
		if ( self:IsFamily( "modes_grenade" ) ) then
			self.Owner:SendHint( "sfw_bnade_equip_1", 0.05 )
		end
		
		if ( self:IsFamily( "enerbow" ) ) then
			self.Owner:SendHint( "sfw_charge_equip_1", 0.05 )
		end
		
		if ( self:IsFamily( "infammo" ) && self:IsFamily( "autoregen" ) ) then
			self.Owner:SendHint( "sfw_autoregen_equip_1", 0.05 )
		end
	end
	
	if ( NewOwner:IsNPC() ) then
		if ( self.SciFiWorld ~= nil && self.SciFiWorld ~= "" ) then
			self:SetMaterial( self.SciFiWorld )
		end

		self:SetNPCFireRate( 0.01 )
		self:SetNPCMinBurst( 4 )
		self:SetNPCMaxBurst( 4 )
		self:SetNPCMinRest( 0 )
		self:SetNPCMaxRest( 1 )
		
		if ( self.HoldTypeNPC ) then
			self:SetupWeaponHoldTypeForAI( self.HoldTypeNPC )
		else
			self:SetupWeaponHoldTypeForAI( "ar2" )
		end
		
		NewOwner:SetKeyValue ("FireRate", "0.01" )
	--	NewOwner:SetKeyValue( "spawnflags", "16" )
	--	self.Owner:SetKeyValue( "spawnflags", "256" )
	--	NewOwner:SetKeyValue( "spawnflags", "1024" )
		NewOwner:SetKeyValue( "spawnflags", "4" )

		NewOwner:SetSaveValue( "m_flShotDelay", 0.001 )
		NewOwner:SetSaveValue( "m_nBurstHits", 12 )
		NewOwner:SetSaveValue( "m_nMaxBurstHits", 12 )
		NewOwner:SetSaveValue( "m_nBurstMode", 0 )
		NewOwner:SetSaveValue( "m_nBurstSteerMode", 4 )
		
		NewOwner:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	end

	if ( self.Owner:IsPlayer() ) && ( self:GetAmmoNature() ) && ( !GetConVar( "vh_campaign" ):GetBool() ) then
		self.Owner:GiveAmmo( self.Primary.ClipSize * 8, self.Primary.Ammo )
	end
	
	if ( self.Owner:IsPlayer() ) && ( self:IsFamily( "custom" ) && self:IsFamily( "infammo" ) ) then
		if ( self.Owner:Armor() <= 100 ) then
			self.Owner:SetArmor( self.Owner:Armor() + 10 )
		end
	end

end

function SWEP:Deploy() 

	self:SetAds( false )

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self.SciFiState = SCIFI_STATE_IDLE
		self.SciFiMeleeCharge = 0
		self.SciFiACC = 2.5
	end
	
	menu = 0
	sprint = 0
	crouch = 0
	melee = 0
	Mul = 0

	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid(self.Owner) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	self.SciFiState = SCIFI_STATE_IDLE

	self:SetAds( false )

	self:OnRemove()
	return true

end

function SWEP:OnDrop()

	self:SetAds( false )
	self:OnRemove()

end

function SWEP:ShouldDropOnDie()

	return true
	
end

function SWEP:OwnerChanged()

	local wOwner = self:GetOwner()

	if ( IsValid( wOwner ) ) && ( wOwner ~= self.LastOwner ) then
		self.LastOwner = wOwner
	else
		self:OnRemove()
	end
	
end

function SWEP:CanPrimaryAttack( cap, canunderwater )
	
	if ( self.Owner == NULL ) then return end
	
	if ( !cap ) then
		cap = 0
	end
	
	local bAnims = cmd_advanims:GetBool() 

	if ( self:Clip1() <= cap ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
		--	self:SendWeaponAnim( ACT_VM_DRYFIRE )
		end
		
		if ( self.ReloadOnTrigger ) then
			self:Reload()
		end
		
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		return false
	end

	if ( self.SciFiState == SCIFI_STATE_SPRINT ) && ( bAnims ) then
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		if ( canunderwater  ) then
			return true
		end
		
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
--			self:SendWeaponAnim( ACT_VM_DRYFIRE )
		end
		
--		self:SendWeaponAnim( ACT_VM_DRYFIRE )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end

	return true
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 || event == 22 ) then
		return true
	end

end

local heat_lastcast = 0
function SWEP:DoMuzzleEffect()

	local bComplexParticles = cmd_fx_particles:GetBool()
	local bHeatPartilces = cmd_fx_heat:GetBool()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end
	
	local bSuppressOnZoom = cmd_fx_suppressonzoom:GetBool()
	local bIsAds = ( self.SciFiState == SCIFI_STATE_ADS )

	if ( bIsAds && bSuppressOnZoom ) then return false end

	local pOwnerSP = self.Owner:GetShootPos()
	local vmEntity = self:GetViewModelEnt()
	
	if ( !game.SinglePlayer && self.Owner:ShouldDrawLocalPlayer() ) then 
		vmEntity = self.Owner:GetActiveWeapon()
	end
	
	local vmAttach

	if ( self.VfxMuzzleAttachment ) then
		vmAttach = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )
	else
		vmAttach = vmEntity:LookupAttachment( "muzzle" )
		
		if ( vmAttach == 0 ) then
			vmAttach = vmEntity:LookupAttachment( "1" )
		end
	end
	
	if ( vmAttach == 0 ) || ( !vmAttach ) then 
		DevMsg( "@"..self:GetClass().." : !Error; Invalid muzzle attachment ID." ) 
		vmAttach = 1
	end

	local vmOrigin = vmEntity:GetAttachment( vmAttach ).Pos
	
	if ( !isvector( vmOrigin ) ) then DevMsg( "@"..self:GetClass().." : !Error; Invalid muzzle attachment position." ) return end

	local ed = EffectData()
	ed:SetOrigin( vmOrigin )
	ed:SetEntity( self )
	ed:SetAttachment( vmAttach )
	
	util.Effect( "sfw_muzzle_generic", ed )
	
	if ( !bComplexParticles ) then return end

	if ( game.SinglePlayer && SERVER || !game.SinglePlayer ) then
		local maxacc = cmd_maxacc:GetFloat() * self.VfxHeatThreshold
		
		local delay = 0
		if ( self.VfxHeatDelay > 0 ) then
			delay = heat_lastcast + self.VfxHeatDelay
		end
		
		if ( delay <= CurTime() ) && ( ( self.VfxHeatForce ) || ( bHeatPartilces ) ) && ( self.SciFiACC >= maxacc ) then
			ParticleEffectAttach( self.VfxHeatParticle, PATTACH_POINT_FOLLOW, vmEntity, vmAttach )
			heat_lastcast = CurTime()
		end
	end
	
end

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 0.08 )

	local viewmodel = self:GetViewModelEnt()
	local amp = GetConVar( "sfw_damageamp" ):GetFloat()
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .0021, .0021 ) * self.SciFiACC
	bullet.Tracer = 1
	bullet.TracerName = "ca3_tracer" 
	bullet.Force = 4
	bullet.HullSize = 1
	bullet.Damage = 8 * amp
	bullet.Callback = function( attacker, tr, dmginfo )
	
		ParticleEffect( "ngen_hit", tr.HitPos, Angle( 0, 0, 0 ), fx )
		sound.Play( "scifi.ca3.hit", tr.HitPos, SOUNDLVL_NORM, m_random( 95, 102 ), 1.0 )
	
		if ( GetRelChance( 8 ) ) then 
			ParticleEffect( "hornet_blast", tr.HitPos, Angle( 0, 0, 0 ), fx )
			DoElementalEffect( { Element = EML_SHOCK, Target = tr.Entity, Attacker = self.Owner, Damage = 30 } )
			self:DealAoeDamage( bit.bor( DMG_SHOCK, DMG_RADIATION ), 12 * amp, tr.HitPos, 40 )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	self:DoMuzzleEffect()
--	self:DrawMuzzleLight( "120 110 255 120" , 155, 500, 0.07 )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( m_random( -0.6, -1 ), m_random( -0.1, -0.5 ), m_random( -0.1, -0.3 ) ) * ( self.SciFiACC * 0.1 ) )
	end
	
	self:AddSciFiACC( 3.4 )
	
	self:EmitSound( "cat.vk21.pfire" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
end

function SWEP:CanSecondaryAttack()

	if ( self:Clip1() < 30 ) then
		self:EmitSound( "Weapon_ar2.Empty" )
		self:Reload()
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
		end
		
		self:SetNextSecondaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_SPRINT ) && ( cmd_advanims:GetBool() ) then
		return false
	end

	return true

end

function SWEP:SecondaryAttack()

end

function SWEP:CreateReloadModels()

	if ( !self.ReloadModels ) then return end
	
	local cmd_propcreation = GetConVar( "sfw_allow_propcreation" ):GetBool()
	if ( cmd_propcreation ) then return end

	if ( SERVER ) then
		local pOwnerSP = self.Owner:GetShootPos()
		local pOwnerEA = self.Owner:EyeAngles()
		local fw = pOwnerEA:Forward()
		local rt = pOwnerEA:Right()
		local up = pOwnerEA:Up()
		
		local ent = ents.Create( "prop_physics" )
		if (  !IsValid( ent ) ) then return end
		ent:SetModel( self.ReloadGib )
		ent:SetMaterial( self.ReloadGibMaterial )
		ent:SetPos( pOwnerSP + ( up * -14 + rt * 4 + fw * 10 ) )
		ent:SetAngles( pOwnerEA + AngleRand() )
		ent:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
		ent:SetModelScale( self.ReloadGibSize )
		ent:Spawn()
			
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		if ( self.ReloadGibMass ) then
			phys:SetMass( self.ReloadGibMass )
		end
		phys:SetMaterial( "weapon" )
		phys:ApplyForceCenter( fw * 64 )
		
		SafeRemoveEntityDelayed( ent, 10 )
	end

end

function SWEP:CanReload()

	if ( self:Clip1() >= self.Primary.ClipSize ) then
		return false
	end
	
	if ( self:GetNextPrimaryFire() > CurTime() ) then
		return false
	end
	
	if ( self.Owner:IsPlayer() ) then
		if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then
			return false
		end

		if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
			return false
		end
		
		if ( ( self.SciFiState == SCIFI_STATE_SPRINT ) && ( cmd_advanims:GetBool() ) ) then
			return false
		end
	end	
	
	return true
	
end

function SWEP:OnReload()

end

function SWEP:OnReloadFinish()

end

function SWEP:Reload()

	if ( !self:CanReload() ) then return end

	self:OnReload()
	self:CreateReloadModels()

	if ( self.Owner:IsPlayer() ) then
		if ( SERVER ) then
			net.Start( "SciFiReload" )
			net.WriteBool( true )
			net.Send( self.Owner )
		end
	
		self.SciFiState = SCIFI_STATE_RELOADING

		self:SetAds( false )
		
		if ( self.ReloadRealisticClips ) then
			if ( self:Clip1() > 0 ) then
				self:SetClip1( 1 )
				self.Primary.ClipSize = self.Primary.ClipSize + 1
			else
				self:SetClip1( 0 )
			end
		end

		timer.Simple( self.ReloadTime, function()
			if ( IsValid( self ) && IsValid( self.Owner ) ) then
				if ( self.ReloadRealisticClips ) then
					self.Primary.ClipSize = self.Primary.DefaultClip
				end
				
				if ( self.ReloadAnimEndIdle ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end
				
				if ( SERVER ) then
					net.Start( "SciFiReload" )
					net.WriteBool( false )
					net.Send( self.Owner )
				end
				
				self.SciFiState = SCIFI_STATE_IDLE

				local vm = self.Owner:GetViewModel()
				vm:SetPlaybackRate( 1 )
				
				self:OnReloadFinish()
			end
		end )
	end
	
	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetNextPrimaryFire( CurTime() + self.ReloadTime )
		self:SetNextSecondaryFire( CurTime() + self.ReloadTime )
		
		if ( self.ReloadSND ) then
			self:EmitSound( self.ReloadSND )
		end

		self:SetNWInt( "BurstCount", 5 )

		if ( self.Owner:IsPlayer() ) then
			local vm = self.Owner:GetViewModel()
			vm:SetPlaybackRate( self.ReloadPlaybackRate )
	
			self:DefaultReload( self.ReloadACT )
			self.Owner:DoReloadEvent()

			vm:SetPlaybackRate( self.ReloadPlaybackRate )
		else
			self:SetClip1( self.Primary.ClipSize )
		end
	end
	
end

function SWEP:DrawMuzzleLight( color, fov, range, lifetime )

	if ( cmd_fx_muzzlelights:GetInt() < 2 ) then return end
	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
	local pOwnerAV = self.Owner:GetAimVector()
	local pOwnerEP = self.Owner:EyePos()
	local ang = pOwnerAV:Angle()

	local vmEntity = self:GetViewModelEnt()

	local vmAttach = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )

	if ( !vmAttach || vmAttach == 0 ) then
		vmAttach = vmEntity:LookupAttachment( "1" )
	end
	
	local pos 
	if ( !vmAttach || vmAttach == 0 ) then
		pos = self:GetProjectileSpawnPos()
	else
		pos = vmEntity:GetAttachment( vmAttach ).Pos
		pos = pos + ( VectorRand() * ( self.SciFiACC / 10 ) )
	end

	if ( SERVER ) then
		local realtime = ents.Create( "env_projectedtexture" )
		if ( !IsValid( realtime ) ) then return end
		realtime:SetKeyValue( "targetname", "realtimelight" )
		realtime:SetPos( pos )
		realtime:SetAngles( ang )		
		realtime:SetKeyValue( "lightfov", fov * m_random( 0.98, 1.02 ) )
		realtime:SetKeyValue( "lightworld", 1 )	
		realtime:SetKeyValue( "lightcolor", color )
		realtime:SetKeyValue( "enableshadows", 1 )
		realtime:SetKeyValue( "farz", range )
		realtime:SetKeyValue( "nearz", 4 )
		realtime:SetParent( self )
		realtime:Spawn()
		realtime:Fire( "SpotlightTexture", self.VfxMuzzleProjexture, 0 )
		realtime:Fire( "kill", "", lifetime )
	end
	
end

function SWEP:CanMelee()
	
	if ( !self.Owner:IsPlayer() ) then return false end
	if ( self.Owner:InVehicle() ) then return false end

	local cmd_allow_melee = GetConVar( "sfw_allow_melee" ):GetBool()
	if ( !cmd_allow_melee ) then return false end

	if ( self.Owner:KeyDown( IN_ATTACK ) ) then return false end
	
	if ( self.SciFiState ~= SCIFI_STATE_IDLE ) then return false end
	
	return true
	
end

function SWEP:SciFiMelee()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end
	
	if ( !self:CanMelee() ) then return end
	
	if ( !self.SciFiMeleeCharge ) then 
		self.SciFiMeleeCharge = 0 
	end

	if ( self.Owner:KeyDown( IN_GRENADE2 ) && !self.Owner:KeyPressed( IN_ATTACK ) ) then
		if ( self.SciFiMeleeCharge < self.SciFiMeleeChargeMax ) then
			self.SciFiMeleeCharge = self.SciFiMeleeCharge + 1
		end
	else
		if ( self.SciFiMeleeCharge > 0 ) then
			self.SciFiMeleeCharge = self.SciFiMeleeCharge - 0.5
		end
	end

	if ( self.Owner:KeyReleased( IN_GRENADE2 ) ) then
		if !( self.SciFiMeleeTime <= CurTime() && self:GetNextPrimaryFire() < CurTime() ) then return end

		self.SciFiState = SCIFI_STATE_MELEE_ATTACK
		
		self:EmitSound( self.SciFiMeleeSound )
		
		local vPunchAng = Angle( m_random( 1, 2 ), m_random( 1, 5 ), m_random( 0, 0.1 ) )
		self.Owner:ViewPunch( vPunchAng * ( 4 + self.SciFiACC * 0.5 + self.SciFiMeleeCharge / 10 ) )
		
		timer.Simple( self.SciFiMeleeRecoverTime, function()
			if ( IsValid( self ) && IsValid( self.Owner ) && self.Owner:Alive() ) then
				self.SciFiState = SCIFI_STATE_MELEE_IDLE
			end
		end )
		
		local amp = GetConVar( "sfw_damageamp" ):GetFloat()
		local playervelo = self.Owner:GetVelocity()
		local velo = m_Clamp( ( m_Round( ( m_abs( playervelo.y ) + m_abs( playervelo.x ) + m_abs( playervelo.z ) ) ) / 64 ), 1, 10 )

		if ( !game.SinglePlayer() && SERVER ) || ( CLIENT ) then
			self.Owner:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true )
		end
		
		self.Owner:LagCompensation( true )
	
		local tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.SciFiMeleeRange,
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		} )

		if ( !IsValid( tr.Entity ) ) then 
			tr = util.TraceHull( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * ( self.SciFiMeleeRange + self.SciFiMeleeCharge / 8 ) ,
				filter = self.Owner,
				mins = Vector( -10, -4, -2 ),
				maxs = Vector( 10, 4, 2 ),
				mask = MASK_SHOT_HULL
			} )
		end
		
		if ( SERVER && IsValid( tr.Entity ) ) then -- && ( tr.Entity:GetOwner() ~= self.Owner ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 || tr.Entity:IsRagdoll() || tr.Entity:GetClass() == "prop_physics" ) ) then
			local dmginfo = DamageInfo()
			
			local cmd_stealthfinisher = GetConVar( "sfw_allow_stealthfinishers" )
			local iDmg = self.SciFiMeleeDamage * amp + velo + self.SciFiMeleeCharge / 10
			
			if ( tr.Entity:GetClass() == "item_item_crate" ) then
				iDmg = iDmg * 4
			end
			
			if ( util.GetSurfacePropName( tr.SurfaceProps ) == "glass" && tr.Entity:GetClass() == "func_breakable" ) then
				iDmg = iDmg * 2
			end
			
			if ( self.Owner:WaterLevel() == 3 ) then
				iDmg = iDmg / 2
			end
			
			if ( cmd_stealthfinisher:GetBool() ) && ( tr.Entity:IsNPC() && tr.Entity:GetNPCState() == NPC_STATE_IDLE ) then
				iDmg = iDmg * 8
			end
			
			local attacker = self.Owner
			if ( !IsValid( attacker ) ) then attacker = self end
			dmginfo:SetAttacker( attacker )
			dmginfo:SetInflictor( attacker )
			dmginfo:SetDamage( iDmg )
			dmginfo:SetDamageForce( self.Owner:GetRight() * 2 + self.Owner:GetForward() * 12 )
			dmginfo:SetDamageType( self.SciFiMeleeDamageType )
			local phys = tr.Entity:GetPhysicsObject()
			
			if ( IsValid( phys ) ) then
				phys:ApplyForceCenter( self.Owner:GetRight() * 2 + self.Owner:GetForward() * 8 + playervelo * 4 )
			end
			
			if ( tr.Entity:IsNPC() ) then
				local target = tr.Entity	
				if ( !target:IsCurrentSchedule( SCHED_BACK_AWAY_FROM_ENEMY ) && target:GetMaxHealth() <= 150 && !target:GetNWBool( "bliz_frozen" )  ) then
					target:SetSchedule( SCHED_FEAR_FACE ) -- step aside, peasants!
					target:SetSchedule( SCHED_MOVE_AWAY )
					target:SetSchedule( SCHED_BACK_AWAY_FROM_ENEMY )
					target:SetSchedule( SCHED_RUN_FROM_ENEMY )
					timer.Simple( 50 / target:Health(), function()
						if ( IsValid( target ) ) && ( SERVER ) then
							target:SetSchedule( SCHED_WAKE_ANGRY )
						end
					end )
				end
			end

			tr.Entity:TakeDamageInfo( dmginfo )
		end

		if ( !( game.SinglePlayer() && CLIENT ) ) then
			if ( tr.Hit && !tr.HitWorld ) then
				self:EmitSound( self.SciFiMeleeHitBody )
			elseif( tr.HitWorld ) then
				self:EmitSound( self.SciFiMeleeHitWorld )
			end
		end

		if ( SERVER && IsValid( tr.Entity ) ) then
			local phys = tr.Entity:GetPhysicsObject()
			if ( IsValid( phys ) ) then
				phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
			end
		end

		self.Owner:LagCompensation( false )
		
		local delay = CurTime() + self.SciFiMeleeASpeed

--		self:SetNextPrimaryFire( delay - 0.1 )
		self.SciFiMeleeTime = delay
		self:AddSciFiACC( 12 )
		
		self.SciFiMeleeCharge = 0
	end

end

local iSprintSpeed
local dSprintSpeed
function SWEP:IsSprinting()

	if ( dSprintSpeed ~= self.Owner:GetRunSpeed() ) then
		iSprintSpeed = nil
	end

	if ( !iSprintSpeed ) then
		iSprintSpeed = self.Owner:GetRunSpeed() - 10
		dSprintSpeed = iSprintSpeed + 1
	end
	
	local key_sprint = self.Owner:KeyDown( IN_SPEED )
	if ( !key_sprint ) then return false end 

	local pVelo = self.Owner:GetVelocity()
	local pSpeed = pVelo:Length()

	if ( key_sprint ) && ( self.Owner:OnGround() ) && ( pSpeed >= iSprintSpeed ) then 
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			self:SetAds( false )
		end
		
		return true
	else
		return false
	end
	
end

local fIdleTime, fAttackTime1, fAttackTime2
function SWEP:AnimsUpdate( value )

--	if ( self.Owner:KeyDown( IN_ATTACK ) || self.Owner:KeyDown( IN_ATTACK2 ) ) then return end
	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then return end

	if ( !value ) then
		local vm = self.Owner:GetViewModel()
		value = vm:SequenceDuration()
	end
	
	if ( value < 0 ) then DevMsg( "@" .. self:GetClass() .. " : !Error; Tried to set negative idle time (" .. value .. ")." ) return end

	self:SetAnimNextIdle( CurTime() + value )

end

local dState
function SWEP:Anims()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) || ( !self.Owner:IsPlayer() ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end
	
	if ( self.ViewModelIdleAnim ) && ( ( self.SciFiState ~= SCIFI_STATE_ADS && dState == SCIFI_STATE_ADS ) || !( self.SciFiState == SCIFI_STATE_ADS ) ) then
		fIdleTime = self:GetAnimNextIdle()
		fAttackTime1 = self:GetNextPrimaryFire()
		fAttackTime2 = self:GetNextSecondaryFire()

		if ( SERVER || !game.SinglePlayer() ) then
			if ( fAttackTime1 > fIdleTime ) then
				local fDiff = fIdleTime - fAttackTime1
				fDiff = fDiff + 2
				self:AnimsUpdate( fDiff )
			end
			
			if ( fAttackTime2 > fIdleTime ) then
				local fDiff = fIdleTime - fAttackTime2
				fDiff = fDiff + 2
				self:AnimsUpdate( fDiff )
			end
			
			fIdleTime = self:GetAnimNextIdle()

			if ( fIdleTime >= 0 && fIdleTime < CurTime() ) then
				if ( self.Charge && self.Charge < 1 ) then
					self:AnimsUpdate()
					self:SendWeaponAnim( ACT_VM_IDLE )
				else
					self:AnimsUpdate( 1 )
				end
			end
		end
	end

	if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
		if ( dState == SCIFI_STATE_ADS ) then
			self.SwayScale 	= self.DefaultSwayScale
			self.BobScale 	= self.DefaultBobScale
		end

		dState = self.SciFiState
		return 
	end
	
	if ( self.SciFiState == SCIFI_STATE_MELEE_ATTACK ) then 
		dState = self.SciFiState
		return 
	end
	
	if ( self.SciFiState == SCIFI_STATE_ADS ) then
		if ( self:IsSprinting() ) then
			self.SciFiState = false
		end
		
		if !( dState == SCIFI_STATE_ADS ) then
			self.SwayScale 	= 0.2
			self.BobScale 	= 0.1
		end
	
		dState = self.SciFiState
		return 
	end
	
	if ( dState == SCIFI_STATE_ADS ) then
		self.SwayScale 	= self.DefaultSwayScale
		self.BobScale 	= self.DefaultBobScale
	end

	if ( self:IsSprinting() ) then
		self.SciFiState = SCIFI_STATE_SPRINT
	elseif ( !self.SciFiState ) || ( dState ~= SCIFI_STATE_IDLE ) then
		self.SciFiState = SCIFI_STATE_IDLE
	end

	local cmd_allow_anims = GetConVar( "sfw_allow_advanims" ):GetBool()

	if ( cmd_allow_anims ) && ( self.SprintAnim ) then
		if ( self.SprintAnimIdle ) then
			if ( self.SciFiState == SCIFI_STATE_SPRINT ) && ( dState ~= SCIFI_STATE_SPRINT ) then
				self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )
			end

			if ( self.SciFiState == SCIFI_STATE_IDLE ) && ( dState == SCIFI_STATE_SPRINT ) then
				self:SendWeaponAnim( ACT_VM_IDLE )
			end
		end

		if ( dState == SCIFI_STATE_SPRINT && self.SciFiState == SCIFI_STATE_SPRINT ) then
			if ( self.SprintAnimIdle && self.SciFiState ~= SCIFI_STATE_RELOADING ) then
				self:SendWeaponAnim( ACT_VM_IDLE_LOWERED )
			end

			if ( self.SwayScale ~= self.SprintSwayScale ) then
				self.SwayScale = self.SprintSwayScale
				self.BobScale = self.SprintBobScale
			end
			
			local wHType = self:GetHoldType()
			if ( wHType ~= self.HoldTypeSprint ) then
				self:SetHoldType( self.HoldTypeSprint )
			end
		elseif ( dState == SCIFI_STATE_SPRINT && self.SciFiState ~= SCIFI_STATE_SPRINT ) then
			if ( self.SwayScale ~= self.DefaultSwayScale ) then
				self.SwayScale 	= self.DefaultSwayScale
				self.BobScale 	= self.DefaultBobScale
			end

			local wHType = self:GetHoldType()
			if ( wHType ~= self.HoldType ) then
				self:SetHoldType( self.HoldType )
			end
		end
	end

	dState = self.SciFiState

end

function SWEP:AdjustMouseSensitivity()
	
	if ( CLIENT ) then
		local IsAds = self.SciFiState == SCIFI_STATE_ADS
	
		if ( IsAds ) then
			return self.AdsMSpeedScale
		else
			return 1
		end
	end

end

function SWEP:CanAds()

	if ( !IsValid( self.Owner ) ) then 
		return false
	end
	if ( self.Owner:IsNPC() ) then 
		return false
	end

	local key_use = self.Owner:KeyDown( IN_USE ) 
	
	if ( key_use ) && ( self.SciFiState ~= SCIFI_STATE_ADS ) then
		return false
	end
	
	if ( self.SciFiState == SCIFI_STATE_SPRINT || self.SciFiState == SCIFI_STATE_RELOADING ) then
		return false
	end
	
	if ( self.Owner:InVehicle() ) then
		return false
	end
	
	return true

end

function SWEP:Ads()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then 
		DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) 
		return 
	end

	if ( self.Owner:KeyPressed( IN_ATTACK2 ) ) then
		self:SetAds( true, true )
	end

	if ( self.Owner:KeyReleased( IN_ATTACK2 ) || self.SciFiState == SCIFI_STATE_RELOADING ) then
		self:SetAds( false, true )
	end

end

if ( SERVER ) then
	util.AddNetworkString( "SciFiADS" )
	util.AddNetworkString( "SciFiReload" )
	util.AddNetworkString( "SciFiUpdateOwnership" )
end

net.Receive( "SciFiADS", function( len, ply )

	local bool = net.ReadBool()
	local wep = ply:GetActiveWeapon()
	
	if ( IsValid( wep ) ) && ( bool ) then
		wep.SciFiState = SCIFI_STATE_ADS
	else
		wep.SciFiState = SCIFI_STATE_IDLE
	end
	
end )

net.Receive( "SciFiReload", function( len, ply )

	if ( !ply ) then
		ply = LocalPlayer()
	end

	if ( IsValid( ply ) ) then
		local bool = net.ReadBool()
		local wep = ply:GetActiveWeapon()

		if ( !IsValid( wep ) || bool == nil ) then return end

		if ( bool ) then
			wep.SciFiState = SCIFI_STATE_RELOADING

			local vm = ply:GetViewModel()
			if ( IsValid( vm ) ) then
				vm:SetPlaybackRate( wep.ReloadPlaybackRate )
			end
		else
			dState = wep.SciFiState
			wep.SciFiState = false
			
			local vm = ply:GetViewModel()
			if ( IsValid( vm ) ) then
				vm:SetPlaybackRate( 1 )
			end
		end
	end
	
end )

net.Receive( "SciFiUpdateOwnership", function( len, ply )

	if ( !CLIENT ) then return end
	
	local pOwner = net.ReadEntity()
	if ( !pOwner || pOwner == NULL ) then return end
	
	local vmEntity = pOwner:GetViewModel()
	
	for i=0, pOwner:GetBoneCount() do
		pOwner:ManipulateBoneScale( i, Vector(1, 1, 1) )
		pOwner:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		pOwner:ManipulateBonePosition( i, Vector(0, 0, 0) )
	end

	if ( !IsValid( vmEntity ) ) then return end

	vmEntity:SetSubMaterial( 0, "" )
	vmEntity:SetSubMaterial( 1, "" )
	vmEntity:SetSubMaterial( 2, "" )
	vmEntity:SetSubMaterial( 3, "" )
	vmEntity:SetSubMaterial( 4, "" )
	
	if ( !vmEntity:GetBoneCount() ) then return end
	
	for i=0, vmEntity:GetBoneCount() do
		vmEntity:ManipulateBoneScale( i, Vector(1, 1, 1) )
		vmEntity:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		vmEntity:ManipulateBonePosition( i, Vector(0, 0, 0) )
	end

end )

function SWEP:SetAds( adsBool, adsSounds )

	if ( !IsValid( self.Owner ) ) then return end
	if ( self.Owner:IsNPC() ) then return end
	
	if ( !self:CanAds() ) then return end

	if ( CLIENT ) then
		net.Start( "SciFiADS" )
			if ( adsBool ) then
				net.WriteBool( true )
				self.SciFiState = SCIFI_STATE_ADS
			else
				net.WriteBool( false )
				
				if ( self.SciFiState == SCIFI_STATE_ADS ) then
					self.SciFiState = SCIFI_STATE_IDLE
				end
			end
		net.SendToServer()
		
		if ( self.AdsSounds ) && ( adsSounds ) then
			if ( adsBool ) then
				self:EmitSound( self.AdsSoundEnable )
			else
				self:EmitSound( self.AdsSoundDisable )
			end
		end
	end

	if ( cmd_legacyzoom:GetBool() ) && ( ( SERVER ) || ( !game.SinglePlayer() && CLIENT ) ) then
		if ( !adsBool ) then
			local key_sprint = self.Owner:KeyDown( IN_SPEED )
		
			if ( key_sprint ) then
				self.Owner:SetFOV( 0, 0 )
			else
				self.Owner:SetFOV( 0, self.AdsFovTransitionTime )
			end
		end
		
		if ( adsBool ) && ( self:CanAds() ) && ( !self.AdsRTScopeEnabled ) then
			local cmd_enginefov = cmd_engine_fovdesired:GetInt()
			local fovcompensation = cmd_enginefov / 56 + ( cmd_enginefov - 90 )
			local fov = self.AdsFov
			fov = m_Round( self.AdsFov * fovcompensation, 2 )
		
			self.Owner:SetFOV( m_Clamp( fov, self.AdsFov, cmd_enginefov ), self.AdsFovTransitionTime )
		end
	end
	
	
	self:OnAds( adsBool )

end

function SWEP:OnAds( adsBool )

end

local angNull = Angle(0, 0, 0)
local angVBob = Angle(0, 0, 0)
local FovAdapted = 0

function SWEP:CalcView( pOwner, pOrigin, pAngles, pFov ) 

	local iFrameTime 	= FrameTime()
	local iCurTime  	= CurTime()
	
	if ( !self.AdsRTScopeEnabled ) then
		local FovEngine = pFov || cmd_engine_fovdesired:GetInt()
		local FovIntended = FovIndended || FovEngine

		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			local FovCompensation = FovEngine - 75 -- magic number of default FOV --
			
			FovAdapted = Lerp( iFrameTime * self.AdsTransitionSpeed, FovAdapted, ( FovEngine - ( self.AdsFov + FovCompensation ) ) )
		else
			FovAdapted = Lerp( iFrameTime * self.AdsTransitionSpeed, FovAdapted, 0 )
		end
		
		pFov = FovIntended - FovAdapted
	end
	
	local cmd_viewbob = cmd_viewbob:GetBool()
	if !( cmd_advanims && cmd_viewbob ) then return pOrigin, pAngles, pFov end
	
	local cos1, cos2
	local iPlayerSpeed 	= self.Owner:GetVelocity():Length()
	
	local pOwnerWS = self.Owner:GetWalkSpeed()

	if ( self.Owner:OnGround() ) && ( iPlayerSpeed > pOwnerWS * 0.1 ) then
		if ( iPlayerSpeed < pOwnerWS * 1.2 )  then
			cos1 = m_cos( iCurTime * 10 )
			cos2 = m_cos( iCurTime * 8 )
			angVBob.p = cos1 * 0.2
			angVBob.y = cos2 * 0.1
		else
			cos1 = m_cos( iCurTime * 18 )
			cos2 = m_cos( iCurTime * 10 )
			angVBob.p = cos1 * 0.4
			angVBob.y = cos2 * 0.2
		end
	else
		angVBob = LerpAngle( iFrameTime * 10, angVBob, angNull )
	end
	

	return pOrigin, pAngles + angVBob, pFov
	
end

function SWEP:ModulateViewModelPosition( pos, ang, newpos, newang, factor )

	if ( factor <= 0 ) then return pos, ang end

	local rt = ang:Right()
	local up = ang:Up()
	local fw = ang:Forward()
	
	if ( !game.SinglePlayer() ) then
		factor = factor * 0.8
	end
	
	pos = pos + newpos.x * rt * factor
	pos = pos + newpos.y * fw * factor
	pos = pos + newpos.z * up * factor
	
	ang:RotateAroundAxis( rt, self.ViewModelHomeAng.x + ( newang.x * factor ) )
	ang:RotateAroundAxis( up, self.ViewModelHomeAng.y + ( newang.y * factor ) )
	ang:RotateAroundAxis( fw, self.ViewModelHomeAng.z + ( newang.z * factor ) )
	
	return pos, ang
	
end

local dMouseX = 0
local dMouseY = 0
function SWEP:GetMouseOffset()
	if ( !GetConVar( "sfw_allow_viewsway" ):GetBool() ) then 
		return false
	end
	
	local iMouseX, iMouseY = gui.MouseX(), gui.MouseY()
	local iDiffX = dMouseX - iMouseX
	local iDiffY = dMouseY - iMouseY
	
	dMouseX = iMouseX
	dMouseY = iMouseY
	
	local mAngle = Angle( 0, 0, 0 )
	mAngle.pitch = iDiffY
	mAngle.yaw = iDiffX

	return mAngle
end

local vecSprint = Vector( 0, 0, 0 )
local angSprint = Angle( 0, 0, 0 )
local angDelta = Angle( 0, 0, 0 )
--[[
local vecMove, vecDelayed = Vector( 0, 0, 0 ), Vector( 0, 0, 0 )
local angMove, angDelayed = Angle( 0, 0, 0 ), Angle( 0, 0, 0 )

local cMoveFW, cMoveRT, cMoveUP = 0, 0, 0

if ( SERVER ) then
	util.AddNetworkString( "SciFiReadPlayerMovement" )

	local function ReadPlayerMovement( pEntity, CMoveData, CUserCmd )
		cMoveFW, cMoveRT, cMoveUP = CMoveData:GetForwardSpeed(), CMoveData:GetSideSpeed(), CMoveData:GetUpSpeed()
		
		if ( CMoveData:KeyDown( IN_JUMP ) ) then
			cMoveUP = 10000
		end
		
		if ( CMoveData:KeyDown( IN_DUCK ) ) then
			cMoveUP = -10000
		end

		net.Start( "SciFiReadPlayerMovement" )
		net.WriteVector( Vector( cMoveFW, cMoveRT, cMoveUP ) )
		net.Send( pEntity )
	end

	hook.Add( "SetupMove", "SciFiReadPlayerMovement", ReadPlayerMovement )
end

net.Receive( "SciFiReadPlayerMovement", function( len, ply )

	local mValue = net.ReadVector()
	cMoveFW, cMoveRT, cMoveUP = mValue.x, mValue.y, mValue.z

end )
]]--
function SWEP:GetViewModelPosition( pos, ang )

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end

	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()

	local inspectkey = cmd_kb_inspect:GetInt() 
	local WaterLevel = self.Owner:WaterLevel()
	local TimeStep = FrameTime()
	
	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
	local bAdvancedAnimations = cmd_advanims:GetBool()
	
	local vang = self.Owner:EyeAngles()
		
	if !( self.SciFiState == SCIFI_STATE_ADS ) && ( bAdvancedAnimations ) then
		local fPitchMod = m_abs( vang.pitch - 0.1, 0 )
		local vmod_pos = Vector( fPitchMod * -0.01, fPitchMod * 0.005, fPitchMod * -0.025 )
		local vmod_ang = Angle( 0, fPitchMod * 0.02, fPitchMod * 0.06 * ( 1 + sprint ) )

		local pVelo = self.Owner:GetVelocity()
		pVelo = pVelo:Length()

		local pVeloMax = self.Owner:GetRunSpeed()
--		local sprintspeed = m_min( 100, ( pVeloMax - 50 ) * -1, pVelo ) / 100

		vecSprint = Vector( 0, 0, 0 )
		
		local pVeloHold = pVeloMax / 4
		
		if ( pVelo > pVeloHold ) then
			local iMul = m_Round( pVelo / pVeloHold * self.ViewModelSprintSway, 0 )
			local f_SprintCos = m_cos( CurTime() * iMul ) * sprint
			local f_SprintSin = m_sin( CurTime() * iMul ) * sprint
			local f_SprintMod = m_tan( f_SprintCos * f_SprintSin, f_SprintCos * f_SprintSin )

			vecSprint = Vector( 0, 0, f_SprintMod )
		end
		
		if ( self.ViewModelReloadAnim ) then
			if ( self.SciFiState == SCIFI_STATE_RELOADING ) then
				relanim = m_Approach( relanim, 1, TimeStep * 4 )
			else
				if ( relanim > 0 ) then 
					relanim = m_Approach( relanim, 0, TimeStep * 4 )
				end
			end
			
			pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelReloadPos, self.ViewModelReloadAng, relanim )
		end
	
		if ( self.ViewModelInspectable ) then
			if ( input.IsKeyDown( inspectkey ) || input.IsMouseDown( inspectkey ) ) then
				menu = m_Approach( menu, 1, TimeStep * 6 )
			else
				if ( menu > 0 ) then 
					menu = m_Approach( menu, 0, TimeStep * 4 )
				end
			end
			
			pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelMenuPos, self.ViewModelMenuAng, menu )
		end
		
		if ( self.SciFiState == SCIFI_STATE_SPRINT && !self.Owner:Crouching() ) then
			sprint = m_Round( Lerp( TimeStep * ( self.SprintAnimSpeed / 2 ), sprint, 1 ), 3 )
			pos = pos + vecSprint
		elseif ( WaterLevel > 2 ) then  
			sprint = m_Round( Lerp( TimeStep * 2, sprint, 0 ), 2 )
		else
			sprint = m_Truncate( Lerp( TimeStep * self.SprintAnimSpeed, sprint, 0 ), 2 )
		end
		
		pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelSprintPos, self.ViewModelSprintAng, sprint )
		
		if ( self.SciFiState ~= SCIFI_STATE_SPRINT && self.Owner:Crouching() ) then
			crouch = m_Approach( crouch, 1, TimeStep * 8 )
		elseif ( WaterLevel > 2 ) then  
			crouch = m_Approach( crouch, 0, TimeStep * 4 )
		else
			if ( crouch > 0 ) then
				crouch = m_Approach( crouch, 0, TimeStep * 6 )
			end
		end
		
		pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelDuckPos, self.ViewModelDuckAng, crouch )

		if ( self.SciFiMeleeCharge ) && ( self.SciFiMeleeCharge >= 20 ) then
			pos = pos + self.ViewModelSprintPos.z * Forward * ( self.SciFiMeleeCharge - 20 ) * -0.022
			melee = Lerp( TimeStep * 2, melee, -0.2 )
		end
		
		if ( self.SciFiState == SCIFI_STATE_MELEE_ATTACK ) then
			if ( WaterLevel < 3 ) then
				melee = Lerp( TimeStep * 24, melee, 1 )
			else
				melee = Lerp( TimeStep * 6, melee, 1 )
			end
		else
			if ( melee > 0 ) then
				if ( WaterLevel < 3 ) then
					melee = m_Truncate( Lerp( TimeStep * 8, melee, 0 ), 3 )
				else
					melee = m_Truncate( Lerp( TimeStep * 2, melee, 0 ), 3 )
				end
			end
		end

		pos = pos + self.ViewModelMeleePos.x * Right * melee
		pos = pos + self.ViewModelMeleePos.y * Forward * melee
		pos = pos + self.ViewModelMeleePos.z * Up * melee
		
		ang:RotateAroundAxis( ang:Right(), self.ViewModelHomeAng.x + ( self.ViewModelMeleeAng.x * melee ) )
		ang:RotateAroundAxis( ang:Up(), self.ViewModelHomeAng.y + ( self.ViewModelMeleeAng.y * melee ) )
		ang:RotateAroundAxis( ang:Forward(), self.ViewModelHomeAng.z + ( self.ViewModelMeleeAng.z * melee ) )
		
		pos = pos + vmod_pos
		ang = ang + vmod_ang
	end
	
	if ( !self.AdsPos ) then return pos, ang end
	
	local speed = self.AdsTransitionSpeed
	
	if ( GetConVar( "sfw_allow_adsdeltaanim" ):GetBool() ) then
		speed = ( speed * self.ChargeDeltaFactor )
	end
	
	if ( self.AdsTransitionAnim && bAdvancedAnimations ) then
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			Mul = Lerp( TimeStep * speed, Mul, 0.975 )
--			Mul = m_Approach( Mul, 0.975, TimeStep * speed )
		else
			if ( Mul > 0 ) then
--				Mul = Lerp( TimeStep * speed, Mul, 0 )
				Mul = m_Approach( Mul, 0, TimeStep * speed )
			end
		end
	else 
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			Mul = 0.975
		else
			Mul = 0
		end
	end
	
	pos = pos + self.AdsPos.x * Right * Mul
	pos = pos + self.AdsPos.y * Forward * Mul
	pos = pos + self.AdsPos.z * Up * Mul
	
	ang:RotateAroundAxis( ang:Right(), self.AdsAng.x * Mul )
	ang:RotateAroundAxis( ang:Up(), self.AdsAng.y * Mul )
	ang:RotateAroundAxis( ang:Forward(), self.AdsAng.z * Mul )

	if ( GetConVar( "sfw_allow_viewsway" ):GetBool() ) then
		local pitch, yaw, roll
		pitch 	= m_AngleDifference( ang.pitch, angDelta.pitch )
		yaw 	= m_AngleDifference( ang.yaw, angDelta.yaw )
--		roll 	= m_AngleDifference( ang.roll, angDelta.roll )

		local aSway = Angle( 0, 0, 0 )
		aSway.pitch = m_Clamp( pitch, -1, 1 )
		aSway.yaw 	= m_Clamp( yaw, -1, 1 )
--		aSway.roll 	= m_Clamp( roll, -1, 1 )

		aSway.pitch = m_Round( pitch / 16, 3 )
		aSway.yaw 	= m_Round( yaw / 16, 3 )
--		aSway.roll 	= m_Round( roll / 12, 3 )
--[[
		vecMove = Vector( cMoveFW, cMoveUP, cMoveRT ) * 0.1
		angMove = Angle( cMoveFW / 10, 0, cMoveRT ) * 0.2

		vecDelayed = LerpVector( TimeStep * 4, vecMove, vecDelayed )
		angDelayed = LerpAngle( TimeStep * 2, angMove, angDelayed )
]]--
		local ratio = TimeStep * 16 --* self.ChargeDeltaFactor
		angDelta = LerpAngle( ratio, angDelta, ang )
	--	angDelta.pitch 	= Lerp( ratio, angDelta.pitch, ang.pitch )
	--	angDelta.yaw 	= Lerp( ratio, angDelta.yaw, ang.yaw )
	--	angDelta.roll 	= Lerp( ratio, angDelta.roll, ang.roll )
--[[		
		local adsmod = 1
		if ( self.SciFiState == SCIFI_STATE_ADS ) then
			adsmod = -1
		end
]]--
		local vSway = Vector( aSway.yaw * -0.2, 0, aSway.pitch * 0.2 )

		pos = pos + vSway -- + vecDelayed
		ang = ang + aSway + angVBob -- + angDelayed
	end

	return pos, ang
	
end

function SWEP:TranslateActivity( act )

	if ( self.Owner:IsNPC() ) then
		if ( self.ActivityTranslateAI[ act ] ) then
			return self.ActivityTranslateAI[ act ]
		end
		return -1
	end

	if ( self.ActivityTranslate[ act ] != nil ) then
		return self.ActivityTranslate[ act ]
	end

	return -1

end

function SWEP:SetupWeaponHoldTypeForAI( t )

	if ( t == "grenade" ) then
	
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_GRENADE_TOSS 
	
	end
	
	if ( t == "smg" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_SMG1
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SMG1
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_SMG1
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_SMG1

	return end
	
	if ( t == "ar2" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SMG1
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
--		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_AR2
--		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_SMG1
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_AR2_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_AR2

	return end

	if ( t == "pistol" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_PISTOL
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_PISTOL
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_PISTOL_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_PISTOL
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_PISTOL_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_PISTOL
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_PISTOL

	return end
	
	if ( t == "shotgun" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SHOTGUN
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SHOTGUN_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_AR2
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_AR2_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_AR2

	return end

end

function SWEP:DrawSciFiBaseDebugInfo( vmEntity, pOwner, pWeapon )

	local bShowAnimScaling = cmd_debug_showanimscaling:GetBool()
	if ( !bShowAnimScaling ) then return end

	local w, h = ScrW(), ScrH()
	local x, y = w * 0.05, h * 0.25
	
	local offset = 0
	
	local dbFont = "DebugFixed"
	local dbColorText = Color( 255, 255, 255, 255 )
	local dbColorPanel = Color( 50, 55, 60, 200 )
	
	cam.Start2D( Vector( x, y ), 1 )
		draw.WordBox( 4, x - 16, y + offset, "Animation Scaling", dbFont, dbColorPanel, dbColorText )
		offset = offset + 32
		draw.WordBox( 4, x, y + offset, "Sprint 		: " .. sprint .. " / " .. tostring( vecSprint ), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Crouch 		: " .. crouch, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Reload 		: " .. relanim, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Melee  		: " .. melee, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "ADS    		: " .. Mul, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "Inspect		: " .. menu, dbFont, dbColorPanel, dbColorText )
		offset = offset + 48
		draw.WordBox( 4, x - 16, y + offset, "Anim table", dbFont, dbColorPanel, dbColorText )
		offset = offset + 32
		draw.WordBox( 4, x, y + offset, "bob scale  : " .. self.BobScale, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "sway scale : " .. self.SwayScale, dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "sway angle  	: " .. tostring(angDelta), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "sequence   : " .. self:GetSequenceName(self:GetSequence()) .. " / " .. self:GetSequenceActivityName(self:GetSequence()), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "idle time  	: " .. tostring(fIdleTime) .. " / " .. tostring(CurTime()), dbFont, dbColorPanel, dbColorText )
		offset = offset + 48
		draw.WordBox( 4, x - 16, y + offset, "State", dbFont, dbColorPanel, dbColorText )
		offset = offset + 32
		draw.WordBox( 4, x, y + offset, "internal  : " .. tostring(self.SciFiState), dbFont, dbColorPanel, dbColorText )
		offset = offset + 24
		draw.WordBox( 4, x, y + offset, "delta  			: " .. tostring(dState), dbFont, dbColorPanel, dbColorText )
	cam.End2D()
	
end