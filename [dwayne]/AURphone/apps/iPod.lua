local ipodGUI = {}
local volume = nil
local soundURL = nil
local showStartSong = false
local updateStations = true
local iPodSound=false
exports.DENsettings:addPlayerSetting( "iPodTitle", "true" )

addEvent("onSMS",true)

local iPodRadio = {
	["Aurora"] =  {
		{"Aurora", "http://uk.curtcreation.net:8000/aurora"},
		{"Power 181", "http://listen.181fm.com:8128"},
		{"UK TOP 40", "http://listen.181fm.com:8070"},
		{"OldSchool Hip Hop", "http://listen.181fm.com:8068"},
		{"The Buzz", "http://listen.181fm.com:8126"},
		{"90's Country", "http://listen.181fm.com:8050"},
		{"Highway 181", "http://listen.181fm.com:8018"},
		{"Energy 98", "http://listen.181fm.com:8800"},
		{"90's Dance", "http://listen.181fm.com:8140"},
	},
}


function openiPod()
	togglePhone()
	executeCommandHandler ( "mplayer" )
end
apps[3][8] = openiPod

function loadRadioStations ()
	guiGridListClear(ipodGUI[1])
	for theName, theCategory in pairs( iPodRadio ) do
		local row = guiGridListAddRow( ipodGUI[1] )
		guiGridListSetItemText( ipodGUI[1], row, 1, theName, true, false )

		for theIndex, theStation in pairs( theCategory ) do
			local row = guiGridListAddRow( ipodGUI[1] )
			guiGridListSetItemText( ipodGUI[1], row, 1, theStation[1], false, false )
			guiGridListSetItemData ( ipodGUI[1], row, 1, theStation[2] )
		end
	end
	if ( iPodSound ) and (  volume ) then guiSetText ( ipodGUI[6], "Radio volume: " .. math.floor((volume/1*100)) .. "%" ) end
end

function closeiPod()

	removeEventHandler ( "onClientGUIClick", ipodGUI[3], onStartMusic )
	removeEventHandler ( "onClientGUIClick", ipodGUI[2], onStopMusic )
	removeEventHandler ( "onClientGUIClick", ipodGUI[4], onAddVolume )
	removeEventHandler ( "onClientGUIClick", ipodGUI[5], onLowerVolume )
	removeEventHandler ( "onClientGUIClick", ipodGUI[8], onShowSongTitleSetting )

	for i=1,#ipodGUI do
		if i ~= 7 then
			guiSetVisible ( ipodGUI[i], false )
			guiSetProperty ( ipodGUI[i], "AlwaysOnTop", "False" )
		end
	end

	apps[3][7] = false

end
apps[3][9] = closeiPod

function onStartMusic ()
	local row, column = guiGridListGetSelectedItem ( ipodGUI[1] )
	if ( row ) then
		if ( iPodSound ) then stopSound( iPodSound ) end
		local stationURL = guiGridListGetItemData( ipodGUI[1], row, column )
		iPodSound = playSound( stationURL )
		soundURL = stationURL
		if ( volume ) then setSoundVolume(iPodSound, volume) else setSoundVolume(iPodSound, 0.5) end

		showStartSong = true
	end
end

function onStopMusic ()
	if ( iPodSound ) then
		stopSound( iPodSound )
		soundURL = nil
	end
end

function onAddVolume ()
	if ( iPodSound ) then
		if ( tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) +0.1 ) ) <= 1 ) then
			volume = tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) +0.1 ) )
			setSoundVolume(iPodSound, volume )
			guiSetText ( ipodGUI[6], "iPod volume: " .. math.floor((volume/1*100)) .. "%" )
		end
	end
end

function onLowerVolume ()
	if ( iPodSound ) then
		if ( tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) -0.1 ) ) >= 0 ) then
			volume = tonumber( string.format( "%.1f", getSoundVolume ( iPodSound ) -0.1 ) )
			setSoundVolume(iPodSound, volume )
			guiSetText ( ipodGUI[6], "iPod volume: " .. math.floor((volume/1*100)) .. "%" )
		end
	end
end

function onShowSongTitleSetting ()
	if ( source == ipodGUI[8] ) then
		exports.DENsettings:setPlayerSetting( "iPodTitle", tostring( guiCheckBoxGetSelected( ipodGUI[8] ) ) )
	end
end

addEventHandler( "onClientSoundChangedMeta", root,
	function( theStream )
		if ( iPodSound ) and ( exports.DENsettings:getPlayerSetting ( "iPodTitle" ) ) and ( iPodSound == source ) then
			local aTable = getSoundMetaTags ( source )
			if ( tostring( aTable.stream_title ) ~= "nil" ) then exports.NGCdxmsg:createNewDxMessage( "iPod current song: " .. tostring( aTable.stream_title ) .."", 0, 225, 0 ) end
		end
	end
)

addEventHandler( "onClientSoundStream", root,
	function( state, length, theStream )
		if ( state ) and ( exports.DENsettings:getPlayerSetting ( "iPodTitle" ) ) and ( iPodSound ) and ( showStartSong ) then
			local aTable = getSoundMetaTags ( iPodSound )
			if ( tostring( aTable.stream_title ) ~= "nil" ) then exports.NGCdxmsg:createNewDxMessage( "iPod current song: " .. tostring( aTable.stream_title ) .."", 0, 225, 0 ) end
			showStartSong = false
		end
	end
)
