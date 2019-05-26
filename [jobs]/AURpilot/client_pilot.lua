local missionString = "Currently no mission."

local passengers = {}
local passengerMarkers = {}

function getPassengerMarker(passenger)
	for i=1, #passengers do
		if passengers[i].player == passenger then
			return passengers[i].marker
		end
	end
	return false
end

addEvent ( "airport_c_onPassengerEnter", true )
function pilot_onPassengerEnter ( targetX, targetY )

	if not isPlayerPassenger(source) then

		local x,y,z = getElementPosition ( localPlayer )
		local passengerMarker = createMarker ( targetX, targetY, getGroundPosition ( targetX, targetY, z ), "cylinder", 8, 200, 0, 0 )
		local passengerBlip = createBlipAttachedTo ( passengerMarker, 41 )
		addEventHandler ( "onClientMarkerHit", passengerMarker, pilot_onTargetMarkerHit, false )
		addEventHandler ( "onClientPlayerQuit", source, pilot_onPassengerExit, false )
		addEventHandler ( "onClientPlayerWasted", source, pilot_onPassengerExit, false )

		table.insert( passengers, { player=source, marker=passengerMarker } )
		setElementData ( localPlayer, "airport_pilot_passengers", passengers )
		setElementData ( passengerMarker, "airport_markerPassenger", source )
		setElementData ( passengerMarker, "airport_markerBlip", passengerBlip )

		exports.NGCdxmsg:createNewDxMessage ( getPlayerName(source).." has entered your vehicle.", 0, 255, 0 )
		local plane = getPedOccupiedVehicle(localPlayer)

		if #passengers == 1 then

			addEventHandler ( "onClientVehicleExit", plane, pilot_onPlaneExit, false )
			addCommandHandler ( "air", airChatForPilot )
			passengersThatShouldPay = {}
			checkMarkerZTimer = setTimer ( checkMarkerZs, 500, 0 )
			addEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )

		end

		stopCargo()
		missionString = "Currently transporting "..#passengers.." passenger(s)."

	end

end

addEventHandler ( "airport_c_onPassengerEnter", root, pilot_onPassengerEnter )

function checkMarkerZs ()

	for i=1, #passengers do

		if isElement ( passengers[i].marker ) then

			local x,y,z = getElementPosition ( passengers[i].marker )
			local px,py,pz = getElementPosition ( localPlayer )

			if getGroundPosition ( x, y, pz ) ~= z then

				setElementPosition ( passengers[i].marker, x, y, getGroundPosition ( x, y, pz ) )

			end

		end

	end

end

function pilot_onPlaneExit ( thePlayer )

	if isPlayerPassenger( thePlayer ) then

		pilot_onPassengerExit( thePlayer )

	elseif thePlayer == localPlayer then

		pilot_onPilotExit()

	end

end

function pilot_onPilotExit ()

	triggerServerEvent ( "airport_s_pilotExit", localPlayer, passengers )
	removeEventHandler ( "onClientVehicleExit", getPedOccupiedVehicle ( localPlayer ), pilot_onPlaneExit, false )
	removeEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )
	removeCommandHandler ( "air", airChatForPilot )
	if isTimer(checkMarkerZTimer) then destroyTimer ( checkMarkerZTimer ) end

	pilot_reset()


end

function isPlayerPassenger( playerToCheck )

	for i=1, #passengers do

		if passengers[i].player == playerToCheck then

			return true

		end

	end

	return false

end

function pilot_onPassengerExit( passenger )

	for i=1, #passengers do

		if passengers[i].player == passenger then

			if isElement ( passengers[i].marker ) then

				removeEventHandler ( "onClientMarkerHit", passengers[i].marker, pilot_onTargetMarkerHit, false )
				destroyElement ( getElementData ( passengers[i].marker, "airport_markerBlip" ) )
				destroyElement ( passengers[i].marker )

			end

			triggerServerEvent ( "airport_s_onPassengerExit", localPlayer, passenger, passengersThatShouldPay[passenger] )
			removeEventHandler ( "onClientPlayerQuit", passenger, pilot_onPassengerExit, false )
			removeEventHandler ( "onClientPlayerWasted", passenger, pilot_onPassengerExit, false )
			table.remove ( passengers, i )
			setElementData ( localPlayer, "airport_pilot_passengers", passengers )

			if #passengers <= 0 then

				removeEventHandler ( "onClientVehicleExit", getPedOccupiedVehicle ( localPlayer ), pilot_onPlaneExit, false )
				removeEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )
				removeCommandHandler ( "air", airChatForPilot )
				if isTimer(checkMarkerZTimer) then killTimer ( checkMarkerZTimer ) end
				missionString = "Currently no mission."
			end

		end

	end

	for i = 1, #passengersThatShouldPay do

		if passengersThatShouldPay[i] == passenger then

			table.remove ( passengersThatShouldPay, i )

		end

	end

	exports.NGCdxmsg:createNewDxMessage ( getPlayerName( passenger ).." has left your vehicle.", 0, 255, 0 )
	triggerServerEvent ( "airport_s_notifyPassengerOfArrival", localPlayer, onArrival)

end

function getSmallVersionOfPassengers()

	local new = {}
	for i=1, #passengers do

		table.insert ( new, passengers.player )

	end
	return new

end

function pilot_onPilotWasted()

	local passengers = getSmallVersionOfPassengers()
	triggerServerEvent ( "airport_s_pilotDied", localPlayer, passengers )
	removeEventHandler ( "onClientVehicleExit", getPedOccupiedVehicle ( localPlayer ), pilot_onPlaneExit, false )
	removeEventHandler ( "onClientPlayerWasted", localPlayer, pilot_onPilotWasted, false )
	removeCommandHandler ( "air", airChatForPilot )
	if isTimer(checkMarkerZTimer) then killTimer ( checkMarkerZTimer ) end
	pilot_reset()

end

function pilot_reset()

	setTimer ( function () passengersThatShouldPay = {} end, 1500, 1 )
	for i=1, #passengers do


		if isElement ( passengers[i].marker ) then destroyElement ( passengers[i].marker ) end
		if isElement ( getElementData ( passengers[i].marker, "airport_markerBlip" ) ) then destroyElement ( getElementData ( passengers[i].marker, "airport_markerBlip" ) ) end

	end
	setTimer ( function () passengers = {} end, 1500, 1 )

end

function airChatForPilot(commandName, ...)

local arg = {...}
local allMessages = tostring( table.concat( arg, " " ) )

	if allMessages and string.gsub(allMessages, " ", "") ~= "" then

		if getElementData(localPlayer, "Occupation" ) == "Pilot" then

			local passengers = nil
			passengers = getElementData ( localPlayer, "airport_pilot_passengers" )

			if passengers then

				triggerServerEvent ( "airport_s_chat", localPlayer, allMessages, localPlayer, passengers )

			end

		end

	end

end

function pilot_onTargetMarkerHit()
local passenger = getElementData ( source, "airport_markerPassenger" )

	if passenger then

		if not passengersThatShouldPay[passenger] then table.insert ( passengersThatShouldPay, passenger ) end
		local marker = getPassengerMarker( passenger )
		destroyElement ( getElementData ( marker, "airport_markerBlip" ) )
		destroyElement ( marker )
		triggerServerEvent ( "airport_s_notifyPassengerOfArrival", passenger )

	end

end

--------- cargo

function playerHasPlane()

	local vehicle = getPedOccupiedVehicle( localPlayer )
	if vehicle then
		if getElementData(vehicle,"vehicleTeam") == "Civilian Workers" and getElementData(vehicle,"vehicleOccupation") == "Pilot" then
			local vehType = getVehicleType( vehicle )
			if(vehType == "Plane") then
				return getElementModel(vehicle) ~= 520 and getElementModel(vehicle) ~= 476
			elseif(vehType == "Helicopter") then
				return getElementModel(vehicle) ~= 425
			else
				return false
			end
		else
			return false
		end
	end
	return false

end

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		return false
	end
end

local cargoStartMissionTimer
local cargoDestinationMarker
local cargoDestinationBlip
local onCargoMission
local cargoStartMarkerHit
local cargoMissionTarget
local cargoMissionStart
local pilotInitialised = false
local cargoPlayerPlane

local cargos = {
	[1] = {
		[1] = {2074.1752929688,-2536.1809082031,13.546875,165.35821533203},
	},

	[2] = {
		[1] = {-1353.5059814453,-65.653022766113,14.1484375,220.81872558594},
	},

	[3] = {
		[1] = {402.63824462891,2507.3225097656,16.484375,179.19415283203},
	},

	[4] = {
		[1] = {1388.8469238281,1768.4041748047,10.8203125},

	},
}
local cargoname = {
	[1] = "Los Santos", [2] = "San Fierro", [3] = "the Abandoned Airstrip", [4] = "Las Venturas"
}

function onElementDataChange( dataName, oldValue )
	if dataName == "Occupation" and source == localPlayer then
		if getElementData(localPlayer,dataName) == "Pilot" then
			initCargo()
		else
			onEndPilotJob()
		end
	end
end
addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange )

addEvent( "onClientPlayerTeamChange" )
function onTeamChange ( oldTeam, newTeam )
	if source == localPlayer then
		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
				if getElementData ( localPlayer, "Occupation" ) == "Pilot" and newTeam == "Civilian Workers" then
					initCargo ()
				else
					onEndPilotJob()
				end
			end
		end, 500, 1 )
	end
end
addEventHandler( "onClientPlayerTeamChange", localPlayer, onTeamChange )

function onResourceStart()
	setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local team = getTeamName ( getPlayerTeam( localPlayer ) )
				if getElementData ( localPlayer, "Occupation" ) == "Pilot" and team == "Civilian Workers" then
					initCargo()
				end
			end
		end
	, 2500, 1 )
end
addEventHandler ( "onClientResourceStart", resourceRoot, onResourceStart )

function isPlayerPilot()
	local occupation = getElementData ( localPlayer, "Occupation" )
	local team = getPlayerTeam ( localPlayer )
	if team then
		return getTeamName ( team ) == "Civilian Workers" and occupation == "Pilot"
	end
end

function initCargo()

	if pilotInitialised then return false end
	pilotInitialised = true
	if isTimer ( cargoStartMissionTimer ) then killTimer ( cargoStartMissionTimer ) end

	cargoStartMissionTimer = setTimer ( startCargoMission, math.random(5000,15000), 1 )

end

function onEndPilotJob()

	if not pilotInitialised then return false end
	pilotInitialised = false
	if isTimer ( cargoStartMissionTimer ) then

		killTimer ( cargoStartMissionTimer )

	else


		if cargoPlayerPlane and isElement ( cargoPlayerPlane ) then

			removeEventHandler ( "onClientVehicleExit", cargoPlayerPlane, onExitVehicle, false )
			removeEventHandler ( "onClientElementDestroy", onCargoMission, stopCargo, false )

		end
		cargoPlayerPlane = false

		cargoMissionTarget = false
		cargoMissionStart = false
		onCargoMission = false
		cargoStartMarkerHit = false

		removeEventHandler ( "onClientPlayerWasted", localPlayer, stopCargo, false )
		if isElement(cargoDestinationMarker) then removeEventHandler ( "onClientMarkerHit", cargoDestinationMarker, onCargoMarkerHit ) end
		cargoPlayerPlane = nil
		if isElement ( cargoDestinationBlip ) then destroyElement ( cargoDestinationBlip ) end
		if isElement ( cargoDestinationMarker ) then destroyElement ( cargoDestinationMarker ) end

	end
	exports.CSGranks:closePanel()
end

function stopCargo()

	if isTimer ( cargoStartMissionTimer ) then

		killTimer ( cargoStartMissionTimer )

	else

		cargoMissionTarget = false
		cargoMissionStart = false
		onCargoMission = false
		cargoStartMarkerHit = false
		if cargoPlayerPlane and isElement ( cargoPlayerPlane ) then

			removeEventHandler ( "onClientVehicleExit", cargoPlayerPlane, onExitVehicle, false )
			removeEventHandler ( "onClientElementDestroy", cargoPlayerPlane, stopCargo, false )

		end
		cargoPlayerPlane = false

		removeEventHandler ( "onClientPlayerWasted", localPlayer, stopCargo, false )
		removeEventHandler ( "onClientMarkerHit", cargoDestinationMarker, onCargoMarkerHit )
		cargoPlayerPlane = nil
		if isElement ( cargoDestinationBlip ) then destroyElement ( cargoDestinationBlip ) end
		if isElement ( cargoDestinationMarker ) then destroyElement ( cargoDestinationMarker ) end

		if isPlayerPilot() then

			cargoStartMissionTimer = setTimer ( startCargoMission, math.random(5000,15000), 1 )

		end
		missionString = "Currently no mission."

	end
end

function onExitVehicle(thePlayer)

	if thePlayer == localPlayer then

		stopCargo()

	end

end


function startCargoMission ()

	if playerHasPlane() and getElementHealth ( localPlayer ) > 0 and #passengers == 0 then

		airportStart = math.random(1, #cargos) -- 1 to 4, airport type
		airportDest = math.random(1, #cargos) -- 1 to 4, airport type

		cargoMissionStart = math.random(1,  #cargos[airportStart]) -- The marker within the specified airport
		cargoMissionTarget = math.random(1,  #cargos[airportDest]) -- The marker within the specified airport

		outputDebugString("airportStart: "..airportStart.." airportDest: "..airportDest)
		outputDebugString("[start] marker no: "..cargoMissionStart)
		outputDebugString("[dest] marker no: "..cargoMissionStart)

		outputDebugString("Start: "..cargoname[airportStart].." Dest: "..cargoname[airportDest])
		outputDebugString(tostring("Start: "..cargos[airportStart][cargoMissionStart][1]..", "..cargos[airportStart][cargoMissionStart][2]..", "..cargos[airportStart][cargoMissionStart][3].." Dest: "..cargos[airportDest][cargoMissionTarget][1]..", "..cargos[airportDest][cargoMissionTarget][2]..", "..cargos[airportDest][cargoMissionTarget][3]))

		--while cargoMissionTarget == cargoMissionStart do
		while airportDest == airportStart do
			airportDest = math.random(1, #cargos)
			cargoMissionTarget = math.random(1,  #cargos[airportDest])
		end

		onCargoMission = true
		cargoPlayerPlane = getPedOccupiedVehicle(localPlayer)
		cargoStartMarkerHit = false
		cargoDestinationMarker = createMarker(cargos[airportStart][cargoMissionStart][1], cargos[airportStart][cargoMissionStart][2], cargos[airportStart][cargoMissionStart][3] - 1, "cylinder", 8, 255, 0, 0 )
		cargoDestinationBlip = createBlipAttachedTo(cargoDestinationMarker, 0, 3)
		addEventHandler("onClientMarkerHit", cargoDestinationMarker, onCargoMarkerHit)
		addEventHandler("onClientVehicleExit", cargoPlayerPlane, onExitVehicle, false)
		addEventHandler("onClientElementDestroy", cargoPlayerPlane, stopCargo, false)
		addEventHandler("onClientPlayerWasted", localPlayer, stopCargo, false)

		exports.NGCdxmsg:createNewDxMessage( "There has been a request for cargo transport, pick up the cargo in "..tostring(cargoname[airportStart])..".", 0, 255, 0 )
		missionString = cargoname[airportStart].." to "..cargoname[airportDest]
	else

		cargoStartMissionTimer = setTimer ( startCargoMission, math.random(5000,15000), 1 )

	end

end

function onCargoMarkerHit ( hitElement )
	if hitElement ~= localPlayer and hitElement ~= cargoPlayerPlane then return end
	if playerHasPlane() then
		local vehiclespeed = getElementSpeed ( getPedOccupiedVehicle ( localPlayer ) )
		if vehiclespeed <= 35 then

			setElementFrozen ( getPedOccupiedVehicle ( localPlayer ), true )
			fadeCamera ( false, 1 )
			setTimer ( fadeCamera, 1500, 1, true, 1 )
			setTimer (
				function (veh)
				if isElement ( veh ) then setElementFrozen ( veh, false )  end
			end, 2000, 1, getPedOccupiedVehicle ( localPlayer ) )
			if not cargoStartMarkerHit then
				cargoStartMarkerHit = true
				setTimer (
				function ()
					if onCargoMission then
						local x,y,z = cargos[airportDest][cargoMissionTarget][1], cargos[airportDest][cargoMissionTarget][2], cargos[airportDest][cargoMissionTarget][3] - 1
						setElementPosition ( cargoDestinationMarker, x, y, z )
						exports.NGCdxmsg:createNewDxMessage( "You picked up the cargo, now bring it to "..cargoname[airportDest]..".", 0, 255, 0 )
					end
				end, 1500, 1 )
			else
				setTimer(
				function ()
					if onCargoMission then
						local sx, sy = cargos[airportStart][cargoMissionStart][1], cargos[airportStart][cargoMissionStart][1]
						local tx, ty = cargos[airportDest][cargoMissionTarget][1], cargos[airportDest][cargoMissionTarget][2]

						local reward = 3500 +  ( ( math.floor( getDistanceBetweenPoints2D( sx, sy, tx, ty ) /100 ) * 100 ) )
						triggerServerEvent ( "onPlayerFinishCargo", localPlayer, reward, getDistanceBetweenPoints2D( sx, sy, tx, ty ) )
						stopCargo()
					end
				end, 1500, 1 )
			end
		else
			local pre = ""
			if cargoStartMarkerHit then
				pre = "un"
			end
			local message = "Slow down, the cargo can't be "..pre.."loaded!"
			exports.NGCdxmsg:createNewDxMessage ( message, 255, 0, 0 )
		end
	end
end


function togglePilotPanel()
	if getElementData(localPlayer,"Occupation") == "Pilot" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5","down",togglePilotPanel)


