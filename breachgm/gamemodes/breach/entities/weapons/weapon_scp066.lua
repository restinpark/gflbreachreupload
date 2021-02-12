AddCSLuaFile()
--(One of) my first sweps, you won't enjoy.
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/scp_066_wep")
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-066"
SWEP.Author = "Aurora"
SWEP.Category = "Aurora's SWEPs"
SWEP.Instructions = "Primary to play beethoven’s second symphony at 140 decibels, Secondary to unleash your musical strings, Reload to break glass and gates."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.droppable = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Damage = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = false
SWEP.Purpose = "Display your love for beethoven"
SWEP.NextAttackH = 0
SWEP.NextAttackW = 0
SWEP.NextAttackR = 0
SWEP.NextString = 0
SWEP.AttackDelay1 = 8
SWEP.AttackDelay2 = 1
SWEP.AttackDelay3 = 2
SWEP.StringDelay = 15
SWEP.nexteric = CurTime() + 15
function SWEP:Initialize()
  util.PrecacheSound( "scp066/beethoven.ogg" )
  util.PrecacheSound( "scp066/eric1.ogg" )
  util.PrecacheSound( "scp066/eric2.ogg" )
  util.PrecacheSound( "scp066/eric3.ogg" )
  util.PrecacheSound( "scp066/notes1.ogg" )
  util.PrecacheSound( "scp066/notes2.ogg" )
  util.PrecacheSound( "scp066/notes3.ogg" )
end
function SWEP:Deploy()
  self.Owner:DrawViewModel( false )
  self.Owner:DrawWorldModel( false )
	self.Owner.BaseWalk =  self.Owner:GetWalkSpeed()
	self.Owner.BaseRun = self.Owner:GetRunSpeed()
	self.Owner.jumpp = self.Owner:GetJumpPower()
end
function SWEP:Holster()
	return true
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("melee")
end
function SWEP:Think()
  --Play a random note/eric every 20-30 seconds
	--print(self.nexteric - CurTime())
	if CurTime() < self.nexteric then return end
	if self.AttackIsActive then return end
  self.Owner:EmitSound( "scp066/eric"..math.random(1, 6)..".ogg", SNDLVL_100dB, 100, 1, CHAN_AUTO )
  self.nexteric = CurTime() + math.random(20, 40)
end

function SWEP:Reload()
if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if (CurTime() < self.NextAttackH) then return end
	self.NextAttackH = CurTime() + self.AttackDelay2
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
			if ent:GetClass() == "func_breakable" then
				if SERVER then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				end
			elseif SERVER and BREACH_IsGateDoor(ent) then
				ent:TakeDamage( math.random(100, 150), self.Owner, self.Owner )
			end
		end
end
function SWEP:PrimaryAttack()
  if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if CurTime() < self.NextAttackW then return end
	self.AttackIsActive = true
	self.Owner:EmitSound("scp066/beethoven.ogg",  SNDLVL_140dB, 100, 1,  CHAN_WEAPON)
	function ApplyEffect()
	  if SERVER and IsValid(self.Owner) then
		    local findents = ents.FindInSphere( self.Owner:GetPos(), 275 )
		    local foundplayers = {}
		    for k,v in pairs(findents) do
			       if v:IsPlayer() and IsValid(v) then
						if !(v:Team() == TEAM_SCP or v:Team() == TEAM_SPEC or v == self.Owner) then
						   if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					                table.ForceInsert(foundplayers, v)
				           end
			       end
		    end
		  if #foundplayers > 0 then
			  for index,ply in pairs(foundplayers) do
				    if SERVER then
					      ply:TakeDamage(10, self.Owner, self )
			 	    end
			  end
		  end
	  end
  end
	function NotAttacking()
		self.AttackIsActive = false
    if SERVER then
      --self.Owner:Freeze(false)
			--
			self.Owner:SetWalkSpeed(self.Owner.BaseWalk)
			self.Owner:SetRunSpeed(self.Owner.BaseRun)
    end
	end
  if SERVER then
		--self.Owner:Freeze(false)
    self.Owner.BaseWalk =  self.Owner:GetWalkSpeed()
		self.Owner.BaseRun = self.Owner:GetRunSpeed()
		self.Owner:SetWalkSpeed(self.Owner.BaseWalk * 0.8)
		self.Owner:SetRunSpeed(self.Owner.BaseRun * 0.8)
  end
	timer.Create("EFFECT_DURATION_SCP_066_1", .5, 20, ApplyEffect)
	timer.Simple(10, NotAttacking)
	self.NextAttackW = CurTime() + self.AttackDelay1 + 10
end

function SWEP:SecondaryAttack()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if (CurTime() < self.NextString) then return end
	self.NextString = CurTime() + self.StringDelay
	if ( IsFirstTimePredicted() ) then
		self.Owner:ViewPunch( Angle( -3, 0, 0 ) )
		timer.Simple(0.2, function() self:EmitSound( "weapons/gu_hit/hit" .. math.random( 1, 2 ) .. ".mp3", 400, math.random( 85, 100 ) ) end)
		timer.Simple(0.25, function() util.ScreenShake( self.Owner:GetPos(), 4, 100, 0.5, 128 ) end)
		local fx = EffectData()
			fx:SetEntity(self.Weapon)
			fx:SetOrigin(self.Owner:GetShootPos())
			fx:SetNormal(self.Owner:GetAimVector())
		timer.Simple(0.3, function() util.Effect("m9k_m_heat",fx) end)
		local bullet = {}
		bullet.Num = 12
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector(0.12, 0.12, 0)
		bullet.Tracer = 1
		bullet.TracerName = "m_guitar_tracer"
		bullet.Force = 10
		bullet.Damage = 15
		timer.Simple(0.3, function() self.Owner:FireBullets(bullet) end)

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Next chorus ready!"
	local showcolor = Color(0,255,0)

	if self.NextAttackW > CurTime() then
		showtext = "Moving to the next staff " .. math.Round(self.NextAttackW - CurTime())
		showcolor = Color(255,0,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 30 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
if disablehud == true then return end

	local showtext2 = "E Sharp is ready!"
	local showcolor2 = Color(0,255,0)

	if self.NextString > CurTime() then
		showtext2 = "Tuning the strings " .. math.Round(self.NextString - CurTime())
		showcolor2 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = showcolor2,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( 0, 255, 0, 255 )

	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
end
