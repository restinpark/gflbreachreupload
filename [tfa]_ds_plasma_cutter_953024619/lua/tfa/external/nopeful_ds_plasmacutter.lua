local path = "weapons/plasma_cutter_n/"
local pref = "plasma_cutter_n"

TFA.AddFireSound(pref .. ".1", path .. "fire.wav", true, ")" )

TFA.AddWeaponSound(pref .. ".draw", path .. "draw.wav")
TFA.AddWeaponSound(pref .. ".foley1", path .. "foley1.wav")
TFA.AddWeaponSound(pref .. ".slideout", path .. "slideout.wav")
TFA.AddWeaponSound(pref .. ".out", path .. "out.wav")
TFA.AddWeaponSound(pref .. ".in", path .. "in.wav")
TFA.AddWeaponSound(pref .. ".trapdown", path .. "trapdown.wav")
TFA.AddWeaponSound(pref .. ".turn", path .. "turn.wav")

if killicon and killicon.Add then
    killicon.Add("weapon_plasmacutter_bread", "vgui/killicons/weapon_plasmacutter_bread", Color(255, 80, 0, 191))
end