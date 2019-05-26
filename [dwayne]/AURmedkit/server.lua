addEvent( "takeKitMoney", true )
addEventHandler( "takeKitMoney", root,
	function ( amount,cost )
		local c,m = exports.NGCmanagement:isPlayerLagging(source)
		if c then
			local kitMoney = getPlayerMoney(source)
			local kits = exports.DENstats:getPlayerAccountData( source, "mk" )
			if ( kitMoney >= cost*exports.AURtax:getCurrentTax() ) then
				if ( kits < 0 ) then
					exports.DENstats:setPlayerAccountData( source, "mk", 0 )
					kits = 0
				end
				exports.DENstats:setPlayerAccountData( source, "mk", kits + amount)
				exports.NGCmanagement:RPM( source, cost*exports.AURtax:getCurrentTax() )
				exports.NGCdxmsg:createNewDxMessage( source, "Transaction Alert: "..exports.AURtax:getCurrentTax().."% has taken from your money due to taxes.", 225, 0, 0 )
				exports.NGCdxmsg:createNewDxMessage(source,"You bought "..amount.." medic kits for $"..cost,0,255,0)
				fadeCamera( source, false, 1 )
				setTimer( fadeCamera, 500, 1, source, true, 1 )
				triggerClientEvent( source, "NGCmedkitsbought", source, amount )
				recMedic(source)
			else
				if amount == 1 then
					exports.NGCdxmsg:createNewDxMessage( source, "You don't have $"..cost.." to buy "..amount.." medkits!", 255, 0, 0 )
				else
					exports.NGCdxmsg:createNewDxMessage( source, "You don't have $"..cost.." to buy "..amount.." medkits!", 255, 0, 0 )
				end
				return false
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You can't buy medic kits while you're lagging",255,0,0)
		end
	end
)

addEvent( "onServerPlayerLogin", true )
addEventHandler( "onServerPlayerLogin",root,
	function ()
		theTimer2 = setTimer(function(player)
			recMedic(player)
		end,5000,1,source)
	end
)

addEvent( "usedMK", true )
addEventHandler( "usedMK", root,
	function ()
		exports.DENstats:setPlayerAccountData( source,"mk", exports.DENstats:getPlayerAccountData( source, "mk" ) -1 )
		recMedic(source)
	end
)

function dropMk(player,value)
	exports.DENstats:setPlayerAccountData(player,"mk",exports.DENstats:getPlayerAccountData(player,"mk")-value)
	recMedic(player)
end

function giveMk(player,value)
	exports.DENstats:setPlayerAccountData(player,"mk",exports.DENstats:getPlayerAccountData(player,"mk")+value)
	triggerClientEvent(player,"rev",player,value)
	recMedic(player)
end

function recMedic(player)
	local x = exports.DENstats:getPlayerAccountData( player,"mk" )
	if x then
		triggerClientEvent( player, "recMK", player, math.floor(x) )
		triggerClientEvent( player, "recMK2", player, math.floor(x) )
	else
		triggerClientEvent( player, "recMK", player, 0 )
		triggerClientEvent( player, "recMK2", player, 0 )
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
	theTimer = setTimer(function()
		for k, pro in pairs( getElementsByType( "player" ) ) do
			recMedic(pro)
		end
	end,5000,1)
end)

--[[
setTimer(
	function()
		for k, source in pairs( getElementsByType( "player" ) ) do
			local x = exports.DENstats:getPlayerAccountData( source,"mk" )
			if x then
				triggerClientEvent( source, "recMK", source, math.floor(x) )
			else
				triggerClientEvent( source, "recMK", source, 0 )
			end
			local y = exports.DENstats:getPlayerAccountData( source,"mk" )
			if y then
				triggerClientEvent( source, "recMK2", source, math.floor(y) )
			else
				triggerClientEvent( source, "recMK2", source, 0 )
			end
		end
	end, 15000, 0
)
]]
