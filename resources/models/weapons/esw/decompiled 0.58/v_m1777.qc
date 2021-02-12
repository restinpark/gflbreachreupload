// Created by Crowbar 0.58

$modelname "napoleon/models/weapons/rarri/v_m1777.mdl"

$bodygroup "studio"
{
	studio "v_m1777_reference.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -5.099 -67.827 -15.571

$cdmaterials "models\weapons\AWoI\v_models\austrian_m1756\"
$cdmaterials "models\weapons\awoi\v_models\hands\"
$cdmaterials "models\weapons\m1777\"

$texturegroup "skinfamilies"
{
	{ "sleeve"  }
	{ "sleeve2" }
	{ "sleeve3" }
	{ "sleeve4" }
	{ "sleeve5" }
	{ "sleeve6" }
	{ "sleeve7" }
}

$attachment "0" "Rifle" 1.5 1.5 3.3 rotate -.. 0 0
$attachment "1" "Rifle" 0 88 2 rotate -.. 0 0
$attachment "muzzle_flash" "Bone17" 0 0 0 rotate -.. 0 0

$cbox 0 0 0 0 0 0

$bbox -26.683 -30.03 -28.831 124.473 18.882 -1.166

$definebone "Base" "" -7.714 -10.77 -7.221 0 179.999966 0 0 0 0 0 0 0
$definebone "R Arm" "Base" 2.535486 -7.352271 -3.160847 -.. 21.999975 0 0 0 0 0 0 0
$definebone "R Arm1" "R Arm" 0.000001 -19.606968 0 -.. 0 0 0 0 0 0 0 0
$definebone "R Hand" "R Arm" 0.029416 1.26741 0.044051 1.095667 -19.752718 -25.978539 0 0 0 0 0 0
$definebone "R Thumb" "R Hand" -0.588219 1.262087 1.324904 -11.553466 25.123171 -3.118892 0 0 0 0 0 0
$definebone "R Thumb 1" "R Thumb" -0.190578 2.058875 2.277339 0.32624 -0.021367 -7.492969 0 0 0 0 0 0
$definebone "R Thumb 2" "R Thumb 1" -0.1664 2.467746 1.063648 1.50424 -0.502942 -36.973761 0 0 0 0 0 0
$definebone "R Finger 1 0" "R Hand" 0.000002 6.685143 1.55268 0.043602 -0.0004 -0.999065 0 0 0 0 0 0
$definebone "R Finger 1 1" "R Finger 1 0" 0.000001 2.544662 0.08626 -0.982338 26.620198 1.856614 0 0 0 0 0 0
$definebone "R Finger 1 2" "R Finger 1 1" -0.000004 1.595806 0.086262 0.478647 40.115648 6.280592 0 0 0 0 0 0
$definebone "R Finger 2 0" "R Hand" 0.000004 7.159572 0.172524 7.825915 76.165858 -5.154843 0 0 0 0 0 0
$definebone "R Finger 2 1" "R Finger 2 0" -0.000002 2.242754 -0.043128 0.47206 78.499563 0.421299 0 0 0 0 0 0
$definebone "R Finger 2 2" "R Finger 2 1" -0.000001 1.725197 0.000001 0.21675 25.99917 0.060106 0 0 0 0 0 0
$definebone "R Finger 3 0" "R Hand" 0.000002 6.943921 -1.380154 11.329667 85.282651 2.960015 0 0 0 0 0 0
$definebone "R Finger 3 1" "R Finger 3 0" 0 1.983977 0 -0.862705 62.49658 -0.576398 0 0 0 0 0 0
$definebone "R Finger 3 2" "R Finger 3 1" 0 1.423285 0 -0.463925 27.99644 -0.137398 0 0 0 0 0 0
$definebone "R Finger 4 0" "R Hand" 0 6.555755 -2.717183 23.850855 96.796629 0.770285 0 0 0 0 0 0
$definebone "R Finger 4 1" "R Finger 4 0" 0.000002 1.725193 -0.000002 -1.610761 32.965017 -0.554113 0 0 0 0 0 0
$definebone "R Finger 4 2" "R Finger 4 1" 0 1.466413 -0.04313 -2.311141 51.963376 -1.253982 0 0 0 0 0 0
$definebone "L Arm" "Base" -3.944039 23.505634 -6.619229 -33.482564 -42.410909 30.024877 0 0 0 0 0 0
$definebone "L Arm 1" "L Arm" -0.000002 -19.606968 -0.000003 -7.493311 17.283097 -19.435645 0 0 0 0 0 0
$definebone "L Hand" "L Arm" 0.029417 1.267408 0.044049 -35.680779 2.32632 -34.619371 0 0 0 0 0 0
$definebone "L Thumb" "L Hand" 0.723616 1.316238 1.740259 16.046884 -3.012789 3.12474 0 0 0 0 0 0
$definebone "L Thumb 1" "L Thumb" 0.243483 2.059265 2.283981 -4.441166 1.602389 11.611797 0 0 0 0 0 0
$definebone "L Thumb 2" "L Thumb 1" 0.219202 2.473881 1.06813 -1.268699 2.897622 -6.849595 0 0 0 0 0 0
$definebone "L Finger 1 0" "L Hand" 0.000004 6.685135 1.552675 0.38721 -60.483662 1.218683 0 0 0 0 0 0
$definebone "L Finger 1 1" "L Finger 1 0" 0 2.544664 0.08626 0.308424 -55.485353 1.140874 0 0 0 0 0 0
$definebone "L Finger 1 2" "L Finger 1 1" 0 1.595806 0.086266 0.01782 -28.49319 0.624521 0 0 0 0 0 0
$definebone "L Finger 2 0" "L Hand" -0.000004 7.159559 0.172522 -0.695452 -78.396495 -1.899696 0 0 0 0 0 0
$definebone "L Finger 2 1" "L Finger 2 0" 0.000008 2.242754 -0.043123 0.132586 -41.989555 0.899888 0 0 0 0 0 0
$definebone "L Finger 2 2" "L Finger 2 1" -0.000003 1.725189 0.000002 0.077981 -36.491112 0.791025 0 0 0 0 0 0
$definebone "L Finger 3 0" "L Hand" 0 6.943914 -1.380155 0.055924 -89.130466 0.124161 0 0 0 0 0 0
$definebone "L Finger 3 1" "L Finger 3 0" 0.000002 1.983978 0.000003 0.087146 -37.49081 0.811194 0 0 0 0 0 0
$definebone "L Finger 3 2" "L Finger 3 1" -0.000001 1.423286 0.000006 0.257487 -51.986476 1.082491 0 0 0 0 0 0
$definebone "L Finger 4 0" "L Hand" -0.000002 6.555746 -2.717182 1.048112 -93.971956 1.532263 0 0 0 0 0 0
$definebone "L Finger 4 1" "L Finger 4 0" 0 1.725191 0.000001 0.210162 -48.487595 1.021068 0 0 0 0 0 0
$definebone "L Finger 4 2" "L Finger 4 1" -0.000002 1.466427 -0.043129 0.121868 -40.989868 0.880523 0 0 0 0 0 0
$definebone "Rifle" "Base" 0.030928 7.424726 -2.725917 -.. 0 0 0 0 0 0 0 0
$definebone "Bone01" "Rifle" 1.530732 3.665211 1.222328 -.. 0 -37.000013 0 0 0 0 0 0
$definebone "Bone05" "Rifle" 1.552132 -2.082191 -0.209102 -.. 0 -74.000019 0 0 0 0 0 0
$definebone "Bone15" "Rifle" 0.001698 58.341591 -0.821975 -.. 0 0 0 0 0 0 0 0
$definebone "Bone17" "Rifle" 0.001693 84.588989 1.382943 -.. 0 0 0 0 0 0 0 0
$definebone "Bone23" "Base" 18.075565 -12.049757 -14.58567 -.. 0 0 0 0 0 0 0 0
$definebone "Bone24" "Bone23" 0 3.708472 -0.051058 -.. 0 0 0 0 0 0 0 0
$definebone "Bone25" "Bone24" -0.911175 1.678204 0.109503 -.. 0 0 0 0 0 0 0 0
$definebone "Bone27" "Bone24" -0.898764 1.898778 0.109503 -.. 0 0 0 0 0 0 0 0
$definebone "Bone29" "Bone24" -0.886374 2.118808 0.109503 -.. 0 0 0 0 0 0 0 0
$definebone "Bone31" "Bone24" -1.199036 1.64981 0.109503 -.. 0 0 0 0 0 0 0 0
$definebone "Bone32" "Bone31" -0.169863 -0.355385 0 -.. 0 0 0 0 0 0 0 0


$sectionframes 30 281

$sequence "idle1" {
	"v_m1777_anims\idle1.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 15
}

$sequence "idle1_empty" {
	"v_m1777_anims\idle1_empty.smd"
	activity "ACT_VM_IDLE_EMPTY" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 15
}

$sequence "idle2" {
	"v_m1777_anims\idle2.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 15
}

$sequence "idle2_empty" {
	"v_m1777_anims\idle2_empty.smd"
	activity "ACT_VM_IDLE_EMPTY" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 15
}

$sequence "deploy" {
	"v_m1777_anims\deploy.smd"
	activity "ACT_VM_DRAW" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "deploy_empty" {
	"v_m1777_anims\deploy_empty.smd"
	activity "ACT_VM_DRAW_EMPTY" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "holster" {
	"v_m1777_anims\holster.smd"
	activity "ACT_VM_HOLSTER" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"v_m1777_anims\reload.smd"
	activity "ACT_VM_RELOAD" 1
	fadein 0.2
	fadeout 0.2
	fps 37
}

$sequence "fire1" {
	"v_m1777_anims\fire1.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5002 2 "2" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "fire2" {
	"v_m1777_anims\fire2.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5002 2 "2" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "stab" {
	"v_m1777_anims\stab.smd"
	activity "ACT_VM_HITCENTER" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "stab_empty" {
	"v_m1777_anims\stab_empty.smd"
	activity "ACT_VM_HITCENTER_DRY" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}
