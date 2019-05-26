local handled = false

addCommandHandler("startmusic", function ( plr, commandName, url ) 
	setTimer(triggerClientEvent, 1000, 1, "playmus", root, url)
end)

function startmusic(url, plr)
	if (url and plr) then
		if (handled == false) then
			local name = getPlayerName(plr)
			setTimer(triggerClientEvent, 1000, 1, "NGCconcert.playmus", root, url, name)
			handled = true
		end
	end
end
addEvent("NGCconcert.startmusic", true)
addEventHandler("NGCconcert.startmusic", root, startmusic)

function initstopmusic()
	if (handled == true) then
		setTimer(triggerClientEvent, 1000, 1, "NGCconcert.stopmusic", root)
		handled = false
	end
end
addEvent("NGCconcert.initstopmusic", true)
addEventHandler("NGCconcert.initstopmusic", root, initstopmusic)