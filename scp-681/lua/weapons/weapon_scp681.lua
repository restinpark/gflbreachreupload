AddCSLuaFile()
SWEP.PrintName = "SCP-681"
SWEP.Instructions = "Move around to spread your Helium gas."
SWEP.droppable = false

SWEP.Author = "Ralsei"

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary = SWEP.Primary

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    timer.Simple(0, function ()
        if self.Owner and IsValid(self.Owner) then
            self.Owner:DrawViewModel(false)
        end
    end)
end

function SWEP:DrawWorldModel()

end

function SWEP:Reload() end

function SWEP:PrimaryAttack()
	if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
		if(ent:GetPos():Distance(self.Owner:GetPos()) < 125) then
			if ent:IsPlayer() then
				if ent:Team() == TEAM_SCP then return end
				if ent:Team() == TEAM_SPEC then return end
				//ent:SetSCP0492()
				//roundstats.zombies = roundstats.zombies + 1
                ent:TakeDamage(math.random(3, 5), self.Owner, self.Owner)
			else
				if ent:GetClass() == "func_breakable" then
					ent:TakeDamage( 1000, self.Owner, self.Owner )
				elseif BREACH_IsGateDoor(ent) then
					ent:TakeDamage( math.random(25, 100), self.Owner, self.Owner )
				end
			end
		end
	end
end

SWEP.NextSpecial = 0

function SWEP:SecondaryAttack()
    if preparing or postround then return end
    if not IsFirstTimePredicted() then return end
    if self.NextSpecial > CurTime() then return end
    self.NextSpecial = CurTime() + 30
    if self.Owner:Health() <= 100 then
        if CLIENT then
            chat.AddText(Color(255,255,255), "hegas681.lua: Blocking special as player would die if they activated this special. (Health <= 100)")
        end
        return
    end
    if SERVER then
        local oldspeed = self.Owner:GetRunSpeed()
        self.Owner:SetRunSpeed(300)
        self.Owner:SetWalkSpeed(300)
        self.Owner:SetMaxSpeed(300)
        self.Owner:SetHealth(self.Owner:Health() - 100)
        if self.Owner:Health() <= 0 then
            self.Owner:Kill()
        end
        local x = self.Owner
        timer.Simple(15, function ()
            if x and IsValid(x) and x:IsPlayer() and x:GetNClass() == ROLE_SCP681 then
                x:SetRunSpeed(oldspeed)
                x:SetWalkSpeed(oldspeed)
                x:SetMaxSpeed(oldspeed)
            end
        end)
    end
end

local LIST_OF_HE = {}
if SERVER then
    timer.Create("Spawn681Stuff", 1, 0, function ()
        if preparing then return end
        for k,v in pairs(player.GetAll()) do
            if v:GetNClass() == ROLE_SCP681 then
                local idx = os.time()
                LIST_OF_HE[idx] = ents.Create("ent_681_hazard")
                LIST_OF_HE[idx]:SetPos(v:GetPos() + Vector(0,0,30))
                LIST_OF_HE[idx].Owner = v
                LIST_OF_HE[idx]:Spawn()
                timer.Simple(45, function ()
                    LIST_OF_HE[idx] = nil
                end)
            end
        end
    end)
end

hook.Add("BreachStartRound", "BreachRoundStart_HECleanup", function ()
    LIST_OF_HE = {}
end)

function SWEP:DrawHUD()
	local showtext = "Special is ready"
	local showcolor = Color(0,255,0)

	if self.NextSpecial > CurTime() then
		showtext = "Next special in " .. math.Round(self.NextSpecial - CurTime())
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