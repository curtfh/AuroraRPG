function screenshotGUIOpenClose(player)
	triggerClientEvent(player, "AURscreenshot.t", player)
end
addCommandHandler("screenshots", screenshotGUIOpenClose)

function takePlayerScreen(w, h)
	takePlayerScreenShot(client, w, h, "1234566778808005102421")
end
addEvent("AURscreenshot.takess", true)
addEventHandler("AURscreenshot.takess", root, takePlayerScreen)

function ssSaveClient(resource, status, data, _, tag)
	if (tag ~= "1234566778808005102421") then
		return false 
	end
	if (resource ~= getThisResource()) then
		return false 
	end
	if (status ~= "ok") then
		outputChatBox("Failed to take screenshot because: 1. minimized screen 2. disabled screen uploads in settings", source, 255, 0, 0)
		return false
	end
	triggerClientEvent(source, "AURscreenshot.ssData", source, data)
end
addEventHandler("onPlayerScreenShot", root, ssSaveClient)