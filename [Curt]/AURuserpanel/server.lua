local allowedDimensions = {[5001] = "Shooting", [5002] = "Destruction Derby", [5003] = "Counter Strike", [5004] = "Deathmatch"}
local racingDimensions = {[5001] = "Shooting", [5002] = "Destruction Derby", [5004] = "Deathmatch"}

local availableInShops = {
	{title="Fix Vehicle", price=5000,
		description="This addon will instant fix your vehicle. (One time use only).", 
		allowedRooms={[5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=true, theFunctions=function(player) 
		if (isPedDrivingVehicle(player)) then 
			fixVehicle(getPedOccupiedVehicle(player))
			return true
		else
			return false
		end 
	end},
	
	{title="Vehicle Color", price=50000,
		description="This addon will change your vehicle color to your choice. (This color will be applied pernamently when you join a vehicle type room, but also you can still change the color of the vehicle)", 
	allowedRooms={[5001]=true, [5002]=true, [5004]=true}, colorPicker=true, skipVerification=false},
	
	{title="Secondary Vehicle Color", price=50000,
		description="This addon will change your vehicle color to your choice. (This color will be applied pernamently when you join a vehicle type room, but also you can still change the secondary color of the vehicle)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=true, skipVerification=false},
	
	{title="Rainbow Color", price=500000,
		description="This addon will change your vehicle color random.", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},
	
	{title="Remove Neon", price=0, 
	description="This addon will remove neons into your vehicle.", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=true, theFunctions=function(player)
		if (isPedDrivingVehicle(player)) then 
			deleteData(player, "Neon Mod - Blue")
			return true
		else
			return false
		end 
	end},
	
	{id=1000, title="Upgrade: Pro", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1001, title="Upgrade: Win", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1002, title="Upgrade: Drag", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1003, title="Upgrade: Alpha", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1004, title="Upgrade: Champ scoop", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1005, title="Upgrade: Fury scoop", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1006, title="Upgrade: Roof scoop", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1007, title="Upgrade: Side skirt Left", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1011, title="Upgrade: Race scoop", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1012, title="Upgrade: Worx scoop", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1013, title="Upgrade: Round fog lamps", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1014, title="Upgrade: Champ", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1015, title="Upgrade: Race", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1016, title="Upgrade: Worx", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1017, title="Upgrade: Side skirt Right", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1018, title="Upgrade: Upswept", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1019, title="Upgrade: Twin", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1020, title="Upgrade: Large", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1021, title="Upgrade: Medium", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1022, title="Upgrade: Small", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1023, title="Upgrade: Fury", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1024, title="Upgrade: Square fog lamps", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1025, title="Upgrade: Offroad", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1026, title="Upgrade: Side skirt Left (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1027, title="Upgrade: Side skirt Right (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1028, title="Upgrade: Exhaust (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1029, title="Upgrade: Exhaust (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1030, title="Upgrade: Side skirt Right (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1031, title="Upgrade: Side skirt Left (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1032, title="Upgrade: Roof vent (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1033, title="Upgrade: Roof vent (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1034, title="Upgrade: Side skirt Right (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1035, title="Upgrade: Side skirt Left (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1036, title="Upgrade: Exhaust (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1037, title="Upgrade: Exhaust (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1038, title="Upgrade: Side skirt Right (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1039, title="Upgrade: Side skirt Left (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1040, title="Upgrade: Roof vent (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1041, title="Upgrade: Roof vent (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1042, title="Upgrade: Side skirt Left (Chrome strip)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1043, title="Upgrade: Exhaust (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1044, title="Upgrade: Exhaust (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1045, title="Upgrade: Side skirt Right (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1046, title="Upgrade: Side skirt Left (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1047, title="Upgrade: Exhaust (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1048, title="Upgrade: Exhaust (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1049, title="Upgrade: Side skirt Right (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1050, title="Upgrade: Side skirt Left (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1051, title="Upgrade: Roof vent (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1052, title="Upgrade: Roof vent (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1053, title="Upgrade: Spoiler (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1054, title="Upgrade: Spoiler (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1055, title="Upgrade: Side skirt Right (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1056, title="Upgrade: Side skirt Left (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1057, title="Upgrade: Exhaust (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1058, title="Upgrade: Exhaust (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1059, title="Upgrade: Side skirt Right (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1060, title="Upgrade: Side skirt Left (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1061, title="Upgrade: Roof vent (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1062, title="Upgrade: Roof vent (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1063, title="Upgrade: Spoiler (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1064, title="Upgrade: Spoiler (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1065, title="Upgrade: Side skirt Right (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1066, title="Upgrade: Side skirt Left (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1067, title="Upgrade: Exhaust (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1068, title="Upgrade: Exhaust (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1069, title="Upgrade: Side skirt Right (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1070, title="Upgrade: Side skirt Left (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1071, title="Upgrade: Roof vent (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1072, title="Upgrade: Roof vent (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1073, title="Upgrade: Shadow", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1074, title="Upgrade: Mega", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1075, title="Upgrade: Rimshine=", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1076, title="Upgrade: Wires", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1077, title="Upgrade: Classic", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1078, title="Upgrade: Twist", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1079, title="Upgrade: Cutter", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1080, title="Upgrade: Switch", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1081, title="Upgrade: Grove", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1082, title="Upgrade: Import", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1083, title="Upgrade: Dollar", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1084, title="Upgrade: Trance", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1085, title="Upgrade: Atomic", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1086, title="Upgrade: Stereo bass boost", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1087, title="Upgrade: Hydralics", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1088, title="Upgrade: Side skirt Right (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1089, title="Upgrade: Side skirt Left (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1090, title="Upgrade: Exhaust (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1091, title="Upgrade: Exhaust (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1092, title="Upgrade: Side skirt Right (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1093, title="Upgrade: Side skirt Left (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1094, title="Upgrade: Roof vent (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1095, title="Upgrade: Roof vent (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1096, title="Upgrade: Ahab", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1097, title="Upgrade: Virtual", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1098, title="Upgrade: Access", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1100, title="Upgrade: Bullbar (Chrome grill)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1101, title="Upgrade: Side skirt Right (Chrome flames)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1102, title="Upgrade: Side skirt Left (Chrome strip)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1103, title="Upgrade: Roof (Convertible roof)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1104, title="Upgrade: Exhaust (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1105, title="Upgrade: Exhaust (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1106, title="Upgrade: Side skirt Left (Chrome arches)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1107, title="Upgrade: Side skirt Right (Chrome strip)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1108, title="Upgrade: Side skirt Left (Chrome strip)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1109, title="Upgrade: Rear bullbars (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1110, title="Upgrade: Rear bullbars (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1111, title="Upgrade: Unknown", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1112, title="Upgrade: Unknown", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1113, title="Upgrade: Exhaust (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1114, title="Upgrade: Exhaust (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1115, title="Upgrade: Front bullbars (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1116, title="Upgrade: Front bullbars (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1117, title="Upgrade: Front bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1118, title="Upgrade: Side skirt Left (Chrome trim)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1119, title="Upgrade: Side skirt Left (Wheelcovers)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1120, title="Upgrade: Side skirt Right (Chrome trim)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1121, title="Upgrade: Side skirt Right (Wheelcovers)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1122, title="Upgrade: Side skirt Left (Chrome flames)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1123, title="Upgrade: Bullbar (Chrome bars)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1124, title="Upgrade: Side skirt Right (Chrome arches)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1125, title="Upgrade: Bullbar (Chrome lights)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1126, title="Upgrade: Exhaust (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1127, title="Upgrade: Exhaust (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1128, title="Upgrade: Roof (Vinyl hardtop)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1129, title="Upgrade: Exhaust (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1130, title="Upgrade: Roof (Hardtop)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1131, title="Upgrade: Roof (Softtop)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1132, title="Upgrade: Exhaust (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1133, title="Upgrade: Side skirt Left (Chrome strip)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1134, title="Upgrade: Side skirt Left (Chrome strip)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1135, title="Upgrade: Exhaust (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1136, title="Upgrade: Exhaust (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1137, title="Upgrade: Side skirt Right (Chrome strip)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1138, title="Upgrade: Spoiler (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1139, title="Upgrade: Spoiler (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1140, title="Upgrade: Rear bumper (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1141, title="Upgrade: Rear bumper (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1142, title="Upgrade: Oval vents Right", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1143, title="Upgrade: Oval vents Left", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1144, title="Upgrade: Square vents Right", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1145, title="Upgrade: Square vents Left", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1146, title="Upgrade: Spoiler (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1147, title="Upgrade: Spoiler (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1148, title="Upgrade: Rear bumber (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1149, title="Upgrade: Rear bumber (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1150, title="Upgrade: Rear bumber (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1151, title="Upgrade: Rear bumber (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1152, title="Upgrade: Front bumper (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1153, title="Upgrade: Front bumper (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1154, title="Upgrade: Rear bumber (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1155, title="Upgrade: Rear bumber (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1156, title="Upgrade: Front bumper (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1157, title="Upgrade: Front bumper (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1158, title="Upgrade: Spoiler (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1159, title="Upgrade: Spoiler (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1160, title="Upgrade: Rear bumber (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1161, title="Upgrade: Rear bumber (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1162, title="Upgrade: Front bumper (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1163, title="Upgrade: Spoiler (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1164, title="Upgrade: Spoiler (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1165, title="Upgrade: Rear bumber (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1166, title="Upgrade: Rear bumber (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1167, title="Upgrade: Front bumper (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1168, title="Upgrade: Front bumper (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1169, title="Upgrade: Front bumper (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1170, title="Upgrade: Front bumper (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1171, title="Upgrade: Front bumper (Alien)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1172, title="Upgrade: Front bumper (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1173, title="Upgrade: Front bumper (X-flow)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1174, title="Upgrade: Front bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1175, title="Upgrade: Front bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1176, title="Upgrade: Rear bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1177, title="Upgrade: Rear bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1178, title="Upgrade: Rear bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1179, title="Upgrade: Front bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1180, title="Upgrade: Rear bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1181, title="Upgrade: Front bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1182, title="Upgrade: Front bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1183, title="Upgrade: Rear bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1184, title="Upgrade: Rear bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1185, title="Upgrade: Front bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1186, title="Upgrade: Rear bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1187, title="Upgrade: Rear bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1188, title="Upgrade: Front bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1189, title="Upgrade: Front bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1190, title="Upgrade: Front bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1191, title="Upgrade: Front bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1192, title="Upgrade: Rear bumper (Chromer)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	{id=1193, title="Upgrade: Rear bumper (Slamin)", price=13000, 
	description="This addon will apply vehicle upgrades. (Also note, this will not work if your vehicle is not compatible with the said item name.)", 
	allowedRooms={[0]=true, [5001]=true, [5002]=true, [5004]=true}, colorPicker=false, skipVerification=false},

	
	
}

function checkingDataCorrect (thePlayer)
	local theData = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "mg_addons")
	if (theData == "" or theData ==  nil) then 
		exports.AURcurtmisc:setPlayerAccountData(thePlayer, "mg_addons", "[[]]")
	end 
end 


function isPedDrivingVehicle(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ isPedDrivingVehicle [ped/player expected, got " .. tostring(ped) .. "]")
    local isDriving = isPedInVehicle(ped) and getVehicleOccupant(getPedOccupiedVehicle(ped)) == ped
    return isDriving, isDriving and getPedOccupiedVehicle(ped) or nil
end

function playerRequestedData (thePlayer)
	checkingDataCorrect(thePlayer)
	local theData = {}
	theData["level"] = exports.AURlevels:getPlayerLevel(thePlayer)
	theData["xp"] = exports.AURlevels:getPlayerXP(thePlayer)
	theData["allowedDimensions"] = allowedDimensions
	theData["availableInShops"] = availableInShops
	theData["boughtStuff"] = fromJSON(exports.AURcurtmisc:getPlayerAccountData(thePlayer, "mg_addons") or "[[]]")
	triggerClientEvent(thePlayer, "AURuserpanel.clientDataRecieved", thePlayer, theData)
end 
addEvent("AURuserpanel.playerRequestedData", true)
addEventHandler("AURuserpanel.playerRequestedData", resourceRoot, playerRequestedData)

function buyItem (thePlayer, theItem, theCost, colorpicker_r, colorpicker_g, colorpicker_b)
	for i=1, #availableInShops do 
		if (availableInShops[i].title == theItem and availableInShops[i].price == theCost) then 
			if (getPlayerMoney(thePlayer) >= theCost) then 
				if (colorpicker_r ~= nil and colorpicker_g ~= nil and colorpicker_b ~= nil) then 
					saveData(thePlayer, theItem.."_r", colorpicker_r)
					saveData(thePlayer, theItem.."_g", colorpicker_g)
					saveData(thePlayer, theItem.."_b", colorpicker_b)
					exports.AURpayments:takeMoney(thePlayer, theCost, "AURuserpanel")
					exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("You purchased %s for $%s.", true, thePlayer), theItem, theCost), 0, 255, 0)
					applyUpgrades(thePlayer)
					return
				else
					if (availableInShops[i].skipVerification == true) then 
						if (availableInShops[i].theFunctions(thePlayer) == true) then 
							exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("You purchased %s for $%s.", true, thePlayer), theItem, theCost), 0, 255, 0)
							return 
						end 
						exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("Unable to process your transaction due to an error.", true, thePlayer)), 255, 0, 0)
						return 
					end 
					if (hasData(thePlayer, theItem) == false) then 
						exports.AURpayments:takeMoney(thePlayer, theCost, "AURuserpanel")
						if (type(availableInShops[i].id) == "number") then 
							saveData(thePlayer, theItem, availableInShops[i].id)
						else 
							saveData(thePlayer, theItem, 1)
						end 
						applyUpgrades(thePlayer)
						exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("You purchased %s for $%s.", true, thePlayer), theItem, theCost), 0, 255, 0)
						return 
					else
						exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("You already bought %s!", true, thePlayer), theItem), 255, 0, 0)
						return
					end 
				end 
			else
				exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("Unable to process your transaction. You don't have enough money to buy this item.", true, thePlayer)), 255, 0, 0)
				return
			end
		end 
	end 
	exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("Unexpected Error!", true, thePlayer)), 255, 0, 0)
end 
addEvent("AURuserpanel.buyItem", true)
addEventHandler("AURuserpanel.buyItem", resourceRoot, buyItem)

function getPlayerFromAccountname ( theName )
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if ( getElementData( thePlayer, "playerAccount" ) == theName ) then
			return thePlayer
		end
	end
end

function saveData (thePlayer, theAddon, theValue)
	checkingDataCorrect(thePlayer)
	local theData = fromJSON(exports.AURcurtmisc:getPlayerAccountData(thePlayer, "mg_addons"))
	for i=1, #theData do 
		if (theData[i][1] == theAddon) then 
			theData[i] = {theAddon, theValue}
			exports.AURcurtmisc:setPlayerAccountData(thePlayer, "mg_addons", toJSON(theData))
			return true
		end
	end 
	theData[#theData+1] = {theAddon, theValue}
	exports.AURcurtmisc:setPlayerAccountData(thePlayer, "mg_addons", toJSON(theData))
end 

function deleteData (thePlayer, theAddon)
	checkingDataCorrect(thePlayer)
	local theData = fromJSON(exports.AURcurtmisc:getPlayerAccountData(thePlayer, "mg_addons"))
	for i=1, #theData do 
		if (theData[i][1] == theAddon) then 
			theData[i] = nil
			exports.AURcurtmisc:setPlayerAccountData(thePlayer, "mg_addons", toJSON(theData))
			return true
		end 
	end 
	return false
end 

function hasData (thePlayer, theAddon)
	checkingDataCorrect(thePlayer)
	local theData = fromJSON(exports.AURcurtmisc:getPlayerAccountData(thePlayer, "mg_addons"))
	for i=1, #theData do 
		if (theData[i][1] == theAddon) then 
			return true
		end 
	end 
	return false
end 

function getData (thePlayer, theAddon)
	checkingDataCorrect(thePlayer)
	local theData = fromJSON(exports.AURcurtmisc:getPlayerAccountData(thePlayer, "mg_addons"))
	for i=1, #theData do 
		if (theData[i][1] == theAddon) then 
			return theData[i][2]
		end 
	end 
	return false
end 

function getTop50Level (thePlayer)
	local theTable = exports.DENmysql:query("SELECT * FROM `levels` ORDER BY `levels`.`xp` DESC LIMIT 1,50")
	local theData = {}
	for i=1, #theTable do 
		local whatUsername = exports.DENmysql:query("SELECT username FROM accounts WHERE id=?", theTable[i].userid)
		for z=1, #whatUsername do 
			if (isElement(getPlayerFromAccountname(whatUsername[z].username))) then 
				theData[#theData+1] = {getPlayerName(getPlayerFromAccountname(whatUsername[z].username)).." ("..whatUsername[z].username..")", "Level "..theTable[i].level.." - "..theTable[i].xp.." XPs"}
			else 
				theData[#theData+1] = {whatUsername[z].username, "Level "..theTable[i].level.." - "..theTable[i].xp.." XPs"}
			end 
		end 
		
	end 
	triggerClientEvent(thePlayer, "AURuserpanel.clientDataRecievedScoreboard", thePlayer, theData)
end 
addEvent("AURuserpanel.playerRequestedDataScoreboard", true)
addEventHandler("AURuserpanel.playerRequestedDataScoreboard", resourceRoot, getTop50Level)


local blacklisted = {["Secondary Vehicle Color_r"]=true,["Secondary Vehicle Color_g"]=true,["Secondary Vehicle Color_b"]=true,["Vehicle Color_r"]=true,["Vehicle Color_g"]=true,["Vehicle Color_b"]=true}
function applyUpgrades (thePlayer)
	if (racingDimensions[getElementDimension(thePlayer)]) then 
		checkingDataCorrect(thePlayer)
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		
		if (isElement(theVehicle)) then 
		
			local attachedElements = getAttachedElements (theVehicle)
			 if (attachedElements) then
				for ElementKey, ElementValue in ipairs ( attachedElements ) do
					if ( getElementType ( ElementValue ) ~= "player" ) then
						destroyElement(ElementValue)
					end
				 end 
			 end 
		
			local theData = fromJSON(exports.AURcurtmisc:getPlayerAccountData(thePlayer, "mg_addons"))
			for i=1, #theData do 
				
				if (string.find(theData[i][1], "Upgrade") ~= nil) then 
					if (addVehicleUpgrade(theVehicle, theData[i][2])) then 
						outputDebugString("Added vehicle upgrade id "..theData[i][2])
					end
				elseif (blacklisted[theData[i][1]]) then 
					local r,g,b,rz,gz,bz getVehicleColor(theVehicle)
					setVehicleColor(theVehicle, getData(thePlayer, "Vehicle Color_r") or r, getData(thePlayer, "Vehicle Color_g") or g, getData(thePlayer, "Vehicle Color_b") or b, getData(thePlayer, "Secondary Vehicle Color_r") or rz, getData(thePlayer, "Secondary Vehicle Color_g") or gz, getData(thePlayer, "Secondary Vehicle Color_b") or bz)
				elseif (theData[i][1] == "Rainbow Color") then 
					for i, thePlayers in ipairs ( getElementsByType ( "player" ) ) do
						if (racingDimensions[getElementDimension(thePlayers)]) then 
							triggerClientEvent(thePlayers, "AURuserpanel.activateRainbow", thePlayers, theVehicle)
						end
					end 
				elseif (theData[i][1] == "Neon Mod - Blue") then 
					local x, y, z = getElementPosition ( theVehicle )
					local neon = createObject ( 5681, x, y, z )
					local neon1 = createObject ( 5681, x, y, z )
					local neon2 = createObject ( 5681, x, y, z )
					local neon3 = createObject ( 5681, x, y, z )
					
					attachElements ( neon3, theVehicle, 0, 1.25, -0.63, 0, 0, 90 )
                    attachElements ( neon2, theVehicle, 0, -1.25, -0.63, 0, 0, 90 )
                    attachElements ( neon1, theVehicle, 0.95, 0, -0.63 )
                    attachElements ( neon, theVehicle, -0.95, 0, -0.63 )
					setElementDimension(neon, getElementDimension(theVehicle))
					setElementDimension(neon1, getElementDimension(theVehicle))
					setElementDimension(neon2, getElementDimension(theVehicle))
					setElementDimension(neon3, getElementDimension(theVehicle))
				end 
						
				
			end 
		end
	end 
end 

function applyMods(theVehicle, seat, jacked)
    if (racingDimensions[getElementDimension(source)]) then 
		setTimer(function(thePlayer)
			applyUpgrades(thePlayer)
		end, 2000, 1, source)
	end 
end
addEventHandler ("onPlayerVehicleEnter", getRootElement(), applyMods) 

function applyModsNow ()
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		applyUpgrades(thePlayer)
	end 
end
addEventHandler ("onResourceStart", resourceRoot, applyModsNow)