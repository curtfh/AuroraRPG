local screenWidth, screenHeight = guiGetScreenSize()

local phi, theta = false, false
local elem = false
local distance = false
local height = false

local sin = math.sin
local cos = math.cos
local pi = math.pi
local rad = math.rad

local function scale(factor, baseX, baseY, baseZ, x, y, z)
	return baseX + factor*(x-baseX), baseY + factor*(y-baseY), baseZ + factor*(z-baseZ)
end

local function onRender()
	if not elem then
		return
	end
	local x, y, z = getElementPosition(elem)
	local camX = x + distance*cos(phi)*cos(theta)
	local camY = y + distance*sin(phi)*cos(theta)
	local camZ = z + 0.4*height + distance/1.5*sin(theta)
	local camLookZ = z + 0.5*height
	local hit, hitX, hitY, hitZ = processLineOfSight(x, y, camLookZ, camX, camY, camZ, true, false, false)
	if hit then
		camX, camY, camZ = scale(0.9, x, y, camLookZ, hitX, hitY, hitZ)
	end
	setCameraMatrix(camX, camY, camZ, x, y, camLookZ)
end

local function onMouseMove(relX, relY, absX, absY)
	if isMTAWindowActive() then
		return
	end
	absX = absX - screenWidth/2
	absY = absY - screenHeight/2
	phi = (phi - 0.005*absX) % (2*pi)
	theta = theta + 0.005*absY
	if theta > 0.4*pi then
		theta = 0.4*pi
	elseif theta < -0.4*pi then
		theta = -0.4*pi
	end
end

function setMouseLook(target, h, dist)
	if target then
		elem = target
		distance = dist
		height = h
		local rX, rY, rZ = getElementRotation(elem)
		phi = rad(rZ + 90 + 180)
		theta = 0
		addEventHandler('onClientCursorMove', getRootElement(), onMouseMove)
		addEventHandler('onClientRender', getRootElement(), onRender)
	else
		elem = false
		distance = false
		height = false
		removeEventHandler('onClientCursorMove', getRootElement(), onMouseMove)
		removeEventHandler('onClientRender', getRootElement(), onRender)
	end
end
