AddCSLuaFile()

ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true
ENT.PrintName = "SCP-682 Hazard"
ENT.Spawnable = false
ENT.Author = "Ralsei"

function ENT:Initialize()
    self:SetModel(Model("models/hunter/blocks/cube2x2x2.mdl"))
    self:PhysicsInit(SOLID_BBOX)
    self:SetCollisionBounds(Vector(-30, -30, -100), Vector(30, 30, 100))
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
			particle:SetVelocity(Vector(math.random(-30, 30), math.random(-30, 30), math.random(0, 100)))
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

if CLIENT then
    hook.Add("Think", "ThinkSCP681", function ()
    --for _,v in pairs(ents.FindByClass("ent_681_hazard")) do
      --  local part = EffectData()
        --part:SetEntity( v )
        --part:SetOrigin(v:GetPos())
        --part:SetStart(v:GetPos())
        --util.Effect( "scp681_gas", part)
    --end
end)
end

function ENT:DrawModel() end

print("scp681 rev 3 loads")