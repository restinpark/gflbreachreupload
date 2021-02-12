AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:TearStartup()
	self:GetWeaponStats()

	self.IsaacLaserLine = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + -self:GetAngles():Forward() * -self.Laser.Distance,  
		filter = self.Owner, 
	})

	self:TearRender()

	self:TearCollision()

	self:SetHealth(10)

	self:Activate()

	local e = self.Entity

	local ang = self:GetOwner():EyeAngles()
	local dir = ang:Forward()

	timer.Simple(self.Laser.Timer,
		function()
			if(e and e:IsValid()) then
				self:Destroy()	
				if self.Owner then
					self.Owner:Freeze( false )
				end		
			end
		end
	)

	self.HomingRange = true
	self.DealtDamage = false

	if self.TearsShot > 1 and !self.FakeTear then
		self:MultiTear(self.TearsShot, true)
	end

	if self.Tear.Bombs then
		self:TearExplode( 190, (self.Damage*5)+30)
	elseif self.Tear.Explosive then
		self:TearExplode( 140, self.Damage+40 )
	end

	self.Owner:Freeze( true )
end


function ENT:TearRender()
	self.Mins = Vector(-50, -50, 0)
	self.Maxs = Vector(50, 50, 50)

	self:SetModel( "models/isaactears/brimstone.mdl" )
	self:SetAngles( self.Owner:EyeAngles()+Angle(180,0,0) )
	self:SetPos( self:LocalToWorld(Vector(-50, 0, 0) ) )

	self.ColorTable["a"] = 220

	if !self.FakeTear then
		local ED_Explosion = EffectData()
		ED_Explosion:SetOrigin( self:GetPos() )
		ED_Explosion:SetEntity( self )
		ED_Explosion:SetScale( 10 )
		ED_Explosion:SetMagnitude( self.Laser.Timer )
		util.Effect("isaac_brimstone_gore",ED_Explosion)
		ED_Explosion:SetOrigin( self:GetPos() + -self:GetAngles():Forward() * self.Laser.Distance )
		util.Effect("isaac_brimstone_gore",ED_Explosion)
		self:EmitSound( Sound("weapons/isaactears/brimstone/idle.wav"))
	end

	if !self.FakeTear then
		if self.IsaacLaserLine.Hit and self.IsaacLaserLine.Entity:IsWorld() then
			local ED_Explosion = EffectData()
			ED_Explosion:SetOrigin( self.IsaacLaserLine.HitPos )
			ED_Explosion:SetEntity( self )
			ED_Explosion:SetScale( 10 )
			ED_Explosion:SetMagnitude( self.Laser.Timer )
			util.Effect("isaac_brimstone_gore",ED_Explosion)
		end
	end

	self:SetColor( self.ColorTable )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
end

function ENT:TearCollision()
	self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
end

function ENT:MultiTear( tearnum, bump )
	self:Destroy(true)
	for i = 1, tearnum-1 do
		local ang = self:GetOwner():EyeAngles()
		local dir = ang:Forward()

		local new_multitear = ents.Create( "proj_isaactears_brimstone" )
		new_multitear.OriginalTear = self
		new_multitear.FakeTear = true
		new_multitear:SetOwner(self.Owner)
			
		local newpos = ( ((self.Tear.Spread*0)/tearnum) * (i-tearnum/2) )

		if bump then
			local bumppos = ( (((self.Tear.Spread*0))/tearnum) * -math.abs((i-tearnum/2))/3 )			
			new_multitear:SetPos( self:LocalToWorld(Vector(bumppos, newpos, 0) ) )
		else
			new_multitear:SetPos( self:LocalToWorld(Vector(0, newpos, 0) ) )
		end
		new_multitear:Spawn()

		new_multitear:SetOwner(self.Owner)			
	end
end

function ENT:Think()
	self.IsaacTraceLine = ents.FindAlongRay(self:GetPos(), self:GetPos() + -self:GetAngles():Forward() * self.Laser.Distance,  self.Mins, self.Maxs )
	if self.IsaacTraceLine then
		for k, v in pairs(self.IsaacTraceLine) do
			if v:IsNPC() or (v:IsPlayer() and v ~= self.Owner) then
				v.SpawnParticlesDone = v.SpawnParticlesDone or false
				self:TearDamage(v)
				self:TearEffects(v, false)
				if !v.SpawnParticlesDone then
					v.SpawnParticlesDone = true
					if !self.FakeTear then
						local ED_Explosion = EffectData()
						ED_Explosion:SetOrigin( v:EyePos() )
						ED_Explosion:SetEntity( self )
						ED_Explosion:SetScale( 10 )
						ED_Explosion:SetMagnitude( self.Laser.Timer )
						util.Effect("isaac_brimstone_gore",ED_Explosion)
					end
				end
			end
		end
	end
end

function ENT:TearDamage(entity)
	if entity then
		local d = DamageInfo()
		d:SetDamage( self.Damage*self.Laser.DamageMult )
		d:SetDamageType( DMG_ENERGYBEAM )
		d:SetAttacker( self.Owner )
		d:SetInflictor( self )
		entity:TakeDamageInfo( d )
		self:TearEffects(entity, false)
	end
end

function ENT:TearExplode(range, dmg)
	local ED_Explosion = EffectData()
		ED_Explosion:SetEntity( self )
		ED_Explosion:SetScale( 1 )
	if !self.FakeTear then
		ED_Explosion:SetOrigin( self.IsaacLaserLine.HitPos )
		util.BlastDamage(self, self.Owner, self.IsaacLaserLine.HitPos, range, dmg )
	else
		ED_Explosion:SetOrigin( self.OriginalTear.IsaacLaserLine.HitPos )
		util.BlastDamage(self, self.Owner, self.OriginalTear.IsaacLaserLine.HitPos, range, dmg )
	end
	util.Effect("Explosion", ED_Explosion)
end

function ENT:Destroy(quiet)
	if !quiet then
		local ED_Explosion = EffectData()
		ED_Explosion:SetOrigin( self:GetPos() )
		ED_Explosion:SetEntity( self )
		ED_Explosion:SetMagnitude(0)
		ED_Explosion:SetScale( 20 )
		ED_Explosion:SetRadius(0)	
		util.Effect("watersplash", ED_Explosion)
	end

	self:SetNoDraw(true)
		local e = self.Entity
		timer.Simple(0.001,
			function()
				if(e and e:IsValid()) then
					e:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				end
			end
		)
		timer.Simple(0.002,
			function()
				if(e and e:IsValid()) then
					e:Remove()
				end
			end
		)
end