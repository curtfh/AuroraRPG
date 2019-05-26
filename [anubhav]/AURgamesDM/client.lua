
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



fuck = false
addEvent("DMclient.prepareRound", true)
function prepareRound(vehicles)
    -- init countdown
	startProtect = true
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
addEventHandler("DMclient.prepareRound", root, prepareRound)

addEvent("AddDMclientCamera",true)
addEventHandler("AddDMclientCamera",root,function(playing)
	active = true
	suckers = playing
	setPedCanBeKnockedOffBike(localPlayer,false)
end)
addEvent("setDMclientCamera",true)
addEventHandler("setDMclientCamera",root,function()
	active = false
	setPedCanBeKnockedOffBike(localPlayer,true)
	resetWaterColor()
end)

addEvent("setDMNitro",true)
addEventHandler("setDMNitro",root,function()
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
	if getElementDimension(localPlayer) == 5004 then
		setPedWeaponSlot(localPlayer,0)
		setElementHealth(localPlayer,100)
		if not isPedInVehicle(localPlayer) then
			if active == true then
				dxDrawText("Please wait...\nGame in progress", 0, 0, screenWidth, screenHeight-250, tocolor(255,255,255),2,"default-bold","center","center")
			end
		end
		for k, theVehicle in ipairs ( getElementsByType ( "vehicle",resourceRoot ) ) do
			if getElementDimension(theVehicle) == 5004 then
				if ( math.floor( getElementHealth( theVehicle ) ) <= 250 ) then
					setVehicleDamageProof( theVehicle, true )
					setVehicleEngineState ( theVehicle, false )
					setElementHealth(theVehicle,250)
					--if fuck == false then
						--fuck = true
						--triggerServerEvent("setDMVehicleHealth",localPlayer,theVehicle,nil)
					--end
				end
			end
		end
	end
end)




addEventHandler ( "onClientVehicleExplode", root,function (atk,wep,loss)
	if getElementDimension(source) == 5004 then
		cancelEvent()
	end
end)
ifWTF = {}

addEventHandler("onClientVehicleDamage", root,
function(attacker, weapon)
	if getElementDimension(source) == 5004 then
		cancelEvent()
		local hp = math.floor(getElementHealth(source))
		setElementHealth(source,hp-2)
		if math.floor(getElementHealth(source)) <= 250 then
			triggerServerEvent("setDMVehicleHealth",localPlayer,source,nil)
		end
	end
end)

addEvent("DMclient.gameStopSpawnProtection", true)
function stopSpawnProtection(vehicles)
    canFireRockets = true
	startProtect = false

end
addEventHandler("DMclient.gameStopSpawnProtection", root, stopSpawnProtection)

function gameTick()

end

local roundWinner = false

addEvent("DMclient.roundWon", true)
function onRoundWon()
    if(getElementDimension(localPlayer) ~= 5004) then return false end
    roundWinner = source
    addEventHandler("onClientRender", root, renderWinner)
end
addEventHandler("DMclient.roundWon", root, onRoundWon)

addEvent("DMclient.roundEnd", true)
addEvent("onPlayerExitRoom", true)
function onRoundEnd()
    if(roundWinner) then
        removeEventHandler("onClientRender", root, renderWinner)
    end
    roundWinner = false
end
addEventHandler("DMclient.roundEnd", root, onRoundEnd)
addEventHandler("onPlayerExitRoom", localPlayer, onRoundEnd)


function renderWinner()
	if getElementDimension(localPlayer) == 5004 then
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


addEvent("DMclient.playerWasted", true)
function onPlayerWasted(rank, timex, nick,byw)
	if byw == "" or byw == nil then
		outputChatBox("[ "..rank.." ] "..nick.." | "..timex,0,255,0)
	else
		outputChatBox("[ "..rank.." ] "..byw.." has killed "..nick.." | "..timex,0,255,0)
	end
end
addEventHandler("DMclient.playerWasted", root, onPlayerWasted)

addEvent("DMclient.freezeCamera", true)
function freezeCamera()
    local x,y,z,lx,ly,lz,roll,fov = getCameraMatrix()
    setCameraMatrix(x,y,z+50,lx,ly,lz,roll,fov)
end
addEventHandler("DMclient.freezeCamera", localPlayer, freezeCamera)

local theMarkers = {
	--[[{-1005.5849609375, 3970.2768554688, 2.2026896476746,"corona",3},
	{-1133.2963867188, 4051.2941894531, 4.3083543777466,"corona",3},
	{2785.9375, -4372.53125, 15.97,"cylinder",4},
	{4628.3422851563, -1939.732421875, 25,"corona",6},
	{4243.8359375, -1295.3460693359, 22.74,"cylinder",2},
	{5829.775390625, 273.64343261719, 87,"cylinder",4},
	{1425.4832763672, -4782.5395507813, 6.95, "corona", 6},
	{3849.0517578125, -3304.6584472656, 5, "checkpoint", 2},
	{-6866.0512695313, -2250.4782714844, 26.988206100464, "corona", 6},
	{-7367.98046875, -990.58264160156, 5.3095993995667, "corona", 4},
	{4042.3349609375, -3580.029296875, 20.142440795898, "corona", 7},
	{3396.669921875, -1407.7523193359, 365.68896484375, "corona", 7},
	{5244.6362304688, -4211.3891601563, 75.700317382813, "corona", 7},]]
}
local mark = {}
local markers = { }
addEvent("loadDMMap",true)
addEventHandler("loadDMMap",root,function(temp,map)
	if temp then
		if unloadMap() then
			for k,v in ipairs(temp) do
				local obj = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
				setElementDimension(obj, 5004)
				engineSetModelLODDistance ( v[1], 500 )

			end
			--[[mark = {}
			local i = 0
			for k,v in ipairs(theMarkers) do
				local x,y,z,ty = v[1],v[2],v[3],v[4]
				local marx = createMarker(x,y,z,ty,v[5],255,0,0)
				i = i+1
				mark[marx] = i
				setElementDimension(marx,5004)
				addEventHandler("onClientMarkerHit",marx, hitMarker)
			end]]
			if map == "Gallardo2" then
				local x,y,z = 5511.6000976563, -1446.1999511719, 201.80000305176
				for i=0,1 do
				  local m = createMarker(x-179.399902344*i,y,z,"corona",3,0,0,0,0)
				  table.insert(markers,m)
				end
				table.insert(markers,createMarker(5248.7202148438,-1677.3599853516,36.330001831055,"corona",7,0,0,0,0))
				table.insert(markers,createMarker(5390.9702148438,-1468.9899902344,121.37000274658,"corona",5,0,0,0,0))

			end
		end
	else
		outputChatBox("invalid map")
	end
end)


local shader = dxCreateShader("texreplace.fx")
if shader then
	local texture = dxCreateTexture("nbbtext.png")
	dxSetShaderValue(shader,"gTexture",texture)
	engineApplyShaderToWorldTexture(shader,"cypress1")
	engineApplyShaderToWorldTexture(shader,"cypress2")
end

function fixTheSpeed(player)
	if getElementType(player)=="player" then
		local vehicle = getPedOccupiedVehicle(player)
		for i,v in ipairs(markers) do
			if source == markers[1] or source == markers[2] then
				setElementSpeed(vehicle,"kph",91.086647033691)
			elseif source == markers[3] then
				for i=0,2 do
					removeVehicleUpgrade(vehicle,1008+i)
				end
			elseif source == markers[4] then
				setElementSpeed(vehicle,"kph",158.33436295127)
			end
		end
	end
end
addEventHandler("onClientMarkerHit",getResourceRootElement(getThisResource()),fixTheSpeed)

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
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
function hitMarker(player,dim)
	if dim then
		if getElementType(player)=="player" then
			local vehicle = getPedOccupiedVehicle(player)
			if vehicle then
				if mark[source] == 1 then
					setElementVelocity(vehicle, 1, 0, 0) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 2 then
					setElementPosition(vehicle, -854.50524902344, 3890.4655761719, 7.8426895141602)
					setVehicleFrozen(vehicle, true)
					setTimer(setVehicleFrozen, 1000, 1, vehicle, false)
				elseif mark[source] == 3 then
					setElementVelocity(vehicle, 0.4, -1.8, 1.2) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 4 then
					setElementVelocity(vehicle, -1.5, -0.7, 0.5) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 5 then
					setElementVelocity(vehicle, -1,-1 , 0.5) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 6 then
					setElementVelocity(vehicle, 2, -1, 1) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 7 then
					local veh = getPedOccupiedVehicle(getLocalPlayer())
					if veh then
						setElementPosition(veh, 4088.28515625, -2553.9462890625, 101.7)
						setElementFrozen(veh, true)
						setTimer(restoreAll, 1500, 1, veh)
						setElementRotation ( veh, 0, 0, 236.9970703125)
					end
				elseif mark[source] == 8 then
					setElementVelocity(vehicle, 0, 0, 2.5) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 9 then
					setElementVelocity(vehicle, 0, 2, 0.525) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 10 then
					setElementVelocity(vehicle, 0, 1.25, 0.9) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 11 then
					local veh = getPedOccupiedVehicle(getLocalPlayer())
					if veh then
						setElementPosition(veh, -5902.4223632813, -2476.1423339844, 521.16619873047)
						setElementFrozen(veh, true)
						setTimer(restoreAll, 1500, 1, veh)
						setElementRotation ( veh, 0, 0, 270)
					end
				elseif mark[source] == 12 then
					setElementVelocity(vehicle, 3, -1, 0.5) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				elseif mark[source] == 13 then
					setElementVelocity(vehicle, -2, -2, 0.5) --[Change the "0 , 0 , 0". The first 0 is X coordination, Second 0 is Y coordination, Third 0 is Z coordination]
				end
			end
        end
	end
end



function restoreAll(veh)
	fadeCamera(true)
	setElementFrozen(veh, false)
	setTimer(restoreAll, 1500, 1, veh)
end


function unloadMap()
	for k, v in ipairs(getElementsByType("object",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5004 then
				destroyElement(v)
			end
		end
	end
	return true
end

addEvent("loadDMMapMarker",true)
addEventHandler("loadDMMapMarker",root,function(temp,map)
	if temp then
		if unloadMapMarker() then
			for k,v in ipairs(temp) do
				local obj = createMarker(v[2],v[3],v[4],v[1],v[5],math.random(2,255),math.random(2,255),math.random(2,255),150)
				setElementDimension(obj, 5004)
			end
		end
	end
end)




function unloadMapMarker()
	for k, v in ipairs(getElementsByType("marker",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5004 then
				destroyElement(v)
			end
		end
	end
	return true
end

local red     = math.random(0, 255)
local green   = math.random(0, 255)
local blue    = math.random(0, 255)

local addRed   = (1 + math.random(0, 1000)/1000) * 6.2
local addGreen = (1 + math.random(0, 1000)/1000) * 1.2
local addBlue  = (1 + math.random(0, 1000)/1000) * 1.2

function changeWaterColor()
	if getElementDimension(localPlayer) == 5004 then
		if ((red + addRed) < 0) or ((red + addRed) > 255) then
			addRed = addRed * -1
		end
		red = red + addRed

		if ((green + addGreen) < 0) or ((green + addGreen) > 255) then
			addGreen = addGreen * -1
		end
		green = green + addGreen

		if ((blue + addBlue) < 0) or ((blue + addBlue) > 255) then
			addBlue = addBlue * -1
		end
		blue = blue + addBlue
		setWaterColor(red, green, blue)

	end
end
addEventHandler ( "onClientPreRender", root, changeWaterColor )

function mapmisc()
	mapsx = {

	}
	for k,v in ipairs(mapsx) do
		local object = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
		setElementDimension(object,5004)
		setElementCollisionsEnabled(object, false)
		setObjectScale(object, 0)
	end
end

addEvent("removeDMloaddedModels",true)
addEventHandler("removeDMloaddedModels",root,function()
	engineRestoreModel ( 8558 )
engineRestoreModel ( 3458 )
end)

Lawmods = {
	{"gta_tree_palm",622},
	{"brown",8558},
	{"grey",3458},
}

local shader
signTep = { }
signFirstTick = getTickCount ( )
signId1 = 1


addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		shader, tec = dxCreateShader ( "texreplace.fx" )
		if not shader then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			engineApplyShaderToWorldTexture ( shader, "heat_02" )
			if not loadPrutTextures ( ) then
				outputChatBox ( "Loading sign textures failed")
				destroyElement ( shader )
				return
			end
			dxSetShaderValue ( shader, "gTexture", signTep[1] )
			addEventHandler ( "onClientHUDRender", getRootElement (), renderAap )
		end
	end
)



function loadPrutTextures ( )
	for i = 0, 3 do
		local tex = dxCreateTexture ( "stopbord/left/lframe"..i..".png" )
		if not tex then
			unloadPrutTextures ( )
			return false
		end
		table.insert ( signTep, tex )
	end

	return true
end

function unloadPrutTextures ( )
	for index, tex in ipairs ( signTep ) do
		destroyElement ( tex )
	end
end

function renderAap ( )
	if getTickCount ( ) - signFirstTick < 200 then
		return
	end
	signId1 = signId1 + 1
	if signId1 > #signTep then
		signId1 = signId1 - #signTep
	end
	dxSetShaderValue ( shader, "gTexture", signTep [ signId1 ] )
	signFirstTick = getTickCount ( )
end



local shader
signTex = { }
signLastTick = getTickCount ( )
signId = 1


addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		shader, tec = dxCreateShader ( "texreplace.fx" )
		if not shader then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			engineApplyShaderToWorldTexture ( shader, "prolaps02" )
			if not loadsignTextures ( ) then
				outputChatBox ( "Loading sign textures failed")
				destroyElement ( shader )
				return
			end
			dxSetShaderValue ( shader, "gTexture", signTex[1] )
			addEventHandler ( "onClientHUDRender", getRootElement (), renderScreen )
		end
	end
)



function loadsignTextures ( )
	-- Gotta load 'em all!
	for i = 0, 3 do
		local tex = dxCreateTexture ( "stopbord/right/rframe"..i..".png" )
		if not tex then
			unloadsignTextures ( )
			return false
		end
		table.insert ( signTex, tex )
	end

	return true
end

function unloadsignTextures ( )
	for index, tex in ipairs ( signTex ) do
		destroyElement ( tex )
	end
end

function renderScreen ( )
	if getTickCount ( ) - signLastTick < 200 then
		return
	end
	signId = signId + 1
	if signId > #signTex then
		signId = signId - #signTex
	end
	dxSetShaderValue ( shader, "gTexture", signTex [ signId ] )
	signLastTick = getTickCount ( )
end






local mods = {}
local txdFile = {}
local dffFile = {}

---- 3437,
function onThisResourceStart ( )
	for k,v in ipairs(Lawmods) do
		downloadFile ( "mods/"..v[1]..".dff" )
	end
end
addEventHandler ( "onClientResourceStart", resourceRoot, onThisResourceStart )



function onDownloadFinish ( file, success )
    if ( source == resourceRoot ) then                            -- if the file relates to this resource
        if ( success ) then
			for k,v in ipairs(Lawmods) do
				if file == "mods/"..v[1]..".dff" then
					if fileExists(":AURgamesDM/mods/"..v[1]..".dff") then
						loadMyMods(v[1],":AURgamesDM/mods/"..v[1]..".dff",":AURgamesDM/mods/"..v[1]..".txd",v[2],v[1])
					end
				elseif file == "mods/"..v[1]..".txd" then
					if fileExists(":AURgamesDM/mods/"..v[1]..".dff") and fileExists(":AURgamesDM/mods/"..v[1]..".txd") then
						loadmods(v[1],v[2])
					end
				end
            end
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )

function loadMyMods(name,dff,txd,id,wh)
	downloadFile ( "mods/"..name..".txd" )
end

function loadmods(name,id)
	mods[name] = {
		{name,id}
	}
	replaceMods(name)
end

function replaceMods(name)
	for k,v in ipairs(mods[name]) do
		if fileExists(":AURgamesDM/mods/"..v[1]..".txd") then
			txd = engineLoadTXD(":AURgamesDM/mods/"..v[1]..".txd")
			if txd and txd ~= false then
				engineImportTXD(txd,v[2])
			end
		end
		if fileExists(":AURgamesDM/mods/"..v[1]..".dff") and fileExists(":AURgamesDM/mods/"..v[1]..".txd") then
			if fileExists(":AURgamesDM/mods/"..v[1]..".dff") then
				dff = engineLoadDFF(":AURgamesDM/mods/"..v[1]..".dff",v[2])
				if txd and txd ~= false then
					if dff and dff ~= false then
						if v[2] then
							engineReplaceModel(dff,v[2])
							--outputDebugString(v[1].." model has been loaded")
						end
					end
				end
			end
		end
	end
end

