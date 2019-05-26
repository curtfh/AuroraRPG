local sx, sy = guiGetScreenSize()
local sx = sx/1366
local sy = sy/768
local choice = 1
local isBankingShowing = false
local isPinShowing = false
local GUIEditor = {}
local tab = {}
local balance
local antiSpam
local playerPin

function refreshTransactionGrid()
	guiGridListClear(GUIEditor[1])
	for k, v in ipairs(tab) do
		local row = guiGridListAddRow (GUIEditor[1])
		guiGridListSetItemText(GUIEditor[1], row, 1, v["datum"], false, false)
		guiGridListSetItemText(GUIEditor[1], row, 2, v["transaction"], false, false)
	end
end

function initTransactionsElements()
	if (isElement(GUIEditor[2])) or (isElement(GUIEditor[1])) then
		destroyTransactionsElements()
	else
		showCursor(true)
		GUIEditor[2] = guiCreateEdit(sx*366, sy*515, sx*421, sy*31, "", false)
		editText = ""
		GUIEditor[1] = guiCreateGridList(sx*364, sy*325, sx*639, sy*178, false)
		guiGridListAddColumn(GUIEditor[1], "Date:", 0.3)
		guiGridListAddColumn(GUIEditor[1], "Text:", 0.6)  
		refreshTransactionGrid()
	end
end

addEventHandler("onClientGUIChanged", root, function(elem)
	if (elem == GUIEditor[2]) then
		if ((tonumber(guiGetText(elem))) and (tonumber(guiGetText(elem)) > 0)) or (guiGetText(elem) == "") then
			editText = guiGetText(elem)
		else
			guiSetText(elem, editText)
		end
	end
end)

function initPinElements()
	if (isElement(GUIEditor[5])) then 
		destroyElement(GUIEditor[5])
	else
		showCursor(true)
		GUIEditor[5] = guiCreateEdit(sx*441, sy*412, sx*242, sy*43, "", false)
	end
end

function destroyTransactionsElements()
	if (isElement(GUIEditor[2])) then destroyElement(GUIEditor[2]) end
	if (isElement(GUIEditor[1])) then destroyElement(GUIEditor[1]) end
end

function destroyPinElements()
	if (isElement(GUIEditor[5])) then destroyElement(GUIEditor[5]) showCursor(false) end
end

function initOfflineElements()
	if (isElement(GUIEditor[3])) or (isElement(GUIEditor[4])) or (isElement(GUIEditor[6])) then
		destroyOfflineElements()
	else
		showCursor(true)
		GUIEditor[3] = guiCreateEdit(sx*407, sy*357, sx*257, sy*36, "Account Name..", false)
		GUIEditor[4] = guiCreateEdit(sx*407, sy*403, sx*257, sy*36, "Amount..", false) 
		GUIEditor[6] = guiCreateEdit(sx*406, sy*452, sx*258, sy*34, "Change PIN..", false) 
	end
end

function destroyOfflineElements()
	if (isElement(GUIEditor[3])) then destroyElement(GUIEditor[3]) end
	if (isElement(GUIEditor[4])) then destroyElement(GUIEditor[4]) end
	if (isElement(GUIEditor[6])) then destroyElement(GUIEditor[6]) end
end

function destroyAllElements()
	for i=1,#GUIEditor do
		if (isElement(GUIEditor[i])) then
			destroyElement(GUIEditor[i])
			isBankingShowing = false
			showCursor(false)
		end
	end
	choice = 1
end

function initPinWnd()
	dxDrawRectangle(sx*410, sy*296, sx*546, sy*176, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sx*410, sy*296, sx*546, sy*43, tocolor(0, 0, 0, 183), false)
	dxDrawText("Enter your PIN code", sx*408 - 1, sy*296 - 1, sx*956 - 1, sy*339 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Enter your PIN code", sx*408 + 1, sy*296 - 1, sx*956 + 1, sy*339 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Enter your PIN code", sx*408 - 1, sy*296 + 1, sx*956 - 1, sy*339 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Enter your PIN code", sx*408 + 1, sy*296 + 1, sx*956 + 1, sy*339 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Enter your PIN code", sx*408, sy*296, sx*956, sy*339, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Type in your PIN code or 0 if unsure.", sx*413 - 1, sy*345 - 1, sx*950 - 1, sy*388 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
	dxDrawText("Type in your PIN code or 0 if unsure.", sx*413 + 1, sy*345 - 1, sx*950 + 1, sy*388 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
	dxDrawText("Type in your PIN code or 0 if unsure.", sx*413 - 1, sy*345 + 1, sx*950 - 1, sy*388 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
	dxDrawText("Type in your PIN code or 0 if unsure.", sx*413 + 1, sy*345 + 1, sx*950 + 1, sy*388 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
	dxDrawText("Type in your PIN code or 0 if unsure.", sx*413, sy*345, sx*950, sy*388, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
	dxDrawRectangle(sx*708, sy*412, sx*94, sy*43, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sx*841, sy*412, sx*94, sy*43, tocolor(0, 0, 0, 183), false)
	dxDrawText("Submit", sx*708 - 1, sy*412 - 1, sx*802 - 1, sy*455 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Submit", sx*708 + 1, sy*412 - 1, sx*802 + 1, sy*455 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Submit", sx*708 - 1, sy*412 + 1, sx*802 - 1, sy*455 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Submit", sx*708 + 1, sy*412 + 1, sx*802 + 1, sy*455 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Submit", sx*708, sy*412, sx*802, sy*455, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*841 - 1, sy*412 - 1, sx*935 - 1, sy*455 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*841 + 1, sy*412 - 1, sx*935 + 1, sy*455 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*841 - 1, sy*412 + 1, sx*935 - 1, sy*455 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*841 + 1, sy*412 + 1, sx*935 + 1, sy*455 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*841, sy*412, sx*935, sy*455, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function initTransactionsWnd()
	dxDrawRectangle(sx*354, sy*209, sx*659, sy*351, tocolor(2, 2, 2, 183), false)
	dxDrawRectangle(sx*354, sy*209, sx*659, sy*47, tocolor(2, 2, 2, 183), false)
	dxDrawText("Banking", sx*354 - 1, sy*209 - 1, sx*1013 - 1, sy*256 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Banking", sx*354 + 1, sy*209 - 1, sx*1013 + 1, sy*256 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Banking", sx*354 - 1, sy*209 + 1, sx*1013 - 1, sy*256 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Banking", sx*354 + 1, sy*209 + 1, sx*1013 + 1, sy*256 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Banking", sx*354, sy*209, sx*1013, sy*256, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	-- Transactions
	dxDrawRectangle(sx*364, sy*266, sx*103, sy*46, tocolor(2, 2, 2, 183), false)
	dxDrawText("Balance", sx*364 - 1, sy*265 - 1, sx*467 - 1, sy*312 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Balance", sx*364 + 1, sy*265 - 1, sx*467 + 1, sy*312 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Balance", sx*364 - 1, sy*265 + 1, sx*467 - 1, sy*312 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Balance", sx*364 + 1, sy*265 + 1, sx*467 + 1, sy*312 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Balance", sx*364, sy*265, sx*467, sy*312, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	-- Offline transactions
	dxDrawRectangle(sx*477, sy*266, sx*103, sy*46, tocolor(2, 2, 2, 183), false)
	dxDrawText("Manage", sx*477 - 1, sy*265 - 1, sx*580 - 1, sy*312 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Manage", sx*477 + 1, sy*265 - 1, sx*580 + 1, sy*312 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Manage", sx*477 - 1, sy*265 + 1, sx*580 - 1, sy*312 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Manage", sx*477 + 1, sy*265 + 1, sx*580 + 1, sy*312 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Manage", sx*477, sy*265, sx*580, sy*312, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	--Close
	dxDrawRectangle(sx*898, sy*262, sx*103, sy*46, tocolor(2, 2, 2, 183), false)
	dxDrawText("Close", sx*898 - 1, sy*261 - 1, sx*1001 - 1, sy*308 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*898 + 1, sy*261 - 1, sx*1001 + 1, sy*308 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*898 - 1, sy*261 + 1, sx*1001 - 1, sy*308 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*898 + 1, sy*261 + 1, sx*1001 + 1, sy*308 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*898, sy*261, sx*1001, sy*308, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	if (choice == 1) then
		-- Balance
		dxDrawText("Current Balance: $"..exports.server:convertNumber(balance), sx*594 - 1, sy*271 - 1, sx*888 - 1, sy*304 - 1, tocolor(0, 0, 0, 255), 0.8, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("Current Balance: $"..exports.server:convertNumber(balance), sx*594 + 1, sy*271 - 1, sx*888 + 1, sy*304 - 1, tocolor(0, 0, 0, 255), 0.8, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("Current Balance: $"..exports.server:convertNumber(balance), sx*594 - 1, sy*271 + 1, sx*888 - 1, sy*304 + 1, tocolor(0, 0, 0, 255), 0.8, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("Current Balance: $"..exports.server:convertNumber(balance), sx*594 + 1, sy*271 + 1, sx*888 + 1, sy*304 + 1, tocolor(0, 0, 0, 255), 0.8, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("Current Balance: $"..exports.server:convertNumber(balance), sx*594, sy*271, sx*888, sy*304, tocolor(255, 255, 255, 255), 0.8, "pricedown", "left", "center", false, false, false, false, false)
		-- Desposit
		dxDrawRectangle(sx*802, sy*517, sx*78, sy*29, tocolor(2, 2, 2, 183), false)
		dxDrawText("Deposit", sx*802 - 1, sy*517 - 1, sx*880 - 1, sy*546 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Deposit", sx*802 + 1, sy*517 - 1, sx*880 + 1, sy*546 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Deposit", sx*802 - 1, sy*517 + 1, sx*880 - 1, sy*546 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Deposit", sx*802 + 1, sy*517 + 1, sx*880 + 1, sy*546 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Deposit", sx*802, sy*517, sx*880, sy*546, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		-- Withdraw
		dxDrawRectangle(sx*898, sy*517, sx*78, sy*29, tocolor(2, 2, 2, 183), false)
		dxDrawText("Withdraw", sx*(898 - 1), sy*(517 - 1), sx*(976 - 1), sy*546 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Withdraw", sx*(898 + 1), sy*(517 - 1), sx*(976 + 1), sy*546 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Withdraw", sx*(898 - 1), sy*(517 + 1), sx*(976 - 1), sy*546 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Withdraw", sx*(898 + 1), sy*(517 + 1), sx*(976 + 1), sy*546 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Withdraw", sx*898, sy*517, sx*976, sy*546, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
	if (choice == 2) then
		-- Send
		dxDrawRectangle(sx*705, sy*371, sx*103, sy*46, tocolor(2, 2, 2, 183), false)
        dxDrawText("Send", sx*705 - 1, sy*371 - 1, sx*808 - 1, sy*418 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Send", sx*705 + 1, sy*371 - 1, sx*808 + 1, sy*418 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Send", sx*705 - 1, sy*371 + 1, sx*808 - 1, sy*418 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Send", sx*705 + 1, sy*371 + 1, sx*808 + 1, sy*418 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Send", sx*705, sy*371, sx*808, sy*418, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		-- Update PIN
		dxDrawRectangle(sx*706, sy*450, sx*100, sy*36, tocolor(0, 0, 0, 183), false)
		dxDrawText("Update PIN", sx*705 - 1, sy*450 - 1, sx*806 - 1, sy*486 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Update PIN", sx*705 + 1, sy*450 - 1, sx*806 + 1, sy*486 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Update PIN", sx*705 - 1, sy*450 + 1, sx*806 - 1, sy*486 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Update PIN", sx*705 + 1, sy*450 + 1, sx*806 + 1, sy*486 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("Update PIN", sx*705, sy*450, sx*806, sy*486, tocolor(254, 253, 253, 254), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
end

function drawPinWnd(pin, newRes, newBalance)
	balance = tonumber(newBalance)
	tab = newRes
	playerPin = pin
	isPinShowing = true
	addEventHandler("onClientRender", root, initPinWnd)
	initPinElements()
	guiSetInputMode("no_binds_when_editing")
end
addEvent("AURbanking.drawPinWnd", true)
addEventHandler("AURbanking.drawPinWnd", root, drawPinWnd)

function closePinWnd()
	removeEventHandler("onClientRender", root, initPinWnd)
	destroyPinElements()
	isPinShowing = false
	guiSetInputMode("allow_binds")
end
addEvent("AURbanking.closePinWnd", true)
addEventHandler("AURbanking.closePinWnd", root, closePinWnd)

function closePinWnd(button, state, absoluteX, absoluteY)
	if (isPinShowing) and (state == "down") then 
		if ((absoluteX >= sx*841) and (absoluteX <= sx*(841+94)) and (absoluteY >= sy*412) and (absoluteY <= sy*(412+43))) then
			triggerEvent("AURbanking.closePinWnd", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, closePinWnd)

function openBankWnd(button, state, absoluteX, absoluteY)
	if (isPinShowing) and (state == "down") then 
		if ((absoluteX >= sx*708) and (absoluteX <= sx*(708+94)) and (absoluteY >= sy*412) and (absoluteY <= sy*(412+43))) then
			local enteredPin = guiGetText(GUIEditor[5])
			if (tonumber(enteredPin) == tonumber (playerPin)) then
				triggerEvent("AURbanking.closePinWnd", localPlayer)
				triggerEvent("AURbanking.drawTransactionsWnd", localPlayer, tab, balance)
			end
		end
	end
end
addEventHandler("onClientClick", root, openBankWnd)

function drawTransactionsWnd(newRes, newBalance)
	addEventHandler("onClientRender", root, initTransactionsWnd)
	initTransactionsElements()
	isBankingShowing = true
	guiSetInputMode("no_binds_when_editing")
end
addEvent("AURbanking.drawTransactionsWnd", true)
addEventHandler("AURbanking.drawTransactionsWnd", root, drawTransactionsWnd)

function closeTransactionsWnd()
	removeEventHandler("onClientRender", root, initTransactionsWnd)
	destroyAllElements()
	isBankingShowing = false
	guiSetInputMode("allow_binds")
end
addEvent("AURbanking.closeTransactionsWnd", true)
addEventHandler("AURbanking.closeTransactionsWnd", root, closeTransactionsWnd)

function switchTabs(button, state, absoluteX, absoluteY)
	if (isBankingShowing) and (state == "down") then 
		if ((absoluteX >= sx*364) and (absoluteX <= sx*(364+103)) and (absoluteY >= sy*266) and (absoluteY <= sy*(262+46))) then
			choice = 1
			destroyOfflineElements()
			initTransactionsElements()
		end
		if ((absoluteX >= sx*477) and (absoluteX <= sx*(477+103)) and (absoluteY >= sy*266) and (absoluteY <= sy*(262+46))) then
			choice = 2
			destroyTransactionsElements()
			initOfflineElements()
		end
	end
end
addEventHandler("onClientClick", root, switchTabs)

function closeWnd(button, state, absoluteX, absoluteY)
	if (isBankingShowing) and (state == "down") then 
		if ((absoluteX >= sx*898) and (absoluteX <= sx*(898+103)) and (absoluteY >= sy*262) and (absoluteY <= sy*(262+46))) then
			triggerEvent("AURbanking.closeTransactionsWnd", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, closeWnd)

function depositMoney(button, state, absoluteX, absoluteY)
	if (isBankingShowing) and (choice == 1) and(state == "down") then
		if ((absoluteX >= sx*802) and (absoluteX <= sx*(802+78)) and (absoluteY >= sy*517) and (absoluteY <= sy*(517+29))) then
			if (antiSpam and getTickCount() - antiSpam <= 5000) then return false end
			local amount = guiGetText(GUIEditor[2])
			if (amount == "") then return false end
			if not (tonumber(amount)) then return false end
			local amount = tonumber(amount)
			triggerServerEvent("AURbanking.depositMoney", localPlayer, localPlayer, amount)
			setTimer(function()
				refreshTransactionGrid()
			end, 1000, 1)
		end
	end
end
addEventHandler("onClientClick", root, depositMoney)

function withdrawMoney(button, state, absoluteX, absoluteY)
	if (isBankingShowing) and (choice == 1) and(state == "down") then
		if ((absoluteX >= sx*898) and (absoluteX <= sx*(898+78)) and (absoluteY >= sy*517) and (absoluteY <= sy*(517+29))) then
			if (antiSpam and getTickCount() - antiSpam <= 5000) then return false end
			local amount = guiGetText(GUIEditor[2])
			if (amount == "") then return false end
			if not (tonumber(amount)) then return false end
			local amount = tonumber(amount)
			triggerServerEvent("AURbanking.withdrawMoney", localPlayer, localPlayer, amount)
			refreshTransactionGrid()
			setTimer(function()
				refreshTransactionGrid()
			end, 1000, 1)
		end
	end
end
addEventHandler("onClientClick", root, withdrawMoney)

function sendToOfflineAcc(button, state, absoluteX, absoluteY)
	if (isBankingShowing) and (choice == 2) and(state == "down") then
		if ((absoluteX >= sx*705) and (absoluteX <= sx*(705+103)) and (absoluteY >= sy*371) and (absoluteY <= sy*(371+46))) then
			if (antiSpam and getTickCount() - antiSpam <= 5000) then return false end
			local accName = guiGetText(GUIEditor[3])
			local amount = guiGetText(GUIEditor[4])
			if (accName == "") then return false end
			if (amount == "") then return false end
			if not (tonumber(amount)) then return false end
			local amount = tonumber(amount)
			if (amount <= 0) then return false end
			triggerServerEvent("AURbanking.sendToOfflineAcc", localPlayer, localPlayer, accName, amount)
			setTimer(function()
				refreshTransactionGrid()
			end, 1000, 1)
		end
	end
end
addEventHandler("onClientClick", root, sendToOfflineAcc)

function updateAccountPIN(button, state, absoluteX, absoluteY)
	if (isBankingShowing) and (choice == 2) and(state == "down") then
		if ((absoluteX >= sx*706) and (absoluteX <= sx*(706+100)) and (absoluteY >= sy*450) and (absoluteY <= sy*(450+36))) then
			if (antiSpam and getTickCount() - antiSpam <= 5000) then return false end
			local newPin = guiGetText(GUIEditor[6])
			if (newPin == "") then return false end
			if not (tonumber(newPin)) then return false end
			local newPin = tonumber(newPin)
			triggerServerEvent("AURbanking.updateAccountPIN", localPlayer, localPlayer, newPin)
			triggerEvent("AURbanking.closeTransactionsWnd", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, updateAccountPIN)

function changeClientBalance(newBal, text)
	balance = newBal
	local timeTab = getRealTime()
	local str = 1900+timeTab.year.."-"..(string.format("%02d", 1+timeTab.month)).."-"..(string.format("%02d", timeTab.monthday)).." "..(string.format("%02d", timeTab.hour))..":"..(string.format("%02d", timeTab.minute))..":"..(string.format("%02d", timeTab.second))..""
	tab[#tab+1] = {transaction = text, datum = str}
	antiSpam = getTickCount()
end
addEvent("AURbanking.changeClientBalance", true)
addEventHandler("AURbanking.changeClientBalance", root, changeClientBalance)