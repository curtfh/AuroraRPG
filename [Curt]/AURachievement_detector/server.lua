function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
function detectWhenLoggedIn ()
	local player = source
	if (not exports.server:isPlayerLoggedIn(player)) then return false end
	local playtime = round((exports.server:getPlayerPlayTime(player)+5)/60)
	local score = getElementData(player, "playerScore")
	local staff = getTeamName(getPlayerTeam(player))

	if (playtime >= 4000) then 
		exports.AURachievements:givePlayerAward(player, 8)
	end
	if (playtime >= 3000) then 
		exports.AURachievements:givePlayerAward(player, 7)
	end
	if (playtime >= 2000) then 
		exports.AURachievements:givePlayerAward(player, 6)
	end
	if (playtime >= 1000) then 
		exports.AURachievements:givePlayerAward(player, 5)
	end
	if (playtime >= 500) then 
		exports.AURachievements:givePlayerAward(player, 4)
	end
	if (playtime >= 100) then 
		exports.AURachievements:givePlayerAward(player, 3)
	end
	if (playtime >= 50) then 
		exports.AURachievements:givePlayerAward(player, 2)
	end 
	exports.AURachievements:givePlayerAward(player, 1)
	
	if (score >= 100000) then 
		exports.AURachievements:givePlayerAward(player, 16)
	end
	if (score >= 50000) then 
		exports.AURachievements:givePlayerAward(player, 15)
	end
	if (score >= 10000) then 
		exports.AURachievements:givePlayerAward(player, 14)
	end
	if (score >= 5000) then 
		exports.AURachievements:givePlayerAward(player, 13)
	end
	if (score >= 1000) then 
		exports.AURachievements:givePlayerAward(player, 12)
	end
	if (score >= 500) then 
		exports.AURachievements:givePlayerAward(player, 11)
	end
	if (score >= 100) then 
		exports.AURachievements:givePlayerAward(player, 10)
	end
	if (score >= 50) then 
		exports.AURachievements:givePlayerAward(player, 9)

	end
	if (vip == true) then 
		exports.AURachievements:givePlayerAward(player, 18)
	end 
	
	
	if (staff == "Staff") then 
		exports.AURachievements:givePlayerAward(player, 19)
	end 


end 
addEventHandler("onPlayerLogin", root, detectWhenLoggedIn)


function detectPlaytimeTimer ()
	for index, player in pairs(getElementsByType("player")) do
		if (not exports.server:isPlayerLoggedIn(player)) then return false end
		local playtime = round((exports.server:getPlayerPlayTime(player)+5)/60)
		local score = getElementData(player, "playerScore")
		local staff = getTeamName(getPlayerTeam(player))
		local vip = exports.server:isPlayerVIP(player)
		

		if (playtime >= 4000) then 
			exports.AURachievements:givePlayerAward(player, 8)
		end
		if (playtime >= 3000) then 
			exports.AURachievements:givePlayerAward(player, 7)
		end
		if (playtime >= 2000) then 
			exports.AURachievements:givePlayerAward(player, 6)
		end
		if (playtime >= 1000) then 
			exports.AURachievements:givePlayerAward(player, 5)
		end
		if (playtime >= 500) then 
			exports.AURachievements:givePlayerAward(player, 4)
		end
		if (playtime >= 100) then 
			exports.AURachievements:givePlayerAward(player, 3)
		end
		if (playtime >= 50) then 
			exports.AURachievements:givePlayerAward(player, 2)
		end 
		exports.AURachievements:givePlayerAward(player, 1)
		
		if (score >= 100000) then 
			exports.AURachievements:givePlayerAward(player, 16)
		end
		if (score >= 50000) then 
			exports.AURachievements:givePlayerAward(player, 15)
		end
		if (score >= 10000) then 
			exports.AURachievements:givePlayerAward(player, 14)
		end
		if (score >= 5000) then 
			exports.AURachievements:givePlayerAward(player, 13)
		end
		if (score >= 1000) then 
			exports.AURachievements:givePlayerAward(player, 12)
		end
		if (score >= 500) then 
			exports.AURachievements:givePlayerAward(player, 11)
		end
		if (score >= 100) then 
			exports.AURachievements:givePlayerAward(player, 10)
		end
		if (score >= 50) then 
			exports.AURachievements:givePlayerAward(player, 9)

		end
		
		if (vip == true) then 
			exports.AURachievements:givePlayerAward(player, 18)
		end 
		
		if (staff == "Staff") then 
			exports.AURachievements:givePlayerAward(player, 19)
		end 
		--outputDebugString(getPlayerName(player).." - "..score.." - "..vip, 3, 0, 255, 0)
	end
end 
setTimer(detectPlaytimeTimer, 300000, 0)
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), detectPlaytimeTimer)

