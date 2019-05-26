local mapsGUI = {}
local updateBookmarks = true

local GPSTable = {
	["Los Santos"] =  {
		["Milestone"] =  {
			{"Milestone","LS Airport", 1937.7438964844,-2262.0295410156,13.546875},
			{"Milestone","LS Bank", 593.4, -1241.33, 17},
		},
		["Service"] =  {
			{"Service","All Saints Hospital", 1193.9068603516,-1325.8192138672,13.3984375},
			{"Service","LS Police Department", 1585.5649414063,-1632.4291992188,13.3828125},
			{"Service","Pay 'n Spray", 1025.1927490234,-1032.388671875,31.913976669312},
		},
		["Event"] =  {
		{"Event","LS Bankrobbery",1463.56,-1027.88,23},
		{"Event","LS Drugshipment",2750.27,-2460.01,13},
		},
		["Shop"] =  {
		{"Shop","Vehicles Paintjob",863.61895751953,-1060.0125732422,25.1015625,65},
		{"Shop","Ammunation (Weapons)",1363.79,-1278.87,13,90},
		{"Shop","Car Shop (Luxury)", 559.88, -1254.5, 16.5},
		{"Shop","Car Shop", 2134.41, -1121.76, 25},
		{"Shop","Plane Shop",2100.09,-2433.86,13.2},
		{"Shop","Heavy vehicle Shop",2285.4614257813,-2360.2609863281,12.546875},
		{"Shop","Boat Shop",-19.444913864136,-1643.5115966797,2.1643853187561},
		{"Shop","Used Plane Shop",1995.74,-2324.12,13},
		{"Shop","Used Boat Shop", -35.410842895508, -1583.0404052734, 2.8582034111023},
		{"Shop","Used Bike Shop",702.18981933594, -523.77899169922, 16},
		{"Shop","Used Helicopter Shop",1539.73,-1352.19,329},
		},
		["Job"] =  {
		{"Job","Mechanic", 1010.22, -1030.93, 31.94},
		{"Job","Pilot",1896.97, -2245.41, 13.54},
		{"Job","Fisherman",982.05, -2087, 4.8},
		{"Job","Lumberjack",-534.85, -178.03, 78.4},
		},
	},

	["San Fierro"] =  {
		["Milestone"] =  {
		{"Milestone","SF Airport", -1673, -400, 0},
		},
		["Service"] =  {
		{"Service","SF Medical Center", -2641.52, 632.28, 14.45},
		},
		["Shop"] =  {
		{"Shop","Car Shop", -1970.5, 300.23, 35.17},
		{"Shop","Car Shop (Luxury)", -1641.63, 1203.41, 7.24},
		{"Shop","Bike shop", -2069.29, -92.76, 35.16},
		{"Shop","Plane shop", -1500,-610,15.72,74},
		{"Shop","Heavy Vehicle shop", -1963.33,-2472.36,30.65,34},
		},
		["Job"] =  {
		{"Job","Pilot",-1544.8991699219,-438.73773193359,6,180}, -- pilot
		{"Job","Mechanic",-2027.9002685547,144.3180847168,28.8359375,179}, -- mechanic
		{"Job","Firefighter",277,-1812.41,577,6191.06,178}, --- firefighter
		{"Job","Farmer",158,-1803.78,577,6191.06,180}, --- farmer
		{"Job","Lumberjack",27,-1801.39,571.2,6191.06,84},
		{"Job","Taxi driver",-1755.466796875,942.29858398438,24.890625},
		{"Job","Trucker",-1693.1685791016,-19.166397094727,3.5546875,88},
		{"Job","Fisherman",-2090.9846191406,1407.0892333984,7.1015625,86},
		{"Job","Rescuer Man",-2825.8615722656,1307.7030029297,7.1015625,88},
		{"Job","Trash Collector",-1860.3994140625,-201.44895935059,18.3984375,87},
		},
		--{"Job","",},
	},

	["Las Venturas"] =  {
		["Milestone"] =  {
		{"Milestone","LV Airport", 1584, 1643, 0},
		},
		["Service"] =  {
		{"Service","LV Police Department", 2287, 2425, 0},
		{"Service","LV Hospital", 1606.75, 1833.73, 10.82},
		},
		["Shop"] =  {
		{"Shop","Car Shop (Luxury)", 2200.5205078125,1387.7072753906,10.8203125},
		{"Shop","Car Shop", 1736.64, 1879.18, 10.82},
		},
		["Job"] =  {
		{"Job","Mechanic", 1962.9, 2143.65, 10.82},
		{"Job","Pilot",1711.91, 1614.83, 10.13},
		{"Job","Miner",-393.69,2210.27,45.13},
		},
	},
}

function openMaps()
	if not mapsGUI[1] then mapsGUI[1] = guiCreateButton ( BGX+(BGWidth*0.50), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Start GPS", false ) end
	if not mapsGUI[2] then mapsGUI[2] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), 0.50*BGWidth, 0.068*BGHeight, "Stop GPS", false ) end
	if not mapsGUI[3] then mapsGUI[3] = guiCreateCheckBox ( BGX, BGY+(0.74*BGHeight), BGWidth, 0.058*BGHeight, "Enable voice turn by turn GPS", false, false ) end
	if not mapsGUI[4] then mapsGUI[4] = guiCreateCheckBox ( BGX, BGY+(0.79*BGHeight), BGWidth, 0.058*BGHeight, "Enable car rotation arrow", false, false ) end
	if not mapsGUI[5] then mapsGUI[5] = guiCreateCheckBox ( BGX, BGY+(0.84*BGHeight), BGWidth, 0.058*BGHeight, "Enable road rotation arrows", false, false ) end
	if not mapsGUI[6] then mapsGUI[6] = guiCreateGridList ( BGX, BGY+8, 0.99770569801331*BGWidth, 0.70*BGHeight, false ) end
---	if not mapsGUI[7] then mapsGUI[7] = guiCreateLabel ( BGX, BGY+(0.61*BGHeight), BGWidth, 0.048*BGHeight,"Or enter a playername to put GPS on:", false) end
--		if not mapsGUI[8] then mapsGUI[8] = guiCreateEdit( BGX+(0.05*BGWidth),BGY+(0.67*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"",false) end

	guiGridListSetSortingEnabled ( mapsGUI[6], false )
	--guiLabelSetHorizontalAlign ( mapsGUI[7], "center" )
	guiSetFont(mapsGUI[6],"default-bold-small")
	addEventHandler( "onClientGUIClick", mapsGUI[1], onStartMapsGPS )
	addEventHandler( "onClientGUIClick", mapsGUI[2], onStopMapsGPS )

	for i=1, #mapsGUI do
		if i <= 8 then
			guiSetVisible ( mapsGUI[i], true )
			guiSetProperty ( mapsGUI[i], "AlwaysOnTop", "True" )
		end
	end

	if ( updateBookmarks ) then uploadGridlistBookmarks () end

	apps[10][7] = true
end
apps[10][8] = openMaps

function closeMaps()

	removeEventHandler( "onClientGUIClick", mapsGUI[1], onStartMapsGPS )
	removeEventHandler( "onClientGUIClick", mapsGUI[2], onStopMapsGPS )

	for i=1,#mapsGUI do
		if i <= 6 then
			guiSetVisible ( mapsGUI[i], false )
			guiSetProperty ( mapsGUI[i], "AlwaysOnTop", "False" )
		end
	end

	apps[10][7] = false
end
apps[10][9] = closeMaps

function getSelectBookmark ()
	local row, column = guiGridListGetSelectedItem ( mapsGUI[6] )
	if ( tostring( row ~= "-1" ) ) then
		outputDebugString("Row selected")
		local thePos = guiGridListGetItemData( mapsGUI[6], row, 1 )
		local thePlace = guiGridListGetItemText ( mapsGUI[6], row, 1 )
		if thePos then
			return thePos,thePlace
		else
			return false
		end
		--[[if ( thePos ) then
			local theTable = exports.server:stringExplode( thePos, "," )
			return theTable[3], theTable[4], theTable[5], thePlace
		else
			return false
		]]
	else
		return false
	end
end

function onStartMapsGPS ()
	local opt1, opt2, opt3 = guiCheckBoxGetSelected( mapsGUI[3] ), guiCheckBoxGetSelected( mapsGUI[4] ), guiCheckBoxGetSelected( mapsGUI[5] )
	local t,thePlace = getSelectBookmark()
	local x,y,z = unpack(t)
	if ( x ) and ( y ) and ( z ) then
		exports.CSGgps:setDestination( x, y, z, thePlace, false, { opt2, opt3, opt1, false } )
	else
		exports.NGCdxmsg:createNewDxMessage( "You didn't select position from the bookmark!", 255,0, 0 )
	end
end

function onStopMapsGPS ()
	exports.CSGgps:resetDestination()
end

function uploadGridlistBookmarks ()
	guiGridListAddColumn( mapsGUI[6], "Bookmarks:", 0.9 )
	for theName, theCategory in pairs( GPSTable ) do
		local row = guiGridListAddRow( mapsGUI[6] )
		guiGridListSetItemText( mapsGUI[6], row, 1, theName, true, false )
		guiGridListSetItemColor ( mapsGUI[6], row, 1, 255,0,0 )

		for k,v in pairs( theCategory ) do
			local row1 = guiGridListAddRow( mapsGUI[6] )
			guiGridListSetItemText( mapsGUI[6], row1, 1,k, true, false )
			guiGridListSetItemColor ( mapsGUI[6], row1, 1, 255,155,0 )
			for theIndex, theBookmark in pairs( v ) do
				local row = guiGridListAddRow( mapsGUI[6] )
				guiGridListSetItemText( mapsGUI[6], row, 1, theBookmark[2], false, false )
				guiGridListSetItemData( mapsGUI[6], row, 1, {theBookmark[3],theBookmark[4],theBookmark[5]} )
				guiGridListSetItemColor ( mapsGUI[6], row, 1, 255,255,255 )
			end
		end
	end
	updateBookmarks = false
end
