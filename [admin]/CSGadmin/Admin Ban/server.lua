-- All the bans are here
local theBanTable = {}

-- On resource start get all the bans
addEventHandler( "onResourceStart", resourceRoot,
	function ()
		theBanTable = exports.DENmysql:query( "SELECT * FROM bans" )
	end
)

-- Get the complete ban table
function getServerBans ()
	theBanTable = exports.DENmysql:query( "SELECT * FROM bans" )
	if ( theBanTable ) then
		return theBanTable
	else
		return false
	end
end

-- On player ban
function onPlayerBanned( userAccount, banTime, theReason, thePlayer )
	local newTable = exports.DENmysql:querySingle( "SELECT * FROM bans WHERE account=? AND banstamp=? LIMIT 1", userAccount, banTime )
	if ( newTable ) then
		table.insert( theBanTable, newTable )
	else
		theBanTable = exports.DENmysql:query( "SELECT * FROM bans" )
	end
	if ( thePlayer ) then triggerEvent( "onServerPlayerBan", thePlayer, userAccount, banTime, theReason ) end
end

-- Ban a player
function banServerPlayer ( theAdmin, thePlayer, theReason, theTime, theType, a, hidden )
	if ( thePlayer ) and ( theReason ) and ( theTime ) and ( theType ) then
		local userID = exports.server:getPlayerAccountID( thePlayer )
		local userAccount = exports.server:getPlayerAccountName( thePlayer )
		local timeMinutes = math.floor( theTime / 60 )
		exports.CSGscore:takePlayerScore(thePlayer, 1000)
		local cash = getPlayerMoney(thePlayer)
		local bankQuery = exports.DENmysql:querySingle("SELECT * FROM banking WHERE userid=?", userID)
		local playersName = ""
		if (hidden) then
			if (theType == "account") then
				playersName = "hidden player"
			elseif (theType == "serial") then
				if (theTime == 0) then
					playersName = "Hidden player"
				else
					playersName = "hidden player"
				end
			end
		else
			playersName = getPlayerName(thePlayer)
		end
		if (bankQuery) then
			local bankMoney = bankQuery['balance']
			if (cash > 800000) then
				takePlayerMoney(thePlayer, 800000)
			elseif (cash < 800000) and (cash + bankMoney > 800000) then
				local diff = 800000 - cash
				setPlayerMoney(thePlayer, 0)
				exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", bankMoney - diff, userID)
			else
				takePlayerMoney(thePlayer, 800000)
				--exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", 0, userID)
			end
		else
			takePlayerMoney(thePlayer, 800000)
		end
		--if ( theTime ~= 0 ) then banTime = ( getRealTime().timestamp + theTime )  end
		if ( theType == "account" ) then
			if ( theTime == 0 ) then
				exports.DENmysql:exec( "INSERT into bans SET account=?, reason=?, banstamp=?, bannedby=?", userAccount, theReason, 0, getPlayerName( theAdmin ) )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." account banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." account banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				outputChatBox( getPlayerName( theAdmin ).." account banned " .. playersName .. " permanently (" .. theReason .. ")", root, 255, 0, 0 )
				onPlayerBanned( userAccount, banTime, theReason, thePlayer )
				--kickPlayer( thePlayer, "You're banned from this server by: "..getPlayerName( theAdmin ) )
				redirectPlayer (thePlayer, "78.108.216.208", 22003)
				return true
			else
				banTime = ( getRealTime().timestamp + theTime )
				exports.DENmysql:exec( "INSERT into bans SET account=?, reason=?, banstamp=?, bannedby=?", userAccount, theReason, banTime, getPlayerName( theAdmin ) )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." account banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." account banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				outputChatBox( getPlayerName( theAdmin ).." account banned " .. playersName .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")", root, 255, 0, 0 )
				onPlayerBanned( userAccount, banTime, theReason, thePlayer )
				--kickPlayer( thePlayer, "You're banned from this server by: "..getPlayerName( theAdmin ) )
				redirectPlayer (thePlayer, "78.108.216.208", 22003)
				return true
			end
		elseif ( theType == "serial" ) then
			if ( theTime == 0 ) then
				exports.DENmysql:exec( "INSERT into bans SET account=?, reason=?, banstamp=?, serial=?, bannedby=?", userAccount, theReason, 0, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ) )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." serial banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." serial banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				outputChatBox( playersName.." was banned permanently (" .. theReason .. ")", root, 255, 0, 0 )
				onPlayerBanned( userAccount, banTime, theReason, thePlayer )
				--kickPlayer( thePlayer, "You're banned from this server by: "..getPlayerName( theAdmin ).." "..theReason )
				redirectPlayer (thePlayer, "78.108.216.208", 22003)
				return true
			else
				banTime = ( getRealTime().timestamp + theTime )
				exports.DENmysql:exec( "INSERT into bans SET account=?, reason=?, banstamp=?, serial=?, bannedby=?", userAccount, theReason, banTime, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ) )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." serial banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." serial banned " .. getPlayerName( thePlayer ) .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
				outputChatBox( getPlayerName( theAdmin ).." serial banned " .. playersName .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")", root, 255, 0, 0 )
				onPlayerBanned( userAccount, banTime, theReason, thePlayer )
				--kickPlayer( thePlayer, "You're banned from this server by: "..getPlayerName( theAdmin ).." "..theReason )
				redirectPlayer (thePlayer, "78.108.216.208", 22003)
				return true
			end
		end
	else
		return false
	end
end

-- Ban a account
function banServerAccount ( theAccount, theTime, theReason, theAdmin )
	if ( theAccount ) and ( theTime ) and ( theReason ) and ( theAdmin ) then
		local timeMinutes = math.floor( theTime * 60 )
		local banTime = ( getRealTime().timestamp + theTime )
		local accountTable = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? LIMIT 1", theAccount )
		exports.DENmysql:exec( "INSERT into bans SET account=?, reason=?, banstamp=?, bannedby=?", theAccount, theReason, banTime, getPlayerName( theAdmin ) )
		exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", accountTable.id, accountTable.serial, getPlayerName( theAdmin ).." account banned the account " .. theAccount .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
		exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." banned the account " .. theAccount .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
		onPlayerBanned( theAccount, banTime, theReason, thePlayer )
		return true
	else
		return false
	end
end

-- Ban a serial
function banServerSerial ( theSerial, theTime, theReason, theAdmin )
	if ( theSerial ) and ( theTime ) and ( theReason ) and ( theAdmin ) then
		local timeMinutes = math.floor( theTime * 60 )
		local banTime = ( getRealTime().timestamp + theTime )
		exports.DENmysql:exec( "INSERT into bans SET reason=?, banstamp=?, serial=?, bannedby=?", theReason, banTime, theSerial, getPlayerName( theAdmin ) )
		exports.DENmysql:exec( "INSERT INTO punishlog SET serial=?, punishment=?", theSerial, getPlayerName( theAdmin ).." account banned the account " .. theAccount .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
		exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." the serial " .. theSerial .. " for " .. timeMinutes .. " minutes (" .. theReason .. ")" )
		onPlayerBanned( theSerial, banTime, theReason, thePlayer )
		return true
	else
		return false
	end
end

-- Unban ban
function removeServerBan ( banID )
	return exports.DENmysql:exec ( "DELETE * FROM bans WHERE id=?", banID )
end
