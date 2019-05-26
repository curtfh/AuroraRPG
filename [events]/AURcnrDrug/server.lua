local enter = createMarker(2540.38,-1304,36,"arrow",1.5,255,0,0)
local enter2 = createMarker(2545.34,-1277.81,54,"arrow",1.5,255,0,0)
local exits = createMarker(2541.55,-1303.95,1026.3,"arrow",1.5,255,0,0)
local exits2 = createMarker(2548.8,-1294.67,1062.3,"arrow",1.5,255,0,0)

setElementDimension(exits,1)
setElementDimension(exits2,1)
setElementInterior(exits,2)
setElementInterior(exits2,2)

copsIn = {2543.64,-1304.09,1025.07,179}
copsOut = {2536.18,-1303.72,34.95,83}
crimsOut = {2536.18,-1303.72,34.95,83}
crimsIn = {2551.22,-1289.58,1060.98,346}
rootOut = {2542.03,-1277.42,52.76,86}

robMarkers = {
	{2553.59,-1291,1043.12,178},
	{2558.91,-1290.95,1043.12,182},
	{2558.64,-1295.87,1043.12,5},
	{2553.42,-1295.86,1043.12,0},
	{2543.06,-1295.85,1043.12,357},
	{2543.27,-1291.01,1043.12,173},

}

local currentMark = {}
local secure = {}
local robbers = {}
local minRobbers = 1
local joinedLaw = {}
local stopEnter = false
local creating = false
local markers = {}
local dontcreate = false
local timeOut = {}
local eventStartTime = {}
local eventStartMark = false
local deadLawPlayers = {}

drugsTable = {"Ritalin","Weed","Ecstasy","Heroine","Cocaine","LSD"}

addEventHandler("onPlayerWasted",root,function(wep,killer)
	if getElementInterior(source) == 2 and getElementDimension(source) == 1 then
		if killer and isElement(killer) and getElementType(killer) == "player" then
			if exports.DENlaw:isLaw(killer) and getElementData(source,"DFR") and getTeamName(getPlayerTeam(source)) == "Criminals" then
				exports.AURpayments:addMoney(killer,5000,"Custom","Event",0,"CnR DF Robbery")
				for d,a in ipairs(drugsTable) do
					exports.CSGdrugs:giveDrug(killer,a,20)
					exports.NGCdxmsg:createNewDxMessage(killer,"You have earned "..amount.." of "..a.." and $5,000 (Reward for killing "..getPlayerName(source)..")",0,250,0)
					exports.AURcriminalp:giveCriminalPoints(killer, "Race", 5)
				end
			end
			if exports.DENlaw:isLaw(source) and getElementData(source,"DFR") and getTeamName(getPlayerTeam(killer)) == "Criminals" then
				exports.AURpayments:addMoney(killer,5000,"Custom","Event",0,"CnR DF Robbery")
				for d,a in ipairs(drugsTable) do
					exports.CSGdrugs:giveDrug(killer,a,20)
					exports.NGCdxmsg:createNewDxMessage(killer,"You have earned "..amount.." of "..a.." and $5,000 (Reward for killing "..getPlayerName(source)..")",0,250,0)
					exports.AURcriminalp:giveCriminalPoints(killer, "Race", 5)
				end
			end
		end
		if getElementData(source,"DFR") then
			triggerClientEvent(source,"failDFR",source)
		end
		for k,v in ipairs(robbers) do
			if v == source then
				triggerClientEvent(source,"failDFR",source)
				table.remove(robbers,source)
				break
			end
		end
		for k,v in ipairs(joinedLaw) do
			if v == source then
				table.insert(deadLawPlayers,source)
				triggerClientEvent(source,"failDFR",source)
				table.remove(joinedLaw,source)
				break
			end
		end
		setElementData(source,"DFR",false)
		triggerClientEvent("countDFR",root,#joinedLaw,#robbers)
	end
end)
addEventHandler("onPlayerQuit",root,function(wep,killer)
	if getElementInterior(source) == 2 and getElementDimension(source) == 1 then
		if getElementData(source,"DFR") then
			triggerClientEvent(source,"failDFR",source)
		end
		for k,v in ipairs(robbers) do
			if v == source then
				triggerClientEvent(source,"failDFR",source)
				table.remove(robbers,source)
				break
			end
		end
		for k,v in ipairs(joinedLaw) do
			if v == source then
				triggerClientEvent(source,"failDFR",source)
				table.remove(joinedLaw,source)
				break
			end
		end
		local x,y,z,rot = unpack(crimsOut)
		setElementInterior(source,0)
		setElementDimension(source,0)
		setElementPosition(source,x,y,z)
		setPedRotation(source,rot)
		setElementData(source,"DFR",false)
		triggerClientEvent("countDFR",root,#joinedLaw,#robbers)
	end
end)

addEvent("failDFRob",true)
addEventHandler("failDFRob",root,function()
	if source and getElementType(source) == "player" then
		if not isPedInVehicle(source) then
			if secure[source] and isElement(secure[source]) and getElementType(secure[source]) == "player" then
				if secure[source] == source then
					secure[source] = nil
					currentMark[source] = nil
					triggerClientEvent(source,"failDFR",source)
				end
			end
		end
	end
end)

addEventHandler("onMarkerHit",root,function(hitElement,Match)
	if Match then
		if hitElement and getElementType(hitElement) == "player" then
			if not isPedInVehicle(hitElement) then
				if source == enter or source == enter2 then
					if canIEnter(hitElement) then
						if exports.DENlaw:isLaw(hitElement) then
							for k,v in ipairs(joinedLaw) do
								if v == hitElement then
									return false
								end
							end
							setElementData(hitElement,"DFR",true)
							local x,y,z,rot = unpack(copsIn)
							setElementInterior(hitElement,2)
							setElementDimension(hitElement,1)
							setElementPosition(hitElement,x,y,z)
							setPedRotation(hitElement,rot)
							table.insert(joinedLaw,hitElement)
							triggerClientEvent("countDFR",root,#joinedLaw,#robbers)
						else
							if stopEnter == true then
								exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't enter at this time",255,0,0)
							return false end
							for k,v in ipairs(robbers) do
								if v == hitElement then
									return false
								end
							end
							setElementData(hitElement,"DFR",true)
							local x,y,z,rot = unpack(crimsIn)
							setElementInterior(hitElement,2)
							setElementDimension(hitElement,1)
							setElementPosition(hitElement,x,y,z)
							setPedRotation(hitElement,rot)
							table.insert(robbers,hitElement)
							triggerClientEvent("countDFR",root,#joinedLaw,#robbers)
							delay()
						end
					end
				elseif source == exits then
					if Match then
						if hitElement and getElementType(hitElement) == "player" then
							if not isPedInVehicle(hitElement) then
								--if canIEnter(hitElement) then
									if exports.DENlaw:isLaw(hitElement) then
										local x,y,z,rot = unpack(copsOut)
										setElementInterior(hitElement,0)
										setElementDimension(hitElement,0)
										setElementPosition(hitElement,x,y,z)
										setPedRotation(hitElement,rot)
										setElementData(hitElement,"DFR",false)
										for k,v in ipairs(joinedLaw) do
											if v == hitElement then
												table.remove(joinedLaw)
												break
											end
										end
										triggerClientEvent("countDFR",root,#joinedLaw,#robbers)
									else
										local x,y,z,rot = unpack(crimsOut)
										setElementInterior(hitElement,0)
										setElementDimension(hitElement,0)
										setElementPosition(hitElement,x,y,z)
										setPedRotation(hitElement,rot)
										setElementData(hitElement,"DFR",false)
										for k,v in ipairs(robbers) do
											if v == hitElement then
												table.remove(robbers)
												break
											end
										end
										triggerClientEvent("countDFR",root,#joinedLaw,#robbers)
									end
								--end
							end
						end
					end
				elseif source == exits2 then
					if Match then
						if hitElement and getElementType(hitElement) == "player" then
							if not isPedInVehicle(hitElement) then
								--if canIEnter(hitElement) then
									local x,y,z,rot = unpack(rootOut)
									setElementInterior(hitElement,0)
									setElementDimension(hitElement,0)
									setElementPosition(hitElement,x,y,z)
									setPedRotation(hitElement,rot)
									setElementData(hitElement,"DFR",false)
									for k,v in ipairs(joinedLaw) do
										if v == hitElement then
											table.remove(joinedLaw)
											break
										end
									end
									for k,v in ipairs(robbers) do
										if v == hitElement then
											table.remove(robbers)
											break
										end
									end
									triggerClientEvent("countDFR",root,#joinedLaw,#robbers)
								--end
							end
						end
					end
				end
			end
		end
	end
end)

function controlMarker(hitElement,Match)
	if Match then
		if hitElement and getElementType(hitElement) == "player" then
			if not isPedInVehicle(hitElement) then
				if secure[source] and isElement(secure[source]) and getElementType(secure[source]) == "player" then
					if getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
						exports.NGCdxmsg:createNewDxMessage(hitElement,"This machine is being robbed by "..secure[source],255,0,0)
					elseif exports.DENlaw:isLaw(hitElement) then
						exports.NGCdxmsg:createNewDxMessage(hitElement,"This machine is being robbed by "..secure[source].." kill him and defuse the machine",255,0,0)
					end
					return false
				end
				if getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
					if getElementData(source,"robTeam") == "none" then
						triggerClientEvent(hitElement,"addTheCode",hitElement)
						currentMark[hitElement] = source
						secure[source] = hitElement
					else
						exports.NGCdxmsg:createNewDxMessage(hitElement,"This machine already owned by "..getElementData(source,"robTeam"),255,0,0)
					end
				elseif exports.DENlaw:isLaw(hitElement) then
					if getElementData(source,"robTeam") == "none" then
						triggerClientEvent(hitElement,"addTheCode",hitElement)
						currentMark[hitElement] = source
						secure[source] = hitElement
					else
						exports.NGCdxmsg:createNewDxMessage(hitElement,"This machine already owned by "..getElementData(source,"robTeam"),255,0,0)
					end
				end
			end
		end
	end
end

function controlMarkerElse(hitElement,Match)
	if Match then
		if hitElement and getElementType(hitElement) == "player" then
			if not isPedInVehicle(hitElement) then
				if secure[source] and isElement(secure[source]) and getElementType(secure[source]) == "player" then
					if secure[source] == hitElement then
						secure[source] = nil
						currentMark[hitElement] = nil
						triggerClientEvent(hitElement,"failDFR",hitElement)
					end
				end
			end
		end
	end
end

function delay()
	if creating == true then return false end
	if #robbers >= minRobbers then
		if dontcreate == true then return false end
		--- open gates
		creating = true
		stopEnter = true
		for i=1,#robMarkers do
			dontcreate = true
			local x,y,z = robMarkers[i][1],robMarkers[i][2],robMarkers[i][3]
			local marker = createMarker(x,y,z,"cylinder",1.2,255,255,255)
			setElementDimension(marker,1)
			setElementInterior(marker,2)
			secure[marker] = {}
			setElementData(marker,"id",i)
			setElementData(marker,"robTeam","none")
			addEventHandler("onMarkerHit",marker,controlMarker)
			addEventHandler("onMarkerLeave",marker,controlMarkerElse)
			table.insert(markers,marker)
		end
		r("Hack the machine code, rob the drugs and kill the cops")
		c("Kill the robbers and defuse the drugs machines before they escape with the drugs!")
		timeOut = setTimer(destroyEvent,610000,1)
		triggerClientEvent("drawDFRTime",root,610000)
	end
end

function destroyEvent()
	for k,v in ipairs(markers) do
		if isElement(v) then destroyElement(v) end
	end
	r("Leave the drug factory asap, you have got 2 minutes before you die")
	c("Leave the drug factory asap and kill the robbers or arrest them outside")
end



addEvent("lockDownMarker",true)
addEventHandler("lockDownMarker",root,function(d)
	if getTeamName(getPlayerTeam(source)) == "Criminals" then
		if currentMark[source] then
			setMarkerColor(currentMark[source],225,0,0,150)
			setElementData(currentMark[source],"robTeam","Criminals")
			r(getPlayerName(source).." has stole the recipment of "..d,0,255,0)
			local markerx = currentMark[source]
			secure[markerx] = nil
			currentMark[source] = nil
			for k,v in ipairs(robbers) do
				local heist = exports.DENstats:getPlayerAccountData(v,"heistPoints")
				if heist == nil or heist == false or not heist then heist = 0 end
				exports.DENstats:setPlayerAccountData(v,"heistPoints",heist+10)
				exports.CSGscore:givePlayerScore(v,1)
				exports.AURpayments:addMoney(v,4000,"Custom","Event",0,"CnR DF Robbery")
				exports.NGCdxmsg:createNewDxMessage(v,"You have earned 10 heist points & $4,000 & 1 score",0,255,0)
				exports.AURcriminalp:giveCriminalPoints(v, "", 3)
				exports.NGCdxmsg:createNewDxMessage(v,"Exchange heist points for drugs (Head to Recipment dealer)",0,255,0)
			end
			--exports.server:givePlayerWantedPoints(source,15)
		end
	elseif exports.DENlaw:isLaw(source) then
		if currentMark[source] then
			setMarkerColor(currentMark[source],0,100,250,150)
			setElementData(currentMark[source],"robTeam","Law")
			r(getPlayerName(source).." has defused the drugs machine of ( "..d.." )",0,255,0)
			local markerx = currentMark[source]
			secure[markerx] = nil
			currentMark[source] = nil
			for k,v in ipairs(joinedLaw) do
				for d,a in ipairs(drugsTable) do
					exports.CSGdrugs:giveDrug(v,a,50)
					exports.CSGscore:givePlayerScore(v,1)
					exports.AURpayments:addMoney(v,10000,"Custom","Event",0,"CnR DF Robbery")
					exports.NGCdxmsg:createNewDxMessage(v,"You have earned 50 hits of drugs & $10,000 & 1 score",0,255,0)
					exports.AURcriminalp:giveCriminalPoints(v, "", 5)
				end
			end
			--exports.server:givePlayerWantedPoints(source,15)
		end
	end
end)


--[[
 30-40 k
 200 hits
 kill reward > 5k and 30 hits
]]




function c(msg)
	for k,v in ipairs(joinedLaw) do
		exports.NGCdxmsg:createNewDxMessage(v,msg,255,255,0)
	end
end
function r(msg)
	for k,v in ipairs(robbers) do
		exports.NGCdxmsg:createNewDxMessage(v,msg,255,255,0)
	end
end

function startCnR()
	if isTimer(eventStartTime) then killTimer(eventStartTime) end
	eventStartTime = setTimer(function() eventStartMark = true end,60000*5,1)
end

function stopCnR()
	if isTimer(eventStartTime) then killTimer(eventStartTime) end
	eventStartMark = false
	restartTimer = setTimer(function()
		local resx = getResourceFromName("AURcnrDrug")
		restartResource(resx)
	end,50000,1)
end




function canIEnter(p)
	if getElementData(p,"isPlayerPrime") then
		if exports.AURgames:isPlayerSigned(p) then exports.NGCdxmsg:createNewDxMessage(p,"You can't enter while you are signed up in mini games do /leave",255,0,0) return false end
		if exports.DENlaw:isLaw(p) and canLawOfficerEnter(p) then
			if isTimer(eventStartTime) then
				local l,e,m = getTimerDetails(eventStartTime)
				if l <= 10000 then
					if eventStartMark == false then exports.NGCdxmsg:createNewDxMessage(p,"Drug factory robbery event is stopped or event not at this time",255,0,0) return false end
					return true
				else
					return exports.NGCdxmsg:createNewDxMessage(p,"You can't enter at this time check /cnrtime, come back later (Allowed Time:Less than 10 seconds)",255,150,0)
				end
			else
				if eventStartMark == false then exports.NGCdxmsg:createNewDxMessage(p,"Drug factory robbery event is stopped or event not at this time",255,0,0) return false end
				if eventStartMark then
					return true
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(p,"You can't enter drug factory robbery event after you die inside it",255,0,0)
			return false
		end
	else
		return false
	end
end




-- Check if the law player already died while in bank
function canLawOfficerEnter ( theOfficer )
	local state = true
	for k, theLawAccount in ipairs ( deadLawPlayers ) do
		if ( theLawAccount == exports.server:getPlayerAccountName( theOfficer ) ) then
			state = false
		end
	end
	return state
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


addCommandHandler("checkdfr",
function (thePlayer)
	local robType = "(Los Santos: DFR Event)"
	if (isTimer(eventStartTime)) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(eventStartTime)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, onCalculateBanktime(math.floor(timeLeft)).." until event get started "..robType, 230, 230, 0)
	else
		exports.NGCdxmsg:createNewDxMessage(thePlayer, robType.." is able to be robbed go to LS DFR!", 255, 230, 0)
	end
end)



addEvent("queryHeistPoint",true)
addEventHandler("queryHeistPoint",root,function()
	local dm = exports.DENstats:getPlayerAccountData(source,"heistPoints")
	if not dm or dm == nil or dm == false then dm = 0 end
	triggerClientEvent(source,"callHeistPoint",source,dm)
end)


drugsTable = {"Ritalin","Weed","Ecstasy","Heroine","Cocaine","LSD"}

local antiSpam = {}
local quitDetect = {}


addEvent("setPlayerQuit",true)
addEventHandler("setPlayerQuit",root,function()
	quitDetect[source] = true
end)


addEventHandler("onPlayerCommand",root,function(cmd)
	if cmd == "reconnect" or cmd == "quit" or cmd == "disconnect" or cmd == "exit" or cmd == "connect" then
		quitDetect[source] = true
	end
end)


addEvent("exchangeRecipmentPoints",true)
addEventHandler("exchangeRecipmentPoints",root,function(pts,pd)
	local poin = tonumber(pts)
	local dr = tonumber(pd)
	local can,mssg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		if isTimer(antiSpam[source]) then
			exports.NGCdxmsg:createNewDxMessage(source,"Please wait before you sell the recipments 5 seconds",255,0,0)
			return false
		end
		antiSpam[source] = setTimer(function() end,5000,1)
		local num = exports.DENstats:getPlayerAccountData(source,"heistPoints")
		if not num or num == false or num == nil then num = 0 end
		local num = tonumber(num)
		if num > 0 then
			if poin > 0 then
				if num < poin then
					exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough recipment",255,0,0)
					return false
				end
				if num >= poin then
					if num-poin >= 0 then
						if quitDetect[source] == true then
							return false
						end
						exports.DENstats:setPlayerAccountData(source,"heistPoints",num-poin)
						for k,v in ipairs(drugsTable) do
							exports.CSGdrugs:giveDrug(source,v,dr)
							exports.NGCdxmsg:createNewDxMessage(source,"You have sold "..poin.." recipments for "..dr.." hits of all drugs kinds",0,255,0)
						end
						triggerEvent("queryHeistPoint",source)
					else
						exports.NGCdxmsg:createNewDxMessage(source,"Your recipemnt are negative or not enough , please get more recipemnts",255,0,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough recipment",255,0,0)
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You dont have any recipemnt to sell",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,mssg,255,0,0)
	end
end)



createObject( 12950, 2540, -1265.3, 49.8, 0, 0, 270 )
createObject( 12950, 2533.6001, -1265.3, 44.9, 0, 0, 270 )
createObject( 12950, 2527.3, -1265.3, 40, 0, 0, 270 )
createObject( 12950, 2521, -1265.3, 35.1, 0, 0, 270 )
createObject( 12950, 2544.8, -1271.2, 49.8 )
createObject( 3109, 2545.8, -1278.5, 52.9 )
createObject( 13011, 2540, -1265.3, 49.8, 0, 0, 270 )

