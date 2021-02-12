--taken from ttt
-- Simple client-based idle checking
local idle = {ang = nil, pos = nil, mx = 0, my = 0, t = 0}
function CheckIdle()
   local client = LocalPlayer()
   if not IsValid(client) then return end

   if not idle.ang or not idle.pos then
      -- init things
      idle.ang = client:GetAngles()
      idle.pos = client:GetPos()
      idle.mx = gui.MouseX()
      idle.my = gui.MouseY()
      idle.t = CurTime()

      return
   end
   if client:GetNClass() == ROLE_SPEC then return end
   if client:GetNClass() == ROLE_SCP079 then return end
   if gamestarted and client:Alive() then
      local idle_limit = 300
      if idle_limit <= 0 then idle_limit = 300 end -- networking sucks sometimes


      if client:GetAngles() != idle.ang then
         -- Normal players will move their viewing angles all the time
         idle.ang = client:GetAngles()
         idle.t = CurTime()
      elseif gui.MouseX() != idle.mx or gui.MouseY() != idle.my then
         -- Players in eg. the Help will move their mouse occasionally
         idle.mx = gui.MouseX()
         idle.my = gui.MouseY()
         idle.t = CurTime()
      elseif client:GetPos():Distance(idle.pos) > 10 then
         -- Even if players don't move their mouse, they might still walk
         idle.pos = client:GetPos()
         idle.t = CurTime()
      elseif CurTime() > (idle.t + idle_limit) then

      timer.Simple(0.3, function()
        net.Start("BreachAFKSpec")
        net.SendToServer()
        RunConsoleCommand("br_cl_idlepopup")
      end)
      elseif CurTime() > (idle.t + (idle_limit / 2)) then
         -- will repeat

      end
   end
end
timer.Create( "autoafkcheck", 5, 0, CheckIdle )
--end afk checker
