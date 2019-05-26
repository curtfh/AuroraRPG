local dims = {[5001]=true, [5002]=true,[5003]=true,[5004]=true,[5005]=true, [5006]=true}

function transferedDim (thePlayer, lastDim)
	if (dims[getElementDimension(thePlayer)]) then 
		for k, thePlayers in ipairs ( getElementsByType( "player" ) ) do
			if (getElementDimension(thePlayers) == getElementDimension(thePlayer)) then
				exports.killmessages:outputMessage( "[+] "..getPlayerName(thePlayer).." joined the room", thePlayers, 0, 255, 0)
			end
		end
	
	elseif (dims[lastDim]) then 
		for k, thePlayers in ipairs ( getElementsByType( "player" ) ) do
			if (getElementDimension(thePlayers) == lastDim) then
				exports.killmessages:outputMessage( "[-] "..getPlayerName(thePlayer).." left the room", thePlayers, 255, 0, 0)
			end
		end
		exports.killmessages:outputMessage( "[-] "..getPlayerName(thePlayer).." left the room", thePlayer, 255, 0, 0)
	end 
end 
addEvent("AURroomsquitjoin.messageToDim", true)
addEventHandler("AURroomsquitjoin.messageToDim", resourceRoot, transferedDim)