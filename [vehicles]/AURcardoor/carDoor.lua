function openDoor (player, od, number)
local vehicle = getPedOccupiedVehicle (player)
	if (vehicle ~= false) and (getPedOccupiedVehicleSeat(player) == 0) then 
		if tonumber(number)==6 then 
			setVehicleDoorOpenRatio (vehicle, 0, 1, 1000)
			setVehicleDoorOpenRatio (vehicle, 1, 1, 1000)
			setVehicleDoorOpenRatio (vehicle, 2, 1, 1000)
			setVehicleDoorOpenRatio (vehicle, 3, 1, 1000)
			setVehicleDoorOpenRatio (vehicle, 4, 1, 1000)
			setVehicleDoorOpenRatio (vehicle, 5, 1, 1000)
		elseif tonumber(number)>6 or tonumber(number)<0 then outputChatBox("Wrong Number", player, 200, 200, 200) 
		else setVehicleDoorOpenRatio (vehicle, tonumber(number), 1, 1000) end
	elseif (not vehicle) then
			outputChatBox("You're not in a vehicle", player, 200, 200, 200)
	elseif (getPedOccupiedVehicleSeat(player) ~= 0) then
			outputChatBox("You should be the driver of the vehicle", player, 200, 200, 200)
	else return end
end
addCommandHandler ("od",openDoor)

function closeDoor (player, od, number)
local vehicle = getPedOccupiedVehicle (player)
	if (vehicle ~= false) and (getPedOccupiedVehicleSeat(player) == 0) then 
		if tonumber(number)==6 then 
			setVehicleDoorOpenRatio (vehicle, 0, 0, 1000)
			setVehicleDoorOpenRatio (vehicle, 1, 0, 1000)
			setVehicleDoorOpenRatio (vehicle, 2, 0, 1000)
			setVehicleDoorOpenRatio (vehicle, 3, 0, 1000)
			setVehicleDoorOpenRatio (vehicle, 4, 0, 1000)
			setVehicleDoorOpenRatio (vehicle, 5, 0, 1000)
	elseif tonumber(number)>6 or tonumber(number)<0 then outputChatBox("Wrong Number", player, 200, 200, 200) 
		else setVehicleDoorOpenRatio (vehicle, tonumber(number), 0, 1000) end
	elseif (not vehicle) then
			outputChatBox("You're not in a vehicle", player, 200, 200, 200)
	elseif (getPedOccupiedVehicleSeat(player) ~= 0) then
			outputChatBox("You should be the driver of the vehicle", player, 200, 200, 200)
	else return end
end
addCommandHandler ("cd",closeDoor)