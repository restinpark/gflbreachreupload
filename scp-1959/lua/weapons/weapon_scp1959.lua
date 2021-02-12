AddCSLuaFile()
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/scp_1959_wep")
	SWEP.BounceWeaponIcon = false
end
SWEP.PrintName = "SCP-1959" -- The name of the weapon
SWEP.Author = "chan_man1"
SWEP.Contact = "oh boy"
SWEP.Purpose = "Radiate and Control Gravity"
SWEP.Instructions = "Primary for Attack and Secondary for Gravity Lift"
SWEP.Category = "SCP"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ISSCP1959 = true
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
SWEP.NextAttack1 = 0
SWEP.GravThrow = 0
SWEP.AttackDelay1 = 0
SWEP.GravThrowDelay = 10
SWEP.IsFaster = false
SWEP.BoostEnd = 0
SWEP.OrigWalk = 200
SWEP.OrigRun = 300
SWEP.OrigMax = 400
SWEP.OrigJump = 200
function SWEP:Deploy()
	self.OrigWalk = self.Owner:GetWalkSpeed()
	self.OrigRun = self.Owner:GetRunSpeed()
	self.OrigMax = self.Owner:GetMaxSpeed()
	self.OrigJump = self.Owner:GetJumpPower()
	self.Owner:DrawViewModel( false )
	self.Owner:SetWalkSpeed(180)
	self.Owner:SetRunSpeed(180)
	self.Owner:SetMaxSpeed(180)
	self.Owner:SetJumpPower(400)
	self.Owner:SetViewOffset(Vector(0,0,60))
	self.Owner:SetJumpPower(400)
end
function SWEP:Holster()
	self.Owner:SetWalkSpeed(self.OrigWalk)
	self.Owner:SetRunSpeed(self.OrigRun)
	self.Owner:SetMaxSpeed(self.OrigMax)
	self.Owner:SetJumpPower(self.OrigJump)
	self.Owner:SetJumpPower(200)
	self.Owner:SetViewOffset(Vector(0,0,60))
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

function SWEP:SecondaryAttack()
	if self.GravThrow > CurTime() then return end
	self.GravThrow = CurTime() + self.GravThrowDelay
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(),800)) do
	if v:IsPlayer() then
	local
self = v:GetActiveWeapon()if
self&&self.ISSCP1959
then
continue
end
v:SetVelocity(Vector(0,0,650))
end
end
end
end
function SWEP:PrimaryAttack()
	if self.NextAttack1 > CurTime() then return end
	self.NextAttack1 = CurTime() + self.AttackDelay1
	if SERVER then
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
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				ent:TakeDamage(15)

			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 120, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(100, 500), self.Owner, self.Owner )
				end
			end
		end
	end
end
function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Gravity Throw Ready"
	local showcolor = Color(0,255,0)

	if self.GravThrow > CurTime() then
		showtext = "Next throw in " .. math.Round(self.GravThrow - CurTime())
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
function SWEP:Think()
if SERVER then
self.Owner:TakeDamage()
for k, v in pairs(ents.FindInSphere(self:GetPos(),400)) do
if v:IsPlayer() then
    if v:Team() != TEAM_SCP and v:Team() != TEAM_SPEC and self.Owner and IsValid(self.Owner) then
	if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
local
self = v:GetActiveWeapon()if
self&&self.ISSCP1959
then
continue
end
v:TakeDamage(0.4) end
end
end
end
end