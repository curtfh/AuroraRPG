local allowedVehicles =
{
	[499] = true,
	[609] = true,
	[498] = true,
	[455] = true,
	[414] = true,
	[422] = true,
	[482] = true,
	[413] = true,
	[440] = true,
	[543] = true,
	[478] = true,
	[554] = true,
}

local rankToAmount =
{
	[1] = 250,
	[2] = 500,
	[3] = 1000,
	[4] = 2500,
	[5] = 5000,
}

local drugs = {}
local buyer = {}
local sellingCar = {}
local pos = {}
local markers = {}
local markerKeys = {}
local shipMarker = createMarker (2415.95, -2468.92, 12.62, "cylinder", 3, 255, 0, 0)
local blip = createBlipAttachedTo(shipMarker, 17)

function getTraffickingDrugs(plr)
	return drugs[plr]
end

addEventHandler("onResourceStart", resourceRoot, function()
	for k, v in ipairs(getElementsByType("player")) do
		drugs[v] = 
			{
				["Ritalin"] = {0, 100}, 
				["LSD"] = {0, 500}, 
				["Cocaine"] = {0, 100}, 
				["Ecstasy"] = {0, 100},
				["Heroine"] = {0, 100}, 
				["Weed"] = {0,150},
			}
	end
end)

addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", root, function()
	drugs[source] = 
	{
		["Ritalin"] = {0, 100},
		["LSD"] = {0, 500},
		["Cocaine"] = {0, 100},
		["Ecstasy"] = {0, 100},
		["Heroine"] = {0, 100},
		["Weed"] = {0, 150},
	}
end)

addEventHandler("onMarkerHit", shipMarker, function(hElem, matchDim)
	if (matchDim) then
		if (hElem) and (getElementType(hElem) == "vehicle") and (allowedVehicles[getElementModel(hElem)]) then
			local driver = getVehicleOccupant(hElem, 0) 
			for k, v in pairs(drugs[driver]) do
				if (v[1] > 0) then
					return false
				end
			end
			if (getElementData(driver, "Occupation") == "Drug Trafficker") and (driver == getElementData(hElem, "vehicleOwner")) then
				exports.AURprogressbar:drawProgressBar(driver, "Loading the vehicle.", 10000, 255, 0, 0)
				setTimer(function(driver)
					local rankName, rankID = exports.CSGranks:getRank(driver, "Drug Trafficker")
					drugs[driver] = 
					{
						["Ritalin"] = {rankToAmount[rankID], 100},
						["LSD"] = {rankToAmount[rankID], 500},
						["Cocaine"] = {rankToAmount[rankID], 100},
						["Ecstasy"] = {rankToAmount[rankID], 100},
						["Heroine"] = {rankToAmount[rankID], 100},
						["Weed"] = {rankToAmount[rankID], 150},
					}
					sellingCar[driver] = getPedOccupiedVehicle(driver)
					--Take some payment in here and give the player some WL.
				end, 10000, 1, driver)
			end
		end
	end
end)

addCommandHandler("start_selling", function(plr)
	if (getElementData(plr, "Occupation") == "Drug Trafficker") then
		local veh = getPedOccupiedVehicle(plr)
		if (veh) then
			if (sellingCar[plr] == veh) then
				triggerClientEvent(plr, "AURdrug_trafficker.requestPosition", plr)
				setElementFrozen(veh, true)
				setTimer(function(plr)
					local x, y, z = unpack(pos[plr])
					print(x, y, z)
					markers[plr] = createMarker(x, y, z - 1, "cylinder", 2.5, 255, 0, 0)
					markerKeys[markers[plr]] = plr
				end, 1000, 1, plr)
			end
		end
	end
end)

addCommandHandler("stop_selling", function(plr)
	if markers[plr] then
		markerKeys[markers[plr]] = nil
		destroyElement(markers[plr])
		markers[plr] = nil
		setElementFrozen(getPedOccupiedVehicle(plr), false)
		for k, v in ipairs(getElementsByType("player")) do
			if (buyer[v] == plr) then
				triggerClientEvent(v, "AURdrug_trafficker.stopSelling", v)
			end
		end
	end
end)
	
addEventHandler("onVehicleStartExit", root, function(plr)
	if markers[plr] and isElement(markers[plr]) then
		cancelEvent()
	end
end)

addEventHandler("onMarkerHit", root, function(hElem, mDim)
	if (mDim) and isElement(hElem) and markerKeys[source] then
		if (getElementType(hElem) ~= "player") then
			return false 
		end
		if (isPedInVehicle(hElem)) then
			return false
		end
		buyer[hElem] = markerKeys[source]
		triggerClientEvent(hElem, "AURdrug_trafficker.startSelling", hElem, drugs[markerKeys[source]])
	end
end)

addEvent("AURdrug_trafficker.buyDrugs", true)
addEventHandler("AURdrug_trafficker.buyDrugs", root, function(boughtDrugs)
	for k, v in pairs(boughtDrugs) do
		if not (tonumber(drugs[buyer[client]][k][2] * v)) then return exports.NGCdxmsg.createNewDxMessage(client,"You inserted an invalid amount of Drugs!",255,0,0) end
		if (getPlayerMoney(client) < drugs[buyer[client]][k][2] * v) then return false end
		takePlayerMoney(client, drugs[buyer[client]][k][2] * v)
		givePlayerMoney(buyer[client], drugs[buyer[client]][k][2] * v)
		drugs[buyer[client]][k][1] = drugs[buyer[client]][k][1] - v
		exports.CSGdrugs:giveDrug(client, k, v)
		exports.CSGranks:addStat(buyer[client],v)
	end
end)	

addEvent("AURdrug_trafficker.receivePosition", true)
addEventHandler("AURdrug_trafficker.receivePosition", root, function(x, y, z)
	pos[client] = {x, y, z}
end)				

addEvent("AURdrug_trafficker.sendDrugs", true)
addEventHandler("AURdrug_trafficker.sendDrugs", root, function()
	triggerClientEvent(client, "AURdrug_trafficker.requestDrugs", client, drugs[client])
end)

addEvent("AURdrug_trafficker.requestClientDrugs", true)
addEventHandler("AURdrug_trafficker.requestClientDrugs", root, function(data)
	drugs[client] = data
end)