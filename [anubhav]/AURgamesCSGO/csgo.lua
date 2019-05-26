
maxPlayers = 20
STATE_ACTIVE = 1
STATE_FINISHED = 2
STATE_LOADING = 3
STATE_WAITING = 4

local state = STATE_WAITING
players = {}
local isAlive = {}
local isPlayerInCSGO = {}
local rank
local map
local spectators = {}
local updatePlayersTimer
local loadMapTimeoutTimer
local gameStartTick
maptype = "Assault"
local positions = {}
attackers = {}

addEvent("joinCSGORoom",true)
addEventHandler("joinCSGORoom",root,function()
	if not exports.CSGstaff:isPlayerStaff(source) then
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
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the CSGO room while you're not in main world", 255, 0, 0)
		return false
	end
	if getElementData(source,"isPlayerJailed") or getElementData(source,"isPlayerArrested") then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the CSGO room while you're arrested or jailed!", 255, 0, 0)
		return false
	end
	local x,y,z = getElementPosition(source)
	if z >= 200 then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join CSGO!", 255, 0, 0)
		return false
	end
	if not isPedOnGround(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join CSGO!", 255, 0, 0)
		return false
	end
	if getElementData(source,"wantedPoints") >= 15 then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join while you are wanted!", 255, 0, 0)
		return false
	end
	local cmx = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5003 then
			table.insert(cmx,v)
		end
	end
	if #cmx >= maxPlayers then
		outputChatBox("CSGO room is full",root,255,0,0)
		return false
	end
	getPlayerPosition(source)
	playCSGO(source)
end)

function getPlayerPosition(player)
	local x,y,z = getElementPosition(player)
	local hp = getElementHealth(player)
	if not isPedDead(player) and getElementHealth(player) >= 40 then
		positions[player] = {x,y,z,hp}
	end
end

function spawnPlayerCSGO(player)
	setElementPosition(player,-1230.93,264.39,15)
	triggerClientEvent(player, "CSGOclient.freezeCamera", player)
	setElementAlpha(player,255)
	setElementDimension(player, 5003)
	setElementInterior(player,50)
	isPlayerInCSGO[player] = true
end

theMap = 1

function loadGame()
    if(state ~= STATE_FINISHED and state ~= STATE_WAITING) then return false end
	players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5003 then
			triggerClientEvent(v, "CSGOclient.freezeCamera", v)
			table.insert(players,v)
		end
	end
    if(#players <= 1) then
        state = STATE_WAITING
        return
    end
    state = STATE_LOADING
    theMap = theMap+1
	if theMap > 5 then
		theMap = 1
	end
	if theMap == 1 then
		nm = "Assault"
	elseif theMap == 2 then
		nm = "Dust"
	elseif theMap == 3 then
		nm = "Train"
	elseif theMap == 4 then
		nm = "Cbble"
	elseif theMap == 5 then
		nm = "Aztec"
	end
	maptype = nm
	local team = "Terrorist"
    for i,player in ipairs(players) do
        setElementData(player,"Team",team)
        if (team == "Terrorist") then
            team = "Counter Terrorist"
            setPlayerNametagColor ( player ,255,0,0 )
        else
			team = "Terrorist"
            setPlayerNametagColor ( player ,0,0,255)
        end
		outputChatBox("Loading "..tostring(maptype).." map",player,0,255,0)
		loadMap(nm,5003,player)
		isAlive[player] = false
        spawnPlayerCSGO(player)
    end

	playerMapLoaded = {}
    loadMapTimeoutTimer = setTimer(loadMapTimeout, 1000, 1)
end


local playerMapLoaded = {}

function loadMapTimeout()
    if(#players > 1) then
		outputDebugString("TIME OUT WTF")
        for i, player in ipairs(players) do
            if(not playerMapLoaded[player]) then
                exports.NGCdxmsg:createNewDxMessage(player,"Please wait CSGO map is loading",255,255,0)
            end
        end
        players = {}
		for k,v in ipairs(getElementsByType("player")) do
			if getElementDimension(v) == 5003 then
				table.insert(players,v)
			end
		end
        if(#players > 1) then
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
	triggerClientEvent(v, "CSGOclient.freezeCamera", v)
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


kills={}

function prepareGame()
    playerMapLoaded = {}
    if(isTimer(loadMapTimeoutTimer)) then killTimer(loadMapTimeoutTimer) end
    state = STATE_ACTIVE
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5003 then
			triggerClientEvent(v, "CSGOclient.freezeCamera", v)
			table.insert(players,v)
		end
	end
	local spawns = CSGOPos
    local i1, i2 = 1, 1
    local PlayersInRoom = {}
    for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5003 then
			table.insert(players,v)
		end
	end
    for _, player in ipairs(players) do
        local team = getElementData(player,"Team") --== "Terrorist" and "team1" or "team2"
        local spawn
        if (team == "Terrorist") then
            spawn = spawns[maptype]["Terrorist"][i1]
            i1 = i1 + 1
            if(not spawns[i1]) then i1 = 1 end -- go back to first spawn
        else
            spawn = spawns[maptype]["Counter Terrorist"][i1]
            i2 = i2 + 1
            if(not spawns[i2]) then i2 = 1 end -- go back to first spawn
        end
		setElementInterior(player,50)
        setElementPosition(player, spawn[1], spawn[2], spawn[3])
		outputChatBox(spawn[1])
		setPedRotation(player,spawn[4])
		kills[player] = 0
        if (getElementData(player,"Team") == "Terrorist") then
			local skin = math.random(1,2)
			if skin == 1 then
				setElementModel(player,174)
			else
				setElementModel(player,175)
			end
        else
			local skin = math.random(1,2)
			if skin == 1 then
				setElementModel(player,170)
			else
				setElementModel(player,171)
			end
        end
        setElementFrozen(player, true)
        table.insert(PlayersInRoom, player)
        setCameraTarget(player)
        fadeCamera(player, true, 1)
		triggerClientEvent(player,"setCSGOClientCamera",player)
		setCameraTarget(player,player)
		triggerClientEvent(player,"onPlayerJoinCSGO",player)

    end
	triggerClientEvent(players, "CSGOclient.prepareRound", resourceRoot)
    setTimer(startGame, 7000, 1)
end



function startGame()
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5003 then
			table.insert(players,v)
		end
	end
	players2 = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5003 then
			if not isPedDead(v) then
				table.insert(players2,v)
			end
		end
	end
    for i, player in ipairs(players) do
        if not isPedDead(player) then
			isAlive[player] = true
			setElementAlpha(player,150)
			setElementFrozen(player,false)
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


function onCSGOPreKilled(attacker)
	attackers[source] = attacker
end



function endSpawnProtection()
    if(state == STATE_ACTIVE) then
        local igPlayers = {}
        for i, player in ipairs(players) do
            if getElementDimension(player) == 5003 then
				playSound(player,3)
                table.insert(igPlayers, player)
				setElementAlpha(player,255)
                outputChatBox("[CSGO] Spawn protection ended FIGHT!....", player, 10, 170, 250)
            end
        end
        triggerClientEvent(igPlayers, "CSGOclient.gameStopSpawnProtection", resourceRoot)
    end
end

function stopGame(winner)
    if isTimer(updatePlayersTimer) then killTimer(updatePlayersTimer) end
	for i, p in ipairs(players) do
		triggerClientEvent(p,"AddCSGOClientCamera",p,players)
	end
    state = STATE_FINISHED
    if(#players > 1) then
        if(not winner) then
            for i, p in ipairs(players) do
                if(isAlive[p] and getElementDimension(p) == 5003) then
                    winner = p
                    break
                end
            end
        end
        if(winner) then
            local reward = ((#players)-rank) * 1000
            outputChatBox("[CSGO] You win, you gain $"..reward.."!",winner,0,255,0)
        end
    end
    if(winner) then
        for i, player in ipairs(players) do
            if(isElement(player) and getElementDimension(player) == 5003) then
                triggerClientEvent(player, "CSGOclient.roundWon",player, winner)
				triggerClientEvent(player, "CSGOclient.freezeCamera", player)
            end
        end
    end
    setTimer(endGame, 1000, 1)
end



function endGame()
    for i,player in ipairs(players) do
        if(getElementDimension(player) == 5003) then
			triggerClientEvent(player, "CSGOclient.freezeCamera", player)
			triggerClientEvent(player,"AddCSGOClientCamera",player,players)
            triggerClientEvent(player, "CSGOclient.roundEnd", player)
        end
    end
    setTimer(cleanGame, 1000, 1)
end
kk = {}
function cleanGame()
    for k,player in ipairs(players) do
        if(isElement(player)) then
			triggerClientEvent(player, "CSGOclient.freezeCamera", player)
			triggerClientEvent(player,"AddCSGOClientCamera",player,players)
        end
    end
    if isTimer(kk) then killTimer(kk) end
    kk = setTimer(loadGame, 500, 1)
end



function onPlayerWasted(player)
	if(not isAlive[player] or state ~= STATE_ACTIVE) then return end
    local index
    for i, pPlayer in ipairs(players) do
        if(player == pPlayer and isAlive[pPlayer]) then -- he was actually participating
			triggerClientEvent(player,"AddCSGOClientCamera",player,players)
            isAlive[player] = false
            local playersInT1 = getPlayersInTeam1()
            local playersInT2 = getPlayersInTeam2()
            if(#playersInT1 > 0  and #playersInT2 > 0 )then
                startSpectate(player)
                spawnPlayerCSGO(player)
            end
            if(#playersInT1 == 0 or #playersInT2 == 0)then
                setRoundWinner()
            end
        end
    end
    if(index and gameStartTick) then -- valid death
        local secondsSinceStart = math.floor((getTickCount()-gameStartTick)/1000)
        local deathTime = CSGOing.format("%02i:%02i", secondsSinceStart/60, secondsSinceStart%60)
        for i, pPlayer in ipairs(players) do
            if(isElement(pPlayer) and getElementDimension(pPlayer) == 5003) then
                triggerClientEvent(player,"AddCSGOClientCamera",player,players)
				if theATK[player] then
					bywho = theATK[player]
				else
					bywho = ""
				end
                triggerClientEvent(pPlayer, "CSGOclient.playerWasted", player, rank, deathTime,getPlayerName(player),bywho)
            end
        end
    end
    if(index and state == STATE_ACTIVE) then -- find people who are spectating, if they were spectating the person who died, go to the next
        for player, i in pairs(spectators) do
            if(i == index and getElementDimension(player) == 5003) then
                nextSpectateTarget(player)
            end
        end
    end
end

function playSound(p,data)
	triggerClientEvent(p,"AURsounds.playsound", p,data,p)
end


function return_sounds(url, v)
	if (url) then
		triggerClientEvent(v, "AURsounds.proceedsounds", v, url, v)
	end
end
addEvent("AURsounds.return_sounds", true)
addEventHandler("AURsounds.return_sounds", root, return_sounds)

function return_stop(v)
	triggerClientEvent(v, "AURsounds.stop_return", v, v)
end
addEvent("AURsounds.return_stop", true)
addEventHandler("AURsounds.return_stop", root, return_stop)


function setRoundWinner()
	local mostKillsPlayer
	local mostKills = 0
    local winner
    local playersInT1 = getPlayersInTeam1()
    local playersInT2 = getPlayersInTeam2()
    if(#playersInT1 == 0)then
		winner = "Counter Terrorist"
		for i, player in ipairs(players) do
            if isElement(player) and getElementDimension(player) == 5003 then
				playSound(player,2)
			end
		end
    elseif(#playersInT2 == 0)then
		winner = "Terrorist"
		for i, player in ipairs(players) do
            if isElement(player) and getElementDimension(player) == 5003 then
				playSound(player,1)
			end
		end
    end
    if(winner) then
        for i, player in ipairs(players) do
            if isElement(player) and getElementDimension(player) == 5003 then
                triggerClientEvent(player, "CSGOclient.announceWinner", player,winner)
				if(kills[player])then
					if(kills[player] > mostKills)then
					mostKills = kills[player]
					mostKillsPlayer = getPlayerName(player)
					end
				end
            end
        end
		if mostKillsPlayer then
			messageCSGO(mostKillsPlayer.." got the most kills this round. ("..tostring(mostKills).." kills)",255,255,255)
		end
    end
    stopGame(winner)
end

addEventHandler("onPlayerWasted", root,
    function (totalAmmo,killer)
        if (getElementDimension(source) == 5003) then
            onPlayerWasted(source)

			if isPlayerInCSGO[source] then
				playerExitRoom(source)
			end
			if(getElementData(source,"Team") ~= getElementData(killer,"Team"))then
				kills[killer] = kills[killer] + 1
			end
		end
    end
)
function updatePlayers()
    for i, player in ipairs(players) do
        if(isAlive[player]) then
            if(isElementInWater(player)) then
                onPlayerWasted(player)
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
			loadMap(maptype,5003,player)
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
        if getElementDimension(source) == 5003 then
			setElementDimension(source,0)
			setElementInterior(source,0)
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
		if isPlayerInCSGO[source] or getElementDimension(source) == 5003 then
			playerExitRoom(source)
		end
    end
)

function getGameState()
    return state
end


function getPlayersInTeam1()
local team = {}
    for k,player in ipairs(players)do
        if(isAlive[player] and getElementData(player,"Team") == "Terrorist")then
        table.insert(team,player)
        end
    end
    return team
end

function getPlayersInTeam2()
local team = {}
    for k,player in ipairs(players)do
        if(isAlive[player] and getElementData(player,"Team") == "Counter Terrorist")then
        table.insert(team,player)
        end
    end
    return team
end

-- spectating

function startSpectate(player)
    local found = false
    for i, pPlayer in ipairs(players) do
        if(isAlive[pPlayer]) or isPedInVehicle(player) then
            triggerClientEvent(player,"setCSGOClientCamera",player)
			setSpectateTarget(player, pPlayer, i)
            found = true
            break
        end
    end
    if(not found) then
        triggerClientEvent(player, "CSGOclient.freezeCamera", player)
		triggerClientEvent(player,"AddCSGOClientCamera",player,players)
    end
end

function setSpectateTarget(player, target, i)
    if(getElementDimension(player) ~= 5003) then return false end
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


function playCSGO(player)
	triggerClientEvent(player, "CSGOclient.freezeCamera", player)
	setElementFrozen(player,true)
	onClientMapLoaded(player)
	showChat(player,true)
	spawnPlayerCSGO(player)
	if(not isTimer(onResourceStartTimer)) then onPlayerJoinGame(player) end
	bindKey(player, "arrow_r", "up", nextSpectateTarget)
	bindKey(player, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(source,"AddCSGOClientCamera",source,players)
end


addEvent("quitCSGORoom",true)
addEventHandler("quitCSGORoom",root,function()
	setElementFrozen(source,false)
	onPlayerExitGame(source)
	setElementDimension(source,0)
	setElementInterior(source,0)
	local x,y,z = getElementPosition(source)
	if not isPedDead(source) then
		if positions[source] then
			local x,y,z,hp = unpack(positions[source])
			if x and y and z and hp then
				setElementDimension(source,0)
				setElementInterior(source,0)
				setElementPosition(source,x,y,z)
				setElementHealth(source,hp)
				triggerClientEvent(source,"setCSGOClientCamera",source)
				setCameraTarget(source)
				setCameraTarget(source,source)
				exports.NGCdxmsg:createNewDxMessage(source,"We have returned you to your old position",255,250,0)
				positions[source] = {}
			end
		end
	end
	unbindKey(source, "arrow_r", "up", nextSpectateTarget)
	unbindKey(source, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(source,"setCSGOClientCamera",source)
	setCameraTarget(source,source)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,source)
end)


function playerExitRoom(player)
	setElementFrozen(player,false)
	onPlayerExitGame(player)
	setElementDimension(player,0)
	setElementInterior(player,0)
	if not isPedDead(player) then
		if positions[player] then
			local x,y,z,hp = unpack(positions[player])
			if x and y and z and hp then
				setElementDimension(player,0)
				setElementInterior(player,0)
				setElementPosition(player,x,y,z)
				setElementHealth(player,hp)
				triggerClientEvent(player,"setCSGOClientCamera",player)
				setCameraTarget(player,player)
				exports.NGCdxmsg:createNewDxMessage(player,"We have returned you to your old position",255,250,0)
				positions[player] = {}
			end
		end
	end
	unbindKey(player, "arrow_r", "up", nextSpectateTarget)
	unbindKey(player, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(player,"onPlayerLeaveCSGO",player)
	triggerClientEvent(player,"setCSGOClientCamera",player)
	setCameraTarget(player,player)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,player)

end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		onResourceStartTimer = setTimer(loadGame, 2000, 1)
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5003 then
				playCSGO(player)
			end
		end
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5003 then
				playerExitRoom(player)
			end
		end
	end
)

