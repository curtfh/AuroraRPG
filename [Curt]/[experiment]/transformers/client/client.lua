local sizeFactor = 10
local me = getLocalPlayer()

local g_AutoBots = {}		-- { ped = { cars = { {bone1,bone2} = {car=car,attached=bool}, ... }, occupied = bool }, ... }
local prevX, prevY, prevZ
local abs = math.abs
local deg = math.deg
local rad = math.rad
local pi = math.pi
local cos = math.cos
local sin = math.sin
local atan2 = math.atan2
local sqrt = math.sqrt
local floor = math.floor

local screenWidth, screenHeight = guiGetScreenSize()

local function scale(factor, baseX, baseY, baseZ, x, y, z)
	return baseX + factor*(x-baseX), baseY + factor*(y-baseY), baseZ + factor*(z-baseZ)
end

local function angleDiff(angle1, angle2)
	angle1, angle2 = angle1 % 360, angle2 % 360
	local smallest = math.min(angle1, angle2)
	local largest = math.max(angle1, angle2)
	return math.min(largest - smallest, smallest - (largest - 360))
end

local connections = {
	-- spine
	{ 2, 3, forward=true },
	{ 4, 5 },
	-- right arm
	{ 22, 23 },
	{ 23, 24 },
	-- left arm
	{ 32, 33 },
	{ 33, 34 },
	-- right leg
	{ 51, 52, forward=true },
	{ 52, 53, forward=true },
	-- left leg
	{ 41, 42, forward=true },
	{ 42, 43, forward=true }
}
local psadsa

function setAutoBots(autobots)
	g_AutoBots = autobots
	for ped,autobot in pairs(autobots) do
		psadsa = createAutoBot(ped, autobot.model, autobot.color1, autobot.color2)
		g_AutoBots[ped].occupied = autobot.occupied
	end
end

function setAnimsdsd (value)
	setPedAnimation ( psadsa, "fortnite", value )
	return psadsa
end 


function createAutoBot(parentPed, model, color1, color2, positions)
	g_AutoBots[parentPed] = { cars = {}, occupied = false }
	color1 = color1 or math.random(0, 126)
	color2 = color2 or color1
	for i,connection in ipairs(connections) do
		local vehicle = createVehicle(model, 0, 0, 3)
		if positions and positions[i] then
			setElementPosition(vehicle, unpack(positions[i]))
			if positions[i][4] then
				setElementRotation(vehicle, 0, 0, positions[i][4])
			end
		end
		setVehicleColor(vehicle, color1, color2, 0, 0)
		setVehicleFrozen(vehicle, true)
		setElementCollisionsEnabled(vehicle, false)
		setVehicleEngineState(vehicle, false)
		--setVehicleOverrideLights(vehicle, 2)
		g_AutoBots[parentPed].cars[connection] = { car = vehicle, attached = not positions or not positions[i] }
	end
	setElementAlpha(parentPed, 0)
	psadsa = parentPed
	return parentPed
end

function getCarData(car)
	for ped,autobot in pairs(g_AutoBots) do
		for connection,data in pairs(autobot.cars) do
			if data.car == car then
				return data, player
			end
		end
	end
	return false
end

function attachCar(car, data)
	if not data then
		data = getCarData(car)
		if not data then
			return
		end
	end
	data.attached = true
	setElementCollisionsEnabled(car, false)
	setVehicleFrozen(car, true)
end

function detachCar(car, data)
	if not data then
		data = getCarData(car)
		if not data then
			return
		end
	end
	data.attached = false
	setElementCollisionsEnabled(car, true)
	setVehicleFrozen(car, false)
end

function assembleAutoBot(parentPed)
	local autobot = g_AutoBots[parentPed]
	if not autobot then
		return false
	end
	local function moveCar(car, param, info)
		param = (param + 1) / 2
		local x, y, z, rX, rY, rZ = calculateCarPosition(info.ped, info.connection)
		setElementPosition(car, scale(param, info.startpos[1], info.startpos[2], info.startpos[3], x, y, z))
		setElementRotation(car, scale(param, info.startrot[1], info.startrot[2], info.startrot[3], rX, rY, rZ))
	end
	for connection,data in pairs(autobot.cars) do
		if not data.attached then
			setElementCollisionsEnabled(data.car, false)
			setVehicleFrozen(data.car, true)
			Animation.createAndPlay(data.car, { from = pi, to = 0, transform = cos, time = 2000, fn = moveCar, ped = parentPed, connection = connection, startpos = {getElementPosition(data.car)}, startrot = {getElementRotation(data.car)} }, attachCar)
		end
	end
	return true
end

function disintegrateAutoBot(parentPed)
	local autobot = g_AutoBots[parentPed]
	if not autobot then
		return false
	end
	for connection,data in pairs(autobot.cars) do
		detachCar(data.car, data)
	end
	return true
end

function warpPlayerIntoAutoBot(player, parentPed)
	local autobot = g_AutoBots[parentPed]
	if not autobot then
		return false
	end
	if player == me then
		setElementPosition(me, getElementPosition(parentPed))
		enteredBot = true
		setPedRotation(me, getPedRotation(parentPed))
		setMouseLook(me, 2*sizeFactor, 4*sizeFactor)
		setGameSpeed(0.6)
	end
	setElementAlpha(player, 0) --DEBUG make 0
	g_AutoBots[parentPed] = nil
	g_AutoBots[player] = autobot
	autobot.occupied = true
	return true
end

function removePlayerFromAutoBot(player, newParentPed)
	local autobot = g_AutoBots[player]
	if not autobot then
		return false
	end
	if player == me then
		local x, y, z = getElementPosition(me)
		local angle = getPedRotation(me)
		x, y = x + 5*cos(rad(angle)), y + 5*sin(rad(angle))
		local hit, hitX, hitY, hitZ = processLineOfSight(x, y, z + 5, x, y, z - 10)
		if hit then
			z = hitZ + 2
		end
		setElementPosition(me, x, y, z)
		setMouseLook(false)
		setGameSpeed(1)
		setCameraTarget(me)
	end
	setElementAlpha(newParentPed, 0)
	setElementAlpha(player, 255)
	g_AutoBots[player] = nil
	g_AutoBots[newParentPed] = autobot
	autobot.occupied = false
	return true
end

function blowAutoBot(parentPed)
	local autobot = g_AutoBots[parentPed]
	if not autobot then
		return false
	end
	
	local cars = {}
	for connection,data in pairs(autobot.cars) do
		table.insert(cars, data.car)
	end
	local time = 0
	local function blow(car)
		detachCar(car)
		blowVehicle(car)
	end
	for i=1,#cars do
		local car = table.remove(cars, math.random(1, #cars))
		if time == 0 then
			blow(car)
		else
			setTimer(blow, time, 1, car)
		end
		time = time + math.random(100, 500)
	end
	return true
end

function destroyAutoBot(parentPed)
	if not g_AutoBots[parentPed] then
		return false
	end
	for _,data in pairs(g_AutoBots[parentPed].cars) do
		destroyElement(data.car)
	end
	g_AutoBots[parentPed] = nil
	return true
end

local function testForwardCollision(x, y, z, angle)
	for h=-floor(sizeFactor/3),floor(sizeFactor/3) do
		for v=2,floor(sizeFactor*(isPedDucked(me) and 0.6 or 1.5)) do
			local startX, startY, startZ = x + h*cos(rad(angle)), y + h*sin(rad(angle)), z + v
			if processLineOfSight(startX, startY, startZ, startX + sizeFactor/5*cos(rad(angle+90)), startY + sizeFactor/5*sin(rad(angle+90)), startZ, true, true, false) then
				return true
			end
		end
	end
	return false
end

function calculateCarPosition(ped, connection)
	local offsetY, offsetZ = 0, 0
	if isElementInWater(ped) then
		offsetZ = -sizeFactor
	end
	
	local baseX, baseY, baseZ = getElementPosition(ped)
	baseZ = baseZ - getElementDistanceFromCentreOfMassToBaseOfModel(ped)
	local pedRZ = getPedRotation(ped)
	
	local x1, y1, z1 = scale(sizeFactor, baseX, baseY, baseZ, getPedBonePosition(ped, connection[1]))
	z1 = z1 - 1.3
	local x2, y2, z2 = scale(sizeFactor, baseX, baseY, baseZ, getPedBonePosition(ped, connection[2]))
	z2 = z2 - 1.3
	local x, y, z = x1 + (x2 - x1)/2, y1 + (y2 - y1)/2 + offsetY*sin(rad(pedRZ+90)), z1 + (z2 - z1)/2 + offsetZ
	
	local partRX = deg(atan2(z2 - z1, sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))))
	local partRZ = deg(atan2(-(x2-x1), y2-y1))
	if connection.forward then
		if angleDiff(partRZ, pedRZ) >= 90 then
			partRX = partRX - 2*(partRX-270)
			partRZ = partRZ + 180
		end
		if abs((partRX % 360) - 90) < 10 or abs((partRX % 360) - 270) < 10 then
			partRZ = pedRZ
		end
	end
	
	return x, y, z, partRX, 0, partRZ
end

function onRender()
	for ped,autobot in pairs(g_AutoBots) do
		setElementHealth(ped, 100)
		-- place cars
		for connection,data in pairs(autobot.cars) do
			if data.attached then
				local x, y, z, rX, rY, rZ = calculateCarPosition(ped, connection)
				setElementPosition(data.car, x, y, z)
				setElementRotation(data.car, rX, rY, rZ)
			end
		end
	end
	
	if g_AutoBots[me] then
		-- local player movement (adjust walking pace and check for obstacles)
		local x, y, z = getElementPosition(me)
		local angle = getPedRotation(me)
		if getPedTask(me, 'primary', 0) ~= 'TASK_SIMPLE_FALL' and prevX then
			if testForwardCollision(x, y, z, angle) then
				x, y, z = prevX, prevY, prevZ
			else
				if not isElementInWater(me) then
					x, y, z = scale(sizeFactor, prevX, prevY, prevZ, x, y, z)
				else
					x, y = scale(sizeFactor, prevX, prevY, prevZ, x, y, z)
				end
				local hit, tempX, tempY, tempZ
				hit, tempX, tempY, tempZ = processLineOfSight(x, y, z + 3, x, y, z - 3, true, true, false)
				if hit then
					z = tempZ + getElementDistanceFromCentreOfMassToBaseOfModel(me)
				end
			end

			if ( isPedDoingTask ( getLocalPlayer(), "TASK_SIMPLE_CLIMB" ) ) and ( climbStarted ~= true ) then
				climbStarted = true
			elseif not ( isPedDoingTask ( getLocalPlayer(), "TASK_SIMPLE_CLIMB" ) ) and ( climbStarted == true ) then
				climbStarted = false
				x, y, z = getElementPosition ( getLocalPlayer() ) --x,y,z is otherwise the bot which causes conflict as ped can't rip away from climb
			end
			
			if not ( isPedDoingTask ( getLocalPlayer(), "TASK_SIMPLE_CLIMB" ) ) then
				if enteredBot then --If a player gets out of 1 transformer and enters another, the bot position is screwed, user player position once.
					x, y, z = getElementPosition ( getLocalPlayer() )
					enteredBot = false
				end
				
				local vx, vy, vz = getElementVelocity ( getLocalPlayer() )
			
				if ( isPedDoingTask ( getLocalPlayer(), "TASK_SIMPLE_IN_AIR" ) ) then
					if ( jumping ~= true ) then
						-- outputChatBox ( "jump now" )
							
						local vx, vy, vz = getElementVelocity ( getLocalPlayer() )
						if getControlState ( "jump" ) == true then --super jump
							setGravity ( 0.0001 )
							setElementVelocity ( getLocalPlayer(), vx, vy, vz+10 )							
							-- outputChatBox ( "super" )
						else --normal jump
							setGravity ( 0.006 )
							setElementVelocity ( getLocalPlayer(), vx, vy, 10 )
							setTimer ( setElementVelocity, 250, 1, getLocalPlayer(), vx, vy, 0.01 )
							-- outputChatBox ( "normal" )
						end
						setGameSpeed ( 0.5 )
						jumping = true
					end
					
					--Below sets default gravity if bot flies too far from ground (didn't cling to a ledge)
					-- outputChatBox ( "jumping? "..tostring(jumping).." falling? "..tostring(falling) )
					if (jumping == true) and ( falling ~= true ) then
						local px, py, pz = getElementPosition ( getLocalPlayer() )
						local gz = getGroundPosition ( px, py, pz )
						if ( pz > gz + 25 ) then
							-- outputChatBox ( "fall now (pz > gz + 25)" )
							setGravity ( 0.008 )
							falling = true
						elseif vz <= 0 then
							-- outputChatBox ( "fall now (vz <= 0)" )
							setGravity ( 0.008 )
							falling = true 							
						end
					end
				end
				
				if ( vz <= 0.00001 ) and ( vz >= -0.00001 ) and ( falling == true ) and ( jumping == true ) then
					-- outputChatBox ( "reset stuff" )
					jumping = false
					falling = false
					setGravity ( 0.008 )
					setGameSpeed ( 0.6 )
				end	

				setElementPosition(me, x, y, z, false)  --xyz is bot scaled unless I modified it above with getElementPosition ( getLocalPlayer() )
			else
				if not gameSpeedTimer then --climb faster over stuff
					-- outputChatBox ( "climb fast" )
					setGameSpeed ( 1 ) --Inside cause this is client render
					gameSpeedTimer = setTimer ( function()
						setGameSpeed ( 0.6 )
						gameSpeedTimer = nil
					end, 1500, 1)
				end
			end
		end
		prevX, prevY, prevZ = x, y, z
	end
	
	-- dxDrawText ( "Gravity = "..tostring(getGravity()), 400, 600 )  
	-- dxDrawText ( "Game Speed = "..tostring(getGameSpeed()), 400, 615 )  
	-- dxDrawText ( "VelocityZ = "..tostring(vz), 400, 630 ) 
	-- dxDrawText ( "jumping = "..tostring(jumping), 400, 645 ) 
	-- dxDrawText ( "falling = "..tostring(falling), 400, 660 ) 
end

addEventHandler('onClientResourceStop', getResourceRootElement(getThisResource()),
	function()
		--for i,player in ipairs(getElementsByType('player')) do
			--setElementAlpha(player, 255)
		--end
		--setMouseLook(false)
		--se-tCameraTarget(me)
		--toggleAllControls(true)
		--setGameSpeed(1)
	end
)

function collisionlessPed ()
	setElementCollisionsEnabled ( source, false )
end
addEvent( "client_collisionlessPed", true )
addEventHandler( "client_collisionlessPed", root, collisionlessPed )

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function escapeMe ( commandName, taskType )
	local x, y, z = getElementPosition ( getLocalPlayer() )
	setElementPosition ( getLocalPlayer(), x+(math.random(-10,10)), y+(math.random(-10,10)), z+(math.random(1,15)) )
end    
addCommandHandler ( "escape", escapeMe )

function helpMessage ()
	--dxDrawText ( "Hold JUMP for superjump.\n Use /escape if you get stuck!", 0, 0, sx, sy, tocolor(236,94,237), 4, "default", "center", "center" )
	--dxDrawText ( "\n\n\n\n\n\nCreated by arc_\n Poor code modifications by Ransom :P\nPress F9 to see instructions again", 0, 0, sx, sy, tocolor(45,63,243), 4, "default", "center", "center" )
end



addEventHandler('onClientResourceStart', getResourceRootElement(getThisResource()),
	function()
		triggerServerEvent('onLoadedAtClient', me)
		addEventHandler('onClientRender', root, onRender)
			
		--Start client script-----------------
		setGravity ( 0.008 ) -- Normal gravity
		setGameSpeed ( 1 ) -- Normal speed
		sx,sy = guiGetScreenSize ()
		sy = sy * 0.8

		addEventHandler('onClientRender', root, helpMessage )

		setTimer ( function()
			removeEventHandler ( 'onClientRender', root, helpMessage )
		end, 5000, 1 )
		--------------------------------------		
	end
)