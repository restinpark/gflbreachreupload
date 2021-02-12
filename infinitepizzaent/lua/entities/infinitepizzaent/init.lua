

--Pull required addon if there is a spawn set for this map, if there is not a spawn set, then this ENT will not spawn.
if SPAWN_458 then
  resource.AddWorkshop("130298137")
end







function ENT:Initialize()

  self:SetModel("models/props/hhp227/pizza01.mdl")
  self:PhysicsInit(SOLID_VPHYSICS)
  self:SetMoveType(MOVETYPE_VPHYSICS)
  self:SetSolid(SOLID_VPHYSICS)

  --I'm pretty sure this is redundent (It's called by SetSolid())
  local phys = self:GetPhysicsObject()

  if phys:IsValid() then

    phys:Wake()

  end
end

local PIZZA_MESSAGES = {
  [1] = "The Krusty Krab pizza is the pizza for you and the SCPs!",
  [2] = "This pizza has pineapple on it. Disgusting!",
  [3] = "An average pizza.",
}


--caller is the player here
function ENT:Use( activator, caller, useType, value )
  if IsValid(caller) and caller:IsPlayer() and caller:Team() != TEAM_SCP and caller:Team() != TEAM_SPEC then
    if (caller:Health() / caller:GetMaxHealth()) >= 0.8 then
      caller:PrintMessage(4, "You do not appear to be hungry! (Health >= 80)")
      return
    end
    caller:SetHealth(caller:GetMaxHealth())
    local message = table.Random(PIZZA_MESSAGES)
    caller:PrintMessage(4, message)
  end
  local pos = self:GetPos()
  self:Remove()
  timer.Simple(60, function ()
    local pizza = ents.Create("infinitepizzaent")
    if IsValid(pizza) then
      pizza:SetPos(SPAWN_458)
      pizza:Spawn()
    end
  end)
  if SERVER and caller:GetNWString("Sign", "unset") == "7" then
					if caller:GetAmmoCount(12) > 2 then
					caller:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
					caller:PrintMessage(3, "Contract Complete!")
					caller:StripWeapon("weapon_scp_350")
					caller:SetNWString("350", "clear")
					caller:SetNWString("Sign", "clear")
					else
					caller:GiveAmmo(1, "AlyxGun", true)
				end
			end
end

--Need to include the shared file
include("shared.lua")
