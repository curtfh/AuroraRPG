local farmerColSphare = createColRectangle(-1185.1004638672, -1050.79364013672, 150, 130)
local farmerColSphare2 = createColRectangle(-1180, -1230, 90, 70)
local farmerColSphare3 =  createColRectangle(677, 1952, 51, 57) 
local radararea3 = createRadarArea(677, 1952, 61, 67, 255, 255, 0)
local radararea = createRadarArea(-1185.1004638672, -1050.79364013672, 155, 130, 255, 255, 0)
local radararea2 = createRadarArea(-1180, -1230, 90, 70, 255, 255, 0)
local seedMarker = createMarker(-1059.7802734375, -1193.2507324219, 128, "cylinder", 2, 255, 255, 0, 200)
local seedMarker2 = createMarker(696,1977, 4,"cylinder", 2, 255, 255, 0, 200)
local playerToGroundLevel = 1.3085
local antiSpamTimer = getTickCount()
local crops = {}
local inCropColShape = false
local seedGrowTime = 30000
local sWidth, sHeight = guiGetScreenSize()
local Width, Height = 400, 400
local X = (sWidth / 2) - (Width / 2)
local Y = (sHeight / 2) - (Height / 2)
local screenX, screenY = guiGetScreenSize()
local lastCropPlanted = getTickCount()

setElementData(localPlayer, "Planted", 0)

Farmer = guiCreateWindow(X,Y + 100, Width, Height - 200, "Seeds Shop", false)
SeedC1 = guiCreateButton(20, 150, 80, 30, "Buy", false, Farmer)
SeedC2 = guiCreateButton(280, 150, 80, 30, "Close", false, Farmer)
SeedC3 = guiCreateRadioButton(20, 80, 80, 50,"Seeds",false, Farmer)
SeedC4 = guiCreateLabel(20, 50, 350,50, "Click on Seeds then press on buy button!!\nSeeds Cost:$500 for 20 hits.\n1 Plant takes 4 seeds.", false, Farmer)

guiSetVisible(Farmer, false)
guiRadioButtonSetSelected(SeedC3, false)

function buySeedsBtn()
	if (guiRadioButtonGetSelected(SeedC3)) then
		local Seedmoney = getPlayerMoney(player)
		if (Seedmoney < 500) then
			exports.NGCdxmsg:createNewDxMessage("You don't have enough money.", 255, 0, 0)
			return false
		end
		triggerServerEvent("takeSeedmoney", resourceRoot)
		guiSetVisible(Farmer, false)
		showCursor(false)
	end
end
addEventHandler("onClientGUIClick", SeedC1, buySeedsBtn, false)

function closeSeedBuyPanel()
	guiSetVisible(Farmer, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", SeedC2, closeSeedBuyPanel, false)

function hitSeedStore(p)
	if (p ~= localPlayer) then
		return false
	end
	if (not getPlayerTeam(localPlayer) or getTeamName(getPlayerTeam(localPlayer)) ~= "Civilian Workers") then
		return false
	end
	if (isPedInVehicle(localPlayer)) then
		return false
	end
	if (getElementData(localPlayer, "Occupation") ~= "Farmer") then
		return false
	end
	local seedC = getElementData(localPlayer, "Seed") or 0
	guiSetText(SeedC3,"Seeds: "..seedC)
	guiSetVisible(Farmer, true)
	showCursor(true)
end
addEventHandler("onClientMarkerHit", seedMarker, hitSeedStore)
addEventHandler("onClientMarkerHit", seedMarker2, hitSeedStore)

function drawTimeLeftOnHarvest()
	if (Harvester) then
		removeEventHandler("onClientRender", root, drawTimeLeftOnHarvest)
		return false
	end
	local timeLeft = math.floor(((lastCropPlanted) - getTickCount()) / 1000)
	if (timeLeft > 0) then
		dxDrawText("Time left to harvest: "..tostring(timeLeft).." seconds", 0, screenY * 0.7, screenX, screenY * 0.85, tocolor(255, 255, 255, 255), 1.5, "default", "center", "center")
	else
		Harvester = true
		exports.NGCdxmsg:createNewDxMessage("Your plants are ready to be harvested", 255, 255, 0)
	end
end

function SetHarvestTimer()
	if (#crops == 1) then
		lastCropPlanted = getTickCount() + 20000
	else
		lastCropPlanted = lastCropPlanted + 20000
	end
	removeEventHandler("onClientRender", root, drawTimeLeftOnHarvest)
	addEventHandler("onClientRender", root, drawTimeLeftOnHarvest)
end

function bindSeed(hitElement)
	if (hitElement ~= localPlayer) then 
		return false 
	end
	if (getElementData(hitElement, "Occupation") == "Farmer") then
		exports.NGCdxmsg:createNewDxMessage("Press Right Mouse Botton (RMB) to plant, also use your fist.", 0, 255, 0)
		bindKey("mouse2", "down", farmerOccupation)
	end
	if (isPedInVehicle(hitElement) and getElementModel(getPedOccupiedVehicle(hitElement)) == 532) then
		if (not Harvester) then
			exports.NGCdxmsg:createNewDxMessage("You can't harvest until the plants grow up", 255, 0, 0)
		end
		local v = getPedOccupiedVehicle(hitElement)
		for index, vehicle in ipairs(getElementsWithinColShape(source)) do
			setElementCollidableWith(vehicle, v, false)
		end
	end
end
addEventHandler("onClientColShapeHit", farmerColSphare, bindSeed)
addEventHandler("onClientColShapeHit", farmerColSphare2, bindSeed)
addEventHandler("onClientColShapeHit", farmerColSphare3, bindSeed)

function farmerOccupation()
	if (getTickCount() - antiSpamTimer < 2000) then 
		return false 
	end
	if (isPedInVehicle(localPlayer)) then 
		return false 
	end
	if (getPedWeaponSlot(localPlayer) ~= 0) then
		return false
	end
	if (not isElementWithinColShape(localPlayer, farmerColSphare) and not isElementWithinColShape(localPlayer, farmerColSphare2) and not isElementWithinColShape(localPlayer, farmerColSphare3)) then
		return false
	end
	antiSpamTimer = getTickCount()
	local SeedsCrop = getElementData(localPlayer, "Seed") or 0
	if (SeedsCrop == 0) then
		exports.NGCdxmsg:createNewDxMessage("You have no seeds left.", 255, 0, 0)
		return false
	end
	if (#crops >= 30) then
		exports.NGCdxmsg:createNewDxMessage("You can only plant a maximum of 30 plants.", 255, 0, 0)
		return false
	end
	if (lastCropPlantedCol) then
		local x, y = getElementPosition(localPlayer)
		local x2, y2 = unpack(lastCropPlantedCol)
		if (getDistanceBetweenPoints2D(x, y, x2, y2) < 2.5) then
			exports.NGCdxmsg:createNewDxMessage("You cannot place a plant so close to another!", 255, 0, 0)
			return false
		end
	end
	if (inCropColShape) then
		exports.NGCdxmsg:createNewDxMessage("You cannot place a plant so close to another!", 255, 0, 0)
		return false
	end
	local Planted = #crops
	triggerServerEvent("takeSeed", resourceRoot)
	setPedAnimation(localPlayer, "BOMBER", "BOM_Plant", 2500, false, false, false, false, 250)
	setTimer(setPedAnimation, 2500, 1, localPlayer)
	setTimer(
		function()
			local cropID = #crops + 1
			crops[cropID] = {}
			local x, y, z = getElementPosition(localPlayer)
			local groundPos = getGroundPosition(x, y, z) - 0.25
			local fullPlant = createObject(3409, x, y, groundPos)
			local fullblip = createBlip(x, y, z, 0, 0, 255, 0)
			crops[cropID].plantObject = fullPlant
			crops[cropID].plantObjects = fullblip
			crops[cropID].colShape = createColCircle(x, y, 1.5)
			addEventHandler("onClientColShapeHit", crops[cropID].colShape, onCropColHit)
			addEventHandler("onClientColShapeLeave", crops[cropID].colShape,
				function(plr)
					if (plr ~= localPlayer) then
						return false
					end
					inCropColShape = false
				end
			)
			lastCropPlantedCol = {x, y}
			Harvester = false
			SetHarvestTimer()
			setObjectScale(fullPlant, 0.2)
			setTimer(setObjectScale, 20000, 1, fullPlant, 1)
			exports.NGCdxmsg:createNewDxMessage("You have "..getElementData(localPlayer, "Seed").." seeds remaining", 255, 255, 0)
		end
	, 1000, 1)
end

function leaveColsphere(player)
	if (player ~= localPlayer) then
		return false
	end
	unbindKey("mouse2", "down", farmerOccupation)
end
addEventHandler("onClientColShapeLeave", farmerColSphare, leaveColsphere)
addEventHandler("onClientColShapeLeave", farmerColSphare2, leaveColsphere)
addEventHandler("onClientColShapeLeave", farmerColSphare3, leaveColsphere)

function onCropColHit(hitElement)
	if (hitElement ~= localPlayer) then
		return false
	end
	inCropColShape = true
	if (not isPedInVehicle(localPlayer) or getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 532) then
		return false
	end
	if (not Harvester) then
		return false
	end
	for i = 1, #crops do
		if (source == crops[i].colShape) then
			destroyElement(source)
			pX, pY, pZ = getElementPosition(crops[i].plantObject)
			destroyElement(crops[i].plantObject)
			destroyElement(crops[i].plantObjects)
			crops[i].plantObjects = nil
			crops[i].plantObject = nil
			crops[i].colShape = nil
			crops[i].rewardPickup = createPickup(pX, pY, pZ + 1, 3, 2901)
			addEventHandler("onClientPickupHit", crops[i].rewardPickup, onRewardPickupHit)
			break
		end
	end
end

sendRewardTimer = false
sendRewardTimes = 1

function sendReward()
	sendRewardTimer = nil
	if (sendRewardTimes < 1) then
		return false
	end
	triggerServerEvent("giveSeedMoney", resourceRoot, sendRewardTimes)
	sendRewardTimes = 0
end

function onRewardPickupHit(player, dimensions)
	if (player ~= localPlayer or not dimensions) then
		return false
	end
	if (isPedInVehicle(localPlayer)) then
		return false
	end
	for i = 1, #crops do
		if (source == crops[i].rewardPickup) then
			antiSpam = true
			destroyElement(source)
			sendRewardTimes = sendRewardTimes + 1
			if (sendRewardTimer) then
				killTimer(sendRewardTimer)
			end
			sendRewardTimer = setTimer(sendReward, 2000, 1)
			table.remove(crops, i)
			break
		end
	end
end

function onElementDataChange( dataName, oldValue )
	if (dataName == "Occupation" and getElementData(localPlayer, dataName) == "Farmer") then
		initFarmerOccupation()
	elseif (dataName == "Occupation") then
		stopFarmerOccupation()
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onElementDataChange, false)

function onResourceStart()
	if (not getPlayerTeam(localPlayer)) then
		return false
	end
	local team = getTeamName(getPlayerTeam(localPlayer))
	if (getElementData(localPlayer, "Occupation") == "Farmer" and team == "Civilian Workers") then
		initFarmerOccupation()
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)

function initFarmerOccupation()
	if (isFarmer) then
		return false
	end
	seedCount = getElementData(localPlayer,"Seed") or 0
	exports.NGCdxmsg:createNewDxMessage("You have "..seedCount.." seeds, that are ready to be planted.", 255, 255, 0)
	isFarmer = true
end

function stopFarmerOccupation()
	if (not isFarmer) then
		return false
	end
	for i = 1, #crops do
		if isElement(crops[i].plantObject) then 
			destroyElement(crops[i].plantObject) 
		end
		if isElement(crops[i].plantObjects) then 
			destroyElement(crops[i].plantObjects) 
		end
		if isElement(crops[i].rewardPickup) then 
			destroyElement(crops[i].rewardPickup) 
		end
		if isElement(crops[i].colShape) then 
			destroyElement(crops[i].colShape) 
		end
		unbindKey("mouse2", "down", farmerOccupation)
	end
	guiSetVisible(Farmer, false)
	showCursor(false)
	exports.CSGranks:closePanel()
	removeEventHandler("onClientRender", root, drawTimeLeftOnHarvest)
	Harvester = false
	crops = {}
	isFarmer = false
end


function togglePilotPanel()
	if (getElementData(localPlayer,"Occupation") == "Farmer" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5", "down", togglePilotPanel)

