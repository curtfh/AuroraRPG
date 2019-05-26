local guiElements = {
	window = {},
	button = {},
	label = {},
	gridlist = {},
}

local guiTypes = {
	[1] = {"Default Centre"},
}

local guiButtons_, seperation = {}, {}
local windowWidth, windowHeight = 610, 433
local screenWidth, screenHeight = guiGetScreenSize()
local windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)

function determineElements(string, amount)
	for i = 2, amount + 2 do
		if (not guiElements.gridlist[1]) then
			padding = 10
		else
			padding = 209
		end
		if (string == "label") then
			if (i == 3) then
				seperation[i] = { 84 }
			elseif (i == 4) then
				seperation[i] = { 164 - 25 }
			elseif (i == 5) then
				seperation[i] = { 164 - (25*2) }
			elseif (i == 6) then
				seperation[i] = { 164 - (25*4) }
			else
				seperation[i] = { 10 }
			end
			return
		elseif (string == "button") then
			if (i == 3) then
				seperation[i] = { 368 - 43 }
			elseif (i == 4) then
				seperation[i] = { 368 - (43*2) }
			elseif (i == 5) then
				seperation[i] = { 368 - (43*3) }
			elseif (i == 6) then
				seperation[i] = { 368 - (43*4) }
			else
				seperation[i] = { 368 }
			end
			return
		end
		--outputChatBox(table.concat(seperation[i]))
	end
end

function createDefaultGUI(guiName, guiLabels, guiLabelText, guiButtons, buttonText, guiType, sizeable, movable, bool, guiGridlist)
	if (guiName and guiName ~= "") then
		guiElements.window[1] = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, tostring(guiName), bool or false)
		guiWindowSetSizable(guiElements.window[1], sizeable or false)
		guiWindowSetMovable(guiElements.window[1], movable or false)
		guiSetVisible(guiElements.window[1], false)
		guiSetAlpha(guiElements.window[1], 1.00)
		if (guiGridlist) then
			guiElements.gridlist[1] = guiCreateGridList(10, 114, 193, 309, false, guiElements.window[1])
		end
		if (tonumber(guiButtons) and tonumber(guiButtons) <= 5) then
			for i=2, guiButtons + 2 do
				determineElements("button", guiButtons)
			end
			outputChatBox("Mark line 48, buttons currently marked as "..tostring(guiButtons).." buttons")
		end
		if (buttonText and buttonText ~= "") then
			outputChatBox("Mark line 50, succeeded and moving onto data loop")
			for i=2, guiButtons + 2 do
				guiElements.button[i] = guiCreateButton(padding, table.concat(seperation[i]), 133, 37, buttonText, false, guiElements.window[1])
				guiSetFont(guiElements.button[i], "default-bold-small")
				guiSetProperty(guiElements.button[i], "NormalTextColour", "FFAAAAAA")
				if (guiElements.button[i]) then
					outputChatBox("guiElements.button["..tostring(i).."] created at "..tostring(padding).." padding with "..table.concat(seperation[i]).." seperation!") 
				end
			end
			guiElements.button[1] = guiCreateButton(563, 24, 37, 29, "X", false, guiElements.window[1])
			guiSetFont(guiElements.button[1], "default-bold-small")
			guiSetProperty(guiElements.button[1], "NormalTextColour", "FFAAAAAA")
		end
		if (tonumber(guiLabels) and tonumber(guiLabels) <= 5) then
			for i=2, guiLabels + 2 do
				determineElements("label", guiLabels)
			end
		end
		if (guiLabelText and guiLabelText ~= "") then
			for i=2, guiLabels + 2 do
				if (i == 2) then
					padding = 10
				else
					determineElements("label", guiLabels)
					break
				end
				guiElements.button[i] = guiCreateLabel(padding, table.concat(seperation[i]), 133, 37, guiLabelText, false, guiElements.window[1])
				guiSetFont(guiElements.button[i], "default-bold-small")
				guiSetProperty(guiElements.button[i], "NormalTextColour", "FFAAAAAA")
			end
			guiElements.label[1] = guiCreateLabel(10, 30, 590, 50, guiLabelText or "Ab-47's Test GUI", false, guiElements.window[1])
			guiSetFont(guiElements.label[1], "clear-normal")
			guiLabelSetHorizontalAlign(guiElements.label[1], "center", false)
			guiLabelSetVerticalAlign(guiElements.label[1], "center")
		end
		for i, button in pairs(guiElements.button) do
			addEventHandler("onClientGUIClick", button, function() if (source == guiElements.button[1]) then guiSetVisible(guiElements.window[1], false) showCursor(false) end end)
		end
		addCommandHandler("handlegui", function() guiSetVisible(guiElements.window[1], true) showCursor(true) end)
	end
end

function createTestGUI()
	createDefaultGUI("Ab-47", 3, "This is my test GUI", 3, "Hello", default, false, false, false, true)
end
addCommandHandler("createmygui", createTestGUI)

--[[guiElements = {
    label = {},
    edit = {},
    button = {},
    window = {},
    radiobutton = {},
    gridlist = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        guiElements.window[1] = guiCreateWindow(374, 172, 610, 433, "Default GUI Centred", false)
        guiWindowSetSizable(guiElements.window[1], false)
        guiSetAlpha(guiElements.window[1], 1.00)

        guiElements.label[1] = guiCreateLabel(10, 30, 590, 50, "Default GUI Label", false, guiElements.window[1])
        guiSetFont(guiElements.label[1], "clear-normal")
        guiLabelSetHorizontalAlign(guiElements.label[1], "center", false)
        guiLabelSetVerticalAlign(guiElements.label[1], "center")
        guiElements.gridlist[1] = guiCreateGridList(10, 114, 193, 309, false, guiElements.window[1])
        guiElements.label[2] = guiCreateLabel(11, 84, 192, 25, "Label 2", false, guiElements.window[1])
        guiSetFont(guiElements.label[2], "clear-normal")
        guiLabelSetHorizontalAlign(guiElements.label[2], "center", false)
        guiLabelSetVerticalAlign(guiElements.label[2], "center")
        guiElements.button[1] = guiCreateButton(209, 386, 133, 37, "Action 1", false, guiElements.window[1])
        guiSetProperty(guiElements.button[1], "NormalTextColour", "FFAAAAAA")
        guiElements.button[2] = guiCreateButton(209, 343, 133, 37, "Action 2", false, guiElements.window[1])
        guiSetProperty(guiElements.button[2], "NormalTextColour", "FFAAAAAA")
        guiElements.button[3] = guiCreateButton(209, 298, 133, 37, "Action 3", false, guiElements.window[1])
        guiSetProperty(guiElements.button[3], "NormalTextColour", "FFAAAAAA")
        guiElements.button[4] = guiCreateButton(209, 253, 133, 37, "Action 4", false, guiElements.window[1])
        guiSetProperty(guiElements.button[4], "NormalTextColour", "FFAAAAAA")
        guiElements.button[5] = guiCreateButton(209, 208, 133, 37, "Action 5", false, guiElements.window[1])
        guiSetProperty(guiElements.button[5], "NormalTextColour", "FFAAAAAA")
        guiElements.button[6] = guiCreateButton(563, 24, 37, 29, "X", false, guiElements.window[1])
        guiSetFont(guiElements.button[6], "default-bold-small")
        guiSetProperty(guiElements.button[6], "NormalTextColour", "FFAAAAAA")
        guiElements.label[3] = guiCreateLabel(213, 114, 387, 25, "Label 3", false, guiElements.window[1])
        guiSetFont(guiElements.label[3], "clear-normal")
        guiLabelSetVerticalAlign(guiElements.label[3], "center")
        guiElements.label[4] = guiCreateLabel(213, 139, 387, 25, "Label 4", false, guiElements.window[1])
        guiSetFont(guiElements.label[4], "clear-normal")
        guiLabelSetVerticalAlign(guiElements.label[4], "center")
        guiElements.label[5] = guiCreateLabel(213, 164, 387, 28, "Label 5", false, guiElements.window[1])
        guiSetFont(guiElements.label[5], "clear-normal")
        guiLabelSetVerticalAlign(guiElements.label[5], "center")
        guiElements.edit[1] = guiCreateEdit(347, 386, 132, 35, "", false, guiElements.window[1])
        guiElements.edit[2] = guiCreateEdit(347, 343, 132, 35, "", false, guiElements.window[1])
        guiElements.edit[3] = guiCreateEdit(347, 210, 132, 35, "", false, guiElements.window[1])
        guiElements.edit[4] = guiCreateEdit(347, 255, 132, 35, "", false, guiElements.window[1])
        guiElements.edit[5] = guiCreateEdit(347, 300, 132, 35, "", false, guiElements.window[1])
        guiElements.radiobutton[1] = guiCreateRadioButton(484, 211, 116, 34, "Radio 1", false, guiElements.window[1])
        guiElements.radiobutton[2] = guiCreateRadioButton(487, 386, 114, 34, "Radio 5", false, guiElements.window[1])
        guiElements.radiobutton[3] = guiCreateRadioButton(487, 342, 112, 34, "Radio 4", false, guiElements.window[1])
        guiRadioButtonSetSelected(guiElements.radiobutton[3], true)
        guiElements.radiobutton[4] = guiCreateRadioButton(487, 299, 113, 34, "Radio 3", false, guiElements.window[1])
        guiElements.radiobutton[5] = guiCreateRadioButton(485, 255, 115, 34, "Radio 2", false, guiElements.window[1])    
    end
)]]
