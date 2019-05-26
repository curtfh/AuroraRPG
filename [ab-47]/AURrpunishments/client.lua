--
-- Author: Ab-47 ~ AURrpunishments/client.lua
-- Updates: Bug fixes, fixed account table retrieved by serial, id from accounts.
--

local screenWidth, screenHeight = guiGetScreenSize()
local serialp = {}
local rlog = {
    edit = {},
    window = {},
    label = {},
    gridlist = {},
    button = {},
    memo = {},
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
		windowWidth, windowHeight = 677, 609
		windowWidthX, windowHeightX = 508, 245
		windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
		windowXX, windowYY = (screenWidth / 2) - (windowWidthX / 2), (screenHeight / 2) - (windowHeightX / 2)
		rlog.window[1] = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "Retrieve Punishlog", false)
		rlog.window[2] = guiCreateWindow(windowXX, windowYY, windowWidthX, windowHeightX, "Retrieve Punishlog Output", false)
		guiWindowSetSizable(rlog.window[1], false)
		guiWindowSetSizable(rlog.window[2], false)

		rlog.gridlist[1] = guiCreateGridList(10, 61, 652, 502, false, rlog.window[1])
		rlog.memo[1] = guiCreateMemo(9, 26, 487, 167, "", false, rlog.window[2])
		rlog.edit[1] = guiCreateEdit(10, 26, 135, 29, "", false, rlog.window[1])
		rlog.edit[2] = guiCreateEdit(231, 25, 315, 30, "Serial not required", false, rlog.window[1])
		rlog.label[1] = guiCreateLabel(147, 26, 80, 25, "Acc Name", false, rlog.window[1])
		rlog.label[2] = guiCreateLabel(242, 570, 309, 29, "Account/ID: ", false, rlog.window[1])
		rlog.label[3] = guiCreateLabel(556, 570, 106, 29, "Returns: Flase ", false, rlog.window[1])
		rlog.label[4] = guiCreateLabel(261, 202, 235, 33, "Retrieving for: ", false, rlog.window[2])
		
		rlog.button[1] = guiCreateButton(553, 26, 109, 29, "Go", false, rlog.window[1])
		rlog.button[2] = guiCreateButton(10, 570, 109, 29, "Output", false, rlog.window[1])
		rlog.button[3] = guiCreateButton(123, 570, 109, 29, "Close", false, rlog.window[1])
		rlog.button[4] = guiCreateButton(10, 200, 121, 36, "Copy All", false, rlog.window[2])
        rlog.button[5] = guiCreateButton(136, 200, 121, 36, "Close", false, rlog.window[2])
		
		guiSetProperty(rlog.button[1], "NormalTextColour", "FFAAAAAA")
		guiSetProperty(rlog.button[2], "NormalTextColour", "FFAAAAAA")
		guiSetProperty(rlog.button[3], "NormalTextColour", "FFAAAAAA")
		guiSetProperty(rlog.button[4], "NormalTextColour", "FFAAAAAA")
		guiSetProperty(rlog.button[5], "NormalTextColour", "FFAAAAAA")
		
		guiSetFont(rlog.label[1], "clear-normal")
		guiSetFont(rlog.button[1], "clear-normal")
		guiSetFont(rlog.button[2], "clear-normal")
		guiSetFont(rlog.button[3], "clear-normal")
		guiSetFont(rlog.label[2], "clear-normal")
		guiSetFont(rlog.label[3], "clear-normal")
		guiSetFont(rlog.label[4], "clear-normal")
		guiLabelSetHorizontalAlign(rlog.label[1], "center", false)
		guiLabelSetHorizontalAlign(rlog.label[4], "center", false)
		guiLabelSetVerticalAlign(rlog.label[1], "center")
		guiLabelSetVerticalAlign(rlog.label[2], "center")
		guiLabelSetVerticalAlign(rlog.label[3], "center")
		guiLabelSetVerticalAlign(rlog.label[4], "center")
		guiGridListAddColumn(rlog.gridlist[1], "Date:", 0.24)
		guiGridListAddColumn(rlog.gridlist[1], "Punishment:", 0.73)

		guiSetVisible(rlog.window[1], false)
		guiSetVisible(rlog.window[2], false)
		guiMemoSetReadOnly(rlog.memo[1], true)
		
		for k, v in pairs(rlog.button) do
			addEventHandler("onClientGUIClick", v, 
				function()
					if (source == rlog.button[1]) then
						handle_panel("1")
					elseif (source == rlog.button[2]) then
						handle_panel("2")
					elseif (source == rlog.button[3]) then
						handle_panel("3")
					elseif (source == rlog.button[4]) then
						handle_panel("4")
					elseif (source == rlog.button[5]) then
						handle_panel("5")
					end
				end
			)
		end
    end
)

function handle_panel(string)
	if (localPlayer) then
		if (getTeamFromName("Staff") ~= getPlayerTeam(localPlayer)) then
			outputChatBox("This feature is only allowed for staff in staff mode!", 255, 0, 0)
			return 
		end
		if (string == "rlog") then
			if (not guiGetVisible(rlog.window[1]) and not guiGetVisible(rlog.window[2])) then
				guiSetVisible(rlog.window[1], true)
				showCursor(true)
			else
				if (guiGetVisible(rlog.window[2])) then
					guiSetVisible(rlog.window[2], false)
				end
				guiSetVisible(rlog.window[1], false)
				showCursor(false)
				retname, return_ = "", ""
				--guiSetText(rlog.memo[1], "")
			end
		elseif (string == "1") then
			if (#guiGetText(rlog.edit[2]) == 32 and not (#guiGetText(rlog.edit[1]) > 0)) then
				triggerServerEvent("onRequestRPunishlog", localPlayer, guiGetText(rlog.edit[2]), false, "serial")
			elseif (guiGetText(rlog.edit[2]) == "Serial not required") or not (#guiGetText(rlog.edit[2]) > 0) then
				if (guiGetText(rlog.edit[1]) ~= "") then
					triggerServerEvent( "onRequestRPunishlog", localPlayer, false, guiGetText(rlog.edit[1]), "account")
				else
					outputChatBox("Please enter a valid account name!", 255, 0, 0)
					return
				end
			else
				outputChatBox("An error has occured, please check you have either the correct serial/acc name you cannot have both fields with data!", 255, 0, 0)
			end
		elseif (string == "2") then
			if (not guiGetVisible(rlog.window[2]) and guiGetVisible(rlog.window[1])) then
				guiSetVisible(rlog.window[2], true)
				guiSetVisible(rlog.window[1], false)
			end
		elseif (string == "3") then
			if (guiGetVisible(rlog.window[1])) then
				guiSetVisible(rlog.window[1], false)
				showCursor(false)
				retname, return_ = "", ""
				--guiSetText(rlog.memo[1], "")
			end
		elseif (string == "4") then
			success = setClipboard(guiGetText(rlog.memo[1]))
			if (success) then
				outputChatBox("Successfully copied retrieved output punishlog to clipboard!", 0, 255, 0)
			else
				outputChatBox("Failed to set clipboard", 255, 0, 0)
			end
		elseif (string == "5") then
			if (not guiGetVisible(rlog.window[1]) and guiGetVisible(rlog.window[2])) then
				guiSetVisible(rlog.window[1], true)
				guiSetVisible(rlog.window[2], false)
			end
		end
	end
end
addCommandHandler("rlog", handle_panel)

addEvent( "onRequestRPunishlog:callRBack", true )
addEventHandler( "onRequestRPunishlog:callRBack", root,
    function ( serialTable, accountTable, string, acc, id )
		if (string == "serial") then
			guiSetText(rlog.memo[1], "")
			guiGridListClear( rlog.gridlist[1] )
			return_ = "True"
			var = fromJSON(acc)
			retname = var.username.." ("..tonumber(id)..")"
			-- Serial punishments
			guiGridListSetItemText( rlog.gridlist[1], guiGridListAddRow( rlog.gridlist[1] ), 1, "Serial Punishments", true, false )
			for i=1,#serialTable do
				guiSetText(rlog.memo[1], guiGetText(rlog.memo[1]).."(Serial) "..(serialTable[i].datum.." "..serialTable[i].punishment))
				local row = guiGridListAddRow ( rlog.gridlist[1] )
				guiGridListSetItemText ( rlog.gridlist[1], row, 1, serialTable[i].datum, false, false )
				guiGridListSetItemText ( rlog.gridlist[1], row, 2, serialTable[i].punishment, false, false )
				guiGridListSetItemData ( rlog.gridlist[1], row, 1, { id = serialTable[i].uniqueid, active = serialTable[i].active } )

				if ( serialTable[i].active == 0 ) then
					guiGridListSetItemColor ( rlog.gridlist[1], row, 1, 225, 0, 0 )
					guiGridListSetItemColor ( rlog.gridlist[1], row, 2, 225, 0, 0 )
				end
			end
			guiSetText(rlog.label[2], "Account/ID: "..retname or "N/A")
			guiSetText(rlog.label[4], "Retrieving for: "..retname or "N/A")
			guiSetText(rlog.label[3], "Returns: "..return_ or "False")
		elseif (string == "all") then
			guiSetText(rlog.memo[1], "")
			guiGridListClear( rlog.gridlist[1] )
			return_ = "True"
			retname = acc.." ("..tonumber(id)..")"
			-- Serial punishments
			guiGridListSetItemText( rlog.gridlist[1], guiGridListAddRow( rlog.gridlist[1] ), 1, "Serial Punishments", true, false )
			for i=1,#serialTable do
				local row = guiGridListAddRow ( rlog.gridlist[1] )
				guiGridListSetItemText ( rlog.gridlist[1], row, 1, serialTable[i].datum, false, false )
				guiGridListSetItemText ( rlog.gridlist[1], row, 2, serialTable[i].punishment, false, false )
				guiGridListSetItemData ( rlog.gridlist[1], row, 1, { id = serialTable[i].uniqueid, active = serialTable[i].active } )
				guiSetText(rlog.memo[1], guiGetText(rlog.memo[1]).."(Serial) "..(serialTable[i].datum.." "..serialTable[i].punishment))
				if ( serialTable[i].active == 0 ) then
					guiGridListSetItemColor ( rlog.gridlist[1], row, 1, 225, 0, 0 )
					guiGridListSetItemColor ( rlog.gridlist[1], row, 2, 225, 0, 0 )
				end
			end
			-- Account bans
			guiGridListSetItemText( rlog.gridlist[1], guiGridListAddRow( rlog.gridlist[1] ), 1, "Account Punishments", true, false )
			for i=1,#accountTable do
				local row = guiGridListAddRow ( rlog.gridlist[1] )
				guiGridListSetItemText ( rlog.gridlist[1], row, 1, accountTable[i].datum, false, false )
				guiGridListSetItemText ( rlog.gridlist[1], row, 2, accountTable[i].punishment, false, false )
				guiGridListSetItemData ( rlog.gridlist[1], row, 1, { id = accountTable[i].uniqueid, active = accountTable[i].active }  )
				guiSetText(rlog.memo[1], guiGetText(rlog.memo[1]).."(Account) "..(accountTable[i].datum.." "..accountTable[i].punishment))
				if ( accountTable[i].active == 0 ) then
					guiGridListSetItemColor ( rlog.gridlist[1], row, 1, 225, 0, 0 )
					guiGridListSetItemColor ( rlog.gridlist[1], row, 2, 225, 0, 0 )
				end
			end
			guiSetText(rlog.label[2], "Account/ID: "..retname or "N/A")
			guiSetText(rlog.label[4], "Retrieving for: "..retname or "N/A")
			guiSetText(rlog.label[3], "Returns: "..return_ or "False")
        end
    end
)