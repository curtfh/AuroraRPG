--[[
Server: AuroraRPG
Resource Name: Races
Version: 1.0
Developer/s: Curt
]]--

--Maps List
local race_map_list = { "map1", "map2", "map3", "map4" }

--Variables
local mapSelected
local waitingEnabled
local waitingMarker
local waitingTimer
local waitingTimerStartup
local waitingBlip
local waitingRacers = {}
local playerRacers
local mapData
local countdownTimer
local countdown
local countdownTimer1
local raceStarted
local ticks

--Settings
local awardmoney = math.random(25000,150000)

--Functions
function formatTime(miliSeconds)
	if miliSeconds >= 60000 then
		local plural = ''
			if math.floor((miliSeconds/1000)/60) >= 2 then
				plural = 's'
			end	
		return tostring(math.floor((miliSeconds/1000)/60) .. " minute" .. plural)
	else
		local plural = ''
		if math.floor((miliSeconds/1000)) >= 2 then
			plural = 's'
		end	
		return tostring(math.floor((miliSeconds/1000)) .. " second" .. plural)
	end
end

function startWaitingMode()
	if (waitingEnabled or playerRacers) then 
		return false
	end
	
	mapSelected = race_map_list[math.random(#race_map_list)]
	if (fileExists("maps/"..mapSelected..".json")) then 
		local file = fileOpen("maps/"..mapSelected..".json")
		local markerRaceTable = fromJSON(fileRead(file, fileGetSize(file)))
		waitingMarker = createMarker(markerRaceTable[1][1], markerRaceTable[1][2], markerRaceTable[1][3]-1, "checkpoint", 8, 255, 0, 0, 130)
		setMarkerTarget (waitingMarker, markerRaceTable[2][1], markerRaceTable[2][2], markerRaceTable[2][3]-1)
		waitingBlip = createBlipAttachedTo(waitingMarker, 19)
		setBlipSize (waitingBlip, 4)
		waitingEnabled = true
		
		addEventHandler ( "onMarkerHit", waitingMarker, onWaitingMarkerHit, false )
		addEventHandler ( "onMarkerLeave", waitingMarker, onWaitingMarkerLeave, false )
		waitingTimerStartup = setTimer (onWaitingStop, 300000, 1)
		
		for i=1, #getElementsByType("player") do 
			exports.NGCdxmsg:createNewDxMessage(getElementsByType("player")[i], "A illegal race has been placed. You can join the race at red flag blip.", 255, 0, 0)
		end
		fileClose(file) 
	end 
end 

function raceTime(player)
	if (isTimer(waitingTimer)) then 
		local timeLeft, executeLeft, executeTotal = getTimerDetails (waitingTimer) 
		local timeLeft = formatTime(timeLeft)
		exports.NGCdxmsg:createNewDxMessage(player,  tostring( timeLeft ).." left before illegal race starts.", 255, 0, 0)
	elseif (isTimer (waitingTimerStartup)) then 
		local timeLeft, executeLeft, executeTotal = getTimerDetails (waitingTimerStartup) 
		local timeLeft = formatTime(timeLeft)
		exports.NGCdxmsg:createNewDxMessage(player, tostring(timeLeft).." left before the illegal race registration ends.", 255, 0, 0)
	elseif playerRacers then
		exports.NGCdxmsg:createNewDxMessage(player, "There is a illegal race going on right now!", 255, 0, 0)
	end
end
addCommandHandler ( "iracetime", raceTime, false, false )

function onWaitingMarkerLeave (hitElement)
	if getElementType ( hitElement ) ~= "player" then return end
	
	if getElementData(hitElement, "aurillegalraces.waiting") == nil then return end 
	
	if (not getPedOccupiedVehicle(hitElement)) then return end 
	
	for i=1, #waitingRacers do
		while waitingRacers[i] == hitElement do 
			table.remove(waitingRacers, i) 
			exports.NGCdxmsg:createNewDxMessage(hitElement, "You left the illegal race event.", 255, 0, 0)
		end 
	end 
	
	
end 

function onWaitingMarkerHit (hitElement)
	if getElementType ( hitElement ) ~= "player" then return end
	
	if getElementData(hitElement, "aurillegalraces.waiting") == nil then return end 
	
	if (not getPedOccupiedVehicle(hitElement)) then 
	exports.NGCdxmsg:createNewDxMessage(hitElement, "You must have a vehicle to join this race.", 255, 0, 0)
	return
	end 

	if getVehicleController(getPedOccupiedVehicle(hitElement)) ~= hitElement then return end 
	
	if (getVehicleType(getPedOccupiedVehicle(hitElement)) ~= "Automobile") then
		exports.NGCdxmsg:createNewDxMessage(hitElement, "This race doesn't allow "..getVehicleType(getPedOccupiedVehicle(hitElement))..". Please get a autombile.", 255, 0, 0)
		return
	end 
	
	if (getTeamName(getPlayerTeam(hitElement)) ~= "Criminals")  then 
		exports.NGCdxmsg:createNewDxMessage(hitElement, "You must be a criminal to join this race.", 255, 0, 0)
		return
	end
	
	table.insert(waitingRacers, hitElement)
	setElementData(hitElement, "aurillegalraces.waiting", true)
	exports.NGCdxmsg:createNewDxMessage(hitElement, "You joined the illegal race. Please don't leave the marker.", 255, 0, 0)		
end 

function getPlayersWaiting()
	local newPlayers = {}
	for i=1, #waitingRacers do
		if isElement ( waitingRacers[i] ) then
			if not isPedDead (waitingRacers[i]) and getPedOccupiedVehicle (waitingRacers[i]) and getVehicleController (getPedOccupiedVehicle ( waitingRacers[i])) == waitingRacers[i] then
				local playerTeamName = getTeamName (getPlayerTeam(waitingRacers[i]))
				--if playerTeamName == "Criminals" then						
					table.insert (newPlayers, waitingRacers[i])
				--end
			end
			setElementData (waitingRacers[i], "aurillegalraces.waiting", false)
		end
	end
	return newPlayers
end

function onWaitingStop ()
	if (#waitingRacers <= 2) then 
		destroyElement(waitingBlip)
		destroyElement(waitingMarker)
		waitingTimer = setTimer (startWaitingMode, 1800000, 1)
		waitingEnabled = false
		for i=1, #waitingRacers do 
			if not isElement(waitingRacers[i]) then 
				return
			end 
			setElementData(waitingRacers[i], "aurillegalraces.waiting", false)
			exports.NGCdxmsg:createNewDxMessage(waitingRacers[i], "Not enough players to start the race. 3 or more players needed.", 255, 0, 0)		
		end 
	else
	destroyElement (waitingBlip)
	destroyElement (waitingMarker)
	setRaceSettings (mapSelected)
	end 
end 

function setRaceSettings (map)
	if (playerRacers) then 
		return false
	end
	if (fileExists("maps/"..map..".json")) then 
		setElementData(root, "aurillegalraces.started", true)
		local mapFile = fileOpen("maps/"..map..".json")
		fileSetPos(mapFile, 0)
		local mapDataLoad = fileRead(mapFile, fileGetSize(mapFile))
		mapData = fromJSON(mapDataLoad)
		fileClose(mapFile)
		playerRacers = getPlayersWaiting()
		local lineCars =  0
		for i=1, #playerRacers do
			setElementData ( playerRacers[i], "aurillegalraces.isFinished", false ) 
			triggerClientEvent ( playerRacers[i], "aurillegalraces.startPreRace", playerRacers[i], map, mapDataLoad, playerRacers )
		end
		setElementData(root, "aurillegalraces.countdown", false)
		countdownTimer = setTimer(startCountdown, 4000, 1)
	end 
end 

function startCountdown()
	if (not playerRacers) then 
		return false
	end 
	countdownTime = 5
	countdownGoDisplayTime = 2
	setElementData(root, "aurillegalraces.countdown", countdownTime)
	countdownTimer1 = setTimer(function()
		if (playerRacers) then 
			countdownTime = countdownTime-1
			if (countdownTime == 0) then 
				if not raceStarted then 
					startRace()
				end 
				setTimer ( setElementData, countdownGoDisplayTime*1000, 1, root, "aurillegalraces.countdown", false  )
			end 
			for i=1, #playerRacers do
				if isElement(playerRacers[i]) then	
					if (countdownTime <= 0) then 
						exports.NGCdxmsg:createNewDxMessage(waitingRacers[i], "Go!", 255, 255, 255)		
					else 	
						exports.NGCdxmsg:createNewDxMessage(waitingRacers[i], "The illegal race starts in "..countdownTime, 255, 0, 0)		
					end 
					
				end		
			end
		end
	end, 1000, countdownTime+1)
end

function startRace()
	ticks = getTickCount ()
	for i=1, #playerRacers do
		setElementFrozen  (playerRacers[i], false)
		setElementFrozen  (getPedOccupiedVehicle(playerRacers[i]) or playerRacers[i], false)
		triggerClientEvent (playerRacers[i], "aurillegalraces.startRace", playerRacers[i], ticks)
		exports.NGCdxmsg:createNewDxMessage(playerRacers[i], "You have given 3 points for participating the illegal race.", 255, 0, 0)		
		exports.CSGscore:givePlayerScore(playerRacers[i], 3)
		exports.server:givePlayerWantedPoints(playerRacers[i], 50)
	end
	raceStarted = true
	addEventHandler ("aurillegalraces.onPlayerFinish", root, onPlayerFinish)
end

function onPlayerFinish ()
	exports.AURpayments:addMoney(source, awardmoney, "Custom", "Racing", 0, "AURillegalraces")
	exports.AURscore:givePlayerScore(source, 30)
	exports.NGCdxmsg:createNewDxMessage(source, "You won the race!", 255, 0, 0)		
	exports.AURcriminalp:giveCriminalPoints(source, "Race", 5)
	for i=1, #playerRacers do
		if isElement(playerRacers[i]) then	
			exports.NGCdxmsg:createNewDxMessage(waitingRacers[i], getPlayerName(source).." has finished the illegal race!", 255, 0, 0)		
		end		
	end
	stopRace()
end
addEvent ( "aurillegalraces.onPlayerFinish", true )

function stopRace()
	if (playerRacers) then
		for i=1, #playerRacers do	
			setElementData ( playerRacers[i], "aurillegalraces.isFinished", false ) 
			setElementData ( playerRacers[i], "aurillegalraces.waiting", false ) 
			if isElement ( playerRacers[i]) then		
				triggerClientEvent ( playerRacers[i], "aurillegalraces.stopRace", playerRacers[i] )
			end	
		end
		setElementData ( root, "aurillegalraces.started", false ) 
		playerRacers = {}
		mapData = nil
		mapSelected = nil
		raceStarted = nil
		waitingRacers = {}
		waitingEnabled = false
		ticks = nil
		removeEventHandler ( "aurillegalraces.onPlayerFinish", root, onPlayerFinish )
		if isTimer (countDownTimer1) then killTimer (countDownTimer1) end
		if isTimer (countDownTimer) then killTimer (countDownTimer) end
		if isTimer (waitingTimer) then killTimer (waitingTimer) end
		if isTimer (waitingTimerStartup) then killTimer (waitingTimerStartup) end
		setElementData (root, "aurillegalraces.countdown", false) 
		waitingTimer = setTimer (startWaitingMode, 1800000, 1)
	end
end

addEventHandler ("onResourceStart", resourceRoot, startWaitingMode)