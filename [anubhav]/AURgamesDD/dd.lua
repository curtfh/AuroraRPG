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
	outputChatBox("DD Map list refreshed.", plr)
end 
addCommandHandler("admin_refresh_ddmaps", refreshT)

maxPlayers = 15
STATE_ACTIVE = 1
STATE_FINISHED = 2
STATE_LOADING = 3
STATE_WAITING = 4

local state = STATE_WAITING
players = {}
local isAlive = {}
local isPlayerInDD = {}
local rank
local map
local spectators = {}
local updatePlayersTimer
local loadMapTimeoutTimer
local playerVehicles = {}
local gameStartTick
maptype = "-dd-budya-dd-4"
local positions = {}
attackers = {}

addEvent("joinDDRoom",true)
addEventHandler("joinDDRoom",root,function()
	--[[if not exports.CSGstaff:isPlayerStaff(source) then
		outputChatBox("LOL GTFO ",source,255,0,0)
		return false
	end]]
	if getElementData(source,"isPlayerFlagger") then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't warp while you have the Flag!",255,0,0)
		return false
	end
	if getTeamName(getPlayerTeam(source)) ~= "Unemployed" then
		exports.NGCdxmsg:createNewDxMessage(source,"Only Unemployed team players are allowed to enter!",255,0,0)
		return false
	end
	if (getElementDimension(source) > 0) then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the DD room while you're not in main world", 255, 0, 0)
		return false
	end
	if getElementData(source,"isPlayerJailed") or getElementData(source,"isPlayerArrested") then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the DD room while you're arrested or jailed!", 255, 0, 0)
		return false
	end
	local x,y,z = getElementPosition(source)
	if z >= 200 then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join DD!", 255, 0, 0)
		return false
	end
	if not isPedOnGround(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join DD!", 255, 0, 0)
		return false
	end
	if getElementData(source,"wantedPoints") >= 15 then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join while you are wanted!", 255, 0, 0)
		return false
	end
	local cmx = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5002 then
			table.insert(cmx,v)
		end
	end
	if #cmx >= maxPlayers then
		outputChatBox("DD room is full",root,255,0,0)
		return false
	end
	getPlayerPosition(source)
	playDD(source)
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
	triggerClientEvent(player, "DDclient.freezeCamera", player)
	setElementAlpha(player,255)
	setElementDimension(player, 5002)
	isPlayerInDD[player] = true
end

theMap = 0

function loadGame()
    if(state ~= STATE_FINISHED and state ~= STATE_WAITING) then return false end
	players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5002 then
			triggerClientEvent(v, "DDclient.freezeCamera", v)
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
	theATK = {}
	for i,player in ipairs(players) do

		outputChatBox("Loading "..tostring(maptype).." map",player,0,255,0)
		loadMap(nm,5002,player)
		isAlive[player] = false
        spawnPlayerSTR(player)
    end

	playerMapLoaded = {}
    loadMapTimeoutTimer = setTimer(loadMapTimeout, 1000, 1)
end


local playerMapLoaded = {}

function loadMapTimeout()
    if(#players > 1) then
		for i, player in ipairs(players) do
            if(not playerMapLoaded[player]) then
                exports.NGCdxmsg:createNewDxMessage(player,"Please wait DD map is loading",255,255,0)
            end
        end
        players = {}
		for k,v in ipairs(getElementsByType("player")) do
			if getElementDimension(v) == 5002 then
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
	triggerClientEvent(v, "DDclient.freezeCamera", v)
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
DDPos = {}
function prepareGame()
    playerMapLoaded = {}
    if(isTimer(loadMapTimeoutTimer)) then killTimer(loadMapTimeoutTimer) end
    state = STATE_ACTIVE
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5002 then
			triggerClientEvent(v, "DDclient.freezeCamera", v)
			table.insert(players,v)
		end
	end
    local vehicles = {}
	
	local theMapFile = xmlLoadFile("maps/"..maptype..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local typex = xmlNodeGetName(v)
		if typex == "spawnpoint" then
			DDPos[#DDPos+1] = {attributes.posX, attributes.posY, attributes.posZ, attributes.rotX, attributes.rotY, attributes.rotZ, attributes.vehicle}
		end
	end
	
	xmlUnloadFile(theMapFile)
	local id = exports.AURlevels:getValidVehicle()
    for index, player in ipairs(players) do
        removePlayerVehicle(player)
		local x,y,z = DDPos[index][1], DDPos[index][2], DDPos[index][3]
		setElementPosition(player,x,y,z)
        local vehicle = createVehicle(id or 415, x, y, z+2.5, DDPos[index][4], DDPos[index][5], DDPos[index][6])
		setElementFrozen(vehicle,true)
		setElementDimension(vehicle, 5002)
		--setElementPosition(player, x,y,z)
        warpPedIntoVehicle(player, vehicle)
		setElementAlpha(vehicle,100)
		if id == 526 then
			local handlingTable = getVehicleHandling ( vehicle )
			local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40 ) )
			setVehicleHandling ( vehicle, "numberOfGears", 5 )
			setVehicleHandling ( vehicle, "driveType", 'awd' )
			setVehicleHandling ( vehicle, "maxVelocity", newVelocity )
			setVehicleHandling ( vehicle, "engineAcceleration", handlingTable["engineAcceleration"] +8 )
		else
			local handlingTable = getVehicleHandling ( vehicle )
			local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 10 ) )
			setVehicleHandling ( vehicle, "numberOfGears", 5 )
			setVehicleHandling ( vehicle, "driveType", 'awd' )
			setVehicleHandling ( vehicle, "maxVelocity", newVelocity )
			setVehicleHandling ( vehicle, "engineAcceleration", handlingTable["engineAcceleration"] +1.5 )
		end

		playerVehicles[player] = vehicle

        table.insert(vehicles, vehicle)
		addEventHandler("onVehicleExplode", vehicle, function () cancelEvent() end)
		triggerClientEvent(player,"setDDClientCamera",player)
        setCameraTarget(player,player)
    end
	DDPos = {}
    triggerClientEvent(players, "DDclient.prepareRound", resourceRoot, vehicles)
    setTimer(startGame, 7000, 1)
end



function startGame()
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5002 then
			table.insert(players,v)
		end
	end
	players2 = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5002 then
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


function onDDPreKilled(attacker)
	attackers[source] = attacker
end


addEvent("onPlayerDDPreKilled", true)
addEventHandler("onPlayerDDPreKilled", root, onDDPreKilled)
function checkIfPlayerWasKilled(player)
	if attackers[player] and isElement(attackers[player][1]) then
		onPlayerDDKilled(attackers[player][1], player, attackers[player][2])
	end
end

addEvent("setDDVehicleHealth",true)
addEventHandler("setDDVehicleHealth",root,function(veh)
	if veh and isElement(veh) then
		setElementHealth(veh,250)
		local atk = getElementData(veh,"killer")
		if atk and isElement(atk) then
			triggerClientEvent(getVehicleController(veh),"addEventMsg",getVehicleController(veh),"STR","DD : #FFFFFFYou have been killed by "..getPlayerName(atk),255,0,0)
			if isTimer(dg[source]) then killTimer(dg[source]) end
			theATK[source] = getPlayerName(atk)
			dg[source] = setTimer(function(v) theATK[v]=nil end,2000,1,source)
			if atk ~= source then
				if isTimer(antispam[atk]) then return false end
				antispam[atk] = setTimer(function() end,1000,1)
				exports.AURlevels:givePlayerXP(atk,1)
			end
		end
	end
end)


function endSpawnProtection()
    if(state == STATE_ACTIVE) then
        local vehicles = {}
        local igPlayers = {}
        for i, player in ipairs(players) do
            local vehicle = getPedOccupiedVehicle(player)
            if (vehicle and getElementDimension(player) == 5002) then
                table.insert(vehicles, vehicle)
                table.insert(igPlayers, player)
                outputChatBox("[DD] Spawn protection ended FIGHT!....", player, 10, 170, 250)
            end
        end
		for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
			setElementAlpha(v,255)
		end
        triggerClientEvent(igPlayers, "DDclient.gameStopSpawnProtection", resourceRoot, vehicles)
    end
end

function stopGame(winner)
    if isTimer(updatePlayersTimer) then killTimer(updatePlayersTimer) end
	for i, p in ipairs(players) do
		triggerClientEvent(p,"AddDDClientCamera",p,players)
	end
    state = STATE_FINISHED
    if(#players > 1) then
        if(not winner) then
            for i, p in ipairs(players) do
                if(isAlive[p] and getElementDimension(p) == 5002) then
                    winner = p
                    break
                end
            end
        end
        if(winner) then
            local reward = ((#players)-rank) * 1000
            outputChatBox("[DD] You win, you gain $"..reward.."!",winner,0,255,0)
			givePlayerMoney(winner,reward)
			exports.AURlevels:givePlayerXP(winner,1)
        end
    end
    if(winner) then
        for i, player in ipairs(players) do
            if(isElement(player) and getElementDimension(player) == 5002) then
                triggerClientEvent(player, "DDclient.roundWon", winner)
				triggerClientEvent(player, "DDclient.freezeCamera", player)
            end
        end
    end
    setTimer(endGame, 1000, 1)
end



function endGame()
    for i,player in ipairs(players) do
        if(getElementDimension(player) == 5002) then
			triggerClientEvent(player, "DDclient.freezeCamera", player)
			triggerClientEvent(player,"AddDDClientCamera",player,players)
            triggerClientEvent(player, "DDclient.roundEnd", player)
        end
    end
    setTimer(cleanGame, 1000, 1)
end
kk = {}
function cleanGame()
    for player, vehicle in pairs(playerVehicles) do
        if(isElement(vehicle)) then
            if(isElement(player)) then
				triggerClientEvent(player, "DDclient.freezeCamera", player)
				triggerClientEvent(player,"AddDDClientCamera",player,players)
				removePedFromVehicle(player)
            end
            destroyElement(vehicle)
        end
    end
    playerVehicles = {}
	if isTimer(kk) then killTimer(kk) end
    kk = setTimer(loadGame, 500, 1)
end



function onPlayerWasted(player)
    if(not isAlive[player] or state ~= STATE_ACTIVE) then return end
    local index
    for i, pPlayer in ipairs(players) do
        if(player == pPlayer and isAlive[pPlayer]) then -- he was actually participating
			triggerClientEvent(player,"AddDDClientCamera",player,players)
			rank = rank - 1
            isAlive[player] = false
            removePlayerVehicle(player)
			spawnPlayerSTR(player)
            startSpectate(player)
            if(rank <= 1) then -- there is one player left
                stopGame()
            else
                exports.NGCdxmsg:createNewDxMessage("[DD] You finished at #"..rank, player, 200,255,200)
            end
            index = i
            break
        end
    end
    if(index and gameStartTick) then -- valid death
        local secondsSinceStart = math.floor((getTickCount()-gameStartTick)/1000)
        local deathTime = string.format("%02i:%02i", secondsSinceStart/60, secondsSinceStart%60)
        for i, pPlayer in ipairs(players) do
            if(isElement(pPlayer) and getElementDimension(pPlayer) == 5002) then
				triggerClientEvent(player,"AddDDClientCamera",player,players)
				if theATK[player] then
					bywho = theATK[player]
				else
					bywho = ""
				end
                triggerClientEvent(pPlayer, "DDclient.playerWasted", player, rank, deathTime,getPlayerName(player),bywho)
            end
        end
    end
    if(index) then -- find people who are spectating, if they were spectating the person who died, go to the next
        for player, i in pairs(spectators) do
            if(i == index and getElementDimension(player) == 5002) then
                nextSpectateTarget(player)
            end
        end
    end
end



addEventHandler("onPlayerWasted", root,
    function ()
        if (getElementDimension(source) == 5002) then
            onPlayerWasted(source)
        end
		if isPlayerInDD[source] then
			playerExitRoom(source)
		end
    end
)

function updatePlayers()
    for i, player in ipairs(players) do
        if(isAlive[player]) then
            if(isElementInWater(player)) then
				if player and isElement(player) then
					local veh = getPedOccupiedVehicle(player)
					local atk = getElementData(veh,"killer")
					if atk and isElement(atk) then
						triggerClientEvent(getVehicleController(veh),"addEventMsg",getVehicleController(veh),"DD","DD : #FFFFFFYou have been killed by "..getPlayerName(atk),255,0,0)
						if isTimer(dg[player]) then killTimer(dg[player]) end
						theATK[player] = getPlayerName(atk)
						dg[player] = setTimer(function(v) if v and isElement(v) then theATK[v]=nil end end,4000,1,player)
						if atk ~= player then
							if isTimer(antispam[atk]) then return false end
							antispam[atk] = setTimer(function() end,1500,1)
							exports.AURlevels:givePlayerXP(atk,1)
						end
					end
				end
                onPlayerWasted(player)
            end
			for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
				local vehicle = getPedOccupiedVehicle(player)
				if(isElement(vehicle)) and vehicle == v then
					if math.floor(getElementHealth(vehicle)) <= 255 then
						onPlayerWasted(player)
					end
				end
			end
        end
    end
end



function onPlayerJoinGame(player)
    local state = getGameState()
    if(state == STATE_WAITING) then
        loadGame()
    elseif(state == STATE_FINISHED or state == STATE_ACTIVE) then
        if(state == STATE_ACTIVE and #players == 1) then
            stopGame()
		else
			outputChatBox("Loading "..tostring(maptype).." map",player,0,255,0)
			loadMap(maptype,5002,player)
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
        if getElementDimension(source) == 5002 then
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
		if isPlayerInDD[source] or getElementDimension(source) == 5002 then
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
            triggerClientEvent(player,"setDDClientCamera",player)
			setSpectateTarget(player, pPlayer, i)
            found = true
            break
        end
    end
    if(not found) then
        triggerClientEvent(player, "DDclient.freezeCamera", player)
		triggerClientEvent(player,"AddDDClientCamera",player,players)
    end
end

function setSpectateTarget(player, target, i)
    if(getElementDimension(player) ~= 5002) then return false end
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
	triggerClientEvent(player,"AddDDClientCamera",player,players)
end

function playDD(player)
	triggerClientEvent(player, "DDclient.freezeCamera", player)
	setElementFrozen(player,true)
	onClientMapLoaded(player)
	showChat(player,true)
	spawnPlayerSTR(player)
	if(not isTimer(onResourceStartTimer)) then onPlayerJoinGame(player) end
	bindKey(player, "arrow_r", "up", nextSpectateTarget)
	bindKey(player, "arrow_l", "up", previousSpectateTarget)
	toggleControl(player, "vehicle_secondary_fire", false)
	triggerClientEvent(source,"AddDDClientCamera",source,players)
end


addEvent("quitDDRoom",true)
addEventHandler("quitDDRoom",root,function()
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
				triggerClientEvent(source,"setDDClientCamera",source)
				setCameraTarget(source)
				setCameraTarget(source,source)
				exports.NGCdxmsg:createNewDxMessage(source,"We have returned you to your old position",255,250,0)
				positions[source] = {}
			end
		end
	end
	unbindKey(source, "arrow_r", "up", nextSpectateTarget)
	unbindKey(source, "arrow_l", "up", previousSpectateTarget)
	toggleControl(source, "vehicle_secondary_fire", true)
	triggerClientEvent(source,"setDDClientCamera",source)
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
				triggerClientEvent(player,"setDDClientCamera",player)
				setCameraTarget(player,player)
				exports.NGCdxmsg:createNewDxMessage(player,"We have returned you to your old position",255,250,0)
				positions[player] = {}
			end
		end
	end
	unbindKey(player, "arrow_r", "up", nextSpectateTarget)
	unbindKey(player, "arrow_l", "up", previousSpectateTarget)
	toggleControl(player, "vehicle_secondary_fire", true)
	triggerClientEvent(player,"setDDClientCamera",player)
	setCameraTarget(player,player)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,player)

end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		onResourceStartTimer = setTimer(loadGame, 2000, 1) -- fix for warpPedIntoVehicle onStart issue: http://bugs.mtasa.com/view.php?id=7855
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5002 then
				playDD(player)
			end
		end
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5002 then
				playerExitRoom(player)
			end
		end
	end
)

function onVehicleStartExit(player)
	if getElementDimension(player) == 5002 then
		cancelEvent()
		onPlayerWasted(player)
	end
end
addEventHandler("onVehicleStartExit", root, onVehicleStartExit)
