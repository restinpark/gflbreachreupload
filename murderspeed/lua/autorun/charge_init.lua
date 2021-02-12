AddCSLuaFile()

game.AddParticles( "particles/wow_charge.pcf" )

if (SERVER) then return end
killicon.Add( "wow_charge", "hud/killicons/wow_charge_killicon", Color( 255, 255, 255, 255 ) )