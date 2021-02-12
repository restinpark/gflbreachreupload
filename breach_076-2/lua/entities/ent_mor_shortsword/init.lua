AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()
	self:SetModel(self.Weapon.WorldModel)	//MAJICKZ
	self.Weapon = self.Weapon:GetClass()	//MORE MAJICKZ
	self:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	self.Lifetime = CurTime() + 20
	self.HitEnemy = false

	self.Entity:DrawShadow(false)

	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(2)
	end

	util.PrecacheSound("weapons/axe/morrowind_axe_hitwall1.wav")
	util.PrecacheSound("weapons/axe/morrowind_axe_hit.wav")

	self.Hit = {
	Sound("weapons/axe/morrowind_axe_hitwall1.wav")};

	self.FleshHit = {
	Sound("weapons/axe/morrowind_axe_hit.wav")}

	self.Entity:SetUseType(SIMPLE_USE)
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()
	if CurTime() > self.Lifetime then
		self:Remove()
	end
end

/*---------------------------------------------------------
   Name: ENT:Disable()
---------------------------------------------------------*/
function ENT:Disable()
	self.PhysicsCollide = function() end
	self.lifetime = CurTime() + 30
end

/*---------------------------------------------------------
   Name: ENT:PhysicsCollided()
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, phys)

	local Ent = data.HitEntity
	if !(IsValid(Ent) or Ent:IsWorld()) then return end

	if Ent:IsWorld() then
		util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)

		if self.Entity:GetVelocity():Length() > 400 then
			self:EmitSound("npc/roller/blade_out.wav", 60)
			self:SetPos(data.HitPos - data.HitNormal * 10)
			self:SetAngles(data.HitNormal:Angle() + Angle(40,self:GetAngles().y,0))
			self:GetPhysicsObject():EnableMotion(false)
		else
			self:EmitSound(self.Hit[math.random(1, #self.Hit)])
		end
		self:Disable()
	elseif Ent.Health and self.HitEnemy == false then	// Only deal damage once.
		if not(Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then
			util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
			self:EmitSound(self.Hit[math.random(1, #self.Hit)])
			self.HitEnemy = true
		end

		local boink = ents.Create(self.Weapon)
		if IsValid(Ent) and Ent:IsPlayer() and ( Ent:Team() != TEAM_SPEC) then
			
			Ent:TakeDamage(50, self:GetOwner(), self:GetOwner())	// If you have a killicon for the axe, this makes it appear.
			--Added code here for achievement.
			hook.Run("SCP076SwordHitPlayer", self:GetOwner(), Ent)
		end
		boink:Remove()

		if (Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then
			local effectdata = EffectData()
			effectdata:SetStart(data.HitPos)
			effectdata:SetOrigin(data.HitPos)
			effectdata:SetScale(1)
			util.Effect("BloodImpact", effectdata)

			self:EmitSound(self.FleshHit[math.random(1,#self.Hit)])
			self.HitEnemy = true
		end
	end
	local sent = self.Entity
	
	local ply = self:GetOwner()
	local function givewep()
		if IsValid(sent) then
			sent:Remove()
		end
		if ply:IsPlayer() and not ply.GetNClass then
			player_manager.RunClass(ply, "SetupDataTables")
		end
  end
  timer.Create("KnifeThrow"..math.random(1, 348243), 3.5, 1, givewep)

  self.Entity:SetOwner(nil)

end

/*---------------------------------------------------------
   Name: ENT:Use()
---------------------------------------------------------*/
function ENT:Use(activator, caller)

end
