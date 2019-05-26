local sx, sy = guiGetScreenSize ( )
local currentList = { }
-- Tables
local main = {}
local read = { }
local add = {
    button = {},
    edit = {}
} local remove = {
    button = {}
}
-- View Panel

local screenW, screenH = guiGetScreenSize()

main.window = guiCreateWindow(( screenW / 2 - 508 / 2 ), ( screenH / 2 - 570 / 2 ), 508, 570, "News and Updates", false)
guiWindowSetMovable(main.window, false)
guiWindowSetSizable(main.window, false)
guiSetVisible(main.window, false)
main.noob = guiCreateStaticImage (60, 30, 390, 150, "logo2.png", false,main.window )

main.grid = guiCreateGridList(18, 179, 472, 280, false, main.window)
guiGridListAddColumn(main.grid, "Date", 0.3)
guiGridListAddColumn(main.grid, "Update", 0.3)
guiGridListAddColumn(main.grid, "Developer", 0.3)
guiSetAlpha(main.grid, 0.80)
main.close = guiCreateButton(162, 515, 171, 40, "Close", false, main.window)
main.readmore = guiCreateLabel(162, 471, 212, 34, "Double Click on Update to view.", false, main.window)

guiSetFont(main.readmore,"default-bold-small")
	guiSetEnabled ( main.readmore, false )



-- Adding Panel
add.window = guiCreateWindow( ( sx / 2 - 482 / 2 ), ( sy / 2 - 571 / 2 ), 482, 571, "Aurora ~ Updates Manager", false)
---guiWindowSetSizable(add.window, false)
guiSetVisible ( add.window, false )
guiCreateLabel(10, 32, 145, 15, "Date (MM/DD/YYYY):", false, add.window)
add.edit['date'] = guiCreateEdit(9, 53, 454, 28, "", false, add.window)
guiCreateLabel(10, 103, 145, 15, "information:", false, add.window)
add.edit['update'] = guiCreateMemo(13, 125, 450, 294, "", false, add.window)
guiCreateLabel(10, 449, 145, 15, "Developer:", false, add.window)
add.edit['author'] = guiCreateEdit(9, 468, 454, 28, "", false, add.window)
add.button['add'] = guiCreateButton(12, 508, 143, 44, "Add Update", false, add.window)
add.button['cancel'] = guiCreateButton(165, 508, 143, 44, "Close", false, add.window)
add.button['remove'] = guiCreateButton(320, 508, 143, 44, "Manager Window", false, add.window)
-- Remove Panel
remove.window = guiCreateWindow( ( sx / 2 - 552 / 2 ), ( sy / 2 - 533 / 2 ), 552, 533, "Aurora ~ Updates Remover", false)
---guiWindowSetSizable(remove.window, false)
guiSetVisible ( remove.window, false )
remove.grid = guiCreateGridList(10, 28, 532, 443, false, remove.window)
guiGridListAddColumn(remove.grid, "Date", 0.18)
guiGridListAddColumn(remove.grid, "Update", 0.58)
guiGridListAddColumn(remove.grid, "Developer", 0.2)
remove.button['remove'] = guiCreateButton(376, 481, 166, 36, "Remove Update", false, remove.window)
guiSetProperty(remove.button['remove'], "NormalTextColour", "FFFF0000")
remove.button['back'] = guiCreateButton(10, 481, 166, 36, "Back to Manager Window", false, remove.window)
-- Read More
read.window = guiCreateWindow( ( sx / 2 - 407 / 2 ), ( sy / 2 - 397 / 2 ), 407, 397, "Aurora ~ Updates information", false)
---guiWindowSetSizable(read.window, false)
guiSetVisible ( read.window, false )
guiSetAlpha ( read.window, 1 )
--guiWindowSetMovable ( read.window, false )
read.date = guiCreateLabel(9, 35, 275, 25, "Date: Loading..", false, read.window)
read.author = guiCreateLabel(9, 70, 388, 25, "Developer: Loading...", false, read.window)
guiCreateLabel(9, 105, 388, 25, "Update:", false, read.window)
read.update = guiCreateMemo(9, 127, 388, 253, "Loading..", false, read.window)
guiMemoSetReadOnly(read.update, true)
read.close = guiCreateButton(294, 25, 103, 35, "Exit", false, read.window)

addEvent ( "Updates:onPanelChangeState", true )
addEventHandler ( "Updates:onPanelChangeState", root, function ( window, ag1 )
	if ( window == 'main' ) then
		if ( guiGetVisible ( add.window ) ) then
			guiSetVisible ( add.window, false )
			showCursor ( false )
		end if ( guiGetVisible ( remove.window ) ) then
			guiSetVisible ( remove.window, false )
			showCursor ( false )
		end
		guiSetVisible ( main.window, true )
		showCursor ( true )
		guiGridListClear ( main.grid )
		if ( type ( ag1 ) == 'table' ) then
			currentList = { }
			-- Reverse the loop --
			local updates = { }
			for index, variable in ipairs ( ag1 ) do
				local lol = updates
				updates = { }
				table.insert ( updates, { variable['Date_'], variable['Name'], variable['Developer'] } )
				for i, v in ipairs ( lol ) do
					table.insert ( updates, v )
				end
			end
			for i,v in ipairs ( updates ) do
				local row = guiGridListAddRow ( main.grid )
				guiGridListSetItemText ( main.grid, row, 1, tostring ( v[1] ), false, false )
				guiGridListSetItemText ( main.grid, row, 2, tostring (v[2] ), false, false )
				guiGridListSetItemText ( main.grid, row, 3, tostring (v[3] ), false, false )
			end
			currentList = updates
		else
			guiGridListSetItemText ( main.grid, guiGridListAddRow ( main.grid ), 2, "Failed to load updates", true, true )
		end
	elseif ( window == 'manager' ) then
		if ( guiGetVisible ( remove.window ) ) then return end
		if ( guiGetVisible ( main.window ) ) then
			guiSetVisible ( main.window, false )
			showCursor ( false )
		end if ( guiGetVisible ( read.window ) ) then
			guiSetVisible ( read.window, false )
		end

		guiSetVisible ( add.window, true )
		showCursor ( true )
		guiSetText ( add.edit['author'], getPlayerName ( localPlayer ) )
		local time = getRealTime ( )
		local day = time.monthday
		local month = time.month + 1
		local year = time.year + 1900
		if ( day < 10 ) then
			day = 0 .. day
		end if ( month < 10 ) then
			month = 0 .. month
		end
		guiSetText ( add.edit['date'], table.concat ( { month, day, year }, "/" ) )
		guiSetInputMode ( "no_binds_when_editing" )
	end
end )

addEventHandler ( 'onClientGUIDoubleClick', root, function ( btn )
if ( source == main.grid ) then
			local row, col = guiGridListGetSelectedItem ( main.grid )
	if ( row ~= -1 and col ~= 0 ) then
				guiSetVisible ( read.window, true )
				guiBringToFront ( read.window )
				guiSetText ( read.date, "Date: "..guiGridListGetItemText ( main.grid, row, 1 ) )
				guiSetText ( read.update, guiGridListGetItemText ( main.grid, row, 2 ) )
				guiSetText ( read.author, "Developer: "..guiGridListGetItemText ( main.grid, row, 3 ) )
	else
		outputChatBox ( "Select an update.", 255, 255, 0 )
	end
	end
end)

addEventHandler ( 'onClientGUIClick', root, function ( btn )
	if ( btn == 'left' ) then
		-- Main Panel
		if ( source == read.close ) then
			guiSetVisible ( read.window, false )
		elseif ( source == main.close ) then
			guiGridListClear ( main.grid )
			guiSetVisible ( main.window, false )
			showCursor ( false )
			if ( guiGetVisible ( read.window ) ) then
				guiSetVisible ( read.window, false )
			end

		-- Adding Panel
		elseif ( source == add.button['cancel'] ) then
			guiSetVisible ( add.window, false )
			showCursor ( false )
		elseif ( source == add.button['add'] ) then
			local date, update, author = guiGetText ( add.edit['date'] ), guiGetText ( add.edit['update'] ), guiGetText ( add.edit['author'] )
			if ( date ~= '' and update ~= '' and author ~= '' ) then
				triggerServerEvent ( "Updates:onServerEvent", localPlayer, 'addUpdate', { date, update, author } )



			else
				outputChatBox ( "You need to enter all of the information.", 255, 0, 0 )
			end
		elseif ( source == add.button['remove'] ) then
			guiSetVisible ( add.window, false )
			guiSetVisible ( remove.window, true )
			guiGridListClear ( remove.grid )
			if ( currentList and #currentList > 0 ) then
				for index, var in ipairs ( currentList ) do
					local row = guiGridListAddRow ( remove.grid )
					guiGridListSetItemText ( remove.grid, row, 1, var[1], false, false )
					guiGridListSetItemText ( remove.grid, row, 2, var[2], false, false )
					guiGridListSetItemText ( remove.grid, row, 3, var[3], false, false )
				end
			else
				guiGridListSetItemText ( remove.grid, guiGridListAddRow ( remove.grid ), 2, "Please use /updates, then come back to this panel.", true, true )
				guiGridListSetItemColor ( remove.grid, 0, 2, 255, 0, 0 )
			end
		-- remove panel
		elseif ( source == remove.button['back'] ) then
			guiSetVisible ( remove.window, false )
			guiSetVisible ( add.window, true )
		elseif ( source == remove.button['remove'] ) then
			local row, col = guiGridListGetSelectedItem ( remove.grid )
			if ( row ~= -1 and col ~= 0 ) then
				local date = guiGridListGetItemText ( remove.grid, row, 1 )
				local update = guiGridListGetItemText ( remove.grid, row, 2 )
				local author = guiGridListGetItemText ( remove.grid, row, 3 )

				for index, var in ipairs ( currentList ) do
					if ( var[1] == date and var[2] == update and var[3] == author ) then
						table.remove ( currentList, index )
						break
					end
				end
				guiGridListClear ( remove.grid )
				if ( #currentList > 0 ) then
					for index, var in ipairs ( currentList ) do
						local row = guiGridListAddRow ( remove.grid )
						guiGridListSetItemText ( remove.grid, row, 1, var[1], false, false )
						guiGridListSetItemText ( remove.grid, row, 2, var[2], false, false )
						guiGridListSetItemText ( remove.grid, row, 3, var[3], false, false )
					end
				else
					guiGridListSetItemText ( remove.grid, guiGridListAddRow ( remove.grid ), 2, "No updates found.", true, true )
				end
				triggerServerEvent ( 'Updates:onServerEvent', localPlayer, 'removeUpdate', { date, update, author } )
			end
		end
	end
end )
up = false
addEvent("ToggleUP",true)
addEventHandler("ToggleUP",root,function()
	if up == false then
		addEventHandler("onClientRender",root,drawUpdates)
		up = true
		setTimer(function()
			removeEventHandler("onClientRender",root,drawUpdates)
			up = false
		end,10000,1)
	end
end)

local screenWidth, screenHeight = guiGetScreenSize()

function dxDrawBorderedText ( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end


function drawUpdates()
	dxDrawBorderedText("NEW Update has been added, type /updates to get more info!", 1.75, (screenW - 504) / 2, (screenH - 220) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,50,0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
end
local closeButton,window,text
addEventHandler("onClientResourceStart",resourceRoot,function()
-- Create the updates window
local x,y = guiGetScreenSize()
window = guiCreateWindow((x-800)/2, (y-600)/2, 800, 600, "Server updates", false )
text = guiCreateMemo( 10, 30, 780, 526, "", false, window )

-- Set readonly and hide
guiMemoSetReadOnly(text, true)
guiSetVisible(window,false)

-- Add close button and triggers
closeButton = guiCreateButton(10,560,780,30,"Close window",false,window)
addEventHandler("onClientGUIClick",closeButton,function() 
	guiSetVisible(window, false)
	showCursor(false)
end)
end)


function viewUpdateListGUI()
	guiSetVisible(window, not guiGetVisible(window))
	guiBringToFront(window)
	requestUpdates()	
end
function toggleUpdateListGUI()
	guiSetVisible(window, not guiGetVisible(window))
	showCursor(not isCursorShowing())
	requestUpdates()
end
addCommandHandler( "updates", toggleUpdateListGUI )

function getUpdatesList()
	return guiGetText(text)
end
function downl(responseData, errno)
    if (errno == 0) then
		guiSetText(text,responseData)
    else
        guiSetText(text, "Failed to collect updates")
    end
end
addEvent("requestUpdates",true)
addEventHandler("requestUpdates",getRootElement(),downl)
function requestUpdates()
	triggerServerEvent("requestUpdates",resourceRoot)
end