SWEP.PrintName			= "Tomato Swep"
SWEP.Author			= "( Bigby Wolf )"
SWEP.Instructions		= "Left mouse to fire a Tomato"

SWEP.Category				= "Bigby's Sweps"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.UseHands = true
SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel 	 	= "models/weapons/w_bugbait.mdl"
local ShootSound = Sound( "physics/body/body_medium_impact_soft7.wav" )

function SWEP:PrimaryAttack()
self.Weapon:SetNextPrimaryFire( CurTime() + 2 )
self:ThrowChair( "models/foodnhouseholditems/tomato.mdl" )
end

function SWEP:ThrowChair( model_file )
self:EmitSound( ShootSound )
if ( CLIENT ) then return 
end
local ent = ents.Create( "prop_physics" )
if ( !IsValid( ent ) ) then return end
ent:SetModel( model_file )
ent:SetCollisionGroup(1)
ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
		local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 5000
	velocity = velocity + ( VectorRand() * 10 )
	phys:ApplyForceCenter( velocity )
	cleanup.Add( self.Owner, "props", ent )
	timer.Simple( 7, function() ents.FindByClass( "prop_physics" )[1]:Remove() end )

end

	
