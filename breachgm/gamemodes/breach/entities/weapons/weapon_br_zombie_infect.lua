AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_zombie")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade/chan_man1"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Infect People"
SWEP.Instructions	= "Click left to infect, Right click to hurt people."
SWEP.Base			= "weapon_breach_basemelee"

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "knife"
SWEP.ViewModel		= "models/weapons/v_zombiearms.mdl"
SWEP.WorldModel		= ""
SWEP.PrintName		= "SCP-008-2"
SWEP.DrawCrosshair	= false
SWEP.Slot			= 0

SWEP.Spawnable			= false
SWEP.AdminOnly			= false

SWEP.droppable				= false
SWEP.Primary.Automatic		= false
SWEP.Primary.NextAttack		= 0.25
SWEP.Primary.AttackDelay	= 0.4
SWEP.Primary.Damage			= 15
SWEP.Primary.Force			= 3250
SWEP.Primary.AnimSpeed		= 2.8

SWEP.Secondary.Automatic	= true
SWEP.Secondary.NextAttack	= 0.7
SWEP.Secondary.AttackDelay	= 1.6
SWEP.Secondary.Damage		= 15
SWEP.Secondary.Force		= 6000
SWEP.Secondary.AnimSpeed	= 2.4

SWEP.Range					= 100

SWEP.UseHands				= false
SWEP.DrawCustomCrosshair	= true
SWEP.DeploySpeed			= 1
SWEP.AttackTeams			= {2,3,5,6} // Attack only humans
SWEP.AttackNPCs				= false

SWEP.ZombieWeapon			= true

SWEP.SoundMiss 			= "npc/zombie/claw_miss1.wav"
SWEP.SoundWallHit		= "npc/zombie/claw_strike1.wav"
SWEP.SoundFleshSmall	= "npc/zombie/claw_strike2.wav"
SWEP.SoundFleshLarge	= "npc/zombie/claw_strike3.wav"

function SWEP:SecondaryAttack()
	self:SetHoldType("knife")
	//if ( !self:CanSecondaryAttack() ) then return end
	//if not IsFirstTimePredicted() then return end
	if self:GetNextSecondaryFire() > CurTime() then return end
	self.Owner:GetViewModel():SetPlaybackRate( self.Secondary.AnimSpeed )
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_RANGE_ZOMBIE)
	timer.Create("AttackDelay2" .. self.Owner:SteamID(), self.Secondary.NextAttack, 1, function()
		if IsValid(self) == false then return end
		self.AttackType = 2
		self:Stab(2, self.Range)
	end)
	self:SetNextPrimaryFire( CurTime() + self.Secondary.AttackDelay)
	self:SetNextSecondaryFire( CurTime() + self.Secondary.AttackDelay)
end

SWEP.NextAttackW			= 0
SWEP.AttackDelay			= 1
function SWEP:PrimaryAttack()
	timer.Destroy("AttackDelay" .. self.Owner:SteamID())
	self.Owner:GetViewModel():SetPlaybackRate( self.Primary.AnimSpeed )
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:GetViewModel():SetPlaybackRate( self.Primary.AnimSpeed )
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	timer.Create("AttackDelay" .. self.Owner:SteamID(), self.Primary.NextAttack, 1, function()
		if IsValid(self) == false then return end
		self.AttackType = 1
		self:Stab(1, self.Range)
	end)
	self:SetNextPrimaryFire( CurTime() + self.Primary.AttackDelay)
	self:SetNextSecondaryFire( CurTime() + self.Primary.AttackDelay)
	if SERVER then
		local ent = nil
		local tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 ),
			filter = self.Owner,
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			mask = MASK_SHOT_HULL
		} )
		ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if ent:GetNClass() == ROLE_SCP990 then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				if ent:GetNClass() == ROLE_CLASSD9341 then ent:Kill() end
				if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
				if ent:Team() == TEAM_GUARD then return end
					ent:SetSCP0082()
					ent:SetPos(self.Owner:GetPos())
					ent:AddFrags(1)
					ent:SetTeam(TEAM_GUARD)
					else
					ent:SetSCP0082()
					ent:SetPos(self.Owner:GetPos())
					ent:AddFrags(1)
				end
			end
		end
	end
end


