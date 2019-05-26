local rewards = {
        {["cash"]=10000}, -- Week 1
        {["cash"]=10000,["drugs"]=5},
        {["cash"]=10000,["drugs"]=10},
        {["cash"]=10000,["drugs"]=15},
        {["cash"]=10000,["drugs"]=20},
        {["cash"]=10000,["drugs"]=25},
        {["cash"]=10000,["drugs"]=30},
        {["cash"]=20000,["drugs"]=5}, -- Week 2
        {["cash"]=20000,["drugs"]=10},
        {["cash"]=20000,["drugs"]=15},
        {["cash"]=20000,["drugs"]=20},
        {["cash"]=20000,["drugs"]=25},
        {["cash"]=20000,["drugs"]=30},
        {["cash"]=20000,["drugs"]=35},
        {["cash"]=30000,["drugs"]=5}, -- Week 3
        {["cash"]=30000,["drugs"]=10},
        {["cash"]=30000,["drugs"]=15},
        {["cash"]=30000,["drugs"]=20},
        {["cash"]=30000,["drugs"]=25},
        {["cash"]=30000,["drugs"]=30},
        {["cash"]=30000,["drugs"]=35},
        {["cash"]=40000,["drugs"]=5}, -- Week 4
        {["cash"]=40000,["drugs"]=10},
        {["cash"]=40000,["drugs"]=15},
        {["cash"]=40000,["drugs"]=20},
        {["cash"]=40000,["drugs"]=25},
        {["cash"]=40000,["drugs"]=30},
        {["cash"]=40000,["drugs"]=35},
        {["cash"]=40000,["drugs"]=35}, -- Week 5
}
local todaysLoggedIn = {}
local timers = {}

function refreshTables ()
	local file = fileOpen("tables.json")
	todaysLoggedIn = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file) 
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), refreshTables)

function onStopRs()
	local file = fileOpen("tables.json")
	fileWrite(file, toJSON(todaysLoggedIn))
	fileClose(file)
end 
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStopRs)

function triggerCommand (thePlayer, theCmd)
	if (not isElement(thePlayer)) then return end 
	if (not exports.server:isPlayerLoggedIn(thePlayer)) then return end 
	
	local id = exports.server:getPlayerAccountID(thePlayer)
	local loggedInToday = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "loggedInToday")
	local daysLoggedIn = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "daysLoggedIn")
	
	if (not todaysLoggedIn[id]) then 
		outputChatBox("Error: You have to reach 1 hour of playtime on this day to claim your reward.", thePlayer, 255, 0, 0)
		return
	end 
	
	if (daysLoggedIn <= #rewards) then 
		exports.AURcurtmisc:setPlayerAccountData(thePlayer, "daysLoggedIn", 1)
	end 
	
	if (loggedInToday == 2) then 
		outputChatBox("Error: You already claimed your daily award!", thePlayer, 255, 0, 0)
		return
	elseif (loggedInToday == 1) then 
		exports.AURcurtmisc:setPlayerAccountData(thePlayer, "loggedInToday", 2)
		exports.AURcurtmisc:setPlayerAccountData(thePlayer, "daysLoggedIn", daysLoggedIn + 1)
		outputChatBox("Success: You claimed your "..daysLoggedIn.." daily award!", thePlayer, 0, 255, 0)
		if (rewards[daysLoggedIn]["cash"]) then 
			exports.AURpayments:addMoney(thePlayer, rewards[daysLoggedIn]["cash"], "Custom", "Daily Rewards", 0, "AURdailyrewards")
			outputChatBox("+"..rewards[daysLoggedIn]["cash"].." cash.", thePlayer, 0, 255, 0)
		end 
		if (rewards[daysLoggedIn]["drugs"]) then 
			exports.csgdrugs:giveDrug(thePlayer, "LSD",rewards[daysLoggedIn]["drugs"])
			exports.csgdrugs:giveDrug(thePlayer, "Cocaine",rewards[daysLoggedIn]["drugs"])
			exports.csgdrugs:giveDrug(thePlayer, "Heroine",rewards[daysLoggedIn]["drugs"])
			exports.csgdrugs:giveDrug(thePlayer, "Ritalin",rewards[daysLoggedIn]["drugs"])
			exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",rewards[daysLoggedIn]["drugs"])
			exports.csgdrugs:giveDrug(thePlayer, "Weed",rewards[daysLoggedIn]["drugs"])
			outputChatBox("+"..rewards[daysLoggedIn]["drugs"].." each drugs.", thePlayer, 0, 255, 0)
		end 		
		return
	end 
	outputChatBox("Error: You have to reach 1 hour of playtime on this day to claim your reward.", thePlayer, 255, 0, 0)
end 
addCommandHandler("rewards", triggerCommand)

function perHourTimer ()
	todaysLoggedIn = {}
end 
setTimer(perHourTimer, 86400000, 0)

function onResourceStar ()
	if (not exports.server:isPlayerLoggedIn(source)) then return end 
		local id = exports.server:getPlayerAccountID(source)
		local loggedInToday = exports.AURcurtmisc:getPlayerAccountData(source, "loggedInToday")
		if (not todaysLoggedIn[id]) then 
			exports.AURcurtmisc:setPlayerAccountData(source, "loggedInToday", 0)
			return
		end 
		if (loggedInToday == 0) then 
			if (isTimer(timers[id])) then 
				killTimer(timers[id])
			end 
			timers[id] = setTimer(function(thePlayer)
				if (isElement(thePlayer)) then
					local loggedInToday = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "loggedInToday")
					if (loggedInToday == 0) then 
						exports.AURcurtmisc:setPlayerAccountData(thePlayer, "loggedInToday", 1)
						todaysLoggedIn[id] = true
					end 
				end 
			end, 3600000, 1, source)
		end 
end 

function onLoggedIn()
	if (not exports.server:isPlayerLoggedIn(source)) then return end 
	local id = exports.server:getPlayerAccountID(source)
	local loggedInToday = exports.AURcurtmisc:getPlayerAccountData(source, "loggedInToday")
	if (not todaysLoggedIn[id]) then 
		exports.AURcurtmisc:setPlayerAccountData(source, "loggedInToday", 0)
		return
	end 
	if (loggedInToday == 0) then 
		if (isTimer(timers[id])) then 
			killTimer(timers[id])
		end 
		timers[id] = setTimer(function(thePlayer)
			if (isElement(thePlayer)) then
				local loggedInToday = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "loggedInToday")
				if (loggedInToday == 0) then 
					exports.AURcurtmisc:setPlayerAccountData(thePlayer, "loggedInToday", 1)
					todaysLoggedIn[id] = true
				end 
			end 
		end, 3600000, 1, source)
	end 
end 
addEventHandler("onServerPlayerLogin", root, onLoggedIn)

function onPlayerLeft()
	if (not exports.server:isPlayerLoggedIn(source)) then return end 
	local id = exports.server:getPlayerAccountID(source)
	local loggedInToday = exports.AURcurtmisc:getPlayerAccountData(source, "loggedInToday")
	if (not todaysLoggedIn[id]) then 
		exports.AURcurtmisc:setPlayerAccountData(source, "loggedInToday", 0)
		return
	end 
	
	if (loggedInToday == 0) then 
		if (isTimer(timers[id])) then 
			killTimer(timers[id])
		end 
	end 
end 
addEventHandler ("onPlayerQuit", getRootElement(), onPlayerLeft)