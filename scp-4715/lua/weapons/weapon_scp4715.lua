SWEP.PrintName = "SCP-4715"
SWEP.Instructions = "Attack targets with your LMB, regenerate at the cost of power with RMB. Reload to break glass and gates"
SWEP.Primary.Automatic = false
SWEP.Primary.Clip = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.AmmoType = "none"
SWEP.droppable = false

function SWEP:Initialize()
    self:SetHoldType("normal")
    if SERVER then
        self:SetNWInt("scp4715_kills", 0)
    end
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawWorldModel() end

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
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				if self.Owner:GetWalkSpeed() == 255 then
                ent:TakeDamage(80, self.Owner, self.Owner)
			elseif self.Owner:GetWalkSpeed() < 255 and self.Owner:GetWalkSpeed() > 200 then
				ent:TakeDamage(60, self.Owner, self.Owner)
			elseif self.Owner:GetWalkSpeed() < 200 and self.Owner:GetWalkSpeed() > 150 then
				ent:TakeDamage(40, self.Owner, self.Owner)
			elseif self.Owner:GetWalkSpeed() < 150 and self.Owner:GetWalkSpeed() > 100 then
				ent:TakeDamage(30, self.Owner, self.Owner)
			elseif self.Owner:GetWalkSpeed() == 100 then
				ent:TakeDamage(20, self.Owner, self.Owner)
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
			end

function SWEP:SecondaryAttack()
	if self.Owner:GetWalkSpeed() < 255 then return end
		self.Owner:SetRunSpeed(100)
		self.Owner:SetWalkSpeed(100)
		self.Owner:SetMaxSpeed(100)
		self.Owner:SetHealth(self.Owner:Health() + 300)
		self.Owner:EmitSound("npc/zombie_poison/pz_pain1.wav", 35, 40)
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext1 = "Threshold at 0%!"
	local showcolor1 = Color(255,0,0)
	if self.Owner:GetWalkSpeed() >= 120 then
		showtext1 = "Threshold at 40%! "
		showcolor1 = Color(0,0,255)
	end
	if self.Owner:GetWalkSpeed() >= 150 then
		showtext1 = "Threshold at 60%! "
		showcolor1 = Color(0,0,255)
	end
	if self.Owner:GetWalkSpeed() >= 200 then
		showtext1 = "Threshold at 80%! "
		showcolor1 = Color(0,0,255)
	end
	if self.Owner:GetWalkSpeed() == 255 then
		showtext1 = "Threshold at 100%! "
		showcolor1 = Color(0,255,0)
	end

	draw.Text( {
		text = showtext1,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor1,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( 0, 255, 0, 255 )

	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
	
	
end
