-- Variables that are used on both client and server
SWEP.Gun = ("tfa_csgo_ssg08")					-- must be the name of your swep
SWEP.Category				= "TFA CS:GO"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "SSG 08"		-- Weapon name (Shown on HUD)	
SWEP.Slot = 3
SWEP.SlotPos = 10
SWEP.ItemType = WEAPON_GUN or 6
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.UseHands = true

SWEP.ViewModelFOV		= 56
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_snip_ssg08.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_scout.mdl"	-- Weapon world model
SWEP.Base				= "tfa_csgo_base"
SWEP.Scoped = false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("TFA_CSGO_SSG08.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 48 			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "SniperPenetratedRound"
SWEP.NearlyEmpty_ClipSize = 0

SWEP.IronInSound = Sound("TFA_CSGO_SSG08.Zoom") --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound("TFA_CSGO_SSG08.Zoom") --Sound to play when ironsighting out?  nil for default

--SWEP.Secondary.ScopeZoom = 90 / 45
SWEP.Secondary.IronFOV			= 15		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 15	-- Base damage per bullet
SWEP.Primary.Spread		= .01	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0.0015 -- Ironsight accuracy, should be the same for shotguns

SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 23/30
SWEP.LuaShellEffect = "RifleShellEject" --Defaults to blowback

SWEP.BoltAction		= true

SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= false	-- I mean it, only one	
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	
SWEP.Secondary.UseAimpoint		= false
SWEP.Secondary.UseMatador		= false
SWEP.Secondary.ScopeTable = {
	["ScopeMaterial"] =  Material("tfa_csgo/scope_lens.png", "smooth"),
	["ScopeBorder"] = color_black,
	["ScopeCrosshair"] = { ["r"] = 0, ["g"]  = 0, ["b"] = 0, ["a"] = 255, ["s"] = 1 }
}

-- Enter iron sight info and bone mod info below
SWEP.Scoped = true --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.9 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.6 --Scale of the scope overlay
SWEP.ReticleScale = 0.5 --Scale of the reticle overlay

SWEP.IronSightsPos = Vector(-6.03, -5.829, 1.21)
SWEP.IronSightsAng = Vector(0.15, -1.491, -3.5)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)
SWEP.ScopeOverlayTransforms = {-2, 5}
--SWEP.InspectPos = Vector(0,0,0)
--SWEP.InspectAng = Vector(0,0,0)
SWEP.DisableIdleAnimations = false
SWEP.FidgetLoop = false --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.Primary.Range = 0.8/0.305*16*1000
SWEP.Primary.SpreadIncrement = 0.3
SWEP.Primary.SpreadRecovery = 2
SWEP.Primary.SpreadMultiplierMax = 2.5
 
SWEP.Offset = {
        Pos = {
        Up = 0.7,
        Right = 0.5,
        Forward = 1.0,
        },
        Ang = {
        Up = 0,
        Right = -9,
        Forward = 180,
        },
		Scale = 1.2
}

SWEP.RTMaterialOverride = nil
SWEP.ScopeAngleTransforms = {
	{"P",90},
	{"Y",1.8}
}
SWEP.RTScopeScale = {1,0.5}

SWEP.DoMuzzleFlash = true --Do a muzzle flash?
SWEP.CustomMuzzleFlash = true --Disable muzzle anim events and use our custom flashes?
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_csgo_muzzle_huntingrifle_ssg"

--Tracer Stuff
SWEP.TracerCount 		= 0 	--0 disables, otherwise, 1 in X chance

SWEP.TracerParticleName = "weapon_tracers_assrifle"

--[[
	
local wepcol = Color(0,0,0,255)

local cd = {}

SWEP.RTMaterialOverride = 2

SWEP.RTOpaque = true

SWEP.RTCode = function( self, rt, scrw, scrh )
	
	if !self.myshadowmask then self.myshadowmask = Material("vgui/scope_shadowmask") end
	if !self.myreticule then self.myreticule = Material("scope/gdcw_scopesightonly") end

	local vm = self.Owner:GetViewModel()
	
	if !self.LastOwnerPos then self.LastOwnerPos = self.Owner:GetShootPos() end
	
	local owoff = self.Owner:GetShootPos() - self.LastOwnerPos
	
	self.LastOwnerPos = self.Owner:GetShootPos()
	

	
	local att = vm:GetAttachment(3)
	if !att then return end
	
	local pos = att.Pos - owoff
	
	local scrpos = pos:ToScreen()
	
	scrpos.x = scrpos.x - scrw/2
	scrpos.y = scrpos.y - scrh/2
	
	scrpos.x = scrpos.x * ( 2 - self.CLIronSightsProgress*1.5 )
	scrpos.y = scrpos.y * ( 2 - self.CLIronSightsProgress*1.5 )
	
	if !self.scrpos then self.scrpos = scrpos end
	
	self.scrpos.x = math.Approach( self.scrpos.x, scrpos.x, (scrpos.x-self.scrpos.x)*FrameTime()*10 )
	self.scrpos.y = math.Approach( self.scrpos.y, scrpos.y, (scrpos.y-self.scrpos.y)*FrameTime()*10 )
	
	scrpos = self.scrpos
	
	render.OverrideAlphaWriteEnable( true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-512,-512,1024,1024)
	render.OverrideAlphaWriteEnable( true, true)
	
	local ang = EyeAngles()
	
	local AngPos = self.Owner:GetViewModel():GetAttachment(3)
	
	if AngPos then
	
		ang = AngPos.Ang
		
		ang:RotateAroundAxis(ang:Right(),89.94)
		ang:RotateAroundAxis(ang:Up(), 1.725)
	
	end
	
	cd.angles = ang
	cd.origin = self.Owner:GetShootPos()
	
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 256
	cd.fov = 3
	cd.drawviewmodel = false
	cd.drawhud = false
	
	render.Clear( 0, 0, 0, 255, true, true )
	
	render.SetScissorRect(0,0,512,256,true)
	if self.CLIronSightsProgress>0.01 then
		render.RenderView(cd)
	end
	render.SetScissorRect(0,0,512,256,false)
	
	render.OverrideAlphaWriteEnable( false, true)
	
	
	cam.Start2D()
		draw.NoTexture()
		surface.SetMaterial(self.myshadowmask)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(scrpos.x,scrpos.y,512,256)
		surface.SetMaterial(self.myreticule)
		surface.DrawTexturedRect(0,0,512,256)		
		surface.SetDrawColor(color_black)
		draw.NoTexture()
		surface.DrawRect(scrpos.x-2048, -1024, 2048, 2048)
		surface.DrawRect(scrpos.x+512, -1024, 2048, 2048)
		surface.DrawRect(-1024, scrpos.y-2048, 2048, 2048)
		surface.DrawRect(-1024, scrpos.y+256, 2048, 2048)
		surface.SetDrawColor(ColorAlpha(color_black,255-255*( math.Clamp( self.CLIronSightsProgress-0.75,0,0.25 )*4 ) ) )
		surface.DrawRect(-1024, -1024,2048,2048)
	cam.End2D()
	
end

SWEP.IronSightsSensitivity = 0.35
]]--
SWEP.FireModeName = "Bolt-Action"
SWEP.DisableChambering = true

SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?

SWEP.MoveSpeed = 230/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 230/260*0.8 --Multiply the player's movespeed by this when sighting.

SWEP.Secondary.ScopeScreenScale = 336 / 1080

SWEP.ShootWhileDraw=false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw=false --Can you reload while draw anim plays?
SWEP.SightWhileDraw=false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster=false --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster=false --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster=false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload=true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting=false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall=false --Can you reload when close to a wall and facing it?

SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 59 / 30
}

SWEP.MagModel = Model("models/weapons/tfa_csgo/w_snip_scout_mag.mdl")
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ time = 24 / 30, type = "lua", value = function(wep,vm) wep:DropMag() end, client = true, server = true },
	}
}