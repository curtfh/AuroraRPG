local mapList = {}
function refreshTables ()
	local file = fileOpen("maps.json")
	mapList = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), refreshTables)

function refreshT(plr)
	if not exports.CSGstaff:isPlayerStaff(plr) then return end
	refreshTables()
	outputChatBox("Drag Map list refreshed.", plr)
end
addCommandHandler("aDragin_refresh_Dragmaps", refreshT)

maxPlayers = 15
STATE_ACTIVE = 1
STATE_FINISHED = 2
STATE_LOADING = 3
STATE_WAITING = 4

local state = STATE_WAITING
players = {}
local isAlive = {}
local isPlayerInDrag = {}
local rank
local map
local spectators = {}
local updatePlayersTimer
local loaDragapTimeoutTimer
local playerVehicles = {}
local gameStartTick
maptype = "drag1"
local positions = {}
attackers = {}

addEvent("joinDragRoom",true)
addEventHandler("joinDragRoom",root,function()
	if not exports.CSGstaff:isPlayerStaff(source) and exports.server:getPlayerAccountName(source) ~= "màhdy" then
		outputChatBox("LOL GTFO ",source,255,0,0)
		return false
	end
	if getElementData(source,"isPlayerFlagger") then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't warp while you have the Flag!",255,0,0)
		return false
	end
	if getTeamName(getPlayerTeam(source)) ~= "Unemployed" then
		exports.NGCdxmsg:createNewDxMessage(source,"Only Unemployed team players are allowed to enter!",255,0,0)
		return false
	end
	if (getElementDimension(source) > 0) then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the Drag room while you're not in main world", 255, 0, 0)
		return false
	end
	if getElementData(source,"isPlayerJailed") or getElementData(source,"isPlayerArrested") then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the Drag room while you're arrested or jailed!", 255, 0, 0)
		return false
	end
	local x,y,z = getElementPosition(source)
	if z >= 200 then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join Drag!", 255, 0, 0)
		return false
	end
	if not isPedOnGround(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join Drag!", 255, 0, 0)
		return false
	end
	if getElementData(source,"wantedPoints") >= 15 then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join while you are wanted!", 255, 0, 0)
		return false
	end
	local cmx = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5006 then
			table.insert(cmx,v)
		end
	end
	if #cmx >= maxPlayers then
		outputChatBox("Drag room is full",root,255,0,0)
		return false
	end
	getPlayerPosition(source)
	playDrag(source)
end)

function getPlayerPosition(player)
	local x,y,z = getElementPosition(player)
	local hp = getElementHealth(player)
	if not isPedDead(player) then
		positions[player] = {x,y,z,hp}
	end
end

function spawnPlayerSTR(player)
	setElementPosition(player,-1930.93,264.39,15)
	triggerClientEvent(player, "Dragclient.freezeCamera", player)
	setElementAlpha(player,255)
	setElementDimension(player, 5006)
	isPlayerInDrag[player] = true
end

theMap = 0
theCOL = {}
thePicksDrag = {}
racepickup={}
function loadGame()
    if(state ~= STATE_FINISHED and state ~= STATE_WAITING) then return false end
	players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5006 then
			triggerClientEvent(v, "Dragclient.freezeCamera", v)
			table.insert(players,v)
		end
	end
    if(#players == 0) then
        state = STATE_WAITING
        return
    end
    state = STATE_LOADING
    theMap = theMap+1
	if theMap > #mapList then
		theMap = 1
	end
	nm = mapList[theMap]
	maptype = nm
	outputDebugString(maptype.." The map")
	value = {}
	mox = {}
	racepickup={}
	--[[local theMapFile = xmlLoadFile("maps/"..maptype..".map")
	local nodes = xmlNodeGetChildren(theMapFile)

	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local typex = xmlNodeGetName(v)
		if typex == "racepickup" then
			racepickup[#racepickup+1] = {attributes.posX, attributes.posY, attributes.posZ,attributes.type,attributes.vehicle}
		end
	end
	xmlUnloadFile(theMapFile)
	if racepickup and #racepickup>0 then
		for k,v in ipairs(racepickup) do
			if v[4] then
				local x,y,z = v[1],v[2],v[3]
				if v[4] == "nitro" then
					model = 2221
					c=0.9
				elseif v[4] == "vehiclechange" then
					model = 1079
					c=0.9
				elseif v[4] == "repair" then
					model = 2222
					c=0.9
				else
					c=1
					model = 1079
				end
				local thePickup = createPickup( x,y,z+c, 3, model,0 )
				local theCOLx = createColSphere(x,y,z+c,3)
				value[theCOLx] = {v[5]}
				mox[theCOLx] = model
				setElementDimension(theCOLx,5006)
				setElementDimension(thePickup,5006)
				attachElements(thePickup,theCOLx)
				table.insert(theCOL,theCOLx)
				table.insert(thePicksDrag,thePickup)
				addEventHandler("onColShapeHit",theCOLx,hic)
			end
		end
	end]]
	theATK = {}
	for i,player in ipairs(players) do
		outputChatBox("Loading "..tostring(maptype).." map",player,0,255,0)
		loaDragap(nm,5006,player)
		isAlive[player] = false
        spawnPlayerSTR(player)
    end
	playerMapLoaded = {}
    loaDragapTimeoutTimer = setTimer(loaDragapTimeout, 1000, 1)
end


function hic(hit,dim)
	if dim then
		if hit and getElementType(hit) == "player" then
			local veh = getPedOccupiedVehicle(hit,0)
			if mox[source] == 2222 then
				fixVehicle(veh)
				exports.NGCdxmsg:createNewDxMessage(hit,"Vehicle fixed successfuly",0,255,0)
			elseif mox[source] == 2221 then
				exports.NGCdxmsg:createNewDxMessage(hit,"NOS is activated",0,255,0)
				removeVehicleUpgrade(veh, 1010)
				addVehicleUpgrade(veh, 1010)
				triggerClientEvent(hit,"setDragNitro",hit)
			elseif mox[source] == 1079 then
				if value[source] then
					local car = unpack(value[source])
					if car then
						exports.NGCdxmsg:createNewDxMessage(hit,"Your vehicle is now "..getVehicleNameFromID(car),0,255,0)
						setElementModel(veh,car)
						fixVehicle(veh)
					end
				end
			end
		end
	end
end

local playerMapLoaded = {}

function loaDragapTimeout()
    if(#players >= 1) then
		for i, player in ipairs(players) do
            if(not playerMapLoaded[player]) then
                exports.NGCdxmsg:createNewDxMessage(player,"Please wait Drag map is loading",255,255,0)
            end
        end
        players = {}
		for k,v in ipairs(getElementsByType("player")) do
			if getElementDimension(v) == 5006 then
				table.insert(players,v)
			end
		end
        if(#players > 0) then
            prepareGame()
        else
            state = STATE_WAITING
        end
    else
        state = STATE_WAITING
    end
end




function onClientMapLoaded(v)
    playerMapLoaded[v] = true
	triggerClientEvent(v, "Dragclient.freezeCamera", v)
    local loading = false
    for i, player in ipairs(players) do
        if(not playerMapLoaded[player]) then
            loading = true
            break
        end
    end
    if(not loading) then
        prepareGame()
    end
end
mygun = {}
whogot = {}
local theSpawns = {}


function loaDragapMarker(map)
	local temp2 = {}
	local theMapFile = xmlLoadFile("maps/"..map..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local type = xmlNodeGetName(v)
		if type == "marker" or type == "checkpoint" then
			temp2[#temp2+1] = {attributes.type, attributes.posX, attributes.posY, attributes.posZ, attributes.size}
		end
	end
	xmlUnloadFile(theMapFile)
	createMarkerForDRAG(temp2,map)
end


function createMarkerForDRAG(tempx,map)
	if tempx then
		if unloaDragapMarker() then
			for k,v in ipairs(tempx) do
				local obj = createMarker(v[2],v[3],v[4],"checkpoint",v[5],math.random(2,255),math.random(2,255),math.random(2,255),150)
				setElementDimension(obj, 5006)
				local blip = createBlipAttachedTo(obj,53)
				setElementDimension(blip, 5006)
				outputDebugString("Marker created")
				addEventHandler("onMarkerHit",obj,disableMarkerHit)
			end
		end
	end
end

function disableMarkerHit(hit,dim)
	if dim then
		if hit and getElementType(hit) == "player" then
			if getElementData(source,"dontHitRace") or getElementData(source,"markerRaceWinner") then return false end
			local vehicle = getPedOccupiedVehicle(hit)
			setElementVelocity(vehicle,0,0,0)
			outputDebugString("WIN")
			setElementData(source,"dontHitRace",true)
			setElementData(source,"markerRaceWinner",hit)
			local anyoneWIN = getElementData(source,"dontHitRace")
			local theWin = getElementData(source,"markerRaceWinner")
			triggerEvent("setDragWinner",hit,anyoneWIN,theWin)
		end
	end
end

function unloaDragapMarker()
	for k, v in ipairs(getElementsByType("blip",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5006 then
				destroyElement(v)
			end
		end
	end
	for k, v in ipairs(getElementsByType("marker",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5006 then
				destroyElement(v)
			end
		end
	end
	return true
end


function prepareGame()
    playerMapLoaded = {}
    if(isTimer(loaDragapTimeoutTimer)) then killTimer(loaDragapTimeoutTimer) end
    state = STATE_ACTIVE
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5006 then
			triggerClientEvent(v, "Dragclient.freezeCamera", v)
			table.insert(players,v)
		end
	end
	loaDragapMarker(maptype)
	local theMapFile = xmlLoadFile("maps/"..maptype..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local typex = xmlNodeGetName(v)
		if typex == "spawnpoint" then
			theSpawns[#theSpawns+1] = {attributes.posX, attributes.posY, attributes.posZ, attributes.rotX, attributes.rotY, attributes.rotZ, attributes.vehicle}
		end
	end
	xmlUnloadFile(theMapFile)
    local vehicles = {}
    for theIn, player in ipairs(players) do
        removePlayerVehicle(player)
		--local theIn = math.random(#theSpawns)
		if not theSpawns[theIn] then
			theIn = math.random(#theSpawns)
		end
		local x,y,z = theSpawns[theIn][1], theSpawns[theIn][2], theSpawns[theIn][3]
		setElementPosition(player,x,y,z)
		local c=math.random(1,2)
		local vehicle = createVehicle( theSpawns[theIn][7], x, y, z+2.5,  theSpawns[theIn][4],  theSpawns[theIn][5], theSpawns[theIn][6])
		setElementDimension(vehicle, 5006)
		setElementFrozen(vehicle,true)
        warpPedIntoVehicle(player, vehicle)
		setElementAlpha(vehicle,100)
		local handlingTable = getVehicleHandling ( vehicle )
		local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40 ) )
		setVehicleHandling ( vehicle, "numberOfGears", 5 )
		setVehicleHandling ( vehicle, "driveType", 'awd' )
		setVehicleHandling ( vehicle, "maxVelocity", newVelocity )
		setVehicleHandling ( vehicle, "engineAcceleration", handlingTable["engineAcceleration"] +8 )

		triggerClientEvent(player,"onEnableManual",player)
		playerVehicles[player] = vehicle
        table.insert(vehicles, vehicle)
		addEventHandler("onVehicleExplode", vehicle, function () cancelEvent() end)
		triggerClientEvent(player,"setDragclientCamera",player)
        setCameraTarget(player,player)
    end
	theSpawns = {}
    triggerClientEvent(players, "Dragclient.prepareRound", resourceRoot, vehicles)
    setTimer(startGame, 6000, 1)
end



function startGame()
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5006 then
			table.insert(players,v)
		end
	end
	players2 = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5006 then
			if getPedOccupiedVehicle(v,0) then
				table.insert(players2,v)
			end
		end
	end
    for i, player in ipairs(players) do
        local vehicle = getPedOccupiedVehicle(player)
        if(vehicle) then
            setElementFrozen(vehicle, false)
            isAlive[player] = true
			fixVehicle(vehicle)
        end
    end
    rank = #players2
	if isTimer(updatePlayersTimer) then killTimer(updatePlayersTimer) end
    updatePlayersTimer = setTimer(updatePlayers, 1000, 0)
	if isTimer(whogot) then killTimer(whogot) end
    whogot = setTimer(endSpawnProtection, 5000, 1)
    gameStartTick = getTickCount()
end

local theATK = {}
local dg = {}
local antispam = {}


function onDragPreKilled(attacker)
	attackers[source] = attacker
end


addEvent("onPlayerDragPreKilled", true)
addEventHandler("onPlayerDragPreKilled", root, onDragPreKilled)
function checkIfPlayerWasKilled(player)
	if attackers[player] and isElement(attackers[player][1]) then
		onPlayerDragKilled(attackers[player][1], player, attackers[player][2])
	end
end

addEvent("setDragVehicleHealth",true)
addEventHandler("setDragVehicleHealth",root,function(veh)
	if veh and isElement(veh) then
		setElementHealth(veh,250)
	end
end)

addEvent("setDragWinner",true)
addEventHandler("setDragWinner",root,function(anyoneWIN,theWin)
	if anyoneWIN then
		if theWin and isElement(theWin) then
			if anyoneWIN then
				if theWin and isElement(theWin) and getElementType(theWin) == "player" then
					if isTimer(updatePlayersTimer) then killTimer(updatePlayersTimer) end
					for i, p in ipairs(players) do
						triggerClientEvent(p,"AddDragclientCamera",p,players)
					end
					state = STATE_FINISHED
					local reward = (rank) * 1000
					outputChatBox("[Drag] You win, you gain $"..reward.."!",theWin,0,255,0)
					givePlayerMoney(theWin,reward)
					if(theWin) then
						for i, player in ipairs(players) do
							if(isElement(player) and getElementDimension(player) == 5006) then
								triggerClientEvent(player, "Dragclient.roundWon", theWin)
								triggerClientEvent(player, "Dragclient.freezeCamera", player)
							end
						end
					end
					setTimer(endGame, 1000, 1)
				end
			end
		else
			outputDebugString("There is no player in DRAG")
		end
	else
		outputDebugString("There is no winner in DRAG")
	end
end)

function endSpawnProtection()
    if(state == STATE_ACTIVE) then
        local vehicles = {}
        local igPlayers = {}
        for i, player in ipairs(players) do
            local vehicle = getPedOccupiedVehicle(player)
            if (vehicle and getElementDimension(player) == 5006) then
                table.insert(vehicles, vehicle)
                table.insert(igPlayers, player)
                outputChatBox("[Drag] Spawn protection ended FIGHT!....", player, 10, 170, 250)
            end
        end
		for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
			if getElementDimension(v) == 5006 then
				setElementAlpha(v,255)
			end
		end
        triggerClientEvent(igPlayers, "Dragclient.gameStopSpawnProtection", resourceRoot, vehicles)
    end
end

function stopGame(winner)
    if isTimer(updatePlayersTimer) then killTimer(updatePlayersTimer) end
	for i, p in ipairs(players) do
		triggerClientEvent(p,"AddDragclientCamera",p,players)
	end
    state = STATE_FINISHED
    if(#players > 1) then
        if(not winner) then
            for i, p in ipairs(players) do
                if(isAlive[p] and getElementDimension(p) == 5006) then
                    winner = p
                    break
                end
            end
        end
        if(winner) then
            local reward = ((#players)-rank) * 1000
            outputChatBox("[Drag] You win, you gain $"..reward.."!",winner,0,255,0)
			givePlayerMoney(winner,reward)
			--exports.AURlevels:givePlayerXP(winner,2)
        end
    end
    if(winner) then
        for i, player in ipairs(players) do
            if(isElement(player) and getElementDimension(player) == 5006) then
                triggerClientEvent(player, "Dragclient.roundWon", winner)
				triggerClientEvent(player, "Dragclient.freezeCamera", player)
            end
        end
    end
    setTimer(endGame, 1000, 1)
end



function endGame()
    for i,player in ipairs(players) do
        if(getElementDimension(player) == 5006) then
			triggerClientEvent(player, "Dragclient.freezeCamera", player)
			triggerClientEvent(player,"AddDragclientCamera",player,players)
            triggerClientEvent(player, "Dragclient.roundEnd", player)
        end
    end
    setTimer(cleanGame, 1000, 1)
end
kk = {}
function cleanGame()
    for player, vehicle in pairs(playerVehicles) do
        if(isElement(vehicle)) then
            if(isElement(player)) then
				triggerClientEvent(player, "Dragclient.freezeCamera", player)
				triggerClientEvent(player,"AddDragclientCamera",player,players)
				removePedFromVehicle(player)
            end
            destroyElement(vehicle)
        end
    end
	for k,v in pairs(thePicksDrag) do
		if isElement(v) then destroyElement(v) end
	end
	for k,v in pairs(theCOL) do
		if isElement(v) then destroyElement(v) end
	end
	theCOL = {}
	thePicksDrag = {}
    playerVehicles = {}
	if isTimer(kk) then killTimer(kk) end
    kk = setTimer(loadGame, 500, 1)
end



function onPlayerWasted(player)
    if(not isAlive[player] or state ~= STATE_ACTIVE) then return end
    local index
    for i, pPlayer in ipairs(players) do
        if(player == pPlayer and isAlive[pPlayer]) then -- he was actually participating
			triggerClientEvent(player,"AddDragclientCamera",player,players)
			rank = rank - 1
            isAlive[player] = false
            removePlayerVehicle(player)
			spawnPlayerSTR(player)
            startSpectate(player)
            if(rank < 1) then -- there is one player left
				stopGame()
            else
                exports.NGCdxmsg:createNewDxMessage("[Drag] You finished at #"..rank, player, 200,255,200)
            end
            index = i
            break
        end
    end
    if(index and gameStartTick) then -- valid death
        local secondsSinceStart = math.floor((getTickCount()-gameStartTick)/1000)
        local deathTime = string.format("%02i:%02i", secondsSinceStart/60, secondsSinceStart%60)
        for i, pPlayer in ipairs(players) do
            if(isElement(pPlayer) and getElementDimension(pPlayer) == 5006) then
				triggerClientEvent(player,"AddDragclientCamera",player,players)
				if theATK[player] then
					bywho = theATK[player]
				else
					bywho = ""
				end
                triggerClientEvent(pPlayer, "Dragclient.playerWasted", player, rank, deathTime,getPlayerName(player),bywho)
            end
        end
    end
    if(index) then -- find people who are spectating, if they were spectating the person who died, go to the next
        for player, i in pairs(spectators) do
            if(i == index and getElementDimension(player) == 5006) then
                nextSpectateTarget(player)
            end
        end
    end
end



addEventHandler("onPlayerWasted", root,
    function ()
        if (getElementDimension(source) == 5006) then
            onPlayerWasted(source)
        end
		if isPlayerInDrag[source] then
			playerExitRoom(source)
		end
    end
)


function updatePlayers()
    for i, player in ipairs(players) do
        if(isAlive[player]) then
            if(isElementInWater(player)) then
				if isPedInVehicle(player) then
					local veh = getPedOccupiedVehicle(player)
					if veh then
						if getElementModel(veh) == 595 or getElementModel(veh) == 460 or getElementModel(veh) == 452 or getElementModel(veh) == 446 or getElementModel(veh) == 493 or getElementModel(veh) == 484 or getElementModel(veh) == 539 or getElementModel(veh) == 454 or getElementModel(veh) == 453 or getElementModel(veh) == 473 then
							return false
						else
							onPlayerWasted(player)
						end
					else
						onPlayerWasted(player)
					end
				else
					onPlayerWasted(player)
				end
            end
			for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
				if getElementDimension(v) == 5006 then
					local vehicle = getPedOccupiedVehicle(player)
					if(isElement(vehicle)) and vehicle == v then
						if math.floor(getElementHealth(vehicle)) <= 250 then
							onPlayerWasted(player)
						end
					end
				end
			end
        end
    end
end
gravityjump1 = createMarker(3948.5, -5050.7001953125, 18.5, "corona", 12, 1, 1, 1, 1)
setElementDimension(gravityjump1,5006)


function MainFunction ( hitPlayer, matchingDimension )
	if matchingDimension then
		if getElementType(hitPlayer) == "player" then
			local vehicle = getPedOccupiedVehicle ( hitPlayer,0 )
			if vehicle then
				local speedx, speedy, speedz = getElementVelocity ( vehicle )
				setElementVelocity(vehicle, 0, 4.05, 1)
			end
		end
	end
end
addEventHandler("onMarkerHit",gravityjump1,MainFunction)

function onPlayerJoinGame(player)
    local state = getGameState()
    if(state == STATE_WAITING) then
        loadGame()
    elseif(state == STATE_FINISHED or state == STATE_ACTIVE) then
        if(state == STATE_ACTIVE and #players == 1) then
            stopGame()
		else
			outputChatBox("Loading "..tostring(maptype).." map",player,0,255,0)
			loaDragap(maptype,5006,player)
			startSpectate(player)

        end
    end
end

function onPlayerExitGame(player)
    spectators[player] = nil
    onPlayerWasted(player)
end

addEventHandler("onPlayerQuit", root,
    function ()
        if getElementDimension(source) == 5006 then
			setElementDimension(source,0)
			local x,y,z,hp = unpack(positions[source])
			if x and y and z then
				setElementPosition(source,x,y,z)
				local userid = exports.server:getPlayerAccountID( source )
				setTimer(function(id,x2,y2,z2)
					exports.DENmysql:exec("UPDATE `accounts` SET `x`=?, `y`=?, `z`=?, `dimension`=?, `interior`=? WHERE `id`=?", x2, y2, z2,0,0,id )
				end,3000,1,userid,x,y,z)
			end
		end
    end
)

addEventHandler("onPlayerQuit", root,
    function ()
        if(isAlive[source]) then
            onPlayerWasted(source)
        end
        spectators[source] = nil
        isAlive[source] = nil
		if isPlayerInDrag[source] or getElementDimension(source) == 5006 then
			playerExitRoom(source)
		end
    end
)

function getGameState()
    return state
end

-- spectating

function startSpectate(player)
    local found = false
    for i, pPlayer in ipairs(players) do
        if(isAlive[pPlayer]) or isPedInVehicle(player) then
            triggerClientEvent(player,"setDragclientCamera",player)
			setSpectateTarget(player, pPlayer, i)
            found = true
            break
        end
    end
    if(not found) then
        triggerClientEvent(player, "Dragclient.freezeCamera", player)
		triggerClientEvent(player,"AddDragclientCamera",player,players)
    end
end

function setSpectateTarget(player, target, i)
    if(getElementDimension(player) ~= 5006) then return false end
    setCameraTarget(player, target)
    spectators[player] = i
end

function nextSpectateTarget(player)
    if(isAlive[player]) then return false end
    local old = spectators[player]
    if(not old) then return false end
    if(#players >= 1) then
        local i = old
        local passedStart = false
        while true do
            i = i + 1
            if(i > #players) then
                if(not passedStart) then
                    i = 1
                    passedStart = true
                else
                    return false
                end
            end
            if(isAlive[players[i]]) then
                setSpectateTarget(player, players[i], i)
                break
            end
        end
        return true
    else
        return false
    end
end

function previousSpectateTarget(player)
    if(isAlive[player]) then return false end
    local old = spectators[player]
    if(not old) then return false end
    if(#players >= 1) then
        local i = old
        local passedZero = false
        while true do
            i = i - 1
            if(i <= 0) then
                if(not passedZero) then
                    i = #players
                    passedZero = true
                else
                    return false
                end
            end
            if(isAlive[players[i]]) then
                setSpectateTarget(player, players[i], i)
                break
            end
        end
        return true
    else
        return false
    end
end

------------------

function removePlayerVehicle(player)
    local vehicle = getPedOccupiedVehicle(player)
    if(isElement(vehicle)) then
        removePedFromVehicle(player, vehicle)
        destroyElement(vehicle)
    end
    vehicle = playerVehicles[player]
    if(isElement(vehicle)) then
        removePedFromVehicle(player, vehicle)
        destroyElement(vehicle)
    end
    playerVehicles[player] = nil
	triggerClientEvent(player,"AddDragclientCamera",player,players)
end

function playDrag(player)
	triggerClientEvent(player, "Dragclient.freezeCamera", player)
	setElementFrozen(player,true)
	onClientMapLoaded(player)
	spawnPlayerSTR(player)
	showChat(player,true)
	if(not isTimer(onResourceStartTimer)) then onPlayerJoinGame(player) end
	bindKey(player, "arrow_r", "up", nextSpectateTarget)
	bindKey(player, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(source,"AddDragclientCamera",source,players)
end


addEvent("quitDragRoom",true)
addEventHandler("quitDragRoom",root,function()
	setElementDimension(source,0)
	setElementFrozen(source,false)
	local vehicle = getPedOccupiedVehicle(source)
	if vehicle and isElement(vehicle) then
		removePedFromVehicle(source, vehicle)
		removePlayerVehicle(source)
	end
	onPlayerExitGame(source)
	local x,y,z = getElementPosition(source)
	if not isPedDead(source) then
		if positions[source] then
			local x,y,z,hp = unpack(positions[source])
			if x and y and z and hp then
				setElementDimension(source,0)
				setElementPosition(source,x,y,z)
				setElementHealth(source,hp)
				triggerClientEvent(source,"setDragclientCamera",source)
				setCameraTarget(source)
				setCameraTarget(source,source)
				exports.NGCdxmsg:createNewDxMessage(source,"We have returned you to your old position",255,250,0)
				positions[source] = {}
			end
		end
	end
	unbindKey(source, "arrow_r", "up", nextSpectateTarget)
	unbindKey(source, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(source,"setDragclientCamera",source)
	setCameraTarget(source,source)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,source)
end)


function playerExitRoom(player)
	setElementFrozen(player,false)
	removePlayerVehicle(player)
	onPlayerExitGame(player)
	if not isPedDead(player) then
		if positions[player] then
			local x,y,z,hp = unpack(positions[player])
			if x and y and z and hp then
				setElementDimension(player,0)
				setElementPosition(player,x,y,z)
				setElementHealth(player,hp)
				triggerClientEvent(player,"setDragclientCamera",player)
				setCameraTarget(player,player)
				exports.NGCdxmsg:createNewDxMessage(player,"We have returned you to your old position",255,250,0)
				positions[player] = {}
			end
		end
	end
	unbindKey(player, "arrow_r", "up", nextSpectateTarget)
	unbindKey(player, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(player,"setDragclientCamera",player)
	setCameraTarget(player,player)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,player)

end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		onResourceStartTimer = setTimer(loadGame, 2000, 1) -- fix for warpPedIntoVehicle onStart issue: http://bugs.mtasa.com/view.php?id=7855
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5006 then
				playDrag(player)
			end
		end
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5006 then
				playerExitRoom(player)
			end
		end
	end
)

function onVehicleStartExit(player)
	if getElementDimension(player) == 5006 then
		cancelEvent()
		onPlayerWasted(player)
	end
end
addEventHandler("onVehicleStartExit", root, onVehicleStartExit)
