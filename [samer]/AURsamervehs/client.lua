local sx, sy = guiGetScreenSize()
local sx = sx/1366
local sy = sy/768
local markers = getMarkersTable()
local jM2jN = {}

for k, v in ipairs (markers) do
-- Markers creation.
	local jMarker = createMarker(v.x, v.y, v.z - 1, "cylinder", 1.5, v.r, v.g, v.b, 255)
	jM2jN[jMarker] = k
end

addEventHandler("onClientRender", root,
    function()
		if (isElement(tempVeh)) then
			dxDrawText("Vehicle Name: "..getVehicleName(tempVeh), sx*900 - 1, sy*397 - 1, sx*1362 - 1, sy*449 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Vehicle Name: "..getVehicleName(tempVeh), sx*900 + 1, sy*397 - 1, sx*1362 + 1, sy*449 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Vehicle Name: "..getVehicleName(tempVeh), sx*900 - 1, sy*397 + 1, sx*1362 - 1, sy*449 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Vehicle Name: "..getVehicleName(tempVeh), sx*900 + 1, sy*397 + 1, sx*1362 + 1, sy*449 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Vehicle Name: "..getVehicleName(tempVeh), sx*900, sy*397, sx*1362, sy*449, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Max speed: "..math.floor(getVehicleHandling(tempVeh).maxVelocity/1.7), sx*900 - 1, sy*459 - 1, sx*1362 - 1, sy*511 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Max speed: "..math.floor(getVehicleHandling(tempVeh).maxVelocity/1.7), sx*900 + 1, sy*459 - 1, sx*1362 + 1, sy*511 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Max speed: "..math.floor(getVehicleHandling(tempVeh).maxVelocity/1.7), sx*900 - 1, sy*459 + 1, sx*1362 - 1, sy*511 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Max speed: "..math.floor(getVehicleHandling(tempVeh).maxVelocity/1.7), sx*900 + 1, sy*459 + 1, sx*1362 + 1, sy*511 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Max speed: "..math.floor(getVehicleHandling(tempVeh).maxVelocity/1.7), sx*900, sy*459, sx*1362, sy*511, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Press backspace to close.", sx*900 - 1, sy*521 - 1, sx*1362 - 1, sy*573 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Press backspace to close.", sx*900 + 1, sy*521 - 1, sx*1362 + 1, sy*573 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Press backspace to close.", sx*900 - 1, sy*521 + 1, sx*1362 - 1, sy*573 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Press backspace to close.", sx*900 + 1, sy*521 + 1, sx*1362 + 1, sy*573 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Press backspace to close.", sx*900, sy*521, sx*1362, sy*573, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Use left and right arrows to navigate.", sx*900 - 1, sy*583 - 1, sx*1362 - 1, sy*635 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Use left and right arrows to navigate.", sx*900 + 1, sy*583 - 1, sx*1362 + 1, sy*635 - 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Use left and right arrows to navigate.", sx*900 - 1, sy*583 + 1, sx*1362 - 1, sy*635 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Use left and right arrows to navigate.", sx*900 + 1, sy*583 + 1, sx*1362 + 1, sy*635 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
			dxDrawText("Use left and right arrows to navigate.", sx*900, sy*583, sx*1362, sy*635, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
		end
	end
)

function onHit(hElem, mDim)
	if mDim and jM2jN[source] and (localPlayer == hElem) and (not getPedOccupiedVehicle(hElem)) and (isPedOnGround(localPlayer)) then
		if (getElementData(localPlayer, "wantedPoints") > 20) then
			exports.NGCdxmsg:createNewDxMessage("You cannot take free a vehicle if you are wanted!", 255, 255, 255)
		return false end
		currentMarker = source
		setElementAlpha(source, 0)
		local occupation = markers[jM2jN[source]].occupation
		x, y, z = markers[jM2jN[source]].x, markers[jM2jN[source]].y, markers[jM2jN[source]].z
		vehicles = markers[jM2jN[source]].vehicles
		rx, ry, rz = markers[jM2jN[source]].rx, markers[jM2jN[source]].ry, markers[jM2jN[source]].rz
		r, g, b = markers[jM2jN[source]].r, markers[jM2jN[source]].g, markers[jM2jN[source]].b
		local cx, cy, cz = markers[jM2jN[source]].cx, markers[jM2jN[source]].cy, markers[jM2jN[source]].cz
		if (occupation == "None") or (getElementData(getRandomPlayer(), "Occupation") == occupation) or (getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Staff") then
			setCameraMatrix(cx, cy, cz, x, y, z)
			tempVeh = createVehicle(getVehicleModelFromName(vehicles[1]), x, y, z+1.5, rx, ry, rz)
			currentIndex = 1
			setTimer(function()
				setVehicleColor(tempVeh, r, g, b)
			end, 400, 1)
			setElementPosition(localPlayer, cx, cy, cz)
			setElementFrozen(localPlayer, true)
			guiSetInputMode("no_binds") 
			setElementFrozen(tempVeh, true)
		end
	end
end
addEventHandler("onClientMarkerHit", root, onHit)

function switchToNext(button, pressed)
	if (isElement(tempVeh)) then
		if (button == "arrow_r") and (pressed) then
			if (currentIndex == #vehicles) then
				currentIndex = 1
			else
				currentIndex = currentIndex + 1
			end
			setElementModel(tempVeh, getVehicleModelFromName(vehicles[currentIndex]))
		end
		if (button == "arrow_l") and (pressed) then
			if (currentIndex == 1) then
				currentIndex = #vehicles
			else
				currentIndex = currentIndex - 1
			end
			setElementModel(tempVeh, getVehicleModelFromName(vehicles[currentIndex]))
		end
	end
end
addEventHandler("onClientKey", root, switchToNext)

function spawnCar(button, pressed)
	if (isElement(tempVeh)) then
		if (button == "enter") and (pressed) then
			local vehName = getVehicleName(tempVeh)
			setPedAnimation(localPlayer, false)
			destroyElement(tempVeh)
			setElementAlpha(currentMarker, 255)
			guiSetInputMode("allow_binds") 
			setCameraTarget(localPlayer)
			triggerServerEvent("AURspawners.spawnMarkerCar", resourceRoot, localPlayer, vehName, x, y, z, rx, ry, rz, r, g, b)
		end
		if (button == "backspace") and (pressed) then
			destroyElement(tempVeh)
			guiSetInputMode("allow_binds")
			setPedAnimation(localPlayer, false)
			setElementAlpha(currentMarker, 255) 
			setCameraTarget(localPlayer)
			setElementFrozen(localPlayer, false)
			setElementPosition(localPlayer, x, y+2, z+1)
		end
	end
end
addEventHandler("onClientKey", root, spawnCar)