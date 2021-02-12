AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/gfx/vgui/deserteagle")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= ""
SWEP.Contact		= "Steam"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "revolver"
SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_deagle.mdl"
SWEP.PrintName		= "Desert Eagle"
SWEP.Base			= "weapon_breach_base"
SWEP.DrawCrosshair	= false
SWEP.Slot			= 2
SWEP.Spawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 4000
SWEP.Primary.Sound			= Sound("Weapon_DEagle.Single")
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Recoil			= 3
SWEP.Primary.Cone			= 0.01
SWEP.Primary.Delay			= 0.225

SWEP.Secondary.Ammo			= "none"
SWEP.DeploySpeed			= 1
SWEP.Damage					= 30
SWEP.HeadshotMultiplier		= 1.6
SWEP.UseHands				= true

SWEP.CSMuzzleFlashes 		= true
SWEP.CSMuzzleX				= false

SWEP.ItemType = WEAPON_DM
SWEP.droppable				= false
SWEP.teams					= {4}
SWEP.IDK					= 125
SWEP.ZoomFov				= 90
SWEP.HasScope				= false
SWEP.DrawCustomCrosshair	= true
function SWEP:Equip()
	if SERVER and IsValid(self.Owner) and self.Primary.Ammo != "none" then
		--if self.Owner.gettingammo then
			//print(self.Owner.gettingammo)
			self:SetClip1(7)
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
			   -- net.Start("deathmatch_gunshot_sound")
        --  net.WriteString(self.Secondary.Sound)
          --net.Send(GetGhosts())
      end
		else
      if SERVER then
			   -- net.Start("deathmatch_gunshot_sound")
        --  net.WriteString(self.Primary.Sound)
        --  net.Send(GetGhosts())
      end
		end
	else
    if SERVER then
      --  net.Start("deathmatch_gunshot_sound")
      --  net.WriteString(self.Primary.Sound)
        --net.Send(GetGhosts())
    end
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
