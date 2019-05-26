--[[
Server: AuroraRPG
Resource Name: Races
Version: 1.0
Developer/s: Curt
]]--

function createRaceMarkerForCheckpoint(checkpoint, index, numberOfCheckpoints)
	local r,g,b, a = 255, 0, 0, 110
	local x,y,z = checkpoint[1], checkpoint[2], checkpoint[3]
	local hitMarkerSize = 17
	local visualMarkerSize = 6
	if (index == 1) then 		
		r,g,b = 0, 0, 255 	
	elseif (index == numberOfCheckpoints) then 		
		r,g,b = 0, 255, 0 
		hitMarkerSize = 17
		visualMarkerSize = 10	
	end	
	local hitMarker
	if (not editingTrack and not loadingTrack) then	
		hitMarker = createMarker (x, y, z, "checkpoint", 20 , 0, 0, 0, 0)
		setMarkerSize (hitMarker, -hitMarkerSize)		
	end		
	local visualMarker = createMarker (x, y, z, "checkpoint", visualMarkerSize , r, g, b, a)
	setElementData (visualMarker, "markerSize", visualMarkerSize)	
	return hitMarker, visualMarker
end

addEvent ("aurillegalraces.startPreRace", true)
function startRacePre (raceName, checkpoints, racers)
	if (not racing) then
		if (isElement (GUI_manageRaceButton_toggleRace)) then
			guiSetText (GUI_manageRaceButton_toggleRace, "Stop Race")
		end
		race_racers = racers
		checkpoints = fromJSON (checkpoints)
		racing = true
		addEventHandler ("onClientPlayerQuit", root, onRacerQuit)
		if (playerGodMode) then
			removeEventHandler ("onClientPlayerDamage", localPlayer, cancelDamage, false)
			playerGodMode = false
		end
		race_checkpointsData = checkpoints
		race_checkpoints = {}
		startRaceticks = false
		race_checkpoints_hit = {}
		playerFinished = false
		setElementData (localPlayer ,"aurillegalraces.checkpointIndexLastHit", 0)
		for i=1, #race_checkpointsData do	
			local hitMarker, visualMarker = createRaceMarkerForCheckpoint (race_checkpointsData[i], i, #race_checkpointsData)
			adjustElementProperties (visualMarker, i, #race_checkpointsData)
			if (i == 1) then
				local blip = createBlipAttachedTo (visualMarker, 0)
				adjustElementProperties (visualMarker, i, #race_checkpointsData)
				if (#race_checkpointsData > 2) then			
					local x2,y2,z2 = race_checkpointsData[i+1][1], race_checkpointsData[i+1][2], race_checkpointsData[i+1][3]
					setMarkerTarget (visualMarker, x2, y2, z2)
					table.insert (race_checkpoints, { hitMarker, visualMarker, blip, arrowObject })				
				else				
					table.insert (race_checkpoints, { hitMarker, visualMarker, blip })					
				end
			elseif (i == 2) then
				local blip = createBlipAttachedTo (visualMarker, 0)
				adjustElementProperties (visualMarker, i, #race_checkpointsData)
				table.insert (race_checkpoints, { hitMarker, visualMarker, blip })				
				setMarkerSize (visualMarker, -6)
			else		
				table.insert (race_checkpoints, { hitMarker, visualMarker })
				setMarkerSize (visualMarker, -6)				
			end	
		end			
		if (isElementWithinMarker (localPlayer, race_checkpoints[1][2]) or isElementWithinMarker (getPedOccupiedVehicle (localPlayer), race_checkpoints[1][2])) then	
			race_onMarkerHit(localPlayer, hitMarker)				
		end						
		rankString = ""
		addEventHandler ("onClientPlayerWasted", localPlayer, onPlayerWasted, false)
		countdownRGB = { math.random (0, 255), math.random (0, 255), math.random (0, 255) }
		setElementFrozen (getPedOccupiedVehicle (localPlayer) or localPlayer, true) 		
		if (not drawingRaceGUI) then
			drawingRaceGUI = true
		end
		setPedCanBeKnockedOffBike (localPlayer, false)
		toggleControl ("accelerate", false)
		toggleControl ("brake_reverse", false)
		toggleControl ("vehicle_left", false)
		toggleControl ("vehicle_right", false)
		if (editingTrack) then	
			trackEditor_saveTrack ("GUI", true)
			trackEditor_closeTrack()			
		end
		if (isTimer (changeCountDownColorTimer)) then killTimer (changeCountDownColorTimer) end
		changeCountDownColorTimer = setTimer (
			function () 
			countdownRGB = { math.random (0, 255), math.random (0, 255), math.random (0, 255) } end
		, math.random (100, 250), 0)
		drawPositions = false		
	end
end
addEventHandler ("aurillegalraces.startPreRace", root, startRacePre)

addEvent ("aurillegalraces.startRace", true)
function startRace (raceStartTicks)
	if (not raceStarted) then
		startRaceticks = getTickCount()	
		if (isElement (race_checkpoints[1][1])) then	
			addEventHandler ("onClientMarkerHit", race_checkpoints[1][1], race_onMarkerHit, false)
			addEventHandler ("onClientMarkerHit", race_checkpoints[1][2], race_onMarkerHit, false)					
		end
		raceStarted = true
		toggleControl ("accelerate", true)
		toggleControl ("brake_reverse", true)
		toggleControl ("vehicle_left", true)
		toggleControl ("vehicle_right", true)
		if (isTimer (changeCountDownColorTimer)) then killTimer (changeCountDownColorTimer) end	
	end
end
addEventHandler ("aurillegalraces.startRace", root, startRace)

addEvent ("aurillegalraces.stopRace", true)
function stopRace ()
	if (racing) then
		racing = false
		removeEventHandler ("onClientPlayerQuit", root, onRacerQuit)
		raceStarted = false
		race_racers = nil
		updateRanksTimer = nil
		rankString = nil
		removeEventHandler ("onClientPlayerWasted", localPlayer, onPlayerWasted, false)
		for i=1, #race_checkpoints do	
			for index=1, #race_checkpoints[i] do		
				if (isElement(race_checkpoints[i][index])) then			
					destroyElement (race_checkpoints[i][index])				
				end		
			end	
		end
		playerFinished = false
		startRaceticks = false
		setElementData (localPlayer ,"aurillegalraces.checkpointIndexLastHit", false)
		race_checkpointsData = nil
		race_checkpoints = nil
		race_checkpoints_hit = nil
		inSpectatorMode = false
		if (getPedOccupiedVehicle (localPlayer)) then
			setVehicleDamageProof (getPedOccupiedVehicle (localPlayer), false)
			setElementFrozen (getPedOccupiedVehicle (localPlayer), false)		
		end	
		if (drawingRaceGUI) then
			drawingRaceGUI = false
		end
		setElementFrozen (localPlayer, false)
		setPedCanBeKnockedOffBike (localPlayer, true)
		toggleControl ("accelerate", true)
		toggleControl ("brake_reverse", true)
		toggleControl ("vehicle_left", true)
		toggleControl ("vehicle_right", true)
		fadeCamera (true)
		if (isTimer (changeCountDownColorTimer)) then killTimer (changeCountDownColorTimer) end
		setElementData (localPlayer, "aurillegalraces.isFinished", false)
		drawPositions = false	
	end
end
addEventHandler ("aurillegalraces.stopRace", root, stopRace)

function distanceFromPlayerToCheckpoint (player, checkpointIndex)
	if (race_checkpoints[checkpointIndex + 1]) then
		local px, py, pz = getElementPosition (player)
		local cx, cy, cz = getElementPosition (race_checkpoints[checkpointIndex + 1][1])	
		return getDistanceBetweenPoints3D (px, py, pz, cx, cy, cz)
	end
end

function race_onMarkerHit(hitElement, marker)
if (not source) then source = marker end
	if (hitElement == localPlayer) then
		local visualMarker
		local newIndex
		for i=1, #race_checkpoints do		
			if (race_checkpoints[i][source]) then		
				visualMarker = race_checkpoints[i][2]
				newIndex = i			
			elseif (race_checkpoints[i][2] == source) then		
				visualMarker = source
				source = race_checkpoints[i][1]
				newIndex = i						
			end			
		end		 
		if (not race_checkpoints_hit[source]) then
			local oldIndex = getElementData (localPlayer ,"aurillegalraces.checkpointIndexLastHit")
			local newIndex = oldIndex + 1
			local nextMarkerIndex = newIndex + 1		
			setElementData (localPlayer ,"aurillegalraces.checkpointIndexLastHit", newIndex)
			table.insert (race_checkpoints_hit, source)
			if (newIndex == #race_checkpoints) then
				race_onHitFinish()
				removeEventHandler ("onClientMarkerHit", race_checkpoints[newIndex][1], race_onMarkerHit, false)
			else 		
				for i=1, newIndex do			
					for ind=1, #race_checkpoints[i] do				
						if (isElement (race_checkpoints[i][ind])) then					
							destroyElement (race_checkpoints[i][ind])							
						end								
						if (isElement (race_checkpoints[i][ind])) then					
							table.remove (race_checkpoints[i], ind)						
						end					
					end					
				end				
				local blip = createBlipAttachedTo (race_checkpoints[nextMarkerIndex][1], 0)
				adjustElementProperties (blip, nextMarkerIndex, #race_checkpoints)
				table.insert (race_checkpoints[nextMarkerIndex], blip)				
				addEventHandler ("onClientMarkerHit", race_checkpoints[nextMarkerIndex][1], race_onMarkerHit, false)
				setMarkerSize (race_checkpoints[nextMarkerIndex ][2], getElementData (race_checkpoints[nextMarkerIndex ][2], "markerSize"))
				if (nextMarkerIndex+1 <= #race_checkpoints) then			
					local blip = createBlipAttachedTo (race_checkpoints[nextMarkerIndex + 1][1], 0)
					adjustElementProperties (blip, nextMarkerIndex+1, #race_checkpoints)				
					table.insert (race_checkpoints[nextMarkerIndex + 1 ], blip)						
					local x2,y2, z2 = getElementPosition (race_checkpoints[nextMarkerIndex + 1][1])
					setMarkerTarget (race_checkpoints[nextMarkerIndex][2], x2, y2, z2)		
				end	
			end
		end
	end
end

function race_onHitFinish()
	triggerServerEvent ("aurillegalraces.onPlayerFinish", localPlayer)
	playerFinished = true
end

function onRacerQuit ()
	if (race_racers[source]) then		
		for i=1,#race_racers do		
			if (source == race_racers[i]) then		
				table.remove (race_racers, i)
			end			
		end		
	end
end
addEventHandler ("onClientResourceStop", getResourceRootElement(getThisResource()), 

function () 
	toggleControl ("accelerate", true)
	toggleControl ("brake_reverse", true)
	toggleControl ("vehicle_left", true)
	toggleControl ("vehicle_right", true)
	setCameraTarget (localPlayer)
	stopRace()
	setElementData (localPlayer, "aurillegalraces.isSignedUp", false) 
	if (getPedOccupiedVehicle (localPlayer)) then
		setVehicleDamageProof (getPedOccupiedVehicle (localPlayer), false)
		setElementFrozen (getPedOccupiedVehicle (localPlayer), false)	
	end
	setElementFrozen (localPlayer, false)	
end
)

function onPlayerWasted ()
	if (racing) then	
		stopRace()		
	end	
end

function isPedDead (ped)
	if (isElement (ped)) then	
		return getElementHealth (ped) <=0		
	end
end

function adjustElementProperties (element, index, maximum)
	if (getElementType (element) == "marker" and getElementData (element, "markerSize")) then	
		local r,g,b, a = 255, 0, 0, 110
		local visualMarkerSize = 6
		if (index == 1) then 	
			r,g,b = 0, 0, 255 	
		elseif (index == maximum) then 	
			r,g,b = 0, 255, 0 
			visualMarkerSize = 10	
		end
		setMarkerColor (element, r, g, b, a)
		setMarkerSize (element, visualMarkerSize)
		setElementData (element, "markerSize", visualMarkerSize)
	elseif (getElementType (element) == "blip") then
		local r,g,b = 4, 255, 0
		local blipSize = 4
		local blipIcon = 0		
		if (index ~= 1 and maximum == index) then	
			blipIcon = 53	
		elseif (index == 1) then		
			r,g,b = 0,0,255
		end			
		setBlipSize (element, blipSize)
		setBlipIcon (element, blipIcon)
		setBlipColor (element, r, g, b, 255)
	end
end