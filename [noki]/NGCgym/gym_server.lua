local sty = {}

-- Set the style and take the money also upload to MySQL the style what player want
function setFightStyle(style)
	local cost = 1000
	local money = getPlayerMoney( source )

	if ( money < cost ) then
		exports.NGCdxmsg:createNewDxMessage( source, "You don't have enough money for a new fighting style", 200, 0, 0 )
	else
		local takemoney = takePlayerMoney( source, cost )
		setPedFightingStyle( source, style )
		playerID = exports.server:getPlayerAccountID( source )
		setMysql = exports.DENmysql:exec( "UPDATE `accounts` SET `fightstyle`=? WHERE `id`=?", style, playerID )
		exports.NGCdxmsg:createNewDxMessage( source, "New fighting style "..style.." is set and ready to use! Price: $1000", 0, 200, 0 )
	end
end
addEvent ("buyFightingStyle", true)
addEventHandler ("buyFightingStyle", root, setFightStyle)

addEvent("NGCwalk.buy",true)
addEventHandler("NGCwalk.buy",root,function(id)
	local curr = exports.DENstats:getPlayerAccountData(source,"walkstyle")
	if curr == false or curr == nil then curr = 0 end
	if curr == id then
		exports.NGCdxmsg:createNewDxMessage( source, "You already have this walking style!", 255, 255, 0 )
	else
		exports.DENstats:setPlayerAccountData( source, "walkstyle", id )
		sty[ source ]=id
		send( source )
		triggerClientEvent( source,"NGCwalk.bought", source, id )
		takePlayerMoney( source, 500 )
	end
end)

addEventHandler( "onServerPlayerLogin", root,
	function ()
		local curr = exports.DENstats:getPlayerAccountData( source, "walkstyle" )
		if curr == false or curr == nil then curr = 0 end
		sty[source] = curr
		send( source )
		triggerClientEvent( source, "NGCwalk.recTable", source, sty )
		setTimer( checkForBannedID, 2000, 1, source )
	end
)

setTimer(
	function ()
		for k,v in pairs( getElementsByType( "player" ) ) do
			if exports.server:isPlayerLoggedIn(v) then
				sty[v] = exports.DENstats:getPlayerAccountData( v, "walkstyle" )
				send(v)
			end
		end
	end, 5000, 1
)

setTimer(
	function ()
		for k, v in pairs( getElementsByType( "player" ) ) do
			if ( exports.server:isPlayerLoggedIn( v ) ) then
				style = exports.DENstats:getPlayerAccountData( v, "walkstyle" )
				if ( getPedWalkingStyle( v ) ~= style ) then
					send( style )
				end
			end
		end
	end, 10000, 1
)

function send( v )
	local id = 0
	if ( sty[ v ] ) then
		id = sty[ v ]
	else
		sty[ v ] = 0
	end

	for k,p in pairs( getElementsByType( "player" ) ) do
		triggerClientEvent( p,"NGCwalk.rec", p, e, id )
	end
end

function checkForBannedID(player)
	if ( isElement( player ) ) then
		if (exports.server:isPlayerLoggedIn( player ) ) then
			local id = exports.DENstats:getPlayerAccountData( player, "walkstyle" )
			if ( id == 138 ) or ( id == 70 ) then
				exports.DENstats:setPlayerAccountData( player, "walkstyle", 0 )
				triggerClientEvent( player, "NGCwalk.rec", player, player, 0 )
			end
		end
	end
end

addEvent( "takeMoneystat", true )
addEventHandler( "takeMoneystat", root,
	function ()
		if getPlayerMoney( source ) >= 2000 then
			takePlayerMoney( source, 2000 )
		else
			exports.NGCdxmsg:createNewDxMessage( source, "You don't have enough money", 255, 0, 0 )
		end
	end
)

addEvent( "setstat", true )
addEventHandler("setstat", root,
	function ()
		local stat = getPedStat( source, 23 )
		setPedStat( source, 23, stat + 100 )
		local newstat = getPedStat( source, 23 )
		exports.DENstats:setPlayerAccountData( source, "cjm", newstat )
		exports.NGCdxmsg:createNewDxMessage( source,"Your muscle increased ( "..(newstat/10).." % )", 0, 255, 0 )
	end
)

addEvent( "resetstat", true )
addEventHandler( "resetstat", root,
	function ()
		if getPlayerMoney( source ) >= 500 then
			setPedStat( source, 23, 0 )
			takePlayerMoney( source, 500 )
			exports.DENstats:setPlayerAccountData( source, "cjm", 0 )
			exports.NGCdxmsg:createNewDxMessage( source, "Your muscle has been reset", 0, 255, 0 )
		else
			exports.NGCdxmsg:createNewDxMessage( source, "You don't have enough money", 255, 0, 0 )
		end
	end
)

addEvent( "onServerPlayerLogin", true )
addEventHandler( "onServerPlayerLogin", root,
	function ()
		local m = exports.DENstats:getPlayerAccountData( source,"cjm" )
		if m == false or m == nil then m = 0 end
		if m then
			setPedStat( source, 23, m )
		end
	end
)


addEventHandler( "onElementModelChange", root,
	function ( _, newModel )
		if getElementType( source ) == "player" then
			if newModel == 0 then
			local muscles = exports.DENstats:getPlayerAccountData( source, "cjm" )
			if muscles then
					setPedStat( source, 23, muscles )
				end
			end
		end
	end
)

addEventHandler( "onResourceStart", resourceRoot,
	function ()
		for k, v in pairs( getElementsByType( "player" ) ) do
			local walkstyleID = exports.DENstats:getPlayerAccountData( v, "walkstyle" )
			if walkstyleID == false or walkstyleID == 0 or walkstyleID == nil then
				walkstyleID = 0
			end
			if walkstyleID == 0 then
				exports.DENstats:setPlayerAccountData( source, "walkstyle", 0 )
			end
			setPedWalkingStyle( v, walkstyleID )
		end
	end
)

addEventHandler("onServerPlayerLogin",root,function()
	local curr = exports.DENstats:getPlayerAccountData( source, "walkstyle" )
	if curr == false or curr == nil or curr == 0 then curr = 0 end
	if curr == 0 then
		exports.DENstats:setPlayerAccountData( source, "walkstyle", 0 )
	end
	setPedWalkingStyle( source, curr )
end)
