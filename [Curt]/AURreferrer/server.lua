function redeemCode (thePlayer, theCommand, theCode)
	if (not theCode) then 
		exports.NGCdxmsg:createNewDxMessage("Syntax: /redeem <account name>", thePlayer, 255, 0, 0)
		return 
	end 
	if (exports.AURcurtmisc:getPlayerAccountData(thePlayer, "AURreferrer") ~= "") then 
		exports.NGCdxmsg:createNewDxMessage("You already redeem a referrer code.", thePlayer, 255, 0, 0)
		return
	end 

	local can,msg = exports.NGCmanagement:isPlayerLagging(thePlayer)

	if (not can) then
		exports.NGCdxmsg:createNewDxMessage("You cannot use this feature while lagging", thePlayer, 255, 0, 0)
		return false
	end

	for k, theSPlayer in pairs(getElementsByType("player")) do
		if (exports.server:getPlayerAccountName(theSPlayer) == theCode) then 
			if (exports.server:getPlayerAccountName(theSPlayer) == exports.server:getPlayerAccountName(thePlayer)) then 
				exports.NGCdxmsg:createNewDxMessage("You cannot use your account.", thePlayer, 255, 0, 0)
				return
			end
			moneyReward = 20000
			if (exports.AURcurtmisc:getPlayerAccountData(theSPlayer, "AURreferrer") ~= "") then
				moneyReward = 20000
			end
			exports.server:givePlayerBankMoney(theSPlayer, 20000)
			exports.server:givePlayerBankMoney(thePlayer, 20000)
			exports.CSGlogging:createLogRow(thePlayer, "money", getPlayerName(thePlayer).." has used referrall on: "..getPlayerName(theSPlayer).." $"..tostring(moneyReward).. " given.")
			exports.CSGlogging:createLogRow(theSPlayer, "money", getPlayerName(theSPlayer).." has got referall from: "..getPlayerName(thePlayer).." $"..tostring(moneyReward).. " given.")
			exports.NGCdxmsg:createNewDxMessage("You successfully redeem code '"..theCode.."'. Enjoy extra $20,000 on your bank account.", thePlayer, 0, 255, 0)
			exports.NGCdxmsg:createNewDxMessage("You successfully invited "..getPlayerName(thePlayer).." from the server. Enjoy extra $20,000 on your bank account.", theSPlayer, 0, 255, 0)
			exports.AURcurtmisc:setPlayerAccountData(thePlayer, "AURreferrer", theCode)
			return
		end 
	end
	exports.NGCdxmsg:createNewDxMessage("The player is offline or the account doesn't exists. Please tell them to go in game and try again.", thePlayer, 255, 0, 0)
end 
addCommandHandler("redeem", redeemCode)