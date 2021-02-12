
AddCSLuaFile()

SWEP.PrintName = "SCP-610-B"
SWEP.Author = "Aurora"
SWEP.Instructions = "Primary attack will infect or kill the player you target."
SWEP.ItemType = WEAPON_SCP or 12
SWEP.droppable = false

function SWEP:Equip(newowner)
    local e = newowner
    timer.Simple(0, function ()
        if e and IsValid(e) and e:IsPlayer() then
            e:DrawViewModel(false)
        end
    end)
end

function SWEP:DrawWorldModel() end

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Reload() end

SWEP.NextAttackW = 0
SWEP.AttackDelay = 0.1
function SWEP:PrimaryAttack()
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
                local infchance = math.random(1,5) == 5
                if ent.UsingArmor and ent.UsingArmor == "armor_hazmat" and infchance then
                    self.NextAttackW = CurTime() + 2
                    self.Owner:PrintMessage(4, "Infection blocked by hazmat suit, try again.")
                    return
                end
                if math.random(1, 2) == 2 then
                    --ent:TakeDamage(10, self.Owner, self)
                    ent:SetBleeding(true)
                    return
                end
                if ent:GetNWBool("SCP610_Infect", false) == false then
                    self.Owner:PrintMessage(4, "You've infected " .. ent:Nick() .. ". They will soon turn into SCP-610-B.")
		    ent:PrintMessage(4, "You've been infected by SCP-610-B, you must take SCP-500 to be cured.")
                else
                    self.Owner:PrintMessage(4, "You've already infected " .. ent:Nick() .. ". They will turn soon enough.")
                end
                ent:SetNWBool("SCP610_Infect", true)
                local tid = tostring(ent:SteamID64()) .. "_SCP610Convert_" .. tostring(math.random(1, 10000))
                timer.Create(tid, math.random(45, 70), 1, function ()
                    if ent and IsValid(ent) and ent:IsPlayer() and ent:Team() != TEAM_SPEC and ent:Team() != TEAM_SCP and ent:GetNWBool("SCP610_Infect", false) then
                        ent:SetSCP610B()
                        
                        ent:SetNWBool("SCP610_Infect", false)

                        --Prevent crack / cocaine zombies
                        ent.BR_HasSpeedBoost = false
                    end
                end)
                SCP_610_TIMERS[#SCP_610_TIMERS + 1] = tid
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
SWEP.NextAttack2 = 0
SWEP.AttackDelay2 = 90
function SWEP:SecondaryAttack() end
