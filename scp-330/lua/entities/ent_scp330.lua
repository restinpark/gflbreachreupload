AddCSLuaFile()

ENT.PrintName = "SCP-330"
ENT.Author = "Ralsei / Aurora"
ENT.Type = "anim"
ENT.Category = "Aurora"
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Please take only one or two."
ENT.CANDY_TAKERS = {}

function ENT:Initialize()
    self:SetModel("models/props/scp330/scp330.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    if SERVER then ServerLog("Candy taker's table: " .. tostring(table.Count(self.CANDY_TAKERS)) .. "\n") end
    self.CANDY_TAKERS = {}
    if SERVER then
        self:SetUseType(3)
        if SPAWN_330 then
            self:SetPos(SPAWN_330)
        else
            self:Remove()
        end
        local phys = self:GetPhysicsObject()
        if phys and IsValid(phys) then
            phys:EnableMotion(false)
        end
    end
end


hook.Add("BreachStartRound", "BreachStartRound_ResetSCP330", function ()
    for k,v in pairs(player.GetAll()) do
        if SERVER then
            v:SetNWInt("SCP330_TookMore", -1)
        end
    end
end)

hook.Add("PlayerCanPickupWeapon", "CanPlayerPickup_SCP330", function (ply, wep) 
    if ply and IsValid(ply) and ply:IsPlayer() and ply:Team() ~= TEAM_SCP and ply:Team() ~= TEAM_SPEC  then
        if ply:GetNWInt("SCP330_TookMore", -1) > CurTime() then
            return false
        elseif ply:GetNWInt("SCP330_TookMore", -1) ~= -1 then
            ply:SetNWInt("SCP330_TookMore", -1)
        end
    end
end)

hook.Add("PlayerDeath", "PlayerDeath_SCP330", function (ply)
    if SERVER then
        ply:SetNWInt("SCP330_TookMore", -1)
    end
end)

function ENT:Use(activator, caller)
    if SERVER and caller and IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SCP and caller:Team() ~= TEAM_SPEC and caller:GetNClass() ~= ROLE_999 then
        --print(self.CANDY_TAKERS[caller])
        if not self.CANDY_TAKERS[caller] then
            self.CANDY_TAKERS[caller] = 0
        end
        self.CANDY_TAKERS[caller] = self.CANDY_TAKERS[caller] + 1
        if self.CANDY_TAKERS[caller] > 2 then
            caller:TakeDamage(30, self, self)
            for k,wep in pairs(caller:GetWeapons()) do
                if IsValid(wep) and wep != nil and IsValid(caller) then
                    if wep.Primary and wep.Primary.Ammo != "none" then
                        wep.SavedAmmo = wep:Clip1()
                    end
                    caller:DropWeapon( wep )
                    caller:ConCommand( "lastinv" )
                end
            end
            caller:SetNWInt("SCP330_TookMore", CurTime() + 120)
            if caller.SetBleeding then
                caller:SetBleeding(true)
            end
        elseif self.CANDY_TAKERS[caller] == 1 then
            caller:Give(table.Random({"item_scp330_red", "item_scp330_yellow"}))
        elseif self.CANDY_TAKERS[caller] == 2 then
            caller:Give("item_scp330_blue")
        end
    end
end