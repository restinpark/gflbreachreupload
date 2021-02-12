SWEP.Category 			    = "SCP-096"
SWEP.PrintName				= "SCP-096"
SWEP.Author					= "Aurora/chan_man1"
SWEP.Instructions			= "If people look at you, you can attack them."
SWEP.ViewModelFOV = 56
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Delay          = 2
SWEP.Primary.Automatic		= true

SWEP.Primary.Ammo			= "None"
SWEP.Primary.Damage = 50
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 0
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.IdleAnim				= true
SWEP.droppable = false
SWEP.ViewModel				= Model("models/weapons/v_arms_scp096.mdl")
SWEP.WorldModel				= Model("models/weapons/v_arms_scp096.mdl")
SWEP.IconLetter			= "w"
SWEP.Primary.Sound = Sound("weapons/scp96/attack1.wav")
SWEP.HoldType 				= "normal"
if (CLIENT) then
  SWEP.WepSelectIcon		= surface.GetTextureID( "breach/096" )
end

--List of players that can be killed
SWEP.ShitList = {}
--List of players who may be added to the shitlist
SWEP.ShitListCanidates = {}
--List of players who have been sent to the client
SWEP.NetworkedShitList = {}

function SWEP:Initialize()
  self:SetHoldType( self.HoldType )
  self:SetNWBool("IsAngry", false)
end

function SWEP:Initialize()
	util.PrecacheSound("weapons/scp96/attack1.wav")
	util.PrecacheSound("weapons/scp96/attack2.wav")
	util.PrecacheSound("weapons/scp96/096_1.wav")
	util.PrecacheSound("weapons/scp96/096_2.wav")
	util.PrecacheSound("weapons/scp96/096_3.wav")
	util.PrecacheSound("weapons/scp96/096_idle1.wav")
	util.PrecacheSound("weapons/scp96/096_idle2.wav")
	util.PrecacheSound("weapons/scp96/096_idle3.wav")
end

function SWEP:IsLookingAt( ent1, ent2 )

  if ent1:GetPos():Distance(ent2:GetPos()) > 2000 then return false end
	return (ent1:GetAimVector():Dot( ( ent2:GetPos() - ent1:GetPos() + Vector( 70 ) ):GetNormalized() ) > 0.39)
end
function SWEP:DrawWorldModel()

end
hook.Add("CalcMainActivity", "CalcMainActivity_096models", function (ply, vel)
  if ply:GetNClass() == ROLE_SCP096 and ply:GetNWBool("DoAngerAnim", false) then
    --TODO: Recompile model with anim
    return ACT_IDLE_ANGRY, nil
  end
end)
function SWEP:Think()
	if CLIENT then
		self.DrawRed = CurTime() + 0.1
	end
	if postround then return end
	local watching = 0
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) and v:Team() != TEAM_SPEC and v:Alive() and v != self.Owner and v:GetNClass() != ROLE_SCP990 and v.canblink then
			local tr_eyes = util.TraceLine( {
				start = v:EyePos() + v:EyeAngles():Forward() * 15,
				endpos = self.Owner:EyePos(),
			} )
			local tr_center = util.TraceLine( {
				start = v:LocalToWorld( v:OBBCenter() ),
				endpos = self.Owner:LocalToWorld( self.Owner:OBBCenter() ),
				filter = v
			} )
			if tr_eyes.Entity == self.Owner or tr_center.Entity == self.Owner then
      if self:IsLookingAt( v ) and v.isblinking == false then
          watching = watching + 1
        end
      end
		end
	end
  if CLIENT then return end
	if watching > 0 then
    self.NextAngry = self.NextAngry or 0
    if not self:GetNWBool("IsAngry", false) and self.NextAngry < CurTime() then
      self:SetNWBool("IsAngry", true)
      self.Owner:EmitSound("096_trig.ogg")
      self.Owner:Freeze(true)
      self.Owner:GodEnable()
      self.Owner:SetNWBool("DoAngerAnim", true)
      local o = self.Owner
      local e = self
      timer.Simple(6, function ()
        if o and IsValid(o) and o:GetNClass() == ROLE_SCP096 then
          o:GodDisable()
          o:Freeze(false)
		if o:GetAmmoCount(22) > 2 then
		  o:SetWalkSpeed(240)
		  o:SetRunSpeed(240)
          o:SetMaxSpeed(240)
		  o:SetArmor(0)
		else
          o:SetWalkSpeed(350)
		  o:SetRunSpeed(350)
          o:SetMaxSpeed(350)
		end
          if e and IsValid(e) then 
            e.Owner:SetNWBool("DoAngerAnim", false)
		end
          timer.Simple(15, function ()
            if IsValid(o) and o:GetNClass() == ROLE_SCP096 then
			if o:GetAmmoCount(20) > 0 then
              o:SetWalkSpeed(50)
              o:SetRunSpeed(50)
              o:SetMaxSpeed(50)
			 else
			  o:SetWalkSpeed(100)
              o:SetRunSpeed(100)
              o:SetMaxSpeed(100)
			end
            end
            if IsValid(e) then
              e:SetNWBool("IsAngry", false)
              self.NextAngry = CurTime() + 10
            end
          end)
        end
      end)

    end
	else

	end
end

function SWEP:PrimaryAttack()
  if not self:GetNWBool("IsAngry", false) then return end
	self:SetNextPrimaryFire( CurTime() + 0.3 )
  self.Owner:SetAnimation( PLAYER_ATTACK1 );
  self:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
  self:EmitSound("weapons/scp96/attack" .. tostring(math.random(1,2)) .. ".wav")
  --Crowbar code
  timer.Simple( 0.15, function()
      if not IsValid(self) then return end
      self.Owner:LagCompensation( true )
      local tr = util.TraceLine( {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 100,
        filter = self.Owner,
        mask = MASK_SHOT_HULL,
      } )
      if !IsValid( tr.Entity ) then
        tr = util.TraceHull( {
          start = self.Owner:GetShootPos(),
          endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 100,
          filter = self.Owner,
          mins = Vector( -16, -16, 0 ),
          maxs = Vector( 16, 16, 0 ),
          mask = MASK_SHOT_HULL,
        } )
      end

      if SERVER and tr.Hit and IsValid(tr.Entity) then
        self.Owner:EmitSound( "player/kevlar3.wav" )
      end
      if SERVER and IsValid( tr.Entity ) then
        if tr.Entity:IsPlayer() and tr.Entity:Team() == TEAM_SPEC then return end
        if tr.Entity:GetClass() == "func_breakable" then
          tr.Entity:TakeDamage(300, self.Owner, self)
          return
        elseif BREACH_IsGateDoor(ent) then
          ent:TakeDamage( math.random(100, 300), self.Owner, self.Owner )
          return
        end
        local dmginfo = DamageInfo()
        local attacker = self.Owner
        if !IsValid( attacker ) then
          attacker = self
        end
        dmginfo:SetAttacker( attacker )
        dmginfo:SetInflictor( self )
        dmginfo:SetDamage( self.Primary.Damage )
        dmginfo:SetDamageForce( self.Owner:GetForward() * 10000)
		if tr.Entity:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
		if tr.Entity:GetNClass() == ROLE_SCP173 then
			tr.Entity:TakeDamage(75)
		end
        tr.Entity:TakeDamageInfo( dmginfo )
        local effectdata = EffectData()
        effectdata:SetOrigin(  tr.Entity:GetPos() + Vector(0,0,30) )
        util.Effect( "BloodImpact", effectdata )
      end
      self.Owner:ViewPunchReset()
      self.Owner:ViewPunch( Angle( 10 * 0.5, -5 * 0.5, 5 * 0.5 ) )
      self.Owner:LagCompensation(false)
  end )

  --end

	self:SetNextPrimaryFire( CurTime() + 0.43 )
end

function SWEP:Deploy()
  if CLIENT then
    SCP_096_CLIENT_SHITLIST = {}
  end
	if self.Owner:IsValid() then
	self.Weapon:EmitSound( "weapons/scp96/096_idle"..math.random(1,3)..".wav" )
	//self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
    //self:SetDeploySpeed( self.Weapon:SequenceDuration(0.2) )
	//self.Weapon:SendWeaponAnim( ACT_VM_IDLE )

	self:SendWeaponAnim( ACT_VM_DRAW )
	timer.Simple(0.9, function(wep) self:SendWeaponAnim(ACT_VM_IDLE) end)
	end
	return true;
end

function SWEP:Holster()
	if self.Owner:IsValid() then
	end
	return true;
end

function SWEP:SecondaryAttack()
	if not self:GetNWBool("IsAngry", false) then return end
  self:SetNextPrimaryFire( 15 )
  self.Owner:SetAnimation( PLAYER_ATTACK1 );
  self:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
  self:EmitSound("weapons/scp96/attack" .. tostring(math.random(1,2)) .. ".wav")
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
		for k,v in pairs(ents.GetAll(ent)) do
		if ent:GetClass() == "func_breakable" then return end
		if BREACH_IsGateDoor(ent) then return end
		if ent:GetClass() == "prop_dynamic" then
			SafeRemoveEntity(ent)
		ent:EmitSound("physics/metal/metal_box_break2.wav", 50, 75)
		end
		if ent:GetClass() == "func_door" then
			SafeRemoveEntity(ent)
		ent:EmitSound("physics/metal/metal_box_break2.wav", 50, 75)
		end
	end
end
end


function SWEP:DrawHUD()


end

function SWEP:IsLookingAt( ply )
	local yes = ply:GetAimVector():Dot( ( self.Owner:GetPos() - ply:GetPos() + Vector( 70 ) ):GetNormalized() )
	return (yes > 0.39)
end
