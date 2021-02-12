SWEP.Base					= "tfa_gun_base"

-- [[ BASIC_INFO ]]
	-- [ Spawnmenu ]
		SWEP.PrintName				= "Tears"
		SWEP.Category				= "Other"
		SWEP.Spawnable				= true
		SWEP.AdminSpawnable			= false

	-- [ HUD ]
		SWEP.DrawCrosshair			= true
		SWEP.DrawCrosshairIS 			= false
		SWEP.Manufacturer 			= "Isaac"
		SWEP.Author					= "SeNNoX"
		SWEP.Purpose				= ""
		SWEP.Description				= ""
		SWEP.Type 					= "Isaac's Tears"

	-- [ Inventory ]
		SWEP.Slot					= 2
		SWEP.SlotPos				= 73
		SWEP.AutoSwitchTo			= true
		SWEP.AutoSwitchFrom			= true
		SWEP.Weight					= 30

-- [[ WEAPON_HANDLING ]]
	-- [ Isaac Stats ]
		SWEP.Isaac = {}
		SWEP.Isaac.Raw = {}
		SWEP.Isaac.Player = {}
		SWEP.Isaac.Stats = {}
		SWEP.Isaac.Effective = {}
		SWEP.Isaac.Tear = {}
		SWEP.Isaac.Tear.Laser = {}
		SWEP.Isaac.Equipped = {}

		SWEP.Isaac.Stats.Damage 		= 5
		SWEP.Isaac.Stats.DamageMult 	= 1
		SWEP.Isaac.Stats.Tears			= 1
		SWEP.Isaac.Stats.TearsShot		= 1
		SWEP.Isaac.Stats.TearSpread		= 0
		SWEP.Isaac.Stats.TearDelayMult	= 1
		SWEP.Isaac.Stats.TearDelayDiv	= 1
		SWEP.Isaac.Stats.TearDelayExtra	= 0
		SWEP.Isaac.Stats.Range 		= 23.75
		SWEP.Isaac.Stats.Speed 		= 1
		SWEP.Isaac.Stats.ShotSpeed 		= 1
		SWEP.Isaac.Stats.Luck 			= 0

		SWEP.Isaac.Tear.Spectral 		= false
		SWEP.Isaac.Tear.Piercing		= false
		SWEP.Isaac.Tear.Ent 			= { [50] = "" }
		SWEP.Isaac.Tear.Color			= { [50] = Color(0,200,250,200) }

		function SWEP:IsaacStats()
			self.Isaac.Raw.Range 			= math.max( self.Isaac.Stats.Range , 7 )

			self.Isaac.Effective.Damage 		= (self.Isaac.Stats.Damage * 5)*self.Isaac.Stats.DamageMult
			self.Isaac.Effective.Range 		= self.Isaac.Stats.Range / 10
			self.Isaac.Effective.TearDelay 	= ((math.max( math.floor( 16-6*math.sqrt( (self.Isaac.Stats.Tears-1)*1.3+1 ) ), 5)*self.Isaac.Stats.TearDelayMult)/self.Isaac.Stats.TearDelayDiv)+self.Isaac.Stats.TearDelayExtra
			self.Isaac.Effective.RPM 		= math.Round(30/( self.Isaac.Effective.TearDelay+1 )*60, 2)
			self.Isaac.Effective.ShotSpeed 	= self.Isaac.Stats.ShotSpeed*1000

			self.Primary.Damage 			= self.Isaac.Effective.Damage
			self.Primary.RPM 				= self.Isaac.Effective.RPM


			local EntityMin = 50
			for k,v in pairs(self.Isaac.Tear.Ent) do
				if k < EntityMin then
					EntityMin = k
				end
			end

			self.Isaac.Tear.EntFull 		= "proj_isaactears"..self.Isaac.Tear.Ent[EntityMin]
		end
		SWEP:IsaacStats()

	-- [ Shooting ]
		SWEP.Primary.PenetrationMultiplier 	= 1
		SWEP.Primary.Damage 			= SWEP.Isaac.Effective.Damage
		SWEP.Primary.DamageTypeHandled 	= true
		SWEP.Primary.DamageType 		= 0
		SWEP.Primary.Force 			= nil
		SWEP.Primary.Knockback 		= nil
		SWEP.Primary.HullSize 			= 0
		SWEP.Primary.NumShots 		= 1
		SWEP.Primary.Automatic 		= true
		SWEP.Primary.TotalTears		= 1
		SWEP.Primary.RPM 			= SWEP.Isaac.Effective.RPM
		SWEP.Primary.RPM_Semi 		= nil
		SWEP.Primary.RPM_Burst 		= nil
		SWEP.Primary.DryFireDelay 		= nil
		SWEP.Primary.BurstDelay 		= nil
		SWEP.FiresUnderwater 			= false
		SWEP.MaxPenetrationCounter 		= 4

	-- [ Sounds ]
		SWEP.Primary.Sound 			= nil
		SWEP.IronInSound 			= nil
		SWEP.IronOutSound 			= nil

	-- [ Selective_Fire ]
		SWEP.SelectiveFire 			= false
		SWEP.DisableBurstFire 			= true
		SWEP.OnlyBurstFire 			= false
		SWEP.DefaultFireMode 			= "Automatic"
		SWEP.FireModeName 			= nil
		SWEP.FireModes 				= {"Automatic"}

	-- [ Ammo ]
		SWEP.Primary.ClipSize 			= -1
		SWEP.Primary.DefaultClip 		= -1
		SWEP.Primary.Ammo 			= "none"
		SWEP.Primary.AmmoConsumption 	= 0
		SWEP.DisableChambering 		= true

		SWEP.Shotgun 				= false
		SWEP.ShotgunEmptyAnim 		= false						-- Enable empty reloads on shotguns?
		SWEP.ShotgunEmptyAnim_Shell 	= true						-- Enable insertion of a shell directly into the chamber on empty reload?
		SWEP.ShellTime 				= .35

	-- [ Recoil ]
		SWEP.Primary.KickUp 			= 0.2
		SWEP.Primary.KickDown 			= 0.2
		SWEP.Primary.KickHorizontal 		= 0.2
		SWEP.Primary.StaticRecoilFactor 	= 0.5
		SWEP.IronRecoilMultiplier 		= 0.4							-- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.

	-- [ Accuracy_and_Range ]
		SWEP.Primary.Spread 			= .025
		SWEP.Primary.IronAccuracy 		= nil
		SWEP.Primary.SpreadMultiplierMax 	= nil							-- How far the spread can expand when you shoot. Example val: 2.5
		SWEP.Primary.SpreadIncrement 	= 1/2.5							-- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
		SWEP.Primary.SpreadRecovery 		= nil							-- How much the spread recovers, per second. Example val: 3
		SWEP.Primary.Range 			= -1
		SWEP.Primary.RangeFalloff 		= 0.6
		SWEP.CrouchAccuracyMultiplier 	= 0.5							-- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

	-- [ Blowback ]
		SWEP.BlowbackEnabled 			= false
		SWEP.BlowbackVector 			= Vector(0,-4,0)	
		SWEP.BlowbackCurrentRoot 		= 0							-- Amount of blowback currently, for root
		SWEP.BlowbackCurrent 			= 0							-- Amount of blowback currently, for bones
		SWEP.BlowbackBoneMods 		= nil							-- Viewmodel bone mods via SWEP Creation Kit
		SWEP.Blowback_Only_Iron 		= true
		SWEP.Blowback_PistolMode 		= false						-- Do we recover from blowback when empty?
		SWEP.Blowback_Shell_Enabled 	= false
		SWEP.Blowback_Shell_Effect 		= ""

	-- [ Misc ]
		SWEP.CanBeSilenced 			= true
		SWEP.Silenced 				= false

		SWEP.Akimbo 				= false
		SWEP.AnimCycle 				= 0							-- Start on the right

		SWEP.ProjectileEntity 			= nil
		SWEP.ProjectileVelocity 			= nil
		SWEP.ProjectileModel 			= nil

		SWEP.MoveSpeed 				= 1							-- Multiply the player's movespeed by this.
		SWEP.IronSightsMoveSpeed 		= 0.8						-- Multiply the player's movespeed by this when sighting.

-- [[ COSMETIC ]]
	-- [ Viewmodel ]
		SWEP.ViewModel				= "models/weapons/v_nothing.mdl"
		SWEP.ViewModelFOV			= 65
		SWEP.ViewModelFlip			= false
		SWEP.UseHands 				= false
		SWEP.Bodygroups_V 			= nil

	-- [ Worldmodel ]
		SWEP.WorldModel				= "models/weapons/w_nothing.mdl"
		SWEP.ShowWorldModel			= false
		SWEP.Bodygroups_W 			= nil
		SWEP.HoldType 				= "normal"
		SWEP.IronSightHoldTypeOverride 	= ""
		SWEP.SprintHoldTypeOverride 		= ""
		SWEP.Offset = {
			Pos = {
				Up = 0,
				Right = 0,
				Forward = 0
			},
			Ang = {
				Up = -1,
				Right = -2,
				Forward = 178
			},
			Scale = 1
		}
		SWEP.ThirdPersonReloadDisable 	= false

	-- [ Iron_Sights ]
		SWEP.data 					= {}
		SWEP.data.ironsights 			= 0
		SWEP.AltAttack				= true
		SWEP.Secondary.IronFOV 		= 70
		SWEP.IronSightsSensitivity 		= 1							-- 0.XX = XX%
		SWEP.BoltAction 				= false						-- Unscope/sight after you shoot?
		
		SWEP.Scoped 				= false 						-- Scope Overlay
		SWEP.ScopeOverlayThreshold 		= 0.875						-- Percentage you have to be sighted in to see the scope.
		SWEP.BoltTimerOffset 			= 0.258						-- How long you stay sighted in after shooting, with a bolt action.
		SWEP.ScopeScale 				= 0.5							-- Scale of the scope overlay
		SWEP.ReticleScale 			= 0.7							-- Scale of the reticle overlay

		SWEP.RTMaterialOverride 		= nil							-- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
		SWEP.RTOpaque 				= false						-- Do you want your render target to be opaque?
		SWEP.RTCode 				= nil							-- function(self) return end -- This is the function to draw onto your rendertarget

				-- GDCW Overlay Options.  Only choose one.
			SWEP.Secondary.UseACOG 		= false
			SWEP.Secondary.UseMilDot 		= false
			SWEP.Secondary.UseSVD 		= false
			SWEP.Secondary.UseParabolic 		= false
			SWEP.Secondary.UseElcan 		= false
			SWEP.Secondary.UseGreenDuplex 	= false
			if surface then
				SWEP.Secondary.ScopeTable = nil						-- { scopetex = surface.GetTextureID("scope/gdcw_closedsight"), reticletex = surface.GetTextureID("scope/gdcw_acogchevron"), dottex = surface.GetTextureID("scope/gdcw_acogcross") }
			end

	-- [ Offsets ]
		SWEP.VMPos 				= Vector(0,0,0)
		SWEP.VMAng 				= Vector(0,0,0)
		SWEP.VMPos_Additive 			= true
		SWEP.CenteredPos 			= nil
		SWEP.CenteredAng 			= nil

		SWEP.IronSightsPos 			= nil
		SWEP.IronSightsAng 			= nil

		SWEP.InspectPos 				= nil
		SWEP.InspectAng 				= nil

		SWEP.RunSightsPos 			= nil
		SWEP.RunSightsAng 			= nil

	-- [ Attachments ]
		SWEP.ViewModelBoneMods = {
		}

		SWEP.VElements = {
		}

		SWEP.WElements = {
		}

		SWEP.Attachments = {
		}

		SWEP.AttachmentDependencies 	= {}							-- {["si_acog"] = {"bg_rail"}}
		SWEP.AttachmentExclusions 		= {}
		SWEP.AllowViewAttachment 		= true

-- [[ ANIMATION ]]
	-- [ Overrides ]
		SWEP.StatusLengthOverride 		= {}							-- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
		SWEP.SequenceLengthOverride 		= {
			[ACT_VM_RELOAD] = 1.8
		}													-- Changes both the status delay and the nextprimaryfire of a given animation
		SWEP.SequenceRateOverride 		= {
			[ACT_VM_RELOAD] = 1
		}							-- Like above but changes animation length to a target
		SWEP.SequenceRateOverrideScaled 	= {}							-- Like above but scales animation length rather than being absolute

	-- [ Modes_and_Transitions ]
		SWEP.Sights_Mode 			= TFA.Enum.LOCOMOTION_LUA			-- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
		SWEP.Sprint_Mode 			= TFA.Enum.LOCOMOTION_LUA			-- ANI = mdl, HYBRID = ani + lua, Lua = lua only
		SWEP.Idle_Mode 				= TFA.Enum.IDLE_BOTH				-- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
		SWEP.Idle_Blend 				= 0.25						-- Start an idle this far early into the end of a transition
		SWEP.Idle_Smooth 			= 0.05						-- Start an idle this far early into the end of another animation

	-- [ Event Table ]
		SWEP.EventTable 	= {
		}

	-- [ Sequences ]
		SWEP.IronAnimation = {
			["in"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ,					-- Sequence or act
				["value"] = "Idle_To_Iron",							-- Number for act, String/Number for sequence
				["value_empty"] = "Idle_To_Iron_Dry",
				["transition"] = true
			},
			["loop"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ,					-- Sequence or act
				["value"] = "Idle_Iron",							-- Number for act, String/Number for sequence
				["value_empty"] = "Idle_Iron_Dry"
			},
			["out"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ,					-- Sequence or act
				["value"] = "Iron_To_Idle",							-- Number for act, String/Number for sequence
				["value_empty"] = "Iron_To_Idle_Dry",
				["transition"] = true
			},
			["shoot"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ,					-- Sequence or act
				["value"] = "Fire_Iron",							-- Number for act, String/Number for sequence
				["value_last"] = "Fire_Iron_Last",
				["value_empty"] = "Fire_Iron_Dry"
			}
		}

		SWEP.SprintAnimation = {
			["in"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ,					-- Sequence or act
				["value"] = "Idle_to_Sprint",						-- Number for act, String/Number for sequence
				["value_empty"] = "Idle_to_Sprint_Empty",
				["transition"] = true
			},
			["loop"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ,					-- Sequence or act
				["value"] = "Sprint_",								-- Number for act, String/Number for sequence
				["value_empty"] = "Sprint_Empty_",
				["is_idle"] = true
			},
			["out"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ,					-- Sequence or act
				["value"] = "Sprint_to_Idle",						-- Number for act, String/Number for sequence
				["value_empty"] = "Sprint_to_Idle_Empty",
				["transition"] = true
			}
		}

	-- [ Procedural ]
		SWEP.DoProceduralReload 		= false
		SWEP.ProceduralReloadTime 		= 1

		SWEP.ProceduralHoslterEnabled 	= nil
		SWEP.ProceduralHolsterTime 		= 0.3
		SWEP.ProceduralHolsterPos 		= Vector(3, 0, -5)
		SWEP.ProceduralHolsterAng	 	= Vector(-40, -30, 10)

-- [[ EFFECTS ]]
	-- [ Attachments ]
		SWEP.MuzzleAttachment			= "1"						-- "1" CSS models / "muzzle" hl2 models
		SWEP.ShellAttachment			= "2"						-- "2" CSS models / "shell" hl2 models
		SWEP.MuzzleFlashEnabled 		= true
		SWEP.MuzzleAttachmentRaw 		= nil							-- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
		SWEP.AutoDetectMuzzleAttachment 	= false						-- For multi-barrel weapons, detect the proper attachment?
		SWEP.MuzzleFlashEffect 		= ""
		SWEP.SmokeParticle 			= ""							-- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
		SWEP.EjectionSmokeEnabled 		= true

	-- [ Shells ]
		SWEP.LuaShellEject 			= nil
		SWEP.LuaShellEjectDelay 		= 1000000000
		SWEP.LuaShellModel 			= nil
		SWEP.LuaShellScale 			= nil
		SWEP.LuaShellYaw 			= nil

	-- [ Tracers_and_Impacts ]
		SWEP.TracerName 				= ""
		SWEP.TracerCount 			= 1
		SWEP.ImpactEffect 			= ""
		SWEP.ImpactDecal 			= nil

-- [[ FUNCTIONS ]]
	-- [ Class ]
		DEFINE_BASECLASS( SWEP.Base )
		include("isaac/isaac_items.lua")
		include("isaac/isaac_system.lua")

		if SERVER then
			util.AddNetworkString("IsaacTears_Toggle_Server")
			util.AddNetworkString("IsaacTears_Toggle_Client")
			util.AddNetworkString("IsaacTears_Pickup_Server")
			util.AddNetworkString("IsaacTears_Pickup_Client")
		end

	-- [ Isaac Menu ]
		SWEP.Isaac.Menu = {}
		SWEP.Isaac.Items = {}
		SWEP.Isaac.Menu.Open = false
		SWEP.Isaac.Menu.Ready = true

		function SWEP:AltAttack()
		end

	-- [ Player Effects ]
		function SWEP:Think()
			if self.Owner and self.Owner:GetMoveType() ~= MOVETYPE_NOCLIP then
				self.Owner:SetMoveType(MOVETYPE_WALK)
				if self.Owner:GetMoveType() == MOVETYPE_WALK and (self.Isaac.Player.Fly or 0 ) > 0 then
					self.Owner:SetMoveType(MOVETYPE_FLY)
				end
			end
			BaseClass.Think(self)
		end

		function SWEP:Holster()
			self.Owner:SetMoveType(MOVETYPE_WALK)
			return true
		end

	-- [ Fix Velocity ]
		function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
			if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
			num_bullets = num_bullets or 1
			aimcone = aimcone or 0
			if SERVER then
				for _ = 1, num_bullets do
					local ent = ents.Create(self:GetStat("Isaac.Tear.EntFull"))
					local dir
					local ang = self:GetOwner():EyeAngles()
					ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
					ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))
					dir = ang:Forward()
					ent:SetPos(self:GetOwner():GetShootPos())
					ent:SetOwner(self:GetOwner())
					ent:SetAngles(self:GetOwner():EyeAngles())
					ent:Spawn()
					ent:SetOwner(self:GetOwner())
				end
			end
		end
