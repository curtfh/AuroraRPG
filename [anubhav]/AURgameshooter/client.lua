
local screenWidth, screenHeight = guiGetScreenSize()
local mygun = nil
local rx, ry = guiGetScreenSize()
local nX, nY = 1366, 768
local sX, sY = guiGetScreenSize()
local count = 3
local count2 = 3
local trigger = false
local canFireRockets = false
local startProtect = false

hop = nil
function startCountdown(interval)
	if countdownImage and isElement(countdownImage) then destroyElement(countdownImage) end
	if isTimer(hop) then killTimer(hop) end
    countdownImage = guiCreateStaticImage((rx/2)-125, (ry/2)-80, 250, 190, "images/3.png", false)
	if not interval then interval = 2000 end
    hop = setTimer(decrementCountdown, interval, 4)
    countdownCount = 3
	startProtect = true
end

function decrementCountdown()
	countdownCount = countdownCount - 1
	if (countdownCount > 0) then
		guiStaticImageLoadImage (countdownImage, "images/"..countdownCount..".png")
	elseif (countdownCount == 0) then
		destroyElement(countdownImage)
		countdownImage = guiCreateStaticImage((rx/2)-160, (ry/2)-80, 320, 190, "images/go.png", false)
	else
		destroyElement(countdownImage)
	end
end

theKiller = {}
dmg = {}
active = false
suckers = {}
targ = false

local lastLauncherSyncTick = getTickCount()
local lastLauncherUpdateTick = getTickCount()


levels = {}

weaponNames = {
  "Rocket", --- 1
  "Dual Rockets", ---- 2
  "Machine Gun", --- 3
  "Dual Miniguns", --- 4
  "Rocket Launcher", ---- 5
  "Minigun", ---- 6
  "Duel Machine Gun", ---- 7
  "Rocket Burst", ---- 8
  "Grenade Launcher" ----9
}

-- Lvl 1-3 = Machine Gun (M4)
-- Lvl 4-6 = Duel Machine Gun
-- Lvl 7-9 Rocket Launcher
-- Lvl 10-13 Grenade Launcher
-- Lvl 14-16 Rocket
-- Lvl 17-19 Duel Rocket
-- Lvl 20-22 Rocket Burst
-- Lvl 23-25 Minigun
-- Lvl 26-28 Duel Minigun
function getLevel(lv)
	local level = tonumber(lv)
	if level <= 0 then
		level = 1
	end
	if levels[level] then
		return unpack(levels[level])
	end
	if not vehicleName then
		vehicleName, vehicles, weapons = getShooterData()
	end
	local vehModel = vehicles[level % #vehicles + 1]
	if level >= 1 and level <= 10 then
		weaponx = 1
	elseif level > 10 and level <= 20 then
		weaponx = 2
	elseif level > 20 and level <= 28 then
		weaponx = 8
	else
		weaponx = 1
	end
	outputDebugString(weaponx.." your next weapon")
	--[[if level >= 1 and level < 4 then
		weaponx = 3
	elseif level >= 4 and level < 7 then
		weaponx = 7
	elseif level >= 7 and level < 10 then
		weaponx = 5
	elseif level >= 10 and level < 14 then
		weaponx = 9
	elseif level >= 14 and level < 17 then
		weaponx = 1
	elseif level >= 17 and level < 20 then
		weaponx = 2
	elseif level >= 20 and level < 23 then
		weaponx = 8
	elseif level >= 23 and level < 26 then
		weaponx = 6
	elseif level >= 26 then
		weaponx = 4
	else
		weaponx = 1
	end]]
	local acceleration = math.sqrt(200 / level) * math.sin(level / 60) + 2
	local accelerationMultiplier = {7,4,7,4,3,7,4,4,7}
	local reloadTimeMultiplier = {1,1,1,1,1.5,1,1,1.3,1}
	local reloadTime = (2 + acceleration * reloadTimeMultiplier[weaponx]) * 1000
	acceleration = acceleration * accelerationMultiplier[weaponx]
	local levelName = vehicleName[vehModel] .. " with " .. weaponNames[weaponx]
	levels[level] = {vehModel,weaponx,acceleration,reloadTime,levelName}
	return vehModel, weaponx, acceleration, reloadTime, levelName
end

function createEvents()
	addEvent("attachShooterWeapons", true)
	addEvent("dettachShooterWeapons", true)
end
createEvents()

function addEvents()
	addEventHandler("attachShooterWeapons", root, shooterAttachWeapons)
	addEventHandler("dettachShooterWeapons", root, dettachShooterWeapons)
	addEventHandler("onClientWeaponFire", root, onClientWeaponFire)

end

function removeEvents()
	removeEventHandler("attachShooterWeapons", root, shooterAttachWeapons)
	removeEventHandler("dettachShooterWeapons", root, dettachShooterWeapons)
	removeEventHandler("onClientWeaponFire", root, onClientWeaponFire)
end



addEvent("onPlayerJoinShooter",true)
addEventHandler("onPlayerJoinShooter",root,function()
	addEvents()
	removeEventHandler("onClientPreRender", root, shooterOnPreRender)
	addEventHandler("onClientPreRender", root, shooterOnPreRender)
	shooterAmmoTimer = setTimer(addShooterAmmo, 50, 0)
	shooterAmmo = 1000
	shooterAmmoAddition = 0
	shooterAttachWeapons()
end)



addEvent("onPlayerLeaveShooter",true)
addEventHandler("onPlayerLeaveShooter",root,function()
	removeEvents()
	unbindShooterKeys()
	removeEventHandler("onClientPreRender", root, shooterOnPreRender)
	dettachAllShooterWeapons()
	if isTimer(shooterAmmoTimer) then
		killTimer(shooterAmmoTimer)
	end
	shooterAmmo = 1000
	shooterAmmoAddition = 0
	killer = nil
end)


attachedObjects = {}
attachedWeapons = {}

function dettachAllShooterWeapons()
	for player, objects in pairs(attachedObjects) do
		dettachShooterWeapons(player)
	end
end

function dettachShooterWeapons(player)
	for id, object in ipairs(attachedObjects[player] or {}) do
		if isElement(object) then
			destroyElement(object)
		end
	end
	for id, weapon in ipairs(attachedWeapons[player] or {}) do
		if isElement(weapon) then
			destroyElement(weapon)
		end
	end
	attachedObjects[player] = nil
	attachedWeapons[player] = nil
end

function attachShooterWeapons(player)
	dettachShooterWeapons(player)
	attachedObjects[player] = {}
	attachedWeapons[player] = {}
	local vehicle = getPedOccupiedVehicle(player)
	if not isElement(vehicle) then
		return
	end
	local level = getElementData(player, "playerLevel") or 1
	local model, iWeapon = getLevel(level)
	for id, weapon in ipairs(weapons[iWeapon][model]) do
		local x, y, z = getPositionFromElementOffset(vehicle, weapon[3], weapon[4], weapon[5])
		local object = createObject(weapon[1], x, y, z, 0, 0, 0)
		setObjectBreakable(object, false)
		toggleObjectRespawn(object, true)
		setElementDimension(object, getElementDimension(localPlayer))
		setObjectScale(object, weapon[2])
		setElementCollisionsEnabled(object, false)
		attachElements(object, vehicle, weapon[3], weapon[4], weapon[5], weapon[6], weapon[7], weapon[8])
		if  iWeapon == 6 then
			local weaponElement = createWeapon("minigun", 0, 0, 0)
			setElementData(weaponElement, "owner", player, false)
			setWeaponProperty(weaponElement, "damage", 30)
			setElementDimension(weaponElement, getElementDimension(localPlayer))
			setElementAlpha(weaponElement, 0)
			setElementCollisionsEnabled(weaponElement, false)
			setWeaponClipAmmo(weaponElement, 10000)
			setWeaponFlags(weaponElement, "disable_model", true)
			attachElements(weaponElement, vehicle, weapon[3], weapon[4] + weapon[2] * 1.2, weapon[5] + weapon[2] * 1.1)
			table.insert(attachedWeapons[player], weaponElement)
		elseif iWeapon == 4 then
			local weaponElement = createWeapon("minigun", 0, 0, 0)
			setElementData(weaponElement, "owner", player, false)
			setWeaponProperty(weaponElement, "damage", 15)
			setElementDimension(weaponElement, getElementDimension(localPlayer))
			setElementAlpha(weaponElement, 0)
			setElementCollisionsEnabled(weaponElement, false)
			setWeaponClipAmmo(weaponElement, 10000)
			setWeaponFlags(weaponElement, "disable_model", true)
			attachElements(weaponElement, vehicle, weapon[3], weapon[4] + weapon[2] * 1.2, weapon[5] + weapon[2] * 1.1)
			table.insert(attachedWeapons[player], weaponElement)
		elseif iWeapon == 7 then
			local weaponElement = createWeapon("m4", 0, 0, 0)
			setElementData(weaponElement, "owner", player, false)
			setWeaponProperty(weaponElement, "damage", 20)
			setElementDimension(weaponElement, getElementDimension(localPlayer))
			setElementAlpha(weaponElement, 0)
			setElementCollisionsEnabled(weaponElement, false)
			setWeaponClipAmmo(weaponElement, 10000)
			setWeaponFlags(weaponElement, "disable_model", true)
			attachElements(weaponElement, vehicle, weapon[3], weapon[4] + weapon[2] * 1.2, weapon[5] + weapon[2] * 0.5)
			table.insert(attachedWeapons[player], weaponElement)
		elseif iWeapon == 3 then
			local weaponElement = createWeapon("m4", 0, 0, 0)
			setElementData(weaponElement, "owner", player, false)
			setWeaponProperty(weaponElement, "damage", 30)
			setElementDimension(weaponElement, getElementDimension(localPlayer))
			setElementAlpha(weaponElement, 0)
			setElementCollisionsEnabled(weaponElement, false)
			setWeaponClipAmmo(weaponElement, 10000)
			setWeaponFlags(weaponElement, "disable_model", true)
			attachElements(weaponElement, vehicle, weapon[3], weapon[4] + weapon[2] * 1.2, weapon[5] + weapon[2] * 0.5)
			table.insert(attachedWeapons[player], weaponElement)
		end
		table.insert(attachedObjects[player], object)
	end
end
function shooterAttachWeapons(player)
	if not player then
		for id, plr in ipairs(getElementsByType("player", getElementParent(localPlayer))) do
			if getElementDimension(plr) == 5001 then
				attachShooterWeapons(plr)
			end
		end
	else
		attachShooterWeapons(player)
	end
end

function bindShooterKeys()
	--[[local keys1 = getBoundKeys("vehicle_fire") or {}
	for keyName, state in pairs(keys1) do
		bindKey(keyName, "down", shooterKeyDown)
		bindKey(keyName, "up", shooterKeyUp)
	end]]
	bindKey("mouse1","down", shooterKeyDown)
	bindKey("lctrl","down", shooterKeyDown)
	bindKey("mouse1","up", shooterKeyUp)
	bindKey("lctrl","up", shooterKeyUp)
end
function unbindShooterKeys()
	unbindKey("mouse1","down", shooterKeyDown)
	unbindKey("lctrl","down", shooterKeyDown)
	unbindKey("mouse1","up", shooterKeyUp)
	unbindKey("lctrl","up", shooterKeyUp)
end
function setArenaData(...)
  return setShooterRoomData(...)
end

function setShooterRoomData(element, key, value)
	setElementData(element, key, value,true)
end

function shooterKeyUp()
	local car = getPedOccupiedVehicle(localPlayer)
	if getElementAlpha(car) < 200 then return false end
	shooterKeyPressed = false
	if getPedOccupiedVehicle(localPlayer) and getElementDimension(localPlayer) == 5001 then
		local level = getElementData(localPlayer, "playerLevel") or 1
		local _, weapon, _, reloadTime = getLevel(level)
		shooterAmmoAddition = 50000 / reloadTime
		if weapon == 7 then
			--setArenaData(localPlayer, "s.laser", nil)
			setArenaData(localPlayer, "s.m4", nil)
		elseif weapon == 3 then
			setArenaData(localPlayer, "s.m4", nil)
		elseif weapon == 4 or weapon == 6 then
			setArenaData(localPlayer, "s.minigun", nil)
		end
	end
end

function shooterKeyDown()
	local car = getPedOccupiedVehicle(localPlayer)
	if getElementAlpha(car) < 200 then return false end
	if startProtect == true then return false end
	if getPedOccupiedVehicle(localPlayer) and getElementDimension(localPlayer) == 5001 then
		do
			local level = getElementData(localPlayer, "playerLevel") or 1
			local _, weapon, _, reloadTime = getLevel(level)
			local vehicle = getPedOccupiedVehicle(localPlayer)
			if not isElement(vehicle) then
				return
			end
			shooterKeyPressed = true
			if weapon == 1 then
				if shooterAmmo == 1000 then
					shootSingleRocket(vehicle)
					shooterAmmoAddition = 50000 / reloadTime
				end
			elseif weapon == 2 then
				local x, y, z = getElementPosition(vehicle)
				local groundZ = getGroundPosition(x, y, z)
				local rX, rY, rZ = getVehicleRotation(vehicle)
				if 1 > math.abs(groundZ - z) then
					z = groundZ + 1
				end
				local x = x + 4 * math.cos(math.rad(rZ + 60))
				local y = y + 4 * math.sin(math.rad(rZ + 60))
				if shooterAmmo >= 500 then
					createProjectile(vehicle, 19, x, y, z, 1, nil)
					shooterAmmo = math.max(shooterAmmo - 500, 0)
				end
				local x, y, z = getElementPosition(vehicle)
				local x = x + 4 * math.cos(math.rad(rZ + 120))
				local y = y + 4 * math.sin(math.rad(rZ + 120))
				if shooterAmmo == 500 then
					createProjectile(vehicle, 19, x, y, z, 1, nil)
					shooterAmmo = 0
				end
				shooterAmmoAddition = 50000 / reloadTime
			elseif weapon == 3 then
				setArenaData(localPlayer, "s.m4", true)
				shooterAmmoAddition = -5
				addShooterAmmo()
			elseif weapon == 4 then
				setArenaData(localPlayer, "s.minigun", true)
				shooterAmmoAddition = -20
				addShooterAmmo()
			elseif weapon == 5 then
				if shooterAmmo == 1000 then
					do
						local launcher
						for id, object in ipairs(getAttachedElements(vehicle)) do
							if getElementModel(object) == 3884 then
								launcher = object
							end
						end
						if launcher and isElement(launcher) then
							function launchRocket()
								if launcher and isElement(launcher) then
									shooterAmmo = 0
									local x, y, z = getElementPosition(launcher)
									local rx, ry, rz = getElementRotation(launcher)
									local vx, vy, vz = getElementVelocity(vehicle)
									local px, py = getPointFromDistanceRotation(x, y, 10, -rz)
									local xRatio, yRatio = px - x, py - y
									local cx, cy, cz, tx, ty, tz = getCameraMatrix()
									local dist3D = getDistanceBetweenPoints3D(cx, cy, cz, tx, ty, tz)
									local sinalpha = (cz - tz) / dist3D
									sinalpha = math.max(sinalpha, 0.31)
									sinalpha = math.min(sinalpha, 0.51)
									local ratio = 1 - (sinalpha - 0.31) * 5
									createProjectile(vehicle, 19, x, y, z + 1.2, 1, nil, 60, 0, rz, 0.05 * xRatio + vx, 0.05 * yRatio + vy, 0.3 * ratio + vz)
								end
							end
							launchRocket()
							setTimer(launchRocket, math.random(300, 400), 1)
							setTimer(launchRocket, math.random(600, 700), 1)
							setTimer(launchRocket, math.random(900, 1000), 1)
							shooterAmmo = 0
							shooterAmmoAddition = 50000 / reloadTime
						end
					end
				end
			elseif weapon == 6 then
				setArenaData(localPlayer, "s.minigun", true)
				shooterAmmoAddition = -20
				addShooterAmmo()
			elseif weapon == 7 then
				---setArenaData(localPlayer, "s.laser", true)
				--shooterAmmoAddition = -30
				--addShooterAmmo()
				setArenaData(localPlayer, "s.m4", true)
				shooterAmmoAddition = -5
				addShooterAmmo()
			elseif weapon == 8 then
				if shooterAmmo == 1000 then
					shootSingleRocket(vehicle)
					setTimer(shootSingleRocket, math.random(200, 300), 1, vehicle)
					setTimer(shootSingleRocket, math.random(400, 500), 1, vehicle)
				end
			elseif weapon == 9 and shooterAmmo == 1000 then
				do
				--[[launchGrenade(0.03)
				setTimer(launchGrenade, 100, 1, 0.045)
				setTimer(launchGrenade, 200, 1, 0.06)
				setTimer(launchGrenade, 300, 1, 0.075)
				shooterAmmo = 0
				shooterAmmoAddition = 50000 / reloadTime]]
				local launcher
						for id, object in ipairs(getAttachedElements(vehicle)) do
							if getElementModel(object) == 951 then
								launcher = object
							end
						end
						if launcher and isElement(launcher) then
							function launchRocket(power)
								if launcher and isElement(launcher) then
									shooterAmmo = 0
									local x, y, z = getElementPosition(launcher)
									local ry, rx, rz = getElementRotation(launcher)
									local vx, vy, vz = getElementVelocity(vehicle)
									local px, py = getPointFromDistanceRotation(x, y, 10, -rz)
									local xRatio, yRatio = px - x, py - y
									local cx, cy, cz, tx, ty, tz = getCameraMatrix()
									local dist3D = getDistanceBetweenPoints3D(cx, cy, cz, tx, ty, tz)
									local sinalpha = (cz - tz) / dist3D
									sinalpha = math.max(sinalpha, 0.31)
									sinalpha = math.min(sinalpha, 0.51)
									local ratio = 1 - (sinalpha - 0.31) * 5
									--createProjectile(vehicle, 16, x, y, z + 1.2, 1, nil, 60, 0, rz, 0.05 * xRatio + vx, 0.05 * yRatio + vy, 0.3 * ratio + vz)
									createProjectile(vehicle, 16, x, y, z + 1, 1, nil, 60, 0, rz, power * xRatio + vx, power * yRatio + vy, 0.2 + vz)
								end
							end
							launchRocket(0.03)
							setTimer(launchRocket, 100, 1,0.045)
							setTimer(launchRocket, 200, 1,0.06)
							setTimer(launchRocket, 300, 1,0.075)
							shooterAmmo = 0
							shooterAmmoAddition = 50000 / reloadTime

						end
				end
			end
		end
	end
end

function shooterOnPreRender()
	local myVehicle = getPedOccupiedVehicle(localPlayer)
	if getElementAlpha(myVehicle) < 200 then return false end
	if startProtect == true then return false end
	--[[if killer and isElement(myVehicle) and getElementHealth(myVehicle) <= 250 then
		killer = nil
		triggerServerEvent("onPlayerShooterPreKilled", localPlayer, nil)
	end]]
	for player, weapons in pairs(attachedWeapons) do
		for id, weapon in ipairs(weapons) do
			setWeaponState(weapon, "ready")
		end
	end
	for id, player in ipairs(getElementsByType("player", getElementParent(localPlayer), true)) do
		--[[if getElementData(player, "s.laser") then
			local vehicle = getPedOccupiedVehicle(player)
			if isElement(vehicle) then
				for i, attachedObject in ipairs(attachedObjects[player] or {}) do
					local x, y, z = getElementPosition(attachedObject)
					local xAttachOffset = getElementAttachedOffsets(attachedObject)
					local tx, ty, tz = getPositionFromElementOffset(vehicle, xAttachOffset, 40, 0)
					local hit, hx, hy, hz, elementHit
					if player == localPlayer then
						hit, hx, hy, hz, elementHit = processLineOfSight(x, y, z, tx, ty, tz, true, true, true, true, false, false, false, false, myVehicle)
					else
						hit, hx, hy, hz, elementHit = processLineOfSight(x, y, z, tx, ty, tz, true, true, true, true, false, false, false, false, vehicle)
					end
					local r, g, b = 255, 0, 0
					if hit then
						if player ~= localPlayer and elementHit == myVehicle then
							local fps = getElementData(localPlayer, "FPS")
							local health = getElementHealth(myVehicle)
							local damageMultiplier = 1
							if #attachedObjects[player] >= 2 then
								damageMultiplier = 0.65
							end
							local newHealth = math.max(0, health - damageMultiplier * (800 / fps))
							setElementHealth(myVehicle, newHealth)
							if health <= 255 then
								killer = player
								dmg[elementHit] = player
								triggerServerEvent("setShooterVehicleHealth",localPlayer,myVehicle,dmg[myVehicle])
								--triggerServerEvent("onPlayerShooterPreKilled", localPlayer, {killer, "laser"})
							end
						end
						dxDrawLine3D(x, y, z, hx, hy, hz, tocolor(r, g, b, 155), 4)
						local vx, vy, vz = x - hx, y - hy, z - hz
						local vectorSize = math.sqrt(vx ^ 2 + vy ^ 2 + vz ^ 2)
						fxAddSparks(hx, hy, hz, vx / vectorSize, vy / vectorSize, vz / vectorSize, 1, 15)
					else
						dxDrawLine3D(x, y, z, tx, ty, tz, tocolor(r, g, b, 155), 4)
					end
				end
			end
		else]]
		--[[if getElementData(player, "s.minigun") then
			local vehicle = getPedOccupiedVehicle(player)
			if isElement(vehicle) and attachedObjects[player] then
				for i, attachedObject in ipairs(attachedObjects[player]) do
					local xOffset = 0
					if #attachedObjects[player] == 2 then
						xOffset = i == 1 and 2 or -2
					end
					local targetX, targetY, targetZ = getPositionFromElementOffset(vehicle, xOffset, 50, 0)
					setWeaponTarget(attachedWeapons[player][i], targetX, targetY, targetZ)
					setWeaponState(attachedWeapons[player][i], "firing")

				end
			end
		elseif getElementData(player, "s.m4") then
			local vehicle = getPedOccupiedVehicle(player)
			if isElement(vehicle) and attachedObjects[player] then
				for i, attachedObject in ipairs(attachedObjects[player]) do
					local xOffset = 0
					if #attachedObjects[player] == 2 then
						xOffset = i == 1 and 2 or -2
					end
					local targetX, targetY, targetZ = getPositionFromElementOffset(vehicle, xOffset, 50, 0)
					setWeaponTarget(attachedWeapons[player][i], targetX, targetY, targetZ)
					setWeaponState(attachedWeapons[player][i], "firing")
				end
			end
		end]]
	end
	if getTickCount() - lastLauncherUpdateTick > 100 then
		lastLauncherUpdateTick = getTickCount()
		for id, player in ipairs(getElementsByType("player", getElementParent(localPlayer), true)) do
			if player ~= localPlayer then
				local theVehicle = getPedOccupiedVehicle(player)
				if theVehicle and isElement(theVehicle) then
					for id, launcher in ipairs(getAttachedElements(theVehicle)) do
						if getElementModel(launcher) == 3884 or getElementModel(launcher) == 951 then
							local rz = getElementData(player, "launcher.rotation")
							if rz then
								local ax, ay, az, arx, ary, arz = getElementAttachedOffsets(launcher)
								attachElements(launcher, theVehicle, ax, ay, az, arx, ary, rz)
							end
						end
					end
				end
			end
		end
	end
	if myVehicle and isElement(myVehicle) then
		for id, launcher in ipairs(getAttachedElements(myVehicle)) do
			if getElementModel(launcher) == 3884 then
				local cx, cy, cz, tx, ty, tz, roll, fov = getCameraMatrix()
				local rot = findRotation(cx, cy, tx, ty)
				local rx, ry, rz = getElementRotation(myVehicle)
				local ax, ay, az, arx, ary, arz = getElementAttachedOffsets(launcher)
				attachElements(launcher, myVehicle, ax, ay, az, arx, ary, rot - rz)
				if getTickCount() - lastLauncherSyncTick > 100 then
					setShooterRoomData(localPlayer, "launcher.rotation", rot - rz)
					lastLauncherSyncTick = getTickCount()
				end
				break
			end
		end
	end
	if myVehicle and isElement(myVehicle) then
		for id, launcher in ipairs(getAttachedElements(myVehicle)) do
			if getElementModel(launcher) == 951 then
				local cx, cy, cz, tx, ty, tz, roll, fov = getCameraMatrix()
				local rot = findRotation(cx, cy, tx, ty)
				local rx, ry, rz = getElementRotation(myVehicle)
				local ax, ay, az, arx, ary, arz = getElementAttachedOffsets(launcher)
				attachElements(launcher, myVehicle, ax, ay, az, arx, ary, rot - rz)
				if getTickCount() - lastLauncherSyncTick > 100 then
					setShooterRoomData(localPlayer, "launcher.rotation", rot - rz)
					lastLauncherSyncTick = getTickCount()
				end
				break
			end
		end
	end
end

function launchGrenade(power)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local launcher = attachedObjects[localPlayer][1]
	if isElement(vehicle) and isElement(launcher) then
		local x, y, z = getElementPosition(launcher)
		local ry, rx, rz = getElementRotation(vehicle)
		local vx, vy, vz = getElementVelocity(vehicle)
		local cx, cy, cz, tx, ty, tz = getCameraMatrix()
		local px, py = getPositionFromElementOffset(vehicle, 0, 10, 0)
		local xRatio, yRatio = px - x, py - y


		createProjectile(vehicle, 16, x, y, z + 1, 1, nil, 60, 0, rz, power * xRatio + vx, power * yRatio + vy, 0.2 + vz)
	end
end
function shootSingleRocket(vehicle)
	if isElement(vehicle) then
		shooterAmmo = 0
		local x, y, z = getElementPosition(vehicle)
		local groundZ = getGroundPosition(x, y, z)
		local rX, rY, rZ = getVehicleRotation(vehicle)
		local x = x + 4 * math.cos(math.rad(rZ + 90))
		local y = y + 4 * math.sin(math.rad(rZ + 90))
		if math.abs(groundZ - z) < 1 then
			z = groundZ + 1
		end
		local vx, vy, vz = getElementVelocity(vehicle)
		createProjectile(vehicle, 19, x, y, z, 1, nil)
	end
end

function getPointFromDistanceRotation(x, y, dist, angle)
  local a = math.rad(90 - angle)
  local dx = math.cos(a) * dist
  local dy = math.sin(a) * dist
  return x + dx, y + dy
end

function addShooterAmmo()
	shooterAmmo = math.max(math.min(shooterAmmo + shooterAmmoAddition, 1000), 0)
	if shooterKeyPressed then
		shootingEnabled = shooterAmmo > 0
		local level = getElementData(localPlayer, "playerLevel") or 1
		local _, weapon = getLevel(level)
		if weapon == 7 then
			--setArenaData(localPlayer, "s.laser", shootingEnabled)
			setArenaData(localPlayer, "s.m4", shootingEnabled)
		elseif weapon == 3 then
			setArenaData(localPlayer, "s.m4", shootingEnabled)
		elseif weapon == 4 or weapon == 6 then
			setArenaData(localPlayer, "s.minigun", shootingEnabled)
		end
	end
end

function onClientWeaponFire(hitEntity)
	local veh = getPedOccupiedVehicle(localPlayer)
	if hitEntity == veh and isElement(getElementData(source, "owner")) and getElementHealth(veh) >= 250 then
		setTimer(afterClientWeaponFire, 50, 1, getElementData(source, "owner"))
	end
end

function afterClientWeaponFire(attacker)
	local veh = getPedOccupiedVehicle(localPlayer)
	if getElementHealth(veh) < 250 then
		killer = attacker
		dmg[veh] = attacker
		triggerServerEvent("onPlayerShooterPreKilled", localPlayer, {killer, "minigun"})
	end
end

function stopFiring()
	setArenaData(localPlayer, "s.laser", nil)
	setArenaData(localPlayer, "s.minigun", nil)
	setArenaData(localPlayer, "s.m4", nil)
	shooterKeyPressed = false
end

function math.round(number, decimals, method)
	decimals = decimals or 0
	local factor = 10 ^ decimals
	if method == "ceil" or method == "floor" then
		return math[method](number * factor) / factor
	else
		return tonumber(("%." .. decimals .. "f"):format(number))
	end
end


function getPositionFromElementOffset(element, offX, offY, offZ)
	local m = getElementMatrix(element)
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end

function findRotation(x1, y1, x2, y2)
	local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
	if t < 0 then
		t = t + 360
	end
	return t
end







addEvent("shooterclient.prepareRound", true)
function prepareRound(vehicles)
    -- init countdown
	startProtect = true
    startCountdown(2000)
	--unbindKey("lctrl","down",shootRocket)
   -- unbindKey("mouse1","down",shootRocket)

	unbindKey ( "lshift","down", jump)
    -- spawn protection
    for i, vehicle in ipairs(vehicles) do
        for _,vehicle2 in ipairs(vehicles) do
            if(vehicle ~= vehicle2) then
                setElementCollidableWith(vehicle,vehicle2,false)
            end
        end
    end
end
addEventHandler("shooterclient.prepareRound", root, prepareRound)

addEvent("setClientCamera",true)
addEventHandler("setClientCamera",root,function(playing)
	active = true
	suckers = playing
end)
addEvent("removeClientCamera",true)
addEventHandler("removeClientCamera",root,function()
	active = false
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
		dettachShooterWeapons(localPlayer)
	end
end)

addEvent("setLodDistance",true)
addEventHandler("setLodDistance",root,function(v,v2)
	engineSetModelLODDistance(v,v2)
end)

addEvent("setVehicleGun",true)
addEventHandler("setVehicleGun",root,function(who)
	mygun = who
end)



addEventHandler("onClientRender", getRootElement(),function()
	if getElementDimension(localPlayer) == 5001 then
		setPedWeaponSlot(localPlayer,0)
		setElementHealth(localPlayer,100)
		if not isPedInVehicle(localPlayer) then
			if active == true then
				dxDrawText("Please wait...\nGame in progress", 0, 0, screenWidth, screenHeight-250, tocolor(255,255,255),2,"default-bold","center","center")
			end
		end
		local vehicle = getPedOccupiedVehicle( localPlayer )
		if vehicle and isElement(vehicle) then
			if isPedInVehicle(localPlayer) then
				if ( getVehicleController( vehicle ) == localPlayer ) then
					dxDrawRectangle( ( 328 / nX ) * sX, ( 692 / nY ) * sY, ( 189 / nX ) * sX, ( 29 / nY ) * sY, tocolor( 0, 0, 0, 125 ), false )
					dxDrawRectangle( ( 330 / nX ) * sX, ( 697 / nY ) * sY, ( 3*60 / nX ) * sX, ( 19 / nY ) * sY, tocolor( 34, 135, 38, 255 ), false )

					dxDrawRectangle( ( 328 / nX ) * sX, ( 662 / nY ) * sY, ( 189 / nX ) * sX, ( 29 / nY ) * sY, tocolor( 0, 0, 0, 125 ), false )
					dxDrawRectangle( ( 330 / nX ) * sX, ( 667 / nY ) * sY, ( count*60 / nX ) * sX, ( 19 / nY ) * sY, tocolor( 34, 135, 38, 255 ), false )
					dxDrawRectangle( ( 328 / nX ) * sX, ( 632 / nY ) * sY, ( 189 / nX ) * sX, ( 29 / nY ) * sY, tocolor( 0, 0, 0, 125 ), false )
					dxDrawRectangle( ( 330 / nX ) * sX, ( 637 / nY ) * sY, ( count2*60 / nX ) * sX, ( 19 / nY ) * sY, tocolor( 34, 135, 38, 255 ), false )
					text = "Shoot"
					if trigger == true then
						text2 = "Wait"
					else
						text2 = "Jump"
					end
					dxDrawText( text, ( 495 / nX ) * sX, ( 765 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					dxDrawText( text2, ( 495 / nX ) * sX, ( 705 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					--dxDrawText( "Mouse button - Fire", ( 495 / nX ) * sX, ( 815 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					--dxDrawText( "Left Shift - Jump", ( 495 / nX ) * sX, ( 855 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					if shooterAmmo and shooterAmmoAddition then
						dxDrawText( "Ammo: "..(math.floor(shooterAmmo)).."|"..(math.floor(shooterAmmoAddition)), ( 495 / nX ) * sX, ( 820 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					end
				end
			end
		end
		for k, theVehicle in ipairs ( getElementsByType ( "vehicle",resourceRoot ) ) do
			if ( math.floor( getElementHealth( theVehicle ) ) <= 255 ) then
				setVehicleDamageProof( theVehicle, true )
				setVehicleEngineState ( theVehicle, false )
				outputDebugString("Shutdown the car")
				--[[if dmg[theVehicle] then
					triggerServerEvent("setShooterVehicleHealth",localPlayer,theVehicle,dmg[theVehicle])
				else
					triggerServerEvent("setShooterVehicleHealth",localPlayer,theVehicle,nil)
				end]]
			end
		end
	end
end)



addEventHandler ( "onClientVehicleExplode", root,function (atk,wep,loss)
	if getElementDimension(source) == 5001 then
		cancelEvent()
	end
end)
ifWTF = {}
addEventHandler ( "onClientVehicleDamage", root,function (atk,wep,loss)
	if getElementDimension(source) == 5001 then
		if wep and (wep == 19 or wep == 35 or wep == 51 or wep == 31 or wep == 38 or wep == 16) then
			if math.floor(getElementHealth(source))-loss <= 255 then
				if isTimer(ifWTF) then return false end
				--if getElementData(source,"killer") then return false end
				if getElementType(atk) == "weapon" then
					atk = getElementData(atk,"owner")
				end
				setVehicleDamageProof( source, true )
				cancelEvent()
				if theKiller[source] then

				else
					theKiller[source] = atk
					setElementData(source,"killer",atk)
					ifWTF = setTimer(function(veh) if veh and isElement(veh) then theKiller[veh] = nil setElementData(veh,"killer",false) end end,2000,1,source)
				end
				if getElementData(source,"killer") then
					triggerServerEvent("setShooterVehicleHealth",localPlayer,source,getElementData(source,"killer"))---theKiller[source])
				else
					triggerServerEvent("setShooterVehicleHealth",localPlayer,source,nil)
				end
				cancelEvent()
			end
		end
    end
end)
--[[
addEventHandler("onClientVehicleDamage", root,
function(attacker, weapon)
	if attacker then
		if getElementDimension(source) == 5001 then
			if attacker and isElement(attacker) and getElementType(attacker) == "vehicle" then
				local driver = getVehicleOccupant(source,0)
				local driver2 = getVehicleOccupant(attacker,0)
				if driver then
					if dmg[source] then return false end
					dmg[source] = driver2
					setTimer(function(veh) dmg[veh] = nil end,1000,1,source)
				end
			end
		end
	end
end)]]

function jump()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local team = getPlayerTeam(localPlayer)
	if ( isElement(vehicle) ) and (isVehicleOnGround( vehicle )) and getElementDimension(localPlayer) == 5001 then
		if trigger == false then
			triggerServerEvent("rabbitjump",localPlayer,vehicle)
			trigger = true
			antiSpam2 = setTimer(function()
				trigger = false
				count2 = 3
			end,3000,1)
		end
	end
end
bindKey ( "lshift","down", jump)

addEvent("shooterclient.gameStopSpawnProtection", true)
function stopSpawnProtection(vehicles)
    canFireRockets = true
	startProtect = false
	bindShooterKeys()
	bindKey ( "lshift","down", jump)
    for i, vehicle in ipairs(vehicles) do
        for _,vehicle2 in ipairs(vehicles) do
            if(vehicle ~= vehicle2) then
                setElementCollidableWith(vehicle,vehicle2,true)

                --bindKey("lctrl","down",shootRocket)
                --bindKey("mouse1","down",shootRocket)

            end
        end
    end
end
addEventHandler("shooterclient.gameStopSpawnProtection", root, stopSpawnProtection)

function gameTick()

end

local roundWinner = false

addEvent("shooterclient.roundWon", true)
function onRoundWon()
    if(getElementDimension(localPlayer) ~= 5001) then return false end
    roundWinner = source
    addEventHandler("onClientRender", root, renderWinner)
end
addEventHandler("shooterclient.roundWon", root, onRoundWon)

addEvent("shooterclient.roundEnd", true)
addEvent("onPlayerExitRoom", true)
function onRoundEnd()
    if(roundWinner) then
        removeEventHandler("onClientRender", root, renderWinner)
    end
    roundWinner = false
end
addEventHandler("shooterclient.roundEnd", root, onRoundEnd)
addEventHandler("onPlayerExitRoom", localPlayer, onRoundEnd)


function renderWinner()
	if getElementDimension(localPlayer) == 5001 then
		if(isElement(roundWinner)) then
			local name = getPlayerName(roundWinner)
			dxDrawText("Winner:\n\n"..name, 0, 0, screenWidth, screenHeight, tocolor(math.random(0,255),math.random(0,255),math.random(0,255)),4,"default-bold","center","center")
		end
    end
end

function findPointFromDistanceRotation(x,y, angle, dist)
    local angle = math.rad(angle+90)
    return x+(dist * math.cos(angle)), y+(dist * math.sin(angle))
end

local ROCKET_INTERVAL = 3000
local lastRocket = 0
function shootRocket()
	local vehicle = false
    if(getElementDimension(localPlayer) ~= 5001) then return false end
    if(not canFireRockets or getTickCount() - lastRocket < ROCKET_INTERVAL) then return false end
    local veh = getPedOccupiedVehicle(localPlayer)
    if (veh) then
        lastRocket = getTickCount()
		if mygun and isElement(mygun) then
			vehicle = mygun
		else
			vehicle = veh
		end
		local x,y,z = getElementPosition(vehicle)
        local rx,ry,rz = getElementRotation(veh)
        local px, py = findPointFromDistanceRotation(x,y,rz,4)
        local velocity = 60
        local nrotX = -rx
        local nrotZ = -(rz + 180)

        local vz = velocity * math.sin(math.rad(rx))
        local a = velocity * math.cos(math.rad(rx))

        local vx = a * math.sin(math.rad(-rz))
        local vy = a * math.cos(math.rad(-rz))
        local pz = z+(vz/50)+0.2
		outputDebugString("Shoot")
        createProjectile(localPlayer, 19, px, py, pz, 1.0, nil, nrotX, 0, nrotZ, vx / 50, vy / 50, vz / 50)--,1225)
        ---createProjectile(localPlayer, 16, px, py, pz, 1.0, nil, nrotX, 0, nrotZ, vx / 50, vy / 50, vz / 50,1225)
		count = 0
		setTimer(function() count = 3 end,3000,1)
    end
end
--bindKey("mouse1","down",shootRocket)
--bindKey("lctrl","down",shootRocket)


function getRocketWaitProgress()
    local timeIn = getTickCount()-lastRocket
    return math.min(1, timeIn/ROCKET_INTERVAL)
end

addEvent("shooterclient.playerWasted", true)
function onPlayerWasted(rank, timex, nick,byw)
	if byw == "" or byw == nil then
		outputChatBox("[ "..rank.." ] "..nick.." | "..timex,0,255,0)
	else
		outputChatBox("[ "..rank.." ] "..byw.." has killed "..nick.." | "..timex,0,255,0)
	end
end
addEventHandler("shooterclient.playerWasted", root, onPlayerWasted)

addEvent("shooterclient.freezeCamera", true)
function freezeCamera()
    local x,y,z,lx,ly,lz,roll,fov = getCameraMatrix()
    setCameraMatrix(x,y,z+50,lx,ly,lz,roll,fov)
end
addEventHandler("shooterclient.freezeCamera", localPlayer, freezeCamera)




addEvent("loadShooterMap",true)
addEventHandler("loadShooterMap",root,function(temp)
	if temp then
		if unloadMap() then
			for k,v in ipairs(temp) do
				local obj = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
				setElementDimension(obj, 5001)
				engineSetModelLODDistance ( v[1], 500 )
				--[[local obj2 = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7],true)
				setElementDimension(obj, 5001)
				setElementDimension(obj2, 5001)
				setLowLODElement(obj,obj2)]]
			end
		end
	else
		outputChatBox("invalid map")
	end
end)


function unloadMap()
	for k, v in ipairs(getElementsByType("object",resourceRoot)) do
		if v and isElement(v) then
			if getElementDimension(v) == 5001 then
				destroyElement(v)
			end
		end
	end
	return true
end



function getShooterData()
  return vehicleName, vehicles, weapons
end
vehicleName = {
  [445] = "Admiral",
  [401] = "Bravura",
  [536] = "Blade",
  [527] = "Cadrona",
  [550] = "Sunrise",
  [442] = "Romero",
  [555] = "Windsor",
  [404] = "Perennial",
  [474] = "Hermes",
  [545] = "Hustler",
  [479] = "Regina",
  [478] = "Walton",
  [496] = "Blista Compact",
  [602] = "Alpha",
  [504] = "Bloodring Banger",
  [439] = "Stallion",
  [420] = "Taxi",
  [589] = "Club",
  [565] = "Flash",
  [542] = "Clover",
  [562] = "Elegy",
  [561] = "Stratum",
  [560] = "Sultan",
  [559] = "Jester",
  [558] = "Uranus",
  [535] = "Slamvan",
  [415] = "Cheetah",
  [411] = "Infernus",
  [603] = "Phoenix",
  [480] = "Comet",
  [451] = "Turismo",
  [587] = "Euros",
  [402] = "Buffalo",
  [477] = "ZR-350",
  [541] = "Bullet",
  [533] = "Feltzer",
  [429] = "Banshee",
  [506] = "Super GT",
  [494] = "Hotring Racer",
  [495] = "Sandking",
  [580] = "Stafford",
  [579] = "Huntley",
  [482] = "Burrito",
  [470] = "Patriot",
  [483] = "Camper",
  [554] = "Yosemite",
  [596] = "Police Car",
  [599] = "Police Ranger",
  [490] = "FBI Rancher",
  [416] = "Ambulance",
  [407] = "Firetruck",
  [528] = "FBI Truck",
  [427] = "Enforcer",
  [428] = "Securicar",
  [525] = "Towtruck",
  [498] = "Boxville",
  [508] = "Journey",
  [573] = "Dune",
  [455] = "Flatbed",
  [514] = "Tanker",
  [431] = "Bus",
  [443] = "Packer",
  [423] = "Mr. Whopee",
  [588] = "Hotdog",
  [444] = "Monster",
  [539] = "Vortex",
  [531] = "Tractor",
  [571] = "Kart",
  [471] = "Quad",
  [583] = "Tug",
  [400] = "Landstalker",
  [403] = "Linerunner",
  [405] = "Sentinel",
  [408] = "Trashmaster",
  [409] = "Stretch",
  [410] = "Manana",
  [412] = "Voodoo",
  [413] = "Pony",
  [414] = "Mule",
  [418] = "Moonbeam",
  [419] = "Esperanto",
  [421] = "Washington",
  [422] = "Bobcat",
  [424] = "BF Injection",
  [426] = "Premier",
  [433] = "Barracks",
  [434] = "Hotknife",
  [436] = "Previon",
  [437] = "Coach",
  [438] = "Cabbie",
  [439] = "Stallion",
  [440] = "Rumpo",
  [456] = "Yankee",
  [457] = "Caddy",
  [458] = "Solair",
  [459] = "Topfun Van",
  [466] = "Glendale",
  [467] = "Oceanic",
  [475] = "Sabre",
  [489] = "Rancher",
  [490] = "FBI Rancher",
  [491] = "Virgo",
  [492] = "Greenwood",
  [499] = "Benson",
  [500] = "Mesa",
  [502] = "Hotring Racer",
  [503] = "Hotring Racer",
  [507] = "Elegant",
  [515] = "Roadtrain",
  [516] = "Nebula",
  [517] = "Majestic",
  [518] = "Buccaneer",
  [524] = "Cement Truck",
  [526] = "Fortune",
  [529] = "Willard",
  [534] = "Remington",
  [540] = "Vincent",
  [543] = "Sadler",
  [544] = "Firetruck LA",
  [546] = "Intruder",
  [547] = "Primo",
  [549] = "Tampa",
  [551] = "Merit",
  [552] = "Utility Van",
  [566] = "Tahoma",
  [567] = "Savanna",
  [568] = "Bandito",
  [572] = "Mower",
  [574] = "Sweeper",
  [575] = "Broadway",
  [576] = "Tornado",
  [578] = "DFT-30",
  [582] = "Newsvan",
  [585] = "Emperor",
  [600] = "Picador",
  [601] = "S.W.A.T."
}
vehicles = {
  445,
  401,
  536,
  527,
  550,
  442,
  555,
  404,
  474,
  545,
  479,
  478,
  496,
  602,
  504,
  439,
  420,
  589,
  565,
  542,
  562,
  561,
  560,
  559,
  558,
  535,
  415,
  411,
  603,
  480,
  451,
  587,
  402,
  477,
  541,
  533,
  429,
  506,
  494,
  495,
  580,
  579,
  482,
  470,
  483,
  554,
  596,
  599,
  490,
  416,
  407,
  528,
  427,
  428,
  525,
  498,
  508,
  573,
  455,
  514,
  431,
  443,
  423,
  588,
  444,
  539,
  531,
  571,
  471,
  583,
  400,
  403,
  405,
  408,
  409,
  410,
  412,
  413,
  414,
  418,
  419,
  421,
  422,
  424,
  426,
  433,
  434,
  436,
  437,
  438,
  439,
  440,
  456,
  457,
  458,
  459,
  466,
  467,
  475,
  489,
  490,
  491,
  492,
  499,
  500,
  502,
  503,
  507,
  515,
  516,
  517,
  518,
  524,
  526,
  529,
  534,
  540,
  543,
  544,
  546,
  547,
  549,
  551,
  552,
  566,
  567,
  568,
  572,
  574,
  575,
  576,
  578,
  582,
  585,
  600,
  601
}
weapons = {
  [1] = {
    [474] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.471,
        0,
        0,
        270
      }
    },
    [445] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.316,
        0,
        0,
        270
      }
    },
    [401] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.254,
        0,
        0,
        270
      }
    },
    [401] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.298,
        0,
        0,
        270
      }
    },
    [536] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.218,
        0,
        0,
        270
      }
    },
    [527] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.43,
        0,
        0,
        270
      }
    },
    [550] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.165,
        0,
        0,
        270
      }
    },
    [498] = {
      {
        3790,
        0.6,
        0,
        1.1,
        2.1,
        0,
        0,
        270
      }
    },
    [477] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.26,
        0,
        0,
        270
      }
    },
    [504] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.32,
        0,
        0,
        270
      }
    },
    [496] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.3,
        0,
        0,
        270
      }
    },
    [602] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.225,
        0,
        0,
        270
      }
    },
    [442] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.25,
        0,
        0,
        270
      }
    },
    [415] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.135,
        0,
        0,
        270
      }
    },
    [439] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.31,
        0,
        0,
        270
      }
    },
    [420] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.3,
        0,
        0,
        270
      }
    },
    [603] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.2,
        0,
        0,
        270
      }
    },
    [495] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.47,
        0,
        0,
        270
      }
    },
    [423] = {
      {
        3790,
        0.6,
        0,
        1.5,
        1.51,
        0,
        0,
        270
      }
    },
    [555] = {
      {
        3790,
        0.6,
        0,
        1.5,
        0.2,
        0,
        0,
        270
      }
    },
    [596] = {
      {
        3790,
        0.6,
        0,
        2,
        0.3,
        0,
        0,
        270
      }
    },
    [599] = {
      {
        3790,
        0.6,
        0,
        2,
        0.5,
        0,
        0,
        270
      }
    },
    [490] = {
      {
        3790,
        0.6,
        0,
        2.4,
        0.5,
        0,
        0,
        270
      }
    },
    [589] = {
      {
        3790,
        0.6,
        0,
        2,
        0.5,
        0,
        0,
        270
      }
    },
    [480] = {
      {
        3790,
        0.6,
        0,
        1.5,
        0.26,
        0,
        0,
        270
      }
    },
    [588] = {
      {
        3790,
        1,
        1.6,
        1.3,
        1.6,
        0,
        0,
        270
      }
    },
    [451] = {
      {
        3790,
        0.6,
        0,
        1.85,
        0.175,
        0,
        0,
        270
      }
    },
    [587] = {
      {
        3790,
        0.6,
        0,
        1.8,
        0.28,
        0,
        0,
        270
      }
    },
    [416] = {
      {
        3790,
        0.6,
        0,
        0.05,
        1.78,
        0,
        0,
        270
      }
    },
    [407] = {
      {
        3790,
        0.6,
        0,
        2.15,
        1.83,
        0,
        0,
        270
      }
    },
    [404] = {
      {
        3790,
        0.45,
        0,
        1.649,
        0.505,
        0,
        0,
        270
      }
    },
    [402] = {
      {
        3790,
        0.56,
        0,
        1.798,
        0.34,
        0,
        0,
        270
      }
    },
    [580] = {
      {
        3790,
        0.56,
        0,
        1.798,
        0.489,
        0,
        0,
        270
      }
    },
    [579] = {
      {
        3790,
        0.56,
        0,
        1.798,
        0.574,
        0,
        0,
        270
      }
    },
    [482] = {
      {
        3790,
        0.56,
        0,
        0.373,
        0.924,
        0,
        0,
        270
      }
    },
    [573] = {
      {
        3790,
        0.64,
        0,
        2.072,
        1.599,
        0,
        0,
        270
      }
    },
    [565] = {
      {
        3790,
        0.45,
        0,
        1.621,
        0.299,
        0,
        0,
        270
      }
    },
    [562] = {
      {
        3790,
        0.45,
        0,
        1.621,
        0.374,
        0,
        0,
        270
      }
    },
    [455] = {
      {
        3790,
        0.68,
        0,
        3.021,
        0.899,
        0,
        0,
        270
      }
    },
    [561] = {
      {
        3790,
        0.4,
        0,
        2.021,
        0.274,
        0,
        0,
        270
      }
    },
    [560] = {
      {
        3790,
        0.4,
        0,
        1.821,
        0.399,
        0,
        0,
        270
      }
    },
    [559] = {
      {
        3790,
        0.66,
        0,
        1.77,
        0.349,
        0,
        0,
        270
      }
    },
    [470] = {
      {
        3790,
        0.49,
        0,
        1.495,
        0.519,
        0,
        0,
        270
      }
    },
    [558] = {
      {
        3790,
        0.49,
        0,
        1.519,
        0.359,
        0,
        0,
        270
      }
    },
    [444] = {
      {
        3790,
        0.49,
        0,
        2.219,
        1.069,
        0,
        0,
        270
      }
    },
    [554] = {
      {
        3790,
        0.49,
        0,
        1.818,
        0.414,
        0,
        0,
        270
      }
    },
    [545] = {
      {
        3790,
        0.49,
        0,
        1.117,
        0.364,
        0,
        0,
        270
      }
    },
    [542] = {
      {
        3790,
        0.64,
        0,
        1.792,
        0.314,
        0,
        0,
        270
      }
    },
    [541] = {
      {
        3790,
        0.4,
        0,
        1.867,
        0.264,
        0,
        0,
        270
      }
    },
    [533] = {
      {
        3790,
        0.4,
        0,
        1.966,
        0.279,
        0,
        0,
        270
      }
    },
    [539] = {
      {
        3790,
        0.56,
        0,
        -1.184,
        1.129,
        0,
        0,
        270
      }
    },
    [535] = {
      {
        3790,
        0.56,
        0,
        0.166,
        0.779,
        0,
        0,
        270
      }
    },
    [531] = {
      {
        3790,
        0.56,
        0,
        0.966,
        0.429,
        0,
        0,
        270
      }
    },
    [429] = {
      {
        3790,
        0.56,
        0,
        1.566,
        0.304,
        0,
        0,
        270
      }
    },
    [528] = {
      {
        3790,
        0.56,
        0,
        0.19,
        1.044,
        0,
        0,
        270
      }
    },
    [427] = {
      {
        3790,
        0.56,
        0,
        2.689,
        0.644,
        0,
        0,
        270
      }
    },
    [428] = {
      {
        3790,
        0.56,
        0,
        2.138,
        0.444,
        0,
        0,
        270
      }
    },
    [525] = {
      {
        3790,
        0.56,
        0,
        2.338,
        0.819,
        0,
        0,
        270
      }
    },
    [514] = {
      {
        3790,
        0.56,
        0,
        3.337,
        0.644,
        0,
        0,
        270
      }
    },
    [508] = {
      {
        3790,
        0.56,
        0,
        2.1,
        1.7,
        0,
        0,
        270
      }
    },
    [506] = {
      {
        3790,
        0.56,
        0,
        2.1,
        0.2,
        0,
        0,
        270
      }
    },
    [494] = {
      {
        3790,
        0.56,
        0,
        2.1,
        0.2,
        0,
        0,
        270
      }
    },
    [483] = {
      {
        3790,
        0.56,
        0,
        2.1,
        1.1,
        0,
        0,
        270
      }
    },
    [479] = {
      {
        3790,
        0.56,
        0,
        2.5,
        0.4,
        0,
        0,
        270
      }
    },
    [571] = {
      {
        3790,
        0.25,
        0,
        1.399,
        -0.1,
        0,
        0,
        270
      }
    },
    [478] = {
      {
        3790,
        0.64,
        0,
        2,
        0.4,
        0,
        0,
        270
      }
    },
    [431] = {
      {
        3790,
        1.2,
        0,
        5.3,
        2.2,
        0,
        0,
        270
      }
    },
    [471] = {
      {
        3790,
        0.34,
        0,
        0.8,
        0.5,
        0,
        0,
        270
      }
    },
    [443] = {
      {
        3790,
        0.6,
        0,
        5.8,
        0.7,
        0,
        0,
        270
      }
    },
    [583] = {
      {
        3790,
        0.34,
        0,
        1.199,
        0.8,
        0,
        0,
        270
      }
    },
    [411] = {
      {
        3790,
        0.63,
        0,
        2.699,
        0.2,
        0,
        0,
        270
      }
    },
    [400] = {
      {
        3790,
        0.63,
        0,
        2.3,
        0.265,
        0,
        0,
        270
      }
    },
    [403] = {
      {
        3790,
        0.6,
        0,
        4.399,
        0.679,
        0,
        0,
        270
      }
    },
    [405] = {
      {
        3790,
        0.6,
        0,
        2.6,
        0.309,
        0,
        0,
        270
      }
    },
    [406] = {
      {
        3790,
        2,
        0,
        6.7,
        1.267,
        0,
        0,
        270
      }
    },
    [408] = {
      {
        3790,
        0.6,
        0,
        5,
        0.381,
        0,
        0,
        270
      }
    },
    [409] = {
      {
        3790,
        0.6,
        0,
        3.1,
        0.319,
        0,
        0,
        270
      }
    },
    [410] = {
      {
        3790,
        0.6,
        0,
        1.8,
        0.576,
        0,
        0,
        270
      }
    },
    [412] = {
      {
        3790,
        0.6,
        0,
        2.344,
        0.355,
        0,
        0,
        270
      }
    },
    [413] = {
      {
        3790,
        0.6,
        0,
        3.1,
        0.295,
        0,
        0,
        270
      }
    },
    [414] = {
      {
        3790,
        0.6,
        0,
        3.3,
        0.469,
        0,
        0,
        270
      }
    },
    [418] = {
      {
        3790,
        0.6,
        0,
        2.9,
        0.134,
        0,
        0,
        270
      }
    },
    [419] = {
      {
        3790,
        0.6,
        0,
        2.6,
        0.2,
        0,
        0,
        270
      }
    },
    [421] = {
      {
        3790,
        0.6,
        0,
        2.703,
        0.086,
        0,
        0,
        270
      }
    },
    [422] = {
      {
        3790,
        0.6,
        0,
        2.522,
        0.308,
        0,
        0,
        270
      }
    },
    [424] = {
      {
        3790,
        0.6,
        0,
        1.978,
        0.29,
        0,
        0,
        270
      }
    },
    [426] = {
      {
        3790,
        0.6,
        0,
        1.978,
        0.251,
        0,
        0,
        270
      }
    },
    [433] = {
      {
        3790,
        1,
        0,
        3.3,
        1,
        0,
        0,
        270
      }
    },
    [434] = {
      {
        3790,
        0.6,
        0,
        1.344,
        0.292,
        0,
        0,
        270
      }
    },
    [436] = {
      {
        3790,
        0.6,
        0,
        2,
        0.252,
        0,
        0,
        270
      }
    },
    [437] = {
      {
        3790,
        1,
        0,
        5,
        1.956,
        0,
        0,
        270
      }
    },
    [438] = {
      {
        3790,
        0.6,
        0,
        2.5,
        0.226,
        0,
        0,
        270
      }
    },
    [439] = {
      {
        3790,
        0.6,
        0,
        2.5,
        0.168,
        0,
        0,
        270
      }
    },
    [440] = {
      {
        3790,
        0.6,
        0,
        2.6,
        0.222,
        0,
        0,
        270
      }
    },
    [456] = {
      {
        3790,
        0.6,
        0,
        3.2,
        0.658,
        0,
        0,
        270
      }
    },
    [457] = {
      {
        3790,
        0.34,
        0,
        1.3,
        0.212,
        0,
        0,
        270
      }
    },
    [458] = {
      {
        3790,
        0.6,
        0,
        2.5,
        0.147,
        0,
        0,
        270
      }
    },
    [459] = {
      {
        3790,
        0.6,
        0,
        3,
        0.367,
        0,
        0,
        270
      }
    },
    [466] = {
      {
        3790,
        0.6,
        0,
        2.2,
        0.343,
        0,
        0,
        270
      }
    },
    [467] = {
      {
        3790,
        0.6,
        0,
        2.2,
        0.287,
        0,
        0,
        270
      }
    },
    [475] = {
      {
        3790,
        0.6,
        0,
        2.2,
        0.162,
        0,
        0,
        270
      }
    },
    [489] = {
      {
        3790,
        0.6,
        0,
        2.6,
        0.57,
        0,
        0,
        270
      }
    },
    [490] = {
      {
        3790,
        0.6,
        0,
        3.3,
        0.457,
        0,
        0,
        270
      }
    },
    [491] = {
      {
        3790,
        0.6,
        0,
        2.4,
        0.202,
        0,
        0,
        270
      }
    },
    [492] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.346,
        0,
        0,
        270
      }
    },
    [499] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.43,
        0,
        0,
        270
      }
    },
    [500] = {
      {
        3790,
        0.6,
        0,
        1.9,
        0.229,
        0,
        0,
        270
      }
    },
    [502] = {
      {
        3790,
        0.6,
        0,
        1.9,
        0.19,
        0,
        0,
        270
      }
    },
    [503] = {
      {
        3790,
        0.6,
        0,
        1.9,
        0.216,
        0,
        0,
        270
      }
    },
    [507] = {
      {
        3790,
        0.6,
        0,
        2.1,
        0.261,
        0,
        0,
        270
      }
    },
    [515] = {
      {
        3790,
        1,
        0,
        3.9,
        0.394,
        0,
        0,
        270
      }
    },
    [516] = {
      {
        3790,
        0.6,
        0,
        2.4,
        0.313,
        0,
        0,
        270
      }
    },
    [517] = {
      {
        3790,
        0.6,
        0,
        2.4,
        0.273,
        0,
        0,
        270
      }
    },
    [518] = {
      {
        3790,
        0.6,
        0,
        2.4,
        0.297,
        0,
        0,
        270
      }
    },
    [524] = {
      {
        3790,
        0.6,
        0,
        3.8,
        0.302,
        0,
        0,
        270
      }
    },
    [526] = {
      {
        3790,
        0.6,
        0,
        2.2,
        0.191,
        0,
        0,
        270
      }
    },
    [529] = {
      {
        3790,
        0.6,
        0,
        1.9,
        0.364,
        0,
        0,
        270
      }
    },
    [534] = {
      {
        3790,
        0.6,
        0,
        2.3,
        0.22,
        0,
        0,
        270
      }
    },
    [540] = {
      {
        3790,
        0.6,
        0,
        2.3,
        0.197,
        0,
        0,
        270
      }
    },
    [543] = {
      {
        3790,
        0.6,
        0,
        2.3,
        0.328,
        0,
        0,
        270
      }
    },
    [544] = {
      {
        3790,
        0.6,
        0,
        3.2,
        1.408,
        0,
        0,
        270
      }
    },
    [546] = {
      {
        3790,
        0.6,
        0,
        2,
        0.353,
        0,
        0,
        270
      }
    },
    [547] = {
      {
        3790,
        0.6,
        0,
        2.4,
        0.382,
        0,
        0,
        270
      }
    },
    [549] = {
      {
        3790,
        0.6,
        0,
        2.5,
        0.336,
        0,
        0,
        270
      }
    },
    [551] = {
      {
        3790,
        0.6,
        0,
        2.4,
        0.25,
        0,
        0,
        270
      }
    },
    [552] = {
      {
        3790,
        0.6,
        0,
        2.9,
        0.75,
        0,
        0,
        270
      }
    },
    [566] = {
      {
        3790,
        0.6,
        0,
        2.5,
        0.308,
        0,
        0,
        270
      }
    },
    [567] = {
      {
        3790,
        0.6,
        0,
        2.5,
        0.138,
        0,
        0,
        270
      }
    },
    [568] = {
      {
        3790,
        0.6,
        0,
        2.5,
        0.009,
        0,
        0,
        270
      }
    },
    [572] = {
      {
        3790,
        0.6,
        0,
        1.1,
        0.382,
        0,
        0,
        270
      }
    },
    [574] = {
      {
        3790,
        0.6,
        0,
        1.4,
        1.316,
        0,
        0,
        270
      }
    },
    [575] = {
      {
        3790,
        0.6,
        0,
        2,
        0.499,
        0,
        0,
        270
      }
    },
    [576] = {
      {
        3790,
        0.6,
        0,
        2,
        0.361,
        0,
        0,
        270
      }
    },
    [578] = {
      {
        3790,
        0.6,
        0,
        3.6,
        1.312,
        0,
        0,
        270
      }
    },
    [582] = {
      {
        3790,
        0.6,
        0,
        2.6,
        0.347,
        0,
        0,
        270
      }
    },
    [585] = {
      {
        3790,
        0.6,
        0,
        2.6,
        0.364,
        0,
        0,
        270
      }
    },
    [600] = {
      {
        3790,
        0.6,
        0,
        2.6,
        0.284,
        0,
        0,
        270
      }
    },
    [601] = {
      {
        3790,
        0.6,
        0,
        3.2,
        0.959,
        0,
        0,
        270
      }
    }
  },
  [2] = {
    [474] = {
      {
        3786,
        0.6,
        1.199,
        2.199,
        -0.129,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.199,
        2.199,
        -0.129,
        0,
        0,
        270
      }
    },
    [445] = {
      {
        3786,
        0.6,
        -1.111,
        1.503,
        -0.036,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        1.116,
        1.503,
        -0.036,
        0,
        0,
        270
      }
    },
    [401] = {
      {
        3786,
        0.6,
        1.115,
        1.503,
        0.016,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.11,
        1.503,
        0.016,
        0,
        0,
        270
      }
    },
    [401] = {
      {
        3786,
        0.6,
        -1.11,
        1.503,
        0.1,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        1.115,
        1.503,
        0.1,
        0,
        0,
        270
      }
    },
    [536] = {
      {
        3786,
        0.6,
        1.115,
        1.503,
        -0.054,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.11,
        1.503,
        -0.054,
        0,
        0,
        270
      }
    },
    [527] = {
      {
        3786,
        0.6,
        -1.11,
        1.503,
        -0.002,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        1.115,
        1.503,
        -0.002,
        0,
        0,
        270
      }
    },
    [550] = {
      {
        3786,
        0.6,
        -1.2,
        1.5,
        -0.1,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        1.2,
        1.5,
        -0.1,
        0,
        0,
        270
      }
    },
    [498] = {
      {
        3786,
        0.6,
        -1.4,
        1.9,
        0.3,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        1.4,
        1.9,
        0.3,
        0,
        0,
        270
      }
    },
    [477] = {
      {
        3786,
        0.6,
        -1.174,
        1.324,
        0.225,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        1.101,
        1.324,
        0.225,
        0,
        0,
        270
      }
    },
    [504] = {
      {
        3786,
        0.6,
        1.051,
        1.724,
        0.3,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.05,
        1.724,
        0.3,
        0,
        0,
        270
      }
    },
    [496] = {
      {
        3786,
        0.6,
        1.051,
        1.373,
        0.1,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.049,
        1.373,
        0.1,
        0,
        0,
        270
      }
    },
    [602] = {
      {
        3786,
        0.6,
        1.177,
        1.373,
        0.025,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.149,
        1.373,
        0.025,
        0,
        0,
        270
      }
    },
    [442] = {
      {
        3786,
        0.6,
        1.151,
        1.998,
        0.125,
        0,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.15,
        1.997,
        0.125,
        0,
        0,
        270
      }
    },
    [415] = {
      {
        3786,
        0.6,
        0.976,
        1.771,
        -0.025,
        335,
        0,
        270
      },
      {
        3786,
        0.6,
        -0.999,
        1.772,
        -0.025,
        25,
        0,
        270
      }
    },
    [439] = {
      {
        3786,
        0.6,
        1.076,
        1.496,
        0.075,
        335,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.075,
        1.496,
        0.075,
        25,
        0,
        270
      }
    },
    [420] = {
      {
        3786,
        0.5,
        -1.074,
        1.721,
        0.2,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        1.076,
        1.721,
        0.2,
        335,
        0,
        270
      }
    },
    [603] = {
      {
        3786,
        0.6,
        1.175,
        1.721,
        0.1,
        335,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.15,
        1.721,
        0.1,
        25,
        0,
        270
      }
    },
    [495] = {
      {
        3786,
        0.6,
        1.176,
        1.721,
        0.25,
        335,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.174,
        1.721,
        0.25,
        25,
        0,
        270
      }
    },
    [423] = {
      {
        3786,
        0.6,
        1.026,
        0.946,
        1.45,
        335,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.025,
        0.945,
        1.45,
        25,
        0,
        270
      }
    },
    [555] = {
      {
        3786,
        0.4,
        -0.824,
        1.545,
        0.175,
        25,
        0,
        270
      },
      {
        3786,
        0.4,
        0.851,
        1.545,
        0.175,
        335,
        0,
        270
      }
    },
    [596] = {
      {
        3786,
        0.56,
        -1.075,
        1.619,
        0.175,
        25,
        0,
        270
      },
      {
        3786,
        0.56,
        1.051,
        1.62,
        0.175,
        335,
        0,
        270
      }
    },
    [599] = {
      {
        3786,
        0.56,
        1.15,
        1.893,
        0.35,
        335,
        0,
        270
      },
      {
        3786,
        0.56,
        -1.151,
        1.893,
        0.35,
        25,
        0,
        270
      }
    },
    [490] = {
      {
        3786,
        0.56,
        1.15,
        2.342,
        0.4,
        335,
        0,
        270
      },
      {
        3786,
        0.56,
        -1.125,
        2.343,
        0.4,
        25,
        0,
        270
      }
    },
    [589] = {
      {
        3786,
        0.5,
        0.949,
        1.817,
        0.425,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.951,
        1.816,
        0.425,
        25,
        0,
        270
      }
    },
    [480] = {
      {
        3786,
        0.5,
        -1,
        1.441,
        0.225,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        0.975,
        1.441,
        0.225,
        335,
        0,
        270
      }
    },
    [588] = {
      {
        3786,
        1,
        1.075,
        1.441,
        2.2,
        335,
        0,
        270
      },
      {
        3786,
        1,
        -1.051,
        1.441,
        2.2,
        25,
        0,
        270
      }
    },
    [451] = {
      {
        3786,
        0.5,
        1.026,
        1.516,
        0.125,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.025,
        1.516,
        0.125,
        25,
        0,
        270
      }
    },
    [587] = {
      {
        3786,
        0.5,
        1.05,
        1.516,
        0.175,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.05,
        1.516,
        0.175,
        25,
        0,
        270
      }
    },
    [416] = {
      {
        3786,
        0.75,
        -1.275,
        -0.384,
        1.675,
        25,
        0,
        270
      },
      {
        3786,
        0.75,
        1.251,
        -0.384,
        1.675,
        335,
        0,
        270
      }
    },
    [407] = {
      {
        3786,
        0.75,
        1.25,
        3.216,
        1.25,
        335,
        0,
        270
      },
      {
        3786,
        0.75,
        -1.225,
        3.216,
        1.25,
        25,
        0,
        270
      }
    },
    [404] = {
      {
        3786,
        0.5,
        -0.75,
        -0.109,
        0.925,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        0.726,
        -0.108,
        0.925,
        335,
        0,
        270
      }
    },
    [402] = {
      {
        3786,
        0.6,
        -1.099,
        1.667,
        0.175,
        25,
        0,
        270
      },
      {
        3786,
        0.6,
        1.051,
        1.666,
        0.175,
        335,
        0,
        270
      }
    },
    [580] = {
      {
        3786,
        0.6,
        1.176,
        1.866,
        0.374,
        335,
        0,
        270
      },
      {
        3786,
        0.6,
        -1.2,
        1.865,
        0.374,
        25,
        0,
        270
      }
    },
    [579] = {
      {
        3786,
        0.6,
        -0.924,
        -0.335,
        1.149,
        25,
        0,
        270
      },
      {
        3786,
        0.6,
        0.901,
        -0.334,
        1.149,
        335,
        0,
        270
      }
    },
    [482] = {
      {
        3786,
        0.6,
        0.825,
        0.466,
        0.849,
        335,
        0,
        270
      },
      {
        3786,
        0.6,
        -0.85,
        0.466,
        0.849,
        25,
        0,
        270
      }
    },
    [573] = {
      {
        3786,
        0.6,
        -1.025,
        2.266,
        1.574,
        25,
        0,
        270
      },
      {
        3786,
        0.6,
        1,
        2.266,
        1.574,
        335,
        0,
        270
      }
    },
    [565] = {
      {
        3786,
        0.5,
        0.925,
        1.491,
        0.224,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.925,
        1.49,
        0.224,
        25,
        0,
        270
      }
    },
    [562] = {
      {
        3786,
        0.5,
        1.026,
        1.564,
        0.224,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.025,
        1.565,
        0.224,
        25,
        0,
        270
      }
    },
    [455] = {
      {
        3786,
        1.5,
        1.75,
        -1.886,
        0.349,
        335,
        0,
        270
      },
      {
        3786,
        1.5,
        -1.775,
        -1.885,
        0.349,
        25,
        0,
        270
      }
    },
    [561] = {
      {
        3786,
        0.5,
        0.701,
        -0.01,
        0.7,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.724,
        -0.01,
        0.7,
        25,
        0,
        270
      }
    },
    [560] = {
      {
        3786,
        0.5,
        1.051,
        1.74,
        0.25,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.049,
        1.739,
        0.25,
        25,
        0,
        270
      }
    },
    [559] = {
      {
        3786,
        0.5,
        -1.074,
        1.589,
        0.25,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        1.052,
        1.589,
        0.25,
        335,
        0,
        270
      }
    },
    [470] = {
      {
        3786,
        0.5,
        1.052,
        -0.061,
        1.05,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.073,
        -0.061,
        1.05,
        25,
        0,
        270
      }
    },
    [558] = {
      {
        3786,
        0.5,
        -1.022,
        1.49,
        0.324,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        1.004,
        1.49,
        0.324,
        335,
        0,
        270
      }
    },
    [444] = {
      {
        3786,
        0.5,
        1.203,
        2.04,
        1.025,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.198,
        2.04,
        1.025,
        25,
        0,
        270
      }
    },
    [554] = {
      {
        3786,
        0.5,
        -1.147,
        1.915,
        0.45,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        1.129,
        1.915,
        0.45,
        335,
        0,
        270
      }
    },
    [545] = {
      {
        3786,
        0.25,
        -0.872,
        1.489,
        0.025,
        25,
        0,
        270
      },
      {
        3786,
        0.25,
        0.853,
        1.49,
        0.025,
        335,
        0,
        270
      }
    },
    [542] = {
      {
        3786,
        0.6,
        -1.047,
        1.739,
        0.3,
        25,
        0,
        270
      },
      {
        3786,
        0.6,
        1.053,
        1.739,
        0.3,
        335,
        0,
        270
      }
    },
    [541] = {
      {
        3786,
        0.34,
        -0.972,
        1.389,
        0.25,
        25,
        0,
        270
      },
      {
        3786,
        0.34,
        0.978,
        1.389,
        0.25,
        335,
        0,
        270
      }
    },
    [533] = {
      {
        3786,
        0.53,
        -0.997,
        1.664,
        0.249,
        25,
        0,
        270
      },
      {
        3786,
        0.53,
        1.004,
        1.663,
        0.249,
        335,
        0,
        270
      }
    },
    [539] = {
      {
        3786,
        0.53,
        -0.996,
        0.563,
        0.2,
        25,
        0,
        270
      },
      {
        3786,
        0.53,
        1.029,
        0.563,
        0.2,
        335,
        0,
        270
      }
    },
    [535] = {
      {
        3786,
        0.53,
        1.128,
        1.688,
        0.249,
        335,
        0,
        270
      },
      {
        3786,
        0.53,
        -1.122,
        1.687,
        0.249,
        25,
        0,
        270
      }
    },
    [531] = {
      {
        3786,
        0.25,
        0.43,
        1.312,
        0.349,
        335,
        0,
        270
      },
      {
        3786,
        0.25,
        -0.446,
        1.312,
        0.349,
        25,
        0,
        270
      }
    },
    [429] = {
      {
        3786,
        0.44,
        0.88,
        1.387,
        0.275,
        335,
        0,
        270
      },
      {
        3786,
        0.44,
        -0.921,
        1.386,
        0.275,
        25,
        0,
        270
      }
    },
    [528] = {
      {
        3786,
        0.57,
        -0.871,
        -0.014,
        1.024,
        25,
        0,
        270
      },
      {
        3786,
        0.57,
        0.83,
        -0.014,
        1.024,
        335,
        0,
        270
      }
    },
    [427] = {
      {
        3786,
        0.75,
        -1.121,
        -0.389,
        1.574,
        25,
        0,
        270
      },
      {
        3786,
        0.75,
        1.129,
        -0.389,
        1.574,
        335,
        0,
        270
      }
    },
    [428] = {
      {
        3786,
        0.75,
        -1.17,
        -0.713,
        1.574,
        25,
        0,
        270
      },
      {
        3786,
        0.75,
        1.18,
        -0.712,
        1.574,
        335,
        0,
        270
      }
    },
    [525] = {
      {
        3786,
        0.5,
        -1.195,
        2.112,
        0.674,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        1.18,
        2.113,
        0.674,
        335,
        0,
        270
      }
    },
    [514] = {
      {
        3786,
        0.5,
        -1.244,
        3.887,
        0.099,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        1.231,
        3.887,
        0.099,
        25,
        0,
        270
      }
    },
    [508] = {
      {
        3786,
        0.5,
        1.33,
        1.462,
        1.624,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.345,
        1.461,
        1.624,
        25,
        0,
        270
      }
    },
    [506] = {
      {
        3786,
        0.5,
        -0.97,
        1.461,
        0.099,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        0.98,
        1.461,
        0.099,
        25,
        0,
        270
      }
    },
    [494] = {
      {
        3786,
        0.5,
        -0.921,
        1.461,
        0.174,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        0.929,
        1.461,
        0.174,
        335,
        0,
        270
      }
    },
    [483] = {
      {
        3786,
        0.5,
        0.779,
        1.461,
        0.924,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.772,
        1.461,
        0.924,
        25,
        0,
        270
      }
    },
    [479] = {
      {
        3786,
        0.5,
        -1.021,
        1.861,
        0.324,
        25,
        0,
        270
      },
      {
        3786,
        0.5,
        1.004,
        1.86,
        0.324,
        335,
        0,
        270
      }
    },
    [571] = {
      {
        3786,
        0.15,
        0.379,
        0.91,
        -0.076,
        335,
        0,
        270
      },
      {
        3786,
        0.15,
        -0.346,
        0.91,
        -0.076,
        25,
        0,
        270
      }
    },
    [478] = {
      {
        3786,
        0.4,
        -0.971,
        1.61,
        0.249,
        25,
        0,
        270
      },
      {
        3786,
        0.4,
        0.955,
        1.609,
        0.249,
        335,
        0,
        270
      }
    },
    [431] = {
      {
        3786,
        2,
        -1.27,
        3.159,
        2.114,
        25,
        0,
        270
      },
      {
        3786,
        2,
        1.305,
        3.159,
        2.114,
        335,
        0,
        270
      }
    },
    [471] = {
      {
        3786,
        0.25,
        -0.37,
        0.684,
        0.364,
        25,
        0,
        270
      },
      {
        3786,
        0.25,
        0.356,
        0.684,
        0.364,
        335,
        0,
        270
      }
    },
    [443] = {
      {
        3786,
        0.5,
        1.1,
        5.1,
        0,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.145,
        5.134,
        0.014,
        25,
        0,
        270
      }
    },
    [583] = {
      {
        3786,
        0.5,
        0.68,
        0.844,
        0.709,
        334.99,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.67,
        0.844,
        0.709,
        25,
        0,
        270
      }
    },
    [411] = {
      {
        3786,
        0.5,
        1.056,
        1.893,
        0.134,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.045,
        1.894,
        0.134,
        25,
        0,
        270
      }
    },
    [400] = {
      {
        3786,
        0.5,
        1,
        1.4,
        0.065,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1,
        1.4,
        0.065,
        335,
        0,
        270
      }
    },
    [403] = {
      {
        3786,
        0.5,
        -1,
        3.6,
        -0.021,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        0.9,
        3.6,
        0.079,
        335,
        0,
        270
      }
    },
    [405] = {
      {
        3786,
        0.5,
        1,
        1.5,
        0.109,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1,
        1.5,
        0.109,
        335,
        0,
        270
      }
    },
    [406] = {
      {
        3786,
        1.5,
        2.3,
        4.4,
        0.867,
        335,
        0,
        270
      },
      {
        3786,
        1.5,
        -2.5,
        4.4,
        0.867,
        335,
        0,
        270
      }
    },
    [408] = {
      {
        3786,
        0.5,
        -1.091,
        4.686,
        0.012,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        0.994,
        4.686,
        0.012,
        335,
        0,
        270
      }
    },
    [409] = {
      {
        3786,
        0.5,
        0.9,
        3.6,
        0.119,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.9,
        3.6,
        0.119,
        335,
        0,
        270
      }
    },
    [410] = {
      {
        3786,
        0.5,
        -1,
        2.2,
        0.076,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.2,
        0.076,
        335,
        0,
        270
      }
    },
    [412] = {
      {
        3786,
        0.5,
        0.9,
        2.5,
        0.131,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        2.5,
        0.131,
        335,
        0,
        270
      }
    },
    [413] = {
      {
        3786,
        0.5,
        1.1,
        2.3,
        -0.105,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        2.3,
        0.095,
        335,
        0,
        270
      }
    },
    [414] = {
      {
        3786,
        0.5,
        -1.1,
        2.7,
        0.069,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.7,
        0.069,
        335,
        0,
        270
      }
    },
    [418] = {
      {
        3786,
        0.5,
        1.1,
        2.4,
        -0.166,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        2.4,
        -0.166,
        335,
        0,
        270
      }
    },
    [419] = {
      {
        3786,
        0.5,
        -1,
        2.4,
        0.1,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.4,
        0.1,
        335,
        0,
        270
      }
    },
    [421] = {
      {
        3786,
        0.5,
        1,
        2.4,
        -0.177,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1,
        2.4,
        -0.177,
        335,
        0,
        270
      }
    },
    [422] = {
      {
        3786,
        0.5,
        -1.102,
        2.323,
        -0.287,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.074,
        2.323,
        -0.287,
        335,
        0,
        270
      }
    },
    [424] = {
      {
        3786,
        0.5,
        -0.8,
        1.3,
        0.336,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        0.7,
        1.3,
        0.336,
        335,
        0,
        270
      }
    },
    [426] = {
      {
        3786,
        0.5,
        -1.1,
        2,
        0.073,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2,
        0.073,
        335,
        0,
        270
      }
    },
    [433] = {
      {
        3786,
        1.5,
        -1.3,
        1.6,
        0.1,
        335,
        0,
        270
      },
      {
        3786,
        1.5,
        1.4,
        1.6,
        0.1,
        335,
        0,
        270
      }
    },
    [434] = {
      {
        3786,
        0.5,
        0.532,
        1.456,
        0.017,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.556,
        1.456,
        0.017,
        335,
        0,
        270
      }
    },
    [436] = {
      {
        3786,
        0.5,
        -1,
        2.2,
        0.052,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.2,
        0.052,
        335,
        0,
        270
      }
    },
    [437] = {
      {
        3786,
        1.5,
        -1.4,
        3.4,
        0.056,
        335,
        0,
        270
      },
      {
        3786,
        1.5,
        1.5,
        3.4,
        0.056,
        335,
        0,
        270
      }
    },
    [438] = {
      {
        3786,
        0.5,
        -1.181,
        2.199,
        0.018,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.181,
        2.197,
        0.018,
        335,
        0,
        270
      }
    },
    [439] = {
      {
        3786,
        0.5,
        -1,
        2,
        0.068,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2,
        0.068,
        335,
        0,
        270
      }
    },
    [440] = {
      {
        3786,
        0.5,
        -1,
        2,
        0.122,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2,
        0.122,
        335,
        0,
        270
      }
    },
    [456] = {
      {
        3786,
        0.7,
        -1,
        2.6,
        0.158,
        335,
        0,
        270
      },
      {
        3786,
        0.7,
        1,
        2.6,
        0.158,
        335,
        0,
        270
      }
    },
    [457] = {
      {
        3786,
        0.5,
        0.7,
        0.7,
        0.012,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -0.7,
        0.7,
        0.012,
        335,
        0,
        270
      }
    },
    [458] = {
      {
        3786,
        0.5,
        -1.1,
        2.1,
        0.047,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.1,
        0.047,
        335,
        0,
        270
      }
    },
    [459] = {
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.167,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.167,
        335,
        0,
        270
      }
    },
    [466] = {
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.143,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.14,
        2.2,
        0.143,
        335,
        0,
        270
      }
    },
    [467] = {
      {
        3786,
        0.5,
        -1.1,
        2.5,
        0.137,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.5,
        0.137,
        335,
        0,
        270
      }
    },
    [475] = {
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.062,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.062,
        335,
        0,
        270
      }
    },
    [489] = {
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.37,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.37,
        335,
        0,
        270
      }
    },
    [490] = {
      {
        3786,
        0.5,
        1.1,
        2.7,
        0.457,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        2.7,
        0.457,
        335,
        0,
        270
      }
    },
    [491] = {
      {
        3786,
        0.5,
        -0.9,
        2.2,
        0.102,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        0.9,
        2.2,
        0.102,
        335,
        0,
        270
      }
    },
    [492] = {
      {
        3786,
        0.5,
        0.9,
        2.2,
        0.346,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1,
        2.2,
        0.346,
        335,
        0,
        270
      }
    },
    [499] = {
      {
        3786,
        0.5,
        -1,
        2.2,
        0.33,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        0.9,
        2.2,
        0.33,
        335,
        0,
        270
      }
    },
    [500] = {
      {
        3786,
        0.5,
        -0.9,
        2.2,
        0.129,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        0.8,
        2.2,
        0.129,
        335,
        0,
        270
      }
    },
    [502] = {
      {
        3786,
        0.5,
        -1,
        2.2,
        0.09,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.2,
        0.09,
        335,
        0,
        270
      }
    },
    [503] = {
      {
        3786,
        0.5,
        -1,
        2.2,
        0.216,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.2,
        0.216,
        335,
        0,
        270
      }
    },
    [507] = {
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.161,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.161,
        335,
        0,
        270
      }
    },
    [515] = {
      {
        3786,
        0.5,
        1.3,
        3.9,
        -0.306,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.4,
        3.9,
        -0.306,
        335,
        0,
        270
      }
    },
    [516] = {
      {
        3786,
        0.5,
        1,
        1.9,
        0.213,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1,
        1.9,
        0.213,
        335,
        0,
        270
      }
    },
    [517] = {
      {
        3786,
        0.5,
        1,
        1.9,
        0.173,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1,
        1.9,
        0.173,
        335,
        0,
        270
      }
    },
    [518] = {
      {
        3786,
        0.5,
        -1.05,
        2.2,
        0.147,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.09,
        2.2,
        0.197,
        335,
        0,
        270
      }
    },
    [524] = {
      {
        3786,
        0.5,
        -1.2,
        3.1,
        -0.298,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.2,
        3.1,
        -0.298,
        335,
        0,
        270
      }
    },
    [526] = {
      {
        3786,
        0.5,
        -0.9,
        1.9,
        0.091,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        1.9,
        0.091,
        335,
        0,
        270
      }
    },
    [529] = {
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.264,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1,
        2.2,
        0.264,
        335,
        0,
        270
      }
    },
    [534] = {
      {
        3786,
        0.5,
        -1,
        2.6,
        0.12,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.6,
        0.12,
        335,
        0,
        270
      }
    },
    [540] = {
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.097,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.2,
        0.097,
        335,
        0,
        270
      }
    },
    [543] = {
      {
        3786,
        0.5,
        -1,
        2.1,
        0.278,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        2.1,
        0.278,
        335,
        0,
        270
      }
    },
    [544] = {
      {
        3786,
        1,
        -1.2,
        2.2,
        -0.092,
        335,
        0,
        270
      },
      {
        3786,
        1,
        1.3,
        2.2,
        -0.092,
        335,
        0,
        270
      }
    },
    [546] = {
      {
        3786,
        0.5,
        1.1,
        1.9,
        0.253,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        1.9,
        0.253,
        335,
        0,
        270
      }
    },
    [547] = {
      {
        3786,
        0.5,
        -1,
        1.9,
        0.282,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        1.9,
        0.282,
        335,
        0,
        270
      }
    },
    [549] = {
      {
        3786,
        0.5,
        -1,
        1.9,
        0.236,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1,
        1.9,
        0.236,
        335,
        0,
        270
      }
    },
    [551] = {
      {
        3786,
        0.5,
        -1.1,
        1.9,
        0.15,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        1.9,
        0.15,
        335,
        0,
        270
      }
    },
    [552] = {
      {
        3786,
        0.5,
        -1.2,
        2.4,
        0.55,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.2,
        2.4,
        0.55,
        335,
        0,
        270
      }
    },
    [566] = {
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.108,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.108,
        335,
        0,
        270
      }
    },
    [567] = {
      {
        3786,
        0.5,
        1.2,
        2.4,
        0.038,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.2,
        2.4,
        0.038,
        335,
        0,
        270
      }
    },
    [568] = {
      {
        3786,
        0.5,
        -0.5,
        1.6,
        0.109,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        0.4,
        1.6,
        0.109,
        335,
        0,
        270
      }
    },
    [572] = {
      {
        3786,
        0.3,
        -0.3,
        1,
        0.382,
        335,
        0,
        270
      },
      {
        3786,
        0.3,
        0.3,
        1,
        0.382,
        335,
        0,
        270
      }
    },
    [574] = {
      {
        3786,
        0.52,
        -0.8,
        1.4,
        0.316,
        335,
        0,
        270
      },
      {
        3786,
        0.52,
        0.8,
        1.4,
        0.316,
        335,
        0,
        270
      }
    },
    [575] = {
      {
        3786,
        0.52,
        1,
        1.7,
        0.299,
        335,
        0,
        270
      },
      {
        3786,
        0.52,
        -1,
        1.7,
        0.299,
        335,
        0,
        270
      }
    },
    [576] = {
      {
        3786,
        0.52,
        -1.1,
        1.7,
        0.361,
        335,
        0,
        270
      },
      {
        3786,
        0.52,
        1.1,
        1.7,
        0.361,
        335,
        0,
        270
      }
    },
    [578] = {
      {
        3786,
        1,
        -1.4,
        3.6,
        -0.188,
        335,
        0,
        270
      },
      {
        3786,
        1,
        1.4,
        3.6,
        -0.188,
        335,
        0,
        270
      }
    },
    [582] = {
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.047,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.047,
        335,
        0,
        270
      }
    },
    [585] = {
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.264,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.264,
        335,
        0,
        270
      }
    },
    [600] = {
      {
        3786,
        0.5,
        -1.1,
        2.2,
        0.184,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        1.1,
        2.2,
        0.184,
        335,
        0,
        270
      }
    },
    [601] = {
      {
        3786,
        0.5,
        1.2,
        3,
        0.859,
        335,
        0,
        270
      },
      {
        3786,
        0.5,
        -1.3,
        3,
        0.859,
        335,
        0,
        270
      }
    }
  },
  [3] = {
    [474] = {
      {
        2976,
        1,
        0,
        2.398,
        -0.129,
        0,
        90,
        90
      }
    },
    [445] = {
      {
        2976,
        1,
        0,
        2.398,
        -0.032,
        0,
        90,
        90
      }
    },
    [401] = {
      {
        2976,
        1,
        0,
        2.398,
        -0.09,
        0,
        90,
        90
      }
    },
    [401] = {
      {
        2976,
        1,
        0,
        2.398,
        -0.09,
        0,
        90,
        90
      }
    },
    [536] = {
      {
        2976,
        1,
        0,
        2.398,
        -0.198,
        0,
        90,
        90
      }
    },
    [527] = {
      {
        2976,
        1,
        0,
        2.398,
        -0.12,
        0,
        90,
        90
      }
    },
    [550] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.2,
        0,
        90,
        90
      }
    },
    [498] = {
      {
        2976,
        1,
        0,
        3,
        -0.3,
        0,
        90,
        90
      }
    },
    [477] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.3,
        0,
        90,
        90
      }
    },
    [504] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.1,
        0,
        90,
        90
      }
    },
    [496] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.1,
        0,
        90,
        90
      }
    },
    [602] = {
      {
        2976,
        1,
        0,
        2.399,
        -0.3,
        0,
        90,
        90
      }
    },
    [442] = {
      {
        2976,
        1,
        0,
        2.8,
        -0.2,
        0,
        90,
        90
      }
    },
    [415] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [439] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.1,
        0,
        90,
        90
      }
    },
    [420] = {
      {
        2976,
        1,
        0,
        2.3,
        -0.1,
        0,
        90,
        90
      }
    },
    [603] = {
      {
        2976,
        1,
        0,
        2.729,
        -0.18,
        0,
        90,
        90
      }
    },
    [495] = {
      {
        2976,
        1,
        0,
        2.329,
        -0.03,
        0,
        90,
        90
      }
    },
    [423] = {
      {
        2976,
        1,
        0,
        2.14,
        -0.02,
        0,
        90,
        90
      }
    },
    [555] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.1,
        0,
        90,
        90
      }
    },
    [596] = {
      {
        2976,
        1,
        0,
        2.199,
        0,
        0,
        90,
        90
      }
    },
    [599] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [490] = {
      {
        2976,
        1,
        0,
        3.1,
        -0.4,
        0,
        90,
        90
      }
    },
    [589] = {
      {
        2976,
        1,
        0,
        2.4,
        -0.1,
        0,
        90,
        90
      }
    },
    [480] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.3,
        0,
        90,
        90
      }
    },
    [588] = {
      {
        2976,
        1,
        0,
        3.399,
        -0.5,
        0,
        90,
        90
      }
    },
    [451] = {
      {
        2976,
        1,
        0,
        2.4,
        -0.3,
        0,
        90,
        90
      }
    },
    [587] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.2,
        0,
        90,
        90
      }
    },
    [416] = {
      {
        2976,
        1,
        0,
        2.899,
        -0.4,
        0,
        90,
        90
      }
    },
    [407] = {
      {
        2976,
        1,
        0,
        4.3,
        -0.7,
        0,
        90,
        90
      }
    },
    [404] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.3,
        0,
        90,
        90
      }
    },
    [402] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.2,
        0,
        90,
        90
      }
    },
    [580] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.1,
        0,
        90,
        90
      }
    },
    [579] = {
      {
        2976,
        1,
        0,
        2.3,
        -0.2,
        0,
        90,
        90
      }
    },
    [482] = {
      {
        2976,
        1,
        0,
        2.3,
        -0.3,
        0,
        90,
        90
      }
    },
    [573] = {
      {
        2976,
        1,
        0,
        3.1,
        -0.7,
        0,
        90,
        90
      }
    },
    [565] = {
      {
        2976,
        1,
        0,
        2.1,
        -0.1,
        0,
        90,
        90
      }
    },
    [562] = {
      {
        2976,
        1,
        0,
        2.3,
        -0.1,
        0,
        90,
        90
      }
    },
    [455] = {
      {
        2976,
        1,
        0,
        4.1,
        -0.5,
        0,
        90,
        90
      }
    },
    [561] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.3,
        0,
        90,
        90
      }
    },
    [560] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.1,
        0,
        90,
        90
      }
    },
    [559] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.2,
        0,
        90,
        90
      }
    },
    [470] = {
      {
        2976,
        1,
        0,
        2,
        -0.2,
        0,
        90,
        90
      }
    },
    [558] = {
      {
        2976,
        1,
        0,
        2.1,
        -0.1,
        0,
        90,
        90
      }
    },
    [444] = {
      {
        2976,
        1,
        0,
        2.8,
        0.3,
        0,
        90,
        90
      }
    },
    [554] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.3,
        0,
        90,
        90
      }
    },
    [545] = {
      {
        2976,
        1,
        0,
        1.699,
        -0.2,
        0,
        90,
        90
      }
    },
    [542] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.1,
        0,
        90,
        90
      }
    },
    [541] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.1,
        0,
        90,
        90
      }
    },
    [533] = {
      {
        2976,
        1,
        0,
        2.399,
        -0.1,
        0,
        90,
        90
      }
    },
    [539] = {
      {
        2976,
        1,
        0,
        1.5,
        0.2,
        0,
        90,
        90
      }
    },
    [535] = {
      {
        2976,
        1,
        0,
        2.399,
        -0.1,
        0,
        90,
        90
      }
    },
    [531] = {
      {
        2976,
        1,
        0,
        1.399,
        -0.3,
        0,
        90,
        90
      }
    },
    [429] = {
      {
        2976,
        1,
        0,
        2.3,
        -0.2,
        0,
        90,
        90
      }
    },
    [528] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [427] = {
      {
        2976,
        1,
        0,
        3.3,
        -0.6,
        0,
        90,
        90
      }
    },
    [428] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.7,
        0,
        90,
        90
      }
    },
    [525] = {
      {
        2976,
        1,
        0,
        3,
        0,
        0,
        90,
        90
      }
    },
    [514] = {
      {
        2976,
        1,
        0,
        4.199,
        -0.8,
        0,
        90,
        90
      }
    },
    [508] = {
      {
        2976,
        1,
        0,
        2.899,
        -0.5,
        0,
        90,
        90
      }
    },
    [506] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.3,
        0,
        90,
        90
      }
    },
    [494] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [483] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.5,
        0,
        90,
        90
      }
    },
    [479] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.2,
        0,
        90,
        90
      }
    },
    [571] = {
      {
        2976,
        0.5,
        0,
        0.1,
        0.3,
        0,
        90,
        90
      }
    },
    [478] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.4,
        0,
        90,
        90
      }
    },
    [431] = {
      {
        2976,
        2,
        0,
        5.699,
        -0.3,
        0,
        90,
        90
      }
    },
    [471] = {
      {
        2976,
        0.5,
        0,
        0.8,
        0.2,
        0,
        90,
        90
      }
    },
    [443] = {
      {
        2976,
        2,
        0,
        5.699,
        -0.7,
        0,
        90,
        90
      }
    },
    [583] = {
      {
        2976,
        1,
        0,
        1.4,
        0.5,
        0,
        90,
        90
      }
    },
    [411] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.1,
        0,
        90,
        90
      }
    },
    [400] = {
      {
        2976,
        1,
        0,
        2.1,
        -0.535,
        0,
        90,
        90
      }
    },
    [403] = {
      {
        2976,
        1,
        0,
        4.5,
        -0.821,
        0,
        90,
        90
      }
    },
    [405] = {
      {
        2976,
        1,
        0,
        2.4,
        -0.291,
        0,
        90,
        90
      }
    },
    [406] = {
      {
        2976,
        3,
        0,
        5.3,
        -1.733,
        0,
        90,
        90
      }
    },
    [408] = {
      {
        2976,
        1,
        0,
        5.199,
        -0.719,
        0,
        90,
        90
      }
    },
    [409] = {
      {
        2976,
        1,
        0,
        3.699,
        -0.281,
        0,
        90,
        90
      }
    },
    [410] = {
      {
        2976,
        1,
        0,
        2.3,
        -0.124,
        0,
        90,
        90
      }
    },
    [412] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.269,
        0,
        90,
        90
      }
    },
    [413] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.405,
        0,
        90,
        90
      }
    },
    [414] = {
      {
        2976,
        1,
        0,
        2.8,
        -0.531,
        0,
        90,
        90
      }
    },
    [418] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.666,
        0,
        90,
        90
      }
    },
    [419] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.4,
        0,
        90,
        90
      }
    },
    [421] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.277,
        0,
        90,
        90
      }
    },
    [422] = {
      {
        2976,
        1,
        0,
        2.3,
        -0.325,
        0,
        90,
        90
      }
    },
    [424] = {
      {
        2976,
        1,
        0,
        1.699,
        -0.164,
        0,
        90,
        90
      }
    },
    [426] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.227,
        0,
        90,
        90
      }
    },
    [433] = {
      {
        2976,
        2,
        0,
        4.1,
        -0.5,
        0,
        90,
        90
      }
    },
    [434] = {
      {
        2976,
        1,
        0,
        1.899,
        -0.534,
        0,
        90,
        90
      }
    },
    [436] = {
      {
        2976,
        1,
        0,
        2.399,
        -0.148,
        0,
        90,
        90
      }
    },
    [437] = {
      {
        2976,
        2,
        0,
        5.6,
        -0.544,
        0,
        90,
        90
      }
    },
    [438] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.374,
        0,
        90,
        90
      }
    },
    [439] = {
      {
        2976,
        1,
        0,
        2.399,
        -0.232,
        0,
        90,
        90
      }
    },
    [440] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.378,
        0,
        90,
        90
      }
    },
    [456] = {
      {
        2976,
        1,
        0,
        3.5,
        -0.342,
        0,
        90,
        90
      }
    },
    [457] = {
      {
        2976,
        1,
        0,
        1.199,
        0.012,
        0,
        90,
        90
      }
    },
    [458] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.253,
        0,
        90,
        90
      }
    },
    [459] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.133,
        0,
        90,
        90
      }
    },
    [466] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.057,
        0,
        90,
        90
      }
    },
    [467] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.013,
        0,
        90,
        90
      }
    },
    [475] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.038,
        0,
        90,
        90
      }
    },
    [489] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.33,
        0,
        90,
        90
      }
    },
    [490] = {
      {
        2976,
        1,
        0,
        3.199,
        -0.343,
        0,
        90,
        90
      }
    },
    [491] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.198,
        0,
        90,
        90
      }
    },
    [492] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.154,
        0,
        90,
        90
      }
    },
    [499] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.17,
        0,
        90,
        90
      }
    },
    [500] = {
      {
        2976,
        1,
        0,
        2.199,
        -0.271,
        0,
        90,
        90
      }
    },
    [502] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.31,
        0,
        90,
        90
      }
    },
    [503] = {
      {
        2976,
        1,
        0,
        2.5,
        -0.084,
        0,
        90,
        90
      }
    },
    [507] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.139,
        0,
        90,
        90
      }
    },
    [515] = {
      {
        2976,
        2,
        0,
        4.6,
        -1.106,
        0,
        90,
        90
      }
    },
    [516] = {
      {
        2976,
        1,
        0,
        3,
        -0.187,
        0,
        90,
        90
      }
    },
    [517] = {
      {
        2976,
        1,
        0,
        2.899,
        -0.027,
        0,
        90,
        90
      }
    },
    [518] = {
      {
        2976,
        1,
        0,
        2.8,
        -0.003,
        0,
        90,
        90
      }
    },
    [524] = {
      {
        2976,
        2,
        0,
        4.1,
        -0.898,
        0,
        90,
        90
      }
    },
    [526] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.209,
        0,
        90,
        90
      }
    },
    [529] = {
      {
        2976,
        1,
        0,
        2.6,
        0.064,
        0,
        90,
        90
      }
    },
    [534] = {
      {
        2976,
        1,
        0,
        3,
        -0.08,
        0,
        90,
        90
      }
    },
    [540] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.203,
        0,
        90,
        90
      }
    },
    [543] = {
      {
        2976,
        1,
        0,
        2.199,
        0.028,
        0,
        90,
        90
      }
    },
    [544] = {
      {
        2976,
        2,
        0,
        3.699,
        -0.492,
        0,
        90,
        90
      }
    },
    [546] = {
      {
        2976,
        1,
        0,
        2.699,
        0.053,
        0,
        90,
        90
      }
    },
    [547] = {
      {
        2976,
        1,
        0,
        2.699,
        0.082,
        0,
        90,
        90
      }
    },
    [549] = {
      {
        2976,
        1,
        0,
        2.5,
        0.036,
        0,
        90,
        90
      }
    },
    [551] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.05,
        0,
        90,
        90
      }
    },
    [552] = {
      {
        2976,
        1,
        0,
        3.199,
        0.15,
        0,
        90,
        90
      }
    },
    [566] = {
      {
        2976,
        1,
        0,
        2.699,
        -0.092,
        0,
        90,
        90
      }
    },
    [567] = {
      {
        2976,
        1,
        0,
        2.899,
        -0.162,
        0,
        90,
        90
      }
    },
    [568] = {
      {
        2976,
        1,
        0,
        2.1,
        -0.191,
        0,
        90,
        90
      }
    },
    [572] = {
      {
        2976,
        1,
        0,
        0.899,
        -0.118,
        0,
        90,
        90
      }
    },
    [574] = {
      {
        2976,
        1,
        0,
        1.6,
        0.116,
        0,
        90,
        90
      }
    },
    [575] = {
      {
        2976,
        1,
        0,
        2.4,
        0.099,
        0,
        90,
        90
      }
    },
    [576] = {
      {
        2976,
        1,
        0,
        2.399,
        0.061,
        0,
        90,
        90
      }
    },
    [578] = {
      {
        2976,
        1,
        0,
        4.399,
        -0.788,
        0,
        90,
        90
      }
    },
    [582] = {
      {
        2976,
        1,
        0,
        2.6,
        -0.253,
        0,
        90,
        90
      }
    },
    [585] = {
      {
        2976,
        1,
        0,
        2.899,
        0.164,
        0,
        90,
        90
      }
    },
    [600] = {
      {
        2976,
        1,
        0,
        2.8,
        -0.016,
        0,
        90,
        90
      }
    },
    [601] = {
      {
        2976,
        1.5,
        0,
        2.8,
        0.259,
        0,
        90,
        90
      }
    }
  },
  [4] = {
    [474] = {
      {
        2985,
        1,
        -0.398,
        1.699,
        -0.629,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.399,
        1.699,
        -0.629,
        0,
        0,
        90
      }
    },
    [445] = {
      {
        2985,
        1,
        -0.399,
        1.699,
        -0.85,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.398,
        1.699,
        -0.85,
        0,
        0,
        90
      }
    },
    [401] = {
      {
        2985,
        1,
        -0.399,
        1.699,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.398,
        1.699,
        -0.8,
        0,
        0,
        90
      }
    },
    [401] = {
      {
        2985,
        1,
        -0.399,
        1.699,
        -0.804,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.398,
        1.699,
        -0.804,
        0,
        0,
        90
      }
    },
    [536] = {
      {
        2985,
        1,
        -0.399,
        1.699,
        -0.886,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.398,
        1.699,
        -0.886,
        0,
        0,
        90
      }
    },
    [527] = {
      {
        2985,
        1,
        -0.399,
        1.699,
        -0.68,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.5,
        -0.68,
        0,
        0,
        90
      }
    },
    [550] = {
      {
        2985,
        1,
        -0.5,
        1.899,
        -0.888,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.899,
        -0.894,
        0,
        0,
        90
      }
    },
    [498] = {
      {
        2985,
        1,
        -0.8,
        2.6,
        -0.3,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.699,
        2.6,
        -0.4,
        0,
        0,
        90
      }
    },
    [477] = {
      {
        2985,
        1,
        -0.6,
        1.8,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.8,
        -0.8,
        0,
        0,
        90
      }
    },
    [504] = {
      {
        2985,
        1,
        -0.5,
        1.899,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.9,
        -0.8,
        0,
        0,
        90
      }
    },
    [496] = {
      {
        2985,
        1,
        -0.5,
        1.5,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.5,
        -0.8,
        0,
        0,
        90
      }
    },
    [602] = {
      {
        2985,
        1,
        -0.5,
        1.6,
        -0.9,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.6,
        -1,
        0,
        0,
        90
      }
    },
    [442] = {
      {
        2985,
        1,
        -0.6,
        1.8,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.8,
        -0.8,
        0,
        0,
        90
      }
    },
    [415] = {
      {
        2985,
        1,
        -0.6,
        1.699,
        -0.9,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.7,
        -0.9,
        0,
        0,
        90
      }
    },
    [439] = {
      {
        2985,
        1,
        -0.6,
        1.5,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.5,
        -0.8,
        0,
        0,
        90
      }
    },
    [420] = {
      {
        2985,
        1,
        -0.6,
        1.6,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.6,
        -0.8,
        0,
        0,
        90
      }
    },
    [603] = {
      {
        2985,
        1,
        -0.6,
        1.699,
        -0.85,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.55,
        1.7,
        -0.85,
        0,
        0,
        90
      }
    },
    [495] = {
      {
        2985,
        1,
        -0.5,
        1.699,
        -0.53,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.45,
        1.7,
        -0.53,
        0,
        0,
        90
      }
    },
    [423] = {
      {
        2985,
        1,
        -0.399,
        2,
        -0.67,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.4,
        2.01,
        -0.67,
        0,
        0,
        90
      }
    },
    [555] = {
      {
        2985,
        1,
        -0.4,
        1.5,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.5,
        -0.8,
        0,
        0,
        90
      }
    },
    [596] = {
      {
        2985,
        0.5,
        -0.32,
        1.55,
        0,
        0,
        0,
        90
      },
      {
        2985,
        0.5,
        0.299,
        1.55,
        0,
        0,
        0,
        90
      }
    },
    [599] = {
      {
        2985,
        1,
        -0.399,
        1.5,
        -0.47,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.37,
        1.5,
        -0.47,
        0,
        0,
        90
      }
    },
    [490] = {
      {
        2985,
        1,
        -0.399,
        2.1,
        -0.5,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.4,
        2.1,
        -0.5,
        0,
        0,
        90
      }
    },
    [589] = {
      {
        2985,
        0.6,
        -0.399,
        1.6,
        -0.05,
        0,
        0,
        90
      },
      {
        2985,
        0.6,
        0.4,
        1.6,
        -0.05,
        0,
        0,
        90
      }
    },
    [480] = {
      {
        2985,
        0.8,
        -0.3,
        1.3,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        0.8,
        0.4,
        1.3,
        -0.6,
        0,
        0,
        90
      }
    },
    [588] = {
      {
        2985,
        1,
        -0.699,
        3,
        0.5,
        270,
        180,
        270
      },
      {
        2985,
        1,
        0.7,
        3,
        0.5,
        90,
        180,
        270
      }
    },
    [451] = {
      {
        2985,
        0.8,
        -0.5,
        1.5,
        -0.63,
        0,
        0,
        90
      },
      {
        2985,
        0.8,
        0.534,
        1.5,
        -0.63,
        0,
        0,
        90
      }
    },
    [587] = {
      {
        2985,
        0.6,
        -0.5,
        1.3,
        -0.2,
        0,
        0,
        90
      },
      {
        2985,
        0.6,
        0.48,
        1.3,
        -0.2,
        0,
        0,
        90
      }
    },
    [416] = {
      {
        2985,
        1,
        -0.4,
        2.4,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.4,
        2.4,
        -0.6,
        0,
        0,
        90
      }
    },
    [407] = {
      {
        2985,
        1,
        -0.5,
        3.8,
        0.1,
        270,
        180,
        270
      },
      {
        2985,
        1,
        0.5,
        3.8,
        0.1,
        90,
        180,
        270
      }
    },
    [404] = {
      {
        2985,
        0.8,
        -0.34,
        1.5,
        -0.3,
        0,
        0,
        90
      },
      {
        2985,
        0.8,
        0.335,
        1.5,
        -0.3,
        0,
        0,
        90
      }
    },
    [402] = {
      {
        2985,
        0.8,
        -0.64,
        1.9,
        -0.56,
        0,
        0,
        90
      },
      {
        2985,
        0.8,
        0.68,
        1.9,
        -0.56,
        0,
        0,
        90
      }
    },
    [580] = {
      {
        2985,
        0.8,
        -0.4,
        1.8,
        -0.3,
        0,
        0,
        90
      },
      {
        2985,
        0.8,
        0.4,
        1.8,
        -0.3,
        0,
        0,
        90
      }
    },
    [579] = {
      {
        2985,
        0.8,
        -0.4,
        1.5,
        -0.2,
        0,
        0,
        90
      },
      {
        2985,
        0.8,
        0.4,
        1.5,
        -0.2,
        0,
        0,
        90
      }
    },
    [482] = {
      {
        2985,
        0.8,
        -0.659,
        2.1,
        -0.55,
        0,
        0,
        90
      },
      {
        2985,
        0.8,
        0.699,
        2.1,
        -0.55,
        0,
        0,
        90
      }
    },
    [573] = {
      {
        2985,
        2,
        -0.9,
        2.7,
        -0.5,
        90,
        0,
        90
      },
      {
        2985,
        2,
        0.8,
        2.699,
        -0.5,
        270,
        0,
        90
      }
    },
    [565] = {
      {
        2985,
        1,
        -0.7,
        1.7,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.699,
        1.699,
        -0.6,
        0,
        0,
        90
      }
    },
    [562] = {
      {
        2985,
        1,
        -0.7,
        2,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.699,
        2,
        -0.6,
        0,
        0,
        90
      }
    },
    [455] = {
      {
        2985,
        1,
        -1.3,
        3,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        1.3,
        3,
        -0.6,
        0,
        0,
        90
      }
    },
    [561] = {
      {
        2985,
        1,
        -0.7,
        2.2,
        -0.7,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.699,
        2.199,
        -0.7,
        0,
        0,
        90
      }
    },
    [560] = {
      {
        2985,
        1,
        -0.7,
        1.6,
        -0.5,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.8,
        1.6,
        -0.5,
        0,
        0,
        90
      }
    },
    [559] = {
      {
        2985,
        1,
        -0.699,
        1.6,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.8,
        1.6,
        -0.6,
        0,
        0,
        90
      }
    },
    [470] = {
      {
        2985,
        1,
        -0.899,
        1.6,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.899,
        1.6,
        -0.4,
        0,
        0,
        90
      }
    },
    [558] = {
      {
        2985,
        1,
        -0.5,
        1.3,
        -0.55,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.449,
        1.3,
        -0.55,
        0,
        0,
        90
      }
    },
    [444] = {
      {
        2985,
        1,
        -0.5,
        2.2,
        0.2,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2.199,
        0.2,
        0,
        0,
        90
      }
    },
    [554] = {
      {
        2985,
        1,
        -0.6,
        2.2,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2.199,
        -0.4,
        0,
        0,
        90
      }
    },
    [545] = {
      {
        2985,
        1,
        -0.4,
        0.9,
        -0.5,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.399,
        0.899,
        -0.5,
        0,
        0,
        90
      }
    },
    [542] = {
      {
        2985,
        1,
        -0.6,
        2,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2,
        -0.6,
        0,
        0,
        90
      }
    },
    [541] = {
      {
        2985,
        1,
        -0.5,
        2,
        -0.7,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        2,
        -0.7,
        0,
        0,
        90
      }
    },
    [533] = {
      {
        2985,
        1,
        -0.5,
        2,
        -0.59,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        2,
        -0.59,
        0,
        0,
        90
      }
    },
    [539] = {
      {
        2985,
        1,
        -0.5,
        1.2,
        -0.5,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.199,
        -0.5,
        0,
        0,
        90
      }
    },
    [535] = {
      {
        2985,
        1,
        -0.6,
        1.9,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.699,
        1.899,
        -0.4,
        0,
        0,
        90
      }
    },
    [531] = {
      {
        2985,
        1,
        -0.3,
        1.2,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.3,
        1.199,
        -0.4,
        0,
        0,
        90
      }
    },
    [429] = {
      {
        2985,
        1,
        -0.6,
        1.6,
        -0.5,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.6,
        -0.5,
        0,
        0,
        90
      }
    },
    [528] = {
      {
        2985,
        1,
        -0.5,
        2,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2,
        -0.4,
        0,
        0,
        90
      }
    },
    [427] = {
      {
        2985,
        1,
        -0.6,
        2.9,
        -0.2,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2.899,
        -0.2,
        0,
        0,
        90
      }
    },
    [428] = {
      {
        2985,
        1,
        -0.9,
        2.3,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.899,
        2.3,
        -0.6,
        0,
        0,
        90
      }
    },
    [525] = {
      {
        2985,
        1,
        -0.8,
        2.4,
        0,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.8,
        2.399,
        0,
        0,
        0,
        90
      }
    },
    [514] = {
      {
        2985,
        1,
        -0.5,
        4,
        -0.5,
        315,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        4,
        -0.5,
        45,
        0,
        90
      }
    },
    [508] = {
      {
        2985,
        1,
        -0.6,
        2.7,
        -0.5,
        315,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2.7,
        -0.5,
        45,
        0,
        90
      }
    },
    [506] = {
      {
        2985,
        1,
        -0.6,
        1.4,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.4,
        -0.6,
        0,
        0,
        90
      }
    },
    [494] = {
      {
        2985,
        1,
        -0.6,
        1.8,
        -0.6,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.8,
        -0.6,
        0,
        0,
        90
      }
    },
    [483] = {
      {
        2985,
        1,
        -0.1,
        1.4,
        -0.4,
        270,
        180,
        270
      },
      {
        2985,
        1,
        0.1,
        1.399,
        -0.4,
        90,
        180,
        270
      }
    },
    [479] = {
      {
        2985,
        1,
        -0.6,
        2.2,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2.199,
        -0.4,
        0,
        0,
        90
      }
    },
    [571] = {
      {
        2985,
        0.5,
        -0.199,
        0.699,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        0.5,
        0.2,
        0.7,
        -0.4,
        0,
        0,
        90
      }
    },
    [478] = {
      {
        2985,
        1,
        -0.5,
        1.4,
        -0.4,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        1.399,
        -0.4,
        0,
        0,
        90
      }
    },
    [431] = {
      {
        2985,
        2,
        -0.699,
        5.3,
        -0.2,
        90,
        180,
        270
      },
      {
        2985,
        2,
        0.7,
        5.3,
        -0.2,
        270,
        180,
        270
      }
    },
    [471] = {
      {
        2985,
        0.5,
        -0.3,
        0.6,
        0,
        0,
        0,
        90
      },
      {
        2985,
        0.5,
        0.3,
        0.6,
        0,
        0,
        0,
        90
      }
    },
    [443] = {
      {
        2985,
        1,
        -0.5,
        5.3,
        -0.7,
        305,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        5.3,
        -0.7,
        55,
        0,
        90
      }
    },
    [583] = {
      {
        2985,
        0.6,
        -0.3,
        1.2,
        0.4,
        0,
        0,
        90
      },
      {
        2985,
        0.6,
        0.399,
        1.199,
        0.4,
        0,
        0,
        90
      }
    },
    [411] = {
      {
        2985,
        1,
        -0.5,
        1.6,
        -0.8,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        1.6,
        -0.8,
        0,
        0,
        90
      }
    },
    [400] = {
      {
        2985,
        1,
        -0.6,
        1.4,
        -0.835,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.7,
        1.4,
        -0.835,
        0,
        0,
        90
      }
    },
    [403] = {
      {
        2985,
        1,
        -1.2,
        3.5,
        -1.021,
        0,
        0,
        90
      },
      {
        2985,
        1,
        1.199,
        3.5,
        -1.021,
        0,
        0,
        90
      }
    },
    [405] = {
      {
        2985,
        1,
        -0.699,
        2.1,
        -0.891,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.7,
        2.1,
        -0.891,
        0,
        0,
        90
      }
    },
    [406] = {
      {
        2985,
        3,
        -1.9,
        5.4,
        -4.533,
        0,
        0,
        90
      },
      {
        2985,
        3,
        1.7,
        5.4,
        -4.533,
        0,
        0,
        90
      }
    },
    [408] = {
      {
        2985,
        1,
        -1,
        4.7,
        -1.219,
        0,
        0,
        90
      },
      {
        2985,
        1,
        1,
        4.7,
        -1.219,
        0,
        0,
        90
      }
    },
    [409] = {
      {
        2985,
        1,
        -0.6,
        3.1,
        -0.781,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.5,
        3.1,
        -0.781,
        0,
        0,
        90
      }
    },
    [410] = {
      {
        2985,
        1,
        -0.7,
        1.7,
        -0.624,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.7,
        1.7,
        -0.624,
        0,
        0,
        90
      }
    },
    [412] = {
      {
        2985,
        1,
        -0.8,
        2.4,
        -0.869,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.8,
        2.399,
        -0.869,
        0,
        0,
        90
      }
    },
    [413] = {
      {
        2985,
        1,
        -0.779,
        2.399,
        -0.862,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.8,
        2.399,
        -0.862,
        0,
        0,
        90
      }
    },
    [414] = {
      {
        2985,
        1,
        -0.779,
        2.587,
        -0.66,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.719,
        2.586,
        -0.66,
        0,
        0,
        90
      }
    },
    [418] = {
      {
        2985,
        1,
        -0.758,
        2.302,
        -1.003,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.718,
        2.302,
        -1.003,
        0,
        0,
        90
      }
    },
    [419] = {
      {
        2985,
        1,
        -0.588,
        2.302,
        -0.947,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.581,
        2.302,
        -0.947,
        0,
        0,
        90
      }
    },
    [421] = {
      {
        2985,
        1,
        -0.643,
        2.302,
        -1.044,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.561,
        2.302,
        -1.044,
        0,
        0,
        90
      }
    },
    [422] = {
      {
        2985,
        1,
        -0.643,
        1.798,
        -0.761,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.679,
        1.798,
        -0.761,
        0,
        0,
        90
      }
    },
    [424] = {
      {
        2985,
        1,
        -0.447,
        1.048,
        -0.721,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.412,
        1.048,
        -0.721,
        0,
        0,
        90
      }
    },
    [426] = {
      {
        2985,
        1,
        -0.73,
        1.798,
        -0.772,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.747,
        1.798,
        -0.772,
        0,
        0,
        90
      }
    },
    [433] = {
      {
        2985,
        2,
        -1,
        4,
        -1.9,
        0,
        0,
        90
      },
      {
        2985,
        2,
        1,
        4,
        -1.9,
        0,
        0,
        90
      }
    },
    [434] = {
      {
        2985,
        1,
        -0.247,
        1.611,
        -0.908,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.332,
        1.611,
        -0.908,
        0,
        0,
        90
      }
    },
    [436] = {
      {
        2985,
        1,
        -0.688,
        1.818,
        -0.749,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.659,
        1.817,
        -0.749,
        0,
        0,
        90
      }
    },
    [437] = {
      {
        2985,
        1,
        -0.729,
        5.664,
        -0.826,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.658,
        5.664,
        -0.826,
        0,
        0,
        90
      }
    },
    [438] = {
      {
        2985,
        1,
        -0.597,
        2.098,
        -0.719,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.649,
        2.098,
        -0.719,
        0,
        0,
        90
      }
    },
    [439] = {
      {
        2985,
        1,
        -0.729,
        1.598,
        -0.849,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.699,
        1.598,
        -0.849,
        0,
        0,
        90
      }
    },
    [440] = {
      {
        2985,
        1,
        -0.729,
        2.351,
        -0.882,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.706,
        2.351,
        -0.882,
        0,
        0,
        90
      }
    },
    [456] = {
      {
        2985,
        2,
        -0.9,
        2.7,
        -2.042,
        0,
        0,
        90
      },
      {
        2985,
        2,
        1.1,
        2.7,
        -2.042,
        0,
        0,
        90
      }
    },
    [457] = {
      {
        2985,
        0.6,
        -0.486,
        0.99,
        -0.253,
        0,
        0,
        90
      },
      {
        2985,
        0.6,
        0.482,
        0.99,
        -0.253,
        0,
        0,
        90
      }
    },
    [458] = {
      {
        2985,
        1.2,
        -0.728,
        1.74,
        -0.944,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.705,
        1.74,
        -0.944,
        0,
        0,
        90
      }
    },
    [459] = {
      {
        2985,
        1.2,
        -0.728,
        2.25,
        -0.869,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.689,
        2.249,
        -0.869,
        0,
        0,
        90
      }
    },
    [466] = {
      {
        2985,
        1.2,
        -0.663,
        1.626,
        -0.884,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.689,
        1.626,
        -0.884,
        0,
        0,
        90
      }
    },
    [467] = {
      {
        2985,
        1.2,
        -0.663,
        1.626,
        -0.867,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.772,
        1.626,
        -0.867,
        0,
        0,
        90
      }
    },
    [475] = {
      {
        2985,
        1.2,
        -0.779,
        1.626,
        -0.947,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.771,
        1.626,
        -0.947,
        0,
        0,
        90
      }
    },
    [489] = {
      {
        2985,
        1.2,
        -0.779,
        1.626,
        -0.793,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.828,
        1.626,
        -0.793,
        0,
        0,
        90
      }
    },
    [490] = {
      {
        2985,
        1.2,
        -0.89,
        2.832,
        -0.869,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.828,
        2.833,
        -0.869,
        0,
        0,
        90
      }
    },
    [491] = {
      {
        2985,
        1.2,
        -0.69,
        2.066,
        -0.978,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.642,
        2.065,
        -0.978,
        0,
        0,
        90
      }
    },
    [492] = {
      {
        2985,
        1.2,
        -0.664,
        2.065,
        -0.932,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.644,
        2.065,
        -0.932,
        0,
        0,
        90
      }
    },
    [499] = {
      {
        2985,
        1.2,
        -0.664,
        2.182,
        -0.937,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.694,
        2.182,
        -0.937,
        0,
        0,
        90
      }
    },
    [500] = {
      {
        2985,
        1.2,
        -0.561,
        1.182,
        -1.102,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.563,
        1.182,
        -1.102,
        0,
        0,
        90
      }
    },
    [502] = {
      {
        2985,
        1.2,
        -0.6,
        2,
        -0.91,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        2,
        -0.91,
        0,
        0,
        90
      }
    },
    [503] = {
      {
        2985,
        1.2,
        -0.6,
        1.6,
        -0.884,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.6,
        -0.884,
        0,
        0,
        90
      }
    },
    [507] = {
      {
        2985,
        1.2,
        -0.6,
        1.9,
        -0.939,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.9,
        -0.939,
        0,
        0,
        90
      }
    },
    [515] = {
      {
        2985,
        1.2,
        -1.5,
        3.7,
        -1.406,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        1.5,
        3.7,
        -1.406,
        0,
        0,
        90
      }
    },
    [516] = {
      {
        2985,
        1.2,
        -0.6,
        2.1,
        -0.887,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        2.1,
        -0.887,
        0,
        0,
        90
      }
    },
    [517] = {
      {
        2985,
        1.2,
        -0.6,
        2.1,
        -0.927,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        2.1,
        -0.927,
        0,
        0,
        90
      }
    },
    [518] = {
      {
        2985,
        1.2,
        -0.6,
        2.1,
        -0.903,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        2.1,
        -0.903,
        0,
        0,
        90
      }
    },
    [524] = {
      {
        2985,
        1.2,
        -1.2,
        3.3,
        -1.498,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        1.2,
        3.3,
        -1.498,
        0,
        0,
        90
      }
    },
    [526] = {
      {
        2985,
        1.2,
        -0.6,
        1.9,
        -1.009,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.9,
        -1.009,
        0,
        0,
        90
      }
    },
    [529] = {
      {
        2985,
        1.2,
        -0.6,
        1.9,
        -0.836,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.9,
        -0.836,
        0,
        0,
        90
      }
    },
    [534] = {
      {
        2985,
        1.2,
        -0.6,
        2.4,
        -0.98,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        2.4,
        -0.98,
        0,
        0,
        90
      }
    },
    [540] = {
      {
        2985,
        1.2,
        -0.6,
        1.544,
        -1.038,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.685,
        1.543,
        -1.038,
        0,
        0,
        90
      }
    },
    [543] = {
      {
        2985,
        1.2,
        -0.552,
        1.543,
        -0.862,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.656,
        1.543,
        -0.862,
        0,
        0,
        90
      }
    },
    [544] = {
      {
        2985,
        1.2,
        -0.759,
        3.572,
        -1.104,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.8,
        3.571,
        -1.104,
        0,
        0,
        90
      }
    },
    [546] = {
      {
        2985,
        1.2,
        -0.6,
        1.8,
        -0.847,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.8,
        -0.847,
        0,
        0,
        90
      }
    },
    [547] = {
      {
        2985,
        1.2,
        -0.6,
        1.8,
        -0.868,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.8,
        -0.868,
        0,
        0,
        90
      }
    },
    [549] = {
      {
        2985,
        1.2,
        -0.6,
        1.8,
        -0.864,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.8,
        -0.864,
        0,
        0,
        90
      }
    },
    [551] = {
      {
        2985,
        1.2,
        -0.6,
        1.8,
        -0.9,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.6,
        1.8,
        -0.9,
        0,
        0,
        90
      }
    },
    [552] = {
      {
        2985,
        1.2,
        -0.807,
        2.454,
        -0.45,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.812,
        2.455,
        -0.45,
        0,
        0,
        90
      }
    },
    [566] = {
      {
        2985,
        1.2,
        -0.807,
        2.278,
        -0.903,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.767,
        2.277,
        -0.903,
        0,
        0,
        90
      }
    },
    [567] = {
      {
        2985,
        1.2,
        -0.752,
        2.277,
        -1.056,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.767,
        2.277,
        -1.056,
        0,
        0,
        90
      }
    },
    [568] = {
      {
        2985,
        0.7,
        -0.253,
        1.964,
        -0.565,
        0,
        0,
        90
      },
      {
        2985,
        0.7,
        0.265,
        1.964,
        -0.565,
        0,
        0,
        90
      }
    },
    [572] = {
      {
        2985,
        0.7,
        -0.161,
        0.712,
        -0.242,
        0,
        0,
        90
      },
      {
        2985,
        0.7,
        0.212,
        0.711,
        -0.242,
        0,
        0,
        90
      }
    },
    [574] = {
      {
        2985,
        0.88,
        -0.467,
        1.461,
        -0.557,
        0,
        0,
        90
      },
      {
        2985,
        0.88,
        0.42,
        1.461,
        -0.557,
        0,
        0,
        90
      }
    },
    [575] = {
      {
        2985,
        1.2,
        -0.565,
        1.579,
        -0.74,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.563,
        1.579,
        -0.74,
        0,
        0,
        90
      }
    },
    [576] = {
      {
        2985,
        1.2,
        -0.528,
        1.58,
        -0.778,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.564,
        1.579,
        -0.778,
        0,
        0,
        90
      }
    },
    [578] = {
      {
        2985,
        1.2,
        -0.772,
        4.492,
        -1.613,
        0,
        0,
        90
      },
      {
        2985,
        1.2,
        0.765,
        4.492,
        -1.613,
        0,
        0,
        90
      }
    },
    [582] = {
      {
        2985,
        1,
        -0.8,
        2.3,
        -0.853,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.8,
        2.3,
        -0.853,
        0,
        0,
        90
      }
    },
    [585] = {
      {
        2985,
        1,
        -0.6,
        2.4,
        -0.536,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.6,
        2.4,
        -0.536,
        0,
        0,
        90
      }
    },
    [600] = {
      {
        2985,
        1,
        -0.357,
        2.433,
        -0.573,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.408,
        2.433,
        -0.573,
        0,
        0,
        90
      }
    },
    [601] = {
      {
        2985,
        1,
        -0.424,
        2.667,
        0.002,
        0,
        0,
        90
      },
      {
        2985,
        1,
        0.465,
        2.668,
        0.002,
        0,
        0,
        90
      }
    }
  },
  [5] = {
    [474] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.591,
        0,
        0,
        0
      }
    },
    [445] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.58,
        0,
        0,
        0
      }
    },
    [401] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.54,
        0,
        0,
        0
      }
    },
    [401] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.55,
        0,
        0,
        0
      }
    },
    [536] = {
      {
        3884,
        0.4,
        0,
        -1.8,
        -0.1,
        0,
        0,
        0
      }
    },
    [527] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.63,
        0,
        0,
        0
      }
    },
    [550] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.47,
        0,
        0,
        0
      }
    },
    [498] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        1.9,
        0,
        0,
        0
      }
    },
    [477] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.5,
        0,
        0,
        0
      }
    },
    [504] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.67,
        0,
        0,
        0
      }
    },
    [496] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.6,
        0,
        0,
        0
      }
    },
    [602] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.45,
        0,
        0,
        0
      }
    },
    [442] = {
      {
        3884,
        0.4,
        0,
        -0.8,
        0.67,
        0,
        0,
        0
      }
    },
    [415] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.38,
        0,
        0,
        0
      }
    },
    [439] = {
      {
        3884,
        0.4,
        0,
        -1.8,
        0,
        0,
        0,
        0
      }
    },
    [420] = {
      {
        3884,
        0.4,
        0,
        -1,
        0.6,
        0,
        0,
        0
      }
    },
    [603] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.43,
        0,
        0,
        0
      }
    },
    [495] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.8,
        0,
        0,
        0
      }
    },
    [423] = {
      {
        3884,
        0.4,
        0,
        -1.7,
        1.5,
        0,
        0,
        0
      }
    },
    [555] = {
      {
        3884,
        0.4,
        0,
        -1.5,
        -0.1,
        0,
        0,
        0
      }
    },
    [596] = {
      {
        3884,
        0.4,
        0,
        -1,
        0.6,
        0,
        0,
        0
      }
    },
    [599] = {
      {
        3884,
        0.4,
        0,
        -1.6,
        0.85,
        0,
        0,
        0
      }
    },
    [490] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.86,
        0,
        0,
        0
      }
    },
    [589] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.84,
        0,
        0,
        0
      }
    },
    [480] = {
      {
        3884,
        0.4,
        0,
        -1.5,
        0,
        0,
        0,
        0
      }
    },
    [588] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        3,
        0,
        0,
        0
      }
    },
    [451] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.35,
        0,
        0,
        0
      }
    },
    [587] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.5,
        0,
        0,
        0
      }
    },
    [416] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        1.5,
        0,
        0,
        0
      }
    },
    [407] = {
      {
        3884,
        0.4,
        0,
        0.3,
        0.8,
        0,
        0,
        0
      }
    },
    [404] = {
      {
        3884,
        0.4,
        0,
        -0.9,
        0.7,
        0,
        0,
        0
      }
    },
    [402] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.5,
        0,
        0,
        0
      }
    },
    [580] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.8,
        0,
        0,
        0
      }
    },
    [579] = {
      {
        3884,
        0.4,
        0,
        -1,
        1,
        0,
        0,
        0
      }
    },
    [482] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.7,
        0,
        0,
        0
      }
    },
    [573] = {
      {
        3884,
        0.4,
        0,
        -1.2,
        1.1,
        0,
        0,
        0
      }
    },
    [565] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.45,
        0,
        0,
        0
      }
    },
    [562] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.54,
        0,
        0,
        0
      }
    },
    [455] = {
      {
        3884,
        0.4,
        0,
        1.2,
        1.42,
        0,
        0,
        0
      }
    },
    [561] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.6,
        0,
        0,
        0
      }
    },
    [560] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.6,
        0,
        0,
        0
      }
    },
    [559] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.5,
        0,
        0,
        0
      }
    },
    [470] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.83,
        0,
        0,
        0
      }
    },
    [558] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.62,
        0,
        0,
        0
      }
    },
    [444] = {
      {
        3884,
        0.4,
        0,
        0.2,
        1.44,
        0,
        0,
        0
      }
    },
    [554] = {
      {
        3884,
        0.4,
        0,
        0,
        0.8,
        0,
        0,
        0
      }
    },
    [545] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.53,
        0,
        0,
        0
      }
    },
    [542] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.6,
        0,
        0,
        0
      }
    },
    [541] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.38,
        0,
        0,
        0
      }
    },
    [533] = {
      {
        3884,
        0.4,
        0,
        -1.9,
        0,
        0,
        0,
        0
      }
    },
    [539] = {
      {
        3884,
        0.4,
        0,
        1.1,
        0.1,
        0,
        0,
        0
      }
    },
    [535] = {
      {
        3884,
        0.4,
        0,
        -1.5,
        0.19,
        0,
        0,
        0
      }
    },
    [531] = {
      {
        3884,
        0.4,
        0,
        0.8,
        0.1,
        0,
        0,
        0
      }
    },
    [429] = {
      {
        3884,
        0.4,
        0,
        -1.5,
        0,
        0,
        0,
        0
      }
    },
    [528] = {
      {
        3884,
        0.4,
        0,
        -1,
        0.82,
        0,
        0,
        0
      }
    },
    [427] = {
      {
        3884,
        0.4,
        0,
        -0.9,
        1.46,
        0,
        0,
        0
      }
    },
    [428] = {
      {
        3884,
        0.4,
        0,
        -0.9,
        1.33,
        0,
        0,
        0
      }
    },
    [525] = {
      {
        3884,
        0.4,
        0,
        0.2,
        1.13,
        0,
        0,
        0
      }
    },
    [514] = {
      {
        3884,
        0.4,
        0,
        -0.2,
        1.3,
        0,
        0,
        0
      }
    },
    [508] = {
      {
        3884,
        0.4,
        0,
        -2.1,
        1.63,
        0,
        0,
        0
      }
    },
    [506] = {
      {
        3884,
        0.4,
        0,
        -2.1,
        -0.1,
        0,
        0,
        0
      }
    },
    [494] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.5,
        0,
        0,
        0
      }
    },
    [483] = {
      {
        3884,
        0.4,
        0,
        -0.8,
        0.8,
        0,
        0,
        0
      }
    },
    [479] = {
      {
        3884,
        0.4,
        0,
        -1,
        0.74,
        0,
        0,
        0
      }
    },
    [571] = {
      {
        3884,
        0.2,
        0,
        0.7,
        -0.3,
        0,
        0,
        0
      }
    },
    [478] = {
      {
        3884,
        0.4,
        0,
        0.2,
        0.65,
        0,
        0,
        0
      }
    },
    [431] = {
      {
        3884,
        1,
        0,
        0,
        1.7,
        0,
        0,
        0
      }
    },
    [471] = {
      {
        3884,
        0.2,
        0,
        0.6,
        0.2,
        0,
        0,
        0
      }
    },
    [443] = {
      {
        3884,
        0.4,
        0,
        1.5,
        1.4,
        0,
        0,
        0
      }
    },
    [583] = {
      {
        3884,
        0.4,
        0,
        -0.8,
        1.31,
        0,
        0,
        0
      }
    },
    [411] = {
      {
        3884,
        0.4,
        0,
        -0.199,
        0.46,
        0,
        0,
        0
      }
    },
    [400] = {
      {
        3884,
        0.4,
        0,
        0,
        0.565,
        0,
        0,
        0
      }
    },
    [403] = {
      {
        3884,
        0.4,
        0,
        -0.8,
        1.879,
        0,
        0,
        0
      }
    },
    [405] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.509,
        0,
        0,
        0
      }
    },
    [406] = {
      {
        3884,
        1,
        0,
        3.2,
        1.567,
        0,
        0,
        0
      }
    },
    [408] = {
      {
        3884,
        0.5,
        0,
        1.6,
        1.681,
        0,
        0,
        0
      }
    },
    [409] = {
      {
        3884,
        0.4,
        0,
        -1.9,
        0.619,
        0,
        0,
        0
      }
    },
    [410] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.676,
        0,
        0,
        0
      }
    },
    [412] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.431,
        0,
        0,
        0
      }
    },
    [413] = {
      {
        3884,
        0.4,
        0,
        -1.1,
        0.895,
        0,
        0,
        0
      }
    },
    [414] = {
      {
        3884,
        0.4,
        0,
        -1.1,
        2.069,
        0,
        0,
        0
      }
    },
    [418] = {
      {
        3884,
        0.4,
        0,
        -1.1,
        0.734,
        0,
        0,
        0
      }
    },
    [419] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.4,
        0,
        0,
        0
      }
    },
    [421] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.423,
        0,
        0,
        0
      }
    },
    [422] = {
      {
        3884,
        0.4,
        0,
        0,
        0.575,
        0,
        0,
        0
      }
    },
    [424] = {
      {
        3884,
        0.4,
        0,
        -1.2,
        0.136,
        0,
        0,
        0
      }
    },
    [426] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.573,
        0,
        0,
        0
      }
    },
    [433] = {
      {
        3884,
        0.66,
        0,
        1.2,
        1.2,
        0,
        0,
        0
      }
    },
    [434] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.466,
        0,
        0,
        0
      }
    },
    [436] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.552,
        0,
        0,
        0
      }
    },
    [437] = {
      {
        3884,
        1,
        0,
        -3.6,
        1.456,
        0,
        0,
        0
      }
    },
    [438] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.526,
        0,
        0,
        0
      }
    },
    [439] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.468,
        0,
        0,
        0
      }
    },
    [440] = {
      {
        3884,
        0.4,
        0,
        -1.6,
        0.922,
        0,
        0,
        0
      }
    },
    [456] = {
      {
        3884,
        0.8,
        0,
        -2.8,
        1.858,
        0,
        0,
        0
      }
    },
    [457] = {
      {
        3884,
        0.42,
        0,
        -0.1,
        1.112,
        0,
        0,
        0
      }
    },
    [458] = {
      {
        3884,
        0.42,
        0,
        -0.6,
        0.447,
        0,
        0,
        0
      }
    },
    [459] = {
      {
        3884,
        0.42,
        0,
        -0.899,
        0.867,
        0,
        0,
        0
      }
    },
    [466] = {
      {
        3884,
        0.42,
        0,
        -0.5,
        0.643,
        0,
        0,
        2
      }
    },
    [467] = {
      {
        3884,
        0.42,
        0,
        -0.7,
        0.587,
        0,
        0,
        0
      }
    },
    [475] = {
      {
        3884,
        0.42,
        0,
        -0.6,
        0.462,
        0,
        0,
        0
      }
    },
    [489] = {
      {
        3884,
        0.42,
        0,
        -1.7,
        0.77,
        0,
        0,
        0
      }
    },
    [490] = {
      {
        3884,
        0.42,
        0,
        -2,
        0.757,
        0,
        0,
        0
      }
    },
    [491] = {
      {
        3884,
        0.42,
        0,
        -0.8,
        0.402,
        0,
        0,
        0
      }
    },
    [492] = {
      {
        3884,
        0.42,
        0,
        -0.8,
        0.546,
        0,
        0,
        0
      }
    },
    [499] = {
      {
        3884,
        0.61,
        0,
        -1.9,
        1.53,
        0,
        0,
        0
      }
    },
    [500] = {
      {
        3884,
        0.4,
        0,
        -0.9,
        0.729,
        0,
        0,
        0
      }
    },
    [502] = {
      {
        3884,
        0.4,
        0,
        -0.6,
        0.49,
        0,
        0,
        0
      }
    },
    [503] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.516,
        0,
        0,
        0
      }
    },
    [507] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.561,
        0,
        0,
        0
      }
    },
    [515] = {
      {
        3884,
        0.6,
        0,
        1.5,
        0.894,
        0,
        0,
        0
      }
    },
    [516] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.613,
        0,
        0,
        0
      }
    },
    [517] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.573,
        0,
        0,
        0
      }
    },
    [518] = {
      {
        3884,
        0.4,
        0,
        -0.3,
        0.397,
        0,
        0,
        0
      }
    },
    [524] = {
      {
        3884,
        0.6,
        0,
        1.5,
        0.502,
        0,
        0,
        0
      }
    },
    [526] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.391,
        0,
        0,
        0
      }
    },
    [529] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.664,
        0,
        0,
        0
      }
    },
    [534] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.32,
        0,
        0,
        0
      }
    },
    [540] = {
      {
        3884,
        0.4,
        0,
        -0.7,
        0.397,
        0,
        0,
        0
      }
    },
    [543] = {
      {
        3884,
        0.4,
        0,
        0,
        0.628,
        0,
        0,
        0
      }
    },
    [544] = {
      {
        3884,
        0.6,
        0,
        2.5,
        1.108,
        0,
        0,
        0
      }
    },
    [546] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.553,
        0,
        0,
        0
      }
    },
    [547] = {
      {
        3884,
        0.4,
        0,
        -0.5,
        0.582,
        0,
        0,
        0
      }
    },
    [549] = {
      {
        3884,
        0.4,
        0,
        0,
        0.436,
        0,
        0,
        0
      }
    },
    [551] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.65,
        0,
        0,
        0
      }
    },
    [552] = {
      {
        3884,
        0.4,
        0,
        1.4,
        1.45,
        0,
        0,
        0
      }
    },
    [566] = {
      {
        3884,
        0.4,
        0,
        -0.1,
        0.608,
        0,
        0,
        0
      }
    },
    [567] = {
      {
        3884,
        0.4,
        0,
        -1.8,
        -0.062,
        0,
        0,
        0
      }
    },
    [568] = {
      {
        3884,
        0.4,
        0,
        -0.2,
        0.509,
        0,
        0,
        0
      }
    },
    [572] = {
      {
        3884,
        0.3,
        0,
        0.4,
        0.182,
        0,
        0,
        0
      }
    },
    [574] = {
      {
        3884,
        0.3,
        0,
        -0.6,
        1.016,
        0,
        0,
        0
      }
    },
    [575] = {
      {
        3884,
        0.4,
        0,
        -1.7,
        0.299,
        0,
        0,
        0
      }
    },
    [576] = {
      {
        3884,
        0.4,
        0,
        -2.1,
        0.161,
        0,
        0,
        0
      }
    },
    [578] = {
      {
        3884,
        1.5,
        0,
        -2.1,
        -1.088,
        0,
        0,
        0
      }
    },
    [582] = {
      {
        3884,
        0.66,
        0,
        0.7,
        0.747,
        0,
        0,
        0
      }
    },
    [585] = {
      {
        3884,
        0.4,
        0,
        -0.4,
        0.764,
        0,
        0,
        0
      }
    },
    [600] = {
      {
        3884,
        0.4,
        0,
        -0.1,
        0.484,
        0,
        0,
        0
      }
    },
    [601] = {
      {
        3884,
        0.5,
        0,
        -1.3,
        1.159,
        0,
        0,
        0
      }
    }
  },
  [6] = {
    [474] = {
      {
        2985,
        1,
        0,
        1.699,
        -0.429,
        0,
        0,
        90
      }
    },
    [445] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.7,
        0,
        0,
        90
      }
    },
    [401] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.7,
        0,
        0,
        90
      }
    },
    [401] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.7,
        0,
        0,
        90
      }
    },
    [536] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.8,
        0,
        0,
        90
      }
    },
    [527] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.6,
        0,
        0,
        90
      }
    },
    [550] = {
      {
        2985,
        1,
        0,
        1.899,
        -0.848,
        0,
        0,
        90
      }
    },
    [498] = {
      {
        2985,
        1,
        0,
        2.7,
        -0.4,
        0,
        0,
        90
      }
    },
    [477] = {
      {
        2985,
        1,
        0,
        1.8,
        -0.7,
        0,
        0,
        90
      }
    },
    [504] = {
      {
        2985,
        1,
        0,
        1.9,
        -0.7,
        0,
        0,
        90
      }
    },
    [496] = {
      {
        2985,
        1,
        0,
        1.6,
        -0.7,
        0,
        0,
        90
      }
    },
    [602] = {
      {
        2985,
        1,
        0,
        1.6,
        -0.8,
        0,
        0,
        90
      }
    },
    [442] = {
      {
        2985,
        1,
        0,
        2.1,
        -0.7,
        0,
        0,
        90
      }
    },
    [415] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.8,
        0,
        0,
        90
      }
    },
    [439] = {
      {
        2985,
        1,
        0,
        1.5,
        -0.7,
        0,
        0,
        90
      }
    },
    [420] = {
      {
        2985,
        1,
        0,
        1.6,
        -0.8,
        0,
        0,
        90
      }
    },
    [603] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.8,
        0,
        0,
        90
      }
    },
    [495] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.5,
        0,
        0,
        90
      }
    },
    [423] = {
      {
        2985,
        1,
        -0.014,
        2,
        -0.67,
        0,
        0,
        90
      }
    },
    [555] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.8,
        0,
        0,
        90
      }
    },
    [596] = {
      {
        2985,
        1,
        0,
        1.699,
        -0.649,
        0,
        0,
        90
      }
    },
    [599] = {
      {
        2985,
        1,
        -0.032,
        1.5,
        -0.47,
        0,
        0,
        90
      }
    },
    [490] = {
      {
        2985,
        1,
        -0.001,
        2.1,
        -0.5,
        0,
        0,
        90
      }
    },
    [589] = {
      {
        2985,
        0.6,
        0,
        1.6,
        -0.05,
        0,
        0,
        90
      }
    },
    [480] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.8,
        0,
        0,
        90
      }
    },
    [588] = {
      {
        2985,
        2,
        0,
        3.6,
        -2.5,
        0,
        0,
        90
      }
    },
    [451] = {
      {
        2985,
        0.8,
        0.003,
        1.5,
        -0.63,
        0,
        0,
        90
      }
    },
    [587] = {
      {
        2985,
        1,
        0,
        1.699,
        -0.666,
        0,
        0,
        90
      }
    },
    [416] = {
      {
        2985,
        1,
        0,
        2.386,
        -0.561,
        0,
        0,
        90
      }
    },
    [407] = {
      {
        2985,
        1,
        0,
        4.2,
        -1.1,
        0,
        0,
        90
      }
    },
    [404] = {
      {
        2985,
        1,
        0,
        1.213,
        -0.511,
        0,
        0,
        90
      }
    },
    [402] = {
      {
        2985,
        1,
        0,
        1.213,
        -0.569,
        0,
        0,
        90
      }
    },
    [580] = {
      {
        2985,
        1,
        0,
        1.213,
        -0.413,
        0,
        0,
        90
      }
    },
    [579] = {
      {
        2985,
        1,
        0,
        1.213,
        -0.4,
        0,
        0,
        90
      }
    },
    [482] = {
      {
        2985,
        1,
        0,
        2.023,
        -0.75,
        0,
        0,
        90
      }
    },
    [573] = {
      {
        2985,
        2,
        0,
        3.1,
        -2.5,
        0,
        0,
        90
      }
    },
    [565] = {
      {
        2985,
        1,
        0.007,
        1.699,
        -0.6,
        0,
        0,
        90
      }
    },
    [562] = {
      {
        2985,
        1,
        0.012,
        2,
        -0.6,
        0,
        0,
        90
      }
    },
    [455] = {
      {
        2985,
        1,
        0.015,
        3,
        0.108,
        0,
        0,
        90
      }
    },
    [561] = {
      {
        2985,
        1,
        0.01,
        2.199,
        -0.7,
        0,
        0,
        90
      }
    },
    [560] = {
      {
        2985,
        1,
        0.009,
        1.6,
        -0.5,
        0,
        0,
        90
      }
    },
    [559] = {
      {
        2985,
        1,
        0.017,
        1.6,
        -0.6,
        0,
        0,
        90
      }
    },
    [470] = {
      {
        2985,
        1,
        0.021,
        1.6,
        -0.4,
        0,
        0,
        90
      }
    },
    [558] = {
      {
        2985,
        1,
        0.007,
        1.3,
        -0.55,
        0,
        0,
        90
      }
    },
    [444] = {
      {
        2985,
        1,
        0.019,
        2.199,
        0.2,
        0,
        0,
        90
      }
    },
    [554] = {
      {
        2985,
        1,
        0.015,
        2.199,
        -0.4,
        0,
        0,
        90
      }
    },
    [545] = {
      {
        2985,
        1,
        0.016,
        0.899,
        -0.5,
        0,
        0,
        90
      }
    },
    [542] = {
      {
        2985,
        1,
        0.019,
        2,
        -0.6,
        0,
        0,
        90
      }
    },
    [541] = {
      {
        2985,
        1,
        0.013,
        2,
        -0.7,
        0,
        0,
        90
      }
    },
    [533] = {
      {
        2985,
        1,
        0.018,
        2,
        -0.59,
        0,
        0,
        90
      }
    },
    [539] = {
      {
        2985,
        1,
        0,
        1.199,
        -0.5,
        0,
        0,
        90
      }
    },
    [535] = {
      {
        2985,
        1,
        0.039,
        1.899,
        -0.4,
        0,
        0,
        90
      }
    },
    [531] = {
      {
        2985,
        1,
        0.019,
        1.199,
        -0.4,
        0,
        0,
        90
      }
    },
    [429] = {
      {
        2985,
        1,
        0.013,
        1.6,
        -0.5,
        0,
        0,
        90
      }
    },
    [528] = {
      {
        2985,
        1,
        0.015,
        2,
        -0.4,
        0,
        0,
        90
      }
    },
    [427] = {
      {
        2985,
        1,
        0.022,
        2.899,
        -0.2,
        0,
        0,
        90
      }
    },
    [428] = {
      {
        2985,
        1,
        0.022,
        2.3,
        -0.6,
        0,
        0,
        90
      }
    },
    [525] = {
      {
        2985,
        1,
        0.023,
        2.399,
        0,
        0,
        0,
        90
      }
    },
    [514] = {
      {
        2985,
        1,
        0.014,
        3.397,
        -0.11,
        0,
        0,
        90
      }
    },
    [508] = {
      {
        2985,
        1,
        0.014,
        2.646,
        -0.554,
        0,
        0,
        90
      }
    },
    [506] = {
      {
        2985,
        1,
        0.013,
        1.396,
        -0.586,
        0,
        0,
        90
      }
    },
    [494] = {
      {
        2985,
        1,
        0.013,
        1.8,
        -0.6,
        0,
        0,
        90
      }
    },
    [483] = {
      {
        2985,
        1,
        0,
        3.1,
        -1.4,
        0,
        0,
        90
      }
    },
    [479] = {
      {
        2985,
        1,
        0.031,
        2.199,
        -0.4,
        0,
        0,
        90
      }
    },
    [571] = {
      {
        2985,
        0.5,
        0.008,
        0.699,
        -0.4,
        0,
        0,
        90
      }
    },
    [478] = {
      {
        2985,
        1,
        0.038,
        1.399,
        -0.4,
        0,
        0,
        90
      }
    },
    [431] = {
      {
        2985,
        2,
        -0.061,
        5.3,
        2.239,
        180,
        0,
        90
      }
    },
    [471] = {
      {
        2985,
        0.5,
        0,
        0.7,
        0,
        0,
        0,
        90
      }
    },
    [443] = {
      {
        2985,
        2,
        0.01,
        5.767,
        -2.262,
        0,
        0,
        90
      }
    },
    [583] = {
      {
        2985,
        0.6,
        0.014,
        1.199,
        0.4,
        0,
        0,
        90
      }
    },
    [411] = {
      {
        2985,
        1,
        0.019,
        1.6,
        -0.8,
        0,
        0,
        90
      }
    },
    [400] = {
      {
        2985,
        1,
        0,
        1.8,
        -0.835,
        0,
        0,
        90
      }
    },
    [403] = {
      {
        2985,
        2,
        0,
        4.2,
        -2.221,
        0,
        0,
        90
      }
    },
    [405] = {
      {
        2985,
        1,
        0,
        2.1,
        -0.891,
        0,
        0,
        90
      }
    },
    [406] = {
      {
        2985,
        3,
        0,
        5.4,
        -4.533,
        0,
        0,
        90
      }
    },
    [408] = {
      {
        2985,
        2,
        0,
        5.1,
        -2.419,
        0,
        0,
        90
      }
    },
    [409] = {
      {
        2985,
        1,
        0,
        3.1,
        -0.781,
        0,
        0,
        90
      }
    },
    [410] = {
      {
        2985,
        1,
        0,
        1.7,
        -0.624,
        0,
        0,
        90
      }
    },
    [412] = {
      {
        2985,
        1,
        0,
        2.4,
        -0.869,
        0,
        0,
        90
      }
    },
    [413] = {
      {
        2985,
        1,
        0.026,
        2.399,
        -0.862,
        0,
        0,
        90
      }
    },
    [414] = {
      {
        2985,
        1,
        0.014,
        2.586,
        -0.66,
        0,
        0,
        90
      }
    },
    [418] = {
      {
        2985,
        1,
        0.016,
        2.302,
        -1.003,
        0,
        0,
        90
      }
    },
    [419] = {
      {
        2985,
        1,
        0.02,
        2.302,
        -0.947,
        0,
        0,
        90
      }
    },
    [421] = {
      {
        2985,
        1,
        0.02,
        2.302,
        -1.044,
        0,
        0,
        90
      }
    },
    [422] = {
      {
        2985,
        1,
        0.019,
        1.798,
        -0.761,
        0,
        0,
        90
      }
    },
    [424] = {
      {
        2985,
        1,
        0.018,
        1.048,
        -0.721,
        0,
        0,
        90
      }
    },
    [426] = {
      {
        2985,
        1,
        0.021,
        1.798,
        -0.772,
        0,
        0,
        90
      }
    },
    [433] = {
      {
        2985,
        2,
        0,
        4,
        -1.9,
        0,
        0,
        90
      }
    },
    [434] = {
      {
        2985,
        1,
        0.016,
        1.612,
        -0.908,
        0,
        0,
        90
      }
    },
    [436] = {
      {
        2985,
        1,
        0.02,
        1.817,
        -0.749,
        0,
        0,
        90
      }
    },
    [437] = {
      {
        2985,
        1,
        -0.015,
        5.664,
        -0.826,
        0,
        0,
        90
      }
    },
    [438] = {
      {
        2985,
        1,
        0.019,
        2.098,
        -0.719,
        0,
        0,
        90
      }
    },
    [439] = {
      {
        2985,
        1,
        0.022,
        1.598,
        -0.849,
        0,
        0,
        90
      }
    },
    [440] = {
      {
        2985,
        1,
        0.002,
        2.351,
        -0.882,
        0,
        0,
        90
      }
    },
    [456] = {
      {
        2985,
        2,
        -0.1,
        3.4,
        -2.042,
        0,
        0,
        90
      }
    },
    [457] = {
      {
        2985,
        0.6,
        0.01,
        0.991,
        -0.253,
        0,
        0,
        90
      }
    },
    [458] = {
      {
        2985,
        1.2,
        -0.029,
        1.74,
        -0.944,
        0,
        0,
        90
      }
    },
    [459] = {
      {
        2985,
        1.2,
        -0.003,
        2.249,
        -0.869,
        0,
        0,
        90
      }
    },
    [466] = {
      {
        2985,
        1.2,
        0.017,
        1.626,
        -0.884,
        0,
        0,
        90
      }
    },
    [467] = {
      {
        2985,
        1.2,
        0.011,
        1.626,
        -0.867,
        0,
        0,
        90
      }
    },
    [475] = {
      {
        2985,
        1.2,
        0.012,
        1.626,
        -0.947,
        0,
        0,
        90
      }
    },
    [489] = {
      {
        2985,
        1.2,
        0.025,
        1.626,
        -0.793,
        0,
        0,
        90
      }
    },
    [490] = {
      {
        2985,
        1.2,
        0.035,
        2.832,
        -0.869,
        0,
        0,
        90
      }
    },
    [491] = {
      {
        2985,
        1.2,
        -0.008,
        2.065,
        -0.978,
        0,
        0,
        90
      }
    },
    [492] = {
      {
        2985,
        1.2,
        0.005,
        2.065,
        -0.932,
        0,
        0,
        90
      }
    },
    [499] = {
      {
        2985,
        1.2,
        0.009,
        2.182,
        -0.937,
        0,
        0,
        90
      }
    },
    [500] = {
      {
        2985,
        1.2,
        -0.018,
        1.182,
        -1.102,
        0,
        0,
        90
      }
    },
    [502] = {
      {
        2985,
        1.2,
        0,
        2,
        -0.91,
        0,
        0,
        90
      }
    },
    [503] = {
      {
        2985,
        1.2,
        0,
        1.6,
        -0.884,
        0,
        0,
        90
      }
    },
    [507] = {
      {
        2985,
        1.2,
        0,
        1.9,
        -0.939,
        0,
        0,
        90
      }
    },
    [515] = {
      {
        2985,
        2,
        0,
        4.4,
        -2.306,
        0,
        0,
        90
      }
    },
    [516] = {
      {
        2985,
        1.2,
        0,
        2.1,
        -0.887,
        0,
        0,
        90
      }
    },
    [517] = {
      {
        2985,
        1.2,
        0,
        2.1,
        -0.927,
        0,
        0,
        90
      }
    },
    [518] = {
      {
        2985,
        1.2,
        0,
        2.1,
        -0.903,
        0,
        0,
        90
      }
    },
    [524] = {
      {
        2985,
        2,
        0,
        3.9,
        -2.498,
        0,
        0,
        90
      }
    },
    [526] = {
      {
        2985,
        1.2,
        0,
        1.9,
        -1.009,
        0,
        0,
        90
      }
    },
    [529] = {
      {
        2985,
        1.2,
        0,
        1.9,
        -0.836,
        0,
        0,
        90
      }
    },
    [534] = {
      {
        2985,
        1.2,
        0,
        2.4,
        -0.98,
        0,
        0,
        90
      }
    },
    [540] = {
      {
        2985,
        1,
        0,
        1.9,
        -0.803,
        0,
        0,
        90
      }
    },
    [543] = {
      {
        2985,
        1.2,
        0.033,
        1.543,
        -0.862,
        0,
        0,
        90
      }
    },
    [544] = {
      {
        2985,
        1.2,
        -0.003,
        3.571,
        -1.104,
        0,
        0,
        90
      }
    },
    [546] = {
      {
        2985,
        1.2,
        0,
        1.8,
        -0.847,
        0,
        0,
        90
      }
    },
    [547] = {
      {
        2985,
        1.2,
        0,
        1.8,
        -0.868,
        0,
        0,
        90
      }
    },
    [549] = {
      {
        2985,
        1.2,
        0,
        1.8,
        -0.864,
        0,
        0,
        90
      }
    },
    [551] = {
      {
        2985,
        1.2,
        0,
        1.8,
        -0.9,
        0,
        0,
        90
      }
    },
    [552] = {
      {
        2985,
        1.2,
        0.015,
        2.454,
        -0.45,
        0,
        0,
        90
      }
    },
    [566] = {
      {
        2985,
        1.2,
        0.017,
        2.277,
        -0.903,
        0,
        0,
        90
      }
    },
    [567] = {
      {
        2985,
        1.2,
        0.024,
        2.277,
        -1.056,
        0,
        0,
        90
      }
    },
    [568] = {
      {
        2985,
        0.7,
        0.015,
        1.964,
        -0.565,
        0,
        0,
        90
      }
    },
    [572] = {
      {
        2985,
        0.7,
        0.003,
        0.711,
        -0.242,
        0,
        0,
        90
      }
    },
    [574] = {
      {
        2985,
        0.88,
        0.009,
        1.461,
        -0.557,
        0,
        0,
        90
      }
    },
    [575] = {
      {
        2985,
        1.2,
        0.018,
        1.579,
        -0.74,
        0,
        0,
        90
      }
    },
    [576] = {
      {
        2985,
        1.2,
        0.003,
        1.579,
        -0.778,
        0,
        0,
        90
      }
    },
    [578] = {
      {
        2985,
        1.2,
        0.018,
        4.492,
        -1.613,
        0,
        0,
        90
      }
    },
    [582] = {
      {
        2985,
        1,
        0,
        2.3,
        -0.853,
        0,
        0,
        90
      }
    },
    [585] = {
      {
        2985,
        1,
        0,
        2.4,
        -0.536,
        0,
        0,
        90
      }
    },
    [600] = {
      {
        2985,
        1,
        0,
        2.4,
        -0.616,
        0,
        0,
        90
      }
    },
    [601] = {
      {
        2985,
        1,
        0,
        2.7,
        -0.041,
        0,
        0,
        90
      }
    }
  },
  [7] = {
    [474] = {
      {
        2976,
        1,
        -0.9,
        2.6,
        -0.029,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.899,
        2.6,
        -0.029,
        0,
        90,
        90
      }
    },
    [445] = {
      {
        2976,
        1,
        -0.7,
        2.4,
        0,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.6,
        2.4,
        0,
        0,
        90,
        90
      }
    },
    [401] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.1,
        0,
        90,
        90
      }
    },
    [401] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.1,
        0,
        90,
        90
      }
    },
    [536] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.2,
        0,
        90,
        90
      }
    },
    [527] = {
      {
        2976,
        1,
        -0.7,
        2.4,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.4,
        -0.1,
        0,
        90,
        90
      }
    },
    [550] = {
      {
        2976,
        1,
        -0.7,
        2.7,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.7,
        -0.2,
        0,
        90,
        90
      }
    },
    [498] = {
      {
        2976,
        1,
        -0.9,
        3.1,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        3.1,
        -0.3,
        0,
        90,
        90
      }
    },
    [477] = {
      {
        2976,
        1,
        -0.7,
        2.7,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.7,
        -0.3,
        0,
        90,
        90
      }
    },
    [504] = {
      {
        2976,
        1,
        -0.6,
        2.6,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.6,
        -0.1,
        0,
        90,
        90
      }
    },
    [496] = {
      {
        2976,
        1,
        -0.7,
        2.2,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.2,
        -0.1,
        0,
        90,
        90
      }
    },
    [602] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.3,
        0,
        90,
        90
      }
    },
    [442] = {
      {
        2976,
        1,
        -0.7,
        2.8,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.8,
        -0.2,
        0,
        90,
        90
      }
    },
    [415] = {
      {
        2976,
        1,
        -0.6,
        2.5,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.6,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [439] = {
      {
        2976,
        1,
        -0.8,
        2.5,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        -0.1,
        0,
        90,
        90
      }
    },
    [420] = {
      {
        2976,
        1,
        -0.8,
        2.3,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.3,
        -0.1,
        0,
        90,
        90
      }
    },
    [603] = {
      {
        2976,
        1,
        -0.7,
        2.7,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.7,
        -0.2,
        0,
        90,
        90
      }
    },
    [495] = {
      {
        2976,
        1,
        -0.8,
        2.3,
        0,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.3,
        0,
        0,
        90,
        90
      }
    },
    [423] = {
      {
        2976,
        1,
        -0.816,
        2.139,
        -0.02,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.14,
        -0.02,
        0,
        90,
        90
      }
    },
    [555] = {
      {
        2976,
        1,
        -0.544,
        2.198,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.544,
        2.199,
        -0.1,
        0,
        90,
        90
      }
    },
    [596] = {
      {
        2976,
        1,
        -0.816,
        2.198,
        0,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.199,
        0,
        0,
        90,
        90
      }
    },
    [599] = {
      {
        2976,
        1,
        -0.725,
        2.5,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [490] = {
      {
        2976,
        1,
        -0.816,
        3.099,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.906,
        3.1,
        -0.4,
        0,
        90,
        90
      }
    },
    [589] = {
      {
        2976,
        1,
        -0.725,
        2.398,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.399,
        -0.1,
        0,
        90,
        90
      }
    },
    [480] = {
      {
        2976,
        1,
        -0.635,
        2.198,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        2.199,
        -0.3,
        0,
        90,
        90
      }
    },
    [588] = {
      {
        2976,
        1,
        -0.816,
        3.398,
        -0.5,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        3.399,
        -0.5,
        0,
        90,
        90
      }
    },
    [451] = {
      {
        2976,
        1,
        -0.635,
        2.398,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        2.399,
        -0.3,
        0,
        90,
        90
      }
    },
    [587] = {
      {
        2976,
        1,
        -0.725,
        2.198,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.199,
        -0.2,
        0,
        90,
        90
      }
    },
    [416] = {
      {
        2976,
        1,
        -0.725,
        2.898,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.899,
        -0.4,
        0,
        90,
        90
      }
    },
    [407] = {
      {
        2976,
        1,
        -0.816,
        4.299,
        -0.7,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        4.3,
        -0.7,
        0,
        90,
        90
      }
    },
    [404] = {
      {
        2976,
        1,
        -0.725,
        2.198,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.199,
        -0.3,
        0,
        90,
        90
      }
    },
    [402] = {
      {
        2976,
        1,
        -0.816,
        2.5,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.5,
        -0.2,
        0,
        90,
        90
      }
    },
    [580] = {
      {
        2976,
        1,
        -0.816,
        2.599,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.6,
        -0.1,
        0,
        90,
        90
      }
    },
    [579] = {
      {
        2976,
        1,
        -0.906,
        2.299,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.3,
        -0.2,
        0,
        90,
        90
      }
    },
    [482] = {
      {
        2976,
        1,
        -0.725,
        2.299,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.3,
        -0.3,
        0,
        90,
        90
      }
    },
    [573] = {
      {
        2976,
        1,
        -0.907,
        3.099,
        -0.7,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.906,
        3.1,
        -0.7,
        0,
        90,
        90
      }
    },
    [565] = {
      {
        2976,
        1,
        -0.635,
        2.099,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        2.1,
        -0.1,
        0,
        90,
        90
      }
    },
    [562] = {
      {
        2976,
        1,
        -0.725,
        2.299,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.3,
        -0.1,
        0,
        90,
        90
      }
    },
    [455] = {
      {
        2976,
        1,
        -1.178,
        3.918,
        -0.5,
        0,
        90,
        90
      },
      {
        2976,
        1,
        1.178,
        3.918,
        -0.5,
        0,
        90,
        90
      }
    },
    [561] = {
      {
        2976,
        1,
        -0.635,
        2.599,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        2.6,
        -0.3,
        0,
        90,
        90
      }
    },
    [560] = {
      {
        2976,
        1,
        -0.725,
        2.5,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.5,
        -0.1,
        0,
        90,
        90
      }
    },
    [559] = {
      {
        2976,
        1,
        -0.725,
        2.599,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.6,
        -0.2,
        0,
        90,
        90
      }
    },
    [470] = {
      {
        2976,
        1,
        -0.816,
        2,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2,
        -0.2,
        0,
        90,
        90
      }
    },
    [558] = {
      {
        2976,
        1,
        -0.635,
        2.099,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        2.1,
        -0.1,
        0,
        90,
        90
      }
    },
    [444] = {
      {
        2976,
        1,
        -0.907,
        2.799,
        0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.906,
        2.8,
        0.3,
        0,
        90,
        90
      }
    },
    [554] = {
      {
        2976,
        1,
        -0.816,
        2.5,
        -0.119,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.5,
        -0.119,
        0,
        90,
        90
      }
    },
    [545] = {
      {
        2976,
        1,
        -0.816,
        1.698,
        -0.109,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        1.699,
        -0.109,
        0,
        90,
        90
      }
    },
    [542] = {
      {
        2976,
        1,
        -0.816,
        2.509,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.509,
        -0.1,
        0,
        90,
        90
      }
    },
    [541] = {
      {
        2976,
        1,
        -0.635,
        2.198,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        2.199,
        -0.1,
        0,
        90,
        90
      }
    },
    [533] = {
      {
        2976,
        1,
        -0.725,
        2.398,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.399,
        -0.1,
        0,
        90,
        90
      }
    },
    [539] = {
      {
        2976,
        1,
        -0.725,
        1.137,
        0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        1.138,
        0.1,
        0,
        90,
        90
      }
    },
    [535] = {
      {
        2976,
        1,
        -0.816,
        2.398,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.399,
        -0.1,
        0,
        90,
        90
      }
    },
    [531] = {
      {
        2976,
        1,
        -0.454,
        1.398,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.453,
        1.399,
        -0.3,
        0,
        90,
        90
      }
    },
    [429] = {
      {
        2976,
        1,
        -0.726,
        2.299,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.3,
        -0.2,
        0,
        90,
        90
      }
    },
    [528] = {
      {
        2976,
        1,
        -0.816,
        2.5,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [427] = {
      {
        2976,
        1,
        -0.816,
        3.299,
        -0.6,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        3.3,
        -0.6,
        0,
        90,
        90
      }
    },
    [428] = {
      {
        2976,
        1,
        -0.725,
        2.698,
        -0.7,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.699,
        -0.7,
        0,
        90,
        90
      }
    },
    [525] = {
      {
        2976,
        1,
        -0.816,
        3,
        0,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        3,
        0,
        0,
        90,
        90
      }
    },
    [514] = {
      {
        2976,
        1,
        -0.998,
        4.198,
        -0.8,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.906,
        4.199,
        -0.8,
        0,
        90,
        90
      }
    },
    [508] = {
      {
        2976,
        1,
        -0.816,
        2.898,
        -0.5,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.816,
        2.899,
        -0.5,
        0,
        90,
        90
      }
    },
    [506] = {
      {
        2976,
        1,
        -0.725,
        2.198,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.199,
        -0.3,
        0,
        90,
        90
      }
    },
    [494] = {
      {
        2976,
        1,
        -0.725,
        2.5,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.5,
        -0.4,
        0,
        90,
        90
      }
    },
    [483] = {
      {
        2976,
        1,
        -0.725,
        2.698,
        -0.5,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.725,
        2.699,
        -0.5,
        0,
        90,
        90
      }
    },
    [479] = {
      {
        2976,
        1,
        -0.81,
        2.5,
        -0.2,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.822,
        2.5,
        -0.2,
        0,
        90,
        90
      }
    },
    [571] = {
      {
        2976,
        0.5,
        -0.2,
        0.5,
        0.1,
        0,
        90,
        90
      },
      {
        2976,
        0.5,
        0.2,
        0.5,
        0.1,
        0,
        90,
        90
      }
    },
    [478] = {
      {
        2976,
        1,
        -0.635,
        2.198,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        2.199,
        -0.4,
        0,
        90,
        90
      }
    },
    [431] = {
      {
        2976,
        2,
        -0.997,
        5.698,
        -0.3,
        0,
        90,
        90
      },
      {
        2976,
        2,
        0.997,
        5.699,
        -0.3,
        0,
        90,
        90
      }
    },
    [471] = {
      {
        2976,
        0.5,
        -0.391,
        0.799,
        0.2,
        0,
        90,
        90
      },
      {
        2976,
        0.5,
        0.425,
        0.8,
        0.2,
        0,
        90,
        90
      }
    },
    [443] = {
      {
        2976,
        2,
        -0.997,
        5.698,
        -0.7,
        0,
        90,
        90
      },
      {
        2976,
        2,
        0.997,
        5.699,
        -0.7,
        0,
        90,
        90
      }
    },
    [583] = {
      {
        2976,
        1,
        -0.544,
        1.398,
        0.5,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.634,
        1.399,
        0.5,
        0,
        90,
        90
      }
    },
    [411] = {
      {
        2976,
        1,
        -0.799,
        2.698,
        -0.1,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.82,
        2.698,
        -0.1,
        0,
        90,
        90
      }
    },
    [400] = {
      {
        2976,
        1,
        -0.9,
        2,
        -0.535,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2,
        -0.535,
        0,
        90,
        90
      }
    },
    [403] = {
      {
        2976,
        1,
        -1.1,
        4.399,
        -0.821,
        0,
        90,
        90
      },
      {
        2976,
        1,
        1.1,
        4.4,
        -0.821,
        0,
        90,
        90
      }
    },
    [405] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.291,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.291,
        0,
        90,
        90
      }
    },
    [406] = {
      {
        2976,
        3,
        -1.6,
        5.3,
        -1.733,
        0,
        90,
        90
      },
      {
        2976,
        3,
        1.5,
        5.3,
        -1.733,
        0,
        90,
        90
      }
    },
    [408] = {
      {
        2976,
        1,
        -1.1,
        4.9,
        -0.719,
        0,
        90,
        90
      },
      {
        2976,
        1,
        1.1,
        4.9,
        -0.719,
        0,
        90,
        90
      }
    },
    [409] = {
      {
        2976,
        1,
        -0.9,
        3.6,
        -0.281,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        3.6,
        -0.281,
        0,
        90,
        90
      }
    },
    [410] = {
      {
        2976,
        1,
        -0.7,
        2.3,
        -0.124,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.3,
        -0.124,
        0,
        90,
        90
      }
    },
    [412] = {
      {
        2976,
        1,
        -0.9,
        2.6,
        -0.269,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.6,
        -0.269,
        0,
        90,
        90
      }
    },
    [413] = {
      {
        2976,
        1,
        -0.9,
        2.6,
        -0.405,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.6,
        -0.405,
        0,
        90,
        90
      }
    },
    [414] = {
      {
        2976,
        1,
        -0.9,
        2.8,
        -0.531,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.8,
        -0.531,
        0,
        90,
        90
      }
    },
    [418] = {
      {
        2976,
        1,
        -0.8,
        2.5,
        -0.666,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        -0.666,
        0,
        90,
        90
      }
    },
    [419] = {
      {
        2976,
        1,
        -0.8,
        2.6,
        -0.4,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.6,
        -0.4,
        0,
        90,
        90
      }
    },
    [421] = {
      {
        2976,
        1,
        -0.8,
        2.5,
        -0.277,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        -0.277,
        0,
        90,
        90
      }
    },
    [422] = {
      {
        2976,
        1,
        -0.8,
        2.1,
        -0.325,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.1,
        -0.325,
        0,
        90,
        90
      }
    },
    [424] = {
      {
        2976,
        1,
        -0.6,
        1.6,
        -0.164,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        1.6,
        -0.164,
        0,
        90,
        90
      }
    },
    [426] = {
      {
        2976,
        1,
        -0.9,
        2.3,
        -0.227,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.3,
        -0.227,
        0,
        90,
        90
      }
    },
    [433] = {
      {
        2976,
        2,
        -1.199,
        4.1,
        -0.5,
        0,
        90,
        90
      },
      {
        2976,
        2,
        1.2,
        4.1,
        -0.5,
        0,
        90,
        90
      }
    },
    [434] = {
      {
        2976,
        1,
        -0.6,
        1.9,
        -0.534,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.6,
        1.9,
        -0.534,
        0,
        90,
        90
      }
    },
    [436] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.148,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.4,
        -0.148,
        0,
        90,
        90
      }
    },
    [437] = {
      {
        2976,
        2,
        -1.1,
        5.6,
        -0.544,
        0,
        90,
        90
      },
      {
        2976,
        2,
        1.1,
        5.6,
        -0.544,
        0,
        90,
        90
      }
    },
    [438] = {
      {
        2976,
        1,
        -0.9,
        2.5,
        -0.374,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        -0.374,
        0,
        90,
        90
      }
    },
    [439] = {
      {
        2976,
        1,
        -1,
        2.2,
        -0.232,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.2,
        -0.232,
        0,
        90,
        90
      }
    },
    [440] = {
      {
        2976,
        1,
        -0.9,
        2.4,
        -0.378,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.378,
        0,
        90,
        90
      }
    },
    [456] = {
      {
        2976,
        1,
        -0.9,
        3.3,
        -0.342,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        3.3,
        -0.342,
        0,
        90,
        90
      }
    },
    [457] = {
      {
        2976,
        1,
        -0.5,
        1.1,
        0.012,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.5,
        1.1,
        0.012,
        0,
        90,
        90
      }
    },
    [458] = {
      {
        2976,
        1,
        -0.9,
        2.4,
        -0.253,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.4,
        -0.253,
        0,
        90,
        90
      }
    },
    [459] = {
      {
        2976,
        1,
        -0.8,
        2.5,
        -0.133,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        -0.133,
        0,
        90,
        90
      }
    },
    [466] = {
      {
        2976,
        1,
        -0.9,
        2.5,
        -0.057,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.5,
        -0.057,
        0,
        90,
        90
      }
    },
    [467] = {
      {
        2976,
        1,
        -0.8,
        2.7,
        -0.013,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.7,
        -0.013,
        0,
        90,
        90
      }
    },
    [475] = {
      {
        2976,
        1,
        -0.9,
        2.4,
        -0.038,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.4,
        -0.038,
        0,
        90,
        90
      }
    },
    [489] = {
      {
        2976,
        1,
        -1,
        2.7,
        -0.33,
        0,
        90,
        90
      },
      {
        2976,
        1,
        1,
        2.7,
        -0.33,
        0,
        90,
        90
      }
    },
    [490] = {
      {
        2976,
        1,
        -1,
        3.2,
        -0.343,
        0,
        90,
        90
      },
      {
        2976,
        1,
        1,
        3.2,
        -0.343,
        0,
        90,
        90
      }
    },
    [491] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.198,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.198,
        0,
        90,
        90
      }
    },
    [492] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.154,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.154,
        0,
        90,
        90
      }
    },
    [499] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        -0.17,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        -0.17,
        0,
        90,
        90
      }
    },
    [500] = {
      {
        2976,
        1,
        -0.9,
        2,
        -0.271,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2,
        -0.271,
        0,
        90,
        90
      }
    },
    [502] = {
      {
        2976,
        1,
        -0.8,
        2.5,
        -0.31,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        -0.31,
        0,
        90,
        90
      }
    },
    [503] = {
      {
        2976,
        1,
        -0.7,
        2.3,
        -0.084,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.3,
        -0.084,
        0,
        90,
        90
      }
    },
    [507] = {
      {
        2976,
        1,
        -1,
        2.6,
        -0.139,
        0,
        90,
        90
      },
      {
        2976,
        1,
        1,
        2.6,
        -0.139,
        0,
        90,
        90
      }
    },
    [515] = {
      {
        2976,
        2,
        -1.3,
        4.6,
        -1.106,
        0,
        90,
        90
      },
      {
        2976,
        2,
        1.2,
        4.6,
        -1.106,
        0,
        90,
        90
      }
    },
    [516] = {
      {
        2976,
        1,
        -0.9,
        2.7,
        -0.187,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.7,
        -0.187,
        0,
        90,
        90
      }
    },
    [517] = {
      {
        2976,
        1,
        -0.8,
        2.7,
        -0.027,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.7,
        -0.027,
        0,
        90,
        90
      }
    },
    [518] = {
      {
        2976,
        1,
        -0.9,
        2.6,
        -0.003,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.6,
        -0.003,
        0,
        90,
        90
      }
    },
    [524] = {
      {
        2976,
        2,
        -1.2,
        3.9,
        -0.898,
        0,
        90,
        90
      },
      {
        2976,
        2,
        1.2,
        3.9,
        -0.898,
        0,
        90,
        90
      }
    },
    [526] = {
      {
        2976,
        1,
        -0.9,
        2.3,
        -0.209,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.3,
        -0.209,
        0,
        90,
        90
      }
    },
    [529] = {
      {
        2976,
        1,
        -0.9,
        2.5,
        0.064,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.5,
        0.064,
        0,
        90,
        90
      }
    },
    [534] = {
      {
        2976,
        1,
        -0.9,
        2.9,
        -0.08,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.9,
        -0.08,
        0,
        90,
        90
      }
    },
    [540] = {
      {
        2976,
        1,
        -0.8,
        2.6,
        -0.203,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.6,
        -0.203,
        0,
        90,
        90
      }
    },
    [543] = {
      {
        2976,
        1,
        -0.8,
        2.2,
        0.028,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.2,
        0.028,
        0,
        90,
        90
      }
    },
    [544] = {
      {
        2976,
        2,
        -0.9,
        3.4,
        -0.492,
        0,
        90,
        90
      },
      {
        2976,
        2,
        1,
        3.4,
        -0.492,
        0,
        90,
        90
      }
    },
    [546] = {
      {
        2976,
        1,
        -0.9,
        2.7,
        0.053,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.7,
        0.053,
        0,
        90,
        90
      }
    },
    [547] = {
      {
        2976,
        1,
        -0.8,
        2.5,
        0.082,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        0.082,
        0,
        90,
        90
      }
    },
    [549] = {
      {
        2976,
        1,
        -0.8,
        2.5,
        0.036,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.5,
        0.036,
        0,
        90,
        90
      }
    },
    [551] = {
      {
        2976,
        1,
        -0.8,
        2.6,
        -0.05,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.6,
        -0.05,
        0,
        90,
        90
      }
    },
    [552] = {
      {
        2976,
        1,
        -0.9,
        3,
        0.15,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        3,
        0.15,
        0,
        90,
        90
      }
    },
    [566] = {
      {
        2976,
        1,
        -0.8,
        2.6,
        -0.092,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.6,
        -0.092,
        0,
        90,
        90
      }
    },
    [567] = {
      {
        2976,
        1,
        -0.9,
        2.9,
        -0.162,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.9,
        -0.162,
        0,
        90,
        90
      }
    },
    [568] = {
      {
        2976,
        1,
        -0.5,
        2,
        -0.191,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.5,
        2,
        -0.191,
        0,
        90,
        90
      }
    },
    [572] = {
      {
        2976,
        1,
        -0.4,
        0.6,
        0.182,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.4,
        0.6,
        0.182,
        0,
        90,
        90
      }
    },
    [574] = {
      {
        2976,
        1,
        -0.6,
        1.6,
        0.116,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.6,
        1.6,
        0.116,
        0,
        90,
        90
      }
    },
    [575] = {
      {
        2976,
        1,
        -0.8,
        2.4,
        0.099,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.4,
        0.099,
        0,
        90,
        90
      }
    },
    [576] = {
      {
        2976,
        1,
        -1,
        2.4,
        0.061,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.9,
        2.4,
        0.061,
        0,
        90,
        90
      }
    },
    [578] = {
      {
        2976,
        1,
        -0.8,
        4.4,
        -0.788,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        4.4,
        -0.788,
        0,
        90,
        90
      }
    },
    [582] = {
      {
        2976,
        1,
        -0.7,
        2.6,
        -0.253,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.6,
        -0.253,
        0,
        90,
        90
      }
    },
    [585] = {
      {
        2976,
        1,
        -0.7,
        2.9,
        0.164,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.7,
        2.9,
        0.164,
        0,
        90,
        90
      }
    },
    [600] = {
      {
        2976,
        1,
        -0.8,
        2.8,
        -0.016,
        0,
        90,
        90
      },
      {
        2976,
        1,
        0.8,
        2.8,
        -0.016,
        0,
        90,
        90
      }
    },
    [601] = {
      {
        2976,
        1.5,
        -0.8,
        2.8,
        0.259,
        0,
        90,
        90
      },
      {
        2976,
        1.5,
        0.8,
        2.8,
        0.259,
        0,
        90,
        90
      }
    }
  },
  [8] = {},
  [9] = {
    [474] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.371,
        340,
        0,
        180
      }
    },
    [445] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.3,
        340,
        0,
        180
      }
    },
    [401] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.2,
        340,
        0,
        180
      }
    },
    [401] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.2,
        340,
        0,
        180
      }
    },
    [536] = {
      {
        951,
        1.25,
        0,
        2,
        -0.3,
        340,
        0,
        180
      }
    },
    [527] = {
      {
        951,
        1.25,
        0,
        0,
        0.3,
        340,
        0,
        180
      }
    },
    [550] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.2,
        340,
        0,
        180
      }
    },
    [498] = {
      {
        951,
        1.25,
        0,
        1.3,
        1.6,
        340,
        0,
        180
      }
    },
    [477] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.2,
        340,
        0,
        180
      }
    },
    [504] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.4,
        340,
        0,
        180
      }
    },
    [496] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.3,
        340,
        0,
        180
      }
    },
    [602] = {
      {
        951,
        1.25,
        0,
        -0.5,
        0.2,
        340,
        0,
        180
      }
    },
    [442] = {
      {
        951,
        1.25,
        0,
        0,
        0.4,
        340,
        0,
        180
      }
    },
    [415] = {
      {
        951,
        1.25,
        0,
        -0.5,
        0.2,
        340,
        0,
        180
      }
    },
    [439] = {
      {
        951,
        1.25,
        0,
        1.7,
        -0.2,
        340,
        0,
        180
      }
    },
    [420] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.4,
        340,
        0,
        180
      }
    },
    [603] = {
      {
        951,
        1.25,
        0,
        -0.2,
        0.2,
        340,
        0,
        180
      }
    },
    [495] = {
      {
        951,
        1.25,
        0,
        0.4,
        0.5,
        340,
        0,
        180
      }
    },
    [423] = {
      {
        951,
        1.25,
        0,
        0.1,
        1.7,
        340,
        0,
        180
      }
    },
    [555] = {
      {
        951,
        1.25,
        0,
        -1.6,
        -0.3,
        340,
        0,
        180
      }
    },
    [596] = {
      {
        951,
        1.25,
        0,
        0.3,
        0.5,
        340,
        0,
        180
      }
    },
    [599] = {
      {
        951,
        1.25,
        0,
        -0.2,
        0.6,
        340,
        0,
        180
      }
    },
    [490] = {
      {
        951,
        1.25,
        0,
        0.8,
        0.6,
        340,
        0,
        180
      }
    },
    [589] = {
      {
        951,
        1.25,
        0,
        -1.2,
        0.6,
        340,
        0,
        180
      }
    },
    [480] = {
      {
        951,
        1.25,
        0,
        -1.3,
        -0.2,
        340,
        0,
        180
      }
    },
    [588] = {
      {
        951,
        1.25,
        0,
        2.1,
        3,
        340,
        0,
        180
      }
    },
    [451] = {
      {
        951,
        1.25,
        0,
        -0.3,
        0.1,
        340,
        0,
        180
      }
    },
    [587] = {
      {
        951,
        1.25,
        0,
        -0.3,
        0.2,
        340,
        0,
        180
      }
    },
    [416] = {
      {
        951,
        1.25,
        0,
        0.199,
        1.3,
        340,
        0,
        180
      }
    },
    [407] = {
      {
        951,
        1.25,
        0,
        0.5,
        0.8,
        340,
        0,
        180
      }
    },
    [404] = {
      {
        951,
        1.25,
        0,
        -1.2,
        0.5,
        340,
        0,
        180
      }
    },
    [402] = {
      {
        951,
        1.25,
        0,
        -0.2,
        0.3,
        340,
        0,
        180
      }
    },
    [580] = {
      {
        951,
        1.25,
        0,
        -0.2,
        0.5,
        340,
        0,
        180
      }
    },
    [579] = {
      {
        951,
        1.25,
        0,
        -1.1,
        0.7,
        340,
        0,
        180
      }
    },
    [482] = {
      {
        951,
        1.25,
        0,
        -1,
        0.6,
        340,
        0,
        180
      }
    },
    [573] = {
      {
        951,
        1.25,
        0,
        0.7,
        1.1,
        340,
        0,
        180
      }
    },
    [565] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.2,
        340,
        0,
        180
      }
    },
    [562] = {
      {
        951,
        1.25,
        0,
        -0.2,
        0.3,
        340,
        0,
        180
      }
    },
    [455] = {
      {
        951,
        1.25,
        0,
        1.4,
        1.2,
        340,
        0,
        180
      }
    },
    [561] = {
      {
        951,
        1.25,
        0,
        -0.1,
        0.3,
        340,
        0,
        180
      }
    },
    [560] = {
      {
        951,
        1.25,
        0,
        -0.1,
        0.3,
        340,
        0,
        180
      }
    },
    [559] = {
      {
        951,
        1.25,
        0,
        -0.1,
        0.2,
        340,
        0,
        180
      }
    },
    [470] = {
      {
        951,
        1.25,
        0,
        -0.1,
        0.6,
        340,
        0,
        180
      }
    },
    [558] = {
      {
        951,
        1.25,
        0,
        -0.1,
        0.4,
        340,
        0,
        180
      }
    },
    [444] = {
      {
        951,
        1.25,
        0,
        0.5,
        1.2,
        340,
        0,
        180
      }
    },
    [554] = {
      {
        951,
        1.25,
        0,
        0.3,
        0.5,
        340,
        0,
        180
      }
    },
    [545] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.2,
        340,
        0,
        180
      }
    },
    [542] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.3,
        340,
        0,
        180
      }
    },
    [541] = {
      {
        951,
        1.25,
        0,
        -0.2,
        0.1,
        340,
        0,
        180
      }
    },
    [533] = {
      {
        951,
        1.25,
        0,
        -1.4,
        -0.2,
        340,
        0,
        180
      }
    },
    [539] = {
      {
        951,
        1.25,
        0,
        -0.1,
        0.2,
        340,
        0,
        180
      }
    },
    [535] = {
      {
        951,
        1.25,
        0,
        0.1,
        0.3,
        340,
        0,
        180
      }
    },
    [531] = {
      {
        951,
        1.25,
        0,
        1.2,
        0,
        340,
        0,
        180
      }
    },
    [429] = {
      {
        951,
        1.25,
        0,
        1.399,
        -0.2,
        340,
        0,
        180
      }
    },
    [528] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.6,
        340,
        0,
        180
      }
    },
    [427] = {
      {
        951,
        1.25,
        0,
        0.3,
        1.2,
        340,
        0,
        180
      }
    },
    [428] = {
      {
        951,
        1.25,
        0,
        -0.6,
        1.1,
        340,
        0,
        180
      }
    },
    [525] = {
      {
        951,
        1.25,
        0,
        0.5,
        0.9,
        340,
        0,
        180
      }
    },
    [514] = {
      {
        951,
        1.25,
        0,
        0.6,
        1,
        340,
        0,
        180
      }
    },
    [508] = {
      {
        951,
        1.25,
        0,
        0.7,
        1.2,
        340,
        0,
        180
      }
    },
    [506] = {
      {
        951,
        1.25,
        0,
        1.6,
        -0.2,
        340,
        0,
        180
      }
    },
    [494] = {
      {
        951,
        1.25,
        0,
        -0.3,
        0.2,
        340,
        0,
        180
      }
    },
    [483] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.5,
        340,
        0,
        180
      }
    },
    [479] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.5,
        340,
        0,
        180
      }
    },
    [571] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.5,
        340,
        0,
        180
      }
    },
    [478] = {
      {
        951,
        1.25,
        0,
        0.2,
        0.5,
        340,
        0,
        180
      }
    },
    [431] = {
      {
        951,
        3,
        0,
        3.699,
        1.1,
        340,
        0,
        180
      }
    },
    [471] = {
      {
        951,
        1,
        0,
        -0.8,
        0.9,
        340,
        0,
        180
      }
    },
    [443] = {
      {
        951,
        1.25,
        0,
        1.8,
        1.3,
        340,
        0,
        180
      }
    },
    [583] = {
      {
        951,
        1.25,
        0,
        -0.6,
        1,
        340,
        0,
        180
      }
    },
    [411] = {
      {
        951,
        1.25,
        0,
        0.1,
        0.2,
        340,
        0,
        180
      }
    },
    [400] = {
      {
        951,
        1.25,
        0,
        -0.4,
        0.265,
        340,
        0,
        180
      }
    },
    [403] = {
      {
        951,
        1.25,
        0,
        -0.4,
        1.579,
        340,
        0,
        180
      }
    },
    [405] = {
      {
        951,
        1.25,
        0,
        -0.5,
        0.209,
        340,
        0,
        180
      }
    },
    [406] = {
      {
        951,
        4,
        0,
        4.1,
        0.667,
        340,
        0,
        180
      }
    },
    [408] = {
      {
        951,
        1.25,
        0,
        1.7,
        1.481,
        340,
        0,
        180
      }
    },
    [409] = {
      {
        951,
        1.25,
        0,
        0.6,
        0.319,
        340,
        0,
        180
      }
    },
    [410] = {
      {
        951,
        1.25,
        0,
        0,
        0.376,
        340,
        0,
        180
      }
    },
    [412] = {
      {
        951,
        1.25,
        0,
        -0.4,
        0.131,
        340,
        0,
        180
      }
    },
    [413] = {
      {
        951,
        1.25,
        0,
        0.2,
        0.595,
        340,
        0,
        180
      }
    },
    [414] = {
      {
        951,
        1.25,
        0,
        0.7,
        1.869,
        340,
        0,
        180
      }
    },
    [418] = {
      {
        951,
        1.25,
        0,
        0.7,
        0.534,
        340,
        0,
        180
      }
    },
    [419] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.2,
        340,
        0,
        180
      }
    },
    [421] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.123,
        340,
        0,
        180
      }
    },
    [422] = {
      {
        951,
        1.25,
        0,
        0.3,
        0.275,
        340,
        0,
        180
      }
    },
    [424] = {
      {
        951,
        1.25,
        0,
        -1,
        0.036,
        340,
        0,
        180
      }
    },
    [426] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.373,
        340,
        0,
        180
      }
    },
    [433] = {
      {
        951,
        2,
        0,
        1.7,
        1,
        340,
        0,
        180
      }
    },
    [434] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.266,
        340,
        0,
        180
      }
    },
    [436] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.352,
        340,
        0,
        180
      }
    },
    [437] = {
      {
        951,
        3,
        0,
        2.4,
        0.856,
        340,
        0,
        180
      }
    },
    [438] = {
      {
        951,
        1.25,
        0,
        -0.4,
        0.226,
        340,
        0,
        180
      }
    },
    [439] = {
      {
        951,
        1.25,
        0,
        -0.4,
        0.268,
        340,
        0,
        180
      }
    },
    [440] = {
      {
        951,
        1.25,
        0,
        0,
        0.722,
        340,
        0,
        180
      }
    },
    [456] = {
      {
        951,
        2,
        0,
        0,
        1.658,
        340,
        0,
        180
      }
    },
    [457] = {
      {
        951,
        1.25,
        0,
        -1.1,
        0.912,
        340,
        0,
        180
      }
    },
    [458] = {
      {
        951,
        1.25,
        0,
        -1.1,
        0.247,
        340,
        0,
        180
      }
    },
    [459] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.667,
        340,
        0,
        180
      }
    },
    [466] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.343,
        340,
        0,
        180
      }
    },
    [467] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.287,
        340,
        0,
        180
      }
    },
    [475] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.162,
        340,
        0,
        180
      }
    },
    [489] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.67,
        340,
        0,
        180
      }
    },
    [490] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.557,
        340,
        0,
        180
      }
    },
    [491] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.202,
        340,
        0,
        180
      }
    },
    [492] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.346,
        340,
        0,
        180
      }
    },
    [499] = {
      {
        951,
        1.25,
        0,
        -0.3,
        1.43,
        340,
        0,
        180
      }
    },
    [500] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.529,
        340,
        0,
        180
      }
    },
    [502] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.29,
        340,
        0,
        180
      }
    },
    [503] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.316,
        340,
        0,
        180
      }
    },
    [507] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.261,
        340,
        0,
        180
      }
    },
    [515] = {
      {
        951,
        2,
        0,
        0.4,
        0.794,
        340,
        0,
        180
      }
    },
    [516] = {
      {
        951,
        1.25,
        0,
        -1,
        0.413,
        340,
        0,
        180
      }
    },
    [517] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.373,
        340,
        0,
        180
      }
    },
    [518] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.297,
        340,
        0,
        180
      }
    },
    [524] = {
      {
        951,
        2,
        0,
        2,
        0.102,
        340,
        0,
        180
      }
    },
    [526] = {
      {
        951,
        1.25,
        0,
        -0.1,
        0.191,
        340,
        0,
        180
      }
    },
    [529] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.464,
        340,
        0,
        180
      }
    },
    [534] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.12,
        340,
        0,
        180
      }
    },
    [540] = {
      {
        951,
        1.25,
        0,
        -0.9,
        0.197,
        340,
        0,
        180
      }
    },
    [543] = {
      {
        951,
        1.25,
        0,
        0.1,
        0.428,
        340,
        0,
        180
      }
    },
    [544] = {
      {
        951,
        1.25,
        0,
        2.9,
        0.908,
        340,
        0,
        180
      }
    },
    [546] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.353,
        340,
        0,
        180
      }
    },
    [547] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.382,
        340,
        0,
        180
      }
    },
    [549] = {
      {
        951,
        1.25,
        0,
        -0.2,
        0.236,
        340,
        0,
        180
      }
    },
    [551] = {
      {
        951,
        1.25,
        0,
        -0.6,
        0.45,
        340,
        0,
        180
      }
    },
    [552] = {
      {
        951,
        1.25,
        0,
        -0.3,
        1.25,
        340,
        0,
        180
      }
    },
    [566] = {
      {
        951,
        1.25,
        0,
        -0.7,
        0.308,
        340,
        0,
        180
      }
    },
    [567] = {
      {
        951,
        1.25,
        0,
        -1.6,
        -0.362,
        340,
        0,
        180
      }
    },
    [568] = {
      {
        951,
        1.25,
        0,
        -1,
        0.509,
        340,
        0,
        180
      }
    },
    [572] = {
      {
        951,
        1,
        0,
        -0.9,
        0.382,
        340,
        0,
        180
      }
    },
    [574] = {
      {
        951,
        1,
        0,
        -0.7,
        0.916,
        340,
        0,
        180
      }
    },
    [575] = {
      {
        951,
        1.25,
        0,
        -1.3,
        0.1,
        340,
        0,
        180
      }
    },
    [576] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.261,
        340,
        0,
        180
      }
    },
    [578] = {
      {
        951,
        2.5,
        0,
        3.6,
        0.412,
        340,
        0,
        180
      }
    },
    [582] = {
      {
        951,
        1.25,
        0,
        0.9,
        0.747,
        340,
        0,
        180
      }
    },
    [585] = {
      {
        951,
        1.25,
        0,
        -0.8,
        0.564,
        340,
        0,
        180
      }
    },
    [600] = {
      {
        951,
        1.25,
        0,
        -1.5,
        0.384,
        340,
        0,
        180
      }
    },
    [601] = {
      {
        951,
        1.25,
        0,
        -1.5,
        1.459,
        340,
        0,
        180
      }
    }
  }
}
for vehID, attachedObjects in pairs(weapons[1]) do
  weapons[8][vehID] = {}
  weapons[8][vehID][1] = {
    unpack(weapons[1][vehID][1])
  }
  weapons[8][vehID][2] = {
    unpack(weapons[1][vehID][1])
  }
  weapons[8][vehID][3] = {
    unpack(weapons[1][vehID][1])
  }
  weapons[8][vehID][2][5] = weapons[8][vehID][1][5] + weapons[8][vehID][1][2] * 0.3
  weapons[8][vehID][3][5] = weapons[8][vehID][1][5] + 2 * weapons[8][vehID][1][2] * 0.3
end
