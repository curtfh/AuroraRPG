speedsTable = {
[ 20 ] = 22,
[ 30 ] = 33,
[ 40 ] = 44,
[ 50 ] = 56,
[ 60 ] = 67,
[ 70 ] = 78,
[ 80 ] = 89,
[ 90 ] = 100,
[ 100 ] = 112,
[ 110 ] = 123,
[ 120 ] = 134,
[ 130 ] = 146,
[ 140 ] = 157,
[ 150 ] = 168,
[ 160 ] = 179,
[ 170 ] = 190,
[ 180 ] = 200,
[ 190 ] = 210,
[ 200 ] = 220,
[ 210 ] = 230,
[ 220 ] = 240,
[ 230 ] = 245,
[ 240 ] = 250,
[ 250 ] = 255,
[ 260 ] = 260
}

cruisers = {}

function math.round(number, decimals)
	local decimals = decimals or 0
	return tonumber(( "%." .. decimals .. "f"):format(number)) 
end

function getElementSpeed(element)
	if (isElement(element)) then
		local x, y, z = getElementVelocity(element)
		return ( x ^ 2 + y ^ 2 + z ^ 2 ) ^ 0.5 * 1.61 * 100
	end
end

function binaryToHexadecimal(s)
	local s = tostring(s)
	local bin2hex = {
		["0000"] = "0",
		["0001"] = "1",
		["0010"] = "2",
		["0011"] = "3",
		["0100"] = "4",
		["0101"] = "5",
		["0110"] = "6",
		["0111"] = "7",
		["1000"] = "8",
		["1001"] = "9",
		["1010"] = "A",
		["1011"] = "B",
		["1100"] = "C",
		["1101"] = "D",
		["1110"] = "E",
		["1111"] = "F"
	}
	local l = 0
	local h = ""
	local b = ""
	local rem
	l = string.len(s)
	rem = l % 4
	l = l - 1
	h = ""
	if (rem > 0) then
		s = string.rep("0", 4 - rem) .. s
	end
	for i = 1, l, 4 do
		b = string.sub(s, i, i + 3)
		h = h .. bin2hex[b]
	end
	return h
end

function hexadecimalToBinary(s)
	local s = tostring(s)
	local hex2bin = {
		["0"] = "0000",
		["1"] = "0001",
		["2"] = "0010",
		["3"] = "0011",
		["4"] = "0100",
		["5"] = "0101",
		["6"] = "0110",
		["7"] = "0111",
		["8"] = "1000",
		["9"] = "1001",
		["a"] = "1010",
		["b"] = "1011",
		["c"] = "1100",
		["d"] = "1101",
		["e"] = "1110",
		["f"] = "1111"
	}
	local ret = ""
	local i = 0
	for i in string.gfind(s, ".") do
		i = string.lower(i)
		ret = ret .. hex2bin[i]
	end
	return ret
end

function cruiseClose(vehicle)
	if (getElementData(vehicle, "originalHandling")) then
		local handling = getElementData(vehicle, "originalHandling")
		setVehicleHandling(vehicle, "maxVelocity", handling["maxVelocity"])
		setVehicleHandling(vehicle, "numberOfGears", handling["numberOfGears"])
		setVehicleHandling(vehicle, "handlingFlags", handling["handlingFlags"])
	end
end

function cruiseBind(p)
	if (not isPedInVehicle(p)) then
		if (cruisers[p]) then
			cruisers[p] = nil
			toggleControl(p, "accelerate", true)
			toggleControl(p, "brake_reverse", true)
			toggleControl(p, "handbrake", true)
		end
		return false 
	end
	local veh = getPedOccupiedVehicle(p)
	if (getVehicleOccupant(veh, 0) ~= p) then
		if (cruisers[p]) then
			cruisers[p] = nil
			toggleControl(p, "accelerate", true)
			toggleControl(p, "brake_reverse", true)
			toggleControl(p, "handbrake", true)
		end
		return false 
	end
	if (cruisers[p]) then
		cruiseClose(veh)
		cruisers[p] = nil
		setControlState(p, "accelerate", false)
		toggleControl(p, "accelerate", true)
		toggleControl(p, "brake_reverse", true)
		toggleControl(p, "handbrake", true)
		outputChatBox("Cruise Control: You have stopped cruising", p, 255, 255, 0)
		return false
	end
	if (getElementSpeed(veh) < 20) then
		outputChatBox("Get 20KPH at least to cruise!", p, 255, 255, 0)
		return false
	end
	cruiseP(p, veh)
	outputChatBox("Cruise Control: You have started cruising", p, 255, 255, 0)
	cruisers[p] = true
end

function cruiseP(player, vehicle)
	local speed = math.round(getElementSpeed(vehicle))
	local maxSpeed = speedsTable[math.ceil(speed / 10) * 10]
	local maxVelocity = getVehicleHandling(vehicle)["maxVelocity"]

	if (not maxSpeed or not maxVelocity) then 
		return false
	end
	
	if (maxSpeed >= maxVelocity) then 
		maxSpeed = maxVelocity 
	end
	
	setElementData(vehicle, "originalHandling", getVehicleHandling(vehicle), false)
	setVehicleHandling(vehicle, "maxVelocity", maxSpeed)
	setControlState(player, "accelerate", true)
	toggleControl(player, "accelerate", false)
	toggleControl(player, "brake_reverse", false)
	toggleControl(player, "handbrake", false)
	local handlingFlags = string.reverse(string.format("%X", getVehicleHandling(vehicle)["handlingFlags"]))
	
	while string.len(handlingFlags) < 8 do
		handlingFlags = handlingFlags .. "0"
	end
	
	local newHandlingFlags = "0x" .. string.reverse(string.sub(handlingFlags, 1, 6) .. binaryToHexadecimal(string.sub(hexadecimalToBinary(string.sub(handlingFlags, 7, 7)), 1, 3) .. 1) .. string.sub(handlingFlags, 8))
	setVehicleHandling(vehicle, "handlingFlags", tonumber(newHandlingFlags))
end

function cruiseKey(p)
	if (cruisers[p]) then
		setControlState(p, "accelerate", true)
		toggleControl(p, "accelerate", false)
		toggleControl(p, "brake_reverse", false)
		toggleControl(p, "handbrake", false) 
	end
end

function bindKeyP(p)
	bindKey(p, "c", "down", cruiseBind)
	bindKey(p, "accelerate", "down", cruiseKey)
	bindKey(p, "brake_reverse", "down", cruiseKey)
	bindKey(p, "handbrake", "down", cruiseKey)
end

function resourceStart()
	for _, player in ipairs(getElementsByType("player")) do
		bindKeyP(player)
	end
end
addEventHandler("onResourceStart", resourceRoot, resourceStart)

function login()
	bindKeyP(source)
end
addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", root, login)

function resourceStop()
	for _, player in ipairs(getElementsByType("player")) do
		if (cruisers[player]) then 
			cruisers[player] = nil
			toggleControl(player, "accelerate", true)
			toggleControl(player, "brake_reverse", true)
			toggleControl(player, "handbrake", true)
		end
	end
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		if (getElementData(vehicle, "originalHandling")) then
			local handling = getElementData(vehicle, "originalHandling")
			setVehicleHandling(vehicle, "maxVelocity", handling["maxVelocity"])
			setVehicleHandling(vehicle, "numberOfGears", handling["numberOfGears"])
			setVehicleHandling(vehicle, "handlingFlags", handling["handlingFlags"])
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, resourceStop)

function vehicleExit(player, seat)
	if (seat == 0 and cruisers[player]) then
		cruiseClose(source)
		cruisers[player] = nil
		toggleControl(player, "accelerate", true)
		toggleControl(player, "brake_reverse", true)
		toggleControl(player, "handbrake", true)
		setControlState(player, "accelerate", false)
	end
end
addEventHandler("onVehicleExit", root, vehicleExit)

function driverDied()
	if (cruisers[source]) then
		cruisers[source] = nil
		toggleControl(source, "accelerate", true)
		toggleControl(source, "brake_reverse", true)
		toggleControl(source, "handbrake", true)
		setControlState(source, "accelerate", false)
	end
end
addEventHandler("onPlayerWasted", root, driverDied)