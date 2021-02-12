AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel("models/Gibs/HGIBS.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetColor(Color(255,255,255,0))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetGravity(0)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)

	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )

	if SERVER then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
			phys:EnableGravity(false)
		end
	end

	-- failsafe
	timer.Simple(120,function()
		if IsValid(self) then
			self:Remove()
		end
	end)

	self.scale = 25
	self.range = 512
	self.force = 500
	self.dmglow = 2
	self.dmghigh = 5
	self.PumpSound = "ambient/water/water_splash3.wav"
	self.PumpFX = "fx_poke_bubblepop"
	self.PumpBeam = "fx_poke_hydropump"
end

function ENT:SetStats(dmglow,dmghigh,scale,range,force)
	self.dmglow = dmglow
	self.dmghigh = dmghigh
	self.scale = scale
	self.range = range
	self.force = force
end


function ENT:Pump()
	local owner = self:GetOwner()
	self:SetPos((owner:GetPos()+Vector(0,0,32))+(owner:GetAimVector()*75))
	self:SetAngles(owner:GetAimVector():Angle())

	local tr = util.TraceHull({
		start = self:GetPos(),
		endpos = self:GetPos()+self:GetForward()*self.range,
		mins = Vector( -16, -16, 16 ),
		maxs = Vector( 16, 16, 16 ),
		filter = self
	})

	local fx = EffectData()
	fx:SetOrigin(self:GetPos())
	fx:SetAngles(self:GetAngles())
	fx:SetScale(self.scale)
	fx:SetRadius(self.range)
	util.Effect(self.PumpBeam,fx)

	self:EmitSound(self.PumpSound)

	if tr.Hit then
		for _, v in ipairs(ents.FindInSphere(tr.HitPos,self.scale)) do
			if v != self:GetOwner() then
				local dmginfo = DamageInfo()
				dmginfo:SetAttacker(self:GetOwner())
				dmginfo:SetInflictor(self)
				dmginfo:SetDamage(math.random(self.dmglow,self.dmghigh))
				v:TakeDamageInfo(dmginfo)
				local diff = (self:GetPos()-v:GetPos())+Vector(0,0,-32)
				v:SetVelocity(Vector(0,0,self.force/2))
				v:SetVelocity(-diff*2)
			end
		end
		local fx = EffectData()
		fx:SetOrigin(tr.HitPos)
		fx:SetScale(self.scale*2)
		util.Effect(self.PumpFX,fx)
	end
end

function ENT:Think()
	local owner = self:GetOwner()
	if IsValid(owner) then
		self:Pump()
	else
		self:Remove()
	end
	self:NextThink(CurTime()+0.1)
	return true
end

function ENT:OnRemove()

end