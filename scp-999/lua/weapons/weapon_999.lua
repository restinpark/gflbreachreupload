AddCSLuaFile()

if CLIENT then
	//SWEP.WepSelectIcon 	= surface.GetTextureID("vgui/weapon999")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Aurora"
SWEP.Contact		= ""
SWEP.Purpose		= "idk"
SWEP.Instructions	= ""
//SWEP.Base	= "weapon_base"
SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.HoldType		= "knife"
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"
SWEP.PrintName		= "SCP-999"
SWEP.DrawCrosshair	= true
SWEP.Slot	= 0

SWEP.Spawnable			= true
SWEP.AdminOnly			= false
SWEP.droppable				= false
SWEP.Primary.Automatic		= true
SWEP.Primary.NextAttack		= 0
SWEP.Primary.AttackDelay	= 15
SWEP.Primary.Damage			= nil
SWEP.Primary.Force			= nil
SWEP.Primary.AnimSpeed		= nil

SWEP.Secondary.Automatic	= false
SWEP.Secondary.NextAttack	= 0
SWEP.Secondary.AttackDelay	= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.Force		= 0
SWEP.Secondary.AnimSpeed	= 0
SWEP.Range					= 0

SWEP.UseHands				= false
SWEP.DrawCustomCrosshair	= false
SWEP.DeploySpeed			= 1

function SWEP:Initialize()

end


function SWEP:PrimaryAttack()
	if self.Primary.NextAttack > CurTime() then return end

	if not IsFirstTimePredicted() then return end
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
				if ent:Team() == TEAM_SCP then
					ent:Freeze(true)
					timer.Simple(3.5, function ()
						ent:Freeze(false)
					end)
					self.Primary.NextAttack = CurTime() + self.Primary.AttackDelay
				elseif ent:Team() != TEAM_SPEC then
					local hp = ent:Health()
					local max1 = ent:GetMaxHealth()
					self.Primary.NextAttack = CurTime() + 0.3
					if hp + 5 > max1 then
						ent:SetHealth(max1)
					else
						ent:SetHealth(hp + 5)
					end
					hook.Run("939HealPlayer", self.Owner, ent)
					ent:SetBleeding(false)
				end
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 100, self.Owner, self.Owner )
				end
			end
		end
	end
end
SWEP.NextThink = 0




function SWEP:DrawWorldModel()

end

function SWEP:Deploy()
	self.Owner:DrawViewModel( false)
	//return true
end
function SWEP:SecondaryAttack()

end
