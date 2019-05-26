GUIEditor = {
    staticimage = {},
    label = {},
    gridlist = {},
    window = {},
    button = {}
}
local screenW, screenH = guiGetScreenSize()
local localElements = {}
local allowedDimensions = {}
local availableInShops = {}
local blacklisted = {["Secondary Vehicle Color_r"]=true,["Secondary Vehicle Color_g"]=true,["Secondary Vehicle Color_b"]=true,["Vehicle Color_r"]=true,["Vehicle Color_g"]=true,["Vehicle Color_b"]=true}

function openTheInterface  ()
	if (isElement(GUIEditor.window[1])) then 
		if (isTimer(localElements["antiCursorBug"])) then killTimer(localElements["antiCursorBug"]) end
		showCursor(false)
		destroyElement (GUIEditor.window[1])
		triggerServerEvent("AURuserpanel.playerRequestedData", resourceRoot, localPlayer)
		return
	end 
	if (isTimer(localElements["antiSpam"])) then 
		exports.NGCdxmsg:createNewDxMessage(exports.AURlanguage:getTranslate("Unable to continue your process because you were spamming the system.", true),255,0,0)
		return 
	end 
	GUIEditor.window[1] = guiCreateWindow((screenW - 834) / 2, (screenH - 506) / 2, 834, 506, "Aurora ~ User Panel", false)
	guiWindowSetSizable(GUIEditor.window[1], false)
	guiSetAlpha(GUIEditor.window[1], 0.90)

	GUIEditor.staticimage[1] = guiCreateStaticImage(307, 27, 211, 46, ":server/Images/disc.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[2] = guiCreateStaticImage(10, 73, 92, 80, "home.png", false, GUIEditor.window[1])
	GUIEditor.label[1] = guiCreateLabel(20, 228, 71, 15, "Scoreboard", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
	GUIEditor.staticimage[3] = guiCreateStaticImage(10, 167, 92, 80, "user.png", false, GUIEditor.window[1])
	GUIEditor.label[2] = guiCreateLabel(36, 132, 40, 15, "Home", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
	GUIEditor.staticimage[4] = guiCreateStaticImage(10, 257, 91, 80, "vehicle_addon.png", false, GUIEditor.window[1])
	GUIEditor.label[3] = guiCreateLabel(30, 318, 51, 15, "Addons", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
	GUIEditor.staticimage[5] = guiCreateStaticImage(10, 352, 90, 74, "heart.png", false, GUIEditor.window[1])
	GUIEditor.label[4] = guiCreateLabel(37, 411, 40, 15, "Music", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
	GUIEditor.gridlist[1] = guiCreateGridList(102, 24, 15, 472, false, GUIEditor.window[1])
	GUIEditor.label[5] = guiCreateLabel(10, 45, 88, 18, "Menu Section", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
	GUIEditor.button[2] = guiCreateButton(15, 446, 81, 35, exports.AURlanguage:getTranslate("Close", true), false, GUIEditor.window[1])
	GUIEditor.label[0] = guiCreateLabel((834 - 305) / 2, (506 - 15) / 2, 305, 15, exports.AURlanguage:getTranslate("Please select a menu.", true), false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[0], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[0], "center", false)
	--Setting Variables
	showCursor(true)
	localElements["antiCursorBug"] = setTimer(function()
		if (not isElement(GUIEditor.window[1])) then return end 
		if (isCursorShowing() == false) then 
			showCursor(true)
		end 
	end, 500, 0)
	localElements["currentMenu"] = "None"
	localElements["antiSpam"] = setTimer(function() return end, 3000, 1)
	
	--Buttons and such.
	addEventHandler("onClientGUIClick", GUIEditor.button[2], function()
		openTheInterface()
	end, false)	
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[2], function()
		showMenuContent("home")
	end, false)
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[3], function()
		showMenuContent("scoreboard")
	end, false)
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[4], function()
		showMenuContent("addon")
	end, false)
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[5], function()
		if (type(allowedDimensions[getElementDimension(localPlayer)]) ~= "string") then 
			outputMessage("Aurora User Panel - Error [0x000001]", exports.AURlanguage:getTranslate("You cannot open the music panel when your in the Cops n' Robbers room.", true))
			return 
		end 
		if (getElementData(localPlayer, "VIP") ~= "Yes") then 
			outputMessage("Aurora User Panel - Error [0x000003]", exports.AURlanguage:getTranslate("Unable to open the music panel. Your not a VIP!", true))
			return
		end 
		showMenuContent(false)
		openTheInterface()
		exports.AURgmusic:prompt_password()
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[2], function()
		showMenuContent("home")
	end, false)	
	addEventHandler("onClientGUIClick", GUIEditor.label[3], function()
		showMenuContent("addon")
	end, false)
	addEventHandler("onClientGUIClick", GUIEditor.label[1], function()
		showMenuContent("scoreboard")
	end, false)
	addEventHandler("onClientGUIClick", GUIEditor.label[4], function()
		if (type(allowedDimensions[getElementDimension(localPlayer)]) ~= "string") then 
			outputMessage("Aurora User Panel - Error [0x000001]", exports.AURlanguage:getTranslate("You cannot open the music panel when your in the Cops n' Robbers room.", true))
			return 
		end 
		if (getElementData(localPlayer, "VIP") ~= "Yes") then 
			outputMessage("Aurora User Panel - Error [0x000003]", exports.AURlanguage:getTranslate("Unable to open the music panel. Your not a VIP!", true))
			return
		end 
		exports.AURgmusic:prompt_password()
		showMenuContent(false)
		openTheInterface()
	end, false)
end
addCommandHandler("userp", openTheInterface)

function getBoughtStuff()
	local finalResult = {}
	for i=1, #localElements["boughtStuff"] do 
		if (not blacklisted[localElements["boughtStuff"][i][1]]) then 
			finalResult[#finalResult+1] = localElements["boughtStuff"][i][1]
		end 
	end 
	return table.concat(finalResult, ", ")
end 

function showMenuContent(menu)
	if (not isElement(GUIEditor.window[1])) then return false end
	
	if (isElement(GUIEditor.label[0])) then 
		destroyElement(GUIEditor.label[0])
	end 
	
	if (isElement(GUIEditor.label[6])) then
		destroyElement(GUIEditor.label[6])
		destroyElement(GUIEditor.label[7])
		destroyElement(GUIEditor.label[8])
		destroyElement(GUIEditor.label[9])
		destroyElement(GUIEditor.label[10])
		destroyElement(GUIEditor.label[11])
		destroyElement(GUIEditor.label[12])
	end
	
	if (isElement(GUIEditor.gridlist[2])) then 
		destroyElement(GUIEditor.gridlist[2])
	end 
	
	if (isElement(GUIEditor.gridlist[3])) then 
		destroyElement(GUIEditor.gridlist[3])
		destroyElement(GUIEditor.label[11])
		destroyElement(GUIEditor.label[12])
		destroyElement(GUIEditor.label[13])
		destroyElement(GUIEditor.button[1])
		destroyElement(GUIEditor.button[3])
		removeEventHandler("onClientGUIClick", GUIEditor.gridlist[3])
		localElements["currentlySelected"] = ""
		localElements["colorpicker.r"] = nil
		localElements["colorpicker.g"] = nil
		localElements["colorpicker.b"] = nil
	end 
	
	if (menu == "home") then 
		local room = allowedDimensions[getElementDimension(localPlayer)] or "Cops n' Robbers"
		local wins = 0
		local loses = 0
		local level = "L. "..localElements["level"].." ("..localElements["xp"].." XPs)"
		local hasVIP = getElementData(localPlayer, "VIP") or "None"
		local currentColor = "None"
		local currentUpgrades = getBoughtStuff()
	
		GUIEditor.label[6] = guiCreateLabel(141, 99, 237, 15, string.format(exports.AURlanguage:getTranslate("Current Room: %s", true), room), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[6], "default-bold-small")
		GUIEditor.label[7] = guiCreateLabel(141, 124, 237, 15, string.format(exports.AURlanguage:getTranslate("Total Wins:  %s", true), wins), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[7], "default-bold-small")
		GUIEditor.label[8] = guiCreateLabel(141, 149, 237, 15, string.format(exports.AURlanguage:getTranslate("Total Loses:  %s", true), loses), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[8], "default-bold-small")
		guiLabelSetHorizontalAlign(GUIEditor.label[8], "left", true)
		GUIEditor.label[9] = guiCreateLabel(141, 174, 237, 15, string.format(exports.AURlanguage:getTranslate("Level: %s", true), level), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[9], "default-bold-small")
		GUIEditor.label[10] = guiCreateLabel(141, 199, 237, 15, string.format(exports.AURlanguage:getTranslate("VIP Status: %s", true), hasVIP), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[10], "default-bold-small")
		
		GUIEditor.label[11] = guiCreateLabel(141, 224, 237, 15, string.format(exports.AURlanguage:getTranslate("Current Vehicle Color: %s", true), currentColor), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[11], "default-bold-small")
		
		GUIEditor.label[12] = guiCreateLabel(141, 249, 277, 130, string.format(exports.AURlanguage:getTranslate("Bought stuff: %s", true), currentUpgrades), false, GUIEditor.window[1])
		guiLabelSetHorizontalAlign(GUIEditor.label[12], "left", true)
		guiSetFont(GUIEditor.label[12], "default-bold-small")
	elseif (menu == "scoreboard") then 
		GUIEditor.gridlist[2] = guiCreateGridList(120, 72, 704, 424, false, GUIEditor.window[1])
		guiGridListAddColumn(GUIEditor.gridlist[2], "#", 0.1)
		guiGridListAddColumn(GUIEditor.gridlist[2], exports.AURlanguage:getTranslate("Name", true), 0.3)
		guiGridListAddColumn(GUIEditor.gridlist[2], exports.AURlanguage:getTranslate("Level", true), 0.3)
		if (localElements["scoreboard"]) then 
			for i=1, #localElements["scoreboard"] do 
				local row = guiGridListAddRow(GUIEditor.gridlist[2])
				guiGridListSetItemText(GUIEditor.gridlist[2], row, 1, i, false, false)
				guiGridListSetItemText(GUIEditor.gridlist[2], row, 2, localElements["scoreboard"][i][1], false, false)
				guiGridListSetItemText(GUIEditor.gridlist[2], row, 3, localElements["scoreboard"][i][2], false, false)
			end 
		else
			outputMessage("Aurora - Downloading",exports.AURlanguage:getTranslate("Please wait, downloading scoreboard...", true))
			triggerServerEvent("AURuserpanel.playerRequestedDataScoreboard", resourceRoot, localPlayer)
		end 
	elseif (menu == "addon") then 
		GUIEditor.gridlist[3] = guiCreateGridList(130, 76, 295, 420, false, GUIEditor.window[1])
		guiGridListAddColumn(GUIEditor.gridlist[3], exports.AURlanguage:getTranslate("Item", true), 0.5)
		guiGridListAddColumn(GUIEditor.gridlist[3], exports.AURlanguage:getTranslate("Price", true), 0.5)
		GUIEditor.label[11] = guiCreateLabel(449, 100, 272, 14, exports.AURlanguage:getTranslate("Item Name: %s", true), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[11], "default-bold-small")
		GUIEditor.label[12] = guiCreateLabel(449, 125, 272, 14, exports.AURlanguage:getTranslate("Price: %s", true), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[12], "default-bold-small")
		GUIEditor.label[13] = guiCreateLabel(449, 150, 272, 79, exports.AURlanguage:getTranslate("Description: %s", true), false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[13], "default-bold-small")
		guiLabelSetHorizontalAlign(GUIEditor.label[13], "left", true)
		GUIEditor.button[1] = guiCreateButton(509, 239, 122, 31, exports.AURlanguage:getTranslate("Buy", true), false, GUIEditor.window[1])
		GUIEditor.button[3] = guiCreateButton(509, 280, 122, 31, exports.AURlanguage:getTranslate("Buy a map", true), false, GUIEditor.window[1])
		guiSetEnabled(GUIEditor.button[1], false)
		guiSetEnabled(GUIEditor.button[3], false)
		
		for i=1, #availableInShops do 
			local row = guiGridListAddRow(GUIEditor.gridlist[3])
			guiGridListSetItemText(GUIEditor.gridlist[3], row, 1, availableInShops[i].title, false, false)
			guiGridListSetItemText(GUIEditor.gridlist[3], row, 2, "$"..availableInShops[i].price, false, false)
		end 
		
		
		
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[3], function(btn) 
		if btn ~= 'left' then return false end 
		  local row, col = guiGridListGetSelectedItem(source) 
			  if row >= 0 and col >= 0 then 
				for i=1, #availableInShops do
					if (availableInShops[i].title == guiGridListGetItemText(source, row, 1)) then 
						guiSetEnabled(GUIEditor.button[1], true)
						localElements["currentlySelected"] = availableInShops[i].title
						guiSetText(GUIEditor.label[11], string.format(exports.AURlanguage:getTranslate("Item Name: %s", true), availableInShops[i].title))
						guiSetText(GUIEditor.label[12], string.format(exports.AURlanguage:getTranslate("Price: %s", true), "$"..availableInShops[i].price))
						guiSetText(GUIEditor.label[13], string.format(exports.AURlanguage:getTranslate("Description: %s", true), exports.AURlanguage:getTranslate(availableInShops[i].description, true)))
						return 
					end 
				end
					guiSetEnabled(GUIEditor.button[1], false)
					localElements["currentlySelected"] = ""
					guiSetText(GUIEditor.label[11], string.format(exports.AURlanguage:getTranslate("Item Name: %s", true), ""))
					guiSetText(GUIEditor.label[12], string.format(exports.AURlanguage:getTranslate("Price: %s", true), ""))
					guiSetText(GUIEditor.label[13], string.format(exports.AURlanguage:getTranslate("Description: %s", true), ""))
					localElements["colorpicker.r"] = nil
					localElements["colorpicker.g"] = nil
					localElements["colorpicker.b"] = nil
				else
					guiSetEnabled(GUIEditor.button[1], false)
					localElements["currentlySelected"] = ""
					guiSetText(GUIEditor.label[11], string.format(exports.AURlanguage:getTranslate("Item Name: %s", true), ""))
					guiSetText(GUIEditor.label[12], string.format(exports.AURlanguage:getTranslate("Price: %s", true), ""))
					guiSetText(GUIEditor.label[13], string.format(exports.AURlanguage:getTranslate("Description: %s", true), ""))
					localElements["colorpicker.r"] = nil
					localElements["colorpicker.g"] = nil
					localElements["colorpicker.b"] = nil
			  end 
		end, false) 
		
	addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
			for i=1, #availableInShops do 
				if (availableInShops[i].title == localElements["currentlySelected"]) then 
					if (isTimer(localElements["antiSpam2"])) then 
						exports.NGCdxmsg:createNewDxMessage(exports.AURlanguage:getTranslate("Unable to continue your process because you were spamming the system.", true),255,0,0)
						return 
					end 
					if (availableInShops[i].allowedRooms[getElementDimension(localPlayer)] ~= true) then 
						outputMessage("Aurora - Not Available",exports.AURlanguage:getTranslate("Unable to continue your process because this item is not available on Cops n' Robbers room.", true))
						return 
					end 
					if (getPlayerMoney() >= availableInShops[i].price) then 
					
						if (availableInShops[i].colorPicker == true and type(localElements["colorpicker.b"]) ~= "number") then 
							exports.cpicker:openPicker(source, "#FFAA00", string.format(exports.AURlanguage:getTranslate("Pick a color for %s:", true), availableInShops[i].title))
							addEventHandler("onColorPickerOK", root, colorPickerUpdate)
							return
						end 
						
						if (availableInShops[i].colorPicker == false and type(localElements["colorpicker.b"]) ~= "number") then 
							triggerServerEvent("AURuserpanel.buyItem", resourceRoot, localPlayer, availableInShops[i].title, availableInShops[i].price, nil, nil, nil)
							localElements["colorpicker.r"] = nil
							localElements["colorpicker.g"] = nil
							localElements["colorpicker.b"] = nil
						elseif (availableInShops[i].colorPicker == true and type(localElements["colorpicker.b"]) == "number") then 
							triggerServerEvent("AURuserpanel.buyItem", resourceRoot, localPlayer, availableInShops[i].title, availableInShops[i].price, localElements["colorpicker.r"], localElements["colorpicker.g"], localElements["colorpicker.b"])
							localElements["colorpicker.r"] = nil
							localElements["colorpicker.g"] = nil
							localElements["colorpicker.b"] = nil
						end
						localElements["antiSpam2"] = setTimer(function() return end, 3000, 1)
						
					else
						outputMessage("Aurora User Panel - Error [0x000002]", exports.AURlanguage:getTranslate("The transaction failed. You don't have enough money to buy this item.", true))
					end 
				end
			end 
			
		end, false)
		
		
	end 
end 

function colorPickerUpdate (element, hex, r, g, b)
	localElements["colorpicker.r"] = r
	localElements["colorpicker.g"] = g
	localElements["colorpicker.b"] = b
	outputMessage("Aurora User Panel - Color Picked", exports.AURlanguage:getTranslate("Your almost done! Now please press buy.", true))
	removeEventHandler("onColorPickerOK", root, colorPickerUpdate)
end 

function outputMessage(title, message)
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
	end 
	showCursor(true)
	GUIEditor.window[2] = guiCreateWindow((screenW - 463) / 2, (screenH - 152) / 2, 463, 152, title, false)
	guiWindowSetMovable(GUIEditor.window[2], false)
	guiWindowSetSizable(GUIEditor.window[2], false)
	guiSetAlpha(GUIEditor.window[2], 0.95)

	GUIEditor.label[10303] = guiCreateLabel(5, 23, 455, 75, message, false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[10303], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[10303], "center", true)
	GUIEditor.button[10302] = guiCreateButton(145, 108, 173, 34, "Ok", false, GUIEditor.window[2]) 
	addEventHandler("onClientGUIClick", GUIEditor.button[10302], function()
		if (isElement(GUIEditor.window[2])) then
			showCursor(false)
			destroyElement(GUIEditor.window[2])
		end
	end, false)
end 

function gotRequestedVariablesFromServer (theTable)
	allowedDimensions = theTable["allowedDimensions"]
	localElements["level"] = theTable["level"]
	localElements["xp"] = theTable["xp"]
	availableInShops = theTable["availableInShops"]
	localElements["boughtStuff"] = theTable["boughtStuff"]
end 
addEvent("AURuserpanel.clientDataRecieved", true)
addEventHandler("AURuserpanel.clientDataRecieved", localPlayer, gotRequestedVariablesFromServer)

function clientDataRecievedScoreboard (theTable)
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
	end 
	localElements["scoreboard"] = theTable
	if (isElement(GUIEditor.gridlist[2])) then 
		for i=1, #theTable do 
			local row = guiGridListAddRow(GUIEditor.gridlist[2])
			guiGridListSetItemText(GUIEditor.gridlist[2], row, 1, i, false, false)
			guiGridListSetItemText(GUIEditor.gridlist[2], row, 2, theTable[i][1], false, false)
			guiGridListSetItemText(GUIEditor.gridlist[2], row, 3, theTable[i][2], false, false)
		end 
	end 
end 
addEvent("AURuserpanel.clientDataRecievedScoreboard", true)
addEventHandler("AURuserpanel.clientDataRecievedScoreboard", localPlayer, clientDataRecievedScoreboard)

addEventHandler("onClientResourceStart", resourceRoot, function()
	triggerServerEvent("AURuserpanel.playerRequestedData", resourceRoot, localPlayer)
end)

if (fileExists("interface.lua")) then fileDelete("interface.lua") end