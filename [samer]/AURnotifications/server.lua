-- Get a player from a account name
function getPlayerFromAccountname(theName)
	local lowered = string.lower(tostring(theName))
	print("Searching for "..lowered)
	for k,v in ipairs (getElementsByType ("player" )) do
		if (getElementData(v, "playerAccount")) and (string.lower(getElementData(v, "playerAccount")) == lowered) then
			return v
		end
	end
end

function startDatabase()
	if (not getResourceFromName("DENmysql")) or (getResourceState(getResourceFromName("DENmysql")) == "loaded") then
		cancelEvent()
		outputChatBox(""..getResourceName(getThisResource()).." failed to start due to some MySQL resource failure.", root, 255, 0, 0)
	else
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS notifications (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, accName TEXT, datum timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, notificationText TEXT)")
		for k, v in ipairs(getElementsByType("player")) do
			local res = exports.DENmysql:query("SELECT * FROM notifications WHERE accName=? ORDER BY datum ASC", exports.server:getPlayerAccountName(v))
			triggerClientEvent(v, "AURnotifications.receiveNotifications", v, res)
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, startDatabase)

function bringUpPanel(plr)
	local res = exports.DENmysql:query("SELECT * FROM notifications WHERE accName=? ORDER BY datum ASC", exports.server:getPlayerAccountName(plr))
	if (#res > 0) then
		triggerClientEvent(plr, "AURnotifications.receiveNotifications", plr, res)
		triggerClientEvent(plr, "AURnotifications.openNotificationsPanel", plr)
	end
end
addCommandHandler("notifications", bringUpPanel)

function addNotification(accName, text)
	local guy = getPlayerFromAccountname(tostring(accName))
	exports.DENmysql:exec("INSERT INTO notifications (accName, notificationText) VALUES(?,?)", accName, text)
	if (guy) then
		print("Output to "..getPlayerName(guy).." of his new notif.")
		local res = exports.DENmysql:query("SELECT * FROM notifications WHERE accName=? ORDER BY datum ASC", accName)
		triggerClientEvent(guy, "AURnotifications.receiveNotifications", guy, res)
	end
end

function deleteNotification(id)
	exports.DENmysql:exec("DELETE FROM notifications WHERE id=?", id)
end
addEvent("AURnotifications.deleteNotification", true)
addEventHandler("AURnotifications.deleteNotification", root, deleteNotification)

function onLogin()
	print("Getting "..getPlayerName(source).."'s notifications")
	local res = exports.DENmysql:query("SELECT * FROM notifications WHERE accName=? ORDER BY datum ASC", exports.server:getPlayerAccountName(source))
	triggerClientEvent(source, "AURnotifications.receiveNotifications", source, res)
	if (#res > 0) then
		outputChatBox("You have "..#res.." unread notification(s), press 'm' then on the icon to open them, press escape to close.", source, 255, 0, 0)
	end
end
addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", root, onLogin)