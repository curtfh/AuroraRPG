local _cancelEvent = cancelEvent

local function cancelEvent(cancel, reason, source, attacker, loss, weapon)
	_cancelEvent(cancel, reason)
	if (damageDebugger) then
		if (attacker and getElementType(attacker) ~= "player") then
			attacker = false
		end
		outputChatBox("VEHDMG-CANCEL A: "..(attacker and getPlayerName(attacker) or "Unknown Attacker").." S: "..(source and getElementModel(source) or "Unknown Source").. ": "..reason.." ("..math.floor(loss or 0)..") ("..tostring(weapon)..")")
	end
end

function handleVehicleDamage(attacker, weapon, loss, dX, dY, dZ, tire)
	local health = getElementHealth(source)
	local attackerType = (attacker and getElementType(attacker) or "")
	local attackerTeam = (attackerType == "player" and getTeamName(getPlayerTeam(attacker)) or "")
	local chatzone = exports.server:getPlayChatZone(attacker)
	local dimension = getElementDimension(source)
	if (attackerTeam == "Staff") then
		triggerEvent("onClientVehiclePostDamage", source, attacker, weapon, loss, dX, dY, dZ, tire)
		return false
	end
	if (dimension > 5000 and dimension < 5010) then
		-- Damage handling completely disabled for games dimensions
		return true
	end
	if (getElementData(source, "ArmoredDT") or getElementData(source, "Armored")) then
		if (weapon == 51 or weapon == 37 or weapon == 35) then
			cancelEvent(true, "Explosives used on Armored Truck", source, attacker, loss, weapon)
			return true
		end
		if (attackerType == "vehicle" and weapon == 31) then
			cancelEvent(true, "Armored Truck Protection (1)", source, attacker, loss, weapon)
			return true
		end
		if (attackerType == "vehicle" and getElementModel(attacker) == 432) then
			cancelEvent(true, "Armored Truck Protection against vehicle 432", source, attacker, loss, weapon)
			return true
		end
	end
	if (getElementData(source, "isPlayerProtected")) then
		local foundCriminal = false
		for i, v in pairs(getVehicleOccupants(source)) do
			if (getElementData(v, "isPlayerArrested") or getElementData(v, "wantedPoints") > 10) then
				foundCriminal = true
				break
			end
		end
		if (not foundCriminal) then
			cancelEvent(true, "Vehicle in safe zone", source, attacker, loss, weapon)
			exports.NGCsafeZone:addVehicleMsg(source)
			return true
		end
	end
	if (chatzone ~= "LV" and attackerType ~= "") then
		if (attackerTeam == "Unoccupied" or attackerTeam == "Paramedics" or attackerTeam == "Civilian Workers" or attackerTeam == "Unemployed") then
			cancelEvent(true, "Civ cannot dmg veh", source, attacker, loss, weapon)
			return true
		end
		local criminalInCar = false
		local policeInCar = false
		for i, v in pairs(getVehicleOccupants(source)) do
			if ((getElementData(v, "isPlayerArrested") or getElementData(v, "wantedPoints") > 10) and not exports.DENlaw:isLaw(v)) then
				criminalInCar = true
			elseif (exports.DENlaw:isLaw(v)) then
				policeInCar = true
			end
		end
		if (criminalInCar) then
			if (attackerType == "player" and not exports.DENlaw:isLaw(attacker)) then
				criminalInCar = false
			elseif (attackerType == "vehicle") then
				local polInCar = false
				for i, v in pairs(getVehicleOccupants(attacker)) do
					if (exports.DENlaw:isLaw(v)) then
						polInCar = true
						break
					end
				end
				criminalInCar = polInCar
			end
		end
		if (policeInCar) then
			if (attackerType == "player" and getElementData(attacker, "wantedPoints") < 10) then
				policeInCar = false
			elseif (attackerType == "vehicle") then
				local crimInCar = false
				for i, v in pairs(getVehicleOccupants(attacker)) do
					if (getElementData(v, "wantedPoints") > 10 and not exports.DENlaw:isLaw(v)) then
						crimInCar = true
						break
					end
				end
				policeInCar = crimInCar
			end
		end
		if (not criminalInCar and not policeInCar) then
			cancelEvent(true, "Deathmatch", source, attacker, loss, weapon)
			return true
		end
	end
	if (getElementData(source, "vehicleType") == "playerVehicle" and math.floor(health - loss) < 255) then
		cancelEvent(true, "Veh broken down", source, attacker, loss, weapon)
		return true
	end
	triggerEvent("onClientVehiclePostDamage", source, attacker, weapon, loss, dX, dY, dZ, tire)
end
addEventHandler("onClientVehicleDamage", root, handleVehicleDamage)

function vehicleDmg(attacker, weapon, loss, dX, dY, dZ, tire)
	local attackerType = (attacker and getElementType(attacker) or "Crash")
	local attackerTeam = (attackerType == "player" and getTeamName(getPlayerTeam(attacker)) or "")
	if (damageDebugger) then
		outputChatBox("VEHDMG-DBG A: "..(attackerType == "player" and getPlayerName(attacker) or attackerType)..": ("..math.floor(loss)..")")
	end
end
addEvent("onClientVehiclePostDamage", true)
addEventHandler("onClientVehiclePostDamage", root, vehicleDmg)