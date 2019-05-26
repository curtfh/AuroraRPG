oldTime = 0
difference = 60
cButtonHitCount = 0

setTimer (
	function ()
		local time = getRealTime()
		local hours = time.hour
		local minutes = time.minute
		local seconds = time.second
		local currentTime = (hours * 3600) + (minutes * 60) + seconds
		
		if ( oldTime > 1 ) then
		difference = currentTime - oldTime
			if ( difference > 1 ) then
				if ( difference < 35 ) then
					theSpeed = 60/difference
					triggerServerEvent ( "onServerKickSpeedHacker", localPlayer, theSpeed ) 
				end
			end
		end
		oldTime = currentTime	
	end
,60000, 0)