
ammogui = {
    gridlist = {},
    window = {},
    button = {}
}
ammogui.window[1] = guiCreateWindow(27, 47, 744, 520, "", false)
guiWindowSetSizable(ammogui.window[1], false)
guiSetVisible ( ammogui.window[1], false )
ammogui.gridlist[1] = guiCreateGridList(9, 27, 209, 483, false, ammogui.window[1])
guiGridListAddColumn(ammogui.gridlist[1], "Players", 0.9)
ammogui.gridlist[2] = guiCreateGridList(218, 28, 516, 427, false, ammogui.window[1])
guiGridListAddColumn(ammogui.gridlist[2], "Weapon", 0.5)
guiGridListAddColumn(ammogui.gridlist[2], "Ammo", 0.5)
ammogui.button[1] = guiCreateButton(596, 463, 138, 33, "Close", false, ammogui.window[1])

addEventHandler("onClientGUIClick",root,function()
	if source == ammogui.button[1] then
		guiSetVisible ( ammogui.window[1], false )
		showCursor(false)
	elseif source == ammogui.gridlist[2] then
		guiGridListClear( ammogui.gridlist[2] )
	end
end)


addEventHandler ( 'onClientGUIDoubleClick', root, function ( btn )
	if ( source == ammogui.gridlist[1] ) then
		if getElementData(localPlayer,"isPlayerPrime") then
			local row, col = guiGridListGetSelectedItem ( ammogui.gridlist[1] )
			if ( row ~= -1 and col ~= 0 ) then
				local name = guiGridListGetItemText(ammogui.gridlist[1], guiGridListGetSelectedItem(ammogui.gridlist[1]), 1)
				if name then
					local p = getPlayerFromName(name)
					if p and isElement(p) then
						triggerServerEvent("callAmmoLog",localPlayer,p)
					end
				end
			end
		end
	end
end)

addEvent("returnammolog",true)
addEventHandler("returnammolog",root,function(t)
	guiGridListClear( ammogui.gridlist[2] )
	for k,v in ipairs(t) do
		local row = guiGridListAddRow( ammogui.gridlist[2] )
		guiGridListSetItemText( ammogui.gridlist[2], row, 1, v.wep, false, false )
		guiGridListSetItemText( ammogui.gridlist[2], row, 2, v.wepammo, false, false )
	end
end)

addCommandHandler("ammolog",function()
	if getElementData(localPlayer,"isPlayerPrime") then
		guiSetVisible ( ammogui.window[1], true)
		showCursor(true)
		guiGridListClear( ammogui.gridlist[1] )
		for k,v in ipairs(getElementsByType("player")) do
			local row = guiGridListAddRow( ammogui.gridlist[1] )
			guiGridListSetItemText( ammogui.gridlist[1], row, 1, getPlayerName(v), false, false )
		end
	end
end)





Stafflogins = {
    label = {},
    edit = {},
    button = {},
    window = {},
    radiobutton = {},
    gridlist = {}
}
Stafflogins.window[1] = guiCreateWindow(18, 53, 745, 481, "Aurora ~ Staff logins finder", false)
guiWindowSetSizable(Stafflogins.window[1], false)
guiSetAlpha(Stafflogins.window[1], 0.95)
guiSetVisible ( Stafflogins.window[1], false )
guiSetAlpha(Stafflogins.window[1], 0.95)
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(Stafflogins.window[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(Stafflogins.window[1],x,y,false)

Stafflogins.gridlist[1] = guiCreateGridList(13, 27, 722, 354, false, Stafflogins.window[1])
guiGridListAddColumn(Stafflogins.gridlist[1], "Nickname", 0.2)
guiGridListAddColumn(Stafflogins.gridlist[1], "Date", 0.2)
guiGridListAddColumn(Stafflogins.gridlist[1], "Account", 0.2)
guiGridListAddColumn(Stafflogins.gridlist[1], "IP", 0.2)
guiGridListAddColumn(Stafflogins.gridlist[1], "Serial", 0.2)
Stafflogins.label[1] = guiCreateLabel(40, 391, 213, 28, "Use search type", false, Stafflogins.window[1])
guiSetFont(Stafflogins.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(Stafflogins.label[1], "center", false)
Stafflogins.radiobutton[1] = guiCreateRadioButton(304, 391, 85, 26, "Nickname", false, Stafflogins.window[1])
guiSetFont(Stafflogins.radiobutton[1], "default-bold-small")
Stafflogins.radiobutton[2] = guiCreateRadioButton(398, 391, 85, 26, "Account", false, Stafflogins.window[1])
guiSetFont(Stafflogins.radiobutton[2], "default-bold-small")
guiRadioButtonSetSelected(Stafflogins.radiobutton[2], true)
Stafflogins.edit[1] = guiCreateEdit(34, 429, 129, 36, "NickName Or AccountName", false, Stafflogins.window[1])
Stafflogins.edit[2] = guiCreateEdit(164, 429, 129, 36, "Log Type money", false, Stafflogins.window[1])
Stafflogins.button[1] = guiCreateButton(400, 429, 80, 36, "Search", false, Stafflogins.window[1])
Stafflogins.button[3] = guiCreateButton(500, 429, 80, 36, "Log Search", false, Stafflogins.window[1])
Stafflogins.button[2] = guiCreateButton(600, 429, 80, 36, "Close", false, Stafflogins.window[1])

addEventHandler("onClientGUIClick",root,function()
	if source == Stafflogins.button[2] then
		guiSetVisible ( Stafflogins.window[1], false )
		showCursor( false )
	elseif source == Stafflogins.button[1] then
		local boxedit = guiGetText(Stafflogins.edit[1])
		if boxedit then
			if guiRadioButtonGetSelected(Stafflogins.radiobutton[1]) then
				searc = "Nickname"
			elseif guiRadioButtonGetSelected(Stafflogins.radiobutton[2]) then
				searc = "Accounts"
			else
				searc = ""
			end
			if searc ~= "" then
				triggerServerEvent("onPlayerRequestLogins",localPlayer,searc,boxedit)
			end
		end
	elseif source == Stafflogins.button[3] then
		local boxedit = guiGetText(Stafflogins.edit[1])
		local boxedit2 = guiGetText(Stafflogins.edit[2])
		if boxedit and boxedit2 then
			if guiRadioButtonGetSelected(Stafflogins.radiobutton[1]) then
				return false
			elseif guiRadioButtonGetSelected(Stafflogins.radiobutton[2]) then
				searc = "Accounts"
			else
				searc = ""
			end
			if searc ~= "" then
				triggerServerEvent("onPlayerRequestLogs",localPlayer,searc,boxedit,boxedit2)
			end
		end
	end
end)

Logins = {
	window = {},
    button = {},
	gridlist = {},
    label = {}
}
Logins.window[1] = guiCreateWindow(101, 150, 644, 346, "Aurora ~ Last logins", false)
guiWindowSetSizable(Logins.window[1], false)
guiSetVisible ( Logins.window[1], false )
guiSetAlpha(Logins.window[1], 0.95)
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(Logins.window[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(Logins.window[1],x,y,false)

Logins.label[1] = guiCreateLabel(182, 30, 256, 30, "Your last logins", false, Logins.window[1])
guiSetFont(Logins.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(Logins.label[1], "center", false)
guiLabelSetVerticalAlign(Logins.label[1], "center")
Logins.gridlist[1] = guiCreateGridList(15, 96, 615, 240, false, Logins.window[1])
guiGridListAddColumn(Logins.gridlist[1], "Date :", 0.25)
guiGridListAddColumn(Logins.gridlist[1], "Nickname", 0.15)
guiGridListAddColumn(Logins.gridlist[1], "IP", 0.13)
guiGridListAddColumn(Logins.gridlist[1], "Serial", 0.4)
Logins.button[1] = guiCreateButton(488, 30, 137, 30, "Close", false, Logins.window[1])
Logins.label[2] = guiCreateLabel(20, 72, 600, 20, "Serials with a red color are different from the one you are using now!", false, Logins.window[1])
guiSetFont(Logins.label[2], "default-bold-small")
guiLabelSetColor(Logins.label[2], 255, 0, 0)
guiLabelSetHorizontalAlign(Logins.label[2], "center", false)


addEventHandler( "onClientGUIClick", Logins.button[1],
	function ()
		guiSetVisible ( Logins.window[1], false )
		showCursor( false )
	end, false
)


-- Open the window and insert the last logins
addEvent( "callClientLogins", true )
addEventHandler( "callClientLogins", root,
	function ( theTable )
		if ( theTable ) then
			guiGridListClear( Logins.gridlist[1] )
			for i=1,#theTable do
				local row = guiGridListAddRow( Logins.gridlist[1] )
				guiGridListSetItemText( Logins.gridlist[1], row, 1, theTable[i].datum, false, false )
				guiGridListSetItemText( Logins.gridlist[1], row, 2, theTable[i].nickname, false, false )
				guiGridListSetItemText( Logins.gridlist[1], row, 3, theTable[i].ip, false, false )
				guiGridListSetItemText( Logins.gridlist[1], row, 4, theTable[i].serial, false, false )

				if ( theTable[i].serial ~= getPlayerSerial() ) then
					guiGridListSetItemColor( Logins.gridlist[1], row, 4, 225, 0, 0 )
				end
			end

			guiSetVisible ( Logins.window[1], true )
			showCursor( true )
		else
			outputChatBox( "Something wen't wrong while loading the last logins! Try again.", 225, 0, 0 )
		end
	end
)

-- Open the window and insert the last logins
addEvent( "onRequestLastLogins", true )
addEventHandler( "onRequestLastLogins", root,
	function ( theTable )
		if ( theTable ) then
			guiGridListClear( Stafflogins.gridlist[1] )
			for i=1,#theTable do
				local row = guiGridListAddRow( Stafflogins.gridlist[1] )

				guiGridListSetItemText( Stafflogins.gridlist[1], row, 1, theTable[i].nickname, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 2, theTable[i].datum, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 3, theTable[i].accountname, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 4, theTable[i].ip, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 5, theTable[i].serial, false, false )
			end
		else
			outputChatBox( "Something wen't wrong while loading the last logins! Try again.", 225, 0, 0 )
		end
	end
)
-- Open the window and insert the last logins
addEvent( "onRequestLastLogs", true )
addEventHandler( "onRequestLastLogs", root,
	function ( theTable )
		if ( theTable ) then
			guiGridListClear( Stafflogins.gridlist[1] )
			for i=1,#theTable do
				local row = guiGridListAddRow( Stafflogins.gridlist[1] )

				guiGridListSetItemText( Stafflogins.gridlist[1], row, 1, theTable[i].player, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 2, theTable[i].date, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 3, theTable[i].account, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 4, theTable[i].action, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 5, theTable[i].time, false, false )
			end
		else
			outputChatBox( "Something wen't wrong while loading the last logins! Try again.", 225, 0, 0 )
		end
	end
)
-- Open the window and insert the last logins
addEvent( "onRequestATMLogs", true )
addEventHandler( "onRequestATMLogs", root,
	function ( theTable )
		if ( theTable ) then
			guiGridListClear( Stafflogins.gridlist[1] )
			for i=1,#theTable do
				local row = guiGridListAddRow( Stafflogins.gridlist[1] )

				guiGridListSetItemText( Stafflogins.gridlist[1], row, 1, "N.A", false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 2, theTable[i].datum, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 3, theTable[i].transaction, false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 4, "N.A", false, false )
				guiGridListSetItemText( Stafflogins.gridlist[1], row, 5, "N.A", false, false )
			end
		else
			outputChatBox( "Something wen't wrong while loading the last logins! Try again.", 225, 0, 0 )
		end
	end
)

addCommandHandler("seen",function()
	if exports.CSGstaff:isPlayerStaff(localPlayer) and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 5 or getElementData(localPlayer,"isPlayerPrime") then
		guiSetVisible ( Stafflogins.window[1], true )
		showCursor( true )
	end
end)
