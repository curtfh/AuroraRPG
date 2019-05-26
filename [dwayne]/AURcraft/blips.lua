craft = {
	createBlip(2246.16,-1923.84,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2203.22,-2036.78,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2445.7,-2033,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2519.89,-1958.32,13.62,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2450.68,-1785.64,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2383.8,-1467.01,24,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2335.98,-1319.29,24.09,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2475.52,-1202.5,36.26,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2520.6,-1107.33,56.2,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2392.33,-1211.42,27.15,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2169.24,-1492.09,23.98,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2276.51,-1672.32,15.21,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2369.51,-1641.01,13.49,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2423.98,-1643.3,13.49,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2441.06,-1688.67,13.8,23, 2, 0, 0, 0, 0, 0, 270),
}

function create()
	craft = {
	createBlip(2246.16,-1923.84,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2203.22,-2036.78,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2445.7,-2033,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2519.89,-1958.32,13.62,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2450.68,-1785.64,13.23,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2383.8,-1467.01,24,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2335.98,-1319.29,24.09,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2475.52,-1202.5,36.26,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2520.6,-1107.33,56.2,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2392.33,-1211.42,27.15,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2169.24,-1492.09,23.98,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2276.51,-1672.32,15.21,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2369.51,-1641.01,13.49,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2423.98,-1643.3,13.49,23, 2, 0, 0, 0, 0, 0, 270),
	createBlip(2441.06,-1688.67,13.8,23, 2, 0, 0, 0, 0, 0, 270),
}
end

local blipswitch = function (blipstate)
	if blipstate then
	    for k,v in ipairs(craft) do
			if isElement(v) then destroyElement(v) end
		end
		create()
	else
    	for k,v in ipairs(craft) do
			if isElement(v) then destroyElement(v) end
		end
	end
end

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, blipstate )
		if setting == "craft" then
			blipswitch( blipstate )
		end
	end
)

function checkSettingblip()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "craft" )
		blipswitch( setting )
	else
		setTimer( checkSettingblip, 5000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettingblip )
setTimer( checkSettingblip, 5000, 0 )
