--variables
local recover_range=100
local allPlayerVehicles = {}
local playerVehicles = {}
local idToVehicle = {}
local vehicleToID = {}
local vehiclesBrokenDown = {}
-- utility functions

function updateClientInfo(player,id,keyValueTable)
	if not isElement(player) then return false end
	triggerClientEvent(player,"CSGplayerVehicles:client.updateVehicleInfo",player,id,keyValueTable)
end

function getVehicleID(vehicle)
	return vehicleToID[vehicle]
end
function getVehicleFromID(id)
	return idToVehicle[id]
end

function getVehicleName(model)
	local name = getVehicleNameFromModel(model)
	return name
end

function getPlayerVehicleSlots(player)
	if not exports.server:isPlayerVIP(player) then
		return 15
	else
		return 20
	end
end

function getPlayerVehicles(player)
	local vehicles = exports.DENmysql:query("SELECT * FROM vehicles WHERE ownerid=?", exports.server:getPlayerAccountID(player))
	return vehicles
end

function hexToRGB(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function applyVehicleSpecials(vehicle)
	local vehID = getElementModel(vehicle)
	--[[if vehID == 401 or vehID == 503 then
		setVehicleHandling(vehicle, "mass", 1400)
		setVehicleHandling(vehicle, "turnMass", 3000)
		setVehicleHandling(vehicle, "dragCoeff", 2)
		setVehicleHandling(vehicle, "centerOfMass", { 0, -0.3, 0 } )
		setVehicleHandling(vehicle, "percentSubmerged", 70)
		setVehicleHandling(vehicle, "tractionMultiplier", 0.75)
		setVehicleHandling(vehicle, "tractionLoss", 0.85)
		setVehicleHandling(vehicle, "tractionBias", 0.45)
		setVehicleHandling(vehicle, "numberOfGears", 5)
		setVehicleHandling(vehicle, "maxVelocity", 340)
		setVehicleHandling(vehicle, "engineAcceleration", 56)
		setVehicleHandling(vehicle, "engineInertia", 100)
		setVehicleHandling(vehicle, "driveType", "awd")
		setVehicleHandling(vehicle, "engineType", "diesel")
		setVehicleHandling(vehicle, "brakeDeceleration", 17)
		setVehicleHandling(vehicle, "brakeBias", 0.51)]]
	if vehID == 526 then
		setElementData(vehicle, "vehicleType", "VIPCar")
		local handlingTable = getVehicleHandling ( vehicle )
		local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40 ) )
		setVehicleHandling ( vehicle, "numberOfGears", 5 )
		setVehicleHandling ( vehicle, "driveType", 'awd' )
		setVehicleHandling ( vehicle, "maxVelocity", newVelocity )
		setVehicleHandling ( vehicle, "engineAcceleration", handlingTable["engineAcceleration"] +8 )
	end
end

-- interacting with client's gui

-- Recover place

function isPlayerInRangeOfPoint(player,x,y,z,range)
   local x,y,z = getElementPosition(source)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end

--- recover vehicles
--local x,y,z,rot = manageParks(client)
local recoverPlaces = { -- vehicleType = {x,y,z,rotation} ( General for vehicles which are not listed )
	General =
		{
			{ 1679.09, -1054.18, 23.89, 110 },
			{ -1987.51, 250.96, 35.17, 355 },
			{ 1952.97, 2167.12, 10.82, 133 },
		},
	Plane = {
			{ 2021.44, -2619.91, 13.54, 47 },
			{ -1687.54, -254.3, 14.14, 320},
			{ 1556.43, 1320.08, 10.87, 83},
		},
	Helicopter = {
			{ 2007.4, -2444.05, 14, 180 },
			{ -1186.83, 25.94, 15, 220},
			{ 1534.27, 1735.64, 11.5, 82 },
		},
	Boat = {
			{ -34.441860198975,-1645.5932617188,0.70475423336029,112.02239990234 }, -- LS
			{ 2339.3002929688,525.060546875,1.4629640579224,172.80419921875 }, -- LV
			{ -1645.1304931641,162.55812072754,1.0076143741608,60.320922851563 }, -- SF
		},
}


local customPlaces = {  --- for skimmer plane
	Plane = {
			{ -34.441860198975,-1645.5932617188,0.70475423336029,112.02239990234 }, -- LS
			{ 2339.3002929688,525.060546875,1.4629640579224,172.80419921875 }, -- LV
			{ -1645.1304931641,162.55812072754,1.0076143741608,60.320922851563 }, -- SF
		},
}


local latestRecover = {}
local theTimers = {}

addEvent("CSGplayerVehicles.recover",true)
addEventHandler("CSGplayerVehicles.recover",root,
	function (id,model)
		local px,py,_ = getElementPosition(source)
		local vehType = getVehicleType(model)
		if not recoverPlaces[vehType] then
			vehType = "General"
		end
		local vehicle = idToVehicle[id]

		local x,y,z,rotation
		local dist
		if vehicle and isElement(vehicle) then
			if getElementModel(vehicle) ~= 460 then
				for i=1,#recoverPlaces[vehType] do
					rx,ry,rz,rRotation = unpack(recoverPlaces[vehType][i])

					if rx == 1952.97 and ry == 2167.12 and rz == 10.82 then
						rx,ry,rz,rRotation = manageParks()
					end
					local distance = getDistanceBetweenPoints2D(px,py,rx,ry)
					if not dist or distance < dist then
						dist = distance
						if isElement(vehicle) then
							x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz+math.random(0,4),rRotation -- +random for the ugly way of preventing vehicles getting stuck
						else
							x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz,rRotation -- +random for the ugly way of preventing vehicles getting stuck
						end
					end
				end

			else
				for i=1,#customPlaces[vehType] do
					if getElementModel(vehicle) == 460 then
						local rx,ry,rz,rRotation = unpack(customPlaces[vehType][i])
						local distance = getDistanceBetweenPoints2D(px,py,rx,ry)
						if not dist or distance < dist then
							dist = distance
							if isElement(vehicle) then
								x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz+math.random(0,4),rRotation -- +random for the ugly way of preventing vehicles getting stuck
							else
								x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz,rRotation -- +random for the ugly way of preventing vehicles getting stuck
							end
						end
					end
				end

			end
		end
		local name = getVehicleName(model)
		if isElement(vehicle) then
			local occupants = getVehicleOccupants(vehicle)
			for seat, occupant in pairs(occupants) do
				removePedFromVehicle(occupant) -- remove occupants
				if getElementType(occupant) == 'player' then
					exports.NGCdxmsg:createNewDxMessage(occupant,"You were removed from your vehicle because it was recovered.",255,200,0)
				end
			end

				if getElementData(source, "isPlayerVIP") then
				    if getElementData(source,"isPlayerJailed") and getElementDimension(source) ~= 0 then exports.NGCdxmsg:createNewDxMessage(source, "You can not use this recovery in jail", 225, 0, 0) return end
				    if getElementData(source,"isPlayerArrested") then exports.NGCdxmsg:createNewDxMessage(source, "You can not use this recovery while being arrested", 225, 0, 0) return end
					if getElementDimension(source) ~= 0 then exports.NGCdxmsg:createNewDxMessage(source,"You are only allowed to recover it in main dimension",255,0,0) return end
					if ( getElementInterior(source) == 0 ) then
							local attachs = getAttachedElements (vehicle)
							for k, v in ipairs (attachs) do
								if (not getElementType(v) == "player") then return false end
								triggerEvent("ungluePlayer", v)
							end

							local x, y, z = getElementPosition(source)
							local rx, ry, rz = getElementRotation(source)
							if z >= 200 then exports.NGCdxmsg:createNewDxMessage(source,"You can't recover your vehicle on this height",255,0,0) return end
							if getElementData(source,"tazed",true) then exports.NGCdxmsg:createNewDxMessage(source,"You can't recover your vehicle while tazed",255,0,0) return end
							setVehicleDamageProof(vehicle,true)
							latestRecover[getPlayerSerial(source)] = getTickCount()
							setTimer(function (veh) if isElement(veh) and getElementHealth(veh) > 2 then setVehicleDamageProof(veh,false) end end, 5000, 1,vehicle)
							setElementPosition(vehicle,x+2,y+2,z+2)
							setElementRotation(vehicle,rx,ry,rz)
							exports.NGCdxmsg:createNewDxMessage(source,"We have recovered your "..name.." in your position.",0,255,0)
						end
				else
					setVehicleDamageProof(vehicle,true)
					setTimer(function (veh) if isElement(veh) and getElementHealth(veh) > 250 then setVehicleDamageProof(veh,false) end end, 5000, 1,vehicle)
					setElementPosition(vehicle,x,y,z)
					setElementRotation(vehicle,0,0,rotation)
					exports.NGCdxmsg:createNewDxMessage(source,"Your " .. name .. " has been recovered to "..getZoneName(x,y,z),0,255,0)
				end
		else
			exports.denmysql:exec("UPDATE vehicles SET x=?,y=?,z=?,rotation=? WHERE uniqueid=?",x or rx,y or ry,z or rz,rotation or rRotation,id)
			exports.NGCdxmsg:createNewDxMessage(source,"Your " .. name .. " has been recovered to "..getZoneName(x or rx,y or ry,z or rz).." but is not spawned yet.",255,255,0)
		end
	end
)

local pendingSaleIDs = {}

addEvent("CSGplayerVehicles.sellVeh", true)
addEventHandler("CSGplayerVehicles.sellVeh", root,
	function(id,model)
		local sellings = exports.DENmysql:querySingle("SELECT sale FROM vehicles WHERE uniqueid=?",id)
		if sellings.sale == 1 then
			exports.NGCdxmsg:createNewDxMessage(source, "You can't sell this vehicles while its already for sale!", 225, 0, 0)
			return false
		end
		if isPedInVehicle(source) == true then
			local BustedVehicle = getPedOccupiedVehicle (source)
			local veh = idToVehicle[id]
			if isElement(veh) then
				if BustedVehicle == veh then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't sell your vehicle while you'r inside it!!",255,0,0)
					return false
				end
			end
		end
		if(pendingSaleIDs[id]) then return false end
		pendingSaleIDs[id] = true
		local db = exports.DENmysql:getConnection()
		dbQuery(sellVehicleCallback,{id,model,source},db,"SELECT boughtprice FROM vehicles WHERE uniqueid=?",id)
	end
)

function sellVehicleCallback(qh,id,model,player)
	local result = dbPoll(qh,0)
	if(result and result[1] and isElement(player)) then
		local price = result[1].boughtprice
		if (model == "Sandking") or (model == "Hydra") then
			sellP = 100000
		else
			sellP = getVehicleSellPrice(price,player)
		end
		local name = getVehicleName(model)
		exports.NGCdxmsg:createNewDxMessage(player, "You sold your " .. name .. " for $" .. sellP, 0, 255, 0)
		--exports.CSGaccounts:addPlayerMoney(player, sellP)
		--exports.AURpayments:addMoney(player, sellP, "Custom", "Vehicle "..name.."sold", 0, "CSGplayervehicles")
		exports.AURpayments:addMoney(player, sellP, "Custom", "Aurora Core", 0, "CSGplayervehicles ("..name..")")
		exports.DENmysql:exec("DELETE FROM vehicles WHERE uniqueid=?", id)
		local veh = idToVehicle[id]
		if isElement(veh) then
			destroyElement(veh)
			for i=1,#allPlayerVehicles do
				if allPlayerVehicles[i] == veh then
					table.remove(allPlayerVehicles,i)
					break
				end
			end
			for i=1,#playerVehicles[player] do
				if playerVehicles[player][i] == veh then
					table.remove(playerVehicles[player],i)
					break
				end
			end
		end
		updateClientInfo(player,id,false)
	else
		exports.NGCdxmsg:createNewDxMessage(player, "Something went wrong trying to sell your vehicle, please try again.", 255, 0, 0)
	end
	pendingSaleIDs[id] = nil
end

addEvent("CSGplayerVehicles.spawnVeh",true)
addEventHandler("CSGplayerVehicles.spawnVeh",root,
	function(id)
		local info = exports.denmysql:querySingle("SELECT * FROM vehicles WHERE uniqueid=?",id)
		if info.ownerid == exports.server:getPlayerAccountID(source) then
			spawnPlayerVehicle(source,info,true)
		end
	end
)

addEvent("CSGplayerVehicles.despawnVeh",true)
addEventHandler("CSGplayerVehicles.despawnVeh",root,
	function(id)
		despawnPlayerVehicle(source,id,true)
	end
)

addEvent("CSGplayerVehicles.toggleLock",true)
addEventHandler("CSGplayerVehicles.toggleLock",root,
	function (id,vehicleModel, oldLockState, silent)
		local veh = idToVehicle[id]
		local newState = 1
		local name = getVehicleName(vehicleModel)
		if isElement(veh) then
			if isPlayerInVehicle(source) then
			if getElementData(veh, "locked") then
				setElementData(veh, "locked", false)
				newState = 0 -- vehicle gets unlocked
			else
				setElementData(veh, "locked", true)
				end
			end
		else
			if oldLockState == 1 then newState = 0 end
		end
		exports.denmysql:exec("UPDATE vehicles SET locked=? WHERE uniqueid=?",newState,id)
		if not silent then
			if isPlayerInVehicle(source) then
			if newState == 1 then
				exports.NGCdxmsg:createNewDxMessage(source,"You have locked your "..name,0,255,0)
			else
				exports.NGCdxmsg:createNewDxMessage(source,"You have unlocked your "..name,0,255,0)
				end
			end
		end
		updateClientInfo(source,id,{ locked = newState })
	end
)


-- system

addEvent("CSGplayerVehicles.saleShop",true)
addEventHandler("CSGplayerVehicles.saleShop",root,
	function(player,id)
	local veh = idToVehicle[id]
		if isElement(veh) then
			destroyElement(veh)
			for i=1,#allPlayerVehicles do
				if allPlayerVehicles[i] == veh then
					table.remove(allPlayerVehicles,i)
					break
				end
			end
			for i=1,#playerVehicles[player] do
				if playerVehicles[player][i] == veh then
					table.remove(playerVehicles[player],i)
					break
				end
			end
		end
	updateClientInfo(player,id,false)
	triggerClientEvent("updateAllVehiclesGrid",player)
end)

function spawnPlayerVehicle(player, vehicleInfo, output)
	if not vehicleInfo then outputDebugString("spawnPlayerVehicle:1") return false end
	if isElement(idToVehicle[vehicleInfo.uniqueid]) then outputDebugString("spawnPlayerVehicle:2") return false end -- already spawned
	if not isElement(player) then outputDebugString("spawnPlayerVehicle:3") return false end -- no owner
	if not playerVehicles[player] then playerVehicles[player] = {} end

	if #playerVehicles[player] >= 2 then
		if output then
			exports.NGCdxmsg:createNewDxMessage(player, "You can only spawn 2 vehicles at the same time!", 225, 0, 0)
		end
		return false;
	end
	if vehicleInfo.sale == 1 then
		if output then
			exports.NGCdxmsg:createNewDxMessage(player, "You can't spawn vehicle is already added for sale!", 225, 0, 0)
		end
		return false;
	end

	local vehElement = createVehicle(vehicleInfo.vehicleid, vehicleInfo.x, vehicleInfo.y, vehicleInfo.z, 0, 0, vehicleInfo.rotation,vehicleInfo.licenseplate or "  NGC ")
	table.insert(playerVehicles[player],vehElement)
	table.insert(allPlayerVehicles,vehElement)
	vehicleToID[vehElement] = vehicleInfo.uniqueid
	idToVehicle[vehicleInfo.uniqueid] = vehElement
	setElementData(vehElement, "vehicleOwner", player)
	setElementData(vehElement, "vehicleType", "playerVehicle")
	setElementData(vehElement, "vehicleFuel", vehicleInfo.fuel)
	setElementData(vehElement, "vehicleID", vehicleInfo.uniqueid)
	setElementData(vehElement, "sellPrice", vehicleInfo.boughtprice)
	setElementData(vehElement, "vehicleSpawn", getTickCount())

	applyVehicleSpecials(vehElement)
	local color1r,color1g,color1b = hexToRGB(vehicleInfo.color1)
	local color2r,color2g,color2b = hexToRGB(vehicleInfo.color2)
	setVehicleColor(vehElement,color1r,color1g,color1b,color2r,color2g,color2b)
	if vehicleInfo.wheelstates then
		local wheelStates = split(vehicleInfo.wheelstates, ",")
		setVehicleWheelStates(vehElement, unpack(wheelStates))
	end
	if vehicleInfo.vehiclemods then
		local upgrades = fromJSON(vehicleInfo.vehiclemods)
		if upgrades then
			for _,upgrade in pairs(upgrades) do
				addVehicleUpgrade(vehElement, upgrade)
			end
		end
	end
	if type( vehicleInfo.paintjob ) == 'number' and vehicleInfo.paintjob < 3 then
		setVehiclePaintjob(vehElement, vehicleInfo.paintjob)
	end
	if vehicleInfo.vehiclehealth and tonumber(vehicleInfo.vehiclehealth) <= 250 then
		setElementHealth(vehElement, 251)

		setVehicleEngineState(vehElement, false)
		setVehicleDamageProof(vehElement, true)
		--setElementFrozen(vehElement,true)
		vehiclesBrokenDown[vehElement] = true

	elseif vehicleInfo.vehiclehealth and tonumber(vehicleInfo.vehiclehealth) > 251 then
		setElementHealth(vehElement, vehicleInfo.vehiclehealth)
	else
		setElementHealth(vehElement, 251)
		setTimer(function(plr,veh)
		setElementHealth(veh, 251)
		end,3000,1,player,vehElement)
	end
	--addEventHandler("onVehicleDamage", vehElement, vehicleDamage)
	if vehicleInfo.locked and vehicleInfo.locked == 1 then
		setElementData(vehElement, "locked", true)
	end

	--if exports.AURvehicletune:getHandlingData(vehElement) then
		if vehicleInfo.tune then
			--exports.AURvehicletune:setHandlingData(vehElement, vehicleInfo.tune)
			setHandlingData(vehElement, vehicleInfo.tune)
		end
		if vehicleInfo.vehNeon then
			setElementData(vehElement,"tuning.neon",vehicleInfo.vehNeon)
			triggerClientEvent(root, "tuning->Neon", root, vehElement,vehicleInfo.vehNeon)
		end
		if vehicleInfo.custom then
			--exports.AURvehiclepaints:addVehicleShader(vehElement, vehicleInfo.custom)
			if vehicleInfo.custom then
                if vehicleInfo.custom then
					---outputDebugString("Has custom "..vehicleInfo.custom)
                    setElementData(vehElement,"tuning.CustomPaint",vehicleInfo.custom)
					triggerClientEvent(root, "tuning->CustomPaint", root, vehElement,vehicleInfo.custom)
                end
            end
		end
	--end
	exports.DENmysql:exec("UPDATE vehicles SET spawned=? WHERE uniqueid=?",1,vehicleInfo.uniqueid)
	if output then
		local name = getVehicleName(vehicleInfo.vehicleid)
		exports.NGCdxmsg:createNewDxMessage(player,"Your "..name.." has been spawned!",0,255,0)
	end
	updateClientInfo(player,vehicleInfo.uniqueid,{ element = vehElement })

	return vehElement
end

function getPlayerVehicleInfo(vehicleElement)

	local x,y,z = getElementPosition(vehicleElement)
	local _,_,rz = getElementRotation(vehicleElement)
	local health = getElementHealth(vehicleElement)
	local paintjob = getVehiclePaintjob(vehicleElement)
	local r1,g1,b1,r2,g2,b2 = getVehicleColor(vehicleElement, true)
	local color1 = exports.server:convertRGBToHEX(r1,g1,b1)
	local color2 = exports.server:convertRGBToHEX(r2,g2,b2)
	local ws1, ws2, ws3, ws4 = getVehicleWheelStates(vehicleElement)
	local wheelStates = table.concat({ws1,ws2,ws3,ws4},",")
	local fuel = getElementData(vehicleElement, "vehicleFuel") or 100
	if not fuel then fuel = 0 end
	fuel = math.floor(fuel) or 100
	local upgrades = toJSON(getVehicleUpgrades(vehicleElement))
	local locked = getElementData(vehicleElement, "locked")
	if ( locked ) then
		locked = 1
	else
		locked = 0
	end

	return {x = x,y = y,z = z,rotation = rz,health = health,paintjob = paintjob,color1 = color1,color2 = color2,wheelstates = wheelStates,fuel = fuel, upgrades = upgrades,locked = locked}
end
local timers = {}

function despawnPlayerVehicle(player,id, output)
	local vehicleElement = idToVehicle[id]
	if not isElement(vehicleElement) then return false end
	if isElement(player) then
		if isPedInVehicle(player) == true then
			local BustedVehicle = getPedOccupiedVehicle (player)
			if BustedVehicle == vehicleElement then
				exports.NGCdxmsg:createNewDxMessage(player,"You can't despawn your vehicle while you'r inside it!!",255,0,0)
				return false
			end
		end
	end
	for seat, occupant in pairs(getVehicleOccupants(vehicleElement)) do
		if seat > 0 then
			--exports.NGCdxmsg:createNewDxMessage(player,"You can't despawn your vehicle while someone inside it!!",255,0,0)
			removePedFromVehicle(occupant)
		else
			--local driver = getVehicleOccupant ( vehicleElement )
			removePedFromVehicle(occupant)
		end
	end
	local customPaintjob = 0
	local vehNeon = 0
	local tunningflags = getHandlingData(vehicleElement)
	--exports.AURvehiclepaints:removeVehicleShader(vehicleElement)
	if getElementData(vehicleElement,"tuning.CustomPaint") then
		customPaintjob = getElementData(vehicleElement,"tuning.CustomPaint")
	else
		customPaintjob = 0
	end

	if getElementData(vehicleElement,"tuning.neon") then
		vehNeon = getElementData(vehicleElement,"tuning.neon")
	else
		vehNeon = 0
	end
	if isTimer(timers[player]) then killTimer(timers[player]) end
	timers[player] = setTimer(function(player,id,output,vehicleElement)
	if isElement(player) then triggerEvent("CSGplayervehicles.despawned",player,vehicleElement) end
	-- get info to save into database
	local info = getPlayerVehicleInfo(vehicleElement)

	local update = exports.DENmysql:exec(
	"UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=?,vehiclemods=?, locked=?, spawned=?,custom=?,vehNeon=?,tune=? WHERE uniqueid=?",
	info.x, info.y, info.z, info.rotation, info.health, info.paintjob, info.color1, info.color2, info.wheelstates, info.fuel,info.upgrades,info.locked,0,customPaintjob,vehNeon,tunningflags,id)
	idToVehicle[id] = nil
	for i=1,#allPlayerVehicles do
		if allPlayerVehicles[i] == vehicleElement then
			table.remove(allPlayerVehicles,i)
			break
		end
	end
	if isElement(player) and playerVehicles[player] then
		for i=1,#playerVehicles[player] do
			if playerVehicles[player][i] == vehicleElement then
				table.remove(playerVehicles[player],i)
				break
			end
		end
	else
		playerVehicles[player] = nil
	end
	vehicleToID[vehicleElement] = nil

	updateClientInfo(player,id,{ element = false })
	--updateClientInfo(player,id,{ vehiclehealth = info.health })
	--updateClientInfo(player,id,info)
	updateClientInfo(player,id,{ vehiclehealth = info.health })
	if output then
		local name = getVehicleName(getElementModel(vehicleElement))
		exports.NGCdxmsg:createNewDxMessage(player,"Your "..name.." has been despawned!",0,255,0)
	end


	destroyElement(vehicleElement)
	end,2000,1,player,id,output,vehicleElement)
end
hidePlayerVehicle = despawnPlayerVehicle -- exports

function createPlayerVehicle(player, vehicleModel, playerID, health, price, color1, color2, posX, posY, posZ, rotZ, licensePlate)

	-- add vehicle
	if not playerVehicles[player] then playerVehicles[player] = {} end
	if #playerVehicles[player] >= 2 then
		exports.NGCdxmsg:createNewDxMessage(player, "You can't buy vehicle while you have 2 vehicles spawned at the same time!", 225, 0, 0)
		return false
	end
	takePlayerMoney(player,price)
	local insert = exports.DENmysql:exec(
	"INSERT INTO vehicles SET vehicleid=?, ownerid=?, vehiclehealth=?, boughtprice=?, color1=?, color2=?, x=?, y=?, z=?, rotation=?, licenseplate=?, spawned=?, locked=?",
	vehicleModel, playerID, health, price, color1, color2, posX, posY, posZ, rotZ, licensePlate,0,0)
	local insertInfo = exports.DENmysql:querySingle("SELECT MAX(uniqueid) AS id FROM vehicles") -- get inserted ID
	local vehicleID
	if insertInfo and insertInfo.id then
		vehicleID = insertInfo.id
	else
		exports.NGCdxmsg:createNewDxMessage(player,"Something went wrong with getting your vehicle id, please report this to admin.",255,0,0)
		exports.NGCdxmsg:createNewDxMessage(player,"To use your new vehicle please reconnect.",255,255,0)
		outputDebugString("CSGplayervehicles-purchase-wrong: "..tostring(insertInfo).." - "..tostring((insertInfo or {}).id))
		return false
	end
	-- initiate vehicle info, to spawn vehicle with.
	local sellPrice = getVehicleSellPrice(price,player)
	local info = {
		uniqueid = vehicleID,
		vehicleid = vehicleModel,
		x = posX,
		y = posY,
		z = posZ,
		sellPrice = sellPrice,
		rotation = rotZ,
		licenseplate = licensePlate,
		vehiclehealth = health,
		color1 = color1,
		color2 = color2,
		locked = 0,
	}
	local veh = spawnPlayerVehicle(player, info, false)
	outputDebugString("CSGplayervehicles:boughtElement:"..tostring(veh))
	local name = getVehicleName(vehicleModel)
	if isElement(veh) then
		exports.NGCdxmsg:createNewDxMessage(player,"Your newly bought "..name.." has been spawned!",0,255,0)
		warpPedIntoVehicle(player,veh)
		updateClientInfo(player,vehicleID,info)
	end

	return veh -- return vehicle to shop, so it can mess with it
end

-- manage events, save vehicles
function sendPlayerVehicleInfo(player)
	local accountID = exports.server:getPlayerAccountID(player)
	local vehicles = exports.denmysql:query("SELECT * FROM vehicles WHERE ownerid=?",accountID)
	if #vehicles > 0 then
		local elements = {}
		for i=1,#vehicles do
			if vehicles[i].spawned == 1 then
				elements[i] = spawnPlayerVehicle(player,vehicles[i],false)
			end
			vehicles[i].sellPrice = getVehicleSellPrice(vehicles[i].boughtprice,player)
			vehicles[i].boughtprice = false
		end
		triggerClientEvent(player,"CSGplayerVehicles:client.receiveVehicles",player,vehicles,elements)
	end
end



function getExtraMod(vehicleElement)
	local tunningflags = getHandlingData(vehicleElement)
	if getElementData(vehicleElement,"tuning.CustomPaint") then
		customPaintjob = getElementData(vehicleElement,"tuning.CustomPaint")
	else
		customPaintjob = 0
	end
	if getElementData(vehicleElement,"tuning.neon") then
		vehNeon = getElementData(vehicleElement,"tuning.neon")
	else
		vehNeon = 0
	end
	return customPaintjob,vehNeon,tunning
	--custom=?,vehNeon=?,tune
end

addEventHandler("onPlayerLogin",root,
	function ()
		if not playerVehicles[source] then
			playerVehicles[source] = {}
			sendPlayerVehicleInfo(source)
		end
	end
)
addEventHandler("onResourceStart",resourceRoot,
	function ()
		local players = getElementsByType("player")
		for i=1,#players do
			setTimer(sendPlayerVehicleInfo,i*1500,1,players[i])
		end
	end
)

addEventHandler("onResourceStop",resourceRoot,
	function ()
		for i=1,#allPlayerVehicles do
			local info = getPlayerVehicleInfo(allPlayerVehicles[i])
			local id = vehicleToID[allPlayerVehicles[i]]
			local paint,neon,tunes = getExtraMod(allPlayerVehicles[i])
			local update = exports.DENmysql:exec(
			"UPDATE vehicles SET x=?, y=?, z=?, rotation=?, vehiclehealth=?, paintjob=?, color1=?, color2=?, wheelstates=?, fuel=?,vehiclemods=?, locked=?, spawned=?,custom=?, vehNeon=?, tune=? WHERE uniqueid=?",
			info.x, info.y, info.z, info.rotation, info.health, info.paintjob, info.color1, info.color2, info.wheelstates, info.fuel,info.upgrades,info.locked,1,paint,neon,tunes,id)
			destroyElement(allPlayerVehicles[i])
		end
	end
)


function vehicleDamage(loss)
	if getElementData(source,"vehicleID") then
		if getElementHealth(source) - loss <= 251 and not isVehicleDamageProof(source) then
			local occupants = getVehicleOccupants(source)
			for i=0,#occupants do
				exports.NGCdxmsg:createNewDxMessage(occupants[i],"This vehicle is too damaged. Engine shutting down.",255,255,0)
			end
			--setElementFrozen(source,true)
			setElementHealth(source,250)
			setVehicleEngineState(source, false)
			vehiclesBrokenDown[source] = true
		end
	end
end

addEventHandler("onVehicleExplode",root,
	function()
		local veh = source
		local id = getElementData(source,"vehicleID")
		local owner = getElementData(source,"vehicleOwner")
		if (id) then
			local x,y,z = getElementPosition(source)
			local _,_,rz = getElementRotation(source)
			--exports.DENmysql:exec("UPDATE vehicles SET vehiclehealth=?, x=?,y=?,z=?,rotation=? WHERE uniqueid=?",0,x,y,z,rz,id)
			setElementHealth(veh,250)
			despawnPlayerVehicle(owner,id, false)
			local info = exports.denmysql:querySingle("SELECT * FROM vehicles WHERE uniqueid=?",id)
			setTimer(function(owner) if isElement(owner) then spawnPlayerVehicle(owner,info,false) end end,6000,1,owner)
		end
	end
)

addEventHandler("onVehicleEnter",root,
	function(player,seat)
	local id = getElementData(source,"vehicleID")
	if id then
		local pTeam = getPlayerTeam(player)
		local fuel = getElementData(source,"vehicleFuel") or 100
		if not fuel then fuel = 0 end
		if ( math.floor( getElementHealth(source) /10 ) <= 25 ) or ( fuel and fuel <= 0) then
			exports.NGCdxmsg:createNewDxMessage(player,"This vehicle is broken and/or out of fuel",255,255,0)
			setVehicleDamageProof(source,true)
			--setElementFrozen(source,true)
			--setElementHealth(source,250)
			setVehicleEngineState(source, false)
			--vehiclesBrokenDown[source] = true
		elseif ( vehiclesBrokenDown[source] ) then
			setVehicleDamageProof(source,false)
			--setElementFrozen(source,false)
			--vehiclesBrokenDown[source] = false
		end
	end
end)

addEvent("onVehicleGetFixed",true)
addEventHandler("onVehicleGetFixed",root,function(vehicle)
	local id = getElementData(vehicle,"vehicleID")
	if id then
		setVehicleEngineState(vehicle, true)
		setVehicleDamageProof(vehicle,false)
		vehiclesBrokenDown[vehicle] = false
	end
end)

addEventHandler("onPlayerQuit",root,
	function ()
		local vehs = playerVehicles[source]
		if vehs then
			for i=1,#vehs do
				local occupants = getVehicleOccupants(vehs[i])
				for seat=0, #occupants do
					exports.NGCdxmsg:createNewDxMessage(occupants[seat],"The owner of this vehicle has logged off. The vehicle will be despawned in 10 seconds.",255,255,0)
				end
				setTimer(despawnPlayerVehicle, 5000, 1, false,vehicleToID[vehs[i]]) -- despawn vehicle in 10 seconds, supply no player and give the vehicle id.


				despawnPlayerVehicle(source,vehicleToID[vehs[i]],true)
				--local vehicleElement = idToVehicle[vehicleToID[vehs[i]]]
				--if isElement(vehicleElement) then destroyElement(vehicleElement) end
			end
		end
	end
)

-- law cars

local givenstars = {}
local copCarIDs = {
	[596] = true,
	[597] = true,
	[599] = true,
	[598] = true,
	[426] = true,
	[415] = true,
	[427] = true,
	[433] = true,
	[490] = true,
	[528] = true,
	[579] = true
}

addEventHandler("onVehicleEnter",root,
	function(player,seat)
	local vehOccupation = getElementData(source,"vehicleTeam")
	if seat == 0 and vehOccupation and (vehOccupation == "Government") or (vehOccupation == "Military Forces") or (vehOccupation == "Air Forces") or (vehOccupation == "SWAT Team") then
		if exports.DENlaw:isLaw(player) then
			if getElementData(player,"skill") == "High Speed Unit" then
				if getVehicleType(source) == "Automobile" then
					setVehicleHandling(source,"maxVelocity",200)
					setVehicleHandling(source,"engineAcceleration",15)
				end
			end
		elseif getElementData(source,"vehicleOccupation") ~= "Criminal" and ( not givenstars[source] or getTickCount()-givenstars[source] > 30000 ) then
			givenstars[source] = getTickCount()
			if not (exports.server:isPlayerArrested(player)) then
				exports.CSGwanted:addWanted(player,10,getRandomPlayer())
			end
		end
	end
end
)

addEventHandler("onVehicleExit",root,
	function(player)
		local model = getElementModel(source)
		if (copCarIDs[model]) then
			local unit = false
			for _,occupant in ipairs(getVehicleOccupants(source)) do
				if getElementData(occupant,"skill") == "High Speed Unit" then
					unit = true
					break
				end
			end
			if not unit then
				setVehicleHandling(source,"maxVelocity",200)
				setVehicleHandling(source,"engineAcceleration",10)
			end
		end
	end
)

-- more useless exports

getVehicleUpgradesJSON = function(veh)
local upgrades = {}
local anyUpgrade = false
	for slot = 0, 16 do
		local upgrade = getVehicleUpgradeOnSlot(veh, slot)
		if upgrade then
			upgrades[slot] = upgrade
			anyUpgrade = true
		end
	end
	if anyUpgrade then
		return toJSON(upgrades)
	else
		return "NULL"
	end
end


onSaveVehicleUpgrades = function(veh, id)
	if exports.DENmysql:exec("UPDATE vehicles SET vehiclemods=? WHERE uniqueid=?", getVehicleUpgradesJSON(veh), id) then
		return true
	else
		return false
	end
end


----------- vehicles parks on recovery

local pk = {}
local parks = {
[1]={ 1949.62, 2171.23, 10.82},
[2]={ 1949.62, 2167.23, 10.82},
[3]={ 1949.62, 2162.23, 10.82},
[4]={ 1949.62, 2158.23, 10.82},
[5]={ 1949.62, 2152.23, 10.82},
[6]={ 1949.62, 2154.23, 10.82},
[7]={ 1959.62, 2171.23, 10.82},
[8]={ 1959.62, 2167.23, 10.82},
[9]={ 1959.62, 2162.23, 10.82},
[10]={ 1959.62, 2158.23, 10.82},
[11]={ 1959.62, 2152.23, 10.82},
[12]={ 1959.62, 2154.23, 10.82},
}




function parking(hitElement,matchd)
	if not matchd then return false end
	if hitElement and getElementType(hitElement) == "vehicle" then
		if getElementData(source,"pkTime") == false then
			setElementData(source,"pkTime",true)
			setElementData(source,"ownedx",hitElement)
			for k,v in ipairs(pk) do
				if v == source then
					table.remove(pk,k)
					pk[v] = nil
				end
			end
		end
	end
end

addEventHandler("onElementDestroy",root,function()
	if source and getElementType(source) == "vehicle" then
		for k,v in ipairs(pk) do
			if getElementData(v,"ownedx") == source then
			setElementData(v,"pkTime",false)
			removeElementData(v,"ownedx")
			table.insert(pk,v)
			--setElementData(v,"busyID",#pk+1)
			end
		end
	end
end)


function exparking(hitElement,matchd)
	if not matchd then return false end
	if hitElement and getElementType(hitElement) == "vehicle" then
		if getElementData(source,"pkTime") == true then
			setElementData(source,"pkTime",false)
			table.insert(pk,v)
			--setElementData(source,"busyID",#pk+1)
		end
	end
end




function manageParks()
	if pk and #pk >= 1 then
		for i=1,#pk do
			if getElementData(pk[i],"pkTime") == false then
				local x,y,z = getElementPosition(pk[i])
				--setElementPosition(client,x,y+6,z+2)
				return x,y,z,88
			else
				--setElementPosition(client, 1944.52, 2163.11, 10.82)
				return  1944.52, 2163.11, 10.82,182
			end
		end
	else
		--setElementPosition(client, 1944.52, 2163.11, 10.82)
		return 1944.52, 2163.11, 10.82,182
	end
end

	for k,v in pairs(parks) do
		markerD = createMarker(v[1],v[2],v[3],"cylinder",2,255,255,255,0 )
		setElementData(markerD,"busyID",k)
		table.insert(pk,markerD)
		addEventHandler("onMarkerHit",markerD,parking)
		addEventHandler("onMarkerLeave",markerD,exparking)
	end




local compress = true


local gname = {
    [1] = "engineType",
    [2] = "engineAcceleration",
    [3] = "numberOfGears",
    [1] = "driveType",
    [2] = "handlingFlags",
    [3] = "suspensionForceLevel",
    [4] = "suspensionDamping",
    [5] = "suspensionUpperLimit",
    [6] = "suspensionLowerLimit",
    [7] = "suspensionFrontRearBias",
    [8] = "brakeDeceleration",
    [9] = "tractionBias",
    [10] = "tractionMultiplier",
    [11] = "tractionLoss",
    [12] = "brakeBias",
    [13] = "mass",
    [14] = "dragCoeff",
    [15] = "turnMass",
    [16] = "suspensionAntiDiveMultiplier",
    [17] = "steeringLock",
    [18] = "engineAcceleration",
    [19] = "maxVelocity",
    [20] = "suspensionHighSpeedDamping",
    [21] = "engineInertia",
}

function toCode(theData, theVehicle)
    local theString = ""

    local defaultCarData = getOriginalHandling(getElementModel(theVehicle))
    for i, v in ipairs(gname) do
        if (theData[v] ~= defaultCarData[v]) then
            local val = tostring(i).."_"..tostring(theData[v])
            theString = theString.." "..val
        end
    end

    if (compress) then
        theString = theString:gsub("0000", "%*")
        theString = theString:gsub("00", "%/")
        theString = theString:gsub("99999", "%=")
        theString = theString:gsub("9999", "%^")
        theString = theString:gsub("99", "%+")
    end

    return theString
end

function fromCode(theString)
    theString = tostring(theString)

    if (compress) then
        theString = theString:gsub("%*", "0000")
        theString = theString:gsub("%/", "00")
        theString = theString:gsub("%=", "99999")
        theString = theString:gsub("%^", "9999")
        theString = theString:gsub("%+", "99")
    end

    local theData = {}
    for v in string.gmatch(theString, "%S+") do
        local vs = {}
        local y, z = string.find(v, "_")
		if y and z then
			vs[1] = tonumber(string.sub(v, 1, y-1)) -- gname index
			vs[2] = string.sub(v, z+1) -- setting value

			if (tostring(tonumber(vs[2])) == vs[2]) then
				vs[2] = tonumber(vs[2])
			end
			theData[gname[vs[1]]] = vs[2]
		end
    end

    return theData
end


-- SET

function injectCarData(theCar, theValue)
    if (not isElement(theCar)) then return false end
    for i, v in pairs(theValue) do
        setVehicleHandling(theCar, i, v)
    end
end


function setHandlingData(theVehicle, theValue)
    if (not theVehicle) then return false end
    injectCarData(theVehicle, fromCode(tostring(theValue)))
    return true
end

-- GET
function getHandlingData(theVehicle)
    if (not isElement(theVehicle)) then return false end
    return toCode(getVehicleHandling(theVehicle), theVehicle)
end
