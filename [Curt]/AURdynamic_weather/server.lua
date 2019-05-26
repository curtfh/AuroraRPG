function syncTime()
    local realTime = getRealTime()
    local hour = realTime.hour
    local minute = realTime.minute
    setMinuteDuration (60000)
    setTime(hour , minute)
end

setTimer (syncTime, 500, 1)
setTimer (syncTime, 3000000, 0)

function SyncTime2()
	setTimer (syncTime, 4000, 1)
end
addEventHandler ("onResourceStart", getResourceRootElement(getThisResource()), SyncTime2)
