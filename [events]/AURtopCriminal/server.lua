 local positions = {
--[[[1]={-2135.25,836.47,69.4,271},
[2]={-2082.46,826.84,69.56,348},
[3]={-2067.66,834.99,71.89,263},
[4]={-2118.56,938.8,96.75,281},
[5]={-2125.88,1000.93,96.94,80},
[6]={-2109.75,1036.03,71.51,185},
[7]={-2096.35,954.64,70.62,194},
[8]={-2091.15,913.55,68.31,305},
[9]={-2059.4,904.76,55.12,259},
[10]={-2041.95,954.87,49.78,267},
[11]={-2024.51,927.52,46.11,175},
[12]={-2012.97,851.76,45.44,88},
[13]={-2027.87,839.71,68.71,97},
[14]={-2048.16,965.97,85.21,95},
[15]={-2077.1,890.61,81.6,142},
[16]={-2041.32,826.17,76.3,184},
[17]={-2090.56,823.77,86.88,0},
[18]={-2054.13,930.78,57.25,186},
[19]={-2067.12,987.87,84.05,175},
[20]={-2037.81,1002.61,68.39,0},

[1] = {231.35, 994.76, 0, 250},
[2] = {99.04, 876.21, 0, 257},
[3] = {-90.72, 970.36, 0, 54},
[4] = {-141.77, 1397.49, 0, 277},
[5] = {201.12, 1184.48, 0, 137},
[6] = {135.81, 934.8, 0, 127},
[7] = {-267.11, 950.67, 0, 47},
[8] = {-39.45, 1184.43, 0, 243},
[9] = {-180.71, 1482.79, 0, 192},
[10] = {391.57, 1420.12, 0, 4},
[11] = {638.52, 1533.68, 0, 80},
[12] = {238.55, 1568.14, 0, 118},
[13] = {-85.38, 1755.97, 0, 9},
[14] = {-226.89, 1246.36, 0, 128},
[15] = {99.13, 864.63, 0, 79},
[16] = {52, 1378.9, 0, 23},
[17] = {-99.46, 1444.62, 0, 137},
[18] = {-112.71, 1272.86, 0, 155},
[19] = {69.85, 1081.63, 0, 18},
[20] = {-57.45, 1194.17, 0, 8},]]--

[1] = {70, 2242, 292.95, 98},
[2] = {25, 2247, 296.67, 175},
[3] = {33, 2264, 294.05, 180},
[4] = {-1, 2252, 288.1, 80},
[5] = {-57, 2256, 288.07, 259},
[6] = {-88, 2242, 290.84, 0},
[7] = {-100, 2332, 285.25, 191},
[8] = {-128, 2263, 288.35, 270},
[9] = {-185, 2298, 273.87, 73},
[10] = {-216, 2277, 288.68, 30},
[11] = {-252, 2327, 285, 155},
[12] = {-252, 2425, 285.09, 243},
[13] = {-310, 2353, 282.76, 182},
[14] = {-246, 2224, 279.98, 72},
[15] = {-256, 2165, 279.98, 75},
[16] = {-292, 2153, 283, 302},
[17] = {-285, 2183, 282.7, 208},
[18] = {-77, 2285, 298.81, 130},
[19] = {8, 2247, 294.66, 259},
[20] = {-244, 2333, 290.68, 345},
}
local onNextWeek = false
local Bonus = 0
local markers = {}
local access = false
local deathmatchers = {}
local dead = {}
local startingTimers = {}
local started=false
local weekday = 6
local hour = 20
local requieredToStart = 7

local TimingHour = 1
local anHour = 1800000

set = setTimer(function()
	local real = getRealTime( nil, false )
	if real then
		--if real.weekday == weekday then
			if real.hour == hour then
				startingTimers = setTimer(start,1000,1)
				if isTimer(set) then killTimer(set) end
			end
		--end
	end
end,anHour,0)

addCommandHandler("tcset",function(plr,cmd,t)
	if exports.CSGstaff:isPlayerStaff(plr) then
		if t == "time" then
			if isTimer(set) then killTimer(set) end
			startingTimers = setTimer(start,10000,1)
			start()
		elseif t == "next" then
			onNextWeek = true
		end
	end
end)

addCommandHandler("tc",function(plr)
	if getElementData(plr,"isPlayerPrime") then
		if (#deathmatchers) >= 20 then
			exports.NGCdxmsg:createNewDxMessage(plr,"You can't enter event is full",255,0,0)
			return false
		end
		Bonus = Bonus+1
		if Bonus > 20 then Bonus = 1 end
		local x, y, z = positions[Bonus][1], positions[Bonus][2], positions[Bonus][3]
		setElementDimension(plr,5000)
		setElementPosition(plr,x,y,z+1)
		table.insert(deathmatchers,plr)
		outputChatBox("plr spawn id "..Bonus,plr,255,0,0)
	end
end)
wam = false

local bannedSerials = {
}

function warper(player)
	if getPlayerTeam(player) then
		if getTeamName(getPlayerTeam(player)) == "Criminals" or getTeamName(getPlayerTeam(player)) == "HolyCrap" then
			local real = getRealTime(nil, false)
			--if real.weekday == weekday then
				if access == true then
					if getElementData(player,"isPlayerArrested") then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't participate when you`re arrested!",255,0,0)
					elseif	getElementData(player,"isPlayerJailed") then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't participate when you`re jailed!",255,0,0)
					elseif	getElementDimension(player) ~= 0 then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't participate when you're not in the main dimension!",255,0,0)
					elseif	getElementInterior(player) ~= 0 then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't participate when you're inside interior!",255,0,0)
					elseif	isPedInVehicle(player) then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't participate while you're inside vehicle!",255,0,0)
					elseif bannedSerials[getPlayerSerial(player)] then
						exports.NGCdxmsg:createNewDxMessage(player,"Your serial has been blacklisted from entering top criminal event.",255,0,0)
					elseif exports.AURgames:isPlayerSigned(player) then
						exports.NGCdxmsg:createNewDxMessage(player,"You can't enter while you are signed up in mini games do /leave",255,0,0)
					else
						if (#deathmatchers) >= 20 then
							exports.NGCdxmsg:createNewDxMessage(player,"You can't enter event is full",255,0,0)
							return false
						end
						---if ( canPlayerEnter(player) ) then
							table.insert(deathmatchers,player)
							local x,y,z = getElementPosition(player)
							setElementData(player,"x",x)
							setElementData(player,"y",y)
							setElementData(player,"z",z)
							Bonus = Bonus+1
							if Bonus > 20 then Bonus = 1 end
							--for i=Bonus,Bonus do
								local x, y, z = positions[Bonus][1], positions[Bonus][2], positions[Bonus][3]
								setElementDimension(player,5000)
								setElementPosition(player,x,y,z+1)
								setPedRotation(player,positions[Bonus][4])
								setTimer(function(p,x,y,z)
									setElementPosition(player,x,y,z+1)
								end,5000,1,player,x,y,z)
								setElementFrozen(player,true)
								setElementData(player,"isPlayerInDM",true)
								fadeCamera(player,false)
								table.insert(dead, exports.server:getPlayerAccountName(player) )
								setElementData ( root, "signedup",#deathmatchers )
								exports.NGCdxmsg:createNewDxMessage(player,"Top Criminal: Please Wait 30 seconds after players count reach 10 players signed up to start",255,0,0)
								if (#deathmatchers < requieredToStart) then
									for k,v in ipairs(deathmatchers) do
										exports.NGCdxmsg:createNewDxMessage(v,getPlayerName(player).." has joined the event (Rolling delay time , please wait 20 seconds)",255,0,0)
									end
									if isTimer(delay) then killTimer(delay) end
									delay = setTimer(delayer,20000,1)
								else
									if wam == false then
										wam = true
										outputChatBox("Top Criminal event will be started after 20 seconds",root,255,255,0)
									end
								end
								--outputDebugString(#deathmatchers)
							--end
						---else
						--	exports.NGCdxmsg:createNewDxMessage(player,"You are only allowed to participate once weekly",255,0,0)
						--end
					end
				else
					exports.NGCdxmsg:createNewDxMessage(player,"You can't participate in this event right now",255,0,0)
				end
			--else
				--exports.NGCdxmsg:createNewDxMessage(player,"You can't participate in this event this day",255,0,0)
			--end
		else
			exports.NGCdxmsg:createNewDxMessage(player,"You should be criminal to participate in the event",255,0,0)
		end
	end
end
addCommandHandler("topcriminal",warper)

function start()
	onNextWeek = false
	Bonus = 0
	access = true
	exports.NGCdxmsg:createNewDxMessage(root,"Top criminal event is ready, do /topcriminal to participate!",255,255,0)
	exports.killmessages:outputMessage("Top criminal event is ready, do /topcriminal to participate!",root,255,255,0,"default-bold")

	outputChatBox("Top criminal: Event is ready, do /topcriminal to participate!",root,255,255,0)
	outputChatBox("Top Criminal: 10 players required to start (Max slots: 20)",root,255,250,0)
	if isTimer(delay) then killTimer(delay) end
	delay = setTimer(delayer,30000,1)
end
function returnPlayer(player)
	local x,y,z = getElementData(player,"x"),getElementData(player,"y"),getElementData(player,"z")
	if x and y then
		setElementDimension(player,0)
		setElementPosition(player,x,y,z)
		setElementData(player,"x",false)
		setElementData(player,"y",false)
		setElementData(player,"z",false)
	else
		if isPedDead(player) then
			return
		else
			killPed(player)
		end
	end
end

function stop()
	deathmatchers = {}
	Bonus = 0
	access = false
	started = false
	setElementData ( root, "signedup",0)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerInDM") then
			setElementData(v,"isPlayerInDM",false)
			fadeCamera(v,true)
			setElementFrozen(v,false)
			local x,y,z = getElementData(v,"x"),getElementData(v,"y"),getElementData(v,"z")
			if x and y then
				setElementData(v,"x",false)
				setElementData(v,"y",false)
				setElementData(v,"z",false)
			end
		end
	end
	wam = false
	setEventOnNextWeek()
end


function convertTime(ms)
    local min = math.floor ( ms/60000 )
    local sec = math.floor( (ms/1000)%60 )
    return min, sec
end

function getTimeLeft(timer)
	local remaining = getTimerDetails(timer)
	return remaining
end

function handleEvent()
	--if attacker ~= source then
		for k,v in ipairs(deathmatchers) do
			if v == source then
				table.remove(deathmatchers,k) --- remove player data when wasted,quit or jailed by admin
				setElementData(source,"isPlayerInDM",false)
				setElementDimension(source,0)
				setElementFrozen(source,false)
				fadeCamera(source,true)
				--outputDebugString("Deathmatchers Debug1: "..k)
				if started == true then
					getTheWinner()
				end
			end
		end
	--end
end
addEventHandler("onPlayerWasted",root,handleEvent)
addEventHandler("onPlayerJailed",root,handleEvent)

addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"isPlayerInDM") then
		setElementData ( root, "signedup",tonumber(getElementData( root, "signedup"))-1)
		local x,y,z = getElementData(source,"x"),getElementData(source,"y"),getElementData(source,"z")
		local acc = exports.server:getPlayerAccountID(source)
		exports.DENmysql:exec("UPDATE `accounts` SET `x`=?, `y`=?, `z`=?, `rotation`=?, `health`=? WHERE `id`=?", x, y, z, 90, 100, acc )
		returnPlayer(source)
	end
	if deathmatchers then
		for k,v in ipairs(deathmatchers) do --- roll table to get his ass
			if v == source then
				table.remove(deathmatchers,k)
				getTheWinner()
			end
		end
	end
end)


function getTheWinner()
	if #deathmatchers == 1 then
		for k,v in ipairs(deathmatchers) do --- roll table to get his ass
			if isElement(v) and k == 1 then
				setLastManStanding(v)
				givePlayerMoney(v,300000)
				exports.AURvip:givePlayerVIP(v,60)
				exports.CSGscore:givePlayerScore(v,20)
				exports.NGCdxmsg:createNewDxMessage(v,"You earned $ 300,000 & 300 scores for being the top criminal this week",0,255,0)
				exports.NGCdxmsg:createNewDxMessage(v,"You earned 1 hour VIP for free :)",0,255,0)
				exports.AURcriminalp:giveCriminalPoints(v, "", 10)
				returnPlayer(v)
				setElementData(v,"isPlayerInDM",false)
				--outputDebugString("force to stop")
				stop()
			end
		end
	elseif #deathmatchers <= 0 then
		stop()
		--outputDebugString("No deathmatchers left 0")
	end
end





function setEventOnNextWeek()
	deathmatchers = {}
	Bonus = 0
	wam = false
	access = false
	started = false
	onNextWeek = true
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerInDM") then
			setElementData(v,"isPlayerInDM",false)
			setElementFrozen(v,false)
			fadeCamera(v,true)
			exports.NGCdxmsg:createNewDxMessage(v,"Sorry event stopped wait for next week due lack of players",255,0,0)
			returnPlayer(v)
		end
	end
	if isTimer(noob) then killTimer(noob) end
	noob = setTimer(function()
		proTimer()
	end,(60000*60),1)
end

function proTimer()
	if isTimer(set) then killTimer(set) end
	set = setTimer(function()
		onNextWeek = false
		local real = getRealTime( nil, false )
		if real then
			--if real.weekday == weekday then
				if real.hour == hour then
					startingTimers = setTimer(start,60000,1)
					if isTimer(set) then killTimer(set) end
				end
			--end
		end
	end,(60000*30),0)
end

function delayer()
	if (#deathmatchers >= requieredToStart) then
		access = false
		started=true
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v,"isPlayerInDM") then
				fadeCamera(v,true)
				triggerClientEvent(v,"drawCount",v)
			end
		end
		if #deathmatchers == 20 then
			outputChatBox("TopCriminal event is full 20 players",root,0,255,0)
		else
			outputChatBox("TopCriminal event started by "..#deathmatchers.." players",root,0,255,0)
		end
	else
		if isTimer(delay) then killTimer(delay) end
		local real = getRealTime( nil, false )
		if real then
			--if real.weekday == weekday then
				if real.hour == hour then
					delay = setTimer(delayer,10000,1)
					---outputDebugString("Check TC if it still in valid time and date then return else destroy the event")
				else
					setEventOnNextWeek()
				end
			--else
				--setEventOnNextWeek()
			---end
		end
	end
end


addEvent("setPlayerCanDM",true)
addEventHandler("setPlayerCanDM",root,function()
	setElementFrozen(source,false)
	fadeCamera(source,true)
	toggleControl(source,"fire",true)
	toggleControl(source,"aim_weapon",true)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerInDM") then
			fadeCamera(v,true)
			setElementFrozen(v,false)
			toggleControl(v,"fire",true)
			toggleControl(v,"aim_weapon",true)
		end
	end
	exports.NGCdxmsg:createNewDxMessage(source,"Kill them all, GO GO GO!'",0,255,0)
end)

function canPlayerEnter ( plr )
	local state = true
	for k, theAccount in ipairs ( dead ) do
		if ( theAccount == exports.server:getPlayerAccountName( plr ) ) then
			state = false
		end
	end
	return state
end

function setLastManStanding(player)
	local file = xmlCreateFile("Top.xml",'Top')
    local name = exports.server:getPlayerAccountID(player)
    local node = xmlCreateChild(file,'name')
    xmlNodeSetAttribute(node,'name',name)
    xmlSaveFile(file)
	triggerEvent("getLastManStanding",root)
	local theMessage = getPlayerName(player).." is the Top Criminal"
	triggerClientEvent("SetTC",root, theMessage)
end
addCommandHandler("topset",function(player,cmd,target)
	if getElementData(player,"isPlayerPrime") then
		for k,v in ipairs(getElementsByType("player")) do
			if exports.server:getPlayerAccountName(v) == target then
				setLastManStanding(v)
			end
		end
	end
end)

addEvent("getLastManStanding",true)
addEventHandler("getLastManStanding",root,function()
	local rootnode = xmlLoadFile("Top.xml")
	if rootnode then
		for i,name in ipairs(xmlNodeGetChildren(rootnode)) do
			if name then
				local topName = xmlNodeGetAttribute(name,"name")
				if topName then
					for k,v in ipairs(getElementsByType("player")) do
						if tonumber(exports.server:getPlayerAccountID(v)) == tonumber(topName) then
							setElementData(v,"TC","Top Criminal")
						else
							setElementData(v,"TC",false)
						end
					end
				end
			end
		end
	end
end)


function onCalculateTime ( theTime )
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

function abort()
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerInDM") then
			setElementData(v,"isPlayerInDM",false)
			fadeCamera(v,true)
			setElementFrozen(v,false)
			exports.NGCdxmsg:createNewDxMessage(v,"Sorry event stopped due script get stopped",255,0,0)
			returnPlayer(v)
		end
	end
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), abort )


addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),function()
	local rootnode = xmlLoadFile("Top.xml")
	if rootnode then
		for i,name in ipairs(xmlNodeGetChildren(rootnode)) do
			if name then
				local topName = xmlNodeGetAttribute(name,"name")
				if topName then
					for k,v in ipairs(getElementsByType("player")) do
						if tonumber(exports.server:getPlayerAccountID(v)) == tonumber(topName) then
							setElementData(v,"TC","Top Criminal")
						else
							setElementData(v,"TC",false)
						end
					end
				end
			end
		end
	end
end)


addEventHandler("onServerPlayerLogin",root,function()
	if getElementDimension(source) == 5000 then
		killPed(source)
	end
	local rootnode = xmlLoadFile("Top.xml")
	if rootnode then
		for i,name in ipairs(xmlNodeGetChildren(rootnode)) do
			if name then
				local topName = xmlNodeGetAttribute(name,"name")
				if topName then
					for k,v in ipairs(getElementsByType("player")) do
						if tonumber(exports.server:getPlayerAccountID(v)) == tonumber(topName) then
							setElementData(v,"TC","Top Criminal")
						else
							setElementData(v,"TC",false)
						end
					end
				end
			end
		end
	end
end)

addCommandHandler ( "dmtime",
function( thePlayer )
	local robType = "(Top Criminal)"
	if onNextWeek == true then
		exports.NGCdxmsg:createNewDxMessage( thePlayer, robType.." on next saturday", 225, 0, 0 )
		return false
	end
	if ( isTimer(startingTimers) ) then
		--local timeLeft, timeExLeft, timeExMax = getTimerDetails(startingTimers)
		local minutes, seconds = convertTime(getTimeLeft(startingTimers))
		exports.NGCdxmsg:createNewDxMessage( thePlayer, "Time left until next event: " .. math.floor(minutes/60) .." ( ".. math.floor(minutes) .." minutes ) hours left and ".. math.floor(seconds) .." seconds"..robType, 225, 0, 0 )
	elseif isTimer(delay) then
		--local timeLeft, timeExLeft, timeExMax = getTimerDetails(delay)
		local minutes, seconds = convertTime(getTimeLeft(delay))
		exports.NGCdxmsg:createNewDxMessage( thePlayer, "Time left till event start: ".. math.floor(seconds) .." seconds"..robType, 0, 255, 0 )
	else
		if not isTimer(delay) then
			local real = getRealTime(nil, false)
			--if real.weekday == weekday and started == true then
				--exports.NGCdxmsg:createNewDxMessage( thePlayer, "Event already started , wait till next saturday.", 0, 255, 0 )
			if started == false and real.hour == hour or real.hour >= hour and real.hour < hour+1 then
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "Top Criminal Event is ready after the delayer time check /resettime (Event Command) /topcriminal .", 0, 255, 0 )
			elseif started == false and real.hour < hour then
				if real.hour >= 0 and real.hour < 12 then PM = "AM" else PM = "PM" end
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "Top Criminal Event will be ready at ("..hour.." PM) Current Time is "..real.hour.." "..PM.." : "..real.minute.." minutes", 225, 255, 0 )
			else
				if real.hour >= 0 and real.hour < 12 then PM = "AM" else PM = "PM" end
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "Top Criminal Event not avaliable now and will be ("..hour.." PM) Current Time is "..real.hour.." "..PM.." : "..real.minute.." minutes", 225, 255, 0 )
			end
		end
	end
end
)

addCommandHandler ( "resettime",
function( thePlayer )
	local robType = "(Top Criminal)"
	if ( isTimer(set) ) then
		if onNextWeek == true then
			exports.NGCdxmsg:createNewDxMessage( thePlayer, robType.." on next saturday", 225, 0, 0 )
			return false
		end
		local minutes, seconds = convertTime(getTimeLeft(set))
		exports.NGCdxmsg:createNewDxMessage( thePlayer, "Time left until next start check timer: " .. math.floor(minutes) .. " minutes "..robType, 225, 0, 0 )
	end
end
)
