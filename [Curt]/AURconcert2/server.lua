function changelights (typez, value, r, g, b, a)
	triggerClientEvent(root, "AURconcert2.lightaffects", resourceRoot, typez, value, r, g, b, a)
end 
addEvent("AURconcert2.changelights", true)
addEventHandler("AURconcert2.changelights", resourceRoot, changelights)

local handled = false
local partyTimer
local partyStart = false

addCommandHandler("startmusicaur", function ( plr, commandName, url ) 
	--setTimer(triggerClientEvent, 1000, 1, "playmus", root, url)
	if (partyStart == false) then 
		partyTimer = getTickCount()
		outputChatBox("Squence Started!", plr)
		triggerClientEvent(root, "AURconcert2.setDuration", resourceRoot, ((getTickCount()-partyTimer)*0.001))
		partyStart = true
	end
end)

addCommandHandler("resyncmusic", function ( plr, commandName, url ) 
	--setTimer(triggerClientEvent, 1000, 1, "playmus", root, url)
	if (partyStart == true) then 
		outputChatBox("Resync everyone!", plr)
		triggerClientEvent(root, "AURconcert2.setDuration", resourceRoot, ((getTickCount()-partyTimer)*0.001))
	end
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

function getDuration ()
	if (partyStart == true) then 
		triggerClientEvent(client, "AURconcert2.setDuration", resourceRoot, (getTickCount()-partyTimer)*0.001)
		outputDebugString("Sending Sync"..(getTickCount()-partyTimer)*0.001)
	end
end
addEvent("AURconcert2.getDuration", true)
addEventHandler("AURconcert2.getDuration", resourceRoot, getDuration)

function initstopmusic()
	if (handled == true) then
		setTimer(triggerClientEvent, 1000, 1, "NGCconcert.stopmusic", root)
		handled = false
	end
end
addEvent("NGCconcert.initstopmusic", true)
addEventHandler("NGCconcert.initstopmusic", root, initstopmusic)