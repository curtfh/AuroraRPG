local DMGUI = {}
local screenW,screenH=guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()
local windowWidth, windowHeight = 450, 350
local windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)

local player
local isDMShowing = false
local sX, sY = guiGetScreenSize()
local sX = sX / 1366
local sY = sY / 768

addEvent("AURdm.outputForgivePanel", true)
function initLabelElement(player)
	if (isElement(label)) then
		destroyElement(label)
	else
		label = guiCreateLabel(sX*359, sY*320, sX*651, sY*52, "You have been possibly deathmatched by "..getPlayerName(player), false)
		guiLabelSetHorizontalAlign(label, "left", true)
		guiLabelSetVerticalAlign(label, "center")   
	end
end

function initPunishmentDX()
	dxDrawRectangle(sX*357, sY*270, sX*653, sY*262, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sX*357, sY*270, sX*652, sY*41, tocolor(0, 0, 0, 183), false)
	dxDrawText("Punish or forgive?", sX*356 - 1, sY*270 - 1, sX*1009 - 1, sY*310 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish or forgive?", sX*356 + 1, sY*270 - 1, sX*1009 + 1, sY*310 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish or forgive?", sX*356 - 1, sY*270 + 1, sX*1009 - 1, sY*310 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish or forgive?", sX*356 + 1, sY*270 + 1, sX*1009 + 1, sY*310 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish or forgive?", sX*356, sY*270, sX*1009, sY*310, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(sX*596, sY*385, sX*176, sY*56, tocolor(0, 0, 0, 183), false)
	dxDrawText("Punish", sX*596 - 1, sY*385 - 1, sX*772 - 1, sY*441 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish", sX*596 + 1, sY*385 - 1, sX*772 + 1, sY*441 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish", sX*596 - 1, sY*385 + 1, sX*772 - 1, sY*441 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish", sX*596 + 1, sY*385 + 1, sX*772 + 1, sY*441 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Punish", sX*596, sY*385, sX*772, sY*441, tocolor(255, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(sX*596, sY*451, sX*176, sY*56, tocolor(0, 0, 0, 183), false)
	dxDrawText("Forgive", sX*596, sY*451, sX*772, sY*507, tocolor(0, 255, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function outputForgivePanel(player)
	if (isDMShowing) then
		removeEventHandler("onClientRender", root, initPunishmentDX)
		isDMShowing = false
		showCursor(false)
		if (isElement(label)) then destroyElement(label) end
	else
		addEventHandler("onClientRender", root, initPunishmentDX)
		isDMShowing = true
		initLabelElement(player)
		killer = player
		showCursor(true)
	end
end
addEventHandler("AURdm.outputForgivePanel", root, outputForgivePanel)

function forgivePlayer(button, state, absoluteX, absoluteY)
	if (isDMShowing) and (state == "down") then 
		if ((absoluteX >= sX*596) and (absoluteX <= sX*(596+176)) and (absoluteY >= sY*451) and (absoluteY <= sY*(451+56))) then
			triggerEvent("AURdm.outputForgivePanel", localPlayer)
		end
	end
end
addEventHandler("onClientClick", root, forgivePlayer)

function punishThePlayer(button, state, absoluteX, absoluteY)
	if (isDMShowing) and (state == "down") then 
		if ((absoluteX >= sX*596) and (absoluteX <= sX*(596+176)) and (absoluteY >= sY*385) and (absoluteY <= sY*(385+56))) then
			triggerEvent("AURdm.outputForgivePanel", localPlayer)
			if (killer) then
				triggerServerEvent("AURdm.punishThePlayer", localPlayer, localPlayer, killer)
			end
		end
	end
end
addEventHandler("onClientClick", root, punishThePlayer)


local function createDMGUI()
--	local x,y = (screenW-200)/2, (screenH-400)/2


	DMGUI.window = guiCreateWindow(windowX, windowY,500,400,"DM messages - double click to warp - right click to remove", false)
	guiWindowSetSizable(DMGUI.window, false)
	DMGUI.grid = guiCreateGridList(5,25, 490, 330, false, DMGUI.window)
	guiGridListAddColumn(DMGUI.grid, "Time", 0.10)
	guiGridListAddColumn(DMGUI.grid, "Message", 0.7)
	guiGridListAddColumn(DMGUI.grid, "Player", 0.5)
	guiGridListAddColumn(DMGUI.grid, "ID", 0.1)
	DMGUI.clear = guiCreateButton(5,360, 70, 35, "Clear", false, DMGUI.window)
	DMGUI.close = guiCreateButton(375,360, 70, 35, "Close", false, DMGUI.window)
	addEventHandler("onClientGUIClick", DMGUI.clear, clearDMMessages,false)
	addEventHandler("onClientGUIClick", DMGUI.close, closeDMGUI,false)
	addEventHandler("onClientGUIDoubleClick", DMGUI.grid, onDMGridDoubleClick,false)
	addEventHandler("onClientGUIClick", DMGUI.grid, onDMGridClick,false)
end

function clearDMMessages()
	guiGridListClear(DMGUI.grid)
	for k,v in pairs(getElementsByType("player")) do

	if exports.CSGstaff:isPlayerStaff(v) then
	triggerServerEvent("clearOneByOne",v)
	end
	end
end

function closeDMGUI()
	if(isElement(DMGUI.window)) then
		guiSetVisible(DMGUI.window, false)
		showCursor(false)
	end
end

function toggleDMGUI()
	if(not isElement(DMGUI.window) or not guiGetVisible(DMGUI.window) ) then
		openDMGUI()
	else
		closeDMGUI()
	end
end
addCommandHandler("dmmsgs", toggleDMGUI)
function openDMGUI()
	if(isPlayerStaff(localPlayer)) then
		if(isElement(DMGUI.window)) then
			guiSetVisible(DMGUI.window, true)
		else
			createDMGUI()
		end
		showCursor(true)
	end
end


function onDMGridDoubleClick(btn, state)
	local selected, _ = guiGridListGetSelectedItem(DMGUI.grid)
	if(selected and selected ~= -1) then
		local asshole = guiGridListGetItemData(DMGUI.grid, selected, 1)
		local theNoob = guiGridListGetItemText(DMGUI.grid, selected, 3)
		local thePlayer = getPlayerFromName(theNoob)
		if (isElement(thePlayer)) then
			triggerServerEvent( "onAdminPlayerActions", localPlayer, thePlayer, "warp" )
			triggerServerEvent( "onAdmimWarpToDM", localPlayer,asshole)
		else
			exports.NGCdxmsg:createNewDxMessage("This player already left!", 255,0,0)
		end
	end
end

function onDMGridClick(btn, state,x,y)
	if(btn == "right") then
		local selected, _ = guiGridListGetSelectedItem(DMGUI.grid)
		if(selected and selected ~= -1) then
			guiGridListRemoveRow(DMGUI.grid, selected)
		end
	end
end

addEvent("CSGstaff.dm_message", true)
function addDMMessage(text, id, victim,damer)
	if(not isElement(DMGUI.grid)) then
		createDMGUI()
		guiSetVisible(DMGUI.window, false)
	end
	local row = guiGridListAddRow(DMGUI.grid)
	guiGridListSetItemText(DMGUI.grid, row, 1, getCurrentTimeString(), false, false)
	guiGridListSetItemText(DMGUI.grid, row, 2, text, false, false)
	guiGridListSetItemText(DMGUI.grid, row, 3, getPlayerName(damer), false, true)
	guiGridListSetItemText(DMGUI.grid, row, 4, id, false, true)
	guiGridListSetItemData(DMGUI.grid, row, 1, victim)

	--guiGridListSetItemData(DMGUI.grid, row, 1, damer)
end
addEventHandler("CSGstaff.dm_message", localPlayer, addDMMessage)


function getCurrentTimeString()
	local theTime = getRealTime()
	return string.format("%02i:%02i:%02i", theTime.hour, theTime.minute, theTime.second)
end
