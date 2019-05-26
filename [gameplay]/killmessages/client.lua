killStreaks = {}
counter = 8

function getPlayerKillStreak(name)
	if (not name) then return "" end
	local player = getPlayerFromName(name)
	if (player) then
		if (killStreaks[player][1] > 1) then
			return " (x"..killStreaks[player][1]..")"
		else
			return ""
		end
	else
		return ""
	end
end

function setPlayerKillStreak(player)
	if (player and getElementType(player) == "player") then
		if (not killStreaks[player]) then
			killStreaks[player] = {1, 0}
		end
		if (killStreaks[player][2] >= getTickCount()) then
			killStreaks[player] = {killStreaks[player][1] + 1, getTickCount() + (counter*1000)}
		else
			killStreaks[player] = {1, getTickCount() + (counter*1000)}
		end
		if killStreaks[player][1] == 2 then
			--local filename = "sounds/doublekill.mp3"
			--triggerEvent("playStreakSound",player,filename)
		elseif killStreaks[player][1] == 3 then
			--local filename = "sounds/ultrakill.mp3"
			--triggerEvent("playStreakSound",player,filename)
		elseif killStreaks[player][1] == 4 then
			--local filename = "sounds/unbelievable.mp3"
			--triggerEvent("playStreakSound",player,filename)
		elseif killStreaks[player][1] > 4 then
		--	local filename = "sounds/fantastic.mp3"
			--triggerEvent("playStreakSound",player,filename)
		end
		return true
	end
end

function onPlayerQuit()
	if (killStreaks[source]) then
		killStreaks[source] = nil
	end
end
addEventHandler("onClientPlayerQuit", root, onPlayerQuit)

--addEvent("playStreakSound",true)
--addEventHandler("playStreakSound",localPlayer,function(filename)
	--playSound(filename,false)
--end)

