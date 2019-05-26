local white = tocolor(255, 255, 255, 100)
local orange = tocolor(255, 127, 0, 100)
local green = tocolor(0, 255, 0, 100)
local yellow = tocolor(255, 255, 0, 100)
local red = tocolor(255, 0, 0, 100)
local black = tocolor(0, 0, 0, 100)
local whiteActivated = tocolor(255, 255, 255, 255)
local orangeActivated = tocolor(255, 127, 0, 255)
local greenActivated = tocolor(0, 255, 0, 255)
local yellowActivated = tocolor(255, 255, 0, 255)
local redActivated = tocolor(255, 0, 0, 255)
local blackActivated = tocolor(0, 0, 0, 255)

local screenX, screenY = guiGetScreenSize()

local lockTexture = dxCreateTexture("lock.png")
local engineTexture = dxCreateTexture("engine.png")
local headlightsTexture = dxCreateTexture("headlights.png")


local hudProperties = {
	maxVelocity = false	
}

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

function enterVehicleStartHUD()
	hudProperties.maxVelocity = getVehicleHandling(getPedOccupiedVehicle(localPlayer))["maxVelocity"]
	removeEventHandler("onClientRender", root, drawHUD)
	addEventHandler("onClientRender", root, drawHUD)
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, enterVehicleStartHUD)

function convertHSVToRGB(h, s, v)
	local r, g, b
	local i = math.floor(h * 6);
	local f = h * 6 - i;
	local p = v * (1 - s);
	local q = v * (1 - f * s);
	local t = v * (1 - (1 - f) * s);
	i = i % 6
	if i == 0 then 
		r, g, b = v, t, p
	elseif i == 1 then
		 r, g, b = q, v, p
	elseif i == 2 then 
		r, g, b = p, v, t
	elseif i == 3 then 
		r, g, b = p, q, v
 	elseif i == 4 then 
 		r, g, b = t, p, v
  	elseif i == 5 then 
  		r, g, b = v, p, q
	end
	return r * 255, g * 255, b * 255
end

function drawHUD()
	local veh = getPedOccupiedVehicle(localPlayer)
	if (not veh or not hudProperties.maxVelocity) then
		hudProperties.maxVelocity = false
		removeEventHandler("onClientRender", root, drawHUD)
		return false
	end
	-- Variable declarations
	local eachWidth = 210 / 30
	local currentX = ((1689 / 1920) * screenX) - eachWidth
	local currentY = screenY - 385
	local vehicleSpeed = getElementSpeed(veh, 2)
	local vehicleHealth = math.max(0, ((getElementHealth(veh) - 250) / 750))
	local vR, vG, vB = convertHSVToRGB(vehicleHealth * 1 / 3, 1, 1)
	local vColor = tocolor(vR, vG, vB)
	local vehicleHealth = math.floor(vehicleHealth * 100)
	local vehicleFuel = getElementData(veh, "vehicleFuel") or 100
	local fR, fG, fB = convertHSVToRGB((vehicleFuel / 100) * 1 / 3, 1, 1)
	local fColor = tocolor(fR, fG, fB)
	local x, y, z = getElementPosition(veh)
	--local vehicleFuel = 100
	local speedPerPixel = hudProperties.maxVelocity / 210
	local healthPerPixel = 100 / 210
	local fuelPerPixel = 100 / 210
	local barsUsingUp = (vehicleSpeed / hudProperties.maxVelocity) * 19
	local barsUsingHealth = (vehicleHealth / 100) * 19
	local barsUsingFuel = (vehicleFuel / 100) * 19
	local headlightsVisible = (getVehicleOverrideLights == 2)
	local isEngineOn = getVehicleEngineState(veh)
	local isVehLocked = getElementData(veh, "locked")
	local nitroCount = math.floor(tonumber(getElementData(localPlayer,"nos"))) or 0
	--outputChatBox(barsUsingUp)
	-- Actual rendering
	for bars = 1, 3 do
		for i = 1, 19 do
			-- SPEED
			local height = 10
			local i2 = 1
			local drawExtraActivatedPixels = 0
			local colorToUse = {white, orange}
			local activatedColorsBarSpecific = {whiteActivated, orangeActivated}
			if (bars == 2) then
				colorToUse = {white, green}
				activatedColorsBarSpecific = {whiteActivated, greenActivated}
			elseif (bars == 3) then
				colorToUse = {white, yellow}
				activatedColorsBarSpecific = {whiteActivated, yellowActivated}
			end
			currentY = (screenY - 385) + (((95 / 1080) * screenY) * (bars - 1))
			-- Speedometer increase
			if (bars == 1) then
				if (i <= barsUsingUp) then
					colorToUse[1] = whiteActivated
					colorToUse[2] = orangeActivated
				elseif (i <= (barsUsingUp + 1)) then
					drawExtraActivatedPixels = (barsUsingUp - math.floor(barsUsingUp)) * hudProperties.maxVelocity / 19 * speedPerPixel
					if (drawExtraActivatedPixels > eachWidth) then
						drawExtraActivatedPixels = eachWidth
					end
				end
			elseif (bars == 2) then
				if (i <= barsUsingHealth) then
					colorToUse[1] = whiteActivated
					colorToUse[2] = greenActivated
				elseif (i <= (barsUsingHealth + 1)) then
					drawExtraActivatedPixels = (barsUsingHealth - math.floor(barsUsingHealth)) * 100 / 19 * healthPerPixel
					if (drawExtraActivatedPixels > eachWidth) then
						drawExtraActivatedPixels = eachWidth
					end
				end
			elseif (bars == 3) then
				if (i <= barsUsingFuel) then
					colorToUse[1] = whiteActivated
					colorToUse[2] = yellowActivated
				elseif (i <= (barsUsingFuel + 1)) then
					drawExtraActivatedPixels = (barsUsingFuel - math.floor(barsUsingFuel)) * 100 / 19 * fuelPerPixel
					if (drawExtraActivatedPixels > eachWidth) then
						drawExtraActivatedPixels = eachWidth
					end
				end
			end
			-- Checks if it should be an orange or white bar
			if (i == 1 or (i - 1) % 3 == 0) then
				height = 15
				i2 = (i == 1 and 1 or (((i - 1) / 3) + 1))
			end
			-- Orange/White Bars
			dxDrawRectangle(currentX + (eachWidth * i) + (i * eachWidth / 10), currentY + (1.5 * i), eachWidth, height, (height == 10 and colorToUse[1] or colorToUse[2]))
			if (drawExtraActivatedPixels > 0) then
				dxDrawRectangle(currentX + (eachWidth * i) + (i * eachWidth / 10), currentY + (1.5 * i), drawExtraActivatedPixels, height, (height == 10 and activatedColorsBarSpecific[1] or activatedColorsBarSpecific[2]))
			end
			if (height ~= 10) then
				local width = dxGetTextWidth(tostring(i2), 1, "sans")
				-- Draws text below bars, i.e 1, 2, 3, 4, 5, 6, 7
				dxDrawText(tostring(i2), currentX + (eachWidth * i) + (i * eachWidth / 13), currentY + (1.5 * i) + (15), currentX + (eachWidth * i) + (i * eachWidth / 13) + eachWidth + (width / 2), 0, colorToUse[1], 1, "sans", "center")
			end
		end
		if (bars == 1) then
			dxDrawText(math.floor(vehicleSpeed).." km/h", currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((95 / 1080) * screenY),  currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((95 / 1080) * screenY) / 2, yellowActivated, 1.00, "bankgothic", "center", "center", false, false, false, false, false, 10)
		elseif (bars == 2) then
			dxDrawText(math.floor(vehicleHealth).."% hp", currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((95 / 1080) * screenY),  currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((95 / 1080) * screenY) / 2, vColor, 1.00, "bankgothic", "center", "center", false, false, false, false, false, 10)
		elseif (bars == 3) then
			dxDrawText(math.floor(vehicleFuel).."% fuel", currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((95 / 1080) * screenY),  currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((95 / 1080) * screenY) / 2, fColor, 1.00, "bankgothic", "center", "center", false, false, false, false, false, 10)
			dxDrawText("nos: "..nitroCount, currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((140 / 1080) * screenY),  currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((140 / 1080) * screenY) / 2, fColor, 0.85, "bankgothic", "center", "center", false, false, false, false, false, 10)
			dxDrawText(getZoneName(x, y, z, false), currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((165 / 1080) * screenY),  currentX + (eachWidth * 9.5) + (9.5 * eachWidth / 10), currentY + ((165 / 1080) * screenY) / 2, whiteActivated, 0.60, "bankgothic", "center", "center", false, false, false, false, false, 10)
			dxDrawImage(currentX + (eachWidth * 14.25) + (14.25 * eachWidth / 10), currentY + ((140 / 1080) * screenY), (64 / 1920) * screenX, (64 / 1080) * screenY, engineTexture, 10, 0, 0, isEngineOn and greenActivated or redActivated, true)
			dxDrawImage(currentX + (eachWidth * 6) + (6 * eachWidth / 10), currentY + ((135 / 1080) * screenY), (45 / 1920) * screenX, (45 / 1080) * screenY, headlightsTexture, 10, 0, 0, headlightsVisible and greenActivated or redActivated, true)
			dxDrawImage(currentX + (eachWidth * -2) + (-2 * eachWidth / 10), currentY + ((125 / 1080) * screenY), (32 / 1920) * screenX, (32 / 1080) * screenY, lockTexture, 10, 0, 0, isVehLocked and greenActivated or redActivated, true)
		end
	end
end

-- Start HUD if script was restarted when player was in a vehicle
if (isPedInVehicle(localPlayer)) then
	enterVehicleStartHUD()
end

