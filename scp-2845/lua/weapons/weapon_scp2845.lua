SWEP.PrintName = "SCP-2845"
SWEP.Author = "Aurora"
SWEP.Instructions = "Point at the ground to turn nearby people into Hydrogen."

function SWEP:Initialize()
	self:SetHoldType("melee")
end
function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end
function SWEP:DrawWorldModel()
end
SWEP.Spawnable = true
SWEP.NextAttack = 0
SWEP.droppable = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Secondary = SWEP.Primary

timer.Create("SCP2845_Timer", 1.75, 0, function ()
	if SERVER then
	for x,y in pairs(player.GetAll()) do
		if y:GetNClass() == ROLE_SCP2845 then
			local e2 = ents.FindInSphere(y:GetPos(), 200)
			for k,v in pairs(player.GetAll()) do
				if not table.HasValue(e2, v) then
					v.WasInSphereLastTime = false
				end
			end
			for k,v in pairs(e2) do
				if v and IsValid(v) and v:IsPlayer() and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP and v.WasInSphereLastTime then
				if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
					local p = v:GetPos()
                	local d = DamageInfo()
                	d:SetDamage(4000)
                	d:SetDamageType(DMG_DISSOLVE)
                	d:SetAttacker(y)
                	v:TakeDamageInfo(d)
                	local e = ents.Create("prop_physics")
                	e:SetPos(p)
                	e:SetModel("models/Mechanics/roboticslarge/a1.mdl")
                	e:SetMaterial("mechanics/metal2", true)
				end
				v.WasInSphereLastTime = true
			end
		end
	end
	end
end)

function SWEP:PrimaryAttack()
	if self.NextAttack > CurTime() then return end
	self.NextAttack = CurTime() + 5
	if SERVER then
		local t = util.GetPlayerTrace(self.Owner)
		t.mask = MASK_SOLID_BRUSHONLY
		local trace = util.TraceLine( t )
		local hp
		if trace.Hit then
			hp = trace.HitPos
			local ent = ents.Create("ent_scp2845_aoe")
			ent.HitPos = hp
			ent:SetPos(hp)
			ent:Spawn()
			ent.Owner = self.Owner
			ent:SSetMiddleAndStart(hp)
			net.Start("DoHSplashAnim")
			net.WriteVector(hp)
			net.Broadcast()
			--self.Owner:EmitSound("scp2845/grunt.ogg")
		else
			self.NextAttack = 0
			return
		end
	end
end

function SWEP:SecondaryAttack()
	//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if(ent:GetPos():Distance(self.Owner:GetPos()) < 125) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				ent:TakeDamage(5, self.Owner, self.Owner)
				//ent:SetSCP0492()
				//roundstats.zombies = roundstats.zombies + 1
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 1000, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(25, 100), self.Owner, self.Owner )
				end
			end
		end
	end
end
