GUIEditor = {
    label = {},
    edit = {},
    button = {},
    window = {},
    gridlist = {},
    memo = {},
	browser = {}
}
showCursorHandler = false

addEventHandler("onClientResourceStart", resourceRoot, function()
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 1138) / 2, (screenH - 633) / 2, 1138, 633, "AuroraRPG - Information", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.gridlist[1] = guiCreateGridList(10, 123, 249, 500, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Title", 0.9)
	GUIEditor.label[1] = guiCreateLabel(8, 66, 107, 18, "Search a keyword:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.edit[1] = guiCreateEdit(9, 84, 250, 29, "", false, GUIEditor.window[1])
	GUIEditor.memo[1] = guiCreateMemo(270, 126, 858, 481, "", false, GUIEditor.window[1])
	GIOEditor.browser[1] = guiCreateBrowser(270, 126, 858, 481, true, true, true, GUIEditor.window[1])
	GUIEditor.button[1] = guiCreateButton(1016, 21, 112, 30, "Close", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(1016, 61, 112, 30, "Edit", false, GUIEditor.window[1])
	GUIEditor.button[3] = guiCreateButton(894, 21, 112, 30, "Save", false, GUIEditor.window[1])
	GUIEditor.button[4] = guiCreateButton(894, 61, 112, 30, "Add", false, GUIEditor.window[1])
	GUIEditor.label[2] = guiCreateLabel(970, 608, 152, 15, "AuroraRPG - aurorarpg.com", false, GUIEditor.window[1])
	GUIEditor.edit[2] = guiCreateEdit(896, 96, 227, 25, "A title for article. Edit me", false, GUIEditor.window[1])  
	guiSetVisible(GUIEditor.window[1], false)
	guiSetVisible(GUIEditor.button[2], false)
	guiSetVisible(GUIEditor.button[3], false)
	guiSetVisible(GUIEditor.button[4], false)
	guiSetVisible(GUIEditor.edit[2], false)
	guiSetVisible(GUIEditor.memo[1], false)
end)

function openGUI ()
	if (guiGetVisible(GUIEditor.window[1])) == false then 
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
		triggerServerEvent("AURf1information.getDataList", resourceRoot)
		showCursorHandler = setTimer(function()
			if (not isCursorShowing()) then 
				showCursor(true)
			end 
		end, 500, 0)
	else 
		guiSetVisible(GUIEditor.window[1], false)
		if isTimer(showCursorHandler) then 
			killTimer(showCursorHandler)
		end 
		showCursor(false)
	end 
end 
addCommandHandler("help", openGUI)

addEventHandler ("onClientGUIClick", GUIEditor.button[1], function()
	guiSetVisible(GUIEditor.window[1], false)
	if isTimer(showCursorHandler) then 
		killTimer(showCursorHandler)
	end 
	showCursor(false)
end, false)