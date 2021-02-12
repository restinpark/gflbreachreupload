SWEP.Gun							= ("rw_sw_dc15a")
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Base							= "tfa_gun_base"
SWEP.Category						= "Destiny Weapons"
SWEP.Manufacturer 					= ""
SWEP.Author							= "Delta"
SWEP.Contact						= ""
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "Hard Light"
SWEP.Type							= "Ionized polymer synballistic attack platform. The system's lethality is dynamically robust across tactical spaces."
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 70
SWEP.Slot							= 2
SWEP.SlotPos						= 100

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.SelectiveFire					= false
SWEP.DisableBurstFire				= true
SWEP.OnlyBurstFire					= false
SWEP.DefaultFireMode 				= "FullAuto"
SWEP.FireModeName 					= nil
SWEP.DisableChambering 				= true

SWEP.Primary.ClipSize				= 30
SWEP.Primary.DefaultClip			= 128
SWEP.Primary.RPM					= 600
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 40000
SWEP.Primary.RangeFalloff 			= -1
SWEP.Primary.NumShots				= 1
SWEP.Primary.Automatic				= true
SWEP.Primary.RPM_Semi				= 250
SWEP.Primary.Delay				    = 0
SWEP.Primary.Sound 					= Sound ("TFA_HARDLIGHT_FIRE.1");
SWEP.Primary.ReloadSound 			= Sound ("TFA_HARDLIGHT_RELOAD.1");
SWEP.Primary.PenetrationMultiplier 	= 1
SWEP.Primary.Damage					= 10
SWEP.Primary.HullSize 				= 2
SWEP.DamageType 					= DMG_BULLET

SWEP.DoMuzzleFlash 					= false

SWEP.IronRecoilMultiplier			= 0.5
SWEP.CrouchRecoilMultiplier			= 0.85
SWEP.JumpRecoilMultiplier			= 2
SWEP.WallRecoilMultiplier			= 1.1
SWEP.ChangeStateRecoilMultiplier	= 1.2
SWEP.CrouchAccuracyMultiplier		= 0.8
SWEP.ChangeStateAccuracyMultiplier	= 1
SWEP.JumpAccuracyMultiplier			= 10
SWEP.WalkAccuracyMultiplier			= 1.8
SWEP.NearWallTime 					= 0.5
SWEP.ToCrouchTime 					= 0.25
SWEP.WeaponLength 					= 35
SWEP.SprintFOVOffset 				= 2
SWEP.ProjectileVelocity 			= 9

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel						= "models/weapons/c_hardlight.mdl"
--SWEP.WorldModel						= "models/weapons/c_thorn.mdl"
SWEP.ViewModelFOV					= 54
SWEP.ViewModelFlip					= false
SWEP.UseHands 						= true
SWEP.HoldType 						= "ar2"
SWEP.ReloadHoldTypeOverride 		= "ar2"

SWEP.ShowWorldModel = false

SWEP.BlowbackEnabled 				= true
SWEP.BlowbackVector 				= Vector(math.random(0.02, -0.02), -1.5, -0.09)
SWEP.BlowbackCurrentRoot			= 0
SWEP.BlowbackCurrent 				= 1
SWEP.BlowbackBoneMods 				= nil
SWEP.Blowback_Only_Iron 			= true
SWEP.Blowback_PistolMode 			= false
SWEP.Blowback_Shell_Enabled 		= false
SWEP.Blowback_Shell_Effect 			= "None"

SWEP.Tracer							= 0
SWEP.TracerName 					= nil
SWEP.TracerCount 					= 0
SWEP.TracerLua 						= false
SWEP.TracerDelay					= 0
SWEP.ImpactEffect 					= "impact"



SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.IronSightTime 					= 0.4
SWEP.Primary.KickUp					= 0.1
SWEP.Primary.KickDown				= 0.1
SWEP.Primary.KickHorizontal			= 0.12
SWEP.Primary.StaticRecoilFactor 	= 0.45
SWEP.Primary.Spread					= 0.005
SWEP.Primary.IronAccuracy 			= 0.0009
SWEP.Primary.SpreadMultiplierMax 	= 1.5
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 0.85
SWEP.IronSightsMoveSpeed 			= 0.75

SWEP.IronSightsPos = Vector(-5.155, -3, 0.028)
SWEP.IronSightsAng = Vector(-3.518, -1, 0)
SWEP.RunSightsPos = Vector(5.226, -2, 0)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)
SWEP.InspectPos = Vector(8, -4.8, -3)
SWEP.InspectAng = Vector(11.199, 38, 0)	

SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "hardlight_void", "hardlight_solar", "hardlight_arc" }, order = 1 },
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(2.778, -0.186, 0.925), angle = Angle(0, -1, 0.5) }
}

SWEP.VElements = {
	--["ammo"] = { type = "Quad", bone = "WeaponBone", rel = "", pos = Vector(1.6, 2.56, -0.151), angle = Angle(90, -26, -90), size = 0.008, draw_func = nil},
	--["reticle"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "WeaponBone", rel = "", pos = Vector(3.96, 5, -0.19), angle = Angle(180, 19, 90), size = Vector(0.024, 0.024, 0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "reticle/SurosReticleMain", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["world"] = { type = "Model", model = "models/weapons/c_hardlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-11, 6.752, -7), angle = Angle(-12.858, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ThirdPersonReloadDisable		= false
SWEP.RTScopeAttachment				= -1
SWEP.Scoped_3D 						= false
SWEP.ScopeReticule 					= "" 
SWEP.Secondary.ScopeZoom 			= 3
SWEP.ScopeReticule_Scale 			= {0.875,0.875}
if surface then
	SWEP.Secondary.ScopeTable = nil --[[
		{
			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
			dottex = surface.GetTextureID("scope/gdcw_acogcross")
		}
	]]--
end

SWEP.MuzzleEffect = "hardlight_void"

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Initialize(...)
	self.Owner:SetNWString("hardlight_tracer", "tracer/hardlight_void_tracer" )
	self:Attach("hardlight_void")
	return BaseClass.Initialize(self, ...)
end

function SWEP:Think2(...)
	local element = self.Owner:GetNWString("hardlight_tracer")
	if self.Owner:KeyPressed(IN_RELOAD) and IsValid(self) then
		timer.Create("reloaddetect", 0.5, 1, function() 
			if !IsValid(self) then return end
			if self.Owner:KeyDown(IN_RELOAD) and IsValid(self) then
				if element == "tracer/hardlight_void_tracer" then
					self:Attach("hardlight_solar")
				end
				if element == "tracer/hardlight_solar_tracer" then
					self:Attach("hardlight_arc")
				end
				if element == "tracer/hardlight_arc_tracer" then
					self:Attach("hardlight_void")
				end
			end 
		end)
	end
	return BaseClass.Think2(self, ...)
end

function SWEP:ChangeElement(string)
	if string == "void" then
		self.Owner:SetNWString("hardlight_tracer", "tracer/hardlight_void_tracer" )
		self.MuzzleEffect = "hardlight_void"
	end
	if string == "arc" then
		self.Owner:SetNWString("hardlight_tracer", "tracer/hardlight_arc_tracer" )
		self.MuzzleEffect = "hardlight_arc"
	end
	if string == "solar" then
		self.Owner:SetNWString("hardlight_tracer", "tracer/hardlight_solar_tracer" )
		self.MuzzleEffect = "hardlight_solar"
	end
	timer.Create("elementsound", 1.5, 1, function() self:EmitSound("TFA_HARDLIGHT_CHANGE.1") end)
end

function SWEP:PrimaryAttack(...)
	if SERVER and self:CanPrimaryAttack(true) then
		self:HardlightBeam(true)
		ParticleEffectAttach(self.MuzzleEffect, 4, self.OwnerViewModel, self.OwnerViewModel:LookupAttachment("muzzle"))
	end
	return BaseClass.PrimaryAttack(self, ...)
end

function SWEP:HardlightBeam(bCharged, ShootPos, ShootDir)
	//if bCharged && !self.bInAttack then return end
	local tr
	if self.Owner:IsPlayer() then tr = util.TraceLine(util.GetPlayerTrace(self.Owner))
	else tr = util.TraceLine({start = ShootPos, endpos = ShootPos +ShootDir *32768, filter = self.Owner}) end
	//self:PlaySound("Primary")
	local posShoot = tr.HitPos
	local entBeam = ents.Create("destiny_hardlight_beam")
	entBeam:SetScale(0)
	entBeam:SetPos(posShoot)
	entBeam:AddPosition(tr.HitPos)
	local iRichochet = 4
	local flDist = posShoot:Distance(tr.HitPos)
	while tr.Normal:Dot(tr.HitNormal) *-1 <= 1 && iRichochet > 0 do
		local ang = tr.Normal:Angle()  
		ang:RotateAroundAxis(tr.HitNormal,180)   
		
		local posLast = tr.HitPos
		tr = util.QuickTrace(tr.HitPos, (ang:Forward() *-1) *32768, self.Owner)
		//self:DispatchTraceAttack(DMG_PLASMA, tr)
		flDist = flDist +posLast:Distance(tr.HitPos)
		if flDist > 5000 then break end
		entBeam:AddPosition(tr.HitPos)
		iRichochet = iRichochet -1
		ParticleEffect(self.MuzzleEffect, tr.HitPos, ang)
		//print("lol")
	end
	//util.BlastDamage(self, self.Owner, tr.HitPos, 80, 100)
	entBeam:Spawn()
	entBeam:SetParent(self.Owner)
	entBeam:SetOwner(self.Owner)

	local fx = EffectData()
	fx:SetOrigin(tr.HitPos)
	fx:SetNormal(tr.HitNormal)
	//util.Effect(self.MuzzleEffect, fx)
	
	//if CLIENT then return end

	local splodepos = tr.HitPos

	local vaporizer = ents.Create("point_hurt")
	vaporizer:SetKeyValue("Damage",self.Primary.Damage*1.1)
	vaporizer:SetKeyValue("DamageRadius",100)
	vaporizer:SetKeyValue("DamageType",DMG_BULLET)// DMG_BLAST)
	vaporizer:SetPos(splodepos)
	//vaporizer:SetOwner(self.Owner)
	vaporizer:Spawn()
	vaporizer:Fire("hurt","",0)
	vaporizer:Fire("kill","",0.1)
end

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end -- Do not draw effects vs. the sky.
	ParticleEffect(self.MuzzleEffect, tr.HitPos + tr.HitNormal, self.Owner:EyeAngles()) -- draw the particle
	return false

end