local achievement_list = {
	--Name | Description | Award
	{ "Welcome to AuroraRPG", "First time to play AuroraRPG", "points", 5 },
	{ "50 Hours of Playtime", "You reached 50 hours of playtime", "points", 5 },
	{ "100 Hours of Playtime", "You reached 100 hours of playtime", "points", 5 },
	{ "500 Hours of Playtime", "You reached 500 hours of playtime", "points", 10 },
	{ "1000 Hours of Playtime", "You reached 1000 hours of playtime", "points", 20 },
	{ "2000 Hours of Playtime", "You reached 2000 hours of playtime", "points", 30 },
	{ "3000 Hours of Playtime", "You reached 3000 hours of playtime", "points", 40 },
	{ "4000 Hours of Playtime", "You reached 4000 hours of playtime", "points", 50 },
	{ "50 scores", "You reached 50 scores", "cash", 1000 },
	{ "100 scores", "You reached 100 scores", "cash", 5000 },
	{ "500 scores", "You reached 500 scores", "cash", 10000 },
	{ "1000 scores", "You reached 1000 scores", "cash", 20000 },
	{ "5000 scores", "You reached 5000 scores", "cash", 50000 },
	{ "10,000 scores", "You reached 10,000 scores", "cash", 50000 },
	{ "50,000 scores", "You reached 50,000 scores", "cash", 500000 },
	{ "100,000 scores", "You reached 100,000 scores", "cash", 1000000 },
	{ "Getting Arrested (Coming Soon)", "First time to get arrested", "points", 2 },
	{ "Very Important Person", "First time as VIP.", "cash", 500000 },
	{ "Staff", "First time as a staff.", "points", 10 },
	{ "Event Manager", "First time as a event manager.", "points", 10 },
	{ "Bug Finder", "Thanks for helping the server clean. That bug was soo dirty!", "cash", 100000 },
	{ "First Time in Cop Event", "It's your first time on this event!", "points", 15 },
	{ "3x kill streak!", "Damn boy, calm down.", "points", 5 },
}

function givePlayerAward (player, awardID)
	if (not isElement(player)) then return false end
	if (not exports.server:isPlayerLoggedIn(player)) then return false end
	awardID = math.floor(awardID)
	
	if (achievement_list[awardID][1]) then 
		if (not exports.AURcurtmisc:getPlayerAccountData(player, "aurachievements.data") or exports.AURcurtmisc:getPlayerAccountData(player, "aurachievements.data") == "") then
			exports.AURcurtmisc:setPlayerAccountData(player, "aurachievements.data", "[[]]")
		end 
		
		if (exports.AURcurtmisc:getPlayerAccountData(player, "aurachievements.data")) then
			local theTable = {}
			local countable = 0
			local existants =  -1
			local userData = fromJSON(exports.AURcurtmisc:getPlayerAccountData(player, "aurachievements.data"))
			
			for i=1, #userData do
				if (math.floor(userData[i][1]) == awardID) then 
					existants = awardID
				end 
				local theVal = #theTable+1
				theTable[theVal] = {math.floor(userData[i][1]), userData[i][2]}
			end 
			if (existants ~= awardID) then 
				local theVal = #theTable+1
				theTable[theVal] = {awardID, true}
				if (achievement_list[awardID][3] == "points") then 
					exports.CSGscore:givePlayerScore(player, achievement_list[awardID][4])
					outputChatBox(string.format(exports.AURlanguage:getTranslate("Achievement Unlocked: %s - %s", true, player), exports.AURlanguage:getTranslate(achievement_list[awardID][1], true, player), exports.AURlanguage:getTranslate(achievement_list[awardID][2])), player, 66, 244, 98)
					triggerClientEvent(player, "aurachievements.triggerNotifi", player, exports.AURlanguage:getTranslate(achievement_list[awardID][1], true, player), exports.AURlanguage:getTranslate(achievement_list[awardID][2], true, player), "+"..achievement_list[awardID][4].." points")
				elseif (achievement_list[awardID][3] == "cash") then 
					givePlayerMoney (player, achievement_list[awardID][4])
					outputChatBox(string.format(exports.AURlanguage:getTranslate("Achievement Unlocked: %s - %s", true, player), exports.AURlanguage:getTranslate(achievement_list[awardID][1], true, player), exports.AURlanguage:getTranslate(achievement_list[awardID][2])), player, 66, 244, 98)
					triggerClientEvent(player, "aurachievements.triggerNotifi", player, exports.AURlanguage:getTranslate(achievement_list[awardID][1], true, player), exports.AURlanguage:getTranslate(achievement_list[awardID][2], true, player), "+ $"..achievement_list[awardID][4].." cash")
				end 
			end 
			
			exports.AURcurtmisc:setPlayerAccountData(player, "aurachievements.data", toJSON(theTable))
			
			return true 
		end 
		
	else 
		return false 
	end 
end 

function getClientInfo ()
	if (isElement(client)) then 
	if (not exports.server:isPlayerLoggedIn(client)) then return false end
		if (not exports.AURcurtmisc:getPlayerAccountData(client, "aurachievements.data") or exports.AURcurtmisc:getPlayerAccountData(client, "aurachievements.data") == "") then
			exports.AURcurtmisc:setPlayerAccountData(client, "aurachievements.data", "[[]]")
		end 
		local theTable = exports.AURcurtmisc:getPlayerAccountData(client, "aurachievements.data")
		triggerClientEvent(client, "aurachievements.achievement_list", client, toJSON(achievement_list))
		triggerClientEvent(client, "aurachievements.tableUpdate", client, theTable)
	end 
end 
addEvent ("aurachievements.getClientInfo", true)
addEventHandler ("aurachievements.getClientInfo", resourceRoot, getClientInfo)


function isPlayerHasAward (player, awardID)
	if (not isElement(player)) then return false end
	if (not exports.server:isPlayerLoggedIn(player)) then return false end
	awardID = math.floor(awardID)
	
	if (exports.AURcurtmisc:getPlayerAccountData(player, "aurachievements.data")) then
		local theTable = {}
		local userData = fromJSON(exports.AURcurtmisc:getPlayerAccountData(player, "aurachievements.data"))
		for i=1, #userData do
			if (math.floor(userData[i][1]) == awardID) then
				return true
			end 
		end
		return false
	end 
end 

function giveAchievement (plr, cmd, playername, awardID)
	if (getTeamName(getPlayerTeam(plr)) == "Staff")  then 
		--if (getPlayerName(plr) == "Curt") then 
			givePlayerAward(getPlayerFromName(playername), awardID)
			outputChatBox(string.format(exports.AURlanguage:getTranslate("Award Given To %s", true, plr), getPlayerName(getPlayerFromName(playername))), plr, 255, 255, 255)
		--end 
	end 
end 

addCommandHandler("giveach", giveAchievement)