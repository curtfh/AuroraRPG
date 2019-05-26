local antiSpamTimer

function takeSeedMoney()
	local plrMoney = getPlayerMoney(client)
	if (plrMoney <= 500) then
		outputChatBox("You do not have enough money.")
		return false
	end
	exports.AURpayments:takeMoney(client, 500, "AURfarmer")
	exports.AURcrafting:addPlayerItem(client , "Seed", 20)
	if (exports.AURcrafting:isPlayerHasItem(client, "Seed") == true) then 
		setElementData(client, "Seed", exports.AURcrafting:getPlayerItemQuantity(client, "Seed"))
	else
		setElementData(client, "Seed", 0)
	end 
	outputChatBox("You bought 20 hits of seeds for $500.", client, 0, 255,0)
end
addEvent("takeSeedmoney", true)
addEventHandler("takeSeedmoney", resourceRoot, takeSeedMoney)

function giveSeedMoney(times)
	for i = 1, times do
		exports.AURpayments:addMoney(client, 1000, "Custom", "Farmer", 0, "AURfarmer Seed harvest")
		exports.AURunits:giveUnitMoney(client, 1000, "Farmer")
		exports.CSGranks:addStat(client, 1)
		exports.AURcrafting:addPlayerItem(client, "Herbs", math.random(10, 30))
		exports.CSGscore:givePlayerScore(client, 0.2)
		exports.AURsamgroups:addXP(client, 8)
	end
end
addEvent("giveSeedMoney", true)
addEventHandler("giveSeedMoney", resourceRoot, giveSeedMoney)

function takeSeed()
	exports.AURcrafting:removePlayerItem(client, "Seed", 4)
	if (exports.AURcrafting:isPlayerHasItem(client, "Seed") == true) then 
		setElementData(client, "Seed", exports.AURcrafting:getPlayerItemQuantity(client, "Seed"))
	else 
		setElementData(client, "Seed", 0)
	end
end
addEvent("takeSeed", true)
addEventHandler("takeSeed", resourceRoot, takeSeed)

function setPlrSeeds()
	if (eventName == "onPlayerLogin") then
		setElementData(source, "Seed", exports.AURcrafting:getPlayerItemQuantity(source, "Seed"))
		return true
	end
	for i, v in ipairs(getElementsByType("player")) do
		if (exports.server:isPlayerLoggedIn(v)) then
			setElementData(v, "Seed", exports.AURcrafting:getPlayerItemQuantity(v, "Seed"))
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, setPlrSeeds)
addEventHandler("onPlayerLogin", root, setPlrSeeds)


