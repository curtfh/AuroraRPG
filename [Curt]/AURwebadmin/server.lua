function getPlayerData (playerName)
	local thePlayer = getPlayerFromName(playerName)
	if (not thePlayer) then return false end
	local data = {}
	local x, y, z = getElementPosition(thePlayer)
	if (not exports.server:isPlayerLoggedIn(thePlayer)) then 
		return false
	end
	table.insert(data,{getPlayerName(thePlayer), getPlayerSerial(thePlayer), exports.server:getPlayerAccountName(thePlayer), getTeamName(getPlayerTeam(thePlayer)),
	getPlayerIP(thePlayer), getPlayerVersion(thePlayer), exports.server:getPlayerAccountEmail(thePlayer), exports.server:getPlayerPlayTime(thePlayer), x, y, z,  
	exports.server:getPlayerOccupation(thePlayer), exports.server:getPlayerWantedPoints(thePlayer), exports.server:getPlayChatZone(thePlayer), exports.server:getPlayerBankBalance(thePlayer),
	exports.server:getPlayerGroup(thePlayer), exports.server:getPlayerGroupRank(thePlayer), exports.server:getPlayerVIPHours(thePlayer), getPlayerMoney(thePlayer),
	getElementHealth(thePlayer), getPedArmor(thePlayer), getElementModel(thePlayer), getElementDimension(thePlayer), getElementInterior(thePlayer)})
	return data
end 

function onAdminCreatePunishment ( thePunished, theAdmin, theAction, serial )
	local playerID = exports.server:getPlayerAccountID( thePunished )
	if not ( playerID ) then return end
	if ( serial ) then
		exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, serial=?, punishment=?", tonumber( playerID ), getPlayerSerial( thePunished ), theAction )
	else
		exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?, serial=?", tonumber( playerID ), theAction, "None" )
	end
	exports.CSGlogging:createAdminLogRow ( theAdmin, theAction )
end

function punishPlayer ( theAdminN, thePlayer, action, arg3, arg4 )
		thePlayer = getPlayerFromName(thePlayer)
		exports.DENpunishments:updateLogs(thePlayer)
		if ( action == "slap" ) and not ( isPedDead( thePlayer ) ) then
			if getElementDimension(thePlayer) == 5001 then
				return "You can't slap this player"
			elseif getElementDimension(thePlayer) == 5002 then
				return "You can't slap this player"
			elseif getElementDimension(thePlayer) == 5003 then
				return "You can't slap this player"
			end
			killPed( thePlayer )
			outputChatBox( "You have been slapped by " .. theAdminN .. " (100HP)", thePlayer, 225, 0, 0 )
			onAdminCreatePunishment ( thePlayer, theAdminN, theAdminN.." slapped " .. getPlayerName( thePlayer ) .. " (100HP)", false )
		elseif ( action == "freeze" ) then
			local vehicle = getPedOccupiedVehicle ( thePlayer )
			if ( isElementFrozen ( thePlayer ) ) then
				outputChatBox( "You have been unfrozen by " .. theAdminN .. "", thePlayer, 225, 0, 0 )
			else
				outputChatBox( "You have been frozen by " .. theAdminN .. "", thePlayer, 225, 0, 0 )
				onAdminCreatePunishment ( thePlayer, theAdminN, theAdminN.." froze " .. getPlayerName( thePlayer ) .. "", false )
			end
			if ( vehicle ) then if ( isElementFrozen( vehicle ) ) then setElementFrozen ( vehicle, false ) else setElementFrozen ( vehicle, true ) end end
			if ( isElementFrozen ( thePlayer ) ) then setElementFrozen ( thePlayer, false ) else setElementFrozen ( thePlayer, true ) end
		elseif ( action == "kick" ) then
			outputChatBox( theAdminN.." kicked " .. getPlayerName( thePlayer ) .. "", root, 225, 0, 0 )
			onAdminCreatePunishment ( thePlayer, theAdminN, theAdminN.." kicked " .. getPlayerName( thePlayer ) .. "", false )
			kickPlayer( thePlayer, "You have been kicked by "..theAdminN )
		elseif ( action == "reconnect" ) then
	        outputChatBox( theAdminN.." reconnected " .. getPlayerName( thePlayer ) .. "", root, 225, 0, 0 )
			redirectPlayer( thePlayer, "5.135.254.123", 22003 )
		end
end 
