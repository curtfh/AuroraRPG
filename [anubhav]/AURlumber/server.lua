function lumberJackPayment()
	local _ ,r = exports.CSGranks:getRank(client, "Lumberjack")
	
	exports.CSGranks:addStat(client, 1)
	exports.NGCdxmsg:createNewDxMessage(client, "Cut down a tree: Paid $"..tostring(r * 400).." & 0.5 score", 0, 255, 0)
	exports.CSGscore:givePlayerScore(client, 0.5)
	exports.AURpayments:addMoney(client, r * 400, "Custom", "Misc", 0, "AURlumber")
	exports.AURunits:giveUnitMoney(client, r * 400, "Tree cut down")
	exports.AURsamgroups:addXP(client, 9)
end
addEvent("payLumberJack", true)
addEventHandler("payLumberJack", resourceRoot, lumberJackPayment)