function Check(funcname, ...)
    local arg = {...}
    
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
    
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
        
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

local gWeekDays = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
function FormatDate(format, escaper, timestamp)
	Check("FormatDate", "string", format, "format", {"nil","string"}, escaper, "escaper", {"nil","string"}, timestamp, "timestamp")
	
	escaper = (escaper or "'"):sub(1, 1)
	local time = getRealTime(timestamp)
	local formattedDate = ""
	local escaped = false

	time.year = time.year + 1900
	time.month = time.month + 1
	
	local datetime = { d = ("%02d"):format(time.monthday), h = ("%02d"):format(time.hour), i = ("%02d"):format(time.minute), m = ("%02d"):format(time.month), s = ("%02d"):format(time.second), w = gWeekDays[time.weekday+1]:sub(1, 2), W = gWeekDays[time.weekday+1], y = tostring(time.year):sub(-2), Y = time.year }
	
	for char in format:gmatch(".") do
		if (char == escaper) then escaped = not escaped
		else formattedDate = formattedDate..(not escaped and datetime[char] or char) end
	end
	
	return formattedDate
end

function maxkey(initialtable)
	local maxval = math.max(unpack(initialtable))
	local inv={}
		for k,v in pairs(initialtable) do
			inv[v]=k
		end
	return inv[maxval]
end

function minkey(initialtable)
	local maxval = math.min(unpack(initialtable))
	local inv={}
		for k,v in pairs(initialtable) do
			inv[v]=k
		end
	return inv[maxval]
end

function rgb2hex(r,g,b)
	
	local hex_table = {[10] = 'A',[11] = 'B',[12] = 'C',[13] = 'D',[14] = 'E',[15] = 'F'}
	
	local r1 = math.floor(r / 16)
	local r2 = r - (16 * r1)
	local g1 = math.floor(g / 16)
	local g2 = g - (16 * g1)
	local b1 = math.floor(b / 16)
	local b2 = b - (16 * b1)
	
	if r1 > 9 then r1 = hex_table[r1] end
	if r2 > 9 then r2 = hex_table[r2] end
	if g1 > 9 then g1 = hex_table[g1] end
	if g2 > 9 then g2 = hex_table[g2] end
	if b1 > 9 then b1 = hex_table[b1] end
	if b2 > 9 then b2 = hex_table[b2] end
	
	return "#" .. r1 .. r2 .. g1 .. g2 .. b1 .. b2

end

function dailystats ()
	local playercount = getPlayerCount()
	local dbtable = exports.DENmysql:querySingle("SELECT * FROM `statistics` WHERE `date`=? LIMIT 1", FormatDate("m/d/Y")) or false
	if (dbtable == false) then 
		exports.DENmysql:exec("INSERT INTO `statistics` (`date`, `min`, `max`) VALUES (?, ?, ?)", FormatDate("m/d/Y"), playercount, playercount)
	elseif (type(dbtable) == "table") then 
		local minp = dbtable["min"]
		local maxp = dbtable["max"]
		if (minp >= playercount) then 
			minp = playercount
		elseif (maxp <= playercount) then
			maxp = playercount
		end 
		exports.DENmysql:exec("UPDATE `statistics` SET `min`=?, `max`=? WHERE `date`=?", minp, maxp, FormatDate("m/d/Y"))
	end 
end 

function hourlystats ()
	local playercount = getPlayerCount()
	local dbtable = exports.DENmysql:querySingle("SELECT * FROM `hourlystatistics` WHERE `datetime`=? LIMIT 1", FormatDate("m/d/Y h")) or false
	if (dbtable == false) then 
		exports.DENmysql:exec("INSERT INTO `hourlystatistics` (`datetime`, `min`, `max`) VALUES (?, ?, ?)", FormatDate("m/d/Y h"), playercount, playercount)
	elseif (type(dbtable) == "table") then 
		local minp = dbtable["min"]
		local maxp = dbtable["max"]
		if (minp >= playercount) then 
			minp = playercount
		elseif (maxp <= playercount) then
			maxp = playercount
		end 
		exports.DENmysql:exec("UPDATE `hourlystatistics` SET `min`=?, `max`=? WHERE `datetime`=?", minp, maxp, FormatDate("m/d/Y h"))
	end 
end 

function hourlyfpsstats ()
	local dbtable = exports.DENmysql:querySingle("SELECT * FROM `hourlystatistics_fps` WHERE `datetime`=? LIMIT 1", FormatDate("m/d/Y h")) or false

	local playerListFps = {}
	for index, player in pairs(getElementsByType("player")) do
		if (exports.server:isPlayerLoggedIn(player) == true) then
			local theFPS = getElementData (player, "FPS")
			table.insert (playerListFps, theFPS)
		end 
	end
	local highestFPS = playerListFps[maxkey(playerListFps)]
	local lowestFPS = playerListFps[minkey(playerListFps)]

	if (dbtable == false) then 
		exports.DENmysql:exec("INSERT INTO `hourlystatistics_fps` (`datetime`, `min`, `max`) VALUES (?, ?, ?)", FormatDate("m/d/Y h"), lowestFPS, highestFPS)
	elseif (type(dbtable) == "table") then 
		local minp = dbtable["min"]
		local maxp = dbtable["max"]
		if (minp >= lowestFPS) then 
			minp = lowestFPS
		elseif (maxp <= highestFPS) then
			maxp = highestFPS
		end
		exports.DENmysql:exec("UPDATE `hourlystatistics_fps` SET `min`=?, `max`=? WHERE `datetime`=?", minp, maxp, FormatDate("m/d/Y h"))
	end
end 

function hourlyteamstats ()
	local teams = {}
	for index, team in pairs(getElementsByType("team")) do
		teams[getTeamName(team)] = countPlayersInTeam(team)
	end

	for theTeam, theCount in pairs(teams) do
		local r, g, b = getTeamColor (getTeamFromName(theTeam))
		local hex = rgb2hex(r,g,b)
		local dbtable = exports.DENmysql:querySingle("SELECT * FROM `hourlystatistics_teams` WHERE `datetime`=? AND `team`=? LIMIT 1", FormatDate("m/d/Y h"), theTeam) or false
		if (dbtable == false) then 
			exports.DENmysql:exec("INSERT INTO `hourlystatistics_teams` (`datetime`, `min`, `max`, `team`, `hex`) VALUES (?, ?, ?, ?, ?)", FormatDate("m/d/Y h"), theCount, theCount, theTeam, hex)
		elseif (type(dbtable) == "table") then 
			local minp = dbtable["min"]
			local maxp = dbtable["max"]
			local teamp = dbtable["team"]
			if (minp >= theCount) then 
				minp = theCount
			elseif (maxp <= theCount) then
				maxp = theCount
			end
			exports.DENmysql:exec("UPDATE `hourlystatistics_teams` SET `min`=?, `max`=?, `hex`=? WHERE `datetime`=? AND `team`=?", minp, maxp, hex, FormatDate("m/d/Y h"), teamp)
		end
	end 
end 

function monthlystats ()
	local playercount = getPlayerCount()
	local dbtable = exports.DENmysql:querySingle("SELECT * FROM `monthlystatistics` WHERE `month`=? LIMIT 1", FormatDate("m/Y")) or false
	if (dbtable == false) then 
		exports.DENmysql:exec("INSERT INTO `monthlystatistics` (`month`, `min`, `max`) VALUES (?, ?, ?)", FormatDate("m/Y"), playercount, playercount)
	elseif (type(dbtable) == "table") then 
		local minp = dbtable["min"]
		local maxp = dbtable["max"]
		if (minp >= playercount) then 
			minp = playercount
		elseif (maxp <= playercount) then
			maxp = playercount
		end 
		exports.DENmysql:exec("UPDATE `monthlystatistics` SET `min`=?, `max`=? WHERE `month`=?", minp, maxp, FormatDate("m/Y"))
	end 
end 

local dbplayers = {}
function uniqueplayers ()
	local dbtable = exports.DENmysql:querySingle("SELECT * FROM `uniqueplayers_statistics` WHERE `date`=? LIMIT 1", FormatDate("m/d/Y")) or false
	if (dbtable == false) then 
		local count = 0
		for index, player in pairs(getElementsByType("player")) do
			if (exports.server:isPlayerLoggedIn(player) == true) then
				local userID = exports.server:getPlayerAccountID(player)
				count = count + 1
				dbplayers[userID] = true
			end 
		end 
		exports.DENmysql:exec("INSERT INTO `uniqueplayers_statistics` (`date`, `max`) VALUES (?, ?)", FormatDate("m/d/Y"), count)
		dbplayers = {}
	elseif (type(dbtable) == "table") then 
		local maxp = dbtable["max"]
		if (type(source) == "userdata") then 
			local userID = exports.server:getPlayerAccountID(source)
			if (dbplayers[userID] ~= true) then 
				dbplayers[userID] = true
				exports.DENmysql:exec("UPDATE `uniqueplayers_statistics` SET `max`=? WHERE `date`=?", maxp+1, FormatDate("m/d/Y"))
			end
		end
	end 
end 
addEventHandler("onServerPlayerLogin", root, uniqueplayers)
addEventHandler ("onPlayerJoin", getRootElement(), dailystats)
addEventHandler ("onPlayerJoin", getRootElement(), hourlystats)
addEventHandler ("onPlayerJoin", getRootElement(), monthlystats)
addEventHandler ("onPlayerQuit", getRootElement(), dailystats)
addEventHandler ("onPlayerQuit", getRootElement(), hourlystats)
addEventHandler ("onPlayerQuit", getRootElement(), monthlystats)
dailystats()
monthlystats()
uniqueplayers()
hourlystats()
hourlyfpsstats()
hourlyteamstats()
setTimer(hourlyfpsstats, 10000, 0)
setTimer(hourlyteamstats, 10000, 0)