AddCSLuaFile()
if SERVER then
	util.AddNetworkString("173BlindAttackRequest")
	net.Receive("173BlindAttackRequest", function (l, ply)
		if ply.GetNClass and ply:GetNClass() == ROLE_SCP173 and ply:HasWeapon("weapon_scp_173") and ply:IsFlagSet(FL_FROZEN) then
			local w = ply:GetWeapon("weapon_scp_173")
			if IsValid(w) then
				w:SecondaryAttack()
			end
		end
	end)
end
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_173")
	SWEP.BounceWeaponIcon = false
	hook.Add("PlayerBindPress", "PlayerBindPress_173", function (p, b, pressed)
		if pressed and string.find(b, "+attack2") and LocalPlayer().GetNClass and LocalPlayer():GetNClass() == ROLE_SCP173 and LocalPlayer():IsFlagSet(FL_FROZEN) then
			net.Start("173BlindAttackRequest")
			--print("send")
			net.SendToServer()
		end
	end)
end

SWEP.Author			= "Kanade/chan_man1"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Kill SCP-096"
SWEP.Instructions	= "LMB to break SCP-096's bones"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-173"
SWEP.Slot			= 0
SWEP.SlotPos		= 0
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false

SWEP.AttackDelay			= 0.25
SWEP.ISSCP = true
SWEP.droppable				= false
SWEP.CColor					= Color(0,255,0)
SWEP.SnapSound				= Sound( "snap.wav" )
SWEP.teams					= {1}
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false

SWEP.SpecialDelay			= 30
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.NextAttackW			= 0

function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
	self.Owner:SetJumpPower(175)
	self.Owner:SetWalkSpeed(500)
	self.Owner:SetRunSpeed(500)
	self.Owner:SetMaxSpeed(500)
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:IsLookingAt( ply )
	local yes = ply:GetAimVector():Dot( ( self.Owner:GetPos() - ply:GetPos() + Vector( 70 ) ):GetNormalized() )
	return (yes > 0.39)
end

SWEP.DrawRed = 0
function SWEP:Think()
	if CLIENT then
		self.DrawRed = CurTime() + 0.1
	end
	if postround then return end
	local watching = 0
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) and v:Team() != TEAM_SPEC and v:Team() != TEAM_GUARD and v:Team() != TEAM_SCI and v:Alive() and v != self.Owner and v:GetNClass() != ROLE_SCP990 and v.canblink then
			local tr_eyes = util.TraceLine( {
				start = v:EyePos() + v:EyeAngles():Forward() * 15,
				//start = v:LocalToWorld( v:OBBCenter() ),
				//start = v:GetPos() + (self.Owner:EyeAngles():Forward() * 5000),
				endpos = self.Owner:EyePos(),
				//filter = v
			} )
			local tr_center = util.TraceLine( {
				start = v:LocalToWorld( v:OBBCenter() ),
				endpos = self.Owner:LocalToWorld( self.Owner:OBBCenter() ),
				filter = v
			} )
			if tr_eyes.Entity == self.Owner or tr_center.Entity == self.Owner then
				//self.Owner:PrintMessage(HUD_PRINTTALK, tostring(tr_eyes.Entity) .. " : " .. tostring(tr_center.Entity) .. " : " .. tostring(tr_center.Entity))
				if self:IsLookingAt( v ) and v.isblinking == false then
					watching = watching + 1
					//if self:GetPos():Distance(v:GetPos()) > 100 then
						//self.Owner:PrintMessage(HUD_PRINTTALK, v:Nick() .. " is looking at you")
					//end
				end
			end
		end
	end
	if watching > 0 then
		--self.Owner.IS_FROZEN = true
		self.Owner:Freeze(true)
	else
	--	self.Owner.IS_FROZEN = false
		self.Owner:Freeze(false)
	end
end

function SWEP:Reload()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
end

function SWEP:PrimaryAttack()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if self.NextAttackW > CurTime() then return end
	if self.Owner.IS_FROZEN then return end
	self.NextAttackW = CurTime() + self.AttackDelay
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if (ent:GetPos():Distance(self.Owner:GetPos()) < 150) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_GUARD then return end
				if ent:Team() == TEAM_SPEC then return end
				ent:TakeDamage(200, self.Owner, self.Owner)
				ent:GiveAmmo(1, "AirboatGun", true)
				ent:PrintMessage(3, "Your bones have been broken!")
				ent:EmitSound( "breach/173/necksnap"..math.random(1, 3)..".wav", 500, 100 )
				else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				end
			end
		end
	end
end

function SWEP:Holster()
	self.Owner:SetWalkSpeed(1)
	self.Owner:SetRunSpeed(1)
	self.Owner:SetJumpPower(1)
	return true
end


function SWEP:SecondaryAttack()
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end
	local specialstatus = ""
	local showtext = ""
	local showtextlook = "Noone is looking"
	local lookcolor = Color(0,255,0)
	local showcolor = Color(17, 145, 66)
	if self.DrawRed < CurTime() then
		self.CColor = Color(255,0,0)
		showtextlook = "someone is looking"
		lookcolor = Color(145, 17, 62)
	else
		self.CColor = Color(0,255,0)
	end

	draw.Text( {
		text = showtext,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	draw.Text( {
		text = showtextlook,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = lookcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	local scale = 0.3
	surface.SetDrawColor( self.CColor.r, self.CColor.g, self.CColor.b, 255 )

	local gap = 5
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
end

--hook.Add("StartCommand", "173_StartCommand", function (ply, ucmd)
--	if ply.IS_FROZEN and ply.GetNClass and ply:GetNClass() == ROLE_SCP173 then
--		ucmd:ClearMovement()
--		ucmd:SetForwardMove(0)
--		ucmd:SetSideMove(0)
--		ucmd:SetUpMove(0)
--		ply:SetVelocity(ply:GetVelocity() * -1)
--	end
--end)

hook.Add("DoPlayerDeath", "DoPlayerDeath173", function (ply)
	ply:Freeze(false)
end)