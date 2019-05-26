local bombKey = "k"
local bombCommand = "bombdrop"
local allowByIDs = true --Set if allow by ids. False = only (all) planes. true = Everything listed in 'allowedIDs' table. REMEMBER TO SET THIS VARIABLE IN SERVERSIDE TOO!
local allowedIDs = {520,476} --Remember to keep this table matching in serverside

local tick

local function check()

	if not localPlayer.vehicle then return false end
	if localPlayer.vehicle.controller ~= localPlayer then return false end
	if localPlayer.vehicle.vehicleType ~= "Plane" and allowByIDs == false then return end
	
	if allowByIDs then
		local isAllowed = false
		for _,allowedID in ipairs(allowedIDs) do
			if localPlayer.vehicle.model == allowedID then
				isAllowed = true
			end
		end
		if not isAllowed then
			return false
		end
	end
	
	if not tick then
		tick = getTickCount()
	else
		local currentTick = getTickCount()
		if (currentTick - tick) < 10000 then
			local seconds = tostring(math.floor(20-(currentTick-tick)/1000))
			outputChatBox("You have to wait "..seconds.. " seconds to drop a new bomb!",255,0,0)
			return false
		else
			tick = getTickCount()
		end
	end
	
	return localPlayer.vehicle

end

local function dropBomb()

	local vehicle = check()
	if not vehicle then return end
	
	local vx,vy,vz = getElementPosition(vehicle)
	local hit,hx,hy,hz = processLineOfSight(vx,vy,vz,vx,vy,-100,true,true,true,true,false,true,true,true,vehicle,false,true)
	
	if hit then
		local dist = vz-hz
		triggerServerEvent("onPlayerDropAirplaneBomb",localPlayer,vx,vy,vz-2,hz,dist)
	else
		outputChatBox("You are too high!",255,0,0)
	end

end

local function initScript()

	bindKey(bombKey,"down",dropBomb)
	addCommandHandler(bombCommand,dropBomb,false)

end

addEventHandler("onClientResourceStart",resourceRoot,initScript)