AddCSLuaFile("cat_water.lua")
--[[------------------------------
Configuration
--------------------------------]]
local config = {}
config.SWEPName = "SCP-2185-D"
config.ActionDelay = 1 -- Time in between each action.
--[[-------------------------------------------------------------------------
Bubble
---------------------------------------------------------------------------]]
config.BubbleDelay 		= 3   -- How long until you can use it again?
config.BubbleLife 		= 5   -- How long in seconds do the bubbles last?
config.BubbleInterval 	= 0.1 -- Time in between bubbles.
config.BubbleSpeed		= 512 -- How fast do the bubbles move?
config.BubbleSpread 	= 10
config.BubbleSpews 		= 15  -- How many bubbles will shoot out?
config.BubbleDrunken 	= true -- Does the bubble constantly add random velocity?
config.BubbleDamageLow 	= 3
config.BubbleDamageHigh = 6
config.BubbleRadius 	= 55  -- Bubble size and pop size.
config.BubbleForce 		= 55 -- Bubble pop force.

config.BubbleShootSound = "ambient/water/water_spray1.wav"
config.BubblePopSound = "ambient/water/water_splash3.wav"
config.BubbleEffect = "fx_poke_bubblepop"
--[[-------------------------------------------------------------------------
Hydro Pump
---------------------------------------------------------------------------]]
config.HydroPumpDelay 		= 5   -- How long until you can use it again?
config.HydroPumpTimer 		= 5   -- How long is it active? ( 0 = toggle, deactivates when key is released )
config.HydroPumpInterval 	= 0.1 -- Time in between damages.
config.HydroPumpForce 		= 115 -- Force of the beam ending.
config.HydroPumpMaxRange 	= 1155 -- How far the beam can go.
config.HydroPumpDamageLow 	= 2
config.HydroPumpDamageHigh 	= 4

config.HydroPumpSound = "Physics.WaterSplash"

config.HydroPumpScale 			= 25 -- Size of beam and water effects.
config.HydroPumpBeamEffect 		= "fx_poke_hydropump"
config.HydroPumpImpactEffect 	= "fx_poke_bubblepop"
--[[-------------------------------------------------------------------------
Aqua Jet
---------------------------------------------------------------------------]]
config.AquaJetDelay 	= 3    -- How long until you can use it again?
config.AquaJetDuration 	= 0    -- How long does it last?
config.AquaJetToggle 	= true -- Does the AquaJet toggle or destroy on delay?
config.AquaJetSpeed 	= 4    -- Multiplier of how much speed is gained.
config.AquaJetRange 	= 85   -- How far away to check for collision.
config.AquaJetRadius 	= 85   -- Splash radius.
config.AquaJetDamageMin = 20 
config.AquaJetDamageHigh= 25

config.AquaJetSound = "Physics.WaterSplash"
config.AquaJetPopEffect = "fx_poke_bubblepop"
config.AquaJetMaterial = "models/shadertest/shader3"
--[[-------------------------------------------------------------------------
Messages ( debug )
---------------------------------------------------------------------------]]
config.PrintMessages = false
config.BubbleMessage 		= "Bubble!"
config.HydroPumpMessage 	= "Hydro Pump!"
config.AquaJetMessage 		= "Aqua Jet!"
--[[----------------------
SWEP
------------------------]]
SWEP.PrintName = config.SWEPName
SWEP.Author = "Project Stadium"
SWEP.Purpose = "discord.me/projectstadium"
SWEP.Category = "Project Stadium"
SWEP.HoldType = "fist"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
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

SWEP.NextBubble = 0
SWEP.NextHydroPump = 0
SWEP.NextAquaJet = 0
SWEP.NextAction = 0

-- POKE VARIABLES
SWEP.PokeSWEP = true
SWEP.POKE_MoveType = "grass"

function SWEP:Bubble()
	-- Bubble: Spray bubbles in a cone that pop on contact.
	local owner = self:GetOwner()
	if self.AquaJetEnabled == true then return end
	if self.NextAction > CurTime() then return end
	if self.NextBubble < CurTime() then
		if config.PrintMessages == true then print(config.BubbleMessage) end

		timer.Create("POKEWATERBUBBLE"..owner:SteamID(),config.BubbleInterval,config.BubbleSpews,function()
			if IsValid(owner) then
				if owner:Alive() then
					local bubble = ents.Create("ent_poke_bubble")
					bubble:SetPos(self:GetOwner():GetPos()+Vector(0,0,32))
					bubble:SetOwner(self:GetOwner())
					bubble:Spawn()
					bubble.PopSound = config.BubblePopSound
					bubble.Effect = config.BubbleEffect

					bubble:SetStats(config.BubbleDamageLow,config.BubbleDamageHigh,config.BubbleForce,config.BubbleRadius,config.BubbleDrunken)
					bubble:DeathTimer(2)

					sound.Play(config.BubbleShootSound,self:GetPos())

					local phys = bubble:GetPhysicsObject()
					if IsValid(phys) then
						phys:SetVelocity(self:GetOwner():GetAimVector()*config.BubbleSpeed)
						phys:AddVelocity((VectorRand()*(config.BubbleSpread/2))*config.BubbleSpread)
					end
				else
					timer.Remove("POKEWATERBUBBLE"..owner:SteamID())
				end
			end
		end)

		self.NextBubble = CurTime() + config.BubbleDelay
		self.NextAction = CurTime() + config.BubbleDelay
	end
end

function SWEP:HydroPumpActivate()
	-- Hydro Pump: High impact water beam.
	local owner = self:GetOwner()
	if self.AquaJetEnabled == true then return end
	if self.NextAction > CurTime() then return end
	if owner:GetNWBool("poke_hydropumping") == true then return end
	if self.NextHydroPump < CurTime() then
		if config.PrintMessages == true then print(config.HydroPumpMessage) end
		owner:SetNWBool("poke_hydropumping",true)
		if IsValid(owner.POKE_HYDROPUMP) then
			owner.POKE_HYDROPUMP:Remove()
			owner.POKE_HYDROPUMP = nil
		end

		local pump = ents.Create("ent_poke_hydropump")
		pump:SetOwner(owner)
		pump:SetPos(owner:GetPos())
		pump:Spawn()
		pump.PumpFX = config.HydroPumpImpactEffect
		pump.PumpBeam = config.HydroPumpBeamEffect
		pump.PumpSound = config.HydroPumpSound
		pump:SetStats(config.HydroPumpDamageLow,config.HydroPumpDamageHigh,config.HydroPumpScale,config.HydroPumpMaxRange,config.HydroPumpForce)
				
		owner.POKE_HYDROPUMP = pump

		self.NextHydroPump = CurTime() + config.HydroPumpDelay
		self.NextAction = CurTime() + config.HydroPumpDelay
		if config.HydroPumpTimer > 0 then
			timer.Create("POKEWATERHYDRO"..owner:SteamID(),config.HydroPumpTimer,1,function()
				if IsValid(owner) then
					owner:SetNWBool("poke_hydropumping",false)
					if IsValid(owner.POKE_HYDROPUMP) then
						owner.POKE_HYDROPUMP:Remove()
						owner.POKE_HYDROPUMP = nil
					end
				end
			end)
			self.NextHydroPump = CurTime() + config.HydroPumpTimer + config.HydroPumpDelay
		end
	end
end
function SWEP:HydroPumpRemove()
	local owner = self:GetOwner()
	if owner:GetNWBool("poke_hydropumping") == false then return end
	owner:SetNWBool("poke_hydropumping",false)
	timer.Remove("POKEWATERHYDRO"..owner:SteamID())
	if IsValid(owner.POKE_HYDROPUMP) then
		owner.POKE_HYDROPUMP:Remove()
		owner.POKE_HYDROPUMP = nil
	end
end

function SWEP:ActivateAquaJet()
	-- Aqua Jet: Water forms around you, making you run faster and deal damage when colliding with an enemy.
	local owner = self:GetOwner()
	if self.NextAction > CurTime() then return end
	if self.NextAquaJet < CurTime() then
		if self.AquaJetEnabled == true then
			self:DeactivateAquaJet()
			return
		end
		if config.PrintMessages == true then print(config.AquaJetMessage) end
		sound.Play(config.AquaJetSound,self:GetPos())

		if IsValid(owner.poke_aquajet) then
			owner.poke_aquajet:Remove()
			owner.poke_aquajet = nil
		end
		local aquajet = ents.Create("ent_poke_aquajet")
		aquajet:SetOwner(owner)
		aquajet:SetPos(owner:GetPos())
		aquajet.PopScale 	= config.AquaJetRadius
		aquajet.PopEffect 	= config.AquaJetPopEffect
		aquajet:Spawn()

		owner.poke_aquajet = aquajet

		owner:SetWalkSpeed(100*config.AquaJetSpeed)
		owner:SetRunSpeed(200*config.AquaJetSpeed)

		self.AquaJetEnabled = true
		owner:SetMaterial(config.AquaJetMaterial)

		self.NextAquaJet = CurTime() + config.AquaJetDelay
		self.NextAction = CurTime() + config.AquaJetDelay
		if config.AquaJetDuration > 0 then
			timer.Create("POKEWATERAQUAJET"..owner:SteamID(),config.AquaJetDuration,1,function()
				if IsValid(owner) then
					self:DeactivateAquaJet()
				end
			end)
			self.NextAquaJet = CurTime() + config.AquaJetDuration + 1
		end
	end
end
function SWEP:DeactivateAquaJet()
	local owner = self:GetOwner()
	if IsValid(owner) then
		owner:SetWalkSpeed(owner.POKEWATER_DefaultWalkSpeed)
		owner:SetRunSpeed(owner.POKEWATER_DefaultRunSpeed)

		if IsValid(owner.poke_aquajet) then
			owner.poke_aquajet:Remove()
			owner.poke_aquajet = nil
		end

		self.AquaJetEnabled = false
		owner:SetMaterial()
	end
end
function SWEP:AquaJetExplode(pos)
	local owner = self:GetOwner()
	if self.AquaJetEnabled == false then return end
	sound.Play(config.AquaJetSound,pos)
	for _, entities in ipairs(ents.FindInSphere(pos,config.AquaJetRadius)) do
		if entities != owner then
			local dmg = DamageInfo()
			dmg:SetInflictor(self.Weapon)
			dmg:SetAttacker(owner)
			dmg:SetDamage(config.AquaJetDamageMin,config.AquaJetDamageHigh)
			entities:TakeDamageInfo(dmg)
		end
	end
	self:DeactivateAquaJet()
end

hook.Add("PlayerInitialSpawn","POKEWATERPLAYERINIT",function(ply)
	timer.Simple(1,function()
		if IsValid(ply) then
			ply.POKEWATER_DefaultWalkSpeed = ply:GetWalkSpeed()
			ply.POKEWATER_DefaultRunSpeed = ply:GetRunSpeed()
		end
	end)
end)
hook.Add("PlayerDeath","POKEWATERPLAYERDEATH",function(ply)
	timer.Remove("POKEWATERBUBBLE"..ply:SteamID())
	timer.Remove("POKEWATERAQUAJET"..ply:SteamID())
	timer.Remove("POKEWATERHYDRO"..ply:SteamID())
end)
function SWEP:DoRemove()
	local owner = self:GetOwner()
	if IsValid(owner) then
		owner:SetMaterial()
		self.AquaJetEnabled = false
		if IsValid(owner.poke_aquajet) then
			owner.poke_aquajet:Remove()
			owner.poke_aquajet = nil
		end
		self:HydroPumpRemove()
		timer.Remove("POKEWATERBUBBLE"..owner:SteamID())
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
	if SERVER then
		if owner:KeyReleased(IN_USE) && !owner:KeyDown(IN_RELOAD) then
			self:Substitute()
		elseif !owner:KeyDown(IN_USE) && owner:KeyDown(IN_RELOAD) then
			self:HydroPumpActivate()
		end
		if owner:KeyReleased(IN_RELOAD) then
			if config.HydroPumpTimer <= 0 then
				self:HydroPumpRemove()
			end
		end
	end
	if IsValid(owner) then
		if self.AquaJetEnabled == true then
			if owner:GetVelocity():Length() > 500 then
				local tr = util.TraceHull({
					start = owner:GetPos()+Vector(0,0,32),
					endpos = owner:GetPos()+Vector(0,0,32)+owner:GetForward()*config.AquaJetRange,
					mins = Vector( -16, -16, 16 ),
					maxs = Vector( 16, 16, 16 ),
					filter = owner
				})

				if tr.Hit then
					self:AquaJetExplode(tr.HitPos)
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if SERVER then self:Bubble() end
end

function SWEP:SecondaryAttack()
	if SERVER then self:ActivateAquaJet() end
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
function SWEP:Deploy() 
	self.NextSubstitute = CurTime() + config.SubstituteDelay
	return true 
end