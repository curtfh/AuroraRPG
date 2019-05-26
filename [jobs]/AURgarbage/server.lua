function payGarbageDriver()
	exports.CSGranks:addStat(source, 1)
	exports.AURpayments:addMoney(source, 2000, "Custom", "Trash Collector", 0, "AURgarbage")
	exports.CSGscore:givePlayerScore(source, 1)
	exports.NGCdxmsg:createNewDxMessage(source, "You have earned $2000 from collecting trash", 0, 255, 0)
	exports.NGCdxmsg:createNewDxMessage(source, "You have earned 1 score", 0, 255, 0)
end
addEvent("collectedTrashMoney", true)
addEventHandler("collectedTrashMoney", getRootElement(), payGarbageDriver)
