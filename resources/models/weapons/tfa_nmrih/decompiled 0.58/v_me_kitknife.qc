// Created by Crowbar 0.58

$modelname "weapons\tfa_nmrih\me_kitknife\v_me_kitknife.mdl"

$bodygroup "studio"
{
	studio "v_me_kitknife_reference.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 3.329 -14.658 -9.173

$cdmaterials "models\weapons\tfa_nmrih\me_kitknife\"
$cdmaterials "models\hands\"
$cdmaterials "models\weapons\tfa_nmrih\item_maglite\"

$attachment "nmrih_trace_start" "KitKnife" -.. -0.11 11.6 rotate -.. 0 0
$attachment "nmrih_trace_end" "KitKnife" -.. -0.51 2.55 rotate -.. 0 0
$attachment "camera" "camera_bone" 0 0 0 rotate 90 90 -..
$attachment "light" "MagLite" 0 0 0 rotate -.. 0 0

$cbox 0 0 0 0 0 0

$bbox -3.376 -18.044 -21.079 29.127 23.84 5.123

$definebone "NMRiH_FPS_Arms_Control_World" "" 0 0 0 -.. 0 0 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_Root" "NMRiH_FPS_Arms_Control_World" 0 2.709942 -10.591393 -89.999983 89.999983 0 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightCollar-Brk" "NMRiH_FPS_Arms_Control_Root" 3.500857 9.013945 -0.640573 -89.999983 -.. 0 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightCollar" "NMRiH_FPS_Arms_Control_RightCollar-Brk" -4.939643 -1.517692 -0.876522 0 0 0 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightShoulder" "NMRiH_FPS_Arms_Control_RightCollar" 4.409996 0.000005 -0.000001 -3.269068 3.100046 22.570357 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightElbow" "NMRiH_FPS_Arms_Control_RightShoulder" 10.079979 -0.000017 0.000014 -0.000286 -28.320104 -0.000176 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "NMRiH_FPS_Arms_Control_RightElbow" 0 -0.000002 0 0.000001 -0.000061 0.000058 0 0 0 0 0 0
$definebone "SphereGizmo02" "" -4.288669 -15.493492 -5.360934 11.184249 -91.703555 82.002637 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "SphereGizmo02" -0.11788 -0.102736 -0.180849 -2.188296 2.90375 107.902448 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightWrist" "SphereGizmo02" -0.11788 -0.102736 -0.180849 0.977352 -0.000002 0.000462 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_PSNULL20" "NMRiH_FPS_Arms_Control_RightWrist" 4.409986 -0.000005 0 0 -0.00023 0 0 0 0 0 0 0
$definebone "Ring06" "NMRiH_FPS_Arms_Control_PSNULL20" -0.900579 -0.375773 0.090054 -69.41298 -59.249392 -126.864372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "Ring06" 0.057854 -0.102365 -0.160513 -8.199006 -178.523934 97.622774 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "NMRiH_FPS_Arms_Control_RightShoulder" -0.000001 0 0 0 0 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "NMRiH_FPS_Arms_Control_RightCollar" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftCollar-Brk" "NMRiH_FPS_Arms_Control_Root" 3.500862 -5.725745 -0.640568 -89.999928 179.999979 0 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftCollar" "NMRiH_FPS_Arms_Control_LeftCollar-Brk" -2.18673 3.179637 -0.99615 0 0 0 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftShoulder" "NMRiH_FPS_Arms_Control_LeftCollar" 4.409998 -0.000001 0.000004 9.026034 -4.435667 -93.436702 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftElbow" "NMRiH_FPS_Arms_Control_LeftShoulder" 10.079981 0.000001 0.000029 0.000802 -17.178307 -0.000172 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "NMRiH_FPS_Arms_Control_LeftElbow" 0.000002 -0.000001 0.000001 0 0.000117 0.000058 0 0 0 0 0 0
$definebone "Ring04" "Ring06" -1.303123 -0.000018 -0.000004 -30.521349 -0.057923 -0.242994 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "Ring04" -0.109367 -0.142303 0.132363 8.705048 174.321592 105.023257 0 0 0 0 0 0
$definebone "Ring05" "Ring04" -1.094645 -0.000002 -0.000002 -56.421393 1.00542 -1.312472 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "Ring05" -0.1467 -0.024981 0.132385 18.218654 -173.608206 124.202278 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "NMRiH_FPS_Arms_Control_LeftShoulder" 0 0 -0.000002 0 0.000001 -0.000057 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "NMRiH_FPS_Arms_Control_LeftCollar" 0 0.000001 0.000001 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine4" "NMRiH_FPS_Arms_Control_Root" -0.006198 -0.000006 -0.001754 -10.250101 0 89.999928 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine4" 3.307271 -0.000005 0.000001 -0.000057 22.945532 179.999856 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Head1" "ValveBiped.Bip01_Neck1" 3.593715 -0.000002 0.000003 0 23.296177 0 0 0 0 0 0 0
$definebone "SphereGizmo01" "" 8.055274 -19.356735 -8.141298 -.. -89.843517 89.999983 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftWrist" "SphereGizmo01" -0.118055 -0.108984 0.513327 -4.957804 0.000229 -0.003037 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_PSNULL47" "NMRiH_FPS_Arms_Control_LeftWrist" 4.409998 -0.000018 -0.000008 -.. 0 0 0 0 0 0 0 0
$definebone "Thumb1" "NMRiH_FPS_Arms_Control_PSNULL47" -3.422663 1.711287 0.470893 -30.530345 28.405761 8.002846 0 0 0 0 0 0
$definebone "Thumb2" "Thumb1" 1.410028 -0.000002 0.000004 0.000002 -10.929626 0.000166 0 0 0 0 0 0
$definebone "Thumb3" "Thumb2" 0.993011 -0.000011 0.000001 -0.000003 1.99103 -0.000062 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "Thumb3" 0.197495 0.255112 -0.041076 -9.503025 -6.626196 168.048692 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "Thumb2" 0.098402 -0.002664 -0.075714 0.225171 11.364045 165.187976 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "Thumb1" 0.05366 -0.114882 -0.097672 1.377222 0.061305 162.241719 0 0 0 0 0 0
$definebone "Index1" "NMRiH_FPS_Arms_Control_PSNULL47" -1.022532 1.571294 -0.40626 3.395749 10.612325 0.55405 0 0 0 0 0 0
$definebone "Index2" "Index1" 1.337719 0.000001 -0.000002 -2.839923 -0.33392 -0.000057 0 0 0 0 0 0
$definebone "Index3" "Index2" 1.18047 -0.000093 0.000001 -3.656732 -4.232098 -0.000057 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "Index3" 0.066723 -0.13212 0.028929 -12.152556 -1.295175 -67.175751 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "Index2" 0.133497 -0.098471 -0.093333 -6.57985 -2.37749 -68.447546 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "Index1" 0.087252 -0.043179 -0.084968 -0.851014 -2.423268 -70.751867 0 0 0 0 0 0
$definebone "Middle1" "NMRiH_FPS_Arms_Control_PSNULL47" -0.666718 0.56595 -0.425189 2.020535 2.224796 0.118373 0 0 0 0 0 0
$definebone "Middle2" "Middle1" 1.311726 0 0.000005 -3.043726 -0.936442 -0.000172 0 0 0 0 0 0
$definebone "Middle3" "Middle2" 1.132875 -0.000006 -0.000001 -2.558602 4.916724 0.000172 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "Middle3" 0.079889 -0.000777 -0.04084 -4.14942 -6.373467 -86.563899 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "Middle2" 0.05862 0.000375 -0.081839 -1.751535 0.641199 -86.239547 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "Middle1" 0.064814 -0.004482 -0.14439 -2.075541 0.191427 -87.05137 0 0 0 0 0 0
$definebone "Ring1" "NMRiH_FPS_Arms_Control_PSNULL47" -0.835875 -0.375754 -0.250998 -0.073625 -5.035614 -0.267457 0 0 0 0 0 0
$definebone "Ring2" "Ring1" 1.303123 0.000021 -0.000002 -2.911541 3.710015 0 0 0 0 0 0 0
$definebone "Ring3" "Ring2" 1.094648 -0.000004 0.000001 0.000056 -2.567771 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "Ring3" 0.026533 -0.019737 0.092355 -11.716243 3.44548 -110.210212 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "Ring2" 0.032246 0.029052 -0.044583 -5.574366 -2.301975 -106.926476 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "Ring1" 0.05574 -0.000463 -0.381892 -12.760402 2.516773 -103.009287 0 0 0 0 0 0
$definebone "Pinky1" "NMRiH_FPS_Arms_Control_PSNULL47" -1.144739 -1.304738 0.171515 0.233766 -7.631569 -0.404451 0 0 0 0 0 0
$definebone "Pinky2" "Pinky1" 1.052853 -0.000003 0.000001 -6.40275 -1.952645 0.000057 0 0 0 0 0 0
$definebone "Pinky3" "Pinky2" 0.916349 -0.000026 0.000004 -0.000061 0.66434 -0.000057 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "Pinky3" -0.146458 -0.026382 0.309875 2.742232 7.705995 -126.08252 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "Pinky2" 0.263256 -0.001887 0.082275 -13.209203 -0.469543 -124.606981 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "Pinky1" 0.110191 0.003103 -0.328437 -19.326265 -0.357241 -115.259798 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "SphereGizmo01" -0.118055 -0.108984 0.513327 7.213997 2.037037 -93.314598 0 0 0 0 0 0
$definebone "Thumb04" "NMRiH_FPS_Arms_Control_PSNULL20" -3.459373 1.711252 -0.541793 -38.199957 -158.460773 19.674046 0 0 0 0 0 0
$definebone "Thumb05" "Thumb04" -1.410026 0.000001 -0.000001 -0.000061 -37.143358 -0.000229 0 0 0 0 0 0
$definebone "Thumb06" "Thumb05" -0.99301 0.000006 -0.000001 -3.081776 -17.855245 5.963855 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "Thumb06" -0.000002 0 0 10.856608 -178.409119 171.233295 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "Thumb05" 0.000001 0.000001 -0.000001 4.640147 175.476495 174.453551 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "Thumb04" 0 -0.000001 0 5.552808 169.511363 179.424577 0 0 0 0 0 0
$definebone "Index06" "NMRiH_FPS_Arms_Control_PSNULL20" -1.077421 1.571269 0.162239 -6.887642 175.508092 0.578628 0 0 0 0 0 0
$definebone "Index04" "Index06" -1.337645 -0.000004 -0.000017 -75.358557 -12.103911 8.586797 0 0 0 0 0 0
$definebone "Index05" "Index04" -1.180475 0.000084 -0.000015 -22.90067 -4.40542 -0.034547 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "Index05" -0.025192 0.071651 0.01079 2.629247 175.375545 65.860414 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "Index04" -0.10953 0.051085 0.121141 6.320124 178.816922 67.722009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "Index06" 0.18099 0.139007 0.36973 14.94615 -177.390123 83.954794 0 0 0 0 0 0
$definebone "Middle06" "NMRiH_FPS_Arms_Control_PSNULL20" -0.719604 0.565938 0.238757 -82.120096 -56.267789 -131.264858 0 0 0 0 0 0
$definebone "Middle04" "Middle06" -1.311736 0 0.000004 -37.866716 0.085369 0.162089 0 0 0 0 0 0
$definebone "Middle05" "Middle04" -1.132874 -0.000002 -0.000001 -55.491428 1.827965 -0.170451 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "Middle05" -0.082809 -0.016713 0.131227 9.857495 172.933424 100.902946 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "Middle04" -0.099231 -0.085093 0.221476 10.258788 176.924987 85.539487 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "Middle06" 0.099892 0.046742 -0.430885 -18.465145 -175.330479 78.400129 0 0 0 0 0 0
$definebone "Pinky04" "NMRiH_FPS_Arms_Control_PSNULL20" -1.239069 -1.304757 -0.314278 -56.760368 -84.772142 -99.755904 0 0 0 0 0 0
$definebone "Pinky05" "Pinky04" -1.05285 0.000002 -0.000004 -33.723144 -0.077298 -0.251643 0 0 0 0 0 0
$definebone "Pinky06" "Pinky05" -0.916345 0.00003 0 -46.401505 -0.632204 -1.772205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "Pinky06" -0.3162 -0.062712 -0.184037 13.045087 -162.932388 129.77492 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "Pinky05" -0.342494 -0.077103 -0.045996 25.02315 179.158035 119.59175 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "Pinky04" -0.089992 -0.367979 0.15093 16.784896 166.609011 104.734429 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightElbowTwist1" "NMRiH_FPS_Arms_Control_RightElbow" 0 -0.000003 0.000001 0.000286 0.000109 -6.405438 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightElbowTwist2" "NMRiH_FPS_Arms_Control_RightElbow" 3.359991 0.000009 -0.000005 0.000287 0.00028 -12.811107 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_RightElbowTwist3" "NMRiH_FPS_Arms_Control_RightElbow" 6.719985 0.000018 -0.000016 0.000229 0.000169 -19.216667 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftElbowTwist1" "NMRiH_FPS_Arms_Control_LeftElbow" 0 0 0 0.000172 0.000345 23.388714 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftElbowTwist2" "NMRiH_FPS_Arms_Control_LeftElbow" 3.359993 0.000001 -0.000005 0.000172 0.000173 46.77719 0 0 0 0 0 0
$definebone "NMRiH_FPS_Arms_Control_LeftElbowTwist3" "NMRiH_FPS_Arms_Control_LeftElbow" 6.719987 0.00001 -0.000012 0.000114 0.000232 70.165735 0 0 0 0 0 0
$definebone "camera_bone" "NMRiH_FPS_Arms_Control_World" 0 0 0 -.. -179.999966 89.999983 0 0 0 0 0 0
$definebone "MagLite" "" 7.00866 -16.313408 -22.069904 0 0 0 0 0 0 0 0 0
$definebone "KitKnife" "" -8.395806 -21.715048 -5.72077 -4.690977 7.055002 -13.062005 0 0 0 0 0 0

$bonemerge "NMRiH_FPS_Arms_Control_World"
$bonemerge "NMRiH_FPS_Arms_Control_Root"
$bonemerge "NMRiH_FPS_Arms_Control_RightCollar-Brk"
$bonemerge "NMRiH_FPS_Arms_Control_RightCollar"
$bonemerge "NMRiH_FPS_Arms_Control_RightShoulder"
$bonemerge "NMRiH_FPS_Arms_Control_RightElbow"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "SphereGizmo02"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "NMRiH_FPS_Arms_Control_RightWrist"
$bonemerge "NMRiH_FPS_Arms_Control_PSNULL20"
$bonemerge "Ring06"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "NMRiH_FPS_Arms_Control_LeftCollar-Brk"
$bonemerge "NMRiH_FPS_Arms_Control_LeftCollar"
$bonemerge "NMRiH_FPS_Arms_Control_LeftShoulder"
$bonemerge "NMRiH_FPS_Arms_Control_LeftElbow"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "Ring04"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "Ring05"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_Neck1"
$bonemerge "ValveBiped.Bip01_Head1"
$bonemerge "SphereGizmo01"
$bonemerge "NMRiH_FPS_Arms_Control_LeftWrist"
$bonemerge "NMRiH_FPS_Arms_Control_PSNULL47"
$bonemerge "Thumb1"
$bonemerge "Thumb2"
$bonemerge "Thumb3"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "Index1"
$bonemerge "Index2"
$bonemerge "Index3"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "Middle1"
$bonemerge "Middle2"
$bonemerge "Middle3"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "Ring1"
$bonemerge "Ring2"
$bonemerge "Ring3"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "Pinky1"
$bonemerge "Pinky2"
$bonemerge "Pinky3"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "Thumb04"
$bonemerge "Thumb05"
$bonemerge "Thumb06"
$bonemerge "ValveBiped.Bip01_R_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "Index06"
$bonemerge "Index04"
$bonemerge "Index05"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "Middle06"
$bonemerge "Middle04"
$bonemerge "Middle05"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "Pinky04"
$bonemerge "Pinky05"
$bonemerge "Pinky06"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger4"


$sectionframes 30 200

$sequence "Draw" {
	"v_me_kitknife_anims\Draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event AE_CL_PLAYSOUND 1 "WeaponGeneral.Draw" }
	fadein 0.2
	fadeout 0.2
	fps 32
}

$sequence "Holster" {
	"v_me_kitknife_anims\Holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event AE_CL_PLAYSOUND 0 "WeaponGeneral.Holster" }
	fadein 0.2
	fadeout 0.2
	node "holster"
	fps 32
}

$sequence "Holster_flashlight" {
	"v_me_kitknife_anims\Holster_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_HOLSTER" 1
	{ event AE_CL_PLAYSOUND 0 "Weapon_Flashlight.Off" }
	{ event AE_CL_PLAYSOUND 5 "WeaponGeneral.Holster" }
	fadein 0.2
	fadeout 0.2
	node "holster_light"
	snap
	fps 32
}

$sequence "Shove" {
	"v_me_kitknife_anims\Shove.smd"
	activity "ACT_VM_HITCENTER" 1
	{ event AE_CL_PLAYSOUND 5 "Weapon_Machete.Shove" }
	{ event AE_WPN_SHOVE 6 "" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "Shove_flashlight" {
	"v_me_kitknife_anims\Shove_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_SHOVE" 1
	{ event AE_CL_PLAYSOUND 5 "Weapon_Machete.Shove" }
	{ event AE_WPN_SHOVE 6 "" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "Sprint" {
	"v_me_kitknife_anims\Sprint.smd"
	activity "ACT_VM_SPRINT" 1
	fadein 0.2
	fadeout 0.2
	node "Sprint"
	fps 35
}

$sequence "Sprint_flashlight" {
	"v_me_kitknife_anims\Sprint_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_SPRINT" 1
	fadein 0.2
	fadeout 0.2
	node "Sprint_light"
	fps 35
}

$sequence "Idle" {
	"v_me_kitknife_anims\Idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Idle_flashlight" {
	"v_me_kitknife_anims\Idle_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Attack_Quick" {
	"v_me_kitknife_anims\Attack_Quick.smd"
	activity "ACT_VM_ATTACK_QUICK" 1
	{ event AE_WPN_MELEE_TRACE 8 "1 SLASH" }
	{ event AE_WPN_MELEE_TRACE 13 "0" }
	{ event AE_CL_PLAYSOUND 9 "Weapon_Melee.SwipeSharpLight" }
	fadein 0.2
	fadeout 0.2
	fps 34
}

$sequence "Attack_Quick_flashlight" {
	"v_me_kitknife_anims\Attack_Quick_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_ATTACK_QUICK" 1
	{ event AE_WPN_MELEE_TRACE 8 "1 SLASH" }
	{ event AE_WPN_MELEE_TRACE 13 "0" }
	{ event AE_CL_PLAYSOUND 9 "Weapon_Melee.SwipeSharpLight" }
	fadein 0.2
	fadeout 0.2
	fps 34
}

$sequence "Attack_Charge_Begin" {
	"v_me_kitknife_anims\Attack_Charge_Begin.smd"
	activity "ACT_VM_ATTACK_CHARGE_BEGIN" 1
	fadein 0.2
	fadeout 0.2
	fps 32
}

$sequence "Attack_Charge_Begin_flashlight" {
	"v_me_kitknife_anims\Attack_Charge_Begin_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_ATTACK_CHARGE_BEGIN" 1
	fadein 0.2
	fadeout 0.2
	fps 32
}

$sequence "Attack_Charge_Idle" {
	"v_me_kitknife_anims\Attack_Charge_Idle.smd"
	activity "ACT_VM_ATTACK_CHARGE_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Attack_Charge_Idle_flashlight" {
	"v_me_kitknife_anims\Attack_Charge_Idle_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_ATTACK_CHARGE_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Attack_Charge_End" {
	"v_me_kitknife_anims\Attack_Charge_End.smd"
	activity "ACT_VM_ATTACK_CHARGE_END" 1
	{ event AE_WPN_MELEE_TRACE 9 "1 SLASH" }
	{ event AE_WPN_MELEE_TRACE 13 "0" }
	{ event AE_CL_PLAYSOUND 8 "Weapon_Melee.SwipeSharpLight" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 32
}

$sequence "Attack_Charge_End_flashlight" {
	"v_me_kitknife_anims\Attack_Charge_End_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_ATTACK_CHARGE_END" 1
	{ event AE_WPN_MELEE_TRACE 9 "1 SLASH" }
	{ event AE_WPN_MELEE_TRACE 13 "0" }
	{ event AE_CL_PLAYSOUND 8 "Weapon_Melee.SwipeSharpLight" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 32
}

$sequence "Walk" {
	"v_me_kitknife_anims\Walk.smd"
	activity "ACT_VM_WALK" 1
	fadein 0.2
	fadeout 0.2
	transition "0" "Walk"
	fps 30
}

$sequence "Walk_flashlight" {
	"v_me_kitknife_anims\Walk_flashlight.smd"
	activity "ACT_VM_FLASHLIGHT_WALK" 1
	fadein 0.2
	fadeout 0.2
	transition "0" "Walk"
	fps 30
}

$sequence "Light_On" {
	"v_me_kitknife_anims\Light_On.smd"
	activity "ACT_VM_FLASHLIGHT_ON" 1
	{ event AE_WPN_FLASHLIGHT_ON 14 "" }
	{ event AE_CL_PLAYSOUND 14 "Weapon_Flashlight.On" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Light_Off" {
	"v_me_kitknife_anims\Light_Off.smd"
	activity "ACT_VM_FLASHLIGHT_OFF" 1
	{ event AE_WPN_FLASHLIGHT_OFF 16 "" }
	{ event AE_CL_PLAYSOUND 16 "Weapon_Flashlight.Off" }
	fadein 0.2
	fadeout 0.2
	fps 30
}
