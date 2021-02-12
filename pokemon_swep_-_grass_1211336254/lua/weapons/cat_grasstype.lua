AddCSLuaFile("cat_grasstype.lua")
if SERVER then resource.AddWorkshop("1211336254") end
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "SCP-2953-L"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Melee Attack
---------------------------------------------------------------------------]] 
config.MeleeAttackDelay 		= 1   -- Time in between punches.
config.MeleePunchRange 			= 135  -- Distance between you and the target.
config.MeleeDamageLow 			= 15
config.MeleeDamageHigh 			= 25
config.MeleePunchForce 			= 20 -- How much force to apply to targets?
config.MeleeToggleDelay 		= 2   -- How long until you can toggle again?

config.MeleeSwingSound = Sound( "WeaponFrag.Throw" )
config.MeleePunchSound = Sound( "Flesh.ImpactHard" )
config.MeleeEffect = "fx_poke_melee"
--[[-------------------------------------------------------------------------
Floor Attack
---------------------------------------------------------------------------]]
config.FloorAttackDelay 		= 3   -- How long until you can use it again?
config.FloorAttackSpikes 		= 5   -- How many spikes will shoot out?
config.FloorAttackInterval 		= 0.2 -- Interval of time in between spikes.
config.FloorAttackRadius 		= 55
config.FloorAttackDistance 		= 75  -- Distance in between spikes.
config.FloorAttackDamageLow 	= 12
config.FloorAttackDamageHigh 	= 16
config.FloorAttackForce 		= 150 -- Upward force when hit.

config.FloorAttackSound = "npc/barnacle/neck_snap2.wav"
config.FloorAttackEffect = "fx_poke_grass"
--[[-------------------------------------------------------------------------
AoE Heal
---------------------------------------------------------------------------]]
config.AoEHealDelay 	= 5   -- How long until you can use it again?
config.AoEHealSteps 	= 7   -- How many times does it send a heal wave?
config.AoEHealRadius 	= 256 -- The effective area (radius around you).
config.AoEHealInterval 	= 0.3 -- Time in between heals.
config.AoEHealAmount 	= 4   -- Amount of health gained each interval.

config.AoEHealSound = "weapons/physcannon/physcannon_charge.wav"
config.AoEHealEffect = "fx_poke_heal"
--[[-------------------------------------------------------------------------
Shield
---------------------------------------------------------------------------]]
config.ShieldDelay 		= 1    -- How long until you can use it again?
config.ShieldDistance 	= 55   -- How far away in front of you the shield is.
config.ShieldDuration 	= 5    -- How long does the shield last?
config.ShieldHealth 	= 300  -- How much health does the shield have?
config.ShieldToggle 	= true -- Does the shield toggle or destroy on delay?
config.ShieldModel 		= "models/props_debris/metal_panel02a.mdl"
config.ShieldMaterial   = "models/props_combine/portalball001_sheet"

config.Shield2DToggle 	= true -- Whether or not to use a 2D sprite instead of the model.
config.Shield2DMaterial = "poke/overlay/lightscreen1.png"
config.Shield2DScale 	= 32
config.Shield2DColor = Color(255,255,255,155)

config.ShieldSound = "weapons/physcannon/energy_bounce2.wav"
--[[-------------------------------------------------------------------------
AoE Damage
---------------------------------------------------------------------------]]
config.AoEDamageDelay 		= 5    -- How long until you can use it again?
config.AoEDamageSteps 		= 15   -- How many times will the AoE deal damage?
config.AoEDamageRadius 		= 135  -- The effective area (radius around you).
config.AoEDamageInterval 	= 0.3  -- Time in between damage.
config.AoEDamageLow 		= 10 
config.AoEDamageHigh 		= 15 

config.AoEDamageSound = "vehicles/airboat/pontoon_impact_hard1.wav"
config.AoEDamageEffect = "fx_poke_leaf"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = true
config.MeleeAttackMessage 	= "Mach Punch!"
config.ToggleMeleeMessage 	= "Switch!"
config.FloorAttackMessage 	= "Frenzy Plant!"
config.AoEHealMessage 		= "Heal Pulse!"
config.ShieldMessage 		= "Light Screen!"
config.AoEDamageMessage 	= "Leaf Storm!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.HoldType = "fist"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
SWEP.ShowWorldModel = false
SWEP.ShowViewModel = false
SWEP.UseHands = false
SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "none"
SWEP.Secondary.ClipSize       = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic      = false
SWEP.Secondary.Ammo           = "none"

SWEP.UsingMelee = false
SWEP.NextMeleeToggle = 0
SWEP.NextMeleeAttack = 0
SWEP.NextFloorAttack = 0
SWEP.NextAoEHeal = 0
SWEP.NextShield = 0
SWEP.NextAoEDamage = 0
SWEP.MeleeAttacked = 0
SWEP.NextAction = 0

-- POKE VARIABLES
SWEP.PokeSWEP = true
SWEP.POKE_MoveType = "grass"



function SWEP:FloorAttack()
	-- Frenzy Plant: Send nature spikes shooting out of the gruond in front of you.
	local owner = self:GetOwner()
	if self.NextAction > CurTime() then return end
	if self.NextFloorAttack < CurTime() then
		if config.PrintMessages == true then print(config.FloorAttackMessage) end
		local pos = owner:GetPos()
		local ang = Angle(0,owner:GetAngles().y,0):Forward()
		timer.Create("POKENATUREFLOORATTACK"..owner:SteamID(),config.FloorAttackInterval,config.FloorAttackSpikes,function()
			if IsValid(owner) then
				pos = pos + (ang*config.FloorAttackDistance)
				local tr = util.TraceLine({
					start = pos+Vector(0,0,16),
					endpos = pos+(Vector(0,0,-1)*150000)
				})
				if tr.Hit then pos = tr.HitPos end
				for k, v in pairs(ents.FindInSphere(pos,config.FloorAttackRadius)) do
					if v != owner then
						v:SetVelocity(v:GetVelocity()+(Vector(0,0,1)*config.FloorAttackForce))
						local phys = v:GetPhysicsObject()
						if IsValid(phys) then phys:AddVelocity(v:GetVelocity()+(Vector(0,0,1)*config.FloorAttackForce)) end
						local dmg = DamageInfo()
						dmg:SetAttacker(owner)
						dmg:SetInflictor(self)
						dmg:SetDamage(math.random(config.FloorAttackDamageLow,config.FloorAttackDamageHigh))
						v:TakeDamageInfo(dmg)
					end
				end
				sound.Play(config.FloorAttackSound,pos)
				local fx = EffectData()
				fx:SetOrigin(pos)
				fx:SetScale(config.FloorAttackRadius)
				util.Effect(config.FloorAttackEffect,fx)
			end
		end)
		self.NextFloorAttack = CurTime() + config.FloorAttackDelay
		self.NextAction = CurTime() + config.ActionDelay
	end
end

function SWEP:DoRemove()
	local owner = self:GetOwner()
	if self.Shield != nil then
		self.Shield:Remove()
		self.Shield = nil
	end
	if IsValid(owner) then
		timer.Remove("POKENATUREFLOORATTACK"..owner:SteamID())
		timer.Remove("POKENATUREAOEHEAL"..owner:SteamID())
		timer.Remove("POKENATURESHIELD"..owner:SteamID())
		timer.Remove("POKENATUREAOEDMG"..owner:SteamID())
	end
end

--[[-------------------------------------------------------------------------
Default SWEP functions
---------------------------------------------------------------------------]]
function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.ShowViewModel = false
	self.UseHands = false
end

function SWEP:Think()
	local owner = self:GetOwner()
	local offset = Vector(0,0,64)
	if IsValid(self.Shield) then
		if IsEntity(self.Shield) then
			self.Shield:SetPos(owner:GetPos()+owner:GetForward()*config.ShieldDistance+offset)
			self.Shield:SetAngles(owner:GetAngles())
		end
	end
	if owner:KeyDown(IN_USE) && owner:KeyDown(IN_RELOAD) then
		if self.NextMeleeToggle < CurTime() then
			self:ToggleMelee()
			self.NextMeleeToggle = CurTime() + config.MeleeToggleDelay
		end
	end
	if SERVER then
		if owner:KeyReleased(IN_USE) && !owner:KeyDown(IN_RELOAD) then
			if self.NextMeleeToggle < CurTime() then self:AoEDamage() end
		elseif !owner:KeyDown(IN_USE) && owner:KeyReleased(IN_RELOAD) then
			if self.NextMeleeToggle < CurTime() then self:AoEHeal() end
		end
	end
	if self.UsingMelee then
		local vm = self.Owner:GetViewModel()
		local curtime = CurTime()
		local idletime = self:GetNextIdle()
		if (idletime > 0 && CurTime() > idletime) then
			vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_idle_0"..math.random(1,2)))
			self:UpdateNextIdle()
		end
		if (self.MeleeAttacked > 0) then
			self:DealDamage()
			self.MeleeAttacked = 0
		end
		if (SERVER && CurTime() > self:GetNextPrimaryFire() + 0.1) then
			self:SetCombo(0)
		end
	end
end

function SWEP:PrimaryAttack()
	if self.UsingMelee then self:MeleeAttack()
	else if SERVER then self:FloorAttack() end end
end

function SWEP:SecondaryAttack()
	if self.UsingMelee then self:MeleeAttack()
	else if SERVER then self:ActivateShield() end end
end

function SWEP:Reload()
end

function SWEP:OnRemove()
	self:DoRemove()
end
function SWEP:Holster() 
	self:DoRemove()
	return true 
end
function SWEP:Deploy() return true end

--[[-------------------------------------------------------------------------
Fist SWEP stuff
---------------------------------------------------------------------------]]
function SWEP:SetupDataTables()
	self:NetworkVar("Float",0,"NextMeleeAttack")
	self:NetworkVar("Float",1,"NextIdle")
	self:NetworkVar("Int",2,"Combo")
end

function SWEP:UpdateNextIdle()
	local vm = self.Owner:GetViewModel()
	self:SetNextIdle(CurTime()+vm:SequenceDuration()/vm:GetPlaybackRate())
end

function SWEP:DealDamage()
	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())
	self.Owner:LagCompensation(true)
	local tr = util.TraceLine({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos()+self.Owner:GetAimVector()*config.MeleePunchRange,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	})
	if (!IsValid(tr.Entity)) then
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos()+self.Owner:GetAimVector()*config.MeleePunchRange,
			filter = self.Owner,
			mins = Vector(-10,-10,-8),
			maxs = Vector(10,10,8),
			mask = MASK_SHOT_HULL
		} )
	end
	-- We need the second part for single player because SWEP:Think is ran shared in SP
	if (tr.Hit && !(game.SinglePlayer()&& CLIENT)) then
		self:EmitSound(config.MeleePunchSound)
	end
	if tr.Hit then
		local fx = EffectData()
		fx:SetOrigin(tr.HitPos)
		util.Effect(config.MeleeEffect,fx)
		if SERVER then
			sound.Play(config.MeleePunchSound,tr.HitPos)
		end
	end
	local hit = false
	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( math.random( config.MeleeDamageLow, config.MeleeDamageHigh ) )
		if ( anim == "fists_left" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 + self.Owner:GetForward() * 9998 ) -- Yes we need those specific numbers
		elseif ( anim == "fists_right" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * -4912 + self.Owner:GetForward() * 9989 )
		elseif ( anim == "fists_uppercut" ) then
			dmginfo:SetDamageForce( self.Owner:GetUp() * 5158 + self.Owner:GetForward() * 10012 )
		end
		local diff = (tr.Entity:GetPos()-attacker:GetPos())/2
		tr.Entity:SetPos(tr.Entity:GetPos()+Vector(0,0,1))
		tr.Entity:SetVelocity((diff*config.MeleePunchForce)+Vector(0,0,50))
		tr.Entity:TakeDamageInfo( dmginfo )
		hit = true
	end
	if ( SERVER && IsValid( tr.Entity ) && !tr.Entity:IsPlayer() ) then
		local dmginfo = DamageInfo()
		dmginfo:SetAttacker( self:GetOwner() )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( math.random( config.MeleeDamageLow, config.MeleeDamageHigh ) )
		tr.Entity:TakeDamageInfo( dmginfo )
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * config.MeleePunchForce * phys:GetMass() + Vector(0,0,100), tr.HitPos )
		end
		if tr.Entity:GetClass() == "func_breakable" or tr.Entity:GetClass() == "func_breakable_surf" then
			tr.Entity:Fire("Break","",0)
		end
	end
	if ( SERVER ) then
		if ( hit && anim != "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end
	self.Owner:LagCompensation( false )
end