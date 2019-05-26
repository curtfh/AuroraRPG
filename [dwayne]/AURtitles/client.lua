
PlayerPanel = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

StaffPanel = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}

function centerWindow( center_window )
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize( center_window, false )
    local x, y = ( screenW - windowW ) /2, ( screenH - windowH ) / 2
    guiSetPosition( center_window, x, y, false )
end


addEventHandler("onClientResourceStart",resourceRoot,function()
	PlayerPanel.window[1] = guiCreateWindow(186, 82, 436, 399, "", false)
	guiWindowSetSizable(PlayerPanel.window[1], false)
	guiSetVisible(PlayerPanel.window[1],false)
	centerWindow(PlayerPanel.window[1])
	PlayerPanel.gridlist[1] = guiCreateGridList(9, 53, 165, 336, false, PlayerPanel.window[1])
	guiGridListAddColumn(PlayerPanel.gridlist[1], "Title", 0.9)
	PlayerPanel.label[1] = guiCreateLabel(9, 19, 165, 28, "Titles:", false, PlayerPanel.window[1])
	guiSetFont(PlayerPanel.label[1], "default-bold-small")
	guiLabelSetColor(PlayerPanel.label[1], 255, 45, 45)
	guiLabelSetHorizontalAlign(PlayerPanel.label[1], "center", false)
	guiLabelSetVerticalAlign(PlayerPanel.label[1], "center")
	PlayerPanel.button[1] = guiCreateButton(184, 201, 101, 32, "Personal Title", false, PlayerPanel.window[1])
	PlayerPanel.button[2] = guiCreateButton(318, 201, 101, 32, "Group Title", false, PlayerPanel.window[1])
	PlayerPanel.button[3] = guiCreateButton(318, 347, 101, 32, "Close", false, PlayerPanel.window[1])
	PlayerPanel.edit[1] = guiCreateEdit(253, 137, 166, 43, "", false, PlayerPanel.window[1])
	PlayerPanel.button[4] = guiCreateButton(184, 347, 99, 32, "Select", false, PlayerPanel.window[1])
	PlayerPanel.label[2] = guiCreateLabel(202, 36, 200, 91, "Here you can request title for your group (Founder)\nAlso you can request title for you\n(Title Cost: $10,000,000)\n(Group Title $15,000,000)", false, PlayerPanel.window[1])
	guiSetFont(PlayerPanel.label[2], "default-bold-small")
	guiLabelSetColor(PlayerPanel.label[2], 255, 45, 45)
	guiLabelSetHorizontalAlign(PlayerPanel.label[2], "center", true)
	PlayerPanel.label[3] = guiCreateLabel(181, 137, 66, 38, "Insert title", false, PlayerPanel.window[1])
	guiSetFont(PlayerPanel.label[3], "default-bold-small")
	guiLabelSetColor(PlayerPanel.label[3], 255, 45, 45)
	guiLabelSetHorizontalAlign(PlayerPanel.label[3], "center", false)
	guiLabelSetVerticalAlign(PlayerPanel.label[3], "center")



	StaffPanel.window[1] = guiCreateWindow(165, 107, 456, 353, "", false)
	guiWindowSetSizable(StaffPanel.window[1], false)
	guiSetVisible(StaffPanel.window[1],false)
	centerWindow(StaffPanel.window[1])
	StaffPanel.gridlist[1] = guiCreateGridList(9, 27, 182, 316, false, StaffPanel.window[1])
	guiGridListAddColumn(StaffPanel.gridlist[1], "Name", 0.5)
	guiGridListAddColumn(StaffPanel.gridlist[1], "Title", 0.5)
	StaffPanel.button[1] = guiCreateButton(257, 158, 121, 36, "Approve Request", false, StaffPanel.window[1])
	StaffPanel.button[2] = guiCreateButton(257, 221, 121, 36, "Cancel request", false, StaffPanel.window[1])
	StaffPanel.button[3] = guiCreateButton(257, 280, 121, 36, "Close", false, StaffPanel.window[1])
	StaffPanel.label[1] = guiCreateLabel(202, 27, 236, 121, "Approve the title for selected account name from the list", false, StaffPanel.window[1])
	guiSetFont(StaffPanel.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(StaffPanel.label[1], "center", true)
	guiLabelSetVerticalAlign(StaffPanel.label[1], "center")
	for i=1,4 do
		addEventHandler("onClientGUIClick",PlayerPanel.button[i],guiClicks)
	end
	for i=1,3 do
		addEventHandler("onClientGUIClick",StaffPanel.button[i],guiStaffClicks)
	end
end)


addEvent("addPlayerTitles",true)
addEventHandler("addPlayerTitles",root,function(theTable)
	guiGridListClear(PlayerPanel.gridlist[1])
	if theTable then
		for i,v in ipairs( theTable ) do
			if v and v.active == 1 then
				local row = guiGridListAddRow(PlayerPanel.gridlist[1])
				guiGridListSetItemText(PlayerPanel.gridlist[1], row, 1, tostring( v.title ), false, false )
				guiGridListSetItemData(PlayerPanel.gridlist[1], row, 1, {v.red,v.green,v.blue} )
			end
		end
	end
end)

addEvent("addStaffTitles",true)
addEventHandler("addStaffTitles",root,function(theTable)
	guiGridListClear(StaffPanel.gridlist[1])
	if theTable then
		for i,v in ipairs( theTable ) do
			if v and v.active == 0 then
				local row = guiGridListAddRow(StaffPanel.gridlist[1])
				guiGridListSetItemText(StaffPanel.gridlist[1], row, 1, tostring( v.account ), false, false )
				guiGridListSetItemText(StaffPanel.gridlist[1], row, 2, tostring( v.title ), false, false )
				--guiGridListSetItemData(StaffPanel.gridlist[1], row, 1, tostring( v.account ) )
				--guiGridListSetItemData(StaffPanel.gridlist[1], row, 2, tostring( v.title ) )
			end
		end
	end
end)


function guiClicks()
	if source == PlayerPanel.button[3] then
		guiSetVisible(PlayerPanel.window[1],false)
		showCursor(false)
	elseif source == PlayerPanel.button[2] then
		--- request for group title
		if getElementData(localPlayer,"GroupRank") == "Group Leader" then
			local text = guiGetText(PlayerPanel.edit[1])
			if text and text ~= "" then
				triggerServerEvent("onPlayerRequestTitle",localPlayer,text)
			end
		else
			exports.NGCdxmsg:CreateNewDxMessage("You are not group leader to buy title")
		end
	elseif source == PlayerPanel.button[1] then
		--- request for personal title
		local text = guiGetText(PlayerPanel.edit[1])
		if text and text ~= "" then
			--triggerServerEvent("onPlayerRequestTitle",localPlayer,text)
			--guiSetVisible(PlayerPanel.window[1],false)
			--showCursor(false)
			if getPlayerMoney(localPlayer) >= 10000000 then
				exports.cpicker:openPicker("persTitle",false,"AUR ~ Pick a Title Color")
			else
				exports.NGCdxmsg:CreateNewDxMessage("You don't have enough money to request title",255,0,0)
			end
		end
	elseif source == PlayerPanel.button[4] then
		local row,col = guiGridListGetSelectedItem(PlayerPanel.gridlist[1])
		if row and col and row ~= -1 and col ~= -1 then
			local titleName = guiGridListGetItemText(PlayerPanel.gridlist[1], row, 1)
			if titleName then
				local color = guiGridListGetItemData(PlayerPanel.gridlist[1], guiGridListGetSelectedItem(PlayerPanel.gridlist[1]), 1)
				if color then
					local r,g,b = unpack(color)
					setElementData(localPlayer,"playerTitle",titleName)
					setElementData(localPlayer,"playerTitleColor",color)
				end
			end
		end
	end
end


function buyLaser2(id,hex,r,g,b)
	if id == "persTitle" then
		local text = guiGetText(PlayerPanel.edit[1])
		if text and text ~= "" then
			triggerServerEvent("onPlayerRequestTitle",localPlayer,text,r,g,b)
			guiSetVisible(PlayerPanel.window[1],false)
			showCursor(false)
		end
	end
end
addEvent("onColorPickerOK",true)
addEventHandler("onColorPickerOK",root,buyLaser2)


function guiStaffClicks()
	if source == StaffPanel.button[3] then
		guiSetVisible(StaffPanel.window[1],false)
		showCursor(false)
	elseif source == StaffPanel.button[2] then
		local row,col = guiGridListGetSelectedItem(StaffPanel.gridlist[1])
		if row and col and row ~= -1 and col ~= -1 then
			local accountName = guiGridListGetItemText(StaffPanel.gridlist[1], row, 1)
			local titleName = guiGridListGetItemText(StaffPanel.gridlist[1], row, 2)
			if accountName and titleName then
				--local accData = guiGridListGetItemData(StaffPanel.gridlist[1], guiGridListGetSelectedItem(StaffPanel.gridlist[1]), 1)
				--local titData = guiGridListGetItemData(StaffPanel.gridlist[1], guiGridListGetSelectedItem(StaffPanel.gridlist[1]), 2)
				--if accData and titData then
				triggerServerEvent("onStaffRejectCustomTitle",localPlayer,accountName,titleName)
				--end
			end
		end
	elseif source == StaffPanel.button[1] then
		local row,col = guiGridListGetSelectedItem(StaffPanel.gridlist[1])
		if row and col and row ~= -1 and col ~= -1 then
			local accountName = guiGridListGetItemText(StaffPanel.gridlist[1], row, 1)
			local titleName = guiGridListGetItemText(StaffPanel.gridlist[1], row, 2)
			if accountName and titleName then
				--local accData = guiGridListGetItemData(StaffPanel.gridlist[1], guiGridListGetSelectedItem(StaffPanel.gridlist[1]), 1)
				--local titData = guiGridListGetItemData(StaffPanel.gridlist[1], guiGridListGetSelectedItem(StaffPanel.gridlist[1]), 2)
				--if accData and titData then
				triggerServerEvent("onStaffApproveCustomTitle",localPlayer,accountName,titleName)
				--end
			end
		end
	end
end



addCommandHandler("ct",function()
	guiGridListClear(PlayerPanel.gridlist[1])
	guiSetVisible(PlayerPanel.window[1],true)
	showCursor(true)
	triggerServerEvent("onPlayerLoadTitles",localPlayer)
end)



addCommandHandler("managect",function()
	if exports.CSGstaff:isPlayerStaff(localPlayer) then
		guiGridListClear(StaffPanel.gridlist[1])
		guiSetVisible(StaffPanel.window[1],true)
		showCursor(true)
		triggerServerEvent("onStaffLoadTitles",localPlayer)
	end
end)


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

local screenWidth, screenHeight = guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()
rectangleAlpha = 170
rectangleAlpha2 = 170
textAlpha = 255
textAlpha2 = 255
local screenW, screenH = guiGetScreenSize()
local kill = false
local resX, resY = guiGetScreenSize()
function drawTitle()
	for k, v in pairs( getElementsByType( "player" ) ) do
		if (isElementOnScreen( v ) ) then
			local x, y, z = getElementPosition( v )
			local a, b, c = getElementPosition( localPlayer )
			local dist = getDistanceBetweenPoints3D( x, y , z, a, b, c )
			x, y, z = getPedBonePosition( v, 5 )
			local tX, tY = getScreenFromWorldPosition( x, y, z+0.5, 0, false )
			if ( tX and tY and isLineOfSightClear( a, b, c, x, y, z, true, false, false, true, true, false, false, v ) ) then
				if ( dist < 30 ) then
					theText = getElementData(v,"playerTitle")
					local width = dxGetTextWidth( tostring(theText), 0.8, "default-bold" )
					if ( theText ~= false ) then
						local r,g,b = unpack(getElementData(v,"playerTitleColor"))
						if r and g and b then
							dxDrawBorderedText( tostring(theText),0.8, tX-( width/2), tY, resX, resY, tocolor( r,g,b, 255 ), 1.5, "default-bold")
						end
                    end
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, drawTitle)

