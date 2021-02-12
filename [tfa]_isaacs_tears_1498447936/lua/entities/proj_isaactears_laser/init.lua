AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:TearStartup()
	self:GetWeaponStats()

	self.IsaacLaserLine = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetAngles():Forward() * 400000000,  
		filter = self.Owner, 
	})

	self:TearRender()

	self:TearCollision()

	self:SetHealth(10)

	self:Activate()

	local e = self.Entity

	local ang = self:GetOwner():EyeAngles()
	local dir = ang:Forward()

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
end


function ENT:TearRender()
	self.Mins = Vector(-1, -1, 0)
	self.Maxs = Vector(1, 1, 1)

	self:SetModel( "models/hunter/misc/sphere075x075.mdl" )
	self:SetAngles( self.Owner:EyeAngles()+Angle(180,0,0) )
	self:SetModelScale( 0, 0.05 )

	self.ColorTable["a"] = 1

	self:SetColor( self.ColorTable )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )

	if !self.FakeTear then
		self:EmitSound( Sound("weapons/isaactears/laser/flash"..math.random(0,2)..".wav"))
		if self.IsaacLaserLine.HitPos then
			local ED_Explosion = EffectData()
			ED_Explosion:SetOrigin( self.IsaacLaserLine.HitPos )
			ED_Explosion:SetEntity( self )
			ED_Explosion:SetScale( 10 )
			util.Effect("cball_explode",ED_Explosion)
		end
	end
end

function ENT:TearCollision()
	self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
end

function ENT:MultiTear( tearnum, bump )
	self:Destroy(true)
	for i = 1, tearnum-1 do
		local ang = self:GetOwner():EyeAngles()
		local dir = ang:Forward()

		local new_multitear = ents.Create( "proj_isaactears_laser" )
		new_multitear.OriginalTear = self
		new_multitear.FakeTear = true
		new_multitear:SetOwner(self.Owner)
			
		local newpos = ( ((self.Tear.Spread/4)/tearnum) * (i-tearnum/2) )

		if bump then
			local bumppos = ( (((self.Tear.Spread/4))/tearnum) * -math.abs((i-tearnum/2))/3 )			
			new_multitear:SetPos( self:LocalToWorld(Vector(bumppos, newpos, 0) ) )
		else
			new_multitear:SetPos( self:LocalToWorld(Vector(0, newpos, 0) ) )
		end

		new_multitear:Spawn()
		new_multitear:SetOwner(self.Owner)
	end
end

function ENT:Think()
	self.IsaacTraceLine = ents.FindAlongRay(self:GetPos(), self:GetPos() + -self:GetAngles():Forward() * 400000000,  self.Mins, self.Maxs )
	if self.IsaacTraceLine then
		for k, v in pairs(self.IsaacTraceLine) do
			if v:IsNPC() or (v:IsPlayer() and v ~= self.Owner) then
				self:TearDamage(v)
				self:TearEffects(v, false)
			end
		end
	end
	self:Destroy(true)
end

function ENT:TearDamage(entity)
	if entity then
		local d = DamageInfo()
		d:SetDamage( self.Damage )
		d:SetDamageType( DMG_ENERGYBEAM )
		d:SetAttacker( self.Owner )
		d:SetInflictor( self )
		entity:TakeDamageInfo( d )
		self:TearEffects(entity, false)
	end
end

function ENT:TearExplode(range, dmg)
	local ED_Explosion = EffectData()
		ED_Explosion:SetOrigin( self.IsaacLaserLine.HitPos )
		ED_Explosion:SetEntity( self )
		ED_Explosion:SetScale( 1 )
	util.Effect("Explosion", ED_Explosion)

	util.BlastDamage(self, self.Owner, self.IsaacLaserLine.HitPos, range, dmg )
end

function ENT:Destroy(quiet)
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