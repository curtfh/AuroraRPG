GUIEditor = {
    edit = {},
    button = {},
    window = {},
    label = {},
    combobox = {}
}

local thePassCode = 0
local level = 0

local cooldown = nil
local cursorCheckerTimer
function openGUI()
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 261) / 2, (screenH - 224) / 2, 261, 224, "AuroraRPG - ATM Hack", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(12, 56, 36, 15, "Mode:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.combobox[1] = guiCreateComboBox(58, 54, 188, 64, "Choose a mode", false, GUIEditor.window[1])
	guiComboBoxAddItem(GUIEditor.combobox[1], "Easy - 3 Digit Number")
	guiComboBoxAddItem(GUIEditor.combobox[1], "Medium - 4 Digit Number")
	guiComboBoxAddItem(GUIEditor.combobox[1], "Hard - 5 Digit Number")
	GUIEditor.label[2] = guiCreateLabel(10, 103, 103, 15, "Enter Passcode:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.button[1] = guiCreateButton(17, 177, 86, 37, "Crack!", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(165, 177, 86, 37, "Close", false, GUIEditor.window[1])
	GUIEditor.edit[1] = guiCreateEdit(10, 128, 241, 39, "", false, GUIEditor.window[1])
	guiEditSetMaxLength(GUIEditor.edit[1], 4)
	guiSetEnabled(GUIEditor.edit[1], false)
	guiSetEnabled(GUIEditor.button[1], false)
	GUIEditor.label[3] = guiCreateLabel(12, 31, 234, 15, "Hint: Select a mode first.", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	addEventHandler ("onClientGUIClick", GUIEditor.button[2],function() openHackGUI() end, false)
	addEventHandler ("onClientGUIComboBoxAccepted", GUIEditor.combobox[1],
		function (comboBox)
			local item = guiComboBoxGetSelected(comboBox)
			local text = tostring(guiComboBoxGetItemText(comboBox , item))
			if (text == "Easy - 3 Digit Number") then 
				thePassCode = math.random(100,999)
				guiEditSetMaxLength(GUIEditor.edit[1], 3)
				guiSetText(GUIEditor.label[3], "Hint: Type the number to guess.")
				guiSetEnabled(GUIEditor.edit[1], true)
				guiSetEnabled(GUIEditor.button[1], true)
				level = 1
			elseif (text == "Medium - 4 Digit Number") then 
				thePassCode = math.random(1000,9999)
				guiEditSetMaxLength(GUIEditor.edit[1], 4)
				guiSetText(GUIEditor.label[3], "Hint: Type the number to guess.")
				guiSetEnabled(GUIEditor.edit[1], true)
				guiSetEnabled(GUIEditor.button[1], true)
				level = 2
			elseif (text == "Hard - 5 Digit Number") then 
				thePassCode = math.random(10000,99999)
				guiEditSetMaxLength(GUIEditor.edit[1], 5)
				guiSetText(GUIEditor.label[3], "Hint: Type the number to guess.")
				guiSetEnabled(GUIEditor.edit[1], true)
				guiSetEnabled(GUIEditor.button[1], true)
				level = 3
			else
			
			end 
		end
	)
	
	addEventHandler ("onClientGUIClick", GUIEditor.button[1],function() checkCode() end, false)
	
	
	addEventHandler ( "onClientGUIChanged", GUIEditor.edit[1], function ( ) 
		local text = guiGetText (source) 
		if (text == "") then 
			curText = "1" 
			guiSetText (source, "1") 
			return 
		end 
  
		if (not tonumber (text)) then 
			guiSetText (source, "1") 
		else 
			if (tonumber(text) <= 0) then 
				curText = "1" 
				guiSetText (source, "1") 
			return
			end
			curText = text 
			hintDetector(text, thePassCode)
		end 
	end, false)
end 

function checkCode ()
	if (tonumber(guiGetText(GUIEditor.edit[1])) == thePassCode) then 
		triggerServerEvent("AURbankatm.continue", resourceRoot, level)
		openHackGUI()
		--cooldown = getTickCount()
	else
		exports.NGCdxmsg:createNewDxMessage("Access denied.",255,0,0)
	end 
end 

function hintDetector (number, code)
	
	local getDis = math.abs(tonumber(number) - tonumber(code))
	if (getDis >= 5000) then 
		guiSetText(GUIEditor.label[3], "Hint: Your too too too far from the code!")
	elseif (getDis >= 1000) then 
		guiSetText(GUIEditor.label[3], "Hint: Your too too far from the code!")
	elseif (getDis >= 500) then 
		guiSetText(GUIEditor.label[3], "Hint: Your too far from the code!")
	elseif (getDis >= 300) then 
		guiSetText(GUIEditor.label[3], "Hint: Far from the code!")
	elseif (getDis >= 100) then 
		guiSetText(GUIEditor.label[3], "Hint: Near to the code!")
	elseif (getDis >= 50) then 
		guiSetText(GUIEditor.label[3], "Hint: Very Near to code!")
	elseif (getDis >= 10) then 
		guiSetText(GUIEditor.label[3], "Hint: Nearest!")
	elseif (getDis >= 0) then 
		guiSetText(GUIEditor.label[3], "Hint: Nearest!!")
	end
	
end 

function openHackGUI ()
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false, false)
		if (isTimer(cursorCheckerTimer)) then 
			killTimer(cursorCheckerTimer)
		end 
	else
		--[[if (getTickCount() - cooldown < 900000) then 
			exports.NGCdxmsg:createNewDxMessage("The ATM is unavailable right now to hack. Please try again later.",255,0,0)
			return 
		end]]
		cursorCheckerTimer = setTimer(function() if (not isCursorShowing()) then showCursor(true, true) return end end, 1000, 0)
		openGUI()
		showCursor(true, true)
	end
end 