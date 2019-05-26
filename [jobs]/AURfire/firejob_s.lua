function rewardFireman()
	local _, rank = exports.CSGranks:getRank(client, "Firefighter")

	exports.CSGranks:addStat(client, 1)
	exports.AURpayments:addMoney(client, rank * 100, "Custom", "Misc", 0, "AURfire Fireman")
	exports.AURunits:giveUnitMoney(client, rank * 100, "Fireman")
	exports.CSGscore:givePlayerScore(client, 1)
	exports.NGCdxmsg:createNewDxMessage(client, "You have earned $"..tostring(rank * 100).." from extinguishing fire", 0, 255, 0)
	exports.NGCdxmsg:createNewDxMessage(client, "You have earned 1 score", 0, 255, 0)
end
addEvent("AURfire.reward", true)
addEventHandler("AURfire.reward", root, rewardFireman)