SWEP.PrintName = "SCP-334"
SWEP.Instructions = "Attack targets with your attack1 button."
SWEP.Primary.Automatic = false
SWEP.Primary.Clip = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.AmmoType = "none"
SWEP.Secondary = SWEP.Primary
SWEP.droppable = false

function SWEP:Initialize()
    self:SetHoldType("melee")
    if SERVER then
        self:SetNWInt("scp334_kills", 0)
    end
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawWorldModel() end

function SWEP:Reload() end

function SWEP:Deploy()
    timer.Simple(0, function ()
        if self.Owner and IsValid(self.Owner) then
        self.Owner:DrawViewModel(false)
        end
    end)
end

SWEP.NextAttackH = 0
SWEP.AttackDelay1 = 0.34

function SWEP:PrimaryAttack()
	if self.NextAttackH > CurTime() then return end
	self.NextAttackH = CurTime() + self.AttackDelay1
	if SERVER then
		local ent = nil
		local tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 170 ),
			filter = self.Owner,
			mins = Vector( -20, -20, -20 ),
			maxs = Vector( 20, 20, 20 ),
			mask = MASK_SHOT_HULL
		} )
		ent = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				--roundstats.imkills = roundstats.imkills + 1
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
                ent:TakeDamage(25, self.Owner, self.Owner)
				
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(25, 100), self.Owner, self.Owner )
				end
			end
		end
	end
end


timer.Create("BreachCore.FindEntitiesNear334", 0.2, 0, function ()
    if SERVER then
    for k,v in pairs(player.GetAll()) do
        if v:GetNClass() == ROLE_SCP334 then
            local es = ents.FindInSphere(v:GetPos(), 100)
            for _,x in pairs(es) do
                if x:IsPlayer() and x:Team() != TEAM_SCP and x:Team() != TEAM_SPEC then
				if x:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
                    if x.UsingArmor and x.UsingArmor == "armor_fireproof" then
                        x:TakeDamage(math.random(0, 1), v, v)
                    else
                        x:TakeDamage(math.random(1, 2), v, v)
                    end
                end
            end
        end
    end
    end
end)


hook.Add("DoPlayerDeath", "EntityTakeDamage_SCP334", function (target, attacker)
    if target and IsValid(target) and target:IsPlayer() and target:Team() != TEAM_SPEC and target:Team() != TEAM_SCP and attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:GetNClass() == ROLE_SCP334 then
        attacker:SetHealth(math.Clamp(attacker:Health() + 150, 0, attacker:GetMaxHealth() * 1.5))
        attacker:SetRunSpeed(math.Clamp(attacker:GetRunSpeed() + 12, 0, 300))
        attacker:SetWalkSpeed(attacker:GetRunSpeed())
        attacker:SetMaxSpeed(attacker:GetRunSpeed())
    end
end)