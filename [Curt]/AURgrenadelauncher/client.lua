-- CONFIGURATION VARIABLES FOR YOU TO EDIT
local teamLock = true -- True locks the launcher to the teams listed below, false allows everyone to use it
local teams = {"Staff", "Military Forces", "Government", "Criminals", "Bloods", "SWAT Team"} -- These are the teams that will be allowed to use the grenade launcher if you activate teamlock
local guns = {30, 31} -- These are the guns that have grenade launcher function, I suggest not using any melee shit ;)
local nadeModel = nil -- You can change this to an object ID to change the grenade model with that model. nil is the normal grenade model.
local launchV = 0.8 -- This is the velocity at which the grenade will leave the player, relative to the player.
local inheritMomentum = true -- Should the grenade inherit the momentum of the firing player? Do not touch this if you don't know what I mean.
local consumeNades = true -- True for the launcher to consume player's grenade ammo, false for the launcher to shoot infinite nades.
local fireKey = "e" -- The key binding that should fire the grenade
local explodeOnContact = true -- Should the grenade explode on contact or should it wait for its normal explosion time? Normal is a bit less straining.
local contactThreshold = 0.1 -- The change in velocity, past which, the grenade will be considered in contact and blown up. Do not touch this if you don't know what I mean.
local reloadTime = 8 -- Time after the reload starts until the reload is completed, in seconds
local debugMode = false -- A display in the middle of the screen that shows you change in velocity in each frame. Enable for debugging use only.
-- END OF CONFIGURATION VARIABLES

-- DO NOT TOUCH THESE, initializing variables
local reloaded = true
local reloadstarted = false
local bombs = {}
local differences = {} -- This is for debugging purposes

-- We invert the teams and guns thingies here for faster access later
local allowedTeams = {}
for i,v in ipairs(teams) do
	allowedTeams[v] = true
end
local allowedGuns = {}
for i,v in ipairs(guns) do
	allowedGuns[v] = true
end

-- Derived Aiming Check Function, credits to the 2012-Funstein (Thanks, my past self!)
function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

-- Function that checks whether the player should be able to fire or not.
function canHeFire(player)
	if not isPedAiming(player) then return false end
	if isPlayerDead(player) or isPedInVehicle(player) then return false end
	if teamLock and not (getPlayerTeam(player) and allowedTeams[getTeamName(getPlayerTeam(player))]) then return false end
	if consumeNades and not ((getPedWeapon(player, 8) == 16) and (getPedTotalAmmo(player, 8) > 8)) then return false end
	if not (getPedWeapon(player) and allowedGuns[getPedWeapon(player)]) then return false end
	if (getTeamName(getPlayerTeam(player)) ~= "Staff" and getElementDimension(player) ~= 0) then return false end
	if (getTeamName(getPlayerTeam(player)) ~= "Staff" and getElementInterior(player) ~= 0) then return false end
	if (getTeamName(getPlayerTeam(player)) ~= "Staff" and getElementData(player, "isPlayerProtected") == true) then return false end
	--if (getTeamName(getPlayerTeam(player)) ~= "Staff" and getElementData(player, "AURdeathmatch.value") == false) then return false end
	return true
end

-- This is the actual firing function
function fireNade()
	if canHeFire(localPlayer) then
		if not reloadStarted then
			if reloaded then
				-- Get position of weapon muzzle and target
				local mx, my, mz = getPedWeaponMuzzlePosition(localPlayer)
				local tx, ty, tz = getPedTargetCollision(localPlayer)
				if not (tx and ty and tz) then
					tx, ty, tz = getPedTargetEnd(localPlayer)
				end
				if mx and my and mz and tx and ty and tz then
					-- Calculate the launch velocity of the grenade
					local speed = getDistanceBetweenPoints3D(mx, my, mz, tx, ty, tz)
					local coef = launchV / speed
					local nx, ny, nz = (tx-mx) * coef, (ty-my) * coef, ((tz-mz)* coef) + 0.1
						
					-- Momentum inheritance is performed here
					if inheritMomentum then
						local pvx, pvy, pvz = getElementVelocity(localPlayer)
						nx, ny, nz = nx + pvx, ny + pvy, nz + pvz
					end
						
					-- Create the grenade!
					local nade = createProjectile(localPlayer, 16, mx, my, mz, 0, nil, 0, 0, 0, nx, ny, nz, nadeModel)
					if nade then
						-- Fixing some weird issue that happens for who knows what reason
						setElementVelocity(nade, nx, ny, nz)
						
						-- Inserting the projectile to the list of tracked projectiles
						if explodeOnContact then
							table.insert(bombs, {false, false, false, nade})
							addEventHandler("onClientElementDestroy", nade, function() unlistBomb(source) end)
						end
							
						-- Reduce ammo and require player to reload
						if consumeNades then triggerServerEvent("glauncher.fired", localPlayer) end
						reloaded = false
					end
				end
			else
				exports.NGCdxmsg:createNewDxMessage("You need to reload before firing another round!", 255, 0, 0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("You can't fire while reloading!", 255, 0, 0)
		end
	end
end
bindKey(fireKey, "down", fireNade)

-- The function that checks velocity differences for contact-explosion
function trackBombs()
	if debugMode then
		for i,v in ipairs(differences) do
			local textHeight = dxGetFontHeight()
			dxDrawText(v, 500, 500 + ((i - 1) * (textHeight + 2)), 500, 500 + (i * (textHeight + 2)))
		end
	end
	
	for i,v in ipairs(bombs) do
		local bomb = v[4]
		if isElement(bomb) then
			-- Compare previous and current velocities of the bomb
			local vx, vy, vz = getElementVelocity(bomb)
			local ox, oy, oz = unpack(v)
			local diff = 0
			if ox and oy and oz then
				diff = math.abs(getDistanceBetweenPoints3D(vx, vy, vz, ox, oy, oz))
			end
			
			-- DEBUGGER
			if debugMode then
				table.insert(differences, diff)
				while #differences > 10 do
					table.remove(differences, 1)
				end
			end
			-- END OF DEBUGGER
			
			if diff > contactThreshold or isElementInWater(bomb) then
				-- Detonate bomb if change in velocity is over the threshold
				setElementVelocity(bomb, 0, 0, 0)
				destroyElement(bomb)
				if debugmode then table.insert(differences, "-----KABOOM!-----") end
			else
				-- Store the current velocity of the bomb
				bombs[i] = {vx, vy, vz, bomb}
			end
		else
			-- Remove bomb from list if it exists no more
			unlistBomb(v)
		end
	end
end
if explodeOnContact then addEventHandler("onClientRender", root, trackBombs) end

function unlistBomb(bomb)
	for i,v in ipairs(bombs) do
		if v == bomb then
			table.remove(bombs, i)
			return
		end
	end
end

function endReload()
	if reloadStarted then
		reloaded = true
		reloadStarted = false
	end
end
addEventHandler("onClientPlayerSpawn", localPlayer, endReload)

function beginReload()
	if (not reloadStarted) or (not isPedInVehicle(localPlayer)) then
		reloadStarted = true
		setTimer(function() endReload() end, reloadTime * 1000, 1)
	end
end
addCommandHandler("reload",beginReload)
bindKey("r","down",beginReload)

fileDelete("client.lua")