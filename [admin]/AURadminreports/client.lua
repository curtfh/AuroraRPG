files = {}
function loadChecking ()
	if (not fileExists("files.json")) then 
		local create = fileCreate("files.json")
		fileWrite(create, "[[]]")
		fileClose(create)
	end 
	
	local file = fileOpen("files.json")
	files = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file)
	
	--for i=1, #files do 
--		if (not fileExists("screenshots/"..files[i][1])) then 
			--table.remove(files, i)
		--end 
	--end 
end 
loadChecking()

function unloadChecking ()
	if (not fileExists("files.json")) then 
		fileCreate("files.json")
	end 
	
	for i=1, #files do 
		if (not fileExists("screenshots/"..files[i][1])) then 
			table.remove(files, i)
		end 
	end 
	
	local file = fileOpen("files.json")
	fileWrite(file, toJSON(files))
	fileClose(file)
end 
addEventHandler("OnClientResourceStop", getResourceRootElement(getThisResource()), unloadChecking)

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

addEvent("AURadminreports.onClientScreenshot",true)
addEventHandler( "AURadminreports.onClientScreenshot", resourceRoot,
    function(pixels)
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
	
		local filename = "aurora_report-"..time.month.."-"..time.monthday.."-"..time.year.."_"..time.hour.."-"..time.minute.."-"..time.hour..".jpg"
        --table.insert(files, #files+1, filename)
		files[#files+1] = filename
		local file = fileCreate("screenshots/"..filename)
		fileWrite(file, pixels)
		fileClose(file)
		local file2 = fileOpen("files.json")
		fileWrite(file2, toJSON(files))
		fileClose(file2)
		triggerServerEvent ("AURadminreports.saveScreenshot", resourceRoot, getLocalPlayer(), filename, pixels)
    end
)

local antispam
function takeScreenshotCommand (theCmd)
	if (isTimer(antispam)) then return false end
	local x, y = guiGetScreenSize()
	triggerServerEvent ("AURadminreports.takess", resourceRoot, getLocalPlayer(), x, y)
	outputChatBox("AuroraRPG: Uploading image to the server.", 40, 237, 255)
	antispam = setTimer(function () killTimer(antispam) end, 1000, 1)
end 
addCommandHandler ("rsc", takeScreenshotCommand)

if (fileExists("client.lua")) then 
	fileDelete("client.lua")
end 

if (fileExists("interface.lua")) then 
	fileDelete("interface.lua")
end 