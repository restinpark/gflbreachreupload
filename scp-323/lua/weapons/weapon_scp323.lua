AddCSLuaFile()

SWEP.PrintName = "SCP-323"
SWEP.Author = "Aurora"
SWEP.Purpose = "Eat to survive!"
SWEP.Instructions = "Primary attack to eat!"

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

SWEP.Secondary = SWEP.Primary

SWEP.droppable = false
SWEP.Type = WEAPON_SCP or 12

function SWEP:Initialize()
    self:SetNWInt("NextStarvation", CurTime() + (4 * 60)) --Prevent 323 from starving too quickly
    self:SetNWBool("IsStarving", false)
end

function SWEP:Deploy()
    timer.Simple(0, function ()
        if self and IsValid(self) and self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() and SERVER then
            self.Owner:DrawViewModel(false)
        end
    end)
end

function SWEP:DrawWorldModel() end

SWEP.NextAttack = 0

function SWEP:PrimaryAttack()
    if self.NextAttack > CurTime() then return end
    if not IsFirstTimePredicted() then return end
    self.NextAttack = CurTime() + 0.15
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
            if ent:IsPlayer() and ent:Team() != TEAM_SCP and ent:Team() != TEAM_SPEC then
                self:SetNWInt("NextStarvation", math.max(CurTime() + 60, self:GetNWInt("NextStarvation", CurTime() + 60)))
                ent:TakeDamage(25, self, self.Owner)
            elseif ent:GetClass() == "func_breakable" then
                ent:TakeDamage(200, self, self.Owner)
            elseif BREACH_IsGateDoor(ent) then
                ent:TakeDamage(math.random(20, 100), self, self.Owner)
            end
        end
    end
end

if SERVER then
    timer.Create("WendigoProcess", 1, 0, function ()
        for k,v in pairs(player.GetAll()) do
            if v:GetNClass() == ROLE_SCP323 then
                local w = v:GetWeapon("weapon_scp323")
                if IsValid(w) then
                    if w:GetNWBool("IsStarving", false) then
                        if w:GetNWInt("NextStarvation", CurTime() + 40) > CurTime() then
                            w:SetNWBool("IsStarving", false)
                            return
                        end
                        v:TakeDamage(10, w, v)
                    elseif w:GetNWBool("NextStarvation", CurTime() + 40) < CurTime() then
                        w:SetNWBool("IsStarving", true)
                    end
                end
            end
        end
    end)
end

function SWEP:DrawHUD()
    if disablehud == true then return end

    local showtext = "Starving, find food quick!"
    local showcolor = Color(255,0,0)
    local ns = self:GetNWInt("NextStarvation", CurTime() + 40)
    if ns > CurTime() then
        showtext = "Hungry in " .. math.Round(ns - CurTime())
        showcolor = Color(255,255,0)
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