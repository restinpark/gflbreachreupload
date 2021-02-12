--Disable offset bullshit
MAP_NOCANCERMODE = true
MAP_WANTFORCENOSPEC = true
--had to disable 106 because even though he has a containment unit, there is no pocket dimension. smh
DISABLED_SCPS = {
  "681",
  "079",
  "106"
}


HB_SCP079 = Vector(-4945.529785, 1558.895386, -6482.875000)
--Spawn for 173 
SPAWN_173 = Vector(-2452.439697, 2065.642334, -6166.333496)
--Spawn for 106
SPAWN_106 = Vector(-5254.431641, 1161.528320, -6719.968750)
--Spawn for 049
SPAWN_049 = Vector(-4435.708496, 611.888489, -5142.968750)
SPAWN_681 = Vector(0, 0, 0)
--Spawn for 457
SPAWN_457 = Vector(-2260.612549, -546.933838, -6166.968750)
--Spawn for 939
SPAWN_939 = Vector(-3253.586914, 4616.671387, -6197.402832)
--Spawn for 682
SPAWN_682 = Vector(-1786.112671, 61.377678, -6382.968750)
--Spawn for 096
SPAWN_096 = Vector(-2934.445801, -2721.867920, -5142.968750)
--Spawn for 610
SPAWN_035 = Vector(-3859.243896, -799.980347, -6166.968750)
SPAWN_2845 = Vector(-3500.515625, 1758.965820, -6166.968750)
--Spawn for 1048A, although on the default map he's near able, try finding a different spawn
SPAWN_1048A = Vector(-3487.195313, 2606.545166, -6166.456055)
SPAWN_1048B = SPAWN_1048A
--Spawn for 066, aka the mistake scp
SPAWN_066 = Vector(-6253.212891, -295.058746, -5142.968750)
--Spawn for 076-02
SPAWN_0762 = Vector(-2451.320557, 1451.719482, -6166.968750)
--082
SPAWN_082 = Vector(-5172.338867, 829.591919, -5142.968750)
--966 using 096, comment this out if they're not going to spawn in the same spot
SPAWN_966 = Vector(-2980.542969, 567.533813, -5142.918945)
--178's spawn
SPAWN_178_1 = Vector(-2480.395508, 2604.447510, -6166.968750)
SPAWN_178 = SPAWN_178_1
--I WONDER WHAT THE FUCK THIS IS FOR. 
--I WONDER IF THEY CAN EVEN REACH THE SPOT WHERE THE INTERCOM SPAWNS THIS MAP IS WEIRD
SPAWN_INTERCOM = Vector(-902.289124, 1530.494873, -4071.509033)
--914's entrance booth
ENTER914 = Vector(0, 0, 0)
--914's output
EXIR914 = Vector(0, 0, 0)
--Where the bell would spawn, if it were ever added
POS_513 = Vector(370.003723, -4196.521484, -6454.968750)
SPAWN_079 = Vector(0,0,0)
--This is the trigger, the thing that starts the machine
POS_914BUTTON = Vector(0, 0, 0)
--This is the mode selector
POS_914B_BUTTON = Vector(0, 0, 0)
--This is where the vending machine should spawn
SPAWN_SCP_294 = Vector(-4657.086914, -3222.627197, -5143.048828)
SPAWN_SCP_294_ANG = Angle(0, -88, 0.000000)
SPAWN_SCP1025 = Vector(170.972107, -3097.548096, -6453.804199)
SPAWN_SCP1025_ANGLE = Angle(0.331689, -3.438716, -0.016492)
SPAWN_1048 = Vector(-3487.195313, 2606.545166, -6166.456055)
SPAWN_372 = Vector(-2478.816895, 2654.519287, -6166.968750)
SPAWN_330 = Vector(-5437.726074, 3899.104492, 340.031250)
SPAWN_160 = Vector(0, 0, 0)
SPAWN_160DRONE = Vector(0, 0, 0)
--This is where the surface music starts, this is going to be updated soon, but maybe not
OUTSIDESOUNDS = Vector(-3477.470459, 2993.013184, 20.031250)
SPAWN_458 = Vector(-4783.920410, -3619.859619, -5103.048828)
--Spawn for SCP-1425
SPAWN_SCP1425 = Vector(-2044.075195, -4222.954102, -6102.968750)
SPAWN_SCP1425_ANGLE = Angle(0, 0, 0)

SPAWNS_348 = {
Vector(-4793.473145, -3325.335938, -5103.048828),
Vector(-4784.141113, -3213.354736, -5103.048828)
}
--A table containing all the D Class spawns
SPAWN_CLASSD = {

Vector(-394.212830, -5538.065918, -6366.968750),
Vector(-230.290024, -5699.937012, -6366.968750),
Vector(-138.134491, -5811.017090, -6366.968750),
Vector(38.596283, -5985.240234, -6366.968262),
Vector(183.152740, -6185.287598, -6366.968750),
Vector(172.764603, -6426.412109, -6366.968750),
Vector(173.646790, -6588.795410, -6366.968750),
Vector(159.341110, -6802.831055, -6366.968750),
Vector(38.497726, -7077.865723, -6366.270020),
Vector(-157.936676, -7245.638184, -6366.968750),
Vector(-210.086533, -7382.513184, -6366.968750),
Vector(-365.151855, -7490.221191, -6366.968750),
Vector(-605.031250, -7631.074219, -6366.968750),
Vector(-848.124512, -7637.680176, -6366.968750),
Vector(-1000.657471, -7642.670898, -6366.968750),
Vector(-1226.714722, -7642.627441, -6366.968750),
Vector(-1496.753174, -7515.194824, -6366.968750),
Vector(-1651.530273, -7329.879395, -6366.968750),
Vector(-1759.040527, -7229.506836, -6366.968750),
Vector(-1916.671753, -7078.645020, -6366.968750),
Vector(-2073.308594, -6847.136230, -6366.968750),
Vector(-2076.280518, -6601.703613, -6366.968750),
Vector(-2060.394775, -6444.990234, -6366.968750),
Vector(-2075.015381, -6234.198730, -6366.968750),
Vector(-1943.322021, -5994.190430, -6366.968750),
Vector(-1775.473022, -5815.789551, -6366.968262),
Vector(-1655.263428, -5687.302734, -6366.968750),
Vector(-1496.974609, -5544.991699, -6366.968750),
Vector(198.308487, -6234.846680, -6542.968750),
Vector(162.021088, -6506.968750, -6542.968750),
Vector(160.599365, -6569.734375, -6542.968750),
Vector(152.295670, -6827.297852, -6542.968750),
Vector(29.781237, -7072.558594, -6542.968750),
Vector(-168.176239, -7227.234863, -6542.968750),
Vector(-239.237076, -7338.401855, -6542.968750),
Vector(-404.645355, -7504.027344, -6542.968750),
Vector(-1512.589966, -7527.976074, -6542.958984),
Vector(-1660.323486, -7341.057129, -6542.958984),
Vector(-1735.841675, -7246.263672, -6542.968750),
Vector(-1922.563843, -7076.806641, -6542.968750),
Vector(-393.235352, -5517.581543, -6542.968750),
Vector(-224.524628, -5694.418457, -6542.968750),
Vector(-118.225769, -5827.021973, -6542.969238),
Vector(54.205482, -5977.446289, -6542.968750),
Vector(-2064.385742, -6788.245605, -6542.968750),
Vector(-2063.029541, -6592.644531, -6542.968750),
Vector(-2084.079834, -6464.345703, -6542.968750),
Vector(-2086.430420, -6179.031250, -6542.968750),
Vector(-1963.460449, -5990.010742, -6542.968750),
Vector(-1772.291382, -5810.484375, -6542.968750),
Vector(-1610.187134, -5658.262695, -6542.968750),
Vector(-1484.335449, -5540.074707, -6542.968750),
Vector(-1407.100342, -5975.617188, -6542.968750),
Vector(-1710.461304, -6288.172363, -6542.968750),
Vector(-1695.693481, -6739.468750, -6542.968750),
Vector(-1395.790894, -7176.173340, -6542.968750),
Vector(-594.471985, -7130.333008, -6542.968750),
Vector(-121.159775, -6816.890137, -6542.968750),
Vector(-153.565216, -6409.233398, -6542.968750),
Vector(-501.266113, -6022.419922, -6542.968750),

}
--Alt guard spawns, used for some special rounds where
--the gaurds shouldn't be stuffed in a room
SPAWN_GUARD_HALLWAY = {

	Vector(-5177.068848, 1819.841309, 20.031250),
	Vector(-5091.198730, 1811.663208, 20.031250),
	Vector(-5008.460938, 1803.783569, 20.031250),
	Vector(-4947.968262, 1865.017700, 20.031250),
	Vector(-4992.613281, 1898.343018, 20.031250),
	Vector(-5077.337402, 1907.917969, 20.031250),
	Vector(-5140.801270, 1941.050171, 20.031250),
	Vector(-5167.055176, 2018.604736, 20.031250),
	Vector(-5088.077637, 2052.638916, 20.031250),
	Vector(-4998.569824, 2079.672607, 20.031250),
	Vector(-4973.532227, 2183.458496, 20.031250),
	Vector(-5071.264160, 2217.726318, 20.031250),
	Vector(-5163.478516, 2277.831787, 20.031250),
	Vector(-5172.467773, 2375.348389, 20.031250),
	Vector(-5106.750977, 2401.765381, 20.031250),
	Vector(-4988.387695, 2458.037598, 20.031250),
	Vector(-4981.136230, 2679.133301, 20.031250),
	Vector(-4864.000488, 2656.543213, 20.031250),
	Vector(-4749.695313, 2765.849854, 20.031250),
	Vector(-4735.168945, 2882.191162, 20.031250),
	Vector(-4671.113281, 3021.062012, 20.031250),
	Vector(-4555.023926, 3031.766357, 20.031250),
	Vector(-4530.791016, 2862.237793, 20.031250),
	Vector(-4763.065918, 3209.183105, 20.031250),
	Vector(-4889.889648, 3221.745361, 20.031250),
	Vector(-5092.453613, 3229.295654, 20.031250),
	Vector(-5299.224609, 3217.512451, 20.031250),
	Vector(-5376.165527, 3073.254883, 20.031250),
	Vector(-5361.160156, 2881.633301, 20.031250)

}
--Medbay spawns for guards
SPAWN_GUARD = {

Vector(-4812.671387, 1812.560791, 20.031254),
Vector(-4730.951172, 1815.702881, 20.031254),
Vector(-4640.502930, 1812.232544, 20.031254),
Vector(-4633.099609, 1896.089478, 20.031254),
Vector(-4721.092285, 1912.616577, 20.031254),
Vector(-4804.878906, 1927.680664, 20.031254),
Vector(-4810.112305, 2016.398560, 20.031254),
Vector(-4723.442871, 2019.166626, 20.031254),
Vector(-4629.271484, 2025.145874, 20.031254),
Vector(-4622.149414, 2098.512207, 20.031254),
Vector(-4721.057617, 2105.047852, 20.031254),
Vector(-4811.184082, 2121.127686, 20.031254),
Vector(-4812.588867, 2233.302002, 20.031254),
Vector(-4729.641113, 2252.173828, 20.031254),
Vector(-4639.164063, 2266.645996, 20.031254),
Vector(-4631.813965, 2348.163086, 20.031254),
Vector(-4711.928711, 2364.662842, 20.031256),
Vector(-4798.706543, 2380.264404, 20.031254),
Vector(-4813.468262, 2463.917236, 20.031254),
Vector(-4732.143066, 2467.714111, 20.031254),
Vector(-4632.440918, 2476.155029, 20.031254),
Vector(-5311.632324, 1793.951050, 20.031254),
Vector(-5374.319336, 1798.563599, 20.031254),
Vector(-5439.472656, 1803.357178, 20.031254),
Vector(-5508.345703, 1808.424683, 20.031254),
Vector(-5514.749023, 1859.685791, 20.031254),
Vector(-5464.644043, 1862.754272, 20.031256),
Vector(-5376.315918, 1856.292603, 20.031254),
Vector(-5303.736816, 1850.952148, 20.031254),
Vector(-5306.622070, 1922.958984, 20.031254),
Vector(-5358.593262, 1929.461060, 20.031254),
Vector(-5431.952637, 1934.858521, 20.031252),
Vector(-5505.506836, 1940.270508, 20.031254),
Vector(-5512.076660, 2005.430176, 20.031254),
Vector(-5459.949219, 2005.971436, 20.031254),
Vector(-5405.758301, 2001.983887, 20.031254),
Vector(-5325.240234, 1996.059814, 20.031254),
Vector(-5310.707031, 2074.988770, 20.031254),
Vector(-5383.748047, 2087.995850, 20.031254),
Vector(-5465.960938, 2094.082520, 20.031254),
Vector(-5520.523926, 2098.097900, 20.031252),
Vector(-5524.356445, 2165.677002, 20.031254),
Vector(-5464.799316, 2163.365967, 20.031254),
Vector(-5384.330078, 2157.461182, 20.031254),
Vector(-5305.120605, 2151.631348, 20.031254),
Vector(-5305.734375, 2225.770264, 20.031254),
Vector(-5370.652344, 2232.969727, 20.031254),
Vector(-5443.544434, 2238.349365, 20.031254),
Vector(-5511.586914, 2243.356934, 20.031254),
Vector(-5523.595703, 2307.828369, 20.031254),
Vector(-5462.749512, 2306.124268, 20.031254),
Vector(-5386.924316, 2300.559814, 20.031254),
Vector(-5314.449707, 2295.226318, 20.031254),
Vector(-5293.984863, 2356.979248, 20.031254),
Vector(-5373.243652, 2366.066406, 20.031254),
Vector(-5449.277832, 2371.673096, 20.031254),
Vector(-5514.036621, 2376.439697, 20.031254),
Vector(-5520.421387, 2429.887695, 20.031254),
Vector(-5455.147461, 2429.650391, 20.031254),
Vector(-5391.133301, 2424.980713, 20.031254),
Vector(-5320.172363, 2419.759033, 20.031254),
Vector(-5304.564941, 2493.723389, 20.031254),
Vector(-5353.006836, 2498.007324, 20.031254),
Vector(-5422.335449, 2503.109375, 20.031254),
Vector(-5518.000977, 2510.149658, 20.031254),



}

--technically these aren't outside the facility, but outside the facility is the fucking moon and no one gave the ntf oxygen gear soooooooo
SPAWN_OUTSIDE = {

Vector(-4729.460938, 3275.888428, 20.031250),
Vector(-4740.594727, 3168.520752, 20.031250),
Vector(-4749.224609, 3085.326172, 20.031250),
Vector(-4673.837891, 3071.212402, 20.031250),
Vector(-4559.979980, 3080.176025, 20.031250),
Vector(-4537.354004, 2991.250732, 20.031250),
Vector(-4544.619141, 2914.816895, 20.031250),
Vector(-4626.394043, 2914.071777, 20.031250),
Vector(-4627.844238, 2988.520996, 20.031250),
Vector(-4747.194824, 3017.458252, 20.031250),
Vector(-4748.898438, 2906.408936, 20.031250),
Vector(-4760.402832, 2778.295898, 20.031250)

}

SPAWN_OUTSIDE_RAND = {
	{

Vector(-4729.460938, 3275.888428, 20.031250),
Vector(-4740.594727, 3168.520752, 20.031250),
Vector(-4749.224609, 3085.326172, 20.031250),
Vector(-4673.837891, 3071.212402, 20.031250),
Vector(-4559.979980, 3080.176025, 20.031250),
Vector(-4537.354004, 2991.250732, 20.031250),
Vector(-4544.619141, 2914.816895, 20.031250),
Vector(-4626.394043, 2914.071777, 20.031250),
Vector(-4627.844238, 2988.520996, 20.031250),
Vector(-4747.194824, 3017.458252, 20.031250),
Vector(-4748.898438, 2906.408936, 20.031250),
Vector(-4760.402832, 2778.295898, 20.031250)

	},
	{

Vector(-5521.579102, 3279.001953, 340.031250),
Vector(-5524.215332, 3200.406982, 340.031250),
Vector(-5527.138184, 3113.216553, 340.031250),
Vector(-5530.136230, 3023.779541, 340.031250),
Vector(-5533.007324, 2938.145508, 340.031250),
Vector(-5535.865234, 2852.851318, 340.031250),
Vector(-5538.378906, 2777.843994, 340.031250),
Vector(-5540.868652, 2703.573242, 340.031250),
Vector(-5543.903320, 2616.695801, 340.031250),
Vector(-5627.900879, 2657.560791, 340.031250),
Vector(-5656.458008, 2732.506104, 340.031250),
Vector(-5654.552246, 2818.414307, 340.031250),
Vector(-5651.848633, 2899.132813, 340.031250),
Vector(-5648.472656, 2999.868164, 340.031250),
Vector(-5645.069824, 3101.329346, 340.031250),
Vector(-5642.394043, 3181.157715, 340.031250),
Vector(-5639.299316, 3273.479004, 340.031250)

	}
}

--Leave this 0
LAST_RDC_TIME = 0
--Sci Spawns
SPAWN_SCIENT = {

Vector(37.926296, -3564.710449, -6454.968750),
Vector(424.379761, -3552.713867, -6454.968750),
Vector(1064.025879, -4345.044922, -6454.968750),
Vector(1051.831543, -4159.634277, -6454.968750),
Vector(1044.410034, -3855.436768, -6454.968750),
Vector(1061.045166, -3556.236328, -6454.968262),
Vector(1081.091064, -3169.193848, -6454.969238),
Vector(1279.200073, -4312.865723, -6094.968750),
Vector(1419.036987, -3376.750488, -6094.968750),
Vector(942.305542, -3178.898926, -6094.968750),
Vector(748.561646, -3512.061035, -6094.968750),
Vector(733.351624, -4194.810547, -6094.968750),
Vector(185.527283, -3904.648438, -6070.968750),
Vector(1133.556763, -2908.007568, -6094.968750),
Vector(402.879883, -2051.898682, -6094.968750),
Vector(546.504517, -2544.963379, -6094.968750),
Vector(243.861435, -2544.532959, -6094.968750),
Vector(1192.386230, -4599.458496, -6454.968750),
Vector(1303.094238, -4543.052246, -6286.968750),
Vector(1288.645264, -4936.950195, -6202.968750)

}
--Keyguard level 2 spawns
--For every 'zone' that a level two should spawn in, use a subtable
--You can have as many zones as you'd like
SPAWN_KEYCARD2 = {
	lczaround1 = {

Vector(-485.849091, -6490.194824, -6477.872559),
Vector(-1361.891357, -6527.200684, -6477.859863),
Vector(-1221.765137, -6130.775879, -6541.773438),
Vector(-893.267029, -8437.879883, -6541.775879),
Vector(-664.661682, -7966.929688, -6541.771484),
Vector(-1255.462402, -8214.876953, -6541.774902),
Vector(-406.013092, -6781.354492, -6541.774414)



	},
	lczaround2 = {

Vector(-2041.276367, -3659.327881, -6477.775391),
Vector(-1852.748657, -3862.765137, -6477.773926),
Vector(-1202.686523, -3004.189453, -6477.773438),
Vector(-352.715576, -2864.891602, -6477.826172),
Vector(-156.869812, -3756.884277, -6453.772461),
Vector(1448.609741, -3711.878662, -6453.772949),
Vector(934.720032, -2867.218018, -6093.773438),
Vector(806.785339, -2849.748291, -6093.773926),
Vector(387.879395, -3358.034424, -6093.772949),
Vector(408.247406, -1964.955566, -6093.773926),
Vector(493.348663, -3783.800537, -6069.770996),
Vector(1885.421753, -3973.544189, -6093.773438)

	},
}
--Keyguard level 3 spawns
--For every 'zone' that a level three should spawn in, use a subtable
--You can have as many zones as you'd like
SPAWN_KEYCARD3 = {
	lcz1 = {

		Vector(2179.482178, -3618.685303, -6094.487793),
		Vector(434.593994, -3151.569824, -6454.561035),
		Vector(34.982967, -4048.092529, -6454.557129),
		Vector(-247.678940, -4133.513672, -6542.564453),
		Vector(-557.800720, -4867.810059, -6454.556641),
		Vector(-1980.645020, -3227.516602, -6478.587402),
		Vector(3171.730957, -3366.950684, -6094.586426)

	},
	hcz1 = {

		Vector(-3000.006836, 698.411072, -5142.553223),
		Vector(-4339.569336, 610.090332, -5142.621094),
		Vector(-4880.533203, -3318.774902, -5142.682129),
		Vector(-2289.991943, -623.723328, -6166.626465),
		Vector(-3397.368164, 2319.075928, -6166.623047),
		Vector(-2500.543457, 1710.137939, -6166.620605),
		Vector(-2225.759277, 2803.739502, -6166.622070)

	}
}
--Keyguard level 4 spawns
--For every 'zone' that a level four should spawn in, use a subtable
--You can have as many zones as you'd like
--Currently one keycard per zone is spawned, this will change
SPAWN_KEYCARD4 = {
	lcz1 = {

		Vector(1733.814575, -3791.597656, -6094.586426),
		Vector(1389.187988, -4775.758789, -6454.599609),
		Vector(1194.002930, -2241.220215, -6454.602051)

	},
	lcz2 = {

		Vector(375.939270, -4125.913086, -6454.639160),
		Vector(-388.595734, -2961.614990, -6992.617676)

	},
	--this one is in the pistol armory
	lcz3 = {
		Vector(1610.656616, -4342.648926, -6094.576172)
	},
	hcz1 = {
		Vector(-5710.644531, 1047.085938, -5142.611328),
		Vector(-5172.452148, -3470.450195, -5142.651855),
		Vector(-3005.151611, -2966.479492, -5142.629395)
	},
	hcz2 = {
		Vector(-3373.691162, 2437.710938, -5142.588379),
		Vector(-2844.425781, 606.846863, -5142.599609),
		Vector(-2520.713867, -1344.506836, -5142.615234)
	},
	--adding one to EZ in case commander is dumb or something so TRO can get into the facility.
	ez = {
		Vector(-5356.979492, 2362.973633, 20.450382),
		Vector(-5430.508789, 1849.752930, 20.396553),
		Vector(-4727.691406, 1896.691650, 20.390228)
	}
}
--A table containing keycard 5 spawns, 1 or 2 per game depending on player count
--Currently the 2 spawns are placeholders
--This is unused, but will be used soon
SPAWN_KEYCARD5 = {
Vector(-4121.052246, 4430.216309, -6216.255859),
Vector(-1219.449707, 1517.683716, -4130.587891)
}
--Medkits
SPAWN_MEDKITS = {

Vector(-753.127502, -6523.681641, -6236.554199),
Vector(2797.349121, -3369.143311, -6190.602051),
Vector(1532.041260, -2231.951172, -6454.595703),
Vector(-539.860229, -3610.893555, -6992.594238),
Vector(-4350.817383, 790.055054, -5142.599609),
Vector(-5398.473145, 2460.154053, 20.401386),
Vector(-5377.121094, 2229.887451, 340.413055)

}
--Places to spawn items like SNAVs and such
SPAWN_MISCITEMS = {

Vector(100.648430, -4041.231934, -6454.551758),
Vector(327.849640, -3136.336914, -6454.622559),
Vector(-1240.457153, -3755.979980, -6478.597656),
Vector(-1837.706055, -3039.667969, -6478.600098),
Vector(-1986.014038, -3057.055420, -6478.594727),
Vector(-2026.420288, -3805.181641, -6478.616211),
Vector(-1534.012329, -4061.460205, -6742.637207),
Vector(-735.357483, -5175.830566, -6454.631348),
Vector(-377.724731, -5037.249512, -6454.637207),
Vector(-971.576172, -6244.633789, -6236.621094),
Vector(-3194.517822, -4938.483398, -6166.589844),
Vector(-2277.327393, -4122.639648, -6166.525391),
Vector(-2222.549316, -4304.419922, -6166.520020),
Vector(-2049.516113, -4204.071777, -6166.522461),
Vector(-2046.282349, -4109.898438, -6166.520508)

}

--Night vision goggles
--Currently do to a comment I forgot to remove in the init file
--all of these are used, soon we will use a math formula to determine
--how many to spawn, as of now, just put as many as you want
SPAWN_NVG = {

Vector(-4501.039063, 2721.454102, 340.407806),
Vector(-5323.025391, 3930.707275, 340.398041),
Vector(-2444.883057, 495.963226, -5142.588379),
Vector(-3656.502686, 1401.489136, -6390.611328),
Vector(-565.124329, -3688.435303, -6992.617188),
Vector(-1810.280518, -3175.299316, -6478.615234),
Vector(-1940.708374, -3832.203125, -6478.614746),
Vector(-1131.182983, -3969.160400, -6742.621582),
Vector(-486.283569, -5148.684082, -6454.655762),
Vector(-1048.556030, -6357.123535, -6236.617676),
Vector(-5377.136230, 1839.018066, 20.365555),
Vector(-4650.678711, 1799.018555, 20.388803),
Vector(-4881.980957, -3638.133789, -5142.686035),
Vector(-2642.015869, -3377.141357, -5142.624512),
Vector(-2495.010742, -1237.399292, -5142.627441),
Vector(-4501.513184, 409.580780, -5142.620605),
Vector(-2687.707520, -5094.179688, -6166.622070)


}

SPAWN_BATTERY9 = {

}

SPAWN_BATTERY18 = {

}


SPAWN_BATTERY_STR = {}

--Crowbar spawns, will include other mapspawn melee weapons as they're added
SPAWN_MELEEWEPS = {

Vector(-136.531158, -4059.724121, -6992.810059),
Vector(-1557.387451, -4234.262695, -6742.837891),
Vector(-1027.940308, -6350.974121, -6478.833008),
Vector(-1741.559082, -556.660095, -6311.995605),
Vector(-1716.738892, -506.067963, -6166.864258),
Vector(-2961.625244, -4829.223145, -6166.818848)

}
--GUN SPAWNS:
--All gun spawns are always used, ie every spawn in the table will have a gun

--That one shotgun by gate b
--More than one will be good
SPAWN_SHOTGUNS = {
}
--Riffle ammo spawns
SPAWN_AMMO_RIFLE = {

Vector(-4602.999023, 4339.477539, 343.984985),
Vector(-4607.012695, 4294.250977, 343.978302),
Vector(-4570.718750, 4339.268066, 344.001923),
Vector(-4570.188477, 4293.730469, 344.003693),
Vector(-4535.056641, 4340.945801, 343.991943),
Vector(-4540.305176, 4295.574219, 344.002594),
Vector(-4500.811035, 4339.542480, 344.021454),
Vector(-4505.420410, 4292.780273, 343.991333),
Vector(-4461.675293, 4337.828613, 343.984406),
Vector(-4463.919434, 4290.540039, 344.005524),
Vector(1409.267334, -1728.179810, -6454.658203),
Vector(1356.218872, -1735.870483, -6454.616211),
Vector(1314.106201, -1724.708618, -6454.658203),
Vector(1263.796753, -1722.951172, -6454.599609),
Vector(-1764.259644, -519.339783, -6311.684570),
Vector(-6250.452637, 1819.653564, -6527.526367),
Vector(-3139.722168, 4428.650879, -6166.525879)

}
--SMG ammo spawns
SPAWN_AMMO_SMG = {

Vector(-4692.358398, 4288.375488, 340.481415),
Vector(-4720.768555, 4288.248047, 340.480743),
Vector(-4722.063477, 4321.393555, 340.492371),
Vector(-4692.241211, 4323.891602, 340.482300),
Vector(-4755.380371, 4319.464355, 340.484924),
Vector(-4762.421387, 4286.569336, 340.481140),
Vector(-4793.513672, 4288.435059, 340.483246),
Vector(-4824.079102, 4285.311035, 340.481964),
Vector(-4825.510254, 4315.019531, 340.480774),
Vector(-4787.237793, 4319.717773, 340.478302)

}
--Pistol ammo
SPAWN_AMMO_PISTOL = {

Vector(-2694.276123, -4927.645020, -6166.604004),
Vector(1792.841797, -4350.942383, -6091.005859),
Vector(1794.302979, -4312.900879, -6091.007813),
Vector(1792.605103, -4276.441895, -6091.016113),
Vector(1794.620850, -4233.506348, -6091.023926),
Vector(1834.089478, -4233.783691, -6090.985352),
Vector(1834.583740, -4274.979980, -6091.023926),
Vector(1834.195801, -4317.351074, -6090.988281),
Vector(1834.881592, -4349.424316, -6091.023438),
Vector(-1788.483887, -3874.508545, -6478.300781),
Vector(49.225792, -4114.369141, -6453.961426)

}
--Pistols
SPAWN_PISTOLS = {

Vector(1663.886597, -4241.071289, -6093.900879),
Vector(1690.696045, -4272.506836, -6093.965332),
Vector(1657.993286, -4300.986816, -6093.955078),
Vector(1654.039673, -4338.475586, -6093.959961),
Vector(1686.002441, -4353.351563, -6093.955566),
Vector(1658.169800, -4381.075684, -6093.898926),
Vector(-283.034607, -4186.657715, -6541.899902),
Vector(-567.800293, -3239.246094, -6992.305664)

}
--SMGs
SPAWN_SMGS = {

Vector(-4823.346680, 4173.062988, 340.736908),
Vector(-4837.652344, 4233.618652, 341.051331),
Vector(-4810.332520, 4224.024414, 341.054169),
Vector(-4794.551270, 4161.271973, 341.086090),
Vector(-4751.834961, 4173.508789, 341.000366),
Vector(-4762.125488, 4229.816895, 340.996857),
Vector(-4719.836426, 4234.452637, 340.716217),
Vector(-4715.484375, 4172.297363, 340.740631),
Vector(-4675.355469, 4196.646484, 340.995239),
Vector(-4675.243652, 4231.053223, 340.786102)

}
--Rifles, like aks
SPAWN_RIFLES = {

--EZ rifles
Vector(-4457.814453, 4161.432129, 340.909821),
Vector(-4457.002930, 4240.521484, 340.866821),
Vector(-4488.340820, 4245.188965, 340.902863),
Vector(-4495.885254, 4164.027344, 340.843353),
Vector(-4541.315918, 4170.898438, 340.865875),
Vector(-4540.076172, 4245.148438, 340.811279),
Vector(-4582.268066, 4237.971680, 340.864197),
Vector(-4578.754883, 4175.579590, 340.888489),
Vector(-4620.660156, 4183.052246, 340.850800),
Vector(-4619.256348, 4238.617188, 340.897858),
--LCZ Rifle Cache rifles
Vector(1489.781616, -1908.801636, -6454.167480),
Vector(1485.372437, -2019.207764, -6454.189453),
Vector(1474.717651, -2115.586914, -6454.195313),
--random rifle spawns
Vector(-3077.736328, 4422.429199, -6166.162109),
Vector(-6225.330566, 1776.169556, -6527.203613),
Vector(-1691.010376, -529.228577, -6311.357910)

}

SPAWN_SNIPERS = {


}
--Unused, won't ever be used
--Kept to stop GM from complaining
SPAWN_ZOMBIES = {
}

--Would be locations for a 096 nextbot to spawn
SPAWN_096NEXT = {

}

--The direction the nextbot would point
SCP096_ANGLES = {

}


--MTF Guard vests, all spawns are used
SPAWN_ARMORS = {

Vector(1776.950317, -4099.966797, -6095.036133),
Vector(1660.866577, -4094.137939, -6095.051270),
Vector(-3368.690186, 2281.850586, -5143.049805),
Vector(-3161.123535, -1820.758667, -5143.051758),
Vector(-4163.782227, -1305.371216, -6167.065430),
Vector(-3100.037842, 4307.665039, -6167.075684)

}
--Fire proof vests, all spawns are used
SPAWN_FIREPROOFARMOR = {

Vector(342.858185, -3970.129639, -6455.048340),
Vector(-385.064789, -4131.464844, -6543.049805),
Vector(-1109.831299, -4348.044922, -6743.067383),
Vector(-2261.211914, -349.630920, -6167.077637)

}
--Flash nades, all spawns are used
SPAWN_FLASH = {

Vector(-4534.908691, 4075.403564, 341.676422),
Vector(-4528.005859, 4046.928467, 341.548218),
Vector(-2846.996338, 467.385223, -5139.780762),
Vector(-2488.945313, -1512.620728, -6163.800293),
Vector(-1134.457275, -6345.750977, -6233.783691),
Vector(1704.155762, -4600.643066, -6091.731445),
Vector(1764.846069, -4600.751465, -6091.786133)

}
--Pills, all spawns are used
SPAWN_500 = {

Vector(-149.226761, -4263.287598, -6992.547363),
Vector(-196.372711, -4264.397949, -6992.589355),
Vector(386.997437, -3023.130859, -6415.055664),
Vector(208.776962, -4124.789063, -6454.616699),
Vector(-378.190826, -4262.239746, -6542.619629),
Vector(1622.046631, -3533.931396, -6094.614746),
Vector(-2521.464844, -1313.297363, -6166.623047),
Vector(-3668.782959, 1636.931519, -6390.620117),
Vector(-6230.262695, 2178.336426, -6527.604492),
Vector(-5686.428711, -771.713257, -6270.607910),
Vector(-5160.546387, 540.398132, -5142.620117),
Vector(-4741.346680, 3827.016113, 340.382904),
Vector(-5543.185059, 3552.562988, 340.383942),
Vector(1676.003296, -4447.200684, -6094.577637),
Vector(1648.613525, -4167.130859, -6094.706055),
Vector(1135.302368, -2131.343994, -6454.550293),
Vector(1160.245605, -2201.163330, -6454.559082)

}
--This was used back when chaos didn't spawn with MTF guards
--Feel free to add spawns for it, just know they probably won't ever be used
--(Use in Special round?)
SPAWN_CHAOS_S = {

}

--Compatibility
ALPHA_WARHEAD_SUPPORTED_BY_MAP = false
ALPHA_WARHEAD_STATE = false
local NEXT_914_USE = 0


--THESE ARE MAP BUTTONS
--They are one of the most important things in this config
--Buttons should be accurate or they won't work
--This is where you set keycard requirements and door names
--Every 'door' is a subtable of BUTTONS
--You can have the following attributes on each door

--name (required) - Shown to the user when they use the door, set to an empty string to not Show
--pos (required) - The position of the button
--canactivate - A function thats called to determine if a player can use the button/ent, takes 2 arguments, the player and the ent
--usesounds - true or false value, whether or not the siren should play upon the door being used, false if not present
--clevel - The min. keycard level to use, this probably doesn't work well with canactivate
--customdenymsg - Shown to the user if it is determined they cannot use this door in canactivate (function), usually used to tell players trying to leave their spawn they can't yet during prep
--enabled - Not really sure, haven't played around with it, assuming its whether a door can be used
BUTTONS = {

	--TRO Spawn 1 (This map uses 2 rooms across from eachother to spawn TRO. If there is an issue with this that I can't think of, please tell me)
	{
		
		name = "MTF Spawn Doors",
		pos = Vector(-5255.000000, 1962.020020, 73.000000),
		customdenymsg = "Wait for the round to start",
		canactivate = function(pl, ent)
			if roundtype then
				if roundtype.mtfandscpdelay == false then
					return true
				end
			end
			if preparing then
				//pl:PrintMessage(HUD_PRINTCENTER, "Wait for the round to start")
				return false
			else
				return true
			end
		end
	}, 
	--TRO Spawn 2
	{
		
		name = "MTF Spawn Doors",
		pos = Vector(-4882.000000, 1850.000000, 73.000000),
		customdenymsg = "Wait for the round to start",
		canactivate = function(pl, ent)
			if roundtype then
				if roundtype.mtfandscpdelay == false then
					return true
				end
			end
			if preparing then
				//pl:PrintMessage(HUD_PRINTCENTER, "Wait for the round to start")
				return false
			else
				return true
			end
		end
	},
	--SCP doors
	{
		name = "106",
		pos = Vector(-5809.049805, 944.799988, -6217.750000),
		canactivate = function(pl, ent) return !preparing end
	},

	{
		name = "SCP-966",
		pos = Vector(-3061.139893, 511.059998, -5089.750000),
		canactivate = function () return !preparing end
	},
	{
		name = "096 Containment",
		pos = Vector(-2685.000000, -3473.000000, -5079.000000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end
	},
	{
		name = "SCP-513",
		pos = Vector(224.050003, -3886.860107, -6402.000000),
		clevel = 3
	},
	--Checkpoint between EZ and LCZ. currently commented out because it's being used as Gate A
	--
	--	name = "EZ Main Doors",
	--	pos = Vector(-3678.050049, 2413.800049, -5090.000000), 
	--	usesounds = true,
	--	clevel = 3
	--},
	--Checkpoint between QS and HCZ
	{
		name = "HCZ2 Main Doors",
		pos = Vector(-2818.000000, -1432.000000, -6113.750000),
		usesounds = true,
		canactivate = function (ply)
				if ply:CLevel() > 2 or ply:Team() == TEAM_SCP then
					return true
				end
				return false
		end,
		customdenymsg = "You need at least a level 3 keycard for this door.",
		iscpdoor = true
	},
	{
		name = "LCZ Rifle Cache",
		pos = Vector(1414.050049, -2315.729980, -6401.750000),
		usesounds = true,
		clevel = 5
	},
	--Checkpoint between LCZ and HCZ
	{
		name = "HCZ3 Main Doors",
		pos = Vector(-2818.000000, -1432.000000, -6113.750000),
		usesounds = true,
		canactivate = function (ply)
				if ply:CLevel() > 2 or ply:Team() == TEAM_SCP then
					return true
				end
				return false
		end,
		customdenymsg = "You need at least a level 3 keycard for this door.",
		iscpdoor = true
	},
	--Control / electrical room
	--The button used to open the gate
	{
		name = "Gate A",
		pos = Vector(-3678.050049, 2413.800049, -5090.000000),
		clevel = 4,
		blockhns = true
	},
	--pistol Armory for LCZ, the ECZ armory doesn't usually need a keycard
	{
		name = "LCZ Pistol Armory",
		pos = Vector(1554.000000, -4171.930176, -6042.000000),
		usesounds = true,
		clevel = 4
	},
	--The room used to lock cells
	{
		name = "Cell Control Room",
		pos = Vector(-909.000000, -6277.000000, -6431.000000),
		clevel = 3
	},
	--The room by D class spawn
	{
		name = "Isolement",
		pos = Vector(-798.000000, -5031.930176, -6425.750000),
		clevel = 2
	},
	--The plague book
	--Has keycard/nvg spawn
	--and book spawn, duh
	{
		name = "1025",
		pos = Vector(209.949997, -3257.169922, -6402.000000),
		clevel = 2
	},
	--closet near d class spawn
	{
		name = "Janitorial Closet",
		pos = Vector(-1772.050049, -3320.750000, -6426.000000),
		clevel = 2
	},
	--other closet by their spawn
	{
		name = "Janitorial Closet",
		pos = Vector(-401.950012, -4019.080078, -6490.000000),
		clevel = 2
	},
	--147-FR. no spc in there though
	{
		name = "SCP 147-FR",
		pos = Vector(429.950012, -3257.169922, -6402.000000),
		clevel = 2
	},
	--random closet room 
	{
		name = "Research Supply Closet", 
		pos = Vector(4.050000, -3887.370117, -6402.000000),
		clevel = 2
	},
	--random closet room 2: electric boogaloo but it's clevel 3
	{ 
		name = "Senior Research Supply Closet",
		pos = Vector(1554.000000, -3637.949951, -6042.000000),
		clevel = 3
	},
	--Quartier Scientifique
	{
		name = "Quartier Scientifique", 
		pos = Vector(4.050000, -3887.370117, -6402.000000),
		clevel = 2
	},
	--Bunker 
	{
		name = "Bunker",
		pos = Vector(-463.950012, -3506.959961, -6942.000000), 
		clevel = 3
	},
	--adding this in the hopes that it stops people from getting stuck
	{
		name = "Isolation Chamber Controls",
		pos = Vector(-511.000000, -4924.000000, -6412.520020), 
		canactivate = function(pl, ent) return false end, 
		customdenymsg = "No one needs to be isolated right now."
	},
	--If the map doesn't have 914
	--Move the 'return false' to before 'if NEXT_914_USE > CurTime() then return false end'
	{
		name = "914 Button",
		pos = POS_914BUTTON,
		customdenymsg = "",
		canactivate = function(pl, ent)
			return false 
		end
	},
	--If the map doesn't have 914
	--Move the 'return false' to before 'Use914B(pl, ent)'
	{
		name = "914 Button 2",
		pos = POS_914B_BUTTON,
		customdenymsg = "",
		canactivate = function(pl, ent)
			return false
		end
	},
	--The door to get into the LCZ checkpoint 1 area
	--The tiny room next to the checkpoint
	{
		name = "Checkpoint 1",
		pos = Vector(-2570.010010, -1720.000000, -6119.000000),
		usesounds = true,
		clevel = 3,
		iscpdoor = true
	},
	--Same as above, but other LCZ checkpoint
	{
		name = "Checkpoint 2",
		pos = Vector(-2570.010010, -1720.000000, -5095.000000),
		usesounds = true,
		clevel = 3,
		iscpdoor = true
	},
	--Checkpoint 3 in ECZ, the code is different because
	--previously CI spawned in here
	{
		name = "Checkpoint 3",
		pos = Vector(-3430.010010, 2127.000000, -5095.000000),
		customdenymsg = "Wait for the round to start",
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end, --You can't open the door yet.
		iscpdoor = true
	},
	--ECZ armory
	{
		name = "Armory room 2",
		pos = Vector(-4882.000000, 4007.000000, 393.000000),
		usesounds = true
	},
	--the room we don't touch
	{
		name = "Facility Controls",
		pos = Vector(-4882.000000, 1850.000000, 393.000000), 
		canactivate = function(pl, ent) return false end,
		customdenymsg = "This room is off limits, by order of the 05 Council"
	},
	--035's door
	{
		name = "SCP 035",
		pos = Vector(-3958.949951, -735.840027, -6113.750000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end --You can't open the door yet.
	},
	--066's door
	{
		name = "SCP 066", 
		pos = Vector(-6035.990234, -469.000000, -5095.000000), 
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end 
	},
	--076-2 
	{
		name = "SCP 076-2", 
		pos = Vector(-2651.500000, 1605.000000, -6119.000000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end 
	},
	--082 if he ever get's added back or something
	{
		name = "SCP 082", 
		pos = Vector(-5371.009766, 985.000000, -5095.000000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end 
	},
	--173. poor guy has to use a random containment cell
	{
		name = "SCP 173", 
		pos = Vector(-2651.500000, 2177.000000, -6119.000000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end 
	},
	--372
	{
		name = "SCP 372", 
		pos = Vector(-2651.500000, 2749.000000, -6119.000000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end 
	},
	--{
	--	name = "Alpha Warhead Primer",
	--	pos = Vector(3972.000000, 264.000000, -330.140015),
	--	canactivate = function (pl, ent)
	--		if ALPHA_DET_IN_PROG and ALPHA_WARHEAD_STATE then
	--			ALPHA_WARHEAD_STATE = false
	--			ent:Fire("unlock")
	--			ent:Fire("pressin")
	--			ent:Fire("lock")
	--			ALPHA_WARHEAD_BLOCKED = true
	--			hook.Run("InterruptAlphaWarhead")
	--			return false
	--		elseif ALPHA_DET_IN_PROG then
	--			hook.Run("InterruptAlphaWarhead")
	--			ServerLog("ALPHA WARHEAD IN INVALID STATE!\n")
	--			ALPHA_WARHEAD_STATE = false
	--			ent:Fire("unlock")
	--			ent:Fire("pressin")
	--			ALPHA_WARHEAD_BLOCKED = true
	--			ent:Fire("lock")
	--			return false
	--			
	--		end
	--		if not ALPHA_WARHEAD_STATE then
	--			ALPHA_WARHEAD_STATE = true
	--			ent:Fire("unlock")
	--			ent:Fire("pressout")
	--			ent:Fire("lock")
	--		else
	--			ALPHA_WARHEAD_STATE = false
	--			ent:Fire("unlock")
	--			ent:Fire("pressin")
	--			ent:Fire("lock")
	--		end
	--		return false
	--	end,
	--	customdenymsg = ""
	--},
	{
		name = "SCP-457",
		pos = Vector(-2350.510010, -560.950012, -6113.750000),
		canactivate = function ()
			return !preparing
		end,
		customdenymsg = "Please wait for the round to begin."
	},
	--Dupe? 
	--no I think I fixed it. or broke it more. you never really know do you? -Duc
	{
		name = "SCP 1048",
		pos = Vector(-3281.500000, 2439.000000, -6119.000000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end --You can't open the door yet.
	},
	{
		name = "SCP 035", 
		pos = Vector(-3958.949951, -735.840027, -6113.750000), 
		canactive = function(pl, ent) 
			if preparing then 
				return false 
			else 
				return true 
			end 
		end 
	},
	{
		name = "SCP-2845",
		pos = Vector(-3290.800049, 1590.949951, -6118.459961),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end --You can't open the door yet.
	},
	--066 
	{
		name = "SCP 066",
		pos = Vector(-6035.990234, -469.000000, -5095.000000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end --You can't open the door yet.
	},
	--939's spawn
	{
		name = "SCP-939 Containment",
		pos = Vector(-2890.050049, 4110.799805, -6114.000000),
		usesounds = true,
		canactivate = function(pl, ent)
			return !preparing
		end,
		blockhns = false
	},
	--The door preventing 682 from leaving during preparing
	{
		name = "SCP 682",
		pos = Vector(-2270.139893, -32.939999, -6329.750000),
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end --You can't open the door yet.
	},
	--966, this actually works idk wtf is wrong with site 19 where half the buttons don't work
	{
		name = "SCP-966",
		pos = Vector(-3061.139893, 511.059998, -5089.750000),
		customdenymsg = "Please wait until the round starts",
		canactivate = function(pl, ent)
			if preparing then
				return false
			else
				if ent:GetSaveTable( ).m_bLocked then --The door is locked! Unlock it!
					print("Forcing door unlock!")
					ent:Fire("unlock")
					ent:Fire("use") --Open it now so the user doesnt have to press it again :)
				end
				return true
			end
		end --You can't open the door yet.
	},
	--079's room, currently just used for item spawns. if he gets added to the map you'll need to re-add the other code 
	{
		name = "SCP-079",
		clevel = 5,
		pos = Vector(-3476.060059, 1187.660034, -6337.750000)
	},
	--The thing for 008
	--This sets the global 'SCP008_HAS_BREACHED'
	--May be used to infect a player later on
	{
		name = "SCP 008",
		customdenymsg = "",
		pos = Vector(-5987.000000, -810.000000, -6223.000000),
		canactivate = function(pl, ent)
			if SCP008_HAS_BREACHED then return false end

			if pl:Team() == TEAM_SPEC or pl:Team() == TEAM_SCP then
				return false
			end
			SCP008_HAS_BREACHED = true
			--Currently does nothing
			--hook.Run("BREACH_008_INFECT", pl)
			--pl:PrintMessage(HUD_PRINTTALK, "Something flew off and cut your arm...")
			--local timer_uid = pl:SteamID().."SCP008Timer"
			--hook.Add("BreachEndRound", "Remove_"..timer_uid, function()
			--	timer.Destroy(timer_uid)
			--	hook.Remove("BreachEndRound", "Remove_"..timer_uid)
			--end)
			--timer.Create(timer_uid, 90 + math.random(-30, 30), 1, function()
			--	if pl:Team() != TEAM_SCP and pl:Team() != TEAM_SPEC then
			--		pl:SetSCP0082()
			--	end
			--	hook.Remove("BreachEndRound", "Remove_"..timer_uid)
			--end)

			ent:Fire("use")
			return false
		end
	},
	{
		name = "Facility Airlock Gate", 
		customdenymsg = "That isn't a very good idea.", 
		pos = Vector(-4056.000000, 2771.000000, 73.000000),
		canactivate = function(pl, ent) return false end
	},
	{
		name = "049",
		pos = Vector(-4295.140137, 682.059998, -5090.000000),
		customdenymsg = "Please wait until the round starts",
		canactivate = function(pl, ent)
			if preparing then
				return false
			else 
				return true 
			end
		end 

	}

}

--the escape zone
POS_GATEA = Vector(-4125.558594, 2966.719727, 20.031250)
--The center of the escort zone
POS_ESCORT = Vector(-5634.312988, 2954.567627, 340.031250)
--The button used to open the gate
POS_GATEABUTTON = Vector(-3678.050049, 2413.800049, -5090.000000)
--The button used to open 173's room
POS_173DOORS = Vector(0,0,0)
--Maybe works?
POS_106DOORS = Vector(-5931.990234, 945.010010, -6207.000000)
--Doesn't work due to the way the map works
POS_049BUTTON = Vector(-4295.140137, 682.059998, -5090.000000)
--Same as 173DOORS
POS_173BUTTON = Vector(0,0,0)
--Used to open 096's zone
POS_096BUTTON = Vector(-3061.139893, -3358.939941, -5089.750000)
--This line is fine
POS_096_1BTN = POS_096BUTTON
--Not even sure what thats used for
POS_682BUTTON = Vector(-2270.139893, -32.939999, -6329.750000)
--This is probably unused
POS_BTN1048A1 =  Vector(-3281.500000, 2439.000000, -6119.000000)
--Unused? I made them all the same because who knows what else they should be
POS_BTN1048A2 =  Vector(-3281.500000, 2439.000000, -6119.000000)
--Was used to open 966's old spawn, map broke it
POS_BTN966 = Vector(-3061.139893, 511.059998, -5089.750000)




--new one
POS_BTN966_2 = Vector(-3061.139893, 511.059998, -5089.750000)
--Pocket dem locations. They are in the void since there is no PD and 106 is disabled.
POS_POCKETD = {

Vector(-2961.625244, -4829.223145, -6166.818848),
Vector(-1570.915894, -5215.154785, -6162.512207),
Vector(-1702.865967, -5183.582031, -6141.937988),
Vector(-1859.588013, -5146.082031, -6117.499512),
Vector(-2039.146729, -5103.117676, -6089.501465),
Vector(-2226.298584, -5058.336914, -6060.319336)

}

--not sure if any of these functions are needed for this map

--Called when a player requests gate a
--Use an empty function for maps without gates
local function Breach_RequestGateA(ply)

end

hook.Add("BreachMap_RequestGateA","Breach_gmsite19_requestGateA", Breach_RequestGateA)

--Sets the RDC's state, does nothing if already in the desired state
local function Breach_SetRDCState(desired)

end
hook.Add("BreachMap_SetRDCState", "Breach_site19_desiredRDC", Breach_SetRDCState)

--This function toggles if gate a is open or not
--This is probably unused, but I ported it just in case
local function Breach_ToggleGateA()

end

hook.Add("BreachMap_ToggleGateA", "Breach_site19_ToggleMainGate", Breach_ToggleGateA)

--Function used in the gamemode to close SCP doors
--Some of this is probably broken on the default map
--Potientally unused
local function Breach_CloseSCPDoors()

end
hook.Add("BreachMap_CloseSCPDoors", "Breach_site19_CloseDoors", Breach_CloseSCPDoors)

--Function used to release SCPs at the start of the round
local function Breach_OpenSCPDoors()
print("map: open scp doors")
	//WARNING KANADE CODE BELOW, THIS MAY HAVE ADVERSE HEALTH EFFECTS
	--also duc code so could also be bad for your health. I know there's a way to do this without 11 different if statements but it's quicker for me to write this than remember how to do that. 
	for k, v in pairs( ents.FindByClass( "func_button" ) ) do

		if v:GetPos() == Vector(-2685.000000, -3473.000000, -5079.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-3958.949951, -735.840027, -6113.750000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-6035.990234, -469.000000, -5095.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-2651.500000, 1605.000000, -6119.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-5371.009766, 985.000000, -5095.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-2651.500000, 2177.000000, -6119.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-2651.500000, 2749.000000, -6119.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-3281.500000, 2439.000000, -6119.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-3290.800049, 1590.949951, -6118.459961) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-6035.990234, -469.000000, -5095.000000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-2270.139893, -32.939999, -6329.750000) then
			ForceUse(v, 1, 1)
		end
		if v:GetPos() == Vector(-3061.139893, 511.059998, -5089.750000) then
			ForceUse(v, 1, 1)
		end
	end
	

end
hook.Add("BreachMap_OpenSCPDoors", "Breach_site19_OpenDoors", Breach_OpenSCPDoors)


--Called right after we reset the map, this is called every round
--Called right when preparing starts, before any players / entities are spawned
--Use this if a map needs some things disabled or something
--Also can be used to clean map ents
local function Breach_PostMapCleanup()

end

hook.Add("PostCleanupMap", "BreachMap_site19_mapcleaned", Breach_PostMapCleanup)

TIMED_GATE_SUPPORTED_MAP = true

hook.Add("FOpenGateA", "BreachMap_site19_gateaopenforced", function ()

end)

hook.Add("OpenGateB", "BreachMap_site19_gatebopen", function ()

end)
