--
-- Author: Ab-47; State: BETA 1.2.
-- Additional Notes; N/A; Rights: All Rights Reserved by Developers with permission by Ab-47.
-- Project: AURamisc/client.lua consisting of 2 file(s).
-- Directory: [ab-47]/AURamisc/client.lua
-- Side Notes: BETA version 1.2 (Unstable Release)
--

local screenWidth, screenHeight = guiGetScreenSize()

local vip={
	rwindow = {},
	rlabel = {},
	rbutton = {},
}

local rdata = {}

function loadthingy()
	windowWidth, windowHeight = 408, 111
	windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
	vip.rwindow[1] = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "Someone has requested to glue on your vehicle!", false)
	guiWindowSetSizable(vip.rwindow[1], false)
	guiWindowSetSizable(vip.rwindow[1], false)
	guiSetAlpha(vip.rwindow[1], 1.00)
	guiSetVisible(vip.rwindow[1], false)

	vip.rlabel[1] = guiCreateLabel(3, 24, 399, 21, "You've recieved a request by [AUR]Ab-47", false, vip.rwindow[1])
	vip.rbutton[1] = guiCreateButton(10, 69, 131, 32, "Accept", false, vip.rwindow[1])
	vip.rbutton[2] = guiCreateButton(267, 69, 131, 32, "Decline", false, vip.rwindow[1])
	
	guiSetFont(vip.rlabel[1], "clear-normal")
	guiLabelSetColor(vip.rlabel[1], 14, 240, 211)
	guiLabelSetHorizontalAlign(vip.rlabel[1], "center", false)
	guiLabelSetVerticalAlign(vip.rlabel[1], "center")
	guiSetProperty(vip.rbutton[1], "NormalTextColour", "FF09F41A")
	guiSetProperty(vip.rbutton[2], "NormalTextColour", "FFFD0000")    
		
	for ki, btns in pairs(vip.rbutton) do
		addEventHandler("onClientGUIClick", btns, function() if (source == vip.rbutton[1]) then requestRespone("accepted") end end)
		addEventHandler("onClientGUIClick", btns, function() if (source == vip.rbutton[2]) then requestRespone("declined") end end)
	end
end
addEventHandler("onClientResourceStart", root, loadthingy)
 

function request_glue(requestedPlr, owner)
	if (not guiGetVisible(vip.rwindow[1])) then
		guiSetVisible(vip.rwindow[1], true)
		guiSetText(vip.rlabel[1], "You've recieved a request by "..getPlayerName(requestedPlr))
		showCursor(not isCursorShowing(), true)
		rdata[owner] = {requestedPlr, getPedWeaponSlot(requestedPlr)}
	end
end
addEvent("AURpremium.request_glue", true)
addEventHandler("AURpremium.request_glue", root, request_glue)

function remove_panel(requestedPlr, owner)
	if (guiGetVisible(vip.rwindow[1])) then
		guiSetVisible(vip.rwindow[1], false)
		showCursor(false)
	end
end
addEvent("AURpremium.remove_panel", true)
addEventHandler("AURpremium.remove_panel", root, remove_panel)

function requestRespone(string)
	if (not string) then return end
	if (string == "accepted") then
		triggerServerEvent("AURpremium.initiate_glue", localPlayer, rdata[localPlayer][1], string, localPlayer, rdata[localPlayer][2])
		guiSetVisible(vip.rwindow[1], false)
		showCursor(false)
	elseif (string == "declined") then
		triggerServerEvent("AURpremium.initiate_glue", localPlayer, rdata[localPlayer][1], string, localPlayer)
		guiSetVisible(vip.rwindow[1], false)
		showCursor(false)
	end
end