local cars = {
-- [ID] = colsize --easier to change in case of vehicles getting stuck
-- NB when adding a new spawner check that the vehicle is listed here
[402] = 6,
[426] = 6,
[416] = 6,
[596] = 6,
[599] = 6,
[497] = 6,
[598] = 6,
[525] = 6,
[422] = 6,
[553] = 15,
[511] = 8,
[519] = 17, -- shamal
[487] = 8,
[403] = 7,
[515] = 7,
[468] = 3,
[574] = 7,
[485] = 6,
[453] = 11,
[597] = 6,
[448] = 6,
[433] = 8, -- Barracks
[427] = 6, -- Enforcer
[528] = 6, -- FBI Truck
[490] = 6, -- FBI Rancher
[523] = 6, -- HPV-1000
[432] = 10, -- Rhino
[601] = 6, -- S.W.A.T
[560] = 6, -- Sultan
[476] = 10, -- Rustler
[447] = 10, -- Sea Sparrow
[425] = 10, -- Hunter
[520] = 10, -- Hydra
[513] = 10, -- Stuntplane
[417] = 10, -- Leviathan
[548] = 10, -- cargobob
[500] = 6, -- Mesa
[470] = 6, -- Patriot
[471] = 6, -- quadbike
[541] = 6, -- bullet
[446] = 10, --Squalo
[430] = 10, --Predator
[595] = 10, --Launch
[493] = 10, --Jetmax
[593] = 10, --Vortex
[451] = 6, --Turismo
[415] = 6, --Cheetah
}
-- free spawners added only ---------------
local spawners = {
--{x,y,z,rot,vehicleID,col,job}

	--Las Payasadas
	{-241.3,2594.61,62.22,1,426,nil},--Premiere

	--AP
	{-2187.66,-2308.55,30.62,321,426,nil},--Premiere


    --LV Hosp
    {1626.224609375, 1850.3798828125, 10.651918411255, 180,405,nil},-- sentinel
    {1621.431640625, 1850.3525390625, 10.563329696655, 180,426,nil},--Premiere
    {1616.96, 1838.06, 10.563329696655, 0,586,nil},--sanchez
    {1612.96, 1838.06, 10.563329696655, 0,586,nil},--sanchez
    --LS Jefferson Hospital
    {2034.037109375, -1448.876953125, 16.98240852356, 90,402,nil},--Buffalo
    {2001.884765625, -1418.666015625, 16.735631942749, 180,426,nil},--Premiere

    --LS ALl Saints Hospital

    {1178.2216796875, -1338.2939453125, 13.502555618286, 270.02197265625,402,nil},--Buffalo
    {1178.2724609375, -1308.8740234375, 13.502555618286, 269.58242797852,426,nil},--Premier

    --SF Hospital

    {-2688.4111328125, 632.05078125, 14.249059677124, 180,402,nil},--Buffalo
    {-2682.1640625, 632.0751953125, 14.21791934967,180,426,nil},--Premier

   --LVPD FREE
    {2302.587890625, 2428.2958984375, 10.8203125, 181.80178833008, 426, nil},
    {2298.587890625, 2428.2958984375, 10.8203125, 181.80178833008, 426, nil},
    {2294.587890625, 2428.2958984375, 10.7203125, 181.80178833008, 586, nil},

    -- LSPD
    {1536.98,-1659.63,13.47, 356, 586, nil},

	--LS JAIL
	{899.08,-2360.48,13.24, 210,402,nil},--Buffalo
	{906.81,-2356.32,13.24, 210,426,nil},--Buffalo
   ----LV Hosp
   --{1626.224609375, 1850.3798828125, 10.651918411255, 180,402,nil},-- Buffalo
   --{1620.431640625, 1850.3525390625, 10.563329696655, 180,426,nil},--Premiere
   --{1590.8046875, 1819.12109375, 11.035227775574, 358.38223266602,416,nil, job = "Paramedic"},--Ambulance
   --{1616.03125, 1806.146484375, 31.170415878296, 116.327,563,nil,job = "Paramedic"},
   ----LS Jefferson Hospital
   --{2034.037109375, -1448.876953125, 16.98240852356, 90,402,nil},--Buffalo
   --{2001.884765625, -1418.666015625, 16.735631942749, 180,426,nil},--Premiere
   --{2001.2138671875, -1410.435546875, 17.143705368042,0,416,nil,job = "Paramedic"},--Ambulance
   ----LS ALl Saints Hospital
   --{1177.2607421875, -1338.755859375, 14.062466621399, 272.92306518555,416,nil,job = "Paramedic"},--Ambulance
   --{1174.2216796875, -1310.2939453125, 13.822687149048, 270.02197265625,402,nil},--Buffalo
   --{1174.2724609375, -1306.8740234375, 13.742555618286, 269.58242797852,426,nil},--Premier
   --
   ----SF Hospital
   --{-2622.564453125, 607.7490234375, 14.602592468262, 90,416,nil,job = "Paramedic"},--Ambulance
   --{-2688.4111328125, 632.05078125, 14.249059677124, 180,402,nil},--Buffalo
   --{-2682.1640625, 632.0751953125, 14.21791934967,180,426,nil},--Premier
   ----LSPD
   --{1584.1142578125, -1606.8544921875, 13.106273651123, 180,596,nil,job = "police"},--LSPD vehicle
   --{1569.4150390625, -1606.845703125, 13.575127601624, 180,599,nil,job = "police"},-- Ranger
   --{1566.3134765625, -1645.2138671875, 28.597248077393, 90,497,nil,job = "police",rank = 50000},-- Police Mav
   --{1600.76953125, -1687.8671875, 5.890625, 90, 426, nil, job = "police"},--Premier
   --{1558.8818359375, -1606.634765625, 12.953408241272, 180, 523, nil, job = "police"},---bike
   --{1601.427734375, -1700.216796875, 5.6122007369995, 90, 405, nil, job = "police", rank = 2000},--Sentinel
   --{1591.5654296875, -1710.201171875, 5.6121282577515, 0, 559, nil, job = "police", rank = 2000},--Jester
   --{1578.30859375, -1710.16796875, 5.6119875907898, 0, 579, nil, job = "police", rank = 10000},--Huntley
   --{1570.5224609375, -1710.1884765625, 5.6119346618652, 0, 475, nil, job = "police", rank = 10000},--Sabre
   --{1544.802734375, -1684.541015625, 6.0221581459045, 90, 427, nil, job = "police", rank = 20000},--Enforcer
   --{1528.7626953125, -1687.9189453125, 5.5155725479126, 270, 541, nil, job = "police", rank = 30000},--Bullet
   --{1544.63671875, -1667.9228515625, 5.8103356361389, 90, 402, nil, job = "police", rank = 50000},--Buffalo
   --{1545.611328125, -1676.1904296875, 6.0606665611267, 90, 490, nil, job = "police", rank = 50000},--FBI Rancher
   --{1530.6513671875, -1645.0546875, 5.9339065551758, 180, 528, nil, job = "police", rank = 70000},--FBI Truck
   --{1538.8193359375, -1645.244140625, 5.6625123023987, 180, 415, nil, job = "police", rank = 100000},--Cheetah
   --{1544.50390625, -1655.2373046875, 5.6860718727112, 90, 451, nil, job = "police", rank = 100000},--Turismo,
   ----LVPD
   --{2313.6943359375, 2451.703125, 10.996551513672, 134.90112304688,497,nil,job = "police", rank = 50000},-- Police Mav
   --{2297.6337890625, 2474.87109375, 2.8459534645081, 231.6859588623, 523, nil, job = "police"},--HPV1000
   --{2314.8671875, 2480.0966796875, 3.4639072418213, 90, 599, nil, job = "police"},--Police Ranger
   --{2314.5908203125, 2470.228515625, 3.0191025733948, 90, 598, nil, job = "police"},--Police LV
   --{2298.7177734375, 2460.5712890625, 3.0165264606476, 270, 426, nil, job = "police"},--Premier
   --{2298.4873046875, 2451.4189453125, 3.1484248638153, 270, 405, nil, job = "police", rank = 2000},--Sentinel
   --{2314.8203125, 2455.6201171875, 2.929792881012, 90, 559, nil, job = "police", rank = 2000},--Jester
   --{2290.1396484375, 2430.7568359375, 3.2044637203217, 0, 579, nil, job = "police", rank = 10000},--Huntley
   --{2263.7880859375, 2431.2216796875, 3.0759770870209, 0, 475, nil, job = "police", rank = 10000},--Sabre
   --{2253.873046875, 2456.4375, 3.4053118228912, 0, 427, nil, job = "police", rank = 20000},--Enforcer
   --{2240.322265625, 2447.08203125, 2.8983149528503, 270, 541, nil, job = "police", rank = 30000},--Bullet
   --{2239.998046875, 2470.953125, 3.1050598621368, 270, 402, nil, job = "police", rank = 50000},--Buffalo
   --{2289.673828125, 2487.6044921875, 3.4021542072296, 270, 490, nil, job = "police", rank = 50000},--FBI Rancher
   --{2268.5244140625, 2487.5947265625, 3.3143224716187, 270, 528, nil, job = "police", rank = 70000},--FBI Truck
   --{2281.169921875, 2474.70703125, 3.0448219776154, 0, 415, nil, job = "police", rank = 100000},--Cheetah
   --{2268.3955078125, 2474.6796875, 2.9803867340088, 0, 451, nil, job = "police", rank = 100000},--Turismo
   ----- Mechanic LV
   --{1958.7783203125, 2145.171875, 10.8203125, 0,525,nil,job = "Mechanic"}, --towtruck
   --{1950.3974609375, 2145.1494140625, 10.8203125, 0,422,nil,job = "Mechanic"} ,-- bobcut
   --{2383.1005859375, 1030.2451171875, 10.8203125, 270,422,nil,job = "Mechanic"},
   ----- Pilot LV
   --{1526.95703125, 1828.36328125, 12.8203125, 90,553,nil, job = "Pilot"},
   --{1433.654296875, 1645.119140625, 11.812978744507, 270,511,nil, job = "Pilot"},
   --{1281.658203125, 1361.41796875, 11.8203125, 270,519,nil,job = "Pilot"},
   --{1285.9677734375, 1399.58984375, 11.8203125, 270,487,nil,job = "Pilot" },
   ----- Trucker LV
   --{1446.80859375, 975.34375, 11.967693901062, 0.75189208984,403,nil,job = "Trucker"},
   --{1434.0791015625, 975.343753125, 11.912976837158, 0,515,nil,job = "Trucker"},
   ---- crim LV
   --{1820.537109375, 810.0224609375, 10.8203125, 270,468,nil,job = "criminal"},
   ----montogery ls
   {1238.8818359375, 339.736328125, 19.5546875, 270,402,nil},--buff
   ---- mechanic dillimore
   --{697.892578125, -467.5302734375, 16.34375, 270,422,nil,job = "Mechanic"},
   --{705.4462890625, -454.521484375, 16.34375, 90,525,nil, job = "Mechanic"},
   ----- police dillimore
   --{624.1474609375, -609.490234375, 16.981948852539, 270,599,nil,job = "police"},
   --{619.126953125, -596.9833984375, 17.233013153076, 270,596,nil,job = "police"},
   ---- mechanic ls
   --{1049.111328125, -1031.337890625, 32.061866760254, 180,422,nil,job = "Mechanic"},
   --{1037.373046875, -1031.2958984375, 32.039161682129, 180.80,525,nil,job = "Mechanic"},
   --{2061.9716796875, -1879.9296875, 13.546875, 0,422,nil,job = "Mechanic"},
   ----ls crim
   --{1298.6591796875, -1064.1708984375, 29.275272369385, 270,468,nil,job="criminal"},
   ----- trucker ls
   --{2204.6572265625, -2236.501953125, 14.546875, 220.6,515,nil,job = "trucker"},
   --{2208.900390625, -2223.9365234375, 14.546875, 220,403,nil,job = "trucker"},
   ----- cleaner ls
   --{1621.69140625, -1891.1923828125, 13.549010276794, 360,574,nil,job = "Street Cleaner"},
   -----ls trucker
   --{-73.9248046875, -1115.8359375, 2.078125, 159.2,403,nil,job="trucker"},
   --{1705.958984375, 1619.51171875, 9.8048543930054, 71.428558349609, 485,nil,job = "Pilot"},
   --{1974.669921875, -2233.1376953125, 13.087753295898, 180, 485,nil,job = "Pilot"},
   --{1991.220703125, -2388.6630859375, 14.446349143982, 204.51635742188, 487,nil,job = "Pilot"},
   --{2001.7880859375, -2494.9248046875, 14.460969924927, 86.901092529297, 519,nil,job = "Pilot"},
   --{728.4013671875, -1497.625, -0.34746506810188, 180, 453,nil,job = "Fisherman"},
   --{738.646484375, -1495.9296875, -0.35091948509216, 180, 453,nil,job = "Fisherman"},
   --{-1739.7763671875, 154.5322265625, 4.5382804870605, 179.91760253906, 515,nil,job = "trucker"},
   --{-1917.1748046875, 284.6025390625, 40.928638458252, 181.84616088867, 525,nil,job = "Mechanic"},
   --{-1400.3017578125, 2650.287109375, 55.876068115234, 93.230773925781, 599,nil,job = "police"},
   {-1503.83984375, 2525.4638671875, 55.519214630127, 1.4505615234375, 402, nil},
   {-306.3564453125, 1071.6171875, 19.569778442383, 269.31869506836, 426, nil},
   --{-323.9873046875, 1069.0009765625, 19.890743255615, 4.6153869628906, 416,nil,job = "Paramedic"},
   --{1961.302734375, 2200.0078125, 10.536145210266, 269.84616088867, 468,nil,job = "criminal"},
   ----{1961.302734375, 2200.0078125, 10.536145210266, 269.84616088867, 510, nil},
   --{-84.3798828125, 1128.09765625, 19.619455337524, 181.75823974609, 525,nil,job = "Mechanic"},
   --{-224.4296875, 996.2900390625, 19.727449417114, 271.54498291016, 599,nil,job = "police"},
   --{-2170.4501953125, -2360.13671875, 30.817443847656, 50.417572021484, 599,nil,job = "police"},
   --{68.8798828125, 30.394155502319, 53.582427978516, 597,nil,job = "police"},
   --{-2186.10546875, -2307.4326171875, 30.774681091309, 140.61538696289, 416,nil,job = "Paramedic"},
   --{2096.53515625, -1797.474609375, 12.99011516571, 22.558013916016, 448,nil,job = "Pizza Delivery"},
   --{381.3525390625, -1730.482421875, 8.0763454437256, 0.00274658203125, 468,nil,job = "criminal"},
   --{824, 830, 12, 0, 486, nil, job = "Quarry Miner"},
  ---- SFPD
   --{-1680.353515625, 705.5751953125, 30.794700622559, 90,497,nil,job = "police"},-- Police Mav
   --{-1599.29296875, 651.572265625, 7.18,0 ,597,nil,job = "police"},
   --{-1610.7734375, 651.5722046875, 7.18,0,599,nil,job = "police"},
   ------------LSPD
   --{-1605.2451171875, 651.2236328125, 6.7545185089111, 0, 523, nil, job = "police" , rank = 50000},--HPV1000
   --{-1588.1943359375, 673.9619140625, 6.9303555488586, 180, 426, nil, job = "police"},--Premier
   --{-1628.5302734375, 651.61328125, 7.0624933242798, 0, 405, nil, job = "police", rank = 2000},--Sentinel
   --{-1605.98046875, 674.201171875, 6.8438625335693, 180, 559, nil, job = "police", rank = 2000},--Jester
   --{-1600.220703125, 749.458984375, -5.3102931976318, 180, 579, nil, job = "police", rank = 10000},--Huntley
   --{-1584.0419921875, 748.8310546875, -5.4376320838928, 180, 475, nil, job = "police", rank = 10000},--Sabre
   --{-1600.2880859375, 676.837890625, -5.110342502594, 0, 427, nil, job = "police", rank = 20000},--Enforcer
   --{-1572.990234375, 726.4375, -5.6172246932983, 90, 541, nil, job = "police", rank = 30000},--Bullet
   --{-1573.38671875, 705.9853515625, -5.4105429649353, 90, 402, nil, job = "police", rank = 50000},--Buffalo
   --{-1639.2880859375, 686.4443359375, -5.1142587661743, 270, 490, nil, job = "police", rank = 50000},--FBI Rancher
   --{-1623.203125, 653.857421875, -5.1993560791016, 90, 528, nil, job = "police", rank = 70000},--FBI Truck
   --{-1620.4912109375, 693.234375, -5.4713754653931, 180, 415, nil, job = "police", rank = 100000},--Cheetah
   --{-1639.6552734375, 665.88671875, -5.5356459617615, 270, 451, nil, job = "police", rank = 100000},--Turismo
   --
   --------mf
   --{273.1533203125, 2036.064453125, 18.363571166992, 268.70330810547, 520,nil,job = "police", group = 42}, --hydra
   --{276.396484375, 1977.9169921875, 18.345245361328, 270.63735961914, 476,nil,job = "police" ,group = 42}, --rustler
   --{351.03125, 1932.9775390625, 20.769550323486, 89.802185058594,425,nil,job = "police",group = 42}, --hunter
   --{ 229.3125, 1877.6220703125, 17.649295806885, 0.30767822265625,432,nil,job = "police", group = 42}, --rhino
   --{174.7158203125, 1936.4013671875, 18.193231582642, 178.41760253906,470,nil,job = "police",group = 42}, --patriot
   --{167.8984375, 1938.15234375, 18.563920974731, 182.19779968262,500,nil,job = "police",group = 42}, --mesa
   --{ 192.2109375, 1903.861328125, 17.120859146118, 32.219787597656,471,nil,job = "police",group = 42}, --quadbike
   --{182.3955078125, 1936.6376953125, 17.524379730225, 177.36260986328,541,nil,job = "police",group = 42}, --bullet
   --{197.8125, 1878.3984375, 18.081888198853, 0.21978759765625,433,nil,job = "police",group = 42}, --barracks
   --{336.0791015625, 1984.7587890625, 18.560224533081, 128.30770874023,519,nil,job = "police",group = 42}, --shamal
   --{162.37109375, 1937.7919921875, 18.40456199646, 179.38464355469, 411, nil, job = "police", group = 42},---infernus
   --{350.681640625, 1900.0908203125, 20.37477684021, 89.362670898438, 497, nil, job = "police", group = 42},---police maverick
   --{156.373046875, 1938.0517578125, 18.616102218628, 179.82415771484, 560, nil, job = "police", group = 42},--sultan
   --
   --
   -- --------------ca
   --{991.927734375, 1441.224609375, -14.672918319702, 90.593383789062, 522 , nil, job = "criminal", group = 5973},
   --{991.6689453125, 1435.5556640625, -14.672919273376, 89.010986328125, 411 , nil, job = "criminal", group = 5973},
   --{991.533203125, 1430.0849609375, -14.672919273376, 89.714294433594, 560 , nil, job = "criminal", group = 5973},
   --{978.0927734375, 1409.0498046875, -14.672918319702, 145.01098632812, 451 , nil, job = "criminal", group = 5973},
   --{982.3857421875, 1406.1640625, -14.672918319702, 144.39562988281, 541 , nil, job = "criminal", group = 5973},
   --{986.21875, 1403.5068359375, -14.672919273376+0.5, 143.07693481445, 482 , nil, job = "criminal", group = 5973},
   --{991.5849609375, 1398.607421875, -14.672918319702+0.2, 90.505493164062, 579 , nil, job = "criminal", group = 5973},
   --{991.4755859375, 1393.712890625, -14.672919273376+0.7, 89.274749755859, 495 , nil, job = "criminal", group = 5973},
   --{977.64453125, 1373.6943359375, 1.1220514774323, 359.51647949219, 519 , nil, job = "criminal", group = 5973},
   --{943.611328125, 1308.5224609375, 14.244524002075, 269.40661621094, 487 , nil, job = "criminal", group = 5973},
   --{991.6611328125, 1336.7294921875, 10.433987617493, 88.395599365234, 522 , nil, job = "criminal", group = 5973},
   --{991.7998046875, 1341.6552734375, 10.429179191589, 88.455017089844, 522 , nil, job = "criminal", group = 5973},
   --{990.841796875, 1360.9169921875, 10.595690727234, 89.626373291016, 411 , nil, job = "criminal", group = 5973},
   --
   --
   ------------------swat
   --
   --{-369.40234375, 1524.9638671875, 75.305564880371, 353.18682861328, 426, nil, job = "police", group = 5875},---Premier
   --{-374.5712890625, 1525.7099609375, 75.362983703613, 352.48352050781, 551, nil, job = "police", group = 5875},---Merit
   --{-338.716796875, 1515.4697265625, 75.796829223633, 0.07965087890625, 433, nil, job = "police", group = 5875},---Barracks
   --{-343.025390625, 1515.4541015625, 75.486389160156, 0.77182006835938, 427, nil, job = "police", group = 5875},---Enforcer
   --{-334.4169921875, 1515.3046875, 75.488952636719, 359.82147216797, 490, nil, job = "police", group = 5875},---FBI Rancher
   --{-330.537109375, 1515.7392578125, 75.404006958008, 359.64019775391, 528, nil, job = "police", group = 5875},---FBI Truck
   --{-326.6416015625, 1516.0712890625, 75.352783203125, 0.12359619140625, 470, nil, job = "police", group = 5875},---Patriot
   --{-322.9111328125, 1516.26171875, 75.079391479492, 359.84893798828, 596, nil, job = "police", group = 5875},---Police LS
   --{-318.3779296875, 1516.001953125, 75.556747436523, 358.81619262695, 599, nil, job = "police", group = 5875},---Police Ranger
   --{-313.8349609375, 1515.7734375, 75.11644744873, 1.0299987792969, 601, nil, job = "police", group = 5875},---S.W.A.T.
   --{-299.0791015625, 1538.875, 75.686058044434, 176.21978759766, 428, nil, job = "police", group = 5875},---Securicar
   --{-293.34375, 1538.447265625, 75.494819641113, 177.53845214844, 579, nil, job = "police", group = 5875},---Huntley
   --{-350.265625, 1522.470703125, 75.184944152832, 354.94506835938, 541, nil, job = "police", group = 5875},---Bullet
   --{-354.8017578125, 1522.7529296875, 75.332008361816, 352.39559936523, 415, nil, job = "police", group = 5875},---Cheetah
   --{-359.716796875, 1523.490234375, 75.288375854492, 352.83514404297, 411, nil, job = "police", group = 5875},---Infernus
   --{-364.39453125, 1524.2255859375, 75.26749420166, 353.62637329102, 560, nil, job = "police", group = 5875},---Sultan
   --{-302.677734375, 1539.1357421875, 75.133079528809, 179.38464355469, 522, nil, job = "police", group = 5875},---NRG-500
   --{-304.60546875, 1539.25, 75.22917175293, 180.70314025879, 468, nil, job = "police", group = 5875},---Sanchez
   --{-306.662109375, 1539.181640625, 75.13264465332, 177.18682861328, 523, nil, job = "police", group = 5875},---HPV1000
   --{-271.51953125, 1521.9853515625, 75.667892456055, 44.791229248047, 431, nil, job = "police", group = 5875},---Bus
   --{-284.3291015625, 1511.857421875, 75.711303710938, 45.846160888672, 416, nil, job = "police", group = 5875},---Ambulance
   --{-302.2724609375, 1757.390625, 42.414581298828, 269.23077392578, 411, nil, job = "police", group = 5875},---Infernus
   --{-302.001953125, 1762.2529296875, 42.815299987793, 270.02197265625, 490, nil, job = "police", group = 5875},---FBI Rancher
   --{-301.828125, 1767.7724609375, 42.256034851074, 270.02197265625, 522, nil, job = "police", group = 5875},---NRG-500
   --{-400.3720703125, 1518.3974609375, 80.818672180176, 120.92306518555, 497, nil, job = "police", group = 5875},---Police Maverick
   --{-334.09765625, 1857.2236328125, 45.747406005859, 90.417602539062, 417, nil, job = "police", group = 5875},---Leviathan
   --{-290.025390625, 1766.00390625, 44.357429504395, 177.62634277344, 548, nil, job = "police", group = 5875},---Cargobob
   --{-301.4365234375, 1607.6787109375, 75.460823059082, 305.80221557617, 447, nil, job = "police", group = 5875},---Seasparrow
   --{-255.19140625, 1556.9091796875, 76.210304260254, 312.13186645508, 563, nil, job = "police", group = 5875},---Raindance
   --{-358.9677734375, 1716.3447265625, 46.315212249756, 257.89010620117, 520, nil, job = "police", group = 5875},---Hydra
   --{-363.482421875, 1704.333984375, 46.305511474609, 257.97802734375, 476, nil, job = "police", group = 5875},---Rustler
   --{-243.10546875, 1480.693359375, 76.615547180176, 316.61706542969, 519, nil, job = "police", group = 5875},---Shamal
   --{-432.8037109375, 1212.79296875, -0.26889577507973, 97.274719238281, 430, nil, job = "police", group = 5875},---Predator
   --{-435.9765625, 1220.017578125, -0.26095709204674, 93.846160888672, 446, nil, job = "police", group = 5875},---Squalo
   --
   --
   --
   ---------------ravage
   --
   --{2810.109375, 1237.919921875, 36.619026184082, 88.923095703125, 487, nil, job = "criminal", group = 6020},---maverick
   --{2847.224609375, 1196.310546875, -2.7811608314514, 359.60440063477, 519, nil, job = "criminal", group = 6020},---shamal
   --{2812.9697265625, 1276.9990234375, 10.595831871033, 89.97802734375, 411, nil, job = "criminal", group = 6020},---infernus
   --{2813.0498046875, 1282.9013671875, 10.43260383606, 271.72076416016+180, 522, nil, job = "criminal", group = 6020},---NRG-500
   --{2813.2431640625, 1288.5224609375, 10.574150085449, 92.175811767578, 560, nil, job = "criminal", group = 6020},---Sultan
   --{2813.2412109375, 1295.5849609375, 11.309928512573, 90.065948486328, 495, nil, job = "criminal", group = 6020},---Sandking
   --{2813.03125, 1302.423828125, 10.903508758545, 89.626373291016, 579, nil, job = "criminal", group = 6020},---Huntley
   --{2789.7724609375, 1157.0341796875, 0.6625047326088, 359.51647949219, 409, nil, job = "criminal", group = 6020},---Stretch
   --{2797.7255859375, 1158.6748046875, 0.99583077430725, 359.07693481445, 437, nil, job = "criminal", group = 6020},---Coach
   --{2810.0029296875, 1157.484375, 0.93876975774765, 359.69232177734, 413, nil, job = "criminal", group = 6020},---Pony
   --{2814.65234375, 1157.7373046875, 0.62953466176987, 0.13186645507812, 434, nil, job = "criminal", group = 6020},---hotknife
   --{2822.201171875, 1157.21875, 0.64343899488449, 359.69232177734, 424, nil, job = "criminal", group = 6020},---BF injection
   --{2828.294921875, 1235.662109375, 12.394150733948, 0.043975830078125, 406, nil, job = "criminal", group = 6020},---Dumper
   --{2772.994140625, 1123.7607421875, 1.2338058948517, 359.51647949219, 444, nil, job = "criminal", group = 6020},---monster
   --{2818.9111328125, 1271.9267578125, 10.152284622192, 180.26373291016, 441, nil, job = "criminal", group = 6020},---RC-Bandit
   --
   --
   --
   --
   --
   --
   --
   --
   --
   --
   -----------------7th
   --{1859.8798828125, 491.46875, 36.905891418457, 269.81460571289, 519, nil, job = "criminal", group = 6034},---shamal
   --{1865.267578125, 566.5078125, 29.382326126099, 1.0110168457031, 487, nil, job = "criminal", group = 6034},---maverick
   --{1899.509765625, 556.25390625, 20.920085906982, 1.8869323730469, 411, nil, job = "criminal", group = 6034},---infernus
   --{1905.96484375, 555.8603515625, 20.76375579834, 359.42855834961, 522, nil, job = "criminal", group = 6034},---NRG-500
   --{1939.248046875, 569.232421875, 20.897262573242, 89.890106201172, 560, nil, job = "criminal", group = 6034},---sultan
   --{1938.833984375, 562.72265625, 21.124622344971, 89.274749755859, 579, nil, job = "criminal", group = 6034},---Huntley
   --{1901.41796875, 519.771484375, 20.816905975342, 359.60440063477, 541, nil, job = "criminal", group = 6034},--bullet
   --{1908.1669921875, 520.0458984375, 21.314981460571, 0.923095703125, 482, nil, job = "criminal", group = 6034},--burrito
   --{1886.2314453125, 536.6220703125, 20.963214874268, 270, 415, nil, job = "criminal", group = 6034},--Cheetah
   --{1886.41015625, 526.4375, 20.898342132568, 270, 451, nil, job = "criminal", group = 6034},--Turismo
   --
   --
   --
   -----------------NSA
   --{-91.7822265625, 268.4970703125, 18.806133270264, 328.69671630859, 519, nil, job = "police", group = 5985},---shamal
   ----{-77.0078125, 254.26953125, 18.607568740845, 329.71429443359, 520, nil, job = "police", group = 5985},---hydra
   --{41.5, 335.7373046875, 13.404557228088, 147.56045532227, 487, nil, job = "police", group = 5985},---maverick
   --{123.630859375, 284.2255859375, 14.915387153625, 148.36437988281, 548, nil, job = "police", group = 5985},---cargobob
   --{153.6416015625, 250.5771484375, 5.4207639694214, 148.35168457031, 417, nil, job = "police", group = 5985},---leviathan
   --{83, 162.5859375, 5.1828179359436, 58.065948486328, 409, nil, job = "police", group = 5985},---stretch
   --{1.1240234375, 190.4990234375, 5.5095820426941, 325.93405151367, 490, nil, job = "police", group = 5985},--fbi rancher
   --{-3.376953125, 193.4365234375, 5.3155369758606, 325.934051513677, 579, nil, job = "police", group = 5985},---huntley
   --{-7.1240234375, 195.767578125, 5.0880260467529, 325.93405151367, 560, nil, job = "police", group = 5985},---sultan
   --{-10.8125, 199.337890625, 5.214527130127, 325.93405151367, 402, nil, job = "police", group = 5985},---buffalo
   --{-14.359375, 203.544921875, 5.5148520469666, 325.93405151367, 427, nil, job = "police", group = 5985},---enforcer
   --{-18.5556640625, 208.083984375, 6.4007668495178, 325.93405151367, 515, nil, job = "police", group = 5985},---roadtrain
   --{-23.9814453125, 210.52734375, 5.183262348175, 325.93405151367, 551, nil, job = "police", group = 5985},---merit
   --{-27.6953125, 212.93359375, 5.5748562812805, 325.93405151367, 599, nil, job = "police", group = 5985},---police ranger
   --{-31.365234375, 215.5908203125, 5.4274778366089, 325.93405151367, 528, nil, job = "police", group = 5985},---FBI truck
   --{-35.1328125, 217.7119140625, 5.0078654289246, 325.93405151367, 541, nil, job = "police", group = 5985},---Bullet
   --{-38.287109375, 220.7802734375, 5.1098942756653, 325.93405151367, 411, nil, job = "police", group = 5985},---infernus
   --{-40.984375, 223.3232421875, 5.0902886390686, 325.93405151367, 451, nil, job = "police", group = 5985},---turismo
   --{-43.1201171875, 228.2236328125, 5.516134262085, 325.93405151367, 437, nil, job = "police", group = 5985},---Coach
   --{-48.6748046875, 228.8984375, 5.37482213974, 325.93405151367, 470, nil, job = "police", group = 5985},---patriot
   --{-51.9482421875, 233.7265625, 5.8195614814758, 325.93405151367, 433, nil, job = "police", group = 5985},---barracks
   --{-57.498046875, 235.5068359375, 5.1539268493652, 325.93405151367, 415, nil, job = "police", group = 5985},---cheetah
   --{-61.572265625, 238.431640625, 5.7314209938049, 325.93405151367, 495, nil, job = "police", gorup = 5985},---sandking
   --{-55.07421875, 261.0146484375, 4.9618167877197, 237.58241271973, 522, nil, job = "police", group = 5985},--nrg500
   --{-58.1298828125, 256.103515625, 4.9620232582092, 237.58241271973, 523, nil, job = "police", group = 5985},--HPV1000
   --{-62.4189453125, 250.212890625, 4.9465179443359, 237.58241271973, 471, nil, job = "police", group = 5985},--Quadbike
   --{-60.322265625, 253.23828125, 5.0557699203491, 237.58241271973, 468, nil, job = "police", group = 5985},--sanchez
   --{112.7919921875, 373.9501953125, -0.56254589557648, 327.9560546875, 446, nil, job = "police", group = 5985},--Squalo
   --{120.6884765625, 368.9755859375, -0.25632193684578, 327.9560546875, 430, nil, job = "police", group = 5985},--Predator
   --{119.78515625, 357.76953125, 0.40385320782661, 236.08792114258, 539, nil, job = "police", group = 5985},--Vortex
   --{97.2216796875, 363.0830078125, -0.14493314921856, 60, 493, nil, job = "police", group = 5985},--Jetmax
   --
   --
   --------------------DOD
	--{224.5439453125, 1401.9638671875, 35.624092102051, -135, 487, nil, job = "SWAT Team", group = 5875},---maverick
   --{242.2744140625, 1384.1005859375, 36.000431060791, 224.3579864502, 425,nil,job = "Military Forces", group = 42}, --hunter
   --{241.27734375, 1438.6025390625, 35.96639251709, 313.53845214844, 425,nil,job = "SWAT Team", group = 5875}, --hunter
	--{224.3876953125, 1422.490234375, 35.590217590332, 314.37582397461, 497,nil,job = "Military Forces", group = 42}, -- police maverick
   --{124.5859375, 1371.4638671875, 11.317852020264, 321.62637329102, 520,nil,job = "Military Forces", group = 42}, -- hydra
   --{169.158203125, 1371.4638671875, 11.317852020264, 41, 520,nil,job = "SWAT Team", group = 5875}, -- hydra

}

local vehicles = {}

local spawnedVehs = {}

local canDJV = {}
local floodTimer = {}
local floodTimer2 = {}

local function replaceVehicle(theColShape)
    if(theColShape == spawnedVehs[source].spawner[6])then
		for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
			if isElementWithinColShape(v,theColShape) then
				return false
			end
		end
        placeVehicle(spawnedVehs[source].spawner)
        removeEventHandler("onElementColShapeLeave", source,replaceVehicle)
    end
end

function placeVehicle(spawner)
    local carId = spawner[5]
    if (not isElement(spawner[6])) then
        spawner[6] = createColSphere(spawner[1], spawner[2], spawner[3], cars[carId] or 6)
    end

    local vehicle = createVehicle(carId, spawner[1], spawner[2], spawner[3], 0, 0, spawner[4])
	setElementAlpha(vehicle,0)
	if isTimer(floodTimer[vehicle]) then killTimer(floodTimer[vehicle]) end
	if isTimer(floodTimer2[vehicle]) then killTimer(floodTimer2[vehicle]) end
	floodTimer[vehicle] = setTimer(function(veh)
		if getElementAlpha(veh) > 250 then setElementAlpha(veh,255) return end
		setElementAlpha(veh,getElementAlpha(veh)+50)
	end,1000,5,vehicle)
	floodTimer2[vehicle] = setTimer(function(veh)
		if (isElement(veh)) then
			setVehicleColor(veh,math.random(0,255),math.random(0,255),math.random(0,255))
		end
	end,3000,0,vehicle)
	setElementDimension(vehicle,9000)
    spawnedVehs[vehicle] = {}
    spawnedVehs[vehicle].spawner = spawner
    setVehicleColor(vehicle, 1, 1, 1, 1)
    setElementFrozen(vehicle, true)
    --setElementCollisionsEnabled(vehicle,false)
    setVehicleDamageProof(vehicle, true)
    addEventHandler("onElementColShapeLeave", vehicle, replaceVehicle)

    addEventHandler("onElementColShapeHit", vehicle,
        function (col)
            if (col == spawnedVehs[source].spawner[6]) then
                canDJV[source] = false
            end
        end
    )
    addEventHandler("onElementColShapeLeave", vehicle,
        function (col)
            if (col == spawnedVehs[source].spawner[6]) then
                canDJV[source] = true
            end
        end
    )
    addEventHandler("onVehicleExplode", vehicle,
        function ()
            source:destroy()
        end
    )
    addEventHandler("onVehicleStartEnter", vehicle,
        function (enteringPlayer, seat)
			if ( getElementData( enteringPlayer, "wantedPoints" ) >= 20 )  then
                exports.NGCdxmsg:createNewDxMessage(enteringPlayer, "You cannot take free a vehicle if you are wanted!", 255, 255, 255)
                cancelEvent()
            end
        end
    )
    addEventHandler("onVehicleEnter", vehicle,
        function (player, seat)
            if(seat == 0)then
                if (isElement(vehicles[player]) and vehicles[player] ~= source) then
                    destroyElement(vehicles[player])
                end
                vehicles[player] = source
                local r, g, b = player.team:getColor()
                if (isElement(source)) then
					if isTimer(floodTimer2[source]) then killTimer(floodTimer2[source]) end
                    setVehicleColor(source, r, g, b)
                    setElementFrozen(source, false)
                    --setElementCollisionsEnabled(vehicle, true)
                    setVehicleDamageProof(source, false)
                end
            end
        end
    )
    addEventHandler("onElementDestroy", vehicle,
        function ()
            if (isElementWithinColShape(source, spawnedVehs[source].spawner[6])) then
                placeVehicle(spawner)
            end
        end
    )
    if (spawner.job) then
        addEventHandler("onVehicleStartEnter", vehicle,
            function (enteringPlayer, seat)
                --if ( spawner.rank ~= nil ) then
                    --if ( spawner.rank > exports.USGcnr_jobranks:getPlayerJobExp(enteringPlayer,spawner.job) and seat == 0 and exports.USGcnr_jobs:getPlayerJobType(enteringPlayer) ~= "staff") or (spawner.job ~= exports.USGcnr_jobs:getPlayerJobType(enteringPlayer)) then
                        --exports.NGCdxmsg:createNewDxMessage(enteringPlayer, "You need to be a "..spawner.job.." with a "..spawner.rank.." exp to use this vehicle", 255, 255, 255)
                        --cancelEvent()
                    --end
                if ( spawner.group ~= nil ) then
                    if( spawner.group ~= getElementData(enteringPlayer, "Group") and seat == 0) then
                        exports.NGCdxmsg:createNewDxMessage(enteringPlayer, "You need to be in that group "..spawner.group.." to use this vehicle", 255, 255, 255)
                        cancelEvent()
                    end
                --elseif spawner.job == "Government" or spawner.job == "Criminals" then
                   -- if (spawner.job ~= getElementData(enteringPlayer, "Occupation") and seat == 0) then
                            --exports.NGCdxmsg:createNewDxMessage(enteringPlayer, "You need to be a "..spawner.job.." to use this vehicle", 255, 255, 255)
                            --cancelEvent()
                    --end
               -- elseif spawner.job == "civil" then
				--elseif (spawner.job ~= "Government" and spawner.job ~= "Criminals") then
                   -- if (spawner.job ~= exports.USGcnr_jobs:getPlayerJob(enteringPlayer) and seat == 0 and exports.USGcnr_jobs:getPlayerJobType(enteringPlayer) ~= "staff") then
				   if (spawner.job ~= getElementData(enteringPlayer, "Occupation") and seat == 0) then
                            exports.NGCdxmsg:createNewDxMessage(enteringPlayer, "You need to be a "..spawner.job.." to use this vehicle", 255, 255, 255)
                            cancelEvent()
                    end
                end


            end
        )
    end
    addEventHandler("onVehicleStartExit", vehicle,
        function (exitingPlayer, seat)
            if (isElementWithinColShape(source, spawner[6]) and seat == 0) then
                cancelEvent()
                exports.NGCdxmsg:createNewDxMessage(exitingPlayer, "You need to leave the area to get out of the vehicle", 255, 255, 255)
            end
        end
    )
	setElementDimension(vehicle,0)
    return vehicle
end

for _, v in ipairs(spawners) do
    placeVehicle(v)
end

function destroyVehicle()
    if (isElement(vehicles[source]))then
        destroyElement(vehicles[source])
        removeEventHandler("onPlayerWasted", source, destroyVehicle)
    end
end
addEventHandler("onPlayerWasted",root, destroyVehicle)
addEventHandler("onPlayerQuit", root, destroyVehicle)

function onChangeJob(ID)
    if (isElement(vehicles[source]))then
        destroyElement(vehicles[source])
        removeEventHandler("onPlayerWasted", source, destroyVehicle)
    end
end
addEvent("onPlayerQuitJob", true)
addEventHandler("onPlayerQuitJob", root, onChangeJob)

addCommandHandler("djv",
    function (player)
        if (isElement(vehicles[player]) and canDJV[vehicles[player]])then
            destroyElement(vehicles[player])
            removeEventHandler("onPlayerWasted", player, destroyVehicle)
            exports.NGCdxmsg:createNewDxMessage(player, "Ty for keeping the server clean! :)", 255, 255, 255)
        end
    end
)
