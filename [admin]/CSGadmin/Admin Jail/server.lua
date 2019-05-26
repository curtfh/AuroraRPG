-- Release points for the jail
local jailPoints = {
["LS1"] = {1535.93, -1670.89, 13},
["LS2"] = {638.95, -571.69, 15.81},
["LS3"] = {-2166.05, -2390.38, 30.04},
["SF1"] = {-1606.34, 724.44, 11.53},
["SF2"] = {-1402.04, 2637.7, 55.25},
["LV1"] = {2290.46, 2416.55, 10.3},
["LV2"] = {-208.63, 978.9, 18.73},
["FBI"] = {891.59, -2372.36, 13.27},
}

-- Jailed players
local jailTable = {}
local x = {}
function count()
	x = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerJailed") then
			table.insert(x,v)
			break
		end
	end
	for k,v in ipairs(x) do
		triggerClientEvent(v,"countJailed",v,k)
	end
end
-- Function to jail a player
function setPlayerJailed ( theAdmin, thePlayer, theReason, theTime, thePlace, multiplier, hidden )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	--thePlace = "FBI"

	if ( isElement( thePlayer ) ) and ( userID ) and ( theTime ) then -- and ( thePlace ) then
		if thePlace and thePlace == "LV1" and getTeamName(getPlayerTeam(thePlayer)) == "Criminals" then
			thePlace = "LV1"
		else
			thePlace = "FBI"
		end
		if not ( thePlace ) then
			thePlace = "FBI"
		end

		local multiplier = (multiplier and 1 or 0)
		local highestPunishment = 5

		if (multiplier == 1) then
			local accPunishments = exports.DENmysql:query( "SELECT * FROM punishlog WHERE userid=? AND multiplier=? AND active=?", exports.server:getPlayerAccountID( thePlayer ), 1, 1 )
			for i, v in ipairs(accPunishments) do
				if (v['punishment']:find(" jailed ")) then
					local punishmentTime = string.match(v['punishment'], "%d+")
					if (tonumber(punishmentTime) > highestPunishment) then
						highestPunishment = tonumber(punishmentTime)
					end
				end
			end
			if (highestPunishment == 5) then
				theTime = (5 * 60)
			else
				theTime = math.floor((highestPunishment * 60) * 2)
			end
		end

		-- Jail the player and insert into database
		if ( isPlayerJailed ( thePlayer ) ) and ( theAdmin ) then
			exports.DENmysql:exec( "UPDATE jail SET userid=?, jailtime=?", userID, ( theTime + getElementData( thePlayer, "jailTimeRemaining" ) ) )
			triggerClientEvent( thePlayer, "onSetPlayerJailed", thePlayer, ( theTime + getElementData( thePlayer, "jailTimeRemaining" ) ) )
			togglePlayerControls ( thePlayer, false )
			
		else
			if ( theAdmin ) then
				local wantedPoints = getElementData( thePlayer, "wantedPoints" )
				theActualTime = ( math.floor( tonumber( wantedPoints ) * 100 / 26 ) ) + ( theTime )

			else
				theActualTime = theTime
			end

			setElementData(thePlayer,"jailpos",thePlace)
			if not ( exports.DENmysql:querySingle( "SELECT * FROM jail WHERE userid=? LIMIT 1", userID ) ) then
				exports.DENmysql:exec( "INSERT INTO jail SET userid=?, jailtime=?, jailplace=?", userID, theActualTime, thePlace )
			else
				exports.DENmysql:exec( "UPDATE jail SET jailtime=?,jailplace=? WHERE userid=?", theActualTime,thePlace, userID )
			end

			triggerClientEvent( thePlayer, "onSetPlayerJailed", thePlayer, theActualTime )
			togglePlayerControls ( thePlayer, false )
			jailTable[thePlayer] = thePlace
		end
		count()
		triggerEvent( "onServerPlayerJailed", thePlayer, theActualTime )
		triggerEvent( "onPlayerJailed", thePlayer, theActualTime )
--632.11, -3064.33, 12
		removePedFromVehicle( thePlayer )
		--setElementPosition ( thePlayer, 632.11 + math.random(0.1,2.0),-3064.33 + math.random(0.1,2.0),12 )
		----exports.NGCjailBreak:setPlayerJailed(thePlayer,theActualTime)
		setElementRotation ( thePlayer, 0, 0, 183 )
		setElementDimension( thePlayer, 2 )
		if getElementData( thePlayer, "isPlayerEvent",true) then
		setElementData( thePlayer, "isPlayerEvent",false)
		end
		triggerEvent("setPlayerJailedInNewJail",thePlayer,thePlayer,theActualTime)
		if ( getElementInterior( thePlayer ) ~= 0 ) then setElementInterior( thePlayer, 0, getElementPosition( thePlayer ) ) end
		-- Output etc.
		local plr = ""
		if (hidden) then
			plr = "hidden player"
		else
			plr = getPlayerName(thePlayer)
		end
		if ( theReason ) and ( theAdmin ) then
			outputChatBox( getPlayerName( theAdmin ).." jailed " .. plr .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")", root, 255, 0, 0 )
			exports.server:setPlayerWantedPoints(thePlayer,0)
			triggerEvent( "onAdminPunishment", theAdmin, getPlayerName( theAdmin ).." jailed " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
			exports.DENmysql:exec( "INSERT INTO punishlog SET userid=?, serial=?, punishment=?", userID, getPlayerSerial( thePlayer ), getPlayerName( theAdmin ).." jailed " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
			exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." jailed " .. getPlayerName( thePlayer ) .. " for " .. math.floor(theTime/60).. " minutes (" .. theReason .. ")" )
		end
	end
end

addEvent("onPlayerEscape",true)
addEventHandler("onPlayerEscape",root,function()
	local thePlayer = source
	local userID = exports.server:getPlayerAccountID( thePlayer )
	exports.DENmysql:exec( "DELETE FROM jail WHERE userid=?", userID )
	setElementData(thePlayer,"isPlayerJailed",false,true)
	setElementData(thePlayer,"jailpos",false)
	jailTable[thePlayer] = false
	triggerEvent( "onPlayerJailReleased", thePlayer )
	triggerEvent("releaseMeFromJail",thePlayer)
	togglePlayerControls ( thePlayer, true )
	if isTimer(antiBug[thePlayer]) then killTimer(antiBug[thePlayer]) end
	count()
end)


antiBug = {}
-- Function to unjail a player
addEvent( "onAdminUnjailPlayer", true )
function removePlayerJailed ( thePlayer, theAdmin )
	local userID = exports.server:getPlayerAccountID( thePlayer )
	if ( jailTable[thePlayer] ) and ( isPlayerJailed ( thePlayer ) ) and ( userID ) then
		exports.DENmysql:exec( "DELETE FROM jail WHERE userid=?", userID )
		triggerClientEvent( thePlayer, "onRemovePlayerJail", thePlayer )
		togglePlayerControls ( thePlayer, true )
		local x, y, z = jailPoints[jailTable[thePlayer]][1], jailPoints[jailTable[thePlayer]][2], jailPoints[jailTable[thePlayer]][3]
		setElementPosition ( thePlayer, x + math.random(0.1,2.0), y + math.random(0.1,2.0), z )
		setElementRotation ( thePlayer, 0, 0, 183.27947998047 )
		setElementDimension( thePlayer, 0 )
		setElementData( thePlayer, "wantedPoints", 0 )
		setElementData(thePlayer,"isPlayerAdminJailed",false)
		setElementData(thePlayer,"isPlayerJailed",false,true)
		setElementData(thePlayer,"jailpos",false)
		setPlayerWantedLevel( thePlayer, 0 )
		if ( getElementInterior( thePlayer ) ~= 0 ) then setElementInterior( thePlayer, 0, getElementPosition( thePlayer ) ) end
		if ( theAdmin ) then exports.CSGlogging:createAdminLogRow ( theAdmin, getPlayerName( theAdmin ).." unjailed "..getPlayerName( thePlayer ) ) end
		jailTable[thePlayer] = false
		triggerEvent( "onPlayerJailReleased", thePlayer )
		triggerEvent("releaseMeFromJail",thePlayer)
		if isTimer(antiBug[thePlayer]) then return false end
		antiBug[thePlayer] = setTimer(setElementData,3000,1,thePlayer,"wantedPoints",0)
		count()
	else
		local ja = getElementData(thePlayer,"jailpos")
		if ja then
			x,y,z = jailPoints[ja][1], jailPoints[ja][2],jailPoints[ja][3]
		else
			x,y,z = 891.59, -2372.36, 13.27
		end
		setElementPosition ( thePlayer, x + math.random(0.1,2.0), y + math.random(0.1,2.0), z )
		setElementRotation ( thePlayer, 0, 0, 183.27947998047 )
		setElementDimension( thePlayer, 0 )
		togglePlayerControls ( thePlayer, true )
		setElementData(thePlayer,"isPlayerJailed",false,true)
		setElementData(thePlayer,"jailpos",false)
		setElementData(thePlayer,"isPlayerAdminJailed",false)
		triggerEvent( "onPlayerJailReleased", thePlayer )
		triggerEvent("releaseMeFromJail",thePlayer)
		if isTimer(antiBug[thePlayer]) then return false end
		antiBug[thePlayer] = setTimer(setElementData,3000,1,thePlayer,"wantedPoints",0)
		count()
	end
end
addEventHandler( "onAdminUnjailPlayer", root, removePlayerJailed )

-- Function to get the jail type of a player
function isPlayerJailed ( thePlayer )
	if ( jailTable[thePlayer] ) then
		return true, jailTable[thePlayer]
	else
		return false
	end
end

-- Disabled or enable the controls
function togglePlayerControls ( thePlayer, state )
	if ( thePlayer ) then
		toggleControl ( thePlayer, "fire", state )
		toggleControl ( thePlayer, "next_weapon", state )
		toggleControl ( thePlayer, "previous_weapon", state )
		toggleControl ( thePlayer, "aim_weapon", state )
	end
end
--[[
-- When the player quit we want to save the jail time
addEventHandler( "onPlayerQuit", root,
function ()
	if ( isPlayerJailed( source ) ) then
		exports.DENmysql:exec( "UPDATE jail SET jailtime=? WHERE userid=?", getElementData( source, "jailTimeRemaining" ), exports.server:getPlayerAccountID( source ) )
	end
end
)]]

addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"isPlayerJailed") == true then
	local wp = getElementData( source, "jailTimeRemaining" )
		--exports.DENmysql:exec( "UPDATE jail SET userid=?, jailtime=?", userID, jailTimeRemaining )
		exports.DENmysql:exec( "UPDATE jail SET jailtime=? WHERE userid=?", wp, exports.server:getPlayerAccountID( source ) )
	end
	if isTimer(antiBug[source]) then killTimer(antiBug[source]) end
	count()
end)


addEventHandler("onPlayerCommand",root,
function(cmd)
	if cmd == "reconnect" then
		local wp = getElementData( source, "jailTimeRemaining" )
		if wp and tonumber(wp) > 0 then
			exports.DENmysql:exec( "UPDATE jail SET jailtime=? WHERE userid=?", wp, exports.server:getPlayerAccountID( source ) )
		end
		if isTimer(antiBug[source]) then killTimer(antiBug[source]) end
	end
end)



-- When a player login
addEvent( "onServerPlayerLogin" )
addEventHandler( "onServerPlayerLogin", root,
	function ()
		local jailTable = exports.DENmysql:querySingle( "SELECT * FROM jail WHERE userid=? LIMIT 1", exports.server:getPlayerAccountID( source ) )
		if ( jailTable ) then
			setPlayerJailed ( false, source, false, jailTable.jailtime, jailTable.jailplace )
			setElementData( source, "jailTimeRemaining",jailTable.jailtime )
			if getElementData(source,"wantedPoints") < 10 then
				setElementData(source,"isPlayerAdminJailed",true)
			end
			count()
		end
	end
)
