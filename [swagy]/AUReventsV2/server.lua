--exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS eventmanagers (userid INT, name TEXT)")


function openEventsPanel (plr, cmd)

	if (isPlayerEventManager(plr)) then
		triggerClientEvent(plr, "AUReventsv2:openPanel", plr)
	end
end
addCommandHandler("em", openEventsPanel)

for k,v in ipairs (getElementsByType"player") do

	bindKey(v, "O", "down", openEventsPanel)
end

function bindOpenPanel ()

	bindKey(source, "O", "down", openEventsPanel)
end
addEventHandler("onPlayerJoin", resourceRoot, bindOpenPanel)

function isPlayerEventManager ( plr )

	local query = exports.DENmysql:query("SELECT * FROM staff WHERE userid=?", exports.server:getPlayerAccountID(plr))
	if (#query > 0) and (query[1].eventmanager == 1) then
		return true
	else
		return false
	end
end


