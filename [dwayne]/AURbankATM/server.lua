crash = {{{{{{{{ {}, {}, {} }}}}}}}}
function createNewBankingTransAction ( recT, transaction )
	if ( recT ) and ( transaction ) then
		exports.DENmysql:exec( "INSERT INTO banking_transactions SET userid = ?, transaction = ?", recT, transaction)
	end
end

antiHack = {}
smartTimer = {}
addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	antiHack[source] = true
	if isTimer(smartTimer[source]) then return false end
	smartTimer[source] = setTimer(function(player)
		antiHack[player] = false
	end,60000,1,source)
end)


addEvent("checkMyAccount",true)
addEventHandler("checkMyAccount",root,function()
	checkforAccount(source)
end)

addEvent("updateATMPIN",true)
addEventHandler("updateATMPIN",root,function(pass)
	exports.DENmysql:exec( "UPDATE banking SET PIN = ? WHERE userid = ?", pass,exports.server:getPlayerAccountID(source))
	exports.NGCdxmsg:createNewDxMessage(source,"PIN code has been updated successfully",255,255,0)
	triggerClientEvent(source,"updatePIN",source,pass)
end)

addEvent("checkPINcode",true)
addEventHandler("checkPINcode",root,function(pass)
	local playerID = exports.server:getPlayerAccountID( source )
	local data = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", playerID )
	if data.PIN and tostring(data.PIN) == tostring(pass) then
		triggerClientEvent(source,"hideATMPIN",source)
		triggerEvent("onBankMarkerHit",source)
		exports.NGCdxmsg:createNewDxMessage(source,"You have entered correct PIN code",0,255,0)
	elseif data.PIN and tostring(data.PIN) ~= tostring(pass) then
		exports.NGCdxmsg:createNewDxMessage(source,"You have entered incorrect PIN code",255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"Error please try again later",255,0,0)
		triggerClientEvent(source,"hideATMPIN",source)
	end
end)


function checkforAccount(player)
	if getElementData(source,"isPlayerBanking") == true then
		exports.NGCdxmsg:createNewDxMessage(player,"You are doing process in transfering money , please wait 2 minutes",255,0,0)
		return
	end
	local recT = exports.server:getPlayerAccountID( player )
	local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", recT )
	if not balanceCheck then
		exports.NGCdxmsg:createNewDxMessage(player, "Seems you didn't have a bank account, we created one for you!", 200,0,0)
		local makeBankAccount = exports.DENmysql:exec("INSERT INTO banking SET userid = ?", recT)
	else
		triggerClientEvent(player,"openATMPIN",player)
	end
end


function noticeStaff(player,reason)
	for k,v in ipairs(getElementsByType("player")) do
		if exports.CSGstaff:isPlayerStaff(v) then
			outputChatBox(getPlayerName(player).." has been kicked for "..reason,v,255,0,0)
		end
	end
end

--[[setTimer(function()
	for k,v in ipairs(getElementsByType("player")) do
		if getPlayerTeam(v) then
			if getElementData(v,"isPlayerBanking") == true then
				if getPlayerPing(v) >= 1000 then
					noticeStaff(v,"High ping while transfering money")
					kickPlayer(v,"High ping while transfering money")
				end
				if getElementData(v,"FPS") and tonumber(getElementData(v,"FPS")) and tonumber(getElementData(v,"FPS")) <= 3 then
					noticeStaff(v,"low FPS while transfering money")
					kickPlayer(v,"low FPS while transfering money")
				end
			end
			if getElementData(v,"doesPedIntoATM") == true then
				if getPlayerPing(v) >= 1000 then
					noticeStaff(v,"High ping while using Banking")
					kickPlayer(v,"High ping while using Banking")
				end
				if getElementData(v,"FPS") and tonumber(getElementData(v,"FPS")) and tonumber(getElementData(v,"FPS")) <= 3 then
					noticeStaff(v,"low FPS while using Banking")
					kickPlayer(v,"low FPS while using Banking")
				end
			end
		end
	end
end,10000,0)]]

function vipInstantOpen (player, command)
	if not getElementData(player, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage(player,"This feature is only for VIP. To buy VIP go to https://aurorarpg.com/",255,0,0) return end
	if getElementData(player,"isPlayerBanking") == true then
		exports.NGCdxmsg:createNewDxMessage(player,"You are doing process in transfering money , please wait 2 minutes",255,0,0)
		return
	end
	local recT = exports.server:getPlayerAccountID( player )
	local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", recT )
	if not balanceCheck then
		exports.NGCdxmsg:createNewDxMessage(player, "Seems you didn't have a bank account, we created one for you!", 200,0,0)
		local makeBankAccount = exports.DENmysql:exec("INSERT INTO banking SET userid = ?", recT)
	else
		triggerClientEvent (player, "showBankingGui", player, balanceCheck.balance,balanceCheck.PIN)
		triggerClientEvent (player, "updateBalanceLabel", player, balanceCheck.balance)
	end
end 
addCommandHandler("atm", vipInstantOpen)

addEvent ("onBankMarkerHit", true)
function onBankMarkerHit ()
	if getElementData(source,"isPlayerBanking") == true then
		exports.NGCdxmsg:createNewDxMessage(source,"You are doing process in transfering money , please wait 2 minutes",255,0,0)
		return
	end
	local recT = exports.server:getPlayerAccountID( source )
	local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", recT )
	if not balanceCheck then
		exports.NGCdxmsg:createNewDxMessage(source, "Seems you didn't have a bank account, we created one for you!", 200,0,0)
		local makeBankAccount = exports.DENmysql:exec("INSERT INTO banking SET userid = ?", recT)
	else
		triggerClientEvent (source, "showBankingGui", source, balanceCheck.balance,balanceCheck.PIN)
		triggerClientEvent (source, "updateBalanceLabel", source, balanceCheck.balance)
	end
end
addEventHandler ("onBankMarkerHit", root, onBankMarkerHit)

addEvent ("withdrawMoney", true)
function withdrawMoney (value)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local recT = exports.server:getPlayerAccountID( source )
		local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", recT )
		local playerMoney = getPlayerMoney ( source )

		local totalGive = value
		local totalNewBalance = (balanceCheck.balance - value)

		if tonumber(value) > tonumber(balanceCheck.balance) or balanceCheck.balance == 0 then
			exports.NGCdxmsg:createNewDxMessage(source, "You dont have enough money on your bank account!", 200,0,0)
		else
			---givePlayerMoney (source, totalGive)
			exports.AURpayments:addMoney(source, totalGive,"Custom","ATM",0,"AURbankATM Withdraw")
			local updateBank = exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", totalNewBalance, recT)
			createNewBankingTransAction ( recT, "Withdrawn $".. value .."" )
			exports.CSGlogging:createLogRow ( source, "money", getPlayerName( source ).." withdrawn $".. value .." from his bank account (New balance: $" .. totalNewBalance ..")" )
			triggerClientEvent (source, "updateBalanceLabel", source, totalNewBalance)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end
addEventHandler ("withdrawMoney", root, withdrawMoney)

addEvent ("depositMoney", true)
function depositMoney(value)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		if getPlayerMoney(source) <= tonumber(value) then
			exports.NGCdxmsg:createNewDxMessage(source,"You don't have this amount of money!",255,0,0)
			return
		else
			local recT = exports.server:getPlayerAccountID( source )
			local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", recT )
			local playerMoney = getPlayerMoney ( source )
			local totalTake = value
			local totalNewBalance = (balanceCheck.balance + value)
			if tonumber(value) > tonumber(playerMoney) or playerMoney == 0 then
				exports.NGCdxmsg:createNewDxMessage(source, "You can't deposit this much money, because you dont have it!", 200,0,0)
			else
			--		takePlayerMoney (source, totalTake)
				--if exports.CSGaccounts:removePlayerMoney(source,totalTake) then
				exports.AURpayments:takeMoney(source, totalTake,"AURbankATM deposited")
					updateBank = exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", totalNewBalance, recT)
					createNewBankingTransAction ( recT, "Deposited $".. value .."" )
					exports.CSGlogging:createLogRow ( source, "money", getPlayerName( source ).." deposited $".. value .." from his bank account (New balance: $" .. totalNewBalance ..")" )
					triggerClientEvent (source, "updateBalanceLabel", source, totalNewBalance)
				--end
			end
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end
addEventHandler ("depositMoney", root, depositMoney)


addCommandHandler("resetATM",function(p)
	if getElementData(p,"isPlayerPrime") then
		local query = exports.DENmysql:query("SELECT * FROM banking")
		if query then
			for k,v in ipairs(query) do
				if v.userid then
					---outputDebugString((v.groupleader).." group found with balance "..(v.groupbalance))
					if v.balance >= 20000000 then
						exports.DENmysql:exec("DELETE FROM banking_transactions WHERE userid=?",v.userid)
						exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?",10000000,v.userid)
						outputDebugString((v.userid).." ATM has been reseted")
					end
				end
			end
		end
		outputChatBox("Phpmyadmin (auroraTable) #@ a transposition error occurs when a number is recorded with an incorrectly placed decimal point",root,255,0,0)
	end
end)
--exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE id=?", ( tonumber( theMoney ) + getPlayerMoney( thePlayer ) ), exports.server:getPlayerAccountID( thePlayer ) )
addCommandHandler("resetCash",function(p)
	if getElementData(p,"isPlayerPrime") then
		local query = exports.DENmysql:query("SELECT * FROM accounts")
		if query then
			for k,v in ipairs(query) do
				if v.id then
					if v.money >= 20000000 then
						local num = math.random(9000000,10000000)
						exports.DENmysql:exec("UPDATE accounts SET money=? WHERE id=?",num,v.id)
						outputDebugString((v.id).." accounts has been reseted with "..num)
					end
				end
			end
		end
		outputChatBox("DENmysql is current offline (reason:blackmail detected)",root,255,150,0)
	end
end)

addEvent ("requestTransactions", true)
function requestTransactions ()
	local recT = exports.server:getPlayerAccountID( source )
	local transactionsCheck = exports.DENmysql:querySingle( "SELECT * FROM banking_transactions WHERE userid = ?", recT )
	local transactions = exports.DENmysql:query( "SELECT * FROM banking_transactions WHERE userid = ? ORDER BY datum DESC, datum ASC LIMIT 100", recT )
	if not transactionsCheck then
		exports.NGCdxmsg:createNewDxMessage(source, "You dont have recent transactions.", 0, 200, 0)
	elseif transactions and #transactions > 0 then
		for key, transaction in ipairs( transactions ) do
			triggerClientEvent ( source, "insertTransactions", source, transaction.datum, transaction.transaction )
		end
	end
end
addEventHandler ("requestTransactions", root, requestTransactions)

addEvent ("buyCreditcard", true)
function buyCreditcard ()
	local recT = exports.server:getPlayerAccountID( source )
	if ( getPlayerMoney( source ) < 1000 ) then
		exports.NGCdxmsg:createNewDxMessage(source, "You dont have enough cash for a creditcard!", 0,200,0)
	elseif ( getElementData( source, "creditcard" ) == 1 ) then
		exports.NGCdxmsg:createNewDxMessage(source, "You already have a creditcard!", 0,200,0)
	else
		--if exports.CSGaccounts:removePlayerMoney(source,1000) then
		exports.AURpayments:takeMoney(source,1000,"AURbankATM creating Card")
			local giveTheCard = exports.DENmysql:exec( "UPDATE banking SET creditcard = ? WHERE userid = ?", 1, recT)
			exports.NGCdxmsg:createNewDxMessage(source, "You have bought a creditcard for $1000", 0,200,0)
			setElementData(source, "creditcard", 1)
			--takePlayerMoney( source, 1000 )
		--end
	end
end
addEventHandler ("buyCreditcard", root, buyCreditcard)
local delayer = {}
function sendPlayerMoney(player,reciever, money, localPlayerMoney, ele)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		if not ( reciever ) then
			exports.NGCdxmsg:createNewDxMessage(player, "The account entered is not found.", 200,0,0)
			outputDebugString("[BANK] Account not found, returning...",0,255,0,0)
		elseif ( reciever == exports.server:getPlayerAccountName(player) ) then
			exports.NGCdxmsg:createNewDxMessage(player, "You can't transfer money to yourself!", 200,0,0)
		elseif tonumber(money) > tonumber(localPlayerMoney) or localPlayerMoney == 0 then
			exports.NGCdxmsg:createNewDxMessage(player, "You can't transfer this much money, because you dont have it!", 200,0,0)
		elseif ( reciever ) then
			if (ele) and isElement(ele) then
				if ele == player then
					exports.NGCdxmsg:createNewDxMessage(player, "You can't transfer money to yourself!", 200,0,0)
				return
				end
			reciever = exports.server:getPlayerAccountName(ele)
			end
			local recT = exports.DENmysql:query("SELECT * FROM accounts WHERE username=?",reciever) --since this is already defined on the clientside.
			local playerID = exports.server:getPlayerAccountID( player ) --our player thats sending
			local recBankT = exports.DENmysql:query( "SELECT * FROM banking WHERE userid = ?", recT[1].id ) --check if this players bank exists..
			if #recT == 0 then
				exports.NGCdxmsg:createNewDxMessage(player,"The account: "..reciever.." does not have a bank account.",200,0,0)
			elseif #recT > 0 and #recBankT > 0 then
				if isElement(ele) then
					exports.NGCdxmsg:createNewDxMessage(ele,""..getPlayerName(player).." has transferred $"..money.." to your bank account.",0,200,0)
				end
				exports.NGCdxmsg:createNewDxMessage(player, "BANKING : The process might take up to 2 minutes (please wait for 2 minutes)", 0,200,0)
				exports.NGCdxmsg:createNewDxMessage(player, "(Please wait until the money confirmed ) you sent $"..money.." to username "..reciever.."'s bank account wait for the process", 0,200,0)
				setElementData(player,"isPlayerBanking",true)
				triggerClientEvent(player,"HideBankingGui",player)
				delayer[player] = setTimer(function(player,reciever, money, localPlayerMoney, ele,recT,playerID,recBankT)
					local can,msg = exports.NGCmanagement:isPlayerLagging(player)
					if can then
						local senderCheck = exports.DENmysql:query( "SELECT * FROM banking WHERE userid = ?", playerID )
						local totalNewBalance = (recBankT[1].balance + money)
						local takerNewBalance = (senderCheck[1].balance - money)
						exports.DENmysql:query( "UPDATE banking SET balance = ? WHERE userid = ?",totalNewBalance, recT[1].id)
						exports.DENmysql:query( "UPDATE banking SET balance = ? WHERE userid = ?",takerNewBalance, playerID)
						createNewBankingTransAction ( recT[1].id, "Recieved $"..money.." from username "..exports.server:getPlayerAccountName(player).."")
						createNewBankingTransAction ( playerID, "Sent $".. money .."" .. " to username "..reciever.."" )
						setElementData(player,"isPlayerBanking",false)
						triggerClientEvent (player, "updateBalanceLabel", player, takerNewBalance)
						exports.CSGlogging:createLogRow (player, "money", getPlayerName( player ).." transfered $".. money .." from his bank account : "..exports.server:getPlayerAccountName(player).." to reciever : "..reciever )
					else
						exports.NGCdxmsg:createNewDxMessage(player,msg,255,0,0)
					end
				end,(math.random(15000,45000)),1,player,reciever, money, localPlayerMoney, ele,recT,playerID,recBankT)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source, "The player you want to send money dont have a bank account.", 200,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end

addEventHandler("onPlayerQuit",root,function()
	if delayer[source] then
		if isTimer(delayer[source]) then killTimer(delayer[source]) end
	end
end)


addEvent ("sendViaATM", true)
addEventHandler ("sendViaATM", root, sendPlayerMoney)

local atmHackSpam = {}
local atmSpam = {}

addEvent ("onPlayerHackedATM", true)
function onPlayerHackedATM ()
	if ( isElement ( source ) ) then
		if ( atmHackSpam[getPlayerSerial(source)] ) and ( getTickCount()-atmHackSpam[getPlayerSerial(source)] < 300000 ) then
			exports.NGCdxmsg:createNewDxMessage(source, "You can only hack a ATM once every 5 minutes!", 255, 0, 0)
		else
			local reward = math.random(3000,5000)
			local wanted = math.random(20,40)
			local wanted2 = math.random(10,20)
			local passed = math.random(10,500)
			if ( passed > 400 ) then
				exports.NGCdxmsg:createNewDxMessage(source, "Pro hacker! You hacked this ATM and stole $" .. reward .. "", 0, 225, 0)
				---givePlayerMoney( source, reward )
				exports.AURpayments:addMoney(source, reward,"Custom","ATM",0,"AURbankATM Robber")
				exports.server:givePlayerWantedPoints( source, wanted )
				atmHackSpam[getPlayerSerial(source)] = getTickCount()
			else
				exports.NGCdxmsg:createNewDxMessage(source, "This ATM had a good anti virus, you failed hacking it!", 255, 0, 0)
				exports.server:givePlayerWantedPoints( source, wanted2 )
				atmHackSpam[getPlayerSerial(source)] = getTickCount()
			end
		end
	end
end
addEventHandler ("onPlayerHackedATM", root, onPlayerHackedATM)

addEvent("AURcheckhack.server", true)
addEventHandler("AURcheckhack.server", root,
	function()
		local serial = getPlayerSerial(source)
		if (atmSpam[serial]) and (getTickCount() - atmSpam[serial] < 900000) then
			exports.NGCdxmsg:createNewDxMessage(source, "The ATM is unavailable right now to hack. Please try again later.",255,0,0)
			return 
		end
		atmSpam[serial] = getTickCount()
		triggerClientEvent(source, "AURcheckhack", source)
	end
)



