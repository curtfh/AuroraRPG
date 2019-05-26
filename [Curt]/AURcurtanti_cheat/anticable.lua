frozen = false
tag = false
lagX, lagY, lagZ = 0, 0, 0
count = 0
lastByte = 0
local timeout
ping = {}
tap = true

function lagFreezePlayer(theElement, theState, setPos)
	if theState then
		--count = count + 1
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
			count = 0
			setElementFrozen(theElement, false)
			toggleAllControls(true)
		end
	end
end

teams = {
	['Criminals'] = true,
	['Military Forces'] = true,
	['Governemnt'] = true,
}

setTimer(
	function()
			local loss = getNetworkStats(localPlayer)["packetlossLastSecond"]
			local resend = getNetworkStats(localPlayer)["messagesInResendBuffer"]
			local bSent = getNetworkStats(localPlayer)["bytesSent"]
			local x, y, z = getElementPosition(localPlayer)

			local team = getPlayerTeam(localPlayer)
			if team then
				local name = getTeamName(team)
				lagX, lagY, lagZ = x, y, z
				if loss > 40 and resend > 0 then
					if teams[name] then
						lagFreezePlayer(localPlayer, true, true)
						if (not isTimer(timeout)) then
							timeout = setTimer(function() killTimer(timeout) end, 8000, 1)
						end
					end
				else
					if (isTimer(timeout)) then
						return
					end
					lagFreezePlayer(localPlayer, false)
				end
				lastByte = bSent
			end
	end, 500, 0
)

setTimer(
	function()
		if frozen then
			count = count + 1
				exports.NGCnote:addNote("anticable", "Packet Loss Detected ("..count..")", 255, 0, 0)
				if tap == false then
					exports.NGCdxmsg:createNewDxMessage("You have been frozen due to your packet loss is high (Over 30%).", 255, 0, 0)
					tap = true
				end
		else
			exports.NGCnote:addNote("anticable", "", 255, 25, 25, 1)
			if tap == true then
					exports.NGCdxmsg:createNewDxMessage("You have been unfrozed", 0, 255, 0)
					tap = false
				end
		end
	end, 1000, 0
)
