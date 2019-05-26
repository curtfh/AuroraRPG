local lastDebug, lastDebugTime = "", 0

function debugMessage(message, level, file, line, r, g, b)
	if (not file or not line) then
		return false
	end
	cancelEvent()
	mess = "("..getPlayerName(localPlayer)..") "
	mess = mess..file.."\:"..line.."\: "..message
	if (lastDebug == message) then
		if (getTickCount() - lastDebugTime < 15000) then
			return false
		end
	end
	lastDebug = message
	lastDebugTime = getTickCount()
	triggerServerEvent("AURdebugTools.clientDebug", resourceRoot, level, mess, r, g, b, message)
end
addEventHandler("onClientDebugMessage", root, debugMessage)