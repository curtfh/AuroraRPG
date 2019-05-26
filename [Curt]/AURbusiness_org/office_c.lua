GUIEditor = {
    label = {},
    button = {},
    window = {},
    gridlist = {},
    combobox = {}
}

function openMainWindow()
if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
	else
		if (isClientPassedExpectations() ~= true) then 
			exports.NGCdxmsg:createNewDxMessage("You cannot open this interface due to "..isClientPassedExpectations()..". Please try again later.",255,0,0)
			return false 
		end 
	GUIEditor.window[1] = guiCreateWindow(0.31, 0.32, 0.38, 0.36, "AuroraRPG - Business", true)
	guiWindowSetSizable(GUIEditor.window[1], false)
	GUIEditor.label[2] = guiCreateLabel(0.02, 0.15, 0.20, 0.04, "Members Online: 0", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.label[3] = guiCreateLabel(0.02, 0.09, 0.39, 0.04, "Business Name: ", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.gridlist[1] = guiCreateGridList(0.01, 0.27, 0.70, 0.70, true, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Name", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Location", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Difficulty", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Type", 0.2)
	GUIEditor.button[1] = guiCreateButton(0.72, 0.36, 0.13, 0.08, "Start Mission", true, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(0.86, 0.86, 0.13, 0.11, "Close", true, GUIEditor.window[1])
	GUIEditor.button[3] = guiCreateButton(0.86, 0.36, 0.12, 0.08, "Cancel Mission", true, GUIEditor.window[1])
	GUIEditor.label[4] = guiCreateLabel(0.72, 0.30, 0.26, 0.03, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[4], 172, 34, 34)
	guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
	GUIEditor.label[5] = guiCreateLabel(0.72, 0.32, 0.26, 0.04, "Actions", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
	GUIEditor.label[6] = guiCreateLabel(0.72, 0.44, 0.26, 0.03, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[6], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[6], 172, 34, 34)
	guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
	GUIEditor.label[7] = guiCreateLabel(0.72, 0.47, 0.26, 0.04, "Office Action", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[7], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
	GUIEditor.button[4] = guiCreateButton(0.72, 0.52, 0.12, 0.08, "Kick all players", true, GUIEditor.window[1])
	GUIEditor.button[5] = guiCreateButton(0.86, 0.52, 0.13, 0.08, "Close Office", true, GUIEditor.window[1])
	GUIEditor.label[8] = guiCreateLabel(0.72, 0.60, 0.26, 0.03, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[8], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[8], 172, 34, 34)
	guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
	GUIEditor.label[9] = guiCreateLabel(0.72, 0.62, 0.26, 0.04, "Stocks", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[9], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[9], "center", false)
	GUIEditor.label[10] = guiCreateLabel(0.42, 0.09, 0.29, 0.04, "AuroraRPG - Business Update", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[10], "default-bold-small")
	GUIEditor.label[11] = guiCreateLabel(0.42, 0.15, 0.29, 0.04, "Current Stocks: 0", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[11], "default-bold-small")
	GUIEditor.button[6] = guiCreateButton(0.72, 0.66, 0.26, 0.07, "Open Inventory", true, GUIEditor.window[1])
	GUIEditor.label[12] = guiCreateLabel(0.72, 0.73, 0.26, 0.03, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[12], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[12], 172, 34, 34)
	guiLabelSetHorizontalAlign(GUIEditor.label[12], "center", false)
	addEventHandler("onClientGUIClick", GUIEditor.button[2], openMainWindow, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[6], openMainWindow, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[6], openWarehouseWindow, false)
	local members = 0
	for index, player in pairs(getElementsByType("player")) do
		if (getElementData(player, "Business") == getElementData(getLocalPlayer(), "Business")) then 
			members = members + 1
		end 
	end 
	guiSetText(GUIEditor.label[2], "Members Online: "..members)
	guiSetText(GUIEditor.label[3], "Business Name: "..getElementData(getLocalPlayer(), "Business"))
	showCursor(true)
	end
end

function openWarehouseWindow ()
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
		showCursor(false)
	else
		if (isClientPassedExpectations() ~= true) then 
			exports.NGCdxmsg:createNewDxMessage("You cannot open this interface due to "..isClientPassedExpectations()..". Please try again later.",255,0,0)
			return false 
		end 
		GUIEditor.window[2] = guiCreateWindow(0.28, 0.28, 0.45, 0.44, "AuroraRPG - Inventory", true)
        guiWindowSetSizable(GUIEditor.window[2], false)

        GUIEditor.label[2] = guiCreateLabel(0.02, 0.09, 0.37, 0.04, "Overall Items:", true, GUIEditor.window[2])
        guiSetFont(GUIEditor.label[2], "default-bold-small")
        GUIEditor.gridlist[2] = guiCreateGridList(0.02, 0.16, 0.79, 0.81, true, GUIEditor.window[2])
        guiGridListAddColumn(GUIEditor.gridlist[2], "Item", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[2], "Description", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[2], "Est. Price", 0.3)
        GUIEditor.button[3] = guiCreateButton(0.81, 0.20, 0.17, 0.07, "Sell", true, GUIEditor.window[2])
        GUIEditor.button[4] = guiCreateButton(0.81, 0.31, 0.17, 0.07, "Throw Item", true, GUIEditor.window[2])
        GUIEditor.button[5] = guiCreateButton(0.82, 0.90, 0.16, 0.07, "Close", true, GUIEditor.window[2])      
		addEventHandler("onClientGUIClick", GUIEditor.button[5], openWarehouseWindow, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[5], openMainWindow, false)
		showCursor(true)
	end 
end

function isClientPassedExpectations()
	if getElementDimension(localPlayer) ~= 0 then
		return "different dimension id"
	end
	if getElementInterior(localPlayer) ~= 0 then
		return "different interior id"
	end
	if getElementData(localPlayer,"drugsOpen") then
		return "drug interface is open"
	end
	if (getPlayerWantedLevel() ~= 0) then 
		return "wanted level is higher than 0"
	end
	if isMainMenuActive() then
		return "MTASA main menu is open"
	end
	return true
end