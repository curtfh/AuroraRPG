items = {
	"Stone", "Iron", "Gold", "Diamond", "Explosive Powder"
}
prices = {10,15,100,500,2500}
marker = createMarker(-396.39, 2209.86, 44.39, "cylinder", 2, 255, 255, 0)

function getPlayerItems(p)
	local itemsa = {}
	for i, v in ipairs(items) do
		if (exports.AURcrafting:isPlayerHasItem(p, v)) then
			itemsa[i] = exports.AURcrafting:getPlayerItemQuantity(p, v)
		else
			itemsa[i] = 0
		end
	end
	return itemsa
end

function hitMarker(hitElement)
	if (getElementType(hitElement) ~= "player") then
		return false 
	end
	if (getElementData(hitElement, "Occupation") ~= "Miner") then
		return false 
	end
	local x, y, z = getElementPosition(hitElement)
	if (z - 44.39 > 3) then
		return false 
	end
	triggerClientEvent(hitElement, "AURminerSell.gui", resourceRoot)
end
addEventHandler("onMarkerHit", marker, hitMarker)

function sellStuff(stuff)
	local aI = getPlayerItems(client)
	for i, v in ipairs(stuff) do
		if (tonumber(v)) then
			if (tonumber(v) ~= math.floor(tonumber(v))) then
				exports.NGCdxmsg:createNewDxMessage("Invalid amount entered: "..tostring(items[i]), client, 255, 25, 25)
				return false 
			end
			if (tonumber(aI[i]) < tonumber(v)) then
				exports.NGCdxmsg:createNewDxMessage("You don't have that much "..tostring(items[i]), client, 255, 25, 25)
			else
				exports.NGCdxmsg:createNewDxMessage("Sold "..v.." "..tostring(items[i]).." for $"..tostring(tonumber(v)*prices[i]), client, 255, 25, 25)
				exports.CSGlogging:createLogRow(client, "miner_sell", getPlayerName(client).." sold "..v.." "..tostring(items[i]).."for $"..tostring(tonumber(v)*prices[i]))
				givePlayerMoney(client, tonumber(v)*prices[i])
				exports.AURcrafting:removePlayerItem(client, items[i], v)
			end
		end
	end
	triggerClientEvent(client, "AURminerSell.gui", resourceRoot)
end
addEvent("AURminerSell.sell", true)
addEventHandler("AURminerSell.sell", resourceRoot, sellStuff)