local frozen = false
local tag = false
local lastByte = 0
local count = 0

function lagFreezePlayer(theElement, theState, setPos)
	if theState then
		if not frozen then
			frozen = true
			tag = true
			setElementFrozen(theElement, true)
			toggleAllControls(false)
		end
		if setPos then
			setElementPosition(theElement, lagX, lagY, lagZ)
		end
	else
		if frozen then
			frozen = false
			tag = false
			setElementFrozen(theElement, false)
			toggleAllControls(true)
		end
	end
end

setTimer(
	function()
			local loss = getNetworkStats(localPlayer)["packetlossLastSecond"]
			local resend = getNetworkStats(localPlayer)["messagesInResendBuffer"]
			local bSent = getNetworkStats(localPlayer)["bytesSent"]
			local team = getPlayerTeam(localPlayer)
			
			if (loss > 20 and resend > 0) then
				count = count + 1
				if (count > 5) then 
					--lagFreezePlayer(localPlayer, true, true)
				end 
				triggerServerEvent ( "AURcurt_anticheat.outputDetect", resourceRoot, getPlayerName(localPlayer), loss )
			else
				--lagFreezePlayer(localPlayer, false)
				--outputDebugString("Your not lagging "..loss.."|"..resend)
				count = 0
			end
			lastByte = bSent
	end, 2000, 0
)
