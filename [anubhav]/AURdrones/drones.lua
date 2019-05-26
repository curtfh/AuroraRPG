local drones = {}

function moveDrone()
	local count = 0
	for i, v in pairs(drones) do
		if (isElement(v[1])) then
			if (v[5]) then
				count = count + 1
				local x, y, z = v[2], v[3], v[4]
				local cX, cY, cZ = getElementPosition(v[1])
				local cX = cX + 0.25
				if (x - cX < 75 and not v[6] and isElementFrozen(i)) then
					if (v[7] <= 0.19) then
						drones[i][7] = drones[i][7] + 0.01
					end
					cX = cX - v[7]
				end
				if (v[6]) then
					if (v[7] <= 0.19) then
						drones[i][7] = drones[i][7] + 0.01
					end
					cX = cX + v[7]
				end
				setElementPosition(v[1], cX, cY, cZ)
				if (x - cX <= 0 and not v[6] and not isElementFrozen(i)) then
					droneMovedIn(i)
				end
			end
		else
			drones[i] = nil
		end
	end
	if (count == 0) then
		removeEventHandler("onClientRender", root, moveDrone)
	end
end

function callInDrone()
	if (drones[source] and drones[source][6]) then
		if (localPlayer == source) then
			outputChatBox("The drone is busy.")
		end
		return false
	end
	callOffDrone()
	local x, y, z = getElementPosition(source)
	local veh = createVehicle(593, x - 300, y, z + 50)
	setElementRotation(veh, 0, 0, 270)
	setElementFrozen(veh, true)
	drones[source] = {veh, x, y, z, true, false, 0.01, createBlipAttachedTo(veh, 3)}
	local teamN = getTeamName(getPlayerTeam(source))
	local teamNlocal = getTeamName(getPlayerTeam(localPlayer))
	if (teamN == "Criminals") then
		if (teamNlocal == "Criminals") then
			playSound("sounds/uavcrim.mp3")
		elseif (teamNlocal == "Government") then
			playSound("sounds/uavspotlaw.mp3")
		end
	elseif (teamN == "Government") then
		if (teamNlocal == "Criminals") then
			playSound("sounds/uavspotcrim.mp3")
		elseif (teamNlocal == "Government") then
			playSound("sounds/uavlaw.mp3")
		end
	end
	if (localPlayer == source) then
		outputChatBox("Drone created")
	end
	removeEventHandler("onClientRender", root, moveDrone)
	addEventHandler("onClientRender", root, moveDrone)
end
addEvent("AURdrones.callDrone", true)
addEventHandler("AURdrones.callDrone", root, callInDrone)

function droneMovedIn(plr)
	if (localPlayer ~= plr) then
		return false
	end
	local drone = drones[plr][1]
	local x, y, z = getElementPosition(drone)
	setCameraMatrix(x, y, z, x, y, z - 150)
	setElementFrozen(plr, true)
	outputChatBox("Drone view activated. Do /calloffdrone to stop.")
	setFreecamEnabled()
end

function removeDroneOnQuit()
	if (not drones[source]) then
		return false
	end
	destroyElement(drones[source][1])
	destroyElement(drones[source][8])
	drones[source] = nil
end
addEventHandler("onClientPlayerQuit", root, removeDroneOnQuit)

function missilesLaunched()
	if (not drones[source]) then
		return false
	end
	drones[source][7] = 0.1
	drones[source][6] = true
	setTimer(
		function(source)
			if (not isElement(source)) then
				return false
			end
			if (not drones[source]) then
				return false
			end
			destroyElement(drones[source][1])
			destroyElement(drones[source][8])
			drones[source] = nil
		end
	, 10000, 1, source)
	if (source ~= localPlayer) then
		return false
	end
	setElementFrozen(source, false)
	setCameraTarget(source, source)
end
addEvent("AURdrones.missilesLaunched", true)
addEventHandler("AURdrones.missilesLaunched", root, missilesLaunched)

function callOffDrone()
	if (not drones[source]) then
		return false
	end
	destroyElement(drones[source][1])
	destroyElement(drones[source][8])
	drones[source] = nil
	if (localPlayer == source) then
		setElementFrozen(source, false)
		setCameraTarget(source, source)
		setFreecamDisabled()
		outputChatBox("Drone deleted")
	end
end
addEvent("AURdrones.callOffDrone", true)
addEventHandler("AURdrones.callOffDrone", root, callOffDrone)

function fireMissiles(x, y, z)
	setTimer(callOffDroneOnStop, 10000, 1)
	triggerServerEvent("AURdrones.requestFireMissiles", resourceRoot, x, y, z)
end

function callOffDroneOnStop()
	if (drones[localPlayer]) then
		setElementFrozen(localPlayer, false)
		destroyElement(drones[localPlayer][1])
		destroyElement(drones[localPlayer][8])
		drones[localPlayer] = nil
		setFreecamDisabled()
		setCameraTarget(localPlayer, localPlayer)
	end
end
addEventHandler("onClientResourceStop", resourceRoot, callOffDroneOnStop)