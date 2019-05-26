c = dbConnect("sqlite", "cases.db")
dbExec(c, "CREATE TABLE IF NOT EXISTS cases(accName TEXT, num INT)")
antiSpam = {}
prize = {
	{25000, "money", 100},
	{100000, "money", 90},
	{100, "drug", 100},
	{50, "drug", 90},
	{10, "vip", 100},
	{25, "vip", 90},
	{3, "score", 100},
	{10, "score", 50},
}

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function getCase(player)
	local accName = exports.server:getPlayerAccountName(player)
	local q = dbPoll(dbQuery(c, "SELECT * FROM cases WHERE accName=?", accName), -1)
	if (#q == 0) then
		dbExec(c, "INSERT INTO cases(accName, num) VALUES(?,?)", accName, 0)
		return 0
	else
		return q[1].num
	end
end

function giveCase(player, case)
	local cases = getCase(player)
	local accName = exports.server:getPlayerAccountName(player)
	return dbExec(c, "UPDATE cases SET num=? WHERE accName=?", cases+case, accName)
end

function openWindow(p)
	if (antiSpam[p]) then
		return false
	end
	if (not exports.server:isPlayerLoggedIn(p)) then
		return false
	end
	triggerClientEvent(p, "AURcases.t", p, getCase(p))
end
addCommandHandler("cases", openWindow)

function openPrize()
	if (antiSpam[client]) then
		return false 
	end
	local isLagging = exports.NGCmanagement:isPlayerLagging(client)
	--if (isLagging) then
		--outputChatBox("You are lagging, you cannot open cases", client, 255, 0, 0)
		--return false
	--end
	local cases = getCase(client)
	if (cases == 0 or cases < 0) then
		outputChatBox("Get cases first", client, 255, 0, 0)
		return false 
	end
	giveCase(client, -1)
	openWindow(client)
	antiSpam[client] = true
	local choice = math.random(1,4)
	local number = math.random(1,100)
	if (choice == 1) then
		-- money
		local currentPrize = 0
		for i, v in ipairs(prize) do
			if (v[2] == "money") then
				if (v[3] > number and v[1] > currentPrize) then
					currentPrize = v[1]
				end
			end
		end
		outputChatBox("You have won $"..convertNumber(currentPrize).." by opening the case!", client, 0, 255, 0)
		exports.AURpayments:addMoney(client, currentPrize, "Custom", "Aurora Cases", 0, "AURcases")
	elseif (choice == 2) then
		local currentPrize = 0
		for i, v in ipairs(prize) do
			if (v[2] == "drug") then
				if (v[3] > number and v[1] > currentPrize) then
					currentPrize = v[1]
				end
			end
		end
		exports.csgdrugs:giveDrug(client, "LSD", currentPrize)
		exports.csgdrugs:giveDrug(client, "Cocaine", currentPrize)
		exports.csgdrugs:giveDrug(client, "Heroine", currentPrize)
		exports.csgdrugs:giveDrug(client, "Ritalin", currentPrize)
		exports.csgdrugs:giveDrug(client, "Ecstasy", currentPrize)
		exports.csgdrugs:giveDrug(client, "Weed", currentPrize)
		outputChatBox("You have won "..convertNumber(currentPrize).." drugs by opening the case!", client, 0, 255, 0)	
	elseif (choice == 3) then
		local currentPrize = 0
		for i, v in ipairs(prize) do
			if (v[2] == "vip") then
				if (v[3] > number and v[1] > currentPrize) then
					currentPrize = v[1]
				end
			end
		end
		outputChatBox("You have won "..convertNumber(currentPrize).." VIP hours by opening the case!", client, 0, 255, 0)		
		exports.AURvip:givePlayerVIP(client, currentPrize*60)
	elseif (choice == 4) then
		local currentPrize = 0
		for i, v in ipairs(prize) do
			if (v[2] == "score") then
				if (v[3] > number and v[1] > currentPrize) then
					currentPrize = v[1]
				end
			end
		end
		outputChatBox("You have won "..convertNumber(currentPrize).." score by opening the case!", client, 0, 255, 0)			
		exports.CSGscore:givePlayerScore(client, currentPrize)
	end
	antiSpam[client] = false
end
addEvent("AURcases.openPrize", true)
addEventHandler('AURcases.openPrize', resourceRoot, openPrize)