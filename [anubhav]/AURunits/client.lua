local screenW, screenH = guiGetScreenSize()
local gui_elements = {}
local buttons = {}

local unitName = guiCreateEdit(0.36, 0.29, 0.12, 0.025, "Unit name...", true)

local manageButton = guiCreateButton(0.35, 0.71, 0.30, 0.03, "", true)
local closeButton = guiCreateButton(0.35, 0.76, 0.30, 0.03, "", true)
local createUnit = guiCreateButton(0.49, 0.29, 0.07, 0.02, "", true)
local deleteUnit = guiCreateButton(0.56, 0.29, 0.07, 0.02, "", true)
local inviteButton = guiCreateButton(0.36, 0.63, 0.13, 0.03, "", true)
local inviteGridlist = guiCreateGridList(0.355, 0.37, 0.135, 0.25, true)
guiGridListAddColumn(inviteGridlist, "Invites", 0.9)    

local gui_elements = {unitName, manageButton, closeButton, createUnit, deleteUnit}
local buttons = {manageButton, closeButton, createUnit, deleteUnit, inviteButton}
local invite_elements = {inviteButton, inviteGridlist}

local textLeaveDelete = "Delete Unit"
local textFirstColumn = "Unit Members"
local textUnitName = ""
local textMembers = ""
local textInformation = {
	['cdate'] = "",
	['memberc'] = "",
	['maxmember'] = "5",
	['bonus'] = "",
}

for i=1, #gui_elements do
	guiSetVisible(gui_elements[i], false)
end

for i=1, #invite_elements do
	guiSetVisible(invite_elements[i], false)
end

local function placeholder_function()
	if (eventName == "onClientGUIFocus") then
		local newText = guiGetText(source)
		if (newText == getElementData(source, "place_holder")) then
			guiSetText(source, "")
		end
	else
		if (guiGetText(source) == "") then
			guiSetText(source, getElementData(source, "place_holder"))
		end
	end
end

local function set_placeholder(guiElement)
	addEventHandler("onClientGUIFocus", guiElement, placeholder_function, true)
	addEventHandler("onClientGUIBlur", guiElement, placeholder_function, true)
	setElementData(guiElement, "place_holder", guiGetText(guiElement), false)
end
set_placeholder(unitName)

local function getAlpha(btn)
	if (guiGetEnabled(btn)) then
		return 255
	end

	return 200
end

local function dxMainUnit()
	dxDrawRectangle(screenW * 0.3492, screenH * 0.2167, screenW * 0.3023, screenH * 0.5681, tocolor(0, 0, 0, 175), false)
	dxDrawRectangle(screenW * 0.3492, screenH * 0.2167, screenW * 0.3023, screenH * 0.0375, tocolor(0, 0, 0, 175), false)
	dxDrawText("AuroraRPG - Units", screenW * 0.3492, screenH * 0.2167, screenW * 0.6516, screenH * 0.2542, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Unit: "..textUnitName, screenW * 0.3594, screenH * 0.2542, screenW * 0.6438, screenH * 0.2903, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Bonus is increased by member count", screenW * 0.3578, screenH * 0.6833, screenW * 0.6438, screenH * 0.7111, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3492, screenH * 0.7556, screenW * 0.3016, screenH * 0.0292, tocolor(0, 0, 0, 175), false)
	dxDrawText("Close", screenW * 0.3484, screenH * 0.7569, screenW * 0.6516, screenH * 0.7847, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3492, screenH * 0.7125, screenW * 0.3016, screenH * 0.0292, tocolor(0, 0, 0, 175), false)
	dxDrawText("Manage Members", screenW * 0.3492, screenH * 0.7111, screenW * 0.6523, screenH * 0.7389, tocolor(255, 255, 255, getAlpha(manageButton)), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.4875, screenH * 0.2903, screenW * 0.0695, screenH * 0.0236, tocolor(0, 0, 0, 175), false)
	dxDrawText("Create Unit", screenW * 0.4875, screenH * 0.2903, screenW * 0.5570, screenH * 0.3153, tocolor(255, 255, 255, getAlpha(createUnit)), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.5648, screenH * 0.2903, screenW * 0.0695, screenH * 0.0236, tocolor(0, 0, 0, 175), false)
	dxDrawText(textLeaveDelete, screenW * 0.5648, screenH * 0.2889, screenW * 0.6344, screenH * 0.3139, tocolor(255, 255, 255, getAlpha(deleteUnit)), 1.00, "default-bold", "center", "center", false, false, false, false, false)     
	dxDrawText(textMembers, screenW * 0.3570, screenH * 0.3736, screenW * 0.4719, screenH * 0.6694, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, true, false)
	--dxDrawText(textFirstColumn, screenW * 0.3570, screenH * 0.3458, screenW * 0.4719, screenH * 0.3653, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
	dxDrawText(textFirstColumn, screenW * 0.3531, screenH * 0.3417, screenW * 0.4945, screenH * 0.3639, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)   
	dxDrawText("Member Count: "..textInformation['memberc'].."\n\nMax Member Count: "..textInformation['maxmember'].."\n\nCurrent Bonus: "..textInformation['bonus'].."", screenW * 0.5289, screenH * 0.3736, screenW * 0.6438, screenH * 0.6694, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, true, false)
	dxDrawText("Information", screenW * 0.5289, screenH * 0.3458, screenW * 0.6438, screenH * 0.3653, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
end

local function dxInvites()
	dxDrawRectangle(screenW * 0.3555, screenH * 0.6347, screenW * 0.1336, screenH * 0.0250, tocolor(0, 0, 0, 175), false)
	dxDrawText("Accept Invite", screenW * 0.3555, screenH * 0.6333, screenW * 0.4891, screenH * 0.6597, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
end

local function openMap()
	if (markMap) then
		return false
	end
	markMap = guiCreateStaticImage((screenW - 1080) / 2, (screenH - 1080) / 2, 1080, 1080, "map-hd.png", false)
	addEventHandler("onClientGUIClick", markMap, chosenMap)
	guiSetVisible(markMap, false)
end

function toggleGui()
	local newVisibility = (not guiGetVisible(gui_elements[1]))

	if (newVisibility) then
		addEventHandler("onClientRender", root, dxMainUnit)
	else
		removeEventHandler("onClientRender", root, dxMainUnit)

		local isVis = guiGetVisible(invite_elements[1])
		for i=1, #invite_elements do
			guiSetVisible(invite_elements[i], false)
		end

		if (isVis) then
			removeEventHandler("onClientRender", root, dxInvites)
		end
	end

	guiSetInputMode((newVisibility and "no_binds_when_editing" or "allow_binds"))
	showCursor(newVisibility)

	for i=1, #gui_elements do
		guiSetVisible(gui_elements[i], newVisibility)
	end
end 

local function handleMainButtons(b)
	if (b ~= "left") then
		return false 
	end

	if (source == closeButton) then
		toggleGui()
	end

	if (source == createUnit) then
		local text = guiGetText(unitName)

		if (text == "") then
			return outputChatBox("Unit name cannot be a blank", 255, 255, 0)
		end

		if (text == getElementData(unitName, "place_holder")) then
			return outputChatBox("Please enter a unit name", 255, 255, 0)
		end

		if (text:gsub("%s+", "") ~= text) then
			return outputChatBox("Whitespaces are NOT allowed", 255, 255, 0)
		end

		triggerLatentServerEvent("AURunits.createUnit", 5000, false, resourceRoot, text)
		toggleGui()
	end 

	if (source == deleteUnit) then
		triggerLatentServerEvent("AURunits.deleteUnit", 5000, false, resourceRoot)
		toggleGui()
	end

	if (source == manageButton) then
		toggleGui()
		triggerLatentServerEvent("AURunits.manageMembers", 5000, false, resourceRoot)
	end

	if (source == inviteButton) then
		if (guiGetVisible(inviteGridlist)) then
			local r = guiGridListGetSelectedItem(inviteGridlist)

			if (r == -1) then
				return outputChatBox("You need to choose a unit first!", 255, 255, 0)
			end

			triggerLatentServerEvent("AURunits.acceptInvite", 5000, false, resourceRoot, guiGridListGetItemText(inviteGridlist, r, 1))
		end
	end
end

for i=1, #buttons do
	guiSetAlpha(buttons[i], 0.00)
	addEventHandler("onClientGUIClick", buttons[i], handleMainButtons, false)
end

local function showInvites()
	addEventHandler("onClientRender", root, dxInvites)
	for i=1, #invite_elements do
		guiSetVisible(invite_elements[i], true)
	end
end

local function handleGuiLoading(unit, member, founder, k, invites, bonus)
	textUnitName = unit

	if (unit == "") then
		guiSetEnabled(deleteUnit, false)
		guiSetEnabled(manageButton, false)
		guiSetEnabled(createUnit, true)

		textUnitName = "Not in a unit"
		textLeaveDelete = "Delete Unit"
		textMembers = "N/A"
		textFirstColumn = "Invites"

		textInformation['cdate'] = "N/A"
		textInformation['memberc'] = "N/A"
		textInformation['bonus'] = "N/A"

		showInvites()

		guiGridListClear(inviteGridlist)

		for i, v in ipairs(invites) do
			guiGridListAddRow(inviteGridlist, v['unit'])
		end
	else
		guiSetEnabled(deleteUnit, true)
		guiSetEnabled(manageButton, (k == founder and true or false))
		guiSetEnabled(createUnit, false)

		textFirstColumn = "Unit Members"
		textLeaveDelete = (k == founder and "Delete Unit" or "Leave Unit")
		textMembers = ""

		for i, v in ipairs(member) do
			if (founder == v['member']) then
				textMembers = textMembers.."\n"..v['member2'].. " #ffffff(Founder)"
			else
				textMembers = textMembers.."\n"..v['member2']
			end
		end

		textInformation['cdate'] = "W.I.P"
		textInformation['memberc'] = tostring(#member)

		textInformation['bonus'] = tostring(bonus) .. "%"
	end
	toggleGui()
end
addEvent("AURunits.loadUnitPanel", true)
addEventHandler("AURunits.loadUnitPanel", resourceRoot, handleGuiLoading)

function getUnitOnlineMembers()
	local unit = getElementData(localPlayer, "Unit Name")
	if (unit == "") then
		return {}
	end
	local unitMembers = {}
	for i, v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "Unit Name") == unit) then
			table.insert(unitMembers, v)
		end
	end
	return unitMembers
end

function selectUnitBlip()
	removeEventHandler("onClientRender", root, doMapChecks)
	if (isCursorShowing()) then
		forcePlayerMap(false)
		showCursor(false)
		return true
	end
	forcePlayerMap(true)
	showCursor(true)
	addEventHandler("onClientRender", root, doMapChecks)
end
addEvent("AURunits.selectMapBlip", true)
addEventHandler("AURunits.selectMapBlip", resourceRoot, selectUnitBlip)

local mouseDown, f11OffsetX, f11OffsetY, mouseX, mouseY, lastMouseX, lastMouseY = false, 0, 0, 0, 0, 0, 0
local f11PositionDivisor = (1080 / 6000)

function chosenMap(btn, state, x, y)
	if (btn ~= "left") then
		return false
	end
	--guiSetVisible(markMap, false)
	--showCursor(false)
	forcePlayerMap(false)
	showCursor(false)
	triggerServerEvent("AURunits.markMapLocation", resourceRoot, x, y)
end

local screenSize = Vector2(guiGetScreenSize())

function doMapChecks()
	forcePlayerMap(true)
	local isLeftMouseButtonPressed = getKeyState("mouse1")
	if (isLeftMouseButtonPressed) then
		-- Get the cursor and map bounding box positions
		local cursorPos, mapMin, mapMax = Vector2(getCursorPosition())

		-- Transform the relative cursor position to absolute position
		cursorPos.x, cursorPos.y = cursorPos.x * screenSize.x, cursorPos.y * screenSize.y
		-- Calculate our map points vectors inside a block to delete intermediate variables automatically
		do
			local mx, my, Mx, My = getPlayerMapBoundingBox()
			mapMin = Vector2(mx, my)
			mapMax = Vector2(Mx, My)
		end

		-- If the cursor is inside the map rectangle, create or update the target blip
		-- Otherwise, just ignore the click
		if cursorPos.x >= mapMin.x and cursorPos.y >= mapMin.y and cursorPos.x <= mapMax.x and cursorPos.y <= mapMax.y then
			-- Get the relative position (in range [0, 1]) of the mouse click point from the mapMin point
			-- 0 in a direction means that the cursor is in mapMin in that direction
			-- 1 in a direction means that the cursor is in mapMax in that direction
			local relPos = Vector2((cursorPos.x - mapMin.x) / (mapMax.x - mapMin.x), (cursorPos.y - mapMin.y) / (mapMax.y - mapMin.y))

			-- Translate that relative position to 2D world coordinates
			-- Assumes the world map is a square whose side is 6000 units long
			local worldPlanePos = Vector2(6000 * (relPos.x - 0.5), 3000 - (relPos.y * 6000))

			-- Get a 3D world position by adding the highest ground Z coordinate, which is what we usually want
			-- Note that only the blip ID 0 (marker) uses this additional coordinate. For the rest of blips, we could pass a dummy value instead
			local worldPos = Vector3(worldPlanePos.x, worldPlanePos.y, getGroundPosition(worldPlanePos.x, worldPlanePos.y, 3000))
			chosenMap("left", "press", worldPos.x, worldPos.y, worldPos.z)
			removeEventHandler("onClientRender", root, doMapChecks)
			return true
		end
	end
end