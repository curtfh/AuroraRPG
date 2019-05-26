-------------------------MAP CONFIGURATIONS--------------------------------------
local shipelement = createObject(9585,-2369.8,1605.9,19.7,0,0,0)
setElementDoubleSided(shipelement, true)
local colshape = createColSphere (-2369.8,1605.9,19.7,130)
local createdMarkers = {}
local markerPos = {
	{-2270.32,1605.79,31.52, 2, "Front Deck"},
	{-2328.05,1605.06,30.08, 2, "Upper Shipment Area"},
	{-2400.59,1615.71,14.9, 2, "Engine Room"},
	{-2332.36,1613.71,14.89, 2, "Lower Shipment Area"},
	{-2476.21,1605.93,30.08, 2, "Back Deck"},
	{-2426.82,1606.28,36.36, 2, "Bridge Door"},
	{-2430.79,1598.38,45.93, 2, "Upper Bridge"},
	{-2430.53,1610.98,45.92, 2, "Upper Bridge Ship Controls"},
	{-2430.53,1614.01,45.92, 2, "Upper Bridge Ship Radio"},
}


function applyInverseRotation (x, y, z, rx, ry, rz)
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z

    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z

    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y

    return x, y, z
end

function attachRotationAdjusted (from, to)
    local frPosX, frPosY, frPosZ = getElementPosition(from)
	if (getElementType(from) ~= "object") then 
		frRotX, frRotY, frRotZ = 0, 0, 0
	else 
		frRotX, frRotY, frRotZ = getElementRotation(from)
	end 
    
    local toPosX, toPosY, toPosZ = getElementPosition(to)
    local toRotX, toRotY, toRotZ = getElementRotation(to)
    local offsetPosX = frPosX - toPosX
    local offsetPosY = frPosY - toPosY
    local offsetPosZ = frPosZ - toPosZ
    local offsetRotX = frRotX - toRotX
    local offsetRotY = frRotY - toRotY
    local offsetRotZ = frRotZ - toRotZ

    offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation (offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ)

    attachElements(from, to, offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ)
end

for i,v in ipairs({
    --{9585,-2369.8,1605.9,19.7,0,0,0, true},
    {9586,-2372.1001,1606.1,29.8,0,0,0, true},
    {9590,-2363.5,1605.8,21.5,0,0,0, true},
    {9584,-2445,1606.1,38.9,0,0,0, true},
    {9761,-2371.3,1605.9,39.7,0,0,0, true},
    {9698,-2433.5,1604.9203,41.78,0,0,0, true},
    {9820,-2434.6001,1606.2,45.6,0,0,0, true},
    {9819,-2430.3999,1611.9,45.8,0,0,0, false},
    {9587,-2361.1001,1605.8,36.3,0,0,0, true},
    {9588,-2364.3,1605.8,20.4,0,0,0, true},
    {9604,-2352.6001,1606.6,37.6,0,0,0, true},
    {3361,-2305,1587.6,27.6,0,0,182, true},
    {3361,-2313.2,1587.3,23.6,0,0,182, true},
    {3361,-2319.2,1587.1,19.6,0,0,182, true},
    {3361,-2327.3999,1586.8,15.6,0,0,182, true},
    {3361,-2305.3,1624.3,27.6,0,0,176, true},
    {3361,-2313.3,1624.7,23.5,0,0,177.995, true},
    {3361,-2319.3,1624.9,19.5,0,0,177.995, true},
    {3361,-2327.3999,1625.2,15.4,0,0,177.995, true},
}) do
    local obj = createObject(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
	--attachElements (obj, shipelement, 5, 0, 2.37)
	attachRotationAdjusted(obj, shipelement)
    setObjectScale(obj, 1)
    setElementDimension(obj, 0)
    setElementInterior(obj, 0)
    setElementDoubleSided(obj, v[8])
end
attachElements(colshape, shipelement)

for i,v in ipairs(markerPos) do
	local marker = createMarker(v[1], v[2], v[3]-1, "cylinder", v[4], 255, 255, 255, 255)
	local col = createColSphere (v[1], v[2], v[3], 3)
	createdMarkers[#createdMarkers+1] = marker
	attachRotationAdjusted(marker, shipelement)
	outputDebugString(col)
	attachRotationAdjusted(col, shipelement)
	setElementData(marker, "AURpirates.checkpointname", v[5])
	setElementData(marker, "AURpirates.marker", col)
end 

setElementPosition(shipelement, -2982.36,142.45,6.37)
setElementRotation(shipelement,0, 0,470)
--------------------------END OF MAP CONFIGURATIONS------------------------------------

-------------------------FUNCTIONS OF THE SCRIPT------------------------------
local timeToStart = 20000 --30 minutes
local timeLimitOfCargo = 3600000 --60 minutes
local requiredPlayers = 1
local timeLeftToCaptureTheShipByCops = 300000 -- 5 minutes
local startedmission = false
local accountsAlreadyParticipated = {}
local criminalTeam = {["Criminals"] = true, ["Bloods"] = true}
local allowedTeams = {["Staff"] = true, ["Paramedics"] = true}
local lawTeams = {["Government"] = true, ["Military Forces"] = true, ["SWAT Team"] = true}
local moves = {
	-- x, y, rotation, time
	{-3182.8,472.84,89, 40000},
	{-3378.41,443.26,178, 40000},
	{-2880.14,-2901.82,216, 600000},
	{-2222.24,-3115.82,248, 180000},
	{-1391.1,-3044.18,275, 180000},
	{266.18,-2986.25,266, 300000},
	{266.18,-2986.25,359, 10000},
	{262.59,-1881.09,354, 300000},
}

local savedremaining, savedexecutesRemaining, savedtotalExecutes = 0, 0, 0
local timeElementLimit
local timeElementWait
local timeElementProtectLaw
local currentmoveid = 1



function isPlayerAlreadyParticipated (player) 
	local theAccount = exports.server:getPlayerAccountName (player)
	if (accountsAlreadyParticipated[theAccount] == true) then
		return true
	else 
		return false
	end
end 

function addPlayerInParticipatedList (player)
	local theAccount = exports.server:getPlayerAccountName (player)
	if (accountsAlreadyParticipated[theAccount] == true) then
		return true
	else 
		accountsAlreadyParticipated[theAccount] = true
	end
end 

function clearAllParticipatedList ()
	accountsAlreadyParticipated = {}
end 

function getControlledCheckpoints()
	local captured = 0
	for i=1, #createdMarkers do 
		if (getElementData(createdMarkers[i], "AURpirates.captured") == "criminals") then 
			captured = 0
		end 
	end 
	return captured
end 

function startCriminalMission ()
	if (startedmission == true) then return false end
	local players = getElementsWithinColShape (colshape, "player")
	
	if (#players < requiredPlayers) then 
		for i,thePlayer in ipairs(players) do 
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "The Pirate CnR Event has been posponed. (Required Players: 10)", 255, 0, 0)
		end 
		return false 
	end 
	
	for i,v in ipairs(createdMarkers) do
		setElementAlpha(v, 255)
	end 
	
	for i,thePlayer in ipairs(players) do 
		if (criminalTeam[(getTeamName(getPlayerTeam(thePlayer)))] == true) then 
			addPlayerInParticipatedList(thePlayer)
			exports.server:givePlayerWantedPoints(thePlayer, 70)
		end 
	end
	
	if (isTimer(timeElementWait)) then
		killTimer(timeElementWait)
	end
	
	if (isTimer(timeElementLimit)) then
		killTimer(timeElementLimit)
	end
	
	timeElementLimit = setTimer(function()
		local players = getElementsWithinColShape (colshape, "player")
		for i,thePlayer in ipairs(players) do 
			local convert = (timeLimitOfCargo/1000)/60
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "The Pirate CnR Event is over due to "..convert.." minutes time limit.", 255, 0, 0)
		end 
		endCriminalMission()
	end, timeLimitOfCargo, 1)
	
	local players = getElementsWithinColShape (colshape, "player")
	for i,thePlayer in ipairs(players) do 
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "The Pirate CnR Event has started!", 255, 0, 0)
	end
	--moveShip("next")
	startedmission = true
	return true
end 

function endCriminalMission ()
	if (startedmission == false) then return false end
	for i,v in ipairs(createdMarkers) do
		setElementAlpha(v, 0)
		setMarkerColor(v, 255, 255, 255)
	end 
	
	if (isTimer(timeElementLimit)) then
		killTimer(timeElementLimit)
	end
	if (isTimer(timeElementWait)) then
		killTimer(timeElementWait)
	end
	if (isTimer(timeElementProtectLaw)) then
		killTimer(timeElementProtectLaw)
	end
	timeElementWait = setTimer(function()
		startCriminalMission()
	end, timeToStart, 1)
	savedremaining, savedexecutesRemaining, savedtotalExecutes = 0, 0, 0
	timeElementLimit = nil
	timeElementWait = nil
	timeElementProtectLaw = nil 
	currentmoveid = 1
	startedmission = false
end 

timeElementWait = setTimer(function()
	startCriminalMission()
end, timeToStart, 1)


function viewEventStatus (player, cmd)
	if (startedmission == true) then 
		if (isTimer(timeElementLimit)) then 
			local remaining, executesRemaining, totalExecutes = getTimerDetails(timeElementLimit)
			exports.NGCdxmsg:createNewDxMessage(player, "The Pirates (A CnR Event) has already started. Time left: "..math.floor((remaining/1000)/60).." minutes.", 0, 255, 0)
		else
			exports.NGCdxmsg:createNewDxMessage(player, "Unexpected error. Please contact staff.", 255, 0, 0)
		end 
	elseif (startedmission == false) then 
		if (isTimer(timeElementWait)) then 
			local remaining, executesRemaining, totalExecutes = getTimerDetails(timeElementWait)
			exports.NGCdxmsg:createNewDxMessage(player, "The Pirates (A CnR Event) will start within "..math.floor((remaining/1000)/60).." minutes.", 0, 255, 0)
		else
			exports.NGCdxmsg:createNewDxMessage(player, "Unexpected error. Please contact staff.", 255, 0, 0)
		end 
	else
		exports.NGCdxmsg:createNewDxMessage(player, "Unexpected error. Please contact staff.", 255, 0, 0)
	end 
end 
addCommandHandler("piratestime", viewEventStatus)

function elementColShapeHit(colShapeHit)
    if (colShapeHit ~= colshape) then return false end
	if (getElementType(source) ~= "player") then return false end
	if (startedmission == true) then 
		if (isPlayerAlreadyParticipated(source) == false) then
			exports.NGCdxmsg:createNewDxMessage(source, "You already participated on this event. Give others a chance to play this event.", 255, 0, 0)
			killPed(source)
			return false 
		end 
		if (criminalTeam[(getTeamName(getPlayerTeam(source)))] ~= true or allowedTeams[(getTeamName(getPlayerTeam(source)))] ~= true) then 
			exports.NGCdxmsg:createNewDxMessage(source, "Your not allowed on this event.", 255, 0, 0)
			killPed(source)
			return false
		end
		
		
		if (criminalTeam[(getTeamName(getPlayerTeam(source)))] == true) then 
			exports.NGCdxmsg:createNewDxMessage(source, "You have entered a restricted area, leave this area within 10 seconds or else you will get wanted.", 255, 0, 0)
			setTimer(function()
				if (isElementWithinColShape (source, colshape) == true) then 
					exports.server:givePlayerWantedPoints(source, 70)
					addPlayerInParticipatedList(source)
					exports.NGCdxmsg:createNewDxMessage(source, "Your now wanted because you participated on Pirate CnR Event.", 255, 0, 0)
				end
			end, 10000, 1)
		end
		
	elseif (startedmission == false) then 
		if (allowedTeams[(getTeamName(getPlayerTeam(source)))] ~= true and criminalTeam[(getTeamName(getPlayerTeam(source)))] ~= true) then 
			setElementPosition(source, -2859.68,482.32,4.38, true)
			exports.NGCdxmsg:createNewDxMessage(source, "The event has not yet started.", 255, 0, 0)
			return
		end 
		if (isTimer(timeElementWait)) then 
			local remaining, executesRemaining, totalExecutes = getTimerDetails(timeElementWait)
			exports.NGCdxmsg:createNewDxMessage(source, "You entered the cargo ship (Pirate CnR Event). Please wait within "..math.floor((remaining/1000)/60).." minutes to start.", 255, 0, 0)
		else
			exports.NGCdxmsg:createNewDxMessage(source, "You entered the cargo ship (Pirate CnR Event).", 255, 0, 0)
		end
		
	else
		exports.NGCdxmsg:createNewDxMessage(source, "Unexpected error. Please contact staff.", 255, 0, 0)
	end 
end
addEventHandler("onElementColShapeHit", getRootElement(), elementColShapeHit)

local timerSetter
local remaining, executesRemaining, totalExecutes
function moveShip (status) 
	if (startedmission == false) then return false end
	
	if (status == "next") then 
		if (isTimer(timerSetter)) then killTimer(timerSetter) end
		if (currentmoveid > #moves) then 
			local players = getElementsWithinColShape (colshape, "player")
			for i,thePlayer in ipairs(players) do 
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "The ship has successfully taken by Criminals.", 255, 0, 0)
			end
			stopObject (shipelement)
			setWiner("criminals")
			return
		end 
		local x, y, z = getElementPosition(shipelement)
		local rx, ry, rz = getElementRotation(shipelement)
		--setElementRotation(shipelement, 0, 0, moves[currentmoveid][3])
		--moveObject (shipelement, moves[currentmoveid][4], moves[currentmoveid][1], moves[currentmoveid][2], z, 0, 0, 0, "InOutQuad")
		moveObject (shipelement, moves[currentmoveid][4], moves[currentmoveid][1], moves[currentmoveid][2], z, 0, 0, moves[currentmoveid][3], "InOutQuad")
		outputDebugString(currentmoveid)
		timerSetter = setTimer(function()
			moveShip("next")
		end, moves[currentmoveid][4], 1)
		currentmoveid = currentmoveid + 1
		return true
	elseif (status == "pause") then
		if (isTimer(timerSetter)) then 
			stopObject(shipelement)
			remaining, executesRemaining, totalExecutes = getTimerDetails(timerSetter)
			killTimer(timerSetter)
			return true
		end 
		return false 
	elseif (status == "continue") then
		if (not isTimer(timerSetter)) then 
			local x, y, z = getElementPosition(shipelement)
			local rx, ry, rz = getElementRotation(shipelement)
			moveObject (shipelement, remaining, moves[currentmoveid-1][1], moves[currentmoveid-1][2], z, 0, 0, moves[currentmoveid-1][3], "InOutQuad")
			timerSetter = setTimer(function()
				moveShip("next")
			end, remaining, 1)
			return true
		end 
		return false 
	end 
end 
addCommandHandler("testmovemnt", moveShip)

function setWiner (ttype)
	if (startedmission == false) then return false end
	
	if (ttype == "law") then 
		local players = getElementsWithinColShape (colshape, "player")
		for i,thePlayer in ipairs(players) do 
			if (lawTeams[(getTeamName(getPlayerTeam(hitElement)))] == true) then 
				exports.AURpayments:addMoney(thePlayer, 300000, "Custom", "Pirates CnR Event", 0, "AURpirates")
			end 
		end
		return true
	elseif (ttype == "criminals") then 
		local players = getElementsWithinColShape (colshape, "player")
		for i,thePlayer in ipairs(players) do 
			if (criminalTeam[(getTeamName(getPlayerTeam(hitElement)))] == true) then 
				exports.csgdrugs:giveDrug(thePlayer, "LSD", 200)
				exports.csgdrugs:giveDrug(thePlayer, "Cocaine", 200)
				exports.csgdrugs:giveDrug(thePlayer, "Heroine", 200)
				exports.csgdrugs:giveDrug(thePlayer, "Ritalin", 200)
				exports.csgdrugs:giveDrug(thePlayer, "Ecstasy", 200)
				exports.csgdrugs:giveDrug(thePlayer, "Weed", 200)
				exports.AURpayments:addMoney(thePlayer, 300000, "Custom", "Pirates CnR Event", 0, "AURpirates")
			end
		end
	end 
end 

function checkpointhit(colShapeHit)
	
	--if (startedmission == false) then return false end
	outputDebugString(getPlayerName(source))
	for i=1, #createdMarkers do 
		if (getElementData(createdMarkers[i], "AURpirates.marker") == colShapeHit) then 
		outputDebugString("Test")
			local x, y, z = getElementPosition(source)
			local ax, ay, az = getElementPosition(createdMarkers[i])
			if ( z-3 < az ) and ( z+3 > az ) then
				if (criminalTeam[(getTeamName(getPlayerTeam(source)))] == true) then 
					if (getElementData(createdMarkers[i], "AURpirates.captured") ~= "criminals") then return end
					local nameCheckpoint = getElementData(createdMarkers[i], "AURpirates.checkpointname")
					local players = getElementsWithinColShape (colshape, "player")
					setElementData(createdMarkers[i], "AURpirates.captured", "criminals")
					for i,thePlayer in ipairs(players) do 
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "The "..nameCheckpoint.." has been captured by Criminals ("..getControlledCheckpoints().."/"..#createdMarkers..")", 255, 0, 0)
						if (getControlledCheckpoints() <= #createdMarkers) then 
							exports.NGCdxmsg:createNewDxMessage(thePlayer, "The ship has started moving, all checkpoints are captured by Criminals.", 255, 0, 0)
						end 
					end 
					setMarkerColor(createdMarkers[i], 200, 0, 0)
					if (getControlledCheckpoints() <= #createdMarkers) then 
						if (currentmoveid == 1) then 
							moveShip("next")
						else
							moveShip("continue")
						end 
						if (isTimer(timeElementProtectLaw)) then killTimer(timeElementProtectLaw) end
					end 
					
				elseif (lawTeams[(getTeamName(getPlayerTeam(source)))] == true) then 
					if (getElementData(createdMarkers[i], "AURpirates.captured") ~= "law") then return end
					local nameCheckpoint = getElementData(createdMarkers[i], "AURpirates.checkpointname")
					local players = getElementsWithinColShape (colshape, "player")
					setElementData(createdMarkers[i], "AURpirates.captured", "law")
					for i,thePlayer in ipairs(players) do 
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "The "..nameCheckpoint.." has been captured by Law ("..getControlledCheckpoints().."/"..#createdMarkers.." not controlled)", 0, 0, 200)
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "The ship has stopped moving, the "..nameCheckpoint.." was captured by Law.", 0, 0, 200)
						if (getControlledCheckpoints() >= #createdMarkers) then 
							exports.NGCdxmsg:createNewDxMessage(thePlayer, "The law enforcement has 5 minutes to stop the ship on going.", 0, 0, 200)
						end 
					end 
					moveShip("pause")
					setMarkerColor(createdMarkers[i], 0, 0, 200)
					if (getControlledCheckpoints() >= #createdMarkers) then 
						if (isTimer(timeElementProtectLaw)) then killTimer(timeElementProtectLaw) end
						timeElementProtectLaw = setTimer(function()
							setWiner("law")
							endCriminalMission()
							exports.NGCdxmsg:createNewDxMessage(thePlayer, "The law enforcement has won!", 0, 0, 200)
							setElementPosition(createdMarkers[i], -2859.68,482.32,4.38, true)
						end, timeLeftToCaptureTheShipByCops, 1)
					end 
				end
			end
		end
	end
end
addEventHandler("onElementColShapeHit", getRootElement(), checkpointhit)
for i=1, #createdMarkers do 
	--addEventHandler("onMarkerHit", createdMarkers[i], checkpointhit)
	--local col = createColSphere (0,0,0,3)
	--attachElements(col, createdMarkers[i])
	--setElementData(createdMarkers[i], "AURpirates.marker", col)
end 

--------------------END OF FUNCTIONS OF THE SCRIPT------------------------------