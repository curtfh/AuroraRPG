function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

local screenWidth, screenHeight = guiGetScreenSize() 
local viewing = false
local messageLog = ""

local iconLabel = {}
local sms = {}
local map = {}
local weather = {}
local contacts = {}
local call = {}
local photos = {}
local clock = {}
local calculator = {}
local music = {}
local moneyTransfer = {}
local settings = {}
local changePass = {}
local notes = {}

local x,y=guiGetScreenSize()
function createPhone()
	---------------------------------------------------------------------------------------
	-- ICONS --
	phone = guiCreateStaticImage( x-405, (y-556.5)/2, 535, 556.5, "images/iphone.png", false)
	guiSetVisible(phone, false)
	background = guiCreateStaticImage( 151, 71, 230, 408, "images/wallpapers/wallpaper6.jpg", false, phone)
	guiSetEnabled(background, false)
	wallpaper = guiCreateStaticImage( 151, 71, 230, 408, "images/blank.png", false, phone)
	gotoHomeLabel = guiCreateLabel( 232, 481, 60, 60, "", false, phone)
	smsIcon = guiCreateStaticImage( 7, 342, 42, 43, "images/sms.png", false, wallpaper )
	mapIcon = guiCreateStaticImage( 64, 342, 42, 43, "images/map.png", false, wallpaper)
	weatherIcon = guiCreateStaticImage( 121, 342, 42, 43, "images/weather.png", false, wallpaper)
	contactsIcon = guiCreateStaticImage( 178, 342, 42, 43, "images/contacts.png", false, wallpaper)
	callIcon = guiCreateStaticImage( 7, 25, 42, 43, "images/call.png", false, wallpaper)
	photosIcon = guiCreateStaticImage( 64, 25, 42, 43, "images/photos.png", false, wallpaper)
	clockIcon = guiCreateStaticImage( 121, 25, 42, 43, "images/clock.png", false, wallpaper)
	calculatorIcon = guiCreateStaticImage( 178, 25, 42, 43, "images/calculator.png", false, wallpaper)
	musicIcon = guiCreateStaticImage( 7, 100, 42, 43, "images/music.png", false, wallpaper)
	calendarIcon = guiCreateStaticImage( 64, 100, 42, 43, "images/calendar.png", false, wallpaper)
	transferIcon = guiCreateStaticImage( 121, 100, 42, 43, "images/transfer.png", false, wallpaper)
	settingsIcon = guiCreateStaticImage( 178, 100, 42, 43, "images/settings.png", false, wallpaper)
	notesIcon = guiCreateStaticImage( 7, 175, 42, 43, "images/notes.png", false, wallpaper)
	iconLabel[1] = guiCreateLabel( 18, 385, 100, 20, "SMS", false, wallpaper)
	iconLabel[2] = guiCreateLabel( 73, 385, 100, 20, "Map", false, wallpaper)
	iconLabel[3] = guiCreateLabel( 120, 385, 100, 20, "Weather", false, wallpaper)
	iconLabel[4] = guiCreateLabel( 178, 385, 100, 20, "Contacts", false, wallpaper)
	iconLabel[5] = guiCreateLabel( 18, 68, 100, 20, "Call", false, wallpaper)
	iconLabel[6] = guiCreateLabel( 67, 68, 100, 20, "Photos", false, wallpaper)
	iconLabel[7] = guiCreateLabel( 129, 68, 100, 20, "Clock", false, wallpaper)
	iconLabel[8] = guiCreateLabel( 172, 68, 100, 20, "Calculator", false, wallpaper)
	iconLabel[9] = guiCreateLabel( 12, 143, 100, 20, "Music", false, wallpaper)
	iconLabel[10] = guiCreateLabel( 60, 143, 100, 20, "Calendar", false, wallpaper)
	iconLabel[11] = guiCreateLabel( 120, 143, 100, 20, "Transfer", false, wallpaper)
	iconLabel[12] = guiCreateLabel( 177, 143, 100, 20, "Settings", false, wallpaper)
	iconLabel[13] = guiCreateLabel( 12, 218, 100, 20, "Notes", false, wallpaper)
	for i = 1, 13 do
	guiSetFont(iconLabel[i], "default-bold-small")
	end
	clockLabel = guiCreateLabel( 40, 0, 242, 20, "-", false, wallpaper )
	guiSetFont(clockLabel, "default-bold-small")
	---------------------------------------------------------------------------------------
	-- SMS GUI --
	sms[1] = guiCreateEdit( 10, 25, 222, 25, "Search", false, wallpaper )
	sms[2] = guiCreateGridList( 10, 60, 222, 200, false, wallpaper )
	sms[3] = guiCreateEdit( 10, 270, 222, 35, "Text", false, wallpaper )
	sms[4] = guiCreateButton( 131, 315, 100, 35, "Send", false, wallpaper )
	sms[5] = guiCreateButton( 10, 315, 100, 35, "SMS Log", false, wallpaper )
	sms["column"] = guiGridListAddColumn(sms[2], "Players", 0.80 )
	---------------------------------------------------------------------------------------
	-- MAP GUI --
	map[1] = guiCreateEdit( 10, 25, 222, 25, "Search", false, wallpaper )
	map[2] = guiCreateGridList( 10, 60, 222, 250, false, wallpaper )
	map[3] = guiCreateButton( 131, 315, 100, 35, "Blip", false, wallpaper )
	map[4] = guiCreateButton( 10, 315, 100, 35, "Un-Blip", false, wallpaper )
	map["column"] = guiGridListAddColumn(map[2], "Players", 0.80 )
	---------------------------------------------------------------------------------------
	-- WEATHER GUI --
	weather[1] = guiCreateLabel( 60, 40, 150, 40, "Weather", false, wallpaper)
	guiSetFont(weather[1], "sa-header")
	weather[2] = guiCreateLabel( 0, 110, 242, 20, "Current weather is:", false, wallpaper )
	weather[3] = guiCreateLabel( 0, 130, 242, 30, "Weather", false, wallpaper )
	weather[4] = guiCreateLabel( 0, 190, 242, 20, "Weather in location is:", false, wallpaper )
	weather[5] = guiCreateLabel( 0, 210, 242, 30, "Weather", false, wallpaper )
	for i = 2, 5 do
	guiLabelSetHorizontalAlign ( weather[i], "center")
	guiLabelSetVerticalAlign ( weather[i], "center")
	guiSetFont(weather[i], "default-bold-small")
	end
	---------------------------------------------------------------------------------------
	-- CONTACTS GUI --
	contacts[1] = guiCreateEdit( 120, 25, 106, 25, "Search", false, wallpaper )
	contacts[2] = guiCreateGridList(10, 25, 106, 106, false, wallpaper )
	contacts["column"] = guiGridListAddColumn(contacts[2], "Players", 0.80 )
	contacts[3] = guiCreateGridList(10, 140, 215, 215, false, wallpaper)
	contacts["column1"] = guiGridListAddColumn(contacts[3], "Friends", 0.80)
	contacts[4] = guiCreateButton(120, 55, 106, 35, "Add\nFriend", false, wallpaper)
	contacts[5] = guiCreateButton(120, 95, 106, 35, "Remove\nFriend", false, wallpaper)
	---------------------------------------------------------------------------------------
	-- CALL GUI --
	call[1] = guiCreateGridList(10, 20, 220, 285, false, wallpaper)
	call[2] = guiCreateButton(131, 315, 100, 35, "Call Service", false, wallpaper)
	call["column"] = guiGridListAddColumn(call[1], "Services", 0.80)
	---------------------------------------------------------------------------------------
	-- PHOTOS GUI --
	photos[1] = guiCreateGridList( 10, 25, 222, 285, false, wallpaper )
	photos[2] = guiCreateButton( 131, 315, 100, 35, "Set\nWallpaper", false, wallpaper )
	photos["column"] = guiGridListAddColumn(photos[1], "Wallpapers", 0.80 )
	---------------------------------------------------------------------------------------
	-- CLICK GUI --
	clock[1] = guiCreateLabel( 0, 40, 242, 40, "Time", false, wallpaper)
	clock[2] = guiCreateLabel( 0, 110, 242, 20, "Local Time:", false, wallpaper )
	clock[3] = guiCreateLabel( 0, 130, 242, 30, "", false, wallpaper )
	clock[4] = guiCreateLabel( 0, 190, 242, 20, "Date:", false, wallpaper )
	clock[5] = guiCreateLabel( 0, 210, 242, 30, "", false, wallpaper )
	for i = 1, 5 do
	guiLabelSetHorizontalAlign ( clock[i], "center")
	guiLabelSetVerticalAlign ( clock[i], "center")
	guiSetFont(clock[i], "default-bold-small")
	end
	guiSetFont(clock[1], "sa-header")
	---------------------------------------------------------------------------------------
	-- CALCULATOR GUI --
	calculator[10] = guiCreateEdit( 10, 40, 222, 35, "", false, wallpaper )
	guiEditSetReadOnly(calculator[10], true)
	calculator[7] = guiCreateButton( 15, 110, 45, 45, "7", false, wallpaper )
	calculator[8] = guiCreateButton( 70, 110, 45, 45, "8", false, wallpaper )
	calculator[9] = guiCreateButton( 125, 110, 45, 45, "9", false, wallpaper )
	calculator[4] = guiCreateButton( 15, 165, 45, 45, "4", false, wallpaper )
	calculator[5] = guiCreateButton( 70, 165, 45, 45, "5", false, wallpaper )
	calculator[6] = guiCreateButton( 125, 165, 45, 45, "6", false, wallpaper )
	calculator[1] = guiCreateButton( 15, 220, 45, 45, "1", false, wallpaper )
	calculator[2] = guiCreateButton( 70, 220, 45, 45, "2", false, wallpaper )
	calculator[3] = guiCreateButton( 125, 220, 45, 45, "3", false, wallpaper )
	calculator[11] = guiCreateButton( 180, 110, 45, 45, "C", false, wallpaper )
	calculator[12] = guiCreateButton( 180, 165, 45, 45, "/", false, wallpaper )
	calculator[13] = guiCreateButton( 180, 220, 45, 45, "x", false, wallpaper )
	calculator[14] = guiCreateButton( 180, 275, 45, 45, "=", false, wallpaper )
	calculator[0] = guiCreateButton( 15, 275, 45, 45, "0", false, wallpaper )
	calculator[15] = guiCreateButton( 70, 275, 45, 45, "+", false, wallpaper )
	calculator[16] = guiCreateButton( 125, 275, 45, 45, "-", false, wallpaper )
	---------------------------------------------------------------------------------------
	-- MUSIC GUI --
	music[1] = guiCreateGridList(10, 20, 220, 170, false, wallpaper)
	music["column"] = guiGridListAddColumn(music[1], "Stations", 0.80)
	music[2] = guiCreateButton(131, 200, 100, 35, "Play/Stop", false, wallpaper)
	music[3] = guiCreateLabel( 0, 255, 242, 20, "Play from custom URL:", false, wallpaper )
	guiLabelSetHorizontalAlign ( music[3], "center")
	guiLabelSetVerticalAlign ( music[3], "center")
	guiSetFont(music[3], "default-bold-small")
	music[4] = guiCreateEdit( 10, 275, 222, 35, "", false, wallpaper)
	music[5] = guiCreateButton(131, 315, 100, 35, "Play/Stop", false, wallpaper)
	---------------------------------------------------------------------------------------
	-- HERE SHOULD BE CALENDAR STUFF --
	---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------
	-- MONEY TRANSFER GUI --
	moneyTransfer[1] = guiCreateEdit( 10, 25, 222, 25, "Search", false, wallpaper )
	moneyTransfer[2] = guiCreateGridList( 10, 60, 222, 200, false, wallpaper )
	moneyTransfer[3] = guiCreateEdit( 10, 270, 222, 35, "Amount", false, wallpaper )
	moneyTransfer[4] = guiCreateButton( 131, 315, 100, 35, "Send\nmoney", false, wallpaper )
	moneyTransfer["column"] = guiGridListAddColumn(moneyTransfer[2], "Players", 0.80 )
	---------------------------------------------------------------------------------------
	-- SETTINGS GUI--
	settings[1] = guiCreateCheckBox(10, 25, 150, 20, "Toggle heat haze", false, false, wallpaper)
	settings[2] = guiCreateCheckBox(10, 45, 150, 20, "Toggle FPS", false, false, wallpaper)
	settings[3] = guiCreateCheckBox(10, 65, 150, 20, "Toggle blur", false, false, wallpaper)
	settings[4] = guiCreateCheckBox(10, 85, 150, 20, "Toggle clouds", false, false, wallpaper)
	settings[5] = guiCreateButton( 10, 315, 100, 35, "Change\npassword", false, wallpaper )
	for i = 1, 4 do
	guiSetFont(settings[i], "default-bold-small")
	end
	---------------------------------------------------------------------------------------
	-- CHANGE PASSWORD GUI --
	changePass[0] = guiCreateLabel( 0, 20, 242, 20, "Change account password", false, wallpaper )
	guiLabelSetHorizontalAlign ( changePass[0], "center")
	guiLabelSetVerticalAlign ( changePass[0], "center")
	changePass[1] = guiCreateLabel( 10, 50, 242, 20, "Current password:", false, wallpaper )
	changePass[2] = guiCreateEdit( 10, 70, 222, 30, "", false, wallpaper )
	changePass[3] = guiCreateLabel( 10, 105, 242, 20, "New password:", false, wallpaper )
	changePass[4] = guiCreateEdit( 10, 125, 222, 30, "", false, wallpaper )
	changePass[5] = guiCreateLabel( 10, 160, 242, 20, "Repeat password:", false, wallpaper )
	changePass[6] = guiCreateEdit( 10, 180, 222, 30, "", false, wallpaper )
	changePass[7] = guiCreateLabel( 10, 215, 242, 20, "Security question:", false, wallpaper )
	changePass[8] = guiCreateLabel( 10, 230, 242, 20, "What is your mothers name?", false, wallpaper )
	changePass[9] = guiCreateLabel( 10, 260, 242, 20, "Security answer:", false, wallpaper )
	changePass[10] = guiCreateEdit( 10, 280, 222, 30, "", false, wallpaper )
	changePass[11] = guiCreateButton(131, 315, 100, 35, "Change\npassword", false, wallpaper)
	for i = 0, 11 do
	guiSetFont(changePass[i], "default-bold-small")
	end
	---------------------------------------------------------------------------------------
	-- NOTES GUI --
	notes[1] = guiCreateMemo(10, 23, 222, 280, "", false, wallpaper)
	notes[2] = guiCreateButton(131, 315, 100, 35, "Save", false, wallpaper)
	
	---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------
	
	--toggleAllIcons(false)
end
addEventHandler("onClientResourceStart", resourceRoot, createPhone)

function toggleAllIcons(bool)
	icons = {smsIcon, mapIcon, weatherIcon, contactsIcon, callIcon, photosIcon, clockIcon, calculatorIcon, musicIcon, calendarIcon, transferIcon, settingsIcon, notesIcon}
	for _, icon in ipairs(icons) do
		guiSetVisible(icon, bool)
	end
	for i = 1,13 do
	guiSetVisible(iconLabel[i], bool)
	end
end

function hideAllIfOpen()
	if (guiGetVisible(sms[1])) then
		for i = 1,5 do
			guiSetVisible(sms[i], false)
		end
	end 
	if (guiGetVisible(map[1])) then
		for i = 1,4 do
			guiSetVisible(map[i], false)
		end
	end 
	if (guiGetVisible(weather[1])) then
		for i = 1,5 do
			guiSetVisible(weather[i], false)
		end
	end 
	if (guiGetVisible(contacts[1])) then
		for i = 1,5 do
			guiSetVisible(contacts[i], false)
		end
	end
	if (guiGetVisible(call[1])) then
		for i = 1,2 do
		guiSetVisible(call[i], false)
		end
	end
	if (guiGetVisible(photos[1])) then
		for i = 1,2 do
		guiSetVisible(photos[i], false)
		end
	end
	if (guiGetVisible(clock[1])) then
		for i = 1,5 do
			guiSetVisible(clock[i], false)
		end
	end
	if (guiGetVisible(calculator[1])) then
		for i = 0,16 do
			guiSetVisible(calculator[i], false)
		end
	end
	if (guiGetVisible(music[1])) then
		for i = 1,5 do
			guiSetVisible(music[i], false)
		end
	end
	---------------------------------------------------------------------------------------
	-- HERE SHOULD BE CALENDAR STUFF --
	---------------------------------------------------------------------------------------
	if (guiGetVisible(moneyTransfer[1])) then
		for i = 1,4 do
			guiSetVisible(moneyTransfer[i], false)
		end
	end
	if (guiGetVisible(settings[1])) then
		for i = 1,5 do
			guiSetVisible(settings[i], false)
		end
	end
	if (guiGetVisible(changePass[1])) then
		for i = 0,11 do
		guiSetVisible(changePass[i], false)
		end
	end
	if (guiGetVisible(notes[1])) then
		for i = 1,2 do
		guiSetVisible(notes[i], false)
		end
	end
end

function onPlayerIconClick()
	if (source == smsIcon) then
		toggleAllIcons(false)
		for i = 1,5 do
			guiSetVisible(sms[i], true)
		end
	elseif (source == gotoHomeLabel) then
		toggleAllIcons(true)
		hideAllIfOpen()
		if (refreshClockTimer) then
		killTimer ( refreshClockTimer )
		refreshClockTimer = nil
		end
	elseif (source == mapIcon) then
		toggleAllIcons(false)
		hideAllIfOpen()
		for i = 1,4 do
			guiSetVisible(map[i], true)
		end
	elseif (source == weatherIcon) then
		toggleAllIcons(false)
		hideAllIfOpen()
		local weatherID = getWeather()
		guiSetText( weather[3], getWeatherNameFromID(weatherID))
		x, y, z = getElementPosition(localPlayer)
		guiSetText( weather[4], "Weather in "..getZoneName(x,y,z).." is:")
		guiSetText( weather[5], getWeatherNameFromID(weatherID))
		for i = 1,5 do
			guiSetVisible(weather[i], true)
		end
	elseif (source == contactsIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1,5 do
			guiSetVisible(contacts[i], true)
		end
	elseif (source == callIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1,2 do
		guiSetVisible(call[i], true)
		end
	elseif (source == photosIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1,2 do
		guiSetVisible(photos[i], true)
		end
	elseif (source == clockIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1,5 do
		guiSetVisible(clock[i], true)
		end
		refreshClockTimer = setTimer( refreshClockTime, 1000, 0 )
	elseif (source == calculatorIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 0,16 do
			guiSetVisible(calculator[i], true)
		end
	elseif (source == musicIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1, 5 do
			guiSetVisible(music[i], true)
		end
	---------------------------------------------------------------------------------------
	-- HERE SHOULD BE CALENDAR STUFF --
	---------------------------------------------------------------------------------------
	elseif (source == transferIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1,4 do
			guiSetVisible(moneyTransfer[i], true)
		end
	elseif (source == settingsIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1,5 do
			guiSetVisible(settings[i], true)
		end
	elseif (source == settings[5]) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 0,11 do
			guiSetVisible(changePass[i], true)
		end
	elseif (source == notesIcon) then
		hideAllIfOpen()
		toggleAllIcons(false)
		for i = 1,2 do
			guiSetVisible(notes[i], true)
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onPlayerIconClick)
function getTimeDate()
	local time = getRealTime()
	return 
	string.format ( "%04d/%02d/%02d", time.year + 1900, time.month + 1, time.monthday ),
	string.format ( "%02d:%02d:%02d", time.hour, time.minute, time.second )
end

function togglePhone()
	if (Animation:isPlaying(openAnim) or Animation:isPlaying(closeAnim)) then return end
	if (not exports.server:isPlayerLoggedIn(localPlayer)) then return end
	if (viewing == false) then
		viewing = true
		showCursor(true)
		--exports.NGCdxmsg:createNewDxMessage("The phone is unfortunately not ready for beta..", 255, 255, 0)
		guiSetVisible(phone, true)
		toggleAllIcons(true)
		hideAllIfOpen()
		openAnim = Animation.createAndPlay(phone, Animation.presets.guiFadeIn(1000))
		setTimer(
		function()
		local date, time = getTimeDate()
		guiSetText(clockLabel, date.." - "..time.." GMT")
		end
		, 1000, 0)
		triggerServerEvent("MTA_RP_phone.triggerToApplyWallpaper", localPlayer)
		guiSetInputMode("no_binds_when_editing")
	else
		showCursor(false)
		setTimer(guiSetVisible, 1000, 1, phone, false)
		closeAnim = Animation.createAndPlay(phone, Animation.presets.guiFadeOut(1000))
		guiSetInputMode("allow_binds")
		viewing = false
	end
end
bindKey("k", "down", togglePhone)

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- EVENTS STUFF --
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
-- SMS STUFF --
---------------------------------------------------------------------------------------

function updatePlayerSMSgridlist()
guiGridListClear(sms[2])
	for id, playeritem in ipairs(getElementsByType("player")) do 
		local row = guiGridListAddRow ( sms[2] )
		guiGridListSetItemText ( sms[2], row, sms["column"], getPlayerName ( playeritem ), false, false )
	end
end
addEventHandler("onClientPlayerJoin", root, updatePlayerSMSgridlist)
addEventHandler("onClientPlayerQuit", root, updatePlayerSMSgridlist)
addEventHandler("onClientPlayerChangeNick", root, updatePlayerSMSgridlist)
addEventHandler("onClientResourceStart", resourceRoot, updatePlayerSMSgridlist)

function searchForPlayersGrid()
	if ( source == sms[1] ) then
	guiGridListClear ( sms[2] )
	local row = guiGridListAddRow ( sms[2] )
	local text = guiGetText ( source )
		if ( text == "" ) then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
			guiGridListSetItemText ( sms[2], row, sms["column"], getPlayerName ( player ), false, false )
			end
		else
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
				guiGridListSetItemText ( sms[2], row, sms["column"], getPlayerName ( player ), false, false )
				end
			end
		end
	end
end
addEventHandler("onClientGUIChanged", guiRoot, searchForPlayersGrid)

function onClientSMSSentClick()
	if (source == sms[4]) then
	local playerFromGrid = guiGridListGetSelectedItem ( sms[2] )
		if playerFromGrid and playerFromGrid ~= -1 then
			local text = guiGetText( sms[3] )
			playerName = guiGridListGetItemText ( sms[2], playerFromGrid, sms["column"] or 1 )
			playerElement = getPlayerFromName( playerName )
			triggerServerEvent( "MTA_RP_phone.sendMessage", localPlayer, playerElement, text )
			guiSetText(sms[3], "")
		else
			exports.NGCdxmsg:createNewDxMessage("Please select a player!")
		end
	elseif (source == sms[5]) then
		crateSMSlogWindow(messageLog)
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientSMSSentClick)

addEvent("MTA_RP_phone.writeLatestSMStoSource", true)
function writeLatestSMS(toPlayer, Text)
	messageLog = messageLog.."\n[SMS]"..getPlayerName(localPlayer).."->"..getPlayerName(toPlayer)..":"..Text
end
addEventHandler("MTA_RP_phone.writeLatestSMStoSource", root, writeLatestSMS)

addEvent("MTA_RP_phone.writeLatestSMStoToPlayer", true)
function writeLatestSMS(toPlayer, Text)
	messageLog = messageLog.."\n[SMS]"..getPlayerName(toPlayer).."->"..getPlayerName(localPlayer)..":"..Text
end
addEventHandler("MTA_RP_phone.writeLatestSMStoToPlayer", root, writeLatestSMS)

smsWindow = false
function crateSMSlogWindow(log)
	if (not smsWindow) then
		messageLogWindow = guiCreateWindow( 20, 20, 475, 420, "SMS Log window", false)
		centerWindow(messageLogWindow)
		guiWindowSetSizable( messageLogWindow, false )
		logMemo = guiCreateMemo( 10, 20, 455, 410, log, false, messageLogWindow)
		guiMemoSetReadOnly( logMemo, true )
		smsWindow = true
	else
		guiSetVisible(messageLogWindow, false)
		destroyElement( messageLogWindow )
		messageLogWindow = nil
		smsWindow = false
	end
end
---------------------------------------------------------------------------------------
-- MAP STUFF --
---------------------------------------------------------------------------------------

function updatePlayermapgridlist()
guiGridListClear(map[2])
	for id, playeritem in ipairs(getElementsByType("player")) do 
		local row = guiGridListAddRow ( map[2] )
		guiGridListSetItemText ( map[2], row, map["column"], getPlayerName ( playeritem ), false, false )
	end
end
addEventHandler("onClientPlayerJoin", root, updatePlayermapgridlist)
addEventHandler("onClientPlayerQuit", root, updatePlayermapgridlist)
addEventHandler("onClientPlayerChangeNick", root, updatePlayermapgridlist)
addEventHandler("onClientResourceStart", resourceRoot, updatePlayermapgridlist)

function searchForPlayersGridMap()
	if ( source == map[1] ) then
	guiGridListClear ( map[2] )
	local row = guiGridListAddRow ( map[2] )
	local text = guiGetText ( source )
		if ( text == "" ) then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
			guiGridListSetItemText ( map[2], row, map["column"], getPlayerName ( player ), false, false )
			end
		else
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
				guiGridListSetItemText ( map[2], row, map["column"], getPlayerName ( player ), false, false )
				end
			end
		end
	end
end
addEventHandler("onClientGUIChanged", guiRoot, searchForPlayersGridMap)

clientPlayerBlips = {}
function onClientMapClick()
	if (source == map[3]) then
	local playerFromGrid = guiGridListGetSelectedItem ( map[2] )
		if (playerFromGrid and playerFromGrid ~= -1) then
			playerName = guiGridListGetItemText ( map[2], playerFromGrid, map["column"] or 1 )
			playerElement = getPlayerFromName( playerName )
			if (not clientPlayerBlips[playerElement]) then
				clientPlayerBlips[playerElement] = createBlipAttachedTo( playerElement, 58 )
			else
				exports.NGCdxmsg:createNewDxMessage("This player is already tagged", 255, 0, 0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Please select a player!")
		end
	elseif (source == map[4]) then
	local playerFromGrid = guiGridListGetSelectedItem ( map[2] )
		if (playerFromGrid and playerFromGrid ~= -1) then
			playerName = guiGridListGetItemText ( map[2], playerFromGrid, map["column"] or 1 )
			playerElement = getPlayerFromName( playerName )
			if (clientPlayerBlips[playerElement]) then
				destroyElement(clientPlayerBlips[playerElement])
				clientPlayerBlips[playerElement] = nil
			else
				exports.NGCdxmsg:createNewDxMessage("You must tag a player first!", 255, 0, 0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Please select a player!")
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientMapClick)

function targetDisconnected()
	if (clientPlayerBlips[source]) then
		if (isElement(clientPlayerBlips[source])) then
			destroyElement(clientPlayerBlips[source])
		end
	end
end
addEventHandler("onClientPlayerQuit", root, targetDisconnected)

---------------------------------------------------------------------------------------
-- WEATHER STUFF --
---------------------------------------------------------------------------------------

weatherName = {
	[0] = {"Blue Sky, Sunny"};
	[1] = {"Blue Sky, Sunny"};
	[2] = {"Blue Sky, Clouds"};
	[3] = {"Blue Sky, Clouds"};
	[4] = {"Blue Sky, Clouds"};
	[5] = {"Blue Sky, Clouds"};
	[6] = {"Blue Sky, Clouds"};
	[7] = {"Blue Sky, Clouds"};
	[8] = {"Storming"};
	[9] = {"Cloudy and Foggy"};
}

function getWeatherNameFromID( id )
	return weatherName[3][1]
end

---------------------------------------------------------------------------------------
-- CONTACTS STUFF --
---------------------------------------------------------------------------------------

function updatePlayerContactsgridlist()
guiGridListClear(contacts[2])
	for id, playeritem in ipairs(getElementsByType("player")) do 
		local row = guiGridListAddRow ( contacts[2] )
		guiGridListSetItemText ( contacts[2], row, contacts["column"], getPlayerName ( playeritem ), false, false )
	end
end
addEventHandler("onClientPlayerJoin", root, updatePlayerContactsgridlist)
addEventHandler("onClientPlayerQuit", root, updatePlayerContactsgridlist)
addEventHandler("onClientPlayerChangeNick", root, updatePlayerContactsgridlist)
addEventHandler("onClientResourceStart", resourceRoot, updatePlayerContactsgridlist)

function searchForPlayersGridContacts()
	if ( source == contacts[1] ) then
	guiGridListClear ( contacts[2] )
	local row = guiGridListAddRow ( contacts[2] )
	local text = guiGetText ( source )
		if ( text == "" ) then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
			guiGridListSetItemText ( contacts[2], row, contacts["column"], getPlayerName ( player ), false, false )
			end
		else
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
				guiGridListSetItemText ( contacts[2], row, contacts["column"], getPlayerName ( player ), false, false )
				end
			end
		end
	end
end
addEventHandler("onClientGUIChanged", guiRoot, searchForPlayersGridContacts)

function onClientContactsClick()
	if (source == contacts[4]) then
	local playerFromGrid = guiGridListGetSelectedItem ( contacts[2] )
		if (playerFromGrid and playerFromGrid ~= -1) then
			playerName = guiGridListGetItemText ( contacts[2], playerFromGrid, contacts["column"] or 1 )
			playerElement = getPlayerFromName( playerName )
			triggerServerEvent("MTA_RP_phone.addFriend", localPlayer, playerElement)
			triggerServerEvent("MTA_RP_phone.getTableToClient", localPlayer)
		else
			exports.NGCdxmsg:createNewDxMessage("Please select a player!")
		end
	elseif (source == contacts[5]) then
	local playerFromGrid = guiGridListGetSelectedItem ( contacts[3] )
		if (playerFromGrid and playerFromGrid ~= -1) then
			accountName = guiGridListGetItemText ( contacts[3], playerFromGrid, contacts["column1"] or 1 )
			triggerServerEvent("MTA_RP_phone.removeFriend", localPlayer, accountName)
			triggerServerEvent("MTA_RP_phone.getTableToClient", localPlayer)
		else
			exports.NGCdxmsg:createNewDxMessage("Please select a player!")
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientContactsClick)

isFriendOnline = {}
addEvent("MTA_RP_phone.setFriendsGrid", true)
function setFriendsGrid(friendTable)
guiGridListClear(contacts[3])
	if (friendTable and type(friendTable) == "table") then
		for i, v in ipairs (friendTable) do
			for _, player in ipairs (getElementsByType("player")) do
				if (getElementData(player, "MTA_RP_phone.accName") == v) then
					isFriendOnline[v] = getPlayerName(player)
				end
			end
			--outputChatBox(v)
			if ( type(isFriendOnline[v]) == "string") then
				local row = guiGridListAddRow ( contacts[3] )
				guiGridListSetItemText ( contacts[3], row, contacts["column1"], isFriendOnline[v], false, false )
				guiGridListSetItemColor(  contacts[3], row, contacts["column1"], 0, 255, 0)
			else
				local row = guiGridListAddRow ( contacts[3] )
				guiGridListSetItemText ( contacts[3], row, contacts["column1"], v, false, false )
				guiGridListSetItemColor(  contacts[3], row, contacts["column1"], 255, 0, 0)
			end
		end
	end
end
addEventHandler("MTA_RP_phone.setFriendsGrid", root, setFriendsGrid)



---------------------------------------------------------------------------------------
-- CALL STUFF --
---------------------------------------------------------------------------------------

callServices = {
{"Mechanic", 255, 255, 0};
{"Police", 0, 0, 153};
{"Medic", 0, 255, 255};
}

function updateCallGridList()
guiGridListClear(call[1])
	for id, service in ipairs(callServices) do 
		local row = guiGridListAddRow ( call[1] )
		guiGridListSetItemText ( call[1], row, call["column"], service[1], false, false )
		guiGridListSetItemColor ( call[1], row, call["column"], service[2], service[3], service[4] )
	end
end
addEventHandler("onClientResourceStart", resourceRoot, updateCallGridList)

function onClientCallClick()
	if (source == call[2]) then
	local serviceFromGrid = guiGridListGetSelectedItem ( call[1] )
		if (serviceFromGrid and serviceFromGrid ~= -1) then
			serviceName = guiGridListGetItemText ( call[1], serviceFromGrid, call["column"] or 1 )
			triggerServerEvent("MTA_RP_phone.callService", localPlayer, serviceName)
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientCallClick)

---------------------------------------------------------------------------------------
-- WALLPAPERS STUFF --
---------------------------------------------------------------------------------------

wallpapers = {
{"wallpaper1.jpg"};
{"wallpaper2.jpg"};
{"wallpaper3.jpg"};
{"wallpaper4.jpg"};
{"wallpaper5.jpg"};
{"wallpaper6.jpg"};
}

function updatePhotosGridList()
guiGridListClear(photos[1])
	for id, wallpaper in ipairs(wallpapers) do 
		local row = guiGridListAddRow ( photos[1] )
		guiGridListSetItemText ( photos[1], row, photos["column"], wallpaper[1], false, false )
	end
end
addEventHandler("onClientResourceStart", resourceRoot, updatePhotosGridList)

function onClientPhotoClick()
	if (source == photos[2]) then
	local wallpaperFromGrid = guiGridListGetSelectedItem ( photos[1] )
		if (wallpaperFromGrid and wallpaperFromGrid ~= -1) then
			wallpaperName = guiGridListGetItemText ( photos[1], wallpaperFromGrid, photos["column"] or 1 )
			guiStaticImageLoadImage(background, "images/wallpapers/"..wallpaperName)
			triggerServerEvent("MTA_RP_phone.saveWallpaper", localPlayer, wallpaperName)
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientPhotoClick)

addEvent("MTA_RP_phone.applyWallpaper", true)
function applyWallpaper(wallpaperName)
	guiStaticImageLoadImage(background, wallpaperName)
end
addEventHandler("MTA_RP_phone.applyWallpaper", root, applyWallpaper)

---------------------------------------------------------------------------------------
-- CLOCK STUFF --
---------------------------------------------------------------------------------------

function refreshClockTime()
	local date, time = getTimeDate()
	guiSetText( clock[3], time )
	guiSetText( clock[5], date )
end

---------------------------------------------------------------------------------------
-- CALCULATOR STUFF --
---------------------------------------------------------------------------------------

defin = ""
noumberOne = ""
noumberTwo = ""


function onClientCalculatorClick()
	if (source == calculator[7]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."7")
	elseif (source == calculator[8]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."8")
	elseif (source == calculator[9]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."9")
	elseif (source == calculator[4]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."4")
	elseif (source == calculator[5]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."5")
	elseif (source == calculator[6]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."6")
	elseif (source == calculator[3]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."3")
	elseif (source == calculator[2]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."2")
	elseif (source == calculator[1]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."1")
	elseif (source == calculator[0]) then
	guiSetText(calculator[10], guiGetText(calculator[10]).."0")
	elseif (source == calculator[11]) then
	guiSetText(calculator[10], "0")
	noumberOne = ""
	noumberTwo = ""
	elseif (source == calculator[12]) then
		if (guiGetText(calculator[10]) == "") then
			noumberOne = 0
		else
			noumberOne = guiGetText(calculator[10])
		end
	defin = "/"
	guiSetText(calculator[10], "")
	elseif (source == calculator[13]) then
	if (guiGetText(calculator[10]) == "") then
			noumberOne = 0
		else
			noumberOne = guiGetText(calculator[10])
		end
	defin = "*"
	guiSetText(calculator[10], "")
	elseif (source == calculator[15]) then
		if (guiGetText(calculator[10]) == "") then
			noumberOne = 0
		else
			noumberOne = guiGetText(calculator[10])
		end
	defin = "+"
	guiSetText(calculator[10], "")
	elseif (source == calculator[16]) then
		if (guiGetText(calculator[10]) == "") then
			noumberOne = 0
		else
			noumberOne = guiGetText(calculator[10])
		end
	defin = "-"
	guiSetText(calculator[10], "")
	elseif (source == calculator[14]) then
		if (guiGetText(calculator[10]) == "") then
			noumberTwo = 0
		else
			noumberTwo = guiGetText(calculator[10])
		end
		if defin == "+" then
			guiSetText(calculator[10],tonumber(noumberOne)+tonumber(noumberTwo))
		end
		if defin == "-" then
			guiSetText(calculator[10],tonumber(noumberOne)-tonumber(noumberTwo))
		end
		if defin == "*" then
			guiSetText(calculator[10],tonumber(noumberOne)*tonumber(noumberTwo))
		end
		if defin == "/" then
			guiSetText(calculator[10],tonumber(noumberOne)/tonumber(noumberTwo))
		end
	defin = ""
	noumberOne = ""
	noumberTwo = ""
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientCalculatorClick)

---------------------------------------------------------------------------------------
-- MUSIC STUFF --
---------------------------------------------------------------------------------------

radioStations = 
{
{"Hip Hop Radio", "http://mp3uplink.duplexfx.com:8054/listen.pls"};
{"Power 181", "http://www.181.fm/winamp.pls?station=181-power&style=mp3&description=Power%20181%20(Top%2040)&file=181-power.pls"};
{"Hot 108 Jamz", "http://scfire-dtc-aa01.stream.aol.com:80/stream/1038"};
{"Hot 108 Jamz #1 FOR HIP HOP", "http://scfire-ntc-aa01.stream.aol.com:80/stream/1071"};
{"181.fm - The Breeze", "http://uplink.181.fm:8004/"};
{"181.FM - Chilled", "http://sc-rly.181.fm:80/stream/1092"};
{"181.FM - Energy 98 - Dance Hits", "http://sc-rly.181.fm:80/stream/1093"};
{"181.FM - Kickin' Country", "http://sc-rly.181.fm:80/stream/1075"};
{"181.FM - Lite 80's", "http://uplink.181.fm:8040/"};
{"181.FM - PARTY 181", "http://uplink.181.fm:8036/"};
{"181.fm - True R&B", "http://uplink.181.fm:8022/"};
{"181.fm - Rock 181", "http://uplink.181.fm:8008/"};
{"181.fm - Rock 40", "http://uplink.181.fm:8028/"};
{"181.FM - Star 90's", "http://uplink.181.fm:8012/"};
{"181.FM - The BEAT * #1 For HipHop and R&B", "http://mp3uplink.duplexfx.com:8054/"};
{"Radio 1", "http://195.70.35.172:8000/radio1.mp3"};
{"LARISSA DEEJAY", "http://s4.onweb.gr:8850/"};
{"181.FM - POWER 181(top 40)", "http://relay.181.fm:8128/"};
}

function setUpCarMusicOnResourceStart()
	local veh = getPedOccupiedVehicle(localPlayer)
	if(veh) then
		local seat = 1
		if getVehicleOccupant ( veh, 0 ) == localPlayer then
			seat = 0
		end
		triggerEvent("onClientVehicleEnter", veh, localPlayer, seat)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, setUpCarMusicOnResourceStart)

function cleanUpCarMusicOnResourceStop()
	local veh = getPedOccupiedVehicle(localPlayer)
	if(veh and getVehicleOccupant ( veh, 0 ) == localPlayer) then
		setElementData(veh, "MTA_RP_phone.vehicleMusic", false)
	end
end
addEventHandler("onClientResourceStop", resourceRoot, cleanUpCarMusicOnResourceStop)

function updateStationGridList()
guiGridListClear(music[1])
	for id, station in ipairs(radioStations) do 
		local row = guiGridListAddRow ( music[1] )
		guiGridListSetItemText ( music[1], row, music["column"], station[1], false, false )
		guiGridListSetItemData ( music[1], row, music["column"], station[2])
	end
end
addEventHandler("onClientResourceStart", resourceRoot, updateStationGridList)

function vehicleMusicChanged(dataname, oldVal)
	if (source ~= getPedOccupiedVehicle(localPlayer)) then return end
	if(dataname == "MTA_RP_phone.vehicleMusic") then
		if(not isElement(soundElement)) then
			local driverMusicURL = getElementData(source, "MTA_RP_phone.vehicleMusic")
			if(not driverMusicURL) then
				if(isElement(driverMusicElement)) then
					destroyElement(driverMusicElement)
				end
				return
			end
			if(isElement(driverMusicElement)) then
				destroyElement(driverMusicElement)
			else
				exports.NGCdxmsg:createNewDxMessage("Now listening to the drivers music.", 50, 50, 255)
			end
			driverMusicElement = playSound(driverMusicURL)
		end
	end
end

function exitVehicle(plr, seat)
	if (plr ~= localPlayer) then return end
	if ( seat == 0 ) then
		setElementData(source, "MTA_RP_phone.vehicleMusic", false)
	else
		removeEventHandler("onClientElementDataChange", getRootElement(), vehicleMusicChanged)
		if(isElement(driverMusicElement)) then
			destroyElement(driverMusicElement)
		end
	end
end
addEventHandler("onClientVehicleExit", getRootElement(), exitVehicle)

function enterVehicle(plr, seat)
	if plr ~= localPlayer then return end
	if (seat == 0 and isElement(soundElement)) then
		setElementData(source, "MTA_RP_phone.vehicleMusic", stationURL)
	elseif (seat ~= 0) then
		addEventHandler("onClientElementDataChange", getRootElement(), vehicleMusicChanged)
		triggerEvent("onClientElementDataChange", source, "MTA_RP_phone.vehicleMusic")
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), enterVehicle)

function playMusicGUISound()
	local veh = getPedOccupiedVehicle(localPlayer)
	
	local isDriver = false
	if(isElement(veh))then
		isDriver = (getVehicleOccupant(veh, 0) == localPlayer)
	end
	if(isElement(driverMusicElement)) then
		exports.NGCdxmsg:createNewDxMessage("Stopped listening to the drivers music. Press again to start your music.", 50, 50, 255)
		destroyElement(driverMusicElement)
	elseif (stationURL and not isElement(soundElement)) then
		soundElement = playSound(stationURL)
		if(veh and isDriver and stationURL) then
			setElementData(veh, "MTA_RP_phone.vehicleMusic", stationURL)
		end
	elseif(isElement(soundElement)) then
		destroyElement(soundElement)
		soundElement = nil
		if(veh and not isDriver) then
			local driverMusicURL = getElementData(veh, "MTA_RP_phone.vehicleMusic")
			if(driverMusicURL) then
				exports.NGCdxmsg:createNewDxMessage("Now listening to the drivers music.", 50, 50, 255)
				driverMusicElement = playSound(driverMusicURL)
			end
		end
	end
end

function onClientMusicClick()
	if (source == music[2]) then
		local selectedRow, selectedColumn = guiGridListGetSelectedItem(music[1]) 
		stationURL = guiGridListGetItemData(music[1], selectedRow, selectedColumn)
		playMusicGUISound()
	elseif (source == music[5]) then
		stationURL = guiGetText(music[4])
		playMusicGUISound()
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientMusicClick)


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- HERE SHOULD BE CALENDAR STUFF --
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
-- MONEY TRANSFER STUFF
---------------------------------------------------------------------------------------

function updatePlayerMoneyTransfergridlist()
guiGridListClear(moneyTransfer[2])
	for id, playeritem in ipairs(getElementsByType("player")) do 
		local row = guiGridListAddRow ( moneyTransfer[2] )
		guiGridListSetItemText ( moneyTransfer[2], row, moneyTransfer["column"], getPlayerName ( playeritem ), false, false )
	end
end
addEventHandler("onClientPlayerJoin", root, updatePlayerMoneyTransfergridlist)
addEventHandler("onClientPlayerQuit", root, updatePlayerMoneyTransfergridlist)
addEventHandler("onClientPlayerChangeNick", root, updatePlayerMoneyTransfergridlist)
addEventHandler("onClientResourceStart", resourceRoot, updatePlayerMoneyTransfergridlist)

function searchForPlayerMoneyTransferGrid()
	if ( source == moneyTransfer[1] ) then
	guiGridListClear ( moneyTransfer[2] )
	local row = guiGridListAddRow ( moneyTransfer[2] )
	local text = guiGetText ( source )
		if ( text == "" ) then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
			guiGridListSetItemText ( moneyTransfer[2], row, moneyTransfer["column"], getPlayerName ( player ), false, false )
			end
		else
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
				guiGridListSetItemText ( moneyTransfer[2], row, moneyTransfer["column"], getPlayerName ( player ), false, false )
				end
			end
		end
	end
end
addEventHandler("onClientGUIChanged", guiRoot, searchForPlayerMoneyTransferGrid)

function onClientTransferMoneyClick()
	if (source == moneyTransfer[4]) then
	local playerFromGrid = guiGridListGetSelectedItem ( moneyTransfer[2] )
		if playerFromGrid and playerFromGrid ~= -1 then
			local ammount = guiGetText( moneyTransfer[3] )
			playerName = guiGridListGetItemText ( moneyTransfer[2], playerFromGrid, moneyTransfer["column"] or 1 )
			playerElement = getPlayerFromName( playerName )
			triggerServerEvent( "MTA_RP_phone.sendMoney", localPlayer, playerElement, ammount )
		else
			exports.NGCdxmsg:createNewDxMessage("Please select a player!")
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientTransferMoneyClick)

---------------------------------------------------------------------------------------
-- SETTINGS STUFF --
---------------------------------------------------------------------------------------

function onClientSettingClick()
	if (source == settings[1]) then
		if (guiCheckBoxGetSelected(settings[1])) then
			setHeatHaze(100)
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "heatHaze", true)
		else
			setHeatHaze(0)
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "heatHaze", false)
		end
	elseif (source == settings[2]) then
		if (guiCheckBoxGetSelected(settings[2])) then
			addEventHandler("onClientRender", root, showPlayerFPS)
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "FPS", true)
		else
			removeEventHandler("onClientRender", root, showPlayerFPS)
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "FPS", false)
		end
	elseif (source == settings[3]) then
		if (guiCheckBoxGetSelected(settings[3])) then
			setBlurLevel(100)
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "blur", true)
		else
			setBlurLevel(36)
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "blur", false)
		end
	elseif (source == settings[4]) then
		if (guiCheckBoxGetSelected(settings[4])) then
			setCloudsEnabled( true )
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "clouds", true)
		else
			setCloudsEnabled( false )
			triggerServerEvent("MTA_RP_phone.saveWorldData", localPlayer, "clouds", false)
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientSettingClick)

local counter = 0
local starttick
local currenttick
local currentFPS
function showPlayerFPS()
	if (currentFPS) then
		dxDrawText ( currentFPS, 44, screenHeight - 41, screenWidth, screenHeight, tocolor ( 0, 255, 0, 255 ), 1.5, "pricedown" )
	end
	if not starttick then
		starttick = getTickCount()
	end
counter = counter + 1
currenttick = getTickCount()
	if currenttick - starttick >= 1000 then
		currentFPS = counter
		counter = 0
		starttick = false
	end
end

addEvent("MTA_RP_phone.setWorldData", true)
function setWorldData(heatHazeData, fpsData, blurData, cloudsData)
guiCheckBoxSetSelected(settings[1], heatHazeData)
guiCheckBoxSetSelected(settings[2], fpsData)
guiCheckBoxSetSelected(settings[3], blurData)
guiCheckBoxSetSelected(settings[4], cloudsData)
	if (heatHazeData == true) then
		setHeatHaze(100)
	else
		setHeatHaze(0)
	end
	if (fpsData == true) then
		addEventHandler("onClientRender", root, showPlayerFPS)
	else
		removeEventHandler("onClientRender", root, showPlayerFPS)
	end
	if (blurData == true) then
		setBlurLevel(100)
	else
		setBlurLevel(0)
	end
	if (cloudsData == true) then
		setCloudsEnabled( true )
	else
		setCloudsEnabled( false )
	end
end
addEventHandler("MTA_RP_phone.setWorldData", root, setWorldData)

---------------------------------------------------------------------------------------
-- CHANGE PASSWORD STUFF --
---------------------------------------------------------------------------------------

function onClientChangePassClick()
	if (source == changePass[11]) then
		local curPass = guiGetText(changePass[2])
		local newPass1 = guiGetText(changePass[4])
		local newPass2 = guiGetText(changePass[6])
		local securityAnswer = guiGetText(changePass[10])
		if (newPass1 == newPass2) then
			if string.len(newPass1) >= 5 then
				triggerServerEvent("MTA_RP_phone.changePlayerPassword", localPlayer, curPass, newPass1, securityAnswer)
			else
			exports.NGCdxmsg:createNewDxMessage("Password must be at least 5 characters long", 255, 0, 0)
			end
		else
		exports.NGCdxmsg:createNewDxMessage("New passwords does not match", 255, 0, 0)
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientChangePassClick)

addEvent("MTA_RP_phone.setSecurityQuestioN", true)
function setSecurityQuestioN( question )
	guiSetText(changePass[8], tostring(question) )
end
addEventHandler("MTA_RP_phone.setSecurityQuestioN", root, setSecurityQuestioN)

---------------------------------------------------------------------------------------
-- NOTES STUFF --
---------------------------------------------------------------------------------------

function onClientChangePassClick()
	if (source == notes[2]) then
	local notes = guiGetText(notes[1])
		triggerServerEvent("MTA_RP_phone.saveNotes", localPlayer, notes)
	end
end
addEventHandler("onClientGUIClick", guiRoot, onClientChangePassClick)

addEvent( "MTA_RP_phone.setNotes", true)
function setNotes(noteText)
	guiSetText(notes[1], noteText)
end
addEventHandler("MTA_RP_phone.setNotes", root, setNotes)