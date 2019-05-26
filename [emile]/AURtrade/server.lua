Trade = {
	items = { },
	functions  = { },
	spamTimers = { }
}


quitDetect = {}


local holy = {
	-- ID,Name
	{16,"Grenade","Weapons","16"},
	{17,"Teargas","Weapons","17"},
	{22,"Colt 45","Weapons","22"},
	{23,"Silenced","Weapons","23"},
	{24,"Deagle","Weapons","24"},
	{25,"Shotgun","Weapons","25"},
	{26,"Sawned-off","Weapons","26"},
	{27,"Combat Shotgun","Weapons","27"},
	{28,"Uzi","Weapons","28"},
	{29,"MP5","Weapons","29"},
	{30,"AK-47","Weapons","30"},
	{31,"M4","Weapons","31"},
	{32,"Tec-9","Weapons","32"},
	{33,"Rifle","Weapons","33"},
	{34,"Sniper","Weapons","34"},
	{35,"Rocket Launcher","Weapons","35"},
	{38,"Minigun","Weapons","38"},
	{39,"Satchel","Weapons","39"},
}


local danger = {
	-- ID,Name
	{1,"Ritalin"},

	{2,"LSD"},

	{3,"Cocaine"},

	{4,"Ecstasy"},

	{5,"Heroine"},

	{6,"Weed"},

}

local craftable = {
	{55, "Stone"},
	{56, "Iron"},
	{56, "Diamond"},
	{56, "Explosive Powder"},
	{57, "Phosphorus"},
	{58, "Weed Seed"},
	{59, "Iodine"},
	{60, "Pot"},
}


function createTable()
	--[[exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS  Trade  ( `seller` VARCHAR(225) NOT NULL , `item` VARCHAR(225) NOT NULL , `amountperone` VARCHAR(225) NOT NULL , `quantity` VARCHAR(225) NOT NULL , `this_id` INT(225) NOT NULL AUTO_INCREMENT , PRIMARY KEY (`this_id`))")
	local q = executeSQLQuery( "SELECT * FROM Trade" );
	if ( q and type ( q ) == "table" ) then
		for i, v in pairs ( q ) do
			local d = { }
			for k, e in pairs ( v ) do
				d[k] = e
			end
			outputDebugString(v.seller)
			exports.DENmysql:exec("INSERT INTO Trade SET seller=?,item=?,amountperone=?,quantity=?",v.seller,v.item,v.amountperone,v.quantity)
		end
	end]]
	local data = exports.DENmysql:query("SELECT * FROM Trade")
	for k,v in ipairs(data) do
		Trade.items[ v.this_id ] = v
	--	outputDebugString(v.this_id)
	end
	for k,v in ipairs(getElementsByType("player")) do
		bindKey(v,"F10","down",openPanel)
	end
end
local waitamin = {}
addEventHandler("onServerPlayerLogin",root,function()
	waitamin[source] = setTimer(function(p)

	end,60000,1,source)
	exports.NGCdxmsg:createNewDxMessage(source,"Press F10 to open Trade panel",255,150,0)
	bindKey(source,"F10","down",openPanel)
end)

hhh={}

addEvent("addCloseTimer",true)
addEventHandler("addCloseTimer",root,function(state)
	exports.NGCdxmsg:createNewDxMessage(source,"Your weapons disabled wait 10 seconds",255,0,0)
	if isTimer(hhh[source]) then killTimer(hhh[source]) end
	hhh[source] = setTimer(function(p)
		if p and isElement(p) then
			setElementData(p,"fire",false)
			toggleControl(p,"fire",true)
			exports.NGCdxmsg:createNewDxMessage(p,"Your weapons enabled",255,255,0)
		end
	end,10000,1,source)
end)

function hasWeaponTimer(player)
	if waitamin[player] and isTimer(waitamin[player]) then
		return true
	else
		return false
	end
end

function openPanel(player)
	--if getElementData(player,"isPlayerPrime") then
	--if getTeamName(getPlayerTeam(player)) == "Tester" then
		if exports.server:getPlayerAccountID(player) then
			if waitamin[player] and isTimer(waitamin[player]) then
				exports.NGCdxmsg:createNewDxMessage(player,"Please wait 1 minute before you can open trade panel (Just logged in)",255,0,0)
				return false
			end
			if hhh[player] and isTimer(hhh[player]) then
				exports.NGCdxmsg:createNewDxMessage(player,"You have to wait for weapons timer",255,0,0)
				return false
			end
			local can,msg = exports.NGCmanagement:isPlayerLagging(player)
			if can then
			--	hhh[player] = setTimer(function() end,60000,1)
				setElementData(player,"fire",true)
				toggleControl(player,"fire",false)
				triggerClientEvent(player,"onClientOpenTrade",player)
				setPedWeaponSlot(player,0)
			else
				if not msg then msg = "Lagger cant open panel" end
				exports.NGCdxmsg:createNewDxMessage(player,"[Trade System] : "..msg,255,0,0)
			end
		--else
		--	outputChatBox("You need to be in tester team (Resource under development)",player,255,0,0)
		end
	--end
end

createTable()
addEvent("onPlayerTradePanel",true)
addEventHandler("onPlayerTradePanel",root,function()
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		triggerClientEvent(source,"onServerPlayerTrade",source)
	else
		if not msg then msg = "Lagger cant open panel" end
		exports.NGCdxmsg:createNewDxMessage(source,"[Trade System] : "..msg,255,0,0)
	end
end)

addEventHandler("onPlayerCommand",root,function()
	triggerClientEvent(source,"loopPlayerItems",source)
end)

function addItem ( seller, item, amount, quan )
	--local id = 0
	--while ( Trade.items [ id ] ) do
	----	id = id + 1
	--end

	--[[executeSQLQuery( "INSERT INTO Trade ( seller, item, amountperone, quantity, this_id ) VALUES ( ?, ?, ?, ?, ? )",
		tostring ( seller ), tostring ( item ), tostring ( amount ), tostring ( quan ), tostring ( id ) );]]
	exports.DENmysql:exec("INSERT INTO Trade SET seller=?,item=?,amountperone=?,quantity=?",seller,item,amount,quan)
	local data = {
		seller = seller,
		item = item,
		amountperone = amount,
		quantity = quan,
		--this_id = id
	}

	local data = exports.DENmysql:query("SELECT * FROM Trade")
	for k,v in ipairs(data) do
		Trade.items[ v.this_id ] = v
	--	outputDebugString(v.this_id)
	end
	--outputDebugString(#Trade.items)
	--Trade.items[ #Trade.items+1 ] = data
	return true
end
addEvent ( "TradinggetShopList", true )
addEventHandler ( "TradinggetShopList", root, function ( )
	local items = Trade.items

	for i, v in pairs ( items ) do
		if ( v.quantity == 0 ) then
			table.remove ( Trade.items, i )
--			executeSQLQuery( "DELETE FROM Trade WHERE this_id=?", i )
			exports.DENmysql:exec("DELETE FROM Trade WHERE this_id=?",i)
		end
	end
	--[[if ( type ( items ) == "table" and table.len ( items ) > 0 ) then
		for i, v in pairs ( items ) do
			if v.quantity > 0 then
				if v.seller == "youssefkh19" then
					outputDebugString(v.item.." With "..v.seller)
				end
			end
		end
	end
	local q = executeSQLQuery( "SELECT * FROM Trade")
	if ( q and type ( q ) == "table" ) then
		hol = q
	else
		hol = {}
	end
	]]
	--for i, v in pairs ( hol ) do
	--	Trade.items[i] = v
	--end
	triggerClientEvent ( source, "TradingonClientReciveList", source, items )
end )
local timers = {}
addEvent ( "TradingonClientAttemptBuyItem", true )
addEventHandler ( "TradingonClientAttemptBuyItem", root, function ( id, amnt )
	if isTimer(timers[source]) then exports.NGCdxmsg:createNewDxMessage(source,"Please wait few seconds before you buy again from Trade system!!",255,0,0) return false end
	local can,ms = exports.NGCmanagement:isPlayerLagging(source)
	if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
	timers[source] = setTimer(function() end,3000,1)
	local d = Trade.items [ id ]
	if ( tonumber(d.quantity) < tonumber(amnt) ) then
		return false
	end
	local totalPrice = d.amountperone * amnt
	if ( getPlayerMoney ( source ) < tonumber(totalPrice) ) then
		return exports.NGCdxmsg:createNewDxMessage( "You need $"..totalPrice.." to buy "..amnt.." of this item. You cannot afford it.", source, 255, 255, 0 )
	end
	if quitDetect[source] == true then
		return false
	end
	local itms = getElementData ( source, "TradeItems" )
	if ( not itms ) then
		itms = { }
	end

	for k,v in ipairs(holy) do
		if d.item == v[2] then
				if getPedWeapon(source,7) == 35 and tonumber(getWeaponIDFromName(d.item)) == 35 then
					if getPedTotalAmmo (source, 7)+tonumber(amnt) > 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
					if getPedTotalAmmo (source, 7) >= 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
					if tonumber(amnt) >= 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
				elseif getPedWeapon(source,7) ~= 35 and tonumber(getWeaponIDFromName(d.item)) == 35 then
					if tonumber(amnt) >= 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
				end
				if getPedWeapon(source,7) == 36 and tonumber(getWeaponIDFromName(d.item)) == 36 then
					if getPedTotalAmmo (source, 7)+tonumber(amnt) > 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
					if getPedTotalAmmo (source, 7) >= 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
					if tonumber(amnt) > 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
				elseif getPedWeapon(source,7) ~= 36 and tonumber(getWeaponIDFromName(d.item)) == 36 then
					if tonumber(amnt) > 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
				end
				local weaponSlot = getSlotFromWeapon(getWeaponIDFromName(d.item))
				if getPedWeapon(source,weaponSlot) == tonumber(getWeaponIDFromName(d.item)) and tonumber(getWeaponIDFromName(d.item)) ~= 36 and tonumber(getWeaponIDFromName(d.item)) ~= 35 then
					local am = getPedTotalAmmo (source, weaponSlot)
					local total = tonumber(am) + tonumber(amnt)
					if total >= 9000 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 9000 ammo's of "..getWeaponNameFromID(getWeaponIDFromName(d.item)),255,0,0)
						return false
					end
					if getPedTotalAmmo (source, weaponSlot) >= 9000 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 9000 ammo's of "..getWeaponNameFromID(getWeaponIDFromName(d.item)),255,0,0)
						return false
					end
				elseif getPedWeapon(source,weaponSlot) ~= tonumber(getWeaponIDFromName(d.item)) and tonumber(getWeaponIDFromName(d.item)) ~= 36 and tonumber(getWeaponIDFromName(d.item)) ~= 35 then
					if tonumber(amnt) >= 9000 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 9000 ammo's of "..getWeaponNameFromID(getWeaponIDFromName(d.item)),255,0,0)
						return false
					end
				end
			--[[local weaponSlot = getSlotFromWeapon (getWeaponIDFromName(d.item))
			local playerAmmo = getPedTotalAmmo(source,weaponSlot)
			local total = tonumber(amnt) + playerAmmo
			if d.item == "Rocket Launcher" then
				if exports.server:getPlayerAccountName(source) ~= d.seller then
					if tonumber(total) and tonumber(total) > 100 then
						exports.NGCnote:addNote("House ammo","You can't have more than 100 RPG ammo",source,255,0,0,5000)
						return false
					end
				end
			end]]
			if tonumber(total) and tonumber(total) > 9000 then
				exports.NGCnote:addNote("House ammo","You can't have more than 9000 ammo",source,255,0,0,5000)
				return false
			end
		end
	end
	if ( not itms[d.item] ) then
		itms[d.item] = 0
	end
	for k,v in ipairs(holy) do
		if v[2] == d.item then
			local playerID = exports.server:getPlayerAccountID( source )
			local wepCheck = exports.DENmysql:querySingle( "SELECT * FROM weapons WHERE userid=?",tonumber(playerID))
			if wepCheck then
				local weps = v[4]
				local wpe = tostring(weps)
				if tonumber(wepCheck[wpe]) == 0 then
					--triggerClientEvent( source, "warn2", source )
					exports.NGCdxmsg:createNewDxMessage(source,"You can't buy ammo without weapon!!, go to ammunation and buy the weapon first!",255,0,0)
					return false
				end
			else
				local createWeaponTable = exports.DENmysql:exec("INSERT INTO weapons SET userid=?",tonumber(playerID))
				outputChatBox("There was something wrong, try again or when this error keeps comming warn a staff member!", source, 225, 0, 0)
				return false
			end
		end
	end
	if addItemToPlayer(source,d.item,amnt) then

		itms[d.item] = itms[d.item] + amnt
		setElementData ( source, "TradeItems", itms )
		Trade.items [ id ].quantity = d.quantity - amnt
		local d = Trade.items [ id ]
		exports.AURpayments:takeMoney( source, totalPrice,"AUR Trade "..getPlayerName(source).." bought "..amnt.." "..d.item.."s for $"..totalPrice.." from "..d.seller.."!" )
		exports.NGCdxmsg:createNewDxMessage( "You bought "..amnt.." "..d.item.."s for $"..totalPrice.." from "..d.seller.."!", source, 0, 255, 0 )
		if ( d.quantity == 0 ) then
			--executeSQLQuery( "DELETE FROM Trade WHERE this_id=?", id );
			exports.DENmysql:exec("DELETE FROM Trade WHERE this_id=?",id)
			table.remove ( Trade.items, id )
		else
			--executeSQLQuery( "UPDATE Trade SET quantity=? WHERE this_id=?", d.quantity, id );
			exports.DENmysql:exec("UPDATE Trade SET quantity=? WHERE this_id=?", d.quantity, id )
			Trade.items[id].quantity = d.quantity
		end

		--[[if ( d.seller:lower ( ) ~= "prime" ) then
			local givenMoney = false
			for i, v in pairs ( getElementsByType ( "player" ) ) do
				local a = exports.server:getPlayerAccountName ( v )
				if a == d.seller then
					givePlayerMoney ( v, totalPrice )
					exports.NGCdxmsg:createNewDxMessage( getPlayerName ( source ).." has bought "..amnt.." "..d.item.."s for $"..totalPrice, v, 0, 255, 0 )
					addTradeLog(getPlayerName(source).." has bought "..amnt.." amount "..d.item.." item for "..totalPrice)
					givenMoney = true
					break
				end
			end
			if ( not givenMoney ) then
				local q = exports.DENmysql:exec( "SELECT * FROM accounts WHERE username=?",d.seller)
				if q then
					local am = tonumber(q.money) + tonumber(totalPrice)
					if am then
						exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE username=?",am,d.seller)
						addTradeLog(d.seller.." have got offline cash "..totalPrice)
					end
				end
			end
		end]]
		for i, v in pairs ( getElementsByType ( "player" ) ) do
			local a = exports.server:getPlayerAccountName ( v )
			if a == d.seller then
				exports.NGCdxmsg:createNewDxMessage( getPlayerName ( source ).." has bought "..amnt.." "..d.item.."s for $"..totalPrice, v, 0, 255, 0 )
				exports.NGCdxmsg:createNewDxMessage( getPlayerName ( source ).." has sent the money via ATM", v, 0, 255, 0 )
			end
		end
		local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username = ?", string.lower(d.seller) )
		if ( userData ) then
			addTradeLog(exports.server:getPlayerAccountName(source).." ** "..getPlayerName(source).." has bought "..amnt.." amount "..d.item.." item for "..totalPrice)
			bankTransfer(userData.id,totalPrice,""..d.item.." Amount "..amnt)
		end
	end
end )


function bankTransfer(id,price,name)
	local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", id )
	if not balanceCheck then
		exports.DENmysql:exec("INSERT INTO banking SET userid=?, balance=?", id,price)
		exports.DENmysql:exec( "INSERT INTO banking_transactions SET userid = ?, transaction = ?", id, "Trade System: Has sent to you $"..price.." for selling your "..name..".")
	else
		local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", id )
		local totalNewBalance = (balanceCheck.balance + price)
		exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", totalNewBalance, id)
		exports.DENmysql:exec( "INSERT INTO banking_transactions SET userid = ?, transaction = ?", id, "Trade System: Has sent to you $"..price.." for selling your "..name..".")
	end
end



function removeItem ( id )
	if ( not Trade.items[ id ] ) then
		return false
	end
	table.remove ( Trade.items, id )
	--executeSQLQuery( "DELETE FROM Trade WHERE this_id=?", id )
	exports.DENmysql:exec("DELETE FROM Trade WHERE this_id=?", d.quantity, id )
end

function getUserItems ( account )
	if account then
		--local q = executeSQLQuery( "SELECT * FROM Trade WHERE seller=?", account )
	--[[	if ( not q or type ( q ) ~= "table" ) then
			q = { }
		end
		if q == false then q = {} end
		return q]]
		local data = exports.DENmysql:query("SELECT * FROM Trade WHERE seller=?",account)
		if data then
			return data
		else
			return {}
		end
	end
end
--[[

for k,v in ipairs(danger) do
			if v[2] == item then
				if removeItemFromPlayer(source,item,quantity) == false then
					return false
				end
			end
		end
		for k,v in ipairs(holy) do
			if v[3] == "Weapons" then
				if v[2] == item then

				]]
function canISell(p,t)
	local a = exports.server:getPlayerAccountName(p)
	local items = getUserItems(a)
	for k2,v2 in pairs(items) do
		if v2.item == t then
			exports.NGCdxmsg:createNewDxMessage(p,"You can't sell "..t.." because you already are trying to sell it!",255,0,0)
			return false
		end
	end
	return true
end


addEvent ( "TradinggetProfileItems", true )
addEventHandler ( "TradinggetProfileItems", root, function ( )
	local a = exports.server:getPlayerAccountName(source)
	local items = getUserItems(a)
	triggerClientEvent ( source, "TradingsendClientItems", source, items )
end )


local misusing = {}

function checkMine(gg)
	local weaponsT={}
	for slot = 0, 12 do
		local weapon = getPedWeapon( gg, slot )
		if ( weapon > 0 ) then
			local ammo = getPedTotalAmmo( gg, slot )
			if ( ammo > 0 ) then
				weaponsT[weapon] = ammo
			end
		end
	end
	local str=toJSON(weaponsT)
	return str
end

addEvent ( "TradingaddItemToShop", true )
addEventHandler ( "TradingaddItemToShop", root, function ( item, quantity, price,strin )
	-- ( seller, item, amount, quan )
	if canISell(source,item) then
		local acc = exports.server:getPlayerAccountName(source)
		if ( isTimer ( Trade.spamTimers [ acc ] ) ) then
			exports.NGCdxmsg:createNewDxMessage( "You can only do this process in trade shop once every 5 minutes ("..calculateEngTime ( getTimerDetails ( Trade.spamTimers [ acc ] ) ).." remaining)", source, 255, 0, 0 )
			return false
		end
		if quitDetect[source] == true then
			return false
		end
		--Trade.spamTimers[ acc ] = setTimer ( function() end, 300000, 1 )
		local added = false
		local can,ms = exports.NGCmanagement:isPlayerLagging(source)
		if not can then exports.NGCdxmsg:createNewDxMessage(source,"You can't do this at the moment due lag detected!",255,0,0) return false end
		triggerClientEvent(source,"loopPlayerItems",source)
		if item == "Medickits" then
			if removeItemFromPlayer(source,item,quantity,strin) == false then
				return false
			end
		end
		--if item == "VIP" then
		--	removeItemFromPlayer(source,item,quantity)
		--end
		for k,v in ipairs(craftable) do
			if v[2] == item then
				if removeItemFromPlayer(source,item,quantity,strin) == false then
					return false
				end
			end
		end
		for k,v in ipairs(danger) do
			if v[2] == item then
				if removeItemFromPlayer(source,item,quantity,strin) == false then
					return false
				end
			end
		end
		for k,v in ipairs(holy) do
			if v[3] == "Weapons" then
				if v[2] == item then
					local str = checkMine(source)
					if str ~= strin then
						return false
					end
					if removeItemFromPlayer(source,item,quantity,strin) == false then
						return false
					end
				end
			end
		end
		if misusing[source] == true then return false end
		addItem ( acc, item, price, quantity )
		local data = getElementData ( source, "TradeItems" )
		data[item] = data[item] - quantity
		setElementData ( source, "TradeItems", data )
		--triggerEvent("TradinggetProfileItems",source)
		addTradeLog(exports.server:getPlayerAccountName(source).." * "..getPlayerName(source).." have added "..item.." as amount ("..quantity.." for price "..price)
		exports.NGCdxmsg:createNewDxMessage( "You added "..quantity.." "..item.." to the trade shop, with it being $"..tostring(price).." per item", source, 0, 255, 0 )
		Trade.spamTimers[ acc ] = setTimer ( function() end, 300000, 1 )
	end
end )


function calculateEngTime ( milSec )
	local sec = math.floor ( milSec / 1000 )
	local min = 0
	local hour = 0

	while ( sec > 60 ) do
		sec = sec - 60
		min = min + 1
	end

	while ( min > 60 ) do
		min = min - 60
		hour = hour + 1
	end

	if ( sec > 0 and min == 0 and hour == 0 ) then
		return sec.." seconds"
	elseif ( min > 0 and hour == 0 ) then
		return min.." minutes"
	elseif ( hour > 0 ) then
		return hour.." hours"
	end
end

function addItemToPlayer(player,item,amount)
	local amount = tonumber(amount)
	if quitDetect[player] == true then
		return false
	end
	if item == "Medickits" then
		local kits = exports.DENstats:getPlayerAccountData( player, "mk" ) or 0
		--outputDebugString(kits.." bought ")
		exports.DENstats:setPlayerAccountData( player, "mk",kits+amount)
		local x = exports.DENstats:getPlayerAccountData( player,"mk" ) or 0
		triggerClientEvent( player, "recMK", player, math.floor(x) )
		triggerClientEvent( player, "recMK2", player, math.floor(x) )
		triggerClientEvent( player,"rev",player,math.floor(x))
		return true
		---outputDebugString("Added amount and kits")
	end
	--if	item == "VIP" then
	--	givePlayerVIP(player,amount*60)
	--end
	for k,v in ipairs(craftable) do
		if v[2] == item then
			exports.AURcrafting:addPlayerItem(player, item, amount)
			return true
		end
	end
	for k,v in ipairs(danger) do
		if v[2] == item then
			exports.CSGdrugs:giveDrug(player,item,amount)
			return true
		end
	end
	for k,v in ipairs(holy) do
		if v[2] == item then
			giveWeapon(player,getWeaponIDFromName(item),amount,true)
			exports.CSGaccounts:forceWeaponSync(player)
			return true
		end
	end
	return false
end

local mismatchBreak = {}
addEvent("mismatchBreak",true)
addEventHandler("mismatchBreak",root,function()
	mismatchBreak[source] = true
end)
addEvent("removeMismatch",true)
addEventHandler("removeMismatch",root,function()
	mismatchBreak[source] = false
end)

function removeItemFromPlayer(player,item,amount,inf)
	local amount = tonumber(amount)
	if mismatchBreak[player] then return false end
	local loss = getNetworkStats(player)["packetlossLastSecond"]
	if (loss > 10) then
		exports.NGCdxmsg:createNewDxMessage(player,"Selling in trade has been aborted due Network loss",255,0,0)
		misusing[player] = true
		return false
	end
	local str = checkMine(player)
	if str ~= inf then
		return false
	end
	if item == "Medickits" then
		local kits = exports.DENstats:getPlayerAccountData( player, "mk" ) or 0
		if exports.DENstats:setPlayerAccountData( player,"mk", exports.DENstats:getPlayerAccountData( player, "mk" ) - amount ) then
			local x = exports.DENstats:getPlayerAccountData( player,"mk" ) or 0
			triggerClientEvent( player, "recMK", player, math.floor(x) )
			triggerClientEvent( player, "recMK2", player, math.floor(x) )
			triggerClientEvent(player,"rev",player,math.floor(x))
			return true
		else
			exports.NGCdxmsg:createNewDxMessage(player,"Try to sell medic kits again (Couldnt find your medkits)",255,0,0)
			misusing[player] = true
			return false
		end
	end
	--if item == "VIP" then
	--	setPlayerVIP(player,amount)
	--end
	for k,v in ipairs(craftable) do
		if v[2] == item then
			if (exports.AURcrafting:isPlayerHasItem(player, item) == true) then
				if (exports.AURcrafting:getPlayerItemQuantity(player, item) >= amount) then 
					exports.AURcrafting:removePlayerItem(player, item, amount)
					return true
				else				
					exports.NGCdxmsg:createNewDxMessage(player,"Selling in trade has been aborted no craftable items found",255,0,0)
					misusing[player] = true
					return false
				end
			else
				exports.NGCdxmsg:createNewDxMessage(player,"Selling in trade has been aborted no craftable items found",255,0,0)
				misusing[player] = true
				return false
			end
		end
	end
	for k,v in ipairs(danger) do
		if v[2] == item then
			if exports.CSGdrugs:takeDrug(player,item,amount) then
				return true
			else
				exports.NGCdxmsg:createNewDxMessage(player,"Selling in trade has been aborted no drugs found",255,0,0)
				misusing[player] = true
				return false
			end
		end
	end
	for k,v in ipairs(holy) do
		if v[2] == item then
			if mismatchBreak[player] then return false end
			local weaponSlot = getSlotFromWeapon(getWeaponIDFromName(item))
			if getPedWeapon(player,weaponSlot) == tonumber(getWeaponIDFromName(item)) then
				local am = getPedTotalAmmo (player, weaponSlot)
				if am < amount then
					outputDebugString("Fail on load because ammo isnt same value")
					exports.NGCdxmsg:createNewDxMessage(player,"Selling in trade has been aborted due Ammo isn't matched",255,0,0)
					misusing[player] = true
					return false
				end
			end
			if mismatchBreak[player] then return false end
			local am = getPedTotalAmmo (player, weaponSlot)
			if am < amount then
				exports.NGCdxmsg:createNewDxMessage(player,"Selling in trade has been aborted due Ammo isn't matched",255,0,0)
				outputDebugString("Fail on load because totall ammo indead")
				misusing[player] = true
				return false
			end
			if mismatchBreak[player] then return false end
			if takeWeapon(player,getWeaponIDFromName(item),amount) then
				exports.CSGaccounts:forceWeaponSync(player)
				return true
			else
				if takeWeapon(player,getWeaponIDFromName(item),tonumber(amount)-1) then
					return true
				else
					misusing[player] = true
					exports.NGCdxmsg:createNewDxMessage(player,"Selling in trade has been aborted due Ammo isn't matched",255,0,0)
					return false
				end
			end
		end
	end
	triggerClientEvent(player,"loopPlayerItems",player)
	return false
end


function givePlayerVIP(player,amount)
	if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT VIP FROM accounts WHERE id=?",id)
		local newValue = data["VIP"] + amount
		if (exports.DENmysql:exec("UPDATE accounts SET VIP=?, VIPType=? WHERE id=?",newValue,4,id)) then
			outputDebugString("[Trade VIP] "..getPlayerName(player).." has been given "..amount.." of VIP minutes.",0,0,255,0)
			setElementData(player,"isPlayerVIP",true)
			setElementData(player,"VIP","Yes")
			return true
		else
			outputDebugString("[Trade VIP] failed to give "..getPlayerName(player).." "..amount.." of VIP minutes!",0,255,0,0)
			return false
		end
	else
		return false
	end
end

function setPlayerVIP(player,amount)
	if (isElement(player)) and (exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		local data = exports.DENmysql:querySingle("SELECT VIP FROM accounts WHERE id=?",id)
		local newValue = data["VIP"] - (amount * 60)
		local newValue2 = math.floor(data["VIP"] / 60) - amount
		if newValue2 > 0 then
			if (exports.DENmysql:exec("UPDATE accounts SET VIP=?, VIPType=? WHERE id=?",newValue,4,id)) then
				outputDebugString("[Trade VIP] "..getPlayerName(player).." has been setted "..amount.." of VIP minutes.",0,0,255,0)
				setElementData(player,"isPlayerVIP",true)
				setElementData(player,"VIP","Yes")
				return true
			else
				outputDebugString("[Trade VIP] failed to give "..getPlayerName(player).." "..amount.." of VIP minutes!",0,255,0,0)
				return false
			end
		else
			removePlayerVIP(player)
			setElementData(player,"isPlayerVIP",false)
			setElementData(player,"VIP","No")
		end
	else
		return false
	end
end




function removePlayerVIP(player)
	if (isElement(player) and exports.server:isPlayerLoggedIn(player)) then
		local id = exports.server:getPlayerAccountID(player)
		if (exports.DENmysql:exec("UPDATE accounts SET VIP=? WHERE id=?",0,id)) then
			setElementData(player,"isPlayerVIP",false)
			setElementData(player,"VIP","No")
			return true
		else
			return false
		end
	else
		return false
	end
end

addEvent("loopMyItems",true)
addEventHandler("loopMyItems",root,function(Drugs,DrugsN)
	--- Tables
	local t = {}
	local items = {}
	--- Data check
	local inv = nil
	--local inv = getElementData ( source, "TradeItems" ) or { }
	if not inv then inv = { } setElementData ( source, "TradeItems", { } ) end
	--- Medickits
	local count = exports.DENstats:getPlayerAccountData( source, "mk" ) or 0
	--outputDebugString("Loop result:"..count)
	items["Medickits"] = count or 0
	--- Weapons
	for slot = 0, 12 do
		local weapon = getPedWeapon( source, slot )
		if ( weapon > 0 ) then
			if ( weapon <= 39 and weapon >= 16 and weapon ~= 18 or weapon ~= 19 or weapon ~= 20 or weapon ~= 40 or weapon ~= 21 or weapon ~= 36 or weapon ~= 37 ) then
				for k,v in ipairs(holy) do
					if v[3] == "Weapons" then
						if weapon == v[1] then
							local ammo = getPedTotalAmmo( source, slot )
							if ( ammo > 0 ) then
								items[getWeaponNameFromID(weapon)] = ammo
							end
						end
					end
				end
			end
		end
	end
	--[[ VIP
	local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID( source ) )
	if ( userData and userData.VIP > 0 ) then
		local premTime = math.floor( userData.VIP / 60 )
		if premTime > 0 then
			items["VIP"] = premTime
		end
	end]]
	--- Drugs
	for a,b in pairs(Drugs) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (DrugsN[a2]) then
			items[DrugsN[a2]] = tonumber(b)
		end
	end
	
	for i=1, #craftable do
		if (exports.AURcrafting:isPlayerHasItem(source, craftable[i][2]) == true) then 
			local a = tostring(craftable[i][2])
			local a2 = tonumber(exports.AURcrafting:getPlayerItemQuantity(source, craftable[i][2]))
			items[a] = tonumber(a2)
		end
	end
	---- Add
	misusing[source] = false

	setElementData ( source, "TradeItems", items )
	triggerClientEvent(source,"fastloopass",source)
end)


addEvent("setPlayerQuit",true)
addEventHandler("setPlayerQuit",root,function()
	quitDetect[source] = true
	exports.CSGaccounts:forceWeaponSync(source)
end)


addEventHandler("onPlayerCommand",root,function(cmd)
	if cmd == "reconnect" or cmd == "quit" or cmd == "disconnect" or cmd == "exit" or cmd == "connect" then
		quitDetect[source] = true
		exports.CSGaccounts:forceWeaponSync(source)
	end
end)


function getTimeDate()
	local aRealTime = getRealTime ( )
	return
	string.format ( "%04d/%02d/%02d", aRealTime.year + 1900, aRealTime.month + 1, aRealTime.monthday ),
	string.format ( "%02d:%02d:%02d", aRealTime.hour, aRealTime.minute, aRealTime.second )
end

function addTradeLog(message)
	if (not message) then return end
	local date, time = getTimeDate()
	local final = "["..date.. " - "..time.."]"
	if (not fileExists("logs/Trade2.log")) then
		log = fileCreate("logs/Trade2.log")
	else
		log = fileOpen("logs/Trade2.log")
	end
	if (not log) then return end
	if (not fileExists("logs/Trade2.log")) then return end
	if (fileGetSize(log) == 0) then
		fileWrite(log, final.." "..message)
	else
		fileSetPos(log, fileGetSize(log))
		fileWrite(log, "\r\n", "Trade : "..final.." "..message)
	end
	fileClose(log)
end
