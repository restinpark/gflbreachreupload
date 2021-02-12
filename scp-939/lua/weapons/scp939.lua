AddCSLuaFile()
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/scp_939_wep")
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-939"
SWEP.Author = "Aurora/chan_man1"
SWEP.Category = "Aurora's SWEPs"
SWEP.Instructions = "Primary to attack."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.droppable = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.UseHands = false
SWEP.Contact = "uhh"
SWEP.Purpose = "Hunt"
SWEP.NextAttackH = 2
SWEP.NextAttackW = 30
SWEP.NextLunge = 30
SWEP.AttackDelay1 = 0.5
SWEP.AttackDelay2 = 25
SWEP.IsFaster = false
SWEP.BoostEnd = 0
SWEP.OrigWalk = 200
SWEP.OrigRun = 300
SWEP.OrigMax = 400
SWEP.OrigJump = 200
SWEP.NextPrep = 0
SWEP.PrepDelay = 15
function SWEP:Deploy()
	--self.OrigWalk = self.Owner:GetWalkSpeed()
	--self.OrigRun = self.Owner:GetRunSpeed()
	--self.OrigMax = self.Owner:GetMaxSpeed()
	--self.OrigJump = self.Owner:GetJumpPower()
	self.Owner:DrawViewModel( false )
	--self.Owner:SetWalkSpeed(60)
	--self.Owner:SetRunSpeed(60)
	--self.Owner:SetMaxSpeed(60)
	--self.Owner:SetJumpPower(200)
	--self.Owner:SetViewOffset(Vector(0,0,30))
end
function SWEP:Holster()
	--self.Owner:SetWalkSpeed(self.OrigWalk)
	--self.Owner:SetRunSpeed(self.OrigRun)
	--self.Owner:SetMaxSpeed(self.OrigMax)
	--self.Owner:SetJumpPower(self.OrigJump)
	--self.Owner:SetViewOffset(Vector(0,0,60))
	return true
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end
function SWEP:Think()

end

function SWEP:Reload()
end
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
		hitEnt = tr.Entity
		if IsValid(ent) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				--roundstats.imkills = roundstats.imkills + 1
				 attack_angle = self.Owner:GetAimVector():Angle().yaw - hitEnt:GetAimVector():Angle().yaw
         if math.abs(attack_angle) < 90 or (math.abs(attack_angle) > 270) then
            ent:TakeDamage( 100, self.Owner, self.Owner )
			end
				ent:TakeDamage( 25, self.Owner, self.Owner )
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
SWEP.NextAttackX = 0
function SWEP:SecondaryAttack()
if self.NextPrep > CurTime() then return
	end
	self.NextPrep = CurTime() + self.PrepDelay
	local ply = self.Owner

	ply:SetWalkSpeed(300)
	ply:SetRunSpeed(300)
	ply:SetMaxSpeed(300)
	ply:SetJumpPower(300)
	local function RemoveBuff()

		ply:SetWalkSpeed(200)
		ply:SetRunSpeed(200)
		ply:SetMaxSpeed(200)
		ply:SetJumpPower(200)
	end
	timer.Create("SCP939_PLAYER_WILL_LOSE_BUFF" .. ply:SteamID(), 2, 1, RemoveBuff)
end


function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext2 = "Ready to attack!"
	local showcolor2 = Color(0,255,0)

	if self.NextPrep > CurTime() then
		showtext2 = "Preparing to attack " .. math.Round(self.NextPrep - CurTime())
		showcolor2 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor2,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( 0,0, 0, 255 )

	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
end

