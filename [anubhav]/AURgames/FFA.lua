FFAPlayer = {}
local FFAEliminatedPlayers = {}
local FFAPlayers = {}
FFAStarted = false
local FFAtimer
local FFAstartingTimer
local FFADimension = 5000
local FFAMinPlayers = 8
local FFAMaxPlayers = 15
local timeOut = 900000 -- 15 minutes until time out
maptype = "FFA1"
local proTimer3 = {}
local allowedCity = "LS"
local spammer5 = {}
local jailRadar = createRadarArea( 344.24, 637.82,600,600,0,0,0,250)
local jailCol = createColRectangle(280.66,-2885.72,1050,1050)
setElementDimension(jailCol,5000)
setElementDimension(jailRadar,5000)

local vehID = {
	[1]=541,
	[2]=603,
	[3]=559,
	[4]=415,
	[5]=475,
	[6]=402
}


function theChecking5()
	if (not FFAStarted) then
		return
	end
	for index, player in pairs(FFAPlayers) do
		if player and isElement(player) then
			if (getElementDimension(player) == 5000) then

			else
				FFAFailed(player,"Died due not in dimension")
			end
			if isElementWithinColShape(player,jailCol) then

			else
				FFAFailed(player,"Died left col")
			end
		end
	end
end


function leaveEvent(player)
	if nextEvent == "FFA" then
		if (not FFAPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Free For All : You didn't signup for the FFA Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		if (FFAStarted) then
			addEventMsg(nil,"(Mini-Game) Free For All : You can't leave from this event because it's already started", player, 255, 0, 0)
			return
		end
		FFAPlayer[player] = nil
		for index, player2 in pairs(FFAPlayers) do
			if (player == player2) then
				table.remove(FFAPlayers, index)
				break
			end
		end
		if (#FFAPlayers < FFAMinPlayers and isTimer(FFAstartingTimer)) then
			killTimer(FFAstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onFFAQuit)
	end
end
addCommandHandler("leave", leaveEvent)


function onForceFFA(player)
	if nextEvent == "FFA" then
		if (not FFAPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Free For All : You didn't signup for the FFA Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		FFAPlayer[player] = nil
		for index, player2 in pairs(FFAPlayers) do
			if (player == player2) then
				table.remove(FFAPlayers, index)
				break
			end
		end
		if (#FFAPlayers < FFAMinPlayers and isTimer(FFAstartingTimer)) then
			killTimer(FFAstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onFFAQuit)
	end
end


function signupForFFA(client)
	if (isEventStarted("FFA") ~= true) then
		return
		addEventMsg(nil,"(Mini-Game) Free For All : This event is not started yet", client, 255, 0, 0)
	end
	if (FFAPlayer[client]) then
		addEventMsg(nil,"(Mini-Game) Free For All : You have already signed up for this event", client, 255, 0, 0)
		return
	end
	if (#FFAPlayers == FFAMaxPlayers) then
		addEventMsg(nil,"(Mini-Game) Free For All : The event is already full and about to start", client, 255, 0, 0)
		return
	end
	if (FFAStarted) then
		addEventMsg(nil,"(Mini-Game) Free For All : The event is already started", client, 255, 0, 0)
		return
	end
	if getPlayerTeam(client) then
		if getTeamName(getPlayerTeam(client)) == "Staff" then
			addEventMsg(nil,"(Mini-Game) Hydra: You can't join while you're on staff duty!!", client, 255, 0, 0)
			return
		end
	end
	if hasProsiner(client) == false then
		addEventMsg(nil,"(Mini-Game) Hydra: You can't join while you arrested someone!!", client, 255, 0, 0)
		return
	end
	if (getElementDimension(client) > 0) then
		addEventMsg(nil,"(Mini-Game) Free For All : you can't join the FFA event while you're not in main world", client, 255, 0, 0)
		return
	end
	if getElementData(client,"isPlayerJailed") or getElementData(client,"isPlayerArrested") then
		addEventMsg(nil,"(Mini-Game) Free For All : you can't join the FFA event while you're arrested or jailed!", client, 255, 0, 0)
		return
	end
	FFAPlayer[client] = true
	getPlayerPosition(client)
	sendToFFAPlayers(getPlayerName(client).." has signed up. "..(#FFAPlayers + 1).."/"..FFAMaxPlayers.." players signed up", 0,255,0)
	table.insert(FFAPlayers, client)
	addEventHandler("onPlayerQuit", client, onFFAQuit)
	addEventMsg(nil,"(Mini-Game) #FFFFFFFree For All : You have signed up !!.", client, 0,255,0)
	if (#FFAPlayers == FFAMinPlayers) then
		FFAstartingTimer = setTimer(beforeStartFFA, 10000, 1)
		sendToFFAPlayers("(Mini-Game) Free For All : Event will be started within 10 seconds!", 0,255,0)
	end
	if (#FFAPlayers == FFAMaxPlayers) then
		if (isTimer(FFAstartingTimer)) then
			killTimer(FFAstartingTimer)
		end
		beforeStartFFA()
	end
end



function sendToFFAPlayers(message, r, g, b)
	for index, player in pairs(FFAPlayers) do
		addEventMsg(nil,message, player, r, g, b)
	end
end

function beforeStartFFA()
	FFAStarted = true
	sendToFFAPlayers(#FFAPlayers.." players have signed up for the FFA Event. please wait 5 seconds.", 0,255,0)
	addWastedHandler355()
	nm = "FFA1"
	allowedCity = "LV"
	maptype = nm
	loadMap(nm)
	setTimer(startFFA, 5000, 1) -- here too
end

function addWastedHandler355()
	for index, player in pairs(FFAPlayers) do
		if (isElement(player)) then
			addEventHandler("onPlayerWasted", player, onFFAWasted)
		end
	end
end


function startFFA()
	stopText()
	if isTimer(proTimer3) then killTimer(proTimer3) end
	for k,v in ipairs(getElementsByType("player")) do
		if isPedDead(v) then
			for index, xplayer in pairs(FFAPlayers) do
				if (v == xplayer) then
					table.remove(FFAPlayers, index)
					break
				end
			end
		end
	end
	for index, player in ipairs(FFAPlayers) do
		if (player and isElement(player) and getElementData(player,"isPlayerJailed") == false) then
			if (isPedInVehicle(player)) then
				removePedFromVehicle(player)
			end
			if isPedDead(player) then
				return
			end
			setElementPosition(player,ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3])
			setElementDimension(player, FFADimension)
			setElementRotation(player,0,0,ShooterPos[maptype][index][4])
			triggerClientEvent(player, "startCountDown", player,2000)
			setElementFrozen(player, true)
			setElementHealth(player,200)
			setPedArmor(player,100)
			toggleAllControls(player, false)
			setTimer(setElementFrozenDelayed2225, 8000, 1, player, false)

		end
	end
	FFATimer = setTimer(enFFAD, timeOut, 1)
	proTimer3 = setTimer(theChecking5,500,0)

end


function setElementFrozenDelayed2225(plr, bool)
	if (isElement(plr)) then
		toggleAllControls(plr, true)
		setElementFrozen(plr, bool)
	end
end

function onFFAWasted(ammo,attacker)
	if getElementDimension(source) ~= 5000 then
		onForceFFA(source)
	else
		if attacker and isElement(attacker) and getElementType(attacker) == "player" and source and isElement(source) and getElementType(source) == "player" then
			if FFAPlayer[attacker] and FFAPlayer[source] then
				exports.AURlevels:givePlayerXP(attacker,2)
				addEventMsg("killmsg","(Mini-Game) Free For All : #FFFFFF+2 XP for killing "..getPlayerName(source), attacker, 255, 0, 0)
			end
		end
		FFAFailed(source,"Just wasted")
	end
end


function onFFAQuit()
	if (not FFAPlayer[source]) then
		return
	end
	for index, player in pairs(FFAPlayers) do
		if (source == player) then
			table.remove(FFAPlayers, index)
			break
		end
	end
	if (FFAStarted) then
		sendToFFAPlayers(getPlayerName(source).." is out!", 0,255,0)
		if (#FFAPlayers == 1) then
			enFFAD(FFAPlayers[1])
		end
	else
		if (#FFAPlayers < FFAMinPlayers and isTimer(FFAstartingTimer)) then
			killTimer(FFAstartingTimer)
		end
	end
end


function onLogin2s()
	if (getElementDimension(source) == FFADimension) then
		setElementDimension(source, 0)
	end
end
addEventHandler("onPlayerLogin", root, onLogin2s)

function enFFAD(player)
	if (isElement(player)) then
		FFAPlayer[player] = nil
		outputChatBox("(Mini-Game) Free For All : You won the FFA Event! You got $"..moneyEarn.." +2 scores| +2 XP", player, 0, 255, 0)
		givePlayerMoney(player,moneyEarn)
		exports.AURlevels:givePlayerXP(player,2)
		exports.CSGscore:givePlayerScore(player,2)
		removeEventHandler("onPlayerWasted", player, onFFAWasted)
		removeEventHandler("onPlayerQuit", player, onFFAQuit)
		addEventMsg(nil,getPlayerName(player).." has won the FFA Event!",root, 0,255,0)
		outputChatBox("(Mini-Game [FFA]) : "..getPlayerName(player).." has won the Event!",root, 0,255,0)
		setTimer(function(p)
			killPed(p)
		end,2000,1,player)
	else
		for index, player in pairs(FFAPlayers) do
			FFAPlayer[player] = nil
			addEventMsg(nil,"(Mini-Game) Free For All : Event has ended!! You lost dude!!", player, 255, 0, 0)
			removeEventHandler("onPlayerWasted", player, onFFAWasted)
			removeEventHandler("onPlayerQuit", player, onFFAQuit)
			killPed(player)
		end
		for index, player in pairs(FFAEliminatedPlayers) do
			addEventMsg(nil,"(Mini-Game) Free For All : Event has ended!! You lost dude!!", player, 255, 0, 0)
			addEventMsg(nil,"(Mini-Game) Free For All : None won in this Event!!", player, 255, 0, 0)
		end
	end
	FFAPlayers = {}
	FFAEliminatedPlayers = {}
	FFAPlayer = {}
	FFAStarted = false
	if (isTimer(FFATimer)) then
		killTimer(FFATimer)
	end
	FFATimer = nil
	if isTimer(proTimer3) then killTimer(proTimer3) end
	stopEvent("FFA")
	startEvent("HF")
end

function stopExit2355(player)
	if (FFAStarted and FFAPlayer[player]) then
		cancelEvent()
	end
end

function FFAFailed(plr,msg)
	if (not FFAPlayer[plr]) then
		return
	end
	outputDebugString(getPlayerName(plr))
	FFAPlayer[plr] = nil
	table.insert(FFAEliminatedPlayers, plr)
	removeEventHandler("onPlayerWasted", plr, onFFAWasted)
	removeEventHandler("onPlayerQuit", plr, onFFAQuit)
	sendToFFAPlayers(getPlayerName(plr).." is out!", 0,255,0)
	for index, player in pairs(FFAPlayers) do
		if (plr == player) then
			table.remove(FFAPlayers, index)
			break
		end
	end
	if (#FFAPlayers == 1) then
		enFFAD(FFAPlayers[1])
	elseif (#FFAPlayers == 0) then
		enFFAD(nil)
	end
	killPed(plr)
	outputDebugString(getPlayerName(plr)..": "..msg)
end

