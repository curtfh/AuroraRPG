local numToName = {
	[1] = "Ritalin",
	[2] = "LSD",
	[3] = "Cocaine",
	[4] = "Ecstasy",
	[5] = "Heroine",
	[6] = "Weed",
	["Ritalin"] = 1,
	["LSD"] = 2,
	["Cocaine"] = 3,
	["Ecstasy"] = 4,
	["Heroine"] = 5,
	["Weed"] = 6,
}
local drugsTable = {}


addEvent("getDrugsFromQuery",true)
addEventHandler("getDrugsFromQuery",root,function(player)
local id = exports.server:getPlayerAccountID(player)
	local data = exports.DENmysql:querySingle("SELECT `drugs` FROM `playerstats` WHERE `userid` =? LIMIT 1", id)
	if (data) then
		data = fromJSON(data.drugs)
		drugsTable[player] = {}
		drugsTable[player] = data
		triggerClientEvent(source,"sendDrugsFromQuery",source,drugsTable[player],numToName)
	end
end)
