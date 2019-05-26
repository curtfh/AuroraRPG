function getPlayerFromAccountID (id)
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( getElementData( thePlayer, "accountUserID" ) == id ) then
			return true
		end
	end
	return false
end

function getOnlinePlayers()
	print("getting online players")
	local tab = {}
	for k, v in ipairs(getElementsByType("player")) do
		table.insert(tab, getPlayerName(v))
	end
	return tab
end

function sendPM(account, playerName, text)
	local player = getPlayerFromName(playerName)
	if (not player) then return "Player left or is no longer available!" end
	outputChatBox(account.." sent you a PM from the UCP!", player, 0, 255, 0)
	outputChatBox(text, player, 0, 255, 0)
	return true
end