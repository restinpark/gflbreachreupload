local path = "weapons/tfa_l4d2/1887/"
local pref = "TFA_L4D2.1887"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "1887_fire01.wav", false, ")")

TFA.AddWeaponSound(pref .. ".LoadShell", {path .. "1887_shell1.wav", path .. "1887_shell2.wav"})
TFA.AddWeaponSound(pref .. ".PumpFull", path .. "1887_pump.wav")
TFA.AddWeaponSound(pref .. ".PumpForward", path .. "1887_pump_forward_1st.wav")
TFA.AddWeaponSound(pref .. ".PumpBack", path .. "1887_pump_back_2nd.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_l4d2_1887", "vgui/killicons/tfa_l4d2_1887", hudcolor)
end