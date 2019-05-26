GUIEditor = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

local accessList = {["Manager"] = true, ["Deputy Leader"] = true, ["Group Leader"] = true}
local tables = {}
local antispam_timer
local antispam_timer2
local current = 0

function openGUI()
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
		current = 0
		return false
	end 
	triggerServerEvent ("AURgrouptags.getTableDataFromDatabase", resourceRoot, getLocalPlayer())
	
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 532) / 2, (screenH - 382) / 2, 532, 382, "AuroraRPG - Group Tags", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(14, 23, 262, 15, "Members of GroupName", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
	GUIEditor.gridlist[1] = guiCreateGridList(9, 38, 267, 335, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Account", 0.3)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Prefix", 0.3)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Suffix", 0.3)
	GUIEditor.label[2] = guiCreateLabel(293, 48, 218, 15, "Account Name: Unknown", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.label[3] = guiCreateLabel(293, 81, 43, 15, "Suffix:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.label[4] = guiCreateLabel(293, 123, 43, 15, "Prefix:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	GUIEditor.edit[1] = guiCreateEdit(336, 73, 156, 28, "", false, GUIEditor.window[1])
	guiEditSetMaxLength(GUIEditor.edit[1], 4)
	GUIEditor.edit[2] = guiCreateEdit(336, 113, 156, 28, "", false, GUIEditor.window[1])
	guiEditSetMaxLength(GUIEditor.edit[2], 4)
	GUIEditor.button[1] = guiCreateButton(359, 204, 79, 35, "Apply Changes", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(449, 354, 73, 19, "Close", false, GUIEditor.window[1])
	GUIEditor.button[3] = guiCreateButton(283, 351, 79, 22, "Refresh List", false, GUIEditor.window[1])
	GUIEditor.label[5] = guiCreateLabel(293, 157, 211, 37, "Preview: ", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[5], "left", true)    
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	guiSetEnabled(GUIEditor.edit[1], false)
	guiSetEnabled(GUIEditor.edit[2], false)
	guiSetEnabled(GUIEditor.button[1], false)
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
		  if row >= 0 and col >= 0 then 
			for i=1, #tables do
				if (tables[i][1] == guiGridListGetItemText(source, row, 1)) then
					local suffix = tables[i][2]
					local prefix = tables[i][3]
					if (suffix == "None") then suffix = "" end
					if (prefix == "None") then prefix = "" end
					guiSetText(GUIEditor.label[2], "Account Name: "..tables[i][1])
					guiSetText(GUIEditor.edit[1], suffix)
					guiSetText(GUIEditor.edit[2], prefix)
					guiSetText(GUIEditor.label[5], "Preview: "..suffix.."Name"..prefix)
					guiSetEnabled(GUIEditor.edit[1], true)
					guiSetEnabled(GUIEditor.edit[2], true)
					guiSetEnabled(GUIEditor.button[1], true)
					current = i
					return 
				end 
			end
				guiSetText(GUIEditor.label[2], "Account Name: Unknown")
				guiSetText(GUIEditor.edit[1], "")
				guiSetText(GUIEditor.edit[2], "")
				guiSetText(GUIEditor.label[5], "Preview: ")
				guiSetEnabled(GUIEditor.edit[1], false)
				guiSetEnabled(GUIEditor.edit[2], false)
				guiSetEnabled(GUIEditor.button[1], false)
				current = 0
			else
				guiSetText(GUIEditor.label[2], "Account Name: Unknown")
				guiSetText(GUIEditor.edit[1], "")
				guiSetText(GUIEditor.edit[2], "")
				guiSetText(GUIEditor.label[5], "Preview: ")
				guiSetEnabled(GUIEditor.edit[1], false)
				guiSetEnabled(GUIEditor.edit[2], false)
				guiSetEnabled(GUIEditor.button[1], false)
				current = 0
		  end 
	end, false) 
	
	addEventHandler("onClientGUIChanged", GUIEditor.edit[1], function() 
	   guiSetText(GUIEditor.label[5], "Preview: "..guiGetText(GUIEditor.edit[1]).."Name"..guiGetText(GUIEditor.edit[2]))
	end)
	
	addEventHandler("onClientGUIChanged", GUIEditor.edit[2], function() 
	   guiSetText(GUIEditor.label[5], "Preview: "..guiGetText(GUIEditor.edit[1]).."Name"..guiGetText(GUIEditor.edit[2]))
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
		if (isTimer(antispam_timer2)) then
			exports.NGCdxmsg:createNewDxMessage("Unable to save data due to the button has been pressed too many times.",255,0,0)
			return false 
		end 
		for i=1, #tables do
			if (i == current) then
				--if (tables[i][2] ~= guiGetText(GUIEditor.edit[1])) then 
					triggerServerEvent ("AURgrouptags.updateData", resourceRoot, getLocalPlayer(), "suffix", tables[i][1], guiGetText(GUIEditor.edit[1]))						

				--end
				--if (tables[i][3] ~= guiGetText(GUIEditor.edit[2])) then 
					triggerServerEvent ("AURgrouptags.updateData", resourceRoot, getLocalPlayer(), "prefix", tables[i][1], guiGetText(GUIEditor.edit[2]))						
				--end
				antispam_timer2 = setTimer(function() killTimer(antispam_timer2) end, 3000, 1)
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[2], function()
		openGUI()
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[3], function()
		if (isTimer(antispam_timer)) then
			exports.NGCdxmsg:createNewDxMessage("Unable to refresh due to the button has been pressed too many times.",255,0,0)
			return false 
		end 
		openGUI()
		openGUI()
		antispam_timer = setTimer(function() killTimer(antispam_timer) end, 10000, 1)
	end, false)
end

function theCommandHandling (theCommand)
	local thePlayer = getLocalPlayer()
	if (getElementData(thePlayer, "Group")  == false) then 
		exports.NGCdxmsg:createNewDxMessage("You must have a group to access this command.",255,0,0)
		return false 	
	end 
	if (not accessList[getElementData(thePlayer, "GroupRank")]) then 
		exports.NGCdxmsg:createNewDxMessage("You don't have enough group permissions to access this command.",255,0,0)
		return false
	end
	openGUI()
end 
addCommandHandler("grouptags", theCommandHandling)

function updateTables (theNewTable)
	tables = theNewTable
	if (isElement(GUIEditor.window[1])) then 
		guiGridListClear(GUIEditor.gridlist[1])
		for i=1, #tables do
			guiGridListAddRow(GUIEditor.gridlist[1], tables[i][1], tables[i][2], tables[i][3])
		end 
	end 
end 
addEvent("AURgrouptags.updateTables", true)
addEventHandler("AURgrouptags.updateTables", localPlayer, updateTables)

if (fileExists("client.lua")) then fileDelete("client.lua") end