include("shared.lua")
S294C = ""
local MAX_LEN = 40

local CODES_TO_STRING = {
	[KEY_0] = "0",
	[KEY_1] = "1",
	[KEY_2] = "2",
	[KEY_3] = "3",
	[KEY_4] = "4",
	[KEY_5] = "5",
	[KEY_6] = "6",
	[KEY_7] = "7",
	[KEY_8] = "8",
	[KEY_9] = "9",
	[KEY_A] = "a",
	[KEY_B] = "b",
	[KEY_C] = "c",
	[KEY_D] = "d",
	[KEY_E] = "e",
	[KEY_F] = "f",
	[KEY_G] = "g",
	[KEY_H] = "h",
	[KEY_I] = "i",
	[KEY_J] = "j",
	[KEY_K] = "k",
	[KEY_L] = "l",
	[KEY_M] = "m",
	[KEY_N] = "n",
	[KEY_O] = "o",
	[KEY_P] = "p",
	[KEY_Q] = "q",
	[KEY_R] = "r",
	[KEY_S] = "s",
	[KEY_T] = "t",
	[KEY_U] = "u",
	[KEY_V] = "v",
	[KEY_W] = "w",
	[KEY_X] = "x",
	[KEY_Y] = "y",
	[KEY_Z] = "z"
}

local function HandleInput(this, keycode)
	if keycode == KEY_BACKSPACE then
		S294C = string.sub(S294C, 1, -2)
		surface.PlaySound("scp294/beep.ogg")
	elseif keycode == KEY_SPACE and string.len(S294C) < MAX_LEN then
		S294C = S294C .. " "
		surface.PlaySound("scp294/beep.ogg")
	elseif keycode == KEY_MINUS and string.len(S294C) < MAX_LEN then
		S294C = S294C .. "-"
		surface.PlaySound("scp294/beep.ogg")
	elseif CODES_TO_STRING[keycode] and string.len(S294C) < MAX_LEN then
		S294C = S294C .. CODES_TO_STRING[keycode]
		surface.PlaySound("scp294/beep.ogg")
	elseif keycode == KEY_ENTER and S294P and IsValid(S294P) then
		if S294C == "" then return end
		surface.PlaySound("scp294/beep.ogg")
		net.Start("SCP294_RequestDrinkSpawn")
			net.WriteString(S294C)
		net.SendToServer()
		S294P:Remove()
	end
end

function CreateButton(x,y,key)
	local Key = vgui.Create( "DButton", S294P)
	Key:SetPos( x, y )
	Key:SetText( "" )
	Key:SetSize( ScrW()*0.07, ScrH()*0.13 )
	Key.DoClick = function()
		surface.PlaySound("scp294/beep.ogg")
		if string.len(S294C) < MAX_LEN then
			S294C = S294C .. key
		end
	end
	Key.Paint = function()
	end
	Key.OnKeyCodePressed = HandleInput
end

function ENT:Initialize()
end

function ENT:Draw()
  self:DrawModel()
end

function ENT:Think()
end

function SCP294Panel()
	local ent	=	net.ReadEntity()
	local W, H 	= ScrW(), ScrH()
	S294C = ""
	S294P = vgui.Create( "DFrame" )
	S294P:SetPos( 0, 0 )
	S294P:SetSize( W, H )
	S294P:SetTitle("")
	S294P:SetDraggable( false )
	S294P:ShowCloseButton( true )
	S294P:MakePopup()
	S294P.Paint = function()
		if ( file.Exists( "materials/vgui/scp294/clavier.jpg", "GAME" ) ) then
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( Material("vgui/scp294/clavier.jpg") )
			surface.DrawTexturedRect( 0, 0, W, H )
			draw.SimpleText( "Command : " .. S294C, "DermaLarge", 10, 10 )
		else
			draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color(0,0,0,255) )
			draw.SimpleText( "YOU HAVE NOT THE CONTENT OF SCP 294", "DermaLarge", 10, 10, Color(255,0,0) )
			draw.SimpleText( "INSTALL THE ADDON OF SCP 294 TO SEE THE CONTENT !!!!", "DermaLarge", 10, 50, Color(255,0,0) )
		end
	end
	
	S294P.Think = function () end

	S294P.OnKeyCodePressed = HandleInput

	CreateButton(W*0.115,H*0.235,"1")
	CreateButton(W*0.19,H*0.235,"2")
	CreateButton(W*0.265,H*0.235,"3")
	CreateButton(W*0.34,H*0.235,"4")
	CreateButton(W*0.415,H*0.235,"5")
	CreateButton(W*0.49,H*0.235,"6")
	CreateButton(W*0.57,H*0.235,"7")
	CreateButton(W*0.645,H*0.235,"8")
	CreateButton(W*0.725,H*0.235,"9")
	CreateButton(W*0.8,H*0.235,"0")

	CreateButton(W*0.115,H*0.37,"q")
	CreateButton(W*0.19,H*0.37,"w")
	CreateButton(W*0.265,H*0.37,"e")
	CreateButton(W*0.34,H*0.37,"r")
	CreateButton(W*0.415,H*0.37,"t")
	CreateButton(W*0.49,H*0.37,"y")
	CreateButton(W*0.57,H*0.37,"u")
	CreateButton(W*0.645,H*0.37,"i")
	CreateButton(W*0.725,H*0.37,"o")
	CreateButton(W*0.8,H*0.37,"p")

	CreateButton(W*0.115,H*0.505,"a")
	CreateButton(W*0.19,H*0.505,"s")
	CreateButton(W*0.265,H*0.505,"d")
	CreateButton(W*0.34,H*0.505,"f")
	CreateButton(W*0.415,H*0.505,"g")
	CreateButton(W*0.49,H*0.505,"h")
	CreateButton(W*0.57,H*0.505,"j")
	CreateButton(W*0.645,H*0.505,"k")
	CreateButton(W*0.725,H*0.505,"l")

	CreateButton(W*0.115,H*0.64,"z")
	CreateButton(W*0.19,H*0.64,"x")
	CreateButton(W*0.265,H*0.64,"c")
	CreateButton(W*0.34,H*0.64,"v")
	CreateButton(W*0.415,H*0.64,"b")
	CreateButton(W*0.49,H*0.64,"n")
	CreateButton(W*0.57,H*0.64,"m")
	CreateButton(W*0.645,H*0.64,"-")
	CreateButton(W*0.725,H*0.64," ")

	local Cancel = vgui.Create( "DButton", S294P)
	Cancel:SetPos( W*0.8, H*0.64 )
	Cancel:SetText( "" )
	Cancel:SetSize( ScrW()*0.07, ScrH()*0.13 )
	Cancel.DoClick = function()
		surface.PlaySound("scp294/beep.ogg")
		S294C = string.sub( S294C, 0, #S294C-1 )
	end
	
	Cancel.Paint = function() end

	local Enter = vgui.Create( "DButton", S294P)
	Enter:SetPos( W*0.8, H*0.505 )
	Enter:SetText( "" )
	Enter:SetSize( ScrW()*0.07, ScrH()*0.13 )
	Enter.DoClick = function()
		if S294C == "" then return end
		surface.PlaySound("scp294/beep.ogg")
		net.Start("SCP294_RequestDrinkSpawn")
			net.WriteString(S294C)
		net.SendToServer()
		S294P:Remove()
	end
	Enter.Paint = function() end

	local Close = vgui.Create( "DButton", S294P)
	Close:SetPos( W*0.93, H*0.95 )
	Close:SetText( "" )
	Close:SetSize( ScrW()*0.07, ScrH()*0.05 )
	Close.DoClick = function()
		S294P:Remove()
		surface.PlaySound("scp294/beep.ogg")
	end
	Close.Paint = function()
		draw.SimpleText( "Close", "DermaLarge", 10, 10, Color(255,255,255) )
	end

end

net.Receive("OpenSCP294Panel", SCP294Panel )
