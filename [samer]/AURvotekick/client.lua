local isVoting = false
local currentVote = " "
local yourVote = "You voted: "
local playerKick = "Kick player: "
local voteBy = "Vote by: "
local tab = {}
local endTimer
local sX, sY = guiGetScreenSize()
local sX, sY = sX / 1366, sY / 768
addEvent("AURvotekick.showVoting", true)
addEvent("AURvotekick.receiveData", true)
addEvent("AURvotekick.changeVote", true)

function initDraw()
	-- main recntangle
	dxDrawRectangle(sX*0, sY*222, sX*450, sY*233, tocolor(0, 0, 0, 183), false)
	-- top rectangle
	dxDrawRectangle(sX*0, sY*222, sX*450, sY*42, tocolor(0, 0, 0, 183), false)
	dxDrawText(voteBy, sX*0 - 1, sY*222 - 1, sX*450 - 1, sY*264 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
	dxDrawText(voteBy, sX*0 + 1, sY*222 - 1, sX*450 + 1, sY*264 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
	dxDrawText(voteBy, sX*0 - 1, sY*222 + 1, sX*450 - 1, sY*264 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
	dxDrawText(voteBy, sX*0 + 1, sY*222 + 1, sX*450 + 1, sY*264 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
	dxDrawText(voteBy, sX*0, sY*222, sX*450, sY*264, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
	-- player to vote on
	dxDrawText(playerKick, sX*5 - 1, sY*286 - 1, sX*259 - 1, sY*330 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText(playerKick, sX*5 + 1, sY*286 - 1, sX*259 + 1, sY*330 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText(playerKick, sX*5 - 1, sY*286 + 1, sX*259 - 1, sY*330 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText(playerKick, sX*5 + 1, sY*286 + 1, sX*259 + 1, sY*330 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText(playerKick, sX*5, sY*286, sX*259, sY*330, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	-- bottom rectangle
	dxDrawRectangle(sX*0, sY*413, sX*450, sY*42, tocolor(0, 0, 0, 183), false)
	dxDrawText(yourVote..""..currentVote, sX*0 - 1, sY*413 - 1, sX*450 - 1, sY*455 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, false, true, false)
	dxDrawText(yourVote..""..currentVote, sX*0 + 1, sY*413 - 1, sX*450 + 1, sY*455 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, false, true, false)
	dxDrawText(yourVote..""..currentVote, sX*0 - 1, sY*413 + 1, sX*450 - 1, sY*455 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, false, true, false)
	dxDrawText(yourVote..""..currentVote, sX*0 + 1, sY*413 + 1, sX*450 + 1, sY*455 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, false, true, false)
	dxDrawText(yourVote..""..currentVote, sX*0, sY*413, sX*450, sY*455, tocolor(255, 255, 255, 255), 1.00, "default", "left", "center", false, false, false, true, false)
	-- yes text vote
	if (currentVote ~= " ") and (currentVote == "YES") then
		dxDrawRectangle(sX*357, sY*284, sX*48, sY*45, tocolor(0, 0, 0, 183), false)
	end
	dxDrawText(#tab[getElementDimension(localPlayer)].votedYes, sX*410, sY*284, sX*450, sY*328, tocolor(0, 255, 0, 183), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawImage(sX*357, sY*287, sX*46, sY*37, "yes.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	-- no text vote
	if (currentVote ~= " ") and (currentVote == "NO") then
		dxDrawRectangle(sX*357, sY*339, sX*48, sY*45, tocolor(0, 0, 0, 183), false)
	end
	dxDrawText(#tab[getElementDimension(localPlayer)].votedNo, sX*410, sY*338, sX*450, sY*382, tocolor(255, 0, 0, 183), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawImage(sX*357, sY*339, sX*48, sY*43, "no.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	-- yes selected
	dxDrawRectangle(sX*352, sY*279, sX*98, sY*55, tocolor(0, 0, 0, 75), false)
	-- no selected
	dxDrawRectangle(sX*352, sY*334, sX*98, sY*55, tocolor(0, 0, 0, 75), false)
	-- time left
	dxDrawText("Time left: "..math.ceil((endTimer - getTickCount()) / 1000), sX*5 - 1, sY*340 - 1, sX*259 - 1, sY*384 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText("Time left: "..math.ceil((endTimer - getTickCount()) / 1000), sX*5 + 1, sY*340 - 1, sX*259 + 1, sY*384 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText("Time left: "..math.ceil((endTimer - getTickCount()) / 1000), sX*5 - 1, sY*340 + 1, sX*259 - 1, sY*384 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText("Time left: "..math.ceil((endTimer - getTickCount()) / 1000), sX*5 + 1, sY*340 + 1, sX*259 + 1, sY*384 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText("Time left: "..math.ceil((endTimer - getTickCount()) / 1000), sX*5, sY*340, sX*259, sY*384, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
end


addEventHandler("AURvotekick.receiveData", root, function(data)
	tab = data
end)

addEventHandler("AURvotekick.changeVote", root, function(vote)
	print("Changing vote to "..vote)
	currentVote = vote
end)

addEventHandler("AURvotekick.showVoting", root, function(data)
	if (isVoting) then return false end
	tab = data
	playerKick = "Kick player: "..getPlayerName(data[getElementDimension(localPlayer)].toKick)
	voteBy = "Vote by: "..getPlayerName(data[getElementDimension(localPlayer)].startedBy)
	endTimer = getTickCount() + 15000
	addEventHandler("onClientRender", root, initDraw)
	isVoting = true
end)

addEvent("AURvotekick.endVoting", true)
addEventHandler("AURvotekick.endVoting", root, function()
	removeEventHandler("onClientRender", root, initDraw)
	isVoting = false
end)

if fileExists("client.lua") then
	fileDelete("client.lua")
end