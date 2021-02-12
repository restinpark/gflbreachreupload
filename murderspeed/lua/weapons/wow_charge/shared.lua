AddCSLuaFile( "shared.lua" )

local version = "1.1" -- Current version

-- SWEP.WepSelectIcon		= surface.GetTextureID("wow_charge")
-- SWEP.BounceWeaponIcon	= false

SWEP.PrintName = "Charge"
SWEP.Purpose = "CHARGE. Cooldown if you miss and after using."
SWEP.Instructions = "LMB to cast"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.base = "weapon_base"
SWEP.Category = "[World of Warcraft] Spells"
SWEP.DrawCrosshair = false
SWEP.HoldType = "melee"
SWEP.FiresUnderwater = true

SWEP.Weight = 3
SWEP.Slot = 1
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.ShowViewModel = false
SWEP.UseHands = false
SWEP.ViewModelFOV = 90
SWEP.ViewModelFlip = false

SWEP.ShowWorldModel = false

local soundpoolstart = { "spell_wr_charge_44_01", "spell_wr_charge_44_02", "spell_wr_charge_44_03", "spell_wr_charge_44_04", "spell_wr_charge_44_05" }
local soundpoolend = { "spell_wr_charge_end_44_01", "spell_wr_charge_end_44_02", "spell_wr_charge_end_44_03", "spell_wr_charge_end_44_04" }

SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0	
SWEP.Primary.ClipSize			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic   		= true
SWEP.Primary.Ammo         		= "none"

SWEP.Secondary.Recoil			= 0
SWEP.Secondary.Damage			= 0
SWEP.Secondary.NumShots			= 0
SWEP.Secondary.Cone		  		= 0
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= true
SWEP.Secondary.Ammo         	= "none"

local globalcooldown = 4

function SWEP:Initialize() -- INITIALIZE
	self.Idle = true
	self.IdleDelay = CurTime() + 1
	self.timer1 = 0
	self.active1 = false
	self:SetHoldType( "melee" )
end 

function SWEP:Holster() -- HOLSTER
	return true
end

function SWEP:OnRemove() -- ON_REMOVE
	self:Holster()
end

function SWEP:PrimaryAttack() -- LMB CASTING
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	
	self:Buff_Self (self.Secondary.Model, self.Primary.Sound)
end

function SWEP:SecondaryAttack() -- RMB CASTING
end

function SWEP:Buff_Self (Model, Sound) -- "BUFF_SELF"

	local tr = self.Owner:GetEyeTrace()
	
	local targetlist, i = {}, 1
	
	for x, y in pairs(ents.FindInCone( self.Owner:EyePos(), self.Owner:GetForward(), 700, 0.99 )) do
		if (IsValid(y)) and (y:GetClass() == "player") or (string.match(y:GetClass(), 'npc')) then
		targetlist[i] = y
		i = i + 1
		end
	end
	
	if ( targetlist[1] == nil ) or (self.Owner:GetPos():Distance(targetlist[1]:GetPos()) < 150) then
		self.Weapon:SetNextPrimaryFire( CurTime() + (globalcooldown / 3) )
	return end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	if (!SERVER) then return end
	
	self.Owner:EmitSound(soundpoolstart[math.random(5)] .. ".wav", 75, 100, 1, CHAN_AUTO)
	
	self.Weapon:SetNextPrimaryFire( CurTime() + globalcooldown )
	
	local ent = ents.Create ("ent_charge")
	ent:SetPos(self.Owner:GetPos())
	
	ent:SetCollisionGroup(11)
	ent:SetOwner(self.Owner)
	ent:Spawn()
	local phys = ent:GetPhysicsObject()
	self.Owner:StripWeapon("ent_charge")
	
	local function delete() -- "DELETE"
		
			hook.Remove("Think", "CheckClash")
			ent:Remove();
			
	end
	local function buff_charge() -- "BUFF_CHARGE"
	
		if self:IsValid() == false then return end
		
		target = targetlist[1]
		
		has_clashed = false
		
		exponent = 1
		
		local function rush() -- "RUSH"
		
			if self:IsValid() == false then return end
			if (self.Owner:GetVelocity():Length() > Vector(500, 500, 0):Length()) then return end
		
			self.Owner:SetVelocity( self.Owner:GetVelocity() * Vector(1.5, 1.5, 0) + Vector(0, 0, -1) )
		end
		
		local function CheckClash() -- "CHECK_CLASH"
		
			if self:IsValid() == false then return end
			if target:IsValid() == false then return end
		
			if (self.Owner:GetPos():Distance(target:GetPos()) < 50 + ((target:GetCollisionBounds()):Length())) and (has_clashed == false) then
				self.Owner:SetPos(self.Owner:GetPos())
				has_clashed = true
				
				if (self.Owner:GetVelocity():Length() > 200) then
				
					target:TakeDamage( ((target:GetMaxHealth() / 10) + ((self.Owner:GetVelocity() - target:GetVelocity()):Length() * 0.005)), self.Owner, self )
					target:SetVelocity( self.Owner:GetVelocity() )
					
					self.Owner:SetVelocity( self.Owner:GetVelocity() * -1 )
					
					self.Weapon:EmitSound(soundpoolend[math.random(4)] .. ".wav", 75, 100, 1, CHAN_AUTO)
					
					hook.Remove("Think", "CheckClash")
					
					self.Owner:ResetSequence( PLAYER_ATTACK1 )
					
					local loadout = self.Owner:GetWeapons()
					
					for i = 1, table.getn(loadout), 1 do

						if (string.match(loadout[i]:GetClass(), 'sword')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'blade')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'katana')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'axe')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'mace')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'hammer')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'spear')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'staff')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'dagger')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'knife')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'bow')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'crossbow')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'musket')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						elseif (string.match(loadout[i]:GetClass(), 'fists')) then
							self.Owner:SelectWeapon( loadout[i]:GetClass() ) return
							
						else
						
						end
					end
				end
			end
		end
		
		hook.Add("Think", "CheckClash", CheckClash)
		
		if (has_clashed == false) then
			timer.Simple( 0.1, rush )
			if (has_clashed == false) then
				timer.Simple( 0.15, rush )
				if (has_clashed == false) then
					timer.Simple( 0.2, rush )
					if (has_clashed == false) then
						timer.Simple( 0.25, rush )
						if (has_clashed == false) then
							timer.Simple( 0.3, rush )
							if (has_clashed == false) then
								timer.Simple( 0.35, rush )
								if (has_clashed == false) then
									timer.Simple( 0.4, rush )
									if (has_clashed == false) then
										timer.Simple( 0.45, rush )
										if (has_clashed == false) then
											timer.Simple( 0.5, rush )
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	timer.Simple( 0, buff_charge );
	timer.Simple( 1, delete );
	cleanup.Add( self.Owner, "props", ent )
	
end

function SWEP:Think() -- THINK
	if self.Idle && self.IdleDelay <= CurTime() then	
		self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		self.Idle = false
	end
end

function SWEP:DrawHUD() -- DRAW_HUD

	local tr = self.Owner:GetEyeTrace()
	
	local targetlist, i = {}, 1
	
	for x, y in pairs(ents.FindInCone( self.Owner:EyePos(), self.Owner:GetForward(), 700, 0.99 )) do
		if (IsValid(y)) and (y:GetClass() == "player") or (string.match(y:GetClass(), 'npc')) then
		targetlist[i] = y
		i = i + 1
		end
	end
	
	local progress = ((self.Weapon:GetNextPrimaryFire() - CurTime()) * (200 / globalcooldown))
	
	surface.SetMaterial( Material( "hud/wow_warrior_crosshair.vtf" ) )
	if ( targetlist[1] == nil ) or (self.Owner:GetPos():Distance(targetlist[1]:GetPos()) < 150) then 
		surface.SetDrawColor(Color(128, 128, 128, 255))
	else
		surface.SetDrawColor(Color(255, 255 * math.abs(math.sin(2 * CurTime())), 255 * math.abs(math.sin(2 * CurTime())), 255))
	end
	surface.DrawTexturedRect( (ScrW() / 2) - (32 / 2), (ScrH() / 2) - (32 / 2), 32, 32 )
	
	surface.SetDrawColor(Color(255, 255, 255, (255 * math.abs(math.sin(0.5 * CurTime())))))
	surface.SetMaterial( Material( "hud/killicons/wow_charge_killicon.vtf" ) )
	surface.DrawTexturedRect( (ScrW() / 2) - 32, (ScrH() / 1.1), 64, 64 )
	
	if progress < 0 then return end
	
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.SetMaterial( Material( "hud/killicons/wow_charge_killicon.vtf" ) )
	surface.DrawTexturedRect( (ScrW() / 2) - 13 - 100, (ScrH() / 1.20), 26, 26 )
	surface.SetMaterial( Material( "hud/wow_warrior_cooldown_bar.vtf" ) )
	surface.DrawTexturedRect( (ScrW() / 2) - 100 + 13, (ScrH() / 1.20), 200, 26 )
	surface.SetMaterial( Material( "hud/wow_warrior_cooldown_bar_filled.vtf" ) )
	surface.DrawTexturedRect( (ScrW() / 2) - 100 + 13, (ScrH() / 1.20), progress, 26 )
	
end