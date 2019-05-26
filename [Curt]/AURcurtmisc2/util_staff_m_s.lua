function freezeTheElement(element)
	if (not isElement(element)) then return end
	setElementFrozen(element, true)
	if (getElementType(element) == "player") then
		--exports.NGCdxmsg:createNewDxMessage(element,"You have been forced to move to another position by "..getPlayerName(client)..".",255,0,0)
		
	else
		occupants = getVehicleOccupants(element)
		if (not occupants) then return end
		for i, player in pairs(occupants) do
			--exports.NGCdxmsg:createNewDxMessage(player,"You have been forced to move to another position by "..getPlayerName(client)..".",255,0,0)
		end
	end
end
addEvent("onStaffMovingElement", true)
addEventHandler("onStaffMovingElement", root, freezeTheElement)

function updateFrozenElement(element, x, y, z)
	if (not isElement(element)) then return end
	setElementPosition(element, x, y, z)
end
addEvent("onMovementUpdate", true)
addEventHandler("onMovementUpdate", root, updateFrozenElement)

function stopFreezeElement(element)
	if (not isElement(element)) then return end
	setElementFrozen(element, false)
end
addEvent("onStaffStopMovingElement", true)
addEventHandler("onStaffStopMovingElement", root, stopFreezeElement)

function desEle(element)
	if (not isElement(element)) then return end
	occupants = getVehicleOccupants(element)
	if (not occupants) then return end
	for i, player in pairs(occupants) do
		exports.NGCdxmsg:createNewDxMessage(player,"The vehicle has been destroyed by "..getPlayerName(client)..".",255,0,0)
	end
	destroyElement(element)
end
addEvent("desEle", true)
addEventHandler("desEle", root, desEle)

function killPlrNowLol(element)
	if (not isElement(element)) then return end
	killPed(element)
	exports.NGCdxmsg:createNewDxMessage(element,"You have been slapped by "..getPlayerName(client)..".",255,0,0)
end
addEvent("killPlrNowLol", true)
addEventHandler("killPlrNowLol", root, killPlrNowLol)