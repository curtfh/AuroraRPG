
antiHack = {}
smartTimer = {}
weaponCosts = {}
_giveWeapon = giveWeapon

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	antiHack[source] = true
	if isTimer(smartTimer[source]) then return false end
	smartTimer[source] = setTimer(function(player)
		antiHack[player] = false
	end,60000,1,source)
end)

function giveWeapon(plr, wep, ammo, setCurrent)
	if (getSlotFromWeapon(wep) < 9 and getSlotFromWeapon(wep) > 1) then
		local slotWep = getPedWeapon(plr, getSlotFromWeapon(wep))
		if (slotWep ~= wep and slotWep ~= 0 and getPedTotalAmmo(plr, getSlotFromWeapon(wep)) > 0) then
			local slotAmmo = getPedTotalAmmo(plr, getSlotFromWeapon(wep))
			local cost = weaponCosts[slotWep] / weaponCosts[wep]
			local ammo = ammo + math.floor(slotAmmo * cost)
			if (ammo > 9000) then
				outputChatBox("Cannot have more than 9000 ammo of this weapon.", plr, 255, 0, 0)
				return false, true
			end
			takeWeapon(plr, slotWep)
			return _giveWeapon(plr, wep, ammo, setCurrent)
		end
	end
	return _giveWeapon(plr, wep, ammo, setCurrent)
end

function buyWeapon ( weapon, price )
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local playerID = exports.server:getPlayerAccountID( source )
		local wepCheck = exports.DENmysql:querySingle( "SELECT * FROM weapons WHERE userid=?",tonumber(playerID))
		if ( exports.server:isPlayerVIP( source ) ) then price = tonumber( math.floor( price / 120 * 100 ) ) end
		if wepCheck then
			local money = getPlayerMoney(source)
			if tonumber(wepCheck[weapon]) == 1 then
				triggerClientEvent( source, "warn2", source )
				return
			elseif tonumber(wepCheck[weapon]) == 0 and (money < tonumber(price)) then
				triggerClientEvent( source, "warn4", source )
				return
			else
				setMysql = exports.DENmysql:exec( "UPDATE weapons SET`" .. weapon .. "` = 1 WHERE userid = " .. playerID)
				exports.AURpayments:takeMoney(source,tonumber(price),"AURAmmunation")

				triggerClientEvent( source, "warn3", source )
				return
			end
		else
			local createWeaponTable = exports.DENmysql:exec("INSERT INTO weapons SET userid=?",tonumber(playerID))
			outputChatBox("There was something wrong, try again or when this error keeps comming warn a staff member!", source, 225, 0, 0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end
addEvent( "buyWeaponByID", true )
addEventHandler( "buyWeaponByID", root, buyWeapon )

addEvent("getWeaponBought",true)
addEventHandler("getWeaponBought",root,function(row,id)
	local playerID = exports.server:getPlayerAccountID( source )
	local wepChecks = exports.DENmysql:querySingle( "SELECT * FROM weapons WHERE userid=?",tonumber(playerID))
	if tonumber(wepChecks[id]) == 1 then
		triggerClientEvent(source,"sendWeaponsBought",source,row,1)
	else
		triggerClientEvent(source,"sendWeaponsBought",source,row,0)
	end
end)

addEvent("setPWS",true)
addEventHandler("setPWS",root,function(id)
	setPedWeaponSlot(source,id)
end)

addEvent("loadWeaponsXML",true)
addEventHandler("loadWeaponsXML",root,function(code)
	local table = {}
	local node = xmlLoadFile ( "list.xml" )
	if ( node ) then
		local groups = 0
		while ( xmlFindChild ( node, "group", groups ) ~= false ) do
			local group = xmlFindChild ( node, "group", groups )
			local groupn = xmlNodeGetAttribute ( group, "name" )
			table[groupn] = {}
			local skins = 0
			while ( xmlFindChild ( group, "mod", skins ) ~= false ) do
				local skin = xmlFindChild ( group, "mod", skins )
				local id = #table[groupn] + 1
				table[groupn][id] = {}
				table[groupn][id]["model"] = xmlNodeGetAttribute ( skin, "model" )
				table[groupn][id]["name"] = xmlNodeGetAttribute ( skin, "name" )
				table[groupn][id]["clip"] = xmlNodeGetAttribute ( skin, "clip" )
				table[groupn][id]["clipCost"] = xmlNodeGetAttribute ( skin, "pricePerClip" )*exports.AURtax:getCurrentTax()
				table[groupn][id]["weaponCost"] = xmlNodeGetAttribute ( skin, "weaponCost" )*exports.AURtax:getCurrentTax()
				--outputDebugString(math.abs(xmlNodeGetAttribute ( skin, "weaponCost" )).." - "..(math.abs(xmlNodeGetAttribute ( skin, "weaponCost" ))*math.abs(exports.AURtax:getCurrentTax())))
				table[groupn][id]["imgPath"] = xmlNodeGetAttribute ( skin, "imgPath" )
				weaponCosts[tonumber(table[groupn][id]["model"])] = (table[groupn][id]["clipCost"] / table[groupn][id]["clip"])
				skins = skins + 1
			end
			groups = groups + 1
		end
		xmlUnloadFile ( node )
	end
	triggerClientEvent(source,"returnWeaponsXML",source,table,code)
end)


quitDetect = {}
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

function buyAmmo ( weapon, price, pack )
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		local pack = tonumber(pack)
		local playerID = exports.server:getPlayerAccountID( source )
		local wepChecks = exports.DENmysql:querySingle( "SELECT * FROM weapons WHERE userid=?",tonumber(playerID))
		if ( exports.server:isPlayerVIP( source ) ) then price = tonumber( math.floor( price / 120 * 100 ) ) end
		if wepChecks then
			local money = getPlayerMoney(source)
			if price > money then triggerClientEvent( source, "warn4", source ) return false end
			if tonumber(wepChecks[weapon]) == 0 then
				triggerClientEvent( source, "warn1", source )
				return false
			elseif tonumber(wepChecks[weapon]) == 1 and (money < tonumber(price)) then
				triggerClientEvent( source, "warn4", source )
				return false
			else
				if quitDetect[source] then return false end
				local RPGammo = getPedTotalAmmo (source, 7)
				--[[if tonumber(weapon) == 35 and tonumber(pack) > 100 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
					return false
				elseif getPedWeapon(source,7) == 35 and tonumber(weapon) == 35 and tonumber(RPGammo) > 100 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
					return false
				elseif getPedWeapon(source,7) == 35 and tonumber(weapon) == 35 and tonumber(RPGammo) > 100 and tonumber(pack) > 100 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
					return false
				end
				if getPedWeapon(source,7) == 35 and tonumber(weapon) == 35 then
					if getPedTotalAmmo (source, 7) >= 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
				end
				if getPedWeapon(source,7) == 35 and tonumber(weapon) == 35 and (getPedTotalAmmo (source, 7) + pack) > 100 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
					return false
				end
				if tonumber(weapon) == 36 and tonumber(pack) > 2 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of RPG HS",255,0,0)
					return false
				elseif getPedWeapon(source,7) == 36 and tonumber(weapon) == 36 and tonumber(RPGammo) > 2 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of RPG HS",255,0,0)
					return false
				elseif getPedWeapon(source,7) == 36 and tonumber(weapon) == 36 and tonumber(RPGammo) > 2 and tonumber(pack) > 2 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of RPG HS",255,0,0)
					return false
				end
				if getPedWeapon(source,7) == 36 and tonumber(weapon) == 36 then
					if getPedTotalAmmo (source, 7) >= 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of RPG HS",255,0,0)
						return false
					end
				end
				if getPedWeapon(source,7) == 36 and tonumber(weapon) == 36 and (getPedTotalAmmo (source, 7) + pack) > 2 then
					exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of RPG HS",255,0,0)
					return false
				end]]
					local can,msg = exports.NGCmanagement:isPlayerLagging(source)
					if not can then return false end

				if getPedWeapon(source,7) == 35 and tonumber(weapon) == 35 then
					if getPedTotalAmmo (source, 7)+tonumber(pack) > 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
					if getPedTotalAmmo (source, 7) >= 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
					if tonumber(pack) > 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
				elseif getPedWeapon(source,7) ~= 35 and tonumber(weapon) == 35 then
					if tonumber(pack) > 100 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 100 ammo's of RPG",255,0,0)
						return false
					end
				end
				if getPedWeapon(source,7) == 36 and tonumber(weapon) == 36 then
					if getPedTotalAmmo (source, 7)+tonumber(pack) > 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
					if getPedTotalAmmo (source, 7) >= 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
					if tonumber(pack) > 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
				elseif getPedWeapon(source,7) ~= 36 and tonumber(weapon) == 36 then
					if tonumber(pack) > 2 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 2 ammo's of Javelin",255,0,0)
						return false
					end
				end
				local weaponSlot = getSlotFromWeapon(weapon)
				if getPedWeapon(source,weaponSlot) == tonumber(weapon) and tonumber(weapon) ~= 36 and tonumber(weapon) ~= 35 then
					local am = getPedTotalAmmo (source, weaponSlot)
					local total = tonumber(am) + tonumber(pack)
					if total >= 9000 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 9000 ammo's of "..getWeaponNameFromID(weapon),255,0,0)
						return false
					end
					if getPedTotalAmmo (source, weaponSlot) >= 9000 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 9000 ammo's of "..getWeaponNameFromID(weapon),255,0,0)
						return false
					end
				elseif getPedWeapon(source,weaponSlot) ~= tonumber(weapon) and tonumber(weapon) ~= 36 and tonumber(weapon) ~= 35 then
					if tonumber(pack) >= 9000 then
						exports.NGCdxmsg:createNewDxMessage(source,"You can't have more than 9000 ammo's of "..getWeaponNameFromID(weapon),255,0,0)
						return false
					end
				end
				if quitDetect[source] then return false end
				local wep, cstFai = giveWeapon ( source,tonumber(weapon), pack, true )
				if (not cstFai) then
					exports.NGCdxmsg:createNewDxMessage(source,"You have paid $"..tonumber(price).." for buying "..pack.." ammo's of "..getWeaponNameFromID(weapon).." weapon",0,255,0)
					exports.AURpayments:takeMoney(source,tonumber(price),"AURAmmunation "..pack.." Ammo of "..getWeaponNameFromID(weapon))
					
					exports.CSGaccounts:forceWeaponSync(source)
				end
			end
		else
			local createWeaponTable = exports.DENmysql:exec("INSERT INTO weapons SET userid=?",tonumber(playerID))
			outputChatBox("There was something wrong, try again or when this error keeps comming warn a staff member!", source, 225, 0, 0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,msg,255,0,0)
		return false
	end
end
addEvent( "buyWeaponAmmoByID", true )
addEventHandler( "buyWeaponAmmoByID", getRootElement(), buyAmmo )

addCommandHandler("testrpg",function(player)
	if getElementData(player,"isPlayerPrime") then
		for i=2,8 do
			if i == 7 then
				if getPedWeapon(player,i) == 35 then
					local ammo = getPedTotalAmmo(player,i)
					if ammo > 100 then
						takeWeapon(player,35)
						exports.NGCnote:addNote("Weapon detector","You can't have more than 100 RPG, RPG has been removed",player,255,0,0,5000)
					end
				end
			end
		end
	end
end)
proTimer = {}--[[
addEventHandler("onPlayerSpawn",root,function()
	if isTimer(proTimer[source]) then killTimer(proTimer[source]) end
	proTimer[source] = setTimer(function(p)
		if p and isElement(p) and getElementType(p) == "player" then
			if getPedWeapon(p,7) == 35 then
				local ammo = getPedTotalAmmo(p,7)
				if ammo > 100 then
					setWeaponAmmo(p,35,100)
					exports.NGCnote:addNote("Weapon detector","More than 100 RPG ? You're obviously a boss!",p,255,0,0,5000)
				end
			elseif getPedWeapon(p,7) == 36 then
				local ammo = getPedTotalAmmo(p,7)
				if ammo > 2 then
					setWeaponAmmo(p,36,2)
					exports.NGCnote:addNote("Weapon detector","More than 2 Javelin ? You're obviously a boss!",p,255,0,0,5000)
				end
			end
		end
	end,10000,1,source)
end)]]

function buySpecial ( weapon, price )
	--if weapon <= "15" and weapon >= "2" then
		local money = getPlayerMoney(source)
		if (money < tonumber(price)) then
			triggerClientEvent( source, "warn4", source )
		else
			exports.AURpayments:takeMoney(source,tonumber(price),"AURAmmunation misc")
			giveWeapon ( source, tonumber(weapon))
			exports.NGCdxmsg:createNewDxMessage(source,"You have paid $"..tonumber(price).." for buying "..getWeaponNameFromID(tonumber(weapon)),0,255,0)
		end
	--end
end
addEvent( "buyWeaponMisc", true )
addEventHandler( "buyWeaponMisc", getRootElement(), buySpecial )

function getArmorPrice ( thePlayer, armourType )
	if getElementData(thePlayer, "isPlayerVIP") then
		return 5000
	else
		return 10000
	end
end

addEvent("NGCammu.buyLaser",true)
addEventHandler("NGCammu.buyLaser",root,function(cost,r,g,b)
	local m = getPlayerMoney(source)
	if m > cost then
		exports.NGCmanagement:RPM(source,cost)
		exports.CSGlaser:SetLaserEnabled(source,true)
		exports.CSGlaser:SetLaserColor(source,r,g,b)
		exports.NGCdxmsg:createNewDxMessage(source,"Bought a laser for $"..cost.."",0,255,0)
		exports.NGCdxmsg:createNewDxMessage(source,"Press L or type /laser to equip / unequip it",0,255,0)
		local accountID = exports.server:getPlayerAccountID(source)
		local t = {100,r,g,b,true} --battery percent, r, g, b, enabled

		exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE userid=?",toJSON(t),accountID)
		triggerEvent("NGCammu.boughtLaser",source,t)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You can't afford this laser. It costs $"..cost..", you only have $"..m.."",255,255,0)
	end
end)

function onClientPlayerBoughtArmour (armourType)
	if ( math.floor( getPedArmor ( source ) ) < 100 ) then
		if ( getPlayerMoney( source ) < getArmorPrice ( source, armourType ) ) then
			exports.NGCdxmsg:createNewDxMessage(source, "You don't have enough money!", 225, 0, 0)
		else
			local howMuch = tonumber(armourType)
			local price = getArmorPrice ( source, armourType )
			exports.NGCmanagement:RPM( source, tonumber(price) )
			if ( tonumber(armourType) == 50 ) then setPedArmor ( source, getPedArmor(source) +50 ) else setPedArmor ( source, 100 ) end
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source, "You don't need anymore armor!", 225, 0, 0)
	end
end
addEvent( "onClientPlayerBoughtArmour", true )
addEventHandler( "onClientPlayerBoughtArmour", getRootElement(), onClientPlayerBoughtArmour )
