local path = "weapons/bal27/"
local pref = "bal27"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddWeaponSound(pref .. ".Button", path .. "button.wav")
TFA.AddWeaponSound(pref .. ".Clipout", path .. "clipin.wav")
TFA.AddWeaponSound(pref .. ".Clipin", path .. "clipout.wav")
TFA.AddWeaponSound(pref .. ".EmptyClipout", path .. "empty_clipout.wav")
TFA.AddWeaponSound(pref .. ".EmptyClipin", path .. "empty_clipin.wav")
TFA.AddWeaponSound(pref .. ".Hit", path .. "hit.wav")

--if killicon and killicon.Add then
--	killicon.Add("", "", hudcolor)
--end