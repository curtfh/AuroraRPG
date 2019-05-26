local data = {}

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

mainWnd = guiCreateWindow(232, 96, 931, 528, "Staff Logs", false)
centerWindow(mainWnd)
guiWindowSetSizable(mainWnd, false)
guiSetVisible(mainWnd, false)
gridList = guiCreateGridList(9, 38, 912, 425, false, mainWnd)
guiGridListSetSelectionMode(gridList, 1)
guiGridListAddColumn(gridList, "Timestamp", 0.5)
guiGridListAddColumn(gridList, "Log", 0.5)
copyBtn = guiCreateButton(345, 471, 239, 47, "Copy to Clipboard", false, mainWnd)    

addEvent("AURstafflogs.receiveData", true)
addEventHandler("AURstafflogs.receiveData", root, function(tab)
	data = tab
end )

addCommandHandler("stafflogs", function()
	if (exports.CSGstaff:getPlayerAdminLevel(localPlayer) < 5) then return end
	if (not guiGetVisible(mainWnd)) then
		triggerServerEvent("AURstafflogs.requestData", resourceRoot)
		guiSetVisible(mainWnd, true)
		showCursor(true)
		guiGridListClear(gridList)
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(gridList)
			guiGridListSetItemText(gridList, row, 1, v["timestamp"], false, false)
			guiGridListSetItemText(gridList, row, 2, v["action"], false, false)
		end
	else
		guiSetVisible(mainWnd, false)
		showCursor(false)
	end
end)

addEventHandler("onClientGUIClick", copyBtn, function()
	local str = ""
	for i, data in ipairs(guiGridListGetSelectedItems(gridList)) do
		str = str.."\n "..guiGridListGetItemText(gridList, data["row"], 1).." : "..guiGridListGetItemText(gridList, data["row"], 2)
	end
	setClipboard(str)
end, false)