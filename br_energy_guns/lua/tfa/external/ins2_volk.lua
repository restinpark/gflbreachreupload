local path = "weapons/tfa_ins2/volk/"
local pref = "TFA_INS2.VOLK"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "ar2_fire1.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "ak47_empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "ak47_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "ak47_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".MagRelease", path .. "ak47_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "ak47_magin.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "ak47_magout.wav")
TFA.AddWeaponSound(pref .. ".MagoutRattle", path .. "ak47_magout_rattle.wav")
TFA.AddWeaponSound(pref .. ".ROF", {path .. "ak47_fireselect_1.wav", path .. "ak47_fireselect_2.wav"})
TFA.AddWeaponSound(pref .. ".Rattle", path .. "ak47_rattle.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_arx160", "vgui/killicons/tfa_ins2_arx160", hudcolor)
end