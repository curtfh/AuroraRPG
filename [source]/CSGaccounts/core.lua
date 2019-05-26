


-- Tables

local weaponStringTable = {}

local playerWeaponTable = {}



-- When the player login

addEvent( "onServerPlayerLogin" )

addEventHandler( "onServerPlayerLogin", root,

	function ( userID )

		givePlayerDbWeapons(source, userID)

		setPlayerWeaponString(source, userid)

	end

)


function mathround(number, decimals, method)

    decimals = decimals or 0

    local factor = 10 ^ decimals

    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor

    else return tonumber(("%."..decimals.."f"):format(number)) end

end


function setPlayerWeaponString(player, userid)

	local userID = userid or exports.server:getPlayerAccountID(player)

	dbQuery(setPlayerWeaponStringCB,{player},exports.DENmysql:getConnection(),"SELECT weapons FROM accounts WHERE id=?", userID )

end



function setPlayerWeaponStringCB(qh, player)

	local result = dbPoll(qh,0)

	if(result == nil) then dbFree(qh) return end

	if(not result or not result[1] or not isElement(player)) then return end

	weaponStringTable[player] = result[1].weapons

end



function givePlayerDbWeapons(player, userid)

	local userID = userid or exports.server:getPlayerAccountID(player)

	dbQuery(givePlayerDbWeaponsCB,{player},exports.DENmysql:getConnection(),"SELECT 22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37 FROM weapons WHERE userid=?", userID )

end



function givePlayerDbWeaponsCB(qh, player)

	local result = dbPoll(qh,0)

	if(result == nil) then dbFree(qh) return end

	if(not result or not result[1] or not isElement(player)) then return end

	playerWeaponTable[ player ] = result[1]

	for k,v in pairs(result[1]) do
		--outputDebugString(k)
		if k == 35 and v>0 then

			giveWeapon(player,k,v)
			outputDebugString(k..":"..v)
		end

	end

end



-- Function that checks if the player owns this weapons

function doesPlayerHaveWeapon( thePlayer, theWeapon )

	if ( playerWeaponTable[ thePlayer ] ) and ( playerWeaponTable[ thePlayer ][ tonumber( theWeapon ) ] ) then

		if ( playerWeaponTable[ thePlayer ][ tonumber( theWeapon ) ] == 1 ) then

			return true

		else

			return false

		end

	else

		return false

	end

end



-- Function that gives the player the weapon

function setPlayerOwnedWeapon( thePlayer, theWeapon, theState )

	if ( theState ) then theState = 1 else theState = 0 end if not ( thePlayer ) or not ( theWeapon ) then return false end

	if ( playerWeaponTable[ thePlayer ] ) and ( playerWeaponTable[ thePlayer ][ tonumber( theWeapon ) ] ) then

		if ( exports.server:exec( "UPDATE weapons SET `??`=? WHERE userid=?",tonumber( theWeapon ), theState, expors.server:getPlayerAccountID( thePlayer ) ) ) then

			playerWeaponTable[ thePlayer ][ tonumber( theWeapon ) ] = theState

			return true

		else

			return false

		end

	else

		return exports.server:exec( "UPDATE weapons SET `??`=? WHERE userid=?", tonumber( theWeapon ), theState, expors.server:getPlayerAccountID( thePlayer ) )

	end

end



-- Function to give player money

function addPlayerMoney ( thePlayer, theMoney )

	if ( givePlayerMoney( thePlayer, tonumber( theMoney ) ) ) and ( exports.server:getPlayerAccountID( thePlayer ) ) then

		exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE id=?", ( tonumber( theMoney ) + getPlayerMoney( thePlayer ) ), exports.server:getPlayerAccountID( thePlayer ) )

		return true

	else

		return false

	end

end



-- Function to remove player money

function removePlayerMoney ( thePlayer, theMoney )

	if ( takePlayerMoney( thePlayer, tonumber( theMoney ) ) ) and ( exports.server:getPlayerAccountID( thePlayer ) ) then

		exports.DENmysql:exec( "UPDATE accounts SET money=? WHERE id=?", ( tonumber( theMoney ) + getPlayerMoney( thePlayer ) ), exports.server:getPlayerAccountID( thePlayer ) )

		return true

	else

		return false

	end

end



-- Event that changes the element model in the database

addEventHandler( "onElementModelChange", root,

	function ( oldModel, newModel )

		if ( getElementType( source ) == "player" ) and ( exports.server:getPlayerAccountID( source ) ) and ( getPlayerTeam ( source ) ) then

			if ( getTeamName ( getPlayerTeam ( source ) )  == "Criminals" ) or ( getTeamName ( getPlayerTeam ( source ) )  == "Unemployed" ) or ( getTeamName ( getPlayerTeam ( source ) )  == "Unoccupied" ) then

				exports.DENmysql:exec( "UPDATE accounts SET skin=? WHERE id=?", newModel, exports.server:getPlayerAccountID( thePlayer ) )

			else

				exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", newModel, exports.server:getPlayerAccountID( thePlayer ) )

			end

		end

	end

)



-- Function that get the correct weapon string of the player

function getPlayerWeaponString ( thePlayer )

	return weaponStringTable[thePlayer]

end



-- Event that syncs the correct weapon string with the server

addEvent( "syncPlayerWeaponString", true )

addEventHandler( "syncPlayerWeaponString", root,

	function ( theString, allow )

		--[[if (allow) then

			if isPedDead(source) == true then

				local t = fromJSON(theString)

				if #t == 0 then return end

			end



			weaponStringTable[source] = theString

			exports.DENmysql:exec("UPDATE accounts SET weapons=? WHERE id=?",theString,exports.server:getPlayerAccountID(source))

		elseif isPedDead(source) == true then

			return

		else



			weaponStringTable[source] = theString

			exports.DENmysql:exec("UPDATE accounts SET weapons=? WHERE id=?",theString,exports.server:getPlayerAccountID(source))

		end]]

	end

)


local who = {}
addEventHandler( "onServerPlayerLogin", root,

	function ()
	who[source] = true
		---triggerClientEvent( source, "startSaveWep", source )

	end

)



-- Function that saves the important playerdata

function savePlayerData ( thePlayer )

	if ( exports.server:getPlayerAccountID( thePlayer ) ) and ( getElementData( thePlayer, "joinTick" ) ) --[[and ( getTickCount()-getElementData( thePlayer, "joinTick" ) > 5000 )]] then

		if ( isPedDead( thePlayer ) ) then

			armor = 0

		else

			armor = getPedArmor( thePlayer )

		end



		-- We want to use variable to declare certain account data, just so we don't have to call it during the query. Reduces risk of null data.

		local x, y, z = getElementPosition ( thePlayer )

		local playtime = getElementData( thePlayer, "playTime" )

		local wantedPoints = mathround( getElementData( thePlayer, "wantedPoints" ), 0 )

		local money = getPlayerMoney( thePlayer )

		local interior = getElementInterior( thePlayer )

		local dimension = getElementDimension( thePlayer )

		local rot = getPedRotation( thePlayer )

		local occupation = exports.server:getPlayerOccupation( thePlayer )

		local team = getTeamName( getPlayerTeam( thePlayer ) )

		local id = exports.server:getPlayerAccountID( thePlayer )

		if ( playtime ) then

			exports.DENmysql:exec( "UPDATE `accounts` SET `money`=?, `health`=?, `armor`=?, `wanted`=?, `x`=?, `y`=?, `z`=?, `interior`=?, `dimension`=?, `rotation`=?, `occupation`=?, `team`=?, `playtime`=? WHERE `id`=?",

				money,

				getElementHealth( thePlayer ),

				armor,

				wantedPoints,

				x,

				y,

				z,

				interior,

				dimension,

				rot,

				--getPlayerWeaponString( thePlayer ),

				occupation,

				team,

				playtime,

				id

			)

		else -- don't set playtime to avoid the risk of losing it all

			exports.DENmysql:exec( "UPDATE `accounts` SET `money`=?, `health`=?, `armor`=?, `wanted`=?, `x`=?, `y`=?, `z`=?, `interior`=?, `dimension`=?, `rotation`=?, `occupation`=?, `team`=? WHERE `id`=?",

				money,

				getElementHealth( thePlayer ),

				armor,

				wantedPoints,

				x,

				y,

				z,

				interior,

				dimension,

				rot,

				--getPlayerWeaponString( thePlayer ),

				occupation,

				team,

				id

			)

		end

		return true

	else

		return false

	end

end



-- Triggers that should save playerdata

function doSaveData()

	if (exports.AURloginPanel:isAllowedToSave(source) == true) then

		savePlayerData ( source )

	end

end

--[[

local timers = {}

addEventHandler( "onPlayerLogout", root, function()

	local wantedPoints = getElementData(source,"wantedPoints")

	outputDebugString(math.floor(wantedPoints))

	local id = exports.server:getPlayerAccountID( thePlayer )

	if isTimer(timers[source ]) then return false end

	timers[source ] = setTimer(function(d)

	exports.DENmysql:exec( "UPDATE `accounts` SET wanted=? WHERE `id`=?",math.floor(wantedPoints),d)

	end,3000,1,id)

end)]]



function quit()

	savePlayerData( source )

	playerWeaponTable[source] = nil

	weaponStringTable[source] = nil

end

addEventHandler( "onPlayerQuit", root, quit )

addEventHandler( "onPlayerWasted", root, doSaveData )

addEventHandler( "onPlayerLogout", root, doSaveData )




function getElementModel( p )

	local t = exports.DENmysql:query( "SELECT skin FROM accounts WHERE username=?", exports.server:getPlayerAccountName( p ) )

	return t[1].skin

end



setTimer(

	function ()

		for k, v in ipairs(getElementsByType("player")) do

			if exports.server:isPlayerLoggedIn(v) then

				givePlayerDbWeapons(v)

				setPlayerWeaponString(v)

			end

		end

	end, 1000, 1

)



function forceWeaponSync( p )

	--triggerClientEvent( p,"forceWepSync", p )
	forceSave(p)
end

recentlySaved = {}
local way1 = {}
local way2 = {}


function saveWeapons(player)
	--if who[player] == true then return false end
	--if (recentlySaved[player]) then return end
	--recentlySaved[player] = true
	--setTimer(function(player) recentlySaved[player] = nil end, 50, 1, player)
	--setTimer(function(p) who[p] = false end,3000,1,player)
	if isTimer(way1[player]) then return false end
	if isTimer(way2[player]) then return false end

	local weapons = {}
	for i = 0, 12 do
		local weapon = getPedWeapon(player, i)
		if ( weapon > 0 ) then
			local ammo = getPedTotalAmmo(player, i)
			if ammo > 0 then
				weapons[weapon] = ammo
				--outputDebugString(getWeaponNameFromID(weapon).." : "..ammo)
			end
		end
	end
	way1[player] = setTimer(function() end,1000,1)
	local theString = toJSON(weapons)
	if theString == "[ [ ] ]" and (getElementData(player,"fire") == false or getElementData(player,"isPlayerTrading") == false) then
		--outputDebugString(getPlayerName(player).." Had abort on Weapons Saving")
		--	exports.killmessages:outputMessage("Warning: If you had weapons then your weapons didn't save , Please die again (Dont reconnect)",player,255,0,0)
	else
		setElementData(player,"TheWeapons",toJSON(weapons))
		weaponStringTable[player] = theString
		--outputDebugString(theString)
		--outputDebugString(getPlayerName(player).." saved his Weapons")
		exports.DENmysql:exec("UPDATE accounts SET weapons=? WHERE id=?",theString,exports.server:getPlayerAccountID(player))
	end
	takeAllWeapons(player)
	return true
end

function forceSave(player)
	if isTimer(way1[player]) then return false end
	if isTimer(way2[player]) then return false end
	if isPedDead(player) then
		return
	end
	local weapons = {}
	for i = 0, 12 do
		local weapon = getPedWeapon(player, i)
		if ( weapon > 0 ) then
			local ammo = getPedTotalAmmo(player, i)
			if ammo > 0 then
				weapons[weapon] = ammo
			end
		end
	end
	way2[player] = setTimer(function() end,1000,1)
	local theString = toJSON(weapons)
	if theString == "[ [ ] ]" and (getElementData(player,"fire") == false or getElementData(player,"isPlayerTrading") == false) then
		--outputDebugString(getPlayerName(player).." Had abort on Weapons Saving")
		--	exports.killmessages:outputMessage("Warning: If you had weapons then your weapons didn't save , Please die again (Dont reconnect)",player,255,0,0)
	else
		weaponStringTable[player] = theString
		--outputDebugString(theString)
		--outputDebugString(getPlayerName(player).." saved his Weapons")
		exports.DENmysql:exec("UPDATE accounts SET weapons=? WHERE id=?",theString,exports.server:getPlayerAccountID(player))
	end
	return true
end


addEventHandler("onPlayerWasted",root,function()
	saveWeapons(source)
end)

addEventHandler("onPlayerQuit",root,function()
	if isPedDead(source) then
		return
	end
	saveWeapons(source)
end)