local yays = {}
local nays = {}
local pollElem = createElement("poll")
setElementData(pollElem, "voteOn", false)

function createPoll(p, cmd, ...)
	if (not isPlayerSpeaker(p)) then return false end
	local title = table.concat({...}," ")
	yays = {}
	nays = {}
	local reps = getOnlineReps()
	setElementData(pollElem, "voteOn", true)
	setTimer (stopPoll, 60*1000, 1)
	for k, v in ipairs (reps) do
		outputChatBox("The vote on "..title.." is now open! You have 1 minute until the vote ends. Use /yay to vote for, use /nay to vote against.", v, 0, 0, 255)
	end
end
addCommandHandler("startvote", createPoll)

function stopPoll()
	local reps = getOnlineReps()
	for k, v in ipairs (reps) do
		setElementData(v, "voted", false)
		setElementData(pollElem, "voteOn", false)
		outputChatBox("The vote is now over!", v, 255, 0, 0)
		outputChatBox(""..#yays.." representatives voted for this act!", v, 0, 255, 0)
		outputChatBox(""..#nays.." representatives voted against this act!", v, 255, 0, 0)
		if (#nays >= #yays) then 
			outputChatBox("The act hasn't passed!", v, 255, 0, 0)
		else 
			outputChatBox("The act has passed!", v, 0, 255, 0)
		end
	end	
end

function yay(p, cmd)
	if (getElementData(pollElem, "voteOn")) and (isPlayerRep(p)) and (not getElementData(p, "voted")) then
		local playerName = getPlayerName(p)
		table.insert(yays, p)
		local reps = getOnlineReps()
		setElementData(p, "voted", true)
		for k, v in ipairs (reps) do
			outputChatBox(""..playerName.." has voted for this act.", v, 0, 255, 0)
		end
	end
end
addCommandHandler("yay", yay)

function nay(p, cmd)
	if (getElementData(pollElem, "voteOn")) and (isPlayerRep(p)) and (not getElementData(p, "voted")) then
		local playerName = getPlayerName(p)
		table.insert(nays, p)
		local reps = getOnlineReps()
		setElementData(p, "voted", true)
		for k, v in ipairs (reps) do
			outputChatBox(""..playerName.." has voted against this act.", v, 255, 0, 0)
		end
	end
end
addCommandHandler("nay", nay)