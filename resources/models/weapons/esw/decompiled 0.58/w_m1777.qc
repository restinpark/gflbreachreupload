// Created by Crowbar 0.58

$modelname "napoleon/models/weapons/rarri/w_m1777.mdl"

$bodygroup "studio"
{
	studio "w_m1777_reference.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -0.153 -22.645 -3.09

$cdmaterials "models\weapons\AWoI\w_models\austrian_m1756\"
$cdmaterials "models\weapons\m1777\"

$attachment "muzzle_flash" "ValveBiped.Weapon_bone" 48.83 0.9 -0.42 rotate 0 0 0
$attachment "shell_eject" "ValveBiped.Weapon_bone" 4 0.3 -0.2 rotate -.. 90 -170

$cbox 0 0 0 0 0 0

$bbox -19.331 -1.113 -6.332 45.214 1.773 2.954

$definebone "ValveBiped" "" 0 0 0 -.. 0 89.999983 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped" 0.267086 -2.58952 10.171795 78.841284 -102.773509 -9.262035 0 0 0 0 0 0
$definebone "ValveBiped.Weapon_bone" "ValveBiped.Bip01_R_Hand" 5 -1.5 -4.999992 0.000001 0 0 0 0 0 0 0 0


$sequence "w_k98_idle" {
	"w_m1777_anims\w_k98_idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 1
}
