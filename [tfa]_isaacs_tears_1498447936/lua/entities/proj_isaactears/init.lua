AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Tear = {}
ENT.Laser = {}

function ENT:Initialize()
	self:TearStartup()
end

function ENT:TearStartup()
	self:GetWeaponStats()

	self:TearRender()

	self:TearCollision()

	self:SetHealth(10)

	self:Activate()

	local phys = self:GetPhysicsObject()

	phys:Wake()
	phys:EnableMotion(true)
	phys:AddGameFlag(1024)

	local ang = self:GetOwner():EyeAngles()
	local dir = ang:Forward()
	phys:SetVelocity(dir * (self.Tear.Velocity ) )
	self:SetVelocity(dir * (self.Tear.Velocity ) )

	if self.Tear.Bombs or self.Tear.Explosive then
		phys:EnableDrag(true)
		phys:EnableGravity(true)
	else
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	self:SetPhysicsAttacker(self.Owner,-1)

	if self.Tear.Bombs then
		self.PopTime = self.Range/2
	elseif self.Tear.Eyeball then
		self.PopTime = self.Range*2
	else
		self.PopTime = self.Range*2
	end

	if !self.Tear.Eyeball or self.Tear.Bombs then
		timer.Simple(self.PopTime,
			function()
				if(self and self:IsValid()) then
					self.HomingRange = false
					phys:EnableDrag(true)		
					phys:EnableGravity(true)	
					if self.Tear.Bombs then
						self:TearDamage()
						self:Destroy()
					end
				end
			end
		)
	end
	timer.Simple(self.PopTime*3,
		function()
			if(self and self:IsValid()) then
				self:Destroy()			
			end
		end
	)

	self.HomingRange = true
	self.DealtDamage = false

	if self.TearsShot > 1 and !self.FakeTear then
		self:MultiTear(self.TearsShot, true)
	end
end

function ENT:GetWeaponStats()
	local function GetStat(stat)
		local value = (self.Owner:GetActiveWeapon():GetStat(stat) or 0 ) > 0
		return value
	end

	-- [ Isaac Stats ]
		self.Damage = self.Owner:GetActiveWeapon():GetStat("Isaac.Effective.Damage")
		self.Range = self.Owner:GetActiveWeapon():GetStat("Isaac.Effective.Range")
		self.TearsShot = self.Owner:GetActiveWeapon():GetStat("Isaac.Stats.TearsShot")
		self.TearSize = math.max(math.min(self.Damage/25,1.5),0.05)

	-- [ Tear Stats ]
		self.Tear.Velocity = self.Owner:GetActiveWeapon():GetStat("Isaac.Effective.ShotSpeed")
		self.Tear.Spread = self.Owner:GetActiveWeapon():GetStat("Isaac.Stats.TearSpread")
		self.Laser.Distance = self.Owner:GetActiveWeapon():GetStat("Isaac.Tear.Laser.Distance")
		self.Laser.DamageMult = self.Owner:GetActiveWeapon():GetStat("Isaac.Tear.Laser.DamageMult")
		self.Laser.Timer = self.Owner:GetActiveWeapon():GetStat("Isaac.Tear.Laser.Timer")
		self.Tear.Color = self.Owner:GetActiveWeapon():GetStat("Isaac.Tear.Color")

	-- [ Tear Booleans ]
		self.Tear.Spectral	 = GetStat("Isaac.Tear.Spectral")
		self.Tear.Piercing		 = GetStat("Isaac.Tear.Piercing")
		self.Tear.Homing		 = GetStat("Isaac.Tear.Homing")
		self.Tear.Boomerang	 = GetStat("Isaac.Tear.Boomerang")
		self.Tear.Bombs		 = GetStat("Isaac.Tear.Bombs")
		self.Tear.Explosive	 = GetStat("Isaac.Tear.Explosive")
		self.Tear.Poison		 = GetStat("Isaac.Tear.Poison")
		self.Tear.Fire		 = GetStat("Isaac.Tear.Fire")
		self.Tear.Petrify		 = GetStat("Isaac.Tear.Petrify")
		self.Tear.Slow		 = GetStat("Isaac.Tear.Slow")
		self.Tear.Brimstone	 = GetStat("Isaac.Tear.Brimstone")
		self.Tear.Wide		 = GetStat("Isaac.Tear.Wide")
		self.Tear.Grow		 = GetStat("Isaac.Tear.Grow")
		self.Tear.Bounce		 = GetStat("Isaac.Tear.Bounce")
		self.Tear.Shrink		 = GetStat("Isaac.Tear.Shrink")
		self.Tear.Tooth		 = GetStat("Isaac.Tear.Tooth")
		self.Tear.Eyeball		 = GetStat("Isaac.Tear.Eyeball")

	local ColorMin = 50
	for k,v in pairs(self.Tear.Color) do
		if k < ColorMin then
			ColorMin = k
		end
	end

	self.ColorTable = self.Tear.Color[math.min(ColorMin)]

	if self.FakeTear and self.OriginalTear then
		for v, k in pairs(self.OriginalTear.Tear) do
			self.Tear[v] = k
		end
		for v, k in pairs(self.OriginalTear.Laser) do
			self.Laser[v] = k
		end
	end
end

function ENT:TearRender()
	if !self.Tear.Bombs then
		self.ColorTable["a"] = 200
		if self.Tear.Eyeball then
			self:SetModel( "models/isaactears/eyeball.mdl" )
			self:SetModelScale(self.TearSize,0.05)
			self.ColorTable["a"] = 255
		elseif self.Tear.Tooth then
			self:SetModel( "models/isaactears/tooth.mdl" )
			self:SetModelScale(self.TearSize,0.05)
			self.ColorTable["a"] = 255
		elseif self.Tear.Wide then
			self:SetModel( "models/isaactears/widearc.mdl" )
			self:SetMaterial( "isaactears/tears/generic/bubble", true)
			self:SetModelScale(self.TearSize, 0.05)
		else
			self:SetModel( "models/hunter/misc/sphere075x075.mdl" )
			self:SetMaterial( "isaactears/tears/generic/bubble", true)
			self:SetModelScale(self.TearSize*1.25,0.05)
		end
	else
		self:SetModel( "models/hunter/misc/sphere075x075.mdl" )
		self:SetModelScale(self.TearSize*1.25,0.05)
		self:SetMaterial( "grey", true)
		self.ColorTable["a"] = 255
	end

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
	if !self.FakeTear then
		self.Owner:EmitSound( Sound("weapons/isaactears/generic/fire"..math.random(0,2)..".wav"))
	end
	if self.Tear.Grow then
		self:SetModelScale(self.TearSize*10, 5)
	elseif self.Tear.Shrink then
		self:SetModelScale(self.TearSize/10, 3)
	end

	if self.Tear.Fire then
		self:Ignite(1000,0)
	end
	self:SetColor( self.ColorTable )
end

function ENT:TearCollision()
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetTrigger(true)
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	if self.Tear.Spectral then
		self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	end
end

function ENT:MultiTear( tearnum, bump )
	self:Destroy(true)
	for i = 1, tearnum-1 do
		local ang = self:GetOwner():EyeAngles()
		local dir = ang:Forward()

		local tear = ents.Create( "proj_isaactears" )
		tear.OriginalTear = self
		tear.FakeTear = true
		tear:SetOwner(self.Owner)
			
		local newpos = ( (self.Tear.Spread/tearnum) * (i-tearnum/2) )

		if bump then
			local bumppos = ( (self.Tear.Spread/tearnum) * -math.abs((i-tearnum/2))/3 )
			tear:SetPos( self:LocalToWorld(Vector(bumppos, newpos, 0) ) )
		else
			tear:SetPos( self:LocalToWorld(Vector(0, newpos, 0) ) )
		end
		tear:SetAngles(ang)
		tear:Spawn()

		tear:SetOwner(self.Owner)			
	end
end

function ENT:Touch( entity )
	if (entity ~= self.Owner) and entity:IsPlayer() or entity:IsNPC() then
		timer.Simple(entity.IsaacDamageTimer, function()
			if self:IsValid() and entity.IsaacTearTouching then
				self:TearDamage(entity)
			end
		end)
		entity.IsaacDamageTimer = entity.IsaacDamageTimer + 0.5
	end
	if ( ( !self.Tear.Bombs or (self.Tear.Bombs and self.Tear.Explosive) ) and !self.Tear.Bounce or (self.Tear.Bounce and self.Tear.Explosive) ) then
		if entity:IsWorld()then
			self:TearDamage()
			self:Destroy()
		end
	end
end

function ENT:StartTouch( entity )
	entity.IsaacTearTouching = true
	entity.IsaacDamageTimer = 0
end

function ENT:EndTouch( entity )
	entity.IsaacTearTouching = false
end

function ENT:PhysicsCollide( data, phys )
	self:Touch(data.HitEntity)
end

function ENT:Think()
	if self.Tear.Grow then
		self.Damage = self.Damage + (self:GetModelScale()/3)
	elseif self.Tear.Shrink then
		self.Damage = self.Damage / (1/self:GetModelScale())
	end
	if self:WaterLevel() > 0 then
 		self:Destroy()
 	end
 	if self.Tear.Homing and self.HomingRange then
		local nearestEnt
		local range = 50000
		range = range ^ 2

		local entsnear = ents.FindInSphere(self:GetPos(), range)

		for _, ent in pairs( entsnear ) do
			if ent:IsNPC() or (ent:IsPlayer() and ent ~= self.Owner) then
				local distance = (self:GetPos() - ent:GetPos()):LengthSqr()
				if( distance <= range ) then
					nearestEnt = ent
					range = distance
				end
			end
		end

		if nearestEnt and nearestEnt:Health() > 0 then
			self.HomingNow = true
			local distanceent = self:GetPos():Distance(nearestEnt:GetPos())
			local lerpthing = CurTime()/(2000/(distanceent))
			local ang = Lerp( lerpthing , self:GetAngles(), ( (nearestEnt:GetPos()+Vector(0,0,50) ) - self:GetPos() ):Angle() )

			local dir = ang:Forward()

	 		self:SetAngles( ang )
	 		self:GetPhysicsObject():SetVelocity(dir * ( self.Tear.Velocity*(math.max(math.min(distanceent/500, 1),0.2 ) ) ))
		else
			self.HomingNow = false
			nearestEnt = nil
		end
 	end
 	if self.Tear.Boomerang and !self.HomingNow then
		local lerpthing = CurTime()/(5000/(self:GetPos():Distance(self.Owner:GetPos())))
		local angpos = ( ( (self.Owner:GetPos())+Vector(0,0,50) ) - self:GetPos() ):Angle()
		local ang = ( ( (self.Owner:GetPos() + self:EyeAngles():Forward() * 5000 )+Vector(0,0,50) ) - self:GetPos() ):Angle()
		local dir = ang:Forward()
		local dirpos = angpos:Forward()
	 	self:SetAngles( angpos )
	 	self:GetPhysicsObject():SetVelocity(dir * (self.Tear.Velocity/2 ) )
	 end
end

function ENT:TearDamage(entity)
	if entity then
		if !self.Tear.Spectral and self.Tear.Piercing then 
			if entity:IsWorld() then 
				self:Destroy()
			end
		elseif self.Tear.Spectral and !self.Tear.Piercing then 
			if !entity:IsWorld() then 
				self:Destroy()
			end
		elseif !self.Tear.Spectral and !self.Tear.Piercing then 
			self:Destroy()
		end
	end

	if self.Tear.Bombs then
		self:TearExplode( 190, (self.Damage*5)+30)
	elseif self.Tear.Explosive then
		self:TearExplode( 140, self.Damage+40 )
	else
		if (entity and !self.DealtDamage) or (entity and self.Tear.Piercing) then
			local d = DamageInfo()
			d:SetDamage( self.Damage )
			d:SetAttacker( self.Owner )
			d:SetInflictor( self )
			d:SetDamageType( DMG_BULLET )
			entity:TakeDamageInfo( d )
			self.DealtDamage = true
			self:TearEffects(entity, false)
		end
	end
end

function ENT:TearExplode(range, dmg)
	local ED_Explosion = EffectData()
		ED_Explosion:SetOrigin( self:GetPos() )
		ED_Explosion:SetEntity( self )
		ED_Explosion:SetScale( 1 )
	util.Effect("Explosion", ED_Explosion)

	util.BlastDamage(self, self.Owner, self:GetPos(), range, dmg )
	local EntsInExp = ents.FindInSphere(self:GetPos(), range)
	self:TearEffects(EntsInExp, true)
end

function ENT:TearEffects(ents, group)
	ply = self.Owner
	if group then 
		for k, v in pairs(ents) do
			v.IsaacEffectActive = true
			if (v:IsPlayer() and v ~= self.Owner) or v:IsNPC() then
				self:TearEffects(v, false)
			end
		end
	else
		if self.Tear.Poison then
			self:TearEffectsSolo("Poison", ents, 15, 7)
		end
		if self.Tear.Fire then
			self:TearEffectsSolo("Ignite", ents, 5)
		end
		if self.Tear.Petrify then
			self:TearEffectsSolo("Petrify", ents, 5)
		end
		if self.Tear.Slow then
			self:TearEffectsSolo("Slow", ents, 5)
		end
	end
end

function ENT:TearEffectsSolo(effect, ent, ticks, dmg)
	if (ent:IsPlayer() and ent ~= self.Owner) or ent:IsNPC() then
		ent.IsaacEffectActive = true
		if ent:Health() < 1 then
			if ent:IsNPC() then
				ent:SetSchedule( 55 )
				ent:SetNPCState(7)
			end
			if ent:IsPlayer() and ent.IsaacTearPetrified then
				ent.IsaacTearPetrified = false
				ent:SetColor( Color( 255, 255, 255, 255 ) )
				ent:ScreenFade( SCREENFADE.IN, Color( 0, 125, 255, 125 ), 0.4, 0.2 )
				ent:Freeze( false )
			end
			if ent:IsPlayer() and ent.IsaacTearSlow then
				ent.IsaacTearSlow = false
				ent:SetLaggedMovementValue( 1 )
			end
			ent.IsaacEffectActive = false
		else
			if effect == "Poison" then
				for i = 1, ticks do 
					timer.Simple(i/2, function()
						if IsValid(ent) then
							if ent.IsaacEffectActive then
								local d = DamageInfo()
								d:SetDamage( dmg )
								d:SetAttacker( ply )
								d:SetInflictor( ply )
								d:SetDamageType( DMG_POISON )
								ent:TakeDamageInfo(d)
							end
						end
					end)
				end
			end

			if effect == "Ignite" then
				ent:Ignite(ticks,5)
			end

			if effect == "Slow" and !ent.IsaacTearSlow then
				ent.IsaacTearSlow = true
				if ent:IsPlayer() then
					ent:SetLaggedMovementValue( 0.5 ) 
				end
				timer.Simple( ticks, function()
					if ent:IsValid() and ent.IsaacEffectActive then
						ent.IsaacTearSlow = false
						if ent:IsPlayer() then
							ent:SetLaggedMovementValue( 1 ) 
						end
					end
				end )
			end

			if effect == "Petrify" and !ent.IsaacTearPetrified then
				ent.IsaacTearPetrified = true
				ent:SetColor( Color( 100, 100, 100, 255 ) )
				if ent:IsPlayer() then
					ent:ScreenFade( SCREENFADE.OUT, Color( 125, 125, 125, 125 ), 0.2, 2.5 )
					ent:Freeze( true ) 
				elseif ent:IsNPC() then
					ent:SetSchedule( SCHED_NPC_FREEZE )
				end

				timer.Simple( ticks, function()
					if ent:IsValid() and ent.IsaacEffectActive then
						ent.IsaacTearPetrified = false
						ent:SetColor( Color( 255, 255, 255, 255 ) )
						if ent:IsPlayer() then
							ent:ScreenFade( SCREENFADE.IN, Color( 125, 125, 125, 125 ), 0.4, 0.2 )
							ent:Freeze( false )
						elseif ent:IsNPC() then
							ent:SetCondition( 68 )
						end
					end
				end )
			end
		end
	end
end

function ENT:Destroy(quiet)
	if !quiet then
		local ED_Explosion = EffectData()
		ED_Explosion:SetOrigin( self:GetPos() )
		ED_Explosion:SetEntity( self )
		ED_Explosion:SetFlags( 0 )
		ED_Explosion:SetScale( self:GetModelScale()*5 )
		ED_Explosion:SetMagnitude( self:GetModelScale()*5 )
		if self.Tear.Eyeball then
			util.Effect("bloodimpact", ED_Explosion)
			self:EmitSound( Sound("physics/flesh/flesh_squishy_impact_hard"..math.random(1,4)..".wav"))
		elseif self.Tear.Tooth then
			util.Effect("isaac_tooth_pop", ED_Explosion)
			util.Effect("isaac_tooth_pop", ED_Explosion)
			util.Effect("isaac_tooth_pop", ED_Explosion)
			util.Effect("isaac_tooth_pop", ED_Explosion)
			self:EmitSound( Sound("physics/body/body_medium_break"..math.random(2,4)..".wav"))
		else
			util.Effect("watersplash", ED_Explosion)
			self:EmitSound( Sound("weapons/isaactears/generic/impact"..math.random(0,2)..".wav"))
		end
	end

	self:SetNoDraw(true)
		timer.Simple(0.001,
			function()
				if(self and self:IsValid()) then
					self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				end
			end
		)
		timer.Simple(0.002,
			function()
				if(self and self:IsValid()) then
					self:Remove()
				end
			end
		)
end