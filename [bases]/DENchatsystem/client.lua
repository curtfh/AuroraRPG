local chatRooms = {
"Support", "Mainchat", "AUR", "Localchat", "Teamchat", "Groupchat", "Alliancechat", "NL", "TN", "TR", "RU", "AR","PT-BR" -- USE NAMES THAT ARE COMPATIBLE WITH XML, SO NOT '/'
}

local chatSystemGUI = {}

function onClientChatSystemMessage ()
	local theTab = guiGetSelectedTab( CSGChatTabpanel )
	local theTabName = guiGetText( theTab )
	local theMessage = guiGetText( chatSystemGUI[theTabName][3] )
	if not ( theMessage ) or ( theMessage:match("^%s*$") ) or ( theMessage == "" ) or ( theMessage == " " ) then
		return
	else
		triggerServerEvent( "onChatSystemSendMessage", localPlayer, theMessage, theTabName )
		guiSetText( chatSystemGUI[theTabName][3], "" )
	end
end

function onClientChatSystemCheckbox ()
	local theTab = guiGetSelectedTab( CSGChatTabpanel )
	local theTabName = guiGetText( theTab )
	if ( source == chatSystemGUI[theTabName][4] ) then
		local theCheckBox =	guiCheckBoxGetSelected( chatSystemGUI[theTabName][4] )
		exports.DENsettings:setPlayerSetting( "chatOutput"..theTabName, tostring( theCheckBox ) )
		setElementData( localPlayer, "chatOutput"..theTabName, theCheckBox )
	end
end

CSGChatWindow = guiCreateWindow(370,228,745,447,"AUR ~ Chatsystem",false)
CSGChatTabpanel = guiCreateTabPanel(9,25,736,411,false,CSGChatWindow)

for i, roomName in ipairs ( chatRooms ) do
	chatSystemGUI[roomName] = {}
	chatSystemGUI[roomName][1] = guiCreateTab( roomName, CSGChatTabpanel )
	chatSystemGUI[roomName][2] = guiCreateGridList( 2, 4, 720, 356, false, chatSystemGUI[roomName][1] )
	chatSystemGUI[roomName][3] = guiCreateEdit( 1, 359, 604, 27, "", false, chatSystemGUI[roomName][1] )
	chatSystemGUI[roomName][4] = guiCreateCheckBox( 609, 362, 112, 21, "Show in chatbox", false, false, chatSystemGUI[roomName][1] )
	chatSystemGUI[roomName][5] = guiGridListAddColumn( chatSystemGUI[roomName][2], "Nickname:", 0.25 )
	chatSystemGUI[roomName][6] = guiGridListAddColumn( chatSystemGUI[roomName][2], "Message:", 0.72 )
	guiGridListSetSelectionMode( chatSystemGUI[roomName][2], 0 )
	guiGridListSetSortingEnabled ( chatSystemGUI[roomName][2], false )
	if (roomName == "AUR") then
		guiSetEnabled(chatSystemGUI["AUR"][1], false)
	end
	addEventHandler( "onClientGUIAccepted", chatSystemGUI[roomName][3], onClientChatSystemMessage )
	addEventHandler( "onClientGUIClick", chatSystemGUI[roomName][4], onClientChatSystemCheckbox )

	if ( roomName == "NL" ) or ( roomName == "TN" ) or ( roomName == "TR" ) or ( roomName == "RU" ) or ( roomName == "AR" ) or (roomName=="PT-BR") then
		exports.DENsettings:addPlayerSetting( "chatOutput"..roomName, "false")
	else
		exports.DENsettings:addPlayerSetting( "chatOutput"..roomName, "true")
	end

	local settingState = exports.DENsettings:getPlayerSetting( "chatOutput"..roomName )
	guiCheckBoxSetSelected ( chatSystemGUI[roomName][4], settingState )
	setElementData( localPlayer, "chatOutput"..roomName, settingState )
end

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize( CSGChatWindow, false )
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition( CSGChatWindow, x, y, false )

guiWindowSetMovable ( CSGChatWindow, true )
guiWindowSetSizable ( CSGChatWindow, false )
guiSetVisible ( CSGChatWindow, false )

bindKey( "j", "down",
function()
	if ( guiGetVisible ( CSGChatWindow ) ) then
		guiSetVisible( CSGChatWindow, false )
		showCursor( false )
		if (exports.CSGstaff:isPlayerStaff(localPlayer)) then
			guiSetEnabled(chatSystemGUI["AUR"][1], false)
		end
	else
		if (exports.CSGstaff:isPlayerStaff(localPlayer)) then
			guiSetEnabled(chatSystemGUI["AUR"][1], true)
		end
		guiSetVisible( CSGChatWindow, true)
		showCursor( true )
		guiSetInputMode("no_binds_when_editing")
	end
end
)

addEvent( "onChatSystemMessageToClient", true )
addEventHandler("onChatSystemMessageToClient", localPlayer,
function ( thePlayer, theMessage, theRoom, theName )
	if ( chatSystemGUI[theRoom][2] ) then
		if ( thePlayer ) then
			if (theRoom == "AUR" and thePlayer) then
				local row = guiGridListInsertRowAfter ( chatSystemGUI[theRoom][2], -1 )
				guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 1, getPlayerName( thePlayer ), false, false )
				guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 2, theMessage, false, false )
				return
			end
			local row = guiGridListInsertRowAfter ( chatSystemGUI[theRoom][2], -1 )
			guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 1, getPlayerName( thePlayer ), false, false )
			guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 2, theMessage, false, false )

			if ( theRoom == "Support" ) and ( exports.CSGstaff:isPlayerStaff( thePlayer ) ) then
				guiGridListSetItemColor ( chatSystemGUI[theRoom][2], row, 1, 255, 128, 0 )
				guiGridListSetItemColor ( chatSystemGUI[theRoom][2], row, 2, 255, 128, 0 )
			end
		else
			if (theRoom == "AUR" and thePlayer) then
				local row = guiGridListInsertRowAfter ( chatSystemGUI[theRoom][2], -1 )
				guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 1, getPlayerName( thePlayer ), false, false )
				guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 2, theMessage, false, false )
				return
			end
			local row = guiGridListInsertRowAfter ( chatSystemGUI[theRoom][2], -1 )
			guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 1, theName or "N/A", false, false )
			guiGridListSetItemText ( chatSystemGUI[theRoom][2], row, 2, theMessage, false, false )

			if ( theRoom == "Support" ) and ( exports.CSGstaff:isPlayerStaff( thePlayer ) ) then
				guiGridListSetItemColor ( chatSystemGUI[theRoom][2], row, 1, 255, 128, 0 )
				guiGridListSetItemColor ( chatSystemGUI[theRoom][2], row, 2, 255, 128, 0 )
			end
		end
	end
end
)

-- On player SMS
function onPlayerSendSMS ( thePlayer, theMessage, theReciever )
	triggerServerEvent( "onPlayerSendSMS", thePlayer, theMessage, theReciever )
end

-- Clear chat
function onPlayerClearChat ()
	for i=1,50 do
	   	outputChatBox(" ")
	end
	outputChatBox("Chat has been cleared", 238, 154, 0)
end
addCommandHandler( "clearchat", onPlayerClearChat )

local cz = {
    ["LS"] = {1484, -1401},
    ["SF"] = {-2310, 402},
    ["LV"] = {1797, 1713},
}

setTimer (
	function ()
		local RX, RY, RZ = getElementPosition(localPlayer)
		local distanceLSb = getDistanceBetweenPoints2D(RX, RY, cz["LS"][1], cz["LS"][2])
		local distanceSFb = getDistanceBetweenPoints2D(RX, RY, cz["SF"][1], cz["SF"][2])
		local distanceLVb = getDistanceBetweenPoints2D(RX, RY, cz["LV"][1], cz["LV"][2])
		if (distanceLSb < distanceSFb and distanceLSb < distanceLVb) then
			setElementData ( localPlayer, "City", "LS" )
		elseif (distanceSFb < distanceLSb and distanceSFb < distanceLVb) then
			setElementData ( localPlayer, "City", "SF" )
		elseif (distanceLVb < distanceLSb and distanceLVb < distanceSFb) then
			setElementData ( localPlayer, "City", "LV" )
		end
	end, 200, 0
)
