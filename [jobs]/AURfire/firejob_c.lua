local firePlaces = {
	{-1817.96, 142.17, 15.1},
	{-1817.96, 142.17, 15.1},
	{-2885.11, 460.5, 4.91},
	{-1985.94, 369.42, 35.21},
	{-1756.07, 931.96, 24.74},
	{-1575.65, 1207.31, 7.59},
	{-1552.45, 386.15, 7.18},
	{-1527.6357421875,-404.1904296875,7.078125},
    {-1738.0205078125,103.244140625,3.5546875},
    {-1984.5517578125,368.8173828125,35.231113433838},
    {-2527.19921875,567.8203125,14.4609375},
    {-2656.09765625,608.9365234375,14.453125},
    {-2821.255859375,1304.837890625,7.1015625},
}

local fireElements = {}
local fireObjects = {2021, 2022, 2023}
local isFireFighterRunning = false 
local blip = nil
local screenW, screenH = guiGetScreenSize()
local firesLeft = 0

function loadFireObjects()
	local fire = engineLoadDFF("fire.dff", 0)
	engineReplaceModel(fire, 2021)

	local fire_large = engineLoadDFF("fire_large.dff", 0)
	engineReplaceModel(fire_large, 2023)

	local fire_med = engineLoadDFF("fire_med.dff", 0)
	engineReplaceModel(fire_med, 2022)
end

function unloadFireObjects()
	for i, v in ipairs(fireObjects) do
		engineRestoreModel(v)
	end
end

local timesHit = {}

function destroyFire(fire)
	if (isElement(fire) and fireElements[fire]) then
		destroyElement(fire)
		fireElements[fire] = nil

		triggerServerEvent("AURfire.reward", localPlayer)

		firesLeft = firesLeft - 1
		exports.AURstickynote:displayText("AURfire", "text", firesLeft.." "..(firesLeft > 1 and "fires" or "fire") .." left")
		if (firesLeft == 0) then
			startFire()
		end
	end
end

function hitFire(w, ammo, clipAmmo, hX, hY, hZ, hitEl)
	if (not isFireFighterRunning) then
		removeEventHandler("onClientPlayerWeaponFire", localPlayer, hitFire)
	end

	if (w ~= 42) then
		return false 
	end

	if (not hitEl or not isElement(hitEl)) then
		return false 
	end

	if (getElementType(hitEl) ~= "object") then
		return false
	end

	if (not fireElements[hitEl]) then
		return false 
	end

	if (not timesHit[hitEl]) then
		timesHit[hitEl] = 1
	else
		timesHit[hitEl] = timesHit[hitEl] + 1
	end

	if (timesHit[hitEl] == 25) then
		destroyFire(hitEl)
		timesHit[hitEl] = nil
	end
end

function startFire()
	isFireFighterRunning = true
	unloadFireObjects()
	loadFireObjects()
	firesLeft = 0

	if (isElement(blip)) then
		destroyElement(blip)
	end

	for i, v in pairs(fireElements) do 
		if (isElement(i)) then
			destroyElement(i)
		end
	end

	local randomPlace = firePlaces[math.random(#firePlaces)]
	local x, y, z = unpack(randomPlace)
	local zoneName = getZoneName(x, y, z, false)
	blip = createBlip(x, y, z, 20)
	exports.NGCdxmsg:createNewDxMessage("A fire broke out at "..zoneName.."! Go there and extinguish the fire!", 255, 0, 0)

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x + i, y, z)] = true
	end

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x, y + i, z)] = true
	end

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x - i, y, z)] = true
	end

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x, y - i, z)] = true
	end

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x - i, y - i, z)] = true
	end

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x + i, y + i, z)] = true
	end

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x + i, y - i, z)] = true
	end

	for i=1, 10 do
		local z = z - 0.5

		if (getGroundPosition(x, y, z) ~= getGroundPosition(x, y, z + 15)) then
			z = getGroundPosition(x, y, z + 5)
		end

		fireElements[createObject(fireObjects[math.random(#fireObjects)], x - i, y + i, z)] = true
	end

	for i, v in pairs(fireElements) do
		setElementAlpha(i, 255)
		firesLeft = firesLeft + 1
	end
	exports.AURstickynote:displayText("AURfire", "text", firesLeft.." "..(firesLeft > 1 and "fires" or "fire") .." left")
end

function stopFire()
	if (not isFireFighterRunning) then
		return 
	end
	isFireFighterRunning = false
	unloadFireObjects()

	for i, v in pairs(fireElements) do
		destroyElement(i)
	end

	fireElements = {}

	if (isElement(blip)) then
		destroyElement(blip)
	end

	blip = nil
end

function loadOnStart()
	if (getElementData(localPlayer, "Occupation") == "Firefighter") then
		startFire()
		addEventHandler("onClientPlayerWeaponFire", localPlayer, hitFire)
		addEventHandler("onClientRender", root, dxFires)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, loadOnStart)

function onElementDataChange(dataName, oldValue)
	if (dataName == "Occupation" and getElementData(localPlayer, dataName) == "Firefighter") then
		startFire()
		addEventHandler("onClientPlayerWeaponFire", localPlayer, hitFire)
	elseif (dataName == "Occupation" and isFireFighterRunning) then
		removeEventHandler("onClientPlayerWeaponFire", localPlayer, hitFire)
		exports.AURstickynote:displayText("AURfire", "text", false)
		stopFire()
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onElementDataChange, false)

function toggleFirefighter()
	if (getElementData(localPlayer, "Occupation") == "Firefighter") then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5", "down", toggleFirefighter)