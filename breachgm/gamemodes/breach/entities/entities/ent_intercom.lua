AddCSLuaFile()
ENT.Type = "anim"
ENT.Category = "Breach"
ENT.Spawnable = false
ENT.PrintName = "Intercom"
ENT.Author = "Aurora"
ENT.Contact = ""
ENT.Purpose = "Use this entity to broadcast your voice throughout the facility."
ENT.Model = "models/props/cs_office/phone.mdl"
function ENT:Initialize()
  if not SPAWN_INTERCOM then
    print("Mapconfig: no intercom spawns.")
    if SERVER then
      self:Remove()
    end
    return
  end
  self:SetPos(SPAWN_INTERCOM)
  self:SetModel(self.Model)
  if SPAWN_INTERCOM_ANGLES then
    self:SetAngles(SPAWN_INTERCOM_ANGLES)
  end
  self:PhysicsInit( SOLID_VPHYSICS )
  self:SetUseType( SIMPLE_USE )
  local p = self:GetPhysicsObject()

  if IsValid(p) then
    p:Wake()
    p:EnableMotion( false )
    p:EnableGravity( false )
  end
end

ENT.User = nil
function ENT:Use(a, c)

  if self.User and IsValid(self.User) and IsValid(c) and c:IsPlayer() then
    c:PrintMessage(4, "You cannot use this while somebody else is talking.")
    return
  end
  if IsValid(c) and c:IsPlayer() and not (c.INT_Stopped and c.INT_Stopped + 120 > CurTime()) then
    if c:Team() == TEAM_SCP or c:Team() == TEAM_SPEC then
      return
    end
    self.User = c
    self.User.INT_Stopped = CurTime() + 12
    self.User.INT_IsTalking = true
    self.User:SetNWBool( "intercom", true )
    local d = c
    local sid = d:SteamID64()
    --This will prevent user from talking indefinately if the round ends
    hook.Add("BreachEndRound", "BreachEndRound_Silence" .. c:SteamID64(), function ()
      for k,v in pairs(player.GetAll()) do
        v.INT_IsTalking = nil
        v:SetNWBool( "intercom", false )
      end
      hook.Remove("BreachEndRound", "BreachEndRound_Silence" .. sid)
    end)
    timer.Simple(12, function()
      hook.Remove("BreachEndRound", "BreachEndRound_Silence" .. sid)
      for k,v in pairs(player.GetAll()) do
        v.INT_IsTalking = nil
        v:SetNWBool( "intercom", false )
      end
    end)
    c:PrintMessage(4, "You are now speaking over the intercom.")
    return
  elseif IsValid(c) and c:IsPlayer() then
    c:PrintMessage(4, "You cannot use this for another " .. tostring((c.INT_Stopped + 120) - CurTime()) .. " seconds")
    return
  end
end

function ENT:Think()
  if self.User and IsValid(self.User) and self.User:IsPlayer() and self.User.INT_Stopped > CurTime() and self:GetPos():Distance(self.User:GetPos()) < 175 and self.User.INT_IsTalking and self.User:Team() != TEAM_SPEC and self.User:Team() != TEAM_SCP then
    return
  else
    if self.User and IsValid(self.User) then
      self.User.INT_IsTalking = nil
      self.User:SetNWBool( "intercom", false )
    end
    self.User = nil
  end
end
