local thePlayers = {}
proTimer = {}
objects = {}
local x, y, z, int, dim = 0, 0, 0, 0, 1000
local isEvent = false
local activeEvent = false
local warpLimit = 0
local warps = 0
local allowedTeam = ""
local players = {}
local frozen = true
local vehGhost = false
local multi = false
local theAdmin = ""
local theEventCreator
local lastPos = {}
addEvent( "onCreateEvent", true )
function createWarp ( eventName,theDimension,theInterior,theLimit,Team )
	if ( isEvent ) then
		exports.NGCdxmsg:createNewDxMessage( source, "There is already a event going, please wait till this event ends or destroy it!", 225, 0, 0 )
	elseif activeEvent then
		exports.NGCdxmsg:createNewDxMessage( source, "There is already a event going, please wait or contact another EM if it's finished!", 225, 0, 0 )
	elseif multi == true then
		exports.NGCdxmsg:createNewDxMessage( source, "There is already a event going, multi warp it's opened!!", 225, 0, 0 )
	else
		setElementDimension( source, theDimension )
		local px, py, pz = getElementPosition( source )

		if ( getElementInterior( source ) ~= theInterior ) then
			setElementInterior( source, theInterior, px, py, pz )
		end
		theAdmin = exports.server:getPlayerAccountName(source)
		theEventCreator = source
		x = px
		y = py
		z = pz
		int = tonumber(theInterior)
		dim = tonumber(theDimension)
		isEvent = true
		warpLimit = tonumber(theLimit)
		warps = 0
		vehGhost = false
		frozen = true
		players = {}
		activeEvent = true
		if Team and Team ~= "Law" then
			allowedTeam = Team
		elseif Team == "Law" then
			allowedTeam = "Law"
		else
			allowedTeam = "All"
		end
		thePlayers = {}
		if isEvent then
			exports.NGCdxmsg:createNewDxMessage(root,"[EVENT] " .. eventName .. " (Team: "..allowedTeam..") (LIMIT: " .. theLimit .. ")",0,255,0)
			exports.NGCdxmsg:createNewDxMessage(root,"(BY: " .. getPlayerName( source ) .. ")",0,255,0)
			exports.NGCdxmsg:createNewDxMessage(root,"Use /eventwarp to participate",0,255,0)
			outputChatBox( "[EVENT] " .. eventName .. " (Team: "..allowedTeam..") (LIMIT: " .. theLimit .. ") (BY: " .. getPlayerName( source ) .. ") Use /eventwarp to participate!", root, 0, 225, 0 )
			exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has created event with playerlimit "..warpLimit.." (EVENT Panel)" )
		end
	end
end
addEventHandler( "onCreateEvent", root, createWarp )


addEvent( "onEMCreateMulti", true )
function onEMCreateMulti ( eventName,theDimension,theInterior,theLimit,Team )
	if ( activeEvent ) then

			setElementDimension( source, theDimension )
			local px, py, pz = getElementPosition( source )

			if ( getElementInterior( source ) ~= theInterior ) then
				setElementInterior( source, theInterior, px, py, pz )
			end
			x = px
			y = py
			z = pz
			theAdmin = exports.server:getPlayerAccountName(source)
			int = tonumber(theInterior)
			dim = tonumber(theDimension)
			isEvent = true
			warpLimit = tonumber(theLimit)
			warps = 0
			if frozen == true then
				frozen = true
			end
			multi = true
			if Team and Team ~= "Law" then
				allowedTeam = Team
			elseif Team == "Law" then
				allowedTeam = "Law"
			else
				allowedTeam = "All"
			end
			if isEvent then
				outputChatBox( "[MULTIWARP] " .. eventName .. " (Team: "..allowedTeam..") (LIMIT: " .. theLimit .. ") (BY: " .. getPlayerName( source ) .. ") Use /eventwarp to participate!", root, 255, 225, 0 )
				exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." created multiwarp event with playerlimit "..warpLimit.." (EVENT Panel)" )
			end
	else
		exports.NGCdxmsg:createNewDxMessage( source, "No event active please do create event instead of multiWarps", 225, 0, 0 )
	end
end
addEventHandler( "onEMCreateMulti", root, onEMCreateMulti )


addEvent( "onDestroyEMEvent", true )
function destroyEMEvent ()
	if ( isEvent ) then
		isEvent = false
		outputChatBox( "Warping to the event is no longer available!", root, 0, 225, 0 )
		frozen = true
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).."  has closed warp to event (EVENT Panel)" )
	end
end
addEventHandler( "onDestroyEMEvent", root, destroyEMEvent )


addEventHandler("onPlayerWasted",root,function()
	if getElementDimension(source) ~= tonumber(dim) then
		lastPos[source] = nil
	end
	if lastPos[source] then
		exports.NGCnote:addNote("EM Pos","You'll return to your old position",source,200,255,0,10000)
	end
	triggerClientEvent(source,"enableWeapons",source)
end)

addEventHandler("onPlayerSpawn",root,function()
	if lastPos[source] then
		exports.NGCnote:addNote("EM Pos","You'll be transport to your old position within 2 seconds!",source,200,255,0,10000)
		setTimer(function(player)
			if player and isElement(player) then
				local px,py,pz = unpack(lastPos[player])
				if px then
					setElementPosition(player,px,py,pz)
					setElementHealth(player,100)
					lastPos[player] = nil
					exports.NGCdxmsg:createNewDxMessage(player,"We have returned you to your old position",255,150,0)
				end
			end
		end,2000,1,source)
	end
end)


-- Get nearst copy
function getNearestCop( thePlayer )
	if ( exports.server:getPlayerAccountName ( thePlayer ) ) then
		local x, y, z = getElementPosition( thePlayer )
		local distance = nil
		local theCopNear = false
		for i, theCop in ipairs ( getElementsByType( "player" ) ) do
			local x1, x2, x3 = getElementPosition( theCop )
			if ( exports.server:getPlayerAccountName ( theCop ) ) then
				if exports.DENlaw:isLaw(theCop) then
					if ( distance ) and ( getDistanceBetweenPoints2D( x, y, x1, x2 ) < distance ) then
						distance = getDistanceBetweenPoints2D( x, y, x1, x2 )
						theCopNear = theCop
					elseif ( getDistanceBetweenPoints2D( x, y, x1, x2 ) < 100 ) then
						distance = getDistanceBetweenPoints2D( x, y, x1, x2 )
						theCopNear = theCop
					end
				end
			end
		end
		return theCopNear
	end
end

addCommandHandler("twarp",
function (thePlayer)
	if ( isEvent ) then
		if exports.CSGstaff:isPlayerEventManager(thePlayer) and exports.CSGstaff:isPlayerStaff(thePlayer) and getTeamName(getPlayerTeam(thePlayer)) == "Staff" or getElementData(thePlayer,"isPlayerPrime") then
			outputChatBox("Total Event Warps: "..warps.."/"..warpLimit, thePlayer, 255, 255, 255)
		end
	end
end)

addCommandHandler("eventwarp",
function ( thePlayer )
	if ( isEvent ) then
		local jx,jy,jz = getElementPosition(thePlayer)
		local jx2,jy2,jz2 = 927.44, -2408.72, 5700.42
		local jailDim = getElementDimension(thePlayer)
		if getElementData(thePlayer,"isPlayerFlagger") then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't join a event while you are holding the armor!",255,0,0)
			return
		end
		if exports.AURgames:isPlayerSigned(thePlayer) then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't join a event while you are signed up in mini games!",255,0,0)
			return
		end
		if jailDim == 2 then
			if getDistanceBetweenPoints3D(jx,jy,jz,jx2,jy2,jz2) < 100 then
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't join a event while jailed!",255,0,0)
				return
			end
		end
		if ( getElementData ( thePlayer, "isPlayerArrested" ) ) or ( getElementData ( thePlayer, "isPlayerRobbing" ) ) or ( getElementData ( thePlayer, "isPlayerJailed" ) ) or ( isPedInVehicle( thePlayer ) ) then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't warp while arrested, jailed or when driving a vehicle!", 225, 0, 0 )
			return
		elseif getElementDimension(thePlayer) ~= 0 then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't warp while you're in another dimension!", 225, 0, 0 )
			return
		elseif getElementData(thePlayer,"isPlayerInCarShop") or getElementData(thePlayer,"shopPosition") then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't warp while you're in car shop!", 225, 0, 0 )
			return
		elseif ( warps >= warpLimit ) then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't warp event is full!", 225, 0, 0 )
			return
		else
			if getPlayerWantedLevel(thePlayer) >= 3 then
				local isCopNear = getNearestCop(thePlayer)
				if isCopNear then
					exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't warp whilte you are being chased by a cop!", 225, 0, 0 )
					return false
				end
			end

			local playerTeam = getTeamName(getPlayerTeam(thePlayer))
			if allowedTeam ~= "All" and allowedTeam ~= "Law" then
				if playerTeam ~= allowedTeam then
					exports.NGCdxmsg:createNewDxMessage( thePlayer, "You can't warp while you're not in the vaild team ("..allowedTeam..")", 225, 0, 0 )
					return
				else

					if not ( thePlayers[thePlayer] ) then
						thePlayers[thePlayer] = thePlayer

					end
					for k,v in ipairs(players) do
						if v == thePlayer then
							return false
						end
					end
					if ( warps >= warpLimit ) then
						isEvent = false
					end
					warps = warps + 1
					table.insert(players,thePlayer)
					if ( warps >= warpLimit ) then
						isEvent = false
						outputChatBox( "The event is now full!", root, 0, 225, 0 )
					end
					local px,py,pz = getElementPosition(thePlayer)
					lastPos[thePlayer] = {px,py,pz}
					if ( getElementInterior( thePlayer ) == int ) then
						setElementPosition( thePlayer, x, y, z )
					else
						setElementInterior( thePlayer, int, x, y, z )
					end
					setElementData(thePlayer,"isPlayerInEvent",true)
					setElementDimension( thePlayer, dim )
					toggleControl(thePlayer,"aim_weapon",false)
					toggleControl(thePlayer,"fire",false)
					outputChatBox("Event Warp: "..warps.."/"..warpLimit, theEventCreator, 255, 255, 255)
					if frozen == true then
						Frozen(true)
					end
				end
			elseif allowedTeam == "Law" then
				if exports.DENlaw:isLaw(thePlayer) then

					if not ( thePlayers[thePlayer] ) then
						thePlayers[thePlayer] = thePlayer
					end

					for k,v in ipairs(players) do
						if v == thePlayer then
							return false
						end
					end
					if ( warps >= warpLimit ) then
						isEvent = false
					end
					warps = warps + 1
					table.insert(players,thePlayer)
					if ( warps >= warpLimit ) then
						isEvent = false
						outputChatBox( "The event is now full!", root, 0, 225, 0 )
					end
					local px,py,pz = getElementPosition(thePlayer)
					lastPos[thePlayer] = {px,py,pz}
					if ( getElementInterior( thePlayer ) == int ) then
						setElementPosition( thePlayer, x, y, z )
					else
						setElementInterior( thePlayer, int, x, y, z )
					end
					setElementData(thePlayer,"isPlayerInEvent",true)
					setElementDimension( thePlayer, dim )

					toggleControl(thePlayer,"aim_weapon",false)
					toggleControl(thePlayer,"fire",false)
					if frozen == true then
						Frozen(true)
					end
					outputChatBox("Event Warp: "..warps.."/"..warpLimit, theEventCreator, 255, 255, 255)
				else
					exports.NGCdxmsg:createNewDxMessage(thePlayer,"You are not Law member, you can't join the event",255,0,0)
				end
			else

				if not ( thePlayers[thePlayer] ) then
					thePlayers[thePlayer] = thePlayer

				end
				for k,v in ipairs(players) do
					if v == thePlayer then
						return false
					end
				end
				if ( warps >= warpLimit ) then
					isEvent = false
				end
				warps = warps + 1
				table.insert(players,thePlayer)
				if ( warps >= warpLimit ) then
					isEvent = false
					outputChatBox( "The event is now full!", root, 0, 225, 0 )
				end
				local px,py,pz = getElementPosition(thePlayer)
				lastPos[thePlayer] = {px,py,pz}
				if ( getElementInterior( thePlayer ) == int ) then
					setElementPosition( thePlayer, x, y, z )
				else
					setElementInterior( thePlayer, int, x, y, z )
				end
				setElementData(thePlayer,"isPlayerInEvent",true)
				setElementDimension( thePlayer, dim )

				toggleControl(thePlayer,"fire",false)
				toggleControl(thePlayer,"aim_weapon",false)
				if frozen == true then
						Frozen(true)
					end
				outputChatBox("Event Warp: "..warps.."/"..warpLimit, theEventCreator, 255, 255, 255)
			end
		end
	else
		exports.NGCdxmsg:createNewDxMessage( thePlayer, "There is no event or the current event is full!", 225, 0, 0 )
	end
end)

addEvent("unFrozen",true)
function unFrozen(state)
	for k,v in ipairs(players) do
		setElementFrozen(v,false)
		toggleControl(v,"aim_weapon",true)
		exports.NGCdxmsg:createNewDxMessage(v,"You have been unfrozen",0,255,0)
		if getElementData(v,"fire") then
			exports.NGCdxmsg:createNewDxMessage(v,"You have been detected as user in F10 , please wait 10 seconds to be able to fire",255,0,0)
			return false
		end
		toggleControl(v,"fire",true)
	end
	frozen = false
	if source and isElement(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"Players have been unfrozen",0,255,0)
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has unfrozen the players (EVENT Panel)" )
	end
end
addEventHandler("unFrozen",root,unFrozen)

addEvent("Frozen",true)
function Frozen(state)
	for k,v in ipairs(players) do
		setElementFrozen(v,true)
		toggleControl(v,"aim_weapon",false)
		toggleControl(v,"fire",false)
		exports.NGCdxmsg:createNewDxMessage(v,"You have been frozen",255,0,0)
	end
	if source and isElement(source) then
		exports.NGCdxmsg:createNewDxMessage(source,"Players have been frozen",255,0,0)
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has frozen the players (EVENT Panel)" )
	end
	frozen = true
end
addEventHandler("Frozen",root,Frozen)

addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"isPlayerInEvent") then
		for k,v in ipairs(players) do
			if source == v then
				table.remove(players,k)
				setElementDimension(source,0)
				addProTimer(source)
				break
			end
		end
		if #players == 0 then
			stopEvent()
		end
	end
end)

function addProTimer(p)
	triggerClientEvent(p,"enableWeapons",p)
	if isTimer(proTimer[p]) then killTimer(proTimer[p]) end
	proTimer[p] = setTimer(function(pp)
		setElementData(p,"isPlayerInEvent",false)
	end,5000,1,p)
end

addEventHandler("onPlayerWasted",root,function()
	if getElementData(source,"isPlayerInEvent") then
		for k,v in ipairs(players) do
			if source == v then
				table.remove(players,k)
				addProTimer(source)
				break
			end
		end
		if #players == 0 then
			stopEvent()
		end
	end
end)

addEventHandler("onPlayerSetArrested",root,function()
	if getElementData(source,"isPlayerInEvent") then
		for k,v in ipairs(players) do
			if source == v then
				table.remove(players,k)
				addProTimer(source)
				break
			end
		end
		if #players == 0 then
			stopEvent()
		end
	end
end)

addEventHandler("onSetPlayerJailed",root,function()
	if getElementData(source,"isPlayerInEvent") then
		for k,v in ipairs(players) do
			if source == v then
				table.remove(players,k)
				addProTimer(source)
				break
			end
		end
		if #players == 0 then
			stopEvent()
		end
	end
end)

addEvent("onDisableFire",true)
addEventHandler("onDisableFire",root,function(acc)
	if exports.server:getPlayerAccountName(source) == theAdmin then
		for k,v in ipairs(players) do
			toggleControl(v,"aim_weapon",false)
			toggleControl(v,"fire",false)
			exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has disabled fire & aim",255,255,0)
		end
		exports.NGCdxmsg:createNewDxMessage(source,"Fire has been disabled",255,255,0)
	end
end)
addEvent("onToggleDM",true)
addEventHandler("onToggleDM",root,function(acc,state)
	if exports.server:getPlayerAccountName(source) == theAdmin then
		for k,v in ipairs(players) do
			if state == true then
				exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has enabled ANTI DM",255,255,0)
			else
				exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has disabled ANTI DM",255,255,0)
			end
		end
		if state == true then
			exports.NGCdxmsg:createNewDxMessage(source,"Anti DM enabled",255,255,0)
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Anti DM disabled",255,255,0)
		end
		triggerClientEvent("toggleANTIDM",root,players,state)
	end
end)
addEvent("onToggleGhost",true)
addEventHandler("onToggleGhost",root,function(acc,state)
	if exports.server:getPlayerAccountName(source) == theAdmin then
		for k,v in ipairs(players) do
			if state == true then
				exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has enabled Ghost mode",255,255,0)
			else
				exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has disabled Ghost mode",255,255,0)
			end
		end
		if state == true then
			exports.NGCdxmsg:createNewDxMessage(source,"Ghost mode enabled",255,255,0)
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Ghost mode disabled",255,255,0)
		end
		triggerClientEvent("toggleGhost",root,players,state)
	end
end)

addEvent("onToggleVehGhost",true)
addEventHandler("onToggleVehGhost",root,function(acc,state)
	if exports.server:getPlayerAccountName(source) == theAdmin then
		for k,v in ipairs(players) do
			if state == true then
				exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has enabled Veh Ghost mode",255,255,0)
			else
				exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has disabled Veh Ghost mode",255,255,0)
			end
		end
		if state == true then
			exports.NGCdxmsg:createNewDxMessage(source,"Veh Ghost mode enabled",255,255,0)
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Veh Ghost mode disabled",255,255,0)
		end
		vehGhost = state
		for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
			triggerClientEvent("addVehGhost",root,v,vehGhost)
		end
	end
end)

addEvent("onEnableFire",true)
addEventHandler("onEnableFire",root,function(acc)
	outputDebugString(theAdmin)
	if exports.server:getPlayerAccountName(source) == theAdmin then
		for k,v in ipairs(players) do
			toggleControl(v,"aim_weapon",true)
			toggleControl(v,"fire",true)
			exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has enabled fire & aim",255,255,0)
		end
		exports.NGCdxmsg:createNewDxMessage(source,"Fire has been enabled",255,255,0)
	end
end)

addEvent("onEnableWeapons",true)
addEventHandler("onEnableWeapons",root,function(acc)
	outputDebugString(theAdmin)
	if exports.server:getPlayerAccountName(source) == theAdmin then
		for k,v in ipairs(players) do
			triggerClientEvent(v,"enableWeapons",v)
			exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has enabled the weapons",255,255,0)
		end
		exports.NGCdxmsg:createNewDxMessage(source,getPlayerName(source).." enabled the weapons",255,255,0)
	end
end)

addEvent("onDisableWeapons",true)
addEventHandler("onDisableWeapons",root,function(acc)
	outputDebugString(theAdmin)
	if exports.server:getPlayerAccountName(source) == theAdmin then
		for k,v in ipairs(players) do
			triggerClientEvent(v,"disableWeapons",v)
			exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has disabled the weapons",255,255,0)
		end
		exports.NGCdxmsg:createNewDxMessage(source,getPlayerName(source).." disabled the weapons",255,255,0)
	end
end)

addEvent("onSetAllowedWeapons",true)
addEventHandler("onSetAllowedWeapons",root,function(accName,wepsTable)
	outputDebugString(theAdmin)
	if accName == theAdmin then
		for k,v in ipairs(players) do
			triggerClientEvent(v,"setWeapons",v,wepsTable)
			exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(source).." has changed allowed/disallowed weapons",255,255,0)
		end
		exports.NGCdxmsg:createNewDxMessage(source,"Your weapon rules have been sent to event players",255,255,0)
	end
end)
holdOn = {}
addEvent("stopEvent",true)
function stopEvent(who)
	if ( activeEvent ) then
		for k,v in pairs(players) do
			triggerClientEvent(v,"enableWeapons",v)
			killPed(v)
			setElementFrozen(v,false)
			toggleControl(v,"aim_weapon",true)
			toggleControl(v,"fire",true)
			exports.NGCdxmsg:createNewDxMessage(v,"[Event] : You have been killed by the system (Admin stopped the event)",255,0,0)
		end
		if isTimer(holdOn) then
			return false
		end
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v,"isPlayerInEvent") then
				killPed(v)
				toggleControl(v,"aim_weapon",true)
				toggleControl(v,"fire",true)
			end
		end
		outputDebugString("Event Destroyed")
		holdOn = setTimer(function()
		multi = false
		thePlayers = {}
		players = {}
		x, y, z, int = 0, 0, 0, 0
		warpLimit = 0
		theAdmin = {}
		warps = 0
		vehGhost = false
		allowedTeam = ""
		frozen = true
		isEvent = false
		theEventCreator = false
		activeEvent = false
		if who then
			outputChatBox("Event has been suspended by "..getPlayerName(who),root,255,0,0)
		end
		if who and isElement(source) then
			exports.CSGlogging:createAdminLogRow( who, getPlayerName( who ).."  has stopped the event (EVENT Panel)" )
		end
		end,2000,1)
	else
		if who then
			exports.NGCdxmsg:createNewDxMessage(who,"There is no event active",255,0,0)
		end
	end
end
addEventHandler("stopEvent",root,stopEvent)

addEvent("stopEventWithoutKill",true)
function stopEventWithoutKill(who)
	if ( activeEvent ) then
		for k,v in pairs(players) do
			toggleControl(v,"aim_weapon",true)
			toggleControl(v,"fire",true)
			triggerClientEvent(v,"enableWeapons",v)
			exports.NGCdxmsg:createNewDxMessage(v,"[Event] : You have been ejected from event system (Admin ejected you)",255,0,0)
		end
		if isTimer(holdOn) then
			return false
		end
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v,"isPlayerInEvent") then
				triggerClientEvent(v,"enableWeapons",v)
				setElementData(v,"isPlayerInEvent",false)
				setElementFrozen(v,false)
				toggleControl(v,"aim_weapon",true)
				toggleControl(v,"fire",true)
			end
		end
		holdOn = setTimer(function()
		multi = false
		thePlayers = {}
		players = {}
		x, y, z, int = 0, 0, 0, 0
		warpLimit = 0
		theAdmin = {}
		warps = 0
		vehGhost = false
		allowedTeam = ""
		frozen = true
		isEvent = false
		activeEvent = false
		if who then
			outputChatBox("Event has been suspended (Players ejected) by "..getPlayerName(who),root,255,0,0)
		end
		if who and isElement(source) then
			exports.CSGlogging:createAdminLogRow( who, getPlayerName( who ).."  has stopped (Ejected) the event (EVENT Panel)" )
		end
		end,2000,1)
	else
		if who then
			exports.NGCdxmsg:createNewDxMessage(who,"There is no event active",255,0,0)
		end
	end
end
addEventHandler("stopEventWithoutKill",root,stopEventWithoutKill)


addEvent( "onGiveEventMoney", true )
function sendPlayerEventMoney ( thePlayer, theMoney )
	if ( isElement ( thePlayer ) ) then
		if ( theMoney > 50000 ) then
			exports.NGCdxmsg:createNewDxMessage( source, "Server refused to give more the $50,000 a report has been sent to a L6 staff", 225, 0, 0 )
			exports.CSGlogging:createAdminLogRow (source,getPlayerName(source).."  has tried to send $"..theMoney.." to "..getPlayerName(thePlayer).." ("..exports.server:getPlayerAccountName(thePlayer)..") (EVENT Panel)")
		else
			exports.CSGlogging:createAdminLogRow (source,getPlayerName(source).." has sent $"..theMoney.." to "..getPlayerName(thePlayer).." ("..exports.server:getPlayerAccountName(thePlayer)..") (EVENT Panel)")
			--exports.NGCmanagement:GPM( thePlayer, theMoney,"DAWN EVENTS","admin gave him reward" )
			exports.AURpayments:addMoney(thePlayer,theMoney,"Custom","Event",0,"NGCEvents")
			exports.NGCdxmsg:createNewDxMessage( source, "You sent $" .. theMoney .. " to "..getPlayerName( thePlayer ), 0, 255, 0 )
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "You recieved $" .. theMoney .. " from a event! By: "..getPlayerName( source ), 0, 255, 0 )
		end
	end
end
addEventHandler( "onGiveEventMoney", root, sendPlayerEventMoney )


addEvent("giveEventScore",true)
addEventHandler("giveEventScore",root,function(thePlayer,score)
	if score and tonumber(score) > 50 then
		exports.NGCdxmsg:createNewDxMessage( source, "Server refused to give more the 50 scores a report has been sent to a L6 staff", 225, 0, 0 )
		exports.CSGlogging:createAdminLogRow (source,getPlayerName(source).." has tried to send "..score.." scores to "..getPlayerName(thePlayer).." ("..exports.server:getPlayerAccountName(thePlayer)..") (EVENT Panel)")
	else
		exports.NGCdxmsg:createNewDxMessage(thePlayer,"Event: You have been rewarded "..score.." score!",0,255,0)
		exports.CSGscore:givePlayerScore(thePlayer,score)
		exports.CSGlogging:createAdminLogRow (source,getPlayerName(source).." has sent "..score.." scores to "..getPlayerName(thePlayer).." ("..exports.server:getPlayerAccountName(thePlayer)..") (EVENT Panel)")
	end
end)

addEvent("countForTheEvent",true)
addEventHandler("countForTheEvent",root,function()
	triggerClientEvent(source,"drawEventCount",source)
	for k,v in ipairs(players) do
		triggerClientEvent(v,"drawEventCount",v)
	end
end)



---- Event vehicles
local eventVehicleMarker = {}
local markerData = {}
local markerCreator = {}
local eventVehicles = {}
local createTick = nil

-- Create a marker with vehicles
addEvent( "onEMVehicleMarker", true )
function createEventVehicleMarker ( theVehicleName )
	local creatorAccount = exports.server:getPlayerAccountName( source )
    if not ( getVehicleModelFromName( theVehicleName ) ) then
		exports.NGCdxmsg:createNewDxMessage( source, "There is no vehicle found with this name!", 225, 0, 0 )
	elseif ( creatorAccount ) then
		if ( isElement( eventVehicleMarker[creatorAccount] ) ) then destroyElement( eventVehicleMarker[creatorAccount] ) end
        local x, y, z = getElementPosition( source )
        eventVehicleMarker[creatorAccount] = createMarker( x, y, z - 1, "cylinder", 1.5, 0,255,0, 150 )
		setElementDimension( eventVehicleMarker[creatorAccount], getElementDimension( source ) )
        local theVehicleModel = getVehicleModelFromName( theVehicleName )
        if not ( theVehicleModel ) then
			exports.NGCdxmsg:createNewDxMessage( source, "There is no vehicle found with this name!", 225, 0, 0 )
		else
			createTick = getTickCount()
			markerData[eventVehicleMarker[creatorAccount]] = theVehicleModel
			markerCreator[eventVehicleMarker[creatorAccount]] = creatorAccount
			setElementInterior( eventVehicleMarker[creatorAccount], getElementInterior( source ) )
			addEventHandler( "onMarkerHit", eventVehicleMarker[creatorAccount], hitVehicleEMMarker )
			exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has created vehicle marker (EVENT Panel)" )
		end
	end
end
addEventHandler( "onEMVehicleMarker", root, createEventVehicleMarker )


-- Delete all the vehicles create by a marker
addEvent( "onDestroyEMVehicles", true )
function destroyEMMarkerVehicles ( theCreator )
	if ( eventVehicles[theCreator] ) then
		for i, theElement in ipairs ( eventVehicles[theCreator] ) do
			if ( isElement( theElement ) ) then
				destroyElement( theElement )
				exports.NGCdxmsg:createNewDxMessage(source,"You have destroyed Event vehicles",255,255,0)
			end
		end
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has destroyed vehicles (EVENT Panel)" )
	end
	eventVehicles[theCreator] = {}
end
addEventHandler( "onDestroyEMVehicles", root, destroyEMMarkerVehicles )

addEvent( "onFixEMVehicles", true )
function onFixEMVehicles ( theCreator )
	if ( eventVehicles[theCreator] ) then
		for i, theElement in ipairs ( eventVehicles[theCreator] ) do
			if ( isElement( theElement ) ) then
				fixVehicle(theElement)
				exports.NGCdxmsg:createNewDxMessage(source,"You have fixed Event vehicles",255,255,0)
			end
		end
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has fixed vehicles (EVENT Panel)" )
	end
end
addEventHandler( "onFixEMVehicles", root, onFixEMVehicles )


addEvent( "onBlowEMVehicles", true )
function onBlowEMVehicles ( theCreator )
	if ( eventVehicles[theCreator] ) then
		for i, theElement in ipairs ( eventVehicles[theCreator] ) do
			if ( isElement( theElement ) ) then
				blowVehicle(theElement)
				exports.NGCdxmsg:createNewDxMessage(source,"You have blowed Event vehicles",255,255,0)
			end
		end
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has fixed vehicles (EVENT Panel)" )
	end
end
addEventHandler( "onBlowEMVehicles", root, onBlowEMVehicles )


addEvent( "freezeEMVehicles", true )
function freezeEMVehicles ( theCreator )
	if ( eventVehicles[theCreator] ) then
		for i, theElement in ipairs ( eventVehicles[theCreator] ) do
			if ( isElement( theElement ) ) then
				setElementFrozen(theElement,true)
			end
		end
		exports.NGCnote:addNote("EM","You have frozen event vehicles",source,255,0,0)
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has frozen vehicles (EVENT Panel)" )
	end
end
addEventHandler( "freezeEMVehicles", root, freezeEMVehicles )

addEvent( "unfreezeEMVehicles", true )
function unfreezeEMVehicles ( theCreator )
	if ( eventVehicles[theCreator] ) then
		for i, theElement in ipairs ( eventVehicles[theCreator] ) do
			if ( isElement( theElement ) ) then
				setElementFrozen(theElement,false)
			end
		end
		exports.NGCnote:addNote("EM","You have un-frozen event vehicles",source,255,255,0)
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has unfrozen vehicles (EVENT Panel)" )
	end
end
addEventHandler( "unfreezeEMVehicles", root, unfreezeEMVehicles )

-- Destroy the marker
addEvent( "onDestroyEMVehicleMarker", true )
function destroyEMMarkerVehicleMarker ( theCreator )
	if ( isElement( eventVehicleMarker[theCreator] ) ) then
		removeEventHandler( "onMarkerHit", eventVehicleMarker[theCreator], hitVehicleEMMarker )
		destroyElement( eventVehicleMarker[theCreator] )
		exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has destroyed vehicles marker (EVENT Panel)" )
	end
	if ( eventVehicleMarker[theCreator] ) then eventVehicleMarker[theCreator] = {} end
end
addEventHandler( "onDestroyEMVehicleMarker", root, destroyEMMarkerVehicleMarker )


-- When the player hits a marker for vehicles
function hitVehicleEMMarker ( theElement, matchingDimension )
	if ( matchingDimension ) then
		if ( createTick ) and ( getTickCount()-createTick < 3000 ) then
			return
		else
			if ( getElementType ( theElement ) == "player" ) and not ( isPedInVehicle( theElement ) ) then
				local theModel = markerData[source]
				local theCreator = markerCreator[source]
				if ( theModel ) and ( theCreator ) then
					local x, y, z = getElementPosition( source )
					local theVehicle = createVehicle( theModel, x, y, z +2 )
					setElementDimension( theVehicle, getElementDimension( source ) )
					setElementInterior( theVehicle, getElementInterior( source ) )
					warpPedIntoVehicle( theElement, theVehicle )
					triggerClientEvent("addVehGhost",root,theVehicle,vehGhost)
					if not ( eventVehicles[theCreator] ) then eventVehicles[theCreator] = {} end
					table.insert( eventVehicles[theCreator], theVehicle )
					exports.CSGlogging:createAdminLogRow ( theElement, getPlayerName(theElement).." picked a " .. getVehicleNameFromModel ( theModel ) .." from an event marker (EVENT PANEL)")
				end
			end
		end
	end
end


-- Create pickup
local eventPickups = {}

addEvent( "onCreateEMPickup", true )
function createEventSPickup ( theType )
	local creatorAccount = exports.server:getPlayerAccountName( source )
	if ( isElement ( source ) ) and ( creatorAccount ) then
		local x, y, z = getElementPosition( source )
		if ( string.lower(theType) == "health" ) then
			if ( eventPickups[creatorAccount] ) and ( isElement( eventPickups[creatorAccount] ) ) then destroyElement( eventPickups[creatorAccount] ) eventPickups[creatorAccount] = {} end
			eventPickups[creatorAccount] = createPickup ( x, y, z, 0, 100, 0 )
			setElementDimension( eventPickups[creatorAccount], getElementDimension( source ) )
			setElementInterior( eventPickups[creatorAccount], getElementInterior( source ) )
			exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." created a health pickup (EVENT PANEL)" )
		elseif ( string.lower(theType) == "armor" ) then
			if ( eventPickups[creatorAccount] ) and ( isElement( eventPickups[creatorAccount] ) ) then destroyElement( eventPickups[creatorAccount] ) eventPickups[creatorAccount] = {} end
			eventPickups[creatorAccount] = createPickup ( x, y, z, 1, 100, 0 )
			setElementDimension( eventPickups[creatorAccount], getElementDimension( source ) )
			setElementInterior( eventPickups[creatorAccount], getElementInterior( source ) )
			exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." created an armor pickup (EVENT PANEL)" )
		else
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "Wrong pickup model! (Use: health or armor)", 225, 0, 0 )
		end
	end
end
addEventHandler( "onCreateEMPickup", root, createEventSPickup )

-- Destroy pickup
addEvent( "onDestroyEMPickup", true )
function destroyEventsPickup ()
	local creatorAccount = exports.server:getPlayerAccountName( source )
	if ( isElement ( source ) ) and ( creatorAccount ) then
		if ( eventPickups[creatorAccount] ) and ( isElement( eventPickups[creatorAccount] ) ) then
			exports.CSGlogging:createAdminLogRow( source, getPlayerName( source ).." has destroyed a pickup (EVENT PANEL)" )
			destroyElement( eventPickups[creatorAccount] )
			eventPickups[creatorAccount] = {}
		end
	end
end
addEventHandler( "onDestroyEMPickup", root, destroyEventsPickup )

----------------

addEvent("onEMCreateObject",true)
addEventHandler("onEMCreateObject",root,function(id, x, y, z, rx, ry, rz, dim, int)
	if getTeamName(getPlayerTeam(source)) == "Staff" then
		if (not id) then return end
		if (id == 1225 and dim == 0) then
			outputChatBox("Explosive barrels can not be placed in main dimension", client, 255, 0, 0)
			return
		end
		if (id == 978) then
			z = z-1
		end
		local accName = exports.server:getPlayerAccountName(client)
		local object = createObject(tonumber(id), x, y, z, rx, ry, rz)
		setElementDoubleSided(object, true)
		setElementFrozen(object, true)
		setElementData(object, "creator", accName)
		objects[object] = {object, exports.server:getPlayerAccountName(client)}
		if (tonumber(dim) ~= 0) then
			setElementDimension(object, dim)
		end
		if (tonumber(int) ~= 0) then
			setElementInterior(object, int)
		end
		if (id ~= 1225) then
			triggerClientEvent(client, "nobreak", client, object)
		end
		triggerClientEvent("callBackEventObjects",root)
		exports.NGCdxmsg:createNewDxMessage(source,"You have created a new object",255,0,0)
	end
end)

addEvent("onEMDeleteAllObject",true)
addEventHandler("onEMDeleteAllObject",root,function()
	for k, v in pairs(objects) do
		if isElement(v[1]) then destroyElement(v[1]) end
	end
	objects = {}
	triggerClientEvent("callBackEventObjects",root)
	exports.NGCdxmsg:createNewDxMessage(source,"You have removed all the objects",255,0,0)
end)

addEvent("onEMDeleteObject",true)
addEventHandler("onEMDeleteObject",root,function()
	for k, v in pairs(objects) do
		if (v[2] == exports.server:getPlayerAccountName(client)) then
			if (isElement(v[1])) then
				if isElement(v[1]) then destroyElement(v[1]) end
				v = nil
			end
		end
	end
	triggerClientEvent("callBackEventObjects",root)
	exports.NGCdxmsg:createNewDxMessage(source,"You have removed your objects",255,0,0)
end)

addEvent("EMDestroyObject",true)
addEventHandler("EMDestroyObject",root,function(rb)
	local creator, x, y, z, dim, int, id
	for k, v in pairs(objects) do
		if (v[1] == rb) then
			x, y, z = getElementPosition(v[1])
			dim = getElementDimension(v[1])
			int = getElementInterior(v[1])
			id = getElementModel(v[1])
			if isElement(v[1]) then destroyElement(v[1]) end
			creator = v[2]
			v[1] = nil
		end
	end
	triggerClientEvent("callBackEventObjects",root)
	exports.NGCdxmsg:createNewDxMessage(source,"You have removed your objects",255,0,0)
end)

