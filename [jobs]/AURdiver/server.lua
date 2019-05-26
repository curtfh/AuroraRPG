spam = {}

addEventHandler("onPlayerLogin", root,function()
	local o24 = exports.DENstats:getPlayerAccountData(source,"oxygen")
	if o24 == nil or o24 == false or not o24 then o24 = 0 end
	if o24 < 0 then o24 = 0 end
	setElementData(source,"diveOxygen",o24)
	triggerClientEvent(source,"recO2",source,o24)
end)

stopspam = {}
addEvent("DiverbuyO2", true)
addEventHandler("DiverbuyO2", root,function()
	if isTimer(stopspam[source]) then
		exports.NGCdxmsg:createNewDxMessage(source,"Please wait 1 seconds between each tank refill",255,0,0)
		return false
	end
	if getPlayerMoney(source) >= 100 then
		stopspam[source] = setTimer(function() end,1000,1)
		local o2 = getElementData(source,"diveOxygen")
		if o2 == nil or o2 == false or not o2 then o2 = 0 end
		setElementData(source,"diveOxygen",o2+100)
		exports.DENstats:setPlayerAccountData(source,"oxygen",o2+100)
		exports.NGCdxmsg:createNewDxMessage(source,"You have refilled your oxygen tank by 100% (total: "..getElementData(source,"diveOxygen").."%) for $100",255,255,0)
		exports.AURpayments:takeMoney(source,100,"Custom",0,"Aur diver ox2")
		triggerClientEvent(source,"recO2",source,(o2+100))
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to buy oxygen",255,0,0)
	end
end)

addEvent("setAccountData",true)
addEventHandler("setAccountData",root,function()
	local o23 = getElementData(source,"diveOxygen")
	if not o23 then o23 = 0 end
	exports.DENstats:setPlayerAccountData(source,"oxygen",o23)
	if isPedInVehicle(source) then
		if ( getPlayerTeam(source) ) and (getElementData(source, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(source)) == "Civilian Workers") then
			removePedFromVehicle(source)
		end
	end
	if ( getPlayerTeam(source) ) and (getElementData(source, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(source)) == "Civilian Workers") then
		local elementStandingOn = getPedContactElement(source)
		if elementStandingOn and getElementType(elementStandingOn) == "vehicle" then
			local x,y,z = getElementPosition(source)
			setElementPosition(source,x+10,y+10,z)
			exports.NGCdxmsg:createNewDxMessage(source,"You can't jump on vehicle while you are a diver!!",255,0,0)
		end
	end
end)


addEvent("DiverPayout", true)
addEventHandler("DiverPayout", root,
function (m,m2)
	if isTimer(spam[source]) then return false end
	spam[source] = setTimer(function() end,5000,1)
	exports.NGCdxmsg:createNewDxMessage(source, "[Diver] : You earned $"..(m).." for collecting "..m2.." items", 0, 220, 0)
	exports.AURpayments:addMoney(source,m,"Custom","Misc",0,"AURdiver")
	exports.CSGranks:addStat(source,m2)
	if m2 >= 15 then
		sc = 3
	elseif m2 >= 10 then
		sc = 2
	elseif m2 >= 5 then
		sc = 1
	end
	exports.CSGscore:givePlayerScore(source,sc)
	exports.NGCdxmsg:createNewDxMessage(source, "[Diver] : You earned "..(sc).." scores", 0, 220, 0)
end)


addEventHandler ( "onVehicleStartEnter", root,function ( thePlayer, seat, jacked )
	if ( seat == 0 ) then
		if ( getPlayerTeam(thePlayer) ) and (getElementData(thePlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(thePlayer)) == "Civilian Workers") then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You are not allowed to enter this vehicle!", 0, 200, 0 )
			cancelEvent()
			return
		end
	end
end)


