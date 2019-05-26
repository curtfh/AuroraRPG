local locations = {}

local couponCodes = {}

local items = {
	{"Water Bottle", 30, "A water bottle is required for crafting 'Weed' (1x Water Bottle, 1x Pot, 4x Weed Seed) through '/craft'", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Water Bottle", math.floor(q)) end},
	{"Pot", 80, "Pot is required for crafting 'Weed' (1x Water Bottle, 1x Pot, 4x Weed Seed) through '/craft'.", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Pot", math.floor(q)) end},
	{"Phosphorus", 1, "Phosphorous is required to craft Crystal versions of drugs from '/craft'.", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Phosphorus", math.floor(q)) end},
	{"Iodine", 1, "Iodine is required to craft Crystal versions of drugs using '/craft'.", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Iodine", math.floor(q)) end},
	{"Weed Seed", 10, "Weed Seeds are required to crafting 'Weed' (1x Water Bottle, 1x Pot, 4x Weed Seed) through '/craft'.", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Weed Seed", math.floor(q)) end},
	{"Band Aid", 50, "Band Aid is required to craft a 'Medic Kit' (1x Box, 30x Cotton Pads, 10x Band Aid) through '/craft'.", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Band Aid", math.floor(q)) end},
	{"Box", 50, "Box is required to craft a 'Medic Kit' (1x Box, 30x Cotton Pads, 10x Band Aid) through '/craft'.", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Box", math.floor(q)) end},
	{"Cotton Pads", 1, "Cotton Pads are required to craft a 'Medic Kit' (1x Box, 30x Cotton Pads, 10x Band Aid) through '/craft'.", function(cplayer, q) return exports.AURcrafting:addPlayerItem(cplayer, "Cotton Pads", math.floor(q)) end},
	{"Instant Food", 50, "Gives you health. Reheated from microwave.", function(cplayer, q) setElementHealth(cplayer, getElementHealth(cplayer)+20) return true end},
	{"Bike Helmet", 500, "A helmet for a bike.", function(cplayer, q) 
		if (exports.AURcrafting:isPlayerHasItem(cplayer, "Bike Helmet") == true) then 
			exports.NGCdxmsg:createNewDxMessage("You already have a bike helmet.", cplayer, 255, 0, 0)
			return false
		end 
		if (q == 1) then 
			exports.AURcrafting:addPlayerItem(cplayer, "Bike Helmet", 1) 
			return true
		else 
			exports.NGCdxmsg:createNewDxMessage("This item only accept only 1 quantity.", cplayer, 255, 0, 0)
			return false
		end
	end},
}


function refreshTables ()
	local file1 = fileOpen("locations.json")
	local file2 = fileOpen("coupons.json")
	locations = fromJSON(fileRead(file1, fileGetSize(file1)))
	couponCodes = fromJSON(fileRead(file2, fileGetSize(file2)))
	fileClose(file1) 
	fileClose(file2) 
	for index, player in pairs(getElementsByType("player")) do
		triggerClientEvent(player, "aurconvstore.updateTables", player, locations, couponCodes, items)
	end
end 

function onPlayerJoin ()
	triggerClientEvent(source, "aurconvstore.updateTables", source, locations, couponCodes, items)
end 
addEventHandler ( "onPlayerLogin", getRootElement(), onPlayerJoin)

function addTable (player, cmd)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return end
	local x, y, z = getElementPosition(player)
	locations[#locations+1] = {x, y, z}
	local file1 = fileOpen("locations.json")
	fileWrite(file1, toJSON(locations))
	fileClose(file1)
	refreshTables()
	outputChatBox("Added position "..x..", "..y..", "..z, player)
end 
addCommandHandler("addstoretablestaff", addTable)

function sendSpawnTableToClient ()
	refreshTables()
	setTimer(function()
		for index, player in pairs(getElementsByType("player")) do
			triggerClientEvent(player, "aurconvstore.updateTables", player, locations, couponCodes, items)
		end
	end, 5000, 1)
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), sendSpawnTableToClient)

function playerBuyItem (player, itemid, quantity, discount)
	--if (not exports.server:isPlayerLoggedIn(player)) then return false end
	if (not isPedOnGround(player)) then return false end
	discount = discount or 0
	local countT = 0
	
	for i=1, #items do 
		countT = countT + 1
		if (math.floor(itemid) == countT) then
			local price = 0*exports.AURtax:getCurrentTax()
			if (discount == 0) then 
					price = (items[i][2]*math.floor(quantity))*exports.AURtax:getCurrentTax()
				else 
					price = (discount/100)*(items[i][2]*math.floor(quantity))*exports.AURtax:getCurrentTax()
			end 
			
			if (getPlayerMoney(player) >= price) then 
				if (items[i][4](player, quantity) == true) then 
					--takePlayerMoney(player, price)
					exports.AURpayments:takeMoney(player,price,"AURconvstore")
					exports.NGCdxmsg:createNewDxMessage(player, "You purchased "..items[i][1].." ("..quantity..") which costs $"..price..".", 0, 255, 0)
					exports.NGCdxmsg:createNewDxMessage( player, "Transaction Alert: "..exports.AURtax:getCurrentTax().."% has taken from your money due to taxes.", 225, 0, 0 )
				else 
					exports.NGCdxmsg:createNewDxMessage(player, "Failed to purchase an item. Please try again.", 255, 0, 0)
				end 
			else 
				exports.NGCdxmsg:createNewDxMessage(player, "You don't have enough money to buy that item.", 255, 0, 0)
			end 
		end 
	end 
end 
addEvent ("aurconvstore.playerBuyItem", true)
addEventHandler ("aurconvstore.playerBuyItem", resourceRoot, playerBuyItem)