local inventoryGUI = {}
local sellingGUI = {}
local isSellingShowing = false
local isInventoryShowing = false
local sX_, sY_ = guiGetScreenSize()
local sX = sX_/1366
local sY = sY_/768

addEvent("AURdrug_trafficker.requestPosition", true)
addEventHandler("AURdrug_trafficker.requestPosition", root,
	function()
		if (getPedOccupiedVehicle(localPlayer)) then
			local veh = getPedOccupiedVehicle(localPlayer)
			for k in pairs(getVehicleComponents(veh)) do
				if (k == "door_lf_dummy") then
					local x, y, z = getVehicleComponentPosition(veh, k, "world")
					triggerServerEvent("AURdrug_trafficker.receivePosition", localPlayer, x, y, z)
				end
			end
		end
	end
)

addEvent("AURdrug_trafficker.requestDrugs", true)
addEventHandler("AURdrug_trafficker.requestDrugs", root, function(data)
	tab = data
end)

function initInventoryElem()
	inventoryGUI["Ritalin"] = guiCreateEdit(sX*657, sY*249, sX*200, sY*28, "Wait while we get the value.", false)
	inventoryGUI["LSD"] = guiCreateEdit(sX*657, sY*301, sX*200, sY*28, "Wait while we get the value.", false)
	inventoryGUI["Cocaine"] = guiCreateEdit(sX*657, sY*356, sX*200, sY*28, "Wait while we get the value.", false)
	inventoryGUI["Ecstasy"] = guiCreateEdit(sX*657, sY*411, sX*200, sY*28, "Wait while we get the value.", false)
	inventoryGUI["Heroine"] = guiCreateEdit(sX*657, sY*466, sX*200, sY*28, "Wait while we get the value.", false)
	inventoryGUI["Weed"] = guiCreateEdit(sX*657, sY*524, sX*200, sY*28, "Wait while we get the value.", false) 
end

function destroyInventoryElem()
	destroyElement(inventoryGUI["Ritalin"])
	destroyElement(inventoryGUI["LSD"])
	destroyElement(inventoryGUI["Cocaine"])
	destroyElement(inventoryGUI["Ecstasy"])
	destroyElement(inventoryGUI["Heroine"])
	destroyElement(inventoryGUI["Weed"])
end

function initInventoryDx()
	dxDrawRectangle(sX*381, sY*170, sX*605, sY*428, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sX*381, sY*170, sX*605, sY*40, tocolor(0, 0, 0, 183), false)
	dxDrawText("Inventory", sX*381 - 1, sY*170 - 1, sX*986 - 1, sY*210 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Inventory", sX*381 + 1, sY*170 - 1, sX*986 + 1, sY*210 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Inventory", sX*381 - 1, sY*170 + 1, sX*986 - 1, sY*210 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Inventory", sX*381 + 1, sY*170 + 1, sX*986 + 1, sY*210 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Inventory", sX*381, sY*170, sX*986, sY*210, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Ritalin: "..tab["Ritalin"][1].." hits.", sX*398, sY*239, sX*622, sY*284, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("LSD: "..tab["LSD"][1].." hits.", sX*398, sY*294, sX*622, sY*339, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Cocaine: "..tab["Cocaine"][1].." hits.", sX*398, sY*349, sX*622, sY*394, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Ecstasy: "..tab["Ecstasy"][1].." hits.", sX*398, sY*404, sX*622, sY*449, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Heroine: "..tab["Heroine"][1].." hits.", sX*398, sY*459, sX*622, sY*504, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Weed: "..tab["Weed"][1].." hits.", sX*398, sY*514, sX*622, sY*559, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Click outside of the window to close it and press enter to confirm.", sX*379, sY*210, sX*986, sY*239, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", true, true, false, false, false)
end

function openInventory()
	if (isInventoryShowing) then
		destroyInventoryElem()
		removeEventHandler("onClientRender", root, initInventoryDx)
		isInventoryShowing = false
		showCursor(false)
		guiSetInputMode("allow_binds")
	else
		triggerServerEvent("AURdrug_trafficker.sendDrugs", localPlayer)
		initInventoryElem()
		addEventHandler("onClientRender", root, initInventoryDx)
		isInventoryShowing = true
		showCursor(true)
		guiSetInputMode("no_binds_when_editing")
		setTimer(function()
			for k, v in pairs(tab) do
				guiSetText(inventoryGUI[k], v[2])
			end
		end, 1000, 1)
	end
end
addCommandHandler("drug_inventory", openInventory)

addEventHandler("onClientClick", root, function(btn, state, x, y)
	if (btn == "left") and (state == "down") and (isInventoryShowing) then
		if ((x >= sX*381) and (x <= sX*(381 + 605)) and (y >= sY*170) and (y <= sY*(170 + 428))) then
			--Don't close the window
		else
			print("close inventory")
			destroyInventoryElem()
			removeEventHandler("onClientRender", root, initInventoryDx)
			isInventoryShowing = false
			showCursor(false)
			guiSetInputMode("allow_binds")
		end
	end
end)

addEventHandler("onClientKey", root, function(btn, str)
	if (btn == "enter") and (str) and (isInventoryShowing) then
		for k, v in pairs(inventoryGUI) do
			local newPrice = guiGetText(inventoryGUI[k])
			if not (tonumber(newPrice)) then return false end
		end
		for k, v in pairs(inventoryGUI) do
			local newPrice = tonumber(guiGetText(inventoryGUI[k]))
			tab[k][2] = newPrice
		end
		destroyInventoryElem()
		removeEventHandler("onClientRender", root, initInventoryDx)
		isInventoryShowing = false
		showCursor(false)
		triggerServerEvent("AURdrug_trafficker.requestClientDrugs", localPlayer, tab)
		guiSetInputMode("allow_binds")
	end
end)

function initSellingElem(data)
	sellingGUI["Ritalin"] = guiCreateEdit(sX*660, sY*224, sX*136, sY*31, "", false)
	sellingGUI["LSD"] = guiCreateEdit(sX*660, sY*265, sX*136, sY*31, "", false)
	sellingGUI["Cocaine"] = guiCreateEdit(sX*660, sY*306, sX*136, sY*31, "", false)
	sellingGUI["Ecstasy"] = guiCreateEdit(sX*660, sY*347, sX*136, sY*31, "", false)
	sellingGUI["Heroine"] = guiCreateEdit(sX*660, sY*394, sX*136, sY*31, "", false)
	sellingGUI["Weed"] = guiCreateEdit(sX*660, sY*439, sX*136, sY*31, "", false)  
	--[[for k, v in pairs(data) do
		guiSetText(sellingGUI[k], v[2])
	end]]
	sellingData = data
end

function destroySellingElem()
	destroyElement(sellingGUI["Ritalin"])
	destroyElement(sellingGUI["LSD"])
	destroyElement(sellingGUI["Cocaine"])
	destroyElement(sellingGUI["Ecstasy"])
	destroyElement(sellingGUI["Heroine"])
	destroyElement(sellingGUI["Weed"])
end

function initSellingDx()
	dxDrawRectangle(sX*387, sY*155, sX*593, sY*384, tocolor(0, 0, 0, 183), false)
	dxDrawRectangle(sX*387, sY*155, sX*593, sY*33, tocolor(0, 0, 0, 183), false)
	dxDrawText("Buy Drugs", sX*387 - 1, sY*155 - 1, sX*980 - 1, sY*188 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy Drugs", sX*387 + 1, sY*155 - 1, sX*980 + 1, sY*188 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy Drugs", sX*387 - 1, sY*155 + 1, sX*980 - 1, sY*188 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy Drugs", sX*387 + 1, sY*155 + 1, sX*980 + 1, sY*188 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy Drugs", sX*387, sY*155, sX*980, sY*188, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Ritalin: "..sellingData["Ritalin"][1].." hits left.", sX*406, sY*222, sX*597, sY*255, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("LSD: "..sellingData["LSD"][1].." hits left.", sX*406, sY*265, sX*597, sY*298, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Cocaine: "..sellingData["Cocaine"][1].." hits left.", sX*406, sY*308, sX*597, sY*341, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Ecstasy: "..sellingData["Ecstasy"][1].." hits left.", sX*406, sY*351, sX*597, sY*384, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Heroine: "..sellingData["Heroine"][1].." hits left.", sX*406, sY*394, sX*597, sY*427, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Weed: "..sellingData["Weed"][1].." hits left.", sX*406, sY*437, sX*597, sY*470, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText(sellingData["Ritalin"][2].." $ per hit", sX*806, sY*222, sX*980, sY*255, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText(sellingData["LSD"][2].." $ per hit", sX*806, sY*265, sX*980, sY*298, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText(sellingData["Cocaine"][2].." $ per hit", sX*806, sY*308, sX*980, sY*341, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText(sellingData["Ecstasy"][2].." $ per hit", sX*806, sY*345, sX*980, sY*378, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText(sellingData["Heroine"][2].." $ per hit", sX*806, sY*392, sX*980, sY*425, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText(sellingData["Weed"][2].." $ per hit", sX*806, sY*437, sX*980, sY*470, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawRectangle(sX*584, sY*480, sX*202, sY*47, tocolor(0, 0, 0, 183), false)
	dxDrawText("Buy", sX*584 - 1, sY*480 - 1, sX*786 - 1, sY*527 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy", sX*584 + 1, sY*480 - 1, sX*786 + 1, sY*527 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy", sX*584 - 1, sY*480 + 1, sX*786 - 1, sY*527 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy", sX*584 + 1, sY*480 + 1, sX*786 + 1, sY*527 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Buy", sX*584, sY*480, sX*786, sY*527, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Click outside of the window to close it.", sX*387 - 1, sY*188 - 1, sX*980 - 1, sY*222 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText("Click outside of the window to close it.", sX*387 + 1, sY*188 - 1, sX*980 + 1, sY*222 - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText("Click outside of the window to close it.", sX*387 - 1, sY*188 + 1, sX*980 - 1, sY*222 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText("Click outside of the window to close it.", sX*387 + 1, sY*188 + 1, sX*980 + 1, sY*222 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
	dxDrawText("Click outside of the window to close it.", sX*387, sY*188, sX*980, sY*222, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, true, false, false, false)
end

addEvent("AURdrug_trafficker.startSelling", true)
addEventHandler("AURdrug_trafficker.startSelling", root, function(data)
	if not (isSellingShowing) then
		initSellingElem(data)
		addEventHandler("onClientRender", root, initSellingDx)
		isSellingShowing = true
		showCursor(true)
		guiSetInputMode("no_binds_when_editing")
	end
end)

addEvent("AURdrug_trafficker.stopSelling", true)
addEventHandler("AURdrug_trafficker.stopSelling", root, function()
	destroySellingElem()
	removeEventHandler("onClientRender", root, initSellingDx)
	isSellingShowing = false
	showCursor(false)
	guiSetInputMode("allow_binds")
end)

addEventHandler("onClientClick", root, function(btn, state, x, y)
	if (btn == "left") and (state == "down") and (isSellingShowing) then
		if ((x >= sX*584) and (x <= sX*(584 + 202)) and (y >= sY*480) and (y <= sY*(480 + 47))) then
			boughtDrugs = {}
			for k, v in pairs(sellingGUI) do
				local amount = guiGetText(v)
				local tamount = tonumber(amount)
				if (tamount) then
					if (tamount < 1) then return exports.NGCdxmsg:createNewDxMessage("Drugs amount must be positive.",255,0,0) end
					if (tamount > sellingData[k][1])  then return false end
					boughtDrugs[k] = tamount
				elseif (amount == "") then
					boughtDrugs[k] = 0
				else
					return false
				end
			end
			triggerServerEvent("AURdrug_trafficker.buyDrugs", localPlayer, boughtDrugs)
			print("close selling")
			destroySellingElem()
			removeEventHandler("onClientRender", root, initSellingDx)
			isSellingShowing = false
			showCursor(false)
			guiSetInputMode("allow_binds")
		end
	end
end)

addEventHandler("onClientClick", root, function(btn, state, x, y)
	if (btn == "left") and (state == "down") and (isSellingShowing) then
		if ((x >= sX*387) and (x <= sX*(387 + 593)) and (y >= sY*155) and (y <= sY*(155 + 384))) then
			--Don't close the window
		else
			print("close selling")
			destroySellingElem()
			removeEventHandler("onClientRender", root, initSellingDx)
			isSellingShowing = false
			showCursor(false)
			guiSetInputMode("allow_binds")
		end
	end
end)

if (fileExists("client.lua")) then
	fileDelete("client.lua")
end
		