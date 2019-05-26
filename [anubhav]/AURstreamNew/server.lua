function isPlayerAllowed(player)
	if (getElementData(player, "VIP") == "Yes") then
		return true 
	end
	if (exports.CSGstaff:isPlayerStaff(player)) then
		return true 
	end
	return false
end

function openWindow(player)
	if (not isPlayerAllowed(player)) then
		return false 
	end
	triggerClientEvent(player, "AURstreamNew.window", player)
end
addCommandHandler("stream", openWindow)

function songRecieve(url, x, y, z)
	triggerClientEvent("AURstreamNew.playSong", root, url, x, y, z, client)
end
addEvent("AURstreamNew.playSong", true)
addEventHandler("AURstreamNew.playSong", root, songRecieve)

function songSend()
	triggerClientEvent("AURstreamNew.stopSong", root, client)
end
addEvent("AURstreamNew.stopSong", true)
addEventHandler("AURstreamNew.stopSong", root, songSend)