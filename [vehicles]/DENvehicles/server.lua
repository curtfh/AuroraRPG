local vehicles = {} -- Vehicle table

-- Spawn the vehicle
function spawnVehicle (x, y, z, vehicle, color1, color2, color3, color4, rotation,r,g,b,r2,b2,g2)
	if getElementData(source,"isPlayerGlued",true) then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't spawn a vehicle while gluing",255,0,0)
		return false
	end
	if exports.NGCduel:isPlayerDueling(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't spawn a vehicle while you're in duel!",255,0,0)
		return false
	end
    if isElement(vehicles[source]) then destroyElement(vehicles[source]) end
	if getElementData(source,"skill") == "The Tank" then
		vehicles[source] = createVehicle (tonumber(vehicle), x, y, z+3, 0, 0, rotation,"Re-Infor")
	else
		vehicles[source] = createVehicle (tonumber(vehicle), x, y, z+3, 0, 0, rotation)
	end
	setElementData(vehicles[source], "vehicleOwner", source)
	setElementData(vehicles[source], "theFreeVehicleType", "freeVehicle")
	newShaderVeh(vehicles[source],source)
	if ( tonumber( vehicle) == 481 ) or ( tonumber( vehicle) == 510 ) or ( tonumber( vehicle) == 509 ) or ( tonumber( vehicle) == 462 ) then
		setElementData(vehicles[source], "isVehicleBikeVehicle", true)
	else
		setElementData(vehicles[source], "vehicleTeam", getTeamName(getPlayerTeam ( source )))
		setElementData(vehicles[source], "vehicleOccupation", getElementData(source, "Occupation"))
		setElementData(vehicles[source], "isVehicleBikeVehicle", false)
	end
	if (r) then
		if r ~= nil and r2 ~= nil then
			setVehicleColor(vehicles[source],r,g,b,r2,g2,b2)
		elseif r~= nil then
			setVehicleColor(vehicles[source],r,g,b)
		else
			setVehicleColor(vehicles[source], color1, color2, color3, color4 )
		end
	else
		setVehicleColor(vehicles[source], color1, color2, color3, color4 )
	end
	local veh = vehicles[source]
    warpPedIntoVehicle(source,vehicles[source])
	setTimer(function() fixVehicle(veh) end,1000,1)
end
addEvent("spawnVehicleSystem", true)
addEventHandler("spawnVehicleSystem", root, spawnVehicle )

-- Remove when player quit
addEventHandler("onPlayerQuit",root,
function()
    if isElement(vehicles[source]) then
        destroyElement(vehicles[source])
        vehicles[source] = nil
    end
end)

-- Remove when player end shift
addEventHandler("onEndShift",root,
function()
    if isElement(vehicles[source]) then
        destroyElement(vehicles[source])
        vehicles[source] = nil
    end
end)

-- Remove when vehicle exploded
function deleteFreeVehicleWhenExploded()
local explodedVehicleType = getElementData(source, "theFreeVehicleType")
local vehicleOwner = getElementData(source, "vehicleOwner")
	if explodedVehicleType == "freeVehicle" then
		local theVehicle = vehicles[vehicleOwner]
		vehicles[vehicleOwner] = nil
		setTimer ( function () if isElement(theVehicle) then destroyElement(theVehicle) end end, 5000, 1 )
	end
end
addEventHandler("onVehicleExplode", getRootElement(), deleteFreeVehicleWhenExploded)

-- Remove when player died
function deleteFreeVehicleWhenPlayerDied()
if isElement(vehicles[source]) then
	local explodedVehicleType = getElementData(vehicles[source], "theFreeVehicleType")
	local vehicleOwner = getElementData(vehicles[source], "vehicleOwner")
		if explodedVehicleType == "freeVehicle" then
			local theVehicle = vehicles[vehicleOwner]
			vehicles[vehicleOwner] = nil
			setTimer ( function () if isElement(theVehicle) then destroyElement(theVehicle) end end, 5000, 1 )
		end
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), deleteFreeVehicleWhenPlayerDied )

-- Exported Function to reload the vehicle markers
function reloadFreeVehicleMarkers (thePlayer, deleteVehicle)
local thePlayer = thePlayer or source
	if isElement(thePlayer) then
		if deleteVehicle then
			if isElement(vehicles[thePlayer]) then
				destroyElement(vehicles[thePlayer])
				vehicles[thePlayer] = nil
				triggerClientEvent(thePlayer, "reloadFreeVehicleMarkers", thePlayer)
			else
				triggerClientEvent(thePlayer, "reloadFreeVehicleMarkers", thePlayer)
			end
		else
			triggerClientEvent(thePlayer, "reloadFreeVehicleMarkers", thePlayer)
		end
	end
end

function reloadMarkers ()
reloadFreeVehicleMarkers(source, false)
--setPedArmor(source, 0)
end
addEventHandler("onElementModelChange", root, reloadMarkers)

-- Lock vehicle
function isPlayerInRangeOfPoint(vehicleX, vehicleY, playerX, playerY)
	return getDistanceBetweenPoints2D ( vehicleX, vehicleY, playerX, playerY )
end



vehShaderTable = {}
--shader stuff

local validShaderIDS = { 596,597,598 }

function isShaderVeh(veh)
	local m = getElementModel(veh)
	for k,v in pairs(validShaderIDS) do if v == m then return true end end
	return false
end

addEventHandler ( "onVehicleExplode", getRootElement(),
function()
    for k,v in pairs(vehShaderTable) do
			if v[1] == source then
				table.remove(vehShaderTable,k)
				break
			end
	end
end )

addEventHandler ( "onVehicleRespawn", getRootElement(),
function()
    for k,v in pairs(vehShaderTable) do
			if v[1] == source then
				table.remove(vehShaderTable,k)
				break
			end
	end
end )

addEventHandler("onElementDestroy", getRootElement(),
function ()
    if getElementType(source) == "vehicle" then
        for k,v in pairs(vehShaderTable) do
			if v[1] == source then
				table.remove(vehShaderTable,k)
				break
			end
		end
    end
end)

function newShaderVeh(veh,p)
	if isShaderVeh(veh) == false then return end
	local teamName = getTeamName(getPlayerTeam(p))
	local v = ""
	if teamName == "Government" then
		v="fbi"
	end
	if v == "" then return end
	local t = {}
	table.insert(t,{veh,v})
	table.insert(vehShaderTable,{veh,v})
end

--Destroy vehicle
function DestroyJobVehicle (thePlayer, destroyvehicle)
	if not isPedInVehicle(thePlayer) then
		if isElement(vehicles[thePlayer]) then
			destroyElement(vehicles[thePlayer])
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "Your vehicle has been destroyed!", 0, 200, 0)
		else
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "You don't have a vehicle to destroy!", 255, 0, 0)
		end
    end
end
addCommandHandler( "dveh", DestroyJobVehicle )
addCommandHandler( "Dveh", DestroyJobVehicle )
