local pollInUse = false
local question =  ""
local choice1 = ""
local choice2 = ""
local choice3 = ""
local choice4 = ""

local vote1 = 0
local vote2 = 0
local vote3 = 0
local vote4 = 0

local playerSet 


function pollSetQuestion (player, command, ...)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff")  then return end 
	if (pollInUse == true) then 
		outputChatBox("The poll is on use. To end it type /pollstop.", player, 255, 0, 0)
		return
	end 
	local aq = table.concat ( { ... }, " " )
	question = aq
	outputChatBox("The question has been set to:", player, 66, 244, 209)
	outputChatBox(aq, player, 66, 244, 209)
	playerSet = player
end 
addCommandHandler("pollquestion", pollSetQuestion)




function pollSetChoices (player, command, choice, ...)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff")  then return end 
	if (pollInUse == true) then 
		outputChatBox("The poll is on use. To end it type /pollstop.", player, 255, 0, 0)
		return
	end 
	local aq = table.concat ( { ... }, " " )
	
	if (choice == "a" or choice == "A") then 
		outputChatBox("The letter A choice has been set to:", player, 66, 244, 209)
		outputChatBox(aq, player, 66, 244, 209)
		choice1 = aq
	end 
	
	if (choice == "b" or choice == "B") then 
		outputChatBox("The letter B choice has been set to:", player, 66, 244, 209)
		outputChatBox(aq, player, 66, 244, 209)
		choice2 = aq
	end 
	
	if (choice == "c" or choice == "C") then 
		outputChatBox("The letter C choice has been set to:", player, 66, 244, 209)
		outputChatBox(aq, player, 66, 244, 209)
		choice3 = aq
	end 
	
	if (choice == "d" or choice == "D") then 
		outputChatBox("The letter D choice has been set to:", player, 66, 244, 209)
		outputChatBox(aq, player, 66, 244, 209)
		choice4 = aq
	end
	
	
end 
addCommandHandler("pollsetchoice", pollSetChoices)

function pollStart(player, command)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff")  then return end 
	if (pollInUse == true) then 
		outputChatBox("The poll is on use. To end it type /pollstop.", player, 255, 0, 0)
		return
	end 
	if (question == "") then 
		outputChatBox("Cannot start poll due to the question is not yet set. To set type /pollquestion <your question>", player, 255, 0, 0)
		return 
	end 
	if (choice1 == "") and (choice2 == "") then
		outputChatBox("Atleast 2 or 4 choices are required. To set type /pollsetchoice <letter> <choice message>", player, 255, 0, 0)
		return 
	end 
	
	for index, players in pairs(getElementsByType("player")) do

		outputChatBox("Poll Started by "..getPlayerName(player)..".", players, 66, 244, 209)
		outputChatBox("#ffffffQuestion: #42f44e"..question, players, 66, 244, 209, true)
		outputChatBox("#ffffffChoices: ", players, 255, 0, 0, true)
		if (choice1 ~= "") then
			outputChatBox("#42f44eA. "..choice1, players, 255, 0, 0, true)
		end 
		if (choice2 ~= "") then 
			outputChatBox("#42f44eB. "..choice2, players, 255, 0, 0, true)
		end
		if (choice3 ~= "") then 
			outputChatBox("#42f44eC. "..choice3, players, 255, 0, 0, true)
		end
		if (choice4 ~= "") then 
			outputChatBox("#42f44eD. "..choice4, players, 255, 0, 0, true)
		end
		
		outputChatBox("#d5db20To answer type /poll <letter> | For example /poll e |", players, 255, 0, 0, true)
		outputChatBox("#d5db20Choose wisely or else you cannot change your answer.", players, 66, 244, 209, true)
		setElementData(players, "aurvotepoll.choice", "")
	end 	
	pollInUse = true
	playerSet = player
end 
addCommandHandler("pollstart", pollStart)

function poll (player, command, letter)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff")  then return end 
	if (pollInUse == false) then return end 
	if (letter == nil or letter == "") then
		outputChatBox("Syntax: Type /poll <letter> | For example /poll e", player, 255, 0, 0)
	end 
	
	if (letter == "a" or letter == "A") then 
		if (choice1 ~= "") then
			if (getElementData(player, "aurvotepoll.choice") ~= "") then 
				outputChatBox("Error: You cannot change your answer.", player, 255, 0, 0)
				return
			end 
			vote1 = vote1 + 1
			setElementData(player, "aurvotepoll.choice", 1)
			outputChatBox("You choose: "..choice1, player, 66, 244, 209)
			outputChatBox(getPlayerName(player).." anwered the poll ("..(vote1+vote2+vote3+vote4).."/"..getPlayerCount()..")", playerSet, 66, 244, 209)
		end 
	end 
	
	if (letter == "b" or letter == "B") then 
		if (choice2 ~= "") then 
			if (getElementData(player, "aurvotepoll.choice") ~= "") then 
				outputChatBox("Error: You cannot change your answer.", player, 255, 0, 0)
				return
			end 
			vote2 = vote2 + 1
			setElementData(player, "aurvotepoll.choice", 2)
			outputChatBox("You choose: "..choice2, player, 66, 244, 209)
			outputChatBox(getPlayerName(player).." anwered the poll ("..(vote1+vote2+vote3+vote4).."/"..getPlayerCount()..")", playerSet, 66, 244, 209)
		end
	end 
	
	
	if (letter == "c" or letter == "C") then 
		if (choice4 ~= "") then 
			if (getElementData(player, "aurvotepoll.choice") ~= "") then 
				outputChatBox("Error: You cannot change your answer.", player, 255, 0, 0)
				return
			end 
			vote3 = vote3 + 1
			setElementData(player, "aurvotepoll.choice", 3)
			outputChatBox("You choose: "..choice3, player, 66, 244, 209)
			outputChatBox(getPlayerName(player).." anwered the poll ("..(vote1+vote2+vote3+vote4).."/"..getPlayerCount()..")", playerSet, 66, 244, 209)
		end
	end 
	
	
	if (letter == "d" or letter == "D") then 
		if (choice4 ~= "") then 
			if (getElementData(player, "aurvotepoll.choice") ~= "") then 
				outputChatBox("Error: You cannot change your answer.", player, 255, 0, 0)
				return
			end 
			vote4 = vote4 + 1
			setElementData(player, "aurvotepoll.choice", 4)
			outputChatBox("You choose: "..choice4, player, 66, 244, 209)
			outputChatBox(getPlayerName(player).." anwered the poll ("..(vote1+vote2+vote3+vote4).."/"..getPlayerCount()..")", playerSet, 66, 244, 209)
		end 
	end 
	
end 
addCommandHandler("poll", poll)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function pollStop (player, command)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff")  then return end 
	if (pollInUse == false) then return end 
	local playerCount = getPlayerCount()
	for index, players in pairs(getElementsByType("player")) do
		outputChatBox("Poll Ended by "..getPlayerName(player)..".", players, 66, 244, 209)
		outputChatBox("Poll Results: ", players, 66, 244, 209)
		setElementData(players, "aurvotepoll.choice", "")
		if (choice1 ~= "") then
			outputChatBox("A. "..choice1.." - "..round(vote1*playerCount/(vote1+vote2+vote3+vote4)).."% players voted.", players, 66, 244, 209)
		end 
		if (choice2 ~= "") then 
			outputChatBox("B. "..choice2.." - "..round(vote2*playerCount/(vote1+vote2+vote3+vote4)).."% players voted.", players, 66, 244, 209)
		end
		if (choice4 ~= "") then 
			outputChatBox("C. "..choice3.." - "..round(vote3*playerCount/(vote1+vote2+vote3+vote4)).."% players voted.", players, 66, 244, 209)
		end
		if (choice4 ~= "") then 
			outputChatBox("D. "..choice4.." - "..round(vote4*playerCount/(vote1+vote2+vote3+vote4)).."% players voted.", players, 66, 244, 209)
		end
		outputChatBox("Total players voted: "..round(vote4*playerCount/(vote1+vote2+vote3+vote4))+round(vote3*playerCount/(vote1+vote2+vote3+vote4))+round(vote2*playerCount/(vote1+vote2+vote3+vote4))+round(vote1*playerCount/(vote1+vote2+vote3+vote4)).."% players voted.", players, 66, 244, 209)
	end

	choice4 = ""
	choice3 = ""
	choice2 = ""
	choice1 = ""
	question = ""
	vote1 = 0
	vote2 = 0
	vote3 = 0
	vote4 = 0
	playerSet = nil
end 

addCommandHandler("pollstop", pollStop)
