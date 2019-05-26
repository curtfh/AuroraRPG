local spawnPositions = {
{1284.7861328125,-781.845703125,1084.0078125,89.691009521484},
{1263.892578125,-769.5361328125,1084.0078125,85.933624267578},
{1249.8505859375,-788.9677734375,1084.0078125,183.69694519043},
{1265.8759765625,-795.158203125,1084.0078125,355.23461914062},
{1283.2607421875,-788.9775390625,1084.0148925781,168.96954345703},
{1273.0322265625,-789.0029296875,1084.0078125,89.696502685547},
{1262.1904296875,-800.19140625,1084.0078125,195.60081481934},
{1266.78515625,-808.091796875,1084.0078125,95.310607910156},
{1226.240234375,-836.8720703125,1084.0078125,177.40716552734},
{1256.90625,-835.888671875,1084.0078125,274.25863647461},
{1233.7158203125,-812.8369140625,1084.0078125,163.619140625},
{1277.2265625,-835.05859375,1085.6328125,289.7331237793},
{1278.5888671875,-812.3212890625,1085.6328125,167.52484130859},
{1282.2919921875,-811.326171875,1089.9375,1.6012878417969},
{1274.4521484375,-773.7744140625,1091.90625,192.39825439453},
{1254.142578125,-794.263671875,1084.234375,267.04052734375},
{1279.208984375,-786.734375,1084.0148925781,142.33279418945},
}

local pedSkins = {
    117,118
	}

local enterMarkers = {}
local exitMarkers = {}
local lawSignUp = createMarker(1256.32, -776.17, 92.03-1,"cylinder",4,0,0,255,100)
local crimSignUp = createMarker( 1305.36, -798.32, 84.14-1,"cylinder",4,255,0,0,100)
local lawSignUpCol = createColCircle(1256.32, -776.17,3)
local crimSignUpCol = createColCircle( 1305.36, -798.32,3)
local timeLeft=0
local started=false
local weps = {
    6,7,8,9,25,31,30,33,34,31,30,33,34,31,30,33,34,31,30,33,34,31,30,33,34,31,30,33,34
 }
local eint,edim = 5,1
local peds = {}
local spawnedPlaces = {}
local timeTillEnd = 0
local crimse = {}
local lawse = {}
local entered = {}
local remainingpeds = 1
local team = "crim"
local startseq=false
local startcd = 60
local allowedToJoin={}
local antiBug = {}
setTimer(function()
	for k,v in pairs(allowedToJoin) do
		if (v) and getTickCount() - v > 7200000 then
			allowedToJoin[k]=nil
 		end
	end
end,10000,0)

function msg(a,b,c,d,e)
	exports.NGCdxmsg:createNewDxMessage(a,b,c,d,e)
end

addCommandHandler("setmd",function(player,cmd,value,nm)
	--if getElementData(player,"isPlayerPrime") == true then
		if value == "switch" then
			if nm and tonumber(nm) then
				if isTimer(copsTurn) then killTimer(copsTurn) end
				copsTurn = setTimer(function(player) if team=="law" then team="crim" else team="law" end check1() outputChatBox("MR team =!! "..team,player,255,255,0) end,nm,1,player)
			end
		elseif value == "info" then
			outputChatBox("MR team =? "..team,player,255,255,0)
		end
	--end
end)

local enterPos = {
        --{x,y,z,warptox,warptoy,warptoz,rotation of player after warp}
        {1258.43, -783.07, 92.03 ,1263.13, -785.43, 1091.9,267},
        { 1258.51, -787.86, 92.03,1263.13, -785.43, 1091.9,267},
        {1300.59, -798.41, 84.18,1298.79, -794.23, 1084,350}
    }

local exitPos = {
        {1260.64, -785.37, 1091.9,1254.78, -785.47, 92.03,84},
        {1298.91, -796.9, 1084, 1299.55, -800.94, 84.14,192},

    }

addEventHandler("onMarkerHit",lawSignUp,function(p,dim)
	if dim == false then return end
	if exports.DENlaw:isLaw(p) then
		if started == true then
			if team == "law" then
				exports.NGCdxmsg:createNewDxMessage(p,"The Law Mansion Raid is occuring at the moment",255,255,0)
			else
				exports.NGCdxmsg:createNewDxMessage(p,"The Criminal Mansion Raid is occuring at the moment",255,255,0)
			end
		else
			local acc = exports.server:getPlayerAccountName(p)
			if (allowedToJoin[acc]) then

				exports.NGCdxmsg:createNewDxMessage(p,"You did this event recently. You can only join this event once per 2 hours",0,0,255)
				return
			end
			exports.NGCdxmsg:createNewDxMessage(p,"This is Law Mansion Raid Law Marker (/raidtime)",0,0,255)
			if team == "law" then
				exports.NGCdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Law Enforcement",0,0,255)
				if timeLeft > 0 then
					exports.NGCdxmsg:createNewDxMessage(p,"Come back here in "..timeLeft.." seconds",0,0,255)
				else
					--exports.NGCdxmsg:createNewDxMessage(p,"The event can be started, get 4 Law players in the marker",0,0,255)
					exports.NGCdxmsg:createNewDxMessage(p,"Required to Start: "..(getLawMarkerCount()+1).."/4 Law.",0,255,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Criminals",0,0,255)
				exports.NGCdxmsg:createNewDxMessage(p,"This marker only works when the mansion raid is for Law",0,0,255)
			end
			--if getLawCount() < 5 then

			--end
			startCheck()
		end
	end
end)

setTimer(function()
	if timeLeft > 0 then timeLeft=timeLeft-1 end
	if timeTillEnd > 0 then
		timeTillEnd=timeTillEnd-1
		if (team == "law") then
			for k,v in ipairs (lawse) do
				triggerClientEvent(v, "NGCraid:updateTimer", v, timeTillEnd)
			end
		elseif (team == "crim") then
			for k,v in ipairs (crimse) do
				triggerClientEvent(v, "NGCraid:updateTimer", v, timeTillEnd)
			end
		end
		if timeTillEnd==0 then
			endIt()
		end
	end
	if startcd > 0 then
		startcd=startcd-1
	end
end,1000,0)

picked={}
function endIt(winner)
	if started==false then return end
	for k,v in pairs(peds) do
		if isElement(v) then
			destroyElement(v)
		end
	end
	peds={}
	if (team == "crim") then
		for k,v in ipairs (crimse) do
			local x,y,z = getElementPosition(crimSignUp)
			setElementDimension(v, 0)
			setElementInterior(v,0)
			setElementPosition(v, x,y,z)
			local reward = math.random(20000,30000)
			givePlayerMoney(v, reward)
			exports.NGCdxmsg:createNewDxMessage(v,"You have successfully raided the mansion and got $"..reward.."", 255,255,0)
			exports.CSGgroups:addXP(p,8)
			exports.AURcriminalp:giveCriminalPoints(p, "", 3)
			table.remove(crimse, k)
			setElementData(v, "isPlayerInMR", false)
			triggerClientEvent(v, "onTogglemansionraidStats", v, false)
			triggerClientEvent(v, "AURmansion:addWave", v, "reset")
		end
	elseif (team == "law") then
		for k,v in ipairs (lawse) do
			local x,y,z = getElementPosition(lawSignUp)
			setElementDimension(v, 0)
			setElementInterior(v,0)
			setElementPosition(v, x,y,z)
			local reward = math.random(20000,30000)
			givePlayerMoney(v, reward)
			exports.NGCdxmsg:createNewDxMessage(v,"You have successfully raided the mansion and got $"..reward.."", 255,255,0)
			exports.CSGgroups:addXP(p,8)
			table.remove(lawse, k)
			setElementData(v, "isPlayerInMR", false)
			triggerClientEvent(v, "onTogglemansionraidStats", v, false)
			triggerClientEvent(v, "AURmansion:addWave", v, "reset")
		end
	end
	--[[if (winner) then
		if winner=="crims" then
			for k,v in pairs(crimse) do
				msg(v,"MD Mansion has been successfully raided. Go to the safe for money!",0,255,0)
				msg(v,"You have 1 minute to steal the money!",0,255,0)
			end
			for k,v in pairs(getElementsByType("player")) do
				msg(v,"The Criminal Forces have successfully raided MD Mansion!",0,255,0)
			end
		elseif winner=="laws" then
			for k,v in pairs(lawse) do
				msg(v,"MD Mansion has been cleared of hostile forces. Go to the safe and collect the illegal money!",0,255,0)
				msg(v,"You have 1 minute to collect the money!",0,255,0)
			end
			for k,v in pairs(getElementsByType("player")) do
				msg(v,"The Law Forces have successfully raided MD Mansion!",0,255,0)
			end
		else
			if team == "law" then
				for k,v in pairs(lawse) do
					msg(v,"Mansion Raid has failed!",255,0,0)
					msg(v,"The Mafia Men have taken over, too much time has past!",255,0,0)
					--killPed(v)
					triggerClientEvent(v,"onResetmansionraidStats",v)
				end
			else
				for k,v in pairs(crimse) do
					msg(v,"Mansion Raid has failed!",255,0,0)
					msg(v,"The Security Guards have taken over, too much time has past!",255,0,0)
					triggerClientEvent(v,"onResetmansionraidStats",v)
					--killPed(v)
				end
			end
		end
		local t = {}
		local x2,y2,z2 = 1230.76, -807.18, 1084
		local obj = createObject(1550,x2,y2,z2)
		table.insert(t,obj)
		local m = createMarker(x2,y2,z2-1,"cylinder",2)
		setElementInterior(m,eint)
		setElementDimension(m,edim)
		setElementInterior(obj,eint)
		setElementDimension(obj,edim)
		addEventHandler("onMarkerHit",m,hitbag)
		setTimer(function() destroyElement(obj) end,60000,1)
		setTimer(function() destroyElement(m) picked={} end,60000,1)
		setTimer(function() antiBug = {} end,90000,1)

		for k,v in pairs(crimse) do
			triggerClientEvent(v,"CSGmansionRecBags",v,t,60000)
		end

		for k,v in pairs(lawse) do
			triggerClientEvent(v,"CSGmansionRecBags",v,t,60000)
		end
		offwinner=winner
	end]]--
	timeTillEnd=0
	timeLeft=3600
	check1()
	if team == "law" then team = "crim" else team = "law" end
	started=false
	picked={}
	entered={}
	startedseq=false

end

function hitbag(p,dim )
	if dim == false then return end
	if offwinner == "crims" then
		if getTeamName(getPlayerTeam(p)) == "Criminals" or getTeamName(getPlayerTeam(p)) == "HolyCrap" then
			if picked[p] ~= nil then return end
			local m = math.random(10000,15000)
			givePlayerMoney(p,m)
			exports.CSGgroups:addXP(p,8)
			exports.AURcriminalp:giveCriminalPoints(p, "", 3)
			msg(p,"Picked up $"..m.."!",0,255,0)
			picked[p]=true
		end
	elseif offwinner=="laws" then
		if exports.DENlaw:isLaw(p) then
			if picked[p] ~= nil then return end
			local m = math.random(10000,15000)
			givePlayerMoney(p,m)
			exports.CSGgroups:addXP(p,6)
			msg(p,"Picked up $"..m.."!",0,255,0)
			picked[p]=true
		end
	end
	triggerClientEvent(p,"CSGmd.getKC",p)
end

addEvent("CSGmd.recKC",true)
addEventHandler("CSGmd.recKC",root,function(kills)
	if kills > 0 then
		if canLawOfficerEnter(source) then
			givePlayerMoney(source,kills*500)
			msg(p,"Picked up $"..(kills*500).." for "..kills.." kills",0,255,0)
			table.insert( antiBug, exports.server:getPlayerAccountName(source) )
		else
			exports.NGCdxmsg:createNewDxMessage(source, "You can only pickup the money once per the event!", 225, 0, 0 )
		end
	end
end)

function canLawOfficerEnter (plr)
	local state = true
	for k, theAccount in ipairs (antiBug) do
		if ( theAccount == exports.server:getPlayerAccountName( plr ) ) then
			state = false
		end
	end
	return state
end

addEventHandler("onMarkerHit",crimSignUp,function(p,dim)
	if dim == false then return end
	if p and isElement(p) and getElementType(p) == "player" then
		if getPlayerTeam(p) == getTeamFromName("Criminals") or getPlayerTeam(p) == getTeamFromName("HolyCrap") then
			if started == true then
				if team == "crim" then
					exports.NGCdxmsg:createNewDxMessage(p,"The Criminal Mansion Raid is occuring at the moment",255,255,0)
				else
					exports.NGCdxmsg:createNewDxMessage(p,"The Law Enforcement Mansion Raid is occuring at the moment",255,255,0)
				end
			else
				if (allowedToJoin[acc]) then

					exports.NGCdxmsg:createNewDxMessage(p,"You did this event recently. You can only join this event once per 2 hours",255,255,0)
					return
				end
				exports.NGCdxmsg:createNewDxMessage(p,"This is Criminal Mansion Raid Law Marker (/raidtime)",255,255,0)
				if team == "crim" then
					exports.NGCdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Criminals",255,255,0)
					if timeLeft > 0 then
						exports.NGCdxmsg:createNewDxMessage(p,"Come back here in "..timeLeft.." seconds",255,255,0)
					else
						exports.NGCdxmsg:createNewDxMessage(p,"Required to Start: "..(getCrimMarkerCount()+1).."/4 Criminals.",0,255,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage(p,"The next Mansion Raid is going to be for Law Enforcement",255,255,0)
					exports.NGCdxmsg:createNewDxMessage(p,"This marker only works when the mansion raid is for Criminals",255,255,0)
				end
				startCheck()
			end
		end
	end
end)

function check1()
	if started == true then
		if isTimer(copsTurn) then killTimer(copsTurn) end
	end
	if not isTimer(copsTurn) and started == false then
		copsTurn = setTimer(function() if team=="law" then team="crim" else team="law" end check1() end,3000000,1)
	end
	delayer = setTimer(check1,10000,1)
end
delayer = setTimer(check1,10000,1)

addEventHandler("onPlayerWasted",root,function()
	if getElementData(source,"isPlayerInMR") then
		setElementData(source,"isPlayerInMR",false)
	end
end)


addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"isPlayerInMR") then
		setElementInterior(source,0)
		setElementDimension(source,0)
		setElementData(source,"isPlayerInMR",false)
		local userid = exports.server:getPlayerAccountID( source )
		setTimer(function(player,id)
			local x,y,z,r = 1178.7457275391, -1323.8264160156, 14.135261535645, 270
			exports.DENmysql:exec("UPDATE `accounts` SET `x`=?, `y`=?, `z`=?, `rotation`=?, `health`=? WHERE `id`=?", x, y, z, r, 100, id )
		end,4000,1,source,userid)
	end
end)







function startCheck()
	if timeLeft==0 then
		if started==false and startseq==false then

			if (team=="law" and getLawMarkerCount()+1 >= 4) or (team=="crim" and getCrimMarkerCount()+1 >= 4) then --edit here the rquirements
				if (team=="law" and #getElementsWithinColShape(lawSignUpCol,"player") < 1) then
					return false 
				end
				if (team=="crim" and #getElementsWithinColShape(crimSignUpCol, "player") < 1) then
					return false 
				end
				startseq=true
				started=false
				loadEnters()
				loadExits()
				spawnPeds(15)
				sendUpdatedStats ()
				spawningTimer = setTimer(spawnPeds, 1000*90,2,15)
				setTimer(function() if (team == "crim") then for k,v in ipairs (crimse) do triggerClientEvent(v, "AURmansion:addWave", v, "add") end elseif (team == "law") then for k,v in ipairs (lawse) do triggerClientEvent(v, "AURmansion:addWave", v, "add") end end end, 1000*90,2,15)
				setTimer(sendUpdatedStats, (1000*90)+100,1)
				startcd=60
				timeTillEnd = 900
				if team == "crim" then
				setTimer(function()
				local _,crims = getCrimMarkerCount()
				if isTimer(copsTurn) then killTimer(copsTurn) end
				local cx,cy,cz,crz = 1298.79, -794.23, 1084,350
				for k,v in pairs(crims) do
					setElementInterior(v,eint)
					setElementDimension(v,edim)
					setElementPosition(v,cx+math.random(-1,1),cy+math.random(-1,1),cz)
					setElementRotation(v,0,0,crz)
					triggerClientEvent(v,"onTogglemansionraidStats",v,true)
					table.insert(crimse,v)
					fadeCamera(v,false)
					entered[v]=true
					toggleAllControls(v,true,true,true)
					setElementFrozen(v,true)
					setElementHealth(v,200)
					setTimer(function(plr,int,dim)
						setElementFrozen(v,false)
						fadeCamera(plr,true)
						setElementInterior(plr,5)
						setElementDimension(plr,1)
						setElementPosition(plr,1298.79, -794.23, 1084)
					end,3500,1,v,eint,edim)
					setPedArmor(v,100)
					allowedToJoin[exports.server:getPlayerAccountName(v)] = getTickCount()
				end
				end,3000,1)
				end
				if team == "law" then
				setTimer(function()
				local _,laws = getLawMarkerCount()
				if isTimer(copsTurn) then killTimer(copsTurn) end
				local lx,ly,lz,lrz =  1271.68, -778.57, 1091.9 ,267
				for k,v in pairs(laws) do
					setElementInterior(v,eint)
					setElementDimension(v,edim)
					setElementPosition(v,lx+math.random(-1,1),ly+math.random(-1,1),lz)
					setElementRotation(v,0,0,lrz)
					triggerClientEvent(v,"onTogglemansionraidStats",v,true)
					toggleAllControls(v,true,true,true)
					table.insert(lawse,v)
					entered[v]=true
					setElementFrozen(v,true)

					setElementHealth(v,200)

					setPedArmor(v,100)
					setTimer(function(plr,int,dim)
						setElementFrozen(v,false)
						fadeCamera(plr,true)
						setElementInterior(plr,5)
						setElementDimension(plr,1)
						setElementPosition(plr,1271.68, -778.57, 1091.9)
					end,3500,1,v,eint,edim)
					allowedToJoin[exports.server:getPlayerAccountName(v)] = getTickCount()
				end
				end,3000,1)
				end
				for k,v in pairs(getElementsByType("player")) do
					if team == "law" then
						msg(v,"Mansion Raid (Law) start sequence initiated. Be in the marker within 60 seconds!",0,255,0)
					else
						msg(v,"Mansion Raid (Criminals) start sequence initiated. Be in the marker within 60 seconds!",0,255,0)
					end
				end
				setTimer(function()
				if isTimer(copsTurn) then killTimer(copsTurn) end
				started=true
				startseq=false
				local _,allLaws=getLawCount()
				local _,allCrims=getCrimCount()
				remainingpeds=0
				if team == "law" then
					for k,v in pairs(lawse) do
						msg(v,"MD Mansion Raid has started! Take down all criminals",0,255,0)
						remainingpeds= #peds
					end

				else
					for k,v in pairs(crimse) do
						msg(v,"MD Mansion Raid has started! Take down all security guards!",0,255,0)
						remainingpeds = #peds
					end

				end
				for k,v in pairs(getElementsByType("player")) do
					triggerClientEvent(v,"CSGmraid.started",v,timeTillEnd)
				end
				sendUpdatedStats()
				end,3000,1)
			end
		end
	end
end

addEventHandler("onPlayerWasted",root,function(_,killer)
	if killer and isElement(killer) then
		if getElementData(killer,"isPlayerInMR") then
			if exports.DENlaw:isLaw(source) then
				for k,v in pairs(lawse) do
					if v==source then
						table.remove(lawse,k)
						msg(v,"You died during the Mansion Raid! Better luck next time!",255,0,0)
						if (killer) then
							if isElement(killer) then
								if exports.DENlaw:isLaw(killer) then
									givePlayerMoney(killer,1500)
									exports.CSGgroups:addXP(killer,3)
									--outputDebugString("Got xp from #1")
									msg(killer,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
									exports.CSGscore:givePlayerScore(killer,0.5)
								else
									--outputDebugString("Got xp from #2")
									givePlayerMoney(killer,1500)
									msg(killer,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
									exports.CSGscore:givePlayerScore(killer,0.5)
								end
							end
						end
						if (#lawse == 0) then
							endIt()
						end
						sendUpdatedStats()
						break
					end
				end
			else
				for k,v in pairs(crimse) do
					if v==source then
						table.remove(crimse,k)
						sendUpdatedStats()
						msg(v,"You died during the Mansion Raid! Better luck next time!",255,0,0)
						if (killer) then
							if isElement(killer) then
								if exports.DENlaw:isLaw(killer) then
									givePlayerMoney(killer,1500)
									exports.CSGgroups:addXP(killer,3)
									--outputDebugString("Got xp from #3")
									msg(killer,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
									exports.AURcriminalp:giveCriminalPoints(killer, "", 3)
									exports.CSGscore:givePlayerScore(killer,0.5)
								else
									givePlayerMoney(killer,1500)
									--outputDebugString("Got xp from #4")
									msg(killer,"Killed a enemy! Paid $1500 and +0.5 Score!",0,255,0)
									exports.CSGscore:givePlayerScore(killer,0.5)
									exports.AURcriminalp:giveCriminalPoints(killer, "", 3)
								end
								if (#crimse == 0) then
									endIt ()
								end
							end
						end
						break
					end
				end
			end
		end
	end
end)

addEventHandler("onPlayerQuit",root,function(_,killer)
	for k,v in pairs(lawse) do
			if v==source then
				table.remove(lawse,k)
				sendUpdatedStats()
				break
			end
		end
	for k,v in pairs(crimse) do
			if v==source then
				table.remove(crimse,k)
				sendUpdatedStats()
				break
			end
		end
end)

function spawnPeds(amount)
        for count=1,amount do
                local i = math.random(1,#spawnPositions)
				while (spawnedPlaces[i]~=nil) do
					i = math.random(1,#spawnPositions)
				end
				spawnedPlaces[i]=true
				local x,y,z,rz = unpack(spawnPositions[i])
                local ped = exports.slothbot:spawnBot(x,y,z,rz,pedSkins[math.random(1,#pedSkins)],eint,edim,_,weps[math.random(1,#weps)])
                --exports.slothbot:setBotTeam(ped, getTeamFromName("Government"))
				table.insert(peds,ped)
            end
		spawnedPlaces={}
    end

function loadEnters()
    for k,v in pairs(enterPos) do
            local x,y,z = unpack(v)
            local m = createMarker(x,y,z+1,"arrow",2)
            enterMarkers[m] = k
            addEventHandler("onMarkerHit",m,hitEnter)
        end
    end

function loadExits()
    for k,v in pairs(exitPos) do
            local x,y,z = unpack(v)
            local m = createMarker(x,y,z+1,"arrow",2)
            exitMarkers[m]=k
            setElementDimension(m,edim)
            setElementInterior(m,eint)
            addEventHandler("onMarkerHit",m,hitLeave)
        end
    end

 function hitEnter(player,dim)
	if 1+1 == 2 then return end --no use at the moment
    if dim == false then return end
    if isPedInVehicle(player) then
        return
    else
		if started==false then
			msg(player,"MD Mansion Raid is not occuring rightnow. You can't enter.",255,0,0)
			return
		end
        if exports.DENlaw:isLaw(player) == true or (getTeamName(getPlayerTeam(player)) == "Criminals" or getTeamName(getPlayerTeam(player)) == "HolyCrap") then
			if entered[player] ~= nil then
				msg(player,"You died! You can't re-enter the mansion again during the same raid!",255,0,0)
				return
			end
			entered[player]=true
            local _,_,_,tx,ty,tz,rz = unpack(enterPos[enterMarkers[source]])
            setElementPosition(player,tx,ty,tz)
            setElementInterior(player,eint)
            setElementDimension(player,edim)
            setElementRotation(player,0,0,rz)
			toggleAllControls(player,true,true,true)
			triggerClientEvent(player,"onTogglemansionraidStats",player,true)
			if exports.DENlaw:isLaw(player) then
				table.insert(player,lawse)
			else
				table.insert(player,crimse)
			end
			sendUpdatedStats()
        end
    end
end

function sendUpdatedStats()
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"onChangeMansionCount",v,#lawse,#crimse, #peds)
	end
end

 function hitLeave(player,dim)

    if dim == false then return end
	if getElementType(player) ~= "player" then return end
    if isPedInVehicle(player) then
        return
    else
		if timeTillEnd == 0 then
       -- if exports.DENlaw:isLaw(player) == true or getTeamName(getPlayerTeam(player)) == "Criminals" then
            local _,_,_,tx,ty,tz,rz = unpack(exitPos[exitMarkers[source]])

            setElementInterior(player,0)
    		setElementPosition(player,tx,ty,tz)
            setElementDimension(player,0)
            setElementRotation(player,0,0,rz)
			triggerClientEvent(player,"onTogglemansionraidStats",player,false)
       -- end
		else
			msg(player,"You can't leave while the Mansion Raid is in progress! Fight!",255,0,0)
		end
    end
end

function botKillReward (_,attacker, weapon, bodypart)
	if getElementDimension(source) == 1 and getElementInterior(source) == 5 then
		for k,v in ipairs (peds) do
			if (v == source) then
				table.remove(peds, k)
			end
		end
		if (getElementType (attacker) == "ped") and not (getElementType(attacker) == "player") then
			spawnPeds(1)
		end
	end
	if ( isElement( attacker ) ) and getElementType(attacker) == "player" and ( getPlayerTeam( attacker ) ) then
		if getElementDimension(attacker) == 1 and getElementInterior(attacker) == 5 then
			givePlayerMoney(attacker, 1500)
			exports.NGCdxmsg:createNewDxMessage("You killed a bot and earned $1,5000!", attacker,2552,255,255)
			for k,v in ipairs (peds) do
				if (v == source) then
					table.remove(peds, k)
					destroyElement(v)
				end
			end
			triggerClientEvent(root, "NGCraid:updateKill", attacker, attacker)
			sendUpdatedStats()
			if (#peds == 0) then
				if (isTimer(spawningTimer) == false) then
					endIt ()
				else
					exports.NGCdxmsg:createNewDxMessage(attacker, "More Bots are spawning shortly!",255,255,0)
				end
			end
			for k,v in ipairs (peds) do
				if (#peds > 0) and not (isElement(v)) then
					endIt()
				end
			end
		end
	end
end
addEventHandler("onPedWasted", root, botKillReward)



function getLawMarkerCount()
	local t = getElementsWithinColShape(lawSignUpCol,"player")
	if t==false then t = {} end
	for k,v in pairs(t) do
		if exports.DENlaw:isLaw(v) == false or (allowedToJoin[exports.server:getPlayerAccountName(v)]) then table.remove(t,k) end
	end
	return #t,t
end

function getCrimMarkerCount()
	local t = getElementsWithinColShape(crimSignUpCol,"player")
	if t==false then t = {} end
	for k,v in pairs(t) do
		if (getTeamName(getPlayerTeam(v)) ~= "Criminals" and getTeamName(getPlayerTeam(v)) ~= "HolyCrap") or (allowedToJoin[exports.server:getPlayerAccountName(v)]) then table.remove(t,k) end
	end
	return #t,t
end

function getLawCount()
	local t = getLawTable()
	if t==false or t==nil then t = {} end
	return #t,t
end

function getCrimCount()
	local t = getElementsByType("player")
	if t==false then t = {} end
	for k,v in pairs(t) do
		if (getPlayerTeam(v)) then
			if getTeamName(getPlayerTeam(v)) ~= "Criminals" and getTeamName(getPlayerTeam(v)) ~= "HolyCrap" then table.remove(t,k) end
		end
	end
	return #t,t
end

local lawTeams = {	
	"Military Forces",
	"Government",
}

function getLawTable()
	local law = {}
	for k,v in pairs (lawTeams) do
		local list = getPlayersInTeam(getTeamFromName(v))
		for k,v in pairs(list) do
			table.insert(law,v)
		end
	end
	return law
end
addCommandHandler("mypos",function(ps)
        local x,y,z = getElementPosition(ps)
        local rx,ry,rz = getElementRotation(ps)
        outputChatBox('{'..x..','..y..','..z..','..rz..'},',ps)
    end)


function MDTimeLeft(plr)
	if (not isTimer(copsTurn)) then return end
	local chkTimer = copsTurn
	local milliseconds = math.floor(getTimerDetails(copsTurn))
	local minutes = milliseconds / 60000
	local seconds = minutes * 60
	if team=="crim" then
		tm = "Law"
	else
		tm = "Criminals"
	end
	local txt = "MD Mansion Raid will be switched to "..tm
	exports.NGCdxmsg:createNewDxMessage(plr,txt.." within ("..math.ceil(minutes).." minutes) ("..math.ceil(seconds).." seconds)",255, 255, 0)
end

addCommandHandler("raidtime",MDTimeLeft)

addCommandHandler("raidtime",function(ps)

		if started==true or startseq==true then
			if startseq and started then
				if team == "law" then
					msg(ps,"MD Mansion Raid (Law Enforcement) is occuring rightnow!",0,255,0)
				else
					msg(ps,"MD Mansion Raid (Criminals) is occuring rightnow!",0,255,0)
				end

			elseif startseq and not started then
				if team == "law" then
					msg(ps,"MD Mansion Raid (Law Enforcement) is going to start in "..startcd.." Seconds",0,255,0)
				else
					msg(ps,"MD Mansion Raid (Criminals) is going to start in "..startcd.." Seconds",0,255,0)
				end
			else
				if team == "law" then
					msg(ps,"MD Mansion Raid (Law Enforcement) is occuring rightnow!",0,255,0)
				else
					msg(ps,"MD Mansion Raid (Criminals) is occuring rightnow!",0,255,0)
				end
			end
		else
			if timeLeft > 0 then
				if team == "law" then
					exports.NGCdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Law Enforcement) can be started in "..timeLeft.." Seconds",0,255,0)
				else
					exports.NGCdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Criminals) can be started in "..timeLeft.." Seconds",0,255,0)
				end

			else
				if team == "law" then
					exports.NGCdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Law Enforcement) can be now be started!",0,255,0)
				else
					exports.NGCdxmsg:createNewDxMessage(ps,"MD Mansion Raid (Criminals) can be now be started!",0,255,0)
				end
			end
		end
	end)

loadEnters()
loadExits()









