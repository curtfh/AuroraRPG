local waitingAccounts = {}
local transactions = {}

function refreshTables ()
	local file1 = fileOpen("accounts.json")
	local file2 = fileOpen("transactions.json")
	waitingAccounts = fromJSON(fileRead(file1, fileGetSize(file1)))
	transactions = fromJSON(fileRead(file2, fileGetSize(file2)))
	fileClose(file1) 
	fileClose(file2) 
end 

function refreshDTable (player, cmd)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return end
	refreshTables()
	outputChatBox("Donation Queue Table Refreshed", player, 255, 255, 255)
	
	for index, playerz in pairs(getElementsByType("player")) do
		doTransation(playerz)
	end 
end 
addCommandHandler("refreshdtable", refreshDTable)

function getNumberData (player, cmd)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return end
	outputDebugString("Total of "..#transactions.." transactions and "..#waitingAccounts.." accounts on queue ")
end 
addCommandHandler("totaldonation", getNumberData)

function doTransation (player)
	local theAccount = exports.server:getPlayerAccountName (player)
	if (type(theAccount) == "string") then 
	
		for i=1, #waitingAccounts do 
			if (theAccount == waitingAccounts[i][1]) then 
				local thePlrAcc = waitingAccounts[i][1]
				local dataType = waitingAccounts[i][2]
				local value = waitingAccounts[i][3]
				
				if (dataType == "vip") then 
					givePlayerVIP(thePlrAcc, value)
					table.remove(waitingAccounts, i)
				elseif (dataType == "wife") then 
					givePlayerWife(thePlrAcc)
					table.remove(waitingAccounts, i)
				elseif (dataType == "cash") then 
					givePlayerCash(thePlrAcc, value)
					table.remove(waitingAccounts, i)
				elseif (dataType == "drugs") then 	
					givePlayerDrugs(thePlrAcc, value)
					table.remove(waitingAccounts, i)
				elseif (dataType == "soldierskin") then 
					givePlayerSoldierSkin(thePlrAcc)
					table.remove(waitingAccounts, i)
				end 
				
			end 
		end
		
		
		for i=1, #transactions do 
			if (theAccount == transactions[i][1]) then 
				local transid = transactions[i][2]
				local currency = transactions[i][3]
				local cost = transactions[i][4]
				local method = transactions[i][5]
				local item = transactions[i][6]

				outputToPlayer(transactions[i][1], "========TRANSACTION========")
				outputToPlayer(transactions[i][1], "Transaction Complete")
				outputToPlayer(transactions[i][1], "Transaction ID: "..transid)
				outputToPlayer(transactions[i][1], "Item: 1x "..item.." - "..cost.." "..currency)
				outputToPlayer(transactions[i][1], "Sub-Total: "..cost.." "..currency)
				outputToPlayer(transactions[i][1], "Total: "..cost.." "..currency)
				outputToPlayer(transactions[i][1], "Payment Method: "..method)
				outputToPlayer(transactions[i][1], "Thank you for purchasing. Have a good day!")
				outputToPlayer(transactions[i][1], "Any problems? Contact Curt or Frenky at Forums.")
				outputToPlayer(transactions[i][1], "Forum: forum.aurorarpg.com")
				outputToPlayer(transactions[i][1], "========TRANSACTION========")
				table.remove(transactions, i)
			end 
		end 
	end 
end 

function onStartRs()
	refreshTables()
	setTimer(function()
		for index, player in pairs(getElementsByType("player")) do
			doTransation(player)
		end 
		outputDebugString("Total of "..#transactions.." transactions and "..#waitingAccounts.." accounts on queue cached..")
	end, 3000, 1)
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStartRs)


function onStopRs()
	outputDebugString("Total of "..#transactions.." transactions and "..#waitingAccounts.." accounts on queue saved on local json file.")
	local file1 = fileOpen("accounts.json")
	local file2 = fileOpen("transactions.json")
	fileWrite(file1, toJSON(waitingAccounts))
	fileWrite(file2, toJSON(transactions))
	fileClose(file1)
	fileClose(file2)
end 
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStopRs)

addEventHandler( "onServerPlayerLogin", root,
function ()
	doTransation(source)
end)


function outputTransaction (accountname, transid, item, cost, currency, method)
	if (isPlayerOnline(accountname) == true) then 
		outputToPlayer(accountname, "========TRANSACTION========")
		outputToPlayer(accountname, "Transaction Complete")
		outputToPlayer(accountname, "Transaction ID: "..transid)
		outputToPlayer(accountname, "Item: 1x "..item.." - "..cost.." "..currency)
		outputToPlayer(accountname, "Sub-Total: "..cost.." "..currency)
		outputToPlayer(accountname, "Total: "..cost.." "..currency)
		outputToPlayer(accountname, "Payment Method: "..method)
		outputToPlayer(accountname, "Thank you for purchasing. Have a good day!")
		outputToPlayer(accountname, "Any problems? Contact Curt or Frenky at Forums.")
		outputToPlayer(accountname, "Forum: forum.aurorarpg.com")
		outputToPlayer(accountname, "========TRANSACTION========")
		return true
	else
		transactions[#transactions+1] = {accountname, transid, currency, cost, method, item}
		return true
	end 
end 


function getPlayerFromAccountname ( theName )
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( getElementData( thePlayer, "playerAccount" ) == theName ) then
			return thePlayer
		end
	end
end

function isPlayerOnline(accname)
	local thePlayer = getPlayerFromAccountname(accname)
	if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
		return true
	else
		return false
	end 
end 

function givePlayerVIP(accname, amount)
	if (isPlayerOnline(accname) == true) then 
		local thePlayer = getPlayerFromAccountname(accname)
		if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
			exports.AURvip:givePlayerVIP(thePlayer, math.floor(amount)*60)
			outputChatBox("Thank you for purchasing a "..amount.." of VIP Hours.", thePlayer, 255, 255, 0)
			return true
		else
			return false
		end 
	else 
		waitingAccounts[#waitingAccounts+1] = {accname, "vip", amount}
	end 
end 

function givePlayerWife(accname)
	if (isPlayerOnline(accname) == true) then 
		local thePlayer = getPlayerFromAccountname(accname)
		if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
			outputChatBox("Thank you for purchasing a wife.", thePlayer, 255, 255, 0)
			exports.AURwife:addWife(accname)
			return true
		else
			return false
		end 
	else 
		waitingAccounts[#waitingAccounts+1] = {accname, "wife", true}
	end 
end 

function givePlayerSoldierSkin (accname)
	if (isPlayerOnline(accname) == true) then 
		local thePlayer = getPlayerFromAccountname(accname)
		if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
			outputChatBox("Thank you for purchasing a Soldier Skin. Type /tws to activate.", thePlayer, 255, 255, 0)
			exports.AURagents:addAccount(accname)
			return true
		else
			return false
		end 
	else 
		waitingAccounts[#waitingAccounts+1] = {accname, "soldierskin", true}
	end 
end 

function givePlayerCash(accname, amount)
	if (isPlayerOnline(accname) == true) then 
		local thePlayer = getPlayerFromAccountname(accname)
		if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
			exports.AURpayments:addMoney(thePlayer, amount, "Custom", "Automatic Donation", 0, "AURautodonations")
			outputChatBox("Thank you for purchasing $"..amount.." in game money.", thePlayer, 255, 255, 0)
			return true
		else
			return false
		end 
	else
		waitingAccounts[#waitingAccounts+1] = {accname, "cash", amount}
	end 
end 

function givePlayerDrugs(accname, amount)
	if (isPlayerOnline(accname) == true) then 
		local thePlayer = getPlayerFromAccountname(accname)
		if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
			exports.csgdrugs:giveDrug(thePlayer, "LSD",amount)
			exports.csgdrugs:giveDrug(thePlayer, "Cocaine",amount)
			exports.csgdrugs:giveDrug(thePlayer, "Heroine",amount)
			exports.csgdrugs:giveDrug(thePlayer, "Ritalin",amount)
			exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",amount)
			exports.csgdrugs:giveDrug(thePlayer, "Weed",amount)
			outputChatBox("Thank you for purchasing "..amount.." amount of each drugs.", thePlayer, 255, 255, 0)
			return true
		else
			return false
		end 
	else 
		waitingAccounts[#waitingAccounts+1] = {accname, "drugs", amount}
	end 
end 



function outputToPlayer(accname, say)
	local thePlayer = getPlayerFromAccountname(accname)
	if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
		outputChatBox(say, thePlayer, 255, 255, 0)
		return true
	else
		return false
	end 
end 