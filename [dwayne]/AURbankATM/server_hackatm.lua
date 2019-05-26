--local cooldowns = {}
function continueS (level)
	local serial = getPlayerSerial(client)
	--if (getTickCount() - cooldowns[serial] < 900000) then 
		--exports.NGCdxmsg:createNewDxMessage(client, "The ATM is unavailable right now to hack. Please try again later.",255,0,0)
		--return 
	--end 
	--cooldowns[serial] = getTickCount()
	local money = 20000*level
	exports.NGCdxmsg:createNewDxMessage(client,"You successful robbed the ATM. Here's $"..money,255,0,0)
	givePlayerMoney(client, money)
	exports.AURcriminalp:giveCriminalPoints(client, "BankATMRob", 5)
	exports.server:givePlayerWantedPoints(client, 10*level)
	
end
addEvent( "AURbankatm.continue", true )
addEventHandler( "AURbankatm.continue", resourceRoot, continueS )