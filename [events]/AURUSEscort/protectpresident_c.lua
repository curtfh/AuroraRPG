addEvent("AURcnr_protectpresident.monitorDamage", true)
addEventHandler("AURcnr_protectpresident.monitorDamage", root,
	function ()
		addEventHandler("onClientVehicleDamage", source, onVehicleDamage)
	end
)
addEvent("AURcnr_protectpresident.stopMonitoringDamage", true)
addEventHandler("AURcnr_protectpresident.stopMonitoringDamage", root,
	function ()
		removeEventHandler("onClientVehicleDamage", source, onVehicleDamage)
	end
)

function onVehicleDamage(attacker, weapon, loss)
	if(attacker) then
		if(getElementType(attacker) == "vehicle") then
			attacker = getVehicleController(attacker)
		end
		if(attacker and getElementType(attacker) == "player") then
			if(weapon == 16 or weapon == 39) then
				loss = loss*0.5
			end
			triggerServerEvent("AURcnr_protectpresident.reportDamage",attacker, loss)
		end
	end
end

-- blips
addEvent("onPlayerJobChange", true)
local convoyBlip
function destroyConvoyBlip()
	if(isElement(convoyBlip)) then
		destroyElement(convoyBlip)
		removeEventHandler("onPlayerJobChange",localPlayer,destroyConvoyBlip)
		removeEventHandler("onClientElementDestroy",source,destroyConvoyBlip)
		return true
	end
	return false
end

addEvent("AURcnr_protectpresident.addConvoyBlip", true)
addEventHandler("AURcnr_protectpresident.addConvoyBlip", root,
	function ()
		if(isElement(convoyBlip)) then
			destroyElement(convoyBlip)
		else
			addEventHandler("onPlayerJobChange",localPlayer,destroyConvoyBlip)
			addEventHandler("onClientElementDestroy",source,destroyConvoyBlip)
		end
		convoyBlip = createBlipAttachedTo(source, 59)
	end
)

local convoyStartBlip
function destroyConvoyStartBlip()
	if(isElement(convoyStartBlip)) then
		destroyElement(convoyStartBlip)
		removeEventHandler("onPlayerJobChange",localPlayer,destroyConvoyStartBlip)
		return true
	end
	return false
end

addEvent("AURcnr_protectpresident.destroyConvoyStartBlip", true)
addEventHandler("AURcnr_protectpresident.destroyConvoyStartBlip", root, destroyConvoyStartBlip)

addEvent("AURcnr_protectpresident.addConvoyStartBlip", true)
addEventHandler("AURcnr_protectpresident.addConvoyStartBlip", root,
	function (x, y, z)
		if(isElement(convoyStartBlip)) then
			destroyElement(convoyStartBlip)
		else
			addEventHandler("onPlayerJobChange",localPlayer,destroyConvoyStartBlip)
		end
		convoyStartBlip = createBlip(x, y, z, 46)
	end
)

local targetBlip
function destroyTargetBlip()
	if(isElement(targetBlip)) then
		destroyElement(targetBlip)
		removeEventHandler("onPlayerJobChange",localPlayer,destroyTargetBlip)
		return true
	end
	return false
end
addEvent("AURcnr_protectpresident.destroyTargetBlip", true)
addEventHandler("AURcnr_protectpresident.destroyTargetBlip", root, destroyTargetBlip)

addEvent("AURcnr_protectpresident.addTargetBlip", true)
addEventHandler("AURcnr_protectpresident.addTargetBlip", localPlayer,
	function (x,y,z)
		if(isElement(targetBlip)) then
			destroyElement(targetBlip)
		else
			addEventHandler("onPlayerJobChange",localPlayer,destroyTargetBlip)
		end
		targetBlip = createBlip(x,y,z, 46)
	end
)
