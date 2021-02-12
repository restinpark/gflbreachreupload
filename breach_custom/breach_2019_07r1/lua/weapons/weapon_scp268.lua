if SERVER then
    resource.AddWorkshop("1316693206")

    hook.Add("PlayerCanPickupWeapon", "PlayerCanPickupWeapon_SCP268", function (ply, wep)
        if wep and IsValid(wep) and wep:GetClass() == "weapon_scp268" and wep:GetNWFloat("PickupBlockedUntil", 0) > CurTime() then
            return false
        end
    end)

    hook.Add("EntityTakeDamage", "EntityTakeDamage_SCP268", function (ent)
        if ent and IsValid(ent) and ent:IsPlayer() and ent:HasWeapon("weapon_scp268") then
            local wep = ent:GetWeapon("weapon_scp268")
            if wep and IsValid(wep) and wep:GetNWBool("Active", false) then
                ent:StripWeapon("weapon_scp268")
                local nwep = ents.Create("weapon_scp268")
                if IsValid(nwep) then
                    nwep:SetPos(ent:GetPos() + (ent:GetAimVector() * 15))
                    nwep:SetNWFloat("PickupBlockedUntil", CurTime() + 3)
                    nwep:Spawn()
                end
            end
        end
    end)
    timer.Create("SCP268_BleedingDamage", 1, 0, function ()
        for k,v in pairs(player.GetAll()) do
            if v and v:HasWeapon("weapon_scp268") then
                local hat = v:GetWeapon("weapon_scp268")
                if hat and IsValid(hat) and hat:GetNWBool("Active", false) then
                      v:SetHealth(v:Health() - math.random(5, 10), 0, v:GetMaxHealth())
                      if v:Health() <= 0 then
                        v:PrintMessage(3, "You faded away.")
                        v:Kill()  
                      end
                end
            end
        end
    end)
end

if CLIENT then
    hook.Add("PrePlayerDraw", "PrePlayerDraw_SCP268", function (ply)
        if ply and IsValid(ply) and ply:IsPlayer() and ply:HasWeapon("weapon_scp268") then
            local w = ply:GetWeapon("weapon_scp268")
            if w and IsValid(w) then
                local x = w:GetNWBool("Active", false)
                if x then
                    --Hide the player if the cap is activated
                    return true
                end
            end
        end
    end)
end

SWEP.PrintName = "SCP-268"
SWEP.Author = "Aurora"
SWEP.Instructions = "Toggle on and off w/ primary fire"
SWEP.Purpose = "When active, hides the user from others."

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Secondary = SWEP.Primary
SWEP.WorldModel = "models/autism/autism_hat.mdl"

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

--Hide model unless it is on the ground
function SWEP:DrawWorldModel()
    if not self.Owner or not IsValid(self.Owner) then
        self:DrawModel()
    end
end

SWEP.NextToggle = 0

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    if self.NextToggle > CurTime() then return end
    self.NextToggle = CurTime() + 0.2

    local val = self:GetNWBool("Active", false)
    self:SetNWBool("Active", not val)
end

function SWEP:SecondaryAttack() end
function SWEP:Reload() end

function SWEP:DrawHUD()
    if disablehud == true then return end

    local showtext = "Equipped"
    local showcolor = Color(0,255,0)

    if not self:GetNWBool("Active", false) then
        showtext = "Holstered"
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