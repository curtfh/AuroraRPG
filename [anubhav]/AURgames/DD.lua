DDPlayer = {}
local DDEliminatedPlayers = {}
local DDPlayers = {}
local DDvehicles = {}
local DDVehDrivers = {}
local DDpickups = {}
DDStarted = false
local DDtimer
local DDstartingTimer
local DDDimension = 5000
local DDMinPlayers = 8
local DDMaxPlayers = 15
local timeOut = 900000 -- 15 minutes until time out
maptype = "DD1"
local proTimer = {}


spammer2 = {}
addEvent("setDDKiller",true)
addEventHandler("setDDKiller",root,function(attacker,player)
	if player and attacker then
		if player ~= attacker then
			if getElementDimension(player) == 5000 then
				if spammer2[player] and isTimer(spammer2[player]) then return false end

				addEventMsg("Killer","(Mini-Game) DD : #FFFFFFYou have been killed by "..getPlayerName(attacker), player, 255, 0, 0)
				addEventMsg("Killer2","(Mini-Game) DD : #FFFFFFYou have killed  "..getPlayerName(player), attacker, 255, 0, 0)
				--outputDebugString("(Mini-Game) DD : #FFFFFFYou have been killed by "..getPlayerName(attacker))
				--outputDebugString("(Mini-Game) DD : #FFFFFFYou have killed  "..getPlayerName(player))
				spammer2[player] = setTimer(function() end,5000,1)
				exports.AURlevels:givePlayerXP(attacker,2)
			end
		end
	end
end)


function theChecker()
	for index, vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		if vehicle and isElement(vehicle) then
			if isElementInWater(vehicle) then
				if getElementData(vehicle,"mini-hit") then
					local thePlayer,theKiller = unpack(getElementData(vehicle,"mini-hit"))
					if thePlayer and theKiller then
						if isElement(thePlayer) and isElement(theKiller) then
							triggerEvent("setDDKiller",theKiller,theKiller,thePlayer)
							---outputDebugString("Event triggered here "..getPlayerName(theKiller))
						end
					end
				end
				local driver = DDVehDrivers[vehicle]
				if driver then
					setPlayerFailed(driver)
				end
			end
			if getElementDimension(vehicle) ~= 5000 then
				local driver = DDVehDrivers[vehicle]
				if driver then
					setPlayerFailed(driver)
				end
			end
		end
	end
end


local vehID = {
	[1]=541,
	[2]=603,
	[3]=559,
	[4]=415,
	[5]=475,
	[6]=402
}


function leaveEvent(player)
	if nextEvent == "DD" then
		if (not DDPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) DD: You didn't signup for the DD Event", player, 255, 0, 0)
			return
		end
		if (DDStarted) then
			addEventMsg(nil,"(Mini-Game) DD: You can't leave from this event because it's already started", player, 255, 0, 0)
			return
		end
		DDPlayer[player] = nil
		for index, player2 in pairs(DDPlayers) do
			if (player == player2) then
				table.remove(DDPlayers, index)
				break
			end
		end
		if (#DDPlayers < DDMinPlayers and isTimer(DDstartingTimer)) then
			killTimer(DDstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onDDQuit)
	end
end
addCommandHandler("leave", leaveEvent)


addEvent("setPlayerVehicleModel",true)
addEventHandler("setPlayerVehicleModel",root,function(newid)
	if nextEvent == "DD" then
		ddChange(sr,newid)
	elseif nextEvent == "Shooter" then
		STRChange(sr,newid)
	end
end)
function ddChange(sr,newid)
	if nextEvent == "DD" then
		if isPedInVehicle(sr) and getElementDimension(sr) == 5000 then
			for index, player in ipairs(DDPlayers) do
				if player == sr then
				--outputDebugString("sr is player")
					if isPedInVehicle(sr) then
				--	outputDebugString("is ped in car check ")
						local veh = Shootervehicles[sr]
						if veh and isElement(veh) then
					--	outputDebugString("veh check")
							if getElementHealth(sr) > 1 then
						--		outputDebugString("hp check")
								if getElementHealth(veh) > 250 then
									setElementModel(veh,newid)
						--			outputDebugString("new car")
									addEventMsg(nil,"(Mini-Game) Shooter : #FFFFFFYou have been given "..getVehicleNameFromID(newid), player, 255, 0, 0)
								end
							end
						end
					end
				end
			end
		end
	end
end

function onForceDD(player)
	if nextEvent == "DD" then
		if (not DDPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) DD: You didn't signup for the DD Event", player, 255, 0, 0)
			return
		end
		DDPlayer[player] = nil
		for index, player2 in pairs(DDPlayers) do
			if (player == player2) then
				table.remove(DDPlayers, index)
				break
			end
		end
		if (#DDPlayers < DDMinPlayers and isTimer(DDstartingTimer)) then
			killTimer(DDstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onDDQuit)
	end
end

function signupForDD(client)
	if (isEventStarted("DD") ~= true) then
		return
		addEventMsg(nil,"(Mini-Game) DD: This event is not started yet", client, 255, 0, 0)
	end
	if (DDPlayer[client]) then
		addEventMsg(nil,"(Mini-Game) DD: You have already signed up for this event", client, 255, 0, 0)
		return
	end
	if (#DDPlayers == DDMaxPlayers) then
		addEventMsg(nil,"(Mini-Game) DD: The event is already full", client, 255, 0, 0)
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
	if (DDStarted) then
		addEventMsg(nil,"(Mini-Game) DD: The event is already started", client, 255, 0, 0)
		return
	end
	if (getElementDimension(client) > 0) then
		addEventMsg(nil,"(Mini-Game) DD: you have to be in real world", client, 255, 0, 0)
		return
	end
	if getElementData(client,"isPlayerJailed") or getElementData(client,"isPlayerArrested") then
		addEventMsg(nil,"(Mini-Game) DD: You can't join the DD while being jailed or arrested!!", client, 255, 0, 0)
		return
	end
	DDPlayer[client] = true
	getPlayerPosition(client)
	sendToDDPlayers(getPlayerName(client).." has signed up. "..(#DDPlayers + 1).."/"..DDMaxPlayers.." players signed up", 0,255,0)
	table.insert(DDPlayers, client)
	addEventHandler("onPlayerQuit", client, onDDQuit)
	addEventMsg(nil,"(Mini-Game) #FFFFFFDD: You have signed up!!.", client, 0,255,0)
	if (#DDPlayers == DDMinPlayers) then
		DDstartingTimer = setTimer(beforeStartDD, 10000, 1)
		sendToShooterPlayers("(Mini-Game) DD : Event will be started within 10 seconds!", 0,255,0)

	end
	if (#DDPlayers == DDMaxPlayers) then
		if (isTimer(DDstartingTimer)) then
			killTimer(DDstartingTimer)
		end
		beforeStartDD()
	end
end



function sendToDDPlayers(message, r, g, b)
	for index, player in pairs(DDPlayers) do
		addEventMsg(nil,message, player, r, g, b)
	end
end

function beforeStartDD()
	DDStarted = true
	sendToDDPlayers(#DDPlayers.." players have signed up for the DD Event. Please wait 5 seconds.", 0,255,0)
	addWastedHandler2()
	setTimer(startDD, 5000, 1) -- here too
	local num = math.random(1,3)
	if num == 1 then
		nm = "DD1"
	elseif num == 2 then
		nm = "DD2"
	elseif num == 3 then
		nm = "DD3"
	end
	maptype = nm
	loadMap(nm)
	for k,v in ipairs(pickupTable[nm]) do
		local x,y,z = v[1],v[2],v[3]
		local thePickup = createPickup( x,y,z+0.2, 3, v[5] )
		setElementDimension(thePickup,5000)
		table.insert(DDpickups,thePickup)
	end
end

function addWastedHandler2()
	for index, player in pairs(DDPlayers) do
		if (isElement(player)) then
			addEventHandler("onPlayerWasted", player, onDDWasted)
		end
	end
end


function startDD()
	stopText()
	if isTimer(proTimer) then killTimer(proTimer) end
	for k,v in ipairs(getElementsByType("player")) do
		if isPedDead(v) then
			for index, xplayer in pairs(DDPlayers) do
				if (v == xplayer) then
					table.remove(DDPlayers, index)
					break
				end
			end
		end
	end
	local id = exports.AURlevels:getValidVehicle()
	for index, player in pairs(DDPlayers) do
		if (isElement(player) and getElementData(player,"isPlayerJailed") == false) then
			if (isPedInVehicle(player)) then
				removePedFromVehicle(player)
			end
			if isPedDead(player) then
				return
			end
			--local id = vehID[math.random(#vehID)]
			setElementPosition(player,ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3])
			setElementDimension(player, DDDimension)
			local vehicle = createVehicle(id, ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3] + 1)
			setElementDimension(vehicle, DDDimension)
			DDvehicles[player] = vehicle
			DDVehDrivers[vehicle] = player
			setElementRotation(vehicle,0,0,ShooterPos[maptype][index][4])
			setVehicleDamageProof(vehicle, true)
			setTimer(setVehicleDamageProof, 3000, 1, vehicle, false)
			triggerClientEvent(player, "startCountDown", player,2000)
			setElementFrozen(player, true)
			toggleAllControls(player, false)
			warpPedIntoVehicle(player, vehicle)
			setTimer(setElementFrozenDelayed1, 8000, 1, player, false)
		end
	end
	addEventHandler("onVehicleStartExit", resourceRoot, stopExit)
	DDTimer = setTimer(endDD, timeOut, 1)
	proTimer = setTimer(theChecker,1000,0)

end


addEventHandler("onPickupHit",resourceRoot,function(hit)
	if hit and getElementType(hit) == "player" then
		local veh = getPedOccupiedVehicle(hit,0)
		for k,v in ipairs(DDpickups) do
			if source == v then
				if getElementModel(source) == 1510 then
					local posx, posy, posz = getElementPosition ( source )
					local sx,sy,sz = getElementVelocity ( veh )
					setElementVelocity( veh, sx, sy, sz+0.3)
				elseif getElementModel(source) == 2222 then
					fixVehicle(veh)
				elseif getElementModel(source) == 2223 then
					addVehicleUpgrade(veh, 1010)
				elseif getElementModel(source) == 1079 then
					setElementModel(veh,502)
				end
			end
		end
	end
end)


function setElementFrozenDelayed1(plr, bool)
	if (isElement(plr)) then
		toggleAllControls(plr, true)
		setElementFrozen(plr, bool)
	end
end

function onDDWasted()
	if getElementDimension(source) ~= 5000 then
		onForceDD(source)
	else
		setPlayerFailed(source)
	end
end


function onDDQuit()
	if (not DDPlayer[source]) then
		return
	end
	for index, player in pairs(DDPlayers) do
		if (source == player) then
			table.remove(DDPlayers, index)
			break
		end
	end
	if (DDStarted) then
		sendToDDPlayers(getPlayerName(source).." left the event!", 0,255,0)
		if (#DDPlayers == 1) then
			endDD(DDPlayers[1])
		end
	else
		if (#DDPlayers < DDMinPlayers and isTimer(DDstartingTimer)) then
			killTimer(DDstartingTimer)
		end
	end
end


function onLogin2()
	if (getElementDimension(source) == DDDimension) then
		setElementDimension(source, 0)
	end
end
addEventHandler("onPlayerLogin", root, onLogin2)

function endDD(player)
	if (isElement(player)) then
		DDPlayer[player] = nil
		outputChatBox("(Mini-Game) DD: You won the DD Event! You got $"..moneyEarn.." +2 scores | +2 XP", player, 0, 255, 0)
		removeEventHandler("onPlayerWasted", player, onDDWasted)
		removeEventHandler("onPlayerQuit", player, onDDQuit)
		givePlayerMoney(player,moneyEarn)
		exports.AURlevels:givePlayerXP(player,2)
		exports.CSGscore:givePlayerScore(player,2)
		outputChatBox("(Mini-Game [DD]) : "..getPlayerName(player).." has won the Event!",root, 0,255,0)
		addEventMsg(nil,getPlayerName(player).." has won the DD Event!",root, 0,255,0)
		setTimer(function(p)
			killPed(p)
		end,2000,1,player)
	else
		for index, player in pairs(DDPlayers) do
			DDPlayer[player] = nil
			addEventMsg(nil,"(Mini-Game) DD: Event has ended!! You lost dude!!", player, 255, 0, 0)
			removeEventHandler("onPlayerWasted", player, onDDWasted)
			removeEventHandler("onPlayerQuit", player, onDDQuit)
			killPed(player)
		end
		for index, player in pairs(DDEliminatedPlayers) do
			addEventMsg(nil,"(Mini-Game) DD: Event has ended!! You lost dude!!", player, 255, 0, 0)
			addEventMsg(nil,"(Mini-Game) DD: None won in this Event!!", player, 255, 0, 0)
		end
	end
	DDPlayers = {}
	DDEliminatedPlayers = {}
	DDPlayer = {}
	DDStarted = false
	if (isTimer(DDTimer)) then
		killTimer(DDTimer)
	end
	DDTimer = nil
	if isTimer(proTimer) then killTimer(proTimer) end
	stopEvent("DD")
	startEvent("SW")
	removeEventHandler("onVehicleStartExit", resourceRoot, stopExit)
	for index, vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		if DDVehDrivers[vehicle] then
			DDvehicles[DDVehDrivers[vehicle]] = nil
			DDVehDrivers[vehicle] = nil
		end
		destroyElement(vehicle)
	end
	for k,v in ipairs(DDpickups) do
		if isElement(v) then destroyElement(v) end
	end
	DDvehicles = {}
	DDVehDrivers = {}
end

function stopExit(player)
	if (DDStarted and DDPlayer[player]) then
		cancelEvent()
	end
end

function setPlayerFailed(plr)
	if (not DDPlayer[plr]) then
		return
	end
	DDPlayer[plr] = nil
	table.insert(DDEliminatedPlayers, plr)
	removeEventHandler("onPlayerWasted", plr, onDDWasted)
	removeEventHandler("onPlayerQuit", plr, onDDQuit)
	sendToDDPlayers(getPlayerName(plr).." is dead!", 0,255,0)
	for index, player in pairs(DDPlayers) do
		if (plr == player) then
			table.remove(DDPlayers, index)
			break
		end
	end
	if (#DDPlayers == 1) then
		endDD(DDPlayers[1])
	elseif (#DDPlayers == 0) then
		endDD(nil)
	end
	killPed(plr)
end


local Objects2 = {
	createObject(3458,3653.1006000,-1685.0996000,40.6000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (1)
	createObject(3458,3653.1006000,-1690.2002000,40.6000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (2)
	createObject(3458,3693.5000000,-1690.2002000,40.6000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (3)
	createObject(3458,3693.5000000,-1685.0996000,40.6000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (4)
	createObject(3458,3711.1001000,-1712.9000000,40.6000000,0.0000000,0.0000000,269.9950000),--object(vgncarshade1) (5)
	createObject(3458,3706.0000000,-1712.9004000,40.6000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (6)
	createObject(3458,3706.0000000,-1753.3000000,40.6000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (7)
	createObject(3458,3711.1001000,-1753.3000000,40.6000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (8)
	createObject(3458,3635.5000000,-1712.9000000,40.6000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (9)
	createObject(3458,3640.6001000,-1712.9000000,40.6000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (10)
	createObject(3458,3640.6001000,-1753.3000000,40.5988900,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (11)
	createObject(3458,3635.5000000,-1753.3000000,40.5988900,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (12)
	createObject(3458,3653.1001000,-1775.3000000,40.6000000,0.0000000,0.0000000,359.2450000),--object(vgncarshade1) (13)
	createObject(3458,3653.1001000,-1780.4000000,40.6000000,0.0000000,0.0000000,179.2420000),--object(vgncarshade1) (14)
	createObject(3458,3693.5000000,-1775.8000000,40.6000000,0.0000000,0.0000000,359.2420000),--object(vgncarshade1) (15)
	createObject(3458,3693.3999000,-1780.9000000,40.6000000,0.0000000,0.0000000,179.2360000),--object(vgncarshade1) (16)
	createObject(3458,3711.1001000,-1662.4000000,40.6000000,0.0000000,0.0000000,270.0000000),--object(vgncarshade1) (24)
	createObject(3458,3706.0000000,-1662.4000000,40.6000000,0.0000000,0.0000000,90.0000000),--object(vgncarshade1) (25)
	createObject(3458,3706.0000000,-1622.0000000,40.6000000,0.0000000,0.0000000,90.0000000),--object(vgncarshade1) (26)
	createObject(3458,3711.1001000,-1622.0000000,40.6000000,0.0000000,0.0000000,270.0000000),--object(vgncarshade1) (27)
	createObject(3458,3693.4004000,-1594.2002000,40.6000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (28)
	createObject(3458,3693.3999000,-1599.3000000,40.6000000,0.0000000,0.0000000,180.0000000),--object(vgncarshade1) (29)
	createObject(3458,3635.5000000,-1662.4000000,40.6000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (32)
	createObject(3458,3640.6001000,-1662.4000000,40.6000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (33)
	createObject(3458,3640.6001000,-1622.0000000,40.6000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (34)
	createObject(3458,3635.5000000,-1622.0000000,40.6000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (35)
	createObject(3458,3653.0000000,-1594.2000000,40.6000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (36)
	createObject(3458,3653.0000000,-1599.3000000,40.6000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (37)
	createObject(3458,3672.1001000,-1622.0000000,40.6000000,0.0000000,0.0000000,89.9950000),--object(vgncarshade1) (38)
	createObject(3458,3672.1006000,-1662.4004000,40.6111000,0.0000000,0.0000000,89.9950000),--object(vgncarshade1) (39)
	createObject(3458,3683.3000000,-1642.1000000,40.5977000,0.0000000,0.0000000,359.9950000),--object(vgncarshade1) (40)
	createObject(3458,3653.7000000,-1642.1000000,40.5877700,0.0000000,0.0000000,359.9890000),--object(vgncarshade1) (41)
	createObject(3458,3658.1001000,-1661.0000000,40.5890000,0.0000000,0.0000000,53.7390000),--object(vgncarshade1) (42)
	createObject(3458,3686.6001000,-1660.8000000,40.5870000,0.0000000,0.0000000,306.7380000),--object(vgncarshade1) (43)
	createObject(3458,3692.3999000,-1668.7000000,40.5890000,0.0000000,0.0000000,306.4850000),--object(vgncarshade1) (44)
	createObject(3458,3653.2000000,-1667.7000000,40.5870000,0.0000000,0.0000000,53.7340000),--object(vgncarshade1) (45)
	createObject(3458,3658.2000000,-1622.9000000,40.5880000,0.0000000,0.0000000,306.4850000),--object(vgncarshade1) (46)
	createObject(3458,3654.8999000,-1618.5000000,40.5877000,0.0000000,0.0000000,306.4800000),--object(vgncarshade1) (48)
	createObject(3458,3685.8000000,-1623.0000000,40.5890000,0.0000000,0.0000000,53.7340000),--object(vgncarshade1) (49)
	createObject(3458,3690.7000000,-1616.3000000,40.5870000,0.0000000,0.0000000,53.7290000),--object(vgncarshade1) (50)
	createObject(1633,3647.8999000,-1571.3000000,46.0000000,345.0000000,0.0000000,0.0000000),--object(landjump) (1)
	createObject(1660,3711.1001000,-1591.5000000,41.8700000,0.0000000,0.0000000,0.0000000),--object(ramp) (1)
	createObject(1660,3705.8000000,-1591.5000000,41.8700000,0.0000000,0.0000000,0.0000000),--object(ramp) (2)
	createObject(3458,3710.8999000,-1561.4000000,44.8000000,0.0000000,0.0000000,270.0000000),--object(vgncarshade1) (68)
	createObject(3458,3705.8000000,-1561.4000000,44.8000000,0.0000000,0.0000000,90.0000000),--object(vgncarshade1) (69)
	createObject(3458,3693.2000000,-1538.7000000,44.8000000,0.0000000,0.0000000,180.0000000),--object(vgncarshade1) (70)
	createObject(3458,3693.2000000,-1533.6000000,44.8000000,0.0000000,0.0000000,359.9950000),--object(vgncarshade1) (71)
	createObject(3458,3652.8000000,-1538.7000000,44.8000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (72)
	createObject(3458,3652.8000000,-1533.6000000,44.8000000,0.0000000,0.0000000,359.9890000),--object(vgncarshade1) (73)
	createObject(3458,3635.2000000,-1561.4000000,44.8000000,0.0000000,0.0000000,89.9950000),--object(vgncarshade1) (74)
	createObject(3458,3640.3000000,-1561.4000000,44.8000000,0.0000000,0.0000000,269.9950000),--object(vgncarshade1) (75)
	createObject(1660,3635.3000000,-1591.5000000,41.8700000,0.0000000,0.0000000,0.0000000),--object(ramp) (3)
	createObject(1660,3640.5000000,-1591.5000000,41.8700000,0.0000000,0.0000000,0.0000000),--object(ramp) (4)
	createObject(3458,3683.1001000,-1579.0000000,44.8000000,0.0000000,0.0000000,180.0000000),--object(vgncarshade1) (76)
	createObject(3458,3683.1006000,-1559.7998000,44.8000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (77)
	createObject(3458,3663.0000000,-1559.8000000,44.7880000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (78)
	createObject(3458,3663.0000000,-1579.0000000,44.7880000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (79)
	createObject(1633,3647.8000000,-1564.7000000,46.0000000,344.9980000,0.0000000,180.0000000),--object(landjump) (2)
	createObject(1633,3660.0000000,-1564.7000000,46.0000000,344.9930000,0.0000000,179.9950000),--object(landjump) (3)
	createObject(1633,3660.1001000,-1571.5000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (4)
	createObject(1633,3672.8999000,-1565.1000000,46.0000000,344.9930000,0.0000000,179.9950000),--object(landjump) (5)
	createObject(1633,3673.0000000,-1571.9000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (6)
	createObject(1633,3685.5000000,-1571.7000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (7)
	createObject(1633,3685.5000000,-1564.9000000,46.0000000,344.9930000,0.0000000,179.9950000),--object(landjump) (8)
	createObject(1633,3696.1001000,-1565.1000000,46.0000000,344.9930000,0.0000000,179.9950000),--object(landjump) (9)
	createObject(1633,3696.2000000,-1571.9000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (10)
	createObject(1633,3647.7000000,-1552.3000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (11)
	createObject(1633,3647.6001000,-1545.5000000,46.0000000,344.9980000,0.0000000,180.0000000),--object(landjump) (12)
	createObject(1633,3660.1001000,-1552.3000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (13)
	createObject(1633,3660.1001000,-1545.5000000,46.0000000,344.9930000,0.0000000,179.9950000),--object(landjump) (14)
	createObject(1633,3673.0000000,-1552.2000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (15)
	createObject(1633,3673.0000000,-1545.4000000,46.0000000,344.9980000,0.0000000,180.0000000),--object(landjump) (16)
	createObject(1633,3685.3999000,-1552.3000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (17)
	createObject(1633,3685.3000000,-1545.5000000,46.0000000,344.9930000,0.0000000,179.9950000),--object(landjump) (18)
	createObject(1633,3696.0000000,-1552.3000000,46.0000000,344.9980000,0.0000000,0.0000000),--object(landjump) (19)
	createObject(1633,3696.0000000,-1545.5000000,46.0000000,344.9930000,0.0000000,179.9950000),--object(landjump) (20)
	createObject(3458,3698.5000000,-1851.0000000,0.0000000,0.0000000,0.0000000,180.0000000),--object(vgncarshade1) (81)
	createObject(3458,3698.5000000,-1845.9000000,0.0000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (82)
	createObject(3458,3658.1001000,-1851.0000000,0.0000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (83)
	createObject(3458,3658.1006000,-1845.9004000,0.0000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3634.3999000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (85)
	createObject(3458,3639.5000000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (86)
	createObject(3458,3644.6001000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (87)
	createObject(3458,3649.7002000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (88)
	createObject(3458,3654.8000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (89)
	createObject(3458,3659.9004000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (90)
	createObject(3458,3634.3999000,-1837.8000000,56.3880000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (91)
	createObject(3458,3639.5000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (92)
	createObject(3458,3644.6006000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (93)
	createObject(3458,3649.7000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (94)
	createObject(3458,3654.7998000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (95)
	createObject(3458,3659.9004000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (96)
	createObject(3458,3665.0000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (98)
	createObject(3458,3670.1001000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (99)
	createObject(3458,3675.2000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (100)
	createObject(3458,3680.3000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (101)
	createObject(3458,3685.4004000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (102)
	createObject(3458,3690.5000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (103)
	createObject(3458,3695.6001000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (104)
	createObject(3458,3700.7000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (105)
	createObject(3458,3705.7998000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (106)
	createObject(3458,3710.9004000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (107)
	createObject(3458,3716.0000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (108)
	createObject(3458,3716.0000000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (109)
	createObject(3458,3705.7998000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (110)
	createObject(3458,3710.9004000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (111)
	createObject(3458,3700.7002000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (112)
	createObject(3458,3695.6006000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (113)
	createObject(3458,3690.5000000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (114)
	createObject(3458,3685.4004000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (115)
	createObject(3458,3680.2998000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (116)
	createObject(3458,3675.2002000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (117)
	createObject(3458,3670.1006000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (118)
	createObject(3458,3665.0000000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (119)
	createObject(3458,3659.9004000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (120)
	createObject(3458,3654.7998000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (121)
	createObject(3458,3649.7002000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (122)
	createObject(3458,3644.6006000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (123)
	createObject(3458,3634.4004000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3639.5000000,-1837.7998000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (125)
	createObject(3458,3659.9004000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (126)
	createObject(3458,3654.7998000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (127)
	createObject(3458,3649.7002000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (128)
	createObject(3458,3644.6006000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (129)
	createObject(3458,3639.5000000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (130)
	createObject(3458,3634.4004000,-1837.7998000,56.3880000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3665.0000000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (132)
	createObject(3458,3670.1001000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (133)
	createObject(3458,3675.2000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (134)
	createObject(3458,3680.3000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (135)
	createObject(3458,3685.3999000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (136)
	createObject(3458,3690.5000000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3698.3000000,-1839.1000000,35.1000000,10.0000000,0.0000000,179.9950000),--object(vgncarshade1) (143)
	createObject(3458,3698.2998000,-1844.0996000,36.2000000,14.9960000,0.0000000,179.9950000),--object(vgncarshade1) (144)
	createObject(3458,3716.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (145)
	createObject(3458,3711.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (146)
	createObject(3458,3705.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (147)
	createObject(3458,3700.8000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (148)
	createObject(3458,3695.7000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (149)
	createObject(3458,3690.6001000,-1860.1999500,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (150)
	createObject(3458,3685.5000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (151)
	createObject(3458,3680.3999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (152)
	createObject(3458,3675.3000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (153)
	createObject(3458,3670.2000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (154)
	createObject(3458,3665.1001000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (155)
	createObject(3458,3660.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (156)
	createObject(3458,3654.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (157)
	createObject(3458,3649.8000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (158)
	createObject(3458,3644.7000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (159)
	createObject(3458,3639.6001000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (160)
	createObject(3458,3634.5000000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3634.5000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (162)
	createObject(3458,3639.6001000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (163)
	createObject(3458,3644.7000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (164)
	createObject(3458,3654.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (165)
	createObject(3458,3649.8000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (166)
	createObject(3458,3660.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (167)
	createObject(3458,3665.1001000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (168)
	createObject(3458,3670.3000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (169)
	createObject(3458,3675.3999000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (170)
	createObject(3458,3680.5000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (171)
	createObject(3458,3685.6001000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (172)
	createObject(3458,3690.6001000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (173)
	createObject(3458,3695.8000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (174)
	createObject(3458,3700.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (175)
	createObject(3458,3705.8000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (176)
	createObject(3458,3716.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (177)
	createObject(3458,3710.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (178)
	createObject(3458,3690.5000000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (179)
	createObject(3458,3685.4004000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (180)
	createObject(3458,3680.2998000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (181)
	createObject(3458,3675.2002000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (182)
	createObject(3458,3670.1006000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (183)
	createObject(3458,3665.0000000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (184)
	createObject(3458,3698.6006000,-1856.0996000,0.0000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (185)
	createObject(3458,3738.8999000,-1845.9000000,0.0000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (188)
	createObject(3458,3738.8999000,-1850.9000000,0.0000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (189)
	createObject(3458,3721.1006000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (190)
	createObject(3458,3726.2000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (191)
	createObject(3458,3731.3000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (192)
	createObject(3458,3736.3999000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (193)
	createObject(3458,3741.5000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (194)
	createObject(3458,3746.6001000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (195)
	createObject(3458,3751.7000000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (196)
	createObject(3458,3756.7998000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (197)
	createObject(3458,3760.6006000,-1838.9004000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (198)
	createObject(3458,3760.6006000,-1843.9004000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (199)
	createObject(3458,3760.6006000,-1849.0000000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (200)
	createObject(3458,3760.6006000,-1854.0996000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (201)
	createObject(3458,3721.1006000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (202)
	createObject(3458,3726.2002000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (203)
	createObject(3458,3731.2998000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (204)
	createObject(3458,3736.4004000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (205)
	createObject(3458,3741.5000000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (206)
	createObject(3458,3746.6006000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (207)
	createObject(3458,3751.7002000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (208)
	createObject(3458,3756.7998000,-1860.2002000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (209)
	createObject(3458,3760.6006000,-1859.2002000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (210)
	createObject(3458,3721.1001000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (211)
	createObject(3458,3726.2000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (212)
	createObject(3458,3731.3000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (213)
	createObject(3458,3736.3999000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (214)
	createObject(3458,3741.5000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (215)
	createObject(3458,3746.6001000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (216)
	createObject(3458,3751.7000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (217)
	createObject(3458,3756.8000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (218)
	createObject(3458,3614.4004000,-1599.2998000,33.8000000,0.0000000,19.9900000,179.9950000),--object(vgncarshade1) (220)
	createObject(3458,3614.3999000,-1594.2000000,33.8000000,0.0000000,19.9950000,180.0000000),--object(vgncarshade1) (221)
	createObject(3458,3576.5000000,-1599.3000000,20.0000000,0.0000000,19.9950000,179.9950000),--object(vgncarshade1) (222)
	createObject(3458,3576.5000000,-1594.2002000,20.0000000,0.0000000,19.9900000,179.9950000),--object(vgncarshade1) (223)
	createObject(3458,3536.8000000,-1599.3000000,13.0000000,0.0000000,0.0000000,179.9890000),--object(vgncarshade1) (224)
	createObject(3458,3554.5000000,-1622.0000000,13.0000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (225)
	createObject(3458,3549.3999000,-1622.0000000,13.0000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (226)
	createObject(3458,3536.8000000,-1594.2000000,13.0000000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (227)
	createObject(3458,3496.3999000,-1599.3000000,13.0000000,0.0000000,0.0000000,179.9840000),--object(vgncarshade1) (228)
	createObject(3458,3496.3999000,-1594.2000000,13.0000000,0.0000000,0.0000000,359.9780000),--object(vgncarshade1) (229)
	createObject(3458,3478.8000000,-1622.0000000,13.0000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (230)
	createObject(3458,3483.8999000,-1622.0000000,13.0000000,0.0000000,0.0000000,269.9840000),--object(vgncarshade1) (231)
	createObject(3458,3483.8999000,-1662.4000000,13.0000000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (232)
	createObject(3458,3478.8000000,-1662.4000000,13.0000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (233)
	createObject(3458,3483.8999000,-1702.8000000,13.0000000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (234)
	createObject(3458,3478.7998000,-1702.7998000,13.0000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (235)
	createObject(3458,3554.5000000,-1662.4000000,13.0000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (236)
	createObject(3458,3549.3999000,-1662.4000000,13.0000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (237)
	createObject(3458,3554.5000000,-1702.8000000,13.0000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (238)
	createObject(3458,3549.3999000,-1702.8000000,13.0000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (239)
	createObject(3458,3536.9004000,-1725.5000000,13.0000000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (240)
	createObject(3458,3536.9004000,-1730.5996000,13.0000000,0.0000000,0.0000000,179.9840000),--object(vgncarshade1) (241)
	createObject(3458,3496.5000000,-1730.6000000,13.0000000,0.0000000,0.0000000,179.9840000),--object(vgncarshade1) (242)
	createObject(3458,3496.5000000,-1725.5000000,13.0000000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (243)
	createObject(3458,3516.6001000,-1622.0000000,13.0000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (244)
	createObject(3458,3516.6001000,-1662.4000000,13.0000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (245)
	createObject(3458,3516.6001000,-1702.8000000,13.0000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (246)
	createObject(3458,3526.7000000,-1621.9000000,12.9890000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (247)
	createObject(3458,3526.7000000,-1662.4000000,12.9770000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (248)
	createObject(3458,3526.7000000,-1702.8000000,12.9900000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (249)
	createObject(3458,3496.7000000,-1702.8000000,12.9980000,0.0000000,0.0000000,359.9780000),--object(vgncarshade1) (250)
	createObject(3458,3496.8000000,-1662.4000000,12.9900000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (251)
	createObject(3458,3496.6001000,-1621.9000000,12.9790000,0.0000000,0.0000000,359.9780000),--object(vgncarshade1) (252)
	createObject(3458,3533.3999000,-1702.8000000,12.9790000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (253)
	createObject(3458,3533.3999000,-1662.4000000,12.9690000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (254)
	createObject(3458,3533.3999000,-1622.0000000,12.9690000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (255)
	createObject(3458,3500.1001000,-1622.0000000,12.9690000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (256)
	createObject(3458,3500.1001000,-1662.4000000,12.9690000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (257)
	createObject(3458,3500.1001000,-1702.8000000,12.9690000,0.0000000,0.0000000,269.9780000),--object(vgncarshade1) (258)
	createObject(3458,3526.7000000,-1682.9000000,12.9590000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (259)
	createObject(3458,3496.8000000,-1682.9000000,12.9490000,0.0000000,0.0000000,359.9780000),--object(vgncarshade1) (260)
	createObject(3458,3526.7000000,-1642.4000000,12.9490000,0.0000000,0.0000000,359.9840000),--object(vgncarshade1) (261)
	createObject(3458,3497.0000000,-1642.4000000,12.9460000,0.0000000,0.0000000,359.9780000),--object(vgncarshade1) (262)
	createObject(3458,3617.7002000,-1851.0000000,0.0000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (263)
	createObject(3458,3617.7002000,-1845.9004000,0.0000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (264)
	createObject(12857,3535.2000000,-1848.8000000,-0.9000000,0.0000000,0.0000000,90.0000000),--object(ce_bridge02) (6)
	createObject(3458,3577.3000000,-1845.9000000,0.0000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (264)
	createObject(3458,3577.3000000,-1851.0000000,0.0000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (263)
	createObject(12857,3531.7207000,-1847.8000000,-0.6567000,8.0000000,0.0000000,90.0000000),--amt 12857(7)
	createObject(12857,3528.3091000,-1846.8000000,0.0684600,16.0000000,0.0000000,90.0000000),--amt 12857(8)
	createObject(12857,3525.0315000,-1845.8000000,1.2613600,24.0000000,0.0000000,90.0000000),--amt 12857(9)
	createObject(12857,3521.9519000,-1844.8000000,2.8988000,32.0000000,0.0000000,90.0000000),--amt 12857(10)
	createObject(12857,3519.1304000,-1843.8000000,4.9488900,40.0000000,0.0000000,90.0000000),--amt 12857(11)
	createObject(12857,3516.6213000,-1842.8000000,7.3717400,48.0000000,0.0000000,90.0000000),--amt 12857(12)
	createObject(12857,3514.4741000,-1841.8000000,10.1201800,56.0000000,0.0000000,90.0000000),--amt 12857(13)
	createObject(12857,3512.7300000,-1840.8000000,13.1407200,64.0000000,0.0000000,90.0000000),--amt 12857(14)
	createObject(12857,3511.4236000,-1839.8000000,16.3745800,72.0000000,0.0000000,90.0000000),--amt 12857(15)
	createObject(12857,3510.5798000,-1838.8000000,19.7588000,80.0000000,0.0000000,90.0000000),--amt 12857(16)
	createObject(12857,3510.2151000,-1837.8000000,23.2275100,88.0000000,0.0000000,90.0000000),--amt 12857(17)
	createObject(12857,3510.3369000,-1836.8000000,26.7132100,84.0000000,180.0000000,270.0000000),--amt 12857(18)
	createObject(12857,3510.9426000,-1835.8000000,30.1480500,76.0000000,180.0000000,270.0000000),--amt 12857(19)
	createObject(12857,3512.0203000,-1834.8000000,33.4651600,68.0000000,180.0000000,270.0000000),--amt 12857(20)
	createObject(12857,3513.5493000,-1833.8000000,36.6000000,60.0000000,180.0000000,270.0000000),--amt 12857(21)
	createObject(12857,3515.4998000,-1832.8000000,39.4915400,52.0000000,180.0000000,270.0000000),--amt 12857(22)
	createObject(12857,3517.8335000,-1831.8000000,42.0834900,44.0000000,180.0000000,270.0000000),--amt 12857(23)
	createObject(12857,3520.5054000,-1830.8000000,44.3254200,36.0000000,180.0000000,270.0000000),--amt 12857(24)
	createObject(12857,3523.4631000,-1829.8000000,46.1736900,28.0000000,180.0000000,270.0000000),--amt 12857(25)
	createObject(12857,3526.6494000,-1828.8000000,47.5923200,20.0000000,180.0000000,270.0000000),--amt 12857(26)
	createObject(12857,3530.0022000,-1827.8000000,48.5536900,12.0000000,180.0000000,270.0000000),--amt 12857(27)
	createObject(12857,3533.4561000,-1826.8000000,49.0391000,4.0000000,180.0000000,270.0000000),--amt 12857(28)
	createObject(12857,3536.9438000,-1825.8000000,49.0391000,356.0000000,180.0000000,270.0000000),--amt 12857(29)
	createObject(12857,3540.3977000,-1824.8000000,48.5536900,348.0000000,180.0000000,270.0000000),--amt 12857(30)
	createObject(12857,3543.7505000,-1823.8000000,47.5923200,340.0000000,180.0000000,270.0000000),--amt 12857(31)
	createObject(12857,3546.9368000,-1822.8000000,46.1736900,332.0000000,180.0000000,270.0000000),--amt 12857(32)
	createObject(12857,3549.8945000,-1821.8000000,44.3254200,324.0000000,180.0000000,270.0000000),--amt 12857(33)
	createObject(12857,3552.5664000,-1820.8000000,42.0834900,316.0000000,180.0000000,270.0000000),--amt 12857(34)
	createObject(12857,3554.9001000,-1819.8000000,39.4915400,308.0000000,180.0000000,270.0000000),--amt 12857(35)
	createObject(12857,3556.8506000,-1818.8000000,36.6000000,300.0000000,180.0000000,270.0000000),--amt 12857(36)
	createObject(12857,3558.3796000,-1817.8000000,33.4651600,292.0000000,180.0000000,270.0000000),--amt 12857(37)
	createObject(12857,3559.4573000,-1816.8000000,30.1480500,284.0000000,180.0000000,270.0000000),--amt 12857(38)
	createObject(12857,3560.0630000,-1815.8000000,26.7132100,276.0000000,180.0000000,270.0000000),--amt 12857(39)
	createObject(12857,3560.1848000,-1814.8000000,23.2275100,272.0000000,0.0000000,90.0000000),--amt 12857(40)
	createObject(12857,3559.8201000,-1813.8000000,19.7588000,280.0000000,0.0000000,90.0000000),--amt 12857(41)
	createObject(12857,3558.9763000,-1812.8000000,16.3745800,288.0000000,0.0000000,90.0000000),--amt 12857(42)
	createObject(12857,3557.6699000,-1811.8000000,13.1407200,296.0000000,0.0000000,90.0000000),--amt 12857(43)
	createObject(12857,3555.9258000,-1810.8000000,10.1201800,304.0000000,0.0000000,90.0000000),--amt 12857(44)
	createObject(12857,3553.7786000,-1809.8000000,7.3717400,312.0000000,0.0000000,90.0000000),--amt 12857(45)
	createObject(12857,3551.2695000,-1808.8000000,4.9488900,320.0000000,0.0000000,90.0000000),--amt 12857(46)
	createObject(12857,3548.4480000,-1807.8000000,2.8988000,328.0000000,0.0000000,90.0000000),--amt 12857(47)
	createObject(12857,3545.3684000,-1806.8000000,1.2613600,336.0000000,0.0000000,90.0000000),--amt 12857(48)
	createObject(12857,3542.0908000,-1805.8000000,0.0684600,344.0000000,0.0000000,90.0000000),--amt 12857(49)
	createObject(12857,3538.6792000,-1804.8000000,-0.6567000,352.0000000,0.0000000,90.0000000),--amt 12857(50)
	createObject(12857,3535.2000000,-1803.8000000,-0.9000000,0.0000000,0.0000000,90.0000000),--amt 12857(51)
	createObject(3458,3499.8999000,-1801.1000000,0.0000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (264)
	createObject(3458,3499.8999000,-1806.2000000,0.0000000,0.0000000,0.0000000,180.0000000),--object(vgncarshade1) (264)
	createObject(3458,3477.1001000,-1818.8000000,0.0000000,0.0000000,0.0000000,269.9950000),--object(vgncarshade1) (264)
	createObject(3458,3472.0000000,-1818.8000000,0.0000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (264)
	createObject(3458,3477.1001000,-1859.2000000,0.0000000,0.0000000,0.0000000,269.9890000),--object(vgncarshade1) (264)
	createObject(3458,3472.0000000,-1859.2000000,0.0000000,0.0000000,0.0000000,89.9890000),--object(vgncarshade1) (264)
	createObject(1633,3484.7000000,-1877.3000000,1.4000000,346.0000000,0.0000000,270.0000000),--object(landjump) (21)
	createObject(1633,3484.7000000,-1873.2000000,1.4000000,345.9980000,0.0000000,270.0000000),--object(landjump) (22)
	createObject(1633,3484.7000000,-1869.1000000,1.4000000,345.9980000,0.0000000,270.0000000),--object(landjump) (23)
	createObject(1633,3484.7000000,-1865.0000000,1.4000000,345.9980000,0.0000000,270.0000000),--object(landjump) (24)
	createObject(1633,3484.7000000,-1860.9000000,1.4000000,345.9980000,0.0000000,270.0000000),--object(landjump) (25)
	createObject(1633,3484.7000000,-1856.8000000,1.4000000,345.9980000,0.0000000,270.0000000),--object(landjump) (26)
	createObject(1633,3493.0000000,-1877.3000000,1.7000000,345.9980000,0.0000000,270.0000000),--object(landjump) (27)
	createObject(1633,3493.0000000,-1873.2000000,1.7000000,345.9980000,0.0000000,270.0000000),--object(landjump) (28)
	createObject(1633,3493.0000000,-1869.1000000,1.7000000,345.9980000,0.0000000,270.0000000),--object(landjump) (29)
	createObject(1633,3493.0000000,-1865.0000000,1.7000000,345.9980000,0.0000000,270.0000000),--object(landjump) (30)
	createObject(1633,3493.0000000,-1860.9000000,1.7000000,345.9980000,0.0000000,270.0000000),--object(landjump) (31)
	createObject(1633,3493.0000000,-1856.8000000,1.7000000,345.9980000,0.0000000,270.0000000),--object(landjump) (32)
	createObject(3458,3477.1001000,-1792.9000000,3.1000000,0.0000000,30.0000000,269.9890000),--object(vgncarshade1) (264)
	createObject(3458,3472.0000000,-1792.9000000,3.1000000,0.0000000,29.9980000,269.9890000),--object(vgncarshade1) (264)
	createObject(3458,3472.1001000,-1756.0000000,13.0000000,0.0000000,0.0000000,89.9840000),--object(vgncarshade1) (235)
	createObject(3458,3477.1001000,-1756.0000000,13.0000000,0.0000000,0.0000000,269.9840000),--object(vgncarshade1) (235)
	createObject(1655,3474.5000000,-1740.1000000,15.6000000,0.0000000,0.0000000,0.0000000),--object(waterjumpx2) (1)
	createObject(3458,3721.1001000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3726.2000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3731.3000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3736.3999000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3741.5000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3746.6001000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3751.7000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3756.8000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3721.1006000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3726.2002000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3731.2998000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3736.4004000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3741.5000000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3746.6006000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3751.7002000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3756.7998000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6006000,-1838.9004000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (198)
	createObject(3458,3760.6006000,-1843.9004000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (199)
	createObject(3458,3760.6006000,-1849.0000000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (200)
	createObject(3458,3760.6006000,-1854.0996000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (201)
	createObject(3458,3760.6006000,-1859.2002000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (210)
	createObject(1634,3711.5000000,-1786.4000000,42.0000000,350.0000000,0.0000000,180.0000000),--object(landjump2) (1)
	createObject(1634,3707.3999000,-1786.4000000,42.0000000,349.9970000,0.0000000,179.9950000),--object(landjump2) (2)
	createObject(3458,3634.5000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3639.6001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3644.7000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3649.8000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3654.8999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3660.0000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3665.1001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3670.2000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3675.3000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3680.3999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3685.5000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3690.6001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3695.7000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3700.8000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3705.8999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3711.0000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3716.0000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3721.1001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3726.2000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3731.3000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3736.3999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3741.5000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3746.6001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3751.7000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3756.8000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3733.8999000,-1690.2000000,40.6000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (3)
	createObject(3458,3733.8999000,-1685.1000000,40.6000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (4)
	createObject(3458,3755.5000000,-1685.1000000,15.0000000,0.0000000,90.0000000,181.0000000),--object(vgncarshade1) (4)
	createObject(3458,3755.6001000,-1690.2000000,15.0000000,0.0000000,90.0000000,181.0000000),--object(vgncarshade1) (4)
	createObject(3458,3757.7000000,-1690.1000000,55.0000000,0.0000000,90.0000000,1.0000000),--object(vgncarshade1) (4)
	createObject(3458,3756.5000000,-1684.0000000,55.0000000,0.0000000,90.0000000,91.0000000),--object(vgncarshade1) (4)
	createObject(3458,3756.7000000,-1691.2000000,55.0000000,0.0000000,90.0000000,270.9940000),--object(vgncarshade1) (4)
	createObject(3458,3757.6001000,-1685.0000000,55.0000000,0.0000000,90.0000000,0.9940000),--object(vgncarshade1) (4)
	createObject(3458,3756.7002000,-1691.2002000,15.0000000,0.0000000,90.0000000,270.9940000),--object(vgncarshade1) (4)
	createObject(3458,3756.5000000,-1684.0000000,15.0000000,0.0000000,90.0000000,90.9940000),--object(vgncarshade1) (4)
	createObject(3458,3757.7002000,-1690.0996000,15.0000000,0.0000000,90.0000000,0.9940000),--object(vgncarshade1) (4)
	createObject(3458,3757.6006000,-1685.0000000,15.0000000,0.0000000,90.0000000,0.9940000),--object(vgncarshade1) (4)
	createObject(3458,3755.5000000,-1685.0996000,55.0000000,0.0000000,90.0000000,181.0000000),--object(vgncarshade1) (4)
	createObject(3458,3755.5000000,-1685.0996000,55.0000000,0.0000000,90.0000000,181.0000000),--object(vgncarshade1) (4)
	createObject(3458,3755.6006000,-1690.2002000,55.0000000,0.0000000,90.0000000,181.0000000),--object(vgncarshade1) (4)
	createObject(3458,3612.7000000,-1690.2000000,40.6000000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (2)
	createObject(3458,3612.7000000,-1685.1000000,40.6000000,0.0000000,0.0000000,0.0000000),--object(vgncarshade1) (1)
	createObject(1655,3588.8999000,-1687.8000000,43.4000000,4.9990000,0.0000000,90.0000000),--object(waterjumpx2) (3)
	createObject(1655,3583.3999000,-1687.8000000,47.0000000,15.9000000,0.0000000,90.0000000),--object(waterjumpx2) (4)
	createObject(1655,3578.2000000,-1687.8000000,52.0000000,27.0000000,0.0000000,90.0000000),--object(waterjumpx2) (5)
	createObject(1655,3574.8000000,-1687.8000000,57.0000000,40.0000000,0.0000000,90.0000000),--object(waterjumpx2) (6)
	createObject(1655,3572.6001000,-1687.8000000,63.0000000,55.0000000,0.0000000,90.0000000),--object(waterjumpx2) (7)
	createObject(1655,3571.9004000,-1687.7998000,70.0000000,68.0000000,0.0000000,90.0000000),--object(waterjumpx2) (8)
	createObject(3458,3629.3000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3624.2000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3619.1001000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3614.0000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3608.8999000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3603.8000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3760.6001000,-1838.9000000,56.4000000,0.0000000,90.0000000,0.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6001000,-1844.0000000,56.4000000,0.0000000,90.0000000,0.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6001000,-1849.0000000,56.4000000,0.0000000,90.0000000,0.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6001000,-1854.1000000,56.4000000,0.0000000,90.0000000,0.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6001000,-1859.2000000,56.4000000,0.0000000,90.0000000,0.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6006000,-1859.2002000,56.4000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6006000,-1854.0996000,56.4000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6006000,-1849.0000000,56.4000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6006000,-1844.0000000,56.4000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (137)
	createObject(3458,3760.6006000,-1838.9004000,56.4000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (137)
	createObject(3458,3739.0000000,-1856.1000000,76.7000000,0.0000000,180.0000000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3739.0000000,-1851.0000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3739.0000000,-1845.9000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3739.0000000,-1840.8000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3698.7000000,-1842.6000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3698.6001000,-1845.9000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3698.6001000,-1851.0000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3698.6001000,-1856.1000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3658.2000000,-1856.1000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3658.2000000,-1851.0000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3658.2000000,-1845.9000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3658.2000000,-1840.8000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3634.5000000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3639.6006000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3644.7002000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3649.7998000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3654.9004000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3660.0000000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3665.1006000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3670.2002000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3675.2998000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3680.4004000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3720.0000000,-1838.9000000,56.4000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (137)
	createObject(3458,3691.6001000,-1838.8000000,56.4000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (137)
	createObject(3458,3594.3999000,-1685.0000000,-18.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (2)
	createObject(3458,3594.3999000,-1690.1000000,-18.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (2)
	createObject(3458,3595.5000000,-1691.1000000,-18.0000000,0.0000000,90.0000000,269.9950000),--object(vgncarshade1) (2)
	createObject(3458,3600.6001000,-1691.1000000,-18.0000000,0.0000000,90.0000000,269.9890000),--object(vgncarshade1) (2)
	createObject(3458,3601.6001000,-1690.0000000,22.0000000,0.0000000,90.0000000,359.9890000),--object(vgncarshade1) (2)
	createObject(3458,3601.6001000,-1684.9000000,22.0000000,0.0000000,90.0000000,359.9840000),--object(vgncarshade1) (2)
	createObject(3458,3600.6001000,-1684.0000000,-18.0000000,0.0000000,90.0000000,91.9840000),--object(vgncarshade1) (2)
	createObject(3458,3595.5000000,-1684.2000000,-18.0000000,0.0000000,90.0000000,91.9830000),--object(vgncarshade1) (2)
	createObject(3458,3600.6006000,-1691.0996000,22.0000000,0.0000000,90.0000000,269.9890000),--object(vgncarshade1) (2)
	createObject(3458,3595.5000000,-1691.0996000,22.0000000,0.0000000,90.0000000,269.9890000),--object(vgncarshade1) (2)
	createObject(3458,3594.4004000,-1690.0996000,22.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (2)
	createObject(3458,3594.4004000,-1685.0000000,22.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (2)
	createObject(3458,3601.6006000,-1690.0000000,2218.0000000,0.0000000,90.0000000,359.9840000),--object(vgncarshade1) (2)
	createObject(3458,3601.6006000,-1684.9004000,-18.0000000,0.0000000,90.0000000,359.9840000),--object(vgncarshade1) (2)
	createObject(3458,3601.6006000,-1690.0000000,-18.0000000,0.0000000,90.0000000,359.9840000),--object(vgncarshade1) (2)
	createObject(3458,3595.5000000,-1684.2002000,22.0000000,0.0000000,90.0000000,91.9830000),--object(vgncarshade1) (2)
	createObject(3458,3600.6006000,-1684.0000000,22.0000000,0.0000000,90.0000000,91.9830000),--object(vgncarshade1) (2)
	createObject(3458,3629.3000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3624.2000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3619.1001000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3614.0000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3608.8999000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3603.8000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3629.2998000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3624.2002000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3619.1006000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3614.0000000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3608.9004000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3603.7998000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3629.2998000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3624.2002000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3614.0000000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3619.1006000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3608.9004000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3603.7998000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3690.6006000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3685.5000000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3700.7998000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3695.7002000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3705.9004000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3711.0000000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3716.0000000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3726.2002000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (203)
	createObject(3458,3721.1006000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (202)
	createObject(3458,3721.1006000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3726.2002000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3731.2998000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3731.2998000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (204)
	createObject(3458,3736.4004000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (205)
	createObject(3458,3736.4004000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3741.5000000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3746.6006000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3751.7002000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3756.7998000,-1860.2002000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3756.7998000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (209)
	createObject(3458,3751.7002000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (208)
	createObject(3458,3746.6006000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (207)
	createObject(3458,3741.5000000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (206)
	createObject(3458,3739.1001000,-1837.8000000,79.0000000,90.0000000,0.0000000,180.0000000),--object(vgncarshade1) (84)
	createObject(3458,3698.7000000,-1837.8000000,79.0000000,90.0000000,0.0000000,179.9950000),--object(vgncarshade1) (84)
	createObject(3458,3658.3000000,-1837.8000000,79.0000000,90.0000000,0.0000000,179.9950000),--object(vgncarshade1) (84)
	createObject(3458,3617.8999000,-1837.8000000,79.0000000,90.0000000,0.0000000,179.9950000),--object(vgncarshade1) (84)
	createObject(3458,3698.1001000,-1839.3000000,77.0000000,24.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3617.8000000,-1840.8000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3617.8000000,-1845.9000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3617.8000000,-1851.0000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3617.8000000,-1856.1000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3598.7000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3593.6001000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3588.5000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3583.3999000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3578.3000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3573.2000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3568.1001000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3563.0000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3557.8999000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3557.9004000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3563.0000000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3568.1006000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3573.2002000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3578.2998000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3583.4004000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3588.5000000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3593.6006000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3598.7002000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3598.7000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3593.6001000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3588.5000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3583.3999000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3578.3000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3573.2000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3568.1001000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3563.0000000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3557.8999000,-1837.8000000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3557.9004000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3563.0000000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3568.1006000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3573.2002000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3578.2998000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3583.4004000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3588.5000000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3593.6006000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3598.7002000,-1837.7998000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3761.8999000,-1837.8000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (197)
	createObject(3458,3761.8999000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (137)
	createObject(3458,3629.3999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3624.3000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3619.2000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3614.1001000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3609.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3603.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3598.8000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3593.7000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3588.6001000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3583.5000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3578.3999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3573.3000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3568.2000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3563.1001000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3558.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3552.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3547.8000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3542.7000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3537.6001000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3532.5000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3527.3999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3522.3000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3517.2000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3512.1001000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3507.0000000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3501.8999000,-1860.2000000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (161)
	createObject(3458,3500.8000000,-1861.3000000,16.0000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (161)
	createObject(3458,3500.8999000,-1866.4000000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.8999000,-1871.5000000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.8999000,-1876.5999800,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.8999000,-1881.7000000,16.0000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.9004000,-1881.7002000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.9004000,-1876.5996000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.9004000,-1871.5000000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.9004000,-1866.4004000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (161)
	createObject(3458,3500.9004000,-1861.2998000,16.0000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (161)
	createObject(3458,3501.9004000,-1860.2002000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (161)
	createObject(3458,3629.3999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3624.3000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3619.2000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3614.1001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3609.0000000,-1860.1000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3603.8999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3598.8000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3593.7000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3588.6001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3583.5000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3578.3999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3573.3000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3568.2000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3563.1001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3558.0000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3552.8999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3547.8000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3542.7000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3537.6001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3532.5000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3527.3999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3522.3000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3517.2000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3512.1001000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3507.0000000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3501.8999000,-1860.2000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3500.8999000,-1861.3000000,56.4000000,0.0000000,90.0000000,180.0000000),--object(vgncarshade1) (131)
	createObject(3458,3500.8999000,-1866.4000000,56.4000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (131)
	createObject(3458,3500.8999000,-1871.5000000,56.4000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (131)
	createObject(3458,3500.8999000,-1876.6000000,56.4000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (131)
	createObject(3458,3500.8999000,-1881.7000000,56.4000000,0.0000000,90.0000000,179.9950000),--object(vgncarshade1) (131)
	createObject(3458,3552.8000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3547.7000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3542.6001000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3537.5000000,-1837.8000000,16.0000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (124)
	createObject(3458,3537.5000000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3542.6006000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3547.7002000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3552.7998000,-1837.7998000,16.0000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (124)
	createObject(3458,3552.8000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3547.7000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3542.6001000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3537.5000000,-1837.8000000,56.4000000,0.0000000,90.0000000,90.0000000),--object(vgncarshade1) (131)
	createObject(3458,3537.5000000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3542.6006000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3547.7002000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3552.7998000,-1837.7998000,56.4000000,0.0000000,90.0000000,270.0000000),--object(vgncarshade1) (131)
	createObject(3458,3577.3999000,-1840.8000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3577.3999000,-1845.9000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3577.3999000,-1851.0000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3577.3999000,-1856.1000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3555.2000000,-1840.8000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3555.2000000,-1845.9000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3555.2000000,-1851.0000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3555.2000000,-1856.1000000,76.7000000,0.0000000,179.9950000,0.0000000),--object(vgncarshade1) (84)
	createObject(3458,3500.9004000,-1881.7002000,56.4000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (131)
	createObject(3458,3500.9004000,-1876.5996000,56.4000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (131)
	createObject(3458,3500.9004000,-1871.5000000,56.4000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (131)
	createObject(3458,3500.9004000,-1866.4004000,56.4000000,0.0000000,90.0000000,359.9950000),--object(vgncarshade1) (131)
	createObject(3458,3487.5000000,-1821.2000000,-0.0099000,0.0000000,0.0000000,229.9950000),--object(vgncarshade1) (264)
	createObject(3458,3672.1001000,-1712.9000000,40.6000000,0.0000000,0.0000000,89.9950000),--object(vgncarshade1) (39)
	createObject(3458,3672.1001000,-1753.3000000,40.6000000,0.0000000,0.0000000,89.9950000),--object(vgncarshade1) (39)
	createObject(3458,3663.3000000,-1733.8000000,40.5870000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (39)
	createObject(3458,3692.7000000,-1733.8000000,40.5890000,0.0000000,0.0000000,179.9950000),--object(vgncarshade1) (39)
	createObject(3458,3654.7000000,-1709.2000000,40.5890000,0.0000000,0.0000000,126.4950000),--object(vgncarshade1) (39)
	createObject(3458,3690.7000000,-1757.7000000,40.5890000,0.0000000,0.0000000,126.4910000),--object(vgncarshade1) (39)
	createObject(3458,3658.8999000,-1714.8000000,40.5810000,0.0000000,0.0000000,126.4910000),--object(vgncarshade1) (39)
	createObject(3458,3686.7000000,-1752.3000000,40.5870000,0.0000000,0.0000000,126.4910000),--object(vgncarshade1) (39)
	createObject(3458,3654.8000000,-1756.5000000,40.5900000,0.0000000,0.0000000,52.9950000),--object(vgncarshade1) (39)
	createObject(3458,3691.1001000,-1708.3000000,40.5790000,0.0000000,0.0000000,52.9930000),--object(vgncarshade1) (39)
	createObject(3458,3658.2000000,-1752.0000000,40.5800000,0.0000000,0.0000000,52.9930000),--object(vgncarshade1) (39)
	createObject(3458,3685.8000000,-1715.3000000,40.5800000,0.0000000,0.0000000,52.9930000),--object(vgncarshade1) (39)
	createObject(3458,3577.5000000,-1837.8000000,79.0000000,90.0000000,0.0000000,179.9950000),--object(vgncarshade1) (84)
	createObject(3458,3555.2000000,-1837.8000000,79.0000000,90.0000000,0.0000000,179.9950000),--object(vgncarshade1) (84)
	createObject(3458,3536.5000000,-1856.5000000,79.0000000,90.0000000,0.0000000,269.9950000),--object(vgncarshade1) (84)
	createObject(3458,3534.5000000,-1856.7000000,77.0000000,24.0000000,179.9950000,90.0000000),--object(vgncarshade1) (84)
	createObject(3437,3665.2000000,-1836.3000000,62.8000000,0.0000000,0.0000000,0.0000000),--object(ballypllr01_lvs) (1)
	createObject(3437,3665.2002000,-1836.2998000,55.0000000,0.0000000,0.0000000,0.0000000),--object(ballypllr01_lvs) (2)
	createObject(3437,3668.8999000,-1836.3000000,62.8000000,0.0000000,330.0000000,0.0000000),--object(ballypllr01_lvs) (3)
	createObject(3437,3665.5000000,-1836.4000000,58.9000000,0.0000000,90.0000000,0.0000000),--object(ballypllr01_lvs) (4)
	createObject(3437,3654.8000000,-1836.0000000,55.0000000,0.0000000,20.0000000,0.0000000),--object(ballypllr01_lvs) (5)
	createObject(3437,3657.7000000,-1835.9000000,63.0000000,0.0000000,19.9950000,0.0000000),--object(ballypllr01_lvs) (6)
	createObject(3437,3648.3000000,-1836.3000000,62.0000000,0.0000000,340.0000000,0.0000000),--object(ballypllr01_lvs) (7)
	createObject(3437,3650.9004000,-1836.4004000,55.0000000,0.0000000,339.9990000,0.0000000),--object(ballypllr01_lvs) (8)
	createObject(3437,3637.8999000,-1836.2000000,66.1000000,0.0000000,90.0000000,0.0000000),--object(ballypllr01_lvs) (9)
	createObject(3437,3642.3999000,-1836.2000000,55.0000000,0.0000000,0.0000000,0.0000000),--object(ballypllr01_lvs) (10)
	createObject(3437,3642.4004000,-1836.2002000,59.0000000,0.0000000,0.0000000,0.0000000),--object(ballypllr01_lvs) (11)
	createObject(3437,3633.6001000,-1836.2000000,66.1000000,0.0000000,90.0000000,0.0000000),--object(ballypllr01_lvs) (12)
	createObject(3437,3636.3999000,-1836.3000000,50.6000000,0.0000000,90.0000000,0.0000000),--object(ballypllr01_lvs) (13)
	createObject(3437,3633.3000000,-1836.3000000,50.6000000,0.0000000,90.0000000,0.0000000),--object(ballypllr01_lvs) (14)
	createObject(3437,3623.3999000,-1835.9000000,62.8000000,0.0000000,0.0000000,0.0000000),--object(ballypllr01_lvs) (15)
	createObject(3437,3623.3000000,-1836.0000000,55.0000000,0.0000000,0.0000000,0.0000000),--object(ballypllr01_lvs) (16)
	createObject(1655,3572.6001000,-1687.7000000,76.0000000,80.0000000,0.0000000,90.0000000),--object(waterjumpx2) (8)

}

for k,v in ipairs(Objects2) do
	setElementDimension(v,2000)
end

