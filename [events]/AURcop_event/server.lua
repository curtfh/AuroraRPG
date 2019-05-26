local spawnPoints = {
{424.49624633789, -2790.0776367188, 113.67250823975},
{414.73043823242, -2808.7915039063, 113.26518249512},
{405.31188964844, -2792.2673339844, 113.52907562256},
{406.06390380859, -2737.8444824219, 113.2389755249},
{503.37762451172, -2812.2399902344, 113.67250823975},
{498.67025756836, -2885.4233398438, 107.06688690186},
{443.13259887695, -2917.3439941406, 116.29847717285},
{363.92489624023, -2916.7307128906, 111.24730682373},
{257.28134155273, -3019.2282714844, 56.066848754883},
{404.63500976563, -3038.3503417969, 85.170288085938},
{499.46493530273, -2938.0361328125, 102.92079925537},
{555.50634765625, -2885.3637695313, 101.54344177246},
{271.10809326172, -2651.0651855469, 90.808517456055},
{400.01739501953, -2857.7287597656, 96.620727539063},
}
local copPlayers = {}
local timeToAcceptPlayers = 43200000 -- 12 Hours
local timeToEnd = 600000 -- 10 mnutes
local requiredPlayers = 0
local bots = {}
local totalKillsAll = 0
local totalDeaths = 0
local price = 500000 --500k winer price
local winner
local resumeTimer = 0
local botSpawns = {
	--X Y Z
	{429.73977661133, -2803.2922363281, 112.04668426514},
	{480.07678222656, -2812.6525878906, 113.79902648926},
	{484.07559204102, -2915.1413574219, 102.8443145752},
	{414.97174072266, -2929.75390625, 114.03267669678},
	{346.44219970703, -2952.1396484375, 95.601364135742},
	{343.98086547852, -3018.9104003906, 88.353698730469},
	{255.9009552002, -2996.0881347656, 59.762699127197},
	{341.58190917969, -2789.1948242188, 113.85771179199},
	{404.39709472656, -2728.083984375, 113.67250823975},
	{463.64868164063, -2691.3918457031, 96.279014587402},
	{404.16040039063, -2850.697265625, 99.585678100586},
	{418.71969604492, -2897.4990234375, 113.61631774902},
	{338.5729675293, -2844.5354003906, 114.32946777344},
	{318.2370300293, -2781.3989257813, 114.24303436279},
	{325.26354980469, -2776.2053222656, 114.90266418457},
	{528.70483398438, -2886.7358398438, 108.0729675293},
	{374.3190612793, -2823.4912109375, 104.27262878418},
	{453.90270996094, -2873.0354003906, 101.619140625},
	{518.10864257813, -2847.7224121094, 111.67549133301},
	{281.55322265625, -2650.3154296875, 93.537773132324},
	{323.02154541016, -2751.3056640625, 110.92115020752},
	{321.04168701172, -2769.3444824219, 114.24745941162},
	{329.23342895508, -2808.6198730469, 114.8829498291},
	{337.25048828125, -2844.4865722656, 114.39813995361},
	{328.1923828125, -2902.6262207031, 109.50724029541},
	{420.87524414063, -2882.8002929688, 109.03322601318},
	{435.42233276367, -2829.9560546875, 106.79530334473},
	{369.29412841797, -2799.13671875, 112.95025634766},
	{307.34948730469, -2815.8227539063, 116.99192810059},
	{531.21783447266, -2908.2956542969, 111.93216705322},
	{453.74594116211, -2909.5109863281, 114.1929397583},
	{429.73977661133, -2803.2922363281, 112.04668426514},
	{480.07678222656, -2812.6525878906, 113.79902648926},
	{484.07559204102, -2915.1413574219, 102.8443145752},
	{414.97174072266, -2929.75390625, 114.03267669678},
	
}
local isEventStarted = false
local isEventRegistration = false
local signUpStop = false
local theRegTimer
local theEventTimer
local WeaponIDDisabled = {
	[18] = true,
	[39] = true,
	[17] = true,
	[16] = true,
	[38] = true,
	[37] = true,
	[36] = true,
	[35] = true,
}

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function formatTime(miliSeconds)
	if miliSeconds >= 60000 then
		local plural = ''
			if math.floor((miliSeconds/1000)/60) >= 2 then
				plural = 's'
			end	
		return tostring(math.floor((miliSeconds/1000)/60) .. " minute" .. plural)
	else
		local plural = ''
		if math.floor((miliSeconds/1000)) >= 2 then
			plural = 's'
		end	
		return tostring(math.floor((miliSeconds/1000)) .. " second" .. plural)
	end
end

function startRegistration ()
	if (isEventRegistration == true) then return end
	if (isEventStarted == true) then return end
	
	requiredPlayers = round(getPlayerCount()/2)
	--requiredPlayers = 1
	if (getPlayerCount() <= 5) then 
		for index, players in pairs(getElementsByType("player")) do
			exports.NGCdxmsg:createNewDxMessage(players, "Cannot start cop event due to the lack of players online.", 255, 0, 0)
		end 
		return
	end 
	if (isTimer(theRegTimer)) then killTimer(theRegTimer) end
	for index, players in pairs(getElementsByType("player")) do
		exports.NGCdxmsg:createNewDxMessage(players, "The cop event now accepts new registration type /copevent to signup. The event needs "..requiredPlayers.." players.", 66, 134, 244)
		exports.NGCdxmsg:createNewDxMessage(players, "$"..price.." is the win price for cop event.", 66, 134, 244)
		outputChatBox("The cop event now accepts new registration type /copevent to signup. The event needs "..requiredPlayers.." players.", players, 66, 134, 244)
		outputChatBox("$"..price.." is the win price for cop event.", players, 66, 134, 244)
		isEventRegistration = true
	end 
		isEventRegistration = true
end 
theRegTimer = setTimer(startRegistration, timeToAcceptPlayers, 1)

function registerPlayerToEvent (player, command, leave)
	if (not exports.server:isPlayerLoggedIn(player)) then return end
	if (isEventRegistration == false) then 
		exports.NGCdxmsg:createNewDxMessage(player, "The registration is not yet started.", 255, 0, 0)
		return
	end
	if (isEventStarted == true) then 
		exports.NGCdxmsg:createNewDxMessage(player, "The event has already started.", 255, 0, 0)
		return 
	end 
	if (signUpStop == true) then 
		exports.NGCdxmsg:createNewDxMessage(player, "The registration is full.", 255, 0, 0)
		return
	end
	if (not isPedOnGround(player)) then
		exports.NGCdxmsg:createNewDxMessage(player, "You must be on the ground to able to signup for this event.", 255, 0, 0)
		return
	end
	if (getTeamName(getPlayerTeam(player)) == "Government" or getTeamName(getPlayerTeam(player)) == "SWAT Team" or getTeamName(getPlayerTeam(player)) == "Military Forces") then 
	
		if (leave == "leave") then 
			for i=1, #copPlayers do
			if copPlayers[i] == player then 
				table.remove(copPlayers, i)
				exports.NGCdxmsg:createNewDxMessage(copPlayers[i], getPlayerName(player).." has left the event. "..#copPlayers.."/"..requiredPlayers, 255, 0, 0)
				exports.NGCdxmsg:createNewDxMessage(player, "You left the event.", 255, 0, 0)
				return
			end 
		end 
		
		return
		end 
	
		for i=1, #copPlayers do
			if copPlayers[i] == player then 
				exports.NGCdxmsg:createNewDxMessage(player, "You are already in the event.", 255, 0, 0)
				return
			end 
		end 
		if (requiredPlayers >= #copPlayers) then 
			exports.NGCdxmsg:createNewDxMessage(player, "You signed up for this event. You can leave this event by typing /copevent leave.", 0, 255, 0)
			table.insert(copPlayers, player)
			for i=1, #copPlayers do
				exports.NGCdxmsg:createNewDxMessage(copPlayers[i], getPlayerName(player).." has joined the event. "..#copPlayers.."/"..requiredPlayers, 0, 255, 0)
			end 
			if (requiredPlayers == #copPlayers) then
				for i=1, #copPlayers do
					exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "The event will start in 5 seconds. Be ready for the teleport. Also exit to your vehicle or it will be destroied.", 0, 255, 0)
				end
				signUpStop = true
				setTimer(warpAllPlayersAndStart, 5000, 1)
			end
			return 
		end
		
	else 
		exports.NGCdxmsg:createNewDxMessage(player, "You must be a law enforcer to able to signup for this event.", 255, 0, 0)
	end 
end
addCommandHandler("copevent", registerPlayerToEvent)

function warpAllPlayersAndStart ()
	if (isEventRegistration == false) then return false end
	if (isEventStarted == true) then return false end
	isEventStarted = true
	for i=1, #botSpawns do 
		setTimer(function()
			local theBot = spawnBot(botSpawns[i][1], botSpawns[i][2], botSpawns[i][3], 0, math.random(1, 220), 0, 2000, getTeamFromName("Staff"), math.random(26,34), "waiting")
			setBotAttackEnabled(theBot, false)
			table.insert(bots, theBot)
		end, math.random(1000,5000), 1)
	end 
	
	for i=1, #copPlayers do
		exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "You will be teleported to the event now.", 0, 255, 0)
		local theVehicle = getPedOccupiedVehicle (copPlayers[i])
		if (theVehicle) then 
			exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Your vehicle has been destroied.", 255, 0, 0)
			destroyElement(theVehicle)
		end 
		local x, y, z = getElementPosition(copPlayers[i])
		setElementData(copPlayers[i], "aurcopevent.lastLocationX", x)
		setElementData(copPlayers[i], "aurcopevent.lastLocationY", y)
		setElementData(copPlayers[i], "aurcopevent.lastLocationZ", z)
		fadeCamera (copPlayers[i], false)
		local randomPick = math.random(#spawnPoints)
		setElementPosition(copPlayers[i], spawnPoints[randomPick][1], spawnPoints[randomPick][2], spawnPoints[randomPick][3])
		setElementDimension(copPlayers[i], 2000)
		setElementHealth(copPlayers[i], 200)
		setPedArmor(copPlayers[i], 100)
		setElementFrozen(copPlayers[i], true)
		setElementData(copPlayers[i], "aurcopevent.kills", 0)
		exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Purpose Event: Kill all bots as possible as you can.", 255, 0, 0)
		toggleControl(copPlayers[i], "fire", false)
	end
		setTimer(function()
			for i=1, #copPlayers do
				exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Event will start in 3", 255, 0, 0)
			end 
		end, 1000, 1)
		setTimer(function()
			for i=1, #copPlayers do
				exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Event will start in 2", 255, 0, 0)
			end
		end, 2000, 1)
		setTimer(function()
			for i=1, #copPlayers do
				exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Event will start in 1", 255, 0, 0)
			end
		end, 3000, 1)
		setTimer(function()
			for i=1, #copPlayers do
				exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Go!", 0, 255, 0)
				exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Purpose Event: Kill all bots as possible as you can. Timer: 10 minutes left.", 255, 0, 0)
				setElementFrozen(copPlayers[i], false)
				toggleControl(copPlayers[i], "fire", true)
				fadeCamera (copPlayers[i], true)
				exports.AURachievements:givePlayerAward(copPlayers[i], 22)
				for z=1, #bots do 
					setBotAttackEnabled(bots[z], true)
					setBotHunt (bots[z])
				end 
			end
			theEventTimer = setTimer (eventOver, timeToEnd, 1)
		end, 4000, 1)
end 

function getTimeEvent(player)
	if (isTimer(theRegTimer)) then 
		local theRegTimer, executeLeft, executeTotal = getTimerDetails (theRegTimer) 
		local theRegTimer = formatTime(theRegTimer)
		exports.NGCdxmsg:createNewDxMessage(player,  tostring(theRegTimer).." left before the cop event registration starts.", 255, 255, 255)
	elseif (isEventStarted == true and isTimer(theEventTimer)) then
		local theEventTimer, executeLeft, executeTotal = getTimerDetails (theEventTimer) 
		local theEventTimer = formatTime(theEventTimer)
		exports.NGCdxmsg:createNewDxMessage(player, "The event is already started. "..tostring(theEventTimer).." left.", 255, 255, 255)
	elseif (isEventRegistration == true) then
		exports.NGCdxmsg:createNewDxMessage(player, "The event is on registration. Type /copevent", 255, 255, 255)
	else 
		exports.NGCdxmsg:createNewDxMessage(player, "There's an error on the event. Please try again later.", 255, 255, 255)
	end
end
addCommandHandler ("coptime", getTimeEvent)

function adminEvent(player, command, choice, gg)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return end
	if (choice == "pause") then 
		if (isEventRegistration == false) then return false end
		if (isEventStarted == false) then return false end
		if (isTimer(theEventTimer)) then 
				outputChatBox("ADMIN EVENT CONTROL: The event has been paused.", player, 255, 255, 255)
				eventPause()
			else
				outputChatBox("ADMIN EVENT CONTROL: The event has already been paused.", player, 255, 255, 255)
		end
	elseif (choice == "resume") then 
		if (isEventRegistration == false) then return false end
		if (isEventStarted == false) then return false end
		if (isTimer(theEventTimer)) then 
				outputChatBox("ADMIN EVENT CONTROL: The event has already been resume.", player, 255, 255, 255)
			else
				outputChatBox("ADMIN EVENT CONTROL: The event has been resume.", player, 255, 255, 255)
				eventResume()
		end
	elseif (choice == "forcestartreg") then 
		if (isEventRegistration == true) then return false end
		if (isEventStarted == true) then return false end
		startRegistration()
		outputChatBox("ADMIN EVENT CONTROL: The event now accepts registration.", player, 255, 255, 255)
	elseif (choice == "changeslot") then 
		
		requiredPlayers = math.floor(gg)
		outputChatBox("ADMIN EVENT CONTROL: Changed required slot to "..gg..".", player, 255, 255, 255)
		for index, players in pairs(getElementsByType("player")) do
			exports.NGCdxmsg:createNewDxMessage(player, "AUR Staff changed the player limit of cop event to "..gg, 255, 255, 255)
		end 
		
		elseif (choice == "stop") then 
		outputChatBox("ADMIN EVENT CONTROL: Forced event over.", player, 255, 255, 255)
		
		eventOver()
	end 
end
addCommandHandler("adminevent", adminEvent)

function eventPause()
	if (isEventRegistration == false) then return false end
	if (isEventStarted == false) then return false end
	local theTableKills = {}
	for i=1, #bots do
		setBotWait (bots[i])
		setBotAttackEnabled(bots[i], false)
	end 
	
	for i=1, #copPlayers do
		exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "The event has been paused by AUR Staff.", 255, 255, 255)
		setElementFrozen(copPlayers[i], true)
		toggleControl(copPlayers[i], "fire", false)
	end 
	
	local theRegTimer, executeLeft, executeTotal = getTimerDetails(theEventTimer) 
	resumeTimer = theRegTimer
	if (isTimer(theEventTimer)) then killTimer(theEventTimer) end
	
end

function eventResume()
	if (isEventRegistration == false) then return false end
	if (isEventStarted == false) then return false end
	local theTableKills = {}
	for i=1, #bots do
		setBotHunt (bots[i])
		setBotAttackEnabled(bots[i], true)
	end 
	
	for i=1, #copPlayers do
		exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "The event has been resumed by AUR Staff.", 255, 255, 255)
		setElementFrozen(copPlayers[i], false)
		toggleControl(copPlayers[i], "fire", true)
	end 
	
	theEventTimer = setTimer (eventOver, resumeTimer, 1)
end

function eventOver()
	if (isEventRegistration == false) then return false end
	if (isEventStarted == false) then return false end
	local theTableKills = {}
	for i=1, #bots do
		destroyElement(bots[i])
	end 
	
	for i=1, #copPlayers do
		local theVal = #theTableKills+1
		theTableKills[theVal] = {copPlayers[i], math.floor(getElementData(copPlayers[i], "aurcopevent.kills"))}
		exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "Times up! Please wait, the system will calculate the highest kills in the event.", 255, 0, 0)
		setElementFrozen(copPlayers[i], true)
		toggleControl(copPlayers[i], "fire", false)
		fadeCamera(copPlayers[i], false)

	end 
	
	local mkills, key = -math.huge 
	for i=1, #theTableKills do 
		if (theTableKills[i][2] > mkills) then 
			mkills, key = theTableKills[i][2], i 
		end
	end 
	
	setTimer(function()
		for index, players in pairs(getElementsByType("player")) do
			outputChatBox("Cop Event has been finish.", players, 255, 0, 0)
			outputChatBox("Total Kills: "..totalKillsAll, players, 255, 0, 0)
			outputChatBox("Total Deaths: "..totalDeaths, players, 255, 0, 0)
			outputChatBox("Winner: "..getPlayerName(theTableKills[key][1]).." with "..(mkills+1).." kills", players, 255, 0, 0)
		end 
		givePlayerMoney(theTableKills[key][1], price)
	end, 3000, 1)
	
	setTimer(function()
		for i=1, #copPlayers do
			exports.NGCdxmsg:createNewDxMessage(copPlayers[i], "You will be teleported to your last position.", 0, 255, 0)
			local x = getElementData(copPlayers[i], "aurcopevent.lastLocationX")
			local y = getElementData(copPlayers[i], "aurcopevent.lastLocationY")
			local z  = getElementData(copPlayers[i], "aurcopevent.lastLocationZ")
			setElementPosition(copPlayers[i], x, y, z)
			setElementDimension(copPlayers[i], 0)
			setElementFrozen(copPlayers[i], false)
			toggleControl(copPlayers[i], "fire", true)
			fadeCamera(copPlayers[i], true)
			toggleControl(copPlayers[i], "fire", true)
		end 
	end, 5000, 1)
	
	setTimer(function()
		copPlayers = {}
		requiredPlayers = 0
		bots = {}
		totalKillsAll = 0
		totalDeaths = 0
		resumeTimer = 0
		isEventStarted = false
		isEventRegistration = false
		signUpStop = false
		if (isTimer(theRegTimer)) then killTimer(theRegTimer) end
		if (isTimer(theEventTimer)) then killTimer(theEventTimer) end
		theRegTimer = setTimer(startRegistration, timeToAcceptPlayers, 1)
	end, 6000, 1)
end 

function forceDisqualifiedPlayer (player, reason)
	if (isEventRegistration == false) then return false end
	if (isEventStarted == false) then return false end
	for i=1, #copPlayers do
		if copPlayers[i] == player then 
			local x = getElementData(player, "aurcopevent.lastLocationX")
			local y = getElementData(player, "aurcopevent.lastLocationY")
			local z = getElementData(player, "aurcopevent.lastLocationZ")
			if (x ~= nil and y ~= nil and z ~= nil) then 
				setElementPosition(player, x, y, z)
			end
			exports.NGCdxmsg:createNewDxMessage(player, reason, 255, 0, 0)
			table.remove(copPlayers, i)
			return true
		end 
	end 
	return false
end 

function onPlayerChangedJob (jobName)
	if (isEventRegistration == true) then return end
	if (isEventStarted == true) then 
	
		if (getTeamName(getPlayerTeam(source)) ~= "Government" or getTeamName(getPlayerTeam(source)) ~= "SWAT Team" or getTeamName(getPlayerTeam(source)) ~= "Military Forces") then 
			for i=1, #copPlayers do
				if copPlayers[i] == source then 
					forceDisqualifiedPlayer(source, "You have been disqualified for changing your job.")
					return
				end 
			end 
		end 
	return
	end
	if (getTeamName(getPlayerTeam(source)) ~= "Government" or getTeamName(getPlayerTeam(source)) ~= "SWAT Team" or getTeamName(getPlayerTeam(source)) ~= "Military Forces") then 
		for i=1, #copPlayers do
			if copPlayers[i] == source then 
				table.remove(copPlayers, i)
				for z=1, #copPlayers do
					exports.NGCdxmsg:createNewDxMessage(copPlayers[z], getPlayerName(source).." has left the event. "..#copPlayers.."/"..requiredPlayers, 255, 0, 0)
				end 
				return
			end 
		end 
	end 
end 
addEvent ("onPlayerJobChange", true)
addEventHandler ("onPlayerJobChange", root, onPlayerChangedJob)

function onPlayerQuit ()
	if (isEventRegistration == false) then return end
	if (isEventStarted == false) then 
	
		if (getTeamName(getPlayerTeam(source)) ~= "Government" or getTeamName(getPlayerTeam(source)) ~= "SWAT Team" or getTeamName(getPlayerTeam(source)) ~= "Military Forces") then 
			for i=1, #copPlayers do
				if copPlayers[i] == source then 
					table.remove(copPlayers, i)
					for z=1, #copPlayers do
						exports.NGCdxmsg:createNewDxMessage(copPlayers[z], getPlayerName(source).." has left the event. "..#copPlayers.."/"..requiredPlayers, 255, 0, 0)
					end 
					return
				end 
			end 
		end 
	return
	end
end 
addEventHandler ("onPlayerQuit", getRootElement(), onPlayerQuit)

function onBotWasted(attacker, weapon)
	if (isEventRegistration == false) then return end
	if (isEventStarted == false) then return end 
	
	if (#bots == 1) then 
		eventOver()
	end 
	
	for i=1, #bots do 
		if (bots[i] == source) then 
			table.remove(bots, i)
			local kills = getElementData(attacker, "aurcopevent.kills")
			setElementData(attacker, "aurcopevent.kills", kills + 1)
			--outputChatBox("You killed the bot. You have "..(kills+1).." kill/s.", attacker, 255, 0, 0)
			exports.killmessages:outputMessage("You killed the bot. You have "..(kills+1).." kill/s.", attacker, 255, 0, 0)
			totalKillsAll = totalKillsAll + 1
			for g=1, #copPlayers do
				--outputChatBox(bots.." bot/s left. | Time Left: "..formatTime(theEventTimer), copPlayers[z], 255, 0, 0)
				exports.killmessages:outputMessage(#bots.." bot/s left. | Time Left: "..formatTime(theEventTimer), copPlayers[g], 255, 0, 0)
			end 
		end 
	end 
end 
addEvent("aurj.onBotWasted",true) 
addEventHandler("aurj.onBotWasted",getRootElement(), onBotWasted)

function onPlayerWasted ()
	if (isEventRegistration == false) then return end
	if (isEventStarted == false) then return end 
	
	if (#copPlayers == 1) then 
		for i=1, #copPlayers do
			if (copPlayers[i] == source) then 
			for index, players in pairs(getElementsByType("player")) do
				outputChatBox("Cop Event has been finish.", players, 255, 0, 0)
				outputChatBox("Total Kills: "..totalKillsAll, players, 255, 0, 0)
				outputChatBox("Total Deaths: "..totalDeaths, players, 255, 0, 0)
				outputChatBox("Winner: "..getPlayerName(source).." with "..(getElementData(source, "aurcopevent.kills")+1).." kills", players, 255, 0, 0)
				givePlayerMoney(source, price)
				setElementData(players, "aurcopevent.kills", 0)
			end 
			exports.NGCdxmsg:createNewDxMessage(source, "You won!", 0, 255, 0)
			copPlayers = {}
			requiredPlayers = 0
			bots = {}
			isEventStarted = false
			isEventRegistration = false
			signUpStop = false
			totalKillsAll = 0
			totalDeaths = 0
			resumeTimer = 0
			if (isTimer(theRegTimer)) then killTimer(theRegTimer) end
			if (isTimer(theEventTimer)) then killTimer(theEventTimer) end
			theRegTimer = setTimer(startRegistration, timeToAcceptPlayers, 1)
			return
			end 
		end 
	end 
	
	for i=1, #copPlayers do
		if (copPlayers[i] == source) then 
			table.remove(copPlayers, i)
			totalDeaths = totalDeaths + 1
			exports.NGCdxmsg:createNewDxMessage(source, "You died in the event.", 255, 0, 0)
			for z=1, #copPlayers do 
				--outputChatBox(getPlayerName(source).." died. | Time Left: "..formatTime(theEventTimer), copPlayers[z], 255, 0, 0)
				exports.killmessages:outputMessage(getPlayerName(source).." died. | Time Left: "..formatTime(theEventTimer), copPlayers[z], 255, 0, 0)
			end
		end 
	end 
end
addEventHandler ("onPlayerWasted", getRootElement(), onPlayerWasted)

addEventHandler( "onPlayerWeaponSwitch", root, function (previousWeaponID,currentWeaponID)
	if (getElementDimension(source) == 2000) then 
		if ( WeaponIDDisabled[currentWeaponID] ) then
			toggleControl ( source, 'fire', false ) 
		else
			toggleControl ( source, 'fire', true )
		end
			
		end
end)

