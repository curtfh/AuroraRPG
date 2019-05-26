duelDims = {}

duelRequests = {
    ["player"] = {},
}


spawnPoints = {
    ["Duel"] = {
       ["Team1"] = {
            [1] =  {2556.0864257813,2824.6171875,10.8203125,271},

        },
        ["Team2"] = {
            [1] =  {2610.2463378906,2830.1828613281,10.8203125,93},
        },
    },
}


lastPlayerData = {}

for i=11000, 12000 do
    duelDims[i] = {}
    duelDims[i].used = nil
    duelDims[i].money = nil
    duelDims[i].Armor = nil
    duelDims[i].src1 = nil
    duelDims[i].src2 = nil
    duelDims[i].weaponsTable = nil
end

for k, v in ipairs(getElementsByType("player")) do
    if (getElementData(v, "DuelIndex")) then setElementData(v, "DuelIndex",false) end
end


addCommandHandler("duel",function(player)
	if getElementData(player,"isPlayerLoggedin") ~= true then return false end
	if getElementData(player,"isPlayerJailed") then return false end
	if getElementData(player,"isPlayerArrested") then return false end
	if getElementData(player,"safezone") then
		exports.NGCdxmsg:createNewDxMessage(player,"You can't open the panel yet",255,0,0)
		return false
	end
	openPanel(player, true, true)
end)


function openPanel(player, sDuelReq, showWindow)
    if (isElement(player)) then
		local invites
		if (sDuelReq) then
			invites = getPlayerDuelRequests(player)
		end
		local wonDuels = exports.DENstats:getPlayerAccountData(player,"duelWins") or 0
		local lostDuels = exports.DENstats:getPlayerAccountData(player,"duelLoses") or 0
		triggerLatentClientEvent(player, "NGCduel.openDuelPanel", player, wonDuels, lostDuels, invites)
    end
end


addEvent("NGCduel.duelPlayer",true)
addEventHandler("NGCduel.duelPlayer",root,function(player, moneyAmount, weaponsTable, map)
	if (isElement(player)) then
		if getElementData(player,"isPlayerLoggedin") ~= true then return false end
		if (not duelRequests["player"][player]) then
			duelRequests["player"][player] = {}
		end
		if (not duelRequests["player"][player][client]) then
			duelRequests["player"][player][client] = {moneyAmount or 0, weaponsTable, map}
			exports.NGCdxmsg:createNewDxMessage(client,"Duel challenge has been sent to "..getPlayerName(player), 0, 255, 0)
			exports.NGCdxmsg:createNewDxMessage(player,"Duel challenge has been sent from "..getPlayerName(client), 0, 255, 0)
		else
			exports.NGCdxmsg:createNewDxMessage(client,"The duel has been canceled to "..getPlayerName(player)..".", 255, 0, 0)
			exports.NGCdxmsg:createNewDxMessage(player,"The duel has been canceled by "..getPlayerName(client)..".", 255, 0, 0)
			duelRequests["player"][player][client] = nil
		end
	else
		exports.NGCdxmsg:createNewDxMessage(client,"Player is offline", 255, 0, 0)
	end
end)


addEvent("NGCduel.UpdateMyGrid",true)
addEventHandler("NGCduel.UpdateMyGrid",root,function()
	local invites = getPlayerDuelRequests(source)
	local wonDuels = exports.DENstats:getPlayerAccountData(player,"duelWins") or 0
	local lostDuels = exports.DENstats:getPlayerAccountData(player,"duelLoses") or 0
	triggerLatentClientEvent(source, "NGCduel.updatePanel", source, wonDuels, lostDuels, invites)
end)


addEvent("NGCduel.rejectAllDuels",true)
addEventHandler("NGCduel.rejectAllDuels",root,function()
	if (duelRequests["player"][source]) then
        duelRequests["player"][source] = nil
    end
    local invites = getPlayerDuelRequests(source)
	local wonDuels = exports.DENstats:getPlayerAccountData(player,"duelWins") or 0
	local lostDuels = exports.DENstats:getPlayerAccountData(player,"duelLoses") or 0
	triggerLatentClientEvent(source, "NGCduel.updatePanel", source, wonDuels, lostDuels, invites)
end)




addEvent("NGCduel.RejectDuel", true)
addEventHandler("NGCduel.RejectDuel", root,function(prime)
	if (isElement(prime)) then
		duelRequests["player"][source][prime] = nil
	else
		for k, v in pairs(duelRequests["player"][source]) do
			if (not isElement(k)) then
				duelRequests["player"][source][k] = nil
			end
		end
	end
    triggerEvent("NGCduel.UpdateMyGrid",source)
end)





addEvent("NGCduel.AcceptDuel", true)
addEventHandler("NGCduel.AcceptDuel", root,function(prime)
	if (not isElement(prime)) then return end
	if (duelRequests["player"][source][prime]) then
		local tempData = duelRequests["player"][source][prime]
		local ptable = {source, prime}
		duelRequests["player"][source][prime] = nil
		for k, v in ipairs(ptable) do
			local playerCanDuel, errMsg = canPlayerDuel(v, {tempData[1]})
			if (not playerCanDuel) then
				for key, val in ipairs(ptable) do
					if (val ~= v) then
						exports.NGCnote:addNote("dd",getPlayerName(v).." can't participate in this duel because of ("..errorMessages[errMsg][1]..")",val,255, 0, 0,5000)
						triggerClientEvent(source,"NGCduel.abortDuel",source)
						triggerClientEvent(prime,"NGCduel.abortDuel",prime)
					end
				end
				exports.NGCnote:addNote("duelerror","You aren't allowed to participate in this duel because "..errorMessages[errMsg][2],v, 255, 0, 0,5000)
				triggerEvent("NGCduel.UpdateMyGrid",source)
				triggerClientEvent(source,"NGCduel.abortDuel",source)
				triggerClientEvent(prime,"NGCduel.abortDuel",prime)
				return
			end
		end
		triggerClientEvent(prime,"NGCduel.abortDuel",prime)
		triggerClientEvent(source,"NGCduel.abortDuel",source)
		startDueling("Duel",source, prime, tempData)
	end
end)




function startDueling(Armor,src1, src2, duelData)
    if (not spawnPoints[duelData[3]]) then return end
        local duelIndex = getAvailableDimension()
        duelDims[duelIndex].used = true
        duelDims[duelIndex].money = duelData[1]
		duelDims[duelIndex].Armor = Armor
        duelDims[duelIndex].src1 = src1
        duelDims[duelIndex].src2 = src2
        duelDims[duelIndex].rules = duelData[2]
		if getPlayerMoney(src1) < tonumber(duelData[1]) then
			exports.NGCnote:addNote("dm","You don't have enough money",src1,255,0,0)
			forceDuel(duelIndex,"Not enough money")
			return false
		end
		if getPlayerMoney(src2) < tonumber(duelData[1]) then
			exports.NGCnote:addNote("dm","You don't have enough money",src2,255,0,0)
			forceDuel(duelIndex,"Not enough money")
			return false
		end
		if (duelData[1] > 0) then
			exports.NGCmanagement:RPM(src1, duelData[1])
			exports.NGCmanagement:RPM(src2, duelData[1])
			warpTeams({src1}, {src2}, {duelIndex,Armor,duelData})
		end
	return duelIndex
end


function warpTeams(team1, team2, data)
    for k, v in ipairs(team1) do
        if (isPedInVehicle(v)) then removePedFromVehicle(v) end
        setElementData(v, "DuelIndex", data[1])
        getPlayerData(v)
        triggerClientEvent(v, "onPlayerDuel", v, data[2], data[3][2], team1, data[3][3], data[1])
        setElementDimension(v, data[1])
        setElementPosition(v, spawnPoints[data[3][3]]["Team1"][k][1], spawnPoints[data[3][3]]["Team1"][k][2], spawnPoints[data[3][3]]["Team1"][k][3])
        setElementHealth(v,200)
		setPedAnimation(v,false)
		setPedArmor(v,0)
		toggleControl(v,"fire",true)
		toggleControl(v,"aim_weapon",true)
		setTimer(function(v)
		toggleControl(v,"fire",true)
		toggleControl(v,"aim_weapon",true)
		end,5000,1,v)
    end
    for k, v in ipairs(team2) do
        if (isPedInVehicle(v)) then removePedFromVehicle(v) end
        setElementData(v, "DuelIndex", data[1])
		setPedAnimation(v,false)
        getPlayerData(v)
		setElementHealth(v,200)
		setPedArmor(v,0)
        triggerClientEvent(v, "onPlayerDuel", v, data[2], data[3][2], team2, data[3][3], data[1])
        setElementDimension(v, data[1])
        setElementPosition(v, spawnPoints[data[3][3]]["Team2"][k][1], spawnPoints[data[3][3]]["Team2"][k][2], spawnPoints[data[3][3]]["Team2"][k][3])
        toggleControl(v,"fire",true)
		toggleControl(v,"aim_weapon",true)
		setTimer(function(v)
		toggleControl(v,"fire",true)
		toggleControl(v,"aim_weapon",true)
		end,5000,1,v)
    end
end


function returnPlayerToLastPos(player)
    if (lastPlayerData[player]) then
        if (getElementData(player, "DuelIndex")) then
            setElementData(player, "DuelIndex",false)
            toggleAllControls(player, true, true, true)
            setElementPosition(player, lastPlayerData[player][1] or 0, lastPlayerData[player][2] or 0, lastPlayerData[player][3] or 0)
            setElementInterior(player,0)
            setElementDimension(player,0)
            setElementHealth(player, lastPlayerData[player][6] or 200)
            lastPlayerData[player] = nil
			detonateSatchels ( player )
        end
    else
        killPed(player)
		detonateSatchels( player )
    end
end



function playerDefeated(player, duelIndex)
    if (not getElementData(player, "DuelIndex")) then return end
    triggerClientEvent(player, "StopDuelClientside", player)
    if (duelDims[duelIndex] and duelDims[duelIndex].used) then
        if (not isPedDead(player)) then
            setTimer(function(plr) if (isElement(plr)) then returnPlayerToLastPos(plr) end end, 1500, 1, player)
            toggleAllControls(player, false, true, false)
        end
		local money = duelDims[duelIndex].money or 0
		local winner
		if (duelDims[duelIndex].src1 == player) then winner = duelDims[duelIndex].src2 else winner = duelDims[duelIndex].src1 end
		setTimer(function(plr) if (isElement(plr)) then returnPlayerToLastPos(plr) end end, 1500, 1, winner)
		toggleAllControls(winner, false, true, false)
		triggerClientEvent(winner, "StopDuelClientside", winner)
		if (money == 0) then
			exports.NGCdxmsg:createNewDxMessage(winner,"You won the duel",0, 255, 0)
			exports.NGCdxmsg:createNewDxMessage(player,"You lost the duel", 255, 0, 0)
		else
			exports.NGCdxmsg:createNewDxMessage(winner,"You won the duel and earned $"..money, 0, 255, 0)
			exports.NGCdxmsg:createNewDxMessage(player,"You lost the duel and lost $"..money, 255, 0, 0)
			if (money and money > 0) then
				exports.NGCmanagement:GPM(winner, money * 2,"NGC Duel","Given money on winning")
			end
		end
		local wins = exports.DENstats:getPlayerAccountData(winner,"duelWins")
		if wins == nil or wins == false then wins = 0 end
		exports.DENstats:setPlayerAccountData(winner,"duelWins",wins+1)
		local loses = exports.DENstats:getPlayerAccountData(winner,"duelLoses")
		if loses == nil or loses == false then loses = 0 end
		exports.DENstats:setPlayerAccountData(player,"duelLoses",loses+1)
		duelDims[duelIndex] = {}
    end
end

--**************************************************************************************
--********							Duel miscs 									********
--**************************************************************************************


-- Check if a player is a law player
local lawTeams = {
	"Staff",
}

function isStaff( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end


function getPlayersAbleToParticipate(team1, team2, data) ---- teams check but i dont know if its working or not
    local t1p = {["able"] = {}, ["unable"] = {}}
    local t2p = {["able"] = {}, ["unable"] = {}}
    for k, v in ipairs(getDuelTeamMembers(team1)) do
        local playerCanDuel, err = canPlayerDuel(v)
        if (playerCanDuel) then
            table.insert(t1p["able"], v)
        else
            table.insert(t1p["unable"], {v, err})
        end
    end
    for k, v in ipairs(getDuelTeamMembers(team2)) do
        local playerCanDuel, err = canPlayerDuel(v)
        if (playerCanDuel) then
            table.insert(t2p["able"], v)
        else
            table.insert(t2p["unable"], {v, err})
        end
    end
    return t1p, t2p
end

function getPlayerData(player)
    local x, y, z = getElementPosition(player)
    local int = getElementInterior(player)
    local dim = getElementDimension(player)
    local health = getElementHealth(player)
    lastPlayerData[player] = {x, y, z, int, dim, health}
    local index = getElementData(player, "DuelIndex")
    if (index) then
        if (duelDims[index].rules and not duelDims[index].rules[17]) then
            setPedArmor(player, 0)
        end
    end
end

errorMessages = {
    ["jailed"] = {"player is jailed", "you're jailed wait until you release"},
    ["alreadyinduel"] = {"player is already in duel", "you're already in a duel dude!"},
    ["wanted"] = {"players wanted level is too high", "your wanted level is too high"},
    ["dead"] = {"player is dead", "you're dead can't duel"},
    ["notinmainworld"] = {"player is not in the main world", "you're not in the main world"},
    ["frozen"] = {"player is frozen", "you're frozen can't duel"},
    ["arrested"] = {"player is arrested", "you're arrested can't duel"},
    ["money"] = {"player doesn't have enough money", "you don't have enough money"},
    ["law"] = {"Player can't duel while he's Cop", "you must quit job or end shift, you cant duel while you'r cop"},
    ["animation"] = {"Player can't duel while he's animation", "you must stop animation, you cant duel while you are using animation"},
    ["safezone"] = {"Player can't duel while he just spawned", "You cant duel while you just spawned"},
    ["armor"] = {"Player can't duel while holding armor", "You cant duel while holding armor"},	
    ["attached"] = {"Player can't duel while being attached to an element", "You cant duel while being attached to an element."},	
}



function canPlayerDuel(player, data) --- important checks dont touch dick head
    if (not isElement(player)) then return end
	if (isElementAttached(player)) then
		return false, "attached"
	end
    if getElementData(player,"isPlayerJailed") == true then
        return false, "jailed"
    end
    if getElementData(player,"armor") == true then
        return false, "armor"
    end	
    if (isPlayerDueling(player)) then
        return false, "alreadyinduel"
    end
    if (getElementData(player, "wantedPoints") > 10) then
        return false, "wanted"
    end
    if (isPedDead(player)) then
        return false, "dead"
    end
    if (getElementDimension(player) ~= 0) or (getElementInterior(player) ~= 0) then
        return false, "notinmainworld"
    end
    if (exports.DENlaw:isLaw(player)) or isStaff(player) then
       return false, "law"
    end
    if (isElementFrozen(player)) then
        return false, "frozen"
    end
    if getElementData(player,"isPlayerArrested") == true then
        return false, "arrested"
    end
    if getElementData(player,"safezone") == true then
        return false, "safezone"
    end
    if (data) then
        if (data[1] and tonumber(data[1]) and getPlayerMoney(player) < data[1]) then
            return false, "money"
        end
    end
    return true
end


function onElementDataChange(name, var)
    if (getElementType(source) == "player" and name == "DuelIndex" and getElementData(source, name) == "d") then
        playerDefeated(source, var)
    end
end
addEventHandler("onElementDataChange", root, onElementDataChange)


addEvent("onPlayerJobChange",true)
addEventHandler("onPlayerJobChange",root,function(new,old)
	local duelIndex = getElementData(source, "DuelIndex")
    if (type(duelIndex) == "number") then
        playerDefeated(source, duelIndex)
    end
end)

addEvent("onStartShift",true)
addEventHandler("onStartShift",root,function(occ)
	local duelIndex = getElementData(source, "DuelIndex")
    if (type(duelIndex) == "number") then
        playerDefeated(source, duelIndex)
    end
end)

addEvent("onEndShift",true)
addEventHandler("onEndShift",root,function()
	local duelIndex = getElementData(source, "DuelIndex")
    if (type(duelIndex) == "number") then
        playerDefeated(source, duelIndex)
    end
end)

function onPlayerQuit()
    local duelIndex = getElementData(source, "DuelIndex")
    if duelIndex then
        playerDefeated(source, duelIndex)
		returnPlayerToLastPos(source)
		return false
    end
	for i=11000, 12000 do
		if getElementDimension(source) == i then
			playerDefeated(source, i)
			returnPlayerToLastPos(source)
		end
	end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit, true, "high")

function onPlayerWasted()
    local duelIndex = getElementData(source, "DuelIndex")
    if duelIndex then
        playerDefeated(source, duelIndex)
		setElementData(source,"DuelIndex",false)
		return false
    end
	for i=11000, 12000 do
		if getElementDimension(source) == i then
			playerDefeated(source, duelIndex)
		end
	end
end
addEventHandler("onPlayerWasted", root, onPlayerWasted)

function abortDuel(duelIndex, reason)
    if (duelDims[duelIndex] and duelDims[duelIndex].used) then
		returnPlayerToLastPos(duelDims[duelIndex].src1)
		returnPlayerToLastPos(duelDims[duelIndex].src2)
		setElementData(duelDims[duelIndex].src1, "DuelIndex",false)
		setElementData(duelDims[duelIndex].src2, "DuelIndex",false)
		exports.NGCdxmsg:createNewDxMessage(duelDims[duelIndex].src1,"Duel has been aborted because of : "..tostring(reason), 255, 0, 0)
		exports.NGCdxmsg:createNewDxMessage(duelDims[duelIndex].src2,"Duel has been aborted because of : "..tostring(reason), 255, 0, 0)
		local money = duelDims[duelIndex].money
		if (money and money > 0) then
			exports.NGCmanagement:GPM(duelDims[duelIndex].src1, money,"NGC Duel","Given on aborting")
			exports.NGCmanagement:GPM(duelDims[duelIndex].src2, money,"NGC Duel","Given on aborting")
		end
        duelDims[duelIndex] = {}
    end
end

function forceDuel(duelIndex,reason)
	if (duelDims[duelIndex] and duelDims[duelIndex].used) then
		returnPlayerToLastPos(duelDims[duelIndex].src1)
		returnPlayerToLastPos(duelDims[duelIndex].src2)
		setElementData(duelDims[duelIndex].src1, "DuelIndex",false)
		setElementData(duelDims[duelIndex].src2, "DuelIndex",false)
		exports.NGCdxmsg:createNewDxMessage(duelDims[duelIndex].src1,"Duel has been aborted because of : "..tostring(reason), 255, 0, 0)
		exports.NGCdxmsg:createNewDxMessage(duelDims[duelIndex].src2,"Duel has been aborted because of : "..tostring(reason), 255, 0, 0)
		duelDims[duelIndex] = {}
	end
end

function abortDuels()
    for i=11000, 12000 do
        if (duelDims[i].used) then
            abortDuel(i, "resource stopped")
        end
    end
end
addEventHandler("onResourceStop", resourceRoot, abortDuels)


function isPlayerDueling(player) --- export to check if the nigga is dueling
    if (getElementData(player, "DuelIndex")) then
        return true
    else
        return false
    end
end


function getPlayerDuelRequests(player) --- getting duel request
    if (not isElement(player)) then return end
	return {["player"] = duelRequests["player"][player] or {}}
end


function getAvailableDimension() --- to prevent asshole from getting in other duel dim for another player or .. nvm
    for k, v in pairs(duelDims) do
        if (not v.used) then
            return k
        end
    end
end



function onPlayerQuit2()
    duelRequests["player"][source] = nil
end
addEventHandler("onPlayerQuit", root, onPlayerQuit2)
