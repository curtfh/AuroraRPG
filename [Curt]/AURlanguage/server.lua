local localizations = {"English (United States)", "Russian", "French", "Arabic", "Hebrew", "Greek", "Turkish", "Italian", "Swedish"}
local antiSpamSubmission = {}

function getLanguageTable (player, gl)
	local theTable = exports.DENmysql:query("SELECT * FROM translations")
	triggerClientEvent(player, "AURlanguage.updateTables", player, theTable, localizations, gl)
end
addEvent("AURlanguage.getLanguageTable", true)
addEventHandler("AURlanguage.getLanguageTable", resourceRoot, getLanguageTable)

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getTimestamp(year, month, day, hour, minute, second)
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
    timestamp = timestamp - 3600
    if datetime.isdst then timestamp = timestamp - 3600 end
    return timestamp
end

function theTime() 
	local time = getRealTime() 
	time.month = time.month + 1 
	time.year = time.year + 1900 
	local unix = getTimestamp(time.year,time.month,time.monthday,time.hour,time.minute,time.second) 
	if time.second < 10 then 
	time.second = "0"..time.second 
	end 
	if time.minute < 10 then 
	time.minute = "0"..time.minute 
	end 
	if time.hour < 10 then 
	time.hour = "0"..time.hour 
	end 
	
	return time.month, time.monthday, time.year
end

function submitLanguage (thePlayer, theSubmitedTable)
	for i=1, #antiSpamSubmission do 
		if (antiSpamSubmission[i][1] == getElementData(thePlayer, "playerAccount") and antiSpamSubmission[i][2] == theSubmitedTable["language"] and antiSpamSubmission[i][3] == theSubmitedTable["linkedTo"]) then 
			exports.NGCdxmsg:createNewDxMessage(thePlayer, exports.AURlanguage:getTranslate("Unable to process your submission because you are keep submitting your translation.", true, thePlayer),255,0,0)
			return 
		end 
	end 

	if (theSubmitedTable["language"] == "" or math.floor(theSubmitedTable["linkedTo"]) == 0 or string.gsub(theSubmitedTable["string"], "%s+", "") == "") then 
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Please complete the fields down below.",255,0,0)
	else
		local m,d,y = theTime()
		exports.DENmysql:exec("INSERT INTO translations SET type=?, linkedTo=?, language=?, string=?, date=?, contributor=?, contributor_name=?, version=?, responsible=?", "submited", theSubmitedTable["linkedTo"], theSubmitedTable["language"], theSubmitedTable["string"], m.."/"..d.."/"..y, theSubmitedTable["contributor"], theSubmitedTable["contributor_name"], theSubmitedTable["version"], "None")
		exports.NGCdxmsg:createNewDxMessage(thePlayer, exports.AURlanguage:getTranslate("Your submission has been now submitted. Please wait for an admin to view your contributed string.", true, thePlayer),0,255,0)
		antiSpamSubmission[#antiSpamSubmission+1] = {getElementData(thePlayer, "playerAccount"), theSubmitedTable["language"], theSubmitedTable["linkedTo"]}
		
	end
end 
addEvent("AURlanguage.submitLanguage", true)
addEventHandler("AURlanguage.submitLanguage", resourceRoot, submitLanguage)

setTimer(function() antiSpamSubmission = {} end, 7200000, 0)


function sendSubmission (thePlayer, type, id, oldid, accname)
	if (getTeamName(getPlayerTeam(thePlayer)) ~= "Staff") then return end
	if (type == "approve") then 
		exports.DENmysql:exec("UPDATE translations SET type=?, responsible=? WHERE id=?", "new", getPlayerName(thePlayer), id)
		exports.DENmysql:exec("UPDATE translations SET type=? WHERE id=?", "edited", oldid)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, exports.AURlanguage:getTranslate("The submission of language has been approved and updated to the database.", true, thePlayer),0,255,0)
		exports.AURpayments:addMoney(thePlayer, 500, "Custom", "Automatic Donation", 0, "AURautodonations")
		exports.AURautodonations:givePlayerCash(accname, 5000)
		getLanguageTable(thePlayer, true)
	elseif (type == "deny") then 
		exports.DENmysql:exec("DELETE FROM translations WHERE id=?", id)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, exports.AURlanguage:getTranslate("The submission of language string has been deleted.", true, thePlayer),255,0,0)
		exports.AURpayments:addMoney(thePlayer, 500, "Custom", "Automatic Donation", 0, "AURautodonations")
		getLanguageTable(thePlayer, true)
	else 
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Unknown Function.",255,0,0)			
	end 
end 
addEvent("AURlanguage.sendSubmission", true)
addEventHandler("AURlanguage.sendSubmission", resourceRoot, sendSubmission)