antiSpamSMSTimer = 5000
chatTime = {}

addEvent("MTA_RP_phone.sendMessage", true)
function sendMessage( toPlayer, text )
	if (isPlayerMuted(source)) then 
		exports.NGCdxmsg:createNewDxMessage("You're muted...", source, 255, 0, 0)
		return
	end
	local time = getRealTime()
	local hour = time.hour
	local minute = time.minute
	local sec = time.second
	if (toPlayer == source) then
		exports.NGCdxmsg:createNewDxMessage("Why would you like to SMS yourself?", source, 255, 0, 0)
		return
	end
	if (chatTime[source] and chatTime[source] + antiSpamSMSTimer > getTickCount()) then
		exports.NGCdxmsg:createNewDxMessage("You must wait at least ".. antiSpamSMSTimer/1000 .." seconds between every message!", source, 255, 0, 0)
	else
		if (not isGuestAccount(getPlayerAccount(source))) then
			if( not text ~= "" ) then
				chatTime[source] = getTickCount()
				outputChatBox("SMS Received from"..getPlayerName(source)..":"..text, toPlayer, 255, 255, 0)
				outputChatBox("SMS Message to "..getPlayerName(toPlayer).." has been sent", source, 255, 255, 0)
				exports.MTA_RP_admin:writePlayerLog(source, "[SMS]["..hour..":"..minute..":"..sec.."] from "..getPlayerName(source).." to "..getPlayerName(toPlayer)..":"..text)
				exports.MTA_RP_admin:writeLine("text/sms.log", "[SMS]["..hour..":"..minute..":"..sec.."] from "..getPlayerName(source).." to "..getPlayerName(toPlayer)..":"..text)
				triggerClientEvent(source, "MTA_RP_phone.writeLatestSMStoSource", source, toPlayer, text)
				triggerClientEvent(toPlayer, "MTA_RP_phone.writeLatestSMStoToPlayer", toPlayer, source, text)
			end
		else
		exports.NGCdxmsg:createNewDxMessage("[SMS]Login first, genius!", toPlayer, 255, 255, 0)
		end
	end
end
addEventHandler("MTA_RP_phone.sendMessage", root, sendMessage)


addEvent("MTA_RP_phone.removeFriend", true)
function removeFriend(friendElement)
	removePlayerFriend(source, friendElement)
end
addEventHandler("MTA_RP_phone.removeFriend", root, removeFriend)

friends = {}

function isPlayerOnPlayerFriendList(player, playerFriend)
	if (not isGuestAccount(getPlayerAccount(player))) then
		if (friends[getPlayerAccount(player)]) then
			for i = 1, #friends[getPlayerAccount(player)] do
				if (friends[getPlayerAccount(player)][i] == playerFriend) then
				return true
				end
			end
		end
	end
return false
end
addEvent("MTA_RP_phone.addFriend", true)
function addPlayerFriend(playerToAdd)
--	if (not source == playerToAdd) then
	local playerAccount = getPlayerAccount(source)
		if (not isGuestAccount(playerAccount)) then
		--outputChatBox("ok2")
			if (not isGuestAccount(getPlayerAccount(playerToAdd))) then
				if (not friends[playerAccount]) then
					friends[playerAccount] = {}
				end
				if ( not isPlayerOnPlayerFriendList(source, getAccountName(getPlayerAccount(playerToAdd)))) then
				table.insert(friends[playerAccount], getAccountName(getPlayerAccount(playerToAdd)))
				triggerClientEvent(source, "MTA_RP_phone.setFriendsGrid", source, friends[playerAccount])
				--outputChatBox(toJSON(friends[playerAccount]))
				end
			end
		end
	--end
end
addEventHandler("MTA_RP_phone.addFriend", root, addPlayerFriend)

function removefromtable(table, removethingy)
  for k, v in pairs (table) do
    if v == removethingy then
      table[k] = nil
    end
  end
end

function removePlayerFriend(thePlayer, theDeletePlayer)
local playerAccount = getPlayerAccount(thePlayer)
	if (isPlayerOnPlayerFriendList(thePlayer, theDeletePlayer)) then
	removefromtable(friends[playerAccount], theDeletePlayer)
	end
end

function savePlayerFriends()
local playerAccount = getPlayerAccount(source)
	if (not isGuestAccount(playerAccount)) then
		setAccountData(playerAccount, "MTA_RP_phone.friends", toJSON(friends[playerAccount]))
		friends[playerAccount] = nil
	end
end
addEventHandler("onPlayerQuit", root, savePlayerFriends)

function setPlayerFriends(_, curAccount)
local playerFriendData = getAccountData(curAccount, "MTA_RP_phone.friends")
	if (playerFriendData) then
	local playerFriendTable = fromJSON( playerFriendData )
		friends[curAccount] = playerFriendTable
		triggerClientEvent(source, "MTA_RP_phone.setFriendsGrid", source, playerFriendTable)
	end
end
addEventHandler("onPlayerLogin", root, setPlayerFriends)

addEvent("MTA_RP_phone.getTableToClient", true)
function sendTableToGridList()
	triggerClientEvent(source, "MTA_RP_phone.setFriendsGrid", source, friends[getPlayerAccount(source)])
end
addEventHandler("MTA_RP_phone.getTableToClient", root, sendTableToGridList)

function setPlayerAccountToData()
	for _, player in ipairs(getElementsByType("player")) do
		local pAccount = getPlayerAccount( player)
		if (not isGuestAccount( pAccount )) then
		local accName = getAccountName( pAccount )
		setElementData(player, "MTA_RP_phone.accName", accName)
		end	
	end
end
setTimer(setPlayerAccountToData, 2000, 0)


--
playerjobs = {
["Police"] = { ["Police Officer"] = true };
["Medic"] = { ["Medic"] = true };
["Mechanic"] = { ["Mechanic"] = true };
}

callServiceTimer = {}
antiSpamCallTimer = 30000
addEvent("MTA_RP_phone.callService", true)
function callService(serviceName)
	if (not isGuestAccount(getPlayerAccount(source))) then
		if (getPlayerWantedLevel(source) == 0) then
			if (getElementInterior(source) == 0) then
				if (getElementDimension(source) == 0) then
					if (serviceName) then
					local x, y, z = getElementPosition(source)
						if (callServiceTimer[source] and callServiceTimer[source] + antiSpamCallTimer > getTickCount()) then
						exports.NGCdxmsg:createNewDxMessage("You must wait at least ".. antiSpamCallTimer/1000 .." seconds between every call!", source, 255, 0, 0)
						else
							for _, value in ipairs (getElementsByType("player")) do
								if (playerjobs[serviceName][exports.MTA_RP_business:getPlayerJob(value)]) then
								--if (playerjobs[serviceName][getElementData(value, "Occupation")]) then
								local x, y, z = getElementPosition(source)
									exports.NGCdxmsg:createNewDxMessage(getPlayerName(source).. " is requesting ".. serviceName .." at " .. getZoneName(x, y, z), value, 255, 255, 0)
									exports.NGCdxmsg:createNewDxMessage("Request sent", source, 255, 255, 0)
									callServiceTimer[source] = getTickCount()
								end
							end
						end
					end
				else
				exports.NGCdxmsg:createNewDxMessage("You can't call service if you are not outside!", source, 255, 255, 0)
				end
			else
			exports.NGCdxmsg:createNewDxMessage("You can't call service if you are not outside!", source, 255, 255, 0)
			end
		else
		exports.NGCdxmsg:createNewDxMessage("You can't call service if you are wanted!", source, 255, 255, 0)
		end
	else
	exports.NGCdxmsg:createNewDxMessage("You are not logged in!", source, 255, 255, 0)
	end
end
addEventHandler("MTA_RP_phone.callService", root, callService)

addEvent("MTA_RP_phone.saveWallpaper", true)
function saveWallpaper(wallpaperName)
	if (not isGuestAccount(getPlayerAccount(source))) then
		setAccountData(getPlayerAccount(source), "MTA_RP_phone.wallpaperName", "images/wallpapers/"..wallpaperName)
	end
end
addEventHandler("MTA_RP_phone.saveWallpaper", root, saveWallpaper)

addEvent("MTA_RP_phone.triggerToApplyWallpaper", true)
function triggerToApplyWallpaper()
	if (not isGuestAccount(getPlayerAccount(source))) then
	local playerWallpaperData = getAccountData(getPlayerAccount(source), "MTA_RP_phone.wallpaperName")
		if (playerWallpaperData) then
		triggerClientEvent(source, "MTA_RP_phone.applyWallpaper", source, playerWallpaperData )
		end
	end
end
addEventHandler("MTA_RP_phone.triggerToApplyWallpaper", root, triggerToApplyWallpaper)

addEvent("MTA_RP_phone.sendMoney", true)
function sendMoney(playerToSend, Amount)
local Amount = tonumber(Amount)
	if (not isGuestAccount(getPlayerAccount(source))) then
		if (type(Amount) == 'number') then
			if (Amount > 0) then
				if (playerToSend) then
					if (getPlayerMoney(source) >= tonumber(Amount)) then
						if (not isGuestAccount(getPlayerAccount(playerToSend))) then
							if (not playerToSend == source) then
								return
							exports.NGCdxmsg:createNewDxMessage("You can not send money to yourself!", source, 255, 0, 0)
							end
								exports.MTA_RP_accounts:TPM(source, Amount, "Sent to "..getPlayerName(playerToSend))
								exports.MTA_RP_accounts:GPM(playerToSend, Amount, "Received from "..getPlayerName(source))
								--takePlayerMoney(source, Amount)
								--givePlayerMoney(playerToSend, Amount)
								local formatted = exports.MTA_RP_misc:formatNumber(amount)
								exports.NGCdxmsg:createNewDxMessage(getPlayerName(source).." has sent you $"..formatted, playerToSend, 0, 255, 0)
								exports.NGCdxmsg:createNewDxMessage("Sent $"..formatted.." to "..getPlayerName(playerToSend), source, 0, 255, 0)
						else
						exports.NGCdxmsg:createNewDxMessage("That player is not logged in!", source, 255, 0, 0)
						end
					else
					exports.NGCdxmsg:createNewDxMessage("You don't have enough money to do that!", source, 255, 0, 0)
					end
				else
				exports.NGCdxmsg:createNewDxMessage("Player appears to be offline!", source, 255, 0, 0)
				end
			else
			exports.NGCdxmsg:createNewDxMessage("Amount should be a positive number!", source, 255, 0, 0)
			end
		else
		exports.NGCdxmsg:createNewDxMessage("Invalid amount!", source, 255, 0, 0)
		end
	else
	exports.NGCdxmsg:createNewDxMessage("You must be logged in to do this!", source, 255, 0, 0)
	end
end
addEventHandler("MTA_RP_phone.sendMoney", root, sendMoney)



addEvent("MTA_RP_phone.saveWorldData", true)
function saveWorldData(WorldType, data)
	if (not isGuestAccount(getPlayerAccount(source))) then 
		if (WorldType == "heatHaze") then
			setAccountData(getPlayerAccount(source), "MTA_RP_phone.setting.heathaze", data)
		elseif (WorldType == "FPS") then
			setAccountData(getPlayerAccount(source), "MTA_RP_phone.setting.fps", data)
		elseif (WorldType == "blur") then
			setAccountData(getPlayerAccount(source), "MTA_RP_phone.setting.blur", data)
		elseif (WorldType == "clouds") then
			setAccountData(getPlayerAccount(source), "MTA_RP_phone.setting.clouds", data)
		end
	end
end
addEventHandler("MTA_RP_phone.saveWorldData", root, saveWorldData)

function setWorldData(_, curAccount)
local heatHazeData = getAccountData(curAccount, "MTA_RP_phone.setting.heathaze")
local fpsData = getAccountData(curAccount, "MTA_RP_phone.setting.fps")
local blurData = getAccountData(curAccount, "MTA_RP_phone.setting.blur")
local cloudsData = getAccountData(curAccount, "MTA_RP_phone.setting.clouds")
	triggerClientEvent(source, "MTA_RP_phone.setWorldData", source, heatHazeData, fpsData, blurData, cloudsData)
	
	
	local secQuestion = getAccountData(curAccount, "MTA_RP_accounts.securityQuestion")
	triggerClientEvent(source, "MTA_RP_phone.setSecurityQuestioN", source, secQuestion)
	
	result = executeSQLSelect("MTA_RP_phone", "*", "AccountName = '"..getAccountName(curAccount).."'")
	if ( type( result ) == "table" and #result == 0 ) or not result then
	triggerClientEvent(source, "MTA_RP_phone.setNotes", source, "")
	else
	triggerClientEvent(source, "MTA_RP_phone.setNotes", source, result[1].Notes)
	end
end
addEventHandler("onPlayerLogin", root, setWorldData)

addEvent("MTA_RP_phone.changePlayerPassword", true)
function changePlayerPassword( oldPassword, newPassword, securityAnswer )
	if (not isGuestAccount(getPlayerAccount(source))) then
		if (getAccount(getAccountName(getPlayerAccount(source)), oldPassword)) then
		local secAnswer = getAccountData(getPlayerAccount(source), "MTA_RP_accounts.securityAnswer")
			if (string.lower(tostring(secAnswer)) == string.lower(tostring(securityAnswer))) then
				setAccountPassword(getPlayerAccount(source), newPassword)
				exports.NGCdxmsg:createNewDxMessage("Password successfuly changed!", source, 0, 255, 0)
			else
			exports.NGCdxmsg:createNewDxMessage("Security answer is wrong!", source, 255, 0, 0)
			end
		else
		exports.NGCdxmsg:createNewDxMessage("Wrong current password!", source, 255, 0, 0)
		end
	else
	exports.NGCdxmsg:createNewDxMessage("You must be logged in to do this!", source, 255, 0, 0)
	end
end
addEventHandler("MTA_RP_phone.changePlayerPassword", root, changePlayerPassword)

executeSQLQuery("CREATE TABLE IF NOT EXISTS MTA_RP_phone (AccountName TEXT, Notes TEXT(1000000))")
addEvent("MTA_RP_phone.saveNotes", true)
function saveNotes(notestext)
	if (not isGuestAccount(getPlayerAccount(source))) then
		result = executeSQLSelect ( "MTA_RP_phone", "AccountName", "AccountName = '" .. getAccountName(getPlayerAccount(source)) .. "'" )
		if ( type( result ) == "table" and #result == 0 ) or not result then
			executeSQLInsert ( "MTA_RP_phone", "'"..getAccountName(getPlayerAccount(source)).."', '" .. notestext .. "'" )
			exports.NGCdxmsg:createNewDxMessage("Notes saved!", source, 0, 255, 0)
		else
			executeSQLUpdate ( "MTA_RP_phone", "Notes = '"..notestext.."'","AccountName = '" .. getAccountName(getPlayerAccount(source)) .. "'" )
			exports.NGCdxmsg:createNewDxMessage("Notes saved!", source, 0, 255, 0)
		end	
	end
end
addEventHandler("MTA_RP_phone.saveNotes", root, saveNotes)


--- MUSIC
