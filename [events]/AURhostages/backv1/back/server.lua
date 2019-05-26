
-- Check if a player is a law player
local lawTeams = {
	"Military Forces",
	"SWAT",
}

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

local door = createObject(1506,1731.5, -1014.65, 8894.5,0,0,90)
local mainDoor = createObject(11416,1748.76, -1009.13, 8889.46,0,0,90)
local mainDoor2 = createObject(11416,1748.76, -1009.15, 8892,0,0,90)
local warpEvent = 1748.32, -988.98, 8889.32
local warpInside =  1528.57, -1416.29, 7820.91


local exits = createMarker(1748.32, -986.06, 8890,"arrow",1.5,255,0,0)
local enter = createMarker(1779.66, -1258.85, 16,"arrow",1.5,255,155,0)
local enterfrominside = createMarker(1731.8, -1013.96, 8896,"arrow",1.5,255,155,0)
local exitfromoutside = createMarker(1527.8, -1416.19, 7822 ,"arrow",1.5,255,155,0)

local pos1 = {
{192,1773.56, -1006.32, 8895.5},
{0,1746.52, -1041.54, 8895.5},
{269,1723.92, -989.98, 8895.5},
{194,1725.69, -1006.16, 8895.5},
{192,1529.86, -1401.15, 7820.91},
{0,1532.17, -1401.72, 7820.91},
{269,1771.98, -990.58, 8895.5},
{194,1762.86, -1017.71, 8895.5},
}
local pos2 = {
{190,1531.04, -1395.93, 7827.24},
{299,1563.54, -1395.56, 7831.61},
{300,1534.01, -1403.56, 7827.24},
{193,1548.26, -1395.28, 7820.91},
}
local pos3 = {

{192,1751.75, -992.03, 8889.33},
{0,1747.03, -992.69, 8889.32},
{269,1739.87, -1000.6, 8889.3},
{0,1752.12, -1004.77, 8889.33},
{194,1759.03, -1016.37, 8895.5},
{269,1749.24, -1027.79, 8895.5},
{192,1734.02, -997.25, 8895.5},
{194,1530.89, -1414.58, 7820.92},
{192,1535.36, -1404.26, 7820.91},
{269,1557.39, -1399.65, 7820.91},
}


local stats = {
    [ 69 ] = 500,
    [ 70 ] = 999,
    [ 71 ] = 999,
    [ 72 ] = 999,
    [ 73 ] = 500,
    [ 74 ] = 999,
    [ 75 ] = 500,
    [ 76 ] = 999,
    [ 77 ] = 999,
    [ 78 ] = 999,
    [ 79 ] = 999,
	[ 160 ] = 999,
	[ 229 ] = 999,
	[ 230 ] = 999
}

local peds = {}
local xx = {}
local lawPlayers = {}
local deadLaw = {}
local minCops = 5
local mkr = {}
local secured = {}
local hostages = false
local ren = 18
local bots = 18
local noobs = {}
local res = 0

function openDoor()
	moveObject(mainDoor,5000,1738.76, -1009.13, 8889.46)
	moveObject(mainDoor2,5000,1738.76, -1009.13, 8889.46)
end
function closeDoor()
	moveObject(mainDoor,5000,1748.76, -1009.13, 8889.46)
	moveObject(mainDoor2,5000,1748.76, -1009.15, 8892)
end

function setMainEvent()
	if isTimer(startingTime) then return false end
	startingTime = setTimer(function() hostages = false end,120000*60,1)
end

addCommandHandler("sethr",function(player,cmd,value,times)
	if getElementData(player,"isPlayerPrime") then
		if value == "time" and times and tonumber(times) then
			if isTimer(startingTime) then killTimer(startingTime) end
			startingTime = setTimer(function() hostages = false end,times,1)
		elseif value == "reset" then
			stopEvent(true,"Event Canceled.")
		end
	end
end)

addEventHandler("onMarkerHit",root,function(hitElement,matchdim)
	if source == enter then
		if not matchdim then return false end
		if hitElement and getElementType(hitElement) == "player" then
			if isLaw(hitElement) then
				if isTimer(startingTime) then
					exports.DENdxmsg:createNewDxMessage(hitElement,"There is no mission here anytime soon.",255,0,0)
				else
					if hostages == false then
						--if ( canLawEnter ( hitElement ) ) then
							table.insert( lawPlayers, hitElement )
							setElementPosition(hitElement,1748.32, -988.98, 8890)
							setElementData(hitElement,"isPlayerSWAT",true)
							setPedRotation(hitElement,183)
							warpSWAT(hitElement)
							triggerClientEvent( hitElement, "onToggleHR", hitElement, true )
						--else
							--exports.DENdxmsg:createNewDxMessage(hitElement,"You're only allowed to enter once in the event.",255,0,0)
						--end
					else
						exports.DENdxmsg:createNewDxMessage(hitElement,"You are not allowed to enter at this time",255,0,0)
					end
				end
			else
				exports.DENdxmsg:createNewDxMessage(hitElement,"You aren't allowed to participate in this event.",255,0,0)
			end
		end
	elseif source == exits then
		if not matchdim then return false end
		if hitElement and getElementType(hitElement) == "player" then
			setElementPosition(hitElement,1785.62, -1258.84, 13.63)
			warpBitchOut(hitElement)
			if #lawPlayers < 1 then
				stopEvent(true,"You failed in the event , Police died")
			end
		end
	elseif source == enterfrominside then
		if not matchdim then return false end
		if hitElement and getElementType(hitElement) == "player" then
			setElementPosition(hitElement,1530.68, -1415.53, 7820.92)
			setPedRotation(hitElement,350)
		end
	elseif source == exitfromoutside then
		if not matchdim then return false end
		if hitElement and getElementType(hitElement) == "player" then
			setElementPosition(hitElement,1735.63, -1014.32, 8896)
		end

	end
end)


function canLawEnter ( theOfficer )
	local state = true
	for k, theLawAccount in ipairs ( deadLaw ) do
		if ( theLawAccount == exports.server:getPlayerAccountName( theOfficer ) ) then
			state = false
		end
	end
	return state
end

function warpBitchOut(player)
	if isLaw(player) then
		for k, theCop in ipairs ( lawPlayers ) do
			if ( theCop == player ) then
				table.remove( lawPlayers, k )
			end
		end
		setElementData(player,"isPlayerSWAT",false)
		triggerClientEvent(player, "onToggleHOEStats",player, false )
	end
	triggerClientEvent( "onChangeHOECount", root, #lawPlayers)
	toggleControl(player,"sprint",true)
end

function warpSWAT(player)
	--triggerClientEvent( player, "onToggleHOEStats", player, true )
	triggerClientEvent( "onChangeHOECount", root, #lawPlayers)
	handleTheEvent(player)
	toggleControl(player,"sprint",false)
end

function handleTheEvent(player)
	if #lawPlayers >= minCops then-- or getElementData(player,"isPlayerPrime") then
		if isTimer(timing) then
			return
			false
		end
		triggerClientEvent("onResetHOEStats",root)
		triggerClientEvent("sendTimers",root,"(30 seconds till start)")
		timing = setTimer(function()
			hostages = true
			setBattleConfig1()
			openDoor()
		end,30000,1)
	else
		triggerClientEvent("sendTimers",root,"(5 cops needed to start the event)")
	end
	exports.DENdxmsg:createNewDxMessage(player,#lawPlayers.." cops inside the event.",0,255,0)
end


function setBattleConfig1()
	triggerClientEvent("sendTimers",root,"Kill the terrorists")
	for i=1,8 do
		local id,x,y,z = pos1[i][1],pos1[i][2],pos1[i][3],pos1[i][4]
		noobs[i] = spawnBot(x, y, z, 90, id, 0, 0, getTeamFromName("Criminals"), 27, "guarding")
		setElementData(noobs[i],"bot",true)
		for stat,value in pairs(stats) do
			setPedStat(noobs[i], stat, value)
		end
	end

	for i=1,10 do
		local id,x,y,z = pos3[i][1],pos3[i][2],pos3[i][3],pos3[i][4]
		noobs[i] = spawnBot(x, y, z, 90, id, 0, 0, getTeamFromName("Criminals"),27, "guarding")
		setElementData(noobs[i],"bot",true)
		for stat,value in pairs(stats) do
			setPedStat(noobs[i], stat, value)
		end
	end
end

function setBattleConfig3()
	triggerClientEvent("sendTimers",root,"Kill the reinforcement of terrorists")
	for i=1,8 do
		local id,x,y,z = pos1[i][1],pos1[i][2],pos1[i][3],pos1[i][4]
		noobs[i] = spawnBot(x, y, z, 90, id, 0, 0, getTeamFromName("Criminals"),27, "guarding")
		setElementData(noobs[i],"botX",true)
		for stat,value in pairs(stats) do
			setPedStat(noobs[i], stat, value)
		end
	end

	for i=1,10 do
		local id,x,y,z = pos3[i][1],pos3[i][2],pos3[i][3],pos3[i][4]
		noobs[i] = spawnBot(x, y, z, 90, id, 0, 0, getTeamFromName("Criminals"),27, "guarding")
		setElementData(noobs[i],"botX",true)
		for stat,value in pairs(stats) do
			setPedStat(noobs[i], stat, value)
		end
	end

end
addEventHandler("onPedWasted",root,function()
	local bot = isPedBot(source)
	if bot then
		if getElementData(source,"bot") then
			for k,v in ipairs(noobs) do
			if source == v then table.remove(noobs,k) end
			end

			bots = bots - 1
			if bots < 1 then
				setBattleConfig2()
				triggerClientEvent("sendTimers",root,"Rescue the hostages within 5 mintues.")
				for k,v in ipairs(lawPlayers) do
					exports.DENdxmsg:createNewDxMessage(v,"Rescue the hostages within 5 minutes",0,255,0)
				end
			end
		elseif getElementData(source,"botX") then
			for k,v in ipairs(noobs) do
			if source == v then table.remove(noobs,k) end
			end
			ren = ren - 1
			if ren < 2 then
				if lastProgress then return false end
				lastProgress = setTimer(handleLastMission,180000,1)
				triggerClientEvent("sendTimers",root,"Hold here for 3 mintues.")
			end
		end
	end
end)

function handleLastMission()
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerSWAT") then
			givePlayerMoney(v,75000)
			exports.DENdxmsg:createNewDxMessage(v,"You have earned $75,000 for rescued and saved the civilians from the terrorists",0,255,0)
			exports.DENdxmsg:createNewDxMessage(v,"You can leave the area.",0,255,0)
		end
	end
	triggerClientEvent("sendTimers",root,"Zone successfully cleared.")
	stopEvent(true,"Area successfully cleared")
end

function setBattleConfig2()
	for k,v in ipairs(pos2) do
		local id,x,y,z = v[1],v[2],v[3],v[4]
		ped = createPed(id,x,y,z)
		if not mkr[ped] then mkr[ped] = createMarker(x,y,z-1,"cylinder",1.5,255,0,0,155) end
		attachElements(ped,mkr[ped],0,0,1)
		--setPedFrozen(ped,true)
		setPedAnimation(ped,"ped","cower",-1)
		addEventHandler("onMarkerHit",mkr[ped],rescued)
		setElementData(ped,"kills",true)
		table.insert(peds,ped)
		triggerClientEvent("assignHostages",root,0)
	end
	if isTimer(rescueTimer) then return false end
	rescueTimer = setTimer(stopEvent,300000,1,true,"You didn't rescue the hostages successfully")
end

function rescued(hitElement)
	if hitElement and getElementType(hitElement) == "player" then
		if source and isElement(source) then
			local attachedElements = getAttachedElements ( source )
			if attachedElements then
				for a,d in ipairs ( attachedElements ) do
					--setElementDimension(d,9999)
					table.insert(secured,#secured+1)
					for k,v in ipairs(peds) do
						if d == v then
							table.remove(peds,k)
						end
					end
					res = res + 1
					triggerClientEvent("assignHostages",root,#secured)
					if isElement(source) then destroyElement(source) end
					if isElement(d) then destroyElement(d) end
					if #secured >= 4 then
						triggerClientEvent("assignHostages",root,#secured)
						--for k,v in ipairs(lawPlayers) do
						--	exports.DENdxmsg:createNewDxMessage(v,"Hostages rescued successfully, criminals reinforcements incoming",0,255,0)
						--end
						triggerClientEvent("sendTimers",root,"Hostages rescued successfully")
						if isTimer(rescueTimer) then killTimer(rescueTimer) end
						setBattleConfig3()
					end
				end
			end
		end
	end
end


addEventHandler("onPedWasted",root,function()
	if getElementData(source,"kills") == true then
		for k,v in ipairs(peds) do
			if source == v then
				table.remove(peds,k)
				if isElement(mkr[v]) then destroyElement(mkr[v]) end
				if isElement(v) then destroyElement(v) end
			end
			--if #peds <= 3 then --and #secured <= 2 then
			res = res - 1
			triggerClientEvent("assignHostages",root,res)
			stopEvent(true,"You didn't rescue the hostages successfully (Hostage died)")
			--end
		end
	end
end)

function stopEvent(state,msg)
	if state == true then
		for k,v in ipairs(lawPlayers) do
			exports.DENdxmsg:createNewDxMessage(v,msg,255,0,0)
			setElementPosition(v,1785.62, -1258.84, 13.63)
			warpBitchOut(v)
		end
	end
	for k,v in ipairs(peds) do
		if isElement(mkr[v]) then destroyElement(mkr[v]) end
		if isElement(v) then destroyElement(v) end
	end
	for i=1,18 do
		if isElement(noobs[i]) then destroyElement(noobs[i]) end
	end
	triggerClientEvent("assignHostages",root,0)

	hostages = false
	peds = {}
	xx = {}
	deadLaw = {}
	lawPlayers = {}
	mkr = {}
	secured = {}
	bots = 18
	noobs = {}
	ren = 18
	res = 0
	if isTimer(lastProgress) then killTimer(lastProgress) end
	if isTimer(rescueTimer) then killTimer(rescueTimer) end
	if isTimer(startingTime) then killTimer(startingTime) end
	for k,v in ipairs(getElementsByType("ped", resourceRoot)) do
		if getElementData(v,"bot") then
			if getElementDimension(v) == 0 then
				if isElement(v) then destroyElement(v) end
			end
		end
	end
	triggerClientEvent("onResetHOEStats",root)
	triggerClientEvent("sendTimers",root,"")
	closeDoor()
	setMainEvent()
end

-- player quit and wasted

addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"isPlayerSWAT") then
		warpBitchOut(source)
		for k,v in ipairs (lawPlayers) do
			if ( v == source ) then
				table.remove( lawPlayers, k )
			end
		end
		if #lawPlayers < 1 then
			stopEvent()
		end
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if getElementData(source,"isPlayerSWAT") then
		for k,v in ipairs (lawPlayers) do
			if ( v == source ) then
				table.remove( lawPlayers, k )
			end
		end
		triggerClientEvent(source,"onToggleHOEStats",source,false)
		if #lawPlayers < 1 then
			stopEvent()
		end
		toggleControl(source,"sprint",true)
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
	if getElementData(thePlayer,"Group") == "SWAT Team" or getElementData(thePlayer,"Group") == "Military Forces" or getElementData(thePlayer,"isPlayerPrime") then
		local robType = "(Hostages rescue)"
		if ( isTimer(startingTime) ) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails(startingTime)
			exports.DENdxmsg:createNewDxMessage( thePlayer, "Time left until next mission: " .. onCalcTimer ( math.floor( timeLeft ) ) .. " "..robType, 225, 0, 0 )
		elseif ( isTimer(rescueTimer) ) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails( rescueTimer )
			exports.DENdxmsg:createNewDxMessage( thePlayer, "Rescue the hostages in " ..onCalcTimer( math.floor( timeLeft ) ), 235, 255, 0 )
		elseif ( isTimer(lastProgress) ) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails( lastProgress )
			exports.DENdxmsg:createNewDxMessage( thePlayer, "Hold in this place for " ..onCalcTimer( math.floor( timeLeft ) ), 235, 0, 0 )

		elseif not isTimer(startingTime) and hostages == false then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "Mission ready in Katty Building"..robType, 0, 255, 0 )
		elseif hostages == true then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "Mission in progress "..robType, 0, 255, 0 )
		else
			exports.DENdxmsg:createNewDxMessage( thePlayer, "There is no mission here anytime soon! "..robType, 0, 255, 0 )
		end
	else
		exports.DENdxmsg:createNewDxMessage( thePlayer, "Only official groups can use this command", 0, 255, 0 )
	end
end
addCommandHandler ( "hrtime",showTime)
addCommandHandler ( "hr",showTime)

setMainEvent()

------------ INT
door1 = createObject(11416,1745.2, -1044.88, 8895.5,0,0,90)
door2 = createObject(11416,1749.2, -1044.88, 8895.5,0,0,90)
door3 = createObject(11416,1752.2, -1044.88, 8895.5,0,0,90)

setElementAlpha(door1,0)
setElementAlpha(door2,0)
setElementAlpha(door3,0)
createObject(14444,1535.1748047,-1404.8691406,7826.0649414,0.0000000,0.0000000,0.0000000) --object(carter-topfloor)(1)
createObject(14447,1533.4023438,-1398.4384766,7830.0888672,0.0000000,0.0000000,90.0000000) --object(carter-balcony)(1)
createObject(1846,1531.5068359,-1400.6396484,7831.5732422,90.0000000,90.0000000,270.0000000) --object(shop_shelf04)(1)
createObject(2230,1532.8046875,-1402.0966797,7831.1752930,0.0000000,0.0000000,179.9945068) --object(swank_speaker_2)(1)
createObject(2230,1529.6035156,-1402.0878906,7831.1503906,0.0000000,0.0000000,179.9945068) --object(swank_speaker_2)(2)
createObject(2225,1531.3310547,-1401.5302734,7829.5815430,0.0000000,0.0000000,179.9945068) --object(swank_hi_fi_2)(1)
createObject(2184,1535.7607422,-1398.0419922,7829.7060547,0.0000000,0.0000000,69.9993896) --object(med_office6_desk_2)(1)
createObject(1714,1534.3665772,-1396.7510986,7829.7060547,0.0000000,0.0000000,60.0000000) --object(kb_swivelchair1)(1)
createObject(2190,1535.9792481,-1396.5189209,7830.4819336,0.0000000,0.0000000,270.0000000) --object(pc_1)(1)
createObject(2568,1530.0047607,-1399.0264893,7829.7060547,0.0000000,0.0000000,90.0000000) --object(hotel_dresser_3)(1)
createObject(2265,1530.0427246,-1397.4140625,7831.2817383,0.0000000,0.0000000,90.0000000) --object(frame_slim_6)(1)
createObject(2845,1529.7021484,-1398.8349609,7829.7060547,0.0000000,0.0000000,50.0000000) --object(gb_bedclothes04)(1)
createObject(1846,1541.3339844,-1416.6074219,7828.6469727,90.0000000,90.0000000,270.0000000) --object(shop_shelf04)(2)
createObject(2230,1542.7036133,-1418.0987549,7827.9628906,0.0000000,0.0000000,180.0000000) --object(swank_speaker_2)(3)
createObject(2230,1539.4030762,-1418.0930176,7827.9628906,0.0000000,0.0000000,179.9945068) --object(swank_speaker_2)(4)
createObject(2225,1541.1059570,-1417.5762940,7826.2446289,0.0000000,0.0000000,179.9945068) --object(swank_hi_fi_2)(2)
createObject(1703,1541.7880859,-1412.1230469,7826.2446289,0.0000000,0.0000000,0.0000000) --object(kb_couch02)(1)
createObject(1703,1541.7309570,-1409.6456299,7826.2446289,0.0000000,0.0000000,0.0000000) --object(kb_couch02)(3)
createObject(1703,1541.6833496,-1407.1688232,7826.2446289,0.0000000,0.0000000,0.0000000) --object(kb_couch02)(4)
createObject(1704,1538.6158447,-1412.0988769,7826.2446289,0.0000000,0.0000000,0.0000000) --object(kb_chair03)(1)
createObject(1704,1538.6069336,-1409.6373291,7826.2446289,0.0000000,0.0000000,0.0000000) --object(kb_chair03)(2)
createObject(2823,1544.2775879,-1410.3698731,7827.2993164,0.0000000,0.0000000,0.0000000) --object(gb_kitchtakeway01)(1)
createObject(2647,1539.5441894,-1409.7365723,7827.3413086,0.0000000,0.0000000,0.0000000) --object(cj_bs_cup)(1)
createObject(2647,1541.6523438,-1412.2753906,7827.3300781,0.0000000,0.0000000,0.0000000) --object(cj_bs_cup)(2)
createObject(2647,1544.0524902,-1407.1413574,7827.4560547,0.0000000,0.0000000,0.0000000) --object(cj_bs_cup)(3)
createObject(2047,1541.2998047,-1417.5429688,7831.9848633,0.0000000,0.0000000,179.9945068) --object(cj_flag1)(1)
createObject(644,1561.6536865,-1393.4639893,7830.9184570,0.0000000,0.0000000,279.9938965) --object(pot_02)(4)
createObject(14447,1560.8583984,-1395.0722656,7830.9604492,0.0000000,0.0000000,0.0000000) --object(carter-balcony)(3)
createObject(2133,1562.5361328,-1397.7137451,7830.6186523,0.0000000,0.0000000,180.0000000) --object(cj_kitch2_r)(1)
createObject(1775,1561.4295654,-1397.5521240,7831.7172852,0.0000000,0.0000000,180.0000000) --object(cj_sprunk1)(1)
createObject(2134,1565.4238281,-1397.7258301,7830.5947266,0.0000000,0.0000000,180.0000000) --object(cj_kitch2_m)(1)
createObject(2132,1564.5291748,-1397.7124023,7830.6196289,0.0000000,0.0000000,180.0000000) --object(cj_kitch2_sink)(2)
createObject(2341,1566.3127441,-1397.7238769,7830.6196289,0.0000000,0.0000000,270.0000000) --object(cj_kitch2_corner)(1)
createObject(2141,1566.2999268,-1396.7551269,7830.6196289,0.0000000,0.0000000,270.0000000) --object(cj_kitch2_l)(1)
createObject(2132,1566.3206787,-1394.7526856,7830.6196289,0.0000000,0.0000000,270.0000000) --object(cj_kitch2_sink)(3)
createObject(2133,1566.3291016,-1393.7357178,7830.6196289,0.0000000,0.0000000,269.9945068) --object(cj_kitch2_r)(2)
createObject(16779,1563.3925781,-1395.3916016,7835.1420898,0.0000000,0.0000000,0.0000000) --object(ufo_light02)(1)
createObject(2261,1563.6552734,-1393.3896484,7831.9658203,0.0000000,0.0000000,0.0000000) --object(frame_slim_2)(1)
createObject(14410,1563.0270996,-1408.0323486,7823.0673828,0.0000000,0.0000000,180.0000000) --object(carter-stairs03)(1)
createObject(18013,1567.4492188,-1399.5341797,7823.9287109,0.0000000,0.0000000,90.0000000) --object(int_rest_veg3)(1)
createObject(2745,1562.9960938,-1394.1250000,7821.1093750,0.0000000,0.0000000,359.9835205) --object(cj_stat_3)(3)
createObject(17546,1564.8369141,-1361.2822266,7835.4458008,0.0000000,0.0000000,269.9945068) --object(hydro3_lae)(2)
createObject(2813,1551.5427246,-1366.9969482,7820.7158203,0.0000000,0.0000000,0.0000000) --object(gb_novels01)(1)
createObject(2828,1535.4368897,-1397.4932861,7830.4819336,0.0000000,0.0000000,20.0000000) --object(gb_ornament02)(2)
createObject(2566,1531.9710693,-1393.6304932,7830.0864258,0.0000000,0.0000000,0.0000000) --object(hotel_s_bedset_3)(1)
createObject(3095,1533.3498535,-1405.3338623,7830.5454102,90.0000000,0.0000000,0.0000000) --object(a51_jetdoor)(1)
createObject(3095,1532.0233154,-1406.1838379,7830.5454102,90.0000000,0.0000000,270.0000000) --object(a51_jetdoor)(2)
createObject(3095,1537.1386719,-1406.2567139,7830.5454102,90.0000000,0.0000000,90.0000000) --object(a51_jetdoor)(3)
createObject(3095,1533.4346924,-1406.3540039,7829.3432617,180.0000000,0.0000000,0.0000000) --object(a51_jetdoor)(4)
createObject(1491,1532.9852295,-1401.7197266,7826.2446289,0.0000000,0.0000000,0.0000000) --object(gen_doorint01)(1)
createObject(1491,1536.0096435,-1401.7000732,7826.2446289,0.0000000,0.0000000,180.0000000) --object(gen_doorint01)(2)
createObject(16151,1559.5064697,-1397.4398193,7826.5434570,0.0000000,0.0000000,0.0000000) --object(ufo_bar)(2)
createObject(1726,1554.8742676,-1391.8851318,7826.2446289,0.0000000,0.0000000,0.0000000) --object(mrk_seating2)(1)
createObject(1726,1554.1987305,-1394.5256348,7826.2446289,0.0000000,0.0000000,90.0000000) --object(mrk_seating2)(2)
createObject(644,1554.2406006,-1391.7479248,7826.4477539,0.0000000,0.0000000,330.0000000) --object(pot_02)(25)
createObject(644,1559.9964600,-1409.8514404,7826.5468750,0.0000000,0.0000000,209.9963379) --object(pot_02)(26)
createObject(1726,1557.2763672,-1391.8846435,7826.2446289,0.0000000,0.0000000,0.0000000) --object(mrk_seating2)(3)
createObject(1726,1559.8917236,-1402.9205322,7826.2446289,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(4)
createObject(2964,1555.2519531,-1405.8666992,7826.2446289,0.0000000,0.0000000,270.0000000) --object(k_pooltablesm)(1)
createObject(1726,1559.9144287,-1407.1464844,7826.2446289,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(5)
createObject(2236,1559.3822022,-1405.5711670,7826.2446289,0.0000000,0.0000000,270.0000000) --object(coffee_swank_1)(1)
createObject(644,1559.9482422,-1391.7314453,7826.4477539,0.0000000,0.0000000,239.9908447) --object(pot_02)(27)
createObject(1726,1557.8210449,-1411.6090088,7826.2446289,0.0000000,0.0000000,182.0000000) --object(mrk_seating2)(6)
createObject(1726,1555.3143310,-1411.7012940,7826.2446289,0.0000000,0.0000000,181.9995117) --object(mrk_seating2)(8)
createObject(1726,1547.7722168,-1411.8848877,7826.2446289,0.0000000,0.0000000,181.9995117) --object(mrk_seating2)(9)
createObject(1726,1550.1520996,-1411.7984619,7826.2446289,0.0000000,0.0000000,181.9995117) --object(mrk_seating2)(10)
createObject(1775,1552.3703613,-1411.5616455,7827.3417969,0.0000000,0.0000000,180.0000000) --object(cj_sprunk1)(3)
createObject(1776,1551.1157227,-1411.5717773,7827.3442383,0.0000000,0.0000000,180.0000000) --object(cj_candyvendor)(2)
createObject(3002,1555.3181152,-1406.4193115,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt01)(1)
createObject(3001,1555.3962402,-1406.3524170,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp07)(1)
createObject(3000,1554.7834473,-1405.9575195,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp06)(1)
createObject(2999,1555.1801758,-1405.2454834,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp05)(1)
createObject(2997,1555.6663818,-1405.0480957,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp03)(1)
createObject(2996,1555.2252197,-1406.0549316,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp02)(1)
createObject(3101,1554.9715576,-1406.4455566,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt03)(1)
createObject(3102,1555.6109619,-1406.5550537,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt04)(1)
createObject(3104,1555.1114502,-1406.3443603,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt06)(1)
createObject(3106,1555.6634522,-1405.9056397,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolball8)(1)
createObject(3003,1555.5358887,-1405.5985107,7827.1752930,0.0000000,0.0000000,0.0000000) --object(k_poolballcue)(1)
createObject(3004,1555.4384766,-1406.0637207,7827.1367188,0.0000000,0.0000000,4.0000000) --object(k_poolq2)(1)
createObject(3004,1548.7321777,-1406.5590820,7827.5410156,300.0000000,0.0000000,293.2490234) --object(k_poolq2)(2)
createObject(14415,1535.1943359,-1404.8682861,7826.0781250,0.0000000,0.0000000,0.0000000) --object(carter-floors01)(1)
createObject(2232,1543.9281006,-1417.3167725,7826.8422852,0.0000000,0.0000000,180.0000000) --object(med_speaker_4)(1)
createObject(2232,1543.9277344,-1417.3164062,7828.0126953,0.0000000,0.0000000,179.9945068) --object(med_speaker_4)(2)
createObject(2232,1543.9277344,-1417.3164062,7829.2080078,0.0000000,0.0000000,179.9945068) --object(med_speaker_4)(3)
createObject(2232,1538.8526611,-1417.4204102,7826.8422852,0.0000000,0.0000000,179.9945068) --object(med_speaker_4)(4)
createObject(2232,1538.8525391,-1417.4199219,7828.0126953,0.0000000,0.0000000,179.9945068) --object(med_speaker_4)(5)
createObject(2232,1538.8525391,-1417.4199219,7829.1831055,0.0000000,0.0000000,179.9945068) --object(med_speaker_4)(6)
createObject(2232,1543.7805176,-1417.3272705,7830.1293945,0.0000000,90.0000000,179.9945068) --object(med_speaker_4)(7)
createObject(2232,1542.6041260,-1417.3041992,7830.1293945,0.0000000,90.0000000,179.9945068) --object(med_speaker_4)(8)
createObject(2232,1541.4519043,-1417.3062744,7830.1293945,0.0000000,90.0000000,179.9945068) --object(med_speaker_4)(9)
createObject(2232,1540.3000488,-1417.2832031,7830.1293945,0.0000000,90.0000000,179.9945068) --object(med_speaker_4)(10)
createObject(2232,1539.1236572,-1417.2602539,7830.1293945,0.0000000,90.0000000,179.9945068) --object(med_speaker_4)(11)
createObject(1649,1533.3228760,-1400.4747315,7827.8354492,0.0000000,0.0000000,60.0000000) --object(wglasssmash)(1)
createObject(1557,1527.3198242,-1417.6154785,7819.9140625,0.0000000,0.0000000,90.0000000) --object(gen_doorext19)(7)
createObject(1557,1527.3056641,-1414.5805664,7819.9140625,0.0000000,0.0000000,270.5000000) --object(gen_doorext19)(8)
createObject(4562,1515.8343506,-1386.4663086,7825.9272461,180.0000000,0.0000000,0.0000000) --object(laplaza2_lan)(1)
createObject(3440,1536.8973389,-1394.2988281,7827.2734375,0.0000000,0.0000000,70.0000000) --object(arptpillar01_lvs)(1)
createObject(1649,1536.6234131,-1394.7221680,7827.8105469,0.0000000,0.0000000,59.9963379) --object(wglasssmash)(2)
createObject(3440,1535.4166260,-1396.8011475,7827.2734375,0.0000000,0.0000000,69.9993896) --object(arptpillar01_lvs)(2)
createObject(3440,1534.4101562,-1398.5439453,7827.1240234,0.0000000,0.0000000,69.9993896) --object(arptpillar01_lvs)(3)
createObject(1649,1533.3222656,-1400.4746094,7827.8354492,0.0000000,0.0000000,239.9963379) --object(wglasssmash)(3)
createObject(1649,1536.6230469,-1394.7216797,7827.8105469,0.0000000,0.0000000,239.9963379) --object(wglasssmash)(4)
createObject(2206,1533.7080078,-1394.1779785,7826.2446289,0.0000000,0.0000000,180.0000000) --object(med_office8_desk_02)(1)
createObject(1714,1532.7846680,-1392.7419434,7826.2446289,0.0000000,0.0000000,0.0000000) --object(kb_swivelchair1)(16)
createObject(14455,1536.1087647,-1391.0935059,7827.9165039,0.0000000,0.0000000,180.0000000) --object(gs_bookcase)(7)
createObject(14455,1530.2832031,-1391.0979004,7827.9165039,0.0000000,0.0000000,179.9945068) --object(gs_bookcase)(8)
createObject(14455,1529.4827881,-1392.2031250,7827.9165039,0.0000000,0.0000000,269.9945068) --object(gs_bookcase)(9)
createObject(14455,1529.4885254,-1398.0024414,7827.9165039,0.0000000,0.0000000,269.9890137) --object(gs_bookcase)(10)
createObject(2010,1530.0996094,-1391.7403565,7826.2260742,0.0000000,0.0000000,0.0000000) --object(nu_plant3_ofc)(1)
createObject(2010,1536.7437744,-1391.6640625,7826.2260742,0.0000000,0.0000000,0.0000000) --object(nu_plant3_ofc)(2)
createObject(2010,1536.7231445,-1393.5683594,7826.2260742,0.0000000,0.0000000,0.0000000) --object(nu_plant3_ofc)(3)
createObject(2004,1537.1214600,-1392.2200928,7827.6791992,0.0000000,0.0000000,270.0000000) --object(cr_safe_door)(1)
createObject(14455,1527.4483643,-1401.6679688,7827.9165039,0.0000000,0.0000000,359.9890137) --object(gs_bookcase)(11)
createObject(2010,1529.9708252,-1401.1308594,7826.2260742,0.0000000,0.0000000,0.0000000) --object(nu_plant3_ofc)(4)
createObject(2190,1533.3144531,-1394.3651123,7827.1811523,0.0000000,0.0000000,180.0000000) --object(pc_1)(4)
createObject(2828,1532.1116943,-1394.1431885,7827.1811523,0.0000000,0.0000000,320.0000000) --object(gb_ornament02)(3)
createObject(2964,1548.2519531,-1405.9174805,7826.2446289,0.0000000,0.0000000,270.0000000) --object(k_pooltablesm)(2)
createObject(3002,1548.3184815,-1405.8197022,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt01)(2)
createObject(3001,1548.4965820,-1406.1298828,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp07)(2)
createObject(2998,1548.0158691,-1406.5421143,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp04)(1)
createObject(2995,1548.0152588,-1405.3634033,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballstp01)(1)
createObject(3104,1548.0423584,-1405.9650879,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt06)(2)
createObject(3105,1548.5559082,-1406.6151123,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt07)(1)
createObject(3101,1548.5642090,-1405.2637940,7827.1748047,0.0000000,0.0000000,0.0000000) --object(k_poolballspt03)(2)
createObject(3525,1544.8784180,-1397.9406738,7829.0532227,0.0000000,0.0000000,260.0000000) --object(exbrtorch01)(1)
createObject(3525,1547.4658203,-1398.1250000,7829.0532227,0.0000000,0.0000000,79.9914551) --object(exbrtorch01)(3)
createObject(1714,1532.1743164,-1395.3905029,7826.2446289,0.0000000,0.0000000,140.0000000) --object(kb_swivelchair1)(17)
createObject(1726,1533.4423828,-1398.9902344,7826.2446289,0.0000000,0.0000000,240.0000000) --object(mrk_seating2)(11)
createObject(2528,1532.6055908,-1403.1762695,7826.2446289,0.0000000,0.0000000,90.0000000) --object(cj_toilet3)(1)
createObject(2526,1536.6806641,-1404.8464356,7826.2446289,0.0000000,0.0000000,180.0000000) --object(cj_bath4)(1)
createObject(2527,1533.5231934,-1404.8261719,7826.2050781,0.0000000,0.0000000,90.0000000) --object(cj_shower4)(1)
createObject(3440,1532.1507568,-1402.1450195,7827.2485352,0.0000000,0.0000000,69.9993896) --object(arptpillar01_lvs)(4)
createObject(3440,1537.0007324,-1402.1918945,7827.2734375,0.0000000,0.0000000,69.9993896) --object(arptpillar01_lvs)(5)
createObject(2523,1536.6141357,-1402.8204346,7826.2446289,0.0000000,0.0000000,270.0000000) --object(cj_b_sink3)(1)
createObject(2010,1534.6112060,-1404.8138428,7826.2260742,0.0000000,0.0000000,0.0000000) --object(nu_plant3_ofc)(5)
createObject(1491,1546.0305176,-1409.7287598,7819.9140625,0.0000000,0.0000000,179.9945068) --object(gen_doorint01)(3)
createObject(1491,1543.0047607,-1409.7474365,7819.9140625,0.0000000,0.0000000,359.9945068) --object(gen_doorint01)(4)
createObject(1491,1543.0004883,-1401.5915527,7819.9140625,0.0000000,0.0000000,359.9890137) --object(gen_doorint01)(5)
createObject(1491,1546.0278320,-1401.5784912,7819.9140625,0.0000000,0.0000000,179.9890137) --object(gen_doorint01)(6)
createObject(2745,1557.5721435,-1391.4959717,7821.1093750,0.0000000,0.0000000,359.9835205) --object(cj_stat_3)(3)
createObject(1775,1556.1873779,-1391.5943603,7821.0112305,0.0000000,0.0000000,0.0000000) --object(cj_sprunk1)(4)
createObject(1776,1558.9189453,-1391.6346435,7821.0136719,0.0000000,0.0000000,0.0000000) --object(cj_candyvendor)(3)
createObject(644,1555.0921631,-1391.8018799,7820.2172852,0.0000000,0.0000000,290.0000000) --object(pot_02)(30)
createObject(644,1560.0167236,-1391.7414551,7820.2172852,0.0000000,0.0000000,249.9951172) --object(pot_02)(31)
createObject(1726,1556.8706055,-1410.9362793,7819.9140625,0.0000000,0.0000000,179.9995117) --object(mrk_seating2)(12)
createObject(1726,1559.3160400,-1410.9321289,7819.9140625,0.0000000,0.0000000,179.9995117) --object(mrk_seating2)(13)
createObject(1726,1559.8513184,-1408.1668701,7819.9140625,0.0000000,0.0000000,269.9995117) --object(mrk_seating2)(14)
createObject(1726,1559.8426514,-1405.5638428,7819.9140625,0.0000000,0.0000000,269.9995117) --object(mrk_seating2)(15)
createObject(1726,1559.9257812,-1402.8299560,7819.9140625,0.0000000,0.0000000,268.7495117) --object(mrk_seating2)(16)
createObject(644,1560.0686035,-1411.0021973,7820.2172852,0.0000000,0.0000000,119.9938965) --object(pot_02)(32)
createObject(644,1560.0770264,-1401.9284668,7820.2172852,0.0000000,0.0000000,179.9938965) --object(pot_02)(33)
createObject(2565,1537.3378906,-1398.8646240,7820.4936523,0.0000000,0.0000000,90.0000000) --object(hotel_d_bedset_3)(1)
createObject(644,1535.6153565,-1400.4020996,7820.2133789,0.0000000,0.0000000,349.9890137) --object(pot_02)(34)
createObject(644,1535.5120850,-1391.8104248,7820.2133789,0.0000000,0.0000000,329.9859619) --object(pot_02)(35)
createObject(2357,1550.2888184,-1396.3348389,7820.3090820,0.0000000,0.0000000,270.0000000) --object(dunc_dinning)(1)
createObject(1714,1550.3272705,-1399.3353272,7819.9140625,0.0000000,0.0000000,188.0000000) --object(kb_swivelchair1)(18)
createObject(1714,1548.7824707,-1397.8288574,7819.9140625,0.0000000,0.0000000,87.9980469) --object(kb_swivelchair1)(19)
createObject(1714,1548.7382812,-1396.3299560,7819.9140625,0.0000000,0.0000000,87.9949951) --object(kb_swivelchair1)(20)
createObject(1714,1548.9111328,-1394.5678711,7819.9140625,0.0000000,0.0000000,57.9949951) --object(kb_swivelchair1)(21)
createObject(1714,1550.3574219,-1393.5378418,7819.9140625,0.0000000,0.0000000,347.9913330) --object(kb_swivelchair1)(22)
createObject(1714,1551.6636963,-1394.9244385,7819.9140625,0.0000000,0.0000000,277.9864502) --object(kb_swivelchair1)(23)
createObject(1714,1551.7463379,-1396.4223633,7819.9140625,0.0000000,0.0000000,257.9815674) --object(kb_swivelchair1)(24)
createObject(1714,1551.7947998,-1397.8707275,7819.9140625,0.0000000,0.0000000,257.9809570) --object(kb_swivelchair1)(25)
createObject(3859,1545.9968262,-1398.5166016,7822.0717773,0.0000000,0.0000000,197.5000000) --object(ottosmash04)(1)
createObject(3859,1545.9334717,-1391.7153320,7822.0717773,0.0000000,0.0000000,197.4957275) --object(ottosmash04)(2)
createObject(3859,1545.9326172,-1391.7148438,7822.0717773,0.0000000,0.0000000,17.4957275) --object(ottosmash04)(3)
createObject(3859,1545.9960938,-1398.5166016,7822.0717773,0.0000000,0.0000000,17.4957275) --object(ottosmash04)(4)
createObject(3498,1546.1279297,-1394.4735107,7820.4038086,0.0000000,0.0000000,0.0000000) --object(wdpillar01_lvs)(1)
createObject(3498,1546.1127930,-1396.1223144,7820.4038086,0.0000000,0.0000000,0.0000000) --object(wdpillar01_lvs)(2)
createObject(14455,1546.8371582,-1401.1490478,7821.5859375,0.0000000,0.0000000,0.0000000) --object(gs_bookcase)(12)
createObject(14455,1548.2602539,-1401.1867676,7821.5859375,0.0000000,0.0000000,0.0000000) --object(gs_bookcase)(13)
createObject(644,1553.4674072,-1400.6170654,7820.1391602,0.0000000,0.0000000,129.9859619) --object(pot_02)(36)
createObject(14455,1551.2270508,-1391.1700440,7821.5859375,0.0000000,0.0000000,180.0000000) --object(gs_bookcase)(14)
createObject(14455,1552.6517334,-1391.1378174,7821.5859375,0.0000000,0.0000000,179.9945068) --object(gs_bookcase)(15)
createObject(644,1553.5052490,-1391.6738281,7820.1391602,0.0000000,0.0000000,249.9847412) --object(pot_02)(37)
createObject(1846,1553.0146484,-1396.4145508,7821.4355469,90.0000000,90.0000000,0.0000000) --object(shop_shelf04)(1)
createObject(2612,1553.9652100,-1393.8354492,7821.5800781,0.0000000,0.0000000,270.0000000) --object(police_nb2)(1)
createObject(2611,1553.9245606,-1399.0718994,7821.5981445,0.0000000,0.0000000,270.0000000) --object(police_nb1)(1)
createObject(1846,1542.5721435,-1392.1226807,7821.2861328,90.0000000,90.0000000,90.0000000) --object(shop_shelf04)(1)
createObject(1846,1542.5700684,-1392.1470947,7821.2612305,90.0000000,90.0000000,90.0000000) --object(shop_shelf04)(1)
createObject(1726,1545.2410889,-1392.2093506,7819.9140625,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(17)
createObject(1726,1543.6505127,-1394.9956055,7819.9140625,0.0000000,0.0000000,180.0000000) --object(mrk_seating2)(18)
createObject(1726,1540.0618897,-1393.9683838,7819.9140625,0.0000000,0.0000000,89.9945068) --object(mrk_seating2)(19)
createObject(2568,1541.5186768,-1400.6168213,7819.9140625,0.0000000,0.0000000,180.0000000) --object(hotel_dresser_3)(2)
createObject(2236,1542.1094971,-1393.4801025,7819.9140625,0.0000000,0.0000000,0.0000000) --object(coffee_swank_1)(2)
createObject(2225,1544.5054932,-1391.3457031,7819.9140625,0.0000000,0.0000000,0.0000000) --object(swank_hi_fi_2)(4)
createObject(2028,1542.3818359,-1392.9663086,7820.5029297,0.0000000,0.0000000,0.0000000) --object(swank_console)(1)
createObject(2344,1543.7487793,-1394.7371826,7820.8266602,0.0000000,0.0000000,160.0000000) --object(cj_remote)(2)
createObject(937,1550.7069092,-1411.2921143,7820.3886719,0.0000000,0.0000000,90.0000000) --object(cj_df_worktop)(1)
createObject(5706,1554.0993652,-1428.4758301,7830.6523438,0.0000000,0.0000000,270.0000000) --object(studiobld03_law)(1)
createObject(3095,1546.0148926,-1414.4760742,7820.3920898,90.0000000,0.0000000,90.0000000) --object(a51_jetdoor)(5)
createObject(3095,1538.5272217,-1410.2655029,7820.3920898,90.0000000,0.0000000,180.0000000) --object(a51_jetdoor)(6)
createObject(3095,1537.3414307,-1414.5561523,7820.3920898,90.0000000,0.0000000,269.9945068) --object(a51_jetdoor)(7)
createObject(3095,1541.7644043,-1418.2308350,7820.3920898,90.0000000,0.0000000,359.9890137) --object(a51_jetdoor)(8)
createObject(3498,1534.2091065,-1409.8448486,7820.5732422,0.0000000,0.0000000,0.0000000) --object(wdpillar01_lvs)(3)
createObject(3498,1534.2058106,-1410.1700440,7820.5732422,0.0000000,0.0000000,0.0000000) --object(wdpillar01_lvs)(5)
createObject(3498,1534.5045166,-1401.7221680,7820.5732422,0.0000000,0.0000000,0.0000000) --object(wdpillar01_lvs)(6)
createObject(3498,1534.5078125,-1401.3212891,7820.5732422,0.0000000,0.0000000,0.0000000) --object(wdpillar01_lvs)(7)
createObject(3383,1543.7116699,-1417.3179932,7819.9140625,0.0000000,0.0000000,0.0000000) --object(a51_labtable1_)(1)
createObject(3383,1539.4862060,-1417.3188477,7819.9140625,0.0000000,0.0000000,0.0000000) --object(a51_labtable1_)(2)
createObject(860,1544.4567871,-1417.0087891,7820.9697266,0.0000000,0.0000000,0.0000000) --object(sand_plant01)(1)
createObject(860,1542.9473877,-1416.9602051,7820.9697266,0.0000000,0.0000000,0.0000000) --object(sand_plant01)(2)
createObject(860,1540.3479004,-1416.9741211,7820.9697266,0.0000000,0.0000000,0.0000000) --object(sand_plant01)(3)
createObject(860,1538.7908935,-1417.0491943,7820.9697266,0.0000000,0.0000000,0.0000000) --object(sand_plant01)(4)
createObject(937,1539.1691894,-1414.1369629,7820.3886719,0.0000000,0.0000000,180.0000000) --object(cj_df_worktop)(2)
createObject(937,1541.1203613,-1414.1499023,7820.3886719,0.0000000,0.0000000,179.9945068) --object(cj_df_worktop)(3)
createObject(937,1544.9447022,-1414.1326904,7820.3886719,0.0000000,0.0000000,179.9945068) --object(cj_df_worktop)(4)
createObject(1577,1544.6652832,-1414.1041260,7820.8427734,0.0000000,0.0000000,320.0000000) --object(drug_yellow)(1)
createObject(1577,1545.2406006,-1414.1175537,7820.8427734,0.0000000,0.0000000,259.9987793) --object(drug_yellow)(2)
createObject(1577,1538.6687012,-1413.9599609,7820.8427734,0.0000000,0.0000000,259.9969482) --object(drug_yellow)(3)
createObject(1579,1539.1682129,-1414.2941894,7820.8427734,0.0000000,0.0000000,30.0000000) --object(drug_blue)(1)
createObject(1579,1540.8177490,-1414.2506103,7820.8427734,0.0000000,0.0000000,129.9981690) --object(drug_blue)(2)
createObject(1580,1541.3283691,-1414.1209717,7820.8535156,0.0000000,0.0000000,340.0000000) --object(drug_red)(1)
createObject(1580,1538.8580322,-1414.2486572,7821.0029297,0.0000000,0.0000000,339.9993897) --object(drug_red)(2)
createObject(1578,1544.9879150,-1414.2291260,7821.0136719,0.0000000,0.0000000,0.0000000) --object(drug_green)(1)
createObject(1550,1545.6394043,-1413.1744385,7820.3076172,0.0000000,0.0000000,0.0000000) --object(cj_money_bag)(1)
createObject(1550,1545.0412598,-1413.1221924,7819.9838867,86.0000000,0.0000000,220.0000000) --object(cj_money_bag)(2)
createObject(1575,1544.2270508,-1413.9122315,7820.8408203,0.0000000,0.0000000,50.0000000) --object(drug_white)(1)
createObject(1575,1539.7846680,-1414.1876221,7820.8408203,0.0000000,0.0000000,49.9987793) --object(drug_white)(2)
createObject(1575,1540.3347168,-1413.8023682,7820.8408203,0.0000000,0.0000000,159.9987793) --object(drug_white)(3)
createObject(936,1538.4886475,-1411.0762940,7820.3886719,0.0000000,0.0000000,0.0000000) --object(cj_df_worktop_2)(1)
createObject(936,1540.4434815,-1411.0655518,7820.3886719,0.0000000,0.0000000,0.0000000) --object(cj_df_worktop_2)(2)
createObject(2035,1538.0855713,-1410.7478027,7820.8886719,0.0000000,0.0000000,0.0000000) --object(cj_m16)(1)
createObject(2035,1538.0863037,-1411.0223389,7820.8886719,0.0000000,0.0000000,0.0000000) --object(cj_m16)(2)
createObject(2035,1538.0876465,-1411.3718262,7820.8886719,0.0000000,0.0000000,0.0000000) --object(cj_m16)(3)
createObject(2036,1540.6477051,-1410.7282715,7820.8979492,0.0000000,0.0000000,0.0000000) --object(cj_psg1)(1)
createObject(2036,1540.1986084,-1411.0550537,7820.8979492,0.0000000,0.0000000,0.0000000) --object(cj_psg1)(2)
createObject(2036,1540.6501465,-1411.3527832,7820.8979492,0.0000000,0.0000000,0.0000000) --object(cj_psg1)(3)
createObject(2044,1538.8497315,-1410.7738037,7820.8916016,0.0000000,0.0000000,0.0000000) --object(cj_mp5k)(1)
createObject(2044,1539.1999512,-1410.7717285,7820.8916016,0.0000000,0.0000000,298.0000000) --object(cj_mp5k)(2)
createObject(2044,1539.2006836,-1411.0717773,7820.8916016,0.0000000,0.0000000,0.0000000) --object(cj_mp5k)(3)
createObject(2044,1538.8249512,-1411.0981445,7820.8916016,0.0000000,0.0000000,20.0000000) --object(cj_mp5k)(4)
createObject(2044,1538.8256836,-1411.3979492,7820.8916016,0.0000000,0.0000000,160.0000000) --object(cj_mp5k)(5)
createObject(2044,1539.2001953,-1411.3205566,7820.8916016,0.0000000,0.0000000,30.0000000) --object(cj_mp5k)(6)
createObject(2044,1539.7510986,-1411.3927002,7820.8916016,0.0000000,0.0000000,310.0000000) --object(cj_mp5k)(7)
createObject(2044,1539.7460938,-1410.6928711,7820.8916016,0.0000000,0.0000000,0.0000000) --object(cj_mp5k)(8)
createObject(2044,1541.0987549,-1410.9610596,7820.8916016,0.0000000,0.0000000,30.0000000) --object(cj_mp5k)(9)
createObject(1672,1540.9782715,-1410.6926269,7820.9453125,0.0000000,0.0000000,0.0000000) --object(gasgrenade)(1)
createObject(1672,1540.8442383,-1410.7810059,7820.9453125,0.0000000,0.0000000,90.0000000) --object(gasgrenade)(2)
createObject(1672,1538.9826660,-1410.5427246,7820.9453125,0.0000000,0.0000000,90.0000000) --object(gasgrenade)(3)
createObject(2780,1542.0347900,-1423.4914551,7822.5263672,76.0000000,0.0000000,190.0000000) --object(cj_smoke_mach)(2)
createObject(914,1543.4924316,-1418.2344971,7822.3364258,0.0000000,0.0000000,0.0000000) --object(grill)(1)
createObject(914,1539.1174316,-1418.2387695,7822.3364258,0.0000000,0.0000000,0.0000000) --object(grill)(2)
createObject(1726,1553.1883545,-1409.0715332,7819.9140625,0.0000000,0.0000000,179.9945068) --object(mrk_seating2)(20)
createObject(1726,1550.5874023,-1409.1003418,7819.9140625,0.0000000,0.0000000,179.9945068) --object(mrk_seating2)(21)
createObject(1726,1541.6588135,-1409.0983887,7819.9140625,0.0000000,0.0000000,179.9945068) --object(mrk_seating2)(22)
createObject(1726,1539.2102051,-1409.0751953,7819.9140625,0.0000000,0.0000000,179.9945068) --object(mrk_seating2)(23)
createObject(1726,1536.7617188,-1409.0776367,7819.9140625,0.0000000,0.0000000,179.9945068) --object(mrk_seating2)(24)
createObject(644,1533.9223633,-1409.0897217,7820.2612305,0.0000000,0.0000000,79.9890137) --object(pot_02)(38)
createObject(644,1535.1469727,-1402.1870117,7820.2612305,0.0000000,0.0000000,269.9859619) --object(pot_02)(39)
createObject(1726,1533.7011719,-1398.9855957,7819.9140625,0.0000000,0.0000000,269.9945068) --object(mrk_seating2)(25)
createObject(1726,1530.9971924,-1398.2943115,7819.9140625,0.0000000,0.0000000,359.9945068) --object(mrk_seating2)(26)
createObject(1726,1528.4873047,-1398.2612305,7819.9140625,0.0000000,0.0000000,359.9890137) --object(mrk_seating2)(27)
createObject(644,1533.9300537,-1398.1828613,7820.2612305,0.0000000,0.0000000,269.9835205) --object(pot_02)(40)
createObject(1726,1528.0600586,-1401.2714844,7819.9140625,0.0000000,0.0000000,89.9890137) --object(mrk_seating2)(28)
createObject(1726,1528.0681152,-1403.7741699,7819.9140625,0.0000000,0.0000000,89.9890137) --object(mrk_seating2)(29)
createObject(1726,1528.0256348,-1406.2812500,7819.9140625,0.0000000,0.0000000,89.9890137) --object(mrk_seating2)(30)
createObject(1726,1528.0351562,-1408.8103027,7819.9140625,0.0000000,0.0000000,89.9890137) --object(mrk_seating2)(31)
createObject(1506,1537.2337647,-1394.2957764,7826.2446289,0.0000000,0.0000000,0.0000000) --object(gen_doorext08)(1)
createObject(2010,1539.3699951,-1394.6239014,7826.2260742,0.0000000,0.0000000,0.0000000) --object(nu_plant3_ofc)(6)

function createObjectToLS(id,x,y,z,r1,r2,r3)
	s = createObject(id,x+2500,y+1000,z,r1,r2,r3)
end

createObjectToLS(8565,-760.3114014,-1967.2869873,8888.9355469,0.0000000,0.0000000,0.0000000) --object(vgsebuild03_lvs)(1)
createObjectToLS(3984,-754.1767578,-1987.8798828,8898.1289062,0.0000000,0.0000000,0.0000000) --object(churchprog1_lan)(1)
createObjectToLS(8565,-722.0224609,-1989.1914062,8888.9238281,0.0000000,0.0000000,270.0000000) --object(vgsebuild03_lvs)(2)
createObjectToLS(8565,-780.4638672,-1989.1923828,8888.9531250,0.0000000,0.0000000,90.0000000) --object(vgsebuild03_lvs)(3)
createObjectToLS(14409,-751.2820435,-2016.0306397,8891.2822266,0.0000000,0.0000000,0.0000000) --object(carter-stairs02)(1)
createObjectToLS(8565,-729.3104858,-2027.1831055,8888.9238281,0.0000000,0.0000000,180.0000000) --object(vgsebuild03_lvs)(4)
createObjectToLS(8565,-773.1279297,-2027.2177734,8888.9238281,0.0000000,0.0000000,179.9945068) --object(vgsebuild03_lvs)(5)
createObjectToLS(3095,-744.7274780,-2013.3968506,8894.5068359,180.0000000,0.0000000,0.0000000) --object(a51_jetdoor)(1)
createObjectToLS(3095,-744.7265625,-2022.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(2)
createObjectToLS(3095,-753.7265625,-2022.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(3)
createObjectToLS(3095,-757.7155762,-2013.4270019,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(4)
createObjectToLS(3095,-735.7865601,-2013.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(5)
createObjectToLS(3095,-735.7861328,-2004.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(6)
createObjectToLS(3095,-735.7861328,-1995.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(7)
createObjectToLS(3095,-735.7861328,-1986.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(8)
createObjectToLS(3095,-766.7148438,-2013.4267578,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(9)
createObjectToLS(3095,-766.7148438,-2004.4267578,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(10)
createObjectToLS(3095,-766.7148438,-1995.4267578,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(11)
createObjectToLS(3095,-766.7148438,-1986.4267578,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(12)
createObjectToLS(3095,-753.7265625,-2031.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(14)
createObjectToLS(3850,-753.3255005,-2010.7166748,8895.0537109,0.0000000,0.0000000,0.0000000) --object(carshowbann_sfsx)(1)
createObjectToLS(3850,-755.0877075,-2008.9881592,8895.0537109,0.0000000,0.0000000,270.0000000) --object(carshowbann_sfsx)(2)
createObjectToLS(3850,-756.8175049,-2008.9901123,8895.0537109,0.0000000,0.0000000,270.0000000) --object(carshowbann_sfsx)(3)
createObjectToLS(3850,-760.3702393,-2008.9826660,8895.0537109,0.0000000,0.0000000,270.0000000) --object(carshowbann_sfsx)(4)
createObjectToLS(3850,-762.2612305,-2007.0913086,8895.0537109,0.0000000,0.0000000,180.0000000) --object(carshowbann_sfsx)(5)
createObjectToLS(3850,-762.2583008,-2003.4942627,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(6)
createObjectToLS(3850,-762.2487183,-1999.9468994,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(7)
createObjectToLS(3850,-762.2343750,-1996.3675537,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(8)
createObjectToLS(3850,-762.2360840,-1992.7913818,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(9)
createObjectToLS(3850,-762.2351685,-1989.2382812,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(10)
createObjectToLS(3850,-762.2505493,-1985.6124268,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(11)
createObjectToLS(3850,-753.3218384,-2014.2670898,8895.0537109,0.0000000,0.0000000,0.0000000) --object(carshowbann_sfsx)(12)
createObjectToLS(3850,-753.3350220,-2015.9918213,8895.0537109,0.0000000,0.0000000,0.0000000) --object(carshowbann_sfsx)(13)
createObjectToLS(3850,-749.1760254,-2010.7769775,8895.0537109,0.0000000,0.0000000,0.0000000) --object(carshowbann_sfsx)(14)
createObjectToLS(3850,-749.1820679,-2014.3040772,8895.0537109,0.0000000,0.0000000,0.0000000) --object(carshowbann_sfsx)(15)
createObjectToLS(3850,-749.1816406,-2016.0017090,8895.0537109,0.0000000,0.0000000,0.0000000) --object(carshowbann_sfsx)(16)
createObjectToLS(3850,-747.4192505,-2008.9257812,8895.0537109,0.0000000,0.0000000,270.0000000) --object(carshowbann_sfsx)(17)
createObjectToLS(3850,-745.7197266,-2008.9399414,8895.0537109,0.0000000,0.0000000,270.0000000) --object(carshowbann_sfsx)(18)
createObjectToLS(3850,-742.1434326,-2008.9456787,8895.0537109,0.0000000,0.0000000,270.0000000) --object(carshowbann_sfsx)(19)
createObjectToLS(3850,-740.2279663,-2007.1655273,8895.0537109,0.0000000,0.0000000,180.0000000) --object(carshowbann_sfsx)(20)
createObjectToLS(3850,-740.2379761,-2003.5866699,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(21)
createObjectToLS(3850,-740.2465210,-2000.0090332,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(22)
createObjectToLS(3850,-740.2460938,-1996.4324951,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(23)
createObjectToLS(3850,-740.2460938,-1992.8553467,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(24)
createObjectToLS(3850,-740.2460938,-1989.2308350,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(25)
createObjectToLS(3850,-740.2460938,-1985.6300049,8895.0537109,0.0000000,0.0000000,179.9945068) --object(carshowbann_sfsx)(26)
createObjectToLS(3598,-750.9877319,-1980.9233398,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(1)
createObjectToLS(3598,-725.7216797,-1980.8782959,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(2)
createObjectToLS(3598,-721.4083252,-1983.3507080,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(3)
createObjectToLS(3598,-721.5419922,-1998.1279297,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(4)
createObjectToLS(3598,-709.2382812,-1991.5332031,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(5)
createObjectToLS(3095,-726.7861328,-1995.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(16)
createObjectToLS(3095,-726.7861328,-1986.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(17)
createObjectToLS(3598,-721.7024536,-2013.1955566,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(6)
createObjectToLS(3095,-726.7861328,-2004.3964844,8894.5068359,180.0000000,0.0000000,0.0000000) --object(a51_jetdoor)(18)
createObjectToLS(3598,-709.3567505,-2005.9938965,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(7)
createObjectToLS(1491,-734.1524658,-1991.8293457,8894.5029297,0.0000000,0.0000000,270.0000000) --object(gen_doorint01)(1)
createObjectToLS(3055,-734.0933227,-1987.9028320,8896.7021484,0.0000000,0.0000000,270.0000000) --object(kmb_shutter)(1)
createObjectToLS(3055,-768.6962891,-2008.2402344,8896.7070312,0.0000000,0.0000000,270.0000000) --object(kmb_shutter)(2)
createObjectToLS(1491,-768.7285156,-2004.3642578,8894.5078125,0.0000000,0.0000000,90.0000000) --object(gen_doorint01)(2)
createObjectToLS(3598,-758.2310791,-1980.6358643,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(8)
createObjectToLS(3598,-781.6727295,-1983.3214111,8901.3769531,0.0000000,0.0000000,180.0000000) --object(hillhouse01_la)(9)
createObjectToLS(3598,-781.7265625,-1998.0927734,8901.3769531,0.0000000,0.0000000,179.9945068) --object(hillhouse01_la)(10)
createObjectToLS(3095,-775.7148438,-1986.4267578,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(19)
createObjectToLS(4012,-754.0398560,-2005.5263672,8896.9375000,179.9945068,0.0000000,0.0000000) --object(termanexgrd1_lan)(2)
createObjectToLS(3095,-775.7148438,-1995.4267578,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(20)
createObjectToLS(3598,-793.0238648,-1992.5147705,8901.3769531,0.0000000,0.0000000,179.9945068) --object(hillhouse01_la)(11)
createObjectToLS(3598,-781.7630615,-2013.0523682,8901.3769531,0.0000000,0.0000000,179.9945068) --object(hillhouse01_la)(12)
createObjectToLS(3095,-775.7148438,-2004.4267578,8894.5117188,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(21)
createObjectToLS(3598,-792.4783935,-2006.9050293,8901.3769531,0.0000000,0.0000000,179.9945068) --object(hillhouse01_la)(13)
createObjectToLS(3598,-735.6143799,-2024.9797363,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(14)
createObjectToLS(3598,-721.7098389,-2019.5218506,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(15)
createObjectToLS(3095,-735.7861328,-2022.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(22)
createObjectToLS(3598,-767.1042481,-2024.9669190,8901.3769531,0.0000000,0.0000000,180.0000000) --object(hillhouse01_la)(16)
createObjectToLS(3598,-769.1035156,-2029.7402344,8901.3769531,0.0000000,0.0000000,179.9945068) --object(hillhouse01_la)(17)
createObjectToLS(3095,-744.7265625,-2031.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(23)
createObjectToLS(3598,-733.7294922,-2030.2041016,8901.3769531,0.0000000,0.0000000,0.0000000) --object(hillhouse01_la)(18)
createObjectToLS(3095,-766.7065430,-2022.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(25)
createObjectToLS(3095,-757.7060547,-2022.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(26)
createObjectToLS(3598,-782.1714477,-2020.4157715,8901.3769531,0.0000000,0.0000000,179.9945068) --object(hillhouse01_la)(20)
createObjectToLS(3055,-734.3876953,-2008.1376953,8896.7021484,0.0000000,0.0000000,270.0000000) --object(kmb_shutter)(3)
createObjectToLS(1491,-734.4323731,-2004.2709961,8894.5029297,0.0000000,0.0000000,90.0000000) --object(gen_doorint01)(3)
createObjectToLS(1491,-768.6739502,-1991.9611816,8894.5078125,0.0000000,0.0000000,270.0000000) --object(gen_doorint01)(4)
createObjectToLS(3055,-768.5958252,-1988.0273438,8896.7070312,0.0000000,0.0000000,270.0000000) --object(kmb_shutter)(4)
createObjectToLS(1557,-753.2019653,-1985.5435791,8888.3261719,0.0000000,0.0000000,0.0000000) --object(gen_doorext19)(1)
createObjectToLS(1557,-750.1754761,-1985.5438232,8888.3261719,0.0000000,0.0000000,180.0000000) --object(gen_doorext19)(2)
createObjectToLS(3920,-755.7993164,-1985.4085693,8893.4384766,0.0000000,0.0000000,180.0000000) --object(lib_veg3)(1)
createObjectToLS(3920,-746.6633301,-1985.4987793,8893.4384766,0.0000000,0.0000000,179.9945068) --object(lib_veg3)(2)
createObjectToLS(644,-740.7756348,-1986.0913086,8888.6660156,0.0000000,0.0000000,220.0000000) --object(pot_02)(1)
createObjectToLS(644,-761.4833984,-1986.3808594,8888.6660156,0.0000000,0.0000000,259.9914551) --object(pot_02)(2)
createObjectToLS(3095,-753.7265625,-2040.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(14)
createObjectToLS(3095,-744.7265625,-2040.3964844,8894.5068359,179.9945068,0.0000000,0.0000000) --object(a51_jetdoor)(23)
createObjectToLS(3598,-760.9271240,-2031.9567871,8901.3261719,0.0000000,0.0000000,269.9945068) --object(hillhouse01_la)(17)
createObjectToLS(3598,-741.9931641,-2032.2849121,8901.3261719,0.0000000,0.0000000,89.9890137) --object(hillhouse01_la)(17)
createObjectToLS(1649,-751.1698608,-2044.7740478,8895.9414062,0.0000000,0.0000000,180.0000000) --object(wglasssmash)(1)
createObjectToLS(1649,-746.8111572,-2044.8116455,8895.9414062,0.0000000,0.0000000,179.7445068) --object(wglasssmash)(2)
createObjectToLS(1649,-755.5263672,-2044.7839356,8895.9414062,0.0000000,0.0000000,179.9945068) --object(wglasssmash)(3)

createObjectToLS(13804,-720.4962769,-2043.4937744,8888.0322266,0.0000000,0.0000000,140.0000000) --object(cuntelandf4)(1)
createObjectToLS(13715,-762.1658325,-2096.1479492,8864.5927734,0.0000000,0.0000000,354.5000000) --object(cunte_hollyhil9)(1)
createObjectToLS(3763,-758.1076050,-2100.7814941,8925.3681641,0.0000000,0.0000000,0.0000000) --object(ce_radarmast3)(1)
createObjectToLS(621,-760.7374878,-2049.8398438,8892.0986328,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(1)
createObjectToLS(621,-745.9633789,-2048.1982422,8892.0986328,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(2)
createObjectToLS(621,-772.1503296,-2136.0197754,8883.3486328,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(3)
createObjectToLS(621,-758.0761719,-2139.6235352,8886.4892578,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(4)
createObjectToLS(621,-783.9131470,-2150.3918457,8886.4892578,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(5)
createObjectToLS(621,-747.9086304,-2156.3137207,8883.4892578,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(6)
createObjectToLS(621,-704.3019409,-2152.6267090,8874.9892578,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(7)
createObjectToLS(621,-700.3961182,-2140.2219238,8874.9892578,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(8)
createObjectToLS(621,-810.1705933,-2129.9013672,8882.8408203,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(9)
createObjectToLS(13805,-816.5408325,-2061.9594727,8894.4892578,0.0000000,0.0000000,24.0000000) --object(celalandbiv)(1)
createObjectToLS(3604,-785.0455933,-2056.9448242,8896.8925781,0.0000000,0.0000000,210.2500000) --object(bevmangar_law2)(1)
createObjectToLS(3603,-811.4349976,-2068.3818359,8899.7910156,0.0000000,0.0000000,24.0000000) --object(bevman_law2)(1)
createObjectToLS(669,-787.3614502,-2069.5390625,8894.1855469,0.0000000,0.0000000,70.0000000) --object(sm_veg_tree4)(1)
createObjectToLS(621,-720.5810547,-2142.6718750,8883.3486328,0.0000000,0.0000000,0.0000000) --object(veg_palm02)(10)
createObjectToLS(669,-700.4717407,-2085.7319336,8883.6855469,0.0000000,0.0000000,69.9993896) --object(sm_veg_tree4)(2)
createObjectToLS(672,-794.0955200,-2080.9250488,8894.6933594,0.0000000,0.0000000,0.0000000) --object(sm_veg_tree5)(1)
createObjectToLS(706,-840.2169190,-2133.3540039,8887.1113281,0.0000000,0.0000000,50.0000000) --object(sm_vegvbbig)(1)
createObjectToLS(13725,-700.0072632,-2161.5300293,8891.1210938,0.0000000,0.0000000,0.0000000) --object(opmans01_cunte)(1)
createObjectToLS(711,-723.7453613,-2090.4250488,8893.0312500,0.0000000,0.0000000,50.0000000) --object(vgs_palm02)(1)
createObjectToLS(669,-721.2442017,-2081.9951172,8883.6855469,0.0000000,0.0000000,69.9993896) --object(sm_veg_tree4)(3)
createObjectToLS(2206,-750.8184204,-2044.1579590,8894.5039062,0.0000000,0.0000000,180.0000000) --object(med_office8_desk_02)(1)
createObjectToLS(1714,-751.7956543,-2042.7044678,8894.5039062,0.0000000,0.0000000,0.0000000) --object(kb_swivelchair1)(1)
createObjectToLS(2190,-751.4270019,-2044.2966309,8895.4404297,0.0000000,0.0000000,180.0000000) --object(pc_1)(1)
createObjectToLS(2828,-752.4900513,-2043.9910889,8895.4404297,0.0000000,0.0000000,300.0000000) --object(gb_ornament02)(1)
createObjectToLS(2044,-751.0280151,-2044.6717529,8894.6582031,3.4169922,89.2415161,282.5225220) --object(cj_mp5k)(1)
createObjectToLS(2001,-755.1593018,-2033.8414307,8894.5039062,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(1)
createObjectToLS(2001,-755.7774658,-2044.3795166,8894.5039062,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(2)
createObjectToLS(3055,-746.7561035,-2033.2655029,8896.7021484,0.0000000,0.0000000,180.0000000) --object(kmb_shutter)(2)
createObjectToLS(1491,-750.6721802,-2033.2009277,8894.5039062,0.0000000,0.0000000,180.0000000) --object(gen_doorint01)(2)
createObjectToLS(3055,-756.0821533,-2033.2510986,8896.7021484,0.0000000,0.0000000,179.9945068) --object(kmb_shutter)(2)
createObjectToLS(1726,-755.4971314,-2042.7348633,8894.5039062,0.0000000,0.0000000,90.0000000) --object(mrk_seating2)(1)
createObjectToLS(1726,-747.3411255,-2041.1864014,8894.5039062,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(2)
createObjectToLS(2566,-753.8692017,-2038.2142334,8895.0830078,0.0000000,0.0000000,90.0000000) --object(hotel_s_bedset_3)(1)
createObjectToLS(1846,-747.5361328,-2036.9520264,8896.0380859,90.0000000,270.0000000,180.0000000) --object(shop_shelf04)(1)
createObjectToLS(2225,-746.6477661,-2037.0855713,8894.1474609,0.0000000,0.0000000,270.0000000) --object(swank_hi_fi_2)(1)
createObjectToLS(2344,-747.2426758,-2037.5249023,8894.5126953,0.0000000,0.0000000,30.0000000) --object(cj_remote)(1)
createObjectToLS(2230,-746.0980835,-2035.6383057,8895.5380859,0.0000000,0.0000000,270.0000000) --object(swank_speaker_2)(1)
createObjectToLS(2230,-746.1148682,-2038.8878174,8895.5380859,0.0000000,0.0000000,270.0000000) --object(swank_speaker_2)(2)
createObjectToLS(2233,-746.4899902,-2035.0783691,8894.5048828,0.0000000,0.0000000,310.0000000) --object(swank_speaker_4)(1)
createObjectToLS(2233,-746.8496704,-2039.4141846,8894.5048828,0.0000000,0.0000000,237.9957275) --object(swank_speaker_4)(2)
createObjectToLS(2001,-747.1884766,-2044.4462891,8894.5039062,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(3)
createObjectToLS(2001,-747.0936890,-2034.4678955,8894.5039062,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(4)
createObjectToLS(2261,-755.8337402,-2036.6112060,8895.9208984,0.0000000,0.0000000,90.0000000) --object(frame_slim_2)(1)
createObjectToLS(2260,-747.2424316,-2042.1923828,8895.9414062,0.0000000,0.0000000,270.0000000) --object(frame_slim_1)(1)
createObjectToLS(2265,-755.6364136,-2041.7327881,8895.9990234,0.0000000,0.0000000,90.0000000) --object(frame_slim_6)(1)
createObjectToLS(2239,-749.9140015,-2044.1273193,8894.5039062,0.0000000,0.0000000,210.0000000) --object(cj_mlight16)(1)
createObjectToLS(2239,-753.6118164,-2044.1909180,8894.5039062,0.0000000,0.0000000,139.9981690) --object(cj_mlight16)(2)
createObjectToLS(1726,-755.6102295,-2032.4312744,8894.5039062,0.0000000,0.0000000,90.0000000) --object(mrk_seating2)(3)
createObjectToLS(1726,-747.5809326,-2030.3673096,8894.5039062,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(4)
createObjectToLS(2001,-749.0991211,-2028.7799072,8894.5029297,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(5)
createObjectToLS(2001,-753.3778686,-2028.5958252,8894.5029297,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(6)
createObjectToLS(2001,-755.7451172,-2019.7485352,8894.5029297,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(7)
createObjectToLS(2001,-747.2719116,-2019.5714111,8894.5029297,0.0000000,0.0000000,0.0000000) --object(nu_plant_ofc)(8)
createObjectToLS(2244,-755.9530029,-2038.1036377,8895.4111328,0.0000000,0.0000000,0.0000000) --object(plant_pot_9)(1)
createObjectToLS(2010,-735.1845703,-2019.4101562,8894.5087891,0.0000000,0.0000000,130.0000000) --object(nu_plant3_ofc)(1)
createObjectToLS(2010,-765.9449463,-2019.7418213,8894.5087891,0.0000000,0.0000000,129.9957275) --object(nu_plant3_ofc)(2)
createObjectToLS(955,-767.5952759,-2020.0775147,8894.8837891,0.0000000,0.0000000,180.0000000) --object(cj_ext_sprunk)(1)
createObjectToLS(2010,-768.6784058,-2019.5375977,8894.5087891,0.0000000,0.0000000,129.9957275) --object(nu_plant3_ofc)(3)
createObjectToLS(955,-736.2309570,-2019.4315185,8895.0322266,0.0000000,0.0000000,179.9945068) --object(cj_ext_sprunk)(2)
createObjectToLS(1726,-740.6710815,-2012.8135986,8894.5029297,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(5)
createObjectToLS(2236,-745.6310425,-1988.1236572,8888.3408203,0.0000000,0.0000000,270.0000000) --object(coffee_swank_1)(1)
createObjectToLS(1726,-744.5026856,-2014.8657227,8894.5029297,0.0000000,0.0000000,90.0000000) --object(mrk_seating2)(6)
createObjectToLS(1726,-760.7874145,-2015.0098877,8894.5029297,0.0000000,0.0000000,90.0000000) --object(mrk_seating2)(7)
createObjectToLS(1726,-757.1365356,-2012.9582519,8894.5029297,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(8)
createObjectToLS(2236,-759.4707642,-2013.4852295,8894.5039062,0.0000000,0.0000000,270.0000000) --object(coffee_swank_1)(2)
createObjectToLS(2010,-748.3930054,-2009.3310547,8894.5087891,0.0000000,0.0000000,129.9957275) --object(nu_plant3_ofc)(4)
createObjectToLS(2010,-753.6943359,-2009.3510742,8894.5087891,0.0000000,0.0000000,129.9957275) --object(nu_plant3_ofc)(5)
createObjectToLS(2745,-748.5259399,-2012.7312012,8891.6503906,0.0000000,0.0000000,270.0000000) --object(cj_stat_3)(1)
createObjectToLS(2745,-758.5277710,-2009.8845215,8895.7167969,0.0000000,0.0000000,180.0000000) --object(cj_stat_3)(2)
createObjectToLS(2745,-742.9673462,-2009.6944580,8895.7167969,0.0000000,0.0000000,179.9945068) --object(cj_stat_3)(3)
createObjectToLS(644,-761.5621338,-2008.1782227,8888.6005859,0.0000000,0.0000000,39.9914551) --object(pot_02)(2)
createObjectToLS(644,-741.1423950,-2008.1298828,8888.6005859,0.0000000,0.0000000,149.9902344) --object(pot_02)(2)
createObjectToLS(14399,-743.3151856,-1997.3392334,8888.0146484,0.0000000,0.0000000,90.0000000) --object(bar2)(1)
createObjectToLS(18077,-748.3822022,-2003.4295654,8888.8994141,0.0000000,0.0000000,0.0000000) --object(din_donut_furn)(1)
createObjectToLS(1551,-745.1470947,-2000.7170410,8889.6298828,0.0000000,0.0000000,0.0000000) --object(dyn_wine_big)(1)
createObjectToLS(1544,-745.4461670,-2003.3704834,8889.3896484,0.0000000,0.0000000,0.0000000) --object(cj_beer_b_1)(1)
createObjectToLS(1543,-745.2690430,-2000.3741455,8889.3896484,0.0000000,0.0000000,0.0000000) --object(cj_beer_b_2)(1)
createObjectToLS(1544,-744.5620117,-1997.5147705,8889.3896484,0.0000000,0.0000000,0.0000000) --object(cj_beer_b_1)(2)
createObjectToLS(1541,-744.6284790,-2002.1573486,8889.5634766,0.0000000,0.0000000,270.0000000) --object(cj_beer_taps_1)(1)
createObjectToLS(2206,-733.5029297,-1990.6478272,8894.5039062,0.0000000,0.0000000,89.9945068) --object(med_office8_desk_02)(2)
createObjectToLS(1714,-724.6430054,-2005.7384033,8894.5039062,0.0000000,0.0000000,80.0000000) --object(kb_swivelchair1)(2)
createObjectToLS(2190,-733.6047974,-1989.9675293,8895.4404297,0.0000000,0.0000000,90.0000000) --object(pc_1)(2)
createObjectToLS(1808,-753.8328857,-2024.6251221,8894.5039062,0.0000000,0.0000000,90.0000000) --object(cj_watercooler2)(1)
createObjectToLS(1808,-734.8400879,-1996.7645264,8894.5039062,0.0000000,0.0000000,270.0000000) --object(cj_watercooler2)(2)
createObjectToLS(2010,-722.9951782,-2008.0334473,8894.4921875,0.0000000,0.0000000,260.0000000) --object(nu_plant3_ofc)(7)
createObjectToLS(2010,-723.0056763,-2003.3231201,8894.4921875,0.0000000,0.0000000,259.9969482) --object(nu_plant3_ofc)(8)
createObjectToLS(2298,-727.1975098,-2004.5969238,8894.5039062,0.0000000,0.0000000,180.0000000) --object(swank_bed_7)(1)
createObjectToLS(1567,-733.4464722,-2008.4637451,8894.5039062,0.0000000,0.0000000,0.0000000) --object(gen_wardrobe)(1)
createObjectToLS(2296,-729.6562500,-2002.8756103,8894.5039062,0.0000000,0.0000000,0.0000000) --object(tv_unit_1)(1)
createObjectToLS(2010,-733.6281738,-2007.9211426,8894.4921875,0.0000000,0.0000000,259.9969482) --object(nu_plant3_ofc)(9)
createObjectToLS(2256,-732.2767944,-2002.8319092,8895.9394531,0.0000000,0.0000000,0.0000000) --object(frame_clip_3)(1)
createObjectToLS(2344,-727.2255859,-2008.3048096,8895.0351562,0.0000000,0.0000000,300.0000000) --object(cj_remote)(2)
createObjectToLS(2206,-722.9931641,-2004.7890625,8894.5039062,0.0000000,0.0000000,269.9890137) --object(med_office8_desk_02)(3)
createObjectToLS(2299,-725.8093872,-1990.2773438,8894.5029297,0.0000000,0.0000000,270.0000000) --object(swank_bed_6)(1)
createObjectToLS(1726,-727.1801758,-1993.0291748,8894.5039062,0.0000000,0.0000000,180.0000000) --object(mrk_seating2)(9)
createObjectToLS(2296,-729.3255005,-1988.0612793,8894.5039062,0.0000000,0.0000000,0.0000000) --object(tv_unit_1)(2)
createObjectToLS(1714,-732.1851196,-1989.2199707,8894.5039062,0.0000000,0.0000000,309.9969482) --object(kb_swivelchair1)(3)
createObjectToLS(2190,-722.7988281,-2005.3417969,8895.4404297,0.0000000,0.0000000,270.0000000) --object(pc_1)(3)
createObjectToLS(2870,-733.4553833,-1988.9890137,8895.4404297,0.0000000,0.0000000,26.0000000) --object(gb_ornament05)(1)
createObjectToLS(2010,-769.3270874,-1988.5070801,8894.4970703,0.0000000,0.0000000,279.9969482) --object(nu_plant3_ofc)(10)
createObjectToLS(2010,-722.8458252,-1988.2663574,8894.4921875,0.0000000,0.0000000,259.9969482) --object(nu_plant3_ofc)(11)
createObjectToLS(2266,-722.8542481,-1990.8050537,8896.1582031,0.0000000,0.0000000,270.0000000) --object(frame_wood_5)(1)
createObjectToLS(2852,-726.4158935,-1992.4453125,8894.5029297,0.0000000,0.0000000,0.0000000) --object(gb_bedmags02)(1)
createObjectToLS(1742,-725.8331299,-1987.7427978,8894.4990234,0.0000000,0.0000000,0.0000000) --object(med_bookshelf)(1)
createObjectToLS(2330,-726.6058350,-2003.8303223,8894.4785156,0.0000000,0.0000000,0.0000000) --object(cj_bedroom1_w)(1)
createObjectToLS(2843,-731.1372070,-2005.1021728,8894.5039062,0.0000000,0.0000000,0.0000000) --object(gb_bedclothes02)(1)
createObjectToLS(2745,-765.6406860,-1985.6302490,8895.7167969,0.0000000,0.0000000,359.9945068) --object(cj_stat_3)(4)
createObjectToLS(2745,-737.4404297,-1986.2177734,8895.7128906,0.0000000,0.0000000,359.9890137) --object(cj_stat_3)(5)
createObjectToLS(2299,-770.8739014,-2004.8948975,8894.5087891,0.0000000,0.0000000,180.0000000) --object(swank_bed_6)(2)
createObjectToLS(2185,-776.9708252,-2008.0177002,8894.5087891,0.0000000,0.0000000,0.0000000) --object(med_office6_desk_1)(1)
createObjectToLS(1714,-776.0527954,-2006.7932129,8894.5087891,0.0000000,0.0000000,0.0000000) --object(kb_swivelchair1)(4)
createObjectToLS(14455,-779.2686768,-2003.4284668,8895.4697266,0.0000000,0.0000000,270.0000000) --object(gs_bookcase)(1)
createObjectToLS(2297,-772.1494751,-2002.9713135,8894.5078125,0.0000000,0.0000000,316.0000000) --object(tv_unit_2)(1)
createObjectToLS(14455,-779.2435303,-2003.4276123,8895.9521484,0.0000000,0.0000000,270.0000000) --object(gs_bookcase)(2)
createObjectToLS(14455,-761.4700317,-2008.9764404,8889.9267578,0.0000000,0.0000000,0.0000000) --object(gs_bookcase)(3)
createObjectToLS(14455,-758.5937500,-2008.9615478,8889.9267578,0.0000000,0.0000000,0.0000000) --object(gs_bookcase)(4)
createObjectToLS(14455,-762.2128906,-2003.8519287,8889.9267578,0.0000000,0.0000000,270.0000000) --object(gs_bookcase)(5)
createObjectToLS(14455,-762.1881103,-1998.0765381,8889.9267578,0.0000000,0.0000000,270.0000000) --object(gs_bookcase)(6)
createObjectToLS(1726,-755.5831909,-2004.9715576,8888.3154297,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(10)
createObjectToLS(1726,-755.5949097,-2002.0421143,8888.3154297,0.0000000,0.0000000,270.0000000) --object(mrk_seating2)(11)
createObjectToLS(1726,-758.6489868,-2000.9688721,8888.3154297,0.0000000,0.0000000,0.0000000) --object(mrk_seating2)(12)
createObjectToLS(1726,-759.8614502,-2004.0385742,8888.3154297,0.0000000,0.0000000,90.0000000) --object(mrk_seating2)(13)
createObjectToLS(1726,-759.8199463,-2007.1882324,8888.3154297,0.0000000,0.0000000,90.0000000) --object(mrk_seating2)(14)
createObjectToLS(2824,-756.9317017,-2006.5131836,8888.3115234,0.0000000,0.0000000,0.0000000) --object(gb_novels02)(1)
createObjectToLS(2852,-758.5955200,-2002.9190674,8888.3085938,0.0000000,0.0000000,0.0000000) --object(gb_bedmags02)(2)
createObjectToLS(3984,-761.6347046,-1969.4300537,8898.0019531,0.0000000,0.0000000,90.0000000) --object(churchprog1_lan)(1)
createObjectToLS(869,-757.2135620,-1990.7211914,8889.0781250,0.0000000,0.0000000,0.0000000) --object(veg_pflowerswee)(1)
createObjectToLS(870,-757.1050415,-1991.8491211,8888.8652344,0.0000000,0.0000000,0.0000000) --object(veg_pflowers2wee)(1)
createObjectToLS(870,-757.3587647,-1989.9674072,8888.8652344,0.0000000,0.0000000,0.0000000) --object(veg_pflowers2wee)(2)
createObjectToLS(1726,-756.4075928,-1994.4674072,8888.3154297,0.0000000,0.0000000,32.0000000) --object(mrk_seating2)(15)
createObjectToLS(1726,-753.6941528,-1991.9058838,8888.3154297,0.0000000,0.0000000,91.9976807) --object(mrk_seating2)(16)
createObjectToLS(1726,-759.7880859,-1993.5968018,8888.3154297,0.0000000,0.0000000,331.9940186) --object(mrk_seating2)(17)
createObjectToLS(1726,-746.5090332,-1989.5941162,8888.3154297,0.0000000,0.0000000,90.7440186) --object(mrk_seating2)(18)
createObjectToLS(1726,-743.8320923,-1987.6339111,8888.3154297,0.0000000,0.0000000,270.7415772) --object(mrk_seating2)(19)
createObjectToLS(1726,-743.7810669,-1991.8099365,8888.3154297,0.0000000,0.0000000,270.7360840) --object(mrk_seating2)(20)
createObjectToLS(1726,-746.4581299,-1993.7436523,8888.3154297,0.0000000,0.0000000,90.7415771) --object(mrk_seating2)(21)
createObjectToLS(2236,-743.1162109,-2013.3632812,8894.5039062,0.0000000,0.0000000,270.0000000) --object(coffee_swank_1)(3)
createObjectToLS(2236,-745.6237793,-1992.2509766,8888.3408203,0.0000000,0.0000000,270.0000000) --object(coffee_swank_1)(4)
createObjectToLS(1487,-745.1616821,-1992.9627685,8889.0439453,0.0000000,0.0000000,0.0000000) --object(dyn_wine_1)(1)
createObjectToLS(1544,-744.9634399,-1992.7904053,8888.8466797,0.0000000,0.0000000,0.0000000) --object(cj_beer_b_1)(3)
createObjectToLS(1543,-745.0821533,-1988.3530273,8888.8466797,0.0000000,0.0000000,0.0000000) --object(cj_beer_b_2)(2)
createObjectToLS(2566,-777.3585205,-1992.3743897,8895.0878906,0.0000000,0.0000000,90.0000000) --object(hotel_s_bedset_3)(2)
createObjectToLS(2207,-774.5086670,-1992.7257080,8894.5078125,0.0000000,0.0000000,180.0000000) --object(med_office7_desk_1)(1)
createObjectToLS(2190,-775.2174683,-1992.9007568,8895.2851562,0.0000000,0.0000000,166.0000000) --object(pc_1)(4)
createObjectToLS(1714,-775.1247559,-1991.4575195,8894.5078125,0.0000000,0.0000000,0.0000000) --object(kb_swivelchair1)(5)
createObjectToLS(2828,-775.9476929,-1992.9279785,8895.2851562,0.0000000,0.0000000,336.0000000) --object(gb_ornament02)(2)
createObjectToLS(2260,-775.4509888,-1993.1563721,8895.9072266,0.0000000,0.0000000,180.0000000) --object(frame_slim_1)(2)
createObjectToLS(2010,-722.8984375,-1992.9921875,8894.4921875,0.0000000,0.0000000,259.9969482) --object(nu_plant3_ofc)(12)
createObjectToLS(2010,-779.3457642,-1988.5552978,8894.4970703,0.0000000,0.0000000,279.9920654) --object(nu_plant3_ofc)(13)
createObjectToLS(2010,-779.2921143,-1993.0549316,8894.4970703,0.0000000,0.0000000,279.9920654) --object(nu_plant3_ofc)(14)
createObjectToLS(2568,-750.5009766,-2033.7595215,8894.5029297,0.0000000,0.0000000,0.0000000) --object(hotel_dresser_3)(1)
createObjectToLS(2568,-772.9042969,-1988.5908203,8894.5087891,0.0000000,0.0000000,0.0000000) --object(hotel_dresser_3)(2)
