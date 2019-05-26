local signedup = {}
local player_count = {}
local spawnPos = {}
local fcfs = {}
local rally_vehicles = {}
local prevTeam = {}

local spawnData = {
	[1] = {3787.8029785156, -1534.2375488281, 17.431833267212};
	[2] = {3790.7756347656, -1537.1217041016, 17.449741363525};
	[3] = {3796.310546875, -1528.8732910156, 17.203287124634};
	[4] = {3800.6186523438, -1522.4583740234, 17.013427734375};
	[5] = {3793.3479003906, -1526.3602294922, 17.185581207275};
}

local plrs = {}

function enableRaceMisc()
	count = 0
	plrs = 0
	event_nil = true
end
addEventHandler("onResourceStart", root, enableRaceMisc)

function sign_up(player)
	if (not signedup[player] or signedup[player] == nil or signedup[player] == false) then
		if (count >= 5) then outputChatBox("There is an ongoing event at this moment, please try again later.", player, 255, 0, 0) return end
		if (isPedInVehicle(player)) then outputChatBox("You cannot sign up whilst in a vehicle", player, 255, 0, 0) return end
		if (getPlayerWantedLevel(player) >= 1) then outputChatBox("You cannot sign up whilst you're wanted!", player, 255, 0, 0) return end
		--if (getPlayerAccount(player))then if(isGuestAccount(getPlayerAccount(player)))then return end return end
		signedup[player] = true
		player_count[count] = {}
		count = count + 1
		plrs = plrs + 1
		fcfs[player] = plrs
		prevTeam[player] = getPlayerTeam(player)
		setPlayerTeam(player, getTeamFromName("Rally"))
		--outputChatBox(count)
		triggerClientEvent(root, "NGCrally.update_charts", root, count, getPlayerName(player))
		outputChatBox("You have successfully registered for the rally, please wait for other players!", player, 0, 255, 0)
	else
		outputChatBox("You have already been registered for this rally, please wait till it starts!", player, 255, 0, 0)
	end
end
addEvent("NGCrally.sign_up", true)
addEventHandler("NGCrally.sign_up", root, sign_up)

function quit_event(player, string)
	if (player and isElement(player) and getElementType(player) == "player") then
		if (string == "1") then
			if (not signedup[player]) then return end
			signedup[player] = nil
			fcfs[player] = nil
			if isElement(rally_vehicles[player]) then
				destroyElement(rally_vehicles[player])
			end
			plrs = 0
			fcfs[player] = plrs
			count = 0
			player_count[count] = {}
			end_global_event()
			event_nil = true
			allPlayersWarped = false
			--outputChatBox("Element data removed")
		elseif (string == "2") then
			if event_nil == true then outputChatBox("There was no event lol") return end
			if isElement(rally_vehicles[player]) then
				destroyElement(rally_vehicles[player])
			end
			for index, root_ in pairs(getPlayersInTeam(getTeamFromName("Rally"))) do
				plrs = 0
				fcfs[root_] = plrs
				count = 0
				signedup[root_] = nil
				setPlayerTeam(root_, prevTeam[root_])
				end_global_event()
				event_nil = true
				allPlayersWarped = false
				player_count[count] = {}
				if isElement(rally_vehicles[root_]) then
					destroyElement(rally_vehicles[root_])
				end
			end
			outputChatBox("The event is now over, and the winner is "..getPlayerName(player).."!", root, 255, 255, 0)
		else
			--outputChatBox("unknown string element")
		end
	end
end
addEvent("AURrally.quit_event", true)
addEventHandler("AURrally.quit_event", root, quit_event)
--addCommandHandler("removerace", quit_event)

addEventHandler("onPlayerWasted", getRootElement(),
	function()
		if signedup[source] then
			signedup[source] = nil
			outputChatBox("Player removed from event, due to death.")
			setPlayerTeam(root_, prevTeam[root_])
			if isElement(rally_vehicles[source]) then
				destroyElement(rally_vehicles[source])
			end
		end
	end
)

addEventHandler("onPlayerQuit", getRootElement(),
	function()
		if signedup[source] then
			signedup[source] = nil
			outputChatBox("Player removed from event, due to quit.")
			setPlayerTeam(root_, prevTeam[root_])
			if isElement(rally_vehicles[source]) then
				destroyElement(rally_vehicles[source])
			end
		end
	end
)

addEventHandler("onVehicleStartExit", getRootElement(),
	function(k)
		--for index, k in pairs(getElementsByType("player")) do
			if (fcfs[k] == 1 or fcfs[k] == 2 or fcfs[k] == 3 or fcfs[k] == 4 or fcfs[k] == 5) then
				cancelEvent()
				outputChatBox("event cancelled exit", k)
			end
		--end
	end
)

addEventHandler("onVehicleStartEnter", getRootElement(),
	function(k)
		--for index, k in pairs(getElementsByType("player")) do
			if (signedup[k] == true) then
				cancelEvent()
				--outputChatBox("event cancelled enter")
				outputChatBox("You cannot enter a vehicle whilst being signed up for the event!", k, 255, 0, 0)
			end
		--end
	end
)

function init_rally_trigger()
	for k, v in pairs(player_count) do
		curr_count = count
	end
	if (curr_count and curr_count == 2 and event_nil == true) then
		if (not allPlayersWarped == true) then
			event_nil = false
			allPlayersWarped = true
			t = setTimer(init_rally_start, 10000, 1)
			if (isTimer(t_2)) then
				killTimer(t_2)
			end
			if (isTimer(t_4)) then
				killTimer(t_4)
			end
			outputChatBox("5 contestants have now registered, get ready for the rally race!", root, 255, 0, 0)
		end
	elseif (curr_count and curr_count == 4 and event_nil == true) then
		if (allPlayersWarped == false) then
			if (isTimer(t_2)) then
				killTimer(t_2)
			end
			t_3 = setTimer(init_rally_start, 5000, 1)
			--outputChatBox("Triggering init_rally_start because 4 players joined, destroyed timer 2 added timer 3")
		end
	elseif (curr_count and curr_count < 4 and curr_count >= 3 and event_nil == true) then
		if (not isTimer(t_4)) then
			t_4 = setTimer(init_rally_trig_lessplrs, 20000, 1)
			--outputChatBox("Triggering init_rally_trig_lessplrs because less than 4 players joined")
		end
	end
end
setTimer(init_rally_trigger, 2000, 0)

function init_rally_trig_lessplrs()
	for k, v in pairs(player_count) do
		current_count = count
	end
	if (current_count and current_count >= 3 and event_nil == true) then
		if (not allPlayersWarped == true) then
			event_nil = false
			t_2 = setTimer(init_rally_start, 5000, 1)
			--outputChatBox("Not enough players registered in time, current players will be warped!", root, 0, 255, 0)
			--outputChatBox("Triggering init_rally_start because 3 players joined, added timer 2")
		end
	end
end

function init_rally_start()
	for i, v in ipairs(getElementsByType("player")) do
		if (signedup[v] == true) then
			x1, y1, z1 = unpack(spawnData[1])
			x2, y2, z2 = unpack(spawnData[2])
			x3, y3, z3 = unpack(spawnData[3])
			x4, y4, z4 = unpack(spawnData[4])
			x5, y5, z5 = unpack(spawnData[5])
			if (fcfs[v] == 1) then
				--outputChatBox("init_rally_start_1")
				--setElementPosition(v, x1, y1, z1)
				rally_vehicles[v] = createVehicle(526, x1, y1, z1)
				setElementRotation(rally_vehicles[v], 0, 0, 148)
				warpPedIntoVehicle(v, rally_vehicles[v])
			end
			if (fcfs[v] == 2) then
				--outputChatBox("init_rally_start_2")
				--setElementPosition(v, x2, y2, z2)
				rally_vehicles[v] = createVehicle(526, x2, y2, z2)
				setElementRotation(rally_vehicles[v], 0, 0, 148)
				warpPedIntoVehicle(v, rally_vehicles[v])
			end
			if (fcfs[v] == 3) then
				--outputChatBox("init_rally_start_3")
				--setElementPosition(v, x3, y3, z3)
				rally_vehicles[v] = createVehicle(526, x3, y3, z3)
				setElementRotation(rally_vehicles[v], 0, 0, 148)
				warpPedIntoVehicle(v, rally_vehicles[v])
			end
			if (fcfs[v] == 4) then
				--outputChatBox("init_rally_start_4")
				--setElementPosition(v, x4, y4, z4)
				rally_vehicles[v] = createVehicle(526, x4, y4, z4)
				setElementRotation(rally_vehicles[v], 0, 0, 148)
				warpPedIntoVehicle(v, rally_vehicles[v])
			end
			if (fcfs[v] == 5) then
				--outputChatBox("init_rally_start_5")
				--setElementPosition(v, x5, y5, z5)
				rally_vehicles[v] = createVehicle(526, x5, y5, z5)
				--setElementPosition(rally_vehicles[v], x5, y5, z5)
				setElementRotation(rally_vehicles[v], 0, 0, 148)
				--warpPedIntoVehicle(v, rally_vehicles[v])
			end
			if (allPlayersWarped == true) then
				init_race_ctimer = setTimer(init_race_call, 1000, 1)
			end
		else
			--outputChatBox("init_rally_return_false")
		end
	end
end

-- Testing area

function getSortedTable(pos) 
	local sortedTable = {}
	local players = getPlayersInTeam(getTeamFromName("Rally"))
	for i=1, #players do
		--if (signedup[players]) then
			local playerName = getPlayerName(players[i])
			local poss = getElementData(players[i], "pos")
			table.insert(sortedTable,{['name'] = playerName,['value'] = tonumber(poss)})
		--end
	end
	table.sort(sortedTable, function(a, b) return a.value > b.value end )
	return sortedTable
end

function update_position(plr, pos)
	setElementData(plr, "pos", pos)
	local sortedPlayers = getSortedTable(pos)
	for i=1, #getPlayersInTeam(getTeamFromName("Rally")) do
		outputChatBox("Position: "..i.." - "..sortedPlayers[i].name.." - Checkpoint: "..sortedPlayers[i].value.." of 10", plr, 0, 255, 0)
	end
end
addEvent("AURrally.update_position", true)
addEventHandler("AURrally.update_position", root, update_position)


--addCommandHandler('show10', show10RichestPlayers)

-- Testing end

function init_race_call()
	for k, v in pairs(getElementsByType("player")) do
		if (signedup[v] == true) then
			triggerClientEvent(v, "NGCrally.init_starting", v)
			--triggerRaceCheckpoints(v)
			veh = getPedOccupiedVehicle(v)
			setElementFrozen(rally_vehicles[v], true)
			setTimer(function() setElementFrozen(rally_vehicles[v], false) end, 4000, 1)
		end
	end
end

function triggerRaceCheckpoints(plr)
	triggerClientEvent(plr, "AURrally.addRaceCheckpoints", plr)
end

function end_global_event()
	player_count[count] = nil
	player_count[count] = {}
	count = 0
	plrs = 0
	--outputChatBox("The event is now over", root, 255, 255, 0)
	triggerClientEvent(root, "NGCrally.destroy_elements", root)
end