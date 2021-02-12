
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

	
end

if ( CLIENT ) then
	
	AddCSLuaFile( "shared.lua" )
	SWEP.PrintName			= "SCP-212-5"
	SWEP.Author			= "Haxray"
	SWEP.Slot			= 2
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "f"
	SWEP.DrawCrosshair		= true
	
        killicon.AddFont( "weapon_deagle", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )


end

-----------------------Main functions----------------------------
 
-- function SWEP:Reload() --To do when reloading
-- end 
 
function SWEP:Think() -- Called every frame
	if self.isflying == true then
        if self.Owner:GetVelocity()[3] <= 0 and !self.islanding then
			self.islanding = true
        end

        if self.Owner:GetVelocity()[3] >= 0 and self.islanding then
			hitposent = ents.Create("info_target")
			hitpos = self.Owner:GetPos() - Vector(0,0,10)
			tokill = {}
			tokill.Num    = 20
			tokill.Src    = self.Owner:GetPos()
			tokill.Dir    = self.Owner:GetPos() - Vector(0,0,10)
			tokill.Spread = Vector(75, 75, 0)
			tokill.Tracer = 0
			tokill.Force  = 10
			tokill.Damage = 100
			self.Owner:FireBullets(tokill)
			self.isflying = false
        end

	end

end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType );
end

function SWEP:SecondaryAttack()
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 5
	bullet.Damage = 60
    self.Owner:FireBullets(bullet)
    self.Owner:SetAnimation( PLAYER_ATTACK1 );
    local hitposent = ents.Create("info_target")
    local trace = self.Owner:GetEyeTrace()
    local hitpos = trace.HitPos
else
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end

end
 
function SWEP:PrimaryAttack()
if !self.isflying then
	if self.Owner:KeyDown(IN_DUCK) then
        self.isflying = true
        self.islanding = false
		self.Owner:SetVelocity((self.Owner:GetUp() * 300) + (self.Owner:GetForward() * 1000));
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	end
end
if self.isflying then
		local tr = util.QuickTrace(self.Owner:GetShootPos(), (self.Owner:GetForward() * -60), self.Owner);
			if (tr.Hit) then
				self.Owner:ViewPunch(Angle(5, 0, 0));
				self.Owner:SetVelocity((self.Owner:GetForward() * 1000) + (self.Owner:GetUp() * 300));
				self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
			end
end
end

function SWEP:Deploy()
	self.waitingwep = 0
	self.Owner.ShouldReduceFallDamage = true
	return true
end

function SWEP:Holster()
	self.Owner.ShouldReduceFallDamage = false
	return true
end

hook.Add("EntityTakeDamage", "ReduceFallDamage", ReduceFallDamage)

-------------------------------------------------------------------

------------General Swep Info---------------
SWEP.Author   = "Haxray"
SWEP.Contact        = ""
SWEP.Purpose        = "Assault"
SWEP.Instructions   = "Control + Left click for pounce and right for claws."
SWEP.Spawnable      = true
SWEP.AdminSpawnable  = true
SWEP.HoldType	= "duel"
SWEP.Category = "Left 4 Dead"
SWEP.ViewModelFOV = 53
SWEP.SwayScale	  = 2.0
SWEP.BobScale	  = 1.5	
-----------------------------------------------

------------Models---------------------------
SWEP.ViewModel      = ""
SWEP.WorldModel   = ""
-----------------------------------------------

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.2 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 9	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= false	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------