--[[
Server Name: AuroraRPG
Resource Name: AURcrafting
Version: 1.0
Developer/s: Curt
]]--

function getAllPlayerWeapons(player)
	local table = {}
	for i=0, 13 do
		local weapon = getPedWeapon(player,i)
		
		if (weapon and getPedTotalAmmo(player,i) ~= 0) then
			local theVal = #table + 1
			table[theVal] = {getWeaponNameFromID(weapon), getPedTotalAmmo(player, i)}
		end
	end
	 
	return table
end

function getInventoryData (player)
	if (not exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") or exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") == "" or not fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))) then
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	end 
	if (exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data")) then
		local theTable = {}
		local customItems = fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))
		local weapTable = getAllPlayerWeapons(player)
		for i=1, #weapTable do
			local theVal = #theTable+1
			theTable[theVal] = {weapTable[i][1], weapTable[i][2]}
		end
		for i=1, #customItems do
			local theVal = #theTable+1
			theTable[theVal] = {customItems[i][1], customItems[i][2]}
		end
		triggerClientEvent(player, "aurcrafting.updateList", player, toJSON(theTable))
		return 
	end 
	exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	triggerClientEvent(player, "aurcrafting.updateList", player, toJSON(getAllPlayerWeapons(player)))
	
end 
addEvent("aurcrafting.getInventoryData", true)
addEventHandler("aurcrafting.getInventoryData", resourceRoot, getInventoryData)

function addPlayerItem (player, item, quantity)
	if (quantity == nil or quantity == "") then 
		quantity = 1
	end 
	if (not exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") or exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") == "" or not fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))) then
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	end 
	if (exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data")) then
		local theTable = {}
		local countable = 0
		local existants = ""
		local customItems = fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))
		for i=1, #customItems do
			local theVal = #theTable+1
			if (item == customItems[i][1]) then
				local theVal = #theTable+1
				theTable[theVal] = {customItems[i][1], customItems[i][2]+quantity}
				existants = customItems[i][1]
			else
				theTable[theVal] = {customItems[i][1], customItems[i][2]}
			end 
			countable = countable + 1
		end
		local theVal = #theTable+1
		if (countable == 0) then 
			theTable[theVal] = {item, quantity}
		elseif (existants ~= item) then 
			theTable[theVal] = {item, quantity}
		end 
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", toJSON(theTable))
		return true
	end 
end 

function removePlayerItem (player, item, quantity)
	if (quantity == nil or quantity == "") then 
		quantity = 1
	end 
	quantity = math.floor(quantity)
	if (not exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") or exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") == "" or not fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))) then
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	end 
	if (exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data")) then
		local theTable = {}
		local customItems = fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))
		for i=1, #customItems do
			local theVal = #theTable+1
			if (item == customItems[i][1]) then
				local theVal = #theTable+1
				theTable[theVal] = {customItems[i][1], math.floor(customItems[i][2])-quantity}
			else 
				theTable[theVal] = {customItems[i][1], customItems[i][2]}
			end 
		end
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", toJSON(theTable))
		return true
	end 
end

function removePlayerAllItem (player, item)
	if (not exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") or exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") == "" or not fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))) then
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	end 
	if (exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data")) then
		local theTable = {}
		local customItems = fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))
		for i=1, #customItems do
			local theVal = #theTable+1
			if (item ~= customItems[i][1]) then
				theTable[theVal] = {customItems[i][1], customItems[i][2]}
			end 
		end
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", toJSON(theTable))
		return true
	end 
end 

function isPlayerHasItem (player, item)
	if (not exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") or exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") == "" or not fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))) then
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	end 
	if (exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data")) then
		local theTable = {}
		local customItems = fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))
		for i=1, #customItems do
			if (item == customItems[i][1]) then
				return true
			end 
		end
		return false
	end 
end 

function getPlayerItemQuantity (player, item)
	if (not exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") or exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") == "" or not fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))) then
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	end 
	if (exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data")) then
		local theTable = {}
		local customItems = fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))
		for i=1, #customItems do
			if (item == customItems[i][1]) then
				if (math.floor(customItems[i][2]) <= 0) then 
					removePlayerAllItem(player, item)
					return 0
				end 
				return math.floor(customItems[i][2])
			end 
		end
		return false
	end 
end 

function getAllCraftableItems ()
	local finalTable = {}
	local file = fileOpen("items.json")
	local theTable = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file) 
	for j=1, #theTable do
		if (theTable[j][3] == true) then 
			local theVal = #finalTable+1
			finalTable[theVal] = {theTable[j][1], theTable[j][2], theTable[j][3], theTable[j][4]}
		end 
	end 
	return toJSON(finalTable)
end 

function clientGetAllCraftableItems (player)
	triggerClientEvent(player, "aurcrafting.updateCraftableList", player, getAllCraftableItems())
end 
addEvent("aurcrafting.clientGetAllCraftableItems", true)
addEventHandler("aurcrafting.clientGetAllCraftableItems", resourceRoot, clientGetAllCraftableItems)

function reanableAllThings (player)
	toggleAllControls (player, true, true, true) 
	fadeCamera (player, true)
	toggleControl(player, "jump", true)
	toggleControl(player, "fire", true)
	toggleControl(player, "next_weapon", true)
	toggleControl(player, "previous_weapon", true)
	toggleControl(player, "forwards", true)
	toggleControl(player, "backwards", true)
	toggleControl(player, "left", true)
	toggleControl(player, "right", true)
	toggleControl(player, "zoom_in", true)
	toggleControl(player, "zoom_out", true)
	toggleControl(player, "sprint", true)
	toggleControl(player, "look_behind", true)
	toggleControl(player, "crouch", true)
	toggleControl(player, "action", true)
	toggleControl(player, "walk", true)
	toggleControl(player, "aim_weapon", true)
	toggleControl(player, "conversation_yes", true)
	toggleControl(player, "conversation_no", true)
	toggleControl(player, "group_control_forwards", true)
	toggleControl(player, "group_control_back", true)
	toggleControl(player, "enter_exit", true)
end 

function disableAllThings (player)
	toggleAllControls (player, false, false, false) 
	toggleControl(player, "jump", false)
	toggleControl(player, "fire", false)
	toggleControl(player, "next_weapon", false)
	toggleControl(player, "previous_weapon", false)
	toggleControl(player, "forwards", false)
	toggleControl(player, "backwards", false)
	toggleControl(player, "left", false)
	toggleControl(player, "right", false)
	toggleControl(player, "zoom_in", false)
	toggleControl(player, "zoom_out", false)
	toggleControl(player, "sprint", false)
	toggleControl(player, "look_behind", false)
	toggleControl(player, "crouch", false)
	toggleControl(player, "action", false)
	toggleControl(player, "walk", false)
	toggleControl(player, "aim_weapon", false)
	toggleControl(player, "conversation_yes", false)
	toggleControl(player, "conversation_no", false)
	toggleControl(player, "group_control_forwards", false)
	toggleControl(player, "group_control_back", false)
	toggleControl(player, "enter_exit", false)
end 

function playerCraftItem (player, item, quantity)
	if (quantity == 0 or quantity == nil or quantity == "") then 
		quantity = 1
	end 
	quantity = math.floor(quantity)
	if (not exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") or exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data") == "" or not fromJSON(exports.AURcurtmisc:getPlayerAccountData((player), "aurcrafting.data"))) then
		exports.AURcurtmisc:setPlayerAccountData((player), "aurcrafting.data", "[[]]")
	end 
	if (item == "Armor") then 
		if (quantity ~= 1) then 
			exports.NGCdxmsg:createNewDxMessage(player, "You cannot craft more than 1 quantity.", 255, 0, 0)
			return false
		end 
	end 
	local file = fileOpen("items.json")
	local theTable = fromJSON(fileRead(file, fileGetSize(file)))
	local totalRequired = 0
	local realTotalR = 0
	fileClose(file) 
	for i=1, #theTable do
		if (item == theTable[i][1]) then
			if (theTable[i][3] == true) then 
				local theRequired = fromJSON(theTable[i][4])
				for j=1, #theRequired do
					if (isPlayerHasItem(player, theRequired[j][1]) == true) then 
						if (getPlayerItemQuantity(player, theRequired[j][1]) >= math.floor(theRequired[j][2])*quantity) then
							totalRequired = totalRequired + 1
						end 
					end 
					realTotalR = realTotalR + 1
				end
			end 
			if (realTotalR == totalRequired) then 
				local theRequired = fromJSON(theTable[i][4])
				exports.NGCdxmsg:createNewDxMessage(player, "You crafted a "..quantity.."x "..item..".", 66, 244, 98)
				for j=1, #theRequired do
					removePlayerItem(player, theRequired[j][1], math.floor(theRequired[j][2])*quantity)
				end 
				if (item == "Grenade") then 
					giveWeapon (player, 16, quantity)
				elseif (item == "Satchel") then 
					giveWeapon (player, 39, quantity)
				elseif (item == "Armor") then 
					exports.NGCdxmsg:createNewDxMessage(player, "You have been frozen for 5 seconds because you were crafting an armour.", 66, 244, 98)
					setElementFrozen(player, true)
					disableAllThings(player)
					setTimer(function()
						setPlayerArmor(player, 100)
						setElementFrozen(player, false)
						reanableAllThings(player)
					end, 5000, 1)
				elseif (item == "Ritalin") then 
					exports.csgdrugs:giveDrug(player, "Ritalin",quantity)
				elseif (item == "LSD") then 
					exports.csgdrugs:giveDrug(player, "LSD",quantity)
				elseif (item == "Cocaine") then 
					exports.csgdrugs:giveDrug(player, "Cocaine",quantity)
				elseif (item == "Ecstasy") then 
					exports.csgdrugs:giveDrug(player, "Ecstasy",quantity)
				elseif (item == "Heroine") then 
					exports.csgdrugs:giveDrug(player, "Heroine",quantity)
				elseif (item == "Weed") then 
					exports.csgdrugs:giveDrug(player, "Weed",quantity)
				else
					addPlayerItem(player, item, quantity)
				end 
				return true
			else 
				exports.NGCdxmsg:createNewDxMessage(player, "You failed to craft "..item.." due to inefficient required items.", 255, 0, 0)
				return false
			end 
		end 
	end
end 
addEvent("aurcrafting.playerCraftItem", true)
addEventHandler("aurcrafting.playerCraftItem", resourceRoot, playerCraftItem)