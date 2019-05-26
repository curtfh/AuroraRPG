HFPlayer = {}
local HFEliminatedPlayers = {}
local HFPlayers = {}
local HFvehicles = {}
local HFVehDrivers = {}
local HFpickups = {}
HFStarted = false
local HFtimer
local HFstartingTimer
local HFDimension = 5000
local HFMinPlayers = 8
local HFMaxPlayers = 15
local timeOut = 900000 -- 15 minutes until time out
maptype = "HF1"
local proTimer3 = {}
local allowedCity = "LS"
local spammer5 = {}
addEvent("setHFKiller",true)
addEventHandler("setHFKiller",root,function(attacker,player)
	if player and attacker then
		if player ~= attacker then
			if spammer5[player] and isTimer(spammer5[player]) then return false end
			if getElementDimension(player) == 5000 then
				addEventMsg("Killer","(Mini-Game) Hydra Fight : #FFFFFFYou have been killed by "..getPlayerName(attacker), player, 255, 0, 0)
				addEventMsg("Killer2","(Mini-Game) Hydra Fight : #FFFFFFYou have killed  "..getPlayerName(player).." +2 XP", attacker, 255, 0, 0)
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


function theChecking5()
	if (not HFStarted) then
		return
	end
	for index, player in pairs(HFPlayers) do
		if player and isElement(player) then
			if (getElementDimension(player) == 5000) then
				if isPedInVehicle(player) == false then
					HFFailed(player,"Player isn't in vehicle")
				else
					if tostring(exports.server:getPlayChatZone(player)) ~= tostring(allowedCity) then
						HFFailed(player,"Player isn't in chatzone")
						exports.NGCdxmsg:createNewDxMessage("(Mini-Game) HF : You have lost due left "..allowedCity,player,255,0,0)
					end
				end
			else
				HFFailed(player,"Died due not in dimension")
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
							triggerEvent("setHFKiller",theKiller,theKiller,thePlayer)
						end
					end
					local driver = HFVehDrivers[vehicle]
					if driver then
						HFFailed(driver)
					end
				end
			end
		end
	end]]
end


function leaveEvent(player)
	if nextEvent == "HF" then
		if (not HFPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Hydra Fight : You didn't signup for the HF Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		if (HFStarted) then
			addEventMsg(nil,"(Mini-Game) Hydra Fight : You can't leave from this event because it's already started", player, 255, 0, 0)
			return
		end
		HFPlayer[player] = nil
		for index, player2 in pairs(HFPlayers) do
			if (player == player2) then
				table.remove(HFPlayers, index)
				break
			end
		end
		if (#HFPlayers < HFMinPlayers and isTimer(HFstartingTimer)) then
			killTimer(HFstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onHFQuit)
	end
end
addCommandHandler("leave", leaveEvent)


function onForceHF(player)
	if nextEvent == "HF" then
		if (not HFPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Hydra Fight : You didn't signup for the HF Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		HFPlayer[player] = nil
		for index, player2 in pairs(HFPlayers) do
			if (player == player2) then
				table.remove(HFPlayers, index)
				break
			end
		end
		if (#HFPlayers < HFMinPlayers and isTimer(HFstartingTimer)) then
			killTimer(HFstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onHFQuit)
	end
end


function signupForHF(client)
	if (isEventStarted("HF") ~= true) then
		return
		addEventMsg(nil,"(Mini-Game) Hydra Fight : This event is not started yet", client, 255, 0, 0)
	end
	if (HFPlayer[client]) then
		addEventMsg(nil,"(Mini-Game) Hydra Fight : You have already signed up for this event", client, 255, 0, 0)
		return
	end
	if (#HFPlayers == HFMaxPlayers) then
		addEventMsg(nil,"(Mini-Game) Hydra Fight : The event is already full and about to start", client, 255, 0, 0)
		return
	end
	if (HFStarted) then
		addEventMsg(nil,"(Mini-Game) Hydra Fight : The event is already started", client, 255, 0, 0)
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
		addEventMsg(nil,"(Mini-Game) Hydra Fight : you can't join the HF event while you're not in main world", client, 255, 0, 0)
		return
	end
	if getElementData(client,"isPlayerJailed") or getElementData(client,"isPlayerArrested") then
		addEventMsg(nil,"(Mini-Game) Hydra Fight : you can't join the HF event while you're arrested or jailed!", client, 255, 0, 0)
		return
	end
	getPlayerPosition(client)
	HFPlayer[client] = true
	sendToHFPlayers(getPlayerName(client).." has signed up. "..(#HFPlayers + 1).."/"..HFMaxPlayers.." players signed up", 0,255,0)
	table.insert(HFPlayers, client)
	addEventHandler("onPlayerQuit", client, onHFQuit)
	addEventMsg(nil,"(Mini-Game) #FFFFFFHydra Fight : You have signed up !!.", client, 0,255,0)
	if (#HFPlayers == HFMinPlayers) then
		HFstartingTimer = setTimer(beforeStartHF, 10000, 1)
		sendToHFPlayers("(Mini-Game) Hydra Fight : Event will be started within 10 seconds!", 0,255,0)
	end
	if (#HFPlayers == HFMaxPlayers) then
		if (isTimer(HFstartingTimer)) then
			killTimer(HFstartingTimer)
		end
		beforeStartHF()
	end
end



function sendToHFPlayers(message, r, g, b)
	for index, player in pairs(HFPlayers) do
		addEventMsg(nil,message, player, r, g, b)
	end
end

function beforeStartHF()
	HFStarted = true
	sendToHFPlayers(#HFPlayers.." players have signed up for the HF Event. please wait 5 seconds.", 0,255,0)
	addWastedHandler35()
	local num = math.random(1,3)
	if num == 1 then
		nm = "HF1"
		allowedCity = "LS"
	elseif num == 2 then
		nm = "HF2"
		allowedCity = "SF"
	elseif num == 3 then
		nm = "HF3"
		allowedCity = "LV"
	end

	maptype = nm
	loadMap(nm)
	for k,v in ipairs(pickupTable[nm]) do
		local x,y,z = v[1],v[2],v[3]
		local thePickup = createPickup( x,y,z+0.2, 3, v[5] )
		setElementDimension(thePickup,5000)
		table.insert(HFpickups,thePickup)
	end
	setTimer(startHF, 5000, 1) -- here too
end

function addWastedHandler35()
	for index, player in pairs(HFPlayers) do
		if (isElement(player)) then
			addEventHandler("onPlayerWasted", player, onHFWasted)
		end
	end
end


function startHF()
	stopText()
	if isTimer(proTimer3) then killTimer(proTimer3) end
	for k,v in ipairs(getElementsByType("player")) do
		if isPedDead(v) then
			for index, xplayer in pairs(HFPlayers) do
				if (v == xplayer) then
					table.remove(HFPlayers, index)
					break
				end
			end
		end
	end
	for index, player in ipairs(HFPlayers) do
		if (player and isElement(player) and getElementData(player,"isPlayerJailed") == false) then
			if (isPedInVehicle(player)) then
				removePedFromVehicle(player)
			end
			if isPedDead(player) then
				return
			end
			setElementPosition(player,ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3])
			setElementDimension(player, HFDimension)
			local vehicle = createVehicle(520, ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3] + 1)
			setElementDimension(vehicle, HFDimension)
			HFvehicles[player] = vehicle
			HFVehDrivers[vehicle] = player
			setElementRotation(vehicle,0,0,ShooterPos[maptype][index][4])
			setVehicleDamageProof(vehicle, true)
			setTimer(setVehicleDamageProof, 3000, 1, vehicle, false)
			triggerClientEvent(player, "startCountDown", player,2000)
			setElementFrozen(player, true)
			toggleAllControls(player, false)
			warpPedIntoVehicle(player, vehicle)
			setTimer(setElementFrozenDelayed222, 8000, 1, player, false)

		end
	end
	addEventHandler("onVehicleStartExit", resourceRoot, stopExit2355)
	HFTimer = setTimer(enHFD, timeOut, 1)
	proTimer3 = setTimer(theChecking5,500,0)

end


function setElementFrozenDelayed222(plr, bool)
	if (isElement(plr)) then
		toggleAllControls(plr, true)
		setElementFrozen(plr, bool)
		toggleControl(plr, "vehicle_secondary_fire", false)
		setTimer(toggleControl, 14000, 1, plr, "vehicle_secondary_fire", true)
	end
end

function onHFWasted()
	if getElementDimension(source) ~= 5000 then
		onForceHF(source)
	else
		HFFailed(source,"Just wasted")
	end
end


function onHFQuit()
	if (not HFPlayer[source]) then
		return
	end
	for index, player in pairs(HFPlayers) do
		if (source == player) then
			table.remove(HFPlayers, index)
			break
		end
	end
	if (HFStarted) then
		sendToHFPlayers(getPlayerName(source).." is out!", 0,255,0)
		if (#HFPlayers == 1) then
			enHFD(HFPlayers[1])
		end
	else
		if (#HFPlayers < HFMinPlayers and isTimer(HFstartingTimer)) then
			killTimer(HFstartingTimer)
		end
	end
end


function onLogin2s()
	if (getElementDimension(source) == HFDimension) then
		setElementDimension(source, 0)
	end
end
addEventHandler("onPlayerLogin", root, onLogin2s)

function enHFD(player)
	if (isElement(player)) then
		HFPlayer[player] = nil
		outputChatBox("(Mini-Game) Hydra Fight : You won the HF Event! You got $"..moneyEarn.." +2 scores| +2 XP", player, 0, 255, 0)
		givePlayerMoney(player,moneyEarn)
		exports.AURlevels:givePlayerXP(player,2)
		exports.CSGscore:givePlayerScore(player,2)
		removeEventHandler("onPlayerWasted", player, onHFWasted)
		removeEventHandler("onPlayerQuit", player, onHFQuit)
		addEventMsg(nil,getPlayerName(player).." has won the HF Event!",root, 0,255,0)
		outputChatBox("(Mini-Game [HF]) : "..getPlayerName(player).." has won the Event!",root, 0,255,0)
		setTimer(function(p)
			killPed(p)
		end,2000,1,player)
	else
		for index, player in pairs(HFPlayers) do
			HFPlayer[player] = nil
			addEventMsg(nil,"(Mini-Game) Hydra Fight : Event has ended!! You lost dude!!", player, 255, 0, 0)
			removeEventHandler("onPlayerWasted", player, onHFWasted)
			removeEventHandler("onPlayerQuit", player, onHFQuit)
			killPed(player)
		end
		for index, player in pairs(HFEliminatedPlayers) do
			addEventMsg(nil,"(Mini-Game) Hydra Fight : Event has ended!! You lost dude!!", player, 255, 0, 0)
			addEventMsg(nil,"(Mini-Game) Hydra Fight : None won in this Event!!", player, 255, 0, 0)
		end
	end
	HFPlayers = {}
	HFEliminatedPlayers = {}
	HFPlayer = {}
	HFStarted = false
	if (isTimer(HFTimer)) then
		killTimer(HFTimer)
	end
	HFTimer = nil
	if isTimer(proTimer3) then killTimer(proTimer3) end
	stopEvent("HF")
	startEvent("Shooter")
	removeEventHandler("onVehicleStartExit", resourceRoot, stopExit2355)
	for index, vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		if HFVehDrivers[vehicle] then
			HFvehicles[HFVehDrivers[vehicle]] = nil
			HFVehDrivers[vehicle] = nil
		end
		destroyElement(vehicle)
	end
	for k,v in ipairs(HFpickups) do
		if isElement(v) then destroyElement(v) end
	end
	HFvehicles = {}
	HFVehDrivers = {}
end

function stopExit2355(player)
	if (HFStarted and HFPlayer[player]) then
		cancelEvent()
	end
end

function HFFailed(plr,msg)
	if (not HFPlayer[plr]) then
		return
	end
	HFPlayer[plr] = nil
	table.insert(HFEliminatedPlayers, plr)
	removeEventHandler("onPlayerWasted", plr, onHFWasted)
	removeEventHandler("onPlayerQuit", plr, onHFQuit)
	sendToHFPlayers(getPlayerName(plr).." is out!", 0,255,0)
	for index, player in pairs(HFPlayers) do
		if (plr == player) then
			table.remove(HFPlayers, index)
			break
		end
	end
	if (#HFPlayers == 1) then
		enHFD(HFPlayers[1])
	elseif (#HFPlayers == 0) then
		enHFD(nil)
	end
	killPed(plr)
	outputDebugString(getPlayerName(plr)..": "..msg)
end

