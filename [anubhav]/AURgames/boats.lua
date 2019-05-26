SWPlayer = {}
local SWEliminatedPlayers = {}
local SWPlayers = {}
local SWvehicles = {}
local SWVehDrivers = {}
local SWpickups = {}
SWStarted = false
local SWtimer
local SWstartingTimer
local SWDimension = 5000
local SWMinPlayers = 8
local SWMaxPlayers = 15
local timeOut = 900000 -- 15 minutes until time out
maptype = "SW1"
local proTimer3 = {}
local allowedCity = "LS"
local spammer5 = {}
addEvent("setSWKiller",true)
addEventHandler("setSWKiller",root,function(attacker,player)
	if player and attacker then
		if player ~= attacker then
			if getElementDimension(player) == 5000 then
				if spammer5[player] and isTimer(spammer5[player]) then return false end

				addEventMsg("Killer","(Mini-Game) Ships War : #FFFFFFYou have been killed by "..getPlayerName(attacker), player, 255, 0, 0)
				addEventMsg("Killer2","(Mini-Game) Ships War : #FFFFFFYou have killed  "..getPlayerName(player).." +2 XP", attacker, 255, 0, 0)
				spammer5[player] = setTimer(function() end,5000,1)
				exports.AURlevels:givePlayerXP(attacker,2)
			end
		end
	end
end)


local vehID = {
	[1]=541,
	[2]=603,
	[3]=559,
	[4]=415,
	[5]=475,
	[6]=402
}


function theChecking9()
	if (not SWStarted) then
		return
	end
	for index, player in pairs(SWPlayers) do
		if player and isElement(player) then
			if (getElementDimension(player) == 5000) then
				if isPedInVehicle(player) == false then
					SWFailed(player,"Player isn't in vehicle")
				else
					if tostring(exports.server:getPlayChatZone(player)) ~= tostring(allowedCity) then
						SWFailed(player,"Player isn't in chatzone")
						exports.NGCdxmsg:createNewDxMessage("(Mini-Game) SW : You have lost due left "..allowedCity,player,255,0,0)
					end
				end
			else
				SWFailed(player,"Died due not in dimension")
			end
		end
	end
	--[[for index, vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		if vehicle and isElement(vehicle) then
			if (getElementDimension(vehicle) == 5000) then
				if isElementInWater(vehicle) then
					if getElementData(vehicle,"mini-hit") then
						local thePlayer,theKiller = unpack(getElementData(vehicle,"mini-hit"))
						if thePlayer and isElement(thePlayer) and theKiller and isElement(theKiller) then
							triggerEvent("setSWKiller",theKiller,theKiller,thePlayer)
						end
					end
					local driver = SWVehDrivers[vehicle]
					if driver then
						SWFailed(driver)
					end
				end
			end
		end
	end]]
end


function leaveEvent(player)
	if nextEvent == "SW" then
		if (not SWPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Ships War : You didn't signup for the SW Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		if (SWStarted) then
			addEventMsg(nil,"(Mini-Game) Ships War : You can't leave from this event because it's already started", player, 255, 0, 0)
			return
		end
		SWPlayer[player] = nil
		for index, player2 in pairs(SWPlayers) do
			if (player == player2) then
				table.remove(SWPlayers, index)
				break
			end
		end
		if (#SWPlayers < SWMinPlayers and isTimer(SWstartingTimer)) then
			killTimer(SWstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onSWQuit)
	end
end
addCommandHandler("leave", leaveEvent)


function onForceSW(player)
	if nextEvent == "SW" then
		if (not SWPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Ships War : You didn't signup for the SW Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		SWPlayer[player] = nil
		for index, player2 in pairs(SWPlayers) do
			if (player == player2) then
				table.remove(SWPlayers, index)
				break
			end
		end
		if (#SWPlayers < SWMinPlayers and isTimer(SWstartingTimer)) then
			killTimer(SWstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onSWQuit)
	end
end


function signupForSW(client)
	if (isEventStarted("SW") ~= true) then
		return
		addEventMsg(nil,"(Mini-Game) Ships War : This event is not started yet", client, 255, 0, 0)
	end
	if (SWPlayer[client]) then
		addEventMsg(nil,"(Mini-Game) Ships War : You have already signed up for this event", client, 255, 0, 0)
		return
	end
	if (#SWPlayers == SWMaxPlayers) then
		addEventMsg(nil,"(Mini-Game) Ships War : The event is already full and about to start", client, 255, 0, 0)
		return
	end
	if (SWStarted) then
		addEventMsg(nil,"(Mini-Game) Ships War : The event is already started", client, 255, 0, 0)
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
		addEventMsg(nil,"(Mini-Game) Ships War : you can't join the SW event while you're not in main world", client, 255, 0, 0)
		return
	end
	if getElementData(client,"isPlayerJailed") or getElementData(client,"isPlayerArrested") then
		addEventMsg(nil,"(Mini-Game) Ships War : you can't join the SW event while you're arrested or jailed!", client, 255, 0, 0)
		return
	end
	SWPlayer[client] = true
	getPlayerPosition(client)
	sendToSWPlayers(getPlayerName(client).." has signed up. "..(#SWPlayers + 1).."/"..SWMaxPlayers.." players signed up", 0,255,0)
	table.insert(SWPlayers, client)
	addEventHandler("onPlayerQuit", client, onSWQuit)
	addEventMsg(nil,"(Mini-Game) #FFFFFFShips War : You have signed up !!.", client, 0,255,0)
	if (#SWPlayers == SWMinPlayers) then
		SWstartingTimer = setTimer(beforeStartSW, 10000, 1)
		sendToSWPlayers("(Mini-Game) Ships War : Event will be started within 10 seconds!", 0,255,0)
	end
	if (#SWPlayers == SWMaxPlayers) then
		if (isTimer(SWstartingTimer)) then
			killTimer(SWstartingTimer)
		end
		beforeStartSW()
	end
end



function sendToSWPlayers(message, r, g, b)
	for index, player in pairs(SWPlayers) do
		addEventMsg(nil,message, player, r, g, b)
	end
end

function beforeStartSW()
	SWStarted = true
	sendToSWPlayers(#SWPlayers.." players have signed up for the SW Event. please wait 5 seconds.", 0,255,0)
	addWastedHandler39()
	local num = math.random(1,3)
	nm = "SW1"
	allowedCity = "LS"
	maptype = nm
	unloadMap()
	setTimer(startSW, 5000, 1) -- here too
end

function addWastedHandler39()
	for index, player in pairs(SWPlayers) do
		if (isElement(player)) then
			addEventHandler("onPlayerWasted", player, onSWWasted)
		end
	end
end


function startSW()
	stopText()
	if isTimer(proTimer3) then killTimer(proTimer3) end
	for k,v in ipairs(getElementsByType("player")) do
		if isPedDead(v) then
			for index, xplayer in pairs(SWPlayers) do
				if (v == xplayer) then
					table.remove(SWPlayers, index)
					break
				end
			end
		end
	end
	for index, player in ipairs(SWPlayers) do
		if (player and isElement(player) and getElementData(player,"isPlayerJailed") == false) then
			if (isPedInVehicle(player)) then
				removePedFromVehicle(player)
			end
			if isPedDead(player) then
				return
			end
			setElementPosition(player,ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3])
			setElementDimension(player, SWDimension)
			local vehicle = createVehicle(430, ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3] + 1)
			setElementDimension(vehicle, SWDimension)
			SWvehicles[player] = vehicle
			SWVehDrivers[vehicle] = player
			setElementRotation(vehicle,0,0,ShooterPos[maptype][index][4])
			setVehicleDamageProof(vehicle, true)
			setTimer(setVehicleDamageProof, 3000, 1, vehicle, false)
			triggerClientEvent(player, "startCountDown", player,2000)
			setElementFrozen(player, true)
			toggleAllControls(player, false)
			warpPedIntoVehicle(player, vehicle)
			setTimer(setElementFrozenDelayed1950, 8000, 1, player, false)
		end
	end
	addEventHandler("onVehicleStartExit", resourceRoot, stopExit925)
	SWTimer = setTimer(enSWD, timeOut, 1)
	proTimer3 = setTimer(theChecking9,500,0)

end


function setElementFrozenDelayed1950(plr, bool)
	if (isElement(plr)) then
		toggleAllControls(plr, true)
		setElementFrozen(plr, bool)
		toggleControl(plr, "vehicle_secondary_fire", false)
		setTimer(toggleControl, 14000, 1, plr, "vehicle_secondary_fire", true)
	end
end

function onSWWasted()
	if getElementDimension(source) ~= 5000 then
		onForceSW(source)
	else
		SWFailed(source,"Just wasted")
	end
end


function onSWQuit()
	if (not SWPlayer[source]) then
		return
	end
	for index, player in pairs(SWPlayers) do
		if (source == player) then
			table.remove(SWPlayers, index)
			break
		end
	end
	if (SWStarted) then
		sendToSWPlayers(getPlayerName(source).." is out!", 0,255,0)
		if (#SWPlayers == 1) then
			enSWD(SWPlayers[1])
		end
	else
		if (#SWPlayers < SWMinPlayers and isTimer(SWstartingTimer)) then
			killTimer(SWstartingTimer)
		end
	end
end


function onLogin2s()
	if (getElementDimension(source) == SWDimension) then
		setElementDimension(source, 0)
	end
end
addEventHandler("onPlayerLogin", root, onLogin2s)

function enSWD(player)
	if (isElement(player)) then
		SWPlayer[player] = nil
		outputChatBox("(Mini-Game) Ships War : You won the SW Event! You got $"..moneyEarn.." +2 scores| +2 XP", player, 0, 255, 0)
		givePlayerMoney(player,moneyEarn)
		exports.AURlevels:givePlayerXP(player,2)
		exports.CSGscore:givePlayerScore(player,2)
		removeEventHandler("onPlayerWasted", player, onSWWasted)
		removeEventHandler("onPlayerQuit", player, onSWQuit)
		addEventMsg(nil,getPlayerName(player).." has won the SW Event!",root, 0,255,0)
		outputChatBox("(Mini-Game [SW]) : "..getPlayerName(player).." has won the Event!",root, 0,255,0)
		setTimer(function(p)
			killPed(p)
		end,2000,1,player)
	else
		for index, player in pairs(SWPlayers) do
			SWPlayer[player] = nil
			addEventMsg(nil,"(Mini-Game) Ships War : Event has ended!! You lost dude!!", player, 255, 0, 0)
			removeEventHandler("onPlayerWasted", player, onSWWasted)
			removeEventHandler("onPlayerQuit", player, onSWQuit)
			killPed(player)
		end
		for index, player in pairs(SWEliminatedPlayers) do
			addEventMsg(nil,"(Mini-Game) Ships War : Event has ended!! You lost dude!!", player, 255, 0, 0)
			addEventMsg(nil,"(Mini-Game) Ships War : None won in this Event!!", player, 255, 0, 0)
		end
	end
	SWPlayers = {}
	SWEliminatedPlayers = {}
	SWPlayer = {}
	SWStarted = false
	if (isTimer(SWTimer)) then
		killTimer(SWTimer)
	end
	SWTimer = nil
	if isTimer(proTimer3) then killTimer(proTimer3) end
	stopEvent("SW")
	startEvent("FFA")
	removeEventHandler("onVehicleStartExit", resourceRoot, stopExit925)
	for index, vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		if SWVehDrivers[vehicle] then
			SWvehicles[SWVehDrivers[vehicle]] = nil
			SWVehDrivers[vehicle] = nil
		end
		destroyElement(vehicle)
	end
	SWvehicles = {}
	SWVehDrivers = {}
end

function stopExit925(player)
	if (SWStarted and SWPlayer[player]) then
		cancelEvent()
	end
end

function SWFailed(plr,msg)
	if (not SWPlayer[plr]) then
		return
	end
	SWPlayer[plr] = nil
	table.insert(SWEliminatedPlayers, plr)
	removeEventHandler("onPlayerWasted", plr, onSWWasted)
	removeEventHandler("onPlayerQuit", plr, onSWQuit)
	sendToSWPlayers(getPlayerName(plr).." is out!", 0,255,0)
	for index, player in pairs(SWPlayers) do
		if (plr == player) then
			table.remove(SWPlayers, index)
			break
		end
	end
	if (#SWPlayers == 1) then
		enSWD(SWPlayers[1])
	elseif (#SWPlayers == 0) then
		enSWD(nil)
	end
	killPed(plr)
	outputDebugString(getPlayerName(plr)..": "..msg)
end

