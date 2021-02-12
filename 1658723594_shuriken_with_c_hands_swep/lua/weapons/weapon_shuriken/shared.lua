if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "melee"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Shurikens"			
	SWEP.Author			= "Jaanus"
	SWEP.Slot			= 2
	SWEP.SlotPos			= 7
	SWEP.ViewModelFOV		= 90
	SWEP.IconLetter			= "x"
	killicon.Add( "shuricon", "effects/killicons/ent_shuriken", Color( 180, 0, 0, 255 ) );
	killicon.AddAlias( "weapon_shuriken", "shuricon" );
	killicon.AddAlias( "ent_shuriken", "shuricon" );


end

SWEP.Author   	    = "Jaanus"
SWEP.Contact        = "Jaanus@jaanus.cc"
SWEP.Purpose        = "Kill stuff - Ninja style."
SWEP.Instructions   = "Left click throws a shuriken."
SWEP.Spawnable      = true
SWEP.AdminSpawnable  = true
SWEP.Category 		= "Other"
SWEP.UseHands = true

SWEP.ViewModel      = "models/jaanus/c_shuriken.mdl"
SWEP.WorldModel   = "models/jaanus/w_shuriken.mdl"
-----------------------------------------------

SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0.5		--Gun Kick
SWEP.Primary.Damage			= 20	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type

SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 20
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
 
-- function SWEP:Reload() --To do when reloading
-- end 
 
 if ( CLIENT ) then
	function SWEP:GetViewModelPosition( pos, ang )
		pos = pos + ang:Forward()*4
		return pos, ang
	end 
end
 
function SWEP:Think() -- Called every frame
end

function SWEP:Initialize()
--util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
util.PrecacheSound("weapons/shuriken/throw1.wav")
util.PrecacheSound("weapons/shuriken/throw2.wav")
util.PrecacheSound("weapons/shuriken/throw3.wav")
util.PrecacheSound("weapons/shuriken/throw4.wav")
end

function SWEP:PrimaryAttack()
	self.Weapon:EmitSound("weapons/shuriken/throw"..tostring( math.random( 1, 4 ) )..".wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	if SERVER then
		local shuriken = ents.Create("ent_shuriken")
		shuriken:SetAngles(self.Owner:EyeAngles())-- Angle(0,90,0))
		shuriken:SetPos(self.Owner:GetShootPos())
		shuriken:SetOwner(self.Owner)
		shuriken:SetPhysicsAttacker(self.Owner)
		shuriken:Spawn()
		shuriken:Activate()
		local phys = shuriken:GetPhysicsObject()
		phys:SetVelocity(self.Owner:GetAimVector()*9000)
		phys:AddAngleVelocity(Vector(math.random(-400, 400), 0, math.random(-2000, 2000)))
	end
end

function SWEP:SecondaryAttack()
end