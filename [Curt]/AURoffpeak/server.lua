local startoffpeak = 18
local endoffpeak = 04
local enabled = false

function giveEveryone ()
	if (enabled == false) then return end
	for index, player in pairs(getElementsByType("player")) do
		if (exports.server:isPlayerLoggedIn(player)) then 
			outputChatBox("OFF PEAK: We gave you a 1x 'Aurora Case' for being online at this time.", player, 255, 255, 0)
			outputChatBox("OFF PEAK: To open Aurora Case. Type /cases.", player, 255, 255, 0)
			exports.AURcases:giveCase(player, 1)
		end 
	end 
end
setTimer(giveEveryone, 1800000, 0)

setTimer(function()
	local time = getRealTime()
	local hours = time.hour
	if (hours >= startoffpeak or hours <= endoffpeak) then 
		if (enabled == false) then 
			enabled = true
			outputChatBox("OFF PEAK: On this time, you'll receive Aurora Cases.", root, 255, 255, 0)
			giveEveryone()
			return 
		end 
	else
		if (enabled == true) then 
			enabled = false
			outputChatBox("OFF PEAK: On this time, off peak giveaway has been ended.", root, 255, 255, 0)
			giveEveryone()
			return
		end 
	end
	
end, 1000, 0)

addEventHandler("onServerPlayerLogin", root, function()
	if (enabled == true) then 
			outputChatBox("OFF PEAK: On this time, you'll receive Aurora Cases.", source, 255, 255, 0)
		end 
end)