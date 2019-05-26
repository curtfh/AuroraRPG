local maxFPS = getFPSLimit()
local minFPS = 25
local timerChecker = 500

local rootElement = getRootElement()
local cachedState = isElementInWater(localPlayer)

triggerServerEvent ( "getMinFPS", resourceRoot )

addEvent( "setMinFPS", true )
addEventHandler( "setMinFPS", localPlayer, function ( fpsValue )
	minFPS = fpsValue
end )

addEventHandler ("onClientResourceStart", resourceRoot, function()
	setTimer(function()	
		local stateNow = isElementInWater( localPlayer )
		if cachedState ~= stateNow then
			if stateNow then
				setFPSLimit( minFPS )
				cachedState = stateNow
			 else 
				setFPSLimit( maxFPS )
				cachedState = stateNow
			 end
		end
	end, timerChecker, 0 )
end) 