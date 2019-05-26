--[[-- make lag
setTimer (
	function ()
		for k, thePlayer in pairs ( getElementsByType( "player" ) ) do
			setPlayerNametagText( thePlayer, getPlayerName( thePlayer ).." (" .. tostring( getPlayerWantedLevel ( thePlayer ) ) .. ")" )
		end
	end, 5000 , 0
)
]]
antiSpam = {}
tazerAssists = {}
cuffs = {}
cuffTimer = {}
cuffTimer2 = {}

ArrestTimer = {}
attempts = {}
heals = {}
addEvent("updatePlayerWantedPointTag",true)
addEventHandler("updatePlayerWantedPointTag",root,function()
	setPlayerNametagText( source, getPlayerName( source ).." (" .. tostring( getPlayerWantedLevel ( source ) ) .. ")" )

end)
--[[
help = {}
function nickChangeHandler(oldNick, newNick)
	if help[source] and isTimer(help[source]) then return false end
		help[source] = setTimer(function(p)
			if p and isElement(p) then
				setPlayerNametagText( p, getPlayerName( p ).." (" .. tostring( getPlayerWantedLevel ( p ) ) .. ")" )
			end
		end,3000,1,source)
end
addEventHandler("onPlayerChangeNick", getRootElement(), nickChangeHandler)
]]


addEvent("onPlayerTargetLossWanted",true)
addEventHandler( "onPlayerTargetLossWanted", root, function(t)
	--setElementHealth(t,20)
end)


function targetingActivated ( target )
	if source == localPlayer then
		if target and isElement(target) and getElementType ( target ) == "player" then
			if not isPedInVehicle(target) and not isPedInVehicle(source) then
				if isLaw(source) then
					if getPedWeapon(source) == 23 or getPedWeapon(source) == 3 then
						if getPedControlState(source,"fire") or getPedControlState(source,"aim_weapon") then
							if getElementHealth(target) <= 10 then
								setElementHealth(target,20)
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerTarget", getRootElement(), targetingActivated )


addEventHandler( "onElementDataChange", root,
	function ( dataName )
		if ( exports.server:getPlayerAccountName ( source ) ) then
			if ( dataName == "wantedPoints" ) then
				local wantedPoints = getElementData ( source, dataName )
				if ( wantedPoints > 9 ) and ( wantedPoints < 20 ) then
					setPlayerWantedLevel( source, 1 )
				elseif ( wantedPoints > 19 ) and ( wantedPoints < 29 ) then
					setPlayerWantedLevel( source, 2 )
				elseif ( wantedPoints > 29 ) and ( wantedPoints < 39 ) then
					setPlayerWantedLevel( source, 3 )
					removeJobDueWantedLevel( source, "Emergency" )
				elseif ( wantedPoints > 39 ) and ( wantedPoints < 49 ) then
					setPlayerWantedLevel( source, 4 )
					removeJobDueWantedLevel( source, "All Jobs" )
				elseif ( wantedPoints > 49 ) and ( wantedPoints < 59 ) then
					setPlayerWantedLevel( source, 5 )
					removeJobDueWantedLevel( source, "All Jobs" )
				elseif ( wantedPoints > 59 ) then
					setPlayerWantedLevel( source, 6 )
					removeJobDueWantedLevel( source, "All Jobs" )
				elseif ( wantedPoints < 10 ) then
					setPlayerWantedLevel( source, 0 )
				end
				setPlayerNametagText( source, getPlayerName( source ).." (" .. tostring( getPlayerWantedLevel ( source ) ) .. ")" )
			end
		end
	end
)

local warns = {}
local complied = {}
local warnsCD = {}
local surTimer = {}



addEvent ( "isTimerForArresting" )
addEventHandler ( "isTimerForArresting", root,
function ( theCop )
	if getPedWeapon(theCop) == 3 then
		if isTimer(antiSpam[source]) then
			exports.NGCdxmsg:createNewDxMessage(theCop,"Please wait few seconds before you hit this prisoner again (Just escaped)",255,0,0)
		return false end
		triggerClientEvent(theCop,"onPlayerGetArrestTime",theCop,source)
	end
end)

addEvent("getArrested",true)
addEventHandler("getArrested",root,function(prisoner)
	triggerEvent( "onReleasePlayerFromArrest", prisoner,source )
	triggerClientEvent(source,"releaseFromTheClient",source,prisoner)
	exports.NGCdxmsg:createNewDxMessage(source,"Required time to jail the prisoner has passed away, the prisoner released",255,0,0)
	exports.NGCdxmsg:createNewDxMessage(source,"You can arrest this prisoner after 5 seconds!",255,0,0)
	clearPlayerTaserAssists(prisoner)
	if isTimer(antiSpam[prisoner]) then return false end
	antiSpam[prisoner] = setTimer(function() end,5000,1)
end)


addEventHandler( "onPlayerCommand", root,
	function ( c )
		if ( c == "surr" ) then
			if getElementData(source,"wantedPoints") >= 10 then
				if isTimer(surTimer[source]) then return false end
				surTimer[source] = setTimer(function(p)
					if complied[p] or complied[p] == true then
						exports.NGCdxmsg( p, "You have already surrendered. Wait for law enforcement to arrive", 255, 0, 0 )
						return
					else
						local t = getElementsByType( "player" )
						local n = getPlayerName( p )
						local x, y, z = getElementPosition( p )
						local msg
						local zonename = getZoneName( x, y, z )
						---if warns[p] and getTickCount() - warns[ p ] <= 10000 then
						msg = n.." has complied and surrendered at "..zonename..""
						complied[p] = true
						---else
							--msg = n.." has surrendered to law at "..zonename..""
						--end
						for k,v in pairs( t ) do
							if isPlayerLawEnforcer(v) then
								exports.killmessages:outputMessage( msg, v, 0, 255, 0 )
							end
						end

						-- We'll add something that freezes them and makes them do a handup animation later
						--[[
						exports.NGCdxmsg( p, "You have surrendered - Wait for law enforcement to arrest you", 0, 255, 0 )
						setPedAnimation( p, "ped", "handsup", 0, false )
						--]]
					end
				end,60000,1,source)
			end
		end
	end
)

addCommandHandler("surrender", function(playerSource, commandName)
	if not ( getTeamName( getPlayerTeam( playerSource ) ) == "Criminals" ) then
		exports.NGCdxmsg:createNewDxMessage(playerSource, "This feature is unavailable on your team.", 255, 0, 0 )
		return false
	end 
	if ( getElementDimension( playerSource ) == 0 ) then
		if getElementData(playerSource,"wantedPoints") >= 10 then
			local scrim = false
			local sdist = 9999
			local px,py,pz = getElementPosition(playerSource)
			local t = getElementsByType("player")
			for k,v in pairs(t) do
				if isPlayerLawEnforcer(v) then
					local x,y,z = getElementPosition(v)
					local dist = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
					if dist < 800 and dist < sdist then sdist = dist scrim = v end
				end
			end
			if scrim then
				if isElement(scrim) then
					exports.NGCdxmsg:createNewDxMessage(playerSource, "You have surrendered and arrested by "..getPlayerName(scrim)..".", 255, 0, 0 )
					exports.NGCdxmsg:createNewDxMessage(scrim, "You arrested "..getPlayerName(playerSource).." for surrendering.", 0, 255, 0 )
					addCopArrestedPlayer ( scrim, playerSource )
					triggerEvent ( "onJailArrestedPlayers", scrim,"LS1",playerSource )
				end
			else
				forceJailSurrender ("LS1", playerSource )
			end
		else
			exports.NGCdxmsg:createNewDxMessage(playerSource, "Your not wanted.", 255, 0, 0 )
		end
	else
		exports.NGCdxmsg:createNewDxMessage(playerSource, "This feature is unavailable on your dimension.", 255, 0, 0 )
	end
end)

function forceJailSurrender (theJailPoint, thePrisoner)
	local wantedPoints = getElementData ( thePrisoner, "wantedPoints" )
	local jailTime = ( math.floor(tonumber(wantedPoints) * 100 / 34 ) )/2 -- it was / 26
	local jailMoney = ( math.floor(tonumber(wantedPoints) * 200 ) )
	local jailTime = math.min(jailTime, 900)
	local jailMoney = math.min(jailTime, 500000)
	if isElementWithinColShape(thePrisoner,LVcol) == true then
		jailMoney=jailMoney*4 --- it was * 4
	end

	setElementData(thePrisoner, "jailTimeRemaining", jailTime )
	toggleAllControls ( thePrisoner, true, true, true )
	showCursor ( thePrisoner, false )

	setControlState ( thePrisoner, "sprint", false )
	setControlState ( thePrisoner, "walk", false )
	setControlState ( thePrisoner, "forwards", false )
	setControlState ( thePrisoner, "jump", false )
	attempts[thePrisoner] = 0
	exports.CSGadmin:setPlayerJailed ( false, thePrisoner, false, jailTime, theJailPoint )

	local assister = getPlayerTaserAssister(thePrisoner)
	clearPlayerTaserAssists(thePrisoner)
	triggerEvent("onPlayerJailed",thePrisoner,jailTime)
	exports.NGCdxmsg:createNewDxMessage(thePrisoner, "You got jailed by surrendering for " .. jailTime .. " seconds", 225, 165, 0 )

	setElementData ( thePrisoner, "isPlayerArrested", false )
end 

addEventHandler( "onPlayerQuit", root,
	function()
		if complied[source] then
			complied[source] = nil
		end
	end
)

function warn(ps,_,name)
	if isPlayerLawEnforcer(ps) then
		if isTimer(warnsCD[ps]) then
			exports.NGCdxmsg:createNewDxMessage(ps,"Please wait before trying to warn again",255,0,0)
			return
		end
		warnsCD[ps] = setTimer(function() end,5000,1)
		local t = getElementsByType("player")
		local sdist = 9999
		local scrim = false
		local px,py,pz = getElementPosition(ps)
		for k,v in pairs(t) do
			if getPlayerWantedLevel(v) > 0 and not(isPlayerLawEnforcer(v)) then
				local x,y,z = getElementPosition(v)
				local dist = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				if dist < 10 and dist < sdist then sdist = dist scrim = v end
			end
		end
		if scrim then
			if isElement(scrim) then
				if not warns[scrim] then
					warns[scrim] = getTickCount()
					local pname = getPlayerName(ps)
					local cname = getPlayerName(scrim)
					if isPedInVehicle(scrim) then
						exports.NGCdxmsg:createNewDxMessage(scrim,getElementData(ps,"Rank").." "..pname.." has asked you to Pull Over!",255,0,0)
						exports.NGCdxmsg:createNewDxMessage(ps,"Asked "..cname.." to Pull Over!",0,255,0)
						for k,v in pairs(t) do
							if isPlayerLawEnforcer(v) then
								exports.killmessages:outputMessage(""..pname.." has asked "..cname.." to Pull Over",v,0,0,255)
							end
						end

					else
						exports.NGCdxmsg:createNewDxMessage(scrim,getElementData(ps,"Rank").." "..pname.." has asked you to surrender!",255,0,0)
						exports.NGCdxmsg:createNewDxMessage(scrim,"Use /surr to surrender within 10 seconds for decreased jail time!",255,0,0)
						exports.NGCdxmsg:createNewDxMessage(ps,"Asked "..cname.." to give himself up and surrender!",0,255,0)
						for k,v in pairs(t) do
							if isPlayerLawEnforcer(v) then
								exports.killmessages:outputMessage(""..pname.." has asked "..cname.." to Surrender",v,0,0,255)
							end
						end
					end
				else
					exports.NGCdxmsg:createNewDxMessage(ps,getPlayerName(scrim).." was warned recently, please wait before warning again",255,0,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage(ps,"There is no wanted person nearby to warn",255,0,0)
			end
		end
	end
end
addCommandHandler("warn",warn)
--[[
setTimer(function()
	local count = getTickCount()
	for k,v in pairs(warns) do
		if count-v > 20000 then
			warns[k]=nil
		end
	end
	for k,v in pairs(warnsCD) do
		if count-v > 3000 then
			warns[k]=nil
		end
	end
end,180000,0)]]

local tazer = {}

-- Kick from job if the player is high wanted
function removeJobDueWantedLevel (thePlayer, type)
	if not ( getTeamName( getPlayerTeam( thePlayer ) ) == "Criminals" ) then
		if ( type == "Emergency" ) then
			if isPlayerLawEnforcer(thePlayer) then
				exports.DENcriminal:setPlayerCriminal( thePlayer )
				triggerEvent( "onPlayerJobKick", thePlayer )
			end
		elseif type == "All Jobs" then
			exports.DENcriminal:setPlayerCriminal( thePlayer )
		end
	end
end

local arrestTable = {}

-- Add a new player to the arrested table of the cop
function addCopArrestedPlayer ( theCop, thePrisoner )
	if not arrestTable[theCop] then
		arrestTable[theCop] = {}
	end

	table.insert ( arrestTable[theCop], thePrisoner )
end

-- Remove a player from the arrest table of the cop
function removeCopArrestedPlayer ( theCop, thePrisoner )
	if arrestTable[theCop] then
		for i=1,#arrestTable[theCop] do
			if arrestTable[theCop][i] == thePrisoner then
				table.remove ( arrestTable[theCop], i )
			end
		end
	end
end

-- Get all the arrested players of the cop
function getCopArrestedPlayers ( theCop )
	return arrestTable[theCop]
end
function outDebug(attacker,msg)
	if getElementData(attacker,"isPlayerPrime") then
		----outputDebugString(msg)
	end
end

addEvent("onPlayerArrestedLagPlayer",true)
addEventHandler("onPlayerArrestedLagPlayer",root,function(crim)
	if isTimer(ArrestTimer[crim]) then return false end
	local oldx,oldy,oldz = getElementPosition(crim)
	if not attempts[crim] then attempts[crim] = 0 end
	exports.NGCdxmsg:createNewDxMessage(crim,"[Laggers Jail] You will be jailed within 5 seconds (Huge packet loss) if the nearest cop didn't get valid nightstick hit",255,100,200)
	ArrestTimer[crim] = setTimer(function(cop,crim,crimx,crimy)
		if crim and cop and isElement(cop) and isElement(crim) then
			local network = getNetworkStats(crim)
			if network["packetlossTotal"] and network["packetlossTotal"] >= 16 then
				if cop and isElement(cop) and getElementHealth(cop) >= 1 then
					local nearestCop = getNearestCop( crim )
					if nearestCop == cop then
						if attempts[crim] >= 1 then return false end
						if getElementData(crim,"isPlayerArrested") then return false end
						if getElementData(crim,"isPlayerJailed") then return false end
						triggerEvent ( "onJailArrestedPlayers", cop,"LS1",crim )
						--outputDebugString(getPlayerName(crim).." is being jailed for lag arrest")
						exports.NGCdxmsg:createNewDxMessage(cop,getPlayerName(crim).." was lagging you are attempting to jail him",0,100,200)
						exports.NGCdxmsg:createNewDxMessage(crim,getPlayerName(cop).." is attempting to jail you (LAGGER +35 Packetloss)",0,100,200)
					end
				end
			end
		end
	end,5000,1,source,crim,oldx,oldy)
end)
addEvent("NoticeCop",true)
addEventHandler("NoticeCop",resourceRoot,function(cop, ...)
	local crim = client
	if getElementData(crim,"wantedPoints") >= 10 then
		if not getElementData(crim,"isPlayerArrested") then
			if not getElementData(crim,"isPlayerJailed") then
				if not attempts[crim] then attempts[crim] = 0 end
				if attempts[crim] >= 3 then
					--outputDebugString(getPlayerName(crim).." got 3 hits and now is being not arrested yet so jailed")
					attempts[crim] = 0
				else
					attempts[crim] = attempts[crim] + 1
					--outputDebugString(getPlayerName(crim).." got "..attempts[crim].." hits")
				end
				onPlayerNightstickArrest(client, cop, ...)
			end
		end
	end
end)

--[[function cancelDmg(attacker, weapon, bodypart, loss)
	outputChatBox(loss, getPlayerFromName("Ab-47"))
	if weapon ~= 3 then
		outputChatBox("not batton", getPlayerFromName("Ab-47"))
		return
	end
	if (getElementHealth(source) < 10) then
		cancelEvent()
		outputChatBox("hello", getPlayerFromName("Ab-47"))
	end
	outputChatBox("Triggered HP: "..getElementHealth(source), getPlayerFromName("Ab-47"))
end
addEventHandler("onPlayerDamage", root, cancelDmg)]]

-- When the player got arrested by a nightstick
function onPlayerNightstickArrest (source, attacker, weapon, bodypart, loss )
	if isElement(attacker) and getElementType ( attacker ) == "player" then
		--if getControlState(attacker,"aim_weapon") == true then return end
		if isPlayerLawEnforcer(attacker) then
			if ( isArrestAllowedForLaw ( attacker, source ) ) then
				if canCopArrest (attacker, source) then
					if not(getElementData ( source, "isPlayerArrested" )) and ( getPlayerWantedLevel(source) > 0 ) then
						if getElementData(source,"safezone") == true then
							if getPedWeapon(source) == 3 then
								exports.NGCdxmsg:createNewDxMessage(attacker,"You can't arrest this player , he just spawned!!",255,0,0)
								return false
							end
						end
						triggerEvent( "onPlayerNightstickHit", source, attacker )
						if ( not wasEventCancelled() ) then
							if ( getElementData ( source, "isPlayerRobbing" ) ) and ( getElementDimension( source ) == 1 ) or ( getElementDimension( source ) == 2 ) or ( getElementDimension( source ) == 3 ) then
								return
							elseif getElementData ( source, "isPlayerInMotel" ) == true then
								return
							elseif getElementData ( source, "isPlayerDFRobbing" ) == true then
								return
							elseif exports.CSGnewturfing2:isPlayerInRT(source) then
								exports.NGCdxmsg:createNewDxMessage("You can't arrest in RT",attacker,255,0,0)
								return
							else
								if isTimer(antiSpam[source]) then
									exports.NGCdxmsg:createNewDxMessage(attacker,"Please wait few seconds before you hit this prisoner again (Just escaped)",255,0,0)
								return false end
								outDebug(attacker,"LAW:5")
								if weapon ~= 3 then
									return
								--	end
								end
								outDebug(attacker,"LAW:6")
								-- local player = tazer[source]
								-- if (player) then
									-- if (player ~= attacker) then
										-- exports.NGCdxmsg:createNewDxMessage(player, "You assisted in an arrest (tazer) when this player gets jailed you will get 50% of the money!", 0, 225, 0)
									-- end
								-- end
								-- tazer[source] = nil
								local assister = getPlayerTaserAssister(source)
								if (assister and assister ~= attacker) then
									exports.NGCdxmsg:createNewDxMessage(assister, "You assisted-tase in an arrest, you will get 50% of the money when the criminal gets jailed!", 0, 255, 0)
								end
								outDebug(attacker,"LAW:7")
								attempts[source] = 3
								setElementData ( source, "isPlayerArrested", true )
								setElementData ( attacker, "copArrestedCrim", true )
								toggleAllControls ( source, false, true, false )
								giveWeapon ( source, 0, 0, true )
								triggerClientEvent( source, "onClientFollowTheCop", source, attacker, source)
								triggerClientEvent( source, "onPlayerSetArrested", source )
								triggerEvent("isTimerForArresting",source,attacker)

								exports.NGCdxmsg:createNewDxMessage(source, "You got arrested by " .. getPlayerName(attacker) .. "!", 0, 225, 0)
								exports.NGCdxmsg:createNewDxMessage(attacker, "You arrested " .. getPlayerName(source) .. "!", 0, 225, 0)
								addCopArrestedPlayer ( attacker, source )
								setElementData( source, "arrestedBy", attacker )
								setCameraTarget ( source, source )
								triggerEvent( "onPlayerArrest", source, attacker )
								onCheckForJailPoints ( attacker, true )
								showCursor ( source, true, true )

								setElementData ( source, "isPlayerRobbing", false )
								setElementData( source, "isPlayerDFRobbing", false )
								setElementData( source, "isPlayerInMotel", false )
								setElementData( source, "JefFinished", false )
								setElementData( source, "DFrobberyFinished", false )
								setElementData( source, "robberyFinished", false )
							end
						end
					end
				end
			end
		end
	end
end
--addEventHandler( "onPlayerDamage", root, onPlayerNightstickArrest )


function onCheckForJailPoints ( theCop, state )
	if state and arrestTable[theCop] then
		triggerClientEvent ( theCop, "onCreateJailPoints", theCop )
	elseif not state and #arrestTable[theCop] == 0 then
		triggerClientEvent ( theCop, "onRemoveJailPoints", theCop )
	else
		triggerClientEvent ( theCop, "onRemoveJailPoints", theCop )
	end
end

-- Function that warp a player into the vehicle
function warpPrisonerIntoVehicle (officer)
	local officerVehicle = getPedOccupiedVehicle ( officer )
	if not isElement(officerVehicle) then return false end

	local officerVehicleSeats = getVehicleMaxPassengers( officerVehicle )
	local officerVehicleOccupants = getVehicleOccupants( officerVehicle )
	for seat = 1, officerVehicleSeats do
		local occupant = officerVehicleOccupants[seat]
		if not occupant then
			warpPedIntoVehicle( source, officerVehicle, seat)
		end
	end
end
addEvent("warpPrisonerIntoVehicle", true)
addEventHandler("warpPrisonerIntoVehicle", root, warpPrisonerIntoVehicle)

-- Function that removes a player out the vehicle
function removePrisonerOutVehicle (theOfficer)
	removePedFromVehicle ( source )
	local x, y, z = getElementPosition ( theOfficer )
	setElementPosition ( source, x + 2, y + 2, z )
end
addEvent("removePrisonerOutVehicle", true)
addEventHandler("removePrisonerOutVehicle", root, removePrisonerOutVehicle)

-- Function that removes a player out the vehicle
function release()

	setControlState (source, "forwards", false )
	setControlState (source, "walk", false )
	setControlState (source, "jump", false )
end
addEvent("setControlStateForPrisoner", true)
addEventHandler("setControlStateForPrisoner", root, release)

-- Function that checks if the cop can arrest
function canCopArrest( officer, thePrisoner )
	-- Check if the player already has 2 prisoners
	if ( arrestTable[officer] ) then
		if ( #arrestTable[officer] > 2 ) then
			return false
		else
			return true
		end
	else
		return true
	end
end

-- Check so Police can't arrest SAPD or MF and SAPD and MF can't arrest eachother
function isArrestAllowedForLaw ( officer, thePrisoner )
	if ( thePrisoner ) and ( officer ) and ( officer ~= thePrisoner ) and ( getTeamName( getPlayerTeam( officer ) ) ) and ( getTeamName( getPlayerTeam( thePrisoner ) ) ) then
		local attackerTeam = ( getTeamName( getPlayerTeam( officer ) ) )
		local sourceTeam = ( getTeamName( getPlayerTeam( thePrisoner ) ) )
		if isTimer(antiSpam[thePrisoner]) then
			exports.NGCdxmsg:createNewDxMessage(officer,"Please wait few seconds before you hit this prisoner again (Just escaped)",255,0,0)
			return false
		end
		if ( attackerTeam == "Government" ) then
			if (  sourceTeam == "Government" or sourceTeam == "Military Forces" or sourceTeam == "Advanced Assault Forces" ) then
				return false
			else
				return true
			end
		end
		if ( attackerTeam == "Military Forces" ) then
			if (  sourceTeam == "Government" or sourceTeam == "Military Forces" or sourceTeam == "Advanced Assault Forces" ) then
				return false
			else
				return true
			end
		end
		if ( attackerTeam == "Advanced Assault Forces" ) then
			if (   sourceTeam == "Government" or sourceTeam == "Military Forces" or sourceTeam == "Advanced Assault Forces" ) then
				return false
			else
				return true
			end
		end
		-- We'll keep this bit just in case
		--[[if ( attackerTeam == "Police" ) then
			if ( sourceTeam == "SAPD" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) or ( sourceTeam == "Police" ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "SAPD" ) then
			if ( sourceTeam == "SAPD" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "onPlayerTargetLossWantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "Military Forces" ) then
			if ( sourceTeam == "SAPD" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		elseif ( attackerTeam == "Government Agency" ) then
			if ( sourceTeam == "SAPD" ) or ( sourceTeam  == "Military Forces" ) or ( sourceTeam == "Government Agency" ) then
				return false
			elseif ( sourceTeam == "Police" ) and ( getElementData( thePrisoner, "wantedPoints" ) < 9 ) then
				return false
			else
				return true
			end
		end]]
	end
end


addEventHandler("onPlayerQuit",root,function()
	if isTimer(bugfix[source]) then killTimer(bugfix[source]) end
end)

addEventHandler("onPlayerSpawn",root,function()
	if getPlayerTeam(source) then
		if isPlayerLawEnforcer(source) then
			if not arrestTable[source] then
				arrestTable[source] = {}
			else
				for i, element in ipairs ( arrestTable[source] ) do
					exports.NGCdxmsg:createNewDxMessage(element, "You are now free! RUN!", 0, 225, 0)
					setElementData ( element, "isPlayerArrested", false )
					setElementData ( source, "copArrestedCrim", false )
					toggleAllControls ( element, true, true, true )
					onCheckForJailPoints ( source, false )
					showCursor ( element, false, false )
					--triggerClientEvent(element,"releaseFromTheClient2",element,source)
					triggerClientEvent(source,"releaseFromTheClient",source,element)
					clearPlayerTaserAssists(element)
					attempts[element] = 0
					if (tazer[element]) then
						tazer[element] = false
					end
					arrestTable[source] = {}
					bugfix[source] = {}
				end
			end
		end
	end
end)
bugfix = {}
addEventHandler("onPlayerWasted",root,function()
	if getPlayerTeam(source) then
		if isPlayerLawEnforcer(source) then
			if not arrestTable[source] then
				arrestTable[source] = {}
			else
				if isTimer(bugfix[source]) then killTimer(bugfix[source]) end
				bugfix[source] = setTimer(function(cop)
					for i, element in ipairs ( arrestTable[cop] ) do
						exports.NGCdxmsg:createNewDxMessage(element, "You are now free! RUN!", 0, 225, 0)
						setElementData ( element, "isPlayerArrested", false )
						setElementData ( cop, "copArrestedCrim", false )
						toggleAllControls ( element, true, true, true )
						onCheckForJailPoints ( cop, false )
						showCursor ( element, false, false )
						clearPlayerTaserAssists(element)
						--triggerClientEvent(element,"releaseFromTheClient2",element,cop)
						triggerClientEvent(cop,"releaseFromTheClient",cop,element)
						attempts[element] = 0
						if (tazer[element]) then
							tazer[element] = false
						end
						arrestTable[cop] = {}
						bugfix[cop] = {}
					end
				end,2000,1,source)
			end
		end
	end
end)

-- /release function of the cop
function releasePlayerFromArrest (officer, cmd, prisoner)
	if ( arrestTable[officer] ) then
		if ( prisoner == "*" ) then
			for i, element in ipairs ( arrestTable[officer] ) do
				exports.NGCdxmsg:createNewDxMessage(element, "You are now free! RUN!", 0, 225, 0)
				setElementData ( element, "isPlayerArrested", false )
				setElementData ( officer, "copArrestedCrim", false )
				toggleAllControls ( element, true, true, true )
				onCheckForJailPoints ( officer, false )
				showCursor ( element, false, false )
				clearPlayerTaserAssists(element)
				---triggerClientEvent(element,"releaseFromTheClient2",element,officer)
				triggerClientEvent(officer,"releaseFromTheClient",officer,element)
				attempts[element] = 0
				if (tazer[element]) then
					tazer[element] = false
				end
			end
			exports.NGCdxmsg:createNewDxMessage(officer, "You released all players under your custody!", 0, 225, 0)
			arrestTable[officer] = {}
		else
			local getPrisoner = exports.server:getPlayerFromNamePart( prisoner )
			for i=1,#arrestTable[officer] do
				local thePrisoner = arrestTable[officer][i]
				if ( getPrisoner ) and ( getPrisoner == thePrisoner ) then
					toggleControl (officer, "fire", false )
					exports.NGCdxmsg:createNewDxMessage(officer, "You released ".. getPlayerName( thePrisoner ) .."!", 0, 225, 0)
					exports.NGCdxmsg:createNewDxMessage(thePrisoner, "You are now free! RUN!", 0, 225, 0)
					setTimer ( function(officers)
						if officers and isElement(officers) then
							toggleControl (officers, "fire", true )
						end
					end, 5000, 1,officer )
					setElementData ( thePrisoner, "isPlayerArrested", false )
					setElementData ( officer, "copArrestedCrim", false )
					toggleAllControls ( thePrisoner, true, true, true )
					removeCopArrestedPlayer ( officer, thePrisoner )
					onCheckForJailPoints ( officer, false )
					showCursor ( thePrisoner, false )
					clearPlayerTaserAssists(thePrisoner)
					--triggerClientEvent(thePrisoner,"releaseFromTheClient2",thePrisoner,officer)
					triggerClientEvent(officer,"releaseFromTheClient",officer,thePrisoner)
					attempts[thePrisoner] = 0
					if (tazer[thePrisoner]) then
						tazer[thePrisoner] = false
					end
				else
					exports.NGCdxmsg:createNewDxMessage(officer, "We couldn't find a player with that name!", 225, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("release", releasePlayerFromArrest)

addEvent("CSGbribe.accepted",true)
addEventHandler("CSGbribe.accepted",root,releasePlayerFromArrest)

local timeToHit = {}
addEventHandler("onPlayerQuit",root,function() timeToHit[source] = nil end)
local tazerDelay = {}
local tazerCount = {}
-- Serverside part when player got tazerd, source is the officer
addEvent("onWantedPlayerGotTazerd", true)
function onWantedPlayerGotTazerd ( prisoner, dogTaz )
	if tazerDelay[prisoner] then return end
	if exports.CSGnewturfing2:isPlayerInRT(source) or exports.CSGnewturfing2:isPlayerInRT(prisoner) then
		exports.NGCdxmsg:createNewDxMessage("You can't taze in RT",source,255,150,0)
		return
	end
	if (timeToHit[prisoner]) then
		if getTickCount()-timeToHit[prisoner] > 10000 then
			timeToHit[prisoner] = nil
			return
		else
			--continue
		end
	else
		if math.random(100) > 40 then
		timeToHit[prisoner] = getTickCount()
		triggerClientEvent(prisoner,"tazed",prisoner)
		for k,v in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(v) and isPlayerLawEnforcer(v) then
				triggerClientEvent(v,"recTazTimeToHit",v,prisoner)
			end
		end
		exports.NGCdxmsg:createNewDxMessage(source,"Tazer nearly missed the target - re-hit within 10s",255,255,0)
		return
		end
	end

	for k,v in pairs(getElementsByType("player")) do
		if isPlayerLawEnforcer(v) then
			triggerClientEvent(v,"removeTimeToHit",v,prisoner)
		end
	end
	  -- 50 percent chance a second hit is needed
	if ( isElement( source ) ) then
		giveWeapon ( source, 3, 1, true )
	end
	triggerEvent("serverDrawTaz",source,prisoner)
	tazerDelay[prisoner] = true
	setTimer(function() tazerDelay[prisoner]=nil end,1000,1)
	exports.NGCdxmsg:createNewDxMessage(source,"Tazer Successfull",0,255,0)
	exports.NGCdxmsg:createNewDxMessage(prisoner,"You have been tazed by "..getPlayerName(source).."",255,0,0)
	if ( isElement(prisoner) ) then
		if tazerAssists[prisoner] == nil then tazerAssists[prisoner] = {} end
		if tazerCount[prisoner] == nil then tazerCount[prisoner] = {} end
		local exists = false
		for k,v in pairs(tazerAssists[prisoner]) do
			if v == source then exists=true break end
		end
		if exists==false then
			table.insert(tazerAssists[prisoner],source)
		end
		setElementFrozen(prisoner,true)
			setElementFrozen(prisoner,false)
			setPedAnimation(prisoner,false)
		if (getPlayerPing(prisoner) < 500) then
			triggerClientEvent(prisoner,"iGotTaz",prisoner,1)
			tazer[prisoner] = source

			setTimer(destroyTazerTable, 3800, 1, prisoner)
			setTimer(function() setPedAnimation(prisoner, "CRACK", "crckidle2") end,2000,1)
			setTimer(setPedAnimation, 3800, 1, prisoner)
			giveWeapon ( prisoner, 0, 0, true )
			local p = prisoner
			toggleControl(p,"fire",false)
			setControlState(p,"jump",false)
			toggleControl(p,"jump",false)
			toggleControl(p,"sprint",false)
			setControlState(p,"walk",true)
			toggleControl(p,"aim_weapon",false)
			setTimer(function()
			if p then
			toggleControl(p,"jump",true)
			toggleControl(p,"sprint",true)
			toggleControl(p,"fire",true)
			toggleControl(p,"aim_weapon",true)
			setControlState(p,"walk",false)
			end
			end,3800,1)
			--toggleAllControls ( prisoner, false, true, false )
			--setTimer(toggleAllControls, 3000, 1, prisoner, true, true, true)
		elseif (getPlayerPing(prisoner) > 500) then
			triggerClientEvent(prisoner,"iGotTaz",prisoner,2)
			tazer[prisoner] = source
			setTimer(destroyTazerTable, 4000, 1, prisoner)
			setTimer(function() setPedAnimation(prisoner, "CRACK", "crckidle2") end,2000,1)
			setTimer(setPedAnimation, 4000, 1, prisoner)
			local p = prisoner
			giveWeapon ( prisoner, 0, 0, true )
			setControlState(p,"jump",false)
			toggleControl(p,"jump",false)
			toggleControl(p,"fire",false)
			toggleControl(p,"sprint",false)
			toggleControl(p,"aim_weapon",false)
			setControlState(p,"walk",true)
			setTimer(function()
			if p then
			toggleControl(p,"jump",true)
			toggleControl(p,"sprint",true)
			toggleControl(p,"fire",true)
			toggleControl(p,"aim_weapon",true)
			setControlState(p,"walk",false)
			end
			end,4000,1)
			--toggleAllControls ( prisoner, false, true, false )
			--setTimer(toggleAllControls, 5000, 1, prisoner, true, true, true)
		end

	end

	--if ( dogTaz ) then
		--local theAnimal = exports.CSGanimals:getPlayerAnimal ( source )
		--if ( theAnimal ) then
			---exports.CSGanimals:setAnimalFollowing ( theAnimal, prisoner )
			--setTimer( call, 6000, 1, getResourceFromName("CSGanimals"), "resetAnimalFollowing", theAnimal )
			--setElementHealth( prisoner, getElementHealth( prisoner ) -5 )
		--end
	--end
end
addEventHandler("onWantedPlayerGotTazerd", root, onWantedPlayerGotTazerd)

function destroyTazerTable(plr)
	if (not getElementData(plr, "isPlayerArrested")) then
		if (not tazer[plr]) then return end
		tazer[plr] = false
		tazer[plr] = {}
	end
end


-- Release when the cop dies
addEventHandler( "onPlayerWasted", root,
function( ammo, attacker, weapon, bodypart )
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if isPlayerLawEnforcer(source) then
			if arrestTable[source] then
				for i, element in ipairs ( arrestTable[source] ) do
					exports.NGCdxmsg:createNewDxMessage(element, "The cop died! You're free again.", 0, 225, 0)
					setElementData ( element, "isPlayerArrested", false )
					setElementData ( source, "copArrestedCrim", false )
					clearPlayerTaserAssists(element)
					---triggerClientEvent(element,"releaseFromTheClient2",element,source)
					triggerClientEvent(source,"releaseFromTheClient",source,element)
					attempts[element] = 0
					toggleAllControls ( element, true, true, true )
					onCheckForJailPoints ( source, false )
					showCursor ( element, false, false )
				end
				arrestTable[source] = {}
			end
		end
	end
end
)

addEvent("onPlayerJobChange",true)
addEventHandler("onPlayerJobChange",root,function(new,old)
	if arrestTable[source] then
			for i, element in ipairs ( arrestTable[source] ) do
				exports.NGCdxmsg:createNewDxMessage(element, "The cop quit his job! You're free again.", 0, 225, 0)
				setElementData ( element, "isPlayerArrested", false )
				setElementData ( source, "copArrestedCrim", false )
				toggleAllControls ( element, true, true, true )
				onCheckForJailPoints ( source, false )
				showCursor ( element, false, false )
				clearPlayerTaserAssists(element)
				--triggerClientEvent(element,"releaseFromTheClient2",element,source)
				triggerClientEvent(source,"releaseFromTheClient",source,element)
				attempts[element] = 0
			end
		arrestTable[source] = {}
	end
end)

-- Release when the cop reconnect
addEventHandler( "onPlayerQuit", root,
function()
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if isPlayerLawEnforcer(source) then
			if arrestTable[source] then
				for i, element in ipairs ( arrestTable[source] ) do
					exports.NGCdxmsg:createNewDxMessage(element, "The cop disconnected! You're free again!", 0, 225, 0)
					setElementData ( element, "isPlayerArrested", false )
					setElementData ( source, "copArrestedCrim", false )
					clearPlayerTaserAssists(element)
					--triggerClientEvent(element,"releaseFromTheClient2",element,source)
					triggerClientEvent(source,"releaseFromTheClient",source,element)
					attempts[element] = 0
					toggleAllControls ( element, true, true, true )
					showCursor ( element, false, false )
				end
				arrestTable[source] = {}
			end
		end
	end
end
)

-- Get nearst copy
function getNearestCop( thePlayer )
	if ( exports.server:getPlayerAccountName ( thePlayer ) ) then
		local x, y, z = getElementPosition( thePlayer )
		local distance = nil
		local theCopNear = nil
		for i, theCop in ipairs ( getElementsByType( "player" ) ) do
			local x1, x2, x3 = getElementPosition( theCop )
			if ( exports.server:getPlayerAccountName ( theCop ) ) then
				if isPlayerLawEnforcer(theCop) then
					if ( distance ) and ( getDistanceBetweenPoints2D( x, y, x1, x2 ) < distance ) then
						distance = getDistanceBetweenPoints2D( x, y, x1, x2 )
						theCopNear = theCop
					elseif ( getDistanceBetweenPoints2D( x, y, x1, x2 ) < 40 ) then
						distance = getDistanceBetweenPoints2D( x, y, x1, x2 )
						theCopNear = theCop
					end
				end
			end
		end
		return theCopNear
	end
end
local abuser = 0
-- When the player that is arrest quit
addEventHandler( "onPlayerQuit", root,
	function(typ)
		if ( exports.server:getPlayerAccountName ( source ) ) and ( getElementData ( source, "isPlayerArrested" ) ) then
			local theCop = getElementData( source, "arrestedBy" )
			local abuser = 0
			if typ ~= "Bad Connection" and typ ~= "Timed Out" and typ ~= "Unknown" then
				exports.CSGscore:takePlayerScore(source,5)
				abuser = 300
			end
			if ( arrestTable[theCop] ) then
				for i=1,#arrestTable[theCop] do
					local thePrisoner = arrestTable[theCop][i]
					if ( thePrisoner == source ) then
						---triggerClientEvent(thePrisoner,"releaseFromTheClient2",thePrisoner,theCop)
						triggerClientEvent(theCop,"releaseFromTheClient",theCop,thePrisoner)
						attempts[thePrisoner] = 0
						local userID = exports.server:getPlayerAccountID( source )
						local wantedPoints = getElementData ( source, "wantedPoints" )
						local jailTime = ( math.floor(tonumber(wantedPoints) * 100 / 26 ) )*2
						local jailTime = jailTime + abuser
						local jailMoney = ( math.floor(tonumber(wantedPoints) * 200 / 2 ) )
						-- if tazerAssists[source] == nil then tazerAssists[source] = {} end
						-- for k,v in pairs(tazerAssists[source]) do
							-- if v == theCop and isElement(v) then
								-- exports.denstats:setPlayerAccountData(theCop,"tazerassists",(exports.denstats:getPlayerAccountData(theCop,"tazerassists"))+1)
							-- end
						-- end
						-- tazerAssists[source] = nil
						if isElementWithinColShape(source,LVcol) == true then
							jailMoney=jailMoney*4
						end
						local addJail = exports.DENmysql:exec( "INSERT INTO jail SET userid=?, jailtime=?, jailplace=?", userID, math.min(jailTime1, 900), "LS1" )
						--givePlayerMoney ( theCop, tonumber(jailMoney) )
						local jailMoney=math.min(jailMoney, 500000)
						exports.AURpayments:addMoney(theCop, tonumber(jailMoney), "Custom", "Aurora Core", 0, "Jail")

						exports.DENstats:setPlayerAccountData ( theCop, "arrests", exports.DENstats:getPlayerAccountData ( theCop, "arrests" ) + 1 )
						exports.DENstats:setPlayerAccountData ( theCop, "arrestpoints", exports.DENstats:getPlayerAccountData ( theCop, "arrestpoints" ) + tonumber(wantedPoints) )

						local message = exports.NGCdxmsg:createNewDxMessage(theCop, "" .. getPlayerName(source) .." quited you earned $".. jailMoney .."", 0, 225, 0)
						removeCopArrestedPlayer ( theCop, source )
						onCheckForJailPoints ( theCop, false )
					end
				end
			end
		elseif ( exports.server:getPlayerAccountName ( source ) ) and not ( getElementData ( source, "isPlayerArrested" ) ) and not(getElementData ( source, "isPlayerJailed" )) and ( getElementData ( source, "wantedPoints" ) >= 10 ) then
			local nearestCop = getNearestCop( source )
			if ( nearestCop ) and not ( nearestCop == source ) then
				local userID = exports.server:getPlayerAccountID( source )
				local wantedPoints = getElementData ( source, "wantedPoints" )
				local jailTime = ( math.floor(tonumber(wantedPoints) * 100 / 26 ) )/2
				local jailMoney = ( math.floor(tonumber(wantedPoints) * 200 / 4.2 ) )
				if isElementWithinColShape(source,LVcol) == true then
					jailMoney=jailMoney*4
				end
				---triggerClientEvent(source,"releaseFromTheClient2",source,nearestCop)
				triggerClientEvent(nearestCop,"releaseFromTheClient",nearestCop,source)
				attempts[source] = 0
				-- if tazerAssists[source] == nil then
					-- tazerAssists[source] = {}
					-- exports.denstats:setPlayerAccountData(nearestCop,"tazerassists",(exports.denstats:getPlayerAccountData(nearestCop,"tazerassists"))+1)
				-- end
				-- for k,v in pairs(tazerAssists[source]) do
					-- if v == nearestCop and isElement(v) then
						-- exports.denstats:setPlayerAccountData(nearestCop,"tazerassists",(exports.denstats:getPlayerAccountData(nearestCop,"tazerassists"))+1)
					-- end
				-- end
				-- tazerAssists[source] = nil
				local addJail = exports.DENmysql:exec( "INSERT INTO jail SET userid=?, jailtime=?, jailplace=?", userID, math.min(jailTime1, 900), "LS1" )
				--givePlayerMoney ( nearestCop, tonumber(jailMoney) )
				local jailMoney = math.min(jailMoney1, 500000)
				exports.AURpayments:addMoney(nearestCop, tonumber(jailMoney), "Custom", "Aurora Core", 0, "Jail Arrest")
				if type(exports.DENstats:getPlayerAccountData ( nearestCop, "arrests" )) == "boolean" then

				else
					exports.DENstats:setPlayerAccountData ( nearestCop, "arrests", exports.DENstats:getPlayerAccountData ( nearestCop, "arrests" ) + 1 )
					exports.DENstats:setPlayerAccountData ( nearestCop, "arrestpoints", exports.DENstats:getPlayerAccountData ( nearestCop, "arrestpoints" ) + tonumber(wantedPoints) )
				end

				local message = exports.NGCdxmsg:createNewDxMessage(nearestCop, "" .. getPlayerName(source) .." evaded his arrest, you earned $".. jailMoney .."!", 0, 225, 0)
			end
		end
	end
)

-- Release when vehicle with wanted player in it get too damaged
function onCopVehicleDamage( loss )
	if ( getElementHealth ( source ) < 251 ) then
		local occupants = getVehicleOccupants( source )
		local seats = getVehicleMaxPassengers( source )
		local driver = getVehicleOccupant ( source )
		for seat = 0, seats do
			local occupant = occupants[seat]
			if occupant and getElementType(occupant)=="player" then
				if getElementData ( occupant, "isPlayerArrested" ) then
					exports.NGCdxmsg:createNewDxMessage(occupant, "The cop vehicle broke down! You're free now!", 0, 225, 0)
					setElementData ( occupant, "isPlayerArrested", false )
					setElementData ( driver, "copArrestedCrim", false )
					setPedAnimation(occupant,false)
					toggleAllControls ( occupant, true, true, true )
					removeCopArrestedPlayer ( getElementData( occupant, "arrestedBy" ), occupant )
					removePedFromVehicle( occupant )
					clearPlayerTaserAssists(occupant)
					---triggerClientEvent(occupant,"releaseFromTheClient2",occupant,driver)
					triggerClientEvent(driver,"releaseFromTheClient",driver,occupant)
					attempts[occupant] = 0
					onCheckForJailPoints ( getElementData( occupant, "arrestedBy" ), false )
					showCursor ( occupant, false, false )
				end
			end
		end
    end
end
addEventHandler ( "onVehicleDamage", root, onCopVehicleDamage )

addEvent( "onlawCheckLaw",true )
addEventHandler ( "onlawCheckLaw", root,function(cop,crim)
	----outputDebugString(getPlayerName(crim).." forced to be auto jail")
	exports.NGCdxmsg:createNewDxMessage(crim,"The officer has forced you to be jailed (NT Problems) Good luck Next time with Abusing :)",255,0,0)
	exports.NGCdxmsg:createNewDxMessage(cop,"You have forced "..getPlayerName(crim).." to be jailed (NT Problems)",255,0,0)
	---onJailArrestedPlayers ( "LS1", crim )
end)

addEvent( "onServerLawMsg",true )
addEventHandler ( "onServerLawMsg", root,function(cop,msg)
	------outputDebugString(getPlayerName(source).." "..msg)
end)

addEvent( "onServerPlayerJailed" )
addEventHandler ( "onServerPlayerJailed", root,
	function ()
		local arrestedTable = getCopArrestedPlayers( source )
		if ( arrestedTable ) then
			for i, thePrisoner in ipairs ( arrestedTable ) do
				exports.NGCdxmsg:createNewDxMessage(thePrisoner, "The cop get jailed! You're free again!", 0, 225, 0)
				setElementData ( thePrisoner, "isPlayerArrested", false )
				setElementData ( source, "copArrestedCrim", false )
				toggleAllControls ( thePrisoner, true, true, true )
				removeCopArrestedPlayer ( source, thePrisoner )
				onCheckForJailPoints ( source, false )
				showCursor ( thePrisoner, false, false )
			end
		end
	end
)

addEvent( "onPlayerJobKick" )
-- When the cop get kicked from job release wanteds
function onCopRemoveJob()
	local arrestedTable = getCopArrestedPlayers( source )
	if ( arrestedTable ) then
		for i, thePrisoner in ipairs ( arrestedTable ) do
			exports.NGCdxmsg:createNewDxMessage(thePrisoner, "Cop switched job! You're free again!", 0, 225, 0)
			setElementData ( thePrisoner, "isPlayerArrested", false )
			setElementData ( source, "copArrestedCrim", false )
			toggleAllControls ( thePrisoner, true, true, true )
			clearPlayerTaserAssists(thePrisoner)
			---triggerClientEvent(thePrisoner,"releaseFromTheClient2",thePrisoner,source)
			triggerClientEvent(source,"releaseFromTheClient",source,thePrisoner)
			attempts[thePrisoner] = 0
			removeCopArrestedPlayer ( source, thePrisoner )
			onCheckForJailPoints ( source, false )
			showCursor ( thePrisoner, false, false )
		end
	end
end
addEventHandler ( "onPlayerJobKick", root, onCopRemoveJob )

-- Arrest when a cop jacks him
function onCopJackWantedPlayer ( thePlayer, seat, jacked )
	if not (isElement(thePlayer)) or getElementType(thePlayer) ~= "player" then return end
    if isPlayerLawEnforcer(thePlayer) then
        if ( jacked ) and ( seat == 0 ) then
			if ( isArrestAllowedForLaw ( thePlayer, jacked ) ) and ( canCopArrest( thePlayer, jacked ) ) then
				if ( getElementData( jacked, "wantedPoints" ) > 9 ) and not ( getElementData( jacked, "isPlayerArrested" ) ) and not ( getElementData( jacked, "isPlayerJailed" ) ) then
				if getElementData(jacked,"safezone") == true then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You can't arrest this player , he just spawned!!",255,0,0) return false end
					if isTimer(antiSpam[jacked]) then
						exports.NGCdxmsg:createNewDxMessage(thePlayer,"Please wait few seconds before you hit this prisoner again (Just escaped)",255,0,0)
					return false end

					setElementData ( jacked, "isPlayerArrested", true )
					setElementData ( thePlayer, "copArrestedCrim", true )
					toggleAllControls ( jacked, false, true, false )
					giveWeapon ( jacked, 0, 0, true )
					triggerClientEvent( jacked, "onClientFollowTheCop", jacked, thePlayer, jacked)
					triggerClientEvent(thePlayer,"onPlayerGetArrestTime",thePlayer,jacked)
					triggerClientEvent(jacked,"onPrisonerGetArrestTime",jacked,thePlayer)
					exports.NGCdxmsg:createNewDxMessage(jacked, "You got arrested by " .. getPlayerName(thePlayer) .. "!", 0, 225, 0)
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "You arrested " .. getPlayerName(jacked) .. "!", 0, 225, 0)
					addCopArrestedPlayer ( thePlayer, jacked )
					setElementData( jacked, "arrestedBy", thePlayer )
					triggerEvent( "onPlayerArrest", thePlayer, jacked )
					onCheckForJailPoints ( thePlayer, true )
					showCursor ( jacked, true, true )
				end
			end
		end
    end
end
addEventHandler ( "onVehicleEnter", root, onCopJackWantedPlayer )

-- Arrest all wanted player in the vehicle
function onCopJackWantedPlayer ( thePlayer, seat, jacked )
	if not (isElement(thePlayer)) or getElementType(thePlayer) ~= "player" then return end
    if isPlayerLawEnforcer(thePlayer) then
        if ( seat == 0 ) then
			local occupants = getVehicleOccupants( source )
			local seats = getVehicleMaxPassengers( source )
			for seat = 0, seats do
				local occupant = occupants[seat]
				if ( occupant ) and ( getElementType(occupant)=="player" ) then
					if ( isArrestAllowedForLaw ( thePlayer, occupant ) ) and ( canCopArrest( thePlayer, occupant ) ) then
						if getElementData( occupant, "wantedPoints" ) > 9 and not ( getElementData( occupant, "isPlayerArrested" ) ) and not ( getElementData( occupant, "isPlayerJailed" ) ) then
						if getElementData(occupant,"safezone") == true then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You can't arrest this player , he just spawned!!",255,0,0) return false end
							if isTimer(antiSpam[occupant]) then
								exports.NGCdxmsg:createNewDxMessage(thePlayer,"Please wait few seconds before you hit this prisoner again (Just escaped)",255,0,0)
							return false end
							setElementData ( occupant, "isPlayerArrested", true )
							setElementData ( thePlayer, "copArrestedCrim", true )
							toggleAllControls ( occupant, false, true, false )
							giveWeapon ( occupant, 0, 0, true )
							triggerClientEvent( occupant, "onClientFollowTheCop", occupant, thePlayer, occupant)
							exports.NGCdxmsg:createNewDxMessage(occupant, "You got arrested by " .. getPlayerName(thePlayer) .. "!", 0, 225, 0)
							exports.NGCdxmsg:createNewDxMessage(thePlayer, "You arrested " .. getPlayerName(occupant) .. "!", 0, 225, 0)
							addCopArrestedPlayer ( thePlayer, occupant )
							setElementData( occupant, "arrestedBy", thePlayer )
							onCheckForJailPoints ( thePlayer, true )
							triggerEvent( "onPlayerArrest", thePlayer, occupant )
							triggerClientEvent(thePlayer,"onPlayerGetArrestTime",thePlayer,occupant)
							triggerClientEvent(occupant,"onPrisonerGetArrestTime",occupant,thePlayer)
							showCursor ( occupant, true, true )
						end
					end
				end
			end
		end
    end
end
addEventHandler ( "onVehicleEnter", root, onCopJackWantedPlayer )
local whoabuse = {}
LVcol = createColRectangle(866,656,2100,2300)
-- Jail the player when the prisoner hits the col jail
addEvent("onJailArrestedPlayers", true)
function onJailArrestedPlayers ( theJailPoint, thePrisoner )
	local arrestedTable = getCopArrestedPlayers( source )
	if ( arrestedTable ) then
		if #arrestedTable == 3 then
			if isTimer(whoabuse[source]) then
			else
				whoabuse[source] = setTimer(function() end,20000,1)
				exports.CSGgroups:addXP(source,8)
			end
		end
		for i=1,#arrestedTable do
			if ( arrestedTable[i] == thePrisoner ) then
				local wantedPoints = getElementData ( thePrisoner, "wantedPoints" )
				local jailTime1 = ( math.floor(tonumber(wantedPoints) * 100 / 34 ) )/2 -- it was / 26
				local jailMoney1 = ( math.floor(tonumber(wantedPoints) * 200 ) )
				if isElementWithinColShape(thePrisoner,LVcol) == true then
					jailMoney1=jailMoney1*1 --- it was * 4
				end
				jailMoney=math.min(jailMoney1, 500000)
				-- if tazerAssists[thePrisoner] == nil then tazerAssists[thePrisoner] = {} end
				-- for k,v in pairs(tazerAssists[thePrisoner]) do
					-- if v == source and isElement(v) then
						-- exports.denstats:setPlayerAccountData(source,"tazerassists",(exports.denstats:getPlayerAccountData(source,"tazerassists"))+1)
					-- end
				-- end
				local chance = 0
				if complied[thePrisoner] then
					exports.NGCdxmsg:createNewDxMessage(source, "You jailed "..getPlayerName(thePrisoner).." who had complied with a warning : Bonus $"..math.floor(jailMoney*0.25),0,255,0)
					--givePlayerMoney(source,jailMoney*0.25)
					exports.AURpayments:addMoney(source, jailMoney*0.25, "Custom", "Aurora Core", 0, "Jail Arrest")
					complied[thePrisoner] = nil
					chance = math.random(15,25)
					exports.NGCdxmsg:createNewDxMessage(thePrisoner,"Jail Time reduced by "..chance.."% for surrendering to law enforcerment when asked to",0,255,0)
				end
				if wantedPoints >= 800 then
					exports.CSGgroups:addXP(source,9)
				end
				exports.CSGgroups:addXP(source,7)
				jailTime1=jailTime1-(jailTime1*(chance/100))
				jailTime1=math.floor(jailTime1)
				jailTime=math.min(jailTime1, 900)
				-- tazerAssists[thePrisoner] = nil
				removePedFromVehicle ( arrestedTable[i] )
				setElementData(thePrisoner, "jailTimeRemaining", jailTime )
				toggleAllControls ( thePrisoner, true, true, true )
				removeCopArrestedPlayer ( source, thePrisoner )
				showCursor ( thePrisoner, false )

				setControlState ( thePrisoner, "sprint", false )
				setControlState ( thePrisoner, "walk", false )
				setControlState ( thePrisoner, "forwards", false )
				setControlState ( thePrisoner, "jump", false )
				--triggerClientEvent(thePrisoner,"releaseFromTheClient2",thePrisoner,source)
				triggerClientEvent(source,"releaseFromTheClient",source,thePrisoner)
				attempts[thePrisoner] = 0
				exports.DENstats:setPlayerAccountData ( source, "arrests", exports.DENstats:getPlayerAccountData ( source, "arrests" ) + 1 )
				exports.DENstats:setPlayerAccountData ( source, "arrestpoints", exports.DENstats:getPlayerAccountData ( source, "arrestpoints" ) + tonumber(wantedPoints) )
				attempts[thePrisoner] = 0
				exports.CSGadmin:setPlayerJailed ( false, thePrisoner, false, jailTime, theJailPoint )
				-- if (tazer[thePrisoner]) then
					-- local assister = tazer[thePrisoner]
					-- if (assister ~= source and isElement(assister)) then
						-- exports.CSGgroups:addXP(assister,1)
						-- exports.CSGscore:givePlayerScore(assister, 1)
						-- givePlayerMoney(assister, jailMoney / 2)
						-- exports.NGCdxmsg:createNewDxMessage(assister, "A criminal you assisted to arrest got jailed and you earned half the money, $"..jailMoney / 2 , 0, 225, 0)
					-- end
				-- end
				local assister = getPlayerTaserAssister(thePrisoner)
				if (assister and assister ~= source) then
					exports.CSGscore:givePlayerScore(assister, 2)
					--givePlayerMoney(assister, jailMoney / 2)
					exports.AURpayments:addMoney(assister, jailMoney / 2, "Custom", "Aurora Core", 0, "Jail Arrest")
					exports.NGCdxmsg:createNewDxMessage(assister, "A criminal that is now a prisoner you assisted-tasing in jailing them, you got rewarded 50% of the money and 2 scores", 0, 255, 0)
					exports.DENstats:setPlayerAccountData(assister, "tazerassists", (exports.DENstts:getPlayerAccountData(source,"tazerassists"))+1)
				end
				clearPlayerTaserAssists(thePrisoner)
				triggerEvent("onPlayerJailed",thePrisoner,jailTime)
				--givePlayerMoney ( source, jailMoney)
				exports.AURpayments:addMoney(source, jailMoney, "Custom", "Aurora Core", 0, "Jail Arrest")
				--outputDebugString(jailMoney.."DJAIL")
				--[[local scoreToGive=0.5
				if wantedPoints > 30 then scoreToGive=1 end
				if wantedPoints > 40 then scoreToGive=1.5 end
				if wantedPoints > 50 then scoreToGive=2 end
				if wantedPoints > 70 then scoreToGive=3 end
				if wantedPoints > 100 then scoreToGive=4 end
				exports.CSGscore:givePlayerScore(source,scoreToGive)--]]

				exports.NGCdxmsg:createNewDxMessage(thePrisoner, "You got jailed by ".. getPlayerName ( source ) .." for " .. jailTime .. " seconds", 225, 165, 0 )
				exports.NGCdxmsg:createNewDxMessage(source, "You jailed ".. getPlayerName ( thePrisoner ) .." for " .. jailTime .. " seconds and earned $" .. jailMoney .. ".", 0, 225, 0 )

				setElementData ( thePrisoner, "isPlayerArrested", false )
				setElementData ( source, "copArrestedCrim", false )

				onCheckForJailPoints ( source, false )
			end
		end
	end
end
addEventHandler("onJailArrestedPlayers", root, onJailArrestedPlayers)

-- Release player event
addEvent("onReleasePlayerFromArrest", true)
function onReleasePlayerFromArrest ( theCop )
	if ( arrestTable[theCop] ) then
		for i=1,#arrestTable[theCop] do
			local thePrisoner = arrestTable[theCop][i]
			if ( source ) and ( source == thePrisoner ) then
				exports.NGCdxmsg:createNewDxMessage(theCop, "You released ".. getPlayerName( thePrisoner ) .."!", 0, 225, 0)
				exports.NGCdxmsg:createNewDxMessage(thePrisoner, "You are now free! RUN!", 0, 225, 0)
				setElementData ( thePrisoner, "isPlayerArrested", false )
				setElementData ( theCop, "copArrestedCrim", false )
				toggleAllControls ( thePrisoner, true, true, true )
				removeCopArrestedPlayer ( theCop, thePrisoner )
				onCheckForJailPoints ( theCop, false )
				showCursor ( thePrisoner, false )
				clearPlayerTaserAssists(thePrisoner)
				---triggerClientEvent(thePrisoner,"releaseFromTheClient2",thePrisoner,theCop)
				triggerClientEvent(theCop,"releaseFromTheClient",theCop,thePrisoner)
				attempts[thePrisoner] = 0
			end
		end
	end
end
addEventHandler("onReleasePlayerFromArrest", root, onReleasePlayerFromArrest)

-- On element datachange
addEventHandler( "onElementDataChange", root,
	function ( theName )
		if ( theName == "Occupation" ) and ( getElementType(source) == "player" ) and ( getPlayerTeam( source ) ) then
			if not isPlayerLawEnforcer(source) then
				onReleasePlayerFromArrest ( source )
			end
		end
	end
)

-- Remove from bike
addEvent("onRemovePlayerFromBike", true)
function onRemovePlayerFromBike ( )
	if ( isElement( source ) ) then
		removePedFromVehicle ( source )
		exports.NGCdxmsg:createNewDxMessage( source, "You fell of your bike due too much damage!", 0, 225, 0)
	end
end
addEventHandler("onRemovePlayerFromBike", root, onRemovePlayerFromBike)

-- Give the cop some money after killing a wanted crim in water
addEventHandler( "onPlayerWasted", root,
function ( ammo, attacker, weapon, bodypart )
	if ( attacker ) and ( isElement( attacker ) ) and ( getElementType ( attacker ) == "player" ) then
		if not ( source == attacker ) and ( getPlayerTeam( attacker ) )then
			if isPlayerLawEnforcer(attacker) then
				if ( isElementInWater ( source ) ) and not isLaw(source) and getTeamName(getPlayerTeam(source)) ~= "Staff" then
				--if not isLaw(source) and getTeamName(getPlayerTeam(source)) ~= "Staff" then
					if not getElementData(source,"isPlayerf") then
						if getElementData(source,"wantedPoints") >= 10 then
							--if (exports.server:getPlayChatZone(source) == "LV") then return end
							--if (exports.server:getPlayChatZone(attacker) == "LV") then return end
							local chance = 0
							local wantedPoints = getElementData(source,"wantedPoints")
							local theReward = ( math.floor(tonumber(wantedPoints) * 200 / 2.1 ) )
							--givePlayerMoney( attacker, theReward )
							local theReward = math.min(theReward, 500000)
							exports.AURpayments:addMoney(attacker, theReward, "Custom", "Aurora Core", 0, "Jail Arrest")
							local jailTime = ( math.floor(tonumber(wantedPoints) * 100 / 34 ) )/2
							jailTime=jailTime-(jailTime*(chance/100))
							jailTime=math.floor(jailTime)
							jailTime = math.min(jailTime, 900)
							exports.NGCnote:addNote("Kill arrest","#FF0000[Jailed] #FFFFFFYou have been jailed by "..getPlayerName(attacker).." (Jailed by kill-arrest)",source,255,0,0,5000)
							exports.NGCnote:addNote("Kill arrest","#FF0000[Jailed] #FFFFFFYou have kill-arrested "..getPlayerName(source).." in water (Jailed by killing)",attacker,255,0,0,5000)
							exports.CSGadmin:setPlayerJailed ( false, source, false, jailTime, "FBI" )
							exports.DENstats:setPlayerAccountData ( attacker, "arrests", exports.DENstats:getPlayerAccountData ( attacker, "arrests" ) + 1 )
							exports.DENstats:setPlayerAccountData ( attacker, "arrestpoints", exports.DENstats:getPlayerAccountData ( attacker, "arrestpoints" ) + tonumber(wantedPoints) )
							exports.NGCdxmsg:createNewDxMessage( attacker, "You kill arrested "..getPlayerName(source).." you earned $"..theReward, 0, 255, 0)
						end
					end
				end
			end
		end
	end
end
)

-- Check if a player is a law player
local lawTeams = {
	"Government",
	"Military Forces",
	"Advanced Assault Forces",
}

function isPlayerLawEnforcer ( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

function isLaw( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

function dx(a,b,c,d,e) exports.NGCdxmsg:createNewDxMessage(a,b,c,d,e) end

function transfer(ps,cmd,crimname,copname)
	if isPlayerLawEnforcer(ps) then
		if (crimname) then
			if (copname) then
				local crim = exports.server:getPlayerFromNamePart(crimname)
				if isElement(crim) then
					local list = arrestTable[ps]
					local found = false
					for k,v in pairs(list) do if v == crim then found=true break end end
					if found == false then
						dx("You didn't arrest "..getPlayerName(crim)..", you can't transfer them!",255,0,0)
						return
					end
					local cop = exports.server:getPlayerFromNamePart(copname)
					if isElement(cop) then
						if cop ~= ps then
							if isPlayerLawEnforcer(cop) then
								local x,y,z = getElementPosition(cop)
								local x2,y2,z2 = getElementPosition(ps)
								if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 7 then
									for k,v in pairs(arrestTable[ps]) do
										if v == crim then
											if isTimer(antiSpam[v]) then
												exports.NGCdxmsg:createNewDxMessage(cop,"Please wait few seconds before you hit this prisoner again (Just escaped)",255,0,0)
											return false end
											table.remove(arrestTable[ps],k)
											if not(arrestTable[cop]) then arrestTable[cop] = {} end
											triggerClientEvent(crim, "onClientFollowTheCop", crim, cop, crim)
											clearPlayerTaserAssists(crim)
											--triggerClientEvent(crim,"releaseFromTheClient2",crim,cop)
											triggerClientEvent(cop,"releaseFromTheClient",cop,crim)
											attempts[crim] = 0
											table.insert(arrestTable[cop],crim)
											triggerClientEvent(cop,"onPlayerGetArrestTime",cop,crim)
											triggerClientEvent(crim,"onPrisonerGetArrestTime",crim,cop)
											--triggerClientEvent(crim,"releaseFromTheClient2",crim,ps)
											triggerClientEvent(ps,"releaseFromTheClient",ps,crim)
											attempts[crim] = 0
											setElementData( crim, "arrestedBy", cop )
											triggerEvent( "onPlayerArrest", crim, cop )
											onCheckForJailPoints ( cop, true )
											local arrestedTable = getCopArrestedPlayers(ps)
											if #arrestedTable <= 0 then
												onCheckForJailPoints ( ps, false )
											end
											dx(crim,"You have been transferred from officer "..getPlayerName(ps).." to officer "..getPlayerName(cop).."",255,255,0)
											dx(ps,"You have transferred "..getPlayerName(crim).." to officer "..getPlayerName(cop).."",0,255,0)
											dx(ps,""..getPlayerName(crim).." is no longer in your custody",0,255,0)
											dx(cop,"Officer "..getPlayerName(ps).." has transferred "..getPlayerName(crim).." into your custody",0,255,0)
											break
										end
									end
								else
									dx(ps,""..getPlayerName(cop).." is too far away, you can't transfer "..getPlayerName(crim).." to them",255,0,0)
								end
							else
								dx(ps,"The person you want to transfer to is not a law enforcer",255,0,0)
							end
						else
							dx(ps,"You can't transfer someone to yourself",255,0,0)
						end
					else
						dx(ps,"The police officer "..copname.." cannot be found",255,0,0)
					end
				else
					dx(ps,"The player "..crimname.." cannot be found",255,0,0)
				end
			else
				dx(ps,"You didn't enter the name of the police to transfer to",255,0,0)
				dx(ps,"Usage: /arrtransfer criminalName copName",255,0,0)
			end
		else
			dx(ps,"You didn't enter the name of the person you want to transfer",255,0,0)
			dx(ps,"Usage: /arrtransfer criminalName copName",255,0,0)
		end
	end
end
addCommandHandler("arrtransfer",transfer)
addCommandHandler("arrt",transfer)

--handle isPlayerArrested change--
function onDataChange(name,_value)
	if not (getElementType(source) == "player") then
		return
	end
	if (name == "isPlayerArrested") then
		------outputDebugString("Arrested data changed.")
		if (getElementData(source,"isPlayerArrested") == false) then
			------outputDebugString("Data confirmed.")
			for cop,value in ipairs(arrestTable) do
				if (value == source) then
					table.remove ( arrestTable[cop], value )
					break
				end
			end
			showCursor(source,false)
			setControlState(source,"sprint",false)
			setControlState(source,"walk",false)
			setControlState(source,"jump",false)
			toggleAllControls(source,true,true,true)
		else
			return false
		end
	else
		return false
	end
end
addEventHandler("onElementDataChange",root,onDataChange)
