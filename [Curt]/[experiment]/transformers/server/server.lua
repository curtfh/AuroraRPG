g_AutoBots = {}		-- { ped = {occupied = bool, model=model, color1=color1, color2=color2} }

function createAutoBot(model, x, y, z, angle, color1, color2, positions)
	local ped = createPed(167, x, y, z, angle)
	triggerClientEvent ( "client_collisionlessPed", ped )
	-- if not ped then
		-- return false
	-- end
	color1 = color1 or math.random(0, 126)
	color2 = color2 or color1
	g_AutoBots[ped] = { occupied = false, model = model, color1 = color1, color2 = color2 }
	clientCall(root, 'createAutoBot', ped, model, color1, color2, positions)
	return ped
end

function destroyAutoBot(parentPed)
	if not g_AutoBots[parentPed] then
		return false
	end
	clientCall(root, 'destroyAutoBot', parentPed)
	if not g_AutoBots[parentPed].occupied then
		destroyElement(parentPed)
	end
	g_AutoBots[parentPed] = nil
	return true
end

function warpPlayerIntoAutoBot(player, parentPed)
	local autobot = g_AutoBots[parentPed]
	if not autobot then
		return false
	end
	if autobot.occupied then
		parentPed = removePlayerFromAutoBot(parentPed)
	end
	clientCall(root, 'warpPlayerIntoAutoBot', player, parentPed)
	destroyElement(parentPed)
	g_AutoBots[parentPed] = nil
	g_AutoBots[player] = autobot
	autobot.occupied = true
	return true
end

function removePlayerFromAutoBot(player)
	local autobot = g_AutoBots[player]
	if not autobot then
		return false
	end
	local x, y, z = getElementPosition(player)
	local angle = getPedRotation(player)
	local parentPed = createPed(167, x, y, z)
	triggerClientEvent ( "client_collisionlessPed", parentPed )
	setPedRotation(parentPed, angle)
	clientCall(root, 'removePlayerFromAutoBot', player, parentPed)
	g_AutoBots[player] = nil
	g_AutoBots[parentPed] = autobot
	autobot.occupied = false
	return parentPed
end

addCommandHandler('blow',
	function(player)
		clientCall(root, 'blowAutoBot', next(g_AutoBots))
	end
)

addEventHandler('onResourceStart', getResourceRootElement(getThisResource()),
	function()
 --, 0, 126, false, { {1, 0, 3, 10}, {5, 3, 3, 82}, {-4, -3, 3, 35}, {10, 8, 3, 200}, {5, -6, 3, 352}, {-9, 2, 3, 184}, {18, -15, 3, 140}, {-20, -18, 3, 80}, {19, 8, 3, 10}, {-20, -25, 3, 250} })  
		players = getElementsByType ( "player" )
		local autoBotSpotting = -1856.63
		local vehicleIDS = { 
		555 }

		for k=1,1 do
			if k <= 1 then --Spawn a max of 6 transformers. Increment as needed with playercount.
				createAutoBot(vehicleIDS[math.random(1,#vehicleIDS)], 569.74, autoBotSpotting, 12.29, 180)
				autoBotSpotting = autoBotSpotting + 12	
			end
		end

		
		-- setTimer(clientCall, 5000, 1, root, 'assembleAutoBot', ped)
		-- setTimer(clientCall, 8000, 1, root, 'setPedAnimation', ped, 'dancing', 'dnce_m_a')
		-- setTimer(clientCall, 12000, 1, root, 'setPedAnimation', ped, 'dancing', 'DAN_Up_A')
		-- setTimer(clientCall, 14000, 1, root, 'setPedAnimation', ped, 'dancing', 'DAN_Right_A')
		-- setTimer(clientCall, 16000, 1, root, 'setPedAnimation', ped, 'dancing', 'DAN_Left_A')
		-- setTimer(clientCall, 18000, 1, root, 'blowAutoBot', ped)
	end
)

function joinHandler(player)
	local playerJoined = not player
	player = player or source
	setTimer ( farmSpawn, 1000, 1, source )

	bindKey(player, 'enter_exit', 'down', enterExitKey)
	if playerJoined then
		clientCall(player, 'setAutoBots', g_AutoBots)
	end
end
addEventHandler('onPlayerJoin', root, joinHandler)

function enterExitKey(player)
	if g_AutoBots[player] then
		-- player is in an autobot; make him get out
		removePlayerFromAutoBot(player)
	else
		-- not in an autobot. look for autobots in the vicinity
		local px, py, pz = getElementPosition(player)
		for ped,autobot in pairs(g_AutoBots) do
			if not autobot.occupied then
				if getDistanceBetweenPoints3D(px, py, pz, getElementPosition(ped)) < 10 then
					warpPlayerIntoAutoBot(player, ped)
					break
				end
			end
		end
	end
end

addEventHandler('onResourceStop', getResourceRootElement(getThisResource()),
	function()	
		setGravity ( 0.008 ) -- Normal gravity
		setGameSpeed ( 1 ) -- Normal speed
	end
)