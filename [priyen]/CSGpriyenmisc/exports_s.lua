function getTimeStampYYYYMMDD()
    local time = GetDateTime(GetTimestamp())
    if time.month < 10 then time.month = "0"..(time.month).."" end
    if time.monthday < 10 then time.monthday = "0"..(time.monthday).."" end
    local str = ""..(time.year)..""..(time.month)..""..(time.monthday)..""
    return str
end

function GetTimestamp(year, month, day, hour, minute, second)
    local i
    local timestamp = 0
    local time = getRealTime()
    local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    if (not year or year < 1970) then
        year = time.year + 1900
        month = time.month + 1
        day = time.monthday
        hour = time.hour
        minute = time.minute
        second = time.second
    else
        month = month or 1
        day = day or 1
        hour = hour or 0
        minute = minute or 0
        second = second or 0
    end

    for i=1970, year-1, 1 do
        timestamp = timestamp + 60*60*24*365
        if (IsYearALeapYear(i)) then
            timestamp = timestamp + 60*60*24
        end
    end

    if (IsYearALeapYear(year)) then
        monthDays[2] = monthDays[2] + 1
    end

    for i=1, month-1, 1 do
        timestamp = timestamp + 60*60*24*monthDays[i]
    end

    timestamp = timestamp + 60*60*24 * (day - 1) + 60*60 * hour + 60 * minute + second

    return timestamp
end

function GetDateTime(timestamp)
    local i
    local time = {}
    local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    time.year = 1970
    while (timestamp >= 60*60*24*365) do
        timestamp = timestamp - 60*60*24*365
        time.year = time.year + 1

        if (IsYearALeapYear(time.year - 1)) then
            if timestamp >= 60*60*24 then
                timestamp = timestamp - 60*60*24
            else
                timestamp = timestamp + 60*60*24*365
                time.year = time.year - 1
                break
            end
        end
    end

    if (IsYearALeapYear(time.year)) then
        monthDays[2] = monthDays[2] + 1
    end

    local month, daycount
    for month, daycount in ipairs(monthDays) do
        time.month = month
        if (timestamp >= 60*60*24*daycount) then
            timestamp = timestamp - 60*60*24*daycount
        else
            break
        end
    end

    time.monthday = math.floor(timestamp / (60*60*24)) + 1
    timestamp = timestamp - 60*60*24 * (time.monthday - 1)

    time.hour = math.floor(timestamp / (60*60))
    timestamp = timestamp - 60*60 * time.hour

    time.minute = math.floor(timestamp / 60)
    timestamp = timestamp - 60 * time.minute

    time.second = timestamp

    local monthcode = time.month - 2
    local year = time.year
    local yearcode

    if (monthcode < 1) then
        monthcode = monthcode + 12
        year = year - 1
    end
    monthcode = math.floor(2.6 * monthcode - 0.2)

    yearcode = year % 100
    time.weekday = time.monthday + monthcode + yearcode + math.floor(yearcode / 4)
    yearcode = math.floor(year / 100)
    time.weekday = time.weekday + math.floor(yearcode / 4) - 2 * yearcode
    time.weekday = time.weekday % 7

    return time
end

function IsYearALeapYear(year)
    if ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0) then
        return true
    else
        return false
    end
end

function online(ps)
    local t = getElementsByType("player")
    exports.NGCdxmsg:createNewDxMessage(ps,"There are "..#t.." players online!",0,255,0)
end
addCommandHandler("players",online)


--anti lag on connect
-- DISABLED: handled in server/Server/server.lua
--[[
addEventHandler("onPlayerJoin",root,function()
    local p = source
    setTimer(function()
        if isElement(p) then
            setCameraMatrix(p, 1323.96, -1281.04, 23.45, 1363.29, -1278.48, 23.45,0, 88 )
        end
    end,1000,1)
end)
]]

addEventHandler("onPlayerLogin",root,function()
	local playerID = exports.server:getPlayerAccountID(source)
	local playerStatus = exports.DENmysql:querySingle( "SELECT * FROM playerstats WHERE userid=?", playerID )
        local thePlayer=source
        if ( playerStatus ) then
            local wepSkills = fromJSON( playerStatus.weaponskills )
            if ( wepSkills ) then
                for skillint, valueint in pairs( wepSkills ) do
                    if ( tonumber(valueint) > 950 ) then
                        if tonumber(skillint) == 73 then
                        setTimer(function() if isElement(thePlayer) then setPedStat ( thePlayer, tonumber(skillint), 995 ) end end,1000,10)
                        else
                        setTimer(function() if isElement(thePlayer) then setPedStat ( thePlayer, tonumber(skillint), 1000 ) end end,1000,10)
                        end
                    else
                        setTimer(function() if isElement(thePlayer) then setPedStat ( thePlayer, tonumber(skillint), tonumber(valueint) ) end end,1000,10)
                    end
                end
            end
	end
end)


for k,v in pairs(getElementsByType("player")) do
  local playerID = exports.server:getPlayerAccountID(v)
 local playerStatus = exports.DENmysql:querySingle( "SELECT * FROM playerstats WHERE userid=?", playerID )
        local thePlayer=v
        if ( playerStatus ) then
            local wepSkills = fromJSON( playerStatus.weaponskills )
            if ( wepSkills ) then
                for skillint, valueint in pairs( wepSkills ) do
				if ( tonumber(valueint) > 950 ) then
					if tonumber(skillint) == 73 then
						setPedStat(v,skillint,995)
						setTimer(function() setPedStat ( thePlayer, tonumber(skillint), 995 ) end,1000,5)
					else
						setPedStat(v,skillint,1000)

						setTimer(function() setPedStat ( thePlayer, tonumber(skillint), 1000 ) end,1000,5)
					end
				else
					setPedStat(v,skillint,valueint)
					setTimer(function() setPedStat ( thePlayer, tonumber(skillint), tonumber(valueint) ) end,1000,5)
				end
			end
		end
	end
end

addEventHandler("onPlayerLogin",root,function()
    local accName = exports.server:getPlayerAccountName(source)
    for k,v in pairs(getElementsByType("player")) do
        if exports.server:isPlayerLoggedIn(v) == true then
            local an = exports.server:getPlayerAccountName(v)
            if an == accName and v ~= source then
                kickPlayer(source,"This user is already logged in!")
            end
        end
    end
end)

setFPSLimit(60) -- to prevent weapons skills bug set to 69