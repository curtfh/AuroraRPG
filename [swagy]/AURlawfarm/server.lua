local entryMarker = createMarker(1060.3, -345.8, 74.99,"arrow", 2, 0,0,255,255)
local exitMarker = createMarker(1060.3, -345.8, 74.99,"arrow", 2, 0,0,255,255)
setElementDimension(exitMarker, 1900)
local farmVehicles = {}
local playersInFarm = {}

function isPlayerLaw (plr)

	local tName = getTeamName(getPlayerTeam(plr))
	if (tName == "Military Forces") or (tName == "GIGN") or (tName == "Government") then
		return true
	else 
		return false
	end
end


function joinFarm (he, dim)

	if (dim) then
		if (getElementType(he) ~= "player") then return false end
		if not (isPlayerLaw(he)) then return false end
		if (isPedInVehicle(he)) then return false end
		if (isPedOnGround(he) == false) then return false end
		if (getElementData(he, "justJoinedFarm")) then return false end
		if (source == entryMarker) then
			setElementDimension(he, 1900)
			local rx,ry,rz = getElementRotation(he)
			setElementRotation(he, rx,ry,rz*90)
			setElementData(he, "justJoinedFarm", true)
			setTimer(setElementData, 3000, 1, he, "justJoinedFarm", false)
			table.insert(playersInFarm, he)
			setElementData(he, "City", "Farm")
			exports.NGCdxmsg:createNewDxMessage(he,"Use /cv vehiclename to start a training with that vehicle",  0, 255, 0)
			
		elseif (source == exitMarker) then
			setElementDimension(he, 0)
			local rx,ry,rz = getElementRotation(he)
			setElementRotation(he, rx,ry,rz*90)
			setElementData(he, "justJoinedFarm", true)
			setTimer(setElementData, 3000, 1, he, "justJoinedFarm", false)
			local x,y,z = getElementPosition(he)
			setElementData(he, "City", getZoneName(x,y,z, true))
			for k,v in ipairs (playersInFarm) do
				if (he == v) then
					table.remove(playersInFarm, k)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit", root, joinFarm)


function createVeh (p, cmd, name)

	if (name) then
		if not (isPlayerLaw(p)) then return false end
		local vehID = getVehicleModelFromName(name)
		if (vehID) then
			if (getElementDimension(p) == 1900) then
				if (farmVehicles[p]) then
					destroyElement(farmVehicles[p])
					local x,y,z = getElementPosition(p)
					farmVehicles[p] = createVehicle(vehID, x,y,z)
					warpPedIntoVehicle(p, farmVehicles[p])
					setElementDimension(farmVehicles[p], 1900)
				else
					local x,y,z = getElementPosition(p)
					farmVehicles[p] = createVehicle(vehID, x,y,z)
					warpPedIntoVehicle(p, farmVehicles[p])
					setElementDimension(farmVehicles[p], 1900)
				end
			end
		end
	end
end
addCommandHandler("cv", createVeh)


function onVehicleLeave (plr)

	if (farmVehicles[plr] == source) then
		destroyElement(farmVehicles[plr])
		farmVehicles[plr] = false
	end
end
addEventHandler("onVehicleExit", root, onVehicleLeave)			


function onPlayerQuit ()

	if (farmVehicles[source]) then
		destroyElement(farmVehicles[source])
		farmVehicles[source] = nil
	end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)		


function getFarmPlayers (p, cmd)

	outputChatBox("Current Players in the farm:",p,255,255,0)
	for k,v in ipairs (playersInFarm) do
		outputChatBox(""..getPlayerName(v).." : "..getTeamName(getPlayerTeam(v)).."",p,255,150,0)
	end
end
addCommandHandler("farmplayers", getFarmPlayers)


function onDeath ()

	for k,v in ipairs (playersInFarm) do
		if (source == v) then
			table.remove(playersInFarm, k)
		end
	end
end
addEventHandler("onPlayerWasted", root, onDeath)

function quitJob (oldJob)

	for k,v in ipairs (playersInFarm) do
		if (source == v)  then
			setElementPosition(v,1060.62,-340.5,73.99) 
            setElementDimension(v,0)
		end
	end

end
addEventHandler("onPlayerJobChange", root, quitJob)

				
