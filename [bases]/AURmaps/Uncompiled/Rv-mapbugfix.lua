Objects = {
createObject ( 8577, 2809.3203, 1303.1875, 10.54688 ),
createObject ( 8575, 2842.5781, 1290.7891, 16.14063 ),
createObject ( 8578, 2798.6328, 1246.6641, 17.10938, 0, 0, 179.995 ),
}

for index, object in ipairs ( Objects ) do

	setElementDoubleSided ( object, true )

	setObjectBrekable(object,false)

end