AddCSLuaFile()
ROLE_SCP607 = ROLE_SCP607 or "SCP-607"
if SERVER then
    include("breach/components/scp607.lua")
end
SWEP.PrintName = "SCP-607"
SWEP.Author = "Aurora"

SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"

SWEP.Secondary = SWEP.Primary
SWEP.HoldType = "normal"
SWEP.droppable = false

function SWEP:DrawWorldModel() end

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    timer.Simple(0, function ()
        if self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() then
            self.Owner:DrawViewModel(false)
        end
    end)
end

SWEP.Instructions = "Bind to a human using the primary attack key. Damage to you will now affect your owner."
if SERVER then
    util.AddNetworkString("SCP607_InformBinding")
end
SWEP.LEventTimer = -1

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
    if not SERVER then return end
    if not EVENT_TIMERS then
        print("warning! eventTimers component is possibly missing, the swep cannot function without this.")
        return
    end
    local dev = self:GetNWEntity("Devotion")
    if dev and IsValid(dev) and dev:IsPlayer() and dev:Team() ~= TEAM_SPEC and dev:Team() ~= TEAM_SCP then
        return
    else
        self:GetNWEntity("Devotion", NULL)
    end

    local ent = nil
    local tr = util.TraceHull( {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 ),
        filter = self.Owner,
        mins = Vector( -10, -10, -10 ),
        maxs = Vector( 10, 10, 10 ),
        mask = MASK_SHOT_HULL
    })
    ent = tr.Entity
    if IsValid(ent) and ent:IsPlayer() and ent:Team() ~= TEAM_SCP and ent:Team() ~= TEAM_SPEC then
        if not EVENT_TIMERS[self.LEventTimer] then
            local so = self.Owner
            local s = self
            self.LEventTimer = BREACH_SetupEventTimer(self.Owner, CurTime() + 0.5, function ()
                if not IsValid(so) then return true end
                if not IsValid(ent) then return true end
                if so:Team() ~= TEAM_SCP then return true end
                if so:GetNClass() ~= ROLE_SCP607 then return true end
                if ent:Team() == TEAM_SCP or ent:Team() == TEAM_SPEC then return true end
                local check = util.TraceHull( {
                    start = so:GetShootPos(),
                    endpos = so:GetShootPos() + ( so:GetAimVector() * 100 ),
                    filter = so,
                    mins = Vector( -10, -10, -10 ),
                    maxs = Vector( 10, 10, 10 ),
                    mask = MASK_SHOT_HULL
                })
                if check.Entity ~= ent then
                    return true
                end
                return false
            end, function ()
                if s and IsValid(s) and so and IsValid(so) and so:GetNClass() == ROLE_SCP607 and IsValid(ent) and ent:IsPlayer() and ent:Team() ~= TEAM_SCP and ent:Team() ~= TEAM_SPEC then
                    s:SetNWEntity("Devotion", ent)
                    net.Start("SCP607_InformBinding")
                    net.Send(ent)
                    so:SetHealth(100)
                    so:SetMaxHealth(100)
                end
            end, "Binding " .. ent:Nick())
        else
            print("event timer already in progress, not starting another one.")
            return
        end
    end
end

if CLIENT then
    net.Receive("SCP607_InformBinding", function ()
        chat.AddText(Color(52, 12, 12), "SCP-607 has its life force to yours.")
    end)
end

function SWEP:DrawHUD()
	if disablehud == true then return end

	local showtext = "Ready to bind"
	local showcolor = Color(0,255,0)

	if IsValid(self:GetNWEntity("Devotion")) then
		showtext = self:GetNWEntity("Devotion"):Nick() .. " is linked to your life force."
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
