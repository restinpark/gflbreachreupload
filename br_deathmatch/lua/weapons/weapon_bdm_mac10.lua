AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/gfx/vgui/mac10")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= ""
SWEP.Contact		= "Steam"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 74
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "smg"
SWEP.ViewModel		= "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_mac10.mdl"
SWEP.PrintName		= "MAC-10"
SWEP.Base			= "weapon_breach_base"
SWEP.DrawCrosshair	= false
SWEP.Slot			= 3
SWEP.Spawnable		= true
SWEP.ItemType = WEAPON_DM
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 4000
SWEP.Primary.Sound			= Sound("weapons/mac10/mac10-1.wav")
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Recoil			= 2.55
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.11

SWEP.Secondary.Ammo			= "none"
SWEP.DeploySpeed			= 1
SWEP.Damage					= 16
SWEP.HeadshotMultiplier		= 1.6
SWEP.UseHands				= true

SWEP.CSMuzzleFlashes 		= true
SWEP.CSMuzzleX				= true

SWEP.droppable				= false
SWEP.teams					= {4}
SWEP.IDK					= 76
SWEP.ZoomFov				= 90
SWEP.HasScope				= false
SWEP.DrawCustomCrosshair	= true
function SWEP:Equip()
	if SERVER and IsValid(self.Owner) and self.Primary.Ammo != "none" then
		--if self.Owner.gettingammo then
			//print(self.Owner.gettingammo)
			self:SetClip1(30)
			--self.Owner.gettingammo = 0
	end
end
function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	timer.Destroy("needtoscope" .. self.Owner:SteamID())
	self.IsReloading = false
	if self.HasSilencer then
		if self.IsSilenced then
      if SERVER then
				--GhostEmitSound(self.Primary.Sound, self.Owner:GetPos())
      end
		else
      if SERVER then
				--	GhostEmitSound(self.Primary.Sound, self.Owner:GetPos())
      end
		end
	else

			--	GhostEmitSound(self.Primary.Sound, self.Owner:GetPos())
if CLIENT then
				self.Weapon:EmitSound(self.Primary.Sound)
			end
	end
	local cone = 0.01
	if self.IsScoping then
		cone = self.Primary.Cone / 2
	else
		cone = self.Primary.Cone
	end
	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
	self:TakePrimaryAmmo( self.Primary.NumShots )
	self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, cone )
end
function SWEP:DoImpactEffect( tr,  damageType )
	return true
end


local disabled_effects = {
		[9001] = true,
		[6001] = true,
		[9011] = true,
		[9021] = true,
		[9031] = true,
		[9041] = true,
		[9051] = true,
		[9061] = true,
		[9071] = true,
		[9081] = true,
		[9091] = true,
		[5004] = true,
		[5001] = true,
		[5011] = true,
		[5021] = true,
		[5031] = true,
		[5002] = true,
		[5003] = true,
		[5013] = true,
		[5023] = true,
		[5033] = true,
		[3017] = true,
		[3018] = true,
	}
local disabled_by_name = {
	["EjectBrass_338Mag"] = true,
	["EjectBrass_762Nato"] = true,
	["EjectBrass_556"] = true,
	["EjectBrass_57"] = true,
	["EjectBrass_12Gauge"] = true,
	["EjectBrass_9mm"] = true,
	["EjectBrass_762Nato 2 150"] = true,
	["EjectBrass_9mm 2 100"] = true,
}

function SWEP:FireAnimationEvent( pos, ang, event, name )

	if disabled_effects[event] then return true end
	if disabled_by_name[name] then return true end
	--print(name ..  " = " .. tostring(event))
end


function SWEP:ShootBullet( damage, recoil, num_bullets, aimcone )
	local meme = neutralnum(self.Owner:GetVelocity():Length() / 25)
	local gap = aimcone + (meme / (self.IDK * 4))
	local bullet = {}
	bullet.Num 		= num_bullets
	bullet.HullSize	= 1.25
	bullet.Src 		= self.Owner:GetShootPos()			-- Source
	bullet.Dir 		= self.Owner:GetAimVector()			-- Dir of bullet
	bullet.Spread 	= Vector( gap, gap, 0 )				-- Aim Cone
	bullet.Tracer	= 0									-- Show a tracer on every x bullets
	bullet.Force	= 1									-- Amount of force to give to phys objects
	bullet.Damage	= self.Damage
	bullet.AmmoType = self.Primary.Ammo

	self:ShootEffects()

	bullet.Callback = function( attacker, tr, dmginfo)
		if attacker:IsPlayer() then
			if SERVER then
				if tr.Entity:GetClass() == "prop_vehicle_prisoner_pod" or tr.Entity:IsVehicle() then
					if tr.Entity:GetDriver() ~= NULL then
						tr.Entity:GetDriver():TakeDamageInfo(dmginfo)
					end
				end
			end

		end
	end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = (recoil * 0.6) or recoil

      local eyeang = self.Owner:EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self.Owner:SetEyeAngles( eyeang )
   end

	self.Owner:FireBullets( bullet )

end
