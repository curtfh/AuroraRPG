local playerLoginsFile
local playerLoginsInfo = {}
-- retrieve stored info using JSON
if fileExists("Admin Panel\\lastLogins.json") then
	playerLoginsFile = fileOpen("Admin Panel\\lastLogins.json")
	local size = fileGetSize(playerLoginsFile) or 1
	local text = fileRead(playerLoginsFile,math.max(1,size))
	playerLoginsInfo = fromJSON(text) or {}
else
	playerLoginsFile = fileCreate("Admin Panel\\lastLogins.json")
	fileWrite(playerLoginsFile,toJSON({}))
	fileFlush(playerLoginsFile)
end


addEvent("setKickMsg",true)
addEventHandler("setKickMsg",root,function(admin)
	exports.NGCdxmsg:createNewDxMessage(source,"You have been kicked from this room by "..getPlayerName(admin),255,0,0)
end)

addEventHandler( "onPlayerLogin",root,
	function (a,b)
		if a or b then return end
		local serial = getPlayerSerial(source)
		local playerName = getPlayerName( source )
		local accountName = exports.server:getPlayerAccountName( source )
		if playerLoginsInfo[serial] then
			local newInfo = {}
			local i = 1
			table.insert(playerLoginsInfo[serial],1,{accountName,playerName})
			for id,info in pairs(playerLoginsInfo[serial]) do
				table.insert(newInfo,info)
				if id >= 6 then
					break
				end
			end
			playerLoginsInfo[serial] = newInfo
		else
			playerLoginsInfo[serial] = {{accountName,playerName}}
		end
	end
)

addEventHandler( "onResourceStop",resourceRoot,
	function ()
		playerLoginsFile = fileCreate("Admin Panel\\lastLogins.json")
		fileWrite(playerLoginsFile,toJSON(playerLoginsInfo))
		fileFlush(playerLoginsFile)
		fileClose(playerLoginsFile)
	end
)

-- Event to get player information
addEvent( "onRequestAdminPlayerInfo", true )
addEventHandler( "onRequestAdminPlayerInfo", root,
	function ( thePlayer )
		if ( exports.server:getPlayerVIPHours( thePlayer ) ) then VIPHours = math.floor( exports.server:getPlayerVIPHours( thePlayer )/60 ) else VIPHours = "Not VIP" end
		if ( exports.server:getPlayerAccountEmail( thePlayer ) ) then playerEmail = exports.server:getPlayerAccountEmail( thePlayer ) else playerEmail = "Not logged in" end
		if ( exports.server:getPlayerAccountName( thePlayer ) ) then accountname = exports.server:getPlayerAccountName( thePlayer ) else accountname = "Not logged in" end
		if ( getElementData( thePlayer, "Play Time" ) ) then playTime = getElementData( thePlayer, "Play Time" ) else playTime = "Not logged in" end
		if ( getElementData( thePlayer, "Group" ) ) then playerGroup = getElementData( thePlayer, "Group" ) else playerGroup = "Not in a group" end
		if (getElementData(thePlayer, "contLong")) then country = getElementData(thePlayer, "contLong") else country = "Country is not found" end
		if ( exports.server:getPlayerBankBalance(thePlayer)) then bBalance = exports.server:convertNumber(exports.server:getPlayerBankBalance(thePlayer)) end
		local playerLogins = playerLoginsInfo[getPlayerSerial( thePlayer )]
		local theTable = {
			getPlayerMoney( thePlayer ) or "N/A",
			bBalance,
			VIPHours,
			playerGroup,
			playerEmail,
			playTime,
			accountname,
			getPlayerSerial( thePlayer ) or "N/A",
			getPlayerIP ( thePlayer ) or "N/A",
			country,
			getPlayerVersion ( thePlayer ) or "N/A",
			playerLogins,
		}
		triggerClientEvent ( source, "onRequestAdminPlayerInfo:callBack", source, theTable )
	end
)

-- Event to get all the admins
addEvent( "onRequestAdminTable", true )
addEventHandler( "onRequestAdminTable", root,
	function ()
		triggerClientEvent( source, "onRequestAdminTable:callBack", source, getAllAdmins() )
	end
)

addEvent("CSGstaff.removePunishRequest",true)
addEventHandler("CSGstaff.removePunishRequest",root,function(id,text)
	exports.DENmysql:query("UPDATE punishlog SET active=? WHERE punishment=? AND uniqueid=?",0,text,id)
end)

addEvent("CSGstaff.enablePunishRequest",true)
addEventHandler("CSGstaff.enablePunishRequest",root,function(id,text)
	exports.DENmysql:query("UPDATE punishlog SET active=? WHERE punishment=? AND uniqueid=?",1,text,id)
end)

-- Get bans
addEvent( "onRequestBansTable", true )
addEventHandler( "onRequestBansTable", root,
	function ()
		local globalbans = exports.denmysql:query("SELECT * FROM bans")
		exports.NGCdxmsg:createNewDxMessage(source,"Transfering data, this may take a while.",255,255,0)
		triggerLatentClientEvent(source,"onRequestBansTable:callBack", 20000, false, source, globalbans, globalbansTable or {} )
	end
)

-- get Accounts

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

addEvent("onRequestAccountBalance",true)
addEventHandler("onRequestAccountBalance",root,
	function (accountID)
		local info = exports.DENmysql:query("SELECT balance FROM banking WHERE userid=? LIMIT 1",accountID);
		local balance
		if type(info[1]) == 'table' then
			balance = info[1]['balance'];
		end
		triggerClientEvent(source,"onRequestAccountBalance:callBack",source,accountID,balance or false);
	end
)
addEvent("onRequestAccountPIN",true)
addEventHandler("onRequestAccountPIN",root,
	function (accountID)
		local info = exports.DENmysql:query("SELECT PIN FROM banking WHERE userid=? LIMIT 1",accountID);
		local PIN
		if type(info[1]) == 'table' then
			PIN = info[1]['PIN'];
		end
		triggerClientEvent(source,"onRequestAccountPIN:callBack",source,accountID,PIN or false);
	end
)

-- Get punishments
addEvent( "onRequestPunishlog", true )
addEventHandler( "onRequestPunishlog", root,
	function ( thePlayer )
		local serial, account = exports.DENpunishments:getPlayerPunishlog ( thePlayer, true )
		triggerClientEvent( source, "onRequestPunishlog:callBack", source, serial, account )
	end
)

-- Event for admin tab stuff
addEvent( "onServerAdminChange", true )
addEventHandler( "onServerAdminChange", root,
	function ( rights, nickname )
		if ( rights == "kick" ) then
			kickAdmin ( nickname )
		elseif ( rights == "demote" ) then
			demoteAdmin ( nickname )
		elseif ( rights == "promote" ) then
			promoteAdmin ( nickname )
		elseif ( rights == "developer" ) then
			setAdminDeveloper ( nickname )
		elseif ( rights == "eventmanager" ) then
			setAdminEventManager ( nickname )
		elseif ( rights == "inactive" ) then
			setAdminActive ( nickname )
		end
		if ( nickname ) then
			setTimer ( triggerClientEvent, 500, 1, "onRequestAdminTable:callBack", source, getAllAdmins() )
			exports.NGCdxmsg:createNewDxMessage( source, "Updating staff table... Please wait!", 0, 225, 0 )
		end
	end
)

-- Event to create a punishment and admin log
function onAdminCreatePunishment ( thePunished, theAdmin, theAction, serial )
	local playerID = exports.server:getPlayerAccountID( thePunished )
	if not ( playerID ) then return end
	if ( serial ) then
		exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, serial=?, punishment=?", tonumber( playerID ), getPlayerSerial( thePunished ), theAction )
	else
		exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?, serial=?", tonumber( playerID ), theAction, "None" )
	end
	exports.CSGlogging:createAdminLogRow ( theAdmin, theAction )
end

-- Event for admin player actions stuff
local theVehicles = {}


addEvent( "onAdminPlayerActions", true )
addEventHandler( "onAdminPlayerActions", root,
	function ( thePlayer, action, arg3, arg4 )
		exports.DENpunishments:updateLogs(thePlayer)
		if ( action == "slap" ) and not ( isPedDead( thePlayer ) ) then
			if getElementDimension(thePlayer) == 5001 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't slap this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5002 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't slap this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5003 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't slap this player",255,0,0)
				return false
			end
			killPed( thePlayer )
			outputChatBox( "You have been slapped by " .. getPlayerName( source ) .. " (100HP)", thePlayer, 225, 0, 0 )
			onAdminCreatePunishment ( thePlayer, source, getPlayerName( source ).." slapped " .. getPlayerName( thePlayer ) .. " (100HP)", false )
		elseif ( action == "freeze" ) then
			local vehicle = getPedOccupiedVehicle ( thePlayer )
			if ( isElementFrozen ( thePlayer ) ) then
				outputChatBox( "You have been unfrozen by " .. getPlayerName( source ) .. "", thePlayer, 225, 0, 0 )
			else
				outputChatBox( "You have been frozen by " .. getPlayerName( source ) .. "", thePlayer, 225, 0, 0 )
				onAdminCreatePunishment ( thePlayer, source, getPlayerName( source ).." froze " .. getPlayerName( thePlayer ) .. "", false )
			end
			if ( vehicle ) then if ( isElementFrozen( vehicle ) ) then setElementFrozen ( vehicle, false ) else setElementFrozen ( vehicle, true ) end end
			if ( isElementFrozen ( thePlayer ) ) then setElementFrozen ( thePlayer, false ) else setElementFrozen ( thePlayer, true ) end
		elseif ( action == "kick" ) then
			outputChatBox( getPlayerName( source ).." kicked " .. getPlayerName( thePlayer ) .. "", root, 225, 0, 0 )
			onAdminCreatePunishment ( thePlayer, source, getPlayerName( source ).." kicked " .. getPlayerName( thePlayer ) .. "", false )
			kickPlayer( thePlayer, "You have been kicked by "..getPlayerName( source ) )
		elseif ( action == "reconnect" ) then
	        outputChatBox( getPlayerName( source ).." reconnected " .. getPlayerName( thePlayer ) .. "", root, 225, 0, 0 )
			redirectPlayer( thePlayer, "78.108.216.208", 22003 )
		elseif ( action == "warp" ) then
			if getElementDimension(thePlayer) == 5001 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't warp to this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5002 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't warp to this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5003 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't warp to this player",255,0,0)
				return false
			end
			onAdminWarpPlayer ( source, thePlayer )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." warped to "..getPlayerName( thePlayer ) )
		elseif ( action == "spectate" ) then
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." started spectating  "..getPlayerName( thePlayer ) )
		elseif ( action == "warpto" ) then
			if getElementDimension(thePlayer) == 5001 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't warp this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5002 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't warp this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5003 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't warp this player",255,0,0)
				return false
			end
			onAdminWarpPlayer ( thePlayer, arg3 )
			outputChatBox( getPlayerName( source ).." warped you to "..getPlayerName( arg3 ), thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." warped " .. getPlayerName( thePlayer ) .. " to "..getPlayerName( arg3 ) )
		elseif ( action == "fixvehicle" ) then
			local vehicle = getPedOccupiedVehicle ( thePlayer )
			if ( vehicle ) then local rX, rY, rZ = getElementRotation( vehicle ) setElementRotation( vehicle, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ ) fixVehicle( vehicle ) outputChatBox( getPlayerName( source ).." fixed your vehicle", thePlayer, 225, 0, 0 ) else exports.NGCdxmsg:createNewDxMessage( source, "Player is not in a vehicle!", 0, 225, 0 ) end
			if ( vehicle ) then exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." repaired the vehicle from " .. getPlayerName( thePlayer ) .. "" ) end
		elseif ( action == "destroyvehicle" ) then
			local vehicle = getPedOccupiedVehicle ( thePlayer )
			if ( vehicle ) and ( getElementData( vehicle, "vehicleType" ) == "playerVehicle" ) then exports.NGCdxmsg:createNewDxMessage( source, "Player owned vehicles cannot be destroyed yet!", 0, 225, 0 ) return end
			if ( vehicle ) then destroyElement( vehicle ) outputChatBox( getPlayerName( source ).." destroyed your vehicle", thePlayer, 225, 0, 0 ) else exports.NGCdxmsg:createNewDxMessage( source, "Player is not in a vehicle!", 0, 225, 0 ) end
			if ( vehicle ) then exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." destroyed the vehicle from " .. getPlayerName( thePlayer ) .. "" ) end
		elseif ( action == "health" ) then
			local thePlayerTeam = getTeamName(getPlayerTeam(source))
			if not (thePlayerTeam == "Staff") then
				exports.NGCdxmsg:createNewDxMessage("You can not use this function, unless you do /staff",source,255,0,0)
				return
				else
			setElementHealth( thePlayer, 200 )
			outputChatBox( getPlayerName( source ).." gave you full health", thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." gave " .. getPlayerName( thePlayer ) .. " full health" )
			end
		elseif ( action == "armor" ) then
			local thePlayerTeam = getTeamName(getPlayerTeam(source))
			if not (thePlayerTeam == "Staff") then
			exports.NGCdxmsg:createNewDxMessage("You can not use this function, unless you do /staff",source,255,0,0)
			return
			else
			setPedArmor( thePlayer, 100 )
			outputChatBox( getPlayerName( source ).." gave you full armor", thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." gave " .. getPlayerName( thePlayer ) .. " full armor" )
			end
		elseif ( action == "jetpack" ) then
			if not ( doesPedHaveJetPack( thePlayer ) ) then exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." gave " .. getPlayerName( thePlayer ) .. " a jetpack" ) end
			if ( doesPedHaveJetPack( thePlayer ) ) then removePedJetPack ( thePlayer ) outputChatBox( getPlayerName( source ).." gave removed your jetpack", thePlayer, 225, 0, 0 ) else givePedJetPack ( thePlayer ) outputChatBox( getPlayerName( source ).." gave you a jetpack", thePlayer, 225, 0, 0 )
			end
		elseif ( action == "VIP" ) then
			if not ( isPedInVehicle( thePlayer ) ) then exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." gave " .. getPlayerName( thePlayer ) .. " a VIP car" ) outputChatBox( getPlayerName( source ).." gave you a VIP car", thePlayer, 225, 0, 0 ) end
			giveVIPCar ( thePlayer )
		elseif ( action == "interior" ) then
			if getElementDimension(thePlayer) == 5001 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5002 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5003 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			end
			outputChatBox( getPlayerName( source ).." moved you to interior "..arg3, thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." moved " .. getPlayerName( thePlayer ) .. " to interior "..arg3 )
			setElementInterior ( thePlayer, arg3, getElementPosition( thePlayer ) )
		elseif ( action == "dimension" ) then
			if getElementDimension(thePlayer) == 5001 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5002 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5003 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			end
			outputChatBox( getPlayerName( source ).." moved you to dimension "..arg3, thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." moved " .. getPlayerName( thePlayer ) .. " to dimension "..arg3 )
			setElementDimension( thePlayer, arg3 )
		elseif ( action == "skin" ) then
			outputChatBox( getPlayerName( source ).." changed your skin to model "..arg3, thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." changed the skin from " .. getPlayerName( thePlayer ) .. " to "..arg3 )
			setElementModel( thePlayer, arg3 )
		elseif ( action == "rename" ) then
			outputChatBox( getPlayerName( source ).." changed your nickname to "..arg3, thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." changed the nickname from " .. getPlayerName( thePlayer ) .. " to "..arg3 )
			setPlayerName( thePlayer, arg3 )
		elseif ( action == "vehicle" ) then
			if getElementDimension(thePlayer) == 5001 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5002 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5003 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			end
			if ( isPedInVehicle( thePlayer ) ) then return end
			outputChatBox( getPlayerName( source ).." gave you a "..getVehicleNameFromModel( arg3 ), thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." gave " .. getPlayerName( thePlayer ) .. " a "..getVehicleNameFromModel( arg3 ) )
			local x, y, z = getElementPosition(thePlayer)
			local rx, ry, rz = getElementRotation(thePlayer)
			local theVehicle = createVehicle( arg3, x, y, z, rx, ry, rz, "VIP" )
			setElementInterior(theVehicle,getElementInterior(thePlayer))
			setElementDimension(theVehicle,getElementDimension(thePlayer))
			theVehicles[theVehicle] = theVehicle
			warpPedIntoVehicle(thePlayer, theVehicle)
		elseif ( action == "weapon" ) then
			outputChatBox ( getPlayerName( source ).." gave you a " .. getWeaponNameFromID( arg3 ) .. " (Ammo: " .. arg4 .. ")", thePlayer, 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." gave " .. getPlayerName( thePlayer ) .. " a " .. getWeaponNameFromID( arg3 ) .. " (Ammo: " .. arg4 .. ")" )
			giveWeapon ( thePlayer, arg3, arg4, true )
		elseif (action == "warpTo") then
			if getElementDimension(thePlayer) == 5001 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5002 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			elseif getElementDimension(thePlayer) == 5003 then
				exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
				return false
			end
			local vehicle = getPedOccupiedVehicle(thePlayer)
			local vehicle2 = getPedOccupiedVehicle(source)
			local x,y,z = getElementPosition(source)
			local int = getElementInterior(source)
			local dim = getElementDimension(source)
			local x = x + 3
			outputChatBox(getPlayerName(source).." warped you to him.",thePlayer,255,0,0)
			exports.CSGlogging:createAdminLogRow ( source, getPlayerName( source ).." warped " .. getPlayerName( thePlayer ) .. " to himself ")
			if (isPedInVehicle(thePlayer)) then
				setElementPosition(vehicle,x,y,z)
				setElementInterior(vehicle,int)
				setElementDimension(vehicle,dim)
			end
			x,y,z = getElementPosition(source)
			int = getElementInterior(source)
			dim = getElementDimension(source)
			x = x + 1
			setElementPosition(thePlayer,x,y,z)
			setElementInterior(thePlayer,int)
			setElementDimension(thePlayer,dim)
		end
	end
)

-- create VIP car
function giveVIPCar ( thePlayer )
	if not ( isPedInVehicle(thePlayer) ) then
		if getElementDimension(thePlayer) == 5001 then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
			return false
		elseif getElementDimension(thePlayer) == 5002 then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
			return false
		elseif getElementDimension(thePlayer) == 5003 then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't do this for this player",255,0,0)
			return false
		end
		local x, y, z = getElementPosition(thePlayer)
		local rx, ry, rz = getElementRotation(thePlayer)
		local theVehicle = createVehicle( 526, x, y, z, rx, ry, rz, "VIP" )
		theVehicles[theVehicle] = theVehicle
		warpPedIntoVehicle(thePlayer, theVehicle)
		local handlingTable = getVehicleHandling ( theVehicle )
		local newVelocity = ( handlingTable["maxVelocity"] + ( handlingTable["maxVelocity"] / 100 * 40 ) )
		setVehicleHandling ( theVehicle, "numberOfGears", 5 )
		setVehicleHandling ( theVehicle, "driveType", 'awd' )
		setVehicleHandling ( theVehicle, "maxVelocity", newVelocity )
		setVehicleHandling ( theVehicle, "engineAcceleration", handlingTable["engineAcceleration"] +8 )
	end
end

-- When a vehicle blows
addEventHandler( "onVehicleExplode", root,
	function ()
		if ( theVehicles[source] ) then
			setTimer ( destroyElement, 4000, 1, source )
		end
	end
)

-- Warp
function onAdminWarpPlayer ( thePlayer, toPlayer, warpTo )
	local thePlayer = thePlayer or source
	local thePlayerTeam = getTeamName(getPlayerTeam(thePlayer))
	if not (thePlayerTeam == "Staff") then
		exports.NGCdxmsg:createNewDxMessage("You can not use this function, unless you do /staff",thePlayer,255,0,0)
		return
		else
	end
	if ( isElement( thePlayer ) ) and ( isElement( toPlayer ) ) then
		if ( isPedInVehicle( thePlayer ) ) then
			exports.NGCdxmsg:createNewDxMessage("You can't warp to "  .. getPlayerName( toPlayer ) ..  " while being in a vehicle !", thePlayer, 255, 0, 0)
			return
		end
		if ( isPedInVehicle ( toPlayer ) ) then
			local vehicle = getPedOccupiedVehicle ( toPlayer )
			local occupants = getVehicleOccupants( vehicle )
			local seats = getVehicleMaxPassengers( vehicle )
			local x, y, z = getElementPosition ( vehicle )
			local isWarped = false
			for seat = 0, seats do
				local occupant = occupants[seat]
				if not ( occupant ) then
					setTimer ( warpPedIntoVehicle, 1000, 1, thePlayer, vehicle, seat )
					fadeCamera ( thePlayer, false, 1, 0, 0, 0 )
					setTimer ( fadeCamera, 1000, 1, thePlayer, true, 1 )
					setElementDimension ( thePlayer, getElementDimension ( toPlayer ) )
					if ( getElementDimension( thePlayer ) ) ~= ( getElementDimension( toPlayer ) ) then setElementInterior ( thePlayer, getElementInterior ( toPlayer ), getElementPosition( toPlayer ) ) end
					isWarped = true
					return
				end
				if not ( isWarped ) then
					setTimer ( setElementPosition, 1000, 1, thePlayer, x, y, z +1 )
					fadeCamera ( thePlayer, false, 1, 0, 0, 0 )
					setTimer ( fadeCamera, 1000, 1, thePlayer, true, 1 )
					setElementDimension ( thePlayer, getElementDimension ( toPlayer ) )
					if ( getElementDimension( thePlayer ) ) ~= ( getElementDimension( toPlayer ) ) then setElementInterior ( thePlayer, getElementInterior ( toPlayer ), getElementPosition( toPlayer ) ) end
				end
			end
		else
			local x, y, z = getElementPosition ( toPlayer )
			local r = getPedRotation ( toPlayer )
			x = x - math.sin ( math.rad ( r ) ) * 2
			y = y + math.cos ( math.rad ( r ) ) * 2
			setTimer ( setElementPosition, 1000, 1, thePlayer, x, y, z + 1 )
			fadeCamera ( thePlayer, false, 1, 0, 0, 0 )
			setElementDimension ( thePlayer, getElementDimension ( toPlayer ) )
			setElementInterior ( thePlayer, getElementInterior ( toPlayer ) )
			setTimer ( fadeCamera, 1000, 1, thePlayer, true, 1 )
		end
	end
end

-- Punishments
addEvent( "onServerPlayerPunish", true )
addEventHandler( "onServerPlayerPunish", root,
	function ( thePlayer, theType, theTime, theReason, vfc, multiplier, hidden )
		if (vfc) then
			theReason = "VFC - "..theReason
		end
		local plr = ""
		if (hidden) then
			plr = "Hidden player"
		else
			plr = thePlayer
		end
		if ( theType == "Mainchat/teamchat mute" ) then
			exports.CSGadmin:adminMutePlayer ( source, thePlayer, theReason, theTime, "Main", multiplier, plr )
		elseif ( theType == "Global mute" ) then
			exports.CSGadmin:adminMutePlayer ( source, thePlayer, theReason, theTime, "Global", multiplier, plr )
		elseif ( theType == "Jail" ) then
			setElementData(thePlayer,"isPlayerArrested",false)
			setElementData(thePlayer,"isPlayerAdminJailed",true)
			local userID = exports.server:getPlayerAccountID(thePlayer)
			exports.CSGscore:takePlayerScore(thePlayer, 150)
			local cash = getPlayerMoney(thePlayer)
			local bankQuery = exports.DENmysql:querySingle("SELECT * FROM banking WHERE userid=?", userID)
			if (#bankQuery > 0) then
				local bankMoney = bankQuery['balance']
				if (cash > 500000) then
					takePlayerMoney(thePlayer, 500000)
				elseif (cash < 500000) and (cash + bankMoney > 500000) then
					local diff = 500000 - cash
					setPlayerMoney(thePlayer, 0)
					exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", bankMoney - diff, userID)
			else
					takePlayerMoney(thePlayer, 500000)
			end
				takePlayerMoney(thePlayer, 500000)
			end
			exports.CSGadmin:setPlayerJailed ( source, thePlayer, theReason, theTime, false, multiplier, hidden )
		elseif ( theType == "Account ban" ) then
			exports.CSGadmin:banServerPlayer ( source, thePlayer, theReason, theTime, "account", multiplier, hidden )
		elseif ( theType == "Serial ban" ) then
			exports.CSGadmin:banServerPlayer ( source, thePlayer, theReason, theTime, "serial", multiplier, hidden )
		end
	end
)

-- Punishments remove
addEvent( "onServerPlayerPunishRemove", true )
addEventHandler( "onServerPlayerPunishRemove", root,
	function ( thePlayer, theType, a, b, hidden )
		if ( theType == "Mainchat/teamchat mute" ) then
			exports.CSGadmin:adminUnmutePlayer ( thePlayer, source, hidden )
		elseif ( theType == "Global mute" ) then
			exports.CSGadmin:adminUnmutePlayer ( thePlayer, source, hidden )
		elseif ( theType == "Jail" ) then
			exports.CSGadmin:removePlayerJailed( thePlayer, source, hidden )
			setElementData(thePlayer,"isPlayerAdminJailed",false)
		end
	end
)




-- bans

addEvent("staffpanel.ban",true)
addEventHandler("staffpanel.ban",root,
function(serialOrAccount,banType,reason,duration,global)
	local theTime = getRealTime()
	local timestamp = theTime.timestamp
	local banstamp
	if (duration == 0) then
		banstamp = 0
	else
		banstamp = timestamp+duration
	end
	local banTable = "bans"
	if global then banTable = 'globalbans' end
	local serial = serialOrAccount
	local account = ""
	if banType == 'account' then
		serial = ""
		account = serialOrAccount
	end
	exports.denmysql:exec("INSERT INTO ?? (serial,account,reason,banstamp,bannedby) VALUES (?,?,?,?,?)",banTable,serial,serialOrAccount,reason,banstamp,getPlayerName(source))
	outputChatBox("AuroraRPG: Added entity '"..serialOrAccount.."' into the ban list within "..banstamp.." for "..reason..".", source, 255, 255, 255)
	local players = getElementsByType('player')
	for i=1,#players do
		if banType == 'serial' then
			local pSerial = getPlayerSerial(players[i])
			if pSerial == serialOrAccount then
				kickPlayer(players[i],source,reason)
			end
		else
			local pAccount = exports.server:getPlayerAccountName(players[i])
			if pAccount == serialOrAccount then
				kickPlayer(players[i],source,reason)
			end
		end
	end
	local globalbans = exports.denmysql:query("SELECT * FROM bans")
	--exports.NGCdxmsg:createNewDxMessage(source,"Transfering data, this may take a while.",255,255,0)
	triggerLatentClientEvent(source,"onRequestBansTable:callBack", 20000, false, source, globalbans, globalbansTable or {} )
end)
addEvent("staffpanel.unban",true)
addEventHandler("staffpanel.unban",root,
	function(banID,global, player)
	local banTable = "bans"
	if global then banTable = "globalbans" end
	exports.denmysql:exec("DELETE FROM ?? WHERE id=?",banTable,banID)
	exports.NGCdxmsg:createNewDxMessage(player,"You unbanned the selected details.",255,0,0)
	local globalbans = exports.denmysql:query("SELECT * FROM bans")
	exports.NGCdxmsg:createNewDxMessage(player,"Updating Ban List.",255,255,0)
	triggerLatentClientEvent(player,"onRequestBansTable:callBack", 20000, false, player, globalbans, globalbansTable or {} )
end)

addEvent('addServerStaff',true)
addEventHandler('addServerStaff',root,function(u,n,g)
	local accounts = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE username=?",u)
	local data = exports.DENmysql:querySingle("SELECT * FROM staff WHERE userid=?",accounts.id)
	if exports.server:getPlayerAccountName(source) == "truc0813" or exports.server:getPlayerAccountName(source) == "badboy1" or exports.server:getPlayerAccountName("ab-47") then
	if data and data.nickname == tostring(n) then
		exports.NGCdxmsg:createNewDxMessage(source,"Staff already hired!",255,0,0)
	else
		exports.DENmysql:exec("INSERT INTO staff SET userid=?,nickname=?,rank=?,gender=?,developer=?,basemod=?,eventmanager=?,active=?",accounts.id,n,1,g,0,0,0,1)
		exports.NGCdxmsg:createNewDxMessage(source,"Staff has been added successfully, tell him to reconnect!",0,255,0)
	end
    end
end)

local datass = {
	old = {
		skin = {},
		team = {}
	},
	active = { false },
}

--[[addCommandHandler("secretstaff", 
	function (plr)
		if (exports.server:getPlayerAccountName(plr) == "dodo") then
		local accounts = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE username=?","dodo")
			if (datass.active[plr]) then
				datass.active[plr] = false
				if (datass.old.skin[plr]) then
					setElementModel(plr, datass.old.skin[plr])
				end
				if (datass.old.team[plr]) then
					setPlayerTeam(plr, datass.old.team[plr])
				else
					setPlayerTeam(plr, getTeamFromName("Unemployed"))
				end
				exports.DENmysql:exec("REMOVE FROM staff WHERE userid=?", accounts.id)
				outputChatBox("Removed from staff, you're now a normal player!", plr, 255, 0, 0)
			else
				datass.old.skin[plr] = getElementModel(plr)
				datass.old.team[plr] = getPlayerTeam(plr)
				exports.DENmysql:exec("INSERT INTO staff SET userid=?,nickname=?,rank=?,gender=?,developer=?,basemod=?,eventmanager=?,active=?",accounts.id,"Akira",3,1,0,0,1,1)
				setPlayerTeam(plr, getTeamFromName("Staff"))
				setElementData(plr, "Occupation", "Your Worst Nightmare")
				setElementModel(plr, 211)
				outputChatBox("Added as L3 staff, go do some undercover work!", plr, 0, 255, 0)
			end
		end
	end
)]]

addEvent('staffpanel.accounts.delete',true)
addEventHandler('staffpanel.accounts.delete',root,
	function (id)
		if not tonumber(id) then return false; end
		local playerAccount = isAccountLoggedIn(tonumber(ID))
		if playerAccount then
			exports.NGCdxmsg:createNewDxMessage(source,"Account logged in as "..getPlayerName(playerAccount)..", please wait till user logs out.",255,0,0)
			return false;
		end
		exports.denmysql:exec("DELETE FROM accounts WHERE id=?",id)
		exports.denmysql:exec("DELETE FROM banking WHERE userid=?",id)
		exports.NGCdxmsg:createNewDxMessage(source,"Account deleted!",0,255,0)
	end
)

addEvent("staffpanel.accounts.updateInfo",true)
addEventHandler("staffpanel.accounts.updateInfo",root,
	function(ID, updatedInfo)
		if not tonumber(ID) then
			exports.NGCdxmsg:createNewDxMessage(source,"ID invalid, account bugged?",255,0,0)
			return false;
		else
			local playerAccount = isAccountLoggedIn(tonumber(ID))
			if playerAccount then
				exports.NGCdxmsg:createNewDxMessage(source,"Account logged in as "..getPlayerName(playerAccount)..", please wait till user logs out.",255,0,0)
				return false;
			end
		end
		local tables = {['banking'] = {}, ['accounts'] = {} }
		for k,v in pairs(updatedInfo) do
			if k == 'bankmoney' then
				getString = "userid=?"
				table.insert(tables['banking'],{'balance',tonumber(v)})
			elseif k == 'password' then
				getString = "id=?"
				table.insert(tables['accounts'],{k,sha256(v)})
			elseif k == "PIN" then
				getString = "userid=?"
				table.insert(tables['banking'],{k,tonumber(v)})
				---outputDebugString(v.."|"..k)
			else
				getString = "id=?"
				table.insert(tables['accounts'],{k,v})
			end
		end
		for dbTable,values in pairs(tables) do
			if #values >= 1 then
				local setString = ""
				local allValues = {}
				for i=1,#values do
					local key,value = unpack(values[i])
					if i ~= #values then
						setString = setString..""..key.."=?,"
					else
						setString = setString..""..key.."=?"
					end
					table.insert(allValues,value)
				end
				table.insert(allValues,tonumber(ID))
				table.insert(allValues,1,dbTable)
				local queryString = "UPDATE ?? SET "..setString.." WHERE "..getString
				exports.denmysql:exec(queryString,unpack(allValues))
			end
		end
		exports.NGCdxmsg:createNewDxMessage(source,"Info updated!",0,255,0)
	end
)
-- manage accounts that are logged in

function isAccountLoggedIn(ID)
	local players = getElementsByType('player');
	for i=1,#players do
		local userID = getElementData(players[i],"accountUserID");
		if userID == ID then
			return players[i];
		end
	end
	return false;
end
