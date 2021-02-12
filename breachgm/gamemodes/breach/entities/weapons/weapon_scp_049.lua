AddCSLuaFile()
if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_049")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade/chan_man1"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Cure"
SWEP.Instructions	= "LMB to cure someone, RMB to get a little closer to your victims, Reload to perform sugery on your patients"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/vinrax/props/keycard.mdl"
SWEP.WorldModel		= "models/vinrax/props/keycard.mdl"
SWEP.PrintName		= "SCP-049"
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
SWEP.teams					= {1}
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false

SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Automatic	= false
SWEP.NextAttackW			= 0
SWEP.SFXCooldown = 0
SWEP.NextPrep				= 0
SWEP.PrepDelay				= 15

SWEP.NextSurg				= 0
SWEP.SurgDelay				= 45
function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end
function SWEP:DrawWorldModel()
end
function SWEP:Initialize()
	self:SetHoldType("normal")
	util.PrecacheSound( "breach/049/infect1.ogg" )
	util.PrecacheSound( "breach/049/infect2.ogg" )
	util.PrecacheSound( "breach/049/infect3.ogg" )
	util.PrecacheSound( "breach/049/infect4.ogg" )
end

function SWEP:Think()
end

function SWEP:Reload()
if self.NextSurg > CurTime() then return
	end
	self.NextSurg = CurTime() + self.SurgDelay
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
				if ent:Team() == TEAM_SCP then
					if ent:GetNClass() == ROLE_SCP0492 then
					if math.random(1,2) == 1 then
					ent:SetWalkSpeed(math.Clamp(self.Owner:GetWalkSpeed() + 50, 0, 300))
					ent:SetModel("models/player/zombie_fast.mdl")
					ent:EmitSound("physics/flesh/flesh_bloody_impact_hard1.wav", 100, 100)
					elseif math.random(1,2) == 1 then
					ent:SetHealth(math.Clamp(self.Owner:Health() + 100, 0, 1000))
					ent:SetModel("models/player/zombie_soldier.mdl")
					ent:EmitSound("physics/flesh/flesh_bloody_impact_hard1.wav", 100, 100)
					else
					ent:SetHealth(ent:Health() + (table.Random({25, 50, 75})))
					ent:EmitSound("physics/flesh/flesh_bloody_impact_hard1.wav", 100, 100)
					if self.Owner.AddAchievementProgress then
						self.Owner:AddAchievementProgress("049MD", 1)
						end
					end
				end
			end
		end
	end
end
end

function SWEP:PrimaryAttack()
	//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if self.NextAttackW > CurTime() then return end
	self.NextAttackW = CurTime() + self.AttackDelay
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
				if ent:GetNClass() == ROLE_SCP990 then return end
				if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				if ent:GetNClass() == ROLE_CLASSD9341 then ent:Kill() end
				local armorchance = math.random(1,5) == 4
				if ent.UsingArmor and ent.UsingArmor == "armor_hazmat" and armorchance then 
					self.Owner:PrintMessage(4, "Infect blocked by armor, try again!")
					self.NextAttackW = CurTime() + 3
					return
				else
					if self.Owner.GiveAchievement then
						self.Owner:GiveAchievement("NothingCanSaveYou")
					end
				end
				if roundtype and roundtype.name and roundtype.name == "Malpractice" then
					table.Random(SPCS)["func"](ent)
					ent:SetMaxHealth(ent:GetMaxHealth() * (math.random(20, 30) / 100))
					ent:SetHealth(ent:GetMaxHealth())
				else
					ent:SetSCP0492()
					ent:AddFrags(1)
					ent:Flashlight(false)
				end
				--SCP294: Prevent the coffee exploit
				ent.BR_HasSpeedBoost = false
				self.Owner:EmitSound( "breach/049/infect" .. math.random(1, 4) .. ".ogg", SNDLVL_150dB, 100 )
				--self.Owner:PS2_AddStandardPoints(200, "Curing a player.", true)
				roundstats.zombies = roundstats.zombies + 1
				hook.Run("SCP049Cure", self.Owner)
			elseif ent:GetClass() == "prop_ragdoll" and ent.player_ragdoll then
				local ply = nil
				local sid = ent:GetNWBool("player_steamid", "NULL")
				for k,v in pairs(player.GetAll()) do
					if sid == v:SteamID64() and v:Team() == TEAM_SPEC and not v:IsAFK() then
						ply = v
						break
					end
				end
				if self.Owner and IsValid(self.Owner) and ((not ply or not IsValid(ply)) or ent:GetNWFloat("corpse_time", 0) + 180 < CurTime()) then
					self.Owner:PrintMessage(3, "The player who owned this corpse cannot be revived.")
					return
				end
				if IsValid(ply) and IsValid(self.Owner) then
					local pos = ent:GetNWVector("player_pos", self.Owner:GetPos())
					SafeRemoveEntity(ent)
					ply:SetScientist()
					//Well this is fucking dumb
					timer.Simple(0.1, function ()
						if IsValid(ply) then
							//Scope Pyramids, who cares?
							ply:SetPos(pos)
							ply:SetSCP0492()
						end
					end)

				end
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
if self.NextPrep > CurTime() then return
	end
	self.NextPrep = CurTime() + self.PrepDelay
	local ply = self.Owner

	ply:SetWalkSpeed(255)
	ply:SetRunSpeed(255)
	ply:SetMaxSpeed(255)
	ply:SetJumpPower(200)
	local function RemoveBuff()

		ply:SetWalkSpeed(160)
		ply:SetRunSpeed(160)
		ply:SetMaxSpeed(160)
		ply:SetJumpPower(200)
	end
	timer.Create("SCP_PLAYER_WILL_LOSE_BUFF" .. ply:SteamID(), 2, 1, RemoveBuff)
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext1 = "Ready to Attack"
	local showcolor1 = Color(0,255,0)

	if self.NextAttackW > CurTime() then
		showtext1 = "Next attack in " .. math.Round(self.NextAttackW - CurTime())
		showcolor1 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext1,
		pos = { ScrW() / 2, ScrH() - 75 },
		font = "173font",
		color = showcolor1,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})

	if disablehud == true then return end

	local showtext2 = "Preperations are complete"
	local showcolor2 = Color(0,255,0)

	if self.NextPrep > CurTime() then
		showtext2 = "Preparing to close the distance " .. math.Round(self.NextPrep - CurTime())
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

if disablehud == true then return end

	local showtext3 = "Prepared for surgery"
	local showcolor3 = Color(0,255,0)

	if self.NextSurg > CurTime() then
		showtext3 = "Next Surgical Experiment in " .. math.Round(self.NextSurg - CurTime())
		showcolor3 = Color(255,0,0)
	end

	draw.Text( {
		text = showtext3,
		pos = { ScrW() / 2, ScrH() - 25 },
		font = "173font",
		color = showcolor3,
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
