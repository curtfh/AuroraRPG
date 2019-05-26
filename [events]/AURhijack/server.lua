theVeh = false
vehs={
445,507,585,587,466,492,546,551,516,411,559,561,560,506,451,480,565,415,541,494
}
local starts = {
	{1197.14,-882.99,43.01,276},
	{1019.27,-1089.31,23.82,176},
	{886.49,-1136.34,23.66,90},
	{743.2,-1350.21,13.5,267},
	{660.63,-1547.23,14.85,91},
	{652.19,-1767.87,13.54,352},
	{1063.43,-1746.26,13.45,264},
	{1337.97,-871.23,39.29,180},

}

local destsCrim = {
	{95.8,-164.88,2.59,90},
}

local destsLaw = {
	{167.94,-44.75,1.57,273},
}

local wanted = {}
current="law"
resetTimer = false
firstEnter=false
resetTimer=false
started=false
local dx,dy,dz = 0,0,0
theVeh=false
local truckMaxSpeed = 50 --kmh
local rex,rey,rez = 0,0,0
truckDM = nil

function start()
	firstEnter=true
	if isTimer(resetTimer) then killTimer(resetTimer) end
	if isTimer(startTimer) then killTimer(startTimer) end
	if current=="crim" then t = destsCrim else t = destsLaw end
	local i2 = math.random(1,#t)
	local i = math.random(1,#starts)
	local x,y,z = starts[i][1], starts[i][2], starts[i][3]
	dx,dy,dz = t[i2][1],t[i2][2],t[i2][3]
	theVeh=createVehicle(vehs[math.random(1,#vehs)],x,y,z)
	truckDM = createColCircle(x,y,30)
	attachElements(truckDM,theVeh)
	rex,rey,rez = x,y,z
	setElementRotation(theVeh,0,0,starts[i][4])
	resetTimer=setTimer(reset,700000,1)
	destMarker=createMarker(dx,dy,dz-1,"cylinder",3)
	addEventHandler("onMarkerHit",destMarker,hitMarker)
	started=true
	vehName=getVehicleName(theVeh)
	wanted={}
	if current == "crim" then
		warnCriminals("(AUR Hijack) The Mafia has left a precious vehicle on the streets!")
		warnCriminals("(AUR Hijack) A "..vehName.." needs to be hijacked! Steal it and bring it in for some money!")
	elseif current=="law" then
		warnLaw("(AUR Hijack) AUR's Government Head Quarters have tracked down a stolen vehicle to a location nearby")
		warnLaw("(AUR Hijack) Recover the stolen "..vehName.." and bring it to the desired destination for a satisfying payment!")
		warnLaw("(AUR Hijack) Escort the vehicle to be paid stay close to the stolen vehicle")
		--warnLaw("(AUR Hijack) (Military forces,Airforce or SWAT team) are allowed to drive it)")
	end
	if current=="crim" then
		for k,v in pairs(getPlayersInTeam(getTeamFromName("Criminals"))) do
			local source=v
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	else
		for k,v in pairs(getLawTable()) do
			local source=v
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	end
end

addEvent("onPlayerLogin",true)
addEventHandler("onPlayerLogin",root,function()
	if started==true then
		if current=="law" then
			if isLaw(source) == true then
				if isElement(theVeh) then
					triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
				end
			end
		elseif current=="crim" then
			if getTeamName(getPlayerTeam(source)) == "Criminals" then
				if isElement(theVeh) then
					triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
				end
			end
		end
	end
end)

function hitMarker(e)
	if source == destMarker then
		if getElementType(e) == "vehicle" then
			if e ~= theVeh then return end
			if isElement(getVehicleController(e)) then
				local p = getVehicleController(e)
				if current=="crim" then
					if getTeamName(getPlayerTeam(p)) == "Criminals" then
						local pay,score = getPay()
						exports.CSGwanted:addWanted(p,37,getRandomPlayer())
						exports.CSGscore:givePlayerScore(p,2)
						local per = getElementHealth(theVeh)/10
						per=math.floor(per)
						pay=(per/100)*pay
						pay=math.floor(pay)
						exports.AURpayments:addMoney(p,pay,"Custom","Misc",0,"AURhijack")
						warnCriminals(""..getElementData(p,"Rank").." "..getPlayerName(p).." has returned the hijacker vehicle ("..per.."% health) for $"..pay.."!")
						exports.NGCdxmsg:createNewDxMessage(p,"+2 Score for delievering the hijacker vehicle!",0,255,0)
						setElementData(p,"wantedPoints",getElementData(p,"wantedPoints")+10)
						exports.AURcriminalp:giveCriminalPoints(p, "", 5)
						local am = exports.DENstats:getPlayerAccountData(p,"hijackcarscrim")
						if am == nil or am == false then am=0 end
						exports.DENstats:setPlayerAccountData(p,"hijackcarscrim",am+1)
						reset()
					else
						exports.NGCdxmsg:createNewDxMessage("Only criminals can deliever this vehicle right now!",255,255,0)
						return
					end
				elseif current=="law" then
					if isLaw(p) then
						local pay,score = getPay()

						exports.CSGscore:givePlayerScore(p,1)
						local per = getElementHealth(theVeh)/10
						per=math.floor(per)
						pay=(per/100)*pay
						pay=math.floor(pay)
						exports.AURpayments:addMoney(p,pay+1000,"Custom","Misc",0,"AURhijack")
						local has = {}
						for k,v in ipairs(getElementsByType("player")) do
							if v ~= p then
								if isLaw(v) then
									if isElementWithinColShape(v,truckDM) then
										if has[v] == true then
										else
											has[v] = true
											exports.CSGscore:givePlayerScore(v,1)
											exports.AURpayments:addMoney(v,pay,"Custom","Misc",0,"AURhijack")
											exports.NGCdxmsg:createNewDxMessage(v,"$"..pay.." and 1 score for escorting the stolen vehicle!",0,255,0)
										end
									end
								end
							end
						end

						warnLaw(""..getElementData(p,"Rank").." "..getPlayerName(p).." has returned the stolen vehicle ("..per.."% health) for $"..(pay+1000).."!")
						exports.NGCdxmsg:createNewDxMessage(p,"$"..(pay+1000).." and 1 Score for returning the stolen vehicle!",0,255,0)
						local am = exports.DENstats:getPlayerAccountData(p,"hijackcarslaw")
						if am == nil or am == false then am=0 end
						exports.DENstats:setPlayerAccountData(p,"hijackcarslaw",am+1)
						reset()
					else
						exports.NGCdxmsg:createNewDxMessage("Only a law enforcement officer can deliever this vehicle right now!",255,255,0)
						return
					end
				end
			end
		end
	end
end

function getPay()
	if current=="law" then
		local law = getLawTable()
		local laws = #law
		local money=laws*1500
		local score=laws*0.18
		return money,score
	elseif current=="crim" then
		local crim = getPlayersInTeam(getTeamFromName("Criminals"))
		local crims = #crim
		local money=crims*1500
		local score=crims*0.18
		return money,score
	end
end

addEventHandler("onVehicleStartEnter",root,function(thePlayer, seat, jacked)
	if source == theVeh then
		if getPedOccupiedVehicleSeat(thePlayer) ~= 0 then
			exports.NGCdxmsg:createNewDxMessage(thePlayer,"You are not allowed to enter as passenger in this vehicle",255,0,0)
			cancelEvent()
			return
		end
		if current=="crim" and getTeamName(getPlayerTeam(thePlayer)) == "Criminals" then
			return
		elseif current=="law" and isLaw(thePlayer) then
			--if getTeamName(getPlayerTeam(thePlayer)) == "SWAT Team" or getTeamName(getPlayerTeam(thePlayer)) == "Military Forces" or getTeamName(getPlayerTeam(thePlayer)) == "Air Force" then
				--return
			--else
				--exports.NGCdxmsg:createNewDxMessage(thePlayer,"You are not allowed to enter hijack vehicle (Military Forces,SWAT Team or Airforce require)",255,0,0)
				--cancelEvent()
			--end
		else
			exports.NGCdxmsg:createNewDxMessage(thePlayer,"You are not allowed to enter hijack vehicle",255,0,0)
			cancelEvent()
		end
	end
end)

addEventHandler("onVehicleEnter",root,function(p)
	if source ~= theVeh then return end
	if getPedOccupiedVehicleSeat(p) ~= 0 then return end
	if current=="crim" and getTeamName(getPlayerTeam(p)) == "Criminals" then
		warnCriminals(""..getElementData(p,"Rank").." "..getPlayerName(p).." has entered the hijacker vehicle "..vehName.."!")
		if wanted[p] == nil then wanted[p]=false end
		if wanted[p] == false then
			exports.CSGwanted:addWanted(p,36,getRandomPlayer())
			wanted[p]=true
		end
		exports.NGCdxmsg:createNewDxMessage(p,"Move to (Cup blip) and drop it there to get reward",255,0,0)
	elseif current=="law" then
		if isLaw(p) then
			warnLaw(""..getElementData(p,"Rank").." "..getPlayerName(p).."  has entered the stolen vehicle "..vehName.."!")
		else
			warnLaw("A unknown stranger has entered the stolen vehicle, recover it!")
		end
		exports.NGCdxmsg:createNewDxMessage(p,"Move to (Cup blip) and drop it there to get reward",255,0,0)
	end
	if firstEnter==true then
		firstEnter=false
		killTimer(resetTimer)
		resetTimer=setTimer(reset,700000,1)
	end
end)

addEventHandler("onVehicleExplode",root,function()
	if source == theVeh then
		if current=="crim" then
			warnCriminals("The "..vehName.." has blown up! It can no longer be recovered!")
			setTimer ( function(theVeh) if isElement(theVeh) then destroyElement(theVeh) end end, 5000, 1,theVeh )
		elseif current=="law" then
			warnLaw("The "..vehName.." has blown up! No law officer is able to return it now!")
			setTimer ( function(theVeh) if isElement(theVeh) then destroyElement(theVeh) end end, 5000, 1,theVeh )
		end
	end
end)

function isVehicleEmpty( vehicle )
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end

	local passengers = getVehicleMaxPassengers( vehicle )
	if type( passengers ) == 'number' then
		for seat = 0, passengers do
			if getVehicleOccupant( vehicle, seat ) then
				return false
			end
		end
	end
	return true
end

function monitorTruck()
	if theVeh and isElement(theVeh) then
		local limit = truckMaxSpeed
		local speedx, speedy, speedz = getElementVelocity ( theVeh )
		local kmh = ((speedx^2 + speedy^2 + speedz^2)^(0.5))*180
		if kmh > limit then
			local diff = limit/kmh
			setElementVelocity(theVeh,speedx*diff,speedy*diff,speedz)
		end
		if isElementInWater(theVeh) then
			if isVehicleEmpty(theVeh) then
				if rex ~= 0 then
					setElementPosition(theVeh,rex,rey,rez)
					if isTimer(startTimer) then killTimer(startTimer) end
					if isTimer(resetTimer) then killTimer(resetTimer) end
					resetTimer=setTimer(reset,700000,1)
				end
			end
		end
	end
end
setTimer(monitorTruck,15000,0)

local lawTeams = {
	"Government",
}

function reset()
	firstEnter=true
	started=false
	if isTimer(resetTimer) then killTimer(resetTimer) end
	if isTimer(startTimer) then killTimer(startTimer) end
	startTimer=setTimer(start,180000,1)
	if current=="law" then
		for k,v in pairs(getLawTable()) do
			local source=v
			triggerClientEvent(source,"hijackBlipd",source)
		end
		current="crim"
	else
		for k,v in pairs(getPlayersInTeam(getTeamFromName("Criminals"))) do
			local source=v
			triggerClientEvent(source,"hijackBlipd",source)
		end
		current="law"
	end
	if isElement(theVeh) then
		destroyElement(theVeh)
	end
	if isElement(destMarker) then
		destroyElement(destMarker)
	end
end

function warnCriminals(msg)
	local list = getPlayersInTeam(getTeamFromName("Criminals"))
	for k,v in pairs(list) do
		 exports.NGCdxmsg:createNewDxMessage(v,msg,255,0,0)
	end
end

function warnLaw(msg)
	local law = getLawTable()
	for k,v in pairs(law) do
		 exports.NGCdxmsg:createNewDxMessage(v,msg,0,255,0)
	end
end

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

function isLaw(e)
	if e and isElement(e) and getPlayerTeam(e) then
		local team = getTeamName(getPlayerTeam(e))
		for k,v in pairs(lawTeams) do if v == team then return true end end
	end
	return false
end

addEvent("onPlayerTeamChange",true)
addEventHandler("onPlayerTeamChange",root,function()
	if current=="law" then
		if isLaw(source) == false then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			if (isElement(theVeh)) then
				triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
			end		end
	else
		if getTeamName(getPlayerTeam(source)) ~= "Criminals" then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			if (isElement(theVeh)) then
				triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
			end
		end
	end
end)

 addEventHandler("onElementDataChange",root,function(name)

	if name ~= "Occupation" then return end
	if getElementType(source) ~= "player" then return end
	if current=="law" then
		if isLaw(source) == false or started==false then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			if started==false then return end
			if isElement(theVeh) == false then return end
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	else
		if getTeamName(getPlayerTeam(source)) ~= "Criminals" or started==false then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			if isElement(theVeh) == false then return end
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	end
end)

setTimer(start,10000,1)
