--Dogshit
AddCSLuaFile()

SWEP.PrintName = "SCP-610"
SWEP.Author = "Aurora"
SWEP.Instructions = "Primary attack will infect the player you target. Secondary attack will activate your special ability."
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
                else
                    if self.Owner.GiveAchievement then
						self.Owner:GiveAchievement("NothingCanSaveYou")
					end
                end
                if ent:GetNWBool("SCP610_Infect", false) == false then
                    self.Owner:PrintMessage(4, "You've infected " .. ent:Nick() .. ". They will soon turn into SCP-610-B.")
		    ent:PrintMessage(4, "You've been infected by SCP-610. You must take SCP-500 to be cured")
                else
                    self.Owner:PrintMessage(4, "You've already infected " .. ent:Nick() .. ". They will turn soon enough.")
                end
                ent:SetNWBool("SCP610_Infect", true)
                local tid = tostring(ent:SteamID64()) .. "_SCP610Convert_" .. tostring(math.random(1, 10000))
                timer.Create(tid, math.random(45, 70), 1, function ()
                    if ent and IsValid(ent) and ent:IsPlayer() and ent:Team() != TEAM_SPEC and ent:Team() != TEAM_SCP  and ent:GetNWBool("SCP610_Infect", false) then
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
function SWEP:SecondaryAttack()
    if preparing or postround then return end
    if not IsFirstTimePredicted() then return end
    if self.NextAttack2 > CurTime() then return end
    self.NextAttack2 = CurTime() + self.AttackDelay2
    if SERVER then
        self.Owner:SetModel("models/nest/nest.mdl")
        self.Owner:SetNWBool("SCP610_Rooted", true)
        --self.Owner:Freeze(true)
        local e2 = self
        --local tid = tostring(self.Owner:SteamID64()) .. "_SCP610Unroot_" .. tostring(math.random(1, 10000))
        --timer.Create(tid, 30, 1, function ()
            local nest = ents.Create("ent_scp_610_infection")
            if IsValid(nest) then
                nest:SetPos(e2.Owner:GetPos())
                nest:Spawn()
                nest:SetState(true)
                timer.Simple(120, function ()
                    if nest and IsValid(nest) then
                    SafeRemoveEntity(nest)
                    end
                end)
            end
            e2.Owner:SetModel("models/player/zombie_fast.mdl")
            e2.Owner:SetNWBool("SCP610_Rooted", false)
            --e2.Owner:Freeze(false)
        --end)
    end
end

hook.Add("EntityTakeDamage", "Scale610Damage", function (entity, info)
    if IsValid(entity) and entity:IsPlayer() and entity:GetNClass() == ROLE_SCP610 and entity:GetNWBool("SCP610_Rooted", false) then
        info:ScaleDamage(0.3)
    end
end)

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to root"
	local showcolor = Color(0,255,0)

	if self.NextAttack2 > CurTime() then
		showtext = "Next root in " .. math.Round(self.NextAttack2 - CurTime())
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
