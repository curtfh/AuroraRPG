function switchLights(thePlayer)
  	if (isPedInVehicle(thePlayer)) then
		local veh = getPedOccupiedVehicle (thePlayer)
		if (getVehicleOverrideLights(veh) ~= 2) then
			setVehicleOverrideLights(veh, 2)
			exports.NGCdxmsg:createNewDxMessage ("Vehicle lights turned on.", thePlayer, 255, 0, 0)
		elseif (getVehicleOverrideLights(veh) ~= 1) then
			setVehicleOverrideLights(veh, 1)
			exports.NGCdxmsg:createNewDxMessage ("Vehicle lights turned off.", thePlayer, 255, 0, 0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage ("You aren't in a vehicle!", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("lights", switchLights)

function breakDownVeh(veh)
	setVehicleEngineState(veh, false)
	setElementHealth(veh, 255)
end
addEvent("AURvehiclemisc.breakDownVeh", true)
addEventHandler("AURvehiclemisc.breakDownVeh", resourceRoot, breakDownVeh)

-- Table with vehicles that are not lockable with MTA functions
local notLockableVehicles = {
	[594] = true, [606] = true, [607] = true, [611] = true, [584] = true, [608] = true,
	[435] = true, [450] = true, [591] = true, [539] = true, [441] = true, [464] = true,
	[501] = true, [465] = true, [564] = true, [472] = true, [473] = true, [493] = true,
	[595] = true, [484] = true, [430] = true, [453] = true, [452] = true, [446] = true,
	[454] = true, [581] = true, [509] = true, [481] = true, [462] = true, [521] = true,
	[463] = true, [510] = true, [522] = true, [461] = true, [448] = true, [468] = true,
	[586] = true, [425] = true, [523] = true,
}

function isVehicleAV(md)
	if tonumber(md) == 520 then
		return true
	--elseif tonumber(md) == 476 then Disabled because Rustler is buyable from vehicles.
		--return true
	elseif tonumber(md) == 447 then
		return true
	elseif tonumber(md) == 432 then
		return true
	elseif tonumber(md) == 425 then
		return true
	end
	return false
end

-- On enter

function handleAVEnter(source, thePlayer, seat, jacked)
	if (seat ~= 0) then
		return false
	end
	if (not isVehicleAV(getElementModel(source))) then
		return false
	end
	if (getElementData(source, "theFreeVehicleType") ~= "freeVehicle") then
		return false
	end
	if (getElementDimension(source) ~= 0) then
		return false
	end
	local plrID = exports.server:getPlayerAccountName(thePlayer)
	local groupID = getElementData(thePlayer, "Group ID")
	if (not groupID) then
		return false
	end
	local spawnData = exports.DENmysql:querySingle("SELECT * FROM samer_groupAvs WHERE groupID=? AND memberAcc=?", groupID, playerID)
	if (not spawnData.hydra) then
		spawnData.hydra = 0
	end
	if (not spawnData.rustler) then
		spawnData.rustler = 0
	end
	if (not spawnData.hunter) then
		spawnData.hunter = 0
	end
	if (not spawnData.rhino) then
		spawnData.rhino = 0
	end
	if (not spawnData.seasparrow) then
		spawnData.seasparrow = 0
	end
	local m = getElementModel(source)
	local canEnterAV = true
	if (m == 520 and spawnData.hydra == 0) then
		canEnterAV = false 
	--elseif (m == 476 and spawnData.rustler == 0) then
		--canEnterAV = false
	elseif (m == 447 and spawnData.seasparrow == 0) then
		canEnterAV = false
	elseif (m == 432 and spawnData.rhino == 0) then
		canEnterAV = false
	elseif (m == 425 and spawnData.hunter == 0) then
		canEnterAV = false
	end
	if (not canEnterAV) then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You do not have access to enter this armed vehicle ("..getVehicleNameFromModel(m)..")", 255, 0, 0)
	end
	return canEnterAV
end

-- Handle entering vehicles in general
function handleVehiclesEntrance(thePlayer, seat, jacked)
	if (seat == 0) then
		if (isVehicleAV(getElementModel(source))) then
			local isAllowed = handleAVEnter(source, thePlayer, seat, jacked)
			if (not isAllowed) then
				cancelEvent()
				return false
			end
		end
		if (getElementData(source, "isVehicleBikeVehicle") and getPlayerWantedLevel(thePlayer) > 1) then
			cancelEvent()
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle", 0, 200, 0)
			return false
		end
		if (getElementData(source, "theFreeVehicleType") ~= "freeVehicle") then
			return false
		end
		local teamName = getTeamName(getPlayerTeam(thePlayer))
		local vehTeam = getElementData(source, "vehicleTeam")
		if (teamName == "Staff") then
			setElementData(source, "locked", false)
			return true
		end
		if (not exports.DENlaw:isPlayerLawEnforcer(thePlayer) and vehTeam == "Government") then
			cancelEvent()
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 0, 200, 0)
			return false
		end
		if (exports.DENlaw:isPlayerLawEnforcer(thePlayer) and jacked) then
			if (getPlayerWantedLevel(getVehicleOccupant(source, 0)) >= 1 or getPlayerTeam(getVehicleOccupant(source, 0)) == getPlayerTeam(thePlayer)) then
				setElementData(source, "locked", false)
			else
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 0, 200, 0)
				cancelEvent()
				return false
			end
			return true
		end
		if (teamName ~= vehTeam and vehTeam ~= "Government") then
			if (teamName == "Civilian Workers" and getElementData(thePlayer, "Occupation") ~= getElementData(source, "vehicleOccupation")) then
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 0, 200, 0)
				cancelEvent()
				return false
			end

			exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 0, 200, 0)
			cancelEvent()
			return false
		end
		return true
	end
	if (getElementData(source, "locked")) then
		local teamName = getTeamName(getPlayerTeam(thePlayer))
		if (teamName == "Staff") then
			return true
		end
		if (exports.DENlaw:isPlayerLawEnforcer(thePlayer) and getVehicleController(source) and getPlayerWantedLevel(getVehicleController(source)) > 0) then
			return true
		end
		if (getElementData(source, "vehicleOwner") == thePlayer) then
			return true
		end
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You cannot enter this vehicle, it's locked!", 0, 200, 0)
		cancelEvent()
		return false
	end
	return true
end
addEventHandler("onVehicleStartEnter", root, handleVehiclesEntrance)

function lockVehicle(player)
	if (not getPedOccupiedVehicle(player)) then
		exports.NGCdxmsg:createNewDxMessage(player, "You're not in a vehicle", 255, 0, 0)
		return false
	end
	local veh = getPedOccupiedVehicle(player)
	if (getElementData(veh, "vehicleOwner") ~= player) then
		exports.NGCdxmsg:createNewDxMessage(player, "You're not the vehicle owner", 255, 0, 0)
		return false
	end
	local x, y, z = getElementPosition(veh)
	local locked = (not getElementData(veh, "locked"))
	setElementData(veh, "locked", locked)
	triggerClientEvent("vehicleLocked", resourceRoot, x, y, z)
	exports.NGCdxmsg:createNewDxMessage(player, "Your vehicle is now "..(not locked and "un-" or "").."locked", 0, 255, 0)
end
addCommandHandler("lock", lockVehicle)
addCommandHandler("vehlock", lockVehicle)

-- Turn the engine off when you exist the vehicle
function turnEngineOffOnExit(theVehicle, seat, jacked)
	if (seat ~= 0) then
		return false
	end
	if (jacked) then
		return false
	end
	setVehicleEngineState(theVehicle, false)
end
addEventHandler("onPlayerVehicleExit", root, turnEngineOffOnExit)

-- Output a message with the vehicle owner
function vehicleOwnerMessage(theVehicle, seat, jacked)
	if (seat ~= 0) then
		return false
	end
	if (getElementData(theVehicle, "vehicleType") ~= "playerVehicle") then
		return false
	end
	local owner = getElementData(theVehicle, "vehicleOwner")
	if (not vehicleOwner or not isElement(vehicleOwner)) then
		return false
	end
	exports.NGCdxmsg:createNewDxMessage(source, "This vehicle belongs to "..getPlayerName(vehicleOwner) .."!", 0, 200, 0)
end

-- Vehicle headlights
function vehicleHeadlightsCmd(thePlayer, cmd, r, g, b)
	if (not tonumber(r)) then 
		r = math.random(1, 255) 
	else 
		r = tonumber(r) 
	end
	if (not tonumber(g)) then 
		g = math.random(1, 255) 
	else 
		g = tonumber(g) 
	end
	if (not tonumber(b)) then 
		b = math.random(1, 255) 
	else 
		b = tonumber(b) 
	end
	if (isPedInVehicle(thePlayer) and getPedOccupiedVehicleSeat(thePlayer) == 0) then
		if (setVehicleHeadLightColor(getPedOccupiedVehicle(thePlayer), r, g, b)) then
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "Your vehicle headlight colors have been changed.", 0, 255, 0)
		else
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "Failed to set your vehicle headlights.", 255, 0, 0)
		end
	end
end
addCommandHandler("headlights", vehicleHeadlightsCmd)

function destroyTank(tank)
	setElementHealth(tank, getElementHealth(tank) - 150)
end
addEvent("setTheTankHealth", true)
addEventHandler("setTheTankHealth", resourceRoot, destroyTank)

--EJECT-
function eject(theEjecter, command, theEjected)
	local veh = getPedOccupiedVehicle(theEjecter)
	local driverSeat = getPedOccupiedVehicleSeat(theEjecter)
	if (theEjecter ~= theEjected and veh and driverSeat == 0) then
		if (theEjected == "*") then
			occupants = getVehicleOccupants(veh)
			for i, v in ipairs(occupants) do
				if (v ~= theEjecter) then
					removePedFromVehicle(v)
					attachElements(v, veh, 0, 0, 2)
					detachElements(v, veh)
					exports.NGCdxmsg:createNewDxMessage(v, "You have been ejected from the vehicle!", 255, 0, 0)
				end
			end
		else 
			playerToEject = exports.server:getPlayerFromNamePart(theEjected)
			if (playerToEject and getPedOccupiedVehicle(playerToEject) == veh and getPedOccupiedVehicleSeat(playerToEject) ~= 0) then
				removePedFromVehicle(playerToEject)
				attachElements(playerToEject, veh, 0, 0, 2)
				detachElements(playerToEject, veh)
				exports.NGCdxmsg:createNewDxMessage(playerToEject, "You have been ejected from the vehicle!", 255, 0, 0)
			elseif (playerToEject and getPedOccupiedVehicleSeat(playerToEject) == 0) then 
				exports.NGCdxmsg:createNewDxMessage(theEjecter, "You can't eject yourself!", 255, 0 ,0)
			else 
				exports.NGCdxmsg:createNewDxMessage(theEjecter, "The player you specified is not on your vehicle/doesn't exist!", 255, 0, 0)
			end
		end
	end
end
addCommandHandler("eject", eject)
