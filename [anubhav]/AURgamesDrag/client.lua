
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
proTimer = {}
hop = nil
function startCountdown(interval,ve)
	if countdownImage and isElement(countdownImage) then destroyElement(countdownImage) end
	if isTimer(hop) then killTimer(hop) end
    countdownImage = guiCreateStaticImage((rx/2)-125, (ry/2)-80, 250, 190, "images/3.png", false)
	if not interval then interval = 2000 end
    hop = setTimer(decrementCountdown, interval, 4,ve)
    countdownCount = 3
	startProtect = true
end

function decrementCountdown(ve)
	countdownCount = countdownCount - 1
	if (countdownCount > 0) then
		guiStaticImageLoadImage (countdownImage, "images/"..countdownCount..".png")
	elseif (countdownCount == 0) then
		destroyElement(countdownImage)
		countdownImage = guiCreateStaticImage((rx/2)-160, (ry/2)-80, 320, 190, "images/go.png", false)
		if isTimer(proTimer) then killTimer(proTimer) end
		proTimer = setTimer(function(vehicles)
		for i, vehicle in ipairs(vehicles) do
			for _,vehicle2 in ipairs(vehicles) do
				if(vehicle ~= vehicle2) then
					setElementCollidableWith(vehicle,vehicle2,true)
				end
			end
		end
		end,8000,1,ve)
	else
		destroyElement(countdownImage)
	end
end

theKiller = {}
Dragg = {}
active = false
suckers = {}
targ = false



fuck = false
addEvent("Dragclient.prepareRound", true)
function prepareRound(vehicles)
    -- init countdown
	startProtect = true
	setPedCanBeKnockedOffBike(localPlayer,false)
	fuck = false
    startCountdown(1000,vehicles)
	-- spawn protection
    for i, vehicle in ipairs(vehicles) do
        for _,vehicle2 in ipairs(vehicles) do
            if(vehicle ~= vehicle2) then
                setElementCollidableWith(vehicle,vehicle2,false)
            end
        end
    end
end
addEventHandler("Dragclient.prepareRound", root, prepareRound)

addEvent("AddDragclientCamera",true)
addEventHandler("AddDragclientCamera",root,function(playing)
	active = true
	suckers = playing
	setPedCanBeKnockedOffBike(localPlayer,false)
end)
addEvent("setDragclientCamera",true)
addEventHandler("setDragclientCamera",root,function()
	active = false
	setPedCanBeKnockedOffBike(localPlayer,true)
	resetWaterColor()
end)

addEvent("setDragNitro",true)
addEventHandler("setDragNitro",root,function()
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
	if getElementDimension(localPlayer) == 5006 then
		setPedWeaponSlot(localPlayer,0)
		setElementHealth(localPlayer,100)
		if not isPedInVehicle(localPlayer) then
			if active == true then
				dxDrawText("Please wait...\nGame in progress", 0, 0, screenWidth, screenHeight-250, tocolor(255,255,255),2,"default-bold","center","center")
			end
		end
		for k, theVehicle in ipairs ( getElementsByType ( "vehicle",resourceRoot ) ) do
			if getElementDimension(theVehicle) == 5006 then
				if ( math.floor( getElementHealth( theVehicle ) ) <= 250 ) then
					setVehicleDamageProof( theVehicle, true )
					setVehicleEngineState ( theVehicle, false )
					setElementHealth(theVehicle,250)
					--if fuck == false then
						--fuck = true
						--triggerServerEvent("setDragVehicleHealth",localPlayer,theVehicle,nil)
					--end
				end
			end
		end
	end
end)




addEventHandler ( "onClientVehicleExplode", root,function (atk,wep,loss)
	if getElementDimension(source) == 5006 then
		cancelEvent()
	end
end)
ifWTF = {}

addEvent("Dragclient.gameStopSpawnProtection", true)
function stopSpawnProtection(vehicles)
    canFireRockets = true
	startProtect = false

end
addEventHandler("Dragclient.gameStopSpawnProtection", root, stopSpawnProtection)

function gameTick()

end

local roundWinner = false

addEvent("Dragclient.roundWon", true)
function onRoundWon()
    if(getElementDimension(localPlayer) ~= 5006) then return false end
    roundWinner = source
    addEventHandler("onClientRender", root, renderWinner)
end
addEventHandler("Dragclient.roundWon", root, onRoundWon)

addEvent("Dragclient.roundEnd", true)
addEvent("onPlayerExitRoom", true)
function onRoundEnd()
    if(roundWinner) then
        removeEventHandler("onClientRender", root, renderWinner)
    end
    roundWinner = false
end
addEventHandler("Dragclient.roundEnd", root, onRoundEnd)
addEventHandler("onPlayerExitRoom", localPlayer, onRoundEnd)


function renderWinner()
	if getElementDimension(localPlayer) == 5006 then
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


addEvent("Dragclient.playerWasted", true)
function onPlayerWasted(rank, timex, nick,byw)
	if byw == "" or byw == nil then
		outputChatBox("[ "..rank.." ] "..nick.." | "..timex,0,255,0)
	else
		outputChatBox("[ "..rank.." ] "..byw.." has killed "..nick.." | "..timex,0,255,0)
	end
end
addEventHandler("Dragclient.playerWasted", root, onPlayerWasted)

addEvent("Dragclient.freezeCamera", true)
function freezeCamera()
    local x,y,z,lx,ly,lz,roll,fov = getCameraMatrix()
    setCameraMatrix(x,y,z+50,lx,ly,lz,roll,fov)
end
addEventHandler("Dragclient.freezeCamera", localPlayer, freezeCamera)

addEvent("loadDragMap",true)
addEventHandler("loadDragMap",root,function(temp,map)
	if temp then
		if unloaDragap() then
			for k,v in ipairs(temp) do
				local obj = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
				setElementDimension(obj, 5006)
				engineSetModelLODDistance ( v[1], 500 )
			end
		end
	else
		outputChatBox("invalid map")
	end
end)



showModel = {}
addEvent("loadDragMapVehicles",true)
addEventHandler("loadDragMapVehicles",root,function(temp,map)
	if temp then
		if unloadloadDragMapVehicles() then
			for k,v in ipairs(temp) do
				local veh = createVehicle(v[1],v[2],v[3],v[4])
				setElementRotation(veh,v[5],v[6],v[7])
				setElementFrozen(veh,true)
				showModel[veh] = true
				setElementDimension(veh, 5006)
			end
		end
	end
end)



function unloadloadDragMapVehicles()
	for k, v in ipairs(getElementsByType("vehicle",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5006 and showModel[v] then
				destroyElement(v)
				showModel[v] = nil
			end
		end
	end
	return true
end


function unloaDragap()
	for k, v in ipairs(getElementsByType("object",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5006 then
				destroyElement(v)
			end
		end
	end
	return true
end

local x, y = guiGetScreenSize()
local sW, sH =  (x/1280), (y/960)
local offsety = 19.2*sH
local offsetx = 12.8*sW
local speedoSize = 250*sH
local speedoTextSize = 1*sH
local showSpeedo = true
local theVehicle
local smoothedRPMRotation = 0
local fontPrototype10 = dxCreateFont("img/Prototype.ttf", 10)
local fontPrototype40 = dxCreateFont("img/Prototype.ttf", 40)
local fontLCD22 = dxCreateFont("img/lcd.ttf", 22)
local green = tocolor ( 0, 255, 0, 255 )
local yellow = tocolor ( 255, 255, 0, 255 )
local red = tocolor ( 255, 0, 0, 255 )
local vehicleRPM = 0
local playerGear = 1
local manual = false
local gear
local handling
local numberOfGears
local shiftImageSize = 100*sH


function drawSpeedo()
	if getElementDimension(localPlayer) ~= 5006 then return false end

	if getPedOccupiedVehicle(localPlayer) then
		theVehicle = getPedOccupiedVehicle(localPlayer)
	elseif getCameraTarget(localPlayer) and getElementType(getCameraTarget(localPlayer)) == "vehicle" then
		theVehicle = getCameraTarget(localPlayer)
	else
		return
	end

	dxDrawImage ( x-speedoSize-offsetx, y-speedoSize-offsety, speedoSize, speedoSize, "img/2.png", 0, 0, 0, tocolor ( 255, 255, 255, 50 ), false )
	dxDrawImage ( x-speedoSize-offsetx, y-speedoSize-offsety, speedoSize, speedoSize, "img/1.png", 0, 0, 0, tocolor ( 0, 0, 0, 255 ), false )
	dxDrawImage ( x-speedoSize-offsetx, y-speedoSize-offsety, speedoSize, speedoSize, "img/rpm.png", 0, 0, 0, tocolor ( 255, 255, 255, 255 ), false )

	for i=0, getRPMRoation(theVehicle), 3 do

		if i > 190 then
			rpmColor = red
		elseif i > 110 then
			rpmColor = yellow
		else
			rpmColor = green
		end
		dxDrawImage ( x-speedoSize-offsetx, y-speedoSize-offsety, speedoSize, speedoSize, "img/needle.png", i, 0, 0, rpmColor, false )

	end

	if not manual then
		gear = getFormattedVehicleGear(theVehicle)
	end

	if manual and getPedOccupiedVehicle(localPlayer) then

		gear = playerGear

		if playerGear == 0 then
			setVehicleEngineState(theVehicle, false)
		elseif playerGear == 1 then
			setVehicleEngineState(theVehicle, true)
			if getVehicleSpeed(theVehicle) > 35 then
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftGreen.png")
				end
			end
			if getVehicleSpeed(theVehicle) > 40 then
				setVehicleSpeed(theVehicle, 40)
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftYellow.png")
				end
			end
		elseif playerGear == 2 then
			if getVehicleSpeed(theVehicle) > 75 then
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftGreen.png")
				end
			end
			if getVehicleSpeed(theVehicle) > 80 then
				setVehicleSpeed(theVehicle, 80)
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftYellow.png")
				end
			elseif getVehicleSpeed(theVehicle) < 35 then
				local speed = getVehicleSpeed(theVehicle)
				setVehicleSpeed(theVehicle, speed-1)
			end
		elseif playerGear == 3 then
			if getVehicleSpeed(theVehicle) > 115 then
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftGreen.png")
				end
			end
			if getVehicleSpeed(theVehicle) > 120 then
				setVehicleSpeed(theVehicle, 120)
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftYellow.png")
				end
			elseif getVehicleSpeed(theVehicle) < 75 then
				local speed = getVehicleSpeed(theVehicle)
				setVehicleSpeed(theVehicle, speed-1.5)
			end
		elseif playerGear == 4 then
			if getVehicleSpeed(theVehicle) > 150 then
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftGreen.png")
				end
			end
			if getVehicleSpeed(theVehicle) > 160 then
				setVehicleSpeed(theVehicle, 160)
				if numberOfGears > playerGear then
					dxDrawImage(x/2-shiftImageSize/2, y/2-shiftImageSize/2, shiftImageSize, shiftImageSize, "img/shiftYellow.png")
				end
			elseif getVehicleSpeed(theVehicle) < 115 then
				local speed = getVehicleSpeed(theVehicle)
				setVehicleSpeed(theVehicle, speed-2)
			end
		elseif playerGear > 4 then
			if getVehicleSpeed(theVehicle) < 150 then
				local speed = getVehicleSpeed(theVehicle)
				setVehicleSpeed(theVehicle, speed-3)
			end
		end


	end


    dxDrawText(gear, x - offsetx - speedoSize/2 - dxGetTextWidth(gear, speedoTextSize, fontPrototype40)/2, y - 200*sH, x, y, tocolor(255, 255, 255, 255), speedoTextSize, fontPrototype40, "left", "top", false, false, false)

	local speed = getVehicleSpeedString(theVehicle)
	dxDrawText(speed, x - offsetx - speedoSize/2 - dxGetTextWidth(speed, speedoTextSize, fontLCD22)/2, y - 115*sH, x, y, tocolor(255, 255, 255, 255), speedoTextSize, fontLCD22, "left", "top", false, false, false)
    dxDrawText("km/h", x - 110*sH, y - 95*sH, x, y, tocolor(255, 255, 255, 255), speedoTextSize, fontPrototype10, "left", "top", false, false, false)

    local nsr, nsg, nsb = getNitroStateColor(theVehicle)
    dxDrawImage(x - 200*sH, y - 170*sH, 24*sH, 24*sH, "img/nitro.png", 0, 0, 0, tocolor(nsr, nsg, nsb, 255), false)
    local csr, csg, csb = getCarStateColor(theVehicle)
    dxDrawImage(x - 200*sH, y - 140*sH, 24*sH, 24*sH, "img/car.png", 0, 0, 0, tocolor(csr, csg, csb , 255), false)

end
addEventHandler("onClientRender", root, drawSpeedo)


function getVehicleSpeed(vehicle)

    if (vehicle) then
        local vx, vy, vz = getElementVelocity(vehicle)

        if (vx) and (vy)and (vz) then
            return math.sqrt(vx^2 + vy^2 + vz^2) * 180
        else
            return 0
        end
    else
        return 0
    end

end


function setVehicleSpeed(element, speed)

	speed = tonumber(speed)
	local acSpeed = getVehicleSpeed(element)
	if acSpeed == 0 then return end

	local diff = speed/acSpeed
	local x,y,z = getElementVelocity(element)
	setElementVelocity(element,x*diff,y*diff,z*diff)
	return true

end



function setManual()

	manual = true
	playerGear = 1
	handling = getVehicleHandling(getPedOccupiedVehicle(localPlayer))
	numberOfGears = handling["numberOfGears"]

end
addEvent("onEnableManual", true)
addEventHandler("onEnableManual", root, setManual)

function getVehicleGear(vehicle)

    if (vehicle) then
        local vehicleGear = getVehicleCurrentGear(vehicle)

        return tonumber(vehicleGear)
    else
        return 0
    end

end


function getFormattedVehicleGear(vehicle)

    local gear = getVehicleGear(vehicle)

    if (gear > 0) then
        return gear
    else
        return "R"
    end

end



function getVehicleRPM(vehicle)

	if (getVehicleEngineState(vehicle) == true) then
		if(getVehicleGear(vehicle) > 0) then
			vehicleRPM = math.floor(((getVehicleSpeed(vehicle)/getVehicleGear(vehicle))*180) + 0.5)

			if (vehicleRPM < 650) then
				vehicleRPM = math.random(650, 750)
			elseif (vehicleRPM >= 9800) then
				vehicleRPM = 9800
			end
		else
			vehicleRPM = math.floor(((getVehicleSpeed(vehicle)/1)*180) + 0.5)

			if (vehicleRPM < 650) then
				vehicleRPM = math.random(650, 750)
			elseif (vehicleRPM >= 9800) then
				vehicleRPM = 9800
			end
		end
	else
		vehicleRPM = 0
	end

	return tonumber(vehicleRPM)

end


function getRPMRoation(vehicle)

    if (getVehicleRPM(vehicle)) and (getVehicleRPM(vehicle) >= 0) then
    local rpmRotation = math.floor(((270/10000)* getVehicleRPM(vehicle)) + 0.5)

        if (smoothedRPMRotation < rpmRotation) then
            smoothedRPMRotation = smoothedRPMRotation + 2
        end

        if (smoothedRPMRotation > rpmRotation) then
            smoothedRPMRotation = smoothedRPMRotation - 2
        end

        return tonumber(smoothedRPMRotation)
    else
        return 0
    end
end


function getCarStateColor(vehicle)
    local health = getElementHealth(vehicle)

    if (health) then
        local g = (255/1000) * health
        local r = 255 - g
        local b = 0

        return r, g, b
    else
        return 0, 255, 0
    end
end


function getVehicleSpeedString(vehicle)
    local speedString = math.floor(getVehicleSpeed(vehicle) + 0.5)
    return string.format("%03d", speedString)
end


function getNitroStateColor(vehicle)
    local nitro = getVehicleUpgradeOnSlot(vehicle, 8)

    if (nitro > 0) then
        return 0, 255, 0
    else
        return 75, 75, 75
    end
end


function setPlayerGear( key )
	if getElementDimension(localPlayer) == 5006 then
	if key == "num_add" then
		outputDebugString(playerGear)
		if playerGear == 1 then
			playerGear = 2
			playSoundFrontEnd( 4 )
		elseif playerGear == 2 then
			playerGear = 3
			playSoundFrontEnd( 4 )
		elseif playerGear == 3 then
			playerGear = 4
			playSoundFrontEnd( 4 )
		elseif playerGear == 4 then
			playerGear = 5
			playSoundFrontEnd( 4 )
		end
	elseif key == "num_sub" then
		outputDebugString(playerGear)
		if playerGear == 5 then
			playerGear = 4
			playSoundFrontEnd( 4 )
		elseif playerGear == 4 then
			playerGear = 3
			playSoundFrontEnd( 4 )
		elseif playerGear == 3 then
			playerGear = 2
			playSoundFrontEnd( 4 )
		elseif playerGear == 2 then
			playerGear = 1
			playSoundFrontEnd( 4 )
		end
	end
	end

end

bindKey( "num_add", "up", setPlayerGear )
bindKey( "num_sub", "up", setPlayerGear )

