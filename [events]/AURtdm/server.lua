addNewRound = false
team1 = {}
team2 = {}
minTeam1 = 5
minTeam2 = 5
inTeam = {}
maxTeam1 = 10
maxTeam2 = 10
crimTable = {}
lawTable = {}
wasEventStarted = true
quickDelay = {}
timeOut = {}
round = 1
crims = {}
laws = {}
addedRound = false
isEventTimedout = false
round1 = ""
round2 = ""
round3 = ""
team1Win = 0
team2Win = 0
sameTarget = {}
iwontfuck = {}
skins = {}
saveTeams = {}
markerTeam1 = createMarker(1129.0963134766,-2004.5347900391,68,"cylinder",3,255,0,0)
markerTeam2 = createMarker(1127.5753173828,-2074.3793945313,68,"cylinder",3,0,100,200)
theColTeam1 = createColCircle(1129.0963134766,-2004.5347900391,2)
theColTeam2 = createColCircle(1127.5753173828,-2074.3793945313,2)
--markerExit1 = createMarker(288.82180786133,166.92359924316,1008.5,"arrow",2,255,255,0)
--markerExit2 = createMarker(238.71691894531,138.63879394531,1004.5,"arrow",2,255,255,0)
setElementData(markerTeam1,"CSGO","Terrorists")
setElementData(markerTeam2,"CSGO","Counter-Terrorists")
red = 0
blue = 0
createTeam("CS:GO",0,175,0)
startingTime = {}
noevent = false



addEventHandler( "onPlayerDamage", root,
function ( wep,theAttacker )
	if ( isElement( source ) ) and ( isElement( theAttacker ) ) then
		if ( getElementType(theAttacker) == "player" ) and getElementType(source) == "player" then
			if ( getPlayerTeam( source ) ) and ( getPlayerTeam( theAttacker ) ) then
				if getElementDimension(source) ~= 1001 then return false end
				if ( getElementData ( source, "CS:GO" ) ) or ( getElementData ( source, "isPlayerinLobby" ) ) then
					if getElementData(theAttacker,"CS:GO Team") == getElementData(source,"CS:GO Team") then
						cancelEvent()
					end
				end
			end
		end
	end
end
)

function handleTeam(sta,p)
	--[[if sta == "Empty" then
		for k,v in ipairs(getElementsByType("player")) do
			if getPlayerTeam(v) and getTeamName(getPlayerTeam(v)) == "CS:GO" then
				setPlayerTeam(v,getTeamFromName(saveTeams[v] or "Unemployed"))
				setElementData(v,"Occupation",saveTeams[v] or "Unemployed")
				local r,g,b = getTeamColor(getPlayerTeam(v))
				setPlayerNametagColor(v,r,g,b)
			end
		end
	elseif sta == "remove" and p then
		if getPlayerTeam(p) and getTeamName(getPlayerTeam(p)) == "CS:GO" then
			setPlayerTeam(p,getTeamFromName(saveTeams[p] or "Unemployed"))
			setElementData(p,"Occupation",saveTeams[p] or "Unemployed")
			local r,g,b = getTeamColor(getPlayerTeam(p))
			setPlayerNametagColor(p,r,g,b)
		end
	end]]
	if p and isElement(p) and getElementType(p) == "player" then
	if getPlayerTeam(p) and getTeamName(getPlayerTeam(p)) == "CS:GO" then
		setPlayerTeam(p,getTeamFromName(saveTeams[p] or "Unemployed"))
		setElementData(p,"Occupation",saveTeams[p] or "Unemployed")
		local r,g,b = getTeamColor(getPlayerTeam(p))
		setPlayerNametagColor(p,r,g,b)
	end
	end
end

function isTeam1Allive()
	local aliveCriminals = 0
	---local CriminalsCount = {}
	for k,v in ipairs(crims) do
		if v and isElement(v) then
			if getElementData(v,"CS:GO") then
				if getElementData(v,"CS:GO Team") == "Terrorists" then
					if getElementDimension(v) == 1001 then
						if getElementData(v,"Occupation") ~= "Dead" then
							--table.insert(aliveCriminals,v)
							aliveCriminals = aliveCriminals + 1
						end
					---	table.insert(CriminalsCount,v)
					end
				end
			end
		end
	end
	----outputDebugString("TERR it should be this "..aliveCriminals)
	return tonumber(aliveCriminals)
end

function isTeam2Allive()
	local aliveLaw = 0
	--local lawCount = {}
	for k,v in ipairs(laws) do
		if v and isElement(v) then
			if getElementData(v,"CS:GO") then
				if getElementData(v,"CS:GO Team") == "Counter-Terrorists" then
					if getElementDimension(v) == 1001 then
						if getElementData(v,"Occupation") ~= "Dead" then
							--table.insert(aliveLaw,v)
							aliveLaw = aliveLaw+1
						end
						--table.insert(lawCount,v)
					end
				end
			end
		end
	end
	----outputDebugString("CTERR it should be this "..aliveLaw)
	return tonumber(aliveLaw)
end

addCommandHandler("alivecsgo",function(p)
	for k,v in ipairs(laws) do
		if v and isElement(v) then
			if getElementData(v,"CS:GO") then
				if getElementData(v,"CS:GO Team") == "Counter-Terrorists" then
					if getElementDimension(v) == 1001 then
						if getElementData(v,"Occupation") ~= "Dead" then
							exports.NGCdxmsg:createNewDxMessage(p,"Alive Counter Terrorists: "..getPlayerName(v),255,255,255)
						end
					end
				end
			end
		end
	end
	for k,v in ipairs(crims) do
		if v and isElement(v) then
			if getElementData(v,"CS:GO") then
				if getElementData(v,"CS:GO Team") == "Terrorists" then
					if getElementDimension(v) == 1001 then
						if getElementData(v,"Occupation") ~= "Dead" then
							exports.NGCdxmsg:createNewDxMessage(p,"Alive Terrorists: "..getPlayerName(v),255,255,255)
						end
					end
				end
			end
		end
	end
end)

function getValidCount()
	local team1Count,Team1Tbl = getTeam1Count()
	local team2Count,Team2Tbl = getTeam2Count()
	for k,v in ipairs(Team1Tbl) do
		if v and isElement(v) then
			exports.NGCdxmsg:createNewDxMessage(v,"(CS:GO TDM) : Terrorists ("..team1Count.."/"..minTeam1..") | Counter Terrorists ("..team2Count.."/"..minTeam2..")",0,225,0)
		end
	end
	for k,v in ipairs(Team2Tbl) do
		if v and isElement(v) then
			exports.NGCdxmsg:createNewDxMessage(v,"(CS:GO TDM) : Terrorists ("..team1Count.."/"..minTeam1..") | Counter Terrorists ("..team2Count.."/"..minTeam2..")",0,225,0)
		end
	end
end
delayisStarted = false
function checkTeam()
	--exports.NGCdxmsg:createNewDxMessage(root,"(CS:GO TDM) : Terrorists ("..#team1.."/"..minTeam1..") | Counter Terrorists ("..#team2.."/"..minTeam2..")",0,225,0)
	getValidCount()
	if wasEventStarted == false then
		local team1Count,Team1Tbl = getTeam1Count()
		local team2Count,Team2Tbl = getTeam2Count()
		if team1Count >= minTeam1 and team2Count >= minTeam2 then
			--if team1Count == team2Count then
				--- each team has got min
				if delayisStarted == true then
					return false
				end
				if isTimer(quickDelay) then return false end
				for k,v in ipairs(Team1Tbl) do
					if v and isElement(v) then
						msg(v,"Event will be started within 5 seconds")
					end
				end
				for k,v in ipairs(Team2Tbl) do
					if v and isElement(v) then
						msg(v,"Event will be started within 5 seconds")
					end
				end
				quickDelay = setTimer(function()
					local team1Count,Team1Tbl = getTeam1Count()
					local team2Count,Team2Tbl = getTeam2Count()
					if team1Count >= minTeam1 and team2Count >= minTeam2 then
						--if team1Count == team2Count then
							delayisStarted = true
							local _,theTeam1 = getTeam1Count()
							for k,v in ipairs(theTeam1) do
								if v and isElement(v) then
									for k3,v3 in ipairs(crims) do
										if v == v3 then
											table.remove(crims,k)
											break
										end
									end
									if getElementDimension(v) == 0 then
										if setElementDimension(v,1001) then
											table.insert(crims,v)
											setElementPosition(v,495.19378662109,-2424.1525878906,6.8939943313599)
											local x,y,z = getElementPosition(v)
											setElementPosition(v,x+math.random(0,1),y,z)
											setPedRotation(v,265)
											setElementHealth(v,200)
											setPedArmor(v,100)
											saveTeams[v] = getTeamName(getPlayerTeam(v))
											setElementData(v,"TDMskin",getElementModel(v))
											setElementModel(v,182)
											msg(v,"Round 1 Ok lets go...")
											setElementData(v,"CS:GO",true)
											toggleControl(v,"sprint",false)
											setElementData(v,"isPlayerinLobby",false)
											setElementData(v,"CS:GO Team","Terrorists")
											setPlayerTeam(v,getTeamFromName("CS:GO"))
											setPlayerNametagColor(v,255,0,0)
											setElementData(v,"Occupation","Terrorists")
											playsound(3,v)
											iwontfuck[v] = false
										end
									end
								end
							end
							local _,theTeam2 = getTeam2Count()
							for k,v in ipairs(theTeam2) do
								if v and isElement(v) then
									for k3,v3 in ipairs(laws) do
										if v == v3 then
											table.remove(laws,k)
											break
										end
									end
									if getElementDimension(v) == 0 then
										if setElementDimension(v,1001) then
											table.insert(laws,v)
											setElementPosition(v,530.06420898438, -2362.6376953125, 1.6939941644669)
											local x,y,z = getElementPosition(v)
											setElementPosition(v,x+math.random(0,1),y,z)
											setPedRotation(v,178.52258300781)
											setElementHealth(v,200)
											setPedArmor(v,100)
											saveTeams[v] = getTeamName(getPlayerTeam(v))
											setElementData(v,"TDMskin",getElementModel(v))
											setElementModel(v,151)
											toggleControl(v,"sprint",false)
											msg(v,"Round 1 Ok lets go...")
											setElementData(v,"isPlayerinLobby",false)
											setElementData(v,"CS:GO",true)
											setElementData(v,"CS:GO Team","Counter-Terrorists")
											setPlayerTeam(v,getTeamFromName("CS:GO"))
											setPlayerNametagColor(v,0,100,200)
											setElementData(v,"Occupation","Counter-Terrorists")
											playsound(3,v)
											iwontfuck[v] = false
										end
									end
								end
							end
							red = team1Count
							blue = team2Count
							wasEventStarted = true
							round = 1
							addNewRound = false
							addRoundTime()
						--else
						--	checkTeam()
						--end
					end
				end,10000,1)
			--end
		end
	end
end

function addRoundTime()
	isEventTimedout = false
	if isTimer(timeOut) then return false end
	timeOut = setTimer(function()
		if addNewRound == true then return false end
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v,"CS:GO") then
				--removePlayer(v,false)
				playsound(1,v)
				msg(v,"Round timed out, Terrorists won")
			end
		end
		forceTerror()
	end,(60 * 1000 * 10),1)
	updateRoundClock()
	addNewRound = false
end

function updateRoundClock()
	if isTimer(timeOut) then
		local l,e,m = getTimerDetails(timeOut)
		triggerClientEvent("CS:GO RoundTime",root,l,round,team1Win,team2Win)
		if isTimer(loopTimer) then killTimer(loopTimer) end
		loopTimer = setTimer(updateRoundClock,1000,1)
	end
end

function getTeam1Count()
	local cInMarker = { }
	local rbmColShape = getElementColShape ( markerTeam1 )
	local pInMarker = getElementsWithinColShape ( rbmColShape , "player" )
	for index , player in ipairs ( pInMarker ) do
		if canIEnter(player,1) then
			table.insert ( cInMarker, player )
		end
	end
	return #cInMarker,cInMarker
end

function isPlayerInCSGO(p)
	local t1,t2 = getTeam1Count()
	local t3,t4 = getTeam2Count()
	for k,v in ipairs(t2) do
		if v == p then
			return true
		end
	end
	for k,v in ipairs(t4) do
		if v == p then
			return true
		end
	end
	return false
end

function getTeam2Count()
	local cInMarker = { }
	local rbmColShape = getElementColShape ( markerTeam2 )
	local pInMarker = getElementsWithinColShape ( rbmColShape , "player" )
	for index , player in ipairs ( pInMarker ) do
		if canIEnter(player,2) then
			table.insert ( cInMarker, player )
		end
	end
	return #cInMarker,cInMarker
end




addEventHandler("onMarkerLeave",root,function(hit,dim)
	if source == markerTeam1 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" then
			if wasEventStarted == false then
				checkTeam()
			end
		end
	elseif source == markerTeam2 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" then
			if wasEventStarted == false then
				checkTeam()
			end
		end
	end
end)

addEventHandler("onMarkerHit",root,function(hit,dim)
	if source == markerTeam1 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" then
			checkTeam()
			local team1Count,Team1Tbl = getTeam1Count()
			local team2Count,Team2Tbl = getTeam2Count()
			exports.NGCdxmsg:createNewDxMessage(hit,"(CS:GO TDM) : Terrorists ("..team1Count.."/"..minTeam1..") | Counter Terrorists ("..team2Count.."/"..minTeam2..")",0,225,0)
		end
	elseif source == markerTeam2 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" then
			checkTeam()
			local team1Count,Team1Tbl = getTeam1Count()
			local team2Count,Team2Tbl = getTeam2Count()
			exports.NGCdxmsg:createNewDxMessage(hit,"(CS:GO TDM) : Terrorists ("..team1Count.."/"..minTeam1..") | Counter Terrorists ("..team2Count.."/"..minTeam2..")",0,225,0)
		end
	end
end)

addEventHandler("onPlayerQuit",root,function()
	removePlayer(source,false)
	if getElementDimension(source) == 1001 then
			setElementDimension(source,0)
			setElementPosition(source,1133.5048828125,-2038.3996582031,69.0078125)
			if laws then
				for k,v in ipairs(laws) do
					if v == source then
						table.remove(laws,k)
						break
					end
				end
			end
			if crims then
				for k,v in ipairs(crims) do
					if v == source then
						table.remove(crims,k)
						break
					end
				end
			end
			if crimTable then
				for k,v in ipairs(crimTable) do
					if v == source then
						table.remove(crimTable,k)
						break
					end
				end
			end
			if lawTable then
				for k,v in ipairs(lawTable) do
					if v == source then
						table.remove(lawTable,k)
						break
					end
				end
			end
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if getElementData(source,"CS:GO") then
		if round < 3 then
			setElementData(source,"isPlayerinLobby",true)
			setElementFrozen(source,true)
			return false
		end
		local team = getElementData(source,"CS:GO Team")
		if team == "Terrorists" then
			red = red - 1
			if red < 0 then red = 0 end
		elseif team == "Counter-Terrorists" then
			blue = blue - 1
			if blue < 0 then
				blue = 0
			end
		end
		handleTeam("remove",source)
		setElementData(source,"CS:GO",false)
		---setElementData(source,"CS:GO Team",false)
		if getElementDimension(source) == 1001 then
			setElementDimension(source,0)
			setElementPosition(source,1133.5048828125,-2038.3996582031,69.0078125)
			local x,y,z = getElementPosition(source)
			setElementPosition(source,x+math.random(0,1),y,z)
			setPedRotation(source,276)
		end
		if not getElementData(source,"TDMskin") then
			setElementData(source,"TDMskin",0)
			exports.NGCdxmsg:createNewDxMessage(source,"Sorry we couldn't find your skin",255,0,0)
		end
		setElementModel(source,getElementData(source,"TDMskin"))
		setElementData(source,"TDMskin",false)
	end
end)

addEventHandler("onPlayerSpawn",root,function()
	if getElementData(source,"CS:GO") then
		if getElementData(source,"isPlayerinLobby") then
			setElementFrozen(source,false)
			setElementDimension(source,1001)
			triggerEvent("CS_Lobby",source)
		end
	end
end)

addEventHandler("onSetPlayerJailed",root,function()
	if getElementData(source,"CS:GO") then
		removePlayer(source,false)
		exports.NGCdxmsg:createNewDxMessage(source,"You have been removed from this Event, due you are Jailed!!",255,0,0)
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		removePlayer(v,false)
		setElementData(v,"CS:GO Team",false)
		setElementData(v,"CS:GO LastRound",false)
		setElementData(v,"isPlayerinLobby",false)
	end
	startingTime = setTimer(function() wasEventStarted = false end,(60 * 1000 * 10),1)
end)

addCommandHandler("csgotime",function(p,cmd,n)
	if getElementData(p,"isPlayerPrime") then
	if isTimer(startingTime) then killTimer(startingTime) end
	startingTime = setTimer(function() wasEventStarted = false end,(60 * 1000 * n),1)
	end
end)

addEventHandler("onServerPlayerLogin",root,function()
	if getPlayerTeam(source) and getTeamName(getPlayerTeam(source)) == "CS:GO" then
		removePlayer(source,false)
	end
end)


function onCalcTimer ( theTime )
	if ( theTime >= 60000 ) then
		local plural = ""
		if ( math.floor((theTime/1000)/60) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)/60) .. " minute" .. plural)
	else
		local plural = ""
		if ( math.floor((theTime/1000)) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)) .. " second" .. plural)
	end
end

showTime = function( thePlayer )
	if exports.server:isPlayerLoggedIn(thePlayer) then
		local robType = "(CS:GO)"
		if ( isTimer(startingTime) ) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails(startingTime)
			msg( thePlayer, "Time left until next mission: " .. onCalcTimer ( math.floor( timeLeft ) ) .. " "..robType, 225, 0, 0 )
		elseif not isTimer(startingTime) and wasEventStarted == false then
			msg(thePlayer,robType.." is ready at LS white house!")
		elseif wasEventStarted == true then
			msg(thePlayer,robType.." in progress")
		else
			msg( thePlayer, "There is no mission here anytime soon! "..robType)
		end
	end
end
addCommandHandler ( "csgo",showTime)

addEventHandler("onResourceStop",resourceRoot,function()
	handleTeam("Empty",nil)
end)


function removePlayer(player,status)
	if player and isElement(player) then
		if getElementData(player,"CS:GO") then
			local team = getElementData(player,"CS:GO Team")
			if team == "Terrorists" then
				red = red - 1
				if red < 0 then red = 0 end
			elseif team == "Counter-Terrorists" then
				blue = blue - 1
				if blue < 0 then blue = 0 end
			end
			toggleControl(player,"sprint",true)
			handleTeam("remove",player)
			setElementData(player,"CS:GO",false)
			--setElementData(player,"CS:GO Team",false)
			if getElementDimension(player) == 1001 then
				setElementDimension(player,0)
				setElementPosition(player,1133.5048828125,-2038.3996582031,69.0078125)
				local x,y,z = getElementPosition(player)
				setElementPosition(player,x+math.random(0,1),y,z)
				setPedRotation(player,276)
				setElementData(player,"CS:GO LastRound",false)
				setElementData(player,"isPlayerinLobby",false)
			end
			if not getElementData(player,"TDMskin") then
				setElementData(player,"TDMskin",0)
				exports.NGCdxmsg:createNewDxMessage(player,"Sorry we couldn't find your skin",255,0,0)
			end
			setElementModel(player,getElementData(player,"TDMskin"))
			setElementData(player,"TDMskin",false)
			if laws then
				for k,v in ipairs(laws) do
					if v == player then
						table.remove(laws,k)
						break
					end
				end
			end
			if crims then
				for k,v in ipairs(crims) do
					if v == player then
						table.remove(crims,k)
						break
					end
				end
			end
			if status ~= true then
				if crimTable then
					for k,v in ipairs(crimTable) do
						if v == player then
							table.remove(crimTable,k)
							break
						end
					end
				end
				if lawTable then
					for k,v in ipairs(lawTable) do
						if v == player then
							table.remove(lawTable,k)
							break
						end
					end
				end
			end
			if #lawTable == 0 and #crimTable == 0 and #crims == 0 and #laws == 0 then
				stopEvent()
			end
		end
	end
end

function canIEnter(player,way)
	if noevent then
		msg(player,"Iphone is not here, you cant touch this event!")
		return false
	elseif isTimer(startingTime) then
		msg(player,"You can't enter at the moment event didn't start yet Check /csgo")
		return false
	elseif wasEventStarted == true then
		msg(player,"You can't enter at the moment event in progress")
		return false
	elseif isPedInVehicle(player) then
		msg(player,"You can't enter while you're inside a vehicle")
		return false
	elseif way == 1 and exports.DENlaw:isLaw(player) then
		msg(player,"You can't enter from here because you are Law")
		return false
	elseif way == 2 and getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) == "Criminals" then
		msg(player,"You can't enter from here because you are a criminal")
		return false
	elseif way == 1 and #team1 >= maxTeam1 then
		msg(player,"You can't enter from here due this team is already full")
		return false
	elseif way == 2 and #team2 >= maxTeam2 then
		msg(player,"You can't enter from here due this team is already full")
		return false
	elseif exports.AURgames:isPlayerSigned(player) then
		msg(player,"You can't enter while you are signed up in another event")
		return false
	elseif getElementDimension(player) ~= 0 then
		msg(player,"You can't enter while you are in another dimension")
		return false
	elseif getElementInterior(player) ~= 0 then
		msg(player,"You can't enter while you are in inside interior")
		return false
	elseif getElementData(player,"isPlayerArrested") then
		msg(player,"You can't enter while you are arresed")
		return false
	elseif getElementData(player,"isPlayerJailed") then
		msg(player,"You can't enter while you are Jailed")
		return false
	elseif getElementData(player,"isPlayerFlagger") then
		msg(player,"You can't enter while you are Jailed")
		return false
	--elseif getTeamName(getPlayerTeam(player)) ~= "Tester" then
	--	msg(player,"You can't enter CS:GO TDM Under development (Tester Team only)")
	--	return false
	else
		return true
	end
end
me = {}
pleaselol = {}
function msg(p,msg)
	if pleaselol[p] == msg then return false end
	pleaselol[p] = msg
	me[p] = setTimer(function(t) pleaselol[t] = false end,1500,1,p)
	exports.NGCdxmsg:createNewDxMessage(p,"CS:GO TDM: "..msg,255,150, 0)
	exports.NGCnote:addNote("JoinCS:GO", "CS:GO TDM: #FFFFFF"..msg, p, 255, 0, 0,5000 )
end
addEvent("CS_Lobby",true)
addEventHandler("CS_Lobby",root,function(killer)
	--[[if round >= 3 then
		-- get winner team
		killPed(source)
		----outputDebugString(getPlayerName(source).." round 3 is finished and you dead")
		return false
	end]]
	if isEventTimedout then return false end
	if iwontfuck[source] then return false end
	if getElementData(source,"CS:GO") then
		if round < 3 then
			iwontfuck[source] = true
			msg(source,"You are moved to Lobby please wait for next round")
			setElementData(source,"isPlayerinLobby",true)
			setElementData(source,"Occupation","Dead")
			setElementPosition(source,554.84930419922,-2324.2561035156,28.74843788147)
			local x,y,z = getElementPosition(source)
			setElementPosition(source,x+math.random(0,1),y,z)
			if isTimer(den) then killTimer(den) end
			den = setTimer(controlPoint,2000,1,false)
		else
			iwontfuck[source] = true
			if isTimer(den) then killTimer(den) end
			removePlayer(source,true)
			----outputDebugString("looping delay check after player die")
			den = setTimer(controlPoint,2000,1,true)
		end
		iwontfuck[source] = true
		if killer and isElement(killer) then
			local killteam = getElementData(killer,"CS:GO Team")
			local killteam2 = getElementData(source,"CS:GO Team")
			if killteam == killteam2 then
				return
			end
			if killteam == "Terrorists" then
				r,g,b = 255,0,0
				r2,g2,b2 = 0,100,200
			end
			if killteam == "Counter-Terrorists" then
				r,g,b = 0,100,200
				r2,g2,b2 = 255,0,0
			end
			if sameTarget[killer] == source then return false end
			if getElementData(killer,"CS:GO Team") ~= getElementData(source,"CS:GO Team") then
				sameTarget[killer] = source
				exports.killmessages:outputKillMessage ( source, r2,g2,b2,killer,r,g,b,getPedWeapon(killer) )
			end
		end
	end
end)

function forceTerror()
	if addNewRound == true then return false end
	if round == 1 then
		round1 = "Terrorists"
		team1Win = team1Win+1
	elseif round == 2 then
		round2 = "Terrorists"
		team1Win = team1Win+1
	elseif round == 3 then
		round3 = "Terrorists"
		team1Win = team1Win+1
	end
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 1001 and getElementData(v,"CS:GO") then
			if round == 1 then
				msg(v,round1.." has won the round (Timed out)")
			elseif round == 2 then
				msg(v,round2.." has won the round (Timed out)")
			elseif round == 3 then
				msg(v,round3.." has won the round (Timed out)")
			end
		end
	end
	if round < 3 then
		delayCheck(false)
		isEventTimedout = true
		for k,v in ipairs(crims) do
			fadeCamera(v,false)
		end
		for k,v in ipairs(laws) do
			fadeCamera(v,false)
		end
	else
		if #crims == 0 and #laws == 0 then
		else
			for k,v in ipairs(getElementsByType("player")) do
				if getElementDimension(v) == 1001 and getElementData(v,"CS:GO") then
					if round == 3 then
						msg(v,"Round 3 has no time out unless there are no players inside, kill the other team!!")
					end
				end
			end
		end
	end
	if #crims == 0 and #laws == 0 then
		stopEvent()
	end
	if isTimer(den) then killTimer(den) end
end

ProTimer = {}
darkness = {}
function controlPoint(state)
	--[[local t = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 1001 and getElementData(v,"CS:GO Team") then
			table.insert(t,v)
		end
	end
	local rap = {}
	local rap2 = {}
	for k,v in ipairs(t) do
		if getElementDimension(v) == 1001 and getElementData(v,"CS:GO Team") then
			if getElementData(v,"isPlayerinLobby") then
				local team = getElementData(v,"CS:GO Team")
				if team == "Terrorists" then
					table.insert(rap,v)
				end
				if team == "Counter-Terrorists" then
					table.insert(rap2,v)
				end
			end
		end
	end]]
	--if (#rap == red) or (#rap2 == blue) then
	Terror = isTeam1Allive()
	CounterTerror = isTeam2Allive()
	if isTimer(ProTimer) then killTimer(ProTimer) end
	ProTimer = setTimer(function(Terror,CounterTerror)
		if (Terror > 0) or (CounterTerror > 0) then
			----outputDebugString("After timer : "..Terror.." and CT "..CounterTerror)
				if (Terror == 0) and (CounterTerror >= 1) then
					----outputDebugString("After timer : CT WON")
					if round == 1 then
						round1 = "Counter-Terrorists"
						team2Win = team2Win+1
						playsound(2,nil)
					elseif round == 2 then
						round2 = "Counter-Terrorists"
						team2Win = team2Win+1
						playsound(2,nil)
					elseif round == 3 then
						round3 = "Counter-Terrorists"
						team2Win = team2Win+1
					else
						----outputDebugString("I have got the number of round failed")
					end
					----outputDebugString("CT should win")
				end
				if (tonumber(CounterTerror) == 0) and (tonumber(Terror) >= 1) then
					----outputDebugString("After timer : TERROR WON")
					if round == 1 then
						round1 = "Terrorists"
						team1Win = team1Win+1
						----outputDebugString("Check if this gives Win "..round1.." points "..team1Win)
						playsound(1,nil)
					elseif round == 2 then
						round2 = "Terrorists"
						team1Win = team1Win+1
						----outputDebugString("Check if this gives Win "..round2.." points "..team1Win)
						playsound(1,nil)
					elseif round == 3 then
						round3 = "Terrorists"
						team1Win = team1Win+1
						----outputDebugString("Check if this gives Win "..round3.." points "..team1Win)

						----outputDebugString("I have got the number of round failed")
					end
					----outputDebugString("Terrorists should win")
				end
				----outputDebugString(round1)
				if (CounterTerror > 0 and Terror == 0) or (Terror > 0 and CounterTerror == 0) then
					----outputDebugString("After timer : Adding checks")
					if isTimer(darkness) then killTimer(darkness) end
					darkness = setTimer(delayCheck,1000,1,state)
					----outputDebugString("Being adding checking for round winner")
				end
		else
			stopEvent()
			----outputDebugString("Blue and RED has no such value with rap")
		end
	end,1000,1,Terror,CounterTerror)
end

function delayCheck(final)
	if team1Win == 0 and team2Win == 0 then
		----outputDebugString("Damn win both team are 0")
		return
	end
	----outputDebugString("Winnings for team1 is "..team1Win)
	----outputDebugString("Winnings for team2 is "..team2Win)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 1001 and getElementData(v,"CS:GO") then
			if round == 1 then
				msg(v,round1.." has won the round")
			elseif round == 2 then
				msg(v,round2.." has won the round")
			elseif round == 3 then
				msg(v,round3.." has won the round")
			end
		end
	end
	if final then
		if isTimer(who) then killTimer(who) end
		----outputDebugString("Before who timer")
		who = setTimer(function()
			----outputDebugString(#crims.." and "..#laws)
			--[[if #crims == 0 then
				checkWinner()
			elseif #laws == 0 then
				checkWinner()
			else
				for k,v in ipairs(lawTable) do
					if v and isElement(v) then
						msg(v,"None won (DRAW)")
					end
				end
				for k,v in ipairs(crimTable) do
					if v and isElement(v) then
						msg(v,"None won (DRAW)")
					end
				end
			end]]
			checkWinner()
			----outputDebugString("Final check "..#crims.." crims and "..#laws)
		end,5000,1)
	else
		if addedRound then return false end
		addedRound = true
		if round >= 3 then
		--	checkWinner()
			----outputDebugString("Here idk why returned")
			return false
		end
		round = round + 1
		if isTimer(locs) then killTimer(locs) end
		locs = setTimer(addRound,2000,1)
		----outputDebugString("Here i found count of all joined")
	end
end
noob = {}
local gotmoney = {}
function checkWinner()
	local t = {}
	if wasEventStarted then
		----outputDebugString("Start checking")
		if round1 ~= "" and round2 ~= "" then
			if team1Win >= 2 or team2Win >= 2 then
				if team1Win >= 2 then
					for k,v in ipairs(crimTable) do
						if v and isElement(v) then
							if gotmoney[v] == true then

							else
								gotmoney[v] = true
								msg(v,"Terrorists Won + $20,000")
								playsound(1,v)
								exports.AURpayments:addMoney(v,20000,"Custom","Event",0,"AURtdm CSGO Terr")
							end
						end
					end
					for k,v in ipairs(lawTable) do
						if v and isElement(v) then
							msg(v,"Terrorists Won "..team1Win.." rounds")
							playsound(1,v)
						end
					end
					----outputDebugString("Terrorists Won + $20,000")
				elseif team2Win >= 2 then
					for k,v in ipairs(lawTable) do
						if v and isElement(v) then
							if gotmoney[v] == true then

							else
								gotmoney[v] = true
								msg(v,"Counter-Terrorists Won + $20,000")
								playsound(2,v)
								exports.AURpayments:addMoney(v,20000,"Custom","Event",0,"AURtdm CSGO C-Terr")
							end
						end
					end
					for k,v in ipairs(crimTable) do
						if v and isElement(v) then
							msg(v,"Counter-Terrorists Won "..team2Win.." rounds")
							playsound(2,v)
						end
					end
					----outputDebugString("Counter-Terrorists Won + $20,000")
				else
					----outputDebugString("Error on count winner CSGO")
				end
				if isTimer(noob) then killTimer(noob) end
				noob = setTimer(function()
					for k,v in ipairs(crimTable) do
						removePlayer(v,true)
					end
					for k,v in ipairs(lawTable) do
						removePlayer(v,true)
					end
					----outputDebugString("Here we closed the tables")
				end,5000,1)
				stopEvent()
			else
				for k,v in ipairs(lawTable) do
					removePlayer(v,false)
					----outputDebugString("this is draw")
				end
				for k,v in ipairs(crimTable) do
					removePlayer(v,false)
					----outputDebugString("this is draw")
				end
				stopEvent()
			end
		end
	end
end

--2228.4328613281,-1159.3023681641,25.792255401611,276.98931884766
function addRound()
	local sen = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 1001 and getElementData(v,"CS:GO Team") then
			table.insert(sen,v)
		end
	end
	for k,v in ipairs(sen) do
		if v and isElement(v) and getElementDimension(v) == 1001 and getElementData(v,"CS:GO Team") then
			msg(v,"Round "..round.." ok lets go..")
			exports.NGCdxmsg:createNewDxMessage(v,"(CS:GO TDM) : Round "..round.." ok lets go..",0,255,0)
			local team = getElementData(v,"CS:GO Team")
			addNewRound = true
			if isTimer(timeOut) then killTimer(timeOut) end
			addRoundTime()
			for k,v in ipairs(getElementsByType("player")) do
				if getElementDimension(v) == 1001 then
					setElementData(v,"isPlayerinLobby",false)
				end
			end
			if team == "Terrorists" then
				setElementDimension(v,1001)
				setElementPosition(v,495.19378662109,-2424.1525878906,6.8939943313599)
				local x,y,z = getElementPosition(v)
				setElementPosition(v,x+math.random(0,1),y,z)
				setPedRotation(v,265)
				setElementHealth(v,200)
				setPedArmor(v,100)
				setElementModel(v,182)
				playsound(3,v)
				sameTarget[v] = nil
				iwontfuck[v] = false
				setElementData(v,"isPlayerinLobby",false)
				setElementData(v,"Occupation",team)
				if not inTeam[v] or inTeam[v] == false or inTeam[v] == nil then
					table.insert(crimTable,v)
					inTeam[v] = true
				end
				if round > 2 then
					if getElementData(v,"CS:GO LastRound") then return false end
					setElementData(v,"CS:GO LastRound",true)
					----outputDebugString("This is last round")
					setElementPosition(v,506.34030151367,-2423.3403320313,8.093994140625)
					local x,y,z = getElementPosition(v)
					setElementPosition(v,x+math.random(0,1),y,z)
					--if isTimer(timeOut) then killTimer(timeOut) end
				end
			elseif team == "Counter-Terrorists" then
				setElementDimension(v,1001)
				setElementPosition(v,530.06420898438, -2362.6376953125, 1.6939941644669)
				local x,y,z = getElementPosition(v)
				setElementPosition(v,x+math.random(0,1),y,z)
				setPedRotation(v,178.52258300781)
				setElementHealth(v,200)
				setPedArmor(v,100)
				setElementModel(v,151)
				playsound(3,v)
				sameTarget[v] = nil
				iwontfuck[v] = false
				--[[if inTeam[v] then
					setElementPosition(v,530.06420898438, -2362.6376953125, 1.6939941644669)
				else
					inTeam[v] = true
					table.insert(laws,v)
					----outputDebugString(getPlayerName(v).." in lobby table")
					setElementPosition(v,530.06420898438, -2362.6376953125, 1.6939941644669)
				end]]
				setElementData(v,"Occupation",team)
				if not inTeam[v] or inTeam[v] == false or inTeam[v] == nil then
					table.insert(lawTable,v)
					inTeam[v] = true
				end
				----outputDebugString(#crimTable)
				----outputDebugString(#lawTable)
				if round > 2 then
					if getElementData(v,"CS:GO LastRound") then return false end
					setElementData(v,"CS:GO LastRound",true)
					----outputDebugString("This is last round")
					setElementPosition(v,530.06420898438, -2362.6376953125, 1.6939941644669)
					local x,y,z = getElementPosition(v)
					setElementPosition(v,x+math.random(0,1),y,z)
					--if isTimer(timeOut) then killTimer(timeOut) end
				end
			else
				msg(v,"ERROR Team not listed!")
			end
			fadeCamera(v,true)
		else
			----outputDebugString("Got problem ")
		end
	end
	addedRound = false
end
re = {}
function stopEvent()
	if isTimer(timeOut) then killTimer(timeOut) end
	if isTimer(re) then return false end
		handleTeam("Empty",nil)
		re = setTimer(function()
		for k,v in ipairs(getElementsByType("player")) do
			removePlayer(v,false)
			setElementData(v,"CS:GO Team",false)
			setElementData(v,"CS:GO LastRound",false)
			setElementData(v,"isPlayerinLobby",false)
		end
		local resx = getResourceFromName("AURtdm")
		restartResource(resx)
		----outputDebugString("CSGO Event restarted")
		if isTimer(loopTimer) then killTimer(loopTimer) end
	end,60000,1)
end
antiSound = {}
function playsound(data,v)
	if not v or v == nil or not isElement(v) then
		for kl,pl in ipairs(getElementsByType("player")) do
			if getElementData(pl,"CS:GO Team") then
				triggerClientEvent(pl,"AURsounds.playsound", pl, data,pl)
			end
		end
	end
	if v and isElement(v) then
	--if isTimer(antiSound[v]) then return false end
		if (data) then
			--antiSound[v] = setTimer(function() end,5000,1)
			triggerClientEvent(v,"AURsounds.playsound", v, data,v)
			return true
		end
	end
end
addEvent("playsound", true)
addEventHandler("playsound", root, playsound)

function return_sounds(url, v)
	if (url) then
		triggerClientEvent(v, "AURsounds.proceedsounds", v, url, v)
	end
end
addEvent("AURsounds.return_sounds", true)
addEventHandler("AURsounds.return_sounds", root, return_sounds)

function return_stop(v)
	triggerClientEvent(v, "AURsounds.stop_return", v, v)
end
addEvent("AURsounds.return_stop", true)
addEventHandler("AURsounds.return_stop", root, return_stop)

addCommandHandler("testsound",function(p,cmd,id)
	if tonumber(id) then
		if tonumber(id) <= 3 and tonumber(id) >= 1 then
			playsound(tonumber(id),p)
		end
	end
end)
