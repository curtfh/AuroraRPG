function takeJob (team, occupation)

	if (team == "Civilian Workers") and (occupation == "Postman") then
		triggerClientEvent(source, "AURpostman.startJob", source)
	end
end
addEventHandler("onSetPlayerJob", root, takeJob)

function startShift (occupation)

	if (occupation == "Postman") then
		triggerClientEvent(source, "AURpostman.startJob", source)
	end
end
addEventHandler("onStartShift", root, startShift)


function quitJob (oldJob)

	triggerClientEvent(source, "AURpostman.endJob", source)

end
addEventHandler("onQuitJob", root, quitJob)

function endShift ()

	triggerClientEvent(source, "AURpostman.endJob", source)

end
addEventHandler("onEndShift", root, quitJob)


function paymentHandler (player, houseOwner)

	local randomMoney = math.random(5000,7000)
	local tip = math.random(500,1000)
	givePlayerMoney(player, randomMoney)
	givePlayerMoney(player, tip)
	exports.CSGscore:givePlayerScore(player, 1.5)
	exports.NGCdxmsg:createNewDxMessage("You have earned $"..tostring(randomMoney).." for delivering a letter!",player,255,255,0)
	exports.NGCdxmsg:createNewDxMessage(""..houseOwner.." has given you $"..tostring(tip).." as a tip!",player,255,255,0)
end
addEvent("AURpostman.payment", true)
addEventHandler("AURpostman.payment", root, paymentHandler)
