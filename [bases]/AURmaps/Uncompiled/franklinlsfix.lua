Objects = {

createObject ( 3114, 1118.7002, -1292.5996, 18.6, 90, 13.263, 166.737 ),
createObject ( 3114, 1129.2002, -1302.4004, 18.2, 90, 18.995, 69.291 ),
createObject ( 3114, 1131.4004, -1301.5, 18.2, 90, 90, 0 ),
createObject ( 3114, 1108.2998, -1302.7002, 19, 90, 90, 0 ),
createObject ( 3114, 1119, -1313, 18.3, 90, 0, 0 ),
createObject ( 2933, 1130.1, -1291.9, 16.3, 0, 90, 8 ),
createObject ( 2933, 1130.1, -1312.3, 17.1, 0, 90, 22 ),
createObject ( 2933, 1110.3, -1312.3, 16.6, 0, 90, 330 ),
createObject ( 3095, 1112.8, -1296.6, 24 ),
createObject ( 3095, 1112.8, -1308.7, 23.8 ),
createObject ( 3095, 1113, -1304.3, 23.8 ),
createObject ( 3095, 1121.9, -1308.9, 23.8 ),
createObject ( 3095, 1121.6, -1304.1, 23.8 ),
createObject ( 3095, 1121.8, -1296.7, 23.8 ),
createObject ( 3095, 1127.4, -1296.6, 23.8 ),
createObject ( 3095, 1127.4, -1305.4, 23.8 ),
createObject ( 3095, 1127.7, -1308.9, 23.8 ),

}

for index, object in ipairs ( Objects ) do
	setElementDoubleSided ( object, true )
	setObjectBreakable( object,false)
	setElementAlpha( object, 0)
end