AddCSLuaFile()
SWEP.PrintName = "SCP-689"
SWEP.Author = ""
SWEP.Purpose = "Dispatch"
SWEP.Instructions = "Primary Fire - Attack // Secondary Fire - Teleport to last viewer"
SWEP.droppable = false

function SWEP:IsLookingAt( ply )
    local yes = ply:GetAimVector():Dot( ( self.Owner:GetPos() - ply:GetPos() + Vector( 70 ) ):GetNormalized() )
    return yes > 0.39
end

SWEP.IsBeingWatched = false
--SWEP.PeopleWhoLooked = {}
SWEP.LastViewer = nil

function SWEP:Think()
    local obs = 0
    for k,v in pairs(player.GetAll()) do
        local tr_eyes = util.TraceLine( {
                start = v:EyePos() + v:EyeAngles():Forward() * 15,
                endpos = self.Owner:EyePos(),
            } )
                local tr_center = util.TraceLine( {
                start = v:LocalToWorld( v:OBBCenter() ),
                endpos = self.Owner:LocalToWorld( self.Owner:OBBCenter() ),
                filter = v
            } )
        if (tr_eyes.Entity == self.Owner or tr_center.Entity == self.Owner) and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP and self:IsLookingAt(v) and self.Owner != v then
            obs = obs + 1
            --self.PeopleWhoLooked[v] = true
            self.LastViewer = v
        end
    end
    if obs > 0 then
        self.IsBeingWatched = true
    else
        self.IsBeingWatched = false
    end
    if self.LastViewer and IsValid(self.LastViewer) and (self.LastViewer:Team() == TEAM_SPEC or self.LastViewer:Team() == TEAM_SCP) then
        self.LastViewer = nil
    end
    --for k,v in pairs(self.PeopleWhoLooked) do
    --    if not IsValid(k) or k:Team() == TEAM_SCP or k:Team() == TEAM_SPEC then
    --        self.PeopleWhoLooked[k] = nil
    --    end
    --end
end

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    local owner = self.Owner
    timer.Simple(0, function ()
        if owner and IsValid(owner) and owner:IsPlayer() then
            owner:DrawViewModel(false)
        end
    end)
end

function SWEP:DrawWorldModel() end

SWEP.NextPrimaryAttack = 0

SWEP.PrimaryCooldown = 0.3

SWEP.NextSecondaryAttack = 0

SWEP.SecondaryCooldown = 10

SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

--Attack the target
function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    if self.NextPrimaryAttack > CurTime() then return end
    self.NextPrimaryAttack = CurTime() + self.PrimaryCooldown
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
		if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
            ent:TakeDamage(55, self.Owner, self)
        elseif ent and IsValid(ent) and ent:GetClass() == "func_breakable" then
            ent:TakeDamage(125, self.Owner, self)
        elseif ent and IsValid(ent) and BREACH_IsGateDoor(ent) then
            ent:TakeDamage(math.random(20, 100), self.Owner, self)
        end
    end
end

--Teleport to a random person who has looked
function SWEP:SecondaryAttack()
    if not IsFirstTimePredicted() then return end
    if self.NextSecondaryAttack > CurTime() then return end
    if not self.LastViewer or not IsValid(self.LastViewer) or self.IsBeingWatched then return end
    if self.LastViewer:Team() == TEAM_SPEC or self.LastViewer:Team() == TEAM_SCP then
	if ent:GetNClass() == ROLE_SCP181 and math.random(1, 2) == 2 then return end
        self.LastViewer = nil
        return
    end
    self.NextSecondaryAttack = CurTime() + self.SecondaryCooldown
    if SERVER then
        local owner = self.Owner
        owner:SetPos(self.LastViewer:GetPos())
        owner:Lock()
        timer.Simple(0.75, function ()
            owner:UnLock()
        end)
    end
    self.LastViewer = nil
end

function SWEP:DrawHUD()
    if disablehud == true then return end
    local specialstatus = ""
    local showtext = ""
    local showtextlook = "Noone is looking"
    local lookcolor = Color(0,255,0)
    local showcolor = Color(17, 145, 66)
    if self.NextSecondaryAttack > CurTime() then
        specialstatus = "Special ready to use in " .. math.Round(self.NextSecondaryAttack - CurTime())
        showcolor = Color(145, 17, 62)
    else
        local lv = self.LastViewer
        local nm
        if lv and IsValid(lv) and lv:IsPlayer() then
            nm = lv:Nick()
        end
        if nm == nil then
            specialstatus = "Can't teleport: No target"
        else
            specialstatus = "Teleport to " .. nm
        end
    end
    showtext = specialstatus
    if self.IsBeingWatched then
        showtextlook = "Somebody is watching"
        lookcolor = Color(145, 17, 62)
    end

    draw.Text( {
        text = showtext,
        pos = { ScrW() / 2, ScrH() - 50 },
        font = "173font",
        color = showcolor,
        xalign = TEXT_ALIGN_CENTER,
        yalign = TEXT_ALIGN_CENTER,
    })

    draw.Text( {
        text = showtextlook,
        pos = { ScrW() / 2, ScrH() - 25 },
        font = "173font",
        color = lookcolor,
        xalign = TEXT_ALIGN_CENTER,
        yalign = TEXT_ALIGN_CENTER,
    })

    local x = ScrW() / 2.0
    local y = ScrH() / 2.0

    local scale = 0.3
    surface.SetDrawColor( Color(255,0,0) )

    local gap = 5
    local length = gap + 20 * scale
    surface.DrawLine( x - length, y, x - gap, y )
    surface.DrawLine( x + length, y, x + gap, y )
    surface.DrawLine( x, y - length, x, y - gap )
    surface.DrawLine( x, y + length, x, y + gap )
end