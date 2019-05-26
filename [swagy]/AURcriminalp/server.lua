local antiSpam = {}
local criminalRanks = {
	--Name, Required Points, whatGiveFunctiom
	{"L0. Trial", 0, function() return false end},
	{"L1. Criminal", 100, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",100 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",100 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",100 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",100 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",100 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",100 )
		exports.AURpayments:addMoney(thePlayer, 20000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L2. Criminal", 300, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",100 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",150 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",150 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",150 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",150 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",150 )
		exports.AURpayments:addMoney(thePlayer, 40000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L3. Criminal", 600, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",170 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",170 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",170 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",170 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",170 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",170 )
		exports.AURpayments:addMoney(thePlayer, 80000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L4. Criminal", 1000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",190 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",190 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",190 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",190 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",190 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",190 )
		exports.AURpayments:addMoney(thePlayer, 100000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L5. Criminal", 1500, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",200 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",200 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",200 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",200 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",200 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",200 )
		exports.AURpayments:addMoney(thePlayer, 120000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L6. Criminal", 2000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",220 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",220 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",220 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",220 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",220 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",220 )
		exports.AURpayments:addMoney(thePlayer, 150000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L7. Criminal", 2500, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",250 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",250 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",250 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",250 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",250 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed", 250 )
		exports.AURpayments:addMoney(thePlayer, 180000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L8. Criminal", 4000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",280 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",280 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",280 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",280 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",280 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",280 )
		exports.AURpayments:addMoney(thePlayer, 200000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L9. Criminal", 6000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",290 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",290 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",290 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",290 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",290 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",290 )
		exports.AURpayments:addMoney(thePlayer, 240000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L10. Criminal", 8000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",300 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",300 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",300 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",300 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",300 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",300 )
		exports.AURpayments:addMoney(thePlayer, 260000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L11. Criminal", 10000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",320 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",320 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",320 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",320 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",320 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",320 )
		exports.AURpayments:addMoney(thePlayer, 280000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L12. Criminal", 50000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",350 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",350 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",350 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",350 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",350 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",350 )
		exports.AURpayments:addMoney(thePlayer, 300000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L13. Criminal", 100000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",370 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",370 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",370 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",370 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",370 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",370 )
		exports.AURpayments:addMoney(thePlayer, 340000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L14. Criminal", 150000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",390 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",390 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",390 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",390 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",390 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",390 )
		exports.AURpayments:addMoney(thePlayer, 360000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L15. Criminal", 300000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",400 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",400 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",400 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",400 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",400 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",400 )
		exports.AURpayments:addMoney(thePlayer, 380000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L16. Criminal", 500000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",420 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",420 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",420 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",420 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",420 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",420 )
		exports.AURpayments:addMoney(thePlayer, 400000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L17. Criminal", 700000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",500 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",500 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",500 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",500 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",500 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",500 )
		exports.AURpayments:addMoney(thePlayer, 500000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L18. Criminal", 1000000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",700 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",700 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",700 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",700 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",700 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",700 )
		exports.AURpayments:addMoney(thePlayer, 600000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L18. Criminal", 2000000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",800 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",800 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",800 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",800 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",800 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",800 )
		exports.AURpayments:addMoney(thePlayer, 800000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
	{"L20. Criminal", 3000000, function(thePlayer)
		exports.csgdrugs:giveDrug(thePlayer, "LSD",1000 )
		exports.csgdrugs:giveDrug(thePlayer, "Cocaine",1000 )
		exports.csgdrugs:giveDrug(thePlayer, "Heroine",1000 )
		exports.csgdrugs:giveDrug(thePlayer, "Ritalin",1000 )
		exports.csgdrugs:giveDrug(thePlayer, "Ecstasy",1000 )
		exports.csgdrugs:giveDrug(thePlayer, "Weed",1000 )
		exports.AURpayments:addMoney(thePlayer, 1000000,"Custom","Criminal Promotion",0,"AURcriminalp")
		return true
	end},
}


function giveCriminalPoints (thePlayer, theReason, points) 
	local getCurrentPoints = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "criminalpoints")
	exports.AURcurtmisc:setPlayerAccountData(thePlayer, "criminalpoints", getCurrentPoints+points)
	setElementData(thePlayer, "criminalpoints", getCurrentPoints+points)
	checkRankings(thePlayer)
	return true 
end 

function takeCriminalPoints (thePlayer, theReason, points)
	local getCurrentPoints = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "criminalpoints")
	exports.AURcurtmisc:setPlayerAccountData(thePlayer, "criminalpoints", getCurrentPoints-points)
	setElementData(thePlayer, "criminalpoints", getCurrentPoints-points)
	checkRankings(thePlayer)
	return true 
end 

function getCriminalPoints (thePlayer)
	local getCurrentPoints = exports.AURcurtmisc:getPlayerAccountData(thePlayer, "criminalpoints")
	return getCurrentPoints
end 

function checkRankings (thePlayer) 
	if (not isElement(thePlayer)) or (not exports.server:isPlayerLoggedIn(thePlayer)) then return false end
	for i=1, #criminalRanks do 
		if (math.floor(getCriminalPoints(thePlayer)) <= criminalRanks[i][2]) then 
			if ((getCriminalPoints(thePlayer)-criminalRanks[i][2]) <= 5 and (getCriminalPoints(thePlayer)-criminalRanks[i][2]) >= 0 ) then 
				local userID = exports.server:getPlayerAccountID(thePlayer)
				if (not isTimer(antiSpam[userID])) then 				
					if (criminalRanks[i][3](thePlayer) == true) then 
						exports.NGCdxmsg:createNewDxMessage(thePlayer, string.format(exports.AURlanguage:getTranslate("You got promoted to %s.", true, thePlayer), criminalRanks[i][1]), 66, 244, 98)
						antiSpam[userID] = setTimer(function() killTimer(antiSpam[userID]) end, 60000, 1)
					end 
				end 
			end 
			if (i+1 <= #criminalRanks) then 
				return criminalRanks[i][1], criminalRanks[i+1][1], criminalRanks[i+1][2]
			else
				return criminalRanks[i][1], 0, "-"
			end 
			
		end 
	end 
end 

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function ()
	for index, player in pairs(getElementsByType("player")) do	
		if (exports.server:isPlayerLoggedIn(player)) then
			setElementData(player, "criminalpoints", getCriminalPoints(player))
			local theRank, theNextRank, theNextRankP = checkRankings(player)
			setElementData(player, "criminalrank", theRank)
			setElementData(player, "criminalnextrank", theNextRank.." ("..theNextRankP.." points)")
		end
		
	end 
end)

addEventHandler("onPlayerLogin", getRootElement(), function()
	setElementData(source, "criminalpoints", getCriminalPoints(source))
	local theRank, theNextRank, theNextRankP = checkRankings(source)
	setElementData(source, "criminalrank", theRank)
	setElementData(source, "criminalnextrank", theNextRank.." ("..theNextRankP.." points)")
end)
