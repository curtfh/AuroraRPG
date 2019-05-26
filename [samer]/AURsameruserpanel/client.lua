local sx, sy = guiGetScreenSize()
local sx = sx/1366
local sy = sy/768
isUserPanelShowing = false
isStaffMemebersShowing = false
isLastLoginsShowing = false

local staffRanks = {
    [0] = "Help Desk",
    [1] = "Trial Manager",
    [2] = "Manager",
    [3] = "Senior Manager",
    [4] = "Supervising Manager",
    [5] = "Executive Manager",
    [6] = "Community Manager",
	[7] = "AUR Developer",
    [8] = "Community Owner",
    [9] = ""
}

function getNameFromName(rank)
	return staffRanks[rank]
end

function getFromID(accID)
	for k, v in ipairs(getElementsByType("player")) do
		if (exports.server:getPlayerAccountID(v) == tonumber(accID)) then
			return true
		end
	end
	return false
end

function initStaffElements(tab)
	if (isElement(staffGridList)) then
		destroyElement(staffGridList)
	else
		staffGridList = guiCreateGridList(sx*280, sy*169, sx*806, sy*430, false)
		guiGridListAddColumn(staffGridList, "Staff Member:", 0.5)
		guiGridListAddColumn(staffGridList, "Staff Level:", 0.5) 
		for k, v in ipairs(tab) do
			local row = guiGridListAddRow(staffGridList)
			guiGridListSetItemText(staffGridList, row, 1, v.nickname, false, false)
			guiGridListSetItemText(staffGridList, row, 2, getNameFromName(v.rank), false, false)
			if (getFromID(v.userid)) then
				guiGridListSetItemColor(staffGridList, row, 1, 0, 255, 0)
				guiGridListSetItemColor(staffGridList, row, 2, 0, 255, 0)
			else
				guiGridListSetItemColor(staffGridList, row, 1, 255, 0, 0)
				guiGridListSetItemColor(staffGridList, row, 2, 255, 0, 0)
			end				
		end
	end
end

function initLoginsElements(tab)
	if (isElement(loginsGridlist)) then
		destroyElement(loginsGridlist)
	else
		loginsGridlist = guiCreateGridList(sx*280, sy*169, sx*806, sy*430, false)
		guiGridListAddColumn(loginsGridlist, "Date:", 0.3)
		guiGridListAddColumn(loginsGridlist, "Name:", 0.3)
		guiGridListAddColumn(loginsGridlist, "Serial:", 0.5) 
		for k, v in ipairs(tab) do
			local row = guiGridListAddRow(loginsGridlist)
			guiGridListSetItemText(loginsGridlist, row, 1, v.datum, false, false)
			guiGridListSetItemText(loginsGridlist, row, 2, v.nickname, false, false)
			guiGridListSetItemText(loginsGridlist, row, 3, v.serial, false, false)
		end
	end
end

function initLoginsPanel()
	dxDrawRectangle(sx*273, sy*100, sx*821, sy*568, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sx*273, sy*100, sx*821, sy*43, tocolor(0, 0, 0, 183), false)
	dxDrawText("Last Logins Panel", sx*271 - 1, sy*100 - 1, sx*1094 - 1, sy*143 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Last Logins Panel", sx*271 + 1, sy*100 - 1, sx*1094 + 1, sy*143 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Last Logins Panel", sx*271 - 1, sy*100 + 1, sx*1094 - 1, sy*143 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Last Logins Panel", sx*271 + 1, sy*100 + 1, sx*1094 + 1, sy*143 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Last Logins Panel", sx*271, sy*100, sx*1094, sy*143, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(sx*613, sy*613, sx*143, sy*45, tocolor(0, 0, 0, 183), false)
	dxDrawText("Close", sx*613 - 1, sy*613 - 1, sx*756 - 1, sy*658 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613 + 1, sy*613 - 1, sx*756 + 1, sy*658 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613 - 1, sy*613 + 1, sx*756 - 1, sy*658 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613 + 1, sy*613 + 1, sx*756 + 1, sy*658 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613, sy*613, sx*756, sy*658, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function initStaffPanel()
	dxDrawRectangle(sx*273, sy*100, sx*821, sy*568, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sx*273, sy*100, sx*821, sy*43, tocolor(0, 0, 0, 183), false)
	dxDrawText("Staff List", sx*271 - 1, sy*100 - 1, sx*1094 - 1, sy*143 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Staff List", sx*271 + 1, sy*100 - 1, sx*1094 + 1, sy*143 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Staff List", sx*271 - 1, sy*100 + 1, sx*1094 - 1, sy*143 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Staff List", sx*271 + 1, sy*100 + 1, sx*1094 + 1, sy*143 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Staff List", sx*271, sy*100, sx*1094, sy*143, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(sx*613, sy*613, sx*143, sy*45, tocolor(0, 0, 0, 183), false)
	dxDrawText("Close", sx*613 - 1, sy*613 - 1, sx*756 - 1, sy*658 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613 + 1, sy*613 - 1, sx*756 + 1, sy*658 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613 - 1, sy*613 + 1, sx*756 - 1, sy*658 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613 + 1, sy*613 + 1, sx*756 + 1, sy*658 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", sx*613, sy*613, sx*756, sy*658, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function drawStaffPanel(tab)
	if (isStaffMemebersShowing) then
		removeEventHandler("onClientRender", root, initStaffPanel)
		if (isElement(staffGridList)) then destroyElement(staffGridList) end
		isStaffMemebersShowing = false
	else
		addEventHandler("onClientRender", root, initStaffPanel)
		initStaffElements(tab)
		isStaffMemebersShowing = true
		removeEventHandler("onClientRender", root, renderInterpolation)
		removeEventHandler("onClientRender", root, initUserpanel)
		isUserPanelShowing = false
	end
	showCursor(isStaffMemebersShowing)
end
addEvent("AURuserpanel.drawStaffPanel", true)
addEventHandler("AURuserpanel.drawStaffPanel", root, drawStaffPanel)

function drawUpdatesPanel(tab)
	executeCommandHandler("updates")
end
addEvent("AURuserpanel.drawUpdatesPanel", true)
addEventHandler("AURuserpanel.drawUpdatesPanel", root, drawUpdatesPanel)

function drawLoginsPanel(tab)
	if (isLastLoginsShowing) then
		removeEventHandler("onClientRender", root, initLoginsPanel)
		if (isElement(loginsGridlist)) then destroyElement(loginsGridlist) end
		isLastLoginsShowing = false
	else
		addEventHandler("onClientRender", root, initLoginsPanel)
		initLoginsElements(tab)
		isLastLoginsShowing = true
		removeEventHandler("onClientRender", root, renderInterpolation)
		removeEventHandler("onClientRender", root, initUserpanel)
		isUserPanelShowing = false
	end
	showCursor(isLastLoginsShowing)
end
addEvent("AURuserpanel.drawLoginsPanel", true)
addEventHandler("AURuserpanel.drawLoginsPanel", root, drawLoginsPanel)	

function initUserpanel()
	dxDrawRectangle(sx*0, sy*0, sx*1366, sy*(87+pos2), tocolor(0, 0, 0, 183), true)
	dxDrawRectangle(sx*11, sy*pos, sx*182, sy*45, tocolor(0, 0, 0, 183), true)
	dxDrawText("Documentation", sx*10 - 1, sy*pos - 1, sx*193 - 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Documentation", sx*10 + 1, sy*pos - 1, sx*193 + 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Documentation", sx*10 - 1, sy*pos + 1, sx*193 - 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Documentation", sx*10 + 1, sy*pos + 1, sx*193 + 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Documentation", sx*10, sy*pos, sx*193, sy*(45+pos), tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawRectangle(sx*591, sy*pos, sx*182, sy*45, tocolor(0, 0, 0, 183), true)
	dxDrawText("Staff List", sx*591 - 1, sy*pos - 1, sx*773 - 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Staff List", sx*591 + 1, sy*pos - 1, sx*773 + 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Staff List", sx*591 - 1, sy*pos + 1, sx*773 - 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Staff List", sx*591 + 1, sy*pos + 1, sx*773 + 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Staff List", sx*591, sy*pos, sx*773, sy*(45+pos), tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawRectangle(sx*1174, sy*pos, sx*182, sy*45, tocolor(0, 0, 0, 183), true)
	dxDrawText("Updates", sx*1174 - 1, sy*pos - 1, sx*1356 - 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Updates", sx*1174 + 1, sy*pos - 1, sx*1356 + 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Updates", sx*1174 - 1, sy*pos + 1, sx*1356 - 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Updates", sx*1174 + 1, sy*pos + 1, sx*1356 + 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Updates", sx*1174, sy*pos, sx*1356, sy*(45+pos), tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawRectangle(sx*301, sy*pos, sx*182, sy*45, tocolor(0, 0, 0, 183), true)
	dxDrawText("Last Logins", sx*301 - 1, sy*pos - 1, sx*483 - 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Last Logins", sx*301 + 1, sy*pos - 1, sx*483 + 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Last Logins", sx*301 - 1, sy*pos + 1, sx*483 - 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Last Logins", sx*301 + 1, sy*pos + 1, sx*483 + 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Last Logins", sx*301, sy*pos, sx*483, sy*(45+pos), tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawRectangle(sx*0, sy*0, sx*1366, sy*pos3, tocolor(0, 0, 0, 183), true)
	dxDrawText("Welcome to AUR userpanel, "..getPlayerName(localPlayer), sx*0 - 1, sy*0 - 1, sx*1366 - 1, sy*pos3 - 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawText("Welcome to AUR userpanel, "..getPlayerName(localPlayer), sx*0 + 1, sy*0 - 1, sx*1366 + 1, sy*pos3 - 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawText("Welcome to AUR userpanel, "..getPlayerName(localPlayer), sx*0 - 1, sy*0 + 1, sx*1366 - 1, sy*pos3 + 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawText("Welcome to AUR userpanel, "..getPlayerName(localPlayer), sx*0 + 1, sy*0 + 1, sx*1366 + 1, sy*pos3 + 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawText("Welcome to AUR userpanel, "..getPlayerName(localPlayer), sx*0, sy*0, sx*1366, sy*pos3, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawRectangle(sx*883, sy*pos, sx*182, sy*45, tocolor(0, 0, 0, 183), true)
	dxDrawText("Weapon Skills", sx*883 - 1, sy*pos - 1, sx*1065 - 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Weapon Skills", sx*883 + 1, sy*pos - 1, sx*1065 + 1, sy*(45+pos) - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Weapon Skills", sx*883 - 1, sy*pos + 1, sx*1065 - 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Weapon Skills", sx*883 + 1, sy*pos + 1, sx*1065 + 1, sy*(45+pos) + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText("Weapon Skills", sx*883, sy*pos, sx*1065, sy*(45+pos), tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
end

function renderInterpolation()
	local now = getTickCount()
	local duration = 2000
	local elapsed = now - start
	local progress = (now - start) / (duration)
	pos = interpolateBetween(0, 0, 0, 86, 0, 0, progress, "OutBounce")
	pos2 = interpolateBetween(0, 0, 0, 158, 0, 0, progress, "OutBounce")
	pos3 = interpolateBetween(0, 0, 0, 49, 0, 0, progress, "Linear")
	if (now > start + duration) then
		removeEventHandler("onClientRender", root, renderInterpolation)
	end
end 

function renderRect()
	if (isStaffMemebersShowing) or (isUpdatesPanelShowing) or (not exports.server:isPlayerLoggedIn(localPlayer)) then return false end
	if (isUserPanelShowing) then
		removeEventHandler("onClientRender", root, renderInterpolation)
		removeEventHandler("onClientRender", root, initUserpanel)
		isUserPanelShowing = false
	else
		start = getTickCount()
		addEventHandler("onClientRender", root, renderInterpolation)
		addEventHandler("onClientRender", root, initUserpanel)
		isUserPanelShowing = true
	end
	showCursor(isUserPanelShowing)
end
addEvent("AURuserpanel.closeMainPanel", true)
addEventHandler("AURuserpanel.closeMainPanel", root, renderRect)
bindKey("F1", "down", renderRect)

function openRulesWindow(button, state, absoluteX, absoluteY)
	if (isUserPanelShowing) and (state == "down") then 	
		if ((absoluteX >= sx*11) and (absoluteX <= sx*(11+182)) and (absoluteY >= sy*pos) and (absoluteY <= sy*(pos+45))) then
			showCursor(false)
			executeCommandHandler("documentation")
			triggerEvent("AURuserpanel.closeMainPanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, openRulesWindow)

function openUpdatesWindow(button, state, absoluteX, absoluteY)
	if (isUserPanelShowing) and (state == "down") then 
		if ((absoluteX >= sx*1174) and (absoluteX <= sx*(1174+182)) and (absoluteY >= sy*pos) and (absoluteY <= sy*(pos+45))) then
			showCursor(false)
			triggerEvent("AURuserpanel.closeMainPanel", localPlayer)
			executeCommandHandler("updates")
		end
	end
end
addEventHandler("onClientClick", root, openUpdatesWindow)

function openStaffWindow(button, state, absoluteX, absoluteY)
	if (isUserPanelShowing) and (state == "down") then 
		if ((absoluteX >= sx*591) and (absoluteX <= sx*(591+182)) and (absoluteY >= sy*pos) and (absoluteY <= sy*(pos+45))) then
			triggerEvent("AURuserpanel.closeMainPanel", localPlayer)
			triggerServerEvent("AURuserpanel.StaffPanel", localPlayer, localPlayer)
			
		end
	end
end
addEventHandler("onClientClick", root, openStaffWindow)

function openLoginsWindow(button, state, absoluteX, absoluteY)
	if (isUserPanelShowing) and (state == "down") then 
		if ((absoluteX >= sx*301) and (absoluteX <= sx*(301+182)) and (absoluteY >= sy*pos) and (absoluteY <= sy*(pos+45))) then
			triggerEvent("AURuserpanel.closeMainPanel", localPlayer)
			triggerServerEvent("AURuserpanel.LoginsPanel", localPlayer, localPlayer)
			
		end
	end
end
addEventHandler("onClientClick", root, openLoginsWindow)

function closeUpdatesWindow(button, state, absoluteX, absoluteY)
	if (isUpdatesPanelShowing) and (state == "down") then 
		if ((absoluteX >= sx*613) and (absoluteX <= sx*(613+143)) and (absoluteY >= sy*613) and (absoluteY <= sy*(613+45))) then
			triggerEvent("AURuserpanel.drawUpdatesPanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, closeUpdatesWindow)

function closeStaffWindow(button, state, absoluteX, absoluteY)
	if (isStaffMemebersShowing) and (state == "down") then 
		if ((absoluteX >= sx*613) and (absoluteX <= sx*(613+143)) and (absoluteY >= sy*613) and (absoluteY <= sy*(613+45))) then
			triggerEvent("AURuserpanel.drawStaffPanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, closeStaffWindow)

function closeLoginsWindow(button, state, absoluteX, absoluteY)
	if (isLastLoginsShowing) and (state == "down") then 
		if ((absoluteX >= sx*613) and (absoluteX <= sx*(613+143)) and (absoluteY >= sy*613) and (absoluteY <= sy*(613+45))) then
			triggerEvent("AURuserpanel.drawLoginsPanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, closeLoginsWindow)

function openSkills(button, state, absoluteX, absoluteY)
	if (isUserPanelShowing) and (state == "down") then 
		if ((absoluteX >= sx*883) and (absoluteX <= sx*(883+182)) and (absoluteY >= sy*pos) and (absoluteY <= sy*(pos+45))) then
			if (antiSpam and getTickCount() - antiSpam <= 5000) then return false end
			triggerServerEvent("AURuserpanel.drawSkillsWnd", localPlayer, localPlayer)
			triggerEvent("AURuserpanel.closeMainPanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, openSkills)