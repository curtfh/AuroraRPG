
local blacklist = {"Smiler", "Curt", "Nixon", "Curt", "Darkness", "AUR", "CIT", "NGC", "CSG"}


function outputMessageToGroup (message, groupID)
	for i,v in ipairs(getElementsByType("player")) do
		local playersGroup = exports.server:getPlayerGroupID(v)
		if (groupID == playersGroup) then
			outputChatBox(message,v,200,0,0)
		end
	end
end 

function getPlayerFromAccountname ( theName )
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( getElementData( thePlayer, "playerAccount" ) == theName ) then
			return thePlayer
		end
	end
end

function getTableDataFromDatabase (thePlayer)
	local groupID = exports.server:getPlayerGroupID(thePlayer)
	local theTable = {}
	
	for i,v in ipairs(getElementsByType("player")) do
		if (exports.server:getPlayerGroupID(v) == groupID) then 
			local accountName = exports.server:getPlayerAccountName(v)
			local suffix = exports.AURcurtmisc:getPlayerAccountData(v, "gt.suffix")
			local prefix = exports.AURcurtmisc:getPlayerAccountData(v, "gt.prefix")
			if (suffix == nil or suffix == "" or suffix == false or suffix == "None") then 
				suffix = "None"
			end 
			if (prefix == nil or prefix == "" or prefix == false or prefix == "None") then 
				prefix = "None"
			end 
			theTable[#theTable+1] = {accountName, suffix, prefix}
		end
	end
	triggerClientEvent (thePlayer, "AURgrouptags.updateTables", thePlayer, theTable)
end 
addEvent("AURgrouptags.getTableDataFromDatabase", true)
addEventHandler("AURgrouptags.getTableDataFromDatabase", resourceRoot, getTableDataFromDatabase)


function updateData (thePlayer, theType, theUpdated, theChange)
	local groupID = exports.server:getPlayerGroupID(thePlayer)
	local theAcc = getPlayerFromAccountname(theUpdated)
	if (not isElement(theAcc) and getElementType(theAcc) ~= "player") then 
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Failed to save user's data, maybe the player is offline.",255,0,0)
		return false 
	end
	for i=1, #blacklist do 
		if (string.find(string.lower(theChange), string.lower(blacklist[i]), 1, true)) then 
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "This value is blacklisted.",255,0,0)
			return false 
		end 
	end 
	
	if (theChange == nil or theChange == "" or theChange == false) then 
		theChange = "None"
	end 
	local origname = exports.AURcurtmisc:getPlayerAccountData(theAcc, "gt.origname") 
	if (origname == nil or origname == "" or origname == false or origname == "None") then 
		exports.AURcurtmisc:setPlayerAccountData(theAcc, "gt.origname", getPlayerName(theAcc)) 
	end
	
	
	
	local suffix = exports.AURcurtmisc:getPlayerAccountData(theAcc, "gt.suffix")
	local prefix = exports.AURcurtmisc:getPlayerAccountData(theAcc, "gt.prefix")
	local newname = ""
		
	
	if (string.find(string.lower(getPlayerName(theAcc)), string.lower(theChange), 1, true)) then 
		newname = string.gsub (getPlayerName(theAcc), theChange, "")
	end 
	
	
	if (theType == "suffix") then 
		exports.AURcurtmisc:setPlayerAccountData(theAcc, "gt."..theType, theChange)
		newname = theChange..getPlayerName(theAcc)
	elseif (theType == "prefix") then 
		exports.AURcurtmisc:setPlayerAccountData(theAcc, "gt."..theType, theChange)
		newname = getPlayerName(theAcc)..theChange
	end
	
	getTableDataFromDatabase(thePlayer)
	outputMessageToGroup(getPlayerName(thePlayer).." updated "..theUpdated.."'s "..theType.." to "..theChange, groupID)
	
	if (theChange == "None") then 
		local origname = exports.AURcurtmisc:getPlayerAccountData(theAcc, "gt.origname")
		setPlayerName(theAcc, origname)
		if (suffix == "None" and theType == "prefix" and theChange == "None") then 
			exports.AURcurtmisc:setPlayerAccountData(theAcc, "gt.origname", "None") 
		end 
		return
	end 
	setPlayerName(theAcc, newname)
end 
addEvent("AURgrouptags.updateData", true)
addEventHandler("AURgrouptags.updateData", resourceRoot, updateData)

function onStartRs()
	for i,v in ipairs(getElementsByType("player")) do
		local suffix = exports.AURcurtmisc:getPlayerAccountData(v, "gt.suffix")
		local prefix = exports.AURcurtmisc:getPlayerAccountData(v, "gt.prefix")
		local name = getPlayerName(v)
		local finalname = name
		if (suffix == nil or suffix == "" or suffix == false or suffix == "None") then 
			suffix = ""
		end 
		if (prefix == nil or prefix == "" or prefix == false or prefix == "None") then 
			prefix = ""
		end 
		if (prefix ~= "" and suffix ~= "") then 
			if (not string.find(string.lower(name), string.lower(suffix), 1, true)) then
				finalname = suffix..finalname
			end 
			if (not string.find(string.lower(name), string.lower(prefix), 1, true)) then
				finalname = finalname..prefix
			end 
			
			setPlayerName(v, finalname)
		end
	end
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStartRs)

function onPlrLogin()
	local playerGroup = exports.server:getPlayerGroupID(source)
	if (playerGroup == false) then 
		exports.AURcurtmisc:setPlayerAccountData(source, "gt.suffix", "None")
		exports.AURcurtmisc:setPlayerAccountData(source, "gt.prefix", "None")
		return false 
	end 
	local suffix = exports.AURcurtmisc:getPlayerAccountData(source, "gt.suffix")
	local prefix = exports.AURcurtmisc:getPlayerAccountData(source, "gt.prefix")
	local name = getPlayerName(source)
	local finalname = name
	if (suffix == nil or suffix == "" or suffix == false or suffix == "None") then 
		suffix = ""
	end 
	if (prefix == nil or prefix == "" or prefix == false or prefix == "None") then 
		prefix = ""
	end 
	if (prefix ~= "" and suffix ~= "") then 
		if (not string.find(string.lower(name), string.lower(suffix), 1, true)) then
			finalname = suffix..finalname
		end 
		if (not string.find(string.lower(name), string.lower(prefix), 1, true)) then
			finalname = finalname..prefix
		end 
		
		setPlayerName(source, finalname)
	end
end 
addEventHandler("onServerPlayerLogin", root, onPlrLogin)