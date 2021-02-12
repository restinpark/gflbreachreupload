// Variables that are used on both client and server
SWEP.Category				= "EXP"
SWEP.Author				= "Mighty Lolrus and various people I stole from"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 		
SWEP.ShellEjectAttachment			= "2" 	
SWEP.DrawCrosshair			= false		
SWEP.ViewModelFOV			= 65		
SWEP.ViewModelFlip			= true		

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false


SWEP.Primary.Sound 			= Sound("")				
SWEP.Primary.Round 			= ("")					
SWEP.Primary.Cone			= 0.2					
SWEP.Primary.RPM				= 0					
SWEP.Primary.ClipSize			= 0					
SWEP.Primary.DefaultClip			= 0					
SWEP.Primary.KickUp			= 0					
SWEP.Primary.KickDown			= 0					
SWEP.Primary.KickHorizontal			= 0					
SWEP.Primary.Automatic			= true					
SWEP.Primary.Ammo			= "none"					

SWEP.Secondary.ClipSize			= 0					
SWEP.Secondary.DefaultClip			= 0					
SWEP.Secondary.Automatic			= false					
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.IronFOV			= 0					

SWEP.data 				= {}					
SWEP.data.ironsights			= 1

SWEP.WallSights				= false

SWEP.Single				= nil
SWEP.IronSightsPos = Vector (2.4537, 1.0923, 0.2696)
SWEP.IronSightsAng = Vector (0.0186, -0.0547, 0)

SWEP.WallSightsPos = Vector (0.2442, -11.6177, -3.9856)
SWEP.WallSightsAng = Vector (59.2164, 1.6346, -1.8014)


function SWEP:Initialize()

	util.PrecacheSound(self.Primary.Sound)
	self.Reloadaftershoot = 0 				
	if !self.Owner:IsNPC() then
		self:SetWeaponHoldType("rpg")                          	
	end
	if SERVER and self.Owner:IsNPC() then
		self:SetWeaponHoldType("rpg")                          	
		self:SetNPCMinBurst(3)			
		self:SetNPCMaxBurst(10)			
		self:SetNPCFireRate(1)	
		self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
	end
end

function SWEP:Deploy()

if game.SinglePlayer() then self.Single=true
else
self.Single=false
end
	self:SetWeaponHoldType("fist")                          	
	self:SetIronsights(false, self.Owner)					
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self.Owner:EmitSound("weapons/bf3/draw1.wav")
	self.Owner:ViewPunch(Angle(-3, 2, 2))
	return true
	end


function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheSound("Buttons.snd14")
end

function SWEP:PrimaryAttack()
	if self:CanPrimaryAttack() then
		self:FireRocket()
		self.Weapon:EmitSound(self.Primary.Sound)
		self.Weapon:TakePrimaryAmmo(1)
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:GetViewModel():SetPlaybackRate( 1 )  
		local fx 		= EffectData()
		fx:SetEntity(self.Weapon)
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetNormal(self.Owner:GetAimVector())
		fx:SetAttachment(self.MuzzleAttachment)
		util.Effect("gdcw_muzzle",fx)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:MuzzleFlash()
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
	end
end

function SWEP:FireRocket()
	if (self:GetIronsights() == true) and self.Owner:KeyDown(IN_ATTACK2) then
	aim = self.Owner:GetAimVector()
	else 
	aim = self.Owner:GetAimVector()+Vector(math.Rand(-0.02,0.02), math.Rand(-0.02,0.02),math.Rand(-0.02,0.02))
	end
	if !self.Owner:IsNPC() then
	pos = self.Owner:GetShootPos()
	else
	pos = self.Owner:GetShootPos()+self.Owner:GetAimVector()*50
	end
	if SERVER then
		local rocket = ents.Create(self.Primary.Round)
		if !rocket:IsValid() then return false end
		rocket:SetAngles(aim:Angle()+Angle(90,0,0))
		rocket:SetPos(pos)
		rocket:SetOwner(self.Owner)
		rocket:Spawn()
		rocket.owner = self.Owner
		rocket:Activate()
	end
		if SERVER and !self.Owner:IsNPC() then
		local anglo = Angle(math.Rand(-self.Primary.KickDown,self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
		self.Owner:ViewPunch(anglo)
		angle = self.Owner:EyeAngles() - anglo
		self.Owner:SetEyeAngles(angle)
		end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	if (SERVER) then end
	self.Weapon:DefaultReload(ACT_VM_RELOAD) 
	if !self.Owner:IsNPC() then
	self.Idle = CurTime() + self.Owner:GetViewModel():SequenceDuration() end

	if ( self.Weapon:Clip1() < self.Primary.ClipSize ) and !self.Owner:IsNPC() then

	

		self.Owner:SetFOV( 0, 0.3 )
		self:SetIronsights(false)
		

end

	
end


function SWEP:IronSight()
	if (SERVER) then end
	
	
	
	if self.Owner:KeyDown(IN_SPEED) and self.Owner:KeyDown(IN_FORWARD) then		// If you hold E and you can shoot then
	
	self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				// Make it so you can't shoot for another quarter second
	self:SetWeaponHoldType("Passive")                          			
	self.IronSightsPos = self.RunSightsPos					
	self.IronSightsAng = self.RunSightsAng				
	self:SetIronsights(true, self.Owner)
	self.Owner:GetViewModel():SetPlaybackRate( 1.05 ) 	
	self.Owner:SetFOV( 0, 0.3 )
	end								

	if self.Owner:KeyReleased (IN_SPEED) then	// If you release E then
	
	self:SetWeaponHoldType("rpg")                          				
	self:SetIronsights(false, self.Owner)	
	
	self.Owner:SetFOV( 0, 0.3 )
	end								

	if !self.Owner:KeyDown(IN_SPEED) then
	

		if self.Owner:KeyPressed(IN_ATTACK2) then
		if (SERVER) then end
		self.Owner:EmitSound("weapons/bf3/ironin.wav")
		if (SERVER) then end
		
		

			self:SetWeaponHoldType("ar2")                          		// Hold type styles; ar2 ar2 shotgun rpg normal melee grenade smg slam fist melee2 passive knife
			self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
			self.IronSightsPos = self.SightsPos					// Bring it up
			self.IronSightsAng = self.SightsAng					// Bring it up
			self:SetIronsights(true, self.Owner)
			

			if CLIENT then return end
 		end
	end

	if self.Owner:KeyReleased(IN_ATTACK2) and !self.Owner:KeyDown(IN_SPEED) then
		if (SERVER) then end
		self.Owner:EmitSound("weapons/bf3/ironout.wav")
		if (SERVER) then end
		self.Owner:SetFOV( 0, 0.3 )
		self:SetWeaponHoldType("rpg")

		self:SetIronsights(false, self.Owner)
		

		if CLIENT then return end
	end


		if self.Owner:KeyDown(IN_ATTACK2) and !self.Owner:KeyDown(IN_SPEED) then
		self.SwayScale 	= 0.03
		self.BobScale 	= 0.03
		else
		self.SwayScale 	= 0.0
		self.BobScale 	= 0.7
		end
		if (SERVER) then end
		
		if self.Owner:KeyPressed(IN_JUMP) then
		self.Owner:SetFOV( 0, 0.3 )
		self:SetIronsights(false, self.Owner)
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
		self.Owner:GetViewModel():SetPlaybackRate( 2 ) 
		
		
end
end

CreateConVar("speech_delay",1,{FCVAR_NOTIFY,FCVAR_ARCHIVE,FCVAR_SERVER_CAN_EXECUTE},"speech delay")
local speechDelay = 0

function SWEP:Think()
	
	self:IronSight()
	if !self.Owner:IsNPC() then
	if self.Idle and CurTime() >= self.Idle then
	self.Idle = nil
	self:SendWeaponAnim(ACT_VM_IDLE)
	end 
	end
		if self.Owner:KeyReleased(IN_USE) then
        if (SERVER) and !self.Owner:IsNPC() then
                local player = self.Owner
 
                -- could also implement distance with ents.FindInSphere
                -- local entities = ents.FindInSphere(Vector(0,0,0),1500)
 
                local trace = player:GetEyeTrace() or nil
                if trace.Hit then
                        local entity = trace.Entity
                        if entity:IsValid() then
                                if entity:IsNPC() or entity:IsPlayer() then
                                        if CurTime() > speechDelay then
                                                local sound = ("bf3/spot"..math.random(1,34)..".wav")
                                                player:EmitSound(sound,45,100)
                                                local soundDelay = SoundDuration(sound)
                                                local convDelay = GetConVarNumber("speech_delay")
                                                speechDelay = CurTime() + soundDelay + convDelay
                                        end
                                end
                        end
                end
        end
end
end


local IRONSIGHT_TIME = 0.2


function SWEP:GetViewModelPosition(pos, ang)

	if (not self.IronSightsPos) then return pos, ang end

	local bIron = self.Weapon:GetNWBool("Ironsights")

	if (bIron != self.bLastIron) then
		self.bLastIron = bIron
		self.fIronTime = CurTime()
	end

	local fIronTime = self.fIronTime or 0

	if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME) then
		return pos, ang
	end

	local Mul = 1.0

	if (fIronTime > CurTime() - IRONSIGHT_TIME) then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if not bIron then Mul = 1 - Mul end
	end

	local Offset	= self.IronSightsPos

	if (self.IronSightsAng) then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), 		self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 		self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), 	self.IronSightsAng.z * Mul)
	end

	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
end


function SWEP:SetIronsights(b)

	self.Weapon:SetNetworkedBool("Ironsights", b)
end

function SWEP:GetIronsights()

	return self.Weapon:GetNWBool("Ironsights")
end