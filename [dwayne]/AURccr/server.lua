local markerTeam1 = createMarker(2194.9,1669.79,11,"cylinder",3,255,0,0)
local markerTeam2 = createMarker(2195.34,1684.27,11,"cylinder",3,250,250,0)
local markerTeam3 = createMarker(2167.51,1754.63,11,"cylinder",3,0,100,200)
local theColTeam1 = createColCircle(2194.9,1669.79,2)
local theColTeam2 = createColCircle(2195.34,1684.27,2)
local theColTeam3 = createColCircle(2195.18,1676.45,2)
createBlipAttachedTo(markerTeam1, 43)
setElementData(markerTeam1,"CRW","Red Dragon Mafia")
setElementData(markerTeam2,"CRW","Yellow Dragon Mafia")
setElementData(markerTeam3,"CRW","Casino Security")
setElementData(markerTeam1,"CW","Red")
setElementData(markerTeam2,"CW","Yellow")
setElementData(markerTeam3,"CW","Blue")
local minTeam1 = 4
local minTeam2 = 4
local minTeam3 = 2
local maxTeam1 = 8
local maxTeam2 = 8
local maxTeam3 = 8
local team1 = {}
local team2 = {}
local team3 = {}
local joinedLaw = {}
local redTeam = {}
local yellowTeam = {}
stoppingTimer = {}
local quickDelay = nil
local startingTimer = nil
local wasEventStarted = false
local forcedStopped = false

createTeam("Red Dragon Mafia",190,0,0)
createTeam("Yellow Dragon Mafia",220,200,0)
createTeam("Casino Security",0,80,200)
setTeamFriendlyFire ( getTeamFromName("Red Dragon Mafia"), false )
setTeamFriendlyFire ( getTeamFromName("Yellow Dragon Mafia"), false )
setTeamFriendlyFire ( getTeamFromName("Casino Security"), false )

addEventHandler("onResourceStart",resourceRoot,function()
	startingTimer = setTimer(function() forcedStopped = false end,60000*60,1)
end)


function isCrim(p)
	if getPlayerTeam(p) and getTeamName(getPlayerTeam(p)) == "Criminals" then
		return true
	else
		return false
	end
end


function getTeam1Count()
	local cInMarker = { }
	local rbmColShape = getElementColShape ( markerTeam1 )
	local pInMarker = getElementsWithinColShape ( rbmColShape , "player" )
	for index , player in ipairs ( pInMarker ) do
		if canIEnter(player,true) then -- and isCrim(player) then
			table.insert ( cInMarker, player )
		end
	end
	return #cInMarker,cInMarker
end


function getTeam2Count()
	local cInMarker = { }
	local rbmColShape = getElementColShape ( markerTeam2 )
	local pInMarker = getElementsWithinColShape ( rbmColShape , "player" )
	for index , player in ipairs ( pInMarker ) do
		if canIEnter(player,true) then-- and isCrim(player) then
			table.insert ( cInMarker, player )
		end
	end
	return #cInMarker,cInMarker
end


function getTeam3Count()
	local cInMarker = { }
	local rbmColShape = getElementColShape ( markerTeam3 )
	local pInMarker = getElementsWithinColShape ( rbmColShape , "player" )
	for index , player in ipairs ( pInMarker ) do
		if canIEnter(player,false) then-- and exports.DENlaw:isLaw(player) then
			table.insert ( cInMarker, player )
		end
	end
	return #cInMarker,cInMarker
end

function msg(player,ms)
	exports.NGCdxmsg:createNewDxMessage(player,ms,255,255,0)
end
--[[
function inMarker(p,w)
	local cInMarker = { }
	local shape = {}
	if w == 1 then
		shape = getElementColShape ( markerTeam1 )
	elseif w == 2 then
		shape = getElementColShape ( markerTeam2 )
	else
		shape = getElementColShape ( markerTeam3 )
	end
	local pInMarker = getElementsWithinColShape ( shape , "player" )
	for index , player in ipairs ( pInMarker ) do
		if player == p then
			return true
		end
	end
	return false
end
]]
function canIEnter(player,way)
	if startingTimer and isTimer(startingTimer) then
		msg(player,"You can't enter at the moment event is not ready yet")
		return false
	end
	if wasEventStarted == true then
		if way == true then
			msg(player,"You can't enter at the moment event in progress")
			return false
		end
	end
	if isPedInVehicle(player) then
		msg(player,"You can't enter while you're inside a vehicle")
		return false
	end
	if exports.AURgames:isPlayerSigned(player) then
		msg(player,"You can't enter while you are signed up in another event")
		return false
	end
	if getElementDimension(player) ~= 0 then
		msg(player,"You can't enter while you are in another dimension")
		return false
	end
	if getElementInterior(player) ~= 0 then
		msg(player,"You can't enter while you are in inside interior")
		return false
	end
	if getElementData(player,"isPlayerArrested") then
		msg(player,"You can't enter while you are arresed")
		return false
	end
	if getElementData(player,"isPlayerJailed") then
		msg(player,"You can't enter while you are Jailed")
		return false
	end
	if getElementData(player,"isPlayerFlagger") then
		msg(player,"You can't enter while you are Jailed")
		return false
	end
	if getElementData(player,"wantedPoints") > 25 then
		msg(player,"You can't enter with +20 wanted points")
		return false
	end
	if way == true and isCrim(player) ~= true then
		msg(player,"You can't enter while you are not a criminal")
		return false
	end
	if way == false and exports.DENlaw:isLaw(player) ~= true then
		msg(player,"You can't enter while you are not a law officer")
		return false
	end
	if way == true and isCrim(player) then
		return true
	end
	if way == false and exports.DENlaw:isLaw(player) == true then
		return true
	end
end

addEventHandler("onMarkerHit",root,function(hit,dim)
	if source == markerTeam1 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" and not isPedInVehicle(hit) then
			checkTeam(hit)
		end
	elseif source == markerTeam2 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" and not isPedInVehicle(hit) then
			checkTeam(hit)
		end
	elseif source == markerTeam3 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" and not isPedInVehicle(hit) then
			if exports.DENlaw:isLaw(hit) then
				if wasEventStarted == true then
					if #team1 > 0 and #team2 > 0 then
						if #joinedLaw < 10 then
							if canLawEnter(hit) then
								table.insert(team3,hit)
								table.insert(joinedLaw,hit)
								setElementData(hit,"teamx",getTeamName(getPlayerTeam(hit)))
								setPlayerTeam(hit,getTeamFromName("Casino Security"))
								setElementData(hit,"Occupation","Security")
								setElementData(hit,"CW",true)
								setElementInterior(hit,1)
								setElementDimension(hit,1)
								setElementPosition(hit,2287.86,1609.2,1008.35)
								setPedRotation(hit,86)
								msg(hit,"Kill The Mafia to save the casino")
								triggerClientEvent(hit,"setCWrules",hit)
							end
						end
					end
				end
			end
		end
	end
end)


function canLawEnter(player)
	for k,v in ipairs(joinedLaw) do
		if v == player then
			return false
		end
	end
	if #joinedLaw >= 10 then
		return false
	end
	return true
end


addEventHandler("onMarkerLeave",root,function(hit,dim)
	if source == markerTeam1 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" and not isPedInVehicle(hit) then
			if wasEventStarted == false then
				checkTeam(hit)
			end
		end
	elseif source == markerTeam2 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" and not isPedInVehicle(hit) then
			if wasEventStarted == false then
				checkTeam(hit)
			end
		end
	elseif source == markerTeam3 then
		if not dim then return false end
		if hit and isElement(hit) and getElementType(hit) == "player" and not isPedInVehicle(hit) then

		end
	end
end)



function checkTeam(player)
	if startingTimer and isTimer(startingTimer) then
		msg(player,"You can't enter at the moment event is not ready yet")
	return false end
	if wasEventStarted == false then
		local team1Count,Team1Tbl = getTeam1Count()
		local team2Count,Team2Tbl = getTeam2Count()
		if team1Count >= minTeam1 and team2Count >= minTeam2 then
			if isTimer(quickDelay) then return false end
			msg(player,"Red mafia team should contain 4/8 same as yellow team (4 Vs 4 Vs Law)")
			for k,v in ipairs(Team1Tbl) do
				if v and isElement(v) then
					msg(v,"Event will be started within 5 seconds if the participate count is valid")
				end
			end
			for k,v in ipairs(Team2Tbl) do
				if v and isElement(v) then
					msg(v,"Event will be started within 5 seconds if the participate count is valid")
				end
			end
			quickDelay = setTimer(function()
				local team1Count,Team1Tbl = getTeam1Count()
				local team2Count,Team2Tbl = getTeam2Count()
				if team1Count >= minTeam1 and team2Count >= minTeam2 then
					wasEventStarted = true
					for k,v in ipairs(Team1Tbl) do
						if v and isElement(v) then
							--oldoccupations[exports.server:getPlayerAccountName(v)] = getElementData(v,"Occupation") or "Criminal"
							setPlayerTeam(v,getTeamFromName("Red Dragon Mafia"))
							setElementData(v,"Occupation","Red Dragon")
							setElementData(v,"CW",true)
							setElementInterior(v,1)
							setElementDimension(v,1)
							setElementPosition(v,2234.62,1699.59,1008.35)
							setPedRotation(v,179)
							msg(v,"Kill the Yellow Dragon Mafia to win the war")
							msg(v,"Kill Casino Security to win the war")
							table.insert(team1,v)
							table.insert(redTeam,v)
							triggerClientEvent(v,"setCWrules",v)
						end
					end
					for k,v in ipairs(Team2Tbl) do
						if v and isElement(v) then
							--oldoccupations[exports.server:getPlayerAccountName(v)] = getElementData(v,"Occupation") or "Criminal"
							setPlayerTeam(v,getTeamFromName("Yellow Dragon Mafia"))
							setElementData(v,"Occupation","Yellow Dragon")
							setElementData(v,"CW",true)
							setElementInterior(v,1)
							setElementDimension(v,1)
							setElementPosition(v,2144.25,1637.62,993.57)
							setPedRotation(v,179)
							triggerClientEvent(v,"setCWrules",v)
							msg(v,"Kill the Red Dragon Mafia to win the war")
							msg(v,"Kill Casino Security to win the war")
							table.insert(team2,v)
							table.insert(yellowTeam,v)
						end
					end
					for k,v in ipairs(getElementsByType("player")) do
						if exports.DENlaw:isLaw(v) then
							--msg(v,"Head to Lv Casino there is war going on between the mafia!")
						end
					end
				else
					msg(player,"Red or Yellow team is not full to start")
					---checkTeam()
				end
			end,5000,1)
		else
			msg(player,"Red or Yellow team is not full to start")
			--checkTeam()
		end
	else
		msg(player,"You can't enter at the moment event is in progress")
	end
end

function checkWinner(player)
	outputDebugString("Starting to check winners")
	outputDebugString("Teams : red "..#team1..", yellow "..#team2..", blue "..#team3)
	if #team1 <= 0 and #team2 > 0 and #team3 <= 0 then
		for k,v in ipairs(yellowTeam) do
			if v and isElement(v) then
				if getElementInterior(v) ~= 0 then
					setElementInterior(v,0)
					setElementDimension(v,0)
					setElementData(v,"CW",false)
					setElementPosition(v,2179.74,1676.96,11.04)
					if isSecurity(v) then
						local teax = getElementData(v,"teamx")
						setplayerTeam(v,getTeamFromName(teax) or getTeamFromName("Government"))
						setElementData(v,"Occupation",teax)
					else
						setPlayerTeam(v,getTeamFromName("Criminals"))
						setElementData(v,"Occupation","Criminal")
						setElementData(v,"Rank","Criminal")
						setElementData(v,"teamx",false)
					end
				end
				givePlayerMoney(v,100000)
				exports.CSGscore:givePlayerScore(v,20)
				exports.NGCdxmsg:createNewDxMessage(v,"You have earned $100,000 and 20 scores from Casino war because your team has won the war",0,255,0)
			end
		end
	else
		outputDebugString("Yellow is not winner")
	end
	if #team1 > 0 and #team2 <= 0 and #team3 <= 0 then
		for k,v in ipairs(redTeam) do
			if v and isElement(v) then
				if getElementInterior(v) ~= 0 then
					setElementInterior(v,0)
					setElementDimension(v,0)
					setElementData(v,"CW",false)
					setElementPosition(v,2179.74,1676.96,11.04)
					if isSecurity(v) then
						local teax = getElementData(v,"teamx")
						setplayerTeam(v,getTeamFromName(teax) or getTeamFromName("Government"))
						setElementData(v,"Occupation",teax)
					else
						setPlayerTeam(v,getTeamFromName("Criminals"))
						setElementData(v,"Occupation","Criminal")
						setElementData(v,"Rank","Criminal")
						setElementData(v,"teamx",false)
					end
				end
				givePlayerMoney(v,100000)
				exports.CSGscore:givePlayerScore(v,20)
				exports.NGCdxmsg:createNewDxMessage(v,"You have earned $100,000 and 20 scores from Casino war because your team has won the war",0,255,0)
			end
		end
	else
		outputDebugString("Red is not winner")
	end
	if #team1 <= 0 and #team2 <= 0 and #team3 > 0 then
		for k,v in ipairs(joinedLaw) do
			if v and isElement(v) then
				if getElementInterior(v) ~= 0 then
					setElementInterior(v,0)
					setElementDimension(v,0)
					setElementPosition(v,2179.74,1676.96,11.04)
				end
				setElementData(v,"CW",false)
				if isSecurity(v) then
					local teax = getElementData(v,"teamx")
					setplayerTeam(v,getTeamFromName(teax) or getTeamFromName("Government"))
					setElementData(v,"Occupation",teax)
					setElementData(v,"teamx",false)
				else
					setPlayerTeam(v,getTeamFromName("Criminals"))
					setElementData(v,"Occupation","Criminal")
					setElementData(v,"Rank","Criminal")
					setElementData(v,"teamx",false)
				end
				givePlayerMoney(v,100000)
				exports.CSGscore:givePlayerScore(v,20)
				exports.NGCdxmsg:createNewDxMessage(v,"You have earned $100,000 and 20 scores from Casino war because your team has won the war",0,255,0)
			end
		end
	else
		outputDebugString("Law is not winner")
	end
	if #team1 > 0 and #team2 <= 0 and #team3 <= 0 then
		breakEvent()
	elseif #team2 > 0 and #team1 <= 0 and #team3 <= 0 then
		breakEvent()
	elseif #team3 > 0 and #team1 <= 0 and #team2 <= 0 then
		breakEvent()
	end
end

function casinoYard(player)
	if getElementInterior(player) ~= 0 then
		setElementInterior(player,0)
		setElementDimension(player,0)
		setElementPosition(player,2179.74,1676.96,11.04)
	end
	setElementData(player,"CW",false)
	if isSecurity(player) then
		local teax = getElementData(player,"teamx")
		setPlayerTeam(player,getTeamFromName(teax) or getTeamFromName("Government"))
		setElementData(player,"Occupation",teax)
		setElementData(player,"teamx",false)
	else
		setPlayerTeam(player,getTeamFromName("Criminals"))
		setElementData(player,"Occupation","Criminal")
		setElementData(player,"Rank","Criminal")
		setElementData(player,"teamx",false)
	end
	outputDebugString("Red team "..#team1.." with "..#redTeam)
	outputDebugString("Yel team "..#team2.." with "..#yellowTeam)
	outputDebugString("Law team "..#team3.." with "..#joinedLaw)
	for k,v in ipairs(team1) do
		if v and isElement(v) and v == player then
			table.remove(team1,k)
			break
		end
	end
	for k,v in ipairs(team2) do
		if v and isElement(v) and v == player then
			table.remove(team2,k)
			break
		end
	end
	for k,v in ipairs(team3) do
		if v and isElement(v) and v == player then
			table.remove(team3,k)
			break
		end
	end
	checkWinner(player)
end

addEventHandler("onResourceStart",resourceRoot,function()
	for k,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"CW") then
			setElementInterior(player,0)
			setElementDimension(player,0)
			setElementData(player,"CW",false)
			setElementPosition(player,2179.74,1676.96,11.04)
			if isSecurity(player) then
				local teax = getElementData(player,"teamx")
				setPlayerTeam(player,getTeamFromName(teax) or getTeamFromName("Government"))
				setElementData(player,"Occupation",teax)
				setElementData(player,"Rank",teax)
			else
				setPlayerTeam(player,getTeamFromName("Criminals"))
				setElementData(player,"Occupation","Criminal")
				setElementData(player,"Rank","Criminal")
			end
		end
	end
end)
addEventHandler("onResourceStop",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"CW") then
			casinoYard(v)
		end
	end
end)

function isSecurity(player)
	if getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) == "Casino Security" or getElementData(player,"Occupation") == "Security" then
		return true
	else
		return false
	end
end


addEventHandler( "onPlayerWasted", root,
function ( ammo, attacker, weapon, bodypart )
	if ( attacker ) and ( isElement( attacker ) ) and ( getElementType ( attacker ) == "player" ) then
		if getElementData(attacker,"CW") and getElementData(source,"CW") then
			if not ( source == attacker ) and ( getPlayerTeam( attacker ) ) then
				if (getTeamName(getPlayerTeam(attacker)) == "Red Dragon Mafia") and (isSecurity(source) or (getTeamName(getPlayerTeam(source)) == "Yellow Dragon Mafia")) then
					givePlayerMoney(attacker,10000)
					exports.NGCdxmsg:createNewDxMessage(attacker,"You have earned $10,000 from killing"..getPlayerName(source),0,255,0)
				elseif (getTeamName(getPlayerTeam(attacker)) == "Yellow Dragon Mafia") and (isSecurity(source) or (getTeamName(getPlayerTeam(source)) == "Red Dragon Mafia")) then
					givePlayerMoney(attacker,10000)
					exports.NGCdxmsg:createNewDxMessage(attacker,"You have earned $10,000 from killing"..getPlayerName(source),0,255,0)
				elseif ((getTeamName(getPlayerTeam(source)) == "Yellow Dragon Mafia") or (getTeamName(getPlayerTeam(source)) == "Red Dragon Mafia")) and isSecurity(attacker) then
					givePlayerMoney(attacker,10000)
					exports.NGCdxmsg:createNewDxMessage(attacker,"You have earned $10,000 from killing"..getPlayerName(source),0,255,0)
				end
			end
		end
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if getElementData(source,"CW") then
		casinoYard(source)
	end
end)


addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"CW") then
		casinoYard(source)
	end
end)

addEventHandler("onPlayerJobChange",root,function()
	if getElementData(source,"CW") then
		casinoYard(source)
	end
end)

addEventHandler("onSetPlayerJailed",root,function()
	if getElementData(source,"CW") then
		casinoYard(source)
	end
end)


function breakEvent()
	outputDebugString("I am breaking the event")
	if forcedStopped == true then return false end
	forcedStopped = true
	if isTimer(startingTimer) then killTimer(startingTimer) end
	if isTimer(stoppingTimer) then killTimer(stoppingTimer) end
	stoppingTimer = setTimer(function()
		startingTimer = setTimer(function() forcedStopped = false end,60000*60,1)
		outputDebugString("EVENT BROKEN")
		team1 = {}
		team2 = {}
		team3 = {}
		joinedLaw = {}
		redTeam = {}
		yellowTeam = {}
		quickDelay = nil
		wasEventStarted = false
	end,30000,1)
end


function onCalculateBanktime(theTime)
	if (theTime >= 60000) then
		local plural = ""
		if (math.floor((theTime/1000)/60) >= 2) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)/60) .. " minute" .. plural)
	else
		local plural = ""
		if (math.floor((theTime/1000)) >= 2) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)) .. " second" .. plural)
	end
end


addCommandHandler("cwtime",
function (thePlayer)
	local robType = "(Casino War)"
	if (isTimer(startingTimer)) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(startingTimer)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, onCalculateBanktime(math.floor(timeLeft)).." until event get started "..robType, 230, 230, 0)
	elseif wasEventStarted == true then
		exports.NGCdxmsg:createNewDxMessage(thePlayer,"Casino War is in progress please wait unti it get finished", 230, 230, 0)
	else
		if wasEventStarted == false then
			if forcedStopped ~= true then
				exports.NGCdxmsg:createNewDxMessage(thePlayer, robType.." Go to LV casino to sign up for war!", 255, 230, 0)
			end
		end
	end
end)
