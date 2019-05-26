local serialT = {}
local accountT = {}
-- Export to get the punishments of a player
function getPlayerPunishlog ( thePlayer, k )
	if ( isElement( thePlayer ) ) then
		local userID = exports.server:getPlayerAccountID( thePlayer )
		local userSerial = getPlayerSerial( thePlayer )
		if ( userID ) then
			if ( k ) then
				local accountTable  = exports.DENmysql:query( "SELECT * FROM punishlog WHERE userid=? ORDER BY datum ASC", userID )
				local serialTable = exports.DENmysql:query( "SELECT * FROM punishlog WHERE serial=? ORDER BY datum ASC", userSerial )
				return serialTable, accountTable
			else
				local accountTable  = exports.DENmysql:query( "SELECT * FROM punishlog WHERE userid=? AND active=? ORDER BY datum ASC", userID, 1 )
				local serialTable = exports.DENmysql:query( "SELECT * FROM punishlog WHERE serial=? AND active=? ORDER BY datum ASC", userSerial, 1 )
				return serialTable, accountTable
			end
		else
			return false, false
		end
	else
		return false, false
	end
end

function updateLogs (player)
	local serialTable, accountTable = getPlayerPunishlog (player)
	serialT[player] = serialTable
	accountT[player] = accountTable
end 

-- Even triggerd when the player want to see his punishments
addEventHandler("onServerPlayerLogin",root,function()
	local serialTable, accountTable = getPlayerPunishlog ( source )
	serialT[source] = serialTable
	accountT[source] = accountTable
end)
-- Even triggerd when the player want to see his punishments
addEventHandler("onPlayerJailed",root,function()
	local serialTable, accountTable = getPlayerPunishlog ( source )
	serialT[source] = serialTable
	accountT[source] = accountTable
end)


-- Even triggerd when the player want to see his punishments
addEvent("onSetPlayerMuted",true)
addEventHandler("onSetPlayerMuted",root,function()
	local serialTable, accountTable = getPlayerPunishlog ( source )
	serialT[source] = serialTable
	accountT[source] = accountTable
end)


local antiSpam = {}

addCommandHandler("punishments",function(player)
	if exports.server:getPlayerAccountID(player) then
		if serialT[player] or accountT[player] then
			if isTimer(antiSpam[player]) then
				exports.NGCdxmsg:createNewDxMessage(player,"You can open punishments panel once every 1 minute",255,0,0)
			return false end
			antiSpam[player] = setTimer(function() end,60000,1)
			exports.NGCdxmsg:createNewDxMessage(player,"(Punishments panel) You will receive punishments data on logging",255,255,0)
			triggerClientEvent( player, "showPunishmentsWindow", player, accountT[player], serialT[player] )
			--if serialT[player] then serialT[player] = nil end
			--if accountT[player] then accountT[player] = nil end
		else
			updateLogs(player)
			if isTimer(antiSpam[player]) then
				exports.NGCdxmsg:createNewDxMessage(player,"You can open punishments panel once every 1 minute",255,0,0)
			return false end
			antiSpam[player] = setTimer(function() end,60000,1)
			exports.NGCdxmsg:createNewDxMessage(player,"(Punishments panel) You will receive punishments data on logging",255,255,0)
			triggerClientEvent( player, "showPunishmentsWindow", player, accountT[player], serialT[player] )
		end
	end
end)

addEventHandler("onPlayerLogout",root,function()
	if serialT[source] then serialT[source] = nil end
	if accountT[source] then accountT[source] = nil end
end)

addEventHandler("onPlayerQuit",root,function()
	if serialT[source] then serialT[source] = nil end
	if accountT[source] then accountT[source] = nil end
end)
