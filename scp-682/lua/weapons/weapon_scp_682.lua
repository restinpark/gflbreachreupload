AddCSLuaFile()
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/scp_682_wep")
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-682"
SWEP.Author = "Aurora"
SWEP.Category = "Aurora's SWEPs"
SWEP.Instructions = "Primary to attack, Secondary for an speed burst."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = ""
SWEP.WorldModel = ""
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
SWEP.Purpose = "Murder"
SWEP.NextAttackH = 2
SWEP.NextAttackW = 30
SWEP.NextLunge = 30
SWEP.NextArmor = 0
SWEP.ArmorDelay = 45
SWEP.AttackDelay1 = 0.5
SWEP.AttackDelay2 = 25
SWEP.IsFaster = false
SWEP.BoostEnd = 0
SWEP.OrigWalk = 200
SWEP.OrigRun = 300
SWEP.OrigMax = 400
SWEP.OrigJump = 200
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
	if self.NextArmor > CurTime() then return end
	self.NextArmor = CurTime() + self.ArmorDelay
	if SERVER then
		local ply = self.Owner
			ply:GodEnable()
			ply:EmitSound("physics/metal/metal_solid_strain1.wav", 100, 30)
		local function RemoveArmor()
			ply:GodDisable()
		end
	timer.Create("SCP_PLAYER_WILL_LOSE_ARMOR" .. ply:SteamID(), 10, 1, RemoveArmor)
end
end
function SWEP:PrimaryAttack()
	if self.NextAttackH > CurTime() then return end
	self.NextAttackH = CurTime() + self.AttackDelay1
	self.Owner:SetAnimation(PLAYER_ATTACK1)
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
				roundstats.repkill = roundstats.repkill + 1
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				ent:TakeDamage( 1500, self.Owner, self.Owner )
				self.Owner:SetHealth(self.Owner:Health() + 50)
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

function SWEP:SecondaryAttack()
	if self.NextAttackW > CurTime() then return
	end
	self.NextAttackW = CurTime() + self.AttackDelay2
	local ply = self.Owner

	ply:SetWalkSpeed(325)
	ply:SetRunSpeed(325)
	ply:SetMaxSpeed(325)
	ply:SetJumpPower(300)
	ply:EmitSound("roar.ogg", 100, 100)
	local function RemoveBuff()

		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(100)
		ply:SetMaxSpeed(100)
		ply:SetJumpPower(200)
	end
	timer.Create("SCP_PLAYER_WILL_LOSE_BUFF" .. ply:SteamID(), 5, 1, RemoveBuff)
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Rage is ready!"
	local showcolor = Color(0,255,0)

	if self.NextAttackW > CurTime() then
		showtext = "Bloodlust returning " .. math.Round(self.NextAttackW - CurTime())
		showcolor = Color(255,0,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 30 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	
if disablehud == true then return end

	local showtext2 = "Armor is ready!"
	local showcolor2 = Color(0,255,0)

	if self.NextArmor > CurTime() then
		showtext2 = "Regenerating new armor plating " .. math.Round(self.NextArmor - CurTime())
		showcolor2 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext2,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = showcolor2,
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
