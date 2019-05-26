local tab = {}
local pos1 = {}
local pos2 = {}
local pos3 = {}
local sx_, sy_ = guiGetScreenSize()
local sX = sx_/1366
local sY = sy_/768
local isNotificationsShowing = false

function receiveNotifications(requestedTab)
	tab = requestedTab
	if (isNotificationsShowing) then
		pos1[#pos1+1] = pos1[#pos1] + 94
		pos2[#pos2+1] = pos2[#pos2] + 94
		pos3[#pos3+1] = pos3[#pos3] + 94
	end
end
addEvent("AURnotifications.receiveNotifications", true)
addEventHandler("AURnotifications.receiveNotifications", root, receiveNotifications)

function renderInterpolation()
	local now = getTickCount()
	local duration = 2000
	local elapsed = now - start
	local progress = (now - start) / (duration)
	for i=1,math.min(#tab,math.floor(sx_/8)) do
		local k = i-1
		pos1[i] = interpolateBetween(0, 0, 0, (k*94)+0, 0, 0, progress, "OutBounce")
		pos2[i] = interpolateBetween(0, 0, 0, (k*94)+93, 0, 0, progress, "OutBounce")
		pos3[i] = interpolateBetween(0, 0, 0, (k*94)+36, 0, 0, progress, "OutBounce")
	end
	if (now > start + duration) then
		removeEventHandler("onClientRender", root, renderInterpolation)
	end
end 

function startCusror()
	showCursor(not isCursorShowing())
end
bindKey("m", "down", startCusror)

function openNotificationsPanel()
	if (isNotificationsShowing) then
		isNotificationsShowing = false
		removeEventHandler("onClientRender", root, renderInterpolation)
		removeEventHandler("onClientRender", root, startThis)
	else
		isNotificationsShowing = true
		start = getTickCount()
		addEventHandler("onClientRender", root, renderInterpolation)
		addEventHandler("onClientRender", root, startThis)
	end
end
addEvent("AURnotifications.openNotificationsPanel", true)
addEventHandler("AURnotifications.openNotificationsPanel", root, openNotificationsPanel)

function startThis()
	if (#tab > 0) and (exports.server:isPlayerLoggedIn(localPlayer)) then
		for i=1,math.min(#tab,math.floor(sx_/8)) do
			dxDrawRectangle(sX*0, sY*pos1[i], sX*463, sY*93, tocolor(0, 0, 0, 183), true)
			dxDrawText(tab[i].datum, sX*0 - 1, sY*pos1[i] - 1, sX*463 - 1, sY*pos3[i] - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].datum, sX*0 + 1, sY*pos1[i] - 1, sX*463 + 1, sY*pos3[i] - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].datum, sX*0 - 1, sY*pos1[i] + 1, sX*463 - 1, sY*pos3[i] + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].datum, sX*0 + 1, sY*pos1[i]+ 1, sX*463 + 1,  sY*pos3[i] + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].datum, sX*0, sY*pos1[i], sX*463, sY*pos3[i], tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			--texts
			dxDrawText(tab[i].notificationText, sX*0 - 1, sY*pos1[i] - 1, sX*463 - 1, sY*pos2[i] - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].notificationText, sX*0 + 1, sY*pos1[i] - 1, sX*463 + 1, sY*pos2[i] - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].notificationText, sX*0 - 1, sY*pos1[i] + 1, sX*463 - 1, sY*pos2[i] + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].notificationText, sX*0 + 1, sY*pos1[i]+ 1, sX*463 + 1,  sY*pos2[i] + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(tab[i].notificationText, sX*0, sY*pos1[i], sX*463, sY*pos2[i], tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
		end
	end
end

addEventHandler("onClientRender", root, 
	function()
		if (not exports.server:isPlayerLoggedIn(localPlayer)) then return false end
		if (not isNotificationsShowing) then
		dxDrawText("UNREAD: "..#tab, sX*72 - 1, sY*692 - 1, sX*472 - 1, sY*764 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("UNREAD: "..#tab, sX*72 + 1, sY*692 - 1, sX*472 + 1, sY*764 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("UNREAD: "..#tab, sX*72 - 1, sY*692 + 1, sX*472 - 1, sY*764 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("UNREAD: "..#tab, sX*72 + 1, sY*692 + 1, sX*472 + 1, sY*764 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawText("UNREAD: "..#tab, sX*72, sY*692, sX*472, sY*764, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
		dxDrawImage(sX*0, sY*694, sX*62, sY*70, "icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
end 
)

function removeOnClick(button, state, absoluteX, absoluteY)
	if (#tab > 0) and (state == "down") then
		if (antiSpam and getTickCount() - antiSpam <= 500) then return false end
		local total = math.min(#tab,math.floor(sx_/9))
		local i = math.floor((absoluteY/(sY*94))+1)
		triggerServerEvent("AURnotifications.deleteNotification", localPlayer, tab[i].id)
		table.remove(tab, i)
		antiSpam = getTickCount()
		if (#tab == 0) then 
			isNotificationsShowing = false
			removeEventHandler("onClientRender", root, renderInterpolation)
			removeEventHandler("onClientRender", root, startThis)
			showCursor(false)
		end
	end
end
addEventHandler("onClientClick", root, removeOnClick)

function onIconClick(button, state, absoluteX, absoluteY)
	if (not isNotificationsShowing) and (state == "down") and (#tab > 0)then
		if ((absoluteX >= sX*0) and (absoluteX <= sX*(0+62)) and (absoluteY >= sY*694) and (absoluteY <= sY*(694+70))) then
			triggerEvent("AURnotifications.openNotificationsPanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, onIconClick)

function closeNotifications(button, pressed)
	if (isNotificationsShowing) and (button == "escape") and (pressed) then
		cancelEvent()
		triggerEvent("AURnotifications.openNotificationsPanel", localPlayer)
	end
end
addEventHandler("onClientKey", root, closeNotifications)