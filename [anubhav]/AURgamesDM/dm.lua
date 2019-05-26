--[[local mapList = {}
function refreshTables ()
	local file = fileOpen("maps.json")
	mapList = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), refreshTables)

function refreshT(plr)
	if not exports.CSGstaff:isPlayerStaff(plr) then return end
	refreshTables()
	outputChatBox("DM Map list refreshed.", plr)
end
addCommandHandler("admin_refresh_dmmaps", refreshT)]]

local mapList = {
	"andres",
	"artpro",
	"ASSEMBLY",
	"canttouch",
	"CorexV1",
	"crush",
	"DarkInception2",
	"dawning",
	"deneme",
	"diFour",
	"DM PAwlo - Have Fun",
	"DM PAwlo - The Silver Mountain",
	"DM PAwlo - We love the Speed --Extended Edition--",
	"DM PAwlo ft. Sealine - Azure Fantasy Way",
	"Drift Project - everything will be fine",
	"DUMSDEIOMG",
	"easyhunter",
	"EclEcl9",
	"emotiva",
	"ExXoTicC",
	"exxoticctobes",
	"frank",
	"freakzer",
	"freakzer3",
	"Gallardo",
	"Gallardo2",
	"ganador",
	"ginu",
	"ginu2",
	"gunahkecisi",
	"gusv2",
	"hardloop",
	"ide",
	"illusion",
	"iltmmi",
	"Jav",
	"Javelin",
	"lolmap",
	"maxihard",
	"nico1",
	"nico2",
	"nico3",
	"nico4",
	"nrg500",
	"parachute",
	"parachute2",
	"race-dm-actafool",
	"race-dm-albaistanbul",
	"race-dm-Chaos",
	"race-dm-naturaltalent",
	"race-dm-soundwave-thedevilisadj",
	"race-dm-soundwave-welovetheloops",
	"race-[dm]kodiaklovelyspeedII",
	"race-[dm]kodiaknighttimerun",
	"race-[dm]kodiakracetheclock",
	"race-[dm]kodiakrollercoaster",
	"race-[dm]kodiakrollercoasterii",
	"race-[dm]kodiakskilledinfernus",
	"race-[dm]kodiakspeedytreedy",
	"race-[dm]Maxi-hard",
	"race-[DM]Norelys",
	"race-[DM]Not that far away",
	"race-[DM]Our-Own-Way",
	"race-[dm]pawlo-welovethespeed",
	"race-[DM]PoeTicS",
	"race-[DM]RaZoRANewHope",
	"race-[DM]SpeedZone V2",
	"race-[DM]SuperPro - Sin Rumbo",
	"race-[dm]The-End",
	"race-[dm]Trackmania",
	"saymen",
	"sebby",
	"skilled quad",
	"sparks",
	"speedskills",
	"stanbul",
	"StyLeXftTaxi",
	"summer",
	"superprime",
	"thePrime",
	"yedi",
	"[DM]andres-vol8-occurrence",
	"[DM]Drift Project - The Hard Loop",
	"[DM]Drift Project-Speed And Skill",
	"[DM]El peor de los casos",
	"[DM]exxoticctobes",
	"[DM]make_aur_great_again",
	"[DM]Ride or Die",
	"[DM]Saymen-TulioTC",
	"[DM]TulioTC-Crush",
	"[DM]TulioTC-ft-APs-Magnetic-Love",
	"[DM]TulioTC-ft-Rafinha-Running-Is-My-Life-IV",
	"[DM]TulioTC-Hot-Summer",
	"[DM]TulioTC-Insomnia-Club",
	"[DM]TulioTC-SummerSkillzZz",
	"[DM]TulioTC-This-Is-My-Style",
}

maxPlayers = 15
STATE_ACTIVE = 1
STATE_FINISHED = 2
STATE_LOADING = 3
STATE_WAITING = 4

local state = STATE_WAITING
players = {}
local isAlive = {}
local isPlayerInDM = {}
local rank
local map
local spectators = {}
local updatePlayersTimer
local loadMapTimeoutTimer
local playerVehicles = {}
local gameStartTick
maptype = "CorexV1"
local positions = {}
attackers = {}

addEvent("joinDMRoom",true)
addEventHandler("joinDMRoom",root,function()
--	if not exports.CSGstaff:isPlayerStaff(source) then
	--	outputChatBox("LOL GTFO ",source,255,0,0)
	--	return false
	--end
	if getElementData(source,"isPlayerFlagger") then
		exports.NGCdxmsg:createNewDxMessage(source,"You can't warp while you have the Flag!",255,0,0)
		return false
	end
	if getTeamName(getPlayerTeam(source)) ~= "Unemployed" then
		exports.NGCdxmsg:createNewDxMessage(source,"Only Unemployed team players are allowed to enter!",255,0,0)
		return false
	end
	if (getElementDimension(source) > 0) then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the DM room while you're not in main world", 255, 0, 0)
		return false
	end
	if getElementData(source,"isPlayerJailed") or getElementData(source,"isPlayerArrested") then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join the DM room while you're arrested or jailed!", 255, 0, 0)
		return false
	end
	local x,y,z = getElementPosition(source)
	if z >= 200 then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join DM!", 255, 0, 0)
		return false
	end
	if not isPedOnGround(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"go on ground to join DM!", 255, 0, 0)
		return false
	end
	if getElementData(source,"wantedPoints") >= 15 then
		exports.NGCdxmsg:createNewDxMessage(source,"you can't join while you are wanted!", 255, 0, 0)
		return false
	end
	local cmx = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5004 then
			table.insert(cmx,v)
		end
	end
	if #cmx >= maxPlayers then
		outputChatBox("DM room is full",root,255,0,0)
		return false
	end
	getPlayerPosition(source)
	playDM(source)
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
	triggerClientEvent(player, "DMclient.freezeCamera", player)
	setElementAlpha(player,255)
	setElementDimension(player, 5004)
	isPlayerInDM[player] = true
end

theMap = 0
theCOL = {}
thePicksDM = {}
racepickup={}
function loadGame()
    if(state ~= STATE_FINISHED and state ~= STATE_WAITING) then return false end
	players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5004 then
			triggerClientEvent(v, "DMclient.freezeCamera", v)
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
				setElementDimension(theCOLx,5004)
				setElementDimension(thePickup,5004)
				attachElements(thePickup,theCOLx)
				table.insert(theCOL,theCOLx)
				table.insert(thePicksDM,thePickup)
				addEventHandler("onColShapeHit",theCOLx,hic)
			end
		end
	end
	theATK = {}
	for i,player in ipairs(players) do
		outputChatBox("Loading "..tostring(maptype).." map",player,0,255,0)
		loadMap(nm,5004,player)
		isAlive[player] = false
        spawnPlayerSTR(player)
    end
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
				triggerClientEvent(hit,"setDMNitro",hit)
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
    if(#players >= 1) then
		for i, player in ipairs(players) do
            if(not playerMapLoaded[player]) then
                exports.NGCdxmsg:createNewDxMessage(player,"Please wait DM map is loading",255,255,0)
            end
        end
        players = {}
		for k,v in ipairs(getElementsByType("player")) do
			if getElementDimension(v) == 5004 then
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
	triggerClientEvent(v, "DMclient.freezeCamera", v)
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
function prepareGame()
    playerMapLoaded = {}
    if(isTimer(loadMapTimeoutTimer)) then killTimer(loadMapTimeoutTimer) end
    state = STATE_ACTIVE
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5004 then
			triggerClientEvent(v, "DMclient.freezeCamera", v)
			table.insert(players,v)
		end
	end
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
    for index, player in ipairs(players) do
        removePlayerVehicle(player)
		local theIn = math.random(#theSpawns)
		local x,y,z = theSpawns[theIn][1], theSpawns[theIn][2], theSpawns[theIn][3]
		setElementPosition(player,x,y,z)
		local c=math.random(1,2)
		local vehicle = createVehicle( theSpawns[theIn][7], x, y, z+2.5,  theSpawns[theIn][4],  theSpawns[theIn][5], theSpawns[theIn][6])
		setElementDimension(vehicle, 5004)
		setElementFrozen(vehicle,true)
        warpPedIntoVehicle(player, vehicle)
		setElementAlpha(vehicle,100)
		if id == 411 then
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
		triggerClientEvent(player,"setDMclientCamera",player)
        setCameraTarget(player,player)
    end
	theSpawns = {}
    triggerClientEvent(players, "DMclient.prepareRound", resourceRoot, vehicles)
    setTimer(startGame, 8000, 1)
end



function startGame()
    players = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5004 then
			table.insert(players,v)
		end
	end
	players2 = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5004 then
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


function onDMPreKilled(attacker)
	attackers[source] = attacker
end


addEvent("onPlayerDMPreKilled", true)
addEventHandler("onPlayerDMPreKilled", root, onDMPreKilled)
function checkIfPlayerWasKilled(player)
	if attackers[player] and isElement(attackers[player][1]) then
		onPlayerDMKilled(attackers[player][1], player, attackers[player][2])
	end
end

addEvent("setDMVehicleHealth",true)
addEventHandler("setDMVehicleHealth",root,function(veh)
	if veh and isElement(veh) then
		setElementHealth(veh,250)
	end
end)


function endSpawnProtection()
    if(state == STATE_ACTIVE) then
        local vehicles = {}
        local igPlayers = {}
        for i, player in ipairs(players) do
            local vehicle = getPedOccupiedVehicle(player)
            if (vehicle and getElementDimension(player) == 5004) then
                table.insert(vehicles, vehicle)
                table.insert(igPlayers, player)
                outputChatBox("[DM] Spawn protection ended FIGHT!....", player, 10, 170, 250)
            end
        end
		for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
			if getElementDimension(v) == 5004 then
				setElementAlpha(v,255)
			end
		end
        triggerClientEvent(igPlayers, "DMclient.gameStopSpawnProtection", resourceRoot, vehicles)
    end
end

function stopGame(winner)
    if isTimer(updatePlayersTimer) then killTimer(updatePlayersTimer) end
	for i, p in ipairs(players) do
		triggerClientEvent(p,"AddDMclientCamera",p,players)
	end
    state = STATE_FINISHED
    if(#players > 1) then
        if(not winner) then
            for i, p in ipairs(players) do
                if(isAlive[p] and getElementDimension(p) == 5004) then
                    winner = p
                    break
                end
            end
        end
        if(winner) then
            local reward = ((#players)-rank) * 1000
            outputChatBox("[DM] You win, you gain $"..reward.."!",winner,0,255,0)
			givePlayerMoney(winner,reward)
			--exports.AURlevels:givePlayerXP(winner,2)
        end
    end
    if(winner) then
        for i, player in ipairs(players) do
            if(isElement(player) and getElementDimension(player) == 5004) then
                triggerClientEvent(player, "DMclient.roundWon", winner)
				triggerClientEvent(player, "DMclient.freezeCamera", player)
            end
        end
    end
    setTimer(endGame, 1000, 1)
end



function endGame()
    for i,player in ipairs(players) do
        if(getElementDimension(player) == 5004) then
			triggerClientEvent(player, "DMclient.freezeCamera", player)
			triggerClientEvent(player,"AddDMclientCamera",player,players)
            triggerClientEvent(player, "DMclient.roundEnd", player)
        end
    end
    setTimer(cleanGame, 1000, 1)
end
kk = {}
function cleanGame()
    for player, vehicle in pairs(playerVehicles) do
        if(isElement(vehicle)) then
            if(isElement(player)) then
				triggerClientEvent(player, "DMclient.freezeCamera", player)
				triggerClientEvent(player,"AddDMclientCamera",player,players)
				removePedFromVehicle(player)
            end
            destroyElement(vehicle)
        end
    end
	for k,v in pairs(thePicksDM) do
		if isElement(v) then destroyElement(v) end
	end
	for k,v in pairs(theCOL) do
		if isElement(v) then destroyElement(v) end
	end
	theCOL = {}
	thePicksDM = {}
    playerVehicles = {}
	if isTimer(kk) then killTimer(kk) end
    kk = setTimer(loadGame, 500, 1)
end



function onPlayerWasted(player)
    if(not isAlive[player] or state ~= STATE_ACTIVE) then return end
    local index
    for i, pPlayer in ipairs(players) do
        if(player == pPlayer and isAlive[pPlayer]) then -- he was actually participating
			triggerClientEvent(player,"AddDMclientCamera",player,players)
			rank = rank - 1
            isAlive[player] = false
            removePlayerVehicle(player)
			spawnPlayerSTR(player)
            startSpectate(player)
            if(rank < 1) then -- there is one player left
				stopGame()
            else
                exports.NGCdxmsg:createNewDxMessage("[DM] You finished at #"..rank, player, 200,255,200)
            end
            index = i
            break
        end
    end
    if(index and gameStartTick) then -- valid death
        local secondsSinceStart = math.floor((getTickCount()-gameStartTick)/1000)
        local deathTime = string.format("%02i:%02i", secondsSinceStart/60, secondsSinceStart%60)
        for i, pPlayer in ipairs(players) do
            if(isElement(pPlayer) and getElementDimension(pPlayer) == 5004) then
				triggerClientEvent(player,"AddDMclientCamera",player,players)
				if theATK[player] then
					bywho = theATK[player]
				else
					bywho = ""
				end
                triggerClientEvent(pPlayer, "DMclient.playerWasted", player, rank, deathTime,getPlayerName(player),bywho)
            end
        end
    end
    if(index) then -- find people who are spectating, if they were spectating the person who died, go to the next
        for player, i in pairs(spectators) do
            if(i == index and getElementDimension(player) == 5004) then
                nextSpectateTarget(player)
            end
        end
    end
end



addEventHandler("onPlayerWasted", root,
    function ()
        if (getElementDimension(source) == 5004) then
            onPlayerWasted(source)
        end
		if isPlayerInDM[source] then
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
				if getElementDimension(v) == 5004 then
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
setElementDimension(gravityjump1,5004)


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
			loadMap(maptype,5004,player)
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
        if getElementDimension(source) == 5004 then
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
		if isPlayerInDM[source] or getElementDimension(source) == 5004 then
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
            triggerClientEvent(player,"setDMclientCamera",player)
			setSpectateTarget(player, pPlayer, i)
            found = true
            break
        end
    end
    if(not found) then
        triggerClientEvent(player, "DMclient.freezeCamera", player)
		triggerClientEvent(player,"AddDMclientCamera",player,players)
    end
end

function setSpectateTarget(player, target, i)
    if(getElementDimension(player) ~= 5004) then return false end
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
	triggerClientEvent(player,"AddDMclientCamera",player,players)
end

function playDM(player)
	triggerClientEvent(player, "DMclient.freezeCamera", player)
	setElementFrozen(player,true)
	onClientMapLoaded(player)
	showChat(player,true)
	spawnPlayerSTR(player)
	if(not isTimer(onResourceStartTimer)) then onPlayerJoinGame(player) end
	bindKey(player, "arrow_r", "up", nextSpectateTarget)
	bindKey(player, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(source,"AddDMclientCamera",source,players)
end


addEvent("quitDMRoom",true)
addEventHandler("quitDMRoom",root,function()
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
				triggerClientEvent(source,"setDMclientCamera",source)
				setCameraTarget(source)
				setCameraTarget(source,source)
				exports.NGCdxmsg:createNewDxMessage(source,"We have returned you to your old position",255,250,0)
				positions[source] = {}
			end
		end
	end
	triggerClientEvent(source,"removeDMloaddedModels",source)
	unbindKey(source, "arrow_r", "up", nextSpectateTarget)
	unbindKey(source, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(source,"setDMclientCamera",source)
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
				triggerClientEvent(player,"setDMclientCamera",player)
				setCameraTarget(player,player)
				exports.NGCdxmsg:createNewDxMessage(player,"We have returned you to your old position",255,250,0)
				positions[player] = {}
			end
		end
	end
	unbindKey(player, "arrow_r", "up", nextSpectateTarget)
	unbindKey(player, "arrow_l", "up", previousSpectateTarget)
	triggerClientEvent(player,"setDMclientCamera",player)
	setCameraTarget(player,player)
	setTimer(function(p)
	setCameraTarget(p,p)
	end,3000,1,player)

end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		onResourceStartTimer = setTimer(loadGame, 2000, 1) -- fix for warpPedIntoVehicle onStart issue: http://bugs.mtasa.com/view.php?id=7855
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5004 then
				playDM(player)
			end
		end
	end
)

addEventHandler("onResourceStop", resourceRoot,
	function ()
		for i, player in ipairs(getElementsByType("player")) do
			if getElementDimension(player) == 5004 then
				playerExitRoom(player)
			end
		end
	end
)

function onVehicleStartExit(player)
	if getElementDimension(player) == 5004 then
		cancelEvent()
		onPlayerWasted(player)
	end
end
addEventHandler("onVehicleStartExit", root, onVehicleStartExit)
