-- Function to set a player stat
function getPlayerAccountData(plr, data)
	if (not plr) or (not data) then return false end
	if (not isElement(plr)) or (not exports.server:isPlayerLoggedIn(plr)) then return false end
	
	local userID = exports.server:getPlayerAccountID(plr)
	
	local theData = exports.DENmysql:querySingle("SELECT `??` FROM `playerstats` WHERE `userid`=? LIMIT 1", data, userID)
	if (theData) then 
		return theData[data]
	else
		exports.DENmysql:exec ("INSERT INTO `playerstats` SET userid=?", userID)
		return ""
	end
	
end

function setPlayerAccountData(plr, data, value)
 	if (not isElement(plr)) then return false end
	local userID = exports.server:getPlayerAccountID(plr)
	if (not userID) then return false end
	
	local theData = exports.DENmysql:querySingle("SELECT userid FROM `playerstats` WHERE `userid`=? LIMIT 1", userID)
	if (theData) then 
		exports.DENmysql:exec("UPDATE `playerstats` SET `??`=? WHERE `userid`=?", data, value, userID)
	return true
	else
		exports.DENmysql:exec ("INSERT INTO `playerstats` SET userid=?, ?=?", userID, data, value)
		return true
	end
	
end


function rtdamanges ( attacker, weapon, bodypart, loss ) 
	--if (exports.CSGnewturfing2:isPlayerInRT (getRootElement())) then return end
	if (getElementDimension(source) ~= 0) then return false end
	if (exports.server:getPlayChatZone(source) ~= "LV") then return false end
	if (getTeamName(getPlayerTeam(source)) ~= "Criminals") then return false end
	if (exports.server:getPlayerGroupID(source) == exports.server:getPlayerGroupID(attacker)) then 
		cancelEvent ()
	end 
end
addEventHandler ( "onPlayerDamage", getRootElement (), rtdamanges )

function operHackMonitor (player, cmd)
	if (exports.CSGstaff:isPlayerStaff(player)) and (getTeamName(getPlayerTeam(player)) == "Staff") then 
		--if (exports.CSGstaff:getPlayerAdminLevel(player) >= 5) then 
			if (getElementData(player, "AURcurtmisc.hackmonitor") == true) then 
				setElementData(player, "AURcurtmisc.hackmonitor", false)
				exports.NGCdxmsg:createNewDxMessage(player,"You are no longer able to see chats!",255,0,0)
			else 
				setElementData(player, "AURcurtmisc.hackmonitor", true)
				exports.NGCdxmsg:createNewDxMessage(player,"You are now able to see chats!",255,255,255)
			end
		--end
	end
end
addCommandHandler("hms", operHackMonitor)

function watchCommand (player, cmd, thePlayer)
	if (exports.CSGstaff:isPlayerStaff(player)) then 
		if (getElementData(player, "AURcurtmisc.hackmonitorcommand") == true) then 
			setElementData(player, "AURcurtmisc.hackmonitorcommand", false)
			setElementData(player, "AURcurtmisc.hackmonitorcommand.namepart", false)
			exports.NGCdxmsg:createNewDxMessage(player,"You are no longer able to see commands!",255,0,0)
		else 
			setElementData(player, "AURcurtmisc.hackmonitorcommand", true)
			setElementData(player, "AURcurtmisc.hackmonitorcommand.namepart", thePlayer)
			exports.NGCdxmsg:createNewDxMessage(player,"You are now able to see commands!",255,255,255)
		end
	end  
end 
addCommandHandler("watchcmd", watchCommand)

addEventHandler("onPlayerCommand",root,
function(command)
	for k,v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "AURcurtmisc.hackmonitorcommand") == true) then 
			local player = exports.server:getPlayerFromNamePart(getElementData(v, "AURcurtmisc.hackmonitorcommand.namepart"))
			if (player == source) then 
				outputChatBox(">>"..getPlayerName(source).." executed command "..command, v, 255, 255, 255)
			end
		end
	end
end)