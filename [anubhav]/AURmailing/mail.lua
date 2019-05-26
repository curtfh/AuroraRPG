local screenW, screenH = guiGetScreenSize()
local mailsCache = {}

function createMailingSystem()
	if (mailingWindow) then
		return true
	end
	-- MAIN WINDOW
	-- Window
	mailingWindow = guiCreateWindow((screenW - 919) / 2, (screenH - 542) / 2, 919, 542, "Aurora Mailing System", false)
	guiWindowSetSizable(mailingWindow, false)
	guiSetVisible(mailingWindow, false)
	-- Gridlist
	mailingGridlist = guiCreateGridList(12, 31, 897, 391, false, mailingWindow)
	guiGridListAddColumn(mailingGridlist, "Mail ID", 0.1)
	guiGridListAddColumn(mailingGridlist, "Date", 0.2)
	guiGridListAddColumn(mailingGridlist, "Title", 0.4)
	guiGridListAddColumn(mailingGridlist, "", 0.25)
	-- Buttons
	closeMailingWindowBtn = guiCreateButton(12, 488, 897, 44, "Close", false, mailingWindow)
	guiSetProperty(closeMailingWindowBtn , "NormalTextColour", "FFAAAAAA")
	viewMailBtn = guiCreateButton(10, 432, 203, 46, "View", false, mailingWindow)
	guiSetProperty(viewMailBtn, "NormalTextColour", "FFAAAAAA")
	composeMailBtn = guiCreateButton(359, 432, 203, 46, "Compose", false, mailingWindow)
	guiSetProperty(composeMailBtn, "NormalTextColour", "FFAAAAAA")
	deleteMailBtn = guiCreateButton(706, 432, 203, 46, "Delete", false, mailingWindow)
	guiSetProperty(deleteMailBtn, "NormalTextColour", "FFAAAAAA")
	-- Event Handlers
	addEventHandler("onClientGUIClick", closeMailingWindowBtn, closeMailingSystem, false)
	addEventHandler("onClientGUIClick", viewMailBtn, viewMail, false)
	addEventHandler("onClientGUIDoubleClick", mailingGridlist, viewMail, false)
	addEventHandler("onClientGUIClick", composeMailBtn, composeMail, false)
	addEventHandler("onClientGUIClick", deleteMailBtn, deleteEmail, false)
	-- VIEW BUTTON
	-- Window
	viewMailWindow = guiCreateWindow((screenW - 548) / 2, (screenH - 510) / 2, 548, 510, "Viewing mail", false)
	guiWindowSetSizable(viewMailWindow, false)
	guiSetVisible(viewMailWindow, false)
	-- Label
	viewingMailInfoLabel = guiCreateLabel(10, 35, 527, 65, "Subject: t\n\nSender: \n\nDate: ", false, viewMailWindow)
	guiSetFont(viewingMailInfoLabel, "default-bold-small")
	guiLabelSetHorizontalAlign(viewingMailInfoLabel, "left", true)
	-- Memos
	viewingMailDescription = guiCreateMemo(10, 110, 528, 281, "", false, viewMailWindow)
	guiMemoSetReadOnly(viewingMailDescription, true)
	-- Buttons
	replyBtn = guiCreateButton(10, 401, 145, 45, "Reply", false, viewMailWindow)
	guiSetProperty(replyBtn, "NormalTextColour", "FFAAAAAA")
	deleteViewMailBtn = guiCreateButton(202, 401, 145, 45, "Delete", false, viewMailWindow)
	guiSetProperty(deleteViewMailBtn, "NormalTextColour", "FFAAAAAA")
	forwardMailBtn = guiCreateButton(393, 401, 145, 45, "Forward", false, viewMailWindow)
	guiSetProperty(forwardMailBtn, "NormalTextColour", "FFAAAAAA")
	backMailBtn = guiCreateButton(10, 460, 527, 40, "Back", false, viewMailWindow)
	guiSetProperty(backMailBtn, "NormalTextColour", "FFAAAAAA")
	-- Event Handlers
	addEventHandler("onClientGUIClick", replyBtn, replyToMail, false)
	addEventHandler("onClientGUIClick", deleteViewMailBtn, deleteEmail, false)
	addEventHandler("onClientGUIClick", forwardMailBtn, forwardMail, false)
	addEventHandler("onClientGUIClick", backMailBtn, returnToMainMailingSystem, false)
	-- COMPOSE BUTTON
	-- Window
	composeWindow = guiCreateWindow((screenW - 487) / 2, (screenH - 543) / 2, 487, 543, "Compose mail", false)
	guiWindowSetSizable(composeWindow, false)
	guiSetVisible(composeWindow, false)
	-- Labels
	composeLabel = guiCreateLabel(10, 41, 77, 16, "Compose to:", false, composeWindow)
	guiSetFont(composeLabel, "default-bold-small")
	guiLabelSetHorizontalAlign(composeLabel, "left", true)
	composeDetailLabel = guiCreateLabel(27, 78, 446, 48, "Enter full player name (if online, it'll be sent, account name is prioritized first) or full player account name. To send to multiple people, seperate it with a comma, i.e: \"curt,smiler\"", false, composeWindow)
	guiLabelSetHorizontalAlign(composeDetailLabel, "left", true)
	subjectLabel = guiCreateLabel(10, 134, 77, 16, "Subject:", false, composeWindow)
	guiSetFont(subjectLabel, "default-bold-small")
	guiLabelSetHorizontalAlign(subjectLabel, "left", true)
	messageLabel = guiCreateLabel(10, 195, 77, 16, "Message:", false, composeWindow)
	guiSetFont(messageLabel, "default-bold-small")
	guiLabelSetHorizontalAlign(messageLabel, "left", true)
	-- Edits
	composeToEdit = guiCreateEdit(114, 35, 212, 27, "", false, composeWindow)
	subjectEdit = guiCreateEdit(114, 126, 212, 27, "", false, composeWindow)
	-- Memos
	messageMemo = guiCreateMemo(10, 225, 467, 236, "", false, composeWindow)
	-- Buttons
	backToMainFromComposeBtn = guiCreateButton(9, 504, 468, 29, "Back", false, composeWindow)
	guiSetProperty(backToMainFromComposeBtn, "NormalTextColour", "FFAAAAAA")
	composeMailMainBtn = guiCreateButton(9, 471, 468, 29, "Compose", false, composeWindow)
	guiSetProperty(composeMailMainBtn, "NormalTextColour", "FFAAAAAA")
	-- Event Handlers
	addEventHandler("onClientGUIClick", composeMailMainBtn, composeRealMail, false)
	addEventHandler("onClientGUIClick", backToMainFromComposeBtn, returnToMainMailingSystem, false)
	-- CONFIRM WINDOW (DELETE WINDOW)
	-- Window
	confirmDeleteWindow = guiCreateWindow((screenW - 612) / 2, (screenH - 294) / 2, 612, 294, "Are you sure you want to delete this e-mail?", false)
	guiWindowSetSizable(confirmDeleteWindow, false)
	-- Buttons
	confirmBtn = guiCreateButton(14, 246, 286, 38, "Confirm", false, confirmDeleteWindow)
	guiSetProperty(confirmBtn, "NormalTextColour", "FFAAAAAA")
	closeConfirmWindowBtn = guiCreateButton(316, 246, 286, 38, "Close", false, confirmDeleteWindow)
	guiSetProperty(closeConfirmWindowBtn, "NormalTextColour", "FFAAAAAA")
	-- Label
	confirmWindowLbl = guiCreateLabel(14, 45, 588, 191, "Deleting this e-mail ('') means that it will be lost forever (a long time!). \n\nAre you sure you want to delete this e-mail?", false, confirmDeleteWindow)
	guiSetFont(confirmWindowLbl, "default-bold-small")
	guiLabelSetHorizontalAlign(confirmWindowLbl, "center", false)
	guiLabelSetVerticalAlign(confirmWindowLbl, "center")
	-- Event Handlers
	addEventHandler("onClientGUIClick", closeConfirmWindowBtn, returnToMainMailingSystem, false)
	addEventHandler("onClientGUIClick", confirmBtn, confirmDelete, false)
end

function composeMail(btn)
	if (btn ~= "left") then
		return false
	end
	guiSetText(composeToEdit, "")
	guiSetText(subjectEdit, "")
	guiSetText(messageMemo, "")
	guiSetVisible(mailingWindow, false)
	guiSetVisible(composeWindow, true)
end

function replyToMail(btn)
	if (btn ~= "left") then
		return false
	end
	local r, c = guiGridListGetSelectedItem(mailingGridlist)
	if (r == -1) then
		outputChatBox("Please select a mail.", 255, 0, 0)
		return false
	end
	local id = guiGridListGetItemText(mailingGridlist, r, 1)
	local found = false
	for i, v in ipairs(mailsCacheSent) do
		if (v.mailID == tonumber(id)) then
			sender = v.senders
			receivers = v.receivers
			found = true
			break
		end
	end
	guiSetVisible(mailingWindow, false)
	guiSetVisible(viewMailWindow, false)
	guiSetVisible(composeWindow, true)
	guiSetText(subjectEdit, "Re: "..(split(guiGetText(viewingMailInfoLabel), "\n\n")[1]:gsub("Subject: ", "")))
	if (not found) then
		guiSetText(composeToEdit, split(split(guiGetText(viewingMailInfoLabel), "\n\n")[2], "|" )[1]:gsub("Sender: ", ""):sub(1, -2))
	else
		guiSetText(composeToEdit, receivers)
	end
end

function deleteEmail(btn)
	if (btn ~= "left") then
		return false
	end
	local r, c = guiGridListGetSelectedItem(mailingGridlist)
	if (r == -1) then
		outputChatBox("Please select a mail.", 255, 0, 0)
		return false
	end
	local id = guiGridListGetItemText(mailingGridlist, r, 1)
	local found = false
	for i, v in ipairs(mailsCache) do
		if (v.mailID == tonumber(id)) then
			guiSetText(confirmWindowLbl, "Deleting this e-mail ('"..v.title.."' by "..v.sender..") means that it will be lost forever (a long time!). \n\nAre you sure you want to delete this e-mail?")
			found = true
			break
		end
	end
	if (not found) then
		outputChatBox("You either cannot delete this e-mail, or no details about this e-mail was found.", 255, 0, 0)
		return false
	end
	guiSetVisible(mailingWindow, false)
	guiSetVisible(viewMailWindow, false)
	guiSetVisible(confirmDeleteWindow, true)
end

function confirmDelete(btn)
	if (btn ~= "left") then
		return false
	end
	local r, c = guiGridListGetSelectedItem(mailingGridlist)
	if (r == -1) then
		outputChatBox("Please select a mail first.", 255, 0, 0)
		return false
	end
	local id = guiGridListGetItemText(mailingGridlist, r, 1)
	triggerServerEvent("AURmailingSystem.deleteMail", resourceRoot, tonumber(id))
	returnToMainMailingSystem("left")
end

function forwardMail(btn)
	if (btn ~= "left") then
		return false
	end
	local fwd = (split(guiGetText(viewingMailInfoLabel), "\n\n")[1]:gsub("Subject: ", ""))
	guiSetVisible(mailingWindow, false)
	guiSetVisible(viewMailWindow, false)
	guiSetVisible(composeWindow, true)
	guiSetText(messageMemo, guiGetText(viewingMailDescription))
	guiSetText(composeToEdit, "")
	guiSetText(subjectEdit, "Fwd: "..fwd)
end

function viewMail(btn)
	if (btn ~= "left") then
		return false
	end
	local r, c = guiGridListGetSelectedItem(mailingGridlist)
	if (r == -1) then
		outputChatBox("Please select a mail.", 255, 0, 0)
		return false
	end
	local id = guiGridListGetItemText(mailingGridlist, r, 1)
	local found = false
	for i, v in ipairs(mailsCache) do
		if (v.mailID == tonumber(id)) then
			guiSetText(viewingMailInfoLabel, "Subject: "..v.title.."\n\nSender: "..v.sender.." | Sent To: "..v.receivers.."\n\nDate: "..v.date)
			guiSetText(viewingMailDescription, v.description)
			if (not isEmailRead(accountName, v)) then
				triggerServerEvent("AURmailingSystem.readMail", resourceRoot, v.mailID)
			end
			found = true
			break
		end
	end
	if (not found) then
		for i, v in ipairs(mailsCacheSent) do
			if (v.mailID == tonumber(id)) then
				guiSetText(viewingMailInfoLabel, "Subject: "..v.title.."\n\nSender: "..v.sender.." | Sent To: "..v.receivers.."\n\nDate: "..v.date)
				guiSetText(viewingMailDescription, v.description)
				found = true
				break
			end
		end
		if (not found) then
			outputChatBox("Cannot find e-mail details.", 255, 0, 0)
			return false
		end
	end
	guiSetVisible(mailingWindow, false)
	guiSetVisible(viewMailWindow, true)
end

function composeRealMail(btn)
	if (btn ~= "left") then
		return false
	end
	local subject = guiGetText(subjectEdit)
	local desc = guiGetText(messageMemo)
	local sendTo = guiGetText(composeToEdit)
	if (subject == "" or desc == "") then
		outputChatBox("One field was not filled.", 255, 0, 0)
		return false
	end
	triggerServerEvent("AURmailingSystem.composeEmail", resourceRoot, sendTo, subject, desc)
end

function closeMailingSystem(btn)
	if (btn ~= "left") then
		return false
	end
	guiSetVisible(mailingWindow, false)
	guiSetVisible(viewMailWindow, false)
	guiSetVisible(composeWindow, false)
	guiSetVisible(confirmDeleteWindow, false)
	showCursor(false)
end

function returnToMainMailingSystem(btn)
	if (btn ~= "left") then
		return false
	end
	guiSetVisible(viewMailWindow, false)
	guiSetVisible(composeWindow, false)
	guiSetVisible(confirmDeleteWindow, false)
	guiSetVisible(mailingWindow, true)
end

function isEmailRead(acc, emailObj)
	local read = emailObj.readBy
	if (read == "" or (not read:find(",") and read ~= acc)) then
		return false
	end
	local read = split(read, ",")
	for i, v in ipairs(read) do
		if (v == acc) then
			return true
		end
	end
	return false
end

function openMailingWindow(mails, mailsSent, acc, updateOnly)
	if (not mailingWindow) then
		createMailingSystem()
	end
	guiSetInputMode("no_binds_when_editing")
	accountName = acc
	mailsCache = mails
	mailsCacheSent = mailsSent
	if (not updateOnly) then
		closeMailingSystem("left")
		local vis = (not guiGetVisible(mailingWindow))
		showCursor(vis)
		guiSetVisible(mailingWindow, vis)
	end
	local selectedGrid = guiGridListGetSelectedItem(mailingGridlist)
	local checkMailID = false
	if (selectedGrid ~= -1) then
		checkMailID = tonumber(guiGridListGetItemText(mailingGridlist, selectedGrid, 1))
	end
	guiGridListClear(mailingGridlist)
	local row = guiGridListAddRow(mailingGridlist)
	guiGridListSetItemText(mailingGridlist, row, 1, "Received", true, false)
	guiGridListSetItemText(mailingGridlist, row, 4, "Sender", true, false)
	for i, v in ipairs(mails) do
		local read = isEmailRead(acc, v)
		local r, g, b = 0, 255, 0
		if (read) then
			r = 255
			g = 0
		end
		local row = guiGridListAddRow(mailingGridlist, v.mailID, v.date, v.title, v.sender)
		guiGridListSetItemColor(mailingGridlist, row, 1, r, g, b)
		guiGridListSetItemColor(mailingGridlist, row, 2, r, g, b)
		guiGridListSetItemColor(mailingGridlist, row, 3, r, g, b)
		guiGridListSetItemColor(mailingGridlist, row, 4, r, g, b)
		if (checkMailID and tonumber(v.mailID) == tonumber(checkMailID)) then
			setTimer(guiGridListSetSelectedItem, 500, 1, mailingGridlist, row, 1)
		end
	end
	local row = guiGridListAddRow(mailingGridlist)
	guiGridListSetItemText(mailingGridlist, row, 1, "Sent", true, false)
	guiGridListSetItemText(mailingGridlist, row, 4, "Sent To", true, false)
	for i, v in ipairs(mailsSent) do
		local r, g, b = 255, 255, 0
		local row = guiGridListAddRow(mailingGridlist, v.mailID, v.date, v.title, v.receivers:gsub(",", ", "))
		guiGridListSetItemColor(mailingGridlist, row, 1, r, g, b)
		guiGridListSetItemColor(mailingGridlist, row, 2, r, g, b)
		guiGridListSetItemColor(mailingGridlist, row, 3, r, g, b)
		guiGridListSetItemColor(mailingGridlist, row, 4, r, g, b)
		if (checkMailID and tonumber(v.mailID) == tonumber(checkMailID)) then
			setTimer(guiGridListSetSelectedItem, 500, 1, mailingGridlist, row, 1)
		end
	end
end
addEvent("AURmailingSystem.windowToggle", true)
addEventHandler("AURmailingSystem.windowToggle", localPlayer, openMailingWindow)

if (fileExists("mail.lua")) then
	fileDelete("mail.lua")
end