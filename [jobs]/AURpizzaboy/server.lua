local anticheat = {}

addEvent ( "AURpizza.pay", true )
addEventHandler( "AURpizza.pay", root,
function ()
	if (isTimer(anticheat[source])) then 
		exports.NGCdxmsg:createNewDxMessage(source,"The system has detected that you've been cheating. Please wait 15 seconds then re-enter to the marker.", 255, 0, 0)
		return false 
	end
	anticheat[source] = setTimer(function() killTimer(anticheat[source]) end, 15000, 1)
	local Pizmoney = math.random(330,550)
	exports.AURpayments:addMoney(source, Pizmoney,"Custom","Pizza Boy",0,"AURpizzajob")
	exports.DENstats:setPlayerAccountData(source,"pizzas",exports.DENstats:getPlayerAccountData(source,"pizzas")+1)
	exports.CSGscore:givePlayerScore(source,0.5)
	exports.NGCdxmsg:createNewDxMessage(source,"You earned $"..Pizmoney..".", 0, 255, 0)
	exports.NGCdxmsg:createNewDxMessage(source,"You earned 0.5 score ", 0, 255, 0)
end	)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	triggerClientEvent(source,"AURpizzalogin",source)
end)