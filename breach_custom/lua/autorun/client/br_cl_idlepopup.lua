BR_IDLE_AFK_FRAME = nil
function ShowAFKMessage()
  if IsValid(BR_IDLE_AFK_FRAME) then
	BR_IDLE_AFK_FRAME:Remove()
  end
  local BR_IDLE_AFK_FRAME = vgui.Create("DFrame")
  
  BR_IDLE_AFK_FRAME:SetSize( 225, 150 )
  BR_IDLE_AFK_FRAME:Center()
  BR_IDLE_AFK_FRAME:SetTitle( "Moved to spectators" )
  BR_IDLE_AFK_FRAME:SetDraggable( false )
  BR_IDLE_AFK_FRAME:MakePopup()
  local DLabel = vgui.Create( "DLabel", BR_IDLE_AFK_FRAME )
  DLabel:SetPos(10,50)
  DLabel:SetSize(200, 22)
  DLabel:SetWrap(true)
  DLabel:SetText( "You have been moved to spectators for being idle." )
  local DermaButton = vgui.Create( "DButton", BR_IDLE_AFK_FRAME )
  DermaButton:SetText( "Come back" )
  DermaButton:SetPos( 25, 120 )
  DermaButton:SetSize(80, 22)
  DermaButton.DoClick = function()
    net.Start("BreachReturnFromAFK")
    net.SendToServer()
    BR_IDLE_AFK_FRAME:Close()
  end
  local DermaButton1 = vgui.Create( "DButton", BR_IDLE_AFK_FRAME )
  DermaButton1:SetText( "Close" )
  DermaButton1:SetPos( 115, 120 )
  DermaButton1:SetSize(80, 22)
  DermaButton1.DoClick = function()
    BR_IDLE_AFK_FRAME:Close()
  end
end

concommand.Add( "br_cl_idlepopup", ShowAFKMessage, nil, nil, FCVAR_CLIENTCMD_CAN_EXECUTE )



hook.Add("PlayerButtonDown", "PlayerButtonDown_PointerToggleBreach", function (ply, btn)
  if ply == LocalPlayer() and btn == KEY_F9 then
    gui.EnableScreenClicker(false)
  end
end)