--[[
AuroraRPG - aurorarpg.com
This resource is property of AuroraRPG.
Author: Curt
All Rights Reserved 2017
]]--
function startIntro ()
	if (exports.server:isPlayerLoggedIn(client)) then 
		setTimer(function(thePlr)
			triggerClientEvent(thePlr, "AURdecember.go", resourceRoot)
		end, 5000, 1, client)
	end 
end
addEvent("AURdecember.startIntro", true)
addEventHandler("AURdecember.startIntro", resourceRoot, startIntro)



function givemoni ()
	exports.AURpayments:addMoney(client, 500000,"Custom","Miner",0,"AURjob_miner")
end
addEvent("AURdecember.givemoni", true)
addEventHandler("AURdecember.givemoni", resourceRoot, givemoni)