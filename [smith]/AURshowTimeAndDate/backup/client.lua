timetriggered = setTimer(function() currentTime() end,1000,0)
local x,y = guiGetScreenSize()
labelTimeandDate = guiCreateLabel( x - 351, y - 16, 264, 17, "Time and Data System - by Smith ", false)
    --guiSetFont(labelTimeandDate, "default-bold-small")
    guiLabelSetColor(labelTimeandDate, 254, 254, 254)
    guiLabelSetHorizontalAlign(labelTimeandDate, "right", false)
    guiLabelSetVerticalAlign(labelTimeandDate, "center")
guiSetVisible(labelTimeandDate, true)

function showOrHideTime ()
	guiSetVisible(labelTimeandDate, not guiGetVisible(labelTimeandDate))
end    
addCommandHandler ( "showtime", showOrHideTime)

function currentTime()
    local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
	local day = time.monthday
	local month = time.month+1
	local year = time.year+1900
    guiSetText ( labelTimeandDate,tostring("Time: "..hours..":"..minutes.."."..seconds.."  Date: "..day.." - "..month.." - "..year.." ") )
end
