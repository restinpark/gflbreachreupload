AddCSLuaFile()

ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true
ENT.PrintName = "SCP-079 Hazard"
ENT.Spawnable = false
ENT.Author = "Aurora"

function ENT:Initialize()
    self:SetModel(Model("models/hunter/blocks/cube2x2x2.mdl"))
    self:PhysicsInit(SOLID_BBOX)
    self:SetCollisionBounds(Vector(-120, -120, -200), Vector(120, 120, 200))
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    if self.SetNoDraw then
        self:SetNoDraw(true)
    end
    if SERVER then
        self:S_INIT()
    end
    if CLIENT then
        local emitter = ParticleEmitter( self:GetPos() )
	
        for i=1, 10 do
		local particle = emitter:Add( "particles/smokey", self:GetPos() + Vector( math.random(0,0),math.random(0,0),math.random(0,0) ) ) 
		 
		if particle == nil then particle = emitter:Add( "particles/smokey", self:GetPos() + Vector(   math.random(0,0),math.random(0,0),math.random(0,0) ) ) end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-120, 120), math.random(-120, 120), math.random(-200, 200)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(45) 
			particle:SetStartAlpha(150)
			particle:SetEndAlpha(0)
			particle:SetStartSize(20) 
			particle:SetEndSize(40)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle(0,0,0) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
            local shade = math.random(160, 200)
			particle:SetColor(shade, shade, shade)
			particle:SetGravity( Vector(0,0,0) ) 
			particle:SetAirResistance(100 )  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
    end
	emitter:Finish()
    end
end

function ENT:DrawModel() end