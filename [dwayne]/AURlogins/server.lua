
--[[ get Accounts

addEvent("onRequestAccountsTable",true)
addEventHandler("onRequestAccountsTable",root,
	function (userSearch,exactMatches)
		if not exactMatches then
			local userSearch = "%"..userSearch.."%"
			local accounts = exports.denmysql:query("SELECT username,id,money,email,team,occupation,score,playtime,VIP FROM accounts WHERE username LIKE ?",userSearch)
			if not accounts then
				exports.NGCdxmsg:createNewDxMessage(source,"Something went wrong, please try again later.",255,0,0)
				return false;
			end
			if #accounts <= 25 then
				exports.NGCdxmsg:createNewDxMessage(source,#accounts.." hits found. Transfering data, this may take a while.",0,255,0)
				triggerLatentClientEvent(source,"onRequestAccountsTable:callBack", 15000, false, source, accounts )
			else
				exports.NGCdxmsg:createNewDxMessage(source,#accounts.." hits found. Please use a more specific search.",255,0,0)
			end
		else
			local accounts = exports.denmysql:query("SELECT username,id,money,email,team,occupation,score,playtime,VIP FROM accounts WHERE username=?",userSearch)
			if #accounts >= 1 then
				exports.NGCdxmsg:createNewDxMessage(source,#accounts.." hit found. Transfering data.",0,255,0)
				triggerLatentClientEvent(source,"onRequestAccountsTable:callBack", 15000, false, source, accounts )
			else
				exports.NGCdxmsg:createNewDxMessage(source,#accounts.." hits found. No exact match found.",255,0,0)
			end
		end
	end
)

-- Get the last logins and send them to the client
addCommandHandler( "lastlogins",
	function ( thePlayer )
		local theAccount = exports.server:getPlayerAccountName ( thePlayer )
		if ( theAccount ) then
			local theTable = exports.DENmysql:query( "SELECT ip,serial,datum,nickname FROM logins WHERE accountname=? ORDER BY datum ASC LIMIT 10", theAccount )
			triggerClientEvent( thePlayer, "onClientOpenLoginsWindow", thePlayer, theTable )
		end
	end
)


]]

addEvent("callAmmoLog",true)
addEventHandler("callAmmoLog",root,function(pl)
	local t = {}
	for slot = 0, 12 do
		local weapon = getPedWeapon( pl, slot )
		if ( weapon > 0 ) then
			local ammo = getPedTotalAmmo( pl, slot )
			if ( ammo > 0 ) then
				table.insert(t,{wep=getWeaponNameFromID(weapon),wepammo=ammo})
			end
		end
	end
	triggerClientEvent(source,"returnammolog",source,t)
	--[[for k,v in ipairs(getElementsByType("player")) do exports.CSGaccounts:forceWeaponSync(v) end
		for i = 0, 12 do
			local weapon = getPedWeapon(v, i)
			if ( weapon > 0 ) then
				local ammo = getPedTotalAmmo(v, i)
				if ammo >= 6000 then
					--setWeaponAmmo(v,weapon,1)
					outputDebugString(getPlayerName(v).." weapon ammo set "..getWeaponNameFromID(weapon).." ammo "..ammo)
				end
			end
		end
	end]]
	--[[local dat = exports.DENmysql:query("SELECT * FROM accounts")
	for k,v in ipairs(dat) do
		outputChatBox("Creating new save table for "..(v.username),source,255,255,0)
		local save = {}
		local weapons = fromJSON( v.weapons )
		if ( weapons ) then
			for weapon, ammo in pairs( weapons ) do
				if ammo > 0 then
					if ammo >= 5000 then
						outputDebugString(getWeaponNameFromID(weapon).." has "..ammo)
						ammo = 1
					end
					save[weapon] = ammo
					--exports.DENmysql:exec("UPDATE accounts SET weapons=? WHERE id=?",theString,v.id)
				end
			end
		end
		local theString = toJSON(save)
		outputDebugString("Saving new weapons for "..(v.username))
		outputDebugString(theString)
		exports.DENmysql:exec("UPDATE accounts SET weapons=? WHERE id=?",theString,v.id)
	end]]
end)

--[[
local save = {}
	local dat = exports.DENmysql:query("SELECT * FROM accounts")
	for k,v in ipairs(dat) do
		local weapons = fromJSON( v.weapons )
		if ( weapons ) then
			for weapon, ammo in pairs( weapons ) do
				if ammo > 0 then
					if ammo >= 6000 then
						outputDebugString(getWeaponNameFromID(weapon).." has "..ammo)
						ammo = 1
					end
					save[weapon] = ammo
				end
			end
		end
		local theString = toJSON(save)
		outputDebugString("Saving new weapons for "..(v.username))
		outputDebugString(theString)
		exports.DENmysql:exec("UPDATE accounts SET weapons=? WHERE id=?",theString,v.id)
	end
	]]

addEvent("onPlayerRequestLogs",true)
addEventHandler("onPlayerRequestLogs",root,function(searchType,name,value)
	if value == "atm" then
		exports.NGCdxmsg:createNewDxMessage(source,"Searching for "..name.."/"..value.." data, this may take a while.",0,255,0)
		local name = tonumber(name)
		local trans = exports.DENmysql:query("SELECT * FROM banking_transactions WHERE userid=?",name)
		if trans then
			triggerClientEvent(source,"onRequestATMLogs", source, trans )
		end
		exports.NGCdxmsg:createNewDxMessage(source,#trans.." hits found. Transfering data, this may take a while.",0,255,0)
	else
		if searchType == "Accounts" then
			accounts2 = exports.denmysql:query("SELECT * FROM logs WHERE type=? AND account=?",value,name)
		else
			return false
		end
		if not accounts2 then
			exports.NGCdxmsg:createNewDxMessage(source,"Something went wrong, please try again later.",255,0,0)
			return false;
		end
	--	if #accounts <= 100 then
			exports.NGCdxmsg:createNewDxMessage(source,#accounts2.." hits found. Transfering data, this may take a while.",0,255,0)
			--triggerLatentClientEvent(source,"onRequestLastLogins", 15000, false, source, accounts )
			triggerClientEvent(source,"onRequestLastLogs", source, accounts2 )
	--	else
		--	exports.NGCdxmsg:createNewDxMessage(source,#accounts.." hits found. Please use a more specific search.",255,0,0)
	--	end
	end
end)

addEvent("onPlayerRequestLogins",true)
addEventHandler("onPlayerRequestLogins",root,function(searchType,name)
	if searchType == "Accounts" then
		accounts = exports.denmysql:query("SELECT * FROM logins WHERE accountname LIKE ?",name)
	else
		local name = "%"..name.."%" ---ip,serial,datum,nickname,accountname
		accounts = exports.denmysql:query("SELECT * FROM logins WHERE nickname LIKE ?",name)
	end
	if not accounts then
		exports.NGCdxmsg:createNewDxMessage(source,"Something went wrong, please try again later.",255,0,0)
		return false;
	end
--	if #accounts <= 100 then
		exports.NGCdxmsg:createNewDxMessage(source,#accounts.." hits found. Transfering data, this may take a while.",0,255,0)
		--triggerLatentClientEvent(source,"onRequestLastLogins", 15000, false, source, accounts )
		triggerClientEvent(source,"onRequestLastLogins", source, accounts )
--	else
	--	exports.NGCdxmsg:createNewDxMessage(source,#accounts.." hits found. Please use a more specific search.",255,0,0)
--	end
end)

antispam = {}

addCommandHandler( "logins",
	function ( thePlayer )
		local theAccount = exports.server:getPlayerAccountName ( thePlayer )
		if ( theAccount ) then
			if isTimer(antispam[thePlayer]) then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You can open logins once every 1 minute",255,0,0) return false end
			antispam[thePlayer] = setTimer(function() end,60000,1)
			local theTable = exports.DENmysql:query( "SELECT ip,serial,datum,nickname FROM logins WHERE accountname=? ORDER BY datum ASC LIMIT 15", theAccount )
			triggerClientEvent( thePlayer, "callClientLogins", thePlayer, theTable )
		end
	end
)
