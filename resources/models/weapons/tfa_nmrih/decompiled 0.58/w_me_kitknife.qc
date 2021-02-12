// Created by Crowbar 0.58

$modelname "weapons\tfa_nmrih\me_kitknife\w_me_kitknife.mdl"

$bodygroup "body"
{
	studio "w_me_kitknife_ref.smd"
}
$bodygroup "maglite"
{
	blank
	studio "w_me_kitknife_w_item_maglite_ref.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition -0.235 0.028 3.407

$cdmaterials "Models\weapons\tfa_nmrih\me_kitknife\"
$cdmaterials "Models\weapons\tfa_nmrih\item_maglite\"

$texturegroup "skinfamilies"
{
	{ "w_item_maglite_d"    }
	{ "w_item_maglite_on_d" }
}

$attachment "light" "Bone01" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -0.194 -0.895 -3.924 0.17 1.09 10.77

$definebone "ValveBiped.weapon_bone" "" -0.698381 2.364122 -2.462065 0 0 89.999983 0 0 0 0 0 0
$definebone "MyWeaponBone01" "ValveBiped.weapon_bone" 0.698381 2.462064 3.324008 -0.93902 89.999983 -89.999983 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "" 0 2.894067 2.533944 -0.000057 -69.999973 89.999983 0 0 0 0 0 0
$definebone "Bone01" "ValveBiped.Bip01_L_Hand" 8.444205 -2.531641 3.073441 -20.00001 0 0 0 0 0 0 0 0


$sequence "Idle" {
	"w_me_kitknife_anims\Idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "w_me_kitknife_physics.smd"
{
	$mass 10
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "

}
