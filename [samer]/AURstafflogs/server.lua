addEvent("AURstafflogs.requestData", true)
addEventHandler("AURstafflogs.requestData", root, function()
	local query = exports.DENmysql:query("SELECT * FROM adminlog ORDER BY `timestamp` DESC LIMIT 150")
	triggerClientEvent(client, "AURstafflogs.receiveData", client, query)
end)