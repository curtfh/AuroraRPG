local antiSpam = {}
local EventObjects = {
    {1583,"Target gta3 Luigi", 0},
    {1584,"Target gta3 Misty", 0},
    {14781, "Boxing ring", 0},
    {13666, "Staunt", 0},
    {1487, "Beer", 0},
    {1225, "Explosion", 0},
    {981, "Large Barrier", 0},
    {3578, "Yellow Barrier", 0},
    {1228, "Warning fence", 90},
    {1282, "Warning fence with light", 90},
    {1422, "Small fence", 0},
    {1425, "Detour ->", 0},
    {1459, "Barrier", 0},
    {3091, "Vehicles Barrier->", 0},
    {1632, "Ramp 1", 0},
    {1633, "Ramp 2", 0},
    {1634, "Ramp 3", 0},
    {1655, "Ramp 4", 0},
    {8171, "Runway", 0},
    {10154, "Garage Door", 0},
    {980, "Airport Gate", 0},
    {3458, "Car Covering", 0},
}

local resX, resY = guiGetScreenSize()
local controls = {"aim_weapon", "fire", "previous_weapon", "next_weapon"}
local offsetType = nil
local offsetAmount = 0.030
local totalOffsetAmount = 0














function centerWindow( center_window )
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize( center_window, false )
    local x, y = ( screenW - windowW ) /2, ( screenH - windowH ) / 2
    guiSetPosition( center_window, x, y, false )
end



EventObjectsPanel = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}
EventObjectsPanel.window[1] = guiCreateWindow(35, 88, 740, 409, "Aurora ~ Event Objects", false)
guiWindowSetSizable(EventObjectsPanel.window[1], false)
guiSetVisible(EventObjectsPanel.window[1],false)
centerWindow(EventObjectsPanel.window[1])
EventObjectsPanel.gridlist[1] = guiCreateGridList(10, 76, 210, 308, false, EventObjectsPanel.window[1])
guiGridListAddColumn(EventObjectsPanel.gridlist[1], "Object", 0.5)
guiGridListAddColumn(EventObjectsPanel.gridlist[1], "Name", 0.5)
EventObjectsPanel.button[1] = guiCreateButton(229, 296, 140, 27, "Create", false, EventObjectsPanel.window[1])
EventObjectsPanel.button[2] = guiCreateButton(379, 296, 140, 27, "Delete my objects", false, EventObjectsPanel.window[1])
EventObjectsPanel.button[3] = guiCreateButton(229, 353, 140, 27, "Close", false, EventObjectsPanel.window[1])
EventObjectsPanel.button[4] = guiCreateButton(379, 353, 140, 27, "Delete All objects", false, EventObjectsPanel.window[1])
EventObjectsPanel.label[1] = guiCreateLabel(9, 27, 210, 39, "Select object", false, EventObjectsPanel.window[1])
guiSetFont(EventObjectsPanel.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(EventObjectsPanel.label[1], "center", false)
guiLabelSetVerticalAlign(EventObjectsPanel.label[1], "center")
EventObjectsPanel.gridlist[2] = guiCreateGridList(526, 73, 204, 311, false, EventObjectsPanel.window[1])
guiGridListAddColumn(EventObjectsPanel.gridlist[2], "ID", 0.2)
guiGridListAddColumn(EventObjectsPanel.gridlist[2], "Name", 0.2)
guiGridListAddColumn(EventObjectsPanel.gridlist[2], "By", 0.2)
EventObjectsPanel.label[2] = guiCreateLabel(224, 73, 287, 156, "Use the Mouse wheel to rotate the EventObject.\nHold Ctrl or Ctrl and Shift to change x and y rotations. \nTo cancel placing use Mouse 2.\nTo place the EventObject use Mouse 1.\nIf you want to delete EventObjects use the right button of the mouse.\nNote that you have to be in staff mode to use this\nTo disable cursor hold Alt\nTo change Z offset use arrow keys", false, EventObjectsPanel.window[1])
guiSetFont(EventObjectsPanel.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(EventObjectsPanel.label[2], "center", true)
guiLabelSetVerticalAlign(EventObjectsPanel.label[2], "center")
EventObjectsPanel.label[3] = guiCreateLabel(520, 18, 210, 39, "Event Objects", false, EventObjectsPanel.window[1])
guiSetFont(EventObjectsPanel.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(EventObjectsPanel.label[3], "center", false)
guiLabelSetVerticalAlign(EventObjectsPanel.label[3], "center")
for k, v in ipairs(EventObjects) do
	local row = guiGridListAddRow(EventObjectsPanel.gridlist[1])
	guiGridListSetItemText(EventObjectsPanel.gridlist[1], row, 2, v[2], false, false)
	guiGridListSetItemText(EventObjectsPanel.gridlist[1], row, 1, v[1] or engineGetModelNameFromID(v[1]) or "Unknown", false, false)
end

addEvent("callBackEventObjects",true)
addEventHandler("callBackEventObjects",root,function()
	guiGridListClear(EventObjectsPanel.gridlist[2])
	for k,v in ipairs(getElementsByType("object",resourceRoot)) do
		local row = guiGridListAddRow(EventObjectsPanel.gridlist[2])
		guiGridListSetItemText(EventObjectsPanel.gridlist[2], row, 1, getElementModel(v), false, false)
		guiGridListSetItemText(EventObjectsPanel.gridlist[2], row, 2, engineGetModelNameFromID(getElementModel(v)) or "Unknown", false, false)
		guiGridListSetItemText(EventObjectsPanel.gridlist[2], row, 3, getElementData(v,"creator") or "Unknown", false, false)
	end
end)


addEventHandler("onClientGUIClick",root,function()
	if source == EventObjectsPanel.button[4] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("onEMDeleteAllObject",localPlayer)
	elseif source == EventObjectsPanel.button[3] then
		guiSetVisible(EventObjectsPanel.window[1],false)
		showCursor(false)
	elseif source == EventObjectsPanel.button[2] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("onEMDeleteObject",localPlayer)
	elseif source == EventObjectsPanel.button[1] then
		local objID = guiGridListGetItemText(EventObjectsPanel.gridlist[1], guiGridListGetSelectedItem(EventObjectsPanel.gridlist[1]), 1)
		local objName = guiGridListGetItemText(EventObjectsPanel.gridlist[1], guiGridListGetSelectedItem(EventObjectsPanel.gridlist[1]), 2)
		if objID then
			if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
			antiSpam[source] = setTimer(function() end,3000,1)
			placeObject(objName,objID)
			---triggerServerEvent("onEMCreateObject",localPlayer,objName,objID)
		end
	end
end)

function placeObject(objName,objID)
	if (not tonumber(objID)) or (objID == "") then
		outputChatBox("Invalid model ID", 255, 0, 0)
		return
	end
	object = createObject(tonumber(objID), 0, 0, 0, 0, 0, 0)
	setElementCollisionsEnabled(object, false)
	setElementDoubleSided(object, true)
	setElementDimension(object, getElementDimension(localPlayer))
	setElementInterior(object, getElementInterior(localPlayer))
	startPlacing()
end


function startPlacing()
	if (object) then
		guiSetEnabled(EventObjectsPanel.button[2], false)
		guiSetEnabled(EventObjectsPanel.button[1], false)
	end
	bindKey("mouse_wheel_up", "down", rotateEventObject)
	bindKey("mouse_wheel_down", "down", rotateEventObject)
	bindKey("mouse1", "down", placeEventObject)
	bindKey("mouse2", "down", cancelEventObject)
	for i, v in pairs(controls) do
		toggleControl(tostring(v), false)
	end
end
---

function cancelEventObject()
	destroyElement(object)
	unbindKey("mouse2", "down", cancelEventObject)
	unbindKey("mouse1", "down", placeEventObject)
	unbindKey("mouse_wheel_up", "down", rotateEventObject)
	unbindKey("mouse_wheel_down", "down", rotateEventObject)
	totalOffsetAmount = 0
	guiSetEnabled(EventObjectsPanel.button[2], true)
	guiSetEnabled(EventObjectsPanel.button[1], true)
	for i, v in pairs(controls) do
		toggleControl(tostring(v), true)
	end
end

function rotateEventObject(key)
	local rX, rY, rZ = getElementRotation(object)
	if (key == "mouse_wheel_up") then
		if (isElement( object)) then
			if (not getKeyState("lctrl") and not getKeyState("lshift")) then
				setElementRotation(object, rX, rY, rZ + 5)
			end
			if (getKeyState("lctrl") and not getKeyState("lshift")) then
				setElementRotation(object, rX, rY + 5, rZ)
			end
			if (getKeyState("lctrl") and getKeyState("lshift")) then
				setElementRotation(object, rX + 5, rY, rZ)
			end
		end
	elseif (key == "mouse_wheel_down") then
		if (not getKeyState("lctrl") and not getKeyState("lshift")) then
			setElementRotation(object, rX, rY, rZ - 5)
		end
		if (getKeyState("lctrl") and not getKeyState("lshift")) then
			setElementRotation(object, rX, rY - 5, rZ)
		end
		if (getKeyState("lctrl") and getKeyState("lshift")) then
			setElementRotation(object, rX - 5, rY, rZ)
		end
	end
end

function placeEventObject()
	if (not object) then return end
	local x, y, z = getElementPosition(object)
	local rx, ry, rz = getElementRotation(object)
	local id = getElementModel(object)
	local dim = getElementDimension(localPlayer)
	local int = getElementInterior(localPlayer)
	triggerServerEvent("onEMCreateObject", localPlayer, id, x, y, z, rx, ry, rz, dim, int)
	destroyElement(object)
    unbindKey("mouse2", "down", cancelEventObject)
    unbindKey("mouse1", "down", placeEventObject)
    unbindKey("mouse_wheel_up", "down", rotateEventObject)
    unbindKey("mouse_wheel_down", "down", rotateEventObject)
	totalOffsetAmount = 0
	guiSetEnabled(EventObjectsPanel.button[2], true)
	guiSetEnabled(EventObjectsPanel.button[1], true)
    for i, v in pairs(controls) do
		toggleControl(tostring(v), true)
    end
end


function noBreak(object)
	if getElementModel(object) == 1583 or getElementModel(object) == 1584 then return false end
	setObjectBreakable(object, false)
end
addEvent("nobreak", true)
addEventHandler("nobreak", root, noBreak)


function toggleCursor(key, state)
	if (guiGetVisible(EventObjectsPanel.window[1])) then
		if (state == "down") then
			showCursor(false)
		else
			showCursor(true)
		end
	end
end
bindKey("lalt", "both", toggleCursor)

function toggleCursor()
	if (guiGetVisible(EventObjectsPanel.window[1])) then
		if (state == "down") then
			showCursor(false)
		else
			showCursor(true)
		end
	end
end
bindKey("z", "down", toggleCursor)


function elementClicked(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
	if (guiGetVisible(EventObjectsPanel.window[1])) then
		if (button == "right") then
			if (state == "up") then
				if (clickedWorld and isElement(clickedWorld)) then
					if (getElementType(clickedWorld) == "object") then
						for k,v in ipairs(getElementsByType("object"), resourceRoot) do
							if (v == clickedWorld) then
								triggerServerEvent("EMDestroyObject", root, clickedWorld)
								return
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, elementClicked)

local screenX, screenY = guiGetScreenSize()
function onCursorMove(cursorX, cursorY)
	if (object and isElement(object)) then
		if (isCursorShowing()) then
			local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
			local px, py, pz = getCameraMatrix()
			local dist = getElementDistanceFromCentreOfMassToBaseOfModel(object)
			local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, true, false, true, true, false, false, false)
			if (hit) then
				local px, py, pz = getElementPosition(localPlayer)
				local distance = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
				setElementPosition(object, x, y, (z + dist + totalOffsetAmount))
			end
		end
	end
end
addEventHandler("onClientCursorMove", root, onCursorMove)

function toggleOffsets(key, state)
	if (state == "up") then
		offsetType = nil
		return
	end
	if (key == "arrow_u") then
		offsetType = "up"
	elseif (key == "arrow_d") then
		offsetType = "down"
	end
end
bindKey("arrow_u", "both", toggleOffsets)
bindKey("arrow_d", "both", toggleOffsets)

function clientPreRender()
	if (offsetType and object and isElement(object)) then
		local addition = 0
		if (getKeyState("lalt")) then
			addition = offsetAmount*100
		end
		local x, y, z = getElementPosition(object)
		if (offsetType == "up") then
			setElementPosition(object, x, y, z + offsetAmount + addition)
			totalOffsetAmount = totalOffsetAmount + offsetAmount + addition
		elseif (offsetType == "down") then
			setElementPosition(object, x, y, z - offsetAmount - addition)
			totalOffsetAmount = totalOffsetAmount - offsetAmount - addition
		end
	end
end
addEventHandler("onClientPreRender", root, clientPreRender)



function onClientRender()
	if (EventObjectsPanel.window[1] and guiGetVisible(EventObjectsPanel.window[1]) and not isElement(object) and isCursorShowing()) then
		local gx, gy
		local camX, camY, camZ = getCameraMatrix()
		local cursorX, cursorY, endX, endY, endZ = getCursorPosition()
		local surfaceFound, targetX, targetY, targetZ, targetElement, nx, ny, nz, material, lighting, piece, buildingId, bx, by, bz, brx, bry, brz, buildingLOD = processLineOfSight(camX, camY, camZ, endX, endY, endZ, true, true, true, true, true, true, true, true, localPlayer, true)
		if not surfaceFound then
			targetX, targetY, targetZ = endX, endY, endZ
		end
		gx, gy = getScreenFromWorldPosition(targetX, targetY, targetZ, 0, false)
		if (gx and gy) then
			if (targetElement) then
				dxDrawText("OBJ ID: "..getElementModel(targetElement) or "Unknown", gx, gy - 20)
			else
				if (buildingId) then
					dxDrawText("OBJ ID: "..buildingId, gx, gy - 20)
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, onClientRender)




----------
Event = {
    gridlist = {},
    label = {},
    button = {},
    window = {},
    edit = {},
    radiobutton = {}
}
EventMisc2 = {
    checkbox = {},
    button = {},
    label = {}
}
Event.window[1] = guiCreateWindow(0, 6, 794, 584, "AURORA ~ Event System", false)
guiWindowSetSizable(Event.window[1], false)
guiSetVisible(Event.window[1],false)
centerWindow(Event.window[1])

Event.gridlist[1] = guiCreateGridList(9, 21, 196, 549, false, Event.window[1])
guiGridListAddColumn(Event.gridlist[1], "Players", 0.9)
Event.radiobutton[1] = guiCreateRadioButton(507, 94, 80, 22, "Custom", false, Event.window[1])
guiSetFont(Event.radiobutton[1], "default-bold-small")
Event.radiobutton[2] = guiCreateRadioButton(508, 67, 50, 22, "All ", false, Event.window[1])
guiSetFont(Event.radiobutton[2], "default-bold-small")
guiRadioButtonSetSelected(Event.radiobutton[2], true)
Event.radiobutton[5] = guiCreateRadioButton(572, 67, 50, 22, "Law", false, Event.window[1])
guiSetFont(Event.radiobutton[5], "default-bold-small")
Event.radiobutton[3] = guiCreateRadioButton(359, 293, 60, 22, "Health", false, Event.window[1])
guiSetFont(Event.radiobutton[3], "default-bold-small")
Event.radiobutton[4] = guiCreateRadioButton(428, 293, 83, 22, "Armor", false, Event.window[1])
guiSetFont(Event.radiobutton[4], "default-bold-small")
Event.label[1] = guiCreateLabel(503, 35, 266, 23, "Teams allowed to warp:", false, Event.window[1])
guiSetFont(Event.label[1], "default-bold-small")
guiLabelSetColor(Event.label[1], 39, 239, 12)
guiLabelSetHorizontalAlign(Event.label[1], "center", false)
guiLabelSetVerticalAlign(Event.label[1], "center")
Event.edit[1] = guiCreateEdit(625, 67, 144, 25, "Criminals", false, Event.window[1])
Event.button[1] = guiCreateButton(215, 140, 134, 29, "Create Event", false, Event.window[1])
guiSetProperty(Event.button[1], "NormalTextColour", "FF31F30B")
Event.edit[2] = guiCreateEdit(230, 30, 259, 28, "Event Name", false, Event.window[1])
Event.button[2] = guiCreateButton(638, 140, 136, 29, "(Kill) Stop Event", false, Event.window[1])
guiSetProperty(Event.button[2], "NormalTextColour", "FFFF0000")
Event.button[18] = guiCreateButton(640, 184, 134, 27, "(No Kill) Stop Event", false, Event.window[1])
guiSetProperty(Event.button[18], "NormalTextColour", "FFEAF30A")
Event.button[3] = guiCreateButton(330, 363, 111, 29, "UnFrozen Players", false, Event.window[1])
guiSetProperty(Event.button[3], "NormalTextColour", "FF858771")
Event.button[4] = guiCreateButton(355, 258, 136, 27, "Destroy vehicles", false, Event.window[1])
guiSetProperty(Event.button[4], "NormalTextColour", "FFFF0000")
Event.button[5] = guiCreateButton(215, 184, 134, 27, "Create Vehicle", false, Event.window[1])
guiSetProperty(Event.button[5], "NormalTextColour", "FF0BF0ED")
Event.button[6] = guiCreateButton(529, 253, 109, 27, "Send money", false, Event.window[1])
guiSetProperty(Event.button[6], "NormalTextColour", "FFF78E05")
Event.button[7] = guiCreateButton(529, 295, 109, 25, "Send Score", false, Event.window[1])
guiSetProperty(Event.button[7], "NormalTextColour", "FFF78E05")
Event.button[8] = guiCreateButton(638, 104, 134, 25, "Auto Count", false, Event.window[1])
guiSetProperty(Event.button[8], "NormalTextColour", "FF2AF109")
Event.button[9] = guiCreateButton(497, 140, 135, 29, "Destroy Vehicle marker", false, Event.window[1])
guiSetProperty(Event.button[9], "NormalTextColour", "FFFF0000")
Event.button[10] = guiCreateButton(217, 295, 132, 26, "Create Pickup", false, Event.window[1])
guiSetProperty(Event.button[10], "NormalTextColour", "FF0BF0ED")
Event.button[11] = guiCreateButton(497, 184, 136, 27, "Destroy Pickup", false, Event.window[1])
guiSetProperty(Event.button[11], "NormalTextColour", "FFFF0000")
Event.button[12] = guiCreateButton(648, 330, 136, 27, "Close", false, Event.window[1])
guiSetProperty(Event.button[12], "NormalTextColour", "FFF78E05")
Event.button[13] = guiCreateButton(217, 362, 111, 29, "Frozen Players", false, Event.window[1])
guiSetProperty(Event.button[13], "NormalTextColour", "FF0BF0ED")
Event.button[14] = guiCreateButton(355, 184, 136, 27, "Close Warps", false, Event.window[1])
guiSetProperty(Event.button[14], "NormalTextColour", "FFFC0000")
Event.button[16] = guiCreateButton(217, 400, 111, 29, "Freeze vehicles", false, Event.window[1])
guiSetProperty(Event.button[16], "NormalTextColour", "FF0BF0ED")
Event.button[17] = guiCreateButton(330, 399, 111, 29, "Un-Freeze vehicles", false, Event.window[1])
guiSetProperty(Event.button[17], "NormalTextColour", "FF858771")
Event.edit[3] = guiCreateEdit(355, 219, 138, 29, "Vehicle name / ID", false, Event.window[1])
Event.edit[4] = guiCreateEdit(345, 64, 144, 25, "1000", false, Event.window[1])
Event.label[4] = guiCreateLabel(215, 64, 98, 25, "Enter Dimension", false, Event.window[1])
guiSetFont(Event.label[4], "default-bold-small")
guiLabelSetHorizontalAlign(Event.label[4], "left", true)
guiLabelSetVerticalAlign(Event.label[4], "center")
Event.edit[5] = guiCreateEdit(345, 98, 144, 25, "999", false, Event.window[1])
Event.label[6] = guiCreateLabel(215, 98, 98, 27, "Set Warp limit", false, Event.window[1])
guiSetFont(Event.label[6], "default-bold-small")
guiLabelSetHorizontalAlign(Event.label[6], "left", true)
guiLabelSetVerticalAlign(Event.label[6], "center")
Event.label[7] = guiCreateLabel(511, 221, 302, 25, "Money & Score managements", false, Event.window[1])
guiSetFont(Event.label[7], "default-bold-small")
guiLabelSetColor(Event.label[7], 39, 239, 12)
guiLabelSetHorizontalAlign(Event.label[7], "center", false)
guiLabelSetVerticalAlign(Event.label[7], "center")
Event.edit[6] = guiCreateEdit(644, 253, 140, 27, "5000", false, Event.window[1])
Event.edit[7] = guiCreateEdit(644, 294, 141, 26, "1", false, Event.window[1])
Event.button[15] = guiCreateButton(353, 140, 136, 29, "MultiWarps", false, Event.window[1])
guiSetProperty(Event.button[15], "NormalTextColour", "FFEAF30A")
EventMisc2.button[1] = guiCreateButton(217, 437, 111, 29, "Enable All Weps", false, Event.window[1])
guiSetProperty(EventMisc2.button[1], "NormalTextColour", "FF0BF0ED")
EventMisc2.button[2] = guiCreateButton(330, 437, 111, 29, "Disable All Weps", false, Event.window[1])
guiSetProperty(EventMisc2.button[2], "NormalTextColour", "FF858771")
EventMisc2.button[3] = guiCreateButton(355, 327, 111, 29, "Custom weapons", false, Event.window[1])
guiSetProperty(EventMisc2.button[3], "NormalTextColour", "FF0BF0ED")
EventMisc2.checkbox[1] = guiCreateCheckBox(454, 362, 85, 27, "Melee", true, false, Event.window[1])
EventMisc2.checkbox[2] = guiCreateCheckBox(454, 400, 85, 27, "Pistols", true, false, Event.window[1])
EventMisc2.checkbox[3] = guiCreateCheckBox(454, 435, 85, 27, "Combat guns", true, false, Event.window[1])
EventMisc2.checkbox[4] = guiCreateCheckBox(454, 472, 85, 27, "SMG", true, false, Event.window[1])
EventMisc2.checkbox[5] = guiCreateCheckBox(549, 472, 85, 27, "Rifles", true, false, Event.window[1])
EventMisc2.checkbox[6] = guiCreateCheckBox(549, 362, 85, 27, "Sniper", true, false, Event.window[1])
EventMisc2.checkbox[7] = guiCreateCheckBox(549, 400, 85, 27, "Heavy", true, false, Event.window[1])
EventMisc2.checkbox[8] = guiCreateCheckBox(549, 435, 85, 27, "Nades", true, false, Event.window[1])
EventMisc2.button[95] = guiCreateButton(454, 542, 111, 27, "Enable V Ghost", false, Event.window[1])
guiSetProperty(EventMisc2.button[95], "NormalTextColour", "FF0BF0ED")
EventMisc2.button[94] = guiCreateButton(570, 542, 111, 27, "Disable V Ghost", false, Event.window[1])
guiSetProperty(EventMisc2.button[94], "NormalTextColour", "FF858771")
EventMisc2.button[97] = guiCreateButton(217, 542, 111, 27, "Enable Ghost", false, Event.window[1])
guiSetProperty(EventMisc2.button[97], "NormalTextColour", "FF0BF0ED")
EventMisc2.button[96] = guiCreateButton(330, 542, 111, 27, "Disable Ghost", false, Event.window[1])
guiSetProperty(EventMisc2.button[96], "NormalTextColour", "FF858771")
EventMisc2.button[99] = guiCreateButton(217, 508, 111, 27, "Enable DM", false, Event.window[1])
guiSetProperty(EventMisc2.button[99], "NormalTextColour", "FF0BF0ED")
EventMisc2.button[98] = guiCreateButton(330, 508, 111, 27, "Disable DM", false, Event.window[1])
guiSetProperty(EventMisc2.button[98], "NormalTextColour", "FF858771")
EventMisc2.button[4] = guiCreateButton(330, 472, 111, 29, "Disable Fire", false, Event.window[1])
guiSetProperty(EventMisc2.button[4], "NormalTextColour", "FF858771")
EventMisc2.button[5] = guiCreateButton(217, 327, 132, 26, "Create object", false, Event.window[1])
guiSetProperty(EventMisc2.button[5], "NormalTextColour", "FFF69F08")
EventMisc2.button[6] = guiCreateButton(217, 221, 134, 27, "Fix Vehicles", false, Event.window[1])
guiSetProperty(EventMisc2.button[6], "NormalTextColour", "FF29EA0F")
EventMisc2.button[7] = guiCreateButton(217, 258, 134, 27, "Blow Vehicles", false, Event.window[1])
guiSetProperty(EventMisc2.button[7], "NormalTextColour", "FFF11409")
EventMisc2.button[8] = guiCreateButton(217, 472, 111, 29, "Enable Fire", false, Event.window[1])
guiSetProperty(EventMisc2.button[8], "NormalTextColour", "FF0BF0ED")

EventMisc2.label[1] = guiCreateLabel(473, 330, 108, 27, "Weapon rules", false, Event.window[1])
guiSetFont(EventMisc2.label[1], "default-bold-small")
guiLabelSetColor(EventMisc2.label[1], 39, 239, 12)
guiLabelSetHorizontalAlign(EventMisc2.label[1], "center", false)
guiLabelSetVerticalAlign(EventMisc2.label[1], "center")


bindKey ( "O", "Down",function()
	if exports.CSGstaff:isPlayerStaff(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Staff" then
		if not guiGetVisible(Event.window[1]) then
			guiSetVisible(Event.window[1],true)
			showCursor(true)
			guiSetInputMode("no_binds_when_editing")
		else
			guiSetVisible(Event.window[1],false)
			showCursor(false)
			guiSetInputMode("allow_binds")
		end
		forcetoShowList2()
	end
end)

addCommandHandler("event",function()
	if exports.CSGstaff:isPlayerStaff(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Staff" and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 2  then
		if not guiGetVisible(Event.window[1]) then
			guiSetVisible(Event.window[1],true)
			showCursor(true)
		else
			guiSetVisible(Event.window[1],false)
			showCursor(false)
		end
		forcetoShowList2()
	end
end)





addEventHandler("onClientGUIClick",root,function()
	if source == Event.edit[1] or source == Event.edit[2] or source == Event.edit[3] or source == Event.edit[4] or source == Event.edit[5] or source == Event.edit[6] or source == Event.edit[7] then
		guiSetText(source,"")
	end
end)

addEventHandler("onClientGUIClick",root,function()
	if source == EventMisc2.button[1] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onEnableWeapons", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == EventMisc2.button[2] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onDisableWeapons", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == EventMisc2.button[3] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local weaponsAllowed = getWeaponsTable()
		triggerServerEvent( "onSetAllowedWeapons", localPlayer, exports.server:getPlayerAccountName(),weaponsAllowed )
	elseif source == EventMisc2.button[5] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		guiSetVisible(Event.window[1],false)
		guiSetVisible(EventObjectsPanel.window[1],true)
	elseif source == EventMisc2.button[94] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onToggleVehGhost", localPlayer, exports.server:getPlayerAccountName(),false )
	elseif source == EventMisc2.button[95] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onToggleVehGhost", localPlayer, exports.server:getPlayerAccountName(),true )
	elseif source == EventMisc2.button[96] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onToggleGhost", localPlayer, exports.server:getPlayerAccountName(),false )
	elseif source == EventMisc2.button[97] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onToggleGhost", localPlayer, exports.server:getPlayerAccountName(),true )
	elseif source == EventMisc2.button[98] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onToggleDM", localPlayer, exports.server:getPlayerAccountName(),false )
	elseif source == EventMisc2.button[99] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onToggleDM", localPlayer, exports.server:getPlayerAccountName(),true )
	elseif source == EventMisc2.button[4] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onDisableFire", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == EventMisc2.button[7] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onBlowEMVehicles", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == EventMisc2.button[6] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onFixEMVehicles", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == EventMisc2.button[8] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onEnableFire", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == Event.button[1] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local customWarp = guiGetText(Event.edit[1])
		local eventName = guiGetText(Event.edit[2])
		local dim = guiGetText(Event.edit[4])
		local warps = guiGetText(Event.edit[5])
		local int = getElementInterior(localPlayer)
		if ( string.match( warps ,'^%d+$' ) ) and ( string.match( int,'^%d+$' ) ) and ( string.match( dim,'^%d+$' ) ) then
			if guiRadioButtonGetSelected(Event.radiobutton[2]) then
				triggerServerEvent("onCreateEvent",localPlayer,eventName,dim,int,warps,nil)
			elseif guiRadioButtonGetSelected(Event.radiobutton[1]) then
				triggerServerEvent("onCreateEvent",localPlayer,eventName,dim,int,warps,customWarp)
			elseif guiRadioButtonGetSelected(Event.radiobutton[5]) then
				triggerServerEvent("onCreateEvent",localPlayer,eventName,dim,int,warps,"Law")
			end
		else
			exports.NGCdxmsg:createNewDxMessage( "Not all fields are filled in right!", 225, 0, 0 )
		end
	elseif source == Event.button[18] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("stopEventWithoutKill",localPlayer,localPlayer)
	elseif source == Event.button[2] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("stopEvent",localPlayer,localPlayer)
	elseif source == Event.button[3] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("unFrozen",localPlayer)
	elseif source == Event.button[13] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("Frozen",localPlayer)
	elseif source == Event.button[4] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onDestroyEMVehicles", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == Event.button[5] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local theVehicle = guiGetText( Event.edit[3] )
		if ( theVehicle ) and not ( theVehicle == "" ) and not ( theVehicle == " " ) then
			triggerServerEvent( "onEMVehicleMarker", localPlayer, theVehicle )
		else
			exports.NGCdxmsg:createNewDxMessage( "There is no vehicle found with this name!", 225, 0, 0 )
		end
	elseif source == Event.button[6] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local thePlayer = guiGridListGetItemText(Event.gridlist[1], guiGridListGetSelectedItem(Event.gridlist[1]), 1)
		if ( isElement( getPlayerFromName( thePlayer ) ) ) then
			local theMoney = guiGetText( Event.edit[6] )
			if ( string.match( theMoney ,'^%d+$' ) ) then
				triggerServerEvent( "onGiveEventMoney", localPlayer, getPlayerFromName( thePlayer ), tonumber(theMoney) )
			else
				exports.NGCdxmsg:createNewDxMessage( "The money amount must be a number!", 225, 0, 0 )
			end
		else
			exports.NGCdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
		end
	elseif source == Event.button[7] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local thePlayer = guiGridListGetItemText(Event.gridlist[1], guiGridListGetSelectedItem(Event.gridlist[1]), 1)
		if ( isElement( getPlayerFromName( thePlayer ) ) ) then
			local theScore = guiGetText(Event.edit[7])
			if ( theScore == "" ) or ( theScore == " " ) or type(tonumber(theScore)) ~= "number" then
				exports.NGCdxmsg:createNewDxMessage( "You didn't enter a valid score!", 225, 0, 0 )
			else
				exports.NGCdxmsg:createNewDxMessage("Event: You have given "..thePlayer.." "..theScore.." score!",0,255,0)
				triggerServerEvent("giveEventScore",localPlayer,getPlayerFromName( thePlayer ),theScore)
			end
		else
			exports.NGCdxmsg:createNewDxMessage( "You didn't select a player!", 225, 0, 0 )
		end
	elseif source == Event.button[8] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("countForTheEvent",localPlayer)
	elseif source == Event.button[9] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent( "onDestroyEMVehicleMarker", localPlayer, exports.server:getPlayerAccountName() )
	elseif source == Event.button[10] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		if guiRadioButtonGetSelected(Event.radiobutton[3]) then
			pickupType = "health"
			triggerServerEvent( "onCreateEMPickup", localPlayer, pickupType )
		elseif guiRadioButtonGetSelected(Event.radiobutton[4]) then
			pickupType = "armor"
			triggerServerEvent( "onCreateEMPickup", localPlayer, pickupType )
		else
			exports.NGCdxmsg:createNewDxMessage( "Wrong pickup model! (Use: health or armor)", 225, 0, 0 )
		end
	elseif source == Event.button[11] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("onDestroyEMPickup",localPlayer)
	elseif source == Event.button[16] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("freezeEMVehicles",localPlayer,exports.server:getPlayerAccountName())
	elseif source == Event.button[17] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		triggerServerEvent("unfreezeEMVehicles",localPlayer,exports.server:getPlayerAccountName())
	elseif source == Event.button[14] then
		triggerServerEvent("onDestroyEMEvent",localPlayer)
	elseif source == Event.button[15] then
		if isTimer(antiSpam[source]) then exports.NGCdxmsg:createNewDxMessage("Please wait 5 seconds don't spam the bottons",255,0,0) return false end
		antiSpam[source] = setTimer(function() end,3000,1)
		local customWarp = guiGetText(Event.edit[1])
		local eventName = guiGetText(Event.edit[2])
		local dim = guiGetText(Event.edit[4])
		local warps = guiGetText(Event.edit[5])
		local int = getElementInterior(localPlayer)
		if ( string.match( warps ,'^%d+$' ) ) and ( string.match( int,'^%d+$' ) ) and ( string.match( dim,'^%d+$' ) ) then
			if guiRadioButtonGetSelected(Event.radiobutton[2]) then
				triggerServerEvent("onEMCreateMulti",localPlayer,eventName,dim,int,warps,nil)
			elseif guiRadioButtonGetSelected(Event.radiobutton[1]) then
				triggerServerEvent("onEMCreateMulti",localPlayer,eventName,dim,int,warps,customWarp)
			elseif guiRadioButtonGetSelected(Event.radiobutton[5]) then
				triggerServerEvent("onEMCreateMulti",localPlayer,eventName,dim,int,warps,"Law")
			end
		else
			exports.NGCdxmsg:createNewDxMessage( "Not all fields are filled in right!", 225, 0, 0 )
		end
	elseif source == Event.button[12] then
		guiSetVisible(Event.window[1],false)
		showCursor(false)
	end
end)


function forcetoShowList2()
	guiGridListClear(Event.gridlist[1])
    for key, player in ipairs(getElementsByType("player")) do
		if player ~= localPlayer then
			local name = getPlayerName(player)
			local row = guiGridListAddRow(Event.gridlist[1])
			if getPlayerTeam(player) then
				local r,g,b = getTeamColor(getPlayerTeam(player))
				if name then
					guiGridListSetItemText(Event.gridlist[1], row, 1, getPlayerName(player), false, false)
					guiGridListSetItemColor (Event.gridlist[1], row, 1, r, g, b )
				end
			end
        end
    end
end


local screenWidth, screenHeight = guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()
rectangleAlpha = 170
rectangleAlpha2 = 170
textAlpha = 255
textAlpha2 = 255
local screenW, screenH = guiGetScreenSize()

function drawCounts()
	--if not imagecount then
	if not isElement(imagecount) then
		windowWidth, windowHeight = 250,190
		windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
		imagecount = guiCreateStaticImage (windowX, windowY, windowWidth, windowHeight,"images/3.png",false)
	else
		guiSetVisible(imagecount,true)
		guiStaticImageLoadImage ( imagecount, "images/3.png" )
	end
	setTimer ( function()
	if not isElement(imagecount) then return false end
	guiStaticImageLoadImage ( imagecount, "images/2.png" )
	setTimer ( function()
	if not isElement(imagecount) then return false end
	guiStaticImageLoadImage ( imagecount, "images/1.png" )
	setTimer ( function()
	if not isElement(imagecount) then return false end
	guiStaticImageLoadImage ( imagecount, "images/go.png" )
	setTimer(function()
	if not isElement(imagecount) then return false end
	guiSetVisible(imagecount,false)
	if isElement(imagecount) then destroyElement(imagecount) end
	end, 1000, 1 )
	end, 1000, 1 )
	end, 1000, 1 )
	end, 1000, 1 )
end
addEvent("drawEventCount",true)
addEventHandler("drawEventCount",root,drawCounts)

addEvent("setWeapons",true)
addEventHandler("setWeapons",root,function(weps)
	setWeaponSlotDisabled(1, not weps[1]) -- knfie katana
    setWeaponSlotDisabled(2, not weps[2]) -- dealge
    setWeaponSlotDisabled(3, not weps[3]) -- shotgun
    setWeaponSlotDisabled(4, not weps[4]) -- mp5
    setWeaponSlotDisabled(5, not weps[5]) -- m4
    setWeaponSlotDisabled(6, not weps[6]) --- rifles
    setWeaponSlotDisabled(7, not weps[7]) --- minigun
    setWeaponSlotDisabled(8, not weps[8])
end)

addEvent("disableWeapons",true)
addEventHandler("disableWeapons",root,function(weps)
	setWeaponSlotDisabled(1,true)
	setWeaponSlotDisabled(2,true)
	setWeaponSlotDisabled(3,true)
	setWeaponSlotDisabled(4,true)
	setWeaponSlotDisabled(5,true)
	setWeaponSlotDisabled(6,true)
	setWeaponSlotDisabled(7,true)
	setWeaponSlotDisabled(8,true)
end)

addEvent("enableWeapons",true)
addEventHandler("enableWeapons",root,function()
	setWeaponSlotDisabled(1, false)
    setWeaponSlotDisabled(2, false)
    setWeaponSlotDisabled(3, false)
    setWeaponSlotDisabled(4, false)
    setWeaponSlotDisabled(5, false)
    setWeaponSlotDisabled(6, false)
    setWeaponSlotDisabled(7, false)
    setWeaponSlotDisabled(8, false)
end)

addEvent("toggleANTIDM",true)
addEventHandler("toggleANTIDM",root,function(tbl,stats)
	setElementData(root, "eventDamageToggle", stats)
end)


addEvent("toggleGhost",true)
addEventHandler("toggleGhost",root,function(tbl,stats)
	if stats == true then
		for index,player in ipairs(tbl) do --LOOP through all Vehicles
			setElementCollidableWith(player, localPlayer, false) -- Set the Collison off with the Other vehicles.
		end
	else
		for index,player in ipairs(tbl) do --LOOP through all Vehicles
			setElementCollidableWith(player, localPlayer, true) -- Set the Collison off with the Other vehicles.
		end
	end
end)


addEvent("addVehGhost",true)
addEventHandler("addVehGhost",root,function(s,stats)
	if stats == true then
		disableCollisions(s)
	else
		enableCollisions(s)
	end
end)


function enableCollisions(v)
	for i,veh in ipairs(getElementsByType("vehicle")) do
		setElementCollidableWith(v, veh, true)
	end
end

function disableCollisions(v)
	for i,veh in ipairs(getElementsByType("vehicle")) do
		setElementCollidableWith(v, veh, false)
	end
end


function dm(atk)
	if atk and getElementType(atk) == "player" then
		if getPlayerTeam(atk) and getTeamName(getPlayerTeam(atk)) == "Staff" then
			return
		end
	elseif atk and getElementType(atk) == "vehicle" then
		local atk = getVehicleController(atk) or atk
		if getPlayerTeam(atk) and getTeamName(getPlayerTeam(atk)) == "Staff" then
			return
		end
	end
	cancelEvent()
end

weapons = {
	[1] = {2, 3, 4, 5, 6, 7, 8, 9},
	[2] = {22, 23, 24},
	[3] = {25, 26, 27},
	[4] = {28, 29, 32},
	[5] = {30, 31},
	[6] = {33, 34},
	[7] = {35, 36, 37, 38},
	[8] = {16, 17, 18, 39},
	[9] = {41, 42, 43},
	[10] = {10, 11, 12, 13, 14, 15},
	[11] = {44, 45, 46},
	[12] = {40},
}

function getWeaponsTable()
	local weaponsTable = {}
	for i=1,8 do
		weaponsTable[i] = guiCheckBoxGetSelected(EventMisc2.checkbox[i])
	end
	return weaponsTable
end


restrictedWeapons = {}

function onClientPreRender()
	if getElementData(localPlayer,"isPlayerInEvent") then
		local weapon = getPedWeapon(localPlayer)
		local slot = getPedWeaponSlot(localPlayer)
		if (restrictedWeapons[weapon]) then
			local weapons = {}
			for i=1, 30 do
				if (getControlState("next_weapon")) then
					slot = slot + 1
				else
					slot = slot - 1
				end
				if (slot == 13) then
					slot = 0
				elseif (slot == -1) then
					slot = 12
				end
				if isWeaponDisabled(weapon) then
					setPedWeaponSlot(localPlayer, slot)
				end
				local w = getPedWeapon(localPlayer, slot)
				if (((w ~= 0 and slot ~= 0) or (w == 0 and slot == 0)) and not restrictedWeapons[w]) then
					setPedWeaponSlot(localPlayer, slot)
					break
				end
			end
		end
		local block, animation = getPedAnimation(localPlayer)
		if block then
			setPedAnimation(localPlayer,false)
		end
	end
end
addEventHandler("onClientPreRender", root, onClientPreRender)

function onClientPlayerWeaponFire(weapon)
	if (restrictedWeapons[weapon]) then return end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onClientPlayerWeaponFire)


function setWeaponDisabled(id, bool)
	if (id == 0) then return end
	restrictedWeapons[id] = bool
end

function isWeaponDisabled(id)
	return restrictedWeapons[id]
end

function setWeaponSlotDisabled(slot, bool)
	if (not weapons[slot]) then return end
	for k, v in ipairs(weapons[slot]) do
		setWeaponDisabled(v, bool)
	end
end
