--
-- Author: Ab-47 ~ AURrpunishments/server.lua
-- Updates: Bug fixes, fixed account table retrieved by serial, id from accounts.
--

-- Get punishments
addEvent( "onRequestRPunishlog", true )
addEventHandler( "onRequestRPunishlog", root,
	function ( userSerial, usernames, string )
		if (string == "serial") then
			local serialTable = exports.DENmysql:query( "SELECT * FROM punishlog WHERE serial=? ORDER BY datum ASC", userSerial )
			local serialAccount = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE serial=?", userSerial)
			if (not serialTable or not serialAccount) then
				exports.NGCdxmsg:createNewDxMessage(source, "No matching serial, please enter the correct serial!", 255, 0, 0)
				return
			end
			triggerClientEvent(source, "onRequestRPunishlog:callRBack", source, serialTable, false, "serial", toJSON(serialAccount), serialAccount.id)
		else
			local accounts = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE username=?", usernames)
			local serialTable = exports.DENmysql:query( "SELECT * FROM punishlog WHERE serial=? ORDER BY datum ASC", accounts.serial )
			local accountTable  = exports.DENmysql:query( "SELECT * FROM punishlog WHERE userid=? ORDER BY datum ASC", accounts.id )
			if (not serialTable or not accountTable or not accounts) then
				exports.NGCdxmsg:createNewDxMessage(source, "No matching serial/account, please enter the correct serial/account name!", 255, 0, 0)
				return
			end
			triggerClientEvent(source, "onRequestRPunishlog:callRBack", source, serialTable, accountTable, "all", accounts.username, accounts.id)
		end
	end
)