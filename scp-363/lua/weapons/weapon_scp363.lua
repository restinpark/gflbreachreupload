--SCP-378 SWEP by Ralsei, based on the concept by Doomnack

--Libraries I want

local now = CurTime

SWEP.PrintName = "SCP-378"
SWEP.Author = "Ralsei"
SWEP.Instructions = "Primary attack to bite. Use Reload to Break Glass or Gates."

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipSize = -1
SWEP.droppable = false
SWEP.Secondary = SWEP.Primary

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:DrawWorldModel()

end

function SWEP:Deploy()
    timer.Simple(0, function ()
        if self and IsValid(self) and self.Owner and IsValid(self.Owner) then
            self.Owner:DrawViewModel(false)
        end
    end)
end


SWEP.NextPrimary = 0

function SWEP:PrimaryAttack()
    if self.NextPrimary > now() then return end
    if not IsFirstTimePredicted() then return end
    self.NextPrimary = now() + 0.2
    if SERVER then
        local tr = util.TraceHull( {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 ),
        filter = self.Owner,
        mins = Vector( -10, -10, -10 ),
        maxs = Vector( 10, 10, 10 ),
        mask = MASK_SHOT_HULL
    } )
    local e = tr.Entity
        if e and IsValid(e) and e:IsPlayer() and e:Team() != TEAM_SCP and e:Team() != TEAM_SPEC then
		if e:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
            e:TakeDamage(15, self.Owner, self)
        elseif e and IsValid(e) then
            if self.Owner and IsValid(self.Owner) then
                if self.Owner:GetClass() == "func_breakable" then
                    e:TakeDamage(200, self.Owner, self)
                elseif BREACH_IsGateDoor and BREACH_IsGateDoor(e) then
                    e:TakeDamage(math.random(20, 100), self.Owner, self)
                end
            end
        end
    end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload()
if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
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
					ent:TakeDamage( 300, self.Owner, self.Owner )
				end
			elseif SERVER and BREACH_IsGateDoor(ent) then
				ent:TakeDamage( math.random(150, 200), self.Owner, self.Owner )
			end
		end
end