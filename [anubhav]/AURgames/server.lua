createTeam("Minigames",100,50,225)
createTeam("Drag",50,55,90)
createTeam("Trials",250,100,100)
createTeam("Shooter",100,250,20)
createTeam("Destruction Derby",250,0,150)
createTeam("Deathmatch",150,80,80)
createTeam("Counter Strike",250,150,0)
---: 3923, 3917, 3911, 3907, 3906, 3905, 3903, 3902, 3900, 3899, 3898, 3897, 3895, 3894, 3893
-- Status of event
ShooterEnabled = false
FFAEnabled = false
SWEnabled = false
HFEnabled = false
DDEnabled = false
moneyEarn = 25000
WaitingTime = 200000
EventTimer = nil
nextEvent = nil
positions = {}
startingEvent = "DD"
-- t

--[[setTimer(function()
	serverCount = getPlayerCount()
end,500,0)]]

events = {
	["SW"] = true,
	["FFA"] = true,
	["HF"] = true,
	["Shooter"] = true,
	["DD"] = true,
}

function isPlayerSigned(player)
	--[[if HFPlayer[player] then
		return true
	elseif FFAPlayer[player] then
		return true
	elseif DDPlayer[player] then
		return true
	elseif ShooterPlayer[player] then
		return true
	elseif SWPlayer[player] then
		return true
	else
		return false
	end]]
	if getElementDimension(player) == 5006 or getElementDimension(player) == 5005 or getElementDimension(player) == 5001 or getElementDimension(player) == 5002 or getElementDimension(player) == 5003 or getElementDimension(player) == 5004 then
		return true
	end
end
-- Trigger the Event

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

function triggerTheEvent(event)
	if (not events[event]) then
		outputDebugString("Bad argument 1 @ triggerTheEvent "..tostring(event).." is not registered", 1)
		return
	end
	if isFFAEnabled == true or isSWEnabled == true or isHFEnabled == true or isShooterEnabled == true or isDDEnabled == true then
		return
	end
	if (event == "Shooter") then
		ShooterEnabled = true
	elseif (event == "DD") then
		DDEnabled = true
	elseif (event == "HF") then
		HFEnabled = true
	elseif (event == "FFA") then
		FFAEnabled = true
	elseif (event == "SW") then
		SWEnabled = true
	end
	if event == "HF" then
		addEventMsg("Ev","#FFF000(Mini-Game) #FF0000Hydra Fight #FFFFFFis ready", getRootElement(), 255, 255, 0,10000)
		outputChatBox("#FF0000(Mini-Game) #FFFF00Hydra Fight #FFFFFFis ready , use /play to participate in the event!",root, 255, 255, 0,true)
	elseif event == "SW" then
		addEventMsg("Ev","#FFF000(Mini-Game) #FF0000Ship War #FFFFFFis ready", getRootElement(), 255, 255, 0,10000)
		outputChatBox("#FF0000(Mini-Game) #FFFF00Ship War #FFFFFFis ready , use /play to participate in the event!",root, 255, 255, 0,true)
	else
		addEventMsg("Ev","#FFF000(Mini-Game) #FF0000"..tostring(event).." #FFFFFFis ready", getRootElement(), 255, 255, 0,10000)
		outputChatBox("#FF0000(Mini-Game) #FFFF00"..tostring(event).." #FFFFFFis ready , use /play to participate in the event!",root, 255, 255, 0,true)
	--outputText(event)
	end
end

-- Stop the Event

function stopEvent(event)
	if (not events[event]) then
		outputDebugString("Bad argument 1 @ stopEvent, event name specified is incorrect: "..tostring(event).."", 1)
		return
	end
	if (event == "Shooter") then
		ShooterEnabled = false
	elseif (event == "HF") then
		HFEnabled = false
	elseif (event == "SW") then
		SWEnabled = false
	elseif (event == "FFA") then
		FFAEnabled = false
	elseif (event == "DD") then
		DDEnabled = false
	end
	---outputChatBox("(Mini-Game) "..event.." has ended /eventtime for more details.",root,255,255,255)
end

-- Check if event is started

function isEventStarted(event)
	if (not events[event]) then
		outputDebugString("Bad argument 1 @ isEventStarted, event name specified is incorrect: "..tostring(event).."", 1)
		return
	end
	if (event == "Shooter") then
		if (ShooterEnabled == true) then
			return true
		elseif (ShooterEnabled ~= true) then
			return false
		end
	elseif (event == "DD") then
		if (DDEnabled == true) then
			return true
		elseif (DDEnabled ~= true) then
			return false
		end

	elseif (event == "HF") then
		if (HFEnabled == true) then
			return true
		elseif (HFEnabled ~= true) then
			return false
		end
	elseif (event == "SW") then
		if (SWEnabled == true) then
			return true
		elseif (SWEnabled ~= true) then
			return false
		end

	elseif (event == "FFA") then
		if (FFAEnabled == true) then
			return true
		elseif (FFAEnabled ~= true) then
			return false
		end

	end
end

-- Start event

function startEvent(event)
	if (not events[event]) then
		outputDebugString("Bad argument 1 @ startEvent, event name specified is incorrect: "..tostring(event).."", 1)
		return
	end
	if (isFFAEnabled == true or isSWEnabled == true or isHFEnabled == true or isShooterEnabled == true or isDDEnabled == true) then
		return
	end
	--EventTimer = setTimer(triggerTheEvent, 200000, 1, event)
	nextEvent = event
end




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

function joinEvent(plr)
	if getPlayerWantedLevel(plr) >= 3 then
		local isCopNear = getNearestCop(plr)
		if isCopNear then
			exports.NGCdxmsg:createNewDxMessage( plr, "You can't warp while you are being chased by a cop!", 225, 0, 0 )
			return false
		end
	end
	if (ShooterEnabled == true) then
	--	if getElementData(plr,"isPlayerPrime") then
		if getElementData(plr,"isPlayerFlagger") then
			exports.NGCdxmsg:createNewDxMessage(plr,"You can't warp while you have the Flag!",255,0,0)
			return false
		end
			signupForShooter(plr)
	--	end
	elseif (DDEnabled == true) then
	--	i-f getElementData(plr,"isPlayerPrime") then
		if getElementData(plr,"isPlayerFlagger") then
			exports.NGCdxmsg:createNewDxMessage(plr,"You can't warp while you have the Flag!",255,0,0)
			return false
		end
			signupForDD(plr)

	--	end
	elseif (HFEnabled == true) then
	--	i-f getElementData(plr,"isPlayerPrime") then
		if getElementData(plr,"isPlayerFlagger") then
			exports.NGCdxmsg:createNewDxMessage(plr,"You can't warp while you have the Flag!",255,0,0)
			return false
		end
			signupForHF(plr)

	--	end
	elseif (SWEnabled == true) then
	--	i-f getElementData(plr,"isPlayerPrime") then
		if getElementData(plr,"isPlayerFlagger") then
			exports.NGCdxmsg:createNewDxMessage(plr,"You can't warp while you have the Flag!",255,0,0)
			return false
		end
			signupForSW(plr)

	--	end
	elseif (FFAEnabled == true) then
	--	i-f getElementData(plr,"isPlayerPrime") then
		if getElementData(plr,"isPlayerFlagger") then
			exports.NGCdxmsg:createNewDxMessage(plr,"You can't warp while you have the Flag!",255,0,0)
			return false
		end
			signupForFFA(plr)

	--	end
	end
end
--addCommandHandler("play", joinEvent)



--[[addCommandHandler("givexd",function(p,cmd,r)
	if getElementData(p,"isPlayerPrime") then
		if r then
			loadMap(r)
			setElementPosition(p,ShooterPos[r][1][1],ShooterPos[r][1][2],ShooterPos[r][1][3])
		end
	end
end)

addCommandHandler("startxd",function(p,cmd,r)
	if getElementData(p,"isPlayerPrime") then
		startEvent(r)
	end
end)]]
-- On resource start

function hasProsiner(p)
	if exports.DENlaw:isPlayerLawEnforcer(p) then
		local arrestedTable = exports.DENlaw:getCopArrestedPlayers( p )
		if arrestedTable then
			if arrestedTable and #arrestedTable == 0 or arrestedTable == nil then
				return true
			else
				for i, thePrisoner in ipairs ( arrestedTable ) do
					if thePrisoner and i > 0 then
						return false
					else
						return true
					end
				end
			end
		else
			return true
		end
	else
		return true
	end
end

function onStart()
	if (isFFAEnabled == true or isSWEnabled == true or isHFEnabled == true or isShooterEnabled == true or isDDEnabled == true) then
		return
	end
	nextEvent = startingEvent
	---EventTimer = setTimer(triggerTheEvent, WaitingTime, 1, startingEvent)

end
addEventHandler("onResourceStart", resourceRoot, onStart)

function outputText(event)
	--addEventMsg("startingEvent", "#FF0000(Mini-Game) #FFFF00"..tostring(event).."",getRootElement(), 255, 255, 0, 5000)

end

function stopText()
	--addEventMsg("startingEvent","",root, 255, 255, 0, 5000)
end

-- Time until next event

function outputTime(plr)
	if (isTimer(EventTimer)) then
		a, b, c = getTimerDetails(EventTimer)
		timeLeftt = a/1000
		timeLeft = math.floor(timeLeftt)
		addEventMsg("Ev1","#00FF00Mini-Game ("..nextEvent..") #FFFFFFEvent upcoming within: "..onCalculateBanktime(math.floor(a)).."", plr, 255, 255, 0)
	elseif (DDEnabled == true) then
		if DDStarted == false then
			addEventMsg("Ev2","#00FF00Mini-Game (DD) Use /play to play this event", plr, 255, 255, 0)
		else
			addEventMsg("Ev1","#00FF00Mini-Game (DD) in progres", plr, 255, 255, 0)
		end
	elseif (ShooterEnabled == true) then
		if ShooterStarted == false then
			addEventMsg("Ev2","#00FF00Mini-Game (Shooter) Use /play to play this event", plr, 255, 255, 0)
		else
			addEventMsg("Ev1","#00FF00Mini-Game (Shooter) in progres", plr, 255, 255, 0)
		end
	elseif (HFEnabled == true) then
		if HFStarted == false then
			addEventMsg("Ev2","#00FF00Mini-Game (Hydra Fight) Use /play to play this event", plr, 255, 255, 0)
		else
			addEventMsg("Ev1","#00FF00Mini-Game (Hydra Fight) in progres", plr, 255, 255, 0)
		end
	elseif (SWEnabled == true) then
		if SWStarted == false then
			addEventMsg("Ev2","#00FF00Mini-Game (Ship War) Use /play to play this event", plr, 255, 255, 0)
		else
			addEventMsg("Ev1","#00FF00Mini-Game (Ship War) in progres", plr, 255, 255, 0)
		end
	elseif (FFAEnabled == true) then
		if FFAStarted == false then
			addEventMsg("Ev2","#00FF00Mini-Game (FFA) Use /play to play this event", plr, 255, 255, 0)
		else
			addEventMsg("Ev1","#00FF00Mini-Game (FFA) in progres", plr, 255, 255, 0)
		end
	end
end
addCommandHandler("eventtime", outputTime)


function addEventMsg(id, text, player, r, g, b, timer)
--	if (type(id) ~= "string") then return false end
	--triggerClientEvent(player, "addEventMsg", player, id, text, r, g, b, timer)
	--for k,v in ipairs(getElementsByType("player")) do
	--	if getPlayerTeam(v) and getTeamName(getPlayerTeam(v)) == "Staff" or getElementData(v,"isPlayerPrime") then
		--	exports.killMessages:outputMessage(removeHEX(text),v,0,255,0)
			triggerClientEvent(player, "addEventMsg", player, id, text, r, g, b, timer)
	--	end
	--end
	return true
end


function removeHEX( message )

	return string.gsub(message,"#%x%x%x%x%x%x", "")

end

