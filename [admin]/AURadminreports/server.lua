repotings = {}

function takeScreenshot (player, x, y)
	takePlayerScreenShot(player, x, y, "AURadminreport-"..getPlayerName(player))
end 
addEvent("AURadminreports.takess", true)
addEventHandler("AURadminreports.takess", resourceRoot, takeScreenshot)

addEventHandler( "onPlayerScreenShot", root,
    function (theResource, status, pixels, timestamp, tag)
		for index, player in pairs(getElementsByType("player")) do
			if (tag == "AURadminreport-"..getPlayerName(player)) then
				if (status == "ok") then
					triggerClientEvent(player, "AURadminreports.onClientScreenshot", resourceRoot, pixels)
					outputChatBox(exports.AURlanguage:getTranslate("AuroraRPG: The screenshot has successfully uploaded. You can use this screenshot on /report system.", true, player), player, 40, 237, 255)
				else
					outputChatBox(exports.AURlanguage:getTranslate("AuroraRPG: The screenshot was unable to upload to the server. Please try again.", true, player), player, 255, 0, 0)
				end 
			end 
		end 
    end
)

function refreshTables ()
	local file = fileOpen("reports.json")
	repotings = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file) 
	
	for i=1, #repotings do 
		if (repotings[i][2] == "" or repotings[i][2] == nil or repotings[i][2] == false)  then 
			table.remove(repotings, i)
		end 
		if (repotings[i][3] == "" or repotings[i][3] == nil or repotings[i][3] == false)  then 
			table.remove(repotings, i)
		end 
	end 
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), refreshTables)

function onStopRs()
	local file = fileOpen("reports.json")
	fileWrite(file, toJSON(repotings))
	fileClose(file)
end 
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStopRs)

function saveScreenshot (player, filename, pixels)
	local accname = exports.server:getPlayerAccountName(player)
	if (not fileExists("screenshots/"..accname.."_"..filename)) then 
		local file = fileCreate("screenshots/"..accname.."_"..filename)
		fileWrite(file, pixels)
		fileClose(file)
	end
end 
addEvent("AURadminreports.saveScreenshot", true)
addEventHandler("AURadminreports.saveScreenshot", resourceRoot, saveScreenshot)

local timer
function submitReport (player, rtype, title, descr, filename)
	if (not player) then return false end
	if (not rtype) then return false end
	if (title == "") then 
		outputChatBox(exports.AURlanguage:getTranslate("Unable to submit your report because the system can't find your title.", true, player), player, 255, 0, 0)
		return
	end
	if (descr == "") then 
		outputChatBox(exports.AURlanguage:getTranslate("Unable to submit your report because the system can't find your description.", true, player), player, 255, 0, 0)
		return 
	end
	if (isTimer(timer)) then 
		outputChatBox(exports.AURlanguage:getTranslate("Please wait 30 seconds.", true, player), player, 255, 0, 0)
		return 
	end 
	if (rtype == "screenshot") then 
		local accname = exports.server:getPlayerAccountName(player)
		local plrname = getPlayerName(player)
		local plrip = getPlayerIP (player)
		local mtaserial = getPlayerSerial (player)
		if (not fileExists("screenshots/"..accname.."_"..filename)) then 
			outputChatBox(exports.AURlanguage:getTranslate("Unable to submit your report because the system can't find your screenshot.", true, player), player, 255, 0, 0)
			return false 
		end 
		
		repotings[#repotings+1] = {accname, plrname, plrip, mtaserial, rtype, title, descr, "screenshots/"..accname.."_"..filename, false}
		outputChatBox(string.format(exports.AURlanguage:getTranslate("Your report has successfully posted. Report ID: %s", true, player), #repotings), player, 40, 237, 255)
		outputToAllStaff("Reports: A new report (#"..#repotings..") from "..getPlayerName(player)..", type /reports to open .")
		triggerClientEvent(source, "AURadminreports.updateReports", resourceRoot, repotings)
		timer = setTimer (function() killTimer(timer) end, 30000, 1)
	elseif (rtype == "text") then 
		local accname = exports.server:getPlayerAccountName(player)
		local plrname = getPlayerName(player)
		local plrip = getPlayerIP (player)
		local mtaserial = getPlayerSerial (player)
		repotings[#repotings+1] = {accname, plrname, plrip, mtaserial, rtype, title, descr, nil, false}
		outputChatBox(string.format(exports.AURlanguage:getTranslate("Your report has successfully posted. Report ID: %s", true, player), #repotings), player, 40, 237, 255)
		triggerClientEvent(source, "AURadminreports.updateReports", resourceRoot, repotings)
		outputToAllStaff("Reports: A new report (#"..#repotings..") from "..getPlayerName(player)..", type /reports to open .")
		timer = setTimer (function() killTimer(timer) end, 30000, 1)
	end 
end
addEvent("AURadminreports.submitReport", true)
addEventHandler("AURadminreports.submitReport", resourceRoot, submitReport)

function requestNewReportingList (player)
	triggerClientEvent(player, "AURadminreports.updateReports", resourceRoot, repotings)
end 
addEvent("AURadminreports.requestNewReportingList", true)
addEventHandler("AURadminreports.requestNewReportingList", resourceRoot, requestNewReportingList)

function requestScreenshot (player, filename)
	if (not fileExists(filename)) then 
		triggerClientEvent(player, "AURadminreports.updateScreenshot", resourceRoot, "not_avail.jpg", false)
		return
	end 
	local file = fileOpen(filename)
	local image = fileRead(file, fileGetSize(file))
	triggerClientEvent(player, "AURadminreports.updateScreenshot", resourceRoot, filename, image)
	fileClose(file) 
end
addEvent("AURadminreports.requestScreenshot", true)
addEventHandler("AURadminreports.requestScreenshot", resourceRoot, requestScreenshot)

function getPlayerFromAccountname ( theName )
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( getElementData( thePlayer, "playerAccount" ) == theName ) then
			return thePlayer
		end
	end
end


function outputToPlayerAccount(accname, say)
	local thePlayer = getPlayerFromAccountname(accname)
	if (isElement(thePlayer) and getElementType(thePlayer) == "player") then 
		outputChatBox(say, thePlayer, 40, 237, 255)
		return true
	else
		return false
	end 
end 

function outputToAllStaff (say)
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if (exports.CSGstaff:isPlayerStaff(thePlayer) == true) then 
			--exports.NGCdxmsg:createNewDxMessage(say, thePlayer, 255, 0, 0)
			outputChatBox(say, thePlayer, 255, 0, 0)
		end 
	end
end 

function setCaseStatus (player, status, reportid, reason)
	if (status == "valid") then 
		for i=1, #repotings do 
			if (i == reportid) then 
				local accname = repotings[i][1]
				local plrname = repotings[i][2]
				local plrip = repotings[i][3]
				local mtaserial = repotings[i][4]
				local rtype = repotings[i][5]
				local title = repotings[i][6]
				local descr = repotings[i][7]
				local dir = repotings[i][8]
				repotings[i] = {accname, plrname, plrip, mtaserial, rtype, title, descr, dir, true}
				outputToPlayerAccount(accname, "AuroraRPG: Your report #"..reportid.." for "..title.." is valid by "..getPlayerName(player)..". The staff team will take further actions.")
				outputToAllStaff("Reports: "..getPlayerName(player).." has set report #"..reportid.." to valid.")
			end 
		end 
	elseif (status == "invalid") then 
		for i=1, #repotings do 
			if (i == reportid) then 
				local accname = repotings[i][1]
				local plrname = repotings[i][2]
				local plrip = repotings[i][3]
				local mtaserial = repotings[i][4]
				local rtype = repotings[i][5]
				local title = repotings[i][6]
				local descr = repotings[i][7]
				local dir = repotings[i][8]
				repotings[i] = {accname, plrname, plrip, mtaserial, rtype, title, descr, dir, true}
				outputToPlayerAccount(accname, "AuroraRPG: Your report #"..reportid.." for "..title.." got rejected by "..getPlayerName(player)..".")
				outputToAllStaff("Reports: "..getPlayerName(player).." has set report #"..reportid.." to rejected.")
			end 
		end 
	elseif (status == "invalid_custom") then 
		for i=1, #repotings do 
			if (i == reportid) then 
				local accname = repotings[i][1]
				local plrname = repotings[i][2]
				local plrip = repotings[i][3]
				local mtaserial = repotings[i][4]
				local rtype = repotings[i][5]
				local title = repotings[i][6]
				local descr = repotings[i][7]
				local dir = repotings[i][8]
				repotings[i] = {accname, plrname, plrip, mtaserial, rtype, title, descr, dir, true}
				outputToPlayerAccount(accname, "AuroraRPG: Your report #"..reportid.." for "..title.." got rejected ("..reason..") by "..getPlayerName(player)..".")
				outputToAllStaff("Reports: "..getPlayerName(player).." has set report #"..reportid.." to rejected ("..reason..").")
			end 
		end 
	end 
end 
addEvent("AURadminreports.setCaseStatus", true)
addEventHandler("AURadminreports.setCaseStatus", resourceRoot, setCaseStatus)
function onAdminLogin ()
	if (not exports.CSGstaff:isPlayerStaff(source)) then return false end
	local count = 0
	for i=1, #repotings do 
		if (repotings[i][9] == true) then 
			count = count + 1
		end 
	end 
	outputChatBox("There are "..count.." reports. Type /reports to manage.", source, 255, 0, 0)
end 
addEventHandler("onServerPlayerLogin", root, onAdminLogin)

local count = 0
for i=1, #repotings do 
	if (repotings[i][9] == true) then 
		count = count + 1
	end 
end 
outputToAllStaff("Reports: There are "..count.." reports. Type /reports to manage.")