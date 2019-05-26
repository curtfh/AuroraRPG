---------------------->
-- Peds / Vehs creator
-- Created by Nicolas
----------------------------------------
----------------------------------------
-- Tables:
local vehicles = {
	--{vehID = vehicle ID, posX = X position, posY = Y position, posZ = Z position, rot = rotation, colorR = red color, colorG = green color, colorB = blue color},
	
	--LSPD
	{vehID = 596, posX = 1548.67, posY = -1606.97, posZ = 13.38, rot = 180, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},	-- LSPD LS Police	
	{vehID = 426, posX = 1591.93, posY = -1606.9, posZ = 13.38, rot = 0, colorR = 69, colorG = 69, colorB = 69},	-- LSPD Premier
	{vehID = 599, posX = 1598.24, posY =  -1607.06, posZ = 13.78, rot = 180, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},	-- LSPD Police Ranger
	{vehID = 523, posX = 1604.32, posY =  -1630.91, posZ = 13.45, rot = 58, colorR = 255, colorG = 255, colorB = 255},	-- LSPD HPV-1000
	{vehID = 523, posX = 1605.07, posY =  -1628.71, posZ = 13.45, rot = 55, colorR = 255, colorG = 255, colorB = 255},	-- LSPD HPV-1000
	{vehID = 415, posX = 1595.5, posY =  -1710.56, posZ = 5.89, rot = 180, colorR = 69, colorG = 69, colorB = 69},	-- LSPD Cheetah
	{vehID = 490, posX = 1570.29, posY =  -1711.44, posZ = 6.2, rot = 0, colorR = 33, colorG = 33, colorB = 33, colorR2 = 33, colorG2 = 33, colorB2 = 33},	-- LSPD FBI Rancher
	{vehID = 427, posX = 1529, posY =  -1688.28, posZ = 6.2, rot = 90, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},	-- LSPD Enforcer
	{vehID = 428, posX = 1530.69, posY =  -1645.49, posZ = 6.2, rot = 180, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},	-- LSPD Securicar
	{vehID = 528, posX = 1545.25, posY =  -1655, posZ = 6, rot = 90, colorR = 255, colorG = 255, colorB = 255},	-- LSPD FBI Truck
	{vehID = 596, posX = 1545.45, posY =  -1672.21, posZ = 5.89, rot = 270, rot = 90, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},	-- LSPD LS Police
	
	--Misc
	{vehID = 433, posX = 290.16, posY = 1878.18, posZ = 18.3, rot = 304, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 433, posX = 290.16, posY = 1866.85, posZ = 18.3, rot = 304, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 433, posX = 290.16, posY = 1872.18, posZ = 18.3, rot = 304, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 433, posX = 290.16, posY = 1882.81, posZ = 18.3, rot = 304, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 432, posX = 290.16, posY = 1908.69, posZ = 18, rot = 304, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 432, posX = 290.16, posY = 1898.88, posZ = 18, rot = 304, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 520, posX = 365.79, posY = 1935.28, posZ = 18.55, rot = 87, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 520, posX = 367.18, posY = 1968.59, posZ = 18.55, rot = 89, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 520, posX = 342, posY = 1907.92, posZ = 18.55, rot = 359, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 470, posX = 90.15, posY = 2080.17, posZ = 17.6, rot = 92, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 425, posX = 338.6, posY = 1871.59, posZ = 18.74, rot = 70, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 425, posX = 338.6, posY = 1858.87, posZ = 19.05, rot = 70, colorR = 0, colorG = 100, colorB = 0},
	{vehID = 425, posX = 338.6, posY = 1843.02, posZ = 18.66, rot = 70, colorR = 0, colorG = 100, colorB = 0},	
	{vehID = 425, posX = 338.6, posY = 1843.02, posZ = 18.66, rot = 70, colorR = 0, colorG = 100, colorB = 0},
	
	
	-- LS All Saints Hospital
	{vehID = 563, posX = 1162.026, posY = -1313.87, posZ = 32.5, rot = 90, colorR = 153, colorG = 0, colorB = 0},
	{vehID = 416, posX = 1135.86, posY = -1340.87, posZ = 14.1, rot = 180, colorR = 153, colorG = 0, colorB = 0},
	{vehID = 490, posX = 1133.12, posY = -1330.37, posZ = 13.9, rot = 198.89747619629, colorR = 0, colorG = 0, colorB = 0},
	{vehID = 405, posX = 1146.18, posY = -1314.82, posZ = 13.65, rot = 90, colorR = math.random( 0, 255 ), colorG = math.random( 0, 255 ), colorB = math.random( 0, 255 )},
	{vehID = 521, posX = 1147.97, posY = -1304.56, posZ = 13.68, rot = 154.32983398438, colorR = 245, colorG = 0, colorB = 110},
	{vehID = 524, posX = 1280.34, posY = -1263.81, posZ = 14.70, rot = 180, colorR = 188, colorG = 188, colorB = 188},
	{vehID = 406, posX = 1251.62, posY = -1256.46, posZ = 15.43, rot = 271.99536132813, colorR = 255, colorG = 255, colorB = 255, bool = true},
	{vehID = 546, posX = 1363, posY = -1288.71, posZ = 13.3, rot = 0, colorR = math.random( 150, 255 ), colorG = math.random( 80, 200 ), colorB = math.random( 30, 120 )},
	
	
	
	-- LS Grove Street
	{vehID = 492, posX = 2508.21, posY = -1666.99, posZ = 13.6, rot = 11.874725341797, colorR = 135, colorG = 206, colorB = 235},
	{vehID = 600, posX = 2469.84, posY = -1710.4, posZ = 13.6, rot = 302.58258056641, colorR = 160, colorG = 82, colorB = 45},
	
	
	-- LV Hospital
	{vehID = 416, posX = 1589.83, posY = 1849.09, posZ = 11.17, rot = 180, colorR = 153, colorG = 0, colorB = 0},
	
	
	-- Drug Farm
	{vehID = 478, posX = 1900.99, posY = 168.52, posZ = 37.35, rot = 84.030456542969, colorR = 255, colorG = 228, colorB = 196},
	
	
	-- LV War Zone
	{vehID = 427, posX = 1634.5, posY = 203.5, posZ = 32.2, rot = 333.99536132813, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},
	{vehID = 598, posX = 1641.400390625, posY = 230.7001953125, posZ = 30.200000762939, rot = 319.99877929688, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},
	{vehID = 598, posX = 1643.5, posY = 238.2001953125, posZ = 30, rot = 329.99877929688, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},
	{vehID = 427, posX = 1787.400390625, posY = 696.8, posZ = 15.800000190735, rot = 325.99731445313, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},
	{vehID = 598, posX = 1789.7998046875, posY = 704.599609375, posZ = 14.89999961853, rot = 309.99572753906, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},
	{vehID = 598, posX = 1803.7998046875, posY = 702.7001953125, posZ = 14.89999961853, rot = 31.9921875, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},
	{vehID = 599, posX = 943.099609375, posY = 737.400390625, posZ = 11.199999809265, rot = 261.99645996094, colorR = 65, colorG = 105, colorB = 225, colorR2 = 176, colorG2 = 196, colorB2 = 222},
	{vehID = 470, posX = 933.2001953125, posY = 2591.7001953125, posZ = 10.45, rot = 273.99353027344, colorR = 255, colorG = 218, colorB = 185},
	{vehID = 470, posX = 938.400390625, posY = 2587, posZ = 10.45, rot = 233.99780273438, colorR = 255, colorG = 218, colorB = 185},
	{vehID = 433, posX = 946, posY = 2587.2998046875, posZ = 11.15, rot = 219.99572753906, colorR = 255, colorG = 218, colorB = 185},
	{vehID = 432, posX = 949.599609375, posY = 2606.2998046875, posZ = 10.9, rot = 215.9912109375, colorR = 255, colorG = 255, colorB = 255},
	{vehID = 432, posX = 930.2001953125, posY = 2571.2998046875, posZ = 10.85, rot = 265.99548339844, colorR = 255, colorG = 255, colorB = 255},
	{vehID = 470, posX = 1655.400390625, posY = 1856.599609375, posZ = 10.9, rot = 13.991088867188, colorR = 255, colorG = 218, colorB = 185},
	{vehID = 544, posX = 1666.599609375, posY = 1817.2001953125, posZ = 11.199999809265, rot = 315.99975585938, colorR = 153, colorG = 0, colorB = 0},
	{vehID = 579, posX = 2119.400390625, posY = 2355.2001953125, posZ = 10.800000190735, rot = 90, colorR = 0, colorG = 0, colorB = 0},
	{vehID = 409, posX = 2127.900390625, posY = 2355.7001953125, posZ = 10.7, rot = 90, colorR = 0, colorG = 0, colorB = 0},
	{vehID = 579, posX = 2135.900390625, posY = 2355.5, posZ = 10.800000190735, rot = 90, colorR = 0, colorG = 0, colorB = 0},
	{vehID = 433, posX = 1697.599609375, posY = 1706.2998046875, posZ = 11.39999961853, rot = 261.99645996094, colorR = 255, colorG = 255, colorB = 255},
	{vehID = 490, posX = 2879.67, posY = 2607.03, posZ = 11.15, rot = 62.641876220703, colorR = 0, colorG = 0, colorB = 0},
	
	

	
		
	--SSG
	--{vehID = 528, posX = -11.10000038147, posY = 293.70001220703, posZ = 2, rot = 0, colorR = 0, colorG = 100, colorB = 0}, -- SSG FBI Truck
	--{vehID = 528, posX =  -4.3000001907349, posY = 293.60000610352, posZ = 2, rot = 0, colorR = 0, colorG = 100, colorB = 0}, -- SSG FBI Truck
	--{vehID = 528, posX = 3.0999999046326, posY = 293.60000610352, posZ = 2, rot = 0, colorR = 0, colorG = 100, colorB = 0}, -- SSG FBI Truck 
}

local peds = {
	--{pedID = ped ID, pedX = X position, pedY = Y position, pedZ = Z position, rot = rotation, pedMainWeaponID = main weapon},
	
	--LSPD
	{pedID = 71, pedX =  1544.09, pedY = -1631.87, pedZ =  13.38, rot = 63, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, -- LSPD Guard
	{pedID = 280, pedX =  1548.67, pedY = -1609.89, pedZ =  13.38, rot = 180, pedMainWeaponID = 0, animBlock = "smoking", animName = "m_smklean_loop"}, -- LSPD Cop smoking
	{pedID = 240, pedX =  1591.14, pedY = -1610.66, pedZ =  13.38, rot = 270, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, -- LSPD Detective
	{pedID = 288, pedX =  1592.71, pedY = -1610.76, pedZ =  13.38, rot = 90, pedMainWeaponID = 0, animBlock = "gangs", animName = "prtial_gngtlkc"}, -- LSPD Sheriff
	{pedID = 71, pedX =  1603.42, pedY = -1616.04, pedZ =  13.5, rot = 90, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, -- LSPD Guard
	{pedID = 284, pedX =  1602.09, pedY = -1627.83, pedZ =  13.48, rot = 202, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, -- LSPD Motor Cop
	{pedID = 284, pedX =  1602.87, pedY = -1629.42, pedZ =  13.49, rot = 32, pedMainWeaponID = 0, animBlock = "gangs", animName = "prtial_gngtlka"}, -- LSPD Motor Cop	
	{pedID = 166, pedX =  1595.4, pedY = -1707.57, pedZ =  5.89, rot = 0, pedMainWeaponID = 0, animBlock = "smoking", animName = "m_smklean_loop"}, -- LSPD Detective
	{pedID = 286, pedX =  1572, pedY = -1711.77, pedZ =  5.89, rot = 270, pedMainWeaponID = 0, animBlock = "gangs", animName = "leanidle"}, -- LSPD FBI
	{pedID = 285, pedX =  1527.82, pedY = -1685.93, pedZ =  5.89, rot = 0, pedMainWeaponID = 31, animBlock = "camera", animName = "camcrch_idleloop"}, -- LSPD SWAT
	{pedID = 285, pedX =  1529.16, pedY = -1685.93, pedZ =  5.89, rot = 0, pedMainWeaponID = 31, animBlock = "camera", animName = "camcrch_idleloop"}, -- LSPD SWAT
	{pedID = 285, pedX =  1530.46, pedY = -1685.93, pedZ =  5.89, rot = 0, pedMainWeaponID = 31, animBlock = "camera", animName = "camcrch_idleloop"}, -- LSPD SWAT
	{pedID = 165, pedX =  1529.16, pedY = -1681.84, pedZ =  5.89, rot = 180, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_think"}, -- LSPD SWAT
	{pedID = 280, pedX =  1544.86, pedY = -1669.08, pedZ =  13.55, rot = 109, pedMainWeaponID = 0, animBlock = "gangs", animName = "prtial_gngtlkb"}, -- LSPD Cop
	{pedID = 281, pedX =  1543.25, pedY = -1669.85, pedZ =  13.55, rot = 298, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_think"}, -- LSPD Cop
	
	--LSPD interior
	{pedID = 282, pedX =  1561.93, pedY = -1680.47, pedZ =  16.19, rot = 333, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 281, pedX =  1563.17, pedY = -1685.15, pedZ =  16.19, rot = 0, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 286, pedX =  1564.07, pedY = -1682.71, pedZ =  16.19, rot = 165, pedMainWeaponID = 0, animBlock = "gangs", animName = "prtial_gngtlka"}, 
	{pedID = 283, pedX =  1577.46, pedY = -1676.26, pedZ =  16.19, rot = 90.158081054688, pedMainWeaponID = 0, animBlock = "gangs", animName = "prtial_gngtlka"}, 
	{pedID = 166, pedX =  1576.19, pedY = -1676.17, pedZ =  16.19, rot = 263.85247802734, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_think"}, 
	{pedID = 154, pedX =  1565.17, pedY = -1690.36, pedZ =  15.79, rot = 180.13623046875, pedMainWeaponID = 10, animBlock = "STRIP", animName = "strip_C"}, 
	{pedID = 97, pedX =  1567.96, pedY = -1682.97, pedZ =  16.19, rot = 85.787902832031, pedMainWeaponID = 0, animBlock = "BOMBER", animName = "BOM_Plant_Loop"}, 
	{pedID = 165, pedX =  1572.77, pedY = -1686.93, pedZ =  16.19, rot = 1.5577087402344, pedMainWeaponID = 0, animBlock = "GANGS", animName = "leanIDLE"}, 
	{pedID = 240, pedX =  1572.97, pedY = -1686.03, pedZ =  16.19, rot = 167.44439697266, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlkH"}, 
	{pedID = 280, pedX =  1566.33, pedY = -1667.68, pedZ =  17.58, rot = 269.12301635742, pedMainWeaponID = 0, animBlock = "GANGS", animName = "Invite_No"}, 
	{pedID = 91, pedX =  1568.03, pedY = -1667.6, pedZ =  17.58, rot = 93.878448486328, pedMainWeaponID = 0, animBlock = "GRAVEYARD", animName = "mrnF_loop"}, 
	{pedID = 71, pedX =  1586.23, pedY = -1698.61, pedZ =  13.58, rot = 45.613952636719, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 254, pedX =  1571.76, pedY = -1693.06, pedZ =  13.58, rot = 179.83520507813, pedMainWeaponID = 0, animBlock = "CRACK", animName = "crckidle4"}, 
	
	
	-- LS All Saints Hospital
	{pedID = 275, pedX =  1177.11, pedY = -1327.02, pedZ =  14.05, rot = 310.57583618164, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 70, pedX =  1177.9, pedY = -1326.17, pedZ =  14.05, rot = 133.57046508789, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlkH"}, 
	{pedID = 10, pedX =  1163.36, pedY = -1328.23, pedZ =  31.49, rot = 56.326049804688, pedMainWeaponID = 0, animBlock = "MISC", animName = "SEAT_LR"}, 
	{pedID = 276, pedX =  1163.87, pedY = -1327.75, pedZ =  31.48, rot = 178.98614501953, pedMainWeaponID = 0, animBlock = "BOMBER", animName = "BOM_Plant_Loop"}, 
	{pedID = 71, pedX =  1163.42, pedY = -1299.28, pedZ =  31.64, rot = 183.24252319336, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 274, pedX =  1137.8, pedY = -1337.9, pedZ =  13.7, rot = 263.73590087891, pedMainWeaponID = 0, animBlock = "GANGS", animName = "leanIDLE"}, 
	{pedID = 165, pedX =  1138.5, pedY = -1337.93, pedZ =  13.69, rot = 81.664947509766, pedMainWeaponID = 0, animBlock = "gangs", animName = "prtial_gngtlka"}, 
	{pedID = 286, pedX =  1138.17, pedY = -1336.32, pedZ =  13.69, rot = 343.52453613281, pedMainWeaponID = 0, animBlock = "DEALER", animName = "DEALER_IDLE"}, 
	{pedID = 71, pedX =  1145.66, pedY = -1296.56, pedZ =  13.64, rot = 90, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 27, pedX =  1278.20, pedY = -1265.43, pedZ =  13.53, rot = 90, pedMainWeaponID = 0, animBlock = "GANGS", animName = "leanIDLE"}, 
	{pedID = 153, pedX =  1272.32, pedY = -1271.57, pedZ =  13.53, rot = 90, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlkH"}, 
	{pedID = 260, pedX =  1271.31, pedY = -1271.62, pedZ =  13.53, rot = 268.33828735352, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlka"}, 
	{pedID = 22, pedX =  1364.51, pedY = -1286.72, pedZ =  13.54, rot = 180, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 56, pedX =  1364.54, pedY = -1287.96, pedZ =  13.54, rot = 0, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlkH"}, 
	
	-- LS Ammu Nation (Market)
	{pedID = 179, pedX =  1370.6, pedY = -1291.99, pedZ =  13.54, rot = 270, pedMainWeaponID = 0, animBlock = "shop", animName = "shp_serve_idle"}, 
	{pedID = 179, pedX =  1378.43, pedY = -1282.8, pedZ =  13.54, rot = 180, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 179, pedX =  1370.33, pedY = -1286.29, pedZ =  18, rot = 270, pedMainWeaponID = 0, animBlock = "gangs", animName = "prtial_gngtlka"},  
	{pedID = 111, pedX =  1372.63, pedY = -1286.29, pedZ =  18, rot = 90, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_think"},
	{pedID = 46, pedX =  1386.13, pedY = -1288.81, pedZ =  18, rot = 270, pedMainWeaponID = 25, animBlock = "shop", animName = "shp_gun_fire"},
	
	-- LS Grove Street
	{pedID = 271, pedX =  2465.87, pedY = -1711.51, pedZ =  13.5, rot = 175.52374267578, pedMainWeaponID = 0, animBlock = "BOMBER", animName = "BOM_Plant_Loop"}, 
	{pedID = 107, pedX =  2478.6, pedY = -1687.63, pedZ =  13.5, rot = 356.009765625, pedMainWeaponID = 0, animBlock = "GANGS", animName = "leanIDLE"}, 
	{pedID = 28, pedX =  2513, pedY = -1654.85, pedZ =  13.87, rot = 159.82067871094, pedMainWeaponID = 0, animBlock = "DEALER", animName = "DEALER_IDLE"}, 
	{pedID = 293, pedX =  2490.17, pedY = -1647.32, pedZ =  14.07, rot = 47.011016845703, pedMainWeaponID = 0, animBlock = "RAPPING", animName = "RAP_B_Loop"}, 
	{pedID = 237, pedX =  2488.57, pedY = -1646.89, pedZ =  14.07, rot = 258.83703613281, pedMainWeaponID = 0, animBlock = "DANCING", animName = "dance_loop"}, 
	{pedID = 13, pedX =  2489.46, pedY = -1645.76, pedZ =  14.07, rot = 190.76219177246, pedMainWeaponID = 0, animBlock = "RAPPING", animName = "RAP_A_Loop"}, 
	{pedID = 102, pedX =  2535.57, pedY = -1666.23, pedZ =  15.16, rot = 171.02197265625, pedMainWeaponID = 22, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 103, pedX =  2536.61, pedY = -1666.55, pedZ =  15.16, rot = 138.79309082031, pedMainWeaponID = 28, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 104, pedX =  2535.38, pedY = -1668.93, pedZ =  15.16, rot = 90, pedMainWeaponID = 28, animBlock = "SWAT", animName = "swt_wllpk_R"}, 
	{pedID = 134, pedX =  2432.74, pedY = -1675.36, pedZ =  13.67, rot = 40.495056152344, pedMainWeaponID = 0, animBlock = "LOWRIDER", animName = "M_smkstnd_loop"}, 
	{pedID = 77, pedX =  2430.46, pedY = -1674.7, pedZ =  13.67, rot = 285.27685546875, pedMainWeaponID = 0, animBlock = "CRACK", animName = "crckidle4"}, 


	-- LV Hospital
	{pedID = 71, pedX =  1630.02, pedY = 1818.71, pedZ =  10.94, rot = 5.9992370605469, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 275, pedX =  1620.81, pedY = 1820.43, pedZ =  10.82, rot = 54.696136474609, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 70, pedX =  1619.86, pedY = 1821.03, pedZ =  10.82, rot = 234.6173248291, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlkH"}, 
	
	
	--Drug Farm
	{pedID = 158, pedX =  1909.69, pedY = 169.67, pedZ =  37.18, rot = 286.33251953125, pedMainWeaponID = 0, animBlock = "BOMBER", animName = "BOM_Plant_Loop"}, 
	{pedID = 159, pedX =  1935.5, pedY = 157.82, pedZ =  37.39, rot = 72.959899902344, pedMainWeaponID = 0, animBlock = "LOWRIDER", animName = "M_smkstnd_loop"}, 
	{pedID = 157, pedX =  1940.68, pedY = 171.42, pedZ =  40.96, rot = 24.091735839844, pedMainWeaponID = 0, animBlock = "sunbathe", animName = "parksit_w_idleb"}, 
	

	-- LV War Zone
	{pedID = 285, pedX =  1636.5999755859, pedY = 207.60000610352, pedZ =  31.60000038147, rot = 62.0031127, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 285, pedX =  1635.3000488281, pedY = 207.89999389648, pedZ =  31.60000038147, rot = 260.003692, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlkH"}, 
	{pedID = 282, pedX =  1641.4000244141, pedY = 232.89999389648, pedZ =  30.299999237061, rot = 44.0031127, pedMainWeaponID = 0, animBlock = "LOWRIDER", animName = "M_smkstnd_loop"}, 
	{pedID = 282, pedX =  1640.5, pedY = 233.69999694824, pedZ =  30.299999237061, rot = 238.394927, pedMainWeaponID = 0, animBlock = "cop_ambient", animName = "coplook_loop"}, 
	{pedID = 282, pedX =  1802.1999511719, pedY = 702.20001220703, pedZ =  15.10000038147, rot = 0, pedMainWeaponID = 25, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 282, pedX =  1791.5, pedY = 703.70001220703, pedZ =  15.10000038147, rot = 327.0722351074, pedMainWeaponID = 22, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 165, pedX =  1789.4000244141, pedY = 696.79998779297, pedZ =  15.5, rot = 158.002563, pedMainWeaponID = 25, animBlock = "", animName = ""},  -- !
	{pedID = 285, pedX =  1788.8000488281, pedY = 695.29998779297, pedZ =  15.60000038147, rot = 312.002960, pedMainWeaponID = 29, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 285, pedX =  1787.5999755859, pedY = 693.29998779297, pedZ =  15.699999809265, rot = 316.002929, pedMainWeaponID = 29, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 285, pedX =  1788.5, pedY = 694.17, pedZ =  15.67, rot = 324.81704711914, pedMainWeaponID = 29, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 288, pedX =  944.84, pedY = 739.19, pedZ =  10.78, rot = 264.95281982422, pedMainWeaponID = 25, animBlock = "", animName = ""}, 
	{pedID = 283, pedX =  944.6, pedY = 735.22, pedZ =  10.76, rot = 278.6501159668, pedMainWeaponID = 29, animBlock = "ped", animName = "WEAPON_crouch"}, 
	{pedID = 287, pedX =  934.70001220703, pedY = 2594.5, pedZ =  10.5, rot = 120.002746, pedMainWeaponID = 31, animBlock = "", animName = ""}, 
	{pedID = 287, pedX =  933.40002441406, pedY = 2593.6999511719, pedZ =  10.5, rot = 295.999114, pedMainWeaponID = 0, animBlock = "GANGS", animName = "prtial_gngtlkH"}, 
	{pedID = 280, pedX =  1787, pedY = 702.2001953125, pedZ =  15.199999809265, rot = 130.005920, pedMainWeaponID = 0, animBlock = "CRACK", animName = "crckidle4"}, 
	{pedID = 275, pedX =  1786.5, pedY = 701.59997558594, pedZ =  15.199999809265, rot = 320.005920, pedMainWeaponID = 0, animBlock = "medic", animName = "cpr"}, 
	{pedID = 286, pedX =  2877.6999511719, pedY = 2611, pedZ =  10.800000190735, rot = 90.0027465, pedMainWeaponID = 31, animBlock = "shop", animName = "shp_gun_aim"}, 
	{pedID = 286, pedX =  2876.1999511719, pedY = 2606.6999511719, pedZ =  10.800000190735, rot = 70.0032348, pedMainWeaponID = 31, animBlock = "shop", animName = "shp_gun_aim"}, 
	{pedID = 287, pedX =  1640, pedY = 1861.8000488281, pedZ =  10.800000190735, rot = 0, pedMainWeaponID = 31, animBlock = "", animName = ""}, 
	{pedID = 287, pedX =  1638, pedY = 1838.9000244141, pedZ =  10.800000190735, rot = 270, pedMainWeaponID = 31, animBlock = "", animName = ""}, 
	{pedID = 287, pedX =  1638, pedY = 1827.5, pedZ =  10.800000190735, rot = 270, pedMainWeaponID = 31, animBlock = "", animName = ""}, 
	{pedID = 287, pedX =  1577, pedY = 1827.6999511719, pedZ =  10.800000190735, rot = 90, pedMainWeaponID = 31, animBlock = "", animName = ""}, 
	{pedID = 287, pedX =  1577, pedY = 1839, pedZ =  10.800000190735, rot = 90, pedMainWeaponID = 31, animBlock = "", animName = ""}, 
	{pedID = 278, pedX =  1662.6999511719, pedY = 1822, pedZ =  11.300000190735, rot = 220.001831, pedMainWeaponID = 0, animBlock = "on_lookers", animName = "lkaround_loop"}, 
	{pedID = 278, pedX =  1660.0999755859, pedY = 1815.5, pedZ =  11.10000038147, rot = 270.000885, pedMainWeaponID = 0, animBlock = "", animName = ""}, 
	
	
	

	
	--Misc
	{pedID = 287, pedX =  94.12, pedY = 2063.74, pedZ =  17.58, rot = 99, pedMainWeaponID = 31, animBlock = "lowrider", animName = "m_smklean_loop"},
	{pedID = 312, pedX = 340.19, pedY = 1793.65, pedZ = 18.14 , rot = 206, pedMainWeaponID = 31, animBlock = "lowrider", animName = "m_smklean_loop"},
	{pedID = 287, pedX =  188.55, pedY = 1926.54, pedZ =  17.65, rot = 180, pedMainWeaponID = 24, animBlock = "ped", animName = "idle_chat"},
	{pedID = 287, pedX =  188.55, pedY = 1925, pedZ =  17.65, rot = 360, pedMainWeaponID = 24, animBlock = "ped", animName = "idle_chat"},
	{pedID = 73, pedX =  348.59, pedY = 1943.07, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  348.59, pedY = 1947.6, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  348.59, pedY = 1952.87, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  348.59, pedY = 1956.38, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  348.59, pedY = 1959.17, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  344.95, pedY = 1943.07, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  344.95, pedY = 1947.6, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  344.95, pedY = 1952.87, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  344.95, pedY = 1956.38, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},
	{pedID = 73, pedX =  344.95, pedY = 1959.17, pedZ =  17.64, rot = 360, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"},	
	{pedID = 145, pedX =  191.35, pedY = 3289.66, pedZ =  16.22, rot = 90, pedMainWeaponID = 12, animBlock = "beach", animName = "lay_bac_loop"},
	{pedID = 154, pedX =  188.29, pedY = 3289.03, pedZ =  15.5, rot = 293.36724853516, pedMainWeaponID = 10, animBlock = "paulnmac", animName = "piss_loop"},
	{pedID = 211, pedX =  -413.68, pedY = 1358.06, pedZ =  12.82, rot = 100, pedMainWeaponID = 10, animBlock = "cop_ambient", animName = "coplook_loop"},	
	
	--SSG
	--{pedID = 26, pedX =  -38, pedY = 309.9 , pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -40, pedY = 309 , pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -40, pedY = 310.8, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -42, pedY = 308.10, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -42, pedY = 309.9, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -42, pedY = 311.7, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -44, pedY = 307.2, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -44, pedY = 309, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -44, pedY = 310.8, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -44, pedY = 312.6, pedZ = 2.05, rot = 270, pedMainWeaponID = 0, animBlock = "park", animName = "tai_chi_loop"}, -- SSG ped
	--{pedID = 26, pedX =  -1.7999999523163, pedY = 288.89999389648, pedZ = 6.6999998092651, rot = 0, pedMainWeaponID = 31, animBlock = "shop", animName = "shp_gun_aim"}, -- SSG ped
	--{pedID = 26, pedX = -36.08, pedY = 468.93, pedZ = 1.96, rot = 270, pedMainWeaponID = 0, animBlock = "bd_fire", animName = "m_smklean_loop"}, -- SSG ped
}


--- DO NOT EDIT createdVehs table! (LET IT CLEAR)
local createdVehs = {}
local createdPeds = {}
----------------------------------------


-- Create vehicles / Peds once the script started
function createVehiclesAndPeds ( )
	for i, v in ipairs(vehicles) do
		local vehicleID = v.vehID
		local x, y, z, rotZ = v.posX, v.posY, v.posZ, v.rot
		local r, g, b = v.colorR or 255, v.colorG or 255, v.colorB or 255
		local r2, g2, b2 = v.colorR2 or 255, v.colorG2 or 255, v.colorB2 or 255
		local datVehicle = createVehicle ( vehicleID, x, y, z-0.2, 0, 0, rotZ )
		setVehicleDamageProof( datVehicle, true )
		local marker = createMarker(x,y,z,"arrow",0.1,0,0,0,0)
		setElementData(datVehicle,"setModelStream",true)

        table.insert(createdVehs, datVehicle)
		setElementFrozen ( datVehicle, true )
		setVehicleDamageProof ( datVehicle, true )
		if setVehicleHeadLightColor ( datVehicle, r, g, b ) then
			if (bool == true) then
				setVehicleColor( datVehicle, r, g, 255 )
			else
				setVehicleColor( datVehicle, r, g, b, r2, g2, b2 )
			end
		end
	end
	for i, v in ipairs(peds) do
		local pedID = v.pedID
		local x, y, z, rotZ = v.pedX, v.pedY, v.pedZ, v.rot
		local pedAnimBlock, animation = v.pedAnimBlock, v.pedAnim
		local mainWep = v.pedMainWeaponID
   		local thePED = createPed ( pedID, x, y, z, rotZ )
		setElementData(thePED,"showModelPed",true)
   		local animBlock = v.animBlock or false
   		local animName = v.animName or false
   		createdPeds[thePED] = {animBlock, animName}
    	setElementFrozen ( thePED, true )
    	if animBlock ~= "" and animName ~= "" then
   		setTimer(setPedAnimation, 1000, 1, thePED, animBlock, animName, -1, true, false, false)
   		end
    	giveWeapon ( thePED, mainWep, 5000, true )
   	end
end
addEventHandler ( "onResourceStart", resourceRoot, createVehiclesAndPeds )

-- Disable being able to enter vehicles created by this script
function enterVehicle ( player, seat, jacked )
	local vehicle = source
	for i, v in ipairs(createdVehs) do
		if v == source then
			cancelEvent()
		end
    end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )

function getPeds()
	triggerClientEvent(source, "AURstaticpedveh.recieveCPed", source, createdPeds)
end
addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", root, getPeds)