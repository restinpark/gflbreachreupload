SWEP.Spawnable = true
SWEP.PrintName = "SCP-500"
SWEP.Author = ""
SWEP.Contact = "uhh"
SWEP.Purpose = "The Cure"
SWEP.Instructions = "Primary fire uses them. "
SWEP.ViewModel = "models/props_lab/jar01b.mdl"
SWEP.WorldModel = "models/scp500model/scp500model.mdl"
if CLIENT then
  SWEP.BounceWeaponIcon = false
  SWEP.DrawAmmo = false
  SWEP.WepSelectIcon = surface.GetTextureID( "vgui/scp_500" )
end
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.ItemType = WEAPON_MEDICAL or 8
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
function SWEP:Deploy()
  self.Owner:DrawViewModel( false )
end
function SWEP:PrimaryAttack()
  self:SendWeaponAnim(ACT_USE)
	if SERVER then
		if self.Owner:GetNClass() == ROLE_SCP1360 then return end
		if IsValid(self.Owner) then
			self.Owner:SetBleeding(false)
			self.Owner:SetDecomposing(false)
			if self.Owner:Team() != TEAM_SCP and self.Owner:GetMaxHealth() == 75 and self.Owner:GetNClass() ~= ROLE_SCP035 then
				self.Owner:SetMaxHealth(100)
			end
			timer.Remove("SCP1025_KILL_" .. self.Owner:SteamID())
			if timer.Exists("Eyed" .. self.Owner:SteamID()) then
			timer.Remove("Eyed" .. self.Owner:SteamID())
			local vec2 = self.Owner:GetShootPos() -- The player's eye pos
			self.Owner:SetEyeAngles( ( vec2 ):Angle() )
			end
			timer.Remove("Boom" .. self.Owner:SteamID())
			timer.Remove("Blind" .. self.Owner:SteamID())
			timer.Remove("Brain" .. self.Owner:SteamID())
			timer.Remove("Craze" .. self.Owner:SteamID())
			timer.Remove("Panic" .. self.Owner:SteamID())
			if self.Owner:GetNWString("bad", "unset") == "md" or self.Owner:GetNWString("bad", "unset") == "ass" then
				timer.Remove("Ass" .. self.Owner:SteamID())
				self.Owner:SetNWString("bad", "cure")
				self.Owner:SetWalkSpeed(240)
			end
			if self.Owner:GetNWString("bad", "unset") == "kf" then
				self.Owner:SetNWString("bad", "cure")
				self.Owner:SetMaxHealth(100)
			end
			if self.Owner:GetNWString("bad", "unset") == "g" then
				self.Owner:SetNWString("bad", "cure")
				self.Owner:ScreenFade( SCREENFADE.PURGE, Color( 255, 0, 0, 128 ), 0.3, 0 )
			end
			if self.Owner:GetNWString("009", "unset") == "grow" then
				self.Owner:SetNWString("009", "cure")
				self.Owner:SetWalkSpeed(240)
			end
			if self.Owner:GetNWString("409", "unset") == "infect" or self.Owner:GetNWString("020", "unset") == "stage1" or self.Owner:GetNWString("MEDNML", "unset") == "1" then
				self.Owner:SetNWString("409", "cure")
				self.Owner:SetNWString("020", "cure")
				self.Owner:SetNWString("MEDNML", "cure")
			end
			if self.Owner:GetNClass() == ROLE_SCP378 then
								self.Owner:SetHealth(math.Clamp(self.Owner:Health() + 100, 0, self.Owner:GetMaxHealth()))
			else
				self.Owner:SetHealth(self.Owner:GetMaxHealth())
			end
			self.Owner:SetNWBool("SCP610_Infect", false)
			hook.Run("BreachPlayerHealed", self.Owner, self.Owner)
			self.Owner:SetNWBool("SCP020_HasSCP020", false)
            self.Owner:SetNWFloat("SCP020_InfStart", CurTime() + 99999999)
            self.Owner:SetNWFloat("SCP020_TurnTime", CurTime() + 99999999)
            self.Owner:SetNWBool("SCP020_CanCure", true)
		end
	if timer.Exists(self.Owner:SteamID().."SCP008Timer") then
		timer.Destroy(self.Owner:SteamID().."SCP008Timer")
	end
	if self.Owner:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
    self.Owner:StripWeapon(self:GetClass())
  end
end

function SWEP:SecondaryAttack()
	--//if ( !self:CanPrimaryAttack() ) then return end
	if preparing or postround then return end
	--if not IsFirstTimePredicted() then return end
	--if self.NextAttackW > CurTime() then return end
	--self.NextAttackW = CurTime() + self.AttackDelay
	if SERVER then
		local ent = nil
		local tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 170 ),
			filter = self.Owner,
			mins = Vector( -10, -10, -10 ),
			maxs = Vector( 10, 10, 10 ),
			mask = MASK_SHOT_HULL
		} )
		ent = tr.Entity
		if IsValid(ent) and ent:IsPlayer() and IsValid(self.Owner) and self.Owner:IsPlayer() then
			if ent.GetNClass and ent:Team() == TEAM_SCP or ent:GetNClass() == ROLE_SCP2953 or ent:GetNClass() == ROLE_SCP2953D or ent:GetNClass() == ROLE_SCP2953C or ent:GetNClass() == ROLE_SCP2953L or ent:GetNClass() == ROLE_SCP2953M or ent:GetNClass() == ROLE_SCP2953G or ent:GetNClass() == ROLE_SCP427 then
				local oldpos = ent:GetPos()
				if ent:GetNClass() == ROLE_SCP0082 or ent:GetNClass() == ROLE_SCP0492 or ent:GetNClass() == ROLE_SCP2953 or ent:GetNClass() == ROLE_SCP2953D or ent:GetNClass() == ROLE_SCP2953C or ent:GetNClass() == ROLE_SCP2953L or ent:GetNClass() == ROLE_SCP2953M or ent:GetNClass() == ROLE_SCP2953G or ent:GetNClass() == ROLE_SCP427 then
					if self.Owner:Team() == TEAM_CHAOS or self.Owner:Team() == TEAM_CLASSD then
						ent:SetClassD()
					elseif self.Owner:Team() == TEAM_SCI or self.Owner:Team() == TEAM_GUARD then
						ent:SetScientist()
					elseif self.Owner:Team() == TEAM_CLASSE then
					if self.Owner.GiveAchievement then
						self.Owner:GiveAchievement("Evival")
					end
						ent:SetClassE()
					elseif self.Owner:Team() == TEAM_GOC then
						ServerLog("Warning! Unexpected TEAM_GOC!!!\n")
					elseif self.Owner:Team() == TEAM_SCP then 
						self.Owner:ChatPrint("This player is already cured!")
						return 
					else
						ent:SetClassD()
					end
					ent:SetPos(oldpos)
					if SERVER and self.Owner:GetNWString("Sign", "unset") == "3" then
					if self.Owner:GetAmmoCount(12) > 4 then
					self.Owner:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
					self.Owner:PrintMessage(3, "Contract Complete!")
					self.Owner:StripWeapon("weapon_scp_350")
					self.Owner:SetNWString("350", "clear")
					self.Owner:SetNWString("Sign", "clear")
					else
					self.Owner:GiveAmmo(1, "AlyxGun", true)
				end
			end
          hook.Run("BreachPlayerHealed", self.Owner, ent)
					ent:PrintMessage(3, "You were cured")
					self.Owner:AddFrags(15)
					timer.Create("BREACH_500_USE_2_"..self.Owner:Nick(), 0, 1, function ()
						if self and IsValid(self) and IsValid(self.Owner) then
						if self.Owner:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
							self.Owner:StripWeapon("weapon_scp_500")
						end
					end)
				end
			end
		end
	end
end

function SWEP:GetBetterOne()
	local x = math.random(1,15)
	if x == 3 and buttonstatus == 4 then
		return "weapon_scp_500_up"
	elseif buttonstatus == 3 then
		return "weapon_scp_427"
	elseif buttonstatus == 2 then
		return "item_medkit"
	elseif buttonstatus == 1 then
		return "weapon_scp_690"
	elseif buttonstatus == 0 then
		return "ent_goop"
	else
		return "weapon_scp_500"
	end
end

