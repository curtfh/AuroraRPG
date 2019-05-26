ShooterPlayer = {}
local ShooterEliminatedPlayers = {}
local ShooterPlayers = {}
local Shootervehicles = {}
local ShooterVehDrivers = {}
local Shooterpickups = {}
ShooterStarted = false
local Shootertimer
local ShooterstartingTimer
local ShooterDimension = 5000
local ShooterMinPlayers = 8
local ShooterMaxPlayers = 15
local timeOut = 900000 -- 15 minutes until time out
maptype = "Shooter1"
local proTimer2 = {}

addEvent("jumpshooter",true)
addEventHandler("jumpshooter",root,function(v)
	if getElementDimension(source) ~= 5000 then return false end
	local sx,sy,sz = getElementVelocity ( v )
	setElementVelocity( v, sx, sy, sz+0.3)
end)

spammer = {}
addEvent("setShooterKiller",true)
addEventHandler("setShooterKiller",root,function(attacker,player)
	if player and attacker then
		if player ~= attacker then
			if spammer[player] and isTimer(spammer[player]) then return false end
			if getElementDimension(player) == 5000 then
				addEventMsg("Killer","(Mini-Game) Shooter : #FFFFFFYou have been killed by "..getPlayerName(attacker), player, 255, 0, 0)
				addEventMsg("Killer2","(Mini-Game) Shooter : #FFFFFFYou have killed  "..getPlayerName(player).." +2 XP", attacker, 255, 0, 0)
				spammer[player] = setTimer(function() end,5000,1)
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


function theChecking()
	if (not ShooterStarted) then
		return
	end
	for index, player in pairs(ShooterPlayers) do
		if player and isElement(player) then
			if (getElementDimension(player) == 5000) then
				if isPedInVehicle(player) == false then
					shooterFailed(player)
				end
			else
				shooterFailed(player)
			end
		end
	end
	for index, vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		if vehicle and isElement(vehicle) then
			if (getElementDimension(vehicle) == 5000) then
				if isElementInWater(vehicle) then
					if getElementData(vehicle,"mini-hit") then
						local thePlayer,theKiller = unpack(getElementData(vehicle,"mini-hit"))
						if thePlayer and isElement(thePlayer) and theKiller and isElement(theKiller) then
							triggerEvent("setShooterKiller",theKiller,theKiller,thePlayer)
						end
					end
					local driver = ShooterVehDrivers[vehicle]
					if driver then
						shooterFailed(driver)
					end
				end
			end
		end
	end
end


function leaveEvent(player)
	if nextEvent == "Shooter" then
		if (not ShooterPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Shooter : You didn't signup for the Shooter Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		if (ShooterStarted) then
			addEventMsg(nil,"(Mini-Game) Shooter : You can't leave from this event because it's already started", player, 255, 0, 0)
			return
		end
		ShooterPlayer[player] = nil
		for index, player2 in pairs(ShooterPlayers) do
			if (player == player2) then
				table.remove(ShooterPlayers, index)
				break
			end
		end
		if (#ShooterPlayers < ShooterMinPlayers and isTimer(ShooterstartingTimer)) then
			killTimer(ShooterstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onShooterQuit)
	end
end
addCommandHandler("leave", leaveEvent)


function onForceShooter(player)
	if nextEvent == "Shooter" then
		if (not ShooterPlayer[player]) then
			addEventMsg(nil,"(Mini-Game) Shooter : You didn't signup for the Shooter Event", player, 255, 0, 0)
			--addEventMsg(nil, text, r, g, b, timer)
			return
		end
		ShooterPlayer[player] = nil
		for index, player2 in pairs(ShooterPlayers) do
			if (player == player2) then
				table.remove(ShooterPlayers, index)
				break
			end
		end
		if (#ShooterPlayers < ShooterMinPlayers and isTimer(ShooterstartingTimer)) then
			killTimer(ShooterstartingTimer)
		end
		removeEventHandler("onPlayerQuit", player, onShooterQuit)
	end
end


function signupForShooter(client)
	if (isEventStarted("Shooter") ~= true) then
		return
		addEventMsg(nil,"(Mini-Game) Shooter : This event is not started yet", client, 255, 0, 0)
	end
	if (ShooterPlayer[client]) then
		addEventMsg(nil,"(Mini-Game) Shooter : You have already signed up for this event", client, 255, 0, 0)
		return
	end
	if (#ShooterPlayers == ShooterMaxPlayers) then
		addEventMsg(nil,"(Mini-Game) Shooter : The event is already full and about to start", client, 255, 0, 0)
		return
	end
	if (ShooterStarted) then
		addEventMsg(nil,"(Mini-Game) Shooter : The event is already started", client, 255, 0, 0)
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
		addEventMsg(nil,"(Mini-Game) Shooter : you can't join the Shooter event while you're not in main world", client, 255, 0, 0)
		return
	end
	if getElementData(client,"isPlayerJailed") or getElementData(client,"isPlayerArrested") then
		addEventMsg(nil,"(Mini-Game) Shooter : you can't join the Shooter event while you're arrested or jailed!", client, 255, 0, 0)
		return
	end
	ShooterPlayer[client] = true
	getPlayerPosition(client)
	sendToShooterPlayers(getPlayerName(client).." has signed up. "..(#ShooterPlayers + 1).."/"..ShooterMaxPlayers.." players signed up", 0,255,0)
	table.insert(ShooterPlayers, client)
	addEventHandler("onPlayerQuit", client, onShooterQuit)
	addEventMsg(nil,"(Mini-Game) #FFFFFFShooter : You have signed up !!.", client, 0,255,0)
	if (#ShooterPlayers == ShooterMinPlayers) then
		ShooterstartingTimer = setTimer(beforeStartShooter, 10000, 1)
		sendToShooterPlayers("(Mini-Game) Shooter : Event will be started within 10 seconds!", 0,255,0)
	end
	if (#ShooterPlayers == ShooterMaxPlayers) then
		if (isTimer(ShooterstartingTimer)) then
			killTimer(ShooterstartingTimer)
		end
		beforeStartShooter()
	end
end



function sendToShooterPlayers(message, r, g, b)
	for index, player in pairs(ShooterPlayers) do
		addEventMsg(nil,message, player, r, g, b)
	end
end

function beforeStartShooter()
	ShooterStarted = true
	sendToShooterPlayers(#ShooterPlayers.." players have signed up for the Shooter Event. please wait 5 seconds.", 0,255,0)
	addWastedHandler3()
	local num = math.random(1,3)
	if num == 1 then
		nm = "Shooter1"
	elseif num == 2 then
		nm = "Shooter2"
	elseif num == 3 then
		nm = "Shooter3"
	end
	maptype = nm
	loadMap(nm)
	for k,v in ipairs(pickupTable[nm]) do
		local x,y,z = v[1],v[2],v[3]
		local thePickup = createPickup( x,y,z+0.2, 3, v[5] )
		setElementDimension(thePickup,5000)
		table.insert(Shooterpickups,thePickup)
	end
	setTimer(startShooter, 5000, 1) -- here too
end

function addWastedHandler3()
	for index, player in pairs(ShooterPlayers) do
		if (isElement(player)) then
			addEventHandler("onPlayerWasted", player, onShooterWasted)
		end
	end
end


function startShooter()
	stopText()
	if isTimer(proTimer2) then killTimer(proTimer2) end
	for k,v in ipairs(getElementsByType("player")) do
		if isPedDead(v) then
			for index, xplayer in pairs(ShooterPlayers) do
				if (v == xplayer) then
					table.remove(ShooterPlayers, index)
					break
				end
			end
		end
	end
	for index, player in ipairs(ShooterPlayers) do
		if (player and isElement(player) and getElementData(player,"isPlayerJailed") == false) then
			if (isPedInVehicle(player)) then
				removePedFromVehicle(player)
			end
			if isPedDead(player) then
				return
			end
			---local id = vehID[math.random(#vehID)]
			local id = exports.AURlevels:getValidVehicle(player)
			--outputDebugString(getPlayerName(player).." car "..id)
			setElementPosition(player,ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3])
			setElementDimension(player, ShooterDimension)
			local vehicle = createVehicle(id, ShooterPos[maptype][index][1], ShooterPos[maptype][index][2], ShooterPos[maptype][index][3] + 1)
			setElementDimension(vehicle, ShooterDimension)

			Shootervehicles[player] = vehicle
			ShooterVehDrivers[vehicle] = player
			setElementRotation(vehicle,0,0,ShooterPos[maptype][index][4])
			setVehicleDamageProof(vehicle, true)
			setTimer(setVehicleDamageProof, 3000, 1, vehicle, false)
			triggerClientEvent(player, "startCountDown", player,2000)
			setElementFrozen(player, true)
			toggleAllControls(player, false)
			warpPedIntoVehicle(player, vehicle)
			setTimer(setElementFrozenDelayed, 8000, 1, player, false)

		end
	end
	addEventHandler("onVehicleStartExit", resourceRoot, stopExit23)
	ShooterTimer = setTimer(enShooterD, timeOut, 1)
	proTimer2 = setTimer(theChecking,1000,0)

end


addEventHandler("onPickupHit",resourceRoot,function(hit)
	if hit and getElementType(hit) == "player" then
		local veh = getPedOccupiedVehicle(hit,0)
		for k,v in ipairs(Shooterpickups) do
			if source == v then
				if getElementModel(source) == 1510 then
					local posx, posy, posz = getElementPosition ( source )
					--createExplosion (posx, posy, posz, 5 )
					local sx,sy,sz = getElementVelocity ( veh )
					setElementVelocity( veh, sx, sy, sz+0.3)
				elseif getElementModel(source) == 2222 then
					fixVehicle(veh)
				elseif getElementModel(source) == 2223 then
					--addVehicleUpgrade(veh, 1010)
				elseif getElementModel(source) == 1079 then
					--setElementModel(veh,502)
				end
			end
		end
	end
end)

function STRChange(rs,newid)
	if nextEvent == "Shooter" then
		if rs and isElement(rs) then
			if isPedInVehicle(rs) and getElementDimension(rs) == 5000 then
				for index, player in ipairs(ShooterPlayers) do
					if player == rs then
						if rs and isElement(rs) then
					--outputDebugString("rs is player")
							if isPedInVehicle(rs) then
						--	outputDebugString("is ped in car check ")
								local veh = Shootervehicles[rs]
								if veh and isElement(veh) then
							--	outputDebugString("veh check")
									if getElementHealth(rs) > 1 then
								--		outputDebugString("hp check")
										if getElementHealth(veh) > 250 then
											setElementModel(veh,newid)
								---			outputDebugString("new car")
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
	end
end

function setElementFrozenDelayed(plr, bool)
	if (isElement(plr)) then
		toggleAllControls(plr, true)
		setElementFrozen(plr, bool)
		setElementData(plr,"mini-game","Shooter")
	end
end

function onShooterWasted()
	if getElementDimension(source) ~= 5000 then
		onForceShooter(source)
	else
		shooterFailed(source)
	end
end


function onShooterQuit()
	if (not ShooterPlayer[source]) then
		return
	end
	for index, player in pairs(ShooterPlayers) do
		if (source == player) then
			table.remove(ShooterPlayers, index)
			break
		end
	end
	if (ShooterStarted) then
		sendToShooterPlayers(getPlayerName(source).." is out!", 0,255,0)
		if (#ShooterPlayers == 1) then
			enShooterD(ShooterPlayers[1])
		end
	else
		if (#ShooterPlayers < ShooterMinPlayers and isTimer(ShooterstartingTimer)) then
			killTimer(ShooterstartingTimer)
		end
	end
end


function onLogin2()
	if (getElementDimension(source) == ShooterDimension) then
		setElementDimension(source, 0)
	end
end
addEventHandler("onPlayerLogin", root, onLogin2)

function enShooterD(player)
	if (isElement(player)) then
		ShooterPlayer[player] = nil
		outputChatBox("(Mini-Game) Shooter : You won the Shooter Event! You got $"..moneyEarn.." +2 scores| +2 XP", player, 0, 255, 0)
		givePlayerMoney(player,moneyEarn)
		exports.AURlevels:givePlayerXP(player,2)
		exports.CSGscore:givePlayerScore(player,2)
		removeEventHandler("onPlayerWasted", player, onShooterWasted)
		removeEventHandler("onPlayerQuit", player, onShooterQuit)
		addEventMsg(nil,getPlayerName(player).." has won the Shooter Event!",root, 0,255,0)
		outputChatBox("(Mini-Game [Shooter]) : "..getPlayerName(player).." has won the Event!",root, 0,255,0)
		setElementData(player,"mini-game",false)
		setTimer(function(p)
			killPed(p)
		end,2000,1,player)
	else
		for index, player in pairs(ShooterPlayers) do
			ShooterPlayer[player] = nil
			addEventMsg(nil,"(Mini-Game) Shooter : Event has ended!! You lost dude!!", player, 255, 0, 0)
			removeEventHandler("onPlayerWasted", player, onShooterWasted)
			removeEventHandler("onPlayerQuit", player, onShooterQuit)
			killPed(player)
		end
		for index, player in pairs(ShooterEliminatedPlayers) do
			addEventMsg(nil,"(Mini-Game) Shooter : Event has ended!! You lost dude!!", player, 255, 0, 0)
			addEventMsg(nil,"(Mini-Game) Shooter : None won in this Event!!", player, 255, 0, 0)
		end
	end
	ShooterPlayers = {}
	ShooterEliminatedPlayers = {}
	ShooterPlayer = {}
	ShooterStarted = false
	if (isTimer(ShooterTimer)) then
		killTimer(ShooterTimer)
	end
	ShooterTimer = nil
	if isTimer(proTimer2) then killTimer(proTimer2) end
	stopEvent("Shooter")
	startEvent("DD")
	removeEventHandler("onVehicleStartExit", resourceRoot, stopExit23)
	for index, vehicle in pairs(getElementsByType("vehicle", resourceRoot)) do
		if ShooterVehDrivers[vehicle] then
			Shootervehicles[ShooterVehDrivers[vehicle]] = nil
			ShooterVehDrivers[vehicle] = nil
		end
		destroyElement(vehicle)
	end
	for k,v in ipairs(Shooterpickups) do
		if isElement(v) then destroyElement(v) end
	end
	Shootervehicles = {}
	ShooterVehDrivers = {}
end

function stopExit23(player)
	if (ShooterStarted and ShooterPlayer[player]) then
		cancelEvent()
	end
end

function shooterFailed(plr)
	if (not ShooterPlayer[plr]) then
		return
	end
	ShooterPlayer[plr] = nil
	table.insert(ShooterEliminatedPlayers, plr)
	removeEventHandler("onPlayerWasted", plr, onShooterWasted)
	removeEventHandler("onPlayerQuit", plr, onShooterQuit)
	sendToShooterPlayers(getPlayerName(plr).." is out!", 0,255,0)
	for index, player in pairs(ShooterPlayers) do
		if (plr == player) then
			table.remove(ShooterPlayers, index)
			break
		end
	end
	if (#ShooterPlayers == 1) then
		enShooterD(ShooterPlayers[1])
	elseif (#ShooterPlayers == 0) then
		enShooterD(nil)
	end
	killPed(plr)
	setElementData(plr,"mini-game",false)
end

