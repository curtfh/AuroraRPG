--[[
Server: AuroraRPG
Resource Name: Cinema
Version: 1.0
Developer/s: Curt
]]--
setElementData(root, "aurcinema.setvideocem", "https://youtube.com/tv#/")
local accounts = {}

function refreshTables ()
	local file1 = fileOpen("accounts.json")
	accounts = fromJSON(fileRead(file1, fileGetSize(file1)))
	fileClose(file1) 
end 

function onStartRs()
	refreshTables()
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStartRs)

function onStopRs()
	local file1 = fileOpen("accounts.json")
	fileWrite(file1, toJSON(accounts))
	fileClose(file1)
end 
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStopRs)

function refreshDTable (player, cmd)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return end
	refreshTables()
	outputChatBox("Cinema Account Table Refreshed", player, 255, 255, 255)
	
end 
addCommandHandler("refreshcinematable", refreshDTable)

function addac (player, cmd, account)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return end
	accounts[account] = true
	outputChatBox("Account added on cinema access list.", player, 255, 255, 255)
	
end 
addCommandHandler("addacccm", addac)


function cmplay (sr, cmd, url)
	if (getElementData(sr, "aurcinema.ColShape") == false) then 
		exports.NGCdxmsg:createNewDxMessage(sr, "You can only use this command at the cinema.", 255, 0, 0)
		return
	end 
	local nam = exports.server:getPlayerAccountName(sr)
	if (accounts[nam] == nil)  then 
		exports.NGCdxmsg:createNewDxMessage(sr, "Only staff or moderators can only use this command. Ask a staff/moderator to change the cinema video.", 255, 0, 0)
		return
	end 
	if (url == nil or url == "") then 
		exports.NGCdxmsg:createNewDxMessage(sr, "The correct syntax for that command is /cmplay <youtube link>", 255, 0, 0)
		return 
	end 
	--[[if (getElementData(sr, "aurcinema.cmstop.limited") == true) then 
		exports.NGCdxmsg:createNewDxMessage(sr, "You can't use this command for another 2 minutes. Please try again later. ", 255, 0, 0)
		return 
	end 
	setElementData(sr, "aurcinema.cmstop.limited", true)
	setTimer(function()
		setElementData(sr, "aurcinema.cmstop.limited", false)
	end, 120000, 1)]]--
	setElementData(root, "aurcinema.setvideocem", "https://youtube.com/tv#/"..url)
	exports.NGCdxmsg:createNewDxMessage(sr, "Successfully changed the cinema video.", 65, 244, 80)
	for index, v in ipairs( getElementsByType("player") ) do
		if (getElementData(v, "aurcinema.ColShape") == true) then 
			triggerClientEvent(v, "aurcinema.onPlrJoin", v, "https://youtube.com/tv#/"..url)
			exports.NGCdxmsg:createNewDxMessage(v, getPlayerName(sr).." changed the cinema video.", 66, 244, 235)
		end 
	end
	
end
addCommandHandler("cmplay", cmplay)

function cmstop (sr, cmd)
	if (getElementData(sr, "aurcinema.ColShape") == false) then 
		exports.NGCdxmsg:createNewDxMessage(sr, "You can only use this command at the cinema.", 255, 0, 0)
		return
	end 
	--[[if (getElementData(sr, "aurcinema.cmstop.limited") == true) then 
		exports.NGCdxmsg:createNewDxMessage(sr, "You can't use this command for another 2 minutes. Please try again later. ", 255, 0, 0)
		return 
	end 
	setElementData(sr, "aurcinema.cmstop.limited", true)
	setTimer(function()
		setElementData(sr, "aurcinema.cmstop.limited", false)
	end, 120000, 1)]]--
	local nam = exports.server:getPlayerAccountName(sr)
	if (accounts[nam] == nil)  then 
		exports.NGCdxmsg:createNewDxMessage(sr, "Only staff or moderators can only use this command. Ask a staff/moderator to stop the cinema video.", 255, 0, 0)
		return
	end 
	setElementData(root, "aurcinema.setvideocem", "https://youtube.com/tv#/")
	exports.NGCdxmsg:createNewDxMessage(sr, "Successfully stop the cinema video.", 65, 244, 80)
	for index, v in ipairs( getElementsByType("player") ) do
		if (getElementData(v, "aurcinema.ColShape") == true) then 
			triggerClientEvent(v, "aurcinema.onPlrJoin", v, "https://youtube.com/tv#/")
			exports.NGCdxmsg:createNewDxMessage(v, getPlayerName(sr).." stopped the cinema video.", 66, 244, 235)
		end 
	end
	
end
addCommandHandler("cmstop", cmstop)

local limit = createColRectangle ( 3495.7792,  -469.36929, 200, 190)
addEventHandler ( "onColShapeHit", limit, function(thePlayer)
	if (getElementType(thePlayer) == "player") then
		triggerClientEvent(thePlayer, "aurcinema.setVolumeCinema", thePlayer, 1.0)
		triggerClientEvent(thePlayer, "aurcinema.loadCinema", thePlayer, true)
		triggerClientEvent(thePlayer, "aurcinema.enableCinema", thePlayer, true)
		setElementData(thePlayer, "aurcinema.ColShape", true)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Welcome to AURCinema. Ask an admin to change the video or stop the video.", 66, 244, 235)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Commands: /cmplay <url> | /cmstop ", 66, 244, 235)
	end
end)

addEventHandler ( "onColShapeLeave", limit, function(thePlayer)
	if (getElementType(thePlayer) == "player") then
		triggerClientEvent(thePlayer, "aurcinema.setVolumeCinema", thePlayer, 0)
		triggerClientEvent(thePlayer, "aurcinema.loadCinema", thePlayer, false)
		triggerClientEvent(thePlayer, "aurcinema.enableCinema", thePlayer, false)
		setElementData(thePlayer, "aurcinema.ColShape", false)
	end
end)
