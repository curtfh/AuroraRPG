local isMoving = false
local refreshTimer = false
local refreshPos = 0.2
local selectedElement = false

function calledByCommand()
	if (getTeamName(getPlayerTeam(localPlayer)) ~= "Staff") then return end
	if (isMoving == false) then
		showCursor(true)
		addEventHandler("onClientClick", root, startMoveElement)
		isMoving = true
	else
		if (isTimer(refreshTimer)) then return end
		showCursor(false)
		removeEventHandler("onClientClick", root, startMoveElement)
		isMoving = false
	end
end
addCommandHandler("wandpower", calledByCommand)

function startMoveElement(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if (not clickedElement) then return end
	if (clickedElement == localPlayer) then return end
	if (not (getElementType(clickedElement) == "vehicle" or getElementType(clickedElement) == "player")) then return end
	if (button == "left") then 
		selectedElement = clickedElement
		triggerServerEvent("onStaffMovingElement", localPlayer, clickedElement)
		addEventHandler("onClientRender", root, attachToMouse)
		removeEventHandler("onClientClick", root, startMoveElement)
		addEventHandler("onClientClick", root, stopMoveElement)
		addEventHandler("onClientElementDestroy", clickedElement, stopMoveElement)
		refreshTimer = setTimer(updateMovement, refreshPos * 1000, 0)
	elseif (button == "right") then 
		if (getElementType(clickedElement) == "vehicle") then 
			triggerServerEvent("desEle", localPlayer, clickedElement)
			selectedElement = false
			showCursor(false)
			isMoving = false
		elseif (getElementType(clickedElement) == "player") then 
			triggerServerEvent("killPlrNowLol", localPlayer, clickedElement)
			selectedElement = false
			showCursor(false)
			isMoving = false
		end 
	end
end

function attachToMouse()
	local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
	local px, py, pz = getCameraMatrix()
	local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz)
	local x0, y0, z0, x1, y1, z1 = getElementBoundingBox(selectedElement)
	if (hit) then
		setElementPosition(selectedElement, x, y, z + (z1-z0))
	else
		setElementPosition(selectedElement, worldx, worldy, worldz + (z1-z0))
	end
end

function updateMovement()
	local x, y, z = getElementPosition(selectedElement)
	triggerServerEvent("onMovementUpdate", localPlayer, selectedElement, x, y, z)
end

function stopMoveElement()
	killTimer(refreshTimer)
	removeEventHandler("onClientRender", root, attachToMouse)
	removeEventHandler("onClientClick", root, stopMoveElement)
	removeEventHandler("onClientElementDestroy", selectedElement, stopMoveElement)
	updateMovement(selectedElement)
	triggerServerEvent("onStaffStopMovingElement", localPlayer, selectedElement)
	selectedElement = false
	showCursor(false)
	isMoving = false
end