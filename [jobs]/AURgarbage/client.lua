local wasteMarkersForPlayer = {}
local wasteTablesForPlayer = {
--[[{1296.353515625, -1856.5751953125, 13.3828125,},
{1371.7177734375, -1874.908203125, 13.3828125,},
{1410.5888671875, -1868.1650390625, 13.3828125,},
{1442.751953125, -1876.1728515625, 13.390607833862,},
{1516.7197265625, -1876.662109375, 13.46245765686,},
{1565.091796875, -1876.416015625, 13.3828125,},
{1580.693359375, -1868.05859375, 13.3828125,},
{1614.6982421875, -1879.205078125, 13.3828125,},
{1675.390625, -1871.421875, 13.390607833862,},
{1724.7177734375, -1818.5458984375, 13.360167503357,},
{1795.8017578125, -1836.2841796875, 13.390607833862,},
{1825.896484375, -1798.671875, 13.3828125,},
{1817.2294921875, -1781.9677734375, 13.3828125,},
{1834.5791015625, -1756.8359375, 13.3828125,},
{1839.216796875, -1748.4951171875, 13.3828125,},
{1864.9267578125, -1756.3818359375, 13.3828125,},
{1884.4130859375, -1747.33203125, 13.3828125,},
{1900.5546875, -1756.2109375, 13.3828125,},
{1925.0869140625, -1756.224609375, 13.3828125,},
{1953.123046875, -1747.275390625, 13.546875,},
{1956.8583984375, -1769.4345703125, 13.3828125,},
{1957.1328125, -1836.8017578125, 13.3828125,},
{1965.763671875, -1856.6123046875, 13.3828125,},
{1957.5791015625, -1870.490234375, 13.3828125,},
{1965.55859375, -1882.1962890625, 13.3828125,},
{1956.9990234375, -1898.3154296875, 13.3828125,},
{1966.0478515625, -1914.6162109375, 13.3828125,},
{1949.2763671875, -1927.92578125, 13.3828125,},
{1925.2763671875, -1937.1953125, 13.3828125,},
{1893.7578125, -1927.9541015625, 13.386819839478,},
{1873.34765625, -1927.4765625, 13.387518882751,},
{1861.119140625, -1936.6103515625, 13.3828125,},
{1836.029296875, -1927.8828125, 13.386923789978,},
{1816.6201171875, -1929.71484375, 13.543491363525,},
{1827.5390625, -2027.3583984375, 13.3828125,},
{1806.37109375, -2109.0126953125, 13.3828125,},
{1772.326171875, -2108.90625, 13.3828125,},
{1744.9296875, -2109.2216796875, 13.3828125,},
{1684.9423828125, -2109.173828125, 13.3828125,},
{1702.8037109375, -2117.162109375, 13.3828125,},
{1721.30859375, -2117.177734375, 13.3828125,},
{1735.8916015625, -2117.19921875, 13.3828125,},
{1766.9267578125, -2116.79296875, 13.3828125,},
{1796.130859375, -2117.0634765625, 13.443180084229,},
{1815.1630859375, -2117.2080078125, 13.3828125,},
{1818.0048828125, -2136.19140625, 13.546875,},
{1818.0654296875, -2155.775390625, 13.3828125,},
{1846.0458984375, -2170.880859375, 13.3828125,},
{1877.5537109375, -2170.9970703125, 13.3828125,},
{1924.55078125, -2171.0478515625, 13.3828125,},
{1965.7177734375, -2140.0966796875, 13.3828125,},
{1977.0302734375, -2115.4990234375, 13.546875,},
{1997.951171875, -2114.7744140625, 13.304531097412,},
{2049.3671875, -2114.4736328125, 13.36639213562,},
{2083.029296875, -2105.9619140625, 13.344847679138,},
{2118.73828125, -2107.3427734375, 13.297811508179,},
{2154.6103515625, -2130.3544921875, 13.307221412659,},
{2185.1044921875, -2158.08984375, 13.379595756531,},
{2227.8544921875, -2142.7412109375, 13.330193519592,},
{2254.568359375, -2115.728515625, 13.451043128967,},
{2271.6796875, -2098.4248046875, 13.619883537292,},
{2269.1376953125, -2088.224609375, 13.503924369812,},
{2261.056640625, -2064.8642578125, 13.33357334137,},
{2256.224609375, -2046.9990234375, 13.356472969055,},
{2234.5888671875, -2037.7626953125, 13.314863204956,},
{2228.703125, -2019.859375, 13.323797225952,},
{2212.4609375, -2009.7412109375, 13.304755210876,},
{2218.5068359375, -1994.6328125, 13.290691375732,},
{2234.583984375, -1976.8154296875, 13.353575706482,},
{2254.2744140625, -1976.8955078125, 13.296767234802,},
{2269.0673828125, -1967.505859375, 13.324505805969,},
{2290.7998046875, -1967.638671875, 13.380281448364,},
{2315.8291015625, -1976.5048828125, 13.345545768738,},
{2337.4638671875, -1976.3759765625, 13.301445960999,},
{2343.8037109375, -1982.705078125, 13.3828125,},
{2344.1552734375, -2003.3994140625, 13.544692993164,},
{2427.0537109375, -2013.623046875, 13.393928527832,},
{2459.09765625, -2013.6513671875, 13.305171966553,},
{2484.7587890625, -2013.28125, 13.28125,},
{2515.982421875, -2013.58984375, 13.28125,},
{2509.083984375, -2005.6025390625, 13.28125,},
{2478.2685546875, -2005.294921875, 13.28125,},
{2455.00390625, -2005.0625, 13.298753738403,},
{2454.5048828125, -1978.724609375, 13.546875,},
{2457.3916015625, -1955.892578125, 13.611755371094,},
{2479.390625, -1935.9873046875, 13.312106132507,},
{2500.92578125, -1927.5830078125, 13.318783760071,},
{2520.4736328125, -1912.337890625, 13.3828125,},
{2520.3037109375, -1886.0078125, 13.3828125,},
{2512.318359375, -1867.6611328125, 13.375169754028,},
{2511.9921875, -1844.75390625, 13.377729415894,},
{2520.9560546875, -1822.9814453125, 13.3828125,},
{2531.6484375, -1784.3603515625, 13.3828125,},
{2523.1767578125, -1769.05859375, 13.3828125,},
{2523.197265625, -1744.3427734375, 13.3828125,},
{2501.30859375, -1727.7978515625, 13.3828125,},
{2480.173828125, -1727.94921875, 13.3828125,},
{2495.240234375, -1683.025390625, 13.338850021362,},
{2508.259765625, -1670.3173828125, 13.380631446838,},
{2505.095703125, -1661.2763671875, 13.401618003845,},
{2497.4765625, -1655.333984375, 13.39209651947,},
{2487.24609375, -1654.2548828125, 13.33004283905,},
{2467.2734375, -1654.0625, 13.332408905029,},
{2436.330078125, -1654.890625, 13.378206253052,},
{2408.0576171875, -1654.9765625, 13.3828125,},
{2392.978515625, -1663.3291015625, 13.3828125,},
{2378.0107421875, -1663.1787109375, 13.3828125,},
{2363.95703125, -1654.4677734375, 13.380072593689,},
{2338.3779296875, -1672.8291015625, 13.361850738525,},
{2347.2255859375, -1690.83203125, 13.359375,},
{2338.3798828125, -1717.228515625, 13.359375,},
{2322.7412109375, -1727.7763671875, 13.3828125,},
{2291.240234375, -1727.4609375, 13.3828125,},
{2255.8759765625, -1727.845703125, 13.3828125,},
{2230.146484375, -1728.0830078125, 13.3828125,},
{2222.74609375, -1716.1923828125, 13.499842643738,},
{2230.4013671875, -1667.470703125, 15.036498069763,},
{2239.9873046875, -1649.7666015625, 15.296875,},
{2256.943359375, -1653.7783203125, 15.16189956665,},
{2281.546875, -1653.7548828125, 15.197764396667,},
{2304.00390625, -1654.82421875, 14.466145515442,},
{2369.5283203125, -1528.9921875, 23.828125,},
{2402.525390625, -1529.1669921875, 23.828125,},
{2419.5625, -1519.12109375, 24,},
{2455.1806640625, -1508.7392578125, 23.828125,},
{2484.9970703125, -1509.0849609375, 23.828125,},
{2505.1162109375, -1499.662109375, 23.828125,},
{2530.126953125, -1499.712890625, 23.830575942993,},
{2555.041015625, -1468.427734375, 23.845767974854,},
{2575.0126953125, -1422.8056640625, 23.839000701904,},
{2575.0439453125, -1286.4091796875, 45.9609375,},
{2575.322265625, -1266.8818359375, 46.094551086426,},
{2446.5986328125, -1276.671875, 23.824213027954,},
{2446.724609375, -1303.82421875, 23.824398040771,},
{2446.4765625, -1333.8779296875, 23.824033737183,},
{2446.5439453125, -1359.2841796875, 23.824132919312,},
{2455.5703125, -1372.1181640625, 23.8359375,},
{2455.6806640625, -1398.5615234375, 23.832008361816,},
{2455.806640625, -1425.7119140625, 23.828125,},
{2375.0419921875, -1367.541015625, 23.830121994019,},
{2374.892578125, -1343.4921875, 23.830341339111,},
{2375.0341796875, -1289.5947265625, 23.83013343811,},
{2374.8466796875, -1268.1904296875, 23.8359375,},
{2375.13671875, -1212.7783203125, 27.4296875,},
{2375.5263671875, -1185.4150390625, 27.4296875,},
{2370.8427734375, -1149.1298828125, 27.4453125,},
{2357.0224609375, -1158.6611328125, 27.356325149536,},
{2325.021484375, -1158.9111328125, 26.796875,},
{2245.1220703125, -1225.0283203125, 23.8125,},
{2192.6357421875, -1225.0888671875, 23.8125,},
{2150.3486328125, -1224.798828125, 23.818313598633,},
{2129.3779296875, -1225.5625, 23.819431304932,},
{2108.166015625, -1225.3388671875, 23.8046875,},
{2091.037109375, -1225.2607421875, 23.8046875,},
{2076.6416015625, -1244.630859375, 24.063991546631,},
{2089.5908203125, -1296.4091796875, 23.8203125,},
{2123.578125, -1296.6943359375, 23.814270019531,},
{2148.4150390625, -1296.2978515625, 23.828107833862,},
{2185.4697265625, -1296.408203125, 23.8203125,},
{2215.0048828125, -1296.08203125, 23.8203125,},
{2235.265625, -1296.3486328125, 23.829393386841,},
{2254.8876953125, -1296.3525390625, 23.829399108887,},
--LS 2nd

{2644.44140625, -1999.2822265625, 13.3828125,},
{2656.37109375, -2008.1083984375, 13.3828125,},
{2675.525390625, -2008.26171875, 13.3828125,},
{2693.1279296875, -2008.611328125, 13.3828125,},
{2693.720703125, -1999.189453125, 13.310596466064,},
{2678.5439453125, -1999.2978515625, 13.357340812683,},
{2761.734375, -1979.6298828125, 13.547719955444,},
{2774.9443359375, -1972.1796875, 13.543581008911,},
{2774.220703125, -1952.720703125, 13.284118652344,},
{2764.814453125, -1944.056640625, 13.283618927002,},
{2774.3193359375, -1924.0634765625, 13.282119750977,},
{2765.2548828125, -1903.1474609375, 11.134958267212,},
{1032.9716796875, -1708.8896484375, 13.3828125,},
{1041.8681640625, -1690.9169921875, 13.3828125,},
{1042.103515625, -1666.6005859375, 13.3828125,},
{1032.71875, -1641.9296875, 13.3828125,},
{1033.1318359375, -1614.89453125, 13.3828125,},
{1041.982421875, -1590.671875, 13.3828125,},
{1051.86328125, -1576.34375, 13.388864517212,},
{1075, -1576.908203125, 13.382778167725,},
{1097.9873046875, -1568.3720703125, 13.375,},
{1115.5859375, -1575.9892578125, 13.392736434937,},
{1132.69921875, -1568.1845703125, 13.32520198822,},
{1164.17578125, -1567.5537109375, 13.29098033905,},
{1182.359375, -1568.1484375, 13.358654022217,},
{1188.3955078125, -1577.306640625, 13.546875,},
{1192.244140625, -1544.7568359375, 13.3828125,},
{1191.87890625, -1515.884765625, 13.375,},
{1191.57421875, -1469.4541015625, 13.3828125,},
{1200.7763671875, -1447.0234375, 13.366548538208,},
{1200.62109375, -1423.380859375, 13.291492462158,},
{1173.029296875, -1410.47265625, 13.327878952026,},
{1122.8876953125, -1390.9580078125, 13.469234466553,},
{1075.61328125, -1391.7265625, 13.644569396973,},
{1066.0498046875, -1364.2177734375, 13.3828125,},
{1066.015625, -1332.3642578125, 13.3828125,},
{1065.984375, -1302.912109375, 13.3828125,},
{1050.623046875, -1286.7275390625, 13.494644165039,},
{1050.6015625, -1266.654296875, 13.830444335938,},
{1066.0087890625, -1257.1005859375, 14.582180023193,},
{1065.9873046875, -1237.619140625, 16.086587905884,},
{1050.0009765625, -1207.96875, 17.328386306763,},
{1049.96484375, -1174.904296875, 23.030628204346,},
{1045.2314453125, -1136.7822265625, 23.65625,},
{1020.630859375, -1136.9990234375, 23.651752471924,},
{985.98046875, -1137.361328125, 23.745105743408,},
{955.9541015625, -1152.736328125, 23.745601654053,},
{981.2197265625, -1153.0927734375, 23.751583099365,},
{1008.265625, -1152.7578125, 23.707178115845,},
{1035.3037109375, -1152.978515625, 23.65625,},
{1079.478515625, -1153.33984375, 23.65625,},
{1110.814453125, -1153.078125, 23.65625,},
{1145, -1153.2265625, 23.65625,},
{1172.2431640625, -1152.9287109375, 23.65625,},
{1199.28125, -1153.1494140625, 23.614326477051,},
{1213.216796875, -1137.2138671875, 23.734981536865,},
{1240.896484375, -1137.310546875, 23.640998840332,},
{1247.1826171875, -1153.4013671875, 23.577869415283,},
{1267.0615234375, -1153.5634765625, 23.65625,},
{1293.1005859375, -1153.7763671875, 23.65625,},
{1325.2490234375, -1154.0390625, 23.65625,},]]
-----SF
{-2222.4453125, 540.423828125, 35.015625,},
{-2221.412109375, 519.2900390625, 35.171875,},
{-2222.142578125, 497.62109375, 35.015625,},
{-2222.142578125, 474.0068359375, 35.015625,},
{-2215.8154296875, 572.5078125, 35.015625,},
{-2237.2216796875, 572.150390625, 35.015625,},
{-2248.263671875, 593.755859375, 38.526172637939,},
{-2248.478515625, 624.740234375, 46.18724822998,},
{-2248.826171875, 653.33984375, 49.296875,},
{-2249.2294921875, 695.212890625, 49.296875,},
{-2249.7939453125, 716.419921875, 49.296875,},
{-2249.533203125, 747.27734375, 49.296875,},
{-2249.4072265625, 777.3916015625, 49.296875,},
{-2249.689453125, 865.837890625, 66.5,},
{-2249.57421875, 892.552734375, 66.5,},
{-2248.6806640625, 932.1015625, 66.5,},
{-2248.591796875, 954.5419921875, 66.6650390625,},
{-2248.9814453125, 1036.7392578125, 83.6953125,},
{-2248.798828125, 1053.337890625, 83.118423461914,},
{-2248.7333984375, 1076.3408203125, 80.560844421387,},
{-2249.1669921875, 1098.88671875, 79.859375,},
{-2249.033203125, 1115.9658203125, 75.021728515625,},
{-2357.404296875, 1131.2412109375, 55.2890625,},
{-2380.3310546875, 1140.142578125, 55.2890625,},
{-2406.396484375, 1148.9697265625, 55.2890625,},
{-2440.181640625, 1154.5673828125, 55.2890625,},
{-2476.6025390625, 1156.30078125, 55.2890625,},
{-2499.6904296875, 1156.4814453125, 55.2890625,},
{-2524.1904296875, 1157.2314453125, 55.292301177979,},
{-2544.41796875, 1159.76953125, 55.2890625,},
{-2563.4609375, 1164.2060546875, 55.290287017822,},
{-2578.6982421875, 1133.7080078125, 55.471504211426,},
{-2562.5048828125, 1128.568359375, 55.570373535156,},
{-2535.82421875, 1125.0234375, 55.578125,},
{-2506.0810546875, 1123.060546875, 55.578125,},
{-2479.94921875, 1122.8359375, 55.578125,},
{-2459.9345703125, 1122.8701171875, 55.578125,},
{-2438.10546875, 1122.16015625, 55.578125,},
{-2413.9912109375, 1118.2216796875, 55.585918426514,},
{-2387.9814453125, 1109.869140625, 55.578125,},
{-2402.0693359375, 912.7509765625, 45.324272155762,},
{-2411.8837890625, 912.8310546875, 45.429725646973,},
{-2412.0771484375, 903.7412109375, 45.431869506836,},
{-2423.486328125, 903.71875, 46.847381591797,},
{-2423.486328125, 903.71875, 46.847381591797,},
{-2434.0830078125, 913.015625, 51.235130310059,},
{-2464.3212890625, 913.0673828125, 62.762798309326,},
{-2469.412109375, 903.7939453125, 62.932159423828,},
{-2486.5166015625, 903.697265625, 63.837657928467,},
{-2500.16796875, 913.044921875, 64.71297454834,},
{-2513.873046875, 912.8916015625, 64.874420166016,},
{-2521.6298828125, 920.3779296875, 65.004013061523,},
{-2521.66796875, 921.0478515625, 65.007614135742,},
{-2521.2734375, 938.509765625, 65.101425170898,},
{-2522.5712890625, 973.333984375, 75.855407714844,},
{-2522.5615234375, 997.154296875, 78.1328125,},
{-2537.50390625, 1000.228515625, 78.13484954834,},
{-2544.431640625, 1008.1279296875, 78.129425048828,},
{-2561.1982421875, 1008.6845703125, 78.140625,},
{-2571.2216796875, 999.6015625, 78.140625,},
{-2592.103515625, 1000.060546875, 78.140625,},
{-2602.494140625, 995.123046875, 78.125862121582,},
{-2610.96484375, 987.4658203125, 78.139511108398,},
{-2610.8515625, 964.8564453125, 78.12939453125,},
{-2602.0205078125, 956.0126953125, 76.789566040039,},
{-2602.1123046875, 941.513671875, 71.557884216309,},
{-2611.041015625, 928.6435546875, 66.731925964355,},
{-2611.333984375, 917.6611328125, 64.828125,},
{-2628.4375, 911.599609375, 68.505264282227,},
{-2661.1025390625, 905.181640625, 79.492431640625,},
{-2662.078125, 904.91796875, 79.495765686035,},
{-2681.986328125, 899.884765625, 79.5546875,},
{-2695.251953125, 888.8935546875, 79.642990112305,},
{-2709.482421875, 885.8486328125, 76.258262634277,},
{-2721.9775390625, 892.0146484375, 71.830276489258,},
{-2745.9638671875, 872.50390625, 66.13395690918,},
{-2746.115234375, 863.1328125, 64.062683105469,},
{-2754.9765625, 846.9755859375, 59.506774902344,},
{-2754.98828125, 828.84765625, 54.576545715332,},
{-2742.4404296875, 816.8818359375, 53.0625,},
{-2737.3115234375, 808.5478515625, 53.0625,},
{-2706.9619140625, 808.509765625, 49.828125,},
{-2706.4453125, 817.5849609375, 49.984375,},
{-2539.234375, 913.244140625, 64.834480285645,},
{-2542.8515625, 904.228515625, 64.825775146484,},
{-2563.0224609375, 903.8759765625, 64.828125,},
{-2570.923828125, 903.7802734375, 64.828125,},
{-2589.611328125, 903.603515625, 64.828125,},
{-2593.478515625, 912.7021484375, 64.828125,},
{-2585.662109375, 912.828125, 64.828125,},
{-2610.9892578125, 891.6044921875, 63.890197753906,},
{-2610.8662109375, 875.7099609375, 59.601150512695,},
{-2610.80859375, 864.8037109375, 56.610904693604,},
{-2610.76953125, 857.2294921875, 54.523231506348,},
{-2610.6630859375, 836.962890625, 49.828125,},
{-2610.5751953125, 820.5341796875, 49.828125,},
{-2602.0322265625, 824.7353515625, 49.828125,},
{-2602.5126953125, 846.4599609375, 51.497081756592,},
{-2602.564453125, 863.9169921875, 56.367603302002,},
{-2602.6220703125, 883.421875, 61.684787750244,},
{-2602.7294921875, 894, 64.53352355957,},
{-2619.376953125, 814.17578125, 49.835823059082,},
{-2644.931640625, 815.3115234375, 49.828125,},
{-2659.9814453125, 816.1875, 49.835823059082,},
{-2682.396484375, 807.92578125, 49.828125,},
{-2664.66796875, 807.36328125, 49.835823059082,},
{-2647.5703125, 806.7666015625, 49.828125,},
{-2632.1845703125, 806.4970703125, 49.835823059082,},
{-2594.630859375, 804.6865234375, 49.830093383789,},
{-2570.6474609375, 804.5693359375, 49.828125,},
{-2548.76171875, 804.5390625, 49.825290679932,},
{-2539.8017578125, 811.8828125, 49.827476501465,},
{-2562.7412109375, 811.71875, 49.828125,},
{-2595.6337890625, 812.359375, 49.830341339111,},
{-2523.16796875, 833.0654296875, 49.828125,},
{-2530.3876953125, 838.21875, 49.828125,},
{-2530.6318359375, 845.9384765625, 51.354072570801,},
{-2530.8193359375, 868.6689453125, 57.671390533447,},
{-2530.884765625, 890.5087890625, 63.595237731934,},
{-2522.2841796875, 892.619140625, 64.157089233398,},
{-2522.6201171875, 860.912109375, 55.543407440186,},
{-2522.4150390625, 826.65625, 49.828125,},
{-2522.2265625, 793.8583984375, 49.094058990479,},
{-2522.3486328125, 782.5927734375, 45.071956634521,},
{-2531.0771484375, 780.94921875, 44.495059967041,},
{-2531.2998046875, 761.9599609375, 37.628868103027,},
{-2523.1806640625, 740.3212890625, 29.981010437012,},
{-2522.03125, 720.96484375, 28.035816192627,},
{-2486.494140625, 712.90625, 34.942901611328,},
{-2447.8134765625, 712.732421875, 35.021057128906,},
{-2415.302734375, 712.876953125, 35.015625,},
{-2402.640625, 712.93359375, 35.015625,},
{-2380.7314453125, 736.435546875, 35.015625,},
{-2379.9677734375, 759.357421875, 35.015625,},
{-2380.3828125, 790.126953125, 35.015625,},
{-2380.28515625, 834.2236328125, 37.611457824707,},
{-2380.203125, 870.0478515625, 44.080284118652,},
{-2380.1796875, 940.75390625, 45.462589263916,},
{-2496.994140625, -59.21484375, 25.467527389526,},
{-2496.9931640625, -39.833984375, 25.609375,},
{-2497.3564453125, 2.00390625, 25.609375,},
{-2497.49609375, 24.9423828125, 25.494129180908,},
{-2504.9140625, 25.599609375, 25.489320755005,},
{-2504.943359375, 1.6552734375, 25.609375,},
{-2505.3701171875, -39.796875, 25.609375,},
{-2505.4853515625, -55.533203125, 25.494491577148,},
{-2599.8203125, -84.373046875, 4.1796875,},
{-2600.0537109375, -99.4482421875, 4.1796875,},
{-2600.3740234375, -115.5126953125, 4.1796875,},
{-2589.794921875, -126.4267578125, 4.1796875,},
{-2575.33203125, -125.9765625, 6.4571523666382,},
{-2577.283203125, -134.255859375, 6.109902381897,},
{-2591.8212890625, -134.95703125, 4.1796875,},
{-2599.62109375, -146.7587890625, 4.1796875,},
{-2599.9248046875, -168.5341796875, 4.1796875,},
{-2599.9091796875, -196.95703125, 4.1796875,},
{-2607.8369140625, -198.6953125, 4.1796875,},
{-2607.92578125, -170.92578125, 4.1796875,},
{-2607.9951171875, -149.3427734375, 4.1796875,},
{-2608.0400390625, -117.2109375, 4.1796875,},
{-2607.775390625, -92.5615234375, 4.1796875,},
{-2607.9716796875, -82.603515625, 4.1796875,},
{-2630.509765625, -74.8134765625, 4.1796875,},
{-2653.1416015625, -74.8544921875, 4.1796875,},
{-2656.2734375, -89.736328125, 4.1333680152893,},
{-2656.234375, -121.37109375, 4.0200366973877,},
{-2656.4521484375, -166.61328125, 4.2169766426086,},
{-2655.197265625, -195.150390625, 4.142674446106,},
{-2673.06640625, -205.2216796875, 4.3359375,},
{-2702.0244140625, -191.1982421875, 4.1796875,},
{-2702.35546875, -167.779296875, 4.2531909942627,},
{-2702.640625, -147.6455078125, 4.3522233963013,},
{-2703.080078125, -119.59765625, 4.2270469665527,},
{-2702.962890625, -90.1318359375, 4.2270121574402,},
{-2710.3525390625, -88.1865234375, 4.1874809265137,},
{-2710.162109375, -108.3076171875, 4.3447947502136,},
{-2709.748046875, -143.9248046875, 4.1796875,},
{-2709.2021484375, -194.0458984375, 4.3248448371887,},
{-2758.1953125, -184.607421875, 6.945864200592,},
{-2757.365234375, -160.9638671875, 6.9297780990601,},
{-2755.9365234375, -120.203125, 7.0682082176208,},
{-2757.0556640625, -85.181640625, 7.0153322219849,},
{-2758.2763671875, -55.771484375, 7.366593837738,},
{-2759.07421875, -37.1328125, 6.9055938720703,},
{-2760.310546875, -14.947265625, 6.9136629104614,},
{-2761.8642578125, 7.58984375, 6.9101014137268,},
{-2762.9921875, 23.9931640625, 7.0001516342163,},
{-2763.27734375, 50.0107421875, 7.03125,},
{-2762.9111328125, 66.427734375, 6.8999276161194,},
{-2762.9814453125, 86.62890625, 6.9082555770874,},
{-2760.677734375, 112.5361328125, 6.9603576660156,},
{-2757.7568359375, 144.5888671875, 7.0035591125488,},
{-1810.388671875, 1096.4541015625, 45.2890625,},
{-1810.5205078125, 1110.0986328125, 45.2890625,},
{-1838.2529296875, 1110.1689453125, 45.2890625,},
{-1864.94921875, 1110.142578125, 45.296855926514,},
{-1860.744140625, 1096.6005859375, 45.2890625,},
{-1847.39453125, 1096.4521484375, 45.2890625,},
{-1800.8427734375, 1012.9853515625, 24.734375,},
{-1800.818359375, 971.0537109375, 24.734375,},
{-1800.5791015625, 947.7626953125, 24.734375,},
{-1773.7578125, 937.7705078125, 24.7421875,},
{-1744.00390625, 937.8173828125, 24.7421875,},
{-1707.2275390625, 1033.14453125, 45.0625,},
{-1707.16796875, 1066.69140625, 45.0625,},
{-1720.1845703125, 1074.8525390625, 45.157249450684,},
{-1720.34765625, 1056.72265625, 45.0625,},
{-1720.662109375, 1027.6279296875, 45.057121276855,},
{-1733.1162109375, 1180.1474609375, 24.970920562744,},
{-1772.4716796875, 1179.7421875, 24.970920562744,},
{-1870.623046875, 1168.869140625, 45.183517456055,},
{-1903.533203125, 1184.8623046875, 45.296875,},
{-1929.5400390625, 1184.978515625, 45.296875,},
{-1979.5078125, 1184.859375, 45.296875,},
{-2005.841796875, 1185.158203125, 45.296875,},
{-2120.49609375, 1184.3916015625, 55.571140289307,},
{-2224.109375, 1183.951171875, 55.578125,},
{-2228.1103515625, 1169.1259765625, 55.578125,},
{-2179.32421875, 1169.0732421875, 55.578125,},
{-2135.7314453125, 1034.7744140625, 79.8515625,},
{-2135.634765625, 998.91796875, 79.8515625,},
{-2150.28125, 1007.5322265625, 79.8515625,},
{-2150.6162109375, 988.3310546875, 79.8515625,},
{-2150.501953125, 958.52734375, 79.8515625,},
{-2136.1923828125, 938.95703125, 79.8515625,},
{-2135.0244140625, 899.3974609375, 79.8515625,},
{-2135.3134765625, 849.9775390625, 69.694938659668,},
{-2150.443359375, 837.1611328125, 69.40625,},
{-2136.564453125, 819.1220703125, 69.40625,},
{-2125.060546875, 813.5048828125, 69.557647705078,},
{-2011.3330078125, 795.0634765625, 45.296875,},
{-2011.099609375, 783.810546875, 45.296875,},
{-2011.0078125, 763.9267578125, 45.296875,},
{-2010.8994140625, 749.197265625, 45.290298461914,},
{-1998.0556640625, 750.2861328125, 45.296875,},
{-1997.55859375, 771.4833984375, 45.296875,},
{-1997.3681640625, 806.7421875, 45.322425842285,},
{-1997.333984375, 830.2431640625, 45.296875,},
}

local screenW, screenH = guiGetScreenSize()

local isWasteJobRunning = false 
local lastTick = getTickCount()
local wasteTakeProgress = nil
local recreateWasteMarkerTimers = {}

function dxWasteMan()
	if (tonumber(wasteTakeProgress)) then
		if (getTickCount() - lastTick >= 100) then
			wasteTakeProgress = wasteTakeProgress + 1
			lastTick = getTickCount()
		end

		dxDrawText("Collecting Trash\n"..tostring(wasteTakeProgress).."%", screenW * 0.2961, screenH * 0.4708, screenW * 0.7047, screenH * 0.5292, tocolor(255, 255, 255, 255), 1.20, "pricedown", "center", "center", false, false, false, false, false)
		
		if (wasteTakeProgress >= 100) then
			removeEventHandler("onClientRender", root, dxWasteMan)
			wasteTakeProgress = nil
			collectedTrash()
		end
	end
end

function onElementDataChange(dataName, oldValue)
	if (dataName == "Occupation" and getElementData(localPlayer, dataName) == "Trash Collector") then
		initWasteJob()
	elseif (dataName == "Occupation" and isWasteJobRunning) then
		stopWasteJob()
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onElementDataChange, false)

--[[function onWasteTeamChange(oldTeam, newTeam)
	if (getElementData(localPlayer, "Occupation") == "Trash Collector" and source == localPlayer) then
		setTimer( 
			function()
				if (getPlayerTeam(localPlayer)) then
					local newTeam = getTeamName(getPlayerTeam(localPlayer))
					if (newTeam == "Unoccupied") then
						stopWasteJob()
					elseif (getElementData(localPlayer, "Occupation") == "Trash Collector" and newTeam == "Civilian Workers") then
						initWasteJob()
					end
				end
			end
		, 200, 1)
	end
end
addEvent("onClientPlayerTeamChange", true)
addEventHandler("onClientPlayerTeamChange", localPlayer, onWasteTeamChange, false)]]

function initWasteJob()
	if (not isWasteJobRunning) then
		isWasteJobRunning = true
		setWaste()
	end
end

function stopWasteJob()
	if (isWasteJobRunning) then
		removeWaste()
	   	isWasteJobRunning = false

	   	exports.CSGranks:closePanel()
	   	
	   	if (tonumber(wasteTakeProgress)) then
	   		removeEventHandler("onClientRender", root, dxWasteMan)
			removeEventHandler("onClientVehicleExplode", getPedOccupiedVehicle(localPlayer), vehicleExplode)
			removeEventHandler("onClientVehicleExit", getPedOccupiedVehicle(localPlayer), vehicleExit)	   

			wasteTakeProgress = nil		
	   	end

	   	for i, v in ipairs(recreateWasteMarkerTimers) do
	   		if (isTimer(v)) then
	   			killTimer(v)
	   		end
	   	end

	   	recreateWasteMarkerTimers = {}
	end
end

function vehicleExplode()
	removeEventHandler("onClientRender", root, dxWasteMan)
	removeEventHandler("onClientVehicleExplode", source, vehicleExplode)
	removeEventHandler("onClientVehicleExit", source, vehicleExit)
	wasteTakeProgress = nil
	showCursor(false)

	exports.NGCdxmsg:createNewDxMessage("You earned nothing because your vehicle got destroyed!", 255, 0, 0)
end

function vehicleExit()
	removeEventHandler("onClientRender", root, dxWasteMan)
	removeEventHandler("onClientVehicleExplode", source, vehicleExplode)
	removeEventHandler("onClientVehicleExit", source, vehicleExit)
	wasteTakeProgress = nil
	showCursor(false)

	exports.NGCdxmsg:createNewDxMessage("You earned nothing because you exited your vehicle!", 255, 0, 0)
end

function hitGarbage(hitElement, matchingDimension)
	local theMarker = source

	if (hitElement and getElementType(hitElement) == "player" and hitElement == localPlayer and matchingDimension and getPedOccupiedVehicle(hitElement) and isWasteMarker(theMarker) and getVehicleController(getPedOccupiedVehicle(hitElement)) == localPlayer) then
		if (isElement(theMarker)) then
			local veh = getPedOccupiedVehicle(hitElement)

			if (getElementModel(veh) ~= 408) then 
				return false 
			end

			setElementFrozen(getPedOccupiedVehicle(hitElement), true)

			local x,y,z = getElementPosition(theMarker)

			recreateWasteMarkerTimers[#recreateWasteMarkerTimers + 1] = setTimer(
				function(x, y, z)
					theMarker = createMarker(x, y, z, "cylinder", 3.0, 200, 100, 0, 255)

					wasteMarkersForPlayer[theMarker] = createBlip(x, y,3,17, 50)
					setBlipVisibleDistance(wasteMarkersForPlayer[theMarker], getBlipVisibleDistance(wasteMarkersForPlayer[theMarker]) / 200)

					addEventHandler("onClientMarkerHit", theMarker, hitGarbage)
				end
			, 120000, 1, x, y, z)

			wasteTakeProgress = 1
			addEventHandler("onClientRender", root, dxWasteMan)

			if (wasteMarkersForPlayer[theMarker]) then
				destroyElement(wasteMarkersForPlayer[theMarker])
			end

			wasteMarkersForPlayer[theMarker] = nil
			removeEventHandler("onClientMarkerHit", theMarker, hitGarbage)
			destroyElement(theMarker)

			showCursor(true)

			addEventHandler("onClientVehicleExplode", veh, vehicleExplode)
			addEventHandler("onClientVehicleExit", veh, vehicleExit)
		end
	end
end

function isWasteMarker(theMarker)
	if (wasteMarkersForPlayer[theMarker]) then
		return true 
	end

	return false
end


function setWaste()
	if (getElementData(localPlayer, "Occupation") == "Trash Collector") then
		for i=1, #wasteTablesForPlayer do
			local x, y, z = wasteTablesForPlayer[i][1], wasteTablesForPlayer[i][2], wasteTablesForPlayer[i][3]
			local theMarker = createMarker(x, y, z -1, "cylinder", 3.0, 200, 100, 0, 255)

			wasteMarkersForPlayer[theMarker] = createBlip(x, y, 3, 17, 50)
			setBlipVisibleDistance(wasteMarkersForPlayer[theMarker], getBlipVisibleDistance(wasteMarkersForPlayer[theMarker]) / 200)

			addEventHandler("onClientMarkerHit", theMarker, hitGarbage)
		end
	end
end

function removeWaste()
	for i, v in pairs(wasteMarkersForPlayer) do
		if (isElement(v)) then
			destroyElement(v)
		end

		if (isElement(i)) then
			removeEventHandler("onClientMarkerHit", i, hitGarbage)
			destroyElement(i)
		end
	end

	wasteMarkersForPlayer = {}
end

function collectedTrash()
	--toggleAllControls(true, true, true)
	setElementFrozen(getPedOccupiedVehicle(localPlayer), false)
	triggerServerEvent("collectedTrashMoney", localPlayer)
	showCursor(false)

	removeEventHandler("onClientVehicleExplode", getPedOccupiedVehicle(localPlayer), vehicleExplode)
	removeEventHandler("onClientVehicleExit", getPedOccupiedVehicle(localPlayer), vehicleExit)
end
addEvent("collectedTrash", true)
addEventHandler("collectedTrash", localPlayer, collectedTrash)

function loadJob()
	if (getElementData(localPlayer, "Occupation") == "Trash Collector") then
		initWasteJob()
	end
end
addEventHandler("onClientResourceStart", resourceRoot, loadJob)

function unloadJob()
	if (isWasteJobRunning and wasteTakeProgress ~= nil) then
		setElementFrozen(getPedOccupiedVehicle(localPlayer), false)
	end
end
addEventHandler("onClientResourceStop", resourceRoot, unloadJob)

function toggleWastePanel()
	if (getElementData(localPlayer, "Occupation") == "Trash Collector" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5", "down", toggleWastePanel)
