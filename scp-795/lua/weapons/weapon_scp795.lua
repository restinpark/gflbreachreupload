AddCSLuaFile()

--Sometimes is undefined at weird times?
local ROLE_SCP795 = "SCP-795"
SWEP.droppable = false
SWEP.PrintName = "SCP-795"
SWEP.Author = "Aurora/Ralsei"
SWEP.Instructions = "Primary attacks as normal. Using your secondary ability on hostiles will result in the victim being turned into a harmless rat for several seconds."

local SCRATCH_COOLDOWN = 0.15
local TRANSFORM_COOLDOWN = 10
local TRANSFORM_TIME_MIN = 4
local TRANSFORM_TIME_MAX = 9
--Scale all damage of transformed creatures by this.
local TRANSFORM_DMG_SCALE = 2
--Scale damage from SCP-795's attacks against transformed creatures by this.
local TRANSFORM_DMG_SCALE_795 = 5


SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.DefaultAmmo = -1
SWEP.Primary.ClipSize = -1

SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.DefaultAmmo = -1
SWEP.Secondary.ClipSize = -1

SWEP.NextScratch = 0
SWEP.NextTransformation = 0

function SWEP:DrawWorldModel() end

function SWEP:Deploy()
    local s = self
    timer.Simple(0, function ()
        if s and s.Owner and IsValid(s.Owner) then
            s.Owner:DrawViewModel(false)
        end
    end)
end

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    if self.NextScratch > CurTime() then return end
    self.NextScratch = CurTime() + SCRATCH_COOLDOWN
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
        if ent and IsValid(ent) then
            if ent:IsPlayer() and ent:Team() != TEAM_SPEC and ent:Team() != TEAM_SCP then
                ent:TakeDamage(5, self.Owner, self)
            elseif ent:GetClass() == "func_breakable" then
                ent:TakeDamage(100, self.Owner, self)
            end
        end
    end
end

local function TransformEntity(entity)
    if SERVER and entity and IsValid(entity) and entity:IsPlayer() and entity:Team() != TEAM_SPEC then
        local old_weapons = {}
        for k,v in pairs(entity:GetWeapons()) do
            old_weapons[#old_weapons + 1] = v:GetClass()
        end
        local old_model = entity:GetModel()
        --Sort of an easy check to catch unexpected things such as round resets, etc
        local old_role = entity:GetNClass()
        entity:StripWeapons()
        entity:SetModel(table.Random({"models/tsbb/animals/rat.mdl", "models/tsbb/animals/rat2.mdl"}))
        local e = entity
        timer.Simple(math.random(TRANSFORM_TIME_MIN, TRANSFORM_TIME_MAX), function ()
            if e and IsValid(e) and e:IsPlayer() and e:Team() != TEAM_SPEC and e:GetNClass() == old_role then
                e:SetModel(old_model)
                for k,v in pairs(old_weapons) do
                    local w = e:Give(v, true)
                    if w and IsValid(w) and w.Primary and w.Primary.Ammo != "none" then
                        w:SetClip1(w.Primary.ClipSize)
                    end
                end
            end
        end)
    end
end


--Prevent 795 from picking up other weapons, prevent others from picking up 795's weapon, and prevent transformed players from picking up any weapon
hook.Add("PlayerCanPickupWeapon", "PlayerCanPickupWeapon_SCP795", function (ply, wep)
    if ply:GetNClass() == ROLE_SCP795 then
        return wep:GetClass() == "weapon_scp795"
    end

    if ply:GetNClass() != ROLE_SCP795 and wep:GetClass() == "weapon_scp795" then
        return false
    end

    if ply:GetModel() == "models/tsbb/animals/rat.mdl" or ply:GetModel() == "models/tsbb/animals/rat2.mdl" then
        return false
    end
end)

hook.Add("EntityTakeDamage", "EntityTakeDamage_SCP795", function (target, dmginfo)
    if target and IsValid(target) and target:IsPlayer() and target:GetNClass() == ROLE_SCP795 then
        local attacker = dmginfo:GetAttacker()
        if attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:Team() != TEAM_SPEC and attacker:Team() != TEAM_SCP and math.random(1, 15) == 4 then
            TransformEntity(attacker)
        end
    elseif target and IsValid(target) and target:IsPlayer() and (target:GetModel() == "models/tsbb/animals/rat.mdl" or target:GetModel() == "models/tsbb/animals/rat2.mdl") then
        local attacker = dmginfo:GetAttacker()
        if attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:GetNClass() == ROLE_SCP795 then
            dmginfo:ScaleDamage(TRANSFORM_DMG_SCALE_795)
        else
            dmginfo:ScaleDamage(TRANSFORM_DMG_SCALE)
        end
    end
end)

function SWEP:SecondaryAttack()
    if not IsFirstTimePredicted() then return end
    if preparing or postround then return end
    if self.NextTransformation > CurTime() then return end
    self.NextTransformation = CurTime() + TRANSFORM_COOLDOWN
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
        if ent and IsValid(ent) and ent:IsPlayer() and ent:Team() != TEAM_SCP and ent:Team() != TEAM_SPEC then
            TransformEntity(ent)
        end
    end
end

function SWEP:DrawHUD()
    if disablehud == true then return end

    local showtext = "Ready to transform"
    local showcolor = Color(0,255,0)

    if self.NextTransformation > CurTime() then
    	showtext = "Next transformation in " .. math.Round(self.NextTransformation - CurTime())
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