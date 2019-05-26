local element = { 
	theVehicle = {
		vehicle_1 = {},
		vehicle_2 = {},
		vehicle_3 = {},
	},
	latest = {
		spawn = {},
		warp = {}, 
		warp_base = {}, 
		spawnPlane = {},
		jetpack = {},
		skin = {},
		nitro = {},
		heal = {},
		advert = {},
		fix = {},
		music = {},
		musicvip = {}
	}, 
	timer = {
		timer_1 = {},
		timer_2 = {}, 
		timer_3 = {},
	},
	attached = {},
	hats = {},
	bombEnabled = {},
	contact = {},
	helpRequested = {},
	hatObjects = {},
	enabled = {},
	prevSkin = {}, --Skin
	newSkin = {}, --Skin (Need to be packed into skin childs)
	wenabled = {},
	glued = {},
	ghosted = {},
	colordata = {},
	cig = {},
	drink = {},
	music = {},
}

local enabledvchat = {}

--[[for k, v in pairs(getElementsByType("player")) do
	element.prevSkin[v] = { getElementModel(v) }
	outputDebugString(tostring(getElementModel(v)).." : "..element.prevSkin[v][1])
end]]

addEventHandler("onPlayerLogin", root,
	function ( )
		element.prevSkin[source] = { getElementModel(source) }
	end
)

local styles = {
	{0},{54},{55},{56},{57},{58},{59},{60},{61},{62},{63},{64},{65},{66},{67},{68},{69},{70},{118},{119},{120},{121},{122},{123},{124},{125},{126},{127},{128},{129},{130},{131},{132},{133},{134},{135},{136},{137},{138},
}

local warpLocations = {
	[1] = {1968.7709960938, -2180.9633789063, 13.546875}; --Airport
	[2] = {1177.9201660156, -1323.8095703125, 14.094498634338}; --Hospital
	[3] = {1545.0682373047, -1675.6929931641, 13.559639930725}; --LSPD
	[4] = {1464.4149169922, -1022.4301757813, 23.828125}; --LS Bank
	[5] = {2674.8908691406, -2414.181640625, 13.6328125}; --LS DS
	[6] = {1719.2785644531, 1589.8266601563, 10.347032546997}; --LV Airport
	[7] = {1602.5057373047, 1818.5699462891, 10.8203125}; --LV Hospital
	[8] = {2184.58984375, 1677.15234375, 11.086436271667}; --LV Casino
	[9] = {419.15246582031, 2531.1787109375, 16.607799530029}; --LV Airstrip
	[10] = {-1555.6568603516, -430.41131591797, 6.0867533683777}; --SF Airport
}

--obj, rotx, roty, rotz = 3053, 0, 180, 0

local obj = {}

for k, v in pairs(warpLocations) do
	obj[k] = createObject(3053, v[1], v[2], v[3]-1.22)
	if (obj[k]) then
		setElementRotation(obj[k], 0, 180, 0)
	end
end

function server_actions(thePlayer, data, string, extraDat, extraDat2, extraDat3)
	if (thePlayer and isElement(thePlayer) and getElementType(thePlayer) == "player") then
		if (data and string) then
			local userData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID(thePlayer))
			if (data == "spawn_vip_car") then
				if (string == "aps") then
					element.theVehicle.vehicle_3[thePlayer] = {526}
				elseif (string == "vipo") then
					element.theVehicle.vehicle_3[thePlayer] = {526}
				elseif (string == "aps_infernus") then
					element.theVehicle.vehicle_3[thePlayer] = {411}
				elseif (string == "vip_plane") then
					element.theVehicle.vehicle_3[thePlayer] = {593}
				elseif (string == "vip_shamal") then
					element.theVehicle.vehicle_3[thePlayer] = {519}
				end
				if (exports.server:getPlayerWantedPoints(thePlayer) >= 10) then outputChatBox("You cannot spawn a vehicle whilst wanted!", thePlayer, 255, 0, 0) return end
				if (getElementDimension(thePlayer) ~= 0) then outputChatBox("You cannot spawn a vehicle in another dimension!", thePlayer, 255, 0, 0) return end
				if getElementData(thePlayer,"isPlayerJailed") then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while jailed!", 225, 0, 0)
					return
				end
				if getElementData(thePlayer,"DuelIndex",true) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature in duels", 225, 0, 0)
					return
				end		
				if getElementData(thePlayer,"isPlayerGlued",true) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while gluing",255,0,0)
					return
				end
				if not (isPedInVehicle(thePlayer)) then
					if (isElement(element.theVehicle.vehicle_1[thePlayer])) then destroyElement(element.theVehicle.vehicle_1[thePlayer]) end
					local x, y, z = getElementPosition(thePlayer)
					local rx, ry, rz = getElementRotation(thePlayer)
					if (element.theVehicle.vehicle_3[thePlayer]) then
						if (string == "aps") then
							if (exports.AURpoints:getAuroraPoints(thePlayer) <= 100) then
								exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase this vehicle!", thePlayer, 255, 0, 0)
								return
							end
							if (element.latest.spawn[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.spawn[getPlayerSerial(thePlayer)] < 600000 ) then outputChatBox("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
							element.latest.spawn[getPlayerSerial(thePlayer)] = getTickCount()
							local aps = exports.AURpoints:getAuroraPoints(thePlayer)
							exports.AURpoints:setPlayerAPS(thePlayer, aps-100)
							exports.NGCdxmsg:createNewDxMessage("You've successfully spawned an APS car with custom handling use /dprem to destroy! APS Charge: -100.", thePlayer, 0, 255, 0)
						elseif (string == "vipo") then
							if (element.latest.spawn[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.spawn[getPlayerSerial(thePlayer)] < 600000 ) then outputChatBox("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
							element.latest.spawn[getPlayerSerial(thePlayer)] = getTickCount()
							exports.NGCdxmsg:createNewDxMessage("You've successfully spawned a premium car with custom handling!", thePlayer, 0, 255, 0)
						elseif (string == "aps_infernus") then
							if (exports.AURpoints:getAuroraPoints(thePlayer) <= 300) then
								exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase this vehicle!", thePlayer, 255, 0, 0)
								return
							end
							if (element.latest.spawn[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.spawn[getPlayerSerial(thePlayer)] < 600000 ) then outputChatBox("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
							element.latest.spawn[getPlayerSerial(thePlayer)] = getTickCount()
							local aps = exports.AURpoints:getAuroraPoints(thePlayer)
							exports.AURpoints:setPlayerAPS(thePlayer, aps-300)
							exports.NGCdxmsg:createNewDxMessage("You've successfully spawned an APS infernus with custom handling use /dprem to destroy! APS Charge: -300.", thePlayer, 0, 255, 0)
						elseif (string == "vip_plane") then
							if (element.latest.spawnPlane[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.spawn[getPlayerSerial(thePlayer)] < 600000 ) then outputChatBox("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
							element.latest.spawnPlane[getPlayerSerial(thePlayer)] = getTickCount()
							exports.NGCdxmsg:createNewDxMessage("You've successfully spawned a premium standard plane!", thePlayer, 0, 255, 0)
						elseif (string == "vip_shamal") then
							if (element.latest.spawnPlane[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.spawn[getPlayerSerial(thePlayer)] < 600000 ) then outputChatBox("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
							element.latest.spawnPlane[getPlayerSerial(thePlayer)] = getTickCount()
							exports.NGCdxmsg:createNewDxMessage("You've successfully spawned a premium shamal!", thePlayer, 0, 255, 0)
						end
					else
						theVehicle.vehicle_1[thePlayer] = createVehicle(526, x, y, z, rx, ry, rz, "Premium")
					end
					element.theVehicle.vehicle_1[thePlayer] = createVehicle(element.theVehicle.vehicle_3[thePlayer][1], x, y, z, rx, ry, rz, "Premium")
					warpPedIntoVehicle(thePlayer, element.theVehicle.vehicle_1[thePlayer])
					setElementData(element.theVehicle.vehicle_1[thePlayer], "vehicleType", "VIPCar")
					setElementData(element.theVehicle.vehicle_1[thePlayer], "vehicleOwner", thePlayer)
					if (element and element.theVehicle.vehicle_3[thePlayer][1] == 411 or element.theVehicle.vehicle_3[thePlayer][1] == 526) then
						local handlingTable = getVehicleHandling (element.theVehicle.vehicle_1[thePlayer])
						local newVelocity = (handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40))
						setVehicleHandling (element.theVehicle.vehicle_1[thePlayer], "numberOfGears", 5)
						setVehicleHandling (element.theVehicle.vehicle_1[thePlayer], "driveType", 'awd')
						setVehicleHandling (element.theVehicle.vehicle_1[thePlayer], "maxVelocity", newVelocity)
						setVehicleHandling (element.theVehicle.vehicle_1[thePlayer], "engineAcceleration", handlingTable["engineAcceleration"] +8)
					end
				else
					exports.NGCdxmsg:createNewDxMessage("You cannot spawn a vehicle whilst already being in one!", thePlayer, 255, 0, 0)
					return
				end
			elseif (data == "misc") then
				if (string == "headless") then
					local type_ = "Premium"
					if (isPedHeadless(thePlayer)) then
						if (extraDat == "aps") then
							type_ = "APS"
						end
						setPedHeadless(thePlayer, false)
						exports.NGCdxmsg:createNewDxMessage(type_.." misc - You've got your head back, gratz.", thePlayer, 255, 255, 255, true)
					else
						if (extraDat == "aps") then
							if (exports.AURpoints:getAuroraPoints(thePlayer) <= 20) then
								exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase misc headless!", thePlayer, 255, 0, 0)
								return
							end
							type_ = "APS"
							local aps = exports.AURpoints:getAuroraPoints(thePlayer)
							exports.AURpoints:setPlayerAPS(thePlayer, aps-20)
						end
						setPedHeadless(thePlayer, true)
						exports.NGCdxmsg:createNewDxMessage(type_.." misc - You've set mode 'headless', re-click headless button to enable head!", thePlayer, 255, 255, 255, true)
					end
				elseif (string == "ondeathbomb") then
					if (not element.bombEnabled[thePlayer]) then
						exports.NGCdxmsg:createNewDxMessage("You've enabled on-death bomb, when you get killed a bomb will follow a painful revenge!", thePlayer, 0, 255, 0)
						element.bombEnabled[thePlayer] = true
					else
						exports.NGCdxmsg:createNewDxMessage("You've disabled the on-death bomb feature!", thePlayer, 255, 0, 0)
						element.bombEnabled[thePlayer] = false
					end
				elseif (string == "walkstyle") then
					local style = styles[math.random(#styles)]
					for k, v in pairs(style) do
						if (not element.wenabled[thePlayer]) then
							outputChatBox("You've changed your walkstyle to "..v, thePlayer, 0, 255, 0)
							setPedWalkingStyle(thePlayer, v)
							element.wenabled[thePlayer] = true
						else
							outputChatBox("You've reset your current walkstyle to 0!", thePlayer, 0, 255, 0)
							setPedWalkingStyle(thePlayer, 0)
							element.wenabled[thePlayer] = false
						end
					end
				elseif (string == "smoke") then
					enable_cig(thePlayer, string)
				elseif (string == "apssmoke") then
					enable_cig(thePlayer, string)
				elseif (string == "drink") then
					enable_drink(thePlayer, string)
				elseif (string == "apsdrink") then
					enable_drink(thePlayer, string)
				elseif (string == "fasttravel") then
					if (element.latest.warp[getPlayerSerial(thePlayer)]) and (getTickCount()-element.latest.warp[getPlayerSerial(thePlayer)] < 600000) then exports.NGCdxmsg:createNewDxMessage("You may only warp once every 60 mins!", thePlayer, 255, 0, 0) return end
					element.latest.warp[getPlayerSerial(thePlayer)] = getTickCount()
					if (extraDat == "LS-Airport") then
						local v1, v2, v3 = unpack(warpLocations[1])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LS-Hospital") then
						local v1, v2, v3 = unpack(warpLocations[2])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LS-PD") then
						local v1, v2, v3 = unpack(warpLocations[3])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LS-Bank") then
						local v1, v2, v3 = unpack(warpLocations[4])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LS-DS") then
						local v1, v2, v3 = unpack(warpLocations[5])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LV-Casino") then
						local v1, v2, v3 = unpack(warpLocations[8])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LV-Hospital") then
						local v1, v2, v3 = unpack(warpLocations[7])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LV-Airport") then
						local v1, v2, v3 = unpack(warpLocations[6])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "LV-AirStrip") then
						local v1, v2, v3 = unpack(warpLocations[9])
						setElementPosition(thePlayer, v1, v2, v3)
					elseif (extraDat == "SF-Airport") then
						local v1, v2, v3 = unpack(warpLocations[10])
						setElementPosition(thePlayer, v1, v2, v3)
					end
				elseif (string == "ghostmode") then
					--if (element.ghosted[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.ghosted[getPlayerSerial(thePlayer)] < 600000 ) then outputChatBox("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
					exports.AURaghost:setPlayerGhosted(thePlayer, true)
					exports.NGCdxmsg:createNewDxMessage("You've enabled premium feature ghostmode for free, you're off the radar for 60 seconds and can be used every 5 mins!", thePlayer, 0, 255, 0)
				end
			elseif (data == "init_armour") then
				if (string == "aps") then
					if (exports.AURpoints:getAuroraPoints(thePlayer) <= 50) then
						outputChatBox("You do not have enough APS to purchase armour!", thePlayer, 255, 0, 0)
						return
					end
					if (element.latest.heal[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.heal[getPlayerSerial(thePlayer)] < 150000 ) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 15 mins!", thePlayer, 255, 0, 0) return end
					element.latest.heal[getPlayerSerial(thePlayer)] = getTickCount()
					local aps = exports.AURpoints:getAuroraPoints(thePlayer)
					exports.AURpoints:setPlayerAPS(thePlayer, aps-50)
					outputChatBox("APS Charge: -50. Toggled armour heal successfully!", thePlayer, 0, 255, 0)
					setPedArmor(thePlayer, 100)
				elseif (string == "vip") then
					if (element.latest.heal[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.heal[getPlayerSerial(thePlayer)] < 150000 ) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 15 mins!", thePlayer, 255, 0, 0) return end
					element.latest.heal[getPlayerSerial(thePlayer)] = getTickCount()
					exports.NGCdxmsg:createNewDxMessage("You've successfully toggled premium armour heal!", thePlayer, 0, 255, 0)
					setPedArmor(thePlayer, 100)
				end
			elseif (data == "heal_player") then
				if (string == "vipl2") then
					if (getPedStat(thePlayer, 24) == 1000) then
						if (getElementHealth(thePlayer) > 199) then exports.NGCdxmsg:createNewDxMessage("You don't need anymore health!", thePlayer, 255, 0, 0) return end
					else
						if (getElementHealth(thePlayer) > 99) then exports.NGCdxmsg:createNewDxMessage("You don't need anymore health!", thePlayer, 255, 0, 0) return end
					end
					if (element.latest.heal[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.heal[getPlayerSerial(thePlayer)] < 150000 ) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 15 mins!", thePlayer, 255, 0, 0) return end
					element.latest.heal[getPlayerSerial(thePlayer)] = getTickCount()
					exports.NGCdxmsg:createNewDxMessage("You've successfully toggled premium health heal 15%", thePlayer, 0, 255, 0)
					setElementHealth(thePlayer, getElementHealth(thePlayer) + 15)
				elseif (string == "vipl3") then
					if (getPedStat(thePlayer, 24) == 1000) then
						if (getElementHealth(thePlayer) > 199) then exports.NGCdxmsg:createNewDxMessage("You don't need anymore health!", thePlayer, 255, 0, 0) return end
					else
						if (getElementHealth(thePlayer) > 99) then exports.NGCdxmsg:createNewDxMessage("You don't need anymore health!", thePlayer, 255, 0, 0) return end
					end
					if (element.latest.heal[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.heal[getPlayerSerial(thePlayer)] < 600000 ) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
					element.latest.heal[getPlayerSerial(thePlayer)] = getTickCount()
					exports.NGCdxmsg:createNewDxMessage("You've successfully toggled premium health heal 50%", thePlayer, 0, 255, 0)
					setElementHealth(thePlayer, getElementHealth(thePlayer) + 50)
				end
			elseif (data == "jetpack") then
				if (string == "toggle") then
					if (exports.server:getPlayerWantedPoints(thePlayer) >= 10) then outputChatBox("You cannot use a jetpack whilst wanted!", thePlayer, 255, 0, 0) return end
					if (getElementDimension(thePlayer) ~= 0) then outputChatBox("You cannot use a jetpack in another dimension!", thePlayer, 255, 0, 0) return end
					if (getElementZoneName(plr, true) == "Las Venturas") then outputChatBox("You cannot use a jetpack in the vicinity of LV!", thePlayer, 255, 0, 0) return end
					if getElementData(thePlayer,"isPlayerJailed") then
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while jailed!", 225, 0, 0)
						return
					end
					if getElementData(thePlayer,"DuelIndex",true) then
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature in duels", 225, 0, 0)
						return
					end		
					if getElementData(thePlayer,"isPlayerGlued",true) then
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while gluing",255,0,0)
						return
					end
					if (element.latest.jetpack[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.jetpack[getPlayerSerial(thePlayer)] < 150000 ) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 15 mins!", thePlayer, 255, 0, 0) return end
					element.latest.jetpack[getPlayerSerial(thePlayer)] = getTickCount()
					if (doesPedHaveJetPack(thePlayer)) then exports.NGCdxmsg:createNewDxMessage("You already have a jetpack", thePlayer, 255, 0, 0) return end
					givePedJetPack(thePlayer)
					exports.NGCdxmsg:createNewDxMessage("You've successfully toggled premium jetpack!", thePlayer, 0, 255, 0)
				elseif (string == "remove") then
					if (not doesPedHaveJetPack(thePlayer)) then outputChatBox("You don't have a jetpack to remove!", thePlayer, 255, 0, 0) return end
					removePedJetPack(thePlayer)
					exports.NGCdxmsg:createNewDxMessage("You've successfully removed your premium jetpack!", thePlayer, 255, 0, 0)
				end
			elseif (data == "init_nitro") then
				if (not isPedInVehicle(thePlayer)) then exports.NGCdxmsg:createNewDxMessage("You must be in a vehicle to use this feature!", thePlayer, 255, 0, 0) return end
				if getElementData(thePlayer,"isPlayerJailed") then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while jailed!", 225, 0, 0)
					return
				end
				if getElementData(thePlayer,"DuelIndex",true) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature in duels", 225, 0, 0)
					return
				end		
				if getElementData(thePlayer,"isPlayerGlued",true) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You can't use this feature while gluing",255,0,0)
					return
				end
				if (element.latest.nitro[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.nitro[getPlayerSerial(thePlayer)] < 600000 ) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 60 mins!", thePlayer, 255, 0, 0) return end
				element.latest.nitro[getPlayerSerial(thePlayer)] = getTickCount()
				local veh = getPedOccupiedVehicle(thePlayer)
				if (not veh) then return end
				if (string == "nitroaps") then
					if (exports.AURpoints:getAuroraPoints(thePlayer) <= 50) then
						exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase nitro!", thePlayer, 255, 0, 0)
						return
					end
					local aps = exports.AURpoints:getAuroraPoints(thePlayer)
					exports.AURpoints:setPlayerAPS(thePlayer, aps-50)
					addVehicleUpgrade(veh, 1009)
					exports.NGCdxmsg:createNewDxMessage("You've successfully upgraded your vehicle adding Nitro x2. APS Charge: -50.", thePlayer, 0, 255, 0)
				elseif (string == "nitrol2") then
					addVehicleUpgrade(veh, 1009)
					exports.NGCdxmsg:createNewDxMessage("You've successfully upgraded your vehicle adding Nitro x2", thePlayer, 0, 255, 0)
				elseif (string == "nitrol3") then
					addVehicleUpgrade(veh, 1010)
					exports.NGCdxmsg:createNewDxMessage("You've successfully upgraded your vehicle adding Nitro x10", thePlayer, 0, 255, 0)
				end
			elseif (data == "fixveh") then
				if (string == "instafix") then
					if (exports.AURpoints:getAuroraPoints(thePlayer) <= 70) then
						exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase insta fix!", thePlayer, 255, 0, 0)
						return
					end
					local aps = exports.AURpoints:getAuroraPoints(thePlayer)
					local veh = getPedOccupiedVehicle(thePlayer)
					if (not veh) then exports.NGCdxmsg:createNewDxMessage("You must be in a vehicle to use this feature!", thePlayer, 255, 0, 0) return end
					if (getElementHealth(veh) < 999) then
						exports.AURpoints:setPlayerAPS(thePlayer, aps-70)
						if (element.latest.fix[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.fix[getPlayerSerial(thePlayer)] < 150000 ) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 15 mins!", thePlayer, 255, 0, 0) return end
						element.latest.fix[getPlayerSerial(thePlayer)] = getTickCount()
						fixVehicle(veh)
						exports.NGCdxmsg:createNewDxMessage("You've successfully fixed your occupied vehicle! APS Charge: -70.", thePlayer, 0, 255, 0)
					else
						exports.NGCdxmsg:createNewDxMessage("This vehicle doesn't need fixing!", thePlayer, 255, 0, 0)
					end
				end
			elseif (data == "help") then
				if (string == "request") then
					if (element.helpRequested[thePlayer]) then outputChatBox("You've already requested direct help, please be patient whilst an admin warps!", thePlayer, 255, 0, 0) return end
					element.helpRequested[thePlayer] = true
					outputChatBox("Your request has been sent! Please be patient whilst the admins warp to you.", thePlayer, 0, 255, 0)
					for k, v in pairs(getPlayersInTeam(getTeamFromName("Staff"))) do
						outputChatBox("L3 VIP player "..getPlayerName(thePlayer).." requests direct assistance, warp to him right away!", v, 255, 0, 0)
					end
				end
			elseif (data == "lights") then
				if (string == "standard") then
					if (thePlayer --[[and getElementData(thePlayer, "isPlayerAb")]]) then
						if (not element.timer.timer_1[thePlayer] and getPedOccupiedVehicle(thePlayer)) then
						if (getElementData(getPedOccupiedVehicle(thePlayer), "AURpremium.lightsEnabled")) then exports.NGCdxmsg:createNewDxMessage("This vehicle's lights are already being handled by another player!", thePlayer, 255, 0, 0) return end
						if (getElementData(getPedOccupiedVehicle(thePlayer), "vehicleOwner") ~= thePlayer) then outputChatBox("You aren't the matching owner to use such feature on this vehicle!", thePlayer, 255, 0, 0) return end
							element.theVehicle.vehicle_2[thePlayer] = getPedOccupiedVehicle(thePlayer)
							setElementData(element.theVehicle.vehicle_2[thePlayer], "AURpremium.occupier", thePlayer)
							setElementData(element.theVehicle.vehicle_2[thePlayer], "AURpremium.lightsEnabled", true)
							element.timer.timer_1[thePlayer] = setTimer(init_lights, 700, 0, thePlayer, (element.theVehicle.vehicle_2[thePlayer]))
							if (getVehicleOverrideLights(element.theVehicle.vehicle_2[thePlayer]) ~= 2) then
								setVehicleOverrideLights(element.theVehicle.vehicle_2[thePlayer], 2)
							end
							exports.NGCdxmsg:createNewDxMessage("Premium vehicle lights are now enabled!", thePlayer, 0, 255, 0)
						elseif (element.timer.timer_1[thePlayer] and getPedOccupiedVehicle(thePlayer)) then
							if (isTimer(element.timer.timer_1[thePlayer])) then
								if (getVehicleOverrideLights(element.theVehicle.vehicle_2[thePlayer]) ~= 0) then
									setVehicleOverrideLights(element.theVehicle.vehicle_2[thePlayer], 0)
								end
								killTimer(element.timer.timer_1[thePlayer])
								element.timer.timer_1[thePlayer] = false
								element.enabled[thePlayer] = false
								setVehicleLightState(element.theVehicle.vehicle_2[thePlayer], 0, 0)
								setVehicleLightState(element.theVehicle.vehicle_2[thePlayer], 1, 0)
								setVehicleLightState(element.theVehicle.vehicle_2[thePlayer], 2, 0)
								setVehicleLightState(element.theVehicle.vehicle_2[thePlayer], 3, 0)
								setElementData(element.theVehicle.vehicle_2[thePlayer], "AURpremium.lightsEnabled", false)
								exports.NGCdxmsg:createNewDxMessage("Premium vehicle lights are now disabled!", thePlayer, 255, 0, 0)
							end
						end
					end
				end
			elseif (data == "skins") then
				if (extraDat) then
					if (extraDat == "firstaps") then
						element.newSkin[thePlayer] = {292, "Yakuza"}
					elseif (extraDat == "secondaps") then
						element.newSkin[thePlayer] = {303, "James"}
					elseif (extraDat == "thirdaps") then
						element.newSkin[thePlayer] = {234, "Joker"}
					elseif (extraDat == "fourthaps") then
						element.newSkin[thePlayer] = {291, "Arrow"}
					elseif (extraDat == "fifthaps") then
						element.newSkin[thePlayer] = {290, "Ghost"}
					elseif (extraDat == "sixthaps") then
						element.newSkin[thePlayer] = {211, "Spiderman"}
					elseif (extraDat == "first") then
						element.newSkin[thePlayer] = {292, "Yakuza"}
					elseif (extraDat == "second") then
						element.newSkin[thePlayer] = {303, "James"}
					elseif (extraDat == "third") then
						element.newSkin[thePlayer] = {234, "Joker"}
					elseif (extraDat == "fourth") then
						element.newSkin[thePlayer] = {291, "Arrow"}
					elseif (extraDat == "fifth") then
						element.newSkin[thePlayer] = {211, "Spiderman"}
					elseif (extraDat == "sixth") then
						element.newSkin[thePlayer] = {290, "Ghost"}
					elseif (extraDat == "seventh") then
						element.newSkin[thePlayer] = {297, "Robber"}
					elseif (extraDat == "eight") then
						element.newSkin[thePlayer] = {199, "Harley"}
					end
				end
				if (string == "apstoggle") then
					if (exports.AURpoints:getAuroraPoints(thePlayer) <= 100) then
						exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase this skin!", thePlayer, 255, 0, 0)
						return
					end
					local aps = exports.AURpoints:getAuroraPoints(thePlayer)
					exports.AURpoints:setPlayerAPS(thePlayer, aps-100)
					if (element.latest.skin[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.skin[getPlayerSerial(thePlayer)] < 300000 ) then outputChatBox("You may only use this feature once every 30 mins!", thePlayer, 255, 0, 0) return end
					element.latest.skin[getPlayerSerial(thePlayer)] = getTickCount()
					if (extraDat) then
						if (getElementModel(thePlayer) == element.newSkin[thePlayer][1]) then outputChatBox("You already have this skin!", thePlayer, 255, 0, 0) return end
						setElementModel(thePlayer, element.newSkin[thePlayer][1])
						outputChatBox("Successful data transferred! Curr Model: "..element.prevSkin[thePlayer][1]..", New Model: "..element.newSkin[thePlayer][1].." ("..element.newSkin[thePlayer][2]..")", thePlayer, 255, 255, 0)
					end
				elseif (string == "apsremove") then
					if (getElementModel(thePlayer) == element.prevSkin[thePlayer][1]) then outputChatBox("You do not have a skin to remove!", thePlayer, 255, 0, 0) return end
					setElementModel(thePlayer, element.prevSkin[thePlayer][1])
					outputChatBox("APS removed skin, reverted to previous! (ID: "..element.prevSkin[thePlayer][1]..")", thePlayer, 255, 0, 0)
				elseif (string == "viptoggle") then
					if (element.latest.skin[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.skin[getPlayerSerial(thePlayer)] < 300000 ) then outputChatBox("You may only use this feature once every 30 mins!", thePlayer, 255, 0, 0) return end
					element.latest.skin[getPlayerSerial(thePlayer)] = getTickCount()
					if (extraDat) then
						if (getElementModel(thePlayer) == element.newSkin[thePlayer][1]) then outputChatBox("You already have this skin!", thePlayer, 255, 0, 0) return end
						setElementModel(thePlayer, element.newSkin[thePlayer][1])
						outputChatBox("Successfull data transfered! Curr Model: "..element.prevSkin[thePlayer][1]..", New Model: "..element.newSkin[thePlayer][1].." ("..element.newSkin[thePlayer][2]..")", thePlayer, 255, 255, 0)
					end
				elseif (string == "vipremove") then
					if (getElementModel(thePlayer) == element.prevSkin[thePlayer][1]) then outputChatBox("You do not have a skin to remove!", thePlayer, 255, 0, 0) return end
					setElementModel(thePlayer, element.prevSkin[thePlayer][1])
					outputChatBox("Premium removed skin, reverted to previous! (ID: "..element.prevSkin[thePlayer][1]..")", thePlayer, 255, 0, 0)
				end
			elseif (data == "vipadvert") then
				if (element.latest.advert[getPlayerSerial(thePlayer)] ) and ( getTickCount()-element.latest.advert[getPlayerSerial(thePlayer)] < 150000 ) then outputChatBox("You may only use this feature once every 15 mins!", thePlayer, 255, 0, 0) return end
				element.latest.advert[getPlayerSerial(thePlayer)] = getTickCount()
				if (string) then
					outputChatBox("(Premium Advert) "..getPlayerName(thePlayer)..": #ffffff"..string, root, 255, 0, 255, true)
				end
			elseif (data == "vipchat") then
				if (string == "enable") then
					--if not getElementData(thePlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You are not VIP",255,0,0) return end
					if enabledvchat[thePlayer] == false or enabledvchat[thePlayer] == nil then
						exports.NGCdxmsg:createNewDxMessage("Premium chat enabled, you can now talk and see premium chat", thePlayer, 0,255,0)
						enabledvchat[thePlayer]=true
					else
						exports.NGCdxmsg:createNewDxMessage("Premium chat disabled, you can no longer talk or see premium chat", thePlayer, 0, 255, 0)
						enabledvchat[thePlayer]=false
					end
				end
			elseif (data == "vipvehcolor") then
				
			elseif (data == "purchase") then
				if (string == "vip" and extraDat) then
					if (userData.premium > 0) then
						outputChatBox("You are already a premium player therefor cannot purchase anymore hours!", thePlayer, 255, 0, 0)
						return
					end
					local aps = exports.AURpoints:getAuroraPoints(source)
					if (aps >= extraDat * 1000) then
						exports.AURpoints:setPlayerAPS(source, aps-(extraDat * 1000))
						givePlayerPremium(thePlayer, extraDat*60, 1)
					else
						outputChatBox("You do not have enough APS to purchase this item!", thePlayer, 255, 0, 0)
					end
				end
			elseif (data == "basespawn") then
				if (string == "apsbasespawn") then
					if (element.latest.warp_base[getPlayerSerial(thePlayer)]) and (getTickCount()-element.latest.warp_base[getPlayerSerial(thePlayer)] < 600000) then exports.NGCdxmsg:createNewDxMessage("You may only warp once every 60 mins!", thePlayer, 255, 0, 0) return end
					element.latest.warp_base[getPlayerSerial(thePlayer)] = getTickCount()
					triggerClientEvent("AURpremium:no_base", thePlayer, thePlayer, string)
				elseif (string == "spawnatvipbase") then
					if (element.latest.warp_base[getPlayerSerial(thePlayer)]) and (getTickCount()-element.latest.warp_base[getPlayerSerial(thePlayer)] < 600000) then exports.NGCdxmsg:createNewDxMessage("You may only warp once every 60 mins!", thePlayer, 255, 0, 0) return end
					element.latest.warp_base[getPlayerSerial(thePlayer)] = getTickCount()
					triggerClientEvent("AURpremium:no_base", thePlayer, thePlayer, string)
				end
			elseif (data == "colorpicker") then
				if (string == "set") then
					if not (extraDat or extraDat2 or extraDat3) then return end
					if (getPedOccupiedVehicle(thePlayer) == element.theVehicle.vehicle_1[thePlayer]) then
						outputChatBox("Successfully changed vehicle colour to Red: "..extraDat..", Green: "..extraDat2..", Blue: "..extraDat3..".", thePlayer, 0, 255, 0)
						local veho = getPedOccupiedVehicle(thePlayer)
						setVehicleColor(veho, extraDat, extraDat2, extraDat3)
					else
						outputChatBox("You may only set colour of your spawned premium vehicle!", thePlayer, 255, 0 , 0)
					end
				end
			elseif (data == "music") then
				if (string == "aps" --[[and extraDat]]) then
					--if (extraDat == "toggleon") then
						if (exports.AURpoints:getAuroraPoints(thePlayer) <= 150) then
							exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase music access!", thePlayer, 255, 0, 0)
							return
						end
						if (element.latest.music[getPlayerSerial(thePlayer)]) and (getTickCount()-element.latest.music[getPlayerSerial(thePlayer)] < 300000) then exports.NGCdxmsg:createNewDxMessage("You can only play a song once every 30 mins!", thePlayer, 255, 0, 0) return end
						element.latest.music[getPlayerSerial(thePlayer)] = getTickCount()
						local aps = exports.AURpoints:getAuroraPoints(source)
						exports.AURpoints:setPlayerAPS(source, aps-150)
						exports.AURgmusic:givePlayerTempMusic(thePlayer, true)
						--element.music[thePlayer] = true
					--elseif (extraDat == "toggleoff") then
					--end
				elseif (string == "vip" and extraDat) then
					if (element.latest.musicvip[getPlayerSerial(thePlayer)]) and (getTickCount()-element.latest.musicvip[getPlayerSerial(thePlayer)] < 150000) then exports.NGCdxmsg:createNewDxMessage("You can only play a song once every 15 mins!", thePlayer, 255, 0, 0) return end
					element.latest.musicvip[getPlayerSerial(thePlayer)] = getTickCount()
					element.music[thePlayer] = true
					for k, v in pairs(getElementsByType("player")) do
						exports.AURgmusic:trigger_return_playy(extraDat, v, getPlayerName(thePlayer), thePlayer, string)
					end
				elseif (string == "vipstop") then
					if (element.music[thePlayer]) then
						for k, v in pairs(getElementsByType("player")) do
							exports.AURgmusic:trigger_return_stopp(v, thePlayer, string)
						end
						element.music[thePlayer] = false
					else
						exports.NGCdxmsg:createNewDxMessage("You cannot stop a song if you haven't played one!", thePlayer, 255, 0, 0)
					end
				end
			elseif (data == "customtitle") then
				if (string == "toggle") then
					exports.AURcustomtitles:recieve_custom_title_data("Premium Player", 0, 255, 255, "premium", thePlayer)
				end
			end
		end
	end
end
addEvent("AURpremium.server_actions", true)
addEventHandler("AURpremium.server_actions", root, server_actions)

addEventHandler("onVehicleStartEnter",root,function(p,seat)
	if seat == 0 then
		if getElementData(source,"vehicleType") == "VIPCar" then
			if getPlayerWantedLevel(p) > 0 then
				cancelEvent()
				exports.NGCdxmsg:createNewDxMessage(p,"You can't drive a VIP car with wanted points!",255,0,0)
			end
		end
	end
end)

-- Destroy the vehicle on quit
addEventHandler ( "onPlayerQuit", root,
	function()
		if ( isElement( element.theVehicle.vehicle_1[source] ) ) then
			destroyElement( element.theVehicle.vehicle_1[source] )
			element.theVehicle.vehicle_1[source] = nil
		end
		if (isTimer(element.timer.timer_1[thePlayer])) then
			killTimer(element.timer.timer_1[thePlayer])
		end
	end
)

-- When the player stats entering the vehicle tazed
addEventHandler("onVehicleStartEnter", root,
	function (thePlayer)
			if getElementData(thePlayer,"tazed",true) then
			cancelEvent()
			exports.NGCdxmsg:createNewDxMessage("You can't enter this vehicle while tazed!",thePlayer,255,0,0)
		end
	end
)

-- Prevent people from entering VIP cars
addEventHandler("onVehicleStartEnter", root,
	function ( thePlayer, seat, jacked )
		if ( getElementData(source, "vehicleType") == "VIPCar" ) and ( seat == 0 ) and not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff" ) then
			if not ( exports.server:isPlayerVIP( thePlayer ) ) then
				cancelEvent()
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are not allowed to enter this vehicle!", 225, 0, 0)
			end
		end
	end
)

addEventHandler("onElementDataChange",root,function(k)
	if k == "wantedPoints" then
		if getPlayerWantedLevel(source) > 0 then
			if doesPedHaveJetPack(source) then
				removePedJetPack(source)
				exports.NGCdxmsg:createNewDxMessage(source,"Your jetpack removed due to being wanted!",255,0,0)
			end
		end
	end
end)

-- Destroy the vehicle when it explodes
addEventHandler("onVehicleExplode", root,
	function ()
		if ( getElementData(source, "vehicleType") == "VIPCar" ) then
			local theOwner = getElementData(source, "vehicleOwner")
			element.timer.timer_3[theOwner] = setTimer(destroyVehicle, 5000, 1, source, theOwner)
		end
	end
)

-- Destroy function
function destroyVehicle ( vehicle, thePlayer  )
	if (isElement(vehicle) and thePlayer) then
		element.theVehicle.vehicle_1[thePlayer] = nil
		element.timer.timer_3[thePlayer] = nil
		destroyElement(vehicle)
	end
end

function destroyByCommands(plr)
	if (plr and isElement(plr) and getElementType(plr) == "player") then
		if (element.theVehicle.vehicle_1[plr]) then
			destroyVehicle(element.theVehicle.vehicle_1[plr], plr)
			exports.NGCdxmsg:createNewDxMessage("You've successfully destroyed your APS/Premium vehicle!", plr, 255, 0, 0)
		else
			exports.NGCdxmsg:createNewDxMessage("You do not have a vehicle to destroy!", plr, 255, 0, 0)
		end
	end
end
addCommandHandler("dprem", destroyByCommands)
 
function changeHats(model,scale, string, name)
	if (model) then
		if (string == "toggleaps") then
			if (exports.AURpoints:getAuroraPoints(source) < 50) then
				exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase a hat!", source, 255, 0, 0)
				return
			end
			local aps = exports.AURpoints:getAuroraPoints(source)
			exports.AURpoints:setPlayerAPS(source, aps-50)
			exports.NGCdxmsg:createNewDxMessage("You've just bought a "..name.." for 50 APS which has been taken from your account!", source, 0, 255, 0)
			element.hats[source] = {"APS"}
		elseif (string == "togglevip") then
			exports.NGCdxmsg:createNewDxMessage("VIP - You've just enabled a "..name.."!", source, 0, 255, 0)
			element.hats[source] = {"VIP"}
		end
		if isElement(element.hatObjects[source]) then
			destroyElement(element.hatObjects[source])
			element.hatObjects[source] = nil
			if isTimer(element.timer.timer_2) then killTimer(element.timer.timer_2[source]) end
		end
		element.hatObjects[source] = createObject(model, 0,0,-10 )
		setObjectScale(element.hatObjects[source],scale)
		exports.bone_attach:attachElementToBone(element.hatObjects[source],source,1,-0.0050,0.025,0.125,0,4,180)
		local p = source
		if (p and element.hatObjects[p]) then
			element.timer.timer_2[p] = setTimer(function(p)
				if (not element.hatObjects[p]) then killTimer(element.timer.timer_2[p]) return end
				local int,dim=getElementInterior(p),getElementDimension(p)
				setElementInterior(element.hatObjects[p],int)
				setElementDimension(element.hatObjects[p],dim)
			end,3000,1,source)
		end
	elseif (string == "removeaps" or string == "removevip") then
		if (not element.hatObjects[source]) then exports.NGCdxmsg:createNewDxMessage("You do not have a hat to remove!", source, 255, 0, 0) return end
		if isElement(element.hatObjects[source]) then destroyElement(element.hatObjects[source]) end
		if isTimer(element.timer.timer_2) then killTimer(element.timer.timer_2[source]) end
		element.hatObjects[source] = nil
		--exports.NGCdxmsg:createNewDxMessage(source,"No longer wearing any hat",0,255,0)
		exports.NGCdxmsg:createNewDxMessage(element.hats[source][1].." - You're no longer wearing any hat", source, 0,255,0)
	--end
	end
end
addEvent("AURpremium.changeHat", true)
addEventHandler("AURpremium.changeHat", root, changeHats)

local cig = {
	object = {},
	timer = {},
}

function enable_cig(thePlayer, string)
	local smoking = "smoking"
	if (not isElement(cig.object[thePlayer])) then
		if (string == "apssmoke") then
			if (exports.AURpoints:getAuroraPoints(thePlayer) < 400) then
				exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase smoking!", thePlayer, 255, 0, 0)
				return
			end
			smoking = "aps smoking"
			local aps = exports.AURpoints:getAuroraPoints(thePlayer)
			exports.AURpoints:setPlayerAPS(thePlayer, aps-400)
		end
		local smoking = smoking or "smoking"
		cig.object[thePlayer] = createObject ( 1485, 0, 0, 0 )
		exports.bone_attach:attachElementToBone(cig.object[thePlayer], thePlayer, 11, 0.1, 0.05, 0.07, 15, -10, 180)
		exports.NGCdxmsg:createNewDxMessage("You've enabled "..smoking..", you may now use /puff to gain some armor (+5) per second but you also loose some health (-3) per second!", thePlayer, 0, 255, 0)
	else
		exports.bone_attach:detachElementFromBone(cig.object[thePlayer])
		destroyElement(cig.object[thePlayer])
		exports.NGCdxmsg:createNewDxMessage("You've put out your fag, you did the right thing... Not! You just wasted a cig you idiot..", thePlayer, 0, 255, 0)
	end
end

local drink = {
	object = {},
	timer = {},
	timerEffect = {},
}

function enable_drink(thePlayer, string)
	local drinking = "drinking"
	if (not isElement(drink.object[thePlayer])) then
		if (string == "apsdrink") then
			if (exports.AURpoints:getAuroraPoints(thePlayer) < 400) then
				exports.NGCdxmsg:createNewDxMessage("You do not have enough APS to purchase a drink!", thePlayer, 255, 0, 0)
				return
			end
			drinking = "aps drinking"
			local aps = exports.AURpoints:getAuroraPoints(thePlayer)
			exports.AURpoints:setPlayerAPS(thePlayer, aps-400)
		end
		local drinking = drinking or "drinking"
		drink.object[thePlayer] = createObject(1544, 0, 0, 0)
		exports.bone_attach:attachElementToBone(drink.object[thePlayer], thePlayer, 12, 0.15, 0.1, 0.3, 15, 140, 180)
		exports.NGCdxmsg:createNewDxMessage("You've enabled "..drinking..", use /drink and get the ability to with-stand more damage, however excessive damage can still kill you!", thePlayer, 0, 255, 0)
	else
		exports.bone_attach:detachElementFromBone(drink.object[thePlayer])
		destroyElement(drink.object[thePlayer])
		exports.NGCdxmsg:createNewDxMessage("You've put down the bottle", thePlayer, 0, 255, 0)
	end
end

function drink_(plr)
    if (drink.timer[plr]) then
		if (isElement(drink.object[plr])) then
			setElementData(plr, "isPlayerAnimated", false)
			setPedAnimation(plr, false)
			startMove(plr, true)
			if (isTimer(drink.timer[plr])) then
				killTimer(drink.timer[plr])
			end
			setElementFrozen(plr, false)
			destroyElement(drink.object[plr])
			exports.bone_attach:detachElementFromBone(drink.object[thePlayer])
			exports.NGCdxmsg:createNewDxMessage("You've stopped drinking, please wait another 30 mins before having another drink", plr, 255, 0, 0)
			return false
		end
	elseif isTimer(drink.timerEffect[plr]) then
		drinkEffects(plr, false)
		killTimer(drink.timerEffect[plr])
		return false
    end
    if (not isElement(drink.object[plr])) then
        exports.NGCdxmsg:createNewDxMessage("You can only sip your drink once you've opened a bottle bro..", plr, 255, 0, 0)
        return false
    end
	if (element.drink[getPlayerSerial(plr)]) and (getTickCount()-element.cig[getPlayerSerial(plr)] < 300000) then exports.NGCdxmsg:createNewDxMessage("You may only have a drink once every 30 mins!", plr, 255, 0, 0) if (isElement(drink.object[plr])) then destroyElement(drink.object[plr]) end return end
	element.drink[getPlayerSerial(plr)] = getTickCount()
	setElementFrozen(plr, true)
    setPedAnimation(plr, "bar", "dnk_stndM_loop", 6500, true, true, false, false)
    setElementData(plr, "isPlayerAnimated", true)
	startMove(plr, false)
    drink.timer[plr] = setTimer(
        function(plr)
            if (not isElement(plr)) then
                killTimer(drink.timer[plr])
                drink.timer[plr] = nil
                return false
            end
            local msLeft, executesRemaining = getTimerDetails(drink.timer[plr])
            if (executesRemaining == 1) then
                setElementData(plr, "isPlayerAnimated", false)
                setPedAnimation(plr, false)
				drinkEffects(plr, true)
				drink.timerEffect[plr] = setTimer(
					function()
						drink.timerEffect[plr] = nil
						drinkEffects(plr, false)
					end, 150000, 1)
				startMove(plr, true)
                drink.timer[plr] = nil
				setElementFrozen(plr, false)
				if (isElement(drink.object[plr])) then
					destroyElement(drink.object[plr])
					exports.bone_attach:detachElementFromBone(drink.object[thePlayer])
					exports.NGCdxmsg:createNewDxMessage("Your drink is now finished, you'll start to feel dizzy and have the ability to with-stand damage for 15 mins.", plr, 255, 0, 0)
				end
            end
        end
    ,1000, 6, plr)
end
addCommandHandler("drink", drink_)

function drinkEffects(plr, bool)
	if (plr) then
		if (bool) then
			setElementData(plr, "AURpremium.playerDrunk", true)
			triggerClientEvent(plr, "AURpremium.drinkEffects", plr, plr, bool)
		else
			setElementData(plr, "AURpremium.playerDrunk", false)
			triggerClientEvent(plr, "AURpremium.drinkEffects", plr, plr, bool)
		end
	end
end
--addCommandHandler("stopdrink", function(plr) drinkEffects(plr, false) end)

function cig_puff(plr)
    if (cig.timer[plr]) then
		if (isElement(cig.object[plr])) then
			setElementData(plr, "isPlayerAnimated", false)
			setPedAnimation(plr, false)
			startMove(plr, true)
			killTimer(cig.timer[plr])
			setElementFrozen(plr, false)
			destroyElement(cig.object[plr])
			exports.bone_attach:detachElementFromBone(cig.object[thePlayer])
			exports.NGCdxmsg:createNewDxMessage("You've ended your cig, please wait another 30 mins before having another zoot", plr, 255, 0, 0)
			return false
		end
    end
    if (not isElement(cig.object[plr])) then
        exports.NGCdxmsg:createNewDxMessage("You can only take a puff once you've sparked up a cig bro..", plr, 255, 0, 0)
        return false
    end
	if (element.cig[getPlayerSerial(plr)]) and (getTickCount()-element.cig[getPlayerSerial(plr)] < 300000) then exports.NGCdxmsg:createNewDxMessage("You may only take a puff once every 30 mins!", plr, 255, 0, 0) if (isElement(cig.object[plr])) then destroyElement(cig.object[plr]) end return end
	element.cig[getPlayerSerial(plr)] = getTickCount()
	setElementFrozen(plr, true)
    setPedAnimation(plr, "BD_FIRE", "M_smklean_loop", 6500, true, true, false, false)
    setElementData(plr, "isPlayerAnimated", true)
	startMove(plr, false)
    cig.timer[plr] = setTimer(
        function(plr)
            if (not isElement(plr)) then
                killTimer(cig.timer[plr])
                cig.timer[plr] = nil
                return false
            end
            local armor = getPedArmor(plr)
            local health = getElementHealth(plr)
            local msLeft, executesRemaining = getTimerDetails(cig.timer[plr])
            if (armor <= 100 and health >= 1) then
                setPedArmor(plr, armor + 10)
                setElementHealth(plr, health - 3)
            end
            if (executesRemaining == 1) then
                setElementData(plr, "isPlayerAnimated", false)
                setPedAnimation(plr, false)
				startMove(plr, true)
                cig.timer[plr] = nil
				setElementFrozen(plr, false)
				if (isElement(cig.object[plr])) then
					destroyElement(cig.object[plr])
					exports.bone_attach:detachElementFromBone(cig.object[thePlayer])
					exports.NGCdxmsg:createNewDxMessage("Your cig is now finished, wait atleast 30 mins before having another zoot..", plr, 255, 0, 0)
				end
            end
        end
    , 1000, 6, plr)
end
addCommandHandler("puff", cig_puff)

function startMove(plr, state)
	toggleControl(plr, "forwards", state)
	toggleControl(plr, "backwards", state)
	toggleControl(plr, "left", state)
	toggleControl(plr, "right", state)
	toggleControl(plr, "crouch", state)
	toggleControl(plr, "enter_exit", state)
	toggleControl(plr, "aim_weapon", state)
	toggleControl(plr, "fire", state)
end

--[[function cig_puff(plr)
	if (not plr or not isElement(plr)) then return end
	if (isTimer(cig.timer[plr])) then
		outputChatBox("You're already puffing bro, chill..", plr, 255, 0, 0)
		return
	end
	if (not cig.object[plr]) then
		exports.NGCdxmsg:createNewDxMessage("You can only take a puff once you've sparked up a cig bro..", plr, 255, 0, 0)
		return
	end
	setPedAnimation(plr, "BD_FIRE", "M_smklean_loop")
	setElementData(plr, "isPlayerAnimated", true)
	toggleAllControls(plr, false)
	cig.timer[plr] = setTimer(function()
		local armor = getPedArmor(plr)
		local health = getElementHealth(plr)
		if (armor <= 100 and health >= 1) then
			setPedArmor(plr, armor + 5)
			setElementHealth(plr, health - 1)
		end
	end, 1000, 5)
	local tmr = setTimer(function()
		toggleAllControls(plr, true)
		setPedAnimation(plr, false)
		setElementData(plr, "isPlayerAnimated", false)
	end, 5000, 1)
end
addCommandHandler("puff", cig_puff)]]


addEventHandler("onPlayerQuit",root,function()
	if isElement(element.hatObjects[source]) then
		if isTimer(element.timer.timer_2[source]) then
			killTimer(element.timer.timer_2[source])
		end
		destroyElement(hatObjects[source])
		element.hatObjects[source] = nil
	end
end)

function onPlayerDead(ammo, attacker, weapon, bodypart)
	if (source and attacker and source ~= attacker) then
		if (element.bombEnabled[source]) then
			local x, y, z = getElementPosition(source)
			local responsible = source
			local el1, el2 = Vector3(getElementPosition(source)), Vector3(getElementPosition(attacker))
			if (getDistanceBetweenPoints3D(el1, el2) <= 15) then
				local explosion = setTimer(function() setTimer(function() createExplosion(x+math.random(0,5), y+math.random(0, 5), z, 6, responsible) end, 100, 2) end, 1000, 1)
				outputChatBox("WATCH OUT! "..getPlayerName(source).." has dropped an on-death bomb!", attacker, 255, 0, 0)
			else
				outputChatBox("You got lucky this time, next time it wont be the same!", attacker, 255, 0, 0)
				outputChatBox("You were too far away from the attacker to drop an on-detah bomb, try getting closer!", source, 255, 255, 0)		
				--outputChatBox(tostring(el1)..", "..tostring(el2)..", "..tostring(getDistanceBetweenPoints3D(el1, el2)))
			end
		end
	end
end
addEventHandler("onPlayerWasted", root, onPlayerDead)

function init_lights(plr, veh)
	if (not plr and not (element.theVehicle.vehicle_2[plr])) then return end
	if (not getElementType(element.theVehicle.vehicle_2[plr]) == "vehicle") or (not getElementType(plr) == "player") then return end
	if (element.theVehicle.vehicle_2[plr]) then
		if (element.enabled[plr]) then
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 1, 1)
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 2, 1)
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 3, 0)
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 0, 0)
			element.enabled[plr] = false
		else
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 1, 0)
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 2, 0)
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 3, 1)
			setVehicleLightState(element.theVehicle.vehicle_2[plr], 0, 1)
			element.enabled[plr] = true
		end
	end
end

function destroy_lights()
	if (source and getElementType(source) == "player" and element.enabled[source]) then
		if (isTimer(element.timer.timer_1[source])) then
			killTimer(element.timer.timer_1[source])
			if (element.theVehicle.vehicle_2[plr]) then
				setVehicleLightState(element.theVehicle.vehicle_2[plr], 0, 0)
				setVehicleLightState(element.theVehicle.vehicle_2[plr], 1, 0)
				setVehicleLightState(element.theVehicle.vehicle_2[plr], 2, 0)
				setVehicleLightState(element.theVehicle.vehicle_2[plr], 3, 0)
			end
		end
	end
end
addEventHandler("onPlayerQuit", root, destroy_lights)

function destroy_lights_()
	if (source and getElementType(source) == "vehicle") then
		if (getElementData(source, "AURpremium.lightsEnabled") == true) then
			local occupier = getElementData(source, "AURpremium.occupier")
			if (isTimer(element.timer.timer_1[occupier])) then
				killTimer(element.timer.timer_1[occupier])
				element.timer.timer_1[occupier] = false
				element.enabled[occupier] = false
				--outputDebugString("deleted timer confirmed")
			end
		end
	end
end
addEventHandler("onVehicleExplode", root, destroy_lights_)

function onResourceStop_()
	for k, veh in pairs(getElementsByType("vehicle")) do
		if (veh and getElementType(veh) == "vehicle") then
			if (getElementData(source, "AURpremium.occupier") or getElementData(veh, "AURpremium.lightsEnabled")) then
				setVehicleLightState(veh, 0, 0)
				setVehicleLightState(veh, 1, 0)
				setVehicleLightState(veh, 2, 0)
				setVehicleLightState(veh, 3, 0)
				removeElementData(veh, "AURpremium.occupier")
				removeElementData(veh, "AURpremium.lightsEnabled")
			end
		end
	end
end
addEventHandler("onResourceStop", getResourceRootElement(), onResourceStop_)

function onDestroyVeh()
	if (source and getElementType(source) == "vehicle" and getElementData(source, "AURpremium.lightsEnabled")) then
		local thePlayer = getElementData(source, "AURpremium.occupier")
		if (not thePlayer) then return end
		if (isTimer(element.timer.timer_1[thePlayer])) then
			killTimer(element.timer.timer_1[thePlayer])
			setElementData(element.theVehicle.vehicle_2[thePlayer], "AURpremium.lightsEnabled", false)
		end
	end
end
addEventHandler("onElementDestroy", root, onDestroyVeh)

addEventHandler("onElementDataChange",root,function(k)
	if k == "wantedPoints" then
		if getPlayerWantedLevel(source) > 0 then
			if doesPedHaveJetPack(source) then
				removePedJetPack(source)
				exports.NGCdxmsg:createNewDxMessage(source,"Jetpack removed due to being wanted",255,0,0)
			end
		end
	end
end)

function onPlayerPremiumChat(thePlayer, cmd, ...)
	if (exports.server:isPlayerPremium(thePlayer)) then
		if enabledvchat[thePlayer] == nil then
			enabledvchat[thePlayer] = true
		end
			if enabledvchat[thePlayer] == false then
				exports.NGCdxmsg:createNewDxMessage(thePlayer,"Premium chat is disabled, please enable it from the panel!",255,0,0)
				--outputChatBox("VIP chat is disabled, enable it from the panel", thePlayer, 0,255,0)
				return
			end
			local theMessage = table.concat( {...}, " " )
			if (theMessage == "") then return end
			for k, aPlayer in ipairs ( getElementsByType( "player" ) ) do
			if ( exports.CSGadmin:getPlayerMute ( thePlayer ) == "Global" ) then
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are muted thus cannot use the premium chat!", 236, 201, 0)
			return false end
			--	if ( exports.server:isPlayerVIP( aPlayer ) ) then
				if (exports.server:isPlayerPremium(thePlayer)) then
					if enabledvchat[aPlayer] == nil then
						outputChatBox( "(PREM) " .. getPlayerName( thePlayer ) .. ": #FFFFFF"..theMessage, aPlayer, 255, 0, 255, true )
					elseif enabledvchat[aPlayer] == true then
						outputChatBox( "(PREM) " .. getPlayerName( thePlayer ) .. ": #FFFFFF"..theMessage, aPlayer, 255, 0, 255, true )
					else
						--off for him
					end
				end
			end
		exports.CSGlogging:createLogRow ( thePlayer, "PremiumChat", theMessage )
	end
end
addCommandHandler("prem", onPlayerPremiumChat)

-- Update the premium time from all players and update it
timer_premTiming = setTimer(
	function ()
		for k, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
			if ( exports.server:getPlayerAccountID( thePlayer ) ) then
				if ( exports.server:isPlayerPremium( thePlayer ) ) then
					local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( thePlayer ) )
					if userData == nil then userData = {} userData.premium = 0 end
					if ( userData.premium > 4 ) then
						PremTime = userData.premium - 5
						premiumType = userData.premLevel
					elseif ( userData.premium == 4 ) then
						PremTime = userData.premium - 4
						premiumType = userData.premLevel
					elseif ( userData.premium == 3 ) then
						PremTime = userData.premium - 3
						premiumType = userData.premLevel
					elseif ( userData.premium == 2 ) then
						PremTime = userData.premium - 2
						premiumType = userData.premLevel
					elseif ( userData.premium == 1 ) then
						PremTime = userData.premium - 1
						premiumType = userData.premLevel
					end

					if (PremTime == 0) then
						setElementData(thePlayer, "isPlayerPremium", false)
						setElementData(thePlayer, "Premium", "No")
						premiumType = 0
						setElementData(thePlayer, "premiumLevel", premiumType)
						triggerClientEvent(thePlayer, "AURpremium.update_panel", thePlayer, thePlayer, exports.AURpoints:getAuroraPoints(thePlayer), 0, 0, true)
						exports.NGCdxmsg:createNewDxMessage("Unfortunately your premium time has expired, you may purchase more at shop.aurorarvg.com!", thePlayer, 255, 0, 0)
					else
						triggerClientEvent(thePlayer, "AURpremium.update_panel", thePlayer, thePlayer, exports.AURpoints:getAuroraPoints(thePlayer), premiumType, PremTime, true)
					end
					exports.DENmysql:exec("UPDATE accounts SET premium=? WHERE id=?", tonumber(PremTime), exports.server:getPlayerAccountID(thePlayer))
				end
			end
		end
	end, 300000, 0
)
--addEventHandler("onResourceStart", root, function() resetTimer(timer_premTiming) end)

function getPremHours(plr)
	local userData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID(plr))
	exports.NGCdxmsg:createNewDxMessage("Your premium time remaining is "..(userData.premium / 60).."!", plr, 255, 0, 255)
end
addCommandHandler("premtime", getPremHours)

function getNearbyPlayers(thePlayer)
	local nearbyPlayers = { }
	local px,py,pz = getElementPosition(thePlayer)
	for k,v in pairs(getElementsByType("player"))do
		local vx,vy,vz = getElementPosition(v)
		--outputDebugString(getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz))
		if(getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz) < 50)then
			table.insert(nearbyPlayers, v)
		end
	end
	return nearbyPlayers
end

addEventHandler("onResourceStart", root, 
	function()
		for k, plr in pairs(getElementsByType("player")) do
			if (plr and exports.server:isPlayerLoggedIn(plr)) then
				local userData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID(plr))
				if (userData and userData.premiumLevel > 0) then
					setElementData(plr, "isPlayerPremium", true)
					setElementData(plr, "Premium", true)
				end
			end
		end
	end
)

function panel_open(plr)
	if (plr) then
		local points = exports.AURpoints:getAuroraPoints(plr)
		local hours = "nil"
		local userData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID(plr))
		if (points and hours and userData) then
			if (userData.premiumLevel > 0) then
				setElementData(plr, "premiumLevel", userData.premiumLevel)
			else
				setElementData(plr, "premiumLevel", 0)
			end
			triggerClientEvent(plr, "AURpremium.update_panel", plr, plr, points, userData.premiumLevel, userData.premium)
		end
	end
end
addEvent("AURpremium.panel_open", true)
addEventHandler("AURpremium.panel_open", root, panel_open)

function givePlayerPremium(player, amount, level)
	if (player and amount and level and level <= 4) then
		if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
			local id = exports.server:getPlayerAccountID(player)
			local data = exports.DENmysql:querySingle("SELECT premium FROM accounts WHERE id=?",id)
			local dataLevel = exports.DENmysql:querySingle("SELECT premiumLevel FROM accounts WHERE id=?",id)
			local newValue, newValueLevel = data["premium"] + amount, dataLevel["premiumLevel"] + level or dataLevel["premiumLevel"]
			if (exports.DENmysql:exec("UPDATE accounts SET premium=?, premiumLevel=? WHERE id=?", newValue, level, id)) then
				outputDebugString("[Premium] "..getPlayerName(player).." has been given "..amount.." of Premium minutes (Level: "..level..").",0,0,255,0)
				setElementData(player, "isPlayerPremium", true)
				setElementData(player, "Premium", "Yes")
				return true
			else
				outputDebugString("[Premium] failed to give "..getPlayerName(player).." "..amount.." of Premium minutes!",0,255,0,0)
				return false
			end
		else
			return false
		end
	else
		outputChatBox("Please enter the correct details, syntax args: 'player (the player to give)', 'amount (minutes [do *60 for hours])', 'level (max 4)'", source, 255, 0, 0)
	end
end

function decreasePlayerPremium(player, amount, level)
	if (player and amount and level and level <= 4) then
		if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
			local id = exports.server:getPlayerAccountID(player)
			local data = exports.DENmysql:querySingle("SELECT premium FROM accounts WHERE id=?",id)
			local dataLevel = exports.DENmysql:querySingle("SELECT premiumLevel FROM accounts WHERE id=?",id)
			local newValue, newValueLevel = data["premium"] - amount, dataLevel["premiumLevel"] - level or dataLevel["premiumLevel"]
			if (newValue <= 0) then
				return false
			end
			if (exports.DENmysql:exec("UPDATE accounts SET premium=?, premiumLevel=? WHERE id=?", newValue, level, id)) then
				outputDebugString("[Premium] "..getPlayerName(player).."'s premium was decreased to "..amount.." (Level: .."..level..") of Premium minutes.",0,0,255,0)
				return true
			else
				outputDebugString("[Premium] failed to decrease "..getPlayerName(player).." "..amount.." of Premium minutes!",0,255,0,0)
				return false
			end
		else
			return false
		end
	else
		outputChatBox("Please enter the correct details, syntax args: 'player (the player to give)', 'amount (minutes [do *60 for hours])', 'level (max 4)'", source, 255, 0, 0)
	end
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function convertTime(minutes)
local hours = 0
local seconds = 0
    repeat
        if seconds >= 60 then
            minutes = minutes + 1; seconds = seconds - 60
        elseif minutes >= 60 then
            hours = hours + 1; minutes = minutes - 60
        end
    until seconds < 60 and minutes < 60
    return hours
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function removePlayerPremium(player)
	if (isElement(player) and exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		if (exports.DENmysql:exec("UPDATE accounts SET premium=?, premiumLevel=? WHERE id=?", 0, 0, id)) then
			setElementData(player,"isPlayerPremium",false)
			setElementData(player,"Premium","No")
			return true
		else
			return false
		end
	else
		return false
	end
end

function getPremiumPaymentBonus(player,pay)
	if (not isElement(player)) then return false end
	if (type(pay) ~= "number") then return false end
	if (not exports.server:isPlayerVIP(player)) then return pay end

	return math.floor(pay*2.0)
end

addEventHandler("onPlayerLogin", root, 
	function ()
		local userData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID(source))
		if (userData.premium > 0) then
			for k, v in pairs(getElementsByType("player")) do
				exports.killmessages:outputStaffMessage("(Premium L"..userData.premiumLevel..") Player "..getPlayerName(source).." is now online. [Logged In]", v, 255, 0, 255)
			end
			exports.NGCdxmsg:createNewDxMessage("Welcome back premium member, your remaining premium hours are "..math.floor(userData.premium) / 60 .." hours.", source, 255, 0, 255)
			setElementData(source, "isPlayerPremium", true)
		end
	end
)

------ enable jetpack

addEvent("onGetJetPack",true)
function getPremJetPack(plr, cmd)
	if (doesPedHaveJetPack(plr)) then
		removePedJetPack(plr)
	end
	if (doesPedHaveJetPack(plr)) then
		removePedJetPack(plr)
	end

	if not getElementData(plr, "isPlayerPremium") then exports.NGCdxmsg:createNewDxMessage(plr,"This feature is only restricted to premium Members. You can purchase premium at shop.aurorarvg.com",255,0,0) return end
	if getElementData(plr,"isPlayerPremium") == true then
		local theDis = getNearbyPlayers(plr)
		if (cmd == true) then
			triggerClientEvent(plr, "AURvip.isPlayerUnderWater", plr)
			return
		end
		local velx, vely, velz = getElementVelocity(plr)
		--outputChatBox(velx..","..vely..","..velz, plr)
		if (isElementInWater(plr) and (velx ~= 0 and vely ~= 0 and velz ~= 0)) then
			exports.NGCdxmsg:createNewDxMessage(plr, "You must be above water to use a jetpack!", 255, 0, 0)
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
			return false
		end
		if ( exports.server:getPlayerWantedPoints( plr ) >= 10 ) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You can't use the premium jetpack while wanted!", 225, 0, 0 )
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
		elseif ( getElementZoneName ( plr, true ) == "Las Venturas" or getElementData(plr, "inLV")) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You can't use the premium jetpack inside the city of LV!", 225, 0, 0 )
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
		elseif ( getElementDimension( plr ) ~= 0 ) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You can only use a jetpack in the main world!", 225, 0, 0 )
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			end
		elseif (getElementData(plr, "copArrestedCrim")) then
			exports.NGCdxmsg:createNewDxMessage( plr, "You cannot use this feature when you have arrested a player!", 225, 0, 0 )
		else
			if (getTeamName(getPlayerTeam(plr)) == "Government" or getTeamName(getPlayerTeam(plr)) == "SWAT Team" or getTeamName(getPlayerTeam(plr)) == "Military Forces") then
				for i=1, #theDis do
					if ( exports.server:getPlayerWantedPoints(theDis[i]) >= 10 and not exports.DENlaw:isPlayerLawEnforcer(plr)) then
						exports.NGCdxmsg:createNewDxMessage( plr, "You cannot use this feature when there's nearby wanted player!", 225, 0, 0 )
						if (doesPedHaveJetPack(plr)) then
							removePedJetPack(plr)
						end
						return
					end
				end
			end
			if (doesPedHaveJetPack(plr)) then
				removePedJetPack(plr)
			else
				givePedJetPack(plr)
				setTimer(giveWeapon, 500, 1, plr, 0, 1, true)
			end
		end
	end
end
addEventHandler("onGetJetPack",root, getPremJetPack)
addCommandHandler("premjetpack", getPremJetPack)