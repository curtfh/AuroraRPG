
local screenWidth, screenHeight = guiGetScreenSize()
local mygun = nil
local rx, ry = guiGetScreenSize()
local nX, nY = 1366, 768
local sX, sY = guiGetScreenSize()
local count = 3
local count2 = 3
local trigger = false
local canFireRockets = false
local startProtect = false
local roundTimer = {}
local theFucker = 15000
local theMarkers = {}
local mark = {}
local takenMarkers = 0
hop = nil
trueSight = false
function startCountdown(interval)
	if countdownImage and isElement(countdownImage) then destroyElement(countdownImage) end
	if isTimer(hop) then killTimer(hop) end
    countdownImage = guiCreateStaticImage((rx/2)-125, (ry/2)-80, 250, 190, "images/3.png", false)
	if not interval then interval = 2000 end
    hop = setTimer(decrementCountdown, interval, 4)
    countdownCount = 3
	startProtect = true
end

function decrementCountdown()
	countdownCount = countdownCount - 1
	if (countdownCount > 0) then
		guiStaticImageLoadImage (countdownImage, "images/"..countdownCount..".png")
	elseif (countdownCount == 0) then
		destroyElement(countdownImage)
		countdownImage = guiCreateStaticImage((rx/2)-160, (ry/2)-80, 320, 190, "images/go.png", false)
		if isTimer(roundTimer) then killTimer(roundTimer) end
		roundTimer = setTimer(finishTrials,theFucker,1)
	else
		destroyElement(countdownImage)
	end
end

theKiller = {}
Trialsg = {}
active = false
suckers = {}
targ = false

local posX = nil
local posY = nil

-- Z-rotation of the spawn
local rotZ = nil

local cameraOffsets = {
	[0] = {15,-10},
	[90] = {10,15},
	[180] = {15,10},
	[270] = {-10,-15}
}

--[[
	for pro map

local posX = 4931.6982421875
local posY = nil

-- Z-rotation of the spawn
local rotZ = 0

local cameraOffsets = {
	[0] = {15,-10},
	[90] = {10,15},
	[180] = {15,10},
	[270] = {-10,-15}
}
]]


fuck = false
addEvent("Trialsclient.prepareRound", true)
function prepareRound(vehicles)
    -- init countdown
	addEventHandler( 'onClientPreRender', root, cameraAndBlock )
	startProtect = true
	toggleControl( 'vehicle_left', false );
	toggleControl( 'vehicle_right', false );
	setPedCanBeKnockedOffBike(localPlayer,false)
	fuck = false
    startCountdown(1000)
	-- spawn protection
    for i, vehicle in ipairs(vehicles) do
        for _,vehicle2 in ipairs(vehicles) do
            if(vehicle ~= vehicle2) then
                setElementCollidableWith(vehicle,vehicle2,false)
            end
        end
    end
end
addEventHandler("Trialsclient.prepareRound", root, prepareRound)

addEvent("AddTrialsclientCamera",true)
addEventHandler("AddTrialsclientCamera",root,function(playing)
	active = true
	suckers = playing
	setPedCanBeKnockedOffBike(localPlayer,false)
end)
addEvent("setTrialsclientCamera",true)
addEventHandler("setTrialsclientCamera",root,function()
	active = false
	trueSight = false
	removeEventHandler( 'onClientPreRender', root, cameraAndBlock )
	setPedCanBeKnockedOffBike(localPlayer,true)
	toggleControl( 'vehicle_left', true );
	toggleControl( 'vehicle_right', true );
end)

addEvent("setTrialsNitro",true)
addEventHandler("setTrialsNitro",root,function()
	local veh = getPedOccupiedVehicle(localPlayer,0)
	if veh then
		if not getVehicleUpgradeOnSlot(veh, 8) then -- Check if the vehicle has nitro installed or not
			addVehicleUpgrade(veh, 1010) -- Install the nitrous
		end
		--setVehicleNitroLevel(veh, 1)
		--setVehicleNitroActivated(veh, true)
	end
end)

addEventHandler("onClientRender", getRootElement(),function()
	if getElementDimension(localPlayer) == 5005 then
		setPedWeaponSlot(localPlayer,0)
		setElementHealth(localPlayer,100)
		if not isPedInVehicle(localPlayer) then
			if active == true then
				dxDrawText("Please wait...\nGame in progress", 0, 0, screenWidth, screenHeight-250, tocolor(255,255,255),2,"default-bold","center","center")
			end
		end
		if isPedInVehicle(localPlayer) then
			if theMarkers then
				dxDrawText(takenMarkers.."/"..theMarkers, 0, 0, screenWidth, screenHeight+250, tocolor(255,255,255),2,"default-bold","center","center")
			end
			if isTimer(roundTimer) then
				local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( roundTimer )
				local timeLeft = math.floor(timeLeft / 1000)
				if timeLeft > 0 then
					dxDrawText ( "Pick the checkpoints in "..tostring(timeLeft).." seconds!", 0, 0, screenWidth, screenHeight+350, tocolor(255,255,255), 1.5, "default", "center", "center" )
				end
			end
		end
		for k, theVehicle in ipairs ( getElementsByType ( "vehicle",resourceRoot ) ) do
			if getElementDimension(theVehicle) == 5005 then
				if ( math.floor( getElementHealth( theVehicle ) ) <= 250 ) then
					setVehicleDamageProof( theVehicle, true )
					setVehicleEngineState ( theVehicle, false )
					setElementHealth(theVehicle,250)
				end
			end
		end
	end
end)




addEventHandler ( "onClientVehicleExplode", root,function (atk,wep,loss)
	if getElementDimension(source) == 5005 then
		cancelEvent()
	end
end)
ifWTF = {}

addEventHandler("onClientVehicleDamage", root,
function(attacker, weapon)
	if getElementDimension(source) == 5005 then
		cancelEvent()
		local hp = math.floor(getElementHealth(source))
		setElementHealth(source,hp-2)
		if math.floor(getElementHealth(source)) <= 250 then
			triggerServerEvent("setTrialsVehicleHealth",localPlayer,source,nil)
		end
	end
end)

addEvent("Trialsclient.gameStopSpawnProtection", true)
function stopSpawnProtection(vehicles)
    canFireRockets = true
	startProtect = false

end
addEventHandler("Trialsclient.gameStopSpawnProtection", root, stopSpawnProtection)



function gameTick()

end

local roundWinner = false

addEvent("Trialsclient.roundWon", true)
function onRoundWon()
    if(getElementDimension(localPlayer) ~= 5005) then return false end
    roundWinner = source
    addEventHandler("onClientRender", root, renderWinner)
end
addEventHandler("Trialsclient.roundWon", root, onRoundWon)

addEvent("Trialsclient.roundEnd", true)
addEvent("onPlayerExitRoom", true)
function onRoundEnd()
    if(roundWinner) then
        removeEventHandler("onClientRender", root, renderWinner)
    end
    roundWinner = false
end
addEventHandler("Trialsclient.roundEnd", root, onRoundEnd)
addEventHandler("onPlayerExitRoom", localPlayer, onRoundEnd)


function renderWinner()
	if getElementDimension(localPlayer) == 5005 then
		if(isElement(roundWinner)) then
			local name = getPlayerName(roundWinner)
			dxDrawText("Winner:\n\n"..name, 0, 0, screenWidth, screenHeight, tocolor(math.random(0,255),math.random(0,255),math.random(0,255)),4,"default-bold","center","center")
		end
    end
end

function findPointFromDistanceRotation(x,y, angle, dist)
    local angle = math.rad(angle+90)
    return x+(dist * math.cos(angle)), y+(dist * math.sin(angle))
end


addEvent("Trialsclient.playerWasted", true)
function onPlayerWasted(rank, timex, nick,byw)
	if byw == "" or byw == nil then
		outputChatBox("[ "..rank.." ] "..nick.." | "..timex,0,255,0)
	else
		outputChatBox("[ "..rank.." ] "..byw.." has killed "..nick.." | "..timex,0,255,0)
	end
end
addEventHandler("Trialsclient.playerWasted", root, onPlayerWasted)

addEvent("Trialsclient.freezeCamera", true)
function freezeCamera()
    local x,y,z,lx,ly,lz,roll,fov = getCameraMatrix()
    setCameraMatrix(x,y,z+50,lx,ly,lz,roll,fov)
end
addEventHandler("Trialsclient.freezeCamera", localPlayer, freezeCamera)

addEvent("loadTrialsMap",true)
addEventHandler("loadTrialsMap",root,function(temp,map)
	if temp then
		if unloaTrialsap() then
			if map == "ThePrime" then
				posX = 4931.6982421875
				posY = nil
				rotZ = 0
				theFucker = 20000
			elseif map == "SuperPrime" then
				posX = nil
				posY = -3089
				rotZ = 270
				theFucker = 20000
			elseif map == "HungryRabbit" then
				posX = 2596.7
				posY = nil
				rotZ = 0
				theFucker = 20000
			end
			trueSight = true
			--local ob = createObject(3406,3758.67,-3089.04,17.15)
			--setElementDimension(ob,5005)

			local tob = createObject(16367,4931.63,-2892.5,344,0,0,-80)
			setElementDimension(tob,5005)
			for k,v in ipairs(temp) do
				local obj = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
				setElementDimension(obj, 5005)
				setObjectScale(obj,v[8])
				--engineSetModelLODDistance ( v[1], 500 )
				--if getElementModel(obj) == 8558 then
				--	setElementAlpha (obj, 0)
				--end
			end
			outputDebugString("This is trials temp "..#temp)
		end
	else
		outputChatBox("invalid map")
	end
end)

function cameraAndBlock()
	if getElementDimension(localPlayer) == 5005 then
		--if trueSight == true then
			local bike = getPedOccupiedVehicle( localPlayer );
			if bike then
				local x, y, z = getElementPosition( bike );
				local rx, ry, rz = getElementRotation( bike );
				setElementPosition( bike, posX or x, posY or y, z );
				setElementRotation( bike, rx, 0, rotZ );
				setCameraMatrix( x + cameraOffsets[rotZ][1], y + cameraOffsets[rotZ][2], z + 10, x, y, z );
			end
		--end
	end
end

--[[
elevatorobject01 = createObject (988, 457.9, -3089, 2.5, 90, 0, 270)
elevatorcol01 = createColSphere (456.2, -3089, 3.2, 3)
setElementDimension(elevatorobject01,5005)
setElementDimension(elevatorcol01,5005)

function elevator01 (theElement,matchingDimensions)
	if matchingDimensions then
		if theElement == getLocalPlayer() then
			destroyElement (elevatorcol01)
			setTimer (moveObject, 500, 1, elevatorobject01, 4500, 457.9, -3089, 7, 0 ,0 ,0)

			setTimer ( function ()
				setTimer (moveObject, 500, 1, elevatorobject01, 4500, 457.9, -3089, 2.5, 0 ,0 ,0)
				shadeobject01 = createObject (8558, 448, -3089, 5.4, 0, 0, 0)
				setElementAlpha (shadeobject01, 0)
			end, 7500, 1)
		end
	end
end
addEventHandler("onClientColShapeHit", elevatorcol01, elevator01)
]]

function createWires ()
	if getElementDimension(localPlayer) == 5005 then
		dxDrawLine3D (760, -3089, 39, 760, -3089, 43.5, tocolor (84, 84, 84, 255), 5)
		dxDrawLine3D (760, -3089, 43.5, 760, -3039, 43.5, tocolor (84, 84, 84, 255), 5)

		dxDrawLine3D (760, -3089, 39, 749.4, -3087.5, 30.4, tocolor (84, 84, 84, 255), 5)
		dxDrawLine3D (760, -3089, 39, 749.4, -3090.5, 30.4, tocolor (84, 84, 84, 255), 5)
		dxDrawLine3D (760, -3089, 39, 769.9, -3090.5, 36, tocolor (84, 84, 84, 255), 5)
		dxDrawLine3D (760, -3089, 39, 769.9, -3087.5, 36, tocolor (84, 84, 84, 255), 5)

	end
end
addEventHandler("onClientRender", getRootElement(), createWires)



function unloaTrialsap()
	for k, v in ipairs(getElementsByType("object",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5005 then
				destroyElement(v)
			end
		end
	end
	trueSight = false
	return true
end

addEvent("loadTrialsMapMarker",true)
addEventHandler("loadTrialsMapMarker",root,function(temp,map)
	if temp then
		if unloaTrialsapMarker() then
			mark = {}
			local i = 0
			for k,v in ipairs(temp) do
				local obj = createMarker(v[2],v[3],v[4],v[1],v[5],math.random(2,255),math.random(2,255),math.random(2,255),255)
				setElementDimension(obj, 5005)
				i = i+1
				outputDebugString(i)
				mark[obj] = i
				addEventHandler("onClientMarkerHit",obj, hitMarker)
			end
			takenMarkers = 0
			theMarkers = #temp
		end
	end
end)


function hitMarker(player,dim)
	if dim then
		if getElementType(player)=="player" then
			local vehicle = getPedOccupiedVehicle(player)
			if vehicle then
				if mark[source] ~= theMarkers then
					if isTimer(roundTimer) then
						local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( roundTimer )
						killTimer(roundTimer)
						roundTimer = setTimer ( finishTrials, timeLeft+theFucker, 1)
					else
						roundTimer = setTimer ( finishTrials, theFucker, 1)
					end
					takenMarkers = takenMarkers+1
					mark[source] = nil
					destroyElement(source)
				else
					mark[source] = nil
					destroyElement(source)
					if isTimer(roundTimer) then
						killTimer(roundTimer)
					end
					forceWinning()
				end
			end
		end
	end
end

function forceWinning()
	outputChatBox("Won")
end

function finishTrials()
	outputChatBox("Lost")
end

function unloaTrialsapMarker()
	for k, v in ipairs(getElementsByType("marker",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5005 then
				destroyElement(v)
			end
		end
	end
	return true
end
showModel = {}
addEvent("loadTrialsMapVehicles",true)
addEventHandler("loadTrialsMapVehicles",root,function(temp,map)
	if temp then
		if unloadTrialsMapVehicles() then
			for k,v in ipairs(temp) do
				local veh = createVehicle(v[1],v[2],v[3],v[4])
				showModel[veh] = true
				setElementDimension(obj, 5005)
			end
		end
	end
end)



function unloadTrialsMapVehicles()
	for k, v in ipairs(getElementsByType("vehicle",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5005 and showModel[v] then
				destroyElement(v)
				showModel[v] = nil
			end
		end
	end
	return true
end


