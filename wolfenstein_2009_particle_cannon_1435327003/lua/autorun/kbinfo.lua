AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )

CreateClientConVar( "sfw_debug_kbinfo", "0", false, false )

local keyboard = {

	KEY_FIRST,
	KEY_NONE,
	KEY_0,
	KEY_1,
	KEY_2,
	KEY_3,
	KEY_4,
	KEY_5,
	KEY_6,
	KEY_7,
	KEY_8,
	KEY_9,
	KEY_A,
	KEY_B,
	KEY_C,
	KEY_D,
	KEY_E,
	KEY_F,
	KEY_G,
	KEY_H,
	KEY_I,
	KEY_J,
	KEY_K,
	KEY_L,
	KEY_M,
	KEY_N,
	KEY_O,
	KEY_P,
	KEY_Q,
	KEY_R,
	KEY_S,
	KEY_T,
	KEY_U,
	KEY_V,
	KEY_W,
	KEY_X,
	KEY_Y,
	KEY_Z,
	KEY_PAD_0,
	KEY_PAD_1,
	KEY_PAD_2,
	KEY_PAD_3,
	KEY_PAD_4,
	KEY_PAD_5,
	KEY_PAD_6,
	KEY_PAD_7,
	KEY_PAD_8,
	KEY_PAD_9,
	KEY_PAD_DIVIDE,
	KEY_PAD_MULTIPLY,
	KEY_PAD_MINUS,
	KEY_PAD_PLUS,
	KEY_PAD_ENTER,
	KEY_PAD_DECIMAL,
	KEY_LBRACKET,
	KEY_RBRACKET,
	KEY_SEMICOLON,
	KEY_APOSTROPHE,
	KEY_BACKQUOTE,
	KEY_COMMA,
	KEY_PERIOD,
	KEY_SLASH,
	KEY_BACKSLASH,
	KEY_MINUS,
	KEY_EQUAL,
	KEY_ENTER,
	KEY_SPACE,
	KEY_BACKSPACE,
	KEY_TAB,
	KEY_CAPSLOCK,
	KEY_NUMLOCK,
	KEY_ESCAPE,
	KEY_SCROLLLOCK,
	KEY_INSERT,
	KEY_DELETE, 	
	KEY_HOME,
	KEY_END,	
	KEY_PAGEUP, 	
	KEY_PAGEDOWN,
	KEY_BREAK,	
	KEY_LSHIFT,
	KEY_RSHIFT,	
	KEY_LALT,
	KEY_RALT,
	KEY_LCONTROL,
	KEY_RCONTROL,
	KEY_LWIN,
	KEY_RWIN,
	KEY_APP,
	KEY_UP,
	KEY_LEFT,
	KEY_DOWN,
	KEY_RIGHT,
	KEY_F1,
	KEY_F2,
	KEY_F3,
	KEY_F4,
	KEY_F5,	
	KEY_F6,	
	KEY_F7,
	KEY_F8,
	KEY_F9,	
	KEY_F10,	
	KEY_F11,
	KEY_F12,	
	KEY_CAPSLOCKTOGGLE,
	KEY_NUMLOCKTOGGLE,
	KEY_LAST,
	KEY_SCROLLLOCKTOGGLE,
	KEY_COUNT

}

local mouse = {

	MOUSE_LEFT,
	MOUSE_RIGHT,
	MOUSE_MIDDLE,
	MOUSE_4,
	MOUSE_5,
	MOUSE_WHEEL_UP,
	MOUSE_WHEEL_DOWN,
	MOUSE_COUNT,
	MOUSE_FIRST,
	MOUSE_LAST
}

local inputs = {

	IN_ALT1,
	IN_ALT2,
	IN_ATTACK,
	IN_ATTACK2,
	IN_BACK,
	IN_DUCK,
	IN_FORWARD,
	IN_JUMP,
	IN_LEFT,
	IN_MOVELEFT,
	IN_MOVERIGHT,
	IN_RELOAD,
	IN_RIGHT,
	IN_SCORE,
	IN_SPEED,
	IN_USE,
	IN_WALK,
	IN_ZOOM,
	IN_GRENADE1,
	IN_GRENADE2,
	IN_WEAPON1,
	IN_WEAPON2,
	IN_BULLRUSH,
	IN_CANCEL,
	IN_RUN

}

function ArrangeElements( minvalue, maxvalue )

	if ( CurTime() % 2 == 0 ) then
	return minvalue
	else 
	return maxvalue
	end

end

hook.Add( "Think", "ShowKBInput", function() 

	if ( CLIENT ) then
	
		if ( GetConVarNumber( "sfw_debug_kbinfo" ) == 0 ) then return end
	
		local player = LocalPlayer()

		DebugInfo( 31, "======= Keyboard Input ========" )
		
		DebugInfo( 33, "- Engine -" )
		for k, v in pairs( inputs ) do
			if ( player:KeyDown( v ) ) then
				if ( math.Round( CurTime(), 1 ) % 2 == 0 ) then
				DebugInfo( 34, tostring( v ) )
				else 
				DebugInfo( 35, tostring( v ) )
				end
			end
		end
		
		
		DebugInfo( 38, "- Keyboard -" )
		for k, v in pairs( keyboard ) do
			if ( input.IsKeyDown( v ) ) then
				if ( math.Round( CurTime(), 1 ) % 2 == 0 ) then
				DebugInfo( 39, input.GetKeyName( v ) )
				else 
				DebugInfo( 40, input.GetKeyName( v ) )
				end
			end
		end
		
		DebugInfo( 43, "- Mouse -" )
		for k, v in pairs( mouse ) do
			if ( input.IsMouseDown( v ) ) then
				DebugInfo( 44, v.." ("..input.GetKeyName( v )..")" )
			end
		end
		

		DebugInfo( 48, "- Info -" )
		DebugInfo( 49, tostring( player ) )		
		DebugInfo( 50, "@"..CurTime() )	
		
		
		DebugInfo( 52, "=========================" )
		
	end
	
end )