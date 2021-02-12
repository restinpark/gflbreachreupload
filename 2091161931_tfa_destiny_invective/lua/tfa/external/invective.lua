local shotgun = "weapons/"

TFA.AddWeaponSound("TFA_INVECTIVE_FIRE.1",  { shotgun .. "InvectiveFire1.wav", shotgun .. "InvectiveFire2.wav" }, false, ")" )
TFA.AddWeaponSound("TFA_INVECTIVE_RELOADSTART.1", shotgun .. "InvectiveReloadStart.wav")
TFA.AddWeaponSound("TFA_INVECTIVE_RELOADEND.1", shotgun .. "InvectiveReloadEnd.wav")
TFA.AddWeaponSound("TFA_INVECTIVE_SHELL.1", shotgun .. "InvectiveReloadShell.wav")
TFA.AddWeaponSound("TFA_INVECTIVE_PUMP.1", shotgun .. "InvectivePump.wav")
TFA.AddWeaponSound("TFA_INVECTIVE_FIREFINAL.1", shotgun .. "InvectiveFireFinal.wav")


local icol = Color( 255, 100, 0, 255 ) 
if CLIENT then
	killicon.Add(  "destiny_invective",	"vgui/killicons/destiny_invective", icol  )
end
