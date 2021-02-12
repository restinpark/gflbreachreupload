SWEP.PrintName = "SCP-207"
SWEP.Category = "SCP Objects"
SWEP.Spawnable = true

SWEP.Slot = 1
SWEP.SlotPos = 101

SWEP.ViewModel = Model( "models/johnmason/food/c_coca_cola_can.mdl" )
SWEP.WorldModel = Model( "models/johnmason/food/w_coca_cola_can.mdl" )
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 3
SWEP.DrinkAmount = 25
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.ViewModelFOV = 54
SWEP.UseHands = true
SWEP.DrawCrosshair = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Opened = false
SWEP.droppable = false
SWEP.Instructions = "For drinking."
function SWEP:Initialize()

	self:SetHoldType( "slam" )
	
end
if SERVER then
hook.Add("BreachEndRound", "BreachEndRound_SCP207", function ()
	for k,v in pairs(player.GetAll()) do
		v:SetNWFloat("WillLiveUntil_SCP207", -1)
	end
end)

hook.Add("BreachStartRound", "BreachStartRound_SCP207", function ()
	for k,v in pairs(player.GetAll()) do
		v:SetNWFloat("WillLiveUntil_SCP207", -1)
	end
end)

hook.Add("PlayerDeath", "PlayerDeath_SCP207", function (ply)
	ply:SetNWFloat("WillLiveUntil_SCP207", -1)
end)

timer.Create("SCP207_Think", 1, 0, function ()
	for k,v in pairs(player.GetAll()) do
		if not (preparing or postround) and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP and v:HasWeapon("item_scp207") and v:GetNWFloat("WillLiveUntil_SCP207", -1) != -1 then
			--print(v:GetNWFloat("WillLiveUntil_SCP207", -1))
			if v:GetNWFloat("WillLiveUntil_SCP207", -1) - CurTime() <= 0 then
			if v:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
				v:Kill()
				v:SetNWFloat("WillLiveUntil_SCP207", -1)
			end
		elseif v:GetNWFloat("WillLiveUntil_SCP207", -1) != -1 then
			v:SetNWFloat("WillLiveUntil_SCP207", -1)
		end
	end
end)

hook.Add("EntityTakeDamage", "EntityTakeDamage_SCP207", function (v, dmg)
	local v = dmg:GetAttacker()
	if v and IsValid(v) and v:IsPlayer() and not (preparing or postround) and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP and v:HasWeapon("item_scp207") and v:GetNWFloat("WillLiveUntil_SCP207", -1) != -1 then
		dmg:ScaleDamage(1.1)
	end
end)
end
function SWEP:PrimaryAttack()
	if preparing or postround then return end
	if ( CLIENT ) then return end

	local ent = self.Owner	
		self:SetClip1( self:Clip1() - 1)
		
		if self.Opened then 
			if SERVER then
				self.Owner:EmitSound( "food/soda_drink.wav", 60 )
			end
			self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		else
			self.Opened = true
			
			if SERVER then
				self.Owner:EmitSound( "food/soda_open.wav", 60 )
			end
			self:SendWeaponAnim( ACT_VM_RELEASE )
		end	
		
			self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 )
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
		
		if ( IsValid( self.Owner ) ) then
			self.Owner:SetMaxHealth(150)
			self.Owner:SetHealth( math.Clamp(self.Owner:Health() + 2910, 0, self.Owner:GetMaxHealth() ))
			if self.Owner:GetNWFloat("WillLiveUntil_SCP207", -1) - CurTime() > 0 then
				self.Owner:SetNWFloat("WillLiveUntil_SCP207", CurTime() + ((self.Owner:GetNWFloat("WillLiveUntil_SCP207") - CurTime()) / 2))
			else
				self.Owner:SetNWFloat("WillLiveUntil_SCP207", CurTime() + 60)
			end
			self.Owner:SetRunSpeed(self.Owner:GetRunSpeed() + 10)
			self.Owner:SetMaxSpeed(self.Owner:GetMaxSpeed() + 10)
		end
end

function SWEP:SecondaryAttack()

end

function SWEP:Reload() end