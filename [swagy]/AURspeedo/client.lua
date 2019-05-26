local speedRotation = 224
local hpRotation = 144
local screenW, screenH = guiGetScreenSize()

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end


--[[if (getVehicleEngineState(veh)) then
    			engCol = tocolor(0,255,255,255)
    		else
    			engCol = tocolor(0,0,0,255)
    		end
    		if (isVehicleLocked(veh)) then
    			lockCol = tocolor(0,255,255,255)
    		else
    			lockCol = tocolor(0,0,0,255)
    		end
    		if (getVehicleLightState(veh, 0) == 0) or (getVehicleLightState(veh, 0) == 1) or (getVehicleLightState(veh, 0) == 2) or (getVehicleLightState(veh, 0) == 3) then
    			lightCol = tocolor(0,255,255,255)
    		else
    			lightCol = tocolor(0,0,0,255)
    		end]]

function drawSpeedo()
    	if (isPedInVehicle(localPlayer)) then
    		local veh = getPedOccupiedVehicle(localPlayer)
    		if (isElement(veh) == false) then return false end
    		local speedRotation = (getElementSpeed(veh, 1)) + 224
    		local speed = math.floor(getElementSpeed(veh, 1))
    		local hp = math.floor(getElementHealth(veh))
    		local percentHP = hp/10
    		local hpRotation = 144 - ((100-percentHP) * 2.8)
    		local fuel = getElementData(veh, "vehicleFuel")
    		local fuelRot = 244 + (fuel * 2.7)
            if (getVehicleEngineState(veh)) then
                engCol = tocolor(0,255,255,255)
            else
                engCol = tocolor(0,0,0,255)
            end
            if (isVehicleLocked(veh)) then
                lockCol = tocolor(0,255,255,255)
            else
                lockCol = tocolor(0,0,0,255)
            end
            if (getVehicleLightState(veh, 0) == 0) or (getVehicleLightState(veh, 0) == 1) or (getVehicleLightState(veh, 0) == 2) or (getVehicleLightState(veh, 0) == 3) then
                lightCol = tocolor(0,255,255,255)
            else
                lightCol = tocolor(0,0,0,255)
            end
        dxDrawImage(screenW * 0.6977, screenH * 0.6576, screenW * 0.1728, screenH * 0.3112, "images/speedo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.5871, screenH * 0.7695, screenW * 0.1105, screenH * 0.1992, "images/fuel.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.8704, screenH * 0.7695, screenW * 0.1105, screenH * 0.1992, "images/hp.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.8250, screenH * 0.6445, screenW * 0.0329, screenH * 0.0521, "images/engine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.7643, screenH * 0.6055, screenW * 0.0329, screenH * 0.0521, "images/headlights.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.7020, screenH * 0.6523, screenW * 0.0329, screenH * 0.0521, "images/lock.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.6654, screenH * 0.6107, screenW * 0.2357, screenH * 0.4115, "images/needle.png", speedRotation, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.5586, screenH * 0.7344, screenW * 0.1662, screenH * 0.2747, "images/needle.png", fuelRot, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.8419, screenH * 0.7344, screenW * 0.1662, screenH * 0.2747, "images/needle.png", hpRotation, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawLine((screenW * 0.7570) - 1, (screenH * 0.8841) - 1, (screenW * 0.7570) - 1, screenH * 0.9206, tocolor(229, 249, 0, 254), 1, false)
        dxDrawLine(screenW * 0.8031, (screenH * 0.8841) - 1, (screenW * 0.7570) - 1, (screenH * 0.8841) - 1, tocolor(229, 249, 0, 254), 1, false)
        dxDrawLine((screenW * 0.7570) - 1, screenH * 0.9206, screenW * 0.8031, screenH * 0.9206, tocolor(229, 249, 0, 254), 1, false)
        dxDrawLine(screenW * 0.8031, screenH * 0.9206, screenW * 0.8031, (screenH * 0.8841) - 1, tocolor(229, 249, 0, 254), 1, false)
        dxDrawRectangle(screenW * 0.7570, screenH * 0.8841, screenW * 0.0461, screenH * 0.0365, tocolor(170, 80, 80, 108), false)
        dxDrawText("".. math.floor(speed) .." km/h", screenW * 0.7599, screenH * 0.8841, screenW * 0.7987, screenH * 0.9141, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
    end
end
addEventHandler("onClientRender", root, drawSpeedo)
