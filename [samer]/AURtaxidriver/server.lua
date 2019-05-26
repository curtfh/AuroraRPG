local taxiCars = {
	[420]=true, -- taxi
	[438]=true, -- cabbie
}

local pos = {
	[1] = {-1534.01, 975.73, 7.19,113.00604248047},
	[2] = {-1672.14, 1298.75, 7.18,129.22711181641},
	[3] = {-1969.4, 1322.6, 7.25,173.72088623047},
	[4] = {-2618.17, 1356.44, 7.11,269.52923583984},
	[5] = {-2834.61, 949.49, 44.09,280.25518798828},
	[6] = {-2859.81, 471.07, 4.35,266.15509033203},
	[7] = {-2803.08, -105.95, 7.18,85.455810546875},
	[8] = {-2798.43, -470.38, 7.18,143.56796264648},
	[9] = {-2598.93, -146.65, 4.33,93.216735839844},
	[10] = {-2508.23, -117.05, 25.61,274.54254150391},
	[11] = {-2395.35, -63.72, 35.32,174.8291015625},
	[12] = {-2018.58, -76.1, 35.32,0},
	[13] = {-1995.83, 137.98, 27.68,269.76998901367},
	[14] = {-1995, 491.37, 35.16,84.756744384766},
	[15] = {-1991.68, 722.39, 45.44,359.52926635742},
	[16] = {-1995.67, 881.06, 45.44,90.396789550781},
	[17] = {-1874.95, 1087.61, 45.44,85.455810546875},
	[18] = {-2164.43, 1167.4, 55.72,1.2641296386719},
	[19] = {-1757.2, -107.78, 3.71,173.02154541016},
	[20] = {-1804.82, -134.56, 6.07,269.6741027832},
	[21] = {-2244.19, 215.89, 35.32,89.674072265625},
	[22] = {-2308.58, 407.65, 35.17,313.99945068359},
	[23] = {-2371.81, 556.56, 24.89,0.37322998046875},
	[24] = {-2208.92, 574.55, 35.17,177.31231689453},
	[25] = {-2133.16, 655.61, 52.36,89.505676269531},
	[26] = {-2116.7, 737.04, 69.56,182.01234436035},
	[27] = {-2082.88, 814.47, 69.56,177.69818115234},
	[28] = {-2520.35, 822.34, 49.97,87.457336425781},
	[29] = {-2585.54, 802.1, 49.98,357.77059936523},
	[30] = {-2734.43, 574.95, 14.55,178.63818359375},
}

maleSkins = {0, 1, 2, 7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 306, 307, 308, 309, 310, 311, 312}

local drops = {

	[1] = {-2705.32, 405.87, 4.36,0},
	[2] = {-2612.63, 209.9, 5.39,5.3632202148438},
	[3] = {-2536.6, 141.25, 16.26,207.38562011719},
	[4] = {-2453.61, 137.94, 34.96,312.86773681641},
	[5] = {-2151.66, 188.6, 35.32,270.80828857422},
	[6] = {-1992.46, 291.52, 34.14,161.62219238281},
	[7] = {-1815.04, 161.22, 14.97,272.35162353516},
	[8] = {-1569.61, 667.7, 7.18,268.10977172852},
	[9] = {-1523.39, 838.09, 7.18,81.216461181641},
	[10] = {-1859.07, 1380.58, 7.18,183.12316894531},
	[11] = {-2373.03, 1215.29, 35.27,274.06314086914},
	[12] = {-2492.61, 1206.05, 37.42,205.99671936035},
	[13] = {-2585.23, 1360.75, 7.19,223.06184387207},
	[14] = {-2866.89, 734.93, 30.07,276.08825683594},
	[15] = {-2754.53, 376.32, 4.13,268.32730102539},
	[16] = {-2711.78, 212.48, 4.32,268.95397949219},
	[17] = {-2203.49, 312.45, 35.32,2.5691528320313},
	[18] = {-2026.46, 166.64, 28.83,262.37396240234},
	[19] = {-2128.48, -376.55, 35.33,2.1598815917969},
	[20] = {-1551.48, -443.31, 6,313.90609741211},
	[21] = {-1757.74, 138.58, 3.58,79.266357421875},
	[22] = {-1698.18, 373.01, 7.17,210.07250976563},
	[23] = {-1890.48, 747.39, 45.44,83.966461181641},
	[24] = {-2015.82, 1086.6, 55.71,173.72546386719},
	[25] = {-1780.79, 1199.68, 25.12,173.96630859375},
	[26] = {-2647.17, 1192.26, 55.57,126.87002563477},
	[27] = {-2491.02, 743.59, 35.01,177.05285644531},
	[28] = {-2423.03, 316.04, 34.96,239.4557800293},
	[29] = {-2019.5, -93.83, 35.16,353.10098266602},
	[30] = {-1977.95, -857.11, 32.03,87.415252685547},
}

local jobs = {}

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function is_taxi(id)
	if (taxiCars[id]) then
		return true 
	end
	return false
end

function taxi_money_d(player)
	return 15000 
end

function taxi_deliver_marker(p)
	if (getElementType(p) ~= "vehicle") then
		return false 
	end
	if (not is_taxi(getElementModel(p))) then
		return false
	end
	local player = getVehicleController(p)
	if (getElementData(source, "taxi_job") ~= player) then
		return false 
	end
	if (not player or not isElement(player) or isElement(player) and getElementType(player) ~= "player") then
		return false 
	end
	local hp = math.floor(100 - getElementHealth(p)/10)
	local defaultMoney = taxi_money_d(player)
	local tick = jobs[player][6]
	destroyElement(source)
	destroyElement(jobs[player][5])
	local secondsMinus = (getTickCount() - tick) / 1000 - 10
	local pay = defaultMoney - (defaultMoney - secondsMinus*10)
	pay = pay - (hp*100) 
	if (pay < 100) then
		pay = 100
	end

	givePlayerMoney(player, pay)
	--
	exports.NGCdxmsg:createNewDxMessage("You got $"..convertNumber(pay).." for working as a taxi driver", player, 25, 255, 25)
	jobs[player] = nil
	taxi_create_job(player)
end

function taxi_start_marker(p)
	if (getElementType(p) ~= "vehicle") then
		return false 
	end
	if (not is_taxi(getElementModel(p))) then
		return false
	end
	local player = getVehicleController(p)
	if (not player or not isElement(player) or isElement(player) and getElementType(player) ~= "player") then
		return false 
	end
	local ped = jobs[player][2]
	if (getElementData(source, "taxi_job") ~= player) then
		return false 
	end
	destroyElement(source)
	destroyElement(ped)
	destroyElement(jobs[player][5])
	setElementFrozen(p, true)
	setTimer(
		function(p)
			if (isElement(p)) then
				setElementFrozen(p, false)
			end
		end
	, 3500, 1, p)
	local num = jobs[player][3]
	local tick = jobs[player][6]
	local eX, eY, eZ, eRot = unpack(drops[num])
	local endingPositionMarker = createMarker(eX, eY, eZ-1.3, "cylinder", 5, 255, 255, 0, 50, player)
	setElementData(endingPositionMarker, "taxi_job", player)
	exports.NGCdxmsg:createNewDxMessage("Hey, please take me to the 'T' blip at "..getZoneName(eX, eY, eZ), player, 25, 255, 25)
	jobs[player] = {endingPositionMarker, nil, num, 1, createBlipAttachedTo(endingPositionMarker, 42, 2, 255, 0, 0, 255, 0, 99999.0, player), tick}
	addEventHandler("onMarkerHit", endingPositionMarker, taxi_deliver_marker)
end

function taxi_destroy_job(p)
	if (not jobs[p]) then
		return false, 0
	end
	local ped = jobs[p][2]
	if (isElement(ped)) then
		destroyElement(ped)
	end
	destroyElement(jobs[p][1])
	destroyElement(jobs[p][5])
	jobs[p] = nil
end

function taxi_create_job(p)
	taxi_destroy_job(p)
	local randomPos = math.random(#pos)
	local startingPosition = pos[randomPos]
	local endingPosition = drops[randomPos]

	local sX, sY, sZ, sRot = unpack(startingPosition)
	local eX, eY, eZ, eRot = unpack(endingPosition)
	local startingPositionMarker = createMarker(sX, sY, sZ-1.3, "cylinder", 5, 255, 255, 0, 50, p)
	local startingPositionPed = createPed(maleSkins[math.random(#maleSkins)], sX, sY, sZ, sRot, true)
	setElementFrozen(startingPositionPed, true)
	setElementData(startingPositionPed, "taxi_ped", p)
	setElementVisibleTo(startingPositionPed, root, false)
	setElementVisibleTo(startingPositionPed, p, true)
	setElementData(startingPositionMarker, "taxi_job", p)
	jobs[p] = {startingPositionMarker, startingPositionPed, randomPos, 0, createBlipAttachedTo(startingPositionPed, 42, 2, 255, 0, 0, 255, 0, 99999.0, p), getTickCount()}
	addEventHandler("onMarkerHit", startingPositionMarker, taxi_start_marker)
end

function taxi_message_enter(player, seat)
	if (seat ~= 0) then
		return false 
	end
	if (not is_taxi(getElementModel(source))) then
		return false 
	end
	if (getElementData(player, "Occupation") == "Taxi Driver") then
		taxi_create_job(player)
	end
end
addEventHandler("onVehicleEnter", root, taxi_message_enter)

function taxi_disable(p)
	taxi_destroy_job(p)
end
addEventHandler("onVehicleStartExit", root, taxi_disable)


function taxi_job_change()
	if (getElementData(source, "Occupation") ~= "Taxi Driver") then
		taxi_destroy_job(source)
	end
end
addEvent("onPlayerJobChange", true)
addEventHandler("onPlayerJobChange", root, taxi_job_change)

local taxiR = {}

function repair_taxi(player)
	if (not isPedInVehicle(player)) then
		return false 
	end
	local veh = getPedOccupiedVehicle(player)
	local c = getVehicleController(veh)
	if (c ~= player) then
		exports.NGCdxmsg:createNewDxMessage("You must be the driver of the vehicle!", player, 255, 25, 25)
		return false 
	end
	if (getElementData(player, "Occupation") ~= "Taxi Driver") then
		exports.NGCdxmsg:createNewDxMessage("Get the taxi job first", player, 255, 25, 25)
		return false 
	end
	if (not is_taxi(getElementModel(veh))) then
		exports.NGCdxmsg:createNewDxMessage("Get a taxi first", player, 255, 25, 25)
		return false 
	end
	if (taxiR[player]) then
		exports.NGCdxmsg:createNewDxMessage("Your vehicle is already getting repaired", player, 255, 25, 25)
		return false 
	end
	local hp = getElementHealth(veh)
	if (math.floor(hp/10) > 50) then
		exports.NGCdxmsg:createNewDxMessage("Vehicle health must be below 50%", player, 255, 25, 25)
		return false 
	end		

	local cost = (50 - math.floor(hp/10)) * 100
	if (getPlayerMoney(player) < cost) then
		exports.NGCdxmsg:createNewDxMessage("Not enough money", player, 255, 25, 25)
		return false 
	end
	setElementFrozen(veh, true)
	taxiR[player] = true
	exports.NGCdxmsg:createNewDxMessage("Repairing your vehicle, please wait for 3 seconds!", player, 25, 255, 25)
	setTimer(
		function(player, veh, cost)
			taxiR[player] = nil
			if (not isElement(player)) then
				return false 
			end
			if (not isElement(veh)) then
				return false 
			end
			local c = getVehicleController(veh)
			if (player ~= c) then
				return false 
			end
			takePlayerMoney(player, cost)
			exports.NGCdxmsg:createNewDxMessage("Vehicle repaired to 50% for $"..convertNumber(cost), player, 25, 255, 25)
			setElementHealth(veh, 500)
			setElementFrozen(veh, false)
		end, 
	3000, 1, player, veh, cost)
end
addCommandHandler("trepair", repair_taxi)

function repair_taxi(player)
	if (not isPedInVehicle(player)) then
		return false 
	end
	local veh = getPedOccupiedVehicle(player)
	if (getElementData(player, "Occupation") ~= "Taxi Driver") then
		exports.NGCdxmsg:createNewDxMessage("Get the taxi job first", player, 255, 25, 25)
		return false 
	end
	if (not is_taxi(getElementModel(veh))) then
		exports.NGCdxmsg:createNewDxMessage("Get a taxi first", player, 255, 25, 25)
		return false 
	end
	local hp = getElementHealth(veh)
	if (math.floor(hp/10) > 50) then
		exports.NGCdxmsg:createNewDxMessage("Cost: $0", player, 255, 25, 25)
		return false 
	end		

	local cost = (50 - math.floor(hp/10)) * 100
	exports.NGCdxmsg:createNewDxMessage("Cost: $"..convertNumber(cost), player, 25, 255, 25)
end
addCommandHandler("trepairc", repair_taxi)