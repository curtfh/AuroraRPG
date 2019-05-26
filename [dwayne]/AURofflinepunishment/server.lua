addEvent("getPlayerAccountBySerial",true)
addEventHandler("getPlayerAccountBySerial",root,function(serial)
	local data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE serial = ?",serial)
	if data then
		triggerClientEvent(source,"foundSerial",source,data.username)
	end
end)

addEvent("offlineJail",true)
addEventHandler("offlineJail",root,function(accountName,theTime,reason)
	local data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username = ?",accountName)
	if data then
		if accountName and theTime and reason then
			if data.username == accountName then
				text = "[OFFLINE-PUNISH] " ..getPlayerName(source).. " jailed account name:" ..tostring(accountName).. " for " ..tostring(theTime).. " secs (" ..tostring(reason).. ")"
				exports.DENmysql:exec("INSERT INTO jail (userid,jailtime,jailplace) VALUES (?,?,?)",tostring(data.id), tostring(theTime),"LS1")
				exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?, serial=?", tostring(data.id), text, " " )
				exports.CSGlogging:createAdminLogRow (source,text)
				outputChatBox( "(Offline Punishment) "..getPlayerName( source ).." Jailed Account Owner : " ..accountName.. " for " .. theTime .. " Seconds (" .. reason .. ")", root, 0, 225, 0 )
			else
				exports.NGCdxmsg:createNewDxMessage(source,"Account not found",255,0,0)
			end
		end
	end
end)

addEvent("offlineMute",true)
addEventHandler("offlineMute",root,function(accountName,theTime,reason)
	local data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username = ?",accountName)
	if data then
		if accountName and theTime and reason then
			if data.username == accountName then
				if accountName and theTime and reason then
					text = "[OFFLINE-PUNISH] " ..getPlayerName(source).. " muted account name:" ..tostring(accountName).. " for " ..tostring(theTime).. " secs (" ..tostring(reason).. ")"
					exports.DENmysql:exec("INSERT INTO mutes (userid,mutetime,mutetype) VALUES (?,?,?)",tostring(data.id), tostring(theTime),"Main")
					exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?, serial=?", tostring(data.id), text, " " )
					exports.CSGlogging:createAdminLogRow (source,text)
					outputChatBox( "(Offline Punishment) "..getPlayerName( source ).." muted Account Owner : " ..accountName.. " for " .. theTime .. " Seconds (" .. reason .. ")", root, 255, 128, 0 )
				end
			end
		end
	end
end)

addEvent("offlineGOMute",true)
addEventHandler("offlineGOMute",root,function(accountName,theTime,reason)
	local data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username = ?",accountName)
	if data then
		if accountName and theTime and reason then
			if data.username == accountName then
				if accountName and theTime and reason then
					text = "[OFFLINE-PUNISH] " ..getPlayerName(source).. " muted account name:" ..tostring(accountName).. " for " ..tostring(theTime).. " secs (" ..tostring(reason).. ")"
					exports.DENmysql:exec("INSERT INTO mutes (userid,mutetime,mutetype) VALUES (?,?,?)",tostring(data.id), tostring(theTime),"Global")
					exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=? serial=?", tostring(data.id), text, " " )
					exports.CSGlogging:createAdminLogRow (source,text)
					outputChatBox( "(Offline Punishment) "..getPlayerName( source ).." Global muted Account Owner : " ..accountName.. " for " .. theTime .. " Seconds (" .. reason .. ")", root, 255, 128, 0 )
				end
			end
		end
	end
end)
--[[
addEvent("banOfflineAccount",true)
addEventHandler("banOfflineAccount",root,function(accountName,theTime,reason)
	if accountName and theTime and reason then

			local timeHours = math.floor( theTime )
			local banTime = ( getRealTime().timestamp + theTime )
			local accountTable = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? LIMIT 1", accountName )
			exports.DENmysql:exec( "INSERT INTO bans SET account=?, reason=?, banstamp=?, bannedby=?", accountName, reason, banTime, getPlayerName( source ) )
			exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", accountTable.id, accountTable.serial, getPlayerName( source ).." account banned the account " .. accountName .. " for " .. timeHours .. " hours (" .. reason .. ")" )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." banned the account " .. accountName .. " for " .. timeHours .. " hours (" .. reason .. ")" )
			outputChatBox("[OFFLINE-PUNISH] (Account Ban) You have banned account name:" ..tostring(accountName).. " for " ..tostring(timeHours).. " hours (" ..tostring(reason).. ")", source, 30, 250, 30)

	end
end)

addEvent("banOfflineSerial",true)
addEventHandler("banOfflineSerial",root,function(accountName,serial,theTime,reason)
	if accountName and theTime and reason and serial then

			local timeHours = math.floor( theTime )
			local banTime = ( getRealTime().timestamp + theTime )
			exports.DENmysql:exec( "INSERT INTO bans SET reason=?, banstamp=?, serial=?, bannedby=?", reason, banTime, serial, getPlayerName( source ) )
			exports.DENmysql:exec( "INSERT INTO punishlog SET serial=?, punishment=?", serial, "[OFFLINE-PUNISH] "..getPlayerName( source ).." has banned the account " .. accountName .. " for " .. timeHours .. " hours (" .. reason .. ")" )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." the serial " .. serial .. " for " .. timeHours .. " hours (" .. reason .. ")" )
			outputChatBox("[OFFLINE-PUNISH] (Serial Ban) You have banned account by serial ( Account : " ..tostring(accountName).. " ) for " ..tostring(timeHours).. " hours (" ..tostring(reason).. ")", source, 30, 250, 30)

	end
end)
]]
addEvent("banOfflineAccount",true)
addEventHandler("banOfflineAccount",root,function(accountName,theTime,reason)
	if accountName and theTime and reason then
	if (exports.CSGstaff:getPlayerAdminLevel(source) < 3) then return false end
	local accountTable = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? LIMIT 1", accountName )
		if accountTable then
			local timeHours = math.floor( theTime / 3600 )
			banTime = ( getRealTime().timestamp + theTime )
			-- this original one--exports.DENmysql:exec( "INSERT INTO bans SET account=?, reason=?, banstamp=?,bannedby=?", accountTable.username, reason, banTime,getPlayerName( source ) )
			---exports.DENmysql:exec( "REPLACE INTO bans SET account=?, reason=?, banstamp=?, bannedby=?", accountTable.username, reason, banTime, getPlayerName( source ) )
			--- exports.DENmysql:exec( "INSERT IGNORE INTO bans SET account=?, reason=?, banstamp=?, bannedby=?", accountTable.username, reason, banTime, getPlayerName( source ) )

			if tonumber(theTime) == 0 then
				banTime = 999999999
			end
			exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", accountTable.id, accountTable.serial, getPlayerName( source ).." account banned " .. accountName .. " for " .. timeHours .. " hours (" .. reason .. ")" )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." account banned " .. accountName .. " for " .. timeHours .. " hours (" .. reason .. ")" )
			--outputChatBox( "(Offline Punishment) "..getPlayerName( source ).." account banned : " ..accountName.. " for "..theTime.." Seconds / " .. timeHours .. " hours (" .. reason .. ")", root, 255, 128, 0 )
			outputChatBox( "(Offline Punishment) "..getPlayerName( source ).." account banned : " ..accountName.. " for "..theTime.." Seconds / " .. timeHours .. " hours (" .. reason .. ")", source, 255, 128, 0 )
		end
	end
end)

addEvent("banOfflineSerial",true)
addEventHandler("banOfflineSerial",root,function(accountName,serial,theTime,reason)
	if accountName and theTime and reason and serial then
		local accountTable = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? LIMIT 1", accountName )
		if accountTable then
			if accountTable.serial == serial and accountTable.username == accountName then
				local timeHours = math.floor( theTime / 3600 )
				banTime = ( getRealTime().timestamp + theTime )
				if tonumber(theTime) == 0 then
					banTime = 999999999
				end
				exports.DENmysql:exec( "INSERT into bans SET account=?, reason=?, banstamp=?, serial=?, bannedby=?", accountTable.username, reason, banTime, accountTable.serial, getPlayerName( source ) )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", accountTable.id, accountTable.serial, getPlayerName( source ).." serial banned on account " .. accountName .. " for " .. timeHours .. " hours (" .. reason .. ")" )
				exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." serial banned : " .. accountTable.serial .. " for " .. timeHours .. " hours (" .. reason .. ")" )
				outputChatBox( "(Offline Punishment) "..getPlayerName( source ).." serial banned : " ..accountName.. " for "..theTime.." Seconds / " .. timeHours .. " hours (" .. reason .. ")", root, 255, 128, 0 )
			end
		end
	end
end)
