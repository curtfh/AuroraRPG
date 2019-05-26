-- Toggle the vehicle controls
function setVehicleControls(state)
	local veh = getPedOccupiedVehicle(localPlayer)
	toggleControl("vehicle_fire", state)
	toggleControl("vehicle_left", state)
	toggleControl("vehicle_right", state)
	toggleControl("steer_forward", state)
	toggleControl("steer_back", state)
	toggleControl("accelerate", state)
	if (not veh) then
		toggleControl("brake_reverse", state)
	elseif (getVehicleType(veh) ~= "Helicopter") then
		toggleControl("brake_reverse", state)
	elseif (state) then
		setControlState("brake_reverse", true)
	end
	toggleControl("vehicle_secondary_fire", true)
	if (veh) then
		if (getElementData(localPlayer, "City") ~= "LV" and getElementModel(veh) == 520) then
			toggleControl("vehicle_secondary_fire", false)
		end
		if (getElementHealth(veh) <= 250 and getElementModel(veh) == 520) then
			toggleControl("vehicle_secondary_fire", false)
			setVehicleDamageProof(veh, true)
		end
	end
	if (getElementData(localPlayer, "isInRestrictedArea", true)) then
		toggleControl("vehicle_secondary_fire", false)
		exports.NGCdxmsg:createNewDxMessage("You can't shoot in AREA 51!", 255, 0, 0)
	end
	if (getElementData(localPlayer,"Occupation") == "Mechanic") then
		toggleControl("vehicle_secondary_fire", false)
	end
end

-- Disable controls in vehicle
function vehDmg(attacker, weapon, loss)
	if (getElementData(source, "vehicleType") ~= "playerVehicle") then
		return false
	end
	local hp = math.floor(getElementHealth(source) - loss)
	if (hp < 255) then
		triggerServerEvent("AURvehiclemisc.breakDownVeh", resourceRoot, source)
		if (getVehicleController(source) == localPlayer) then
			setVehicleControls(false)
		end
	elseif (hp > 255) then
		if (getVehicleController(source) == localPlayer) then
			setVehicleControls(true)
		end
	end
end
addEvent("onClientVehiclePostDamage", true)
addEventHandler("onClientVehiclePostDamage", root, vehDmg)

-- When player exist the vehicle
function exitVehicleSetControls(thePlayer)
	if (thePlayer == localPlayer) then
		setVehicleControls(true)
	end
end
addEventHandler("onClientVehicleExit", root, exitVehicleSetControls)

-- When the player stats entering the vehicle
function doEngineStateDmgCheck(thePlayer)
	if (thePlayer ~= localPlayer) then
		return false
	end
	if (getElementModel(source) == 528) then
		return false
	end
	local hp = math.floor(getElementHealth(source))
	if (hp < 250) then
		setVehicleControls(false)
		setVehicleEngineState(source, false)
		setVehicleDamageProof(source, true)
	elseif (hp > 250) then
		setVehicleControls(true)
		setVehicleDamageProof(source, false)
	end
end
addEventHandler("onClientVehicleStartEnter", root, doEngineStateDmgCheck)

function playLockedVehicleSound(x, y, z)
	stream = playSound3D("carAlarm.mp3", x, y, z,false)
	setSoundMinDistance(stream, 1)
	setSoundMaxDistance(stream, 50)
end
addEvent("vehicleLocked", true)
addEventHandler("vehicleLocked", resourceRoot, playLockedVehicleSound)

function destroyTankHP(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if (hitElement and getElementType(hitElement) == "vehicle" and getElementModel(hitElement) == 432 and weapon == 35) then
		triggerServerEvent("setTheTankHealth", resourceRoot, hitElement)
	end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, destroyTankHP)

Wheels = {
	{"wheel_gn1", 1082},
	{"wheel_gn2", 1085},
	{"wheel_gn3", 1096},
	{"wheel_gn4", 1097},
	{"wheel_gn5", 1098},
	{"wheel_lr1", 1077},
	{"wheel_lr2", 1083},
	{"wheel_lr3", 1078},
	{"wheel_lr4", 1076},
	{"wheel_lr5", 1084},
	{"wheel_or1", 1025},
	{"wheel_sr1", 1079},
	{"wheel_sr2", 1075},
	{"wheel_sr3", 1074},
	{"wheel_sr4", 1081},
	{"wheel_sr5", 1080},
	{"wheel_sr6", 1073},
}

function onThisResourceStart()
	for k, v in pairs(Wheels) do
		--if (not fileExists(":CSGvehiclemisc/models/Wheels/"..v[1]..".dff")) then
			downloadFile ( "models/Wheels/"..v[1]..".dff" )
		--end
	end
	--downloadFile("models/Wheels/vehicle.txd")
end
addEventHandler("onClientResourceStart", resourceRoot, onThisResourceStart)

function onDownloadFinish(file, success)
	if (source == resourceRoot and success) then
		for k,v in ipairs(Wheels) do
			if file == "models/Wheels/"..v[1]..".dff" then
				loadMyMods(file,v[2])
			end
		end
	end
end
addEventHandler("onClientFileDownloadComplete", root, onDownloadFinish)

function loadMyMods(name, id)
	lambTXD = engineLoadTXD("models/Wheels/vehicle.txd")
	engineImportTXD(lambTXD, id)
	lambDFF = engineLoadDFF(name, id)
	engineReplaceModel(lambDFF, id)
end