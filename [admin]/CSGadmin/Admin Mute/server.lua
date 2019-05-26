local mutesTable = {}

-- Function to mute a player
function adminMutePlayer ( theAdmin, thePlayer, theReason, theTime, theType, multiplier, hidden )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	if ( isElement( thePlayer ) ) and ( userID ) and ( theTime ) and ( theType ) then
		local multiplier = (multiplier and 1 or 0)
		local highestPunishment = 5

		if (multiplier == 1) then
			local accPunishments = exports.DENmysql:query( "SELECT * FROM punishlog WHERE userid=? AND multiplier=? AND active=?", exports.server:getPlayerAccountID( thePlayer ), 1, 1 )
			for i, v in ipairs(accPunishments) do
				if (v['punishment']:find(" muted ")) then
					local punishmentTime = string.match(v['punishment'], "%d+")
					if (tonumber(punishmentTime) > highestPunishment) then
						highestPunishment = tonumber(punishmentTime)
					end
				end
			end
			if (highestPunishment == 5) then
				theTime = (5 * 60)
			else
				theTime = math.floor((highestPunishment * 60) * 2)
			end
		end
		-- First unmute the player and then mute him again if he's already muted
		adminUnmutePlayer ( thePlayer, theAdmin )
		exports.DENmysql:exec( "INSERT INTO mutes SET userid=?, mutetime=?, mutetype=?", userID, theTime, theType )
		triggerClientEvent( thePlayer, "onPlayerMute", thePlayer, theTime,theType,thePlayer )
		mutesTable[thePlayer] = theType
		setElementData(thePlayer,"muteType",theType)
		--outputDebugString(theType)
		-- Output etc.
		if ( theReason ) and ( theAdmin ) then
			-- taking money and score
			exports.CSGscore:takePlayerScore(thePlayer, 150)
			local cash = getPlayerMoney(thePlayer)
			local bankQuery = exports.DENmysql:querySingle("SELECT * FROM banking WHERE userid=?", userID)
			local bankMoney = bankQuery['balance']
			if (cash > 500000) then
				takePlayerMoney(thePlayer, 500000)
			elseif (cash < 500000) and (cash + bankMoney > 500000) then
				local diff = 500000 - cash
				setPlayerMoney(thePlayer, 0)
				exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", bankMoney - diff, userID)
			else
				takePlayerMoney(thePlayer, 500000)
				--exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", 0, userID)
			end
			local thePlayersName = ""
			if (hidden == "Hidden player") then
				thePlayersName = "hidden player"
			else
				thePlayersName = getPlayerName(thePlayer)
			end
			if ( theType == "Main" ) then
				triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?, multiplier=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")", multiplier )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
				setTimer(function(theAdmin, thePlayer, theReason, theTime, theType)
					outputChatBox( getPlayerName( theAdmin ).." muted " .. thePlayersName .. " for " .. math.floor(theTime/60) .. " minutes (" .. theReason .. ")", root, 255, 0, 0 )
				end,2000,1,theAdmin, thePlayer, theReason, theTime, theType)
			elseif ( theType == "Global" ) then
				triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." global muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?, multiplier=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." global muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")", multiplier )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." global muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
				setTimer(function(theAdmin, thePlayer, theReason, theTime, theType)
					outputChatBox( getPlayerName( theAdmin ).." global muted " .. thePlayersName .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")", root, 255, 0, 0 )
				end,2000,1,theAdmin, thePlayer, theReason, theTime, theType)
			elseif ( theType == "Support" ) then
				triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." support channel muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
				exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?, multiplier=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." support channel muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")", multiplier )
				exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." support channel muted " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
				setTimer(function(theAdmin, thePlayer, theReason, theTime, theType)
					outputChatBox( getPlayerName( theAdmin ).." support channel muted " .. thePlayersName .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")", root, 255, 0, 0 )
				end,2000,1,theAdmin, thePlayer, theReason, theTime, theType)
			end
		end
	end
end

-- Function to unmute a player
addEvent( "onAdminUnmutePlayer", true )
function adminUnmutePlayer ( thePlayer, theAdmin, plr )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	if ( mutesTable[thePlayer] ) and ( getPlayerMute ( thePlayer ) ) and ( userID ) then
		if (plr) then
			playersName = "Hidden player"
		else
			playersName = getPlayerName(thePlayer)
		end
		if ( theAdmin ) then
			outputChatBox( playersName.." got unmuted! (Unmuted by " .. getPlayerName( theAdmin ) .. ")", root, 0, 225, 0 )
			exports.DENmysql:exec( "DELETE FROM mutes WHERE userid=?", userID )
			mutesTable[thePlayer] = false
			triggerClientEvent( thePlayer, "onRemovePlayerMute", thePlayer )
			setElementData( thePlayer, "muteTimeRemaining", false )
			setElementData(thePlayer,"muteType",false)
		else
			outputChatBox( playersName.." got unmuted! (Mute expired)", root, 0, 225, 0 )
			exports.DENmysql:exec( "DELETE FROM mutes WHERE userid=?", userID )
			mutesTable[thePlayer] = false
			triggerClientEvent( thePlayer, "onRemovePlayerMute", thePlayer )
			setElementData( thePlayer, "muteTimeRemaining", false )
			setElementData(thePlayer,"muteType",false)
		end
	end
end
addEventHandler( "onAdminUnmutePlayer", root, adminUnmutePlayer )

-- Function to get the mute type of a player
function getPlayerMute ( thePlayer )
	if (getElementData(thePlayer, "banned") == true) then 
		return "Global"
	end 
	if ( mutesTable[thePlayer] ) then
		return mutesTable[thePlayer]
	else
		return false
	end
end

-- When a player quits
addEventHandler( "onPlayerQuit", root,
	function ()
		if ( mutesTable[source] ) then
			local userID = exports.server:getPlayerAccountID( source )
			exports.DENmysql:exec( "UPDATE mutes SET mutetime=? WHERE userid=?", getElementData( source, "muteTimeRemaining" ), userID )
		end
	end
)

addEventHandler("onPlayerCommand",root,function(cmd)
	if cmd == "reconnect" or cmd == "quit" or cmd == "disconnect" or cmd == "exit" or cmd == "connect" then
		local userID = exports.server:getPlayerAccountID( source )
		exports.DENmysql:exec( "UPDATE mutes SET mutetime=? WHERE userid=?", getElementData( source, "muteTimeRemaining" ) or 600000, userID )
	end
end)

-- When a player login
addEvent( "onServerPlayerLogin" )
addEventHandler( "onServerPlayerLogin", root,
	function ( userID )
		local muteTable = exports.DENmysql:querySingle( "SELECT * FROM mutes WHERE userid=?", userID )
		if ( muteTable ) then
			adminMutePlayer ( false, source, false, muteTable.mutetime, muteTable.mutetype )
		end
	end
)

-- When a player login
addEventHandler( "onResourceStart", resourceRoot,
	function ()
		setTimer(function()
		for k,v in ipairs(getElementsByType("player")) do
			setElementData( v, "muteTimeRemaining", false )
			setElementData(v,"muteType",false)
			local muteTable = exports.DENmysql:querySingle( "SELECT * FROM mutes WHERE userid=?", exports.server:getPlayerAccountID(v) )
			if ( muteTable ) then
				adminMutePlayer( false, v, false, muteTable.mutetime, muteTable.mutetype )
				outputDebugString(getPlayerName(v))
			end
		end
		end,10000,1)
	end
)
