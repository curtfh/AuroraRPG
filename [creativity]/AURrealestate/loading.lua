cache = {}
odata = {
	lod = {},
	object = {},
	texture = {},
	shader = {},
	data = {},
}

zone_objects = {
	["zone1"] = {
		--Exterior Walls
		{ "2941.4,-1549.1,12.1", "0,90,0", 1462, "brick_wall"},
		{ "2951.3,-1559.2,17.1", "0,90,90", 1462, "brick_wall"},
		{ "2951.3,-1559.2,12.1", "0,90,90", 1462, "brick_wall"},
		{ "2941.4,-1549.1,17.1", "0,90,0", 1462, "brick_wall"},
		{ "2951.3,-1539.1,12.1", "0,90,90", 1462, "brick_wall"},
		{ "2951.3,-1539.1,17.1", "0,90,90", 1462, "brick_wall"},
		{ "2961.2,-1549.1,17.1", "0,90,0", 1462, "brick_wall"},
		{ "2961.2,-1554.1,12.1", "0,90,0", 1467, "brick_wall"},
		-- Glass Roof
		{ "2946.5,-1554.1,19.5", "0,0,0", 2670, "wood1"},
		{ "2946.5,-1544.3,19.5", "0,0,0", 2670, "wood1"},
		{ "2956.3,-1544.3,19.5", "0,0,0", 2670, "wood1"},
		{ "2956.3,-1554.1,19.5", "0,0,0", 2670, "wood1"},
		-- 1st Floor Walls
		{ "2956.1,-1549.1,12", "0,90,90", 1466, "wood2"},
		{ "2951.1,-1546.7,12.1", "0,90,0", 2671, "wood2"},
		{ "2951.1,-1541.7,12.1", "0,90,0", 1464, "wood2"},
		-- Floors of 1st Floor
		{ "2956.3,-1544.1,9.7", "0,0,0", 1469, "wood1"},
		{ "2946.3,-1544.2,9.7", "0,0,0", 1469, "blucarp"},
		{ "2946.1,-1554.2,9.7", "0,0,0", 1469, "blucarp"},
		{ "2956.1,-1554.1,9.7", "0,0,0", 1469, "blacktile"},
		-- Staircase
		{ "2953.8,-1547.9,13.2", "0,0,270", 3056, "wood2"},
		{ "2958.5,-1547.9,10.4", "0,0,270", 3056, "wood2"},
		-- 2nd Floor Walls
		{ "2956.1,-1549.1,17", "0,90,90", 1466, "wood2"},
		{ "2946.3,-1544.2,14.7", "0,0,0", 1469, "wood2"},
		{ "2946.1,-1554.2,14.7", "0,0,0", 1469, "wood2"},
		{ "2956.1,-1554.1,14.7", "0,0,0", 1469, "wood2"},
		{ "2951.2,-1541.7,16.8", "0,90,0", 1465, "wood2"},
		{ "2951.2,-1545.4,15.5", "90,20.705,69.295", 1329, "wood2"},
		{ "2951.2,-1545.4,17", "90,15.501,74.494", 1329, "wood2"},
		{ "2951.2,-1545.4,18.5", "90,13.259,76.73", 1329, "wood2"},
		{ "2951.2,-1547.8,18.5", "90,8.385,81.598", 1329, "wood2"},
		-- Windows
		{ "2961.2,-1554.1,12.1", "0,0,90", 1549, "carbon"},
		{ "2961.2,-1554.1,17.1", "0,0,90", 1549, "carbon"},
		{ "2961.3,-1544.1,17.1", "0,0,90", 1549, "carbon"},
		{ "2956.3,-1559.2,17.1", "0,0,0", 1549, "carbon"},
		{ "2946.3,-1559.2,17.1", "0,0,0", 1549, "carbon"},
		{ "2946.3,-1539.2,17.1", "0,0,0", 1549, "carbon"},
		{ "2941.5,-1554.1,17.1", "0,0,90", 1549, "carbon"},
		{ "2941.5,-1544.1,17.1", "0,0,90", 1549, "carbon"},
		{ "2941.5,-1554.1,12.1", "0,0,90", 1549, "carbon"},
		{ "2941.5,-1544.1,12.1", "0,0,90", 1549, "carbon"},
		{ "2946.3,-1539.2,12.1", "0,0,0", 1549, "carbon"},
		{ "2956.3,-1539.2,12.1", "0,0,0", 1549, "carbon"},
		{ "2956.3,-1539.2,17.1", "0,0,0", 1549, "carbon"},
		{ "2956.3,-1559.2,12.1", "0,0,0", 1549, "carbon"},
		{ "2946.3,-1559.2,12.1", "0,0,0", 1549, "carbon"},
		{ "2951.2,-1542.9,16.8", "0,0,90", 1549, "carbon"},
	},
}
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
--		loadAllBuildings()
	end
)

addEvent( "AURrealestate.pushObjectsToClient", true)
addEventHandler( "AURrealestate.pushObjectsToClient", root,
	function( objectString)
		if objectString ~= "" then
			buildStructure( objectString)
		end
	end
)

function getZoneCache( zone)
	if cache[zone] then
		return cache[zone]
	else
		return false
	end
end

local viewingIDS = false

addCommandHandler( "viewIDFrame",
	function()
		if viewingIDS then
			viewingIDS = false
		else
			viewingIDS = true
		end
	end
)

addEventHandler( "onClientRender", root,
	function()
		if not viewingIDS then return end
		local pX, pY, pZ = getElementPosition( localPlayer)
		local zone = getZoneCache( "zone1")
		if zone then
			for i , object in ipairs ( zone) do
				local x, y, z = getElementPosition( object)

				local sX, sY = getScreenFromWorldPosition( x, y, z)

				if sX and sY then
					dxDrawText( getObjectData( object, "zonename").." - "..getObjectData( object, "shaderTexture"), sX, sY, sX, sY)
				end
			end
		end
	end
)

dbdata = {}

function buildStructure( theString)
	local stringdata = split( theString, "@")
	local theString = stringdata[1]
	local zonename = stringdata[2]
	local objectString = split( theString, ";")
	for i, objectData in ipairs ( objectString) do
		local objectValues = split( objectData, "|")
		local posData = split( objectValues[1], ",")
		local rotData = split( objectValues[2], ",")

		local x, y, z = posData[1], posData[2], posData[3]
		local rX, rY, rZ = rotData[1], rotData[2], rotData[3]
		local materialID = tonumber( objectValues[3])
		local textureName = tostring( objectValues[4])

		if oldIDreplacer[materialID] then
			materialID = oldIDreplacer[materialID]
		else
			materialID = materialID
		end
		odata.object[i] = createObject( materialID, x, y, z, rX, rY, rZ)

		setElementFrozen( odata.object[i], true)
		setElementDoubleSided( odata.object[i], true)
		setObjectBreakable( odata.object[i], false)

		if not cache[zonename] then
			cache[zonename] = {}
		end
		table.insert( cache[zonename], odata.object[i])

		if not dbdata[zonename] then
			dbdata[zonename] = {}
		end
		table.insert( dbdata[zonename], { objectValues[1], objectValues[2], materialID, textureName})

		getZoneCache( zonename)
		setObjectData( odata.object[i], "shaderTexture", textureName)
		setObjectData( odata.object[i], "streaming", true)
		setObjectData( odata.object[i], "zonename", zonename)
		setObjectData( odata.object[i], "objectNumber", i)
		applyCustomTexture( odata.object[i], textureName)
		setTimer( checkStream, 1000, 0, odata.object[i])
	end
end

local saveString = ""

function saveStructure( zone)
	local cacheTable = getZoneCache( "zone1")
	for i, object in ipairs ( cacheTable) do
		local x, y, z = getElementPosition( object)
		local rX, rY, rZ = getElementRotation( object)

		local posData = x..","..y..","..z
		local rotData = rX..","..rY..","..rZ
		local materialID = getElementModel( object)
		local textureName = getObjectData( object, "shaderTexture")

		--"2941.4,-1549.1,12.1|0,90,0|1462|brick_wall;"
		saveString = saveString..posData.."|"..rotData.."|"..materialID.."|"..textureName..";"
	end
	saveString = ""
end
addEventHandler( "onClientResourceStop", resourceRoot, saveStructure)

--[[function loadAllBuildings()
	for zonename, zone in pairs ( zone_objects) do
		--outputChatBox( "test")
		for i, object in ipairs ( zone) do
			local posData = split(object[1], ",")
			local rotData = split(object[2], ",")
			local x, y, z = posData[1], posData[2], posData[3]
			local rX, rY, rZ = rotData[1], rotData[2], rotData[3]
			local materialID = tonumber( object[3])
			local textureName = tostring( object[4])
			--odata.lod[i] = createObject( materialID, x, y, z, rX, rY, rZ, true)
			if oldIDreplacer[materialID] then
				materialID = oldIDreplacer[materialID]
			else
				materialID = materialID
			end
			odata.object[i] = createObject( materialID, x, y, z, rX, rY, rZ)
			setElementFrozen( odata.object[i], true)
			setElementDoubleSided( odata.object[i], true)
			setObjectBreakable( odata.object[i], false)
			if not cache[zonename] then
				cache[zonename] = {}
			end
			table.insert( cache[zonename], odata.object[i])
			if not dbdata[zonename] then
				dbdata[zonename] = {}
			end
			table.insert( dbdata[zonename], { object[1], object[2], materialID, textureName})
			getZoneCache( zonename)
			setObjectData( odata.object[i], "shaderTexture", textureName)
			setObjectData( odata.object[i], "streaming", true)
			setObjectData( odata.object[i], "zonename", zonename)
			--setTimer( applyCustomTexture, 10+(i*50), 1, odata.object[i], textureName)
			applyCustomTexture( odata.object[i], textureName)
			setTimer( checkStream, 1000, 0, odata.object[i])
		end
	end
end]]--