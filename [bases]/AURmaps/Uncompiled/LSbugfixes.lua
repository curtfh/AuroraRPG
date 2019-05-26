for i,v in ipairs({
    {3114,1118.7002,-1292.5996,18.6,90,13.26,166.734},
    {3114,1129.2002,-1302.4004,18.2,90,18.99,69.291},
    {3114,1131.4004,-1301.5,18.2,90,9.731,80.269},
    {3114,1108.2998,-1302.7002,19,90,90,0},
    {3114,1119,-1313,18.3,90,0,0},
    {2933,1130.0996,-1291.9004,16.3,0,90,7.998},
    {2933,1130.1,-1312.3,17.1,0,90,22},
    {2933,1110.2998,-1312.2998,16.6,0,90,329.996},
    {3095,1112.8,-1296.6,24,0,0,0},
    {3095,1112.8,-1308.7,23.8,0,0,0},
    {3095,1113,-1304.3,23.8,0,0,0},
    {3095,1121.9004,-1308.9004,23.8,0,0,0},
    {3095,1121.5996,-1304.0996,23.8,0,0,0},
    {3095,1121.8,-1296.7,23.8,0,0,0},
    {3095,1127.4004,-1296.5996,23.8,0,0,0},
    {3095,1127.4,-1305.4,23.8,0,0,0},
    {3095,1127.7002,-1308.9004,23.8,0,0,0},
    {10946,867.5,-1205.4,14.36,0,180,0},
    {10946,867.45001,-1175.1,14.36,0,179.995,0},
    {3114,859.90002,-1230.8,10.2,90,6.766,83.228},
    {3114,849.70001,-1232.3,15.42,0,0,0},
    {3114,828.79999,-1232.3,15.42,0,0,0},
    {3114,819,-1232.3,15.41,0,0,0},
    {3114,818.29999,-1158.9,20,90,0,180},
    {3114,839.40002,-1158.9,20,90,0,179.995},
    {3114,860.5,-1158.9,20,90,0,179.995},
    {3114,881.5,-1158.9,20,90,0,179.995},
    {3095,807.40002,-1223.6,14.2,90,0,90},
    {3095,807.40002,-1214.6,15.3,90,0,90},
    {3095,807.40002,-1205.6,16.7,90,0,90},
    {3095,807.40002,-1196.6,18.3,90,0,90},
    {3095,807.40002,-1187.6,19.7,90,0,90},
    {3095,807.40002,-1178.6,20.9,90,0,90},
    {3095,807.40997,-1169.6,21.7,90,0,90},
    {3095,807.40002,-1163,21.7,90,0,90},
    {3095,807.40002,-1160.9,14,90,0,90},
    {3095,807.40002,-1169.9,14,90,0,90},
}) do
    local obj = createObject(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    setObjectScale(obj, 1)
    setElementDimension(obj, 0)
    setElementInterior(obj, 0)
    setElementDoubleSided(obj, true)
	setObjectBreakable(obj, false)
end