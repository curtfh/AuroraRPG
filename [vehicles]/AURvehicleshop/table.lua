myFont = guiCreateFont( "font.ttf", 15 )
myFont4 = guiCreateFont( "font3.ttf", 15 )

markers = {
{"Boat",-20.02, -1653.76, 1.2,int=0,pos={-1.66,-1657.23,1.48,329},cam={-25.377, -1645.16, 7.91, 56.61, -1697.885, -14.411, },spawn={-8.11,-1648.37,1.09,183,-19.41,-1634.84,2.33,262}},--LSBOAT
{"Boat",-2188.49, 2413.02, 4.15,int=0,pos={-2234.15,2422.24,2.85,5},cam={-2218.516, 2408.619, 6.85, -2284.692, 2476.928, -24.046, },spawn={-2232.19,2451.71,0.28,138,-2242.12,2450.41,2.47,226}},--SFBOAT
{"Boat",2359.3896484375, 525.70703125, 0.7,int=0,pos={2386.16,525.75,1.38,213},cam={2410.379, 509.598, 10.574, 2334.181, 567.801, -17.823, },spawn={2304.98,527.56,1.06,181,2298.09,545.74,2.84,181}},---LVBOAT
{"Plane",2091.9, -2413.37, 12.54,int=0,pos={2071.22,-2493.94,13.54,89},cam={2069.544, -2475.617, 17.884, 2074.456, -2570.434, -13.509, },spawn={2065.41,-2593.22,13.54,90,2062.87,-2574.25,13.54,181}},--LSAIR
{"Plane",-1479.18, -632.18, 13.14,int=0,pos={-1110.58,382.22,14.99,134},cam={-1107.446, 361.349, 23.26, -1106.199, 454.887, -12.081, },spawn={-1502.67,-619.04,14.14,280,-1503.74,-600.29,14.14,180}},--SFAIR
{"Plane",1305.26, 1623.03, 9.82,int=0,pos={1280.14,1360.2,10.82,271},cam={1291.222, 1351.732, 12.939, 1214.678, 1414.403, -1.667, },spawn={1388.75,1682.47,10.82,179,1368.06,1684.02,10.82,264}},--LVAIR
{"Bike",701.72, -519.34, 15.33,int=1,pos={-2047.49,169.6,28.87,271},cam={-2046.753, 175.198, 28.873, -2055.059, 75.549, 29.92, },spawn={696.16,-522.99,16.33,133,703.19,-523.73,16.33,89}},--LSBIKE
{"Bike",-2071.65, -92.90,34,int=1,pos={-2047.49,169.6,28.87,271},cam={-2046.753, 175.198, 28.873, -2055.059, 75.549, 29.92, },spawn={-2042.91,-87.65,35.16,358,-2064.96,-84.93,35.16,268}},--SFBIKE
{"Bike",1947.56, 2068.66, 9.82,int=1,pos={-2047.49,169.6,28.87,271},cam={-2046.753, 175.198, 28.873, -2055.059, 75.549, 29.92, },spawn={1940.87,2057.51,10.82,179,1945.68,2057.42,10.82,89}},--LVBIKE
{"Car",566.71, -1289.59, 16.24,int=1,pos={-2053.03,178.50,29.52,91},cam={-2053.937, 170.651, 31.42, -2050.966, 268.932, 13.2, },spawn={557.51,-1288.15,17.24,9,543.9,-1288.9,17.24,268}},--LSCAR
{"Car",-1656.65, 1210.99, 6.3,int=1,pos={-2053.03,178.50,29.52,91},cam={-2053.937, 170.651, 31.42, -2050.966, 268.932, 13.2, },spawn={-1641.1,1214.2,7.03,226,-1640.7,1203.68,7.24,247}},--SFCAR
{"Car",2200.72, 1393.8, 9.82,int=1,pos={-2053.03,178.50,29.52,91},cam={-2053.937, 170.651, 31.42, -2050.966, 268.932, 13.2, },spawn={2139.14,1397.92,10.81,175,2175.93,1392.02,10.82,88}},--LVCAR

{"Car",2131.87,-1148.34,23,int=1,pos={-2053.03,178.50,29.52,91},cam={-2053.937, 170.651, 31.42, -2050.966, 268.932, 13.2, },spawn={2120.65,-1140.62,24.9,342,2128.69,-1141.91,25.05,346}},--LS2CAR
{"Car",-1957.17,301.38,34.46,int=1,pos={-2053.03,178.50,29.52,91},cam={-2053.937, 170.651, 31.42, -2050.966, 268.932, 13.2, },spawn={-1970.63,272.68,35.17,89,-1969.6,260.54,35.17,89}},--SF2CAR
{"Car",1658.29,2198.57,10.82,int=1,pos={-2053.03,178.50,29.52,91},cam={-2053.937, 170.651, 31.42, -2050.966, 268.932, 13.2, },spawn={1649.62,2194.78,10.82,178,1638.79,2194.43,10.82,179}},--LV2CAR

{"Truck",2282.6,-2363.78,12.54,int=1,pos={-2044.5, 166.38, 29.8,312},cam={-2051.397, 180.636, 30.291, -2009.616, 89.784, 30.815, },spawn={2273.17,-2339.36,13.54,316,2266.59,-2334.05,13.54,312}},--LSIND
{"Truck",-1959.3, -2480.63, 29.62,int=1,pos={-2044.5, 166.38, 29.8,312},cam={-2051.397, 180.636, 30.291, -2009.616, 89.784, 30.815, },spawn={-1968.75,-2476.85,30.62,108,-1966.98,-2480.83,30.63,108}},--SFIND
{"Truck",591.77, 1638.58, 6,int=1,pos={-2044.5, 166.38, 29.8,312},cam={-2051.397, 180.636, 30.291, -2009.616, 89.784, 30.815, },spawn={594.14,1644.46,6.99,65,595.81,1649.16,6.99,64}},--LVIND
{"Police",2219.94, 2455.75, -8.46,int=0,pos={2240.03,2470.56,-7.46,268},cam={2240.167, 2463.651, -4.805, 2240.552, 2558.758, -35.701, },spawn={2242.43,2446.94,-7.46,267,2234.93,2454.93,-7.46,267}},--LVcop
{"Police",1559.54, -1693.53, 4.89,int=0,pos={1545.07,-1685.39,5.89,9},cam={1544.189, -1697.634, 9.977, 1549.569, -1602.36, -19.921, },spawn={1578.69,-1709.42,5.89,359,1568.82,-1693.33,5.89,176}},--LScop
}


Objects = {
	createObject ( 12979, -2087.5, -89.2998046875, 34.200000762939, 0, 0, 90 ),
	createObject ( 12990, -19, -1586.5, 1 ),
	createObject ( 12990, -19.299999237061, -1614.5, 1 ),
	createObject ( 12990, -19.39999961853, -1642.6999511719, 1 ),


}
ramp1 = createObject ( 2395, -2055.6001, 177.3, 29.1, 270.901, 326.309, 325.562 )
ramp2 = createObject ( 2395, -2054.2, 177.3, 29.1, 270.901, 326.305, 325.558 )
ramp3 = createObject ( 2395, -2050.5, 177.3, 28.9, 293.002, 89.412, 88.611 )
setElementAlpha(ramp1,0)
setElementAlpha(ramp2,0)
setElementAlpha(ramp3,0)
setElementInterior(ramp1,1)
setElementInterior(ramp2,1)
setElementInterior(ramp3,1)
-- price table
vehicleTable = {
["Police"] = {
	[1]={596,250000*exports.AURtax:getCurrentTax()},
	[2]={597,250000*exports.AURtax:getCurrentTax()},
	[3]={599,250000*exports.AURtax:getCurrentTax()},
	[4]={598,250000*exports.AURtax:getCurrentTax()},
	[5]={523,250000*exports.AURtax:getCurrentTax()},
	[6]={426,650000*exports.AURtax:getCurrentTax()},
	[7]={427,900000*exports.AURtax:getCurrentTax()},
	[8]={497,1000000*exports.AURtax:getCurrentTax()},
	[9]={490,1500000*exports.AURtax:getCurrentTax()},
},
["Bike"] = {
	[1]={522,1500000*exports.AURtax:getCurrentTax()},-- NRG-500
	[2]={521,720000*exports.AURtax:getCurrentTax()},-- FCR-900
	[3]={461,580000*exports.AURtax:getCurrentTax()},-- PCJ-600
	[4]={581,200000*exports.AURtax:getCurrentTax()},-- BF-400
	[5]={468,150000*exports.AURtax:getCurrentTax()},-- Sanchez
	[6]={463,120000*exports.AURtax:getCurrentTax()},-- Freeway
	[7]={586,94990*exports.AURtax:getCurrentTax()},-- Wayfarer
	[8]={471,68000*exports.AURtax:getCurrentTax()},-- Quadbike
	[9]={448,25000*exports.AURtax:getCurrentTax()},-- Pizza Boy
	[10]={462,8000*exports.AURtax:getCurrentTax()},-- Faggio
	[11]={572,5000*exports.AURtax:getCurrentTax()},-- Mower
},
["Light vehicle (SUV)"] = {
	[2]={579,600000*exports.AURtax:getCurrentTax()},-- Huntley	579
	[3]={400,400000*exports.AURtax:getCurrentTax()},-- Landstalker
	[4]={582,37000*exports.AURtax:getCurrentTax()},-- News Van
	[5]={482,35000*exports.AURtax:getCurrentTax()},-- Burrito
	[6]={489,35000*exports.AURtax:getCurrentTax()},-- Rancher
	[7]={413,31000*exports.AURtax:getCurrentTax()},-- Pony
	[8]={440,31000*exports.AURtax:getCurrentTax()},-- Rumpo
	[9]={459,31000*exports.AURtax:getCurrentTax()},-- Berkley's RC Van
	[10]={442,30000*exports.AURtax:getCurrentTax()},-- Romero
	[11]={458,30000*exports.AURtax:getCurrentTax()},-- Solair
	[12]={552,29000*exports.AURtax:getCurrentTax()},-- Utility Van
	[13]={479,18000*exports.AURtax:getCurrentTax()},-- Regina
	[14]={404,17000*exports.AURtax:getCurrentTax()},-- Perennial
	[15]={418,16000*exports.AURtax:getCurrentTax()},-- Moonbeam

},
["Heavy Trucks"] = {

	[1]={486,1100000*exports.AURtax:getCurrentTax()},-- Dozer
	[2]={444,1500000*exports.AURtax:getCurrentTax()},-- Monster
	[3]={556,1500000*exports.AURtax:getCurrentTax()},-- Monster 2
	[4]={557,1500000*exports.AURtax:getCurrentTax()},-- Monster 3
	[5]={443,99000*exports.AURtax:getCurrentTax()},-- Packer
	[6]={403,90000*exports.AURtax:getCurrentTax()},-- Linerunner (NOTE: is from tank commander)
	[7]={514,90000*exports.AURtax:getCurrentTax()},-- Linerunner
	[8]={431,890000*exports.AURtax:getCurrentTax()},-- Bus
	[9]={437,890000*exports.AURtax:getCurrentTax()},-- Coach
	[10]={515,890000*exports.AURtax:getCurrentTax()},-- Roadtrain
	[11]={573,79000*exports.AURtax:getCurrentTax()},-- Dune
	[12]={524,70000*exports.AURtax:getCurrentTax()},-- Cement Truck
	[13]={578,60000*exports.AURtax:getCurrentTax()},-- DFT-30
	[14]={455,60000*exports.AURtax:getCurrentTax()},-- Flatbed
	[15]={508,45000*exports.AURtax:getCurrentTax()},-- journey
	[16]={423,40000*exports.AURtax:getCurrentTax()},-- Mr. Whoopee
	[17]={414,39000*exports.AURtax:getCurrentTax()},-- Mule
	[18]={456,36000*exports.AURtax:getCurrentTax()},-- Yankee
	[19]={588,35000*exports.AURtax:getCurrentTax()},-- Hotdog
	[20]={498,30000*exports.AURtax:getCurrentTax()},-- Boxville
	[21]={609,30000*exports.AURtax:getCurrentTax()},-- Black Boxville
	[22]={525,30000*exports.AURtax:getCurrentTax()},-- Towtruck
	[23]={422,24000*exports.AURtax:getCurrentTax()},-- Bobcat
	[24]={478,20000*exports.AURtax:getCurrentTax()},-- Walton
	[25]={531,20000*exports.AURtax:getCurrentTax()},-- Tractor
	[26]={530,14000*exports.AURtax:getCurrentTax()},-- Forklift
	[27]={499,15000*exports.AURtax:getCurrentTax()},-- Benson

},
["Plane & Helicopter"] = {
	[1]={476,20000000*exports.AURtax:getCurrentTax()},-- Rustler
	[2]={519,1500000*exports.AURtax:getCurrentTax()},-- Shamal
	[3]={487,1000000*exports.AURtax:getCurrentTax()},-- Maverick
	[4]={553,300000*exports.AURtax:getCurrentTax()},-- Nevada
	[5]={548,160000*exports.AURtax:getCurrentTax()},-- Cargobob
	[6]={417,140000*exports.AURtax:getCurrentTax()},-- Leviathan
	[7]={563,140000*exports.AURtax:getCurrentTax()},-- Raindance
	[8]={488,900000*exports.AURtax:getCurrentTax()},-- News Chopper
	[9]={512,90000*exports.AURtax:getCurrentTax()},-- Cropduster
	[10]={513,85000*exports.AURtax:getCurrentTax()},-- Stuntplane
	[11]={469,75000*exports.AURtax:getCurrentTax()},-- Sparrow
	[12]={511,60000*exports.AURtax:getCurrentTax()},-- Beagle
	[13]={593,40000*exports.AURtax:getCurrentTax()},-- Dodo
	--[13]={520,50000000*exports.AURtax:getCurrentTax()},-- Hydra
	--[14]={495,80000000*exports.AURtax:getCurrentTax()},-- SandKing

},
["Boat"] = {
	[1]={595,3000000*exports.AURtax:getCurrentTax()},-- Launch
	[2]={460,2000000*exports.AURtax:getCurrentTax()},-- Skimmer
	[3]={452,1100000*exports.AURtax:getCurrentTax()},-- Speeder
	[4]={446,1100000*exports.AURtax:getCurrentTax()},-- Squalo
	[5]={493,1200000*exports.AURtax:getCurrentTax()},-- Jetmax
	[6]={484,100000*exports.AURtax:getCurrentTax()},-- Marquis
	[7]={539,100000*exports.AURtax:getCurrentTax()},-- Vortex
	[8]={454,90000*exports.AURtax:getCurrentTax()},-- Tropic
	[9]={453,70000*exports.AURtax:getCurrentTax()},-- Reefer
	[10]={473,40000*exports.AURtax:getCurrentTax()},-- Dinghy
},
["Sports"] = {
	[1]={411,1600000*exports.AURtax:getCurrentTax()},-- Infernus
	[2]={451,1500000*exports.AURtax:getCurrentTax()},-- Turismo
	[3]={562,990000*exports.AURtax:getCurrentTax()},-- Elegy
	[4]={560,990000*exports.AURtax:getCurrentTax()},-- Sultan
	[5]={506,980000*exports.AURtax:getCurrentTax()},-- Super GT
	[6]={477,860000*exports.AURtax:getCurrentTax()},-- ZR-350
	[7]={415,850000*exports.AURtax:getCurrentTax()},-- cheetah
	[8]={494,730000*exports.AURtax:getCurrentTax()},-- Hotring Racer
	[9]={502,630000*exports.AURtax:getCurrentTax()},-- Hotring Racer 2
	[10]={503,530000*exports.AURtax:getCurrentTax()},-- Hotring Racer 3
	[11]={559,430000*exports.AURtax:getCurrentTax()},-- Jester
	[12]={541,420000*exports.AURtax:getCurrentTax()},-- Bullet
	[13]={480,320000*exports.AURtax:getCurrentTax()},-- Comet
	[14]={429,300000*exports.AURtax:getCurrentTax()},-- Banshee
	[15]={434,300000*exports.AURtax:getCurrentTax()},-- Hotknife
	[16]={561,280000*exports.AURtax:getCurrentTax()},-- Stratum
	[17]={565,280000*exports.AURtax:getCurrentTax()},-- Flash
	[18]={558,276000*exports.AURtax:getCurrentTax()},-- Uranus
	[19]={555,160000*exports.AURtax:getCurrentTax()},-- Windsor
	[20]={401,145000*exports.AURtax:getCurrentTax()},-- Bravura
	[21]={568,134000*exports.AURtax:getCurrentTax()},-- Bandito
	[22]={495,80000000*exports.AURtax:getCurrentTax()},-- SandKing
},
["Muscle"] = {
	[1]={603,120000*exports.AURtax:getCurrentTax()}, -- Phoenix
	[2]={402,95000*exports.AURtax:getCurrentTax()}, -- Buffalo
	[3]={475,90000*exports.AURtax:getCurrentTax()}, -- Sabre
	[4]={542,60000*exports.AURtax:getCurrentTax()}, -- Clover

},
["Luxury"] = {
	[1]={409,66000*exports.AURtax:getCurrentTax()},-- Stretch
	[2]={587,38000*exports.AURtax:getCurrentTax()},-- Euros
	[3]={540,36000*exports.AURtax:getCurrentTax()},-- Vincent
	[4]={405,35000*exports.AURtax:getCurrentTax()},-- Sentinel
	[5]={467,35000*exports.AURtax:getCurrentTax()},-- Oceanic
	[6]={426,35000*exports.AURtax:getCurrentTax()},-- Premier
	[7]={551,34090*exports.AURtax:getCurrentTax()},-- Merit
	[8]={421,32000*exports.AURtax:getCurrentTax()},-- Washington
	[9]={507,32000*exports.AURtax:getCurrentTax()},-- Elegant
	[10]={585,30000*exports.AURtax:getCurrentTax()},-- Emperor
	[11]={445,28000*exports.AURtax:getCurrentTax()},-- Admiral
	[12]={529,27900*exports.AURtax:getCurrentTax()},-- Willard
	[13]={550,27000*exports.AURtax:getCurrentTax()},-- Sunrise
	[14]={547,26000*exports.AURtax:getCurrentTax()},-- Primo
	[15]={466,26000*exports.AURtax:getCurrentTax()},-- Glendale
	[16]={492,26000*exports.AURtax:getCurrentTax()},-- Greenwood
	[17]={516,24900*exports.AURtax:getCurrentTax()},-- Nebula
	[18]={566,24000*exports.AURtax:getCurrentTax()},-- Tahoma
	[19]={546,23000*exports.AURtax:getCurrentTax()},-- Intruder
},
["Compact"] = {
	[1]={474,40000*exports.AURtax:getCurrentTax()},-- Hermes
	[2]={545,39000*exports.AURtax:getCurrentTax()},-- Hustler
	[3]={602,38900*exports.AURtax:getCurrentTax()},-- Alpha
	[4]={496,38000*exports.AURtax:getCurrentTax()},-- Blista Compact
	[5]={518,38000*exports.AURtax:getCurrentTax()},-- Buccaneer
	[6]={439,35000*exports.AURtax:getCurrentTax()},-- Stallion
	[7]={589,30000*exports.AURtax:getCurrentTax()},-- Club
	[8]={533,29000*exports.AURtax:getCurrentTax()},-- Feltzer
	[9]={527,29000*exports.AURtax:getCurrentTax()},-- Cadrona
	[10]={600,16800*exports.AURtax:getCurrentTax()},-- Picador
	[11]={580,15590*exports.AURtax:getCurrentTax()},-- Stafford
	[12]={500,15500*exports.AURtax:getCurrentTax()},-- Mesa
	[13]={419,14500*exports.AURtax:getCurrentTax()},-- Esperanto
	[14]={517,14490*exports.AURtax:getCurrentTax()},-- Majestic
	[15]={549,12390*exports.AURtax:getCurrentTax()},-- Tampa
	[16]={410,12200*exports.AURtax:getCurrentTax()},-- Manana
	[17]={436,12200*exports.AURtax:getCurrentTax()},-- Previon
	[18]={491,12200*exports.AURtax:getCurrentTax()},-- Virgo
},
["Lowriders"] = {
	[1]={536,31000*exports.AURtax:getCurrentTax()},-- Blade
	[2]={575,32000*exports.AURtax:getCurrentTax()},-- Broadway
	[3]={534,33000*exports.AURtax:getCurrentTax()},-- Remington
	[4]={567,34000*exports.AURtax:getCurrentTax()},-- Savanna
	[5]={535,41000*exports.AURtax:getCurrentTax()},-- Slamvan
	[6]={576,32000*exports.AURtax:getCurrentTax()},-- Tornado
	[7]={412,31000*exports.AURtax:getCurrentTax()}, -- Voodoo
},
}

function getVehiclesTable()
	return vehicleTable
end