GUIEditor = {
    gridlist = {},
    label = {},
    button = {},
    window = {},
    combobox = {},
    memo = {}
}
local databaseTable = {}
local localizations = {}
local elementsCreated = {}
local screenW, screenH = guiGetScreenSize()

function openLanguageContributor ()
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
		if (isTimer(elementsCreated["timer1"])) then killTimer(elementsCreated["timer1"]) end
		databaseTable = {}
		elementsCreated["currentID"] = 0
		elementsCreated["currentversion"] = 0
		elementsCreated["linkedTo"] = 0
		elementsCreated["oldIDSeen"] = 0
		return 
	end
	if (isTimer(elementsCreated["antispam_contri"])) then 
		exports.NGCdxmsg:createNewDxMessage("The language contributor interace was unable to open or close because you were flooding the command/button.",255,0,0)
		return 
	end 
	GUIEditor.window[1] = guiCreateWindow((screenW - 837) / 2, (screenH - 495) / 2, 837, 495, "AuroraRPG - Language Contributor", false)
	guiWindowSetSizable(GUIEditor.window[1], false)
	GUIEditor.gridlist[1] = guiCreateGridList(10, 61, 322, 424, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Original Text", 0.9)
	GUIEditor.label[1] = guiCreateLabel(16, 36, 115, 15, "Choose a language: ", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.combobox[1] = guiCreateComboBox(131, 32, 201, 201, "", false, GUIEditor.window[1])
	guiComboBoxAddItem(GUIEditor.combobox[1], exports.AURlanguage:getTranslate("Select a language", true))
	guiComboBoxSetSelected(GUIEditor.combobox[1], 0)
	GUIEditor.memo[1] = guiCreateMemo(343, 82, 478, 99, "", false, GUIEditor.window[1])
	guiMemoSetReadOnly(GUIEditor.memo[1], true)
	GUIEditor.label[2] = guiCreateLabel(343, 61, 115, 15, "Original Text", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.label[3] = guiCreateLabel(342, 197, 479, 15, string.format(exports.AURlanguage:getTranslate("Translate the original text to %s", true), ""), false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.memo[2] = guiCreateMemo(342, 216, 478, 99, "", false, GUIEditor.window[1])
	GUIEditor.label[4] = guiCreateLabel(342, 320, 130, 15, "Recent Changes:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	GUIEditor.memo[3] = guiCreateMemo(342, 335, 478, 99, "", false, GUIEditor.window[1])
	guiMemoSetReadOnly(GUIEditor.memo[3], true)
	GUIEditor.button[1] = guiCreateButton(406, 448, 138, 27, "Submit", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(628, 448, 138, 27, "Close", false, GUIEditor.window[1])
	GUIEditor.label[5] = guiCreateLabel(342, 37, 461, 14, "Reward: Accepted Translation = $2,000", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	elementsCreated["timer1"] = setTimer(function()
		if (isElement(GUIEditor.window[1])) then 
			if (not isCursorShowing()) then
				showCursor(true)
			end 
		end
	end, 500, 0)
	
	triggerServerEvent ("AURlanguage.getLanguageTable", resourceRoot, getLocalPlayer(), getLocalPlayer(), false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[2], function()
		openLanguageContributor()
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
		local theSubmitedTable = {}
		theSubmitedTable["string"] = guiGetText(GUIEditor.memo[2])
		theSubmitedTable["contributor"] = getElementData(getLocalPlayer(), "playerAccount")
		theSubmitedTable["contributor_name"] = getPlayerName(getLocalPlayer())
		theSubmitedTable["linkedTo"] = math.floor(elementsCreated["linkedTo"]) or 0
		theSubmitedTable["version"] = math.floor(elementsCreated["currentversion"])+1 or 1
		theSubmitedTable["language"] = tostring (guiComboBoxGetItemText(GUIEditor.combobox[1] ,guiComboBoxGetSelected (GUIEditor.combobox[1])))
		triggerServerEvent ("AURlanguage.submitLanguage", resourceRoot, getLocalPlayer(), theSubmitedTable)
	end, false)
	
	addEventHandler ("onClientGUIComboBoxAccepted", GUIEditor.combobox[1], function (comboBox)
		local item = guiComboBoxGetSelected (comboBox)
		local text = tostring (guiComboBoxGetItemText (comboBox , item))
		if (text ~= "Choose a language: ") then 
			guiGridListClear(GUIEditor.gridlist[1])
			guiSetText(GUIEditor.label[3], string.format(exports.AURlanguage:getTranslate("Translate the original text to %s", true), ""))
			guiSetText(GUIEditor.memo[1], "")
			guiSetText(GUIEditor.memo[2], "")
			guiSetText(GUIEditor.memo[3], "")
			elementsCreated["currentversion"] = 0
			elementsCreated["linkedTo"] = 0
			for i=1, #databaseTable do 
				if (databaseTable[i].language == "ORIGINAL" and databaseTable[i].type == "ORIGINAL" and databaseTable[i].contributor == "AURORARPG") then 
					local row = guiGridListAddRow(GUIEditor.gridlist[1])
					guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, databaseTable[i].string, false, false)
				end 
			end 
			
		else
			guiGridListClear(GUIEditor.gridlist[1])
			guiSetText(GUIEditor.label[3], string.format(exports.AURlanguage:getTranslate("Translate the original text to %s", true), ""))
			guiSetText(GUIEditor.memo[1], "")
			guiSetText(GUIEditor.memo[2], "")
			guiSetText(GUIEditor.memo[3], "")
			elementsCreated["currentversion"] = 0
			elementsCreated["linkedTo"] = 0
		end 
	end, false)
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
		  if row >= 0 and col >= 0 then 
			for i=1, #databaseTable do
				if (databaseTable[i].string == guiGridListGetItemText(source, row, 1) and databaseTable[i].language == "ORIGINAL" and databaseTable[i].type == "ORIGINAL" and databaseTable[i].contributor == "AURORARPG" and databaseTable[i].linkedTo == 0) then
					guiSetText(GUIEditor.memo[1], "")
					guiSetText(GUIEditor.memo[2], "")
					guiSetText(GUIEditor.memo[3], "")
					elementsCreated["linkedTo"] = 0
					elementsCreated["currentversion"] = 0
					guiSetText(GUIEditor.memo[1], databaseTable[i].string)
					local item = guiComboBoxGetSelected (GUIEditor.combobox[1])
					local text = tostring (guiComboBoxGetItemText (GUIEditor.combobox[1] , item))
					guiSetText(GUIEditor.label[3], string.format(exports.AURlanguage:getTranslate("Translate the original text to %s", true), text))
					elementsCreated["linkedTo"] = databaseTable[i].id
					for z=1, #databaseTable do
						if (databaseTable[z].linkedTo == databaseTable[i].id and databaseTable[z].language == text and databaseTable[z].contributor ~= "AURORARPG" and databaseTable[z].type == "new") then 
							guiSetText(GUIEditor.memo[2], databaseTable[z].string)
						end
						if (databaseTable[z].linkedTo == databaseTable[i].id and databaseTable[z].language == text and databaseTable[z].contributor ~= "AURORARPG" and (databaseTable[z].type == "edited" or databaseTable[z].type == "new")) then 
							if (databaseTable[z].version == 1.0) then 
								guiSetText(GUIEditor.memo[3], guiGetText(GUIEditor.memo[3]).."Created by "..databaseTable[z].contributor_name.."("..databaseTable[z].contributor..") on "..databaseTable[z].date.." [VERSION: "..databaseTable[z].version.."]\n")
								elementsCreated["currentversion"] = databaseTable[z].version
							else
								guiSetText(GUIEditor.memo[3], guiGetText(GUIEditor.memo[3]).."Edited by "..databaseTable[z].contributor_name.."("..databaseTable[z].contributor..") on "..databaseTable[z].date.." [VERSION: "..databaseTable[z].version.."]\n")
								elementsCreated["currentversion"] = databaseTable[z].version
							end 
							
						end
					end 
					
					return 
				end 
			end
				guiSetText(GUIEditor.label[3], string.format(exports.AURlanguage:getTranslate("Translate the original text to %s", true), ""))
				guiSetText(GUIEditor.memo[1], "")
				guiSetText(GUIEditor.memo[2], "")
				guiSetText(GUIEditor.memo[3], "")
				elementsCreated["currentversion"] = 0
				elementsCreated["linkedTo"] = 0
			else
				guiSetText(GUIEditor.label[3], string.format(exports.AURlanguage:getTranslate("Translate the original text to %s", true), ""))
				guiSetText(GUIEditor.memo[1], "")
				guiSetText(GUIEditor.memo[2], "")
				guiSetText(GUIEditor.memo[3], "")
				elementsCreated["currentversion"] = 0
				elementsCreated["linkedTo"] = 0
		  end 
	end, false) 
	
	elementsCreated["antispam_contri"] = setTimer(function () killTimer(elementsCreated["antispam_contri"]) end, 3000, 1)
end

function openLanguageContributorAdmin ()
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
		showCursor(false)
		if (isTimer(elementsCreated["timer2"])) then killTimer(elementsCreated["timer2"]) end
		databaseTable = {}
		elementsCreated["currentID"] = 0
		elementsCreated["currentversion"] = 0
		elementsCreated["linkedTo"] = 0
		elementsCreated["oldIDSeen"] = 0
		return 
	end
	if (isTimer(elementsCreated["antispam_contri"])) then 
		exports.NGCdxmsg:createNewDxMessage("The language contributor interace was unable to open or close because you were flooding the command/button.",255,0,0)
		return 
	end 
	if (getTeamName(getPlayerTeam(getLocalPlayer())) ~= "Staff") then return end
	GUIEditor.window[2] = guiCreateWindow((screenW - 938) / 2, (screenH - 480) / 2, 938, 480, "AuroraRPG - Admin Language Contributor", false)
	guiWindowSetSizable(GUIEditor.window[2], false)
	GUIEditor.label[6] = guiCreateLabel(9, 36, 111, 15, "Choose a language:", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[6], "default-bold-small")
	GUIEditor.combobox[2] = guiCreateComboBox(125, 32, 205, 148, "", false, GUIEditor.window[2])
	guiComboBoxAddItem(GUIEditor.combobox[2], exports.AURlanguage:getTranslate("Select a language", true))
	guiComboBoxSetSelected(GUIEditor.combobox[2], 0)
	GUIEditor.gridlist[2] = guiCreateGridList(9, 60, 321, 408, false, GUIEditor.window[2])
	guiGridListAddColumn(GUIEditor.gridlist[2], "Submited by", 0.5)
	guiGridListAddColumn(GUIEditor.gridlist[2], "Submited Text", 0.5)
	GUIEditor.label[7] = guiCreateLabel(340, 35, 111, 15, "Original Text:", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[7], "default-bold-small")
	GUIEditor.memo[4] = guiCreateMemo(336, 55, 595, 81, "", false, GUIEditor.window[2])
	guiMemoSetReadOnly(GUIEditor.memo[4], true)
	GUIEditor.label[8] = guiCreateLabel(340, 146, 111, 15, "Submited Text:", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[8], "default-bold-small")
	GUIEditor.memo[5] = guiCreateMemo(338, 166, 593, 81, "", false, GUIEditor.window[2])
	guiMemoSetReadOnly(GUIEditor.memo[5], true)
	GUIEditor.label[9] = guiCreateLabel(336, 372, 585, 15, "Submited by: ", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[9], "default-bold-small")
	GUIEditor.label[10] = guiCreateLabel(336, 407, 585, 15, "Date Submited: ", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[10], "default-bold-small")
	GUIEditor.button[3] = guiCreateButton(398, 437, 140, 31, "Approve Submisson", false, GUIEditor.window[2])
	GUIEditor.button[4] = guiCreateButton(548, 437, 140, 31, "Deny Submisson", false, GUIEditor.window[2])
	GUIEditor.button[5] = guiCreateButton(698, 437, 140, 31, "Close", false, GUIEditor.window[2])
	GUIEditor.label[11] = guiCreateLabel(338, 257, 144, 15, "Already Translated Text:", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[11], "default-bold-small")
	GUIEditor.memo[6] = guiCreateMemo(338, 276, 593, 81, "", false, GUIEditor.window[2])
	guiMemoSetReadOnly(GUIEditor.memo[6], true)    
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	elementsCreated["timer2"] = setTimer(function()
		if (isElement(GUIEditor.window[2])) then 
			if (not isCursorShowing()) then
				showCursor(true)
			end 
		end
	end, 500, 0)
	
	triggerServerEvent ("AURlanguage.getLanguageTable", resourceRoot, getLocalPlayer(), false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[5], function()
		openLanguageContributorAdmin()
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[3], function()
		triggerServerEvent ("AURlanguage.sendSubmission", resourceRoot, getLocalPlayer(), "approve", elementsCreated["currentID"], elementsCreated["oldIDSeen"], elementsCreated["acccName"])
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[4], function()
		triggerServerEvent ("AURlanguage.sendSubmission", resourceRoot, getLocalPlayer(), "deny", elementsCreated["currentID"], elementsCreated["oldIDSeen"], elementsCreated["acccName"])
	end, false)
	
	
	addEventHandler ("onClientGUIComboBoxAccepted", GUIEditor.combobox[2], function (comboBox)
		local item = guiComboBoxGetSelected (comboBox)
		local text = tostring (guiComboBoxGetItemText (comboBox , item))
		if (text ~= "Choose a language: ") then 
			guiGridListClear(GUIEditor.gridlist[2])
			guiSetText(GUIEditor.memo[4], "")
			guiSetText(GUIEditor.memo[5], "")
			guiSetText(GUIEditor.memo[6], "")
			guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), ""))
			guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), ""))
			elementsCreated["currentID"] = 0
			elementsCreated["oldIDSeen"] = 0
			elementsCreated["acccName"] = ""
			for i=1, #databaseTable do 
				if (databaseTable[i].language == text and databaseTable[i].type == "submited" and databaseTable[i].contributor ~= "AURORARPG") then 
					local row = guiGridListAddRow(GUIEditor.gridlist[2])
					guiGridListSetItemText(GUIEditor.gridlist[2], row, 1, databaseTable[i].contributor, false, false)
					guiGridListSetItemText(GUIEditor.gridlist[2], row, 2, databaseTable[i].string, false, false)
				end 
			end 
			
		else
			guiGridListClear(GUIEditor.gridlist[2])
			guiSetText(GUIEditor.memo[4], "")
			guiSetText(GUIEditor.memo[5], "")
			guiSetText(GUIEditor.memo[6], "")
			guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), ""))
			guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), ""))
			elementsCreated["currentID"] = 0
			elementsCreated["acccName"] = ""
			elementsCreated["oldIDSeen"] = 0
		end 
		
	end, false)
	
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[2], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
		  if row >= 0 and col >= 0 then 
			for i=1, #databaseTable do
				local item = guiComboBoxGetSelected (GUIEditor.combobox[2])
				local text = tostring (guiComboBoxGetItemText (GUIEditor.combobox[2] , item))
				if (databaseTable[i].string == guiGridListGetItemText(source, row, 2) and databaseTable[i].language == text and databaseTable[i].type == "submited" and databaseTable[i].contributor ~= "AURORARPG" and databaseTable[i].linkedTo ~= 0) then
					guiSetText(GUIEditor.memo[4], "")
					guiSetText(GUIEditor.memo[5], "")
					guiSetText(GUIEditor.memo[6], "")
					guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), ""))
					guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), ""))
					elementsCreated["currentID"] = 0
					elementsCreated["oldIDSeen"] = 0
					elementsCreated["acccName"] = ""
					for n=1, #databaseTable do
						if (databaseTable[n].id == databaseTable[i].linkedTo) then 
							guiSetText(GUIEditor.memo[4], databaseTable[n].string)
						end 
					end 
					guiSetText(GUIEditor.memo[5], databaseTable[i].string)
					guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), databaseTable[i].contributor_name.." ("..databaseTable[i].contributor..")"))
					guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), databaseTable[i].date))
					elementsCreated["currentID"] = databaseTable[i].id
					elementsCreated["acccName"] = databaseTable[i].contributor
					local item = guiComboBoxGetSelected (GUIEditor.combobox[2])
					local text = tostring (guiComboBoxGetItemText (GUIEditor.combobox[2] , item))
						for z=1, #databaseTable do
							if (databaseTable[z].linkedTo == databaseTable[i].linkedTo and databaseTable[z].language == text and databaseTable[z].contributor ~= "AURORARPG" and databaseTable[z].type == "new") then 
								elementsCreated["oldIDSeen"] = databaseTable[z].id
								guiSetText(GUIEditor.memo[6], databaseTable[z].string)
							end
						end 
					return 
				end 
			end
				guiSetText(GUIEditor.memo[4], "")
				guiSetText(GUIEditor.memo[5], "")
				guiSetText(GUIEditor.memo[6], "")
				elementsCreated["currentID"] = 0
				elementsCreated["acccName"] = ""
				elementsCreated["oldIDSeen"] = 0
				guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), ""))
				guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), ""))
			else
				guiSetText(GUIEditor.memo[4], "")
				guiSetText(GUIEditor.memo[5], "")
				guiSetText(GUIEditor.memo[6], "")
				elementsCreated["currentID"] = 0
				elementsCreated["oldIDSeen"] = 0
				elementsCreated["acccName"] = ""
				guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), ""))
				guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), ""))
		  end 
	end, false) 
	
	elementsCreated["antispam_contri"] = setTimer(function () killTimer(elementsCreated["antispam_contri"]) end, 3000, 1)
end 

addCommandHandler("contribute", openLanguageContributor)
addCommandHandler("conadmin", openLanguageContributorAdmin)


function updateTables (theNewTable, newLocalizations, resume)
	databaseTable = theNewTable
	localizations = newLocalizations
	if (resume == true) then 
		if (isElement(GUIEditor.window[2])) then 
			guiGridListClear(GUIEditor.gridlist[2])
			guiSetText(GUIEditor.memo[4], "")
			guiSetText(GUIEditor.memo[5], "")
			guiSetText(GUIEditor.memo[6], "")
			guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), ""))
			guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), ""))
			local item = guiComboBoxGetSelected(GUIEditor.combobox[2])
			local text = tostring(guiComboBoxGetItemText (GUIEditor.combobox[2] , item))
			for i=1, #databaseTable do 
				if (databaseTable[i].language == text and databaseTable[i].type == "submited" and databaseTable[i].contributor ~= "AURORARPG") then 
					local row = guiGridListAddRow(GUIEditor.gridlist[2])
					guiGridListSetItemText(GUIEditor.gridlist[2], row, 1, databaseTable[i].contributor, false, false)
					guiGridListSetItemText(GUIEditor.gridlist[2], row, 2, databaseTable[i].string, false, false)
				end 
			end 
		end 
	else
		if (isElement(GUIEditor.window[1])) then 
			guiSetText(GUIEditor.label[3], string.format(exports.AURlanguage:getTranslate("Translate the original text to %s", true), ""))
			guiSetText(GUIEditor.memo[1], "")
			guiSetText(GUIEditor.memo[2], "")
			guiSetText(GUIEditor.memo[3], "")
			guiComboBoxClear (GUIEditor.combobox[1])
			guiGridListClear(GUIEditor.gridlist[1])
			guiComboBoxAddItem(GUIEditor.combobox[1], exports.AURlanguage:getTranslate("Select a language", true))
			guiComboBoxSetSelected(GUIEditor.combobox[1], 0)
			for i=1, #localizations do 
				guiComboBoxAddItem(GUIEditor.combobox[1], localizations[i])
			end
		end 
		if (isElement(GUIEditor.window[2])) then 
			guiGridListClear(GUIEditor.gridlist[2])
			guiSetText(GUIEditor.memo[4], "")
			guiSetText(GUIEditor.memo[5], "")
			guiSetText(GUIEditor.memo[6], "")
			guiSetText(GUIEditor.label[9], string.format(exports.AURlanguage:getTranslate("Submited by: %s", true), ""))
			guiSetText(GUIEditor.label[10], string.format(exports.AURlanguage:getTranslate("Date Submited: %s", true), ""))
			guiComboBoxClear (GUIEditor.combobox[2])
			guiComboBoxAddItem(GUIEditor.combobox[2], exports.AURlanguage:getTranslate("Select a language", true))
			guiComboBoxSetSelected(GUIEditor.combobox[2], 0)
			for i=1, #localizations do 
				guiComboBoxAddItem(GUIEditor.combobox[2], localizations[i])
			end
		end 
	end
	elementsCreated["currentID"] = 0
	elementsCreated["currentversion"] = 0
	elementsCreated["linkedTo"] = 0
	elementsCreated["oldIDSeen"] = 0
	elementsCreated["acccName"] = ""
end
addEvent("AURlanguage.updateTables", true)
addEventHandler("AURlanguage.updateTables", localPlayer, updateTables)

if (fileExists("interface.lua")) then fileDelete("interface.lua") end