screenW, screenH = guiGetScreenSize()

local scaleX,scaleY = screenW/1440, screenH/900 -- scale based on design resolution ( 1440x900 )
if screenW <= 800 and screenH <= 600 then
    scaleX,scaleY = 1024/1440, 768/900 -- scale based on design resolution ( 1440x900 )
end
scaleX,scaleY = 1366/1366, 768/768 -- scale based on design resolution ( 1440x900 )

local bgDiscWidth, bgDiscHeight = scaleX*250,scaleY*250

---local bgDiscX, bgDiscY = (screenW-bgDiscWidth)/2,(screenH-bgDiscHeight)/2


local enabled = false

local screenWidth, screenHeight = guiGetScreenSize()

local WANTED_X, WANTED_Y = math.floor(0.78*screenWidth),math.floor(0.21*screenHeight)
local WANTED_END_X, WANTED_END_Y = math.floor(0.92*screenWidth), math.floor(0.22*screenHeight)+70

local WANTED_STAR_X, WANTED_STAR_Y = math.floor(0.93*screenWidth), math.floor(0.225*screenHeight)


local fadeStart
local fadeDuration = 5000
local fading = false
--local font = dxCreateFont("font.ttf",12,true)
local opensans = dxCreateFont("opensans.ttf",8,true)
local dig = dxCreateFont("dig.ttf",12,true)

local wasInVehicle = false


function convertHSVToRGB(h, s, v)
  local r, g, b

  local i = math.floor(h * 6);
  local f = h * 6 - i;
  local p = v * (1 - s);
  local q = v * (1 - f * s);
  local t = v * (1 - (1 - f) * s);

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  return r * 255, g * 255, b * 255
end


function getProgressColor(progress)
    return convertHSVToRGB(progress*(1/3), 1, 1)
end

function isResourceReady(name)
    return getResourceFromName(name) and getResourceState(getResourceFromName(name)) == "running"
end


local cities = { LV = "Las Venturas", LS = "Los Santos", SF = "San Fierro" }
local theZone = "AUR"




function renderVehicleHUD()
	if(isPlayerMapVisible()) then return end
	if getElementData(localPlayer,"isPlayerPrime") then return false end
	if getElementDimension(localPlayer) == 5006 then return false end
	if exports.server:isPlayerLoggedIn(localPlayer) then
	local alpha = 200
	local player = localPlayer
    local hudX = screenWidth - 180
	local px,py,pz = getElementPosition(player)
    local theZone = getZoneName(px,py,pz, false)
    local vehicle = getPedOccupiedVehicle(player)
    if(not vehicle) then return false end
	if isPlayerMapVisible() then return false end
	if isPedInVehicle(localPlayer) ~= true then return false end
    local driver = getVehicleController(vehicle) == player
    -- draw seats
    local x = screenWidth - 25
    local y = screenHeight - 35
    for seat=math.min(6,getVehicleMaxPassengers(vehicle)),0,-1 do
        local occupant = getVehicleOccupant(vehicle, seat)
        drawBorder(x,y,20,20, tocolor(255,255,255,alpha))
        if(occupant) then
            local r,g,b = 255,255,255
            if(occupant == player) then
                r,g,b = 120,255,120
            end
            dxDrawRectangle(x+2,y+2,17,17,tocolor(r,g,b,alpha))
        end
        x = x - 25
    end
    y = y - 40

	local speedmph = getElementSpeed(vehicle, 2)


    local fuelProgress = getVehicleFuel(vehicle)/1.65
	local engine = getVehicleEngineState(vehicle)
	local lights = getVehicleOverrideLights(vehicle)
	local nosx = getElementData(localPlayer,"nos")
	if nosx and tonumber(nosx) then
		nos = nosx
	else
		nos = 0
	end
	local hudX = screenWidth - 200
	local bgDiscX = screenWidth - 270
	local bgDiscY = screenHeight - 270

	dxDrawImage(bgDiscX, bgDiscY,bgDiscWidth, bgDiscHeight,"bgon.png",0,0,0,tocolor(255,255,255,255),false)
	dxDrawImage(bgDiscX-65, bgDiscY,bgDiscWidth, bgDiscHeight,"fuel.png",0,0,0,tocolor(255,255,255,255),false)

	if engine == true then
		dxDrawImage(bgDiscX, bgDiscY,bgDiscWidth, bgDiscHeight,"eng2.png",0,0,0,tocolor(255,255,255,255),false)
	else
		dxDrawImage(bgDiscX, bgDiscY,bgDiscWidth, bgDiscHeight,"eng1.png",0,0,0,tocolor(255,255,255,255),false)
	end
	if lights == 2 then
		dxDrawImage(bgDiscX+10, bgDiscY,bgDiscWidth, bgDiscHeight,"light2.png",0,0,0,tocolor(255,255,255,255),false)
	else
		dxDrawImage(bgDiscX+10, bgDiscY,bgDiscWidth, bgDiscHeight,"light1.png",0,0,0,tocolor(255,255,255,255),false)
	end
	dxDrawImage(bgDiscX+140, bgDiscY+40,bgDiscWidth-60, bgDiscHeight-60,"nitro.png",0,0,0,tocolor(255,255,255,255),false)
	dxDrawImage(bgDiscX, bgDiscY+12,bgDiscWidth-20, bgDiscHeight-20, "arrow.png", math.floor(speedmph), 0, 0, tocolor(255,255,255,255),false)
	if getVehicleFuel(vehicle) >= 80 then
		dxDrawImage(bgDiscX-28, bgDiscY+25,bgDiscWidth-20, bgDiscHeight-20, "fuelArrow.png", fuelProgress, 0, 0, tocolor(255,255,255,255),false)
	elseif getVehicleFuel(vehicle) >= 50 and getVehicleFuel(vehicle) < 80 then
		dxDrawImage(bgDiscX-20, bgDiscY+25,bgDiscWidth-20, bgDiscHeight-20, "fuelArrow.png", fuelProgress, 0, 0, tocolor(255,255,255,255),false)
	elseif getVehicleFuel(vehicle) < 50 then
		dxDrawImage(bgDiscX-10, bgDiscY+25,bgDiscWidth-20, bgDiscHeight-20, "fuelArrow.png", fuelProgress, 0, 0, tocolor(255,255,255,255),false)
	end
	local vx,vy,vz = getElementVelocity(vehicle)
    local speed = string.format("%00i", math.sqrt(vx^2+vy^2+vz^2)*155)
    drawText(speed, bgDiscX+40, bgDiscY+115, 172, 28, tocolor(255,255,255,alpha), 1.5,dig)
	if theZone then
		drawText(theZone, bgDiscX+40, bgDiscY+155, 172, 28, tocolor(255,255,255,alpha), 0.8)
	else
		drawText("Unknown", bgDiscX+40, bgDiscY+155, 172, 28, tocolor(255,255,255,alpha), 0.9)
	end
	if nos then
		drawText(math.floor(nos), bgDiscX+120, bgDiscY+190, 172, 28, tocolor(255,255,255,alpha), 1,dig)
	else
		drawText("0", bgDiscX+120, bgDiscY+190, 172, 28, tocolor(255,255,255,alpha), 1,dig)
	end

	local healthProgress = math.max(0,(getElementHealth(vehicle)-250)/750)
    local r,g,b = getProgressColor(healthProgress)
    local text = math.floor(healthProgress*100).."%"
    drawText(text, bgDiscX+160, bgDiscY-3, 172, 28, tocolor(r,g,b,alpha), 0.9,dig)
	end
end
addEventHandler("onClientRender", root, renderVehicleHUD)

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function drawText(text, x,y,width,height,color, scale,font,crop)
    dxDrawText(text, x, y, x+width, y+height, color, scale or 1, font or "default-bold", "center", "center", true, crop or false)
end

function drawBorder(x,y,width,height,color,lineWidth)
    if not lineWidth then lineWidth = 1.75 end
    local width = width - 1
    if not color then color = tocolor( 255,255,255,255) end
    dxDrawLine(x,y,x+width,y,color,lineWidth, post_gui)
    dxDrawLine(x,y,x,y+height,color,lineWidth, post_gui)
    dxDrawLine(x+width,y,x+width,y+height,color,lineWidth, post_gui)
    dxDrawLine(x,y+height,x+width,y+height,color,lineWidth, post_gui)
end


function getVehicleFuel(vehicle)
    return getElementData(vehicle, "vehicleFuel") or 100
end


function getVehicleSpeed()
    if isPedInVehicle(localPlayer) then
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		return math.sqrt(vx^2+vy^2+vz^2)*155
    end
    return 0
end
