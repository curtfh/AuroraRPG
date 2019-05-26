
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

hop = nil
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
	else
		destroyElement(countdownImage)
	end
end

theKiller = {}
dmg = {}
active = false
suckers = {}
targ = false




addEvent("DDclient.prepareRound", true)
function prepareRound(vehicles)
    -- init countdown
	startProtect = true
    startCountdown(2000)
	-- spawn protection
    for i, vehicle in ipairs(vehicles) do
        for _,vehicle2 in ipairs(vehicles) do
            if(vehicle ~= vehicle2) then
                setElementCollidableWith(vehicle,vehicle2,false)
            end
        end
    end
end
addEventHandler("DDclient.prepareRound", root, prepareRound)

addEvent("AddDDClientCamera",true)
addEventHandler("AddDDClientCamera",root,function(playing)
	active = true
	suckers = playing
end)
addEvent("setDDClientCamera",true)
addEventHandler("setDDClientCamera",root,function()
	active = false
end)



addEventHandler("onClientRender", getRootElement(),function()
	if getElementDimension(localPlayer) == 5002 then
		setPedWeaponSlot(localPlayer,0)
		setElementHealth(localPlayer,100)
		if not isPedInVehicle(localPlayer) then
			if active == true then
				dxDrawText("Please wait...\nGame in progress", 0, 0, screenWidth, screenHeight-250, tocolor(255,255,255),2,"default-bold","center","center")
			end
		end
		for k, theVehicle in ipairs ( getElementsByType ( "vehicle",resourceRoot ) ) do
			if ( math.floor( getElementHealth( theVehicle ) ) <= 255 ) then
				setVehicleDamageProof( theVehicle, true )
				setVehicleEngineState ( theVehicle, false )

			end
		end
	end
end)



addEventHandler ( "onClientVehicleExplode", root,function (atk,wep,loss)
	if getElementDimension(source) == 5002 then
		cancelEvent()
	end
end)
ifWTF = {}

addEventHandler("onClientVehicleDamage", root,
function(attacker, weapon)
	if attacker then
		if getElementDimension(source) == 5002 then
			if attacker and isElement(attacker) and getElementType(attacker) == "vehicle" then
				if math.floor(getElementHealth(source)) <= 255 then
				local driver = getVehicleOccupant(source,0)
				local driver2 = getVehicleOccupant(attacker,0)
				if driver and driver2 then

					--if getElementData(source,"killer") then return false end
					setElementData(source,"killer",driver2)
					if isTimer(ifWTF) then killTimer(ifWTF) end
					ifWTF = setTimer(function(veh) if veh and isElement(veh) then if isElementInWater(veh) then return false end  theKiller[veh] = nil setElementData(veh,"killer",false) end end,5000,1,source)
				end
				if getElementData(source,"killer") then
					triggerServerEvent("setDDVehicleHealth",localPlayer,source,getElementData(source,"killer"))---theKiller[source])
				else
					triggerServerEvent("setDDVehicleHealth",localPlayer,source,nil)
				end
				end
			end
		end
	end
end)


damer = {}
addEventHandler("onClientVehicleCollision", root,function(hit,force, bodyPart, x, y, z, nx, ny, nz)
	if getElementDimension(source) == 5002 then
		if hit and getElementType(hit) == "vehicle" then
			local driver = getVehicleOccupant(source,0)
			local driver2 = getVehicleOccupant(hit,0)
			if driver and driver2 then
				--if getElementData(source,"killer") then
					--return false
				--end
				setElementData(source,"killer",driver2)
				if isTimer(damer[source]) then killTimer(damer[source]) end
				damer[source] = setTimer(function(d) if d and isElement(d) then if isElementInWater(d) then return false end setElementData(d,"killer",false) end end,5000,1,source)
			end
		end
	end
end)

addEvent("DDclient.gameStopSpawnProtection", true)
function stopSpawnProtection(vehicles)
    canFireRockets = true
	startProtect = false
	for i, vehicle in ipairs(vehicles) do
        for _,vehicle2 in ipairs(vehicles) do
            if(vehicle ~= vehicle2) then
                setElementCollidableWith(vehicle,vehicle2,true)
            end
        end
    end
end
addEventHandler("DDclient.gameStopSpawnProtection", root, stopSpawnProtection)

function gameTick()

end

local roundWinner = false

addEvent("DDclient.roundWon", true)
function onRoundWon()
    if(getElementDimension(localPlayer) ~= 5002) then return false end
    roundWinner = source
    addEventHandler("onClientRender", root, renderWinner)
end
addEventHandler("DDclient.roundWon", root, onRoundWon)

addEvent("DDclient.roundEnd", true)
addEvent("onPlayerExitRoom", true)
function onRoundEnd()
    if(roundWinner) then
        removeEventHandler("onClientRender", root, renderWinner)
    end
    roundWinner = false
end
addEventHandler("DDclient.roundEnd", root, onRoundEnd)
addEventHandler("onPlayerExitRoom", localPlayer, onRoundEnd)


function renderWinner()
	if getElementDimension(localPlayer) == 5002 then
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


addEvent("DDclient.playerWasted", true)
function onPlayerWasted(rank, timex, nick,byw)
	if byw == "" or byw == nil then
		outputChatBox("[ "..rank.." ] "..nick.." | "..timex,0,255,0)
	else
		outputChatBox("[ "..rank.." ] "..byw.." has killed "..nick.." | "..timex,0,255,0)
	end
end
addEventHandler("DDclient.playerWasted", root, onPlayerWasted)

addEvent("DDclient.freezeCamera", true)
function freezeCamera()
    local x,y,z,lx,ly,lz,roll,fov = getCameraMatrix()
    setCameraMatrix(x,y,z+50,lx,ly,lz,roll,fov)
end
addEventHandler("DDclient.freezeCamera", localPlayer, freezeCamera)




addEvent("loadDDMap",true)
addEventHandler("loadDDMap",root,function(temp)
	if temp then
		if unloadMap() then
			for k,v in ipairs(temp) do
				local obj = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
				setElementDimension(obj, 5002)
				engineSetModelLODDistance ( v[1], 500 )
			end
		end
	else
		outputChatBox("invalid map")
	end
end)


function unloadMap()
	for k, v in ipairs(getElementsByType("object",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5002 then
				destroyElement(v)
			end
		end
	end
	return true
end


