local path1 = "weapons/"
local pref1 = "TFA_HARDLIGHT_FIRE"

TFA.AddWeaponSound(pref1 .. ".1", path1 .. "HardlightFire1.wav", "HardlightFire2.wav", "HardlightFire3.wav", "HardlightFire4.wav", false, ")")
TFA.AddWeaponSound("TFA_HARDLIGHT_CHANGE.1", path1 .. "HardlightChange.wav", false, ")")
TFA.AddWeaponSound("TFA_HARDLIGHT_RELOAD.1", path1 .. "HardlightReload.wav", false, ")")


local icol = Color( 255, 100, 0, 255 ) 
if CLIENT then
 killicon.Add(  "destiny_hardlight",	"vgui/killicons/destiny_hardlight", icol  )
end