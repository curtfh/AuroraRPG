local BLIP_ID = 40 -- T (truth) blip 
local REPAIR_KIT_C = dbConnect("sqlite", "repairkit.db")
local REPAIR_KIT_S = {
	{-1912.08, 276.95, 41.04},
	{2073.78, -1825.06, 13.54},
	{1030.42, -1031.32, 31.98},
	{1966.87, 2151.89, 10.82},
	{-2419.52, 1029.88, 50.2},
	{-1256.6, -45.48, 13.8},
	{-92.42, 1109.62, 19.74},
	{-1426.85, 2594.38, 55.83},
	{371.65, 2537.59, 16.6},
	{1582.33, 1453.53, 10.83},
	{723.9, -464.41, 16.03},
	{1871.5, -2382.77, 13.55},
	{482.75, -1732.48, 11.02}
}
local REPAIR_C = {}
dbExec(REPAIR_KIT_C, "CREATE TABLE IF NOT EXISTS repairKits(accountName TEXT, numberKits INT)")

function repair_repairkit()
	local stuff = dbPoll(dbQuery(REPAIR_KIT_C, "SELECT * FROM repairKits"), -1)
	for i, v in ipairs(stuff) do
		if (v.numberKits < 0) then
			dbExec(REPAIR_KIT_C, "UPDATE repairKits SET numberKits=? WHERE accountName=? ", 0, v.accountName)
		end
	end
end
repair_repairkit()

function repair_kit_gui(PLR, DIM)
	if (not DIM) then
		return false
	end
	if (getElementType(PLR) ~= "player") then
		return false 
	end
	if (isPedInVehicle(PLR)) then
		return false 
	end
	local X, Y, Z = getElementPosition(PLR)
	local X1, Y1, Z1 = getElementPosition(source)
	if (Z-Z1 > 2) then
		return false 
	end
	triggerClientEvent(PLR, "AURrepair_kits:t", resourceRoot)
end

for i, v in ipairs(REPAIR_KIT_S) do
	local X, Y, Z = unpack(v)
	local MARKER_S = createMarker(X, Y, Z-1.3, "cylinder", 2, 255, 255, 0, 255)
	local BLIP_S = createBlipAttachedTo(MARKER_S, BLIP_ID)
	setBlipVisibleDistance(BLIP_S, 500)
	addEventHandler("onMarkerHit", MARKER_S, repair_kit_gui)
end

function give_repair_kits(player, number)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	local ACC_NAME = exports.server:getPlayerAccountName(player)
	local DB_CHECK = dbPoll(dbQuery(REPAIR_KIT_C, "SELECT * FROM repairKits WHERE accountName=?", ACC_NAME), -1)

	if (#DB_CHECK == 0) then
		dbExec(REPAIR_KIT_C, "INSERT INTO repairKits(accountName, numberKits) VALUES(?,?)", ACC_NAME, number)
		return true
	else
		dbExec(REPAIR_KIT_C, "UPDATE repairKits SET numberKits=? WHERE accountName=?", DB_CHECK[1].numberKits + number, ACC_NAME)
		return true
	end
	return false
end

function take_repair_kits(player, number)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	local ACC_NAME = exports.server:getPlayerAccountName(player)
	local DB_CHECK = dbPoll(dbQuery(REPAIR_KIT_C, "SELECT * FROM repairKits WHERE accountName=?", ACC_NAME), -1)

	if (#DB_CHECK == 0) then
		dbExec(REPAIR_KIT_C, "INSERT INTO repairKits(accountName, numberKits) VALUES(?,?)", ACC_NAME, 0)
	else
		dbExec(REPAIR_KIT_C, "UPDATE repairKits SET numberKits=? WHERE accountName=?", DB_CHECK[1].numberKits - number, ACC_NAME)
	end
end

function get_repair_kits(player)
	if (not exports.server:isPlayerLoggedIn(player)) then
		return false 
	end
	local ACC_NAME = exports.server:getPlayerAccountName(player)
	local DB_CHECK = dbPoll(dbQuery(REPAIR_KIT_C, "SELECT * FROM repairKits WHERE accountName=?", ACC_NAME), -1)

	if (#DB_CHECK == 0) then
		dbExec(REPAIR_KIT_C, "INSERT INTO repairKits(accountName, numberKits) VALUES(?,?)", ACC_NAME, 0)
		return 0
	else
		return DB_CHECK[1].numberKits
	end
end

function repair_kit_command(p)
	if (not exports.server:isPlayerLoggedIn(p)) then
		return false 
	end
	if (getPedOccupiedVehicle(p)) then return false end
	if (isPedInVehicle(p)) then
		if (isCursorShowing(p)) then
			showCursor(p, false)
		else
			exports.NGCdxmsg:createNewDxMessage("You must not be in a vehicle!", p, 255, 25, 25)
			return false 
		end
	end
	if (get_repair_kits(p) == 0 or get_repair_kits(p) < 0) then
		exports.NGCdxmsg:createNewDxMessage("You don't have repair kits", p, 255, 25, 25)
		return false 
	end
	showCursor(p, not isCursorShowing(p))
	REPAIR_C[p] = isCursorShowing(p)
end
addCommandHandler("repairkit", repair_kit_command)

local ABUSE_P_T = {}

function repair_on_click(BTN, _, PLR)
	if (not REPAIR_C[PLR]) then
		return false 
	end
	if (ABUSE_P_T[PLR]) then
		return false 
	end
	if (BTN ~= "left") then
		return false 
	end
	if (getElementType(source) ~= "vehicle") then
		return false 
	end
	local X, Y, Z = getElementPosition(PLR)
	local X1, Y1, Z1 = getElementPosition(source)
	if (getDistanceBetweenPoints3D(X, Y, Z, X1, Y1, Z1) > 10) then
		exports.NGCdxmsg:createNewDxMessage("You are too far from the vehicle!", PLR, 255, 25, 25)
		return false 
	end		
	local CONTROLLER = getVehicleController(source)
	if (isVehicleBlown(source)) then
		exports.NGCdxmsg:createNewDxMessage("Too critical condition.", PLR, 255, 25, 25)
		return false 
	end
	if (isPedInVehicle(PLR)) then
		exports.NGCdxmsg:createNewDxMessage("You must not be in a vehicle!", PLR, 255, 25, 25)
		return false 
	end
	if (CONTROLLER and getElementType(CONTROLLER) == "player") then
		exports.NGCdxmsg:createNewDxMessage("Car must be empty to start repairing process", PLR, 255, 25, 25)
		return false
	elseif (not CONTROLLER) then
		if (math.ceil(getElementHealth(source)/10) > 90) then
			exports.NGCdxmsg:createNewDxMessage("Car does not need any more repairs", PLR, 255, 25, 25)
			REPAIR_C[PLR] = false
			showCursor(PLR, false)
			return false 
		end
		exports.NGCdxmsg:createNewDxMessage("Repairing the vehicle - wait for 3 seconds", PLR, 25, 255, 25)
		setElementFrozen(source, true)
		setElementFrozen(PLR, true)
		ABUSE_P_T[PLR] = true
		showCursor(PLR, false)
		setTimer(
			function(PLR, VEHICLE)
				if (not isElement(PLR)) then
					REPAIR_C[PLR] = nil
					ABUSE_P_T[PLR] = nil
					return false
				end
				if (not isElement(VEHICLE)) then
					exports.NGCdxmsg:createNewDxMessage("Vehicle does not exist anymore, repair failed", PLR, 255, 25, 25)
					return false 
				end
				setVehicleWheelStates(VEHICLE, 0, 0, 0, 0)
				setElementFrozen(VEHICLE, false)
				setElementFrozen(PLR, false)
				local HP = getElementHealth(VEHICLE)
				if (HP < 800) then
					setElementHealth(VEHICLE, HP + 200)
				else
					setElementHealth(VEHICLE, 1000)
				end
				take_repair_kits(PLR, 1)
				REPAIR_C[PLR] = nil
				ABUSE_P_T[PLR] = nil
				exports.NGCdxmsg:createNewDxMessage("Vehicle repaired (Repair kits left: "..get_repair_kits(PLR)..")", PLR, 25, 255, 25)
			end
		, 3000, 1, PLR, source)
	end
end
addEventHandler("onElementClicked", root, repair_on_click)

function repair_kit_show(PLR)
	if (not exports.server:isPlayerLoggedIn(PLR)) then
		return false 
	end
	local REPAIR_KITS = get_repair_kits(PLR)
	exports.NGCdxmsg:createNewDxMessage("You have "..REPAIR_KITS.." number of repair kits left with you!", PLR, 25, 255, 25)
end
addCommandHandler("rp", repair_kit_show)

function repair_kit_buy(AMOUNT)
	if (not tonumber(AMOUNT)) then
		outputChatBox("Invalid number", client, 255, 0, 0)
		return false 
	end
	local AMOUNT = tonumber(AMOUNT)

	local MONEY = getPlayerMoney(client)
	if (MONEY < AMOUNT*1500) then
		exports.NGCdxmsg:createNewDxMessage("You cannot afford this!", client, 255, 25, 25)
		return false 
	end
	if (give_repair_kits(client, AMOUNT)) then
		takePlayerMoney(client, AMOUNT*1500)
		exports.NGCdxmsg:createNewDxMessage("You bought "..tostring(AMOUNT).." repair kit(s)!", client, 25, 255, 25)
	end
end
addEvent("AURrepair_kits:b", true)
addEventHandler("AURrepair_kits:b", resourceRoot, repair_kit_buy)