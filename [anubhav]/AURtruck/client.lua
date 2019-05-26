local screenX, screenY = guiGetScreenSize()
truckMissionActive = false
gps = false

missionData = {}

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(angle - 90)
    local dx = math.cos(a) * dist
    local dy = math.sin(a) * dist
    return x + dx, y + dy
end

function centerWindow(center_window)
    local screenW, screenH = screenX, screenY
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW-windowW)/2, (screenH - windowH) / 2
    guiSetPosition(center_window, x, y, false)
end

missionType = {
	["license"] = {
		["Explosives"] = 1.5,
		["Gasoline"] = 1.5,
		["Weapons"] = 1.5,
		["Drugs"] = 1.5,
	},
	["normal"] = {
		["Fruits and Vegetables"] = 1,
		["Furniture"] = 1,
		["Beverages"] = 1,
		["Canned Fish"] = 1,
		["Meat"] = 1,
		["Glass"] = 1,
	}
}

missions = {
	{76.698150634766, -244.18774414063, 1.5, ""},
	{1348.78, 355.87, 19.69, " - BIO-Engineering"},
	{2461.66, -2110.8, 13.54, " - Oil Plant"},
	{2183.56,-2274.58,13.5, " - Train Station"},
	{2757.73, -2394.69, 13.63, " - Docks"},
	{-1534.42, -2748.16, 48.53, " - Gas Station"},
	{-2109.35, -93.63, 35.32, ""},
	{-334.22, 1522.82, 75.35, ""},
	{-479.57, -504.42, 25.51, ""},
	{-1048.74, -655.38, 32, ""},
	{688, 1844.42, 5.5, ""},
	{-1666.1528320313,17.288341522217,3.5546875, " - Docks"},
	{-2100.42, -2255.42, 30.62, "" },
	{-74.57, -1129.11, 1.07, " - RS Haul"},
	{1018.1, -333.53, 73.99, " - Farm"},
	{-1843.15, 135.49, 15.11, " - Solarin Factory"},
	{0, 20, 4, " - Farm"},
	{2100.55, -2218.26, 13.54, " - Airport"},
	{-110.71, 1117.29, 19.74, ""},
	{-531.12, 2622.91, 53.41, ""},
	{-743.63, 2740.09, 47.7, "" },
	{-1116.82, -1660.43, 76.36, " - Farm"},
	{-2198.19, -2435.08, 30.62, ""},
	{-265.66, -2166.94, 28.86, "" },
	{382.7, -1861.36, 7.83, "" },
	{1775.6, -2049.4, 13.56, "" },
	{1780.85, -1928.19, 13.38, ""},
	{2393.54, -1474.36, 23.81, ""},
	{2412.35, -2470.56, 13.62, ""},
	{2317.81, -74.56, 26.48, ""},
	{1694.32, 693.18, 10.82, ""},
	{2634.6, 1075.75, 10.82, " - Gas Station"},
	{1618, 1623, 10.82, " - Airport"},
	{2050.45, 2238.89, 10.82, ""}
}

truckIDs = {
	515,
	514,
	403
}

truckerLicense = false

function playerHasTruck()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (not vehicle) then
		return false
	end
	if (getElementData(vehicle, "vehicleTeam") ~= "Civilian Workers" and getElementData(vehicle, "vehicleOccupation") ~= "Trucker" and not truckerLicense) then
		return false
	end
	local model = getElementModel(vehicle)
	if (model ~= 515 and model ~= 514 and model ~= 403) then
		return false
	end
	return true
end

function onElementDataChange(dataName, oldValue)
	if (dataName == "Occupation" and getElementData(localPlayer, dataName) == "Trucker") then
		initTruckerJob()
	elseif (dataName == "Occupation") then
		stopTruckerJob()
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onElementDataChange, false)

function onTruckerTeamChange ( oldTeam, newTeam )
	if (getElementData(localPlayer, "Occupation") == "Trucker" and source == localPlayer) then
		setTimer(
			function()
				if (not getPlayerTeam(localPlayer)) then
					return false
				end
				local newTeam = getTeamName(getPlayerTeam(localPlayer))
				if (newTeam == "Unoccupied") then
					stopTruckerJob()
				elseif (getElementData(localPlayer, "Occupation") == "Trucker" and newTeam == "Civilian Workers") then
					initTruckerJob()
				end
			end
		, 200, 1 )
	end
end
addEvent("onClientPlayerTeamChange", true)
addEventHandler("onClientPlayerTeamChange", localPlayer, onTruckerTeamChange, false)

function onResourceStart()
	setTimer(
		function()
			if (not getPlayerTeam(localPlayer)) then
				return false
			end
			local teamN = getTeamName(getPlayerTeam(localPlayer))
			if (getElementData(localPlayer, "Occupation") == "Trucker" and teamN == "Civilian Workers") then
				initTruckerJob()
			end
		end
	, 2500, 1 )
	if (type(getElementData(localPlayer, "trucking_stopsDone")) ~= "number") then
		setElementData (localPlayer, "trucking_stopsDone", 0)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)

function initTruckerJob()
	if (isTrucker) then
		return false 
	end
	for i = 1, #missions do
		missions[i][6] = createMarker(missions[i][1], missions[i][2], missions[i][3] - 1, "cylinder", 3, 75, 120, 40)
		addEventHandler("onClientMarkerHit", missions[i][6], startTruckerMissions, false)
		isTrucker = true
	end
end

function stopTruckerJob()
	if (not isTrucker) then
		return false
	end
	stopTruckerMission()
	for i = 1, #missions do
		if (isElement(missions[i][6])) then
			removeEventHandler("onClientMarkerHit", missions[i][6], startTruckerMissions, false)
			destroyElement(missions[i][6])
		end
	end
	isTrucker = false
	exports.CSGranks:closePanel()
end

function randomMissionType(mType)
	local missionTable = {}
	for i, v in pairs(missionType[mType]) do
		table.insert(missionTable, i)
	end
	local mission = missionTable[math.random(#missionTable)]
	return missionType[mType][mission], mission 
end

function calculateDestinationPrice(playerX, playerY, playerZ, targetX, targetY, targetZ, multiplier)
	local startPrice = 1000
	local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, targetX, targetY, targetZ)
	if (distance > 2500) then
		startPrice = 2500
	end
	local distancePrice = math.floor((math.floor((distance / 1.5) / 10) * 130) * multiplier)
	return startPrice + distancePrice
end

function fillDestinationGrid(element)
	missionData = {}
	destroyElement(truckGrid)
	truckGrid = guiCreateGridList(9, 24, 445, 294, false, truckWindow)
	nameColumn = guiGridListAddColumn(truckGrid, "Destination", 0.55)
	rewardColumn = guiGridListAddColumn(truckGrid, "Reward", 0.35)
	guiGridListSetSelectionMode(truckGrid, 0)
	guiGridListClear(truckGrid)
	local px, py, pz = getElementPosition(element)
	for i = 1, #missions do
		local distance = getDistanceBetweenPoints3D(px, py, pz, missions[i][1], missions[i][2], missions[i][3])
		if (distance >= 300) then
			local row = guiGridListAddRow(truckGrid)
			local zoneName = getZoneName(missions[i][1], missions[i][2], missions[i][3], true)
			guiGridListSetItemText(truckGrid, row, 1, zoneName..tostring(missions[i][4]), false, false)
			local multiplier, mission = randomMissionType("normal")
			if (math.random(1, 3) == 3 and truckerLicense) then
				outputDebugString("yes")
				multiplier, mission = randomMissionType("license")
				guiGridListSetItemColor(truckGrid, row, 1, 255, 255, 0)
			end
			local price = calculateDestinationPrice(px, py, pz, missions[i][1], missions[i][2], missions[i][3], multiplier)
			if (zoneName == "Las Venturas" and multiplier == 1) then
				exports.NGCdxmsg:createNewDxMessage("LV Zone check", 255, 0, 0)
				price = tonumber(price) + 1500
				guiGridListSetItemColor(truckGrid, row, 1, 225, 0, 0)
			end
			guiGridListSetItemText(truckGrid, row, 2, tostring(price).."$", false, true)
			missions[i][5] = price
			guiGridListSetItemData(truckGrid, row, 1, row)
			guiGridListSetItemData(truckGrid, row, 2, row)
			missionData[row] = missions[i]
			missions[i].dist = distance
		end
	end
end


function startTruckerMissions(hitElement)
	if (hitElement ~= localPlayer or getElementData(hitElement, "Occupation") ~= "Trucker") then 
		return false 
	end
	if (getPedOccupiedVehicle(hitElement) and getVehicleController(getPedOccupiedVehicle(hitElement)) == hitElement or truckMissionActive) then
		if (playerHasTruck()) then
			createTruckerGUI(source)
			setElementVelocity(getPedOccupiedVehicle(hitElement), 0, 0, 0)
			setElementFrozen(getPedOccupiedVehicle(hitElement), true)
			lastMarkerHit = source
			sourceMarker = source
		else
			exports.NGCdxmsg:createNewDxMessage("You need to spawn truck from near job spawner, you must work with our company trucks!", 255, 0, 0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage("You need to be the driver of a truck!", 255, 0, 0)
	end
end

function createTruckerGUI(marker)
	if (truckWindow) then
		if (not guiGetVisible(truckWindow)) then
			guiSetVisible(truckWindow, true)
			showCursor(true)
		end
		return true
	end
	truckWindow = guiCreateWindow(529, 290, 463, 360, "AUR ~ Trucker Locations", false)
	centerWindow(truckWindow)
	truckGrid = guiCreateGridList(9, 24, 445, 294, false, truckWindow)
	nameColumn = guiGridListAddColumn(truckGrid, "Destination", 0.55)
	rewardColumn = guiGridListAddColumn(truckGrid, "Reward", 0.35)
	guiGridListSetSelectionMode(truckGrid, 0)
	local toggleText = "Choose location"
	if (truckMissionActive) then
		toggleText = "Stop"
		guiSetEnabled(truckGrid, false)
	end
	truckButton_toggle = guiCreateButton(9, 323, 217, 26, toggleText, false, truckWindow)
	truckButton_cancel = guiCreateButton(228, 323, 225, 26, "Close window", false, truckWindow)
	addEventHandler("onClientGUIClick", truckButton_toggle, onTruckerGUIClick, false)
	addEventHandler("onClientGUIClick", truckButton_cancel, onTruckerGUIClick, false)
	if (not truckMissionActive) then
		fillDestinationGrid(marker)
	end
	showCursor(true)
end

function closeTruckerGUI()
	guiSetVisible(truckWindow, false)
	if (not guiGetVisible(truckWindow)) then -- and not guiGetVisible(truckerInfo_window)) then
		showCursor(false)
	end
	setElementFrozen(getPedOccupiedVehicle(localPlayer), false)
end

function onTruckerGUIClick(btn)
	if (btn ~= "left") then
		return false
	end
	if (source == truckButton_toggle) then
		if (truckMissionActive) then
			exports.NGCdxmsg:createNewDxMessage("Truck Mission Canceled!", 255, 0, 0)
		else
			local veh = getPedOccupiedVehicle(localPlayer)
			local x, y, z = getElementPosition(veh)
			local rx, ry, rz = getElementRotation(veh)
			local endX, endY = getPointFromDistanceRotation(x, y, 13, rz)
			if (not isLineOfSightClear(x, y, z - 1, endX, endY, z - 1, true, true, true, true, true, false, false, veh)) then
				exports.NGCdxmsg:createNewDxMessage("There is no room for a trailer!", 255, 0, 0)
				return false
			end
		end
		toggleTruckerMission()
	elseif (source == truckButton_cancel) then
		closeTruckerGUI()
	end
end

function toggleTruckerMission(success)
	if (not truckMissionActive) then
		if (guiGridListGetSelectedItem(truckGrid)) then
			local row, column = guiGridListGetSelectedItem(truckGrid)
			local missionSelected = missionData[guiGridListGetItemData(truckGrid, row, 1)] or missionData[row]
			if (missionSelected) then
				truckMissionActive = missionSelected
				guiSetText(truckButton_toggle, "Stop")
				guiSetEnabled(truckGrid, false)
				targetBlip = createBlipAttachedTo(missionSelected[6], 51)
				if (gps) then
					exports.csggps:setDestination(missionSelected[1], missionSelected[2], missionSelected[3], missionSelected[4])
				end
				playerTruck = getPedOccupiedVehicle(localPlayer)
				addEventHandler("onClientMarkerHit", missionSelected[6], truckerDestinationHit, false)
				addEventHandler("onClientVehicleExit", playerTruck, onExitVehicle, false)
				addEventHandler("onClientVehicleEnter", playerTruck, onEnterVehicle, false)
				addEventHandler("onClientVehicleExplode", playerTruck, onExplodeVehicle, false)
				addEventHandler("onClientPlayerWasted", localPlayer, onDeath, false)
				removeEventHandler("onClientMarkerHit", missionSelected[6], startTruckerMissions, false)
				triggerServerEvent("trucking_CreatePlayerTrailer", resourceRoot)
				closeTruckerGUI()
				local zoneName = getZoneName(missionSelected[1], missionSelected[2], missionSelected[3], true)
				local oldX,oldY,oldZ = getElementPosition(sourceMarker)
				local oldZoneName = getZoneName(oldX, oldY, oldZ, true)
				exports.NGCdxmsg:createNewDxMessage("Truck Mission started, drive to: "..tostring(zoneName)..tostring(missionSelected[4]), 0, 255, 0)
				missionData = {}
				guiGridListClear(truckGrid)
				if (isElement(truckerInfo_stopMission)) then 
					guiSetEnabled(truckerInfo_stopMission, true) 
				end
			else
				exports.NGCdxmsg:createNewDxMessage("You must select a mission!", 255, 0, 0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("You must select a mission!", 255, 0, 0)
		end
		return false
	end
	if (isElement(targetBlip)) then 
		destroyElement(targetBlip) 
	end
	-- remove event handlers for exit, death, trailer stop, vehicle explode, quit. etc.
	local targetMarker = truckMissionActive[6]
	guiSetText(truckButton_toggle, "Choose location")
	guiSetEnabled(truckGrid, true)
	addEventHandler("onClientMarkerHit", targetMarker, startTruckerMissions, false)
	removeEventHandler("onClientMarkerHit", targetMarker, truckerDestinationHit, false)
	if (playerTruck and isElement(playerTruck)) then
		removeEventHandler("onClientVehicleExit", playerTruck, onExitVehicle, false)
		removeEventHandler("onClientVehicleEnter", playerTruck, onEnterVehicle, false)
		removeEventHandler("onClientVehicleExplode", playerTruck, onExplodeVehicle, false)
		removeEventHandler("onClientTrailerDetach", playerTrailer, onDetachTrailer, false)
		removeEventHandler("onClientTrailerAttach", playerTrailer, onAttachTrailer, false)
	end
	removeEventHandler("onClientPlayerWasted", localPlayer, onDeath, false)
	if (isElement(truckerInfo_stopMission)) then 
		guiSetEnabled(truckerInfo_stopMission, false) 
	end
	if (gps) then
		exports.csggps:resetDestination()
	end
	if (exitVehicleStopTimer) then
		killTimer(exitVehicleStopTimer)
		exitVehicleStopTimer = nil
		removeEventHandler("onClientRender", root, drawTimeLeftOnExit)
	end
	triggerServerEvent("trucking_DestroyTrailer", resourceRoot, playerTrailer)
	playerTruck = nil
	playerTrailer = nil
	truckMissionActive = false
	fillDestinationGrid(sourceMarker)
end

function truckerDestinationHit ( hitElement )
	if(hitElement == localPlayer and getPedOccupiedVehicle(hitElement) and getVehicleController(getPedOccupiedVehicle(hitElement)) == hitElement) or ((hitElement == playerTruck or hitElement == playerTrailer) and getVehicleController(hitElement) == localPlayer) then
		if (truckMissionActive and getVehicleTowedByVehicle(playerTruck) == playerTrailer) then
			lastMarkerHit = source
			sourceMarker = source
			setElementVelocity(playerTruck, 0, 0, 0)
			setElementVelocity(playerTrailer, 0, 0, 0)
			setElementFrozen(playerTruck, true)
			fadeCamera(false, 1.0, 0, 0, 0)
			local price = truckMissionActive[5]
			triggerServerEvent("trucking_GiveReward", resourceRoot, price, truckMissionActive.dist)
			setTimer(toggleTruckerMission, 1500, 1)
			setTimer(fadeCamera, 2000, 1, true, 1.0, 0, 0, 0)
			setTimer(setElementFrozen, 2000, 1, playerTruck, false)
			setTimer(createTruckerGUI, 1600, 1, source)
			local oldStops = getElementData(localPlayer, "trucking_stopsDone")
			setElementData(localPlayer, "trucking_stopsDone", oldStops + 1)
		end
	end
end

-- event

function onDeath()
	stopTruckerMission("You died, mission failed!")
end

function onEnterVehicle(thePlayer)
	if (thePlayer ~= localPlayer) then
		return false
	end
	if (exitVehicleStopTimer) then
		killTimer(exitVehicleStopTimer)
		exitVehicleStopTimer = nil
		removeEventHandler("onClientRender", root, drawTimeLeftOnExit)
	end
end

function drawTimeLeftOnExit()
	if (not isTimer(exitVehicleStopTimer) or not truckMissionActive) then
		removeEventHandler("onClientRender", root, drawTimeLeftOnExit)
		return false
	end
	local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails(exitVehicleStopTimer)
	local timeLeft = math.floor(timeLeft / 1000)
	if (timeLeft <= 0) then
		removeEventHandler("onClientRender", root, drawTimeLeftOnExit)
		return true
	end
	dxDrawText("Time left to get in vehicle: "..tostring(timeLeft).." seconds!", 0, screenY * 0.85, screenX, screenY, tocolor(255, 0, 0), 1.5, "default", "center", "center")
end


function drawTimeLeftOnDetach()

	if detachTrailerStopTimer and truckMissionActive then

		local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( detachTrailerStopTimer )
		local timeLeft = math.floor(timeLeft / 1000)
		if timeLeft > 0 then

			dxDrawText ( "Time left to reattach trailer: "..tostring(timeLeft).." seconds!", 0, screenY*0.7, screenX, screenY*0.85, tocolor(255,0,0), 1.5, "default", "center", "center" )

		end

	else
		removeEventHandler ( "onClientRender", root, drawTimeLeftOnDetach )
	end
end

function onExitVehicle(thePlayer)
	if (thePlayer ~= localPlayer) then
		return false
	end
	if (exitVehicleStopTimer) then 
		killTimer(exitVehicleStopTimer) 
	end
	exitVehicleStopTimer = setTimer(stopTruckerMission, 60000, 1, "You didn't get back in on time, mission failed!")
	addEventHandler("onClientRender", root, drawTimeLeftOnExit)
end

function onExplodeVehicle()
	stopTruckerMission()
	exports.NGCdxmsg:createNewDxMessage("Your truck exploded, mission failed!", 255, 0, 0)
end

function onDetachTrailer(tower)
	if (tower ~= playerTruck) then
		return false
	end
	if (detachTrailerStopTimer) then 
		killTimer(detachTrailerStopTimer) 
	end
	detachTrailerStopTimer = setTimer(stopTruckerMission, 60000, 1, "You lost your trailer, mission failed!")
	addEventHandler("onClientRender", root, drawTimeLeftOnDetach)
end

function onAttachTrailer(tower)
	if (tower ~= playerTruck) then
		return false
	end
	if (detachTrailerStopTimer) then 
		killTimer(detachTrailerStopTimer) 
		detachTrailerStopTimer = nil 
	end
end

function stopTruckerMission(msg)
	detachTrailerStopTimer = nil
	exitVehicleStopTimer = nil
	if (not truckMissionActive) then
		return false
	end
	toggleTruckerMission()
	if (msg) then
		exports.NGCdxmsg:createNewDxMessage(msg, 255, 0, 0)
	end
end

function trailerAttached()
	playerTrailer = source
	addEventHandler("onClientTrailerDetach", playerTrailer, onDetachTrailer, false)
	addEventHandler("onClientTrailerAttach", playerTrailer, onAttachTrailer, false)
	for i = 1, 5 do
		attachTrailerToVehicle(playerTruck, playerTrailer)
	end
	setTimer(attachTrailerToVehicle, 300, 1, playerTruck, playerTrailer)
end
addEvent("trailerAttached", true)
addEventHandler("trailerAttached", root, trailerAttached)

function togglePilotPanel()
	if (getElementData(localPlayer,"Occupation") == "Trucker" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5", "down", togglePilotPanel)


