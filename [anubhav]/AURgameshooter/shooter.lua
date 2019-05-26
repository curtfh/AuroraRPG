--- fix for wasted and dont dmg player in car to stay in shooter and fix fade when he leave or wtv
--- add on exit handler
---- add cnr warp back
---- add save posi

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
	outputChatBox("Shooter Map list refreshed.", plr)
end
addCommandHandler("admin_refresh_shtrmaps", refreshT)


maxPlayers = 32
STATE_ACTIVE = 1
STATE_FINISHED = 2
STATE_LOADING = 3
STATE_WAITING = 4

local state = STATE_WAITING
players = {}
local isAlive = {}
local isPlayerInShooter = {}
local rank
local map
local spectators = {}
local updatePlayersTimer
local loadMapTimeoutTimer
local playerVehicles = {}
local gameStartTick
maptype = "Shooter-Black-Mngem-RockStar"
local positions = {}
attackers = {}

addEvent("joinShooterRoom",true)
addEventHandler("joinShooterRoom",root,function()
	if getElementData(source,"isPlayerFlagger") then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't warp while you have the Flag!",255,0,0)
		return false
	end
	if getTeamName(getPlayerTeam(source)) ~= "Unemployed" then
		exports.NGCdxmsg:createNewDxMessage(source,"Only Unemployed team players are allowed to enter!",255,0,0)
		return false
	end
	if (getElementDimension(source) > 0) then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the Shooter room while you're not in main world", 255, 0, 0)
		return false
	end
	if getElementData(source,"isPlayerJailed") or getElementData(source,"isPlayerArrested") then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the Shooter room while you're arrested or jailed!", 255, 0, 0)
		return false
	end
	local x,y,z = getElementPosition(source)
	if z >= 200 then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join shooter!", 255, 0, 0)
		return false
	end
	if not isPedOnGround(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join shooter!", 255, 0, 0)
		return false
	end
	if getElementData(source,"wantedPoints") >= 15 then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join while you are wanted!", 255, 0, 0)
		return false
	end
	local cmx = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5001 then
			table.insert(cmx,v)
		end
	end
	if #cmx >= maxPlayers then
		outputChatBox("Shooter room is full",root,255,0,0)
		return false
	end
	getPlayerPosition(source)
	playShooter(source)
end)

function getPlayerPosition(player)
	local x,y,z = getElementPosition(player)
	local hp = getElementHealth(player)
	if not isPedDead(player) and getElementHealth(player) >= 40 then
		positions[player] = {x,y,z,hp}
	end
end

function spawnPlayerSTR(player)
	setElementPosition(player,-1230.93,264.39,15)
	triggerClientEvent(player, "shooterclient.freezeCamera", player)
	setElementAlpha(player,255)
	setElementDimension(player, 5001)
	isPlayerInShooter[player] = true
end

theMap = 1

theCOL = {}
thePickupShooter = {}
racepickup={}
function loadGame()
    if(state ~= STATE_FINISHED and state ~= STATE_WAITING) then return false end
	players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5001 then
			triggerClientEvent(v, "shooterclient.freezeCamera", v)
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
	for i,player in ipairs(players) do
		outputChatBox("Loading "..tostring(maptype).." map",player,0,255,0)
		local x,y,z = ShooterPos[i][1], ShooterPos[i][2], ShooterPos[i][3]
		setElementPosition(player,x,y,z)
		loadMap(nm,5001,player)
		isAlive[player] = false
        spawnPlayerSTR(player)
    end
	racepickup={}
	value = {}
	mox = {}
	local theMapFile = xmlLoadFile("maps/"..maptype..".map")
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
				setElementDimension(theCOLx,5001)
				setElementDimension(thePickup,5001)
				attachElements(thePickup,theCOLx)
				table.insert(theCOL,theCOLx)
				table.insert(thePickupShooter,thePickup)
				addEventHandler("onColShapeHit",theCOLx,hic)
			end
		end
	end
	ShooterPos = {}
	playerMapLoaded = {}
    loadMapTimeoutTimer = setTimer(loadMapTimeout, 1000, 1)
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

function loadMapTimeout()
    if(#players > 1) then
		outputDebugString("TIME OUT WTF")
        for i, player in ipairs(players) do
            if(not playerMapLoaded[player]) then
                exports.NGCdxmsg:createNewDxMessage(player,"Please wait shooter map is loading",255,255,0)
            end
        end
        players = {}
		for k,v in ipairs(getElementsByType("player")) do
			if getElementDimension(v) == 5001 then
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
	triggerClientEvent(v, "shooterclient.freezeCamera", v)
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
ShooterPos = {}
function prepareGame()
    playerMapLoaded = {}
    if(isTimer(loadMapTimeoutTimer)) then killTimer(loadMapTimeoutTimer) end
    state = STATE_ACTIVE
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5001 then
			triggerClientEvent(v, "shooterclient.freezeCamera", v)
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
			ShooterPos[#ShooterPos+1] = {attributes.posX, attributes.posY, attributes.posZ, attributes.rotX, attributes.rotY, attributes.rotZ, attributes.vehicle}
		end
	end

	xmlUnloadFile(theMapFile)

    for index, player in ipairs(players) do
        removePlayerVehicle(player)
		local id = exports.AURlevels:getValidVehicle(player)
		local x,y,z = ShooterPos[index][1], ShooterPos[index][2], ShooterPos[index][3]
		local vehicle = createVehicle(id or 415, x, y, z+2.5, ShooterPos[index][4], ShooterPos[index][5], ShooterPos[index][6])
		setElementFrozen(vehicle,true)
		setElementDimension(vehicle, 5001)
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

		triggerClientEvent(player,"onPlayerJoinShooter",player)
		playerVehicles[player] = vehicle

        table.insert(vehicles, vehicle)
		triggerClientEvent("attachShooterWeapons", root, player)
        addEventHandler("onVehicleExplode", vehicle, function () cancelEvent() end)
		triggerClientEvent(player,"removeClientCamera",player)
        setCameraTarget(player,player)
    end
    triggerClientEvent(players, "shooterclient.prepareRound", resourceRoot, vehicles)
    setTimer(startGame, 7000, 1)
end



function startGame()
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5001 then
			table.insert(players,v)
		end
	end
	players2 = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5001 then
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


function onShooterPreKilled(attacker)
	attackers[source] = attacker
end

function onPlayerShooterKilled(killer, victim, weapon)
	if getElementDimension(killer) == 5001 then
		local source = source or victim
		local weapon = weapon or "rocket"
		if source == killer then
			return
		end
		theATK[victim] = getPlayerName(killer)
		---exports.AURlevels:givePlayerXP(killer,2)
		onPlayerWasted(victim)
	end
end
addEvent("onPlayerVehicleKilledByProjectile", true)
addEventHandler("onPlayerVehicleKilledByProjectile", root, onPlayerShooterKilled)

addEvent("onPlayerShooterPreKilled", true)
addEventHandler("onPlayerShooterPreKilled", root, onShooterPreKilled)
function checkIfPlayerWasKilled(player)
	if attackers[player] and isElement(attackers[player][1]) then
		onPlayerShooterKilled(attackers[player][1], player, attackers[player][2])
	end
end

addEvent("setShooterVehicleHealth",true)
addEventHandler("setShooterVehicleHealth",root,function(veh,atk)
	if veh and isElement(veh) then
		setElementHealth(veh,250)
		if atk and isElement(atk) then
			triggerClientEvent(getVehicleController(veh),"addEventMsg",getVehicleController(veh),"STR","Shooter : #FFFFFFYou have been killed by "..getPlayerName(atk),255,0,0)
			if isTimer(dg[source]) then killTimer(dg[source]) end
			theATK[source] = getPlayerName(atk)
			dg[source] = setTimer(function(v) theATK[v]=nil end,2000,1,source)
			if atk ~= source then
				if isTimer(antispam[atk]) then return false end
				antispam[atk] = setTimer(function() end,1500,1)
				exports.AURlevels:givePlayerXP(atk,1)
			end
		end
	end
end)

addCommandHandler("st",function(p,cmd,i)
	triggerClientEvent("addW",root,i)
	outputChatBox(i,p,255,0,0)
end)

addEvent("rabbitjump",true)
addEventHandler("rabbitjump",root,function(v)
	local sx,sy,sz = getElementVelocity ( v )
	setElementVelocity( v, sx, sy, sz+0.3)
end)

function endSpawnProtection()
    if(state == STATE_ACTIVE) then
        local vehicles = {}
        local igPlayers = {}
        for i, player in ipairs(players) do
            local vehicle = getPedOccupiedVehicle(player)
            if (vehicle and getElementDimension(player) == 5001) then
                table.insert(vehicles, vehicle)
                table.insert(igPlayers, player)
                outputChatBox("[SHOOTER] Spawn protection ended FIGHT!....", player, 10, 170, 250)
            end
        end
		for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
			setElementAlpha(v,255)
		end
        triggerClientEvent(igPlayers, "shooterclient.gameStopSpawnProtection", resourceRoot, vehicles)
    end
end

function stopGame(winner)
    if isTimer(updatePlayersTimer) then killTimer(updatePlayersTimer) end
	for i, p in ipairs(players) do
		triggerClientEvent(p,"setClientCamera",p,players)
	end
    state = STATE_FINISHED
    if(#players > 1) then
        if(not winner) then
            for i, p in ipairs(players) do
                if(isAlive[p] and getElementDimension(p) == 5001) then
                    winner = p
                    break
                end
            end
        end
        if(winner) then
            local reward = ((#players)-rank) * 1000
            outputChatBox("[SHOOTER] You win, you gain $"..reward.."!",winner,0,255,0)
			givePlayerMoney(winner,reward)
			--exports.AURlevels:givePlayerXP(winner,2)
        end
    end
    if(winner) then
        for i, player in ipairs(players) do
            if(isElement(player) and getElementDimension(player) == 5001) then
                triggerClientEvent(player, "shooterclient.roundWon", winner)
				triggerClientEvent(player, "shooterclient.freezeCamera", player)
            end
        end
    end
    setTimer(endGame, 1000, 1)
end



function endGame()
    for i,player in ipairs(players) do
        if(getElementDimension(player) == 5001) then
			triggerClientEvent(player, "shooterclient.freezeCamera", player)
			triggerClientEvent(player,"setClientCamera",player,players)
            triggerClientEvent(player, "shooterclient.roundEnd", player)
        end
    end
    setTimer(cleanGame, 1000, 1)
end
kk = {}
function cleanGame()
    for player, vehicle in pairs(playerVehicles) do
        if(isElement(vehicle)) then
            if(isElement(player)) then
				triggerClientEvent(player, "shooterclient.freezeCamera", player)
				triggerClientEvent(player,"setClientCamera",player,players)
				triggerClientEvent(player,"onPlayerLeaveShooter",player)
                removePedFromVehicle(player)
            end
            destroyElement(vehicle)
        end
    end
	for k,v in pairs(thePickupShooter) do
		if isElement(v) then destroyElement(v) end
	end
	for k,v in pairs(theCOL) do
		if isElement(v) then destroyElement(v) end
	end
	theCOL={}
	thePickupShooter={}
    playerVehicles = {}
	if isTimer(kk) then killTimer(kk) end
    kk = setTimer(loadGame, 500, 1)
end



function onPlayerWasted(player)
    if(not isAlive[player] or state ~= STATE_ACTIVE) then return end
    local index
    for i, pPlayer in ipairs(players) do
        if(player == pPlayer and isAlive[pPlayer]) then -- he was actually participating
			triggerClientEvent(player,"setClientCamera",player,players)
			triggerClientEvent(player,"dettachShooterWeapons", player, player)
            rank = rank - 1
            isAlive[player] = false
            removePlayerVehicle(player)
			spawnPlayerSTR(player)
            startSpectate(player)
            if(rank <= 1) then -- there is one player left
                stopGame()
            else
                exports.NGCdxmsg:createNewDxMessage("[SHOOTER] You finished at #"..rank, player, 200,255,200)
            end
            index = i
            break
        end
    end
    if(index and gameStartTick) then -- valid death
        local secondsSinceStart = math.floor((getTickCount()-gameStartTick)/1000)
        local deathTime = string.format("%02i:%02i", secondsSinceStart/60, secondsSinceStart%60)
        for i, pPlayer in ipairs(players) do
            if(isElement(pPlayer) and getElementDimension(pPlayer) == 5001) then
				triggerClientEvent(player,"setClientCamera",player,players)
				if theATK[player] then
					bywho = theATK[player]
				else
					bywho = ""
				end
                triggerClientEvent(pPlayer, "shooterclient.playerWasted", player, rank, deathTime,getPlayerName(player),bywho)
            end
        end
    end
    if(index) then -- find people who are spectating, if they were spectating the person who died, go to the next
        for player, i in pairs(spectators) do
            if(i == index and getElementDimension(player) == 5001) then
                nextSpectateTarget(player)
            end
        end
    end
end



addEventHandler("onPlayerWasted", root,
    function ()
        if (getElementDimension(source) == 5001) then
            onPlayerWasted(source)
        end
		if isPlayerInShooter[source] then
			playerExitRoom(source)
		end
    end
)

function updatePlayers()
    for i, player in ipairs(players) do
        if(isAlive[player]) then
            if(isElementInWater(player)) then
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
			loadMap(maptype,5001,player)
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
        if getElementDimension(source) == 5001 then
			setElementDimension(source,0)
			local x,y,z,hp = unpack(positions[source])
			if x and y and z then
				setElementPosition(source,x,y,z)
				local userid = exports.server:getPlayerAccountID( source )
				setTimer(function(id,x2,y2,z2)
					exports.DENmysql:exec("UPDATE `accounts` SET `x`=?, `y`=?, `z`=?, `dimension`=? WHERE `id`=?", x2, y2, z2,0,id )
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
		if isPlayerInShooter[source] or getElementDimension(source) == 5001 then
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
            triggerClientEvent(player,"removeClientCamera",player)
			setSpectateTarget(player, pPlayer, i)
            found = true
            break
        end
    end
    if(not found) then
        triggerClientEvent(player, "shooterclient.freezeCamera", player)
		triggerClientEvent(player,"setClientCamera",player,players)
    end
end

function setSpectateTarget(player, target, i)
    if(getElementDimension(player) ~= 5001) then return false end
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
		if player and isElement(player) then
			triggerClientEvent(player,"onPlayerLeaveShooter",player)
		end
    end
    vehicle = playerVehicles[player]
    if(isElement(vehicle)) then
        removePedFromVehicle(player, vehicle)
        destroyElement(vehicle)
		if player and isElement(player) then
			triggerClientEvent(player,"onPlayerLeaveShooter",player)
		end
    end
    playerVehicles[player] = nil
	triggerClientEvent(player,"setClientCamera",player,players)
end

function playShooter(player)
	triggerClientEvent(player, "shooterclient.freezeCamera", player)
	setElementFrozen(player,true)
	onClientMapLoaded(player)
	showChat(player,true)
	spawnPlayerSTR(player)
	if(not isTimer(onResourceStartTimer)) then onPlayerJoinGame(player) end
	bindKey(player, "arrow_r", "up", nextSpectateTarget)
	bindKey(player, "arrow_l", "up", previousSpectateTarget)
	toggleControl(player, "vehicle_secondary_fire", false)
	triggerClientEvent(source,"setClientCamera",source,players)
end


addEvent("quitShooterRoom",true)
addEventHandler("quitShooterRoom",root,function()
	setElementFrozen(source,false)
	setElementDimension(source,0)
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
				triggerClientEvent(source,"removeClientCamera",source)
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
	triggerClientEvent(source,"removeClientCamera",source)
	setCameraTarget(source,source)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,source)
end)


function playerExitRoom(player)
	setElementFrozen(player,false)
	removePlayerVehicle(player)
	onPlayerExitGame(player)
	setElementDimension(player,0)
	if not isPedDead(player) then
		if positions[player] then
			local x,y,z,hp = unpack(positions[player])
			if x and y and z and hp then
				setElementDimension(player,0)
				setElementPosition(player,x,y,z)
				setElementHealth(player,hp)
				triggerClientEvent(player,"removeClientCamera",player)
				setCameraTarget(player,player)
				exports.NGCdxmsg:createNewDxMessage(player,"We have returned you to your old position",255,250,0)
				positions[player] = {}
			end
		end
	end
	unbindKey(player, "arrow_r", "up", nextSpectateTarget)
	unbindKey(player, "arrow_l", "up", previousSpectateTarget)
	toggleControl(player, "vehicle_secondary_fire", true)
	triggerClientEvent(player,"onPlayerLeaveShooter",player)
	triggerClientEvent(player,"removeClientCamera",player)
	setCameraTarget(player,player)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,player)

end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		onResourceStartTimer = setTimer(loadGame, 2000, 1) -- fix for warpPedIntoVehicle onStart issue: http://bugs.mtasa.com/view.php?id=7855
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5001 then
				playShooter(player)
			end
		end
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5001 then
				playerExitRoom(player)
			end
		end
	end
)

function onVehicleStartExit(player)
	if getElementDimension(player) == 5001 then
		cancelEvent()
		onPlayerWasted(player)
	end
end
addEventHandler("onVehicleStartExit", root, onVehicleStartExit)
