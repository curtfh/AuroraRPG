-- Some data for the scoreboard
setTimer (
	function ()
		setElementData ( localPlayer, "WL", getPlayerWantedLevel( localPlayer ) )
		setElementData ( localPlayer, "Money", "$ "..exports.server:convertNumber( getPlayerMoney( localPlayer ) ) )
		setElementData ( localPlayer, "City", exports.server:getPlayChatZone() )
	end, 1000, 0
)

-- Playtime of a user
setTimer (
	function ()
		if ( getElementData ( localPlayer, "playTime" ) ) then
			local theTime = ( getElementData ( localPlayer, "playTime" ) + 5 )
			setElementData( localPlayer, "playTime", math.floor( theTime ) )
			setElementData( localPlayer, "Play Time", math.floor( theTime / 60 ).." Hours" )
		else
			setElementData( localPlayer, "playTime", 0 )
			setElementData( localPlayer, "Play Time", 0 )
		end
	end, 60000*5, 0
)

-- When the player login set playtime
addEvent( "onClientPlayerLogin" )
addEventHandler( "onClientPlayerLogin", localPlayer,
	function ()
		if ( getElementData ( localPlayer, "playTime" ) ) then
			local theTime = ( getElementData ( localPlayer, "playTime" ) )
			setElementData( localPlayer, "Play Time", math.floor( theTime / 60 ).." Hours" )
		else
			setElementData( localPlayer, "playTime", 0 )
			setElementData( localPlayer, "Play Time", 0 )
		end
	end
)

-- Settings from the CSG Phone
addEventHandler( "onPlayerSettingChange", root,
	function ( theSetting, newValue, oldValue )
		if ( newValue ~= nil ) then
			if ( theSetting == "blur" ) then
				if ( newValue == true ) then
					setBlurLevel ( 36 )
				else
					setBlurLevel ( 0 )
				end
			elseif ( theSetting == "heathaze" ) then
				if ( newValue == true ) then
					setHeatHaze ( 100 )
				else
					setHeatHaze ( 0 )
				end
			elseif ( theSetting == "fpsmeter" ) then
				if ( newValue == true ) then
					drawStates(true)
				else
					drawStates(false)
				end
			elseif ( theSetting == "clouds" ) then
				setCloudsEnabled ( newValue )
			elseif ( theSetting == "chatbox" ) then
				showChat ( newValue )
			elseif ( theSetting == "sms" ) then
				setElementData( localPlayer, "SMSoutput", newValue )
			elseif ( theSetting == "speedmeter" ) then
				triggerEvent( "onClientSwitchSpeedMeter", localPlayer, newValue )
			elseif ( theSetting == "damagemeter" ) then
				triggerEvent( "onClientSwitchDamageMeter", localPlayer, newValue )
			elseif ( theSetting == "fuelmeter" ) then
				triggerEvent( "onClientSwitchFuelMeter", localPlayer, newValue )
			elseif ( theSetting == "groupblips" ) then
				triggerEvent( "onClientSwitchGroupBlips", localPlayer, newValue )
			elseif ( theSetting == "grouptags" ) then
				triggerEvent( "onClientSwitchGroupTags", localPlayer, newValue )
			end
		end
	end
)


local root = getRootElement()
local player = localPlayer
--local ping = getPlayerPing(player)
local counter = 0
local starttick
local currenttick
local toggle = false
setElementData(player, "FPS", 60)
--FPS Counter, this runs in the background even if its enabled / disabled.
--[[addEventHandler("onClientRender",root,
	function ()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(player, "FPS", counter - 1)
			counter = 0
			starttick = false
		end
	end
)]]

function collectPing()
	local ping = setElementData(localPlayer, "Ping", getPlayerPing(localPlayer))
end
setTimer(collectPing, 3000, 0)

