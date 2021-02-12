--Purpose: Functionality of weapon_scp1471
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function SWEP:Equip(newOwner)
    timer.Simple(0, function ()
        if newOwner and IsValid(newOwner) and newOwner:IsPlayer() then
        --Surpress drawing of viewmodel
        newOwner:DrawViewModel(false)
    end
    if self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() then
        --Surpress drawing of viewmodel
        self.Owner:DrawViewModel(false)
    end
    
    end)
end



--view model fix
timer.Create("SCP1471VMFix", 1, 0, function ()
    for k,v in pairs(player.GetAll()) do
        if v:GetNClass() == ROLE_SCP1471 then
            v:DrawViewModel(false)
        end
    end
end)

function SWEP:DoAttack()
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
            if ent:Team() != TEAM_SPEC and ent:Team() != TEAM_SCP and ent:GetNWBool("MaloInfected", false) then
                ent:TakeDamage(self.Damage, self.Owner, self)
            end
        else
            if ent:GetClass() == "func_breakable" then
                ent:TakeDamage( 100, self.Owner, self )
            end
        end
    end
end

function SWEP:DoSpecial()
    local victim = nil
    local acceptable = {}
    for k,v in pairs(player.GetAll()) do
        if v:Team() != TEAM_SCP and v:Team() != TEAM_SPEC and v:GetNWBool("MaloInfected", false) then
            acceptable[#acceptable + 1] = v
        end
    end
    if #acceptable > 0 then
        victim = table.Random(acceptable)
        if IsValid(victim) and IsValid(self.Owner) then
            --victim:PrintMessage(3, "SCP-1471 has teleported to you.")
            self.Owner:SetPos(victim:GetPos())
            self.NextAttack = CurTime() + 1
            self.Owner:PrintMessage(3, "Stunned! You cannot attack for 1 second.")
           
            --Also make malo drunk
            net.Start("BREACH_294_DRUNK")
		    net.WriteInt(2, 8)
		    net.Send(self.Owner)
        end
    else
        self.Owner:PrintMessage(4, "No acceptable victims could be found to use this ability on.")
        self:SetNWInt("NextSpecial", 0)
        self:CallOnClient("ResetSpecialCounter")
    end
end
