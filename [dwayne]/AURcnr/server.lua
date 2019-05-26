local robber = {}
local bankRobbers = {}
local lawPlayers = {}
local joinedLaw = {}
local antiSource = {}
local markers = {}
local peds = {}
local RobberShipment = {}
local LawShipment = {}
local hostagesTable = {}
local kidnappers = {}
local secured = {}
local deadLawPlayers = {} -- All dead law that can't rejoin
local hellMarkers = {}
local moneyHack = {}
local BankLSCol = createColRectangle ( 1243.49, -1160, 450, 350 )
--local mainMarker = createMarker(1495.85,-990.49,1190,"cylinder",2,255,150,0,150)
local noCountForLeavers = false
local criminalsMarker = createMarker(1456.9887695313,-921.05236816406,1002,"cylinder",2,255,0,0,250)
local copsMarker = createMarker(1508.3858642578,-961.34887695313,1000,"cylinder",2,0,100,200,250)
setElementData(copsMarker,"MarkerType","Law Lobby")
setElementData(criminalsMarker,"MarkerType","Criminals Lobby")
local arrow1 = createMarker( 1449,-952.4,1007, "arrow", 0.9, 255, 0, 0, 255)
local arrow2 = createMarker( 1468.8,-965.4,1007, "arrow", 0.9, 255, 0, 0, 255)
--local arrow3 = createMarker( 1502.5,-971.5,1007, "arrow", 0.9, 255, 0, 0, 255)

local gate1 = createObject(3037,1451,-952,1007,0,0,90) --- Crims to enter
local gate2 = createObject(5422, 1471,-966,1007,0,0,90) -- safe room
--local gate3 = createObject(5422, 1504.1,-971.95,1007,0,0,90) --- valut room
local gateCops = createObject(5422,1543,-976.5,1007.5,0,0,0)
local gateCops2 = createObject(5422,1521.6,-957,1006,0,0,0)
local asshole = createPed(280,1464.7702636719,-956.61822509766,1002.2562255859)
setPedRotation(asshole,352)
setElementDimension(copsMarker,10000)
setElementDimension(criminalsMarker,10000)
--setElementDimension(mainMarker,1)
setElementDimension(arrow1,1)
setElementDimension(arrow2,1)
--setElementDimension(arrow3,1)
setElementData(arrow1, "cracked", false)
setElementData(arrow2, "cracked", false)
---setElementData(arrow3, "cracked", false)
setElementDimension(asshole,1)
setElementFrozen(asshole,true)
setElementData(asshole,"BR",true)
setElementDimension(gate1,1)
setElementDimension(gate2,1)
--setElementDimension(gate3,1)
setElementDimension(gateCops,1)
setElementDimension(gateCops2,1)
local maxrobbers = 5
local eventType = "Terrorist"
local DontStopEvent = false
local bankRobberyStarted = false
local positions = {
	{"Engaging Room",1463.7657470703,-938.48889160156,1002.2562255859,181.42541503906},
	{"Lobby Room",1460.5950927734,-961.89288330078,1006.4202880859,268.17276000977},
	{"Management Room",1478.8679199219,-972.14721679688,1006.6109619141,175.30364990234},
	{"Valut Room",1505.0424804688,-978.09759521484,1006.635925293,355.3039855957},
	{"The Garage",1534.6013183594,-957.90588378906,1000.285949707,180.72682189941},
}
local positions2 = {
	{259,1498.9321289063,-979.31494140625,1006.635925293,355.56274414063},
	{55,1505.0797119141,-979.20788574219,1006.635925293,359.29962158203},
	{216,1510.8154296875,-979.60577392578,1006.6422119141,1.4930114746094},
	{40,1509.7711181641,-974.01885986328,1006.635925293,176.33471679688},
	{258,1498.5848388672,-974.38555908203,1006.635925293,176.02142333984},
}

addCommandHandler("bankset",function(p,cmd,mm)
	--if getElementData(p,"isPlayerPrime") then
		if mm == "settime" then
			timeBetweenRobs = 10000
			if isTimer(bankrobStartTimer) then killTimer(bankrobStartTimer) end
			bankrobStartTimer = setTimer(function() bankRobberyStarted = false end, timeBetweenRobs, 1)
		elseif mm == "type" then
			if eventType == "Bankrobbery" then
				eventType = "Terrorist"
			else
				eventType = "Bankrobbery"
			end
		end
	--end
end)
addCommandHandler("bankrobinfo",function(p)
	outputChatBox("Bankrobbery: Capture the rooms and hold it for 5 minutes then once the time finish leave the bank zone to get rewarded",p,255,255,0)
	outputChatBox("Terrorist: Kidnape or rescue the peds and hold inside the bank for 5 minutes to get rewarded",p,255,255,0)
end)

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),function()
	timeBetweenRobs = 6400000
	--timeBetweenRobs = 10000
	bankrobStartTimer = setTimer(function() bankRobberyStarted = false end, timeBetweenRobs, 1)
	for k,player in ipairs(getElementsByType("player")) do
		setElementData(player, "isPlayerKidnapper", false)
		setElementData(player, "takeDown", false)
		setElementData(player, "robberyFinished", false)
		setElementData(player, "isPlayerAttemptToRob", false)
		setElementData(player, "isPlayerRobbing", false)
		setElementData(player, "isPlayerInBank", false)
	end
	robType = math.random(1,4)
	--- we define the type of event by random
	if robType > 2 then
		eventType = "Bankrobbery"
		--eventType = "Terrorist"
	else
		--eventType = "Bankrobbery"
		eventType = "Terrorist"
	end
end)

function onHitArrows(hitElement,dim)
	if source == arrow1 or source == arrow2 then ---or source == arrow3 then
		if (getElementType(hitElement) ~= "player") then return false end
		if (isTimer(bankrobStartTimer)) then return false end
		if not dim then return false end
		if bankRobberyStarted == true then
			if (getTeamName(getPlayerTeam(hitElement)) == "Criminals") or (getTeamName(getPlayerTeam(hitElement)) == "HolyCrap") then
				if (source == arrow1) then
					if (getElementData(arrow1, "cracked") == false) then
						setElementData(hitElement, "keypad", math.random(1,100))
						setElementData(hitElement, "gate1",true)
						setElementData(hitElement, "gate2",false)
						setElementData(hitElement, "gate3",false)
						triggerClientEvent(hitElement,"showStartWindow",hitElement)
					end
				end
				if (source == arrow2) then
					if (getElementData(arrow2, "cracked") == false) then
						setElementData(hitElement, "keypad", math.random(1,100))
						setElementData(hitElement, "gate1",false)
						setElementData(hitElement, "gate2",true)
						setElementData(hitElement, "gate3",false)
						triggerClientEvent(hitElement,"showStartWindow",hitElement)
					end
				end
				--[[if (source == arrow3) then
					if (getElementData(arrow3, "cracked") == false) then
						setElementData(hitElement, "keypad", math.random(1,100))
						setElementData(hitElement, "gate1",false)
						setElementData(hitElement, "gate2",false)
						setElementData(hitElement, "gate3",true)
						triggerClientEvent(hitElement,"showStartWindow",hitElement)
					end
				end]]
			end
		else
			exports.NGCdxmsg:createNewDxMessage(hitElement,"Event not started yet, aim on ped first to start the robbery",255,255,0)
		end
	end
end
addEventHandler("onMarkerHit", root, onHitArrows)

function onMarkerLeave(element)
	-- Gate markers
	if (source == arrow1) then
		setElementData(element, "keypad", math.random(1,100))
		triggerClientEvent(element,"destroySafeGUI",element)
		setElementData(element, "gate1",false)
		setElementData(element, "gate2",false)
		setElementData(element, "gate3",false)
	end
	if (source == arrow2) then
		setElementData(element, "keypad", math.random(1,100))
		triggerClientEvent(element,"destroySafeGUI",element)
		setElementData(element, "gate1",false)
		setElementData(element, "gate2",false)
		setElementData(element, "gate3",false)
	end
	--[[if (source == arrow3) then
		setElementData(element, "keypad", math.random(1,100))
		triggerClientEvent(element,"destroySafeGUI",element)
		setElementData(element, "gate1",false)
		setElementData(element, "gate2",false)
		setElementData(element, "gate3",false)
	end]]
end
addEventHandler("onMarkerLeave", root, onMarkerLeave)
--[[
addEventHandler("onMarkerHit",mainMarker,function(hitElement,DM)
	if source == mainMarker then
		if not DM then return false end
		if hitElement and getElementType(hitElement) == "player" then
			if getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
				if antiSource[source] == true then return false end
				-- here we count before starting the event if pass then stop marker hit
				showMeWhatYouGot(source)
			else
				exports.NGCdxmsg:createNewDxMessage(hitElement,"Only Criminals can start bank robbery!",255,255,0)
			end
		end
	end
end)]]


function onPlayerTarget ( target )
	if ( target == asshole ) then
		if getElementDimension(source) == 1 then
			if getTeamName(getPlayerTeam(source)) ~= "Criminals" and getTeamName(getPlayerTeam(source)) ~= "HolyCrap" then return end
			if bankRobberyStarted then return false end
			if ( target == asshole ) and ( getPedWeaponSlot ( source ) ~= 0 ) and ( getPedWeaponSlot ( source ) ~= 10 ) and ( getPedWeaponSlot ( source ) ~= 11 ) and ( getPedWeaponSlot ( source ) ~= 12 ) then
			if antiSource[asshole] == true then return false end
				local xx, yy, zz = getElementPosition(source)
				local mXX, mYY, mZZ = getElementPosition(asshole)
				local distancee = getDistanceBetweenPoints3D(xx, yy, zz, mXX, mYY, mZZ)
				if distancee < 5 then
					-- here we count before starting the event if pass then stop marker hit
					showMeWhatYouGot(asshole)
				end
			end
		end
	end
end
addEventHandler( "onPlayerTarget", root, onPlayerTarget )


function msgRob(msg)
	for k,v in ipairs(bankRobbers) do
		exports.NGCdxmsg:createNewDxMessage(v,msg,225,0,0)
		exports.killmessages:outputMessage(msg,v,255,0,0)
	end
end
function msgCop(msg)
	for k,v in ipairs(lawPlayers) do
		exports.NGCdxmsg:createNewDxMessage(v,msg,225,0,0)
		exports.killmessages:outputMessage(msg,v,255,0,0)
	end
end

function msgAllCops(msg)
	for k,v in ipairs(getElementsByType("player")) do
		if exports.DENlaw:isLaw(v) then
			exports.NGCdxmsg:createNewDxMessage(v,msg,225,0,0)
			exports.killmessages:outputMessage(msg,v,255,0,0)
		end
	end
end
function showMeWhatYouGot(who)
	if #bankRobbers >= maxrobbers then
		if bankRobberyStarted then return false end
		if antiSource[who] == true then return false end
		antiSource[who] = true
		msgRob("Bankrobbery will be started within 30 seconds, get ready (Mission Type: "..eventType.." )")
		if isTimer(delayer) then return false end
		delayer = setTimer(function()
		-- report for all LAW in NGC
			msgAllCops("Criminals have started bank robbery, respond AT : LS bank (Mission Type: "..eventType.." )")
			--- here we create the event
			for k,v in ipairs(bankRobbers) do
				setElementData(v, "isPlayerKidnapper",false)
				setElementData(v, "isPlayerAttemptToRob",false)
				setElementData(v, "isPlayerRobbing", true)
				exports.server:givePlayerWantedPoints(v,80)
				setElementHealth(v,200)
				setPedArmor(v,getPedArmor(v)+50)
			end
			setElementData(asshole,"scared",true)
			handleMarkers()
			bankRobberyStarted = true
			triggerClientEvent("NGCBankRobbery.alarm",root)
			updateRootClock()
		end,30000,1)
		--end,1000,1)
	else
		outputDebugString("Sorry can't do this not valid count "..#bankRobbers)
	end
end

function updateRootClock()
	if isTimer(progressTimer) then
	local l,e,m = getTimerDetails(progressTimer)
		triggerClientEvent("synceBankTime",root,l,eventType)
	end
	if isTimer(noob) then killTimer(noob) end
	noob = setTimer(updateRootClock,10000,1)
end

function updateClock(v)
	local l,e,m = getTimerDetails(progressTimer)
--	for k,v in ipairs(lawPlayers) do
		triggerClientEvent(v,"synceBankTime",v,l,eventType)
--	end
end

function handleMarkers()
	--- we create here few markers
	if isTimer(progressTimer) then return false end
	--progressTimer = setTimer(finishedRobbery,60000*6,1)
	progressTimer = setTimer(finishedRobbery,60000*6,1)
	updateRootClock()
	local l,e,m = getTimerDetails(progressTimer)
	if eventType == "Bankrobbery" then
		for i=1,#positions do
			local marker = createMarker(positions[i][2],positions[i][3],positions[i][4]-1,"cylinder",2,255,255,255,150)
			setElementDimension(marker,1)
			setElementData(marker,"id",i)
			setElementData(marker,"name",positions[i][1])
			setElementData(marker,"captured","none")
			setElementData(marker,"noHit",false)
			addEventHandler("onMarkerHit",marker,hitMarker)
			table.insert(markers,marker)
		end
		for k,v in ipairs(bankRobbers) do
			triggerClientEvent(v,"drawHax",v,"Bank Robbery Started","Mission Type : Capture the points","Kill the cops",255,0,0)
		end
		for k,v in ipairs(lawPlayers) do
			triggerClientEvent(v,"drawHax",v,"Bank Robbery Started","Mission Type : Capture the points","Kill the robbers",255,0,0)
		end
	else
		for i=1,5 do
			local ped = createPed(positions2[i][1],positions2[i][2],positions2[i][3],positions2[i][4])
			local marker = createMarker(positions2[i][2],positions2[i][3],positions2[i][4]-1,"cylinder",2,255,255,255,150)
			setElementDimension(ped,1)
			setElementDimension(marker,1)
			setElementPosition(ped,positions2[i][2],positions2[i][3],positions2[i][4]+1)
			setPedRotation(ped,positions2[i][5])
			setElementData(marker,"theDick",ped)
			setElementData(marker,"userid",i)
			setElementData(marker,"noHit",false)
			setElementData(marker,"kidnap",false)
			setElementData(marker,"what","none")
			setElementData(ped,"scared",true)
			setElementData(ped,"bankPed",true)
			setElementData(ped,"theDick",marker)
			setElementData(ped,"pos",{positions2[i][2],positions2[i][3],positions2[i][4]})
			attachElements(marker,ped,0,0,-1)
			addEventHandler("onMarkerHit",marker,hitHostage)
			table.insert(peds,ped)
			table.insert(hellMarkers,marker)
		end
		setElementDimension(copsMarker,1)
		setElementDimension(criminalsMarker,1)
		for k,v in ipairs(bankRobbers) do
			triggerClientEvent(v,"drawHax",v,"Bank Robbery Started","Mission Type : Kidnap the civilians","Kill the cops",255,0,0)
		end
		for k,v in ipairs(lawPlayers) do
			triggerClientEvent(v,"drawHax",v,"Bank Robbery Started","Mission Type : Rescue the hostages","Kill the robbers",255,0,0)
		end
	end
end

function forceClear()
	if #bankRobbers <= 0 then
		noRobbers()
		if DontStopEvent ~= true then
			breakBankEvent()
		end
	end
end

function breakBankEvent()
	noCountForLeavers = true
	if eventType == "Terrorist" then
		for index,ped in ipairs(getElementsByType("ped",resourceRoot)) do
			if getElementData(ped,"BR") ~= true then
				local attachedElements = getAttachedElements (ped)
				for i,v in ipairs ( attachedElements ) do
					for ka,va in ipairs(hellMarkers) do
						if va == v then
							table.remove(hellMarkers,ka)
							--if isElement(va) then setMarkerColor(va,0,0,0,0) end--destroyElement(va) end
							if isElement(va) then destroyElement(va) end
							break
						end
					end
				end
				for k,v in ipairs(peds) do
					if ped == v then
						table.remove(peds,k)
						hostagesTable[getElementData(ped,"theOwner")] = nil
						if isElement(v) then destroyElement(v) end
						break
					end
				end
			end
		end
		hellMarkers = {}
		peds = {}
		if isElement(copsMarker) then destroyElement(copsMarker) end
		if isElement(criminalsMarker) then destroyElement(criminalsMarker) end
	else
		for k,v in ipairs(markers) do
			--if isElement(v) then destroyElement(v) end
			if isElement(v) then setMarkerColor(v,0,0,0,0) setElementData(v,"noHit",true) end
		end
		--markers = {}
	end
	msgCop("Exit the bank within 2 minutes")
	msgRob("Exit the bank within 2 minutes")
	if isTimer(holy) then return false end
	holy = setTimer(function()
		for k,v in ipairs(bankRobbers) do
			if v and isElement(v) then
				exports.NGCdxmsg:createNewDxMessage(v,"You have been killed by the system due you didn't leave the bank!",255,0,0)
				killPed(v)
			end
		end
		for k,v in ipairs(lawPlayers) do
			if v and isElement(v) then
				exports.NGCdxmsg:createNewDxMessage(v,"You have been killed by the system due you didn't leave the bank!",255,0,0)
				killPed(v)
			end
		end
	end,60000*2,1)
	restartBanking()
end

addEventHandler("onMarkerHit",root,function(hitElement,dm)
	if source == criminalsMarker then
		if not dm then return false end
		if hitElement and getElementType(hitElement) == "player" then
			if not isPedInVehicle(hitElement) then
				if getTeamName(getPlayerTeam(hitElement)) == "Criminals" or getTeamName(getPlayerTeam(hitElement)) == "HolyCrap" then
					local ped = getElementData(hitElement,"thePed")
					local marker = getElementData(hitElement,"theDick")
					if ped and isElement(ped) then
						if getElementData(hitElement,"isPlayerKidnapper") then
							if getElementData(ped,"fuckedUp") == "Criminals" then
								table.insert(kidnappers,ped)
								--outputDebugString("kid")
							end
							setElementData(hitElement,"isPlayerKidnapper",false)
							local attachedElements = getAttachedElements (ped)
							for i,v in ipairs ( attachedElements ) do
								for ka,va in ipairs(hellMarkers) do
									if va == v then
										table.remove(hellMarkers,ka)
										if isElement(va) then destroyElement(va) end
										break
									end
								end
							end
							for k,v in ipairs(peds) do
								if ped == v then
									table.remove(peds,k)
									hostagesTable[hitElement] = {}
									if isElement(v) then destroyElement(v) end
									break
								end
							end
							if #kidnappers == 5 then
								outputChatBox("Criminals have kidnapped the hostages",root,205,0,50)
								for k,v in ipairs(bankRobbers) do
									triggerClientEvent(v,"drawHax",v,"Stay Alive","kill the Cops","Exit the bank after the mission time finish..",255,255,0)
								end
							end
						end
					end
				end
			end
		end
	elseif source == copsMarker then
		if not dm then return false end
		if hitElement and getElementType(hitElement) == "player" then
			if not isPedInVehicle(hitElement) then
				if exports.DENlaw:isLaw(hitElement) then
					local ped = getElementData(hitElement,"thePed")
					local marker = getElementData(hitElement,"theDick")
					if ped and isElement(ped) then
						if getElementData(hitElement,"isPlayerKidnapper") then
							if getElementData(ped,"fuckedUp") ~= "Criminals" then
								table.insert(secured,ped)
							end
							setElementData(hitElement,"isPlayerKidnapper",false)
							local attachedElements = getAttachedElements (ped)
							for i,v in ipairs ( attachedElements ) do
								for ka,va in ipairs(hellMarkers) do
									if va == v then
										table.remove(hellMarkers,ka)
										if isElement(va) then destroyElement(va) end
										break
									end
								end
							end
							for k,v in ipairs(peds) do
								if ped == v then
									table.remove(peds,k)
									hostagesTable[hitElement] = {}
									if isElement(v) then destroyElement(v) end
									break
								end
							end
							--if #secured > 5 then
							--	#secured = 5
						---	end
							if #secured == 5 then
								outputChatBox("Law Forces have rescued the hostages",root,0,100,200)
								for k,v in ipairs(lawPlayers) do
									triggerClientEvent(v,"drawHax",v,"Stay Alive","kill the robbers","Exit the bank after the mission time finish..",255,255,0)
								end
							end
						end
					end
				end
			end
		end
	end
end)

function resetPed(player)
	if ( hostagesTable[player] ) and ( isElement( hostagesTable[player][1] ) ) then
		local thePed = hostagesTable[player][1]
		local theMarker = getElementData(thePed,"theDick")
		local x,y,z = unpack(getElementData(thePed,"pos"))
		hostagesTable[player] = {}
		triggerClientEvent ( "onSyncPlayerhostages", root, hostagesTable )
		setElementPosition(thePed,x,y,z)
		setElementData(thePed,"kidnap",false)
		setElementData(thePed,"theOwner",false)
		setElementData(thePed,"fuckedUp","none")
		setElementData(thePed,"rescued",false)
		setElementData(thePed,"scared",true)
		setElementData(theMarker,"what","none")
		setMarkerColor(theMarker,255,255,255,150)
	end
	toggleControl(player,"sprint",true)
	setElementData(player, "isPlayerKidnapper",false)
	setElementData(player, "isPlayerInBank", false)
	setElementData(player, "isPlayerAttemptToRob", false)
	setElementData(player, "isPlayerRobbing", false)
	setElementData(player, "takeDown", false)
end

function hitHostage(hitElement,DM)
	if not DM then return false end
	if hitElement and getElementType(hitElement) == "player" then
		if getElementData(source,"noHit") then return false end
		if not isPedInVehicle(hitElement) then
			if exports.DENlaw:isLaw(hitElement) then
				if getElementData(hitElement,"isPlayerInBank") == true then
					local ped = getElementData(source,"theDick")
					if getElementData(ped,"theOwner") == hitElement then return false end
					if getElementData(hitElement,"isPlayerKidnapper") then
						exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't rescue more than 1 civilian",255,0,0)
						return false
					end
					if getElementData(ped,"kidnap") == true then
						hostagesTable[getElementData(ped,"theOwner")] = nil
						setElementData(getElementData(ped,"theOwner"),"isPlayerKidnapper",false)
						setElementData(ped,"theOwner",false)
						setElementData(ped,"fuckedUp","none")
					end
					if getElementData(ped,"rescued") ~= true then
						hostagesTable[hitElement] = { ped,hitElement }
						setMarkerColor(source,0,100,250,150)
						setElementData(ped,"kidnap",false)
						setElementData(ped,"rescued",true)
						setElementData(ped,"fuckedUp","Law")
						setElementData(ped,"theOwner",hitElement)
						setElementData(ped,"scared",false)
						setElementData(source,"what","law")
						setElementData(hitElement,"thePed",ped)
						setElementData(hitElement,"isPlayerKidnapper",true)
						exports.NGCdxmsg:createNewDxMessage(hitElement,"Take the hostage to (LAW Lobby)",255,0,0)
						triggerClientEvent ( "onSyncPlayerhostages", root, hostagesTable )

					end
				end
			elseif getTeamName(getPlayerTeam(hitElement)) == "Criminals" or getTeamName(getPlayerTeam(hitElement)) == "HolyCrap" then
				if getElementData(hitElement,"isPlayerRobbing") == true then
					local ped = getElementData(source,"theDick")
					if getElementData(ped,"theOwner") == hitElement then return false end
					if getElementData(hitElement,"isPlayerKidnapper") then
						exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't kidnap more than 1 civilian",255,0,0)
						return false
					end
					if getElementData(ped,"rescued") == true then
						exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't kidnap this civilian , secured by the LAW (Kill the Cop to kidnap the civlian)",255,0,0)
						return false
					end
					if getElementData(ped,"kidnap") == false then
						hostagesTable[hitElement] = { ped,hitElement }
						setMarkerColor(source,255,0,0,125)
						setElementData(ped,"theOwner",hitElement)
						setElementData(ped,"rescued",false)
						setElementData(ped,"kidnap",true)
						setElementData(ped,"fuckedUp","Criminals")
						setElementData(source,"what","criminals")
						setElementData(ped,"scared",false)
						setElementData(hitElement,"isPlayerKidnapper",true)
						setElementData(hitElement,"thePed",ped)
						exports.NGCdxmsg:createNewDxMessage(hitElement,"Take the hostage to Criminals Lobby",255,0,0)
						triggerClientEvent ( "onSyncPlayerhostages", root, hostagesTable )
					end
				end
			end
		end
	end
end




function hitMarker(hitElement,DM)
	if not DM then return false end
	if hitElement and getElementType(hitElement) == "player" then
		if getElementData(source,"noHit") then return false end
		if getElementData(hitElement,"isPlayerInBank") == true then
			if exports.DENlaw:isLaw(hitElement) then
				if getElementData(source,"captured") ~= "law" then
					local zone = getElementData(source,"name")
					setElementData(source,"captured","law")
					setMarkerColor(source,0,100,250,125)
					getValidShipment()
				end
			end
		elseif getElementData(hitElement,"isPlayerRobbing") == true then
			if getTeamName(getPlayerTeam(hitElement)) == "Criminals" or getTeamName(getPlayerTeam(hitElement)) == "HolyCrap" then
				if getElementData(source,"captured") ~= "criminals" then
					local zone = getElementData(source,"name")
					setElementData(source,"captured","criminals")
					setMarkerColor(source,255,0,0,125)
					getValidShipment()
				end
			end
		end
	end
end


function getValidCount()
	return #secured,#kidnappers
end

function getValidShipment()
	LawShipment = {}
	local t2={}
	for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementData(v,"captured") == "law" then
			table.insert(t2,v)
		end
	end
	for k,v in ipairs(t2) do
		table.insert(LawShipment,v)
	end
	local t={}
	RobberShipment = {}
	for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementData(v,"captured") == "criminals" then
			table.insert(t,v)
		end
	end
	for k,v in ipairs(t) do
		table.insert(RobberShipment,v)
	end
	return #LawShipment,#RobberShipment
end

function noRobbers()
	if eventType == "Bankrobbery" then
		local law,crim = getValidShipment()
		for k,v in ipairs(joinedLaw) do
			triggerClientEvent(v,"drawHax",v,law.." points captured by the Law","Arrest the robbers","",0,150,250)
		end
		--[[if law == 2 then
			handlePayment(joinedLaw,10000,2)
		elseif law == 3 then
			handlePayment(joinedLaw,15000,3)
		elseif law == 4 then
			handlePayment(joinedLaw,25000,4)
		elseif law == 5 then
			handlePayment(joinedLaw,50000,5)
		end]]
		if law >= 1 and crim == 0 or crim == false then
			handlePayment(joinedLaw,50000,5)
			outputChatBox("Law Forces have stopped the bankrobbery captured ("..law.." points)",root,0,100,200)
		end
	else
		local law,crim = getValidCount()
		for k,v in ipairs(joinedLaw) do
			triggerClientEvent(v,"drawHax",v,law.." hostages secured","Arrest the Robbers","",0,150,250)
		end
		--[[if law == 2 then
			handlePayment(joinedLaw,10000,2)
		elseif law == 3 then
			handlePayment(joinedLaw,15000,3)
		elseif law == 4 then
			handlePayment(joinedLaw,25000,4)
		elseif law == 5 then
			handlePayment(joinedLaw,50000,5)
		end]]
		if law >= 1 and crim == 0 or crim == false then
			handlePayment(joinedLaw,50000,law)
			outputChatBox("Law Forces have rescued "..law.." hostages",root,0,100,200)
		end
	end
	if isTimer(progressTimer) then killTimer(progressTimer) end
	for k,v in ipairs(lawPlayers) do
		triggerClientEvent(v,"synceBankTime",v,500,eventType)
	end
	updateRootClock()
end

function finishedRobbery()
	if eventType == "Bankrobbery" then
		local law,crim = getValidShipment()
		for k,v in ipairs(bankRobbers) do
			triggerClientEvent(v,"drawHax",v,crim.." points captured by the Criminals","Exit the Bank","Leave the whole zone!!",255,0,0)
			setElementData(v,"robberyFinished",true)
		end
		for k,v in ipairs(joinedLaw) do
			triggerClientEvent(v,"drawHax",v,law.." points captured by the Law","Arrest the robbers","",0,150,250)
		end
		if law == 2 then
			handlePayment(joinedLaw,10000,2)
		elseif law == 3 then
			handlePayment(joinedLaw,15000,3)
		elseif law == 4 then
			handlePayment(joinedLaw,25000,4)
		elseif law == 5 then
			handlePayment(joinedLaw,50000,5)
		end
		breakBankEvent()
	else
		sexwithme()
	end
	DontStopEvent = true
end

function sexwithme()
	local law,crim = getValidCount()
	for k,v in ipairs(bankRobbers) do
		triggerClientEvent(v,"drawHax",v,crim.." civilians kidnapped","Escape from the Bank","",255,0,0)
		setElementData(v,"takeDown",true)
	end
	for k,v in ipairs(joinedLaw) do
		triggerClientEvent(v,"drawHax",v,law.." hostages secured","Arrest the Robbers","",0,150,250)
	end
	if law == 2 then
		handlePayment(joinedLaw,10000,2)
	elseif law == 3 then
		handlePayment(joinedLaw,15000,3)
	elseif law == 4 then
		handlePayment(joinedLaw,25000,4)
	elseif law == 5 then
		handlePayment(joinedLaw,50000,5)
	end
	if crim == 2 then
		givePayment(bankRobbers,5000,2)
	elseif crim == 3 then
		givePayment(bankRobbers,15000,3)
	elseif crim == 4 then
		givePayment(bankRobbers,25000,4)
	elseif crim == 5 then
		givePayment(bankRobbers,50000,5)
	end
	if isTimer(progressTimer) then killTimer(progressTimer) end
	for k,v in ipairs(bankRobbers) do
		triggerClientEvent(v,"synceBankTime",v,500,eventType)
	end
	for k,v in ipairs(lawPlayers) do
		triggerClientEvent(v,"synceBankTime",v,500,eventType)
	end
	updateRootClock()
	breakBankEvent()
end

function addPay(p,m,a)
	exports.AURpayments:addMoney(p,m,"Custom","Event",0,"CnR Bank Robbery")
	exports.NGCdxmsg:createNewDxMessage(p,"You have earned $"..m,255,255,0)
	exports.CSGgroups:addXP(p,6)
end

function givePayment(tableName,amount,w)
	for k,v in ipairs(tableName) do
		if moneyHack[v] == true then return false end
		moneyHack[v] = true
		addPay(v,amount)
		exports.CSGscore:givePlayerScore(v,5)
		exports.AURcriminalp:giveCriminalPoints(v, "", 5)
		exports.NGCdxmsg:createNewDxMessage(v,"[Bankrobber] You have earned $"..amount.." + 5 scores for robbing the bank (Points:"..w..")",0,225,0)
		triggerClientEvent(v,"drawHax",v,"Bank Robbery","You have robbed the bank","You have Earned $"..amount.." + 5 scores",0,255,0)
	end
end
function handlePayment(tableName,amount,w)
	for k,v in ipairs(tableName) do
		if moneyHack[v] == true then return false end
		moneyHack[v] = true
		addPay(v,amount)
		exports.CSGscore:givePlayerScore(v,5)
		exports.NGCdxmsg:createNewDxMessage(v,"You have earned $"..amount.." + 5 scores for stopping the robbers (Points:"..w..")",0,225,0)
		triggerClientEvent(v,"drawHax",v,"Bank Robbery","You have Earned $"..amount.." + 5 scores","for stopping the robbers",0,255,0)
	end
end

---- warping

function canIEnter(p)
	if isTimer(bankrobStartTimer) then
		local l,e,m = getTimerDetails(bankrobStartTimer)
		if l <= 120000 then
			return true
		else
			return exports.NGCdxmsg:createNewDxMessage(p,"You can't enter at this time check /banktime, come back later (Allowed Time:Less than 1 minute)",255,150,0)
		end
	else
		return true
	end
end

addEvent("warpBankRob",true)
addEventHandler("warpBankRob",root,function(player,where,x,y,z,r)
	if exports.AURgames:isPlayerSigned(player) then exports.NGCdxmsg:createNewDxMessage(player,"You can't enter while you are signed up in mini games do /leave",255,0,0) return false end
	if where == 1 then
		if getTeamName(getPlayerTeam(player)) == "Criminals" or getTeamName(getPlayerTeam(player)) == "HolyCrap" then
			if canIEnter(player) then
				if (isTimer(progressTimer) or bankRobberyStarted == true) then
					exports.NGCdxmsg:createNewDxMessage(player, "You can't enter at this time!!", 255,0,0)
				else
					if robber[player] then return false end
					for k,v in ipairs(bankRobbers) do
						if v == player then
							outputDebugString("already entered")
							--break
							return false
						end
					end
					if getElementDimension(player) ~= 0 then return false end
					robber[player] = true
					table.insert(bankRobbers, player)
					toggleControl(player,"sprint",false)
					setElementData(player, "isPlayerAttemptToRob", true)
					setElementData(player, "isPlayerKidnapper", false)
					setElementData(player, "takeDown", false)
					setElementData(player, "robberyFinished", false)
					setElementData(player, "isPlayerRobbing", false)
					setElementDimension(player,1)
					setElementPosition(player,x,y,z+0.5)
					setElementRotation(player,0,0,r)
					triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
					exports.NGCdxmsg:createNewDxMessage(player,"Robbers inside the bank: "..(#bankRobbers).."/"..maxrobbers,255,255,0)
				end
			end
		elseif getTeamName(getPlayerTeam(player)) == "Paramedics" or getTeamName(getPlayerTeam(player)) == "Staff" then
			if bankRobberyStarted == true then
				setElementDimension(player,1)
				setElementPosition(player,x,y,z+0.5)
				setElementRotation(player,0,0,r)
				updateClock(player)
				setElementData(player,"helper",true)
				toggleControl(player,"sprint",false)
			else
				exports.NGCdxmsg:createNewDxMessage(player,"There is no robbery here!",255,255,0)
			end
		end
	else
		if exports.DENlaw:isLaw(player) then
			local arrestedTable = exports.DENlaw:getCopArrestedPlayers( player )
			if arrestedTable then
				if arrestedTable and #arrestedTable == 0 or arrestedTable == nil then

				else
					for i, thePrisoner in ipairs ( arrestedTable ) do
						if thePrisoner and i > 0 then
							exports.NGCdxmsg:createNewDxMessage(player,"You can't warp while arrested someone!", 255, 0, 0)
							return false
						end
					end
				end
			end
			if canIEnter(player) then
				if canLawOfficerEnter(player) then
					if robber[player] then return false end
					for k,v in ipairs(lawPlayers) do
						if v == player then
							return false
							--break
						end
					end
					if getElementDimension(player) ~= 0 then return false end
					robber[player] = true
					table.insert(lawPlayers, player)
					table.insert(joinedLaw,player)
					setElementData(player, "takeDown",false)
					setElementData(player, "isPlayerKidnapper",false)
					setElementData(player, "isPlayerInBank", true)
					setElementData(player, "lawInBank", true)
					triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
					setElementDimension(player,1)
					setElementPosition(player,x,y,z+0.5)
					setElementRotation(player,0,0,r)
					setElementHealth(player,200)
					toggleControl(player,"sprint",false)
					setPedArmor(player,getPedArmor(player)+50)
					exports.NGCdxmsg:createNewDxMessage(player,"LAW inside the bank: "..(#lawPlayers).."/5",255,255,0)
				else
					exports.NGCdxmsg:createNewDxMessage(player,"You can't join this event after you died inside or left it!",255,255,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage(player,"There is no robbery here!",255,255,0)
			end
		elseif getTeamName(getPlayerTeam(player)) == "Paramedics" or getTeamName(getPlayerTeam(player)) == "Staff" then
			if bankRobberyStarted == true then
				setElementPosition(player,x,y,z+0.5)
				setElementRotation(player,0,0,r)
				setElementData(player,"helper",true)
				toggleControl(player,"sprint",false)
			else
				exports.NGCdxmsg:createNewDxMessage(player,"There is no robbery here!",255,255,0)
			end
		end
	end
end)

addEvent("onBankKickPlayer",true)
addEventHandler("onBankKickPlayer",root,function(player)
	if noCountForLeavers == true then return false end
	if getTeamName(getPlayerTeam(player)) == "Criminals" or getTeamName(getPlayerTeam(player)) == "HolyCrap" then
		for k, theRobber in ipairs(bankRobbers) do
			if (theRobber == player) then
				table.remove(bankRobbers, k)
				setElementData(player, "isPlayerKidnapper", false)
				setElementData(player, "isPlayerRobbing", false)
				setElementData(player, "isPlayerAttemptToRob", false)
				triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
				break
			end
		end
		exports.NGCdxmsg:createNewDxMessage(player,"You have left Bankrobbery zone, probably you falied at the robbery (Reason : left bank zone)",255,0,0)
		robber[player] = false
		resetPed(player)
	else
		if exports.DENlaw:isLaw(player) then
			for k, law in ipairs(lawPlayers) do
				if (law == player) then
					setElementData(law, "isPlayerKidnapper", false)
					setElementData(law, "isPlayerInBank", false)
					table.remove(lawPlayers, k)
					triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
					break
				end
			end
			exports.NGCdxmsg:createNewDxMessage(player,"You have left Bankrobbery zone, probably you falied with stopping the robbery (Reason : left bank zone)",255,0,0)
			robber[player] = false
			resetPed(player)
		end
	end
end)

addEvent("warpBankRobOut",true)
addEventHandler("warpBankRobOut",root,function(player,where,x,y,z,r)
	if where == 1 then
		if getTeamName(getPlayerTeam(player)) == "Criminals" or getTeamName(getPlayerTeam(player)) == "HolyCrap" then
			for k, theRobber in ipairs(bankRobbers) do
				if (theRobber == player) then
					table.remove(bankRobbers, k)
					setElementData(player, "isPlayerKidnapper", false)
					setElementData(player, "isPlayerRobbing", false)
					setElementData(player, "isPlayerAttemptToRob", false)
					triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
					break
				end
			end
			robber[player] = false
			setElementDimension(player,0)
			setElementPosition(player,x,y,z+0.5)
			setElementRotation(player,0,0,r)
			resetPed(player)
		elseif getTeamName(getPlayerTeam(player)) == "Paramedics" or getTeamName(getPlayerTeam(player)) == "Staff" then
			setElementDimension(player,0)
			setElementPosition(player,x,y,z+0.5)
			setElementRotation(player,0,0,r)
		end
	else
		if exports.DENlaw:isLaw(player) then
			for k, law in ipairs(lawPlayers) do
				if (law == player) then
					setElementData(law, "isPlayerKidnapper", false)
					setElementData(law, "isPlayerInBank", false)
					table.remove(lawPlayers, k)
					triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
					break
				end
			end
			table.insert( deadLawPlayers, exports.server:getPlayerAccountName(player) )
			robber[player] = false
			setElementDimension(player,0)
			setElementPosition(player,x,y,z+0.5)
			setElementRotation(player,0,0,r)
			resetPed(player)
		elseif getTeamName(getPlayerTeam(player)) == "Paramedics" or getTeamName(getPlayerTeam(player)) == "Staff" then
			setElementDimension(player,0)
			setElementPosition(player,x,y,z+0.5)
			setElementRotation(player,0,0,r)
		end
	end
end)

---- Events


addEvent("codeCheck",true)
addEventHandler("codeCheck",root,function(code)
	if tonumber(getElementData(source,"keypad")) > tonumber(code) then
		triggerClientEvent(source,"setWarningForKeyPad",source,"Higher")
	elseif tonumber(getElementData(source,"keypad")) < tonumber(code) then
		triggerClientEvent(source,"setWarningForKeyPad",source,"Lower")
	elseif tonumber(code) == tonumber(getElementData(source,"keypad")) then
		triggerClientEvent(source,"setWarningForKeyPad",source,"Accepted")
		triggerClientEvent(source,"destroySafeGUI",source)
		if getElementData(source, "gate1") == true then
			moveObject(gate1,1000,1451,-952,2000)
			setElementData(arrow1, "cracked", true)
			setMarkerColor(arrow1, 0, 255, 0, 150)
			moveObject(gateCops,1000,1543,-976.5,2000)
		elseif getElementData(source, "gate2") == true then
			moveObject(gate2,5000,1471,-966,600)
			setElementData(arrow2, "cracked", true)
			setMarkerColor(arrow2, 0, 255, 0, 150)
			moveObject(gateCops2,5000,1521.6,-957,600)
		--[[elseif getElementData(source, "gate3") == true then
			moveObject(gate3,5000, 1504.1,-971.95,999)
			setElementData(arrow3, "cracked", true)
			setMarkerColor(arrow3, 0, 255, 0, 150)
		end]]
		end
	end
end)

addEvent("onPlayerJobChange",true)
addEventHandler("onPlayerJobChange",root,function(new,old)
	if getElementData(source,"isPlayerInBank") then
		resetPed(source)
		setElementPosition(source,1431.09, -967.87, 37.8)
		setElementDimension(source,0)
		setElementData(source, "isPlayerInBank", false)
		exports.NGCdxmsg:createNewDxMessage(source,"You have ended your shift while you're inside the bank",255,0,0)
		for k, law in ipairs(joinedLaw) do
			if (law == source) then
				table.remove(joinedLaw,k)
				break
			end
		end
		for k, law in ipairs(lawPlayers) do
			if (law == source) then
				setElementData(law, "isPlayerKidnapper", false)
				setElementData(law, "isPlayerInBank", false)
				table.remove(lawPlayers, k)
				triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
				break
			end
		end
	elseif getElementData(source,"isPlayerRobbing") or getElementData(source,"isPlayerAttemptToRob") then
		if (new == "Criminal") then return false end
		resetPed(source)
		setElementPosition(source,1435.16,-1014.27,26.63)
		setElementDimension(source,0)
		exports.NGCdxmsg:createNewDxMessage(source,"You have ended your shift while you're inside the bank",255,0,0)
		print("Kicking "..getPlayerName(source))
		for k,crim in ipairs(bankRobbers) do
			if (crim == source) then
				table.remove(bankRobbers, k)
				triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
				break
			end
		end
	elseif getElementData(source,"helper") then
		setElementPosition(source,1431.09, -967.87, 37.8)
		setElementDimension(source,0)
		setElementData(source,"helper",false)
	end
end)


addEventHandler("onSetPlayerJailed",root,function()
	if getElementData(source,"isPlayerInBank") then
		resetPed(source)
		setElementPosition(source,1431.09, -967.87, 37.8)
		setElementDimension(source,0)
		setElementData(source, "isPlayerInBank", false)
		exports.NGCdxmsg:createNewDxMessage(source,"You have ended your shift while you're inside the bank",255,0,0)
		for k, law in ipairs(joinedLaw) do
			if (law == source) then
				table.remove(joinedLaw,k)
				break
			end
		end
		for k, law in ipairs(lawPlayers) do
			if (law == source) then
				setElementData(law, "isPlayerKidnapper", false)
				setElementData(law, "isPlayerInBank", false)
				table.remove(lawPlayers, k)
				triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
				break
			end
		end
	elseif getElementData(source,"isPlayerRobbing") or getElementData(source,"isPlayerAttemptToRob") then
		resetPed(source)
		setElementPosition(source,1435.16,-1014.27,26.63)
		setElementDimension(source,0)
		exports.NGCdxmsg:createNewDxMessage(source,"You have ended your shift while you're inside the bank",255,0,0)
		for k,crim in ipairs(bankRobbers) do
			if (crim == source) then
				table.remove(bankRobbers, k)
				triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
				break
			end
		end
	elseif getElementData(source,"helper") then
		setElementPosition(source,1431.09, -967.87, 37.8)
		setElementDimension(source,0)
		setElementData(source,"helper",false)
	end
end)

addEventHandler("onColShapeLeave",root,function(hitElement,dm)
	if source == BankLSCol then
		if getElementType(hitElement) == "player" then
			if isPedInVehicle(hitElement) then return false end
			if getElementData(hitElement,"robberyFinished") then
				if getElementData ( hitElement, "isPlayerArrested" ) ~= true then
					local law,crim = getValidShipment()
					if crim == 2 then
						exports.NGCdxmsg:createNewDxMessage(hitElement,"You failed at the robbery only 2 points captured by the criminals!",225,0,0)
					elseif crim == 3 then
						if moneyHack[hitElement] == true then return false end
						moneyHack[hitElement] = true
						addPay(hitElement,15000)
						exports.NGCdxmsg:createNewDxMessage(hitElement,"You earned $15,000 due only 3 points captured by the criminals!",0,255,0)
					elseif crim == 4 then
						if moneyHack[hitElement] == true then return false end
						moneyHack[hitElement] = true
						addPay(hitElement,25000)
						exports.NGCdxmsg:createNewDxMessage(hitElement,"You earned $25,000 due only 4 points captured by the criminals!",0,255,0)
					elseif crim == 5 then
						if moneyHack[hitElement] == true then return false end
						moneyHack[hitElement] = true
						addPay(hitElement,50000)
						exports.NGCdxmsg:createNewDxMessage(hitElement,"You earned $50,000 (5/5 points captured by the criminals)!",0,255,0)
					end
					setElementData(hitElement,"isPlayerAttemptToRob",false)
					setElementData(hitElement,"isPlayerRobbing",false)
					setElementData(hitElement,"robberyFinished",false)
				end
			end
		elseif getElementType(hitElement) == "vehicle" then
			local occupants = getVehicleOccupants(hitElement)
			local seats = getVehicleMaxPassengers(hitElement)
			for seat=0,3 do
				local occupant = occupants[seat]
				if ((occupant) and (getElementType(occupant)=="player")) then
					if getElementData(occupant,"robberyFinished") then
						if getElementData ( occupant, "isPlayerArrested" ) ~= true then
							local law,crim = getValidShipment()
							if crim == 2 then
								exports.NGCdxmsg:createNewDxMessage(occupant,"You failed at the robbery only 2 points captured by the criminals!",225,0,0)
							elseif crim == 3 then
								if moneyHack[occupant] == true then return false end
								moneyHack[occupant] = true
								addPay(occupant,15000)
								exports.NGCdxmsg:createNewDxMessage(occupant,"You earned $15,000 due only 3 points captured by the criminals!",0,255,0)
							elseif crim == 4 then
								if moneyHack[occupant] == true then return false end
								moneyHack[occupant] = true
								addPay(occupant,25000)
								exports.NGCdxmsg:createNewDxMessage(occupant,"You earned $25,000 due only 4 points captured by the criminals!",0,255,0)
							elseif crim == 5 then
								if moneyHack[occupant] == true then return false end
								moneyHack[occupant] = true
								addPay(occupant,50000)
								exports.NGCdxmsg:createNewDxMessage(occupant,"You earned $50,000 (5/5 points captured by the criminals)!",0,255,0)
							end
							setElementData(occupant,"isPlayerAttemptToRob",false)
							setElementData(occupant,"isPlayerRobbing",false)
							setElementData(occupant,"robberyFinished",false)
						end
					end
				end
			end
		end
	end
end)


addEventHandler( "onPlayerWasted", root,
function ( ammo, attacker, weapon, bodypart )
	if ( attacker ) and ( isElement( attacker ) ) and ( getElementType ( attacker ) == "player" ) then
		if not ( source == attacker ) and ( getPlayerTeam( attacker ) )then
			if ((getTeamName(getPlayerTeam(attacker)) == "Criminals") or (getTeamName(getPlayerTeam(attacker)) == "HolyCrap")) and exports.DENlaw:isLaw(source) then
				if getElementData(attacker,"isPlayerRobbing") or getElementData(attacker,"robberyFinished") and getElementData(source,"isPlayerInBank") then
					exports.NGCdxmsg:createNewDxMessage( attacker, "You killed a cop, You earned $2500!", 0, 230, 0)
					exports.AURpayments:addMoney(attacker,2500,"Custom","Event",0,"CnR Bank Robbery")
					exports.CSGgroups:addXP(attacker,3)
					setElementData(attacker, "isPlayerInBank", false)
					exports.server:givePlayerWantedPoints(attacker,10)
				elseif ( exports.DENlaw:isLaw(attacker) ) and ((getTeamName(getPlayerTeam(source)) == "Criminals") or (getTeamName(getPlayerTeam(source)) == "HolyCrap")) then
					if ( getElementData(source, "isPlayerRobbing") ) or (getElementData(source, "robberyFinished")) and (getElementData(attacker, "isPlayerInBank") == true) then
						exports.NGCdxmsg:createNewDxMessage( attacker, "You killed a robber, You earned $2500!", 0, 230, 0)
						exports.AURpayments:addMoney(attacker,2500,"Custom","Event",0,"CnR Bank Robbery")
						exports.CSGgroups:addXP(attacker,3)
						local t = exports.DENstats:getPlayerAccountData(source,"brcrcrimfail")
						if not t or t == 0 or t == false then t = 0 end
						exports.DENstats:setPlayerAccountData(source,"brcrcrimfail",t+1)
						setElementData(source, "isPlayerKidnapper", false)
						setElementData(source, "takeDown", false)
						setElementData(source, "robberyFinished", false)
						setElementData(source, "isPlayerRobbing", false)
					end
				end
			end
		end
	end
end)

addEventHandler( "onPlayerWasted", root,
	function ()
		if getElementData(source,"isPlayerRobbing") or getElementData(source,"isPlayerAttemptToRob") then
			resetPed(source)
			for k, cr in ipairs(bankRobbers) do
				if (cr == source) then
					table.remove(bankRobbers,k)
					break
				end
			end
			setElementData(source, "robberyFinished", false)
			forceClear()
			triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
		end
		if getElementData(source,"isPlayerInBank") then
			resetPed(source)
			table.insert( deadLawPlayers, exports.server:getPlayerAccountName(source) )
			for k, law in ipairs(joinedLaw) do
				if (law == source) then
					table.remove(joinedLaw,k)
					break
				end
			end
			for k, law in ipairs(lawPlayers) do
				if (law == source) then
					table.remove(lawPlayers, k)
					break
				end
			end
			setElementData(source, "robberyFinished", false)
			triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
		end
	end
)

addEventHandler( "onPlayerQuit", root,
	function ()
		if getElementData(source,"isPlayerRobbing") or getElementData(source,"isPlayerAttemptToRob") then
			resetPed(source)
			setElementPosition(source,1431.09, -967.87, 37.8)
			setElementDimension(source,0)
			for k, cr in ipairs(bankRobbers) do
				if (cr == source) then
					table.remove(bankRobbers,k)
					break
				end
			end
			forceClear()
			triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
		end
		if getElementData(source,"isPlayerInBank") then
			resetPed(source)
			setElementPosition(source,1431.09, -967.87, 37.8)
			setElementDimension(source,0)
			for k, law in ipairs(joinedLaw) do
				if (law == source) then
					table.remove(joinedLaw,k)
					break
				end
			end
			for k, law in ipairs(lawPlayers) do
				if (law == source) then
					table.remove(lawPlayers, k)
					break
				end
			end
			triggerClientEvent("countBankRob", root,#bankRobbers,#lawPlayers)
		end
		if getElementDimension(source) == 1 then
			for k, cr in ipairs(bankRobbers) do
				if (cr == source) then
					table.remove(bankRobbers,k)
					break
				end
			end
			killPed(source)
		end
	end
)


-- When a cop wants to arrest a player while robbing wat nog meer alleen de markers toch, en de int zelf pff we moeten een bankrob ik ga ff ig kijken of die mappers er zijn
addEvent ( "onPlayerNightstickHit" )
addEventHandler ( "onPlayerNightstickHit", root,
function ( theCop )
	if ( getPlayerTeam( source ) ) then
		if ( getElementData ( source, "isPlayerRobbing" ) ) then
			if ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) or ( getTeamName( getPlayerTeam( source ) ) == "HolyCrap" ) then
				if getPedWeapon(theCop) == 3 then
					if getElementDimension(source) == 1 then
						exports.NGCdxmsg:createNewDxMessage( theCop, "Don't arrest robbers but kill them!", 225, 0, 0 )
						cancelEvent()
					end
				end
			end
		end
	end
end
)

function restartBanking()
	if isTimer(lox) then return false end
	lox = setTimer(function()
		local resx = getResourceFromName("AURcnr")
		restartResource(resx)
	end,60000*2,1)
end


---- functions of check


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


addCommandHandler("banktime",
function (thePlayer)
	local robType = "(Los Santos: "..eventType.." Event)"
	if (isTimer(bankrobStartTimer)) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(bankrobStartTimer)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, onCalculateBanktime(math.floor(timeLeft)).." until event get started "..robType, 230, 230, 0)
	elseif (isTimer(progressTimer)) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(progressTimer)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, onCalculateBanktime(math.floor(timeLeft)).." until mission get finished!", 230, 230, 0)
	else
		exports.NGCdxmsg:createNewDxMessage(thePlayer, robType.." is able to be robbed go to LS Bank!", 255, 230, 0)
	end
end)


local map = {

createObject(13007,1478.2000000,-974.2000100,1007.4000000,0.0000000,0.0000000,0.0000000), --object(sw_bankbits),(1),
createObject(14412,1463.0000000,-934.5000000,1010.6000000,0.0000000,0.0000000,90.0000000), --object(carter_drugfloor),(1),
createObject(14413,1470.2000000,-944.5999800,1007.3000000,0.0000000,0.0000000,270.0000000), --object(carter-column01),(1),
createObject(14415,1513.4004000,-968.5996100,1011.8000000,0.0000000,0.0000000,179.9950000), --object(carter-floors01),(1),
createObject(14592,1534.4004000,-975.7998000,1006.2000000,0.0000000,0.0000000,0.0000000), --object(mafcasloadbay02),(1),
createObject(3851,1472.5000000,-979.2000100,1008.0000000,0.0000000,0.0000000,90.0000000), --object(carshowwin_sfsx),(2),
createObject(3851,1483.8000000,-979.2000100,1008.0000000,0.0000000,0.0000000,90.0000000), --object(carshowwin_sfsx),(3),
createObject(1491,1502.5000000,-972.0000000,1005.6000000,0.0000000,0.0000000,359.7470000), --object(gen_doorint01),(3),
createObject(1491,1505.5996000,-972.0000000,1005.6000000,0.0000000,0.0000000,179.4950000), --object(gen_doorint01),(4),
createObject(14410,1545.3000000,-971.5000000,1002.4000000,0.0000000,0.0000000,180.2450000), --object(carter-stairs03),(2),
createObject(1566,1514.0996000,-973.5996100,1000.6000000,0.0000000,0.0000000,0.0000000), --object(cj_ws_door),(1),
createObject(1502,1543.2000000,-961.8449700,999.2999900,0.0000000,0.0000000,90.0000000), --object(gen_doorint04),(2),
createObject(3851,1486.2002000,-972.7002000,1007.6000000,0.0000000,0.0000000,270.7420000), --object(carshowwin_sfsx),(4),
createObject(3851,1480.5999800,-967.0999800,1007.5999800,0.0000000,0.0000000,179.9950000), --object(carshowwin_sfsx),(5),
createObject(1506,1485.9000000,-972.7000100,1005.4000000,0.0000000,0.0000000,0.0000000), --object(gen_doorext08),(1),
createObject(1536,1471.2000000,-982.2999900,1005.6000000,0.0000000,0.0000000,0.0000000), --object(gen_doorext15),(1),
createObject(2634,1505.0000000,-981.7999900,1007.1000000,0.0000000,0.0000000,0.0000000), --object(ab_vaultdoor),(1),
createObject(3440,1506.5000000,-981.7998000,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(1),
createObject(3440,1503.5996000,-981.7998000,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(2),
createObject(3440,1503.5996000,-981.7998000,1012.6000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(3),
createObject(3440,1506.5000000,-981.7999900,1012.6000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(4),
createObject(2395,1506.4000000,-981.5999800,1008.8000000,0.0000000,0.0000000,180.0000000), --object(cj_sports_wall),(1),
createObject(2395,1510.1000000,-981.5999800,1008.8000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall),(2),
createObject(2395,1513.8000000,-981.5999800,1008.8000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall),(3),
createObject(2395,1502.7000000,-981.5999800,1008.8000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall),(4),
createObject(2395,1499.0000000,-981.5999800,1008.8000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall),(5),
createObject(2395,1490.8000000,-977.7000100,1005.6000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall),(6),
createObject(2395,1513.5000000,-978.5999800,1008.8000000,0.0000000,0.0000000,270.0000000), --object(cj_sports_wall),(7),
createObject(2395,1513.5000000,-974.9000200,1008.8000000,0.0000000,0.0000000,270.0000000), --object(cj_sports_wall),(8),
createObject(2395,1513.5000000,-972.5999800,1008.8000000,0.0000000,0.0000000,270.0000000), --object(cj_sports_wall),(9),
createObject(2395,1495.5000000,-981.5999800,1008.8000000,0.0000000,0.0000000,90.0000000), --object(cj_sports_wall),(10),
createObject(2395,1495.5000000,-977.9000200,1008.8000000,0.0000000,0.0000000,90.0000000), --object(cj_sports_wall),(11),
createObject(2395,1495.5000000,-975.0999800,1008.8000000,0.0000000,0.0000000,90.0000000), --object(cj_sports_wall),(12),
createObject(3440,1508.8000000,-981.7999900,1008.8000000,0.0000000,90.0000000,0.0000000), --object(arptpillar01_lvs),(5),
createObject(3440,1513.4004000,-981.7998000,1008.8000000,0.0000000,90.0000000,0.0000000), --object(arptpillar01_lvs),(6),
createObject(3440,1501.2000000,-981.7999900,1008.8000000,0.0000000,90.0000000,0.0000000), --object(arptpillar01_lvs),(7),
createObject(3440,1496.6000000,-981.7999900,1008.8000000,0.0000000,90.0000000,0.0000000), --object(arptpillar01_lvs),(8),
createObject(3440,1504.8000000,-981.7999900,1008.8000000,0.0000000,90.0000000,0.0000000), --object(arptpillar01_lvs),(9),
createObject(3440,1513.6000000,-983.2999900,1008.8000000,0.0000000,90.0000000,90.0000000), --object(arptpillar01_lvs),(10),
createObject(3440,1513.6000000,-978.7999900,1008.8000000,0.0000000,90.0000000,90.0000000), --object(arptpillar01_lvs),(11),
createObject(3440,1513.6000000,-974.2999900,1008.8000000,0.0000000,90.0000000,90.0000000), --object(arptpillar01_lvs),(12),
createObject(3440,1495.5000000,-974.2999900,1008.8000000,0.0000000,90.0000000,90.0000000), --object(arptpillar01_lvs),(13),
createObject(3440,1495.5000000,-979.0000000,1008.8000000,0.0000000,90.0000000,90.0000000), --object(arptpillar01_lvs),(14),
createObject(3440,1495.5000000,-983.5999800,1008.8000000,0.0000000,90.0000000,90.0000000), --object(arptpillar01_lvs),(15),
createObject(2942,1458.4000000,-917.7000100,1001.9000000,0.0000000,0.0000000,0.0000000), --object(kmb_atm1),(6),
createObject(11245,1458.8000000,-928.5000000,1007.6000000,0.0000000,0.0000000,0.0000000), --object(sfsefirehseflag),(1),
createObject(11245,1458.8000000,-936.5999800,1007.8000000,0.0000000,0.0000000,0.0000000), --object(sfsefirehseflag),(2),
createObject(11245,1458.7000000,-944.5999800,1007.7000000,0.0000000,0.0000000,0.0000000), --object(sfsefirehseflag),(3),
createObject(11245,1468.0000000,-944.5000000,1007.8000000,0.0000000,0.0000000,177.9950000), --object(sfsefirehseflag),(4),
createObject(11245,1468.0000000,-936.5000000,1007.6000000,0.0000000,0.0000000,177.9900000), --object(sfsefirehseflag),(5),
createObject(11245,1468.1000000,-928.4000200,1007.8000000,0.0000000,0.0000000,177.9900000), --object(sfsefirehseflag),(6),
createObject(2368,1476.1000000,-954.7999900,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1),(4),
createObject(1736,1510.9000000,-955.2000100,1007.6000000,0.0000000,0.0000000,0.0000000), --object(cj_stags_head),(2),
createObject(14527,1504.2000000,-959.0999800,1009.0000000,0.0000000,0.0000000,0.0000000), --object(fannyfan),(1),
createObject(13525,1497.2000000,-950.5999800,1009.2000000,0.0000000,0.0000000,0.0000000), --object(cunteground17a),(1),
createObject(1486,1496.8000000,-961.9000200,1006.4000000,0.0000000,0.0000000,0.0000000), --object(dyn_beer_1),(1),
createObject(1544,1496.8000000,-960.5999800,1006.2000000,0.0000000,0.0000000,0.0000000), --object(cj_beer_b_1),(1),
createObject(1543,1496.8000000,-959.5000000,1006.2000000,0.0000000,0.0000000,0.0000000), --object(cj_beer_b_2),(1),
createObject(1486,1496.8000000,-961.0000000,1006.4000000,0.0000000,0.0000000,0.0000000), --object(dyn_beer_1),(2),
createObject(1455,1496.8000000,-961.2000100,1006.3000000,0.0000000,0.0000000,0.0000000), --object(dyn_glass),(1),
createObject(1544,1496.8000000,-961.4000200,1006.2000000,0.0000000,0.0000000,0.0000000), --object(cj_beer_b_1),(2),
createObject(1543,1496.8000000,-960.4000200,1006.2000000,0.0000000,0.0000000,0.0000000), --object(cj_beer_b_2),(2),
createObject(1517,1496.8000000,-960.2000100,1006.4000000,0.0000000,0.0000000,0.0000000), --object(dyn_wine_break),(1),
createObject(1546,1496.8000000,-961.5999800,1006.3000000,0.0000000,0.0000000,0.0000000), --object(cj_pint_glass),(1),
createObject(1543,1496.8000000,-961.7999900,1006.2000000,0.0000000,0.0000000,0.0000000), --object(cj_beer_b_2),(3),
createObject(1544,1496.8000000,-959.7000100,1006.2000000,0.0000000,0.0000000,0.0000000), --object(cj_beer_b_1),(3),
createObject(2008,1529.8000000,-963.4000200,1005.6000000,0.0000000,0.0000000,90.0000000), --object(officedesk1),(1),
createObject(1999,1529.8000000,-961.5000000,1005.6000000,0.0000000,0.0000000,0.0000000), --object(officedesk2),(1),
createObject(2009,1531.8000000,-961.4000200,1005.6000000,0.0000000,0.0000000,0.0000000), --object(officedesk2l),(1),
createObject(1998,1532.9000000,-959.5000000,1005.6000000,0.0000000,0.0000000,0.0000000), --object(officedesk1l),(1),
createObject(2165,1528.5000000,-955.2999900,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office_desk_1),(1),
createObject(2166,1523.1000000,-963.4000200,1005.6000000,0.0000000,0.0000000,89.7500000), --object(med_office_desk_2),(1),
createObject(2173,1534.8000000,-958.5000000,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office_desk_3),(1),
createObject(2174,1530.5000000,-955.4000200,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office4_desk_2),(1),
createObject(2181,1532.5000000,-955.4000200,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office5_desk_2),(1),
createObject(2206,1525.5000000,-961.5999800,1005.6000000,0.0000000,0.0000000,270.2500000), --object(med_office8_desk_02),(1),
createObject(2206,1525.5000000,-959.5999800,1005.6000000,0.0000000,0.0000000,270.2470000), --object(med_office8_desk_02),(2),
createObject(2206,1523.6000000,-959.5999800,1005.6000000,0.0000000,0.0000000,0.2470000), --object(med_office8_desk_02),(3),
createObject(2886,1503.6000000,-981.5000000,1007.4000000,0.0000000,0.0000000,178.9950000), --object(sec_keypad),(1),
createObject(2356,1524.4000000,-960.7000100,1005.6000000,0.0000000,0.0000000,318.0000000), --object(police_off_chair),(1),
createObject(2356,1524.7000000,-962.5999800,1005.6000000,0.0000000,0.0000000,285.9990000), --object(police_off_chair),(2),
createObject(2356,1530.4000000,-962.7999900,1005.6000000,0.0000000,0.0000000,45.9960000), --object(police_off_chair),(3),
createObject(2356,1532.7000000,-961.2000100,1005.6000000,0.0000000,0.0000000,45.9940000), --object(police_off_chair),(4),
createObject(2356,1533.8000000,-959.5000000,1005.6000000,0.0000000,0.0000000,45.9940000), --object(police_off_chair),(5),
createObject(2356,1535.3000000,-959.2000100,1005.6000000,0.0000000,0.0000000,23.9940000), --object(police_off_chair),(6),
createObject(2356,1533.1000000,-956.2000100,1005.6000000,0.0000000,0.0000000,12.7440000), --object(police_off_chair),(7),
createObject(2356,1531.3000000,-956.2000100,1005.6000000,0.0000000,0.0000000,12.7440000), --object(police_off_chair),(8),
createObject(2356,1529.5000000,-956.0999800,1005.6000000,0.0000000,0.0000000,357.9940000), --object(police_off_chair),(9),
createObject(2172,1524.8000000,-979.7000100,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office2_desk_1),(1),
createObject(2172,1526.7000000,-979.7000100,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office2_desk_1),(2),
createObject(2172,1528.7000000,-979.5999800,1005.6000000,0.0000000,0.0000000,90.0000000), --object(med_office2_desk_1),(3),
createObject(2172,1528.7000000,-977.7000100,1005.6000000,0.0000000,0.0000000,90.0000000), --object(med_office2_desk_1),(4),
createObject(2172,1527.7000000,-976.5999800,1005.6000000,0.0000000,0.0000000,180.0000000), --object(med_office2_desk_1),(5),
createObject(2172,1525.8000000,-976.5999800,1005.6000000,0.0000000,0.0000000,179.9950000), --object(med_office2_desk_1),(6),
createObject(2172,1523.8000000,-976.7000100,1005.6000000,0.0000000,0.0000000,269.9950000), --object(med_office2_desk_1),(7),
createObject(2172,1523.8000000,-978.5999800,1005.6000000,0.0000000,0.0000000,270.7420000), --object(med_office2_desk_1),(8),
createObject(2183,1524.8000000,-978.7999900,1006.3000000,0.0000000,0.0000000,0.0000000), --object(med_office3_desk_09),(1),
createObject(2690,1506.4004000,-971.6699800,1006.9000000,0.0000000,0.0000000,180.0000000), --object(cj_fire_ext),(1),
createObject(2183,1525.3000000,-972.2000100,1005.6000000,0.0000000,0.0000000,359.5000000), --object(med_office3_desk_09),(2),
createObject(2205,1525.5000000,-964.5999800,1005.5000000,0.0000000,0.0000000,270.0000000), --object(med_office8_desk_1),(1),
createObject(2205,1525.5000000,-966.7999900,1005.5000000,0.0000000,0.0000000,269.9950000), --object(med_office8_desk_1),(2),
createObject(2205,1525.5000000,-968.9000200,1005.5000000,0.0000000,0.0000000,269.4950000), --object(med_office8_desk_1),(3),
createObject(2205,1528.3000000,-972.2999900,1005.5000000,0.0000000,0.0000000,269.4950000), --object(med_office8_desk_1),(4),
createObject(2205,1528.3000000,-973.7000100,1005.5000000,0.0000000,0.0000000,180.2450000), --object(med_office8_desk_1),(5),
createObject(2205,1526.1000000,-973.7000100,1005.5000000,0.0000000,0.0000000,179.9920000), --object(med_office8_desk_1),(6),
createObject(2205,1523.9000000,-973.7000100,1005.5000000,0.0000000,0.0000000,179.9890000), --object(med_office8_desk_1),(7),
createObject(2205,1523.1000000,-973.7000100,1005.5000000,0.0000000,0.0000000,179.9890000), --object(med_office8_desk_1),(8),
createObject(2356,1524.4000000,-965.5999800,1005.6000000,0.0000000,0.0000000,271.9900000), --object(police_off_chair),(10),
createObject(2356,1524.5000000,-967.5000000,1005.6000000,0.0000000,0.0000000,271.9890000), --object(police_off_chair),(11),
createObject(2356,1524.5000000,-969.5000000,1005.6000000,0.0000000,0.0000000,271.9890000), --object(police_off_chair),(12),
createObject(2356,1527.2998000,-972.9003900,1005.6000000,0.0000000,0.0000000,271.9890000), --object(police_off_chair),(13),
createObject(2356,1525.5000000,-972.5999800,1005.6000000,0.0000000,0.0000000,323.9890000), --object(police_off_chair),(14),
createObject(2356,1523.0000000,-972.9000200,1005.6000000,0.0000000,0.0000000,217.9870000), --object(police_off_chair),(15),
createObject(2605,1522.6000000,-964.7000100,1006.0000000,0.0000000,0.0000000,0.0000000), --object(polce_desk1),(1),
createObject(3440,1513.2000000,-982.3200100,1006.9000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(24),
createObject(1569,1502.6000000,-963.7000100,1005.6000000,0.0000000,0.0000000,0.0000000), --object(adam_v_door),(1),
createObject(1569,1505.6000000,-963.7000100,1005.6000000,0.0000000,0.0000000,180.0000000), --object(adam_v_door),(2),
createObject(3440,1526.4000000,-964.0999800,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(27),
createObject(3440,1526.4000000,-964.0999800,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(28),
createObject(3440,1529.2000000,-964.0999800,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(29),
createObject(3440,1529.2000000,-964.0999800,1012.6000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(30),
createObject(3440,1533.9004000,-974.9003900,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(31),
createObject(3440,1533.9000000,-974.9000200,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(32),
createObject(3440,1533.9000000,-977.7000100,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(33),
createObject(3440,1533.9000000,-977.7000100,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(34),
createObject(3440,1542.9000000,-977.9000200,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(35),
createObject(3440,1542.9000000,-977.9000200,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(36),
createObject(3440,1542.9000000,-974.7000100,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(37),
createObject(3440,1542.9000000,-974.7000100,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(38),
createObject(3440,1521.5000000,-955.9000200,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(39),
createObject(3440,1521.5000000,-955.9000200,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(40),
createObject(3440,1521.5000000,-958.9000200,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(41),
createObject(3440,1521.5000000,-958.9000200,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(42),
createObject(3850,1506.5000000,-979.9000200,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(40),
createObject(3850,1503.5996000,-979.9003900,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(41),
createObject(3850,1500.4004000,-979.9003900,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(42),
createObject(3440,1500.3000000,-981.7999900,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(43),
createObject(3440,1500.3000000,-981.7999900,1012.5000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(44),
createObject(2634,1498.8000000,-981.7999900,1007.1000000,0.0000000,0.0000000,0.0000000), --object(ab_vaultdoor),(2),
createObject(3440,1497.2000000,-981.7999900,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(45),
createObject(3440,1497.2000000,-981.7999900,1012.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(46),
createObject(3850,1497.2000000,-979.7000100,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(43),
createObject(2526,1543.7000000,-980.5600000,1005.6000000,0.0000000,0.0000000,270.0000000), --object(cj_bath4),(1),
createObject(1523,1545.4000000,-978.5000000,1005.6000000,0.0000000,0.0000000,0.0000000), --object(gen_doorext10),(1),
createObject(1714,1480.8000000,-979.7999900,1005.8000000,0.0000000,0.0000000,182.0000000), --object(kb_swivelchair1),(1),
createObject(1714,1471.3000000,-979.7999900,1005.8000000,0.0000000,0.0000000,168.0000000), --object(kb_swivelchair1),(2),
createObject(2528,1546.9000000,-981.7999900,1005.6000000,0.0000000,0.0000000,180.0000000), --object(cj_toilet3),(1),
createObject(2518,1544.5000000,-979.4000200,1005.6000000,0.0000000,0.0000000,0.0000000), --object(cj_b_sink2),(1),
createObject(3440,1492.1000000,-972.0999800,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(47),
createObject(3440,1492.1000000,-972.0999800,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(48),
createObject(2332,1498.5996000,-972.4003900,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(1),
createObject(3440,1494.2000000,-972.0999800,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(49),
createObject(3440,1494.2000000,-972.0999800,1012.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(50),
createObject(3440,1509.3000000,-981.7999900,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(53),
createObject(3440,1509.3000000,-981.7999900,1012.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(54),
createObject(3440,1512.1000000,-981.7999900,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(55),
createObject(2713,1546.4000000,-982.2000100,1005.8000000,0.0000000,0.0000000,0.0000000), --object(cj_bucket),(1),
createObject(3440,1512.1000000,-981.7999900,1012.3000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(56),
createObject(2634,1510.7000000,-981.7999900,1007.1000000,0.0000000,0.0000000,0.0000000), --object(ab_vaultdoor),(3),
createObject(3850,1509.3000000,-979.7999900,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(44),
createObject(3850,1512.0000000,-979.7000100,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(45),
createObject(2886,1509.3000000,-981.5000000,1007.4000000,0.0000000,0.0000000,178.9890000), --object(sec_keypad),(2),
createObject(2886,1497.2000000,-981.5000000,1007.4000000,0.0000000,0.0000000,175.9890000), --object(sec_keypad),(3),
createObject(1502,1543.1500000,-958.8100000,999.2999900,0.0000000,0.0000000,270.0000000), --object(gen_doorint04),(4),
createObject(3440,1543.2000000,-958.5999800,1001.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(57),
createObject(3440,1543.2000000,-962.0999800,1001.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(58),
createObject(2332,1499.5000000,-972.4003900,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(2),
createObject(2332,1500.4004000,-972.4003900,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(3),
createObject(2332,1501.2998000,-972.4003900,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(4),
createObject(2332,1507.5000000,-972.4003900,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(6),
createObject(2332,1508.4004000,-972.4003900,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(7),
createObject(2332,1509.2998000,-972.4003900,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(8),
createObject(3440,1502.3000000,-971.7999900,1007.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(59),
createObject(2332,1510.2000000,-972.4000200,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(9),
createObject(1977,1475.1000000,-966.4000200,1006.1000000,0.0000000,0.0000000,0.0000000), --object(vendin3),(1),
createObject(3440,1505.8000000,-971.7999900,1007.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(60),
createObject(3440,1502.3000000,-972.5000000,1007.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(61),
createObject(3440,1505.9004000,-972.2998000,1007.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(62),
createObject(3440,1502.2998000,-964.0000000,1007.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(63),
createObject(1550,1508.5000000,-981.9000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(cj_money_bag),(7),
createObject(3440,1505.9000000,-963.9000200,1007.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(64),
createObject(3440,1502.3000000,-972.5000000,1011.3000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(65),
createObject(3440,1505.9000000,-972.2999900,1011.5000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(66),
createObject(3440,1505.8000000,-971.7999900,1011.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(67),
createObject(3440,1502.3000000,-971.7999900,1011.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(68),
createObject(3440,1505.9000000,-963.9000200,1011.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(69),
createObject(3440,1502.3000000,-964.0000000,1011.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(70),
createObject(1361,1470.1000000,-975.0999800,1006.4000000,0.0000000,0.0000000,0.0000000), --object(cj_bush_prop2),(1),
createObject(1714,1476.6000000,-969.7000100,1005.6000000,0.0000000,0.0000000,300.4980000), --object(kb_swivelchair1),(5),
createObject(2173,1507.4000000,-982.0000000,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office_desk_3),(2),
createObject(1550,1507.2000000,-981.9000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(cj_money_bag),(8),
createObject(1550,1507.8000000,-981.9000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(cj_money_bag),(9),
createObject(2173,1501.4000000,-982.0000000,1005.6000000,0.0000000,0.0000000,0.0000000), --object(med_office_desk_3),(3),
createObject(1550,1502.5000000,-981.9000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(cj_money_bag),(10),
createObject(1550,1501.9000000,-981.9000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(cj_money_bag),(11),
createObject(1550,1501.3000000,-981.9000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(cj_money_bag),(12),
createObject(1714,1476.6000000,-973.2000100,1005.6000000,0.0000000,0.0000000,316.0000000), --object(kb_swivelchair1),(6),
createObject(1714,1474.7000000,-979.7999900,1005.8000000,0.0000000,0.0000000,191.2480000), --object(kb_swivelchair1),(7),
createObject(1714,1477.6000000,-979.7999900,1005.8000000,0.0000000,0.0000000,191.2450000), --object(kb_swivelchair1),(8),
createObject(3440,1543.2000000,-962.0999800,1006.3000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(71),
createObject(3440,1543.2000000,-958.5999800,1006.4000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(72),
createObject(1508,1459.0996000,-910.5996100,1002.9000000,0.0000000,0.0000000,270.0000000), --object(dyn_garage_door),(2),
createObject(3440,1543.2000000,-962.0999800,1011.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(73),
createObject(3440,1524.3000000,-957.0999800,1001.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(74),
createObject(3440,1524.3000000,-963.4000200,1001.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(75),
createObject(3440,1472.7000000,-965.7000100,1007.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs),(79),
createObject(1704,1454.5000000,-958.2999900,1005.4000000,0.0000000,0.0000000,0.0000000), --object(kb_chair03),(1),
createObject(1703,1453.2000000,-961.5999800,1005.4000000,0.0000000,0.0000000,90.2530000), --object(kb_couch02),(1),
createObject(1703,1456.0000000,-965.2000100,1005.4000000,0.0000000,0.0000000,180.0000000), --object(kb_couch02),(2),
createObject(1704,1459.5000000,-958.2999900,1005.4000000,0.0000000,0.0000000,0.0000000), --object(kb_chair03),(2),
createObject(1704,1464.7000000,-958.2999900,1005.4000000,0.0000000,0.0000000,0.0000000), --object(kb_chair03),(3),
createObject(1703,1456.6000000,-958.2999900,1005.4000000,0.0000000,0.0000000,0.2580000), --object(kb_couch02),(5),
createObject(1703,1461.4000000,-958.2999900,1005.4000000,0.0000000,0.0000000,0.2580000), --object(kb_couch02),(7),
createObject(1703,1466.7000000,-959.5999800,1005.4000000,0.0000000,0.0000000,270.0050000), --object(kb_couch02),(11),
createObject(1703,1465.9000000,-965.2000100,1005.4000000,0.0000000,0.0000000,180.0000000), --object(kb_couch02),(12),
createObject(3850,1505.8000000,-970.5000000,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(46),
createObject(3850,1502.3000000,-970.4000200,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(47),
createObject(1557,1449.5000000,-957.5999800,1005.4000000,0.0000000,0.0000000,0.0000000), --object(gen_doorext19),(1),
createObject(1557,1452.5000000,-957.5999800,1005.4000000,0.0000000,0.0000000,180.0000000), --object(gen_doorext19),(2),
createObject(3850,1526.5000000,-965.9000200,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(52),
createObject(3850,1526.5000000,-968.7000100,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(53),
createObject(3850,1528.9000000,-972.5000000,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(55),
createObject(3850,1527.1000000,-974.2999900,1006.2000000,0.0000000,0.0000000,270.2500000), --object(carshowbann_sfsx),(56),
createObject(3850,1523.5000000,-974.2999900,1006.2000000,0.0000000,0.0000000,270.2470000), --object(carshowbann_sfsx),(57),
createObject(3850,1529.2000000,-965.7000100,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(58),
createObject(3850,1530.1000000,-968.9000200,1006.2000000,0.0000000,0.0000000,31.0000000), --object(carshowbann_sfsx),(59),
createObject(3850,1532.4000000,-971.4000200,1006.2000000,0.0000000,0.0000000,54.2480000), --object(carshowbann_sfsx),(60),
createObject(3850,1532.4000000,-978.7000100,1006.2000000,0.0000000,0.0000000,270.2470000), --object(carshowbann_sfsx),(62),
createObject(3850,1530.7000000,-980.5000000,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(63),
createObject(3850,1530.7000000,-983.9000200,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(64),
createObject(2356,1527.2000000,-976.0000000,1005.6000000,0.0000000,0.0000000,183.9890000), --object(police_off_chair),(16),
createObject(2356,1525.2000000,-976.0999800,1005.6000000,0.0000000,0.0000000,184.9880000), --object(police_off_chair),(17),
createObject(2356,1523.2000000,-977.2999900,1005.6000000,0.0000000,0.0000000,262.9880000), --object(police_off_chair),(18),
createObject(2356,1523.3000000,-979.4000200,1005.6000000,0.0000000,0.0000000,282.9850000), --object(police_off_chair),(19),
createObject(2356,1525.2000000,-980.2999900,1005.6000000,0.0000000,0.0000000,10.9800000), --object(police_off_chair),(20),
createObject(2356,1527.2000000,-980.2000100,1005.6000000,0.0000000,0.0000000,356.9750000), --object(police_off_chair),(21),
createObject(2356,1529.2000000,-978.9000200,1005.6000000,0.0000000,0.0000000,84.9730000), --object(police_off_chair),(22),
createObject(2356,1529.2000000,-977.0999800,1005.6000000,0.0000000,0.0000000,84.9680000), --object(police_off_chair),(23),
createObject(3850,1526.2002000,-960.5996100,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(66),
createObject(3850,1524.5000000,-958.9000200,1006.2000000,0.0000000,0.0000000,270.2470000), --object(carshowbann_sfsx),(67),
createObject(3850,1526.2002000,-962.2998000,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(68),
createObject(3850,1523.0000000,-956.0000000,1006.2000000,0.0000000,0.0000000,270.2470000), --object(carshowbann_sfsx),(69),
createObject(3850,1525.9000000,-956.0000000,1006.2000000,0.0000000,0.0000000,270.2470000), --object(carshowbann_sfsx),(70),
createObject(3850,1527.7000000,-954.2999900,1006.2000000,0.0000000,0.0000000,0.0000000), --object(carshowbann_sfsx),(71),
createObject(2332,1498.6000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(5),
createObject(2332,1499.5000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(10),
createObject(2332,1500.4000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(11),
createObject(2332,1501.3000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(12),
createObject(2332,1498.6000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(13),
createObject(2332,1499.5000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(14),
createObject(2332,1500.4000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(15),
createObject(2332,1501.3000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(16),
createObject(2332,1497.7000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(17),
createObject(2332,1497.7000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(18),
createObject(2332,1497.7000000,-972.4000200,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(20),
createObject(2332,1496.8000000,-972.4000200,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(21),
createObject(2332,1496.8000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(22),
createObject(2332,1496.8000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(23),
createObject(2332,1507.5000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(24),
createObject(2332,1507.5000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(25),
createObject(2332,1508.4000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(26),
createObject(2332,1508.4000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(27),
createObject(2332,1509.3000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(28),
createObject(2332,1509.3000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(29),
createObject(2332,1510.2000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(30),
createObject(2332,1510.2000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(31),
createObject(2332,1511.1000000,-972.4000200,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(32),
createObject(2332,1511.1000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(33),
createObject(2332,1511.1000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(34),
createObject(2332,1512.0000000,-972.4000200,1007.6000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(35),
createObject(2332,1512.0000000,-972.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(36),
createObject(2332,1512.0000000,-972.4000200,1006.0000000,0.0000000,0.0000000,0.0000000), --object(kev_safe),(37),
createObject(3850,1541.4000000,-963.2999900,999.7999900,0.0000000,0.0000000,269.9970000), --object(carshowbann_sfsx),(80),
createObject(3850,1538.0000000,-963.2999900,999.7999900,0.0000000,0.0000000,270.2470000), --object(carshowbann_sfsx),(81),
createObject(3850,1534.6000000,-963.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(83),
createObject(3850,1531.2000000,-963.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(84),
createObject(3850,1527.8000000,-963.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(85),
createObject(3850,1525.8000000,-963.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(86),
createObject(3850,1541.4000000,-957.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(87),
createObject(3850,1538.0000000,-957.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(88),
createObject(3850,1534.6000000,-957.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(89),
createObject(3850,1531.2000000,-957.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(90),
createObject(3850,1527.8000000,-957.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(91),
createObject(3850,1526.0000000,-957.2999900,999.7999900,0.0000000,0.0000000,269.9950000), --object(carshowbann_sfsx),(92),
createObject(3851,1543.0996000,-960.2998000,1003.8000000,0.0000000,0.0000000,0.0000000), --object(carshowwin_sfsx),(1),
createObject(3851,1543.1000000,-956.5000000,996.2000100,90.0000000,0.0000000,0.0000000), --object(carshowwin_sfsx),(6),
createObject(3851,1543.1000000,-964.0999800,996.2000100,90.0000000,0.0000000,0.0000000), --object(carshowwin_sfsx),(7),
createObject(13028,1505.2000000,-954.7999900,1001.2000000,0.0000000,0.0000000,0.0000000), --object(ce_spraydoor1),(1),
createObject(13028,1505.2000000,-961.2000100,1001.2000000,0.0000000,0.0000000,0.0000000), --object(ce_spraydoor1),(2),
createObject(13028,1505.2000000,-967.5000000,1001.2000000,0.0000000,0.0000000,0.0000000), --object(ce_spraydoor1),(3),
createObject(3578,1509.1000000,-964.9000200,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(13),
createObject(3578,1509.1000000,-963.7000100,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(14),
createObject(3578,1509.1000000,-958.5999800,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(15),
createObject(3578,1509.1000000,-957.2999900,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(16),
createObject(3578,1509.0000000,-952.2000100,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(17),
createObject(3578,1509.0000000,-951.2000100,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(18),
createObject(3578,1509.1000000,-970.0000000,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(19),
createObject(3578,1509.1000000,-971.0999800,998.5000000,0.0000000,0.0000000,1.0000000), --object(dockbarr1_la),(20),
createObject(9339,1449.6999500,-944.5000000,1005.2999900,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (1),
createObject(9339,1451.1000000,-944.5000000,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (2),
createObject(9339,1452.5000000,-944.5000000,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (3),
createObject(9339,1453.9000000,-944.5000000,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (4),
createObject(9339,1455.3000000,-944.5000000,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (5),
createObject(9339,1449.7000000,-918.4000200,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (6),
createObject(9339,1451.1000000,-918.4000200,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (7),
createObject(9339,1452.5000000,-918.4000200,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (8),
createObject(9339,1453.9000000,-918.4000200,1005.3000000,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (9),
createObject(9339,1455.3000500,-918.4000200,1005.2999900,0.0000000,90.0000000,0.0000000), --object(sfnvilla001_cm), (10),
createObject(9339,1469.0000000,-917.9000200,1005.3000000,0.0000000,90.0000000,270.0000000), --object(sfnvilla001_cm), (11),
createObject(9339,1469.0000000,-919.2999900,1005.3000000,0.0000000,90.0000000,270.0000000), --object(sfnvilla001_cm), (12),
createObject(9339,1469.0000000,-920.7000100,1005.3000000,0.0000000,90.0000000,270.0000000), --object(sfnvilla001_cm), (13),
createObject(9339,1475.8000000,-944.7000100,1005.3000000,0.0000000,90.0000000,180.0000000), --object(sfnvilla001_cm), (14),
createObject(9339,1474.4000000,-944.7000100,1005.3000000,0.0000000,90.0000000,179.9950000), --object(sfnvilla001_cm), (15),
createObject(9339,1473.0000000,-944.7000100,1005.3000000,0.0000000,90.0000000,179.9950000), --object(sfnvilla001_cm), (16),
createObject(9339,1471.6000000,-944.7000100,1005.3000000,0.0000000,90.0000000,179.9950000), --object(sfnvilla001_cm), (17),
createObject(9339,1475.8000000,-918.5999800,1005.3000000,0.0000000,90.0000000,179.9950000), --object(sfnvilla001_cm), (18),
createObject(9339,1474.4000000,-918.5999800,1005.3000000,0.0000000,90.0000000,179.9950000), --object(sfnvilla001_cm), (19),
createObject(9339,1473.0000000,-918.5999800,1005.3000000,0.0000000,90.0000000,179.9950000), --object(sfnvilla001_cm), (20),
createObject(9339,1471.6000000,-918.5999800,1005.3000000,0.0000000,90.0000000,179.9950000), --object(sfnvilla001_cm), (21),
createObject(9339,1455.8700000,-939.7999900,1004.7333000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (22),
createObject(9339,1455.9000000,-939.7999900,1001.9000000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (23),
createObject(9339,1455.9000000,-913.7000100,1001.9000000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (24),
createObject(9339,1455.8700000,-913.7000100,1004.7333000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (25),
createObject(1649,1455.9004000,-952.2002000,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (1),
createObject(1649,1455.9004000,-946.0996100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (2),
createObject(1649,1455.9004000,-942.5996100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (3),
createObject(1649,1455.9004000,-936.5996100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (4),
createObject(1649,1455.9004000,-930.5996100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (5),
createObject(1649,1455.9004000,-925.7002000,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (6),
createObject(1649,1455.9000000,-919.4000200,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (7),
createObject(9339,1471.0344000,-944.2999900,1004.7345000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (26),
createObject(9339,1471.0344000,-918.2000100,1004.7345000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (27),
createObject(9339,1471.0000000,-918.2000100,1001.9000000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (28),
createObject(9339,1471.0000000,-944.2999900,1001.9000000,0.0000000,0.0000000,0.0000000), --object(sfnvilla001_cm), (29),
createObject(14409,1457.8300000,-955.2000100,1002.2500000,0.0000000,0.0000000,270.0000000), --object(carter-stairs02), (1),
createObject(9339,1449.7000000,-952.9000200,1001.9600000,0.0000000,0.0000000,90.0000000), --object(sfnvilla001_cm), (30),
createObject(9339,1449.7000000,-953.2000100,1001.9600000,0.0000000,0.0000000,90.0000000), --object(sfnvilla001_cm), (31),
createObject(9339,1449.7000000,-952.9000200,1003.3400000,0.0000000,0.0000000,90.0000000), --object(sfnvilla001_cm), (32),
createObject(9339,1449.7000000,-953.2000100,1003.3400000,0.0000000,0.0000000,90.0000000), --object(sfnvilla001_cm), (33),
createObject(9339,1449.7000000,-952.9000200,1004.7333000,0.0000000,0.0000000,90.0000000), --object(sfnvilla001_cm), (34),
createObject(9339,1449.7000000,-953.2000100,1004.7333000,0.0000000,0.0000000,90.0000000), --object(sfnvilla001_cm), (35),
createObject(8661,1458.7002000,-947.2998000,1009.5000000,0.0000000,0.0000000,0.0000000), --object(gnhtelgrnd_lvs), (1),
createObject(8661,1458.7000000,-927.4000200,1009.5000000,0.0000000,0.0000000,0.0000000), --object(gnhtelgrnd_lvs), (2),
createObject(3851,1466.5000000,-957.5000000,1007.7000000,0.0000000,0.0000000,90.0000000), --object(carshowwin_sfsx), (1),
createObject(3851,1455.2000000,-957.5000000,1007.6000000,0.0000000,0.0000000,90.0000000), --object(carshowwin_sfsx), (2),
createObject(8661,1458.7998000,-967.4003900,1009.5000000,0.0000000,0.0000000,0.0000000), --object(gnhtelgrnd_lvs), (3),
createObject(1649,1470.9000000,-919.4000200,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (9),
createObject(8661,1462.3000000,-917.2999900,995.0999800,90.0000000,90.0000000,90.0000000), --object(gnhtelgrnd_lvs), (4),
createObject(1649,1470.9000000,-925.7999900,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (10),
createObject(1649,1470.9000000,-930.5999800,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (11),
createObject(1649,1470.9000000,-936.7000100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (12),
createObject(1649,1470.9000000,-942.7000100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (13),
createObject(1649,1470.9000000,-946.2000100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (14),
createObject(1649,1470.9000000,-952.2000100,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (15),
createObject(1649,1470.9000000,-958.4000200,1003.0000000,0.0000000,0.0000000,90.0000000), --object(wglasssmash), (16),
createObject(2942,1459.3000000,-917.7000100,1001.9000000,0.0000000,0.0000000,0.0000000), --object(kmb_atm1), (1),
createObject(2942,1468.8000000,-917.7000100,1001.9000000,0.0000000,0.0000000,0.0000000), --object(kmb_atm1), (3),
createObject(2942,1467.9000000,-917.7000100,1001.9000000,0.0000000,0.0000000,0.0000000), --object(kmb_atm1), (4),
createObject(2368,1476.1000000,-952.0000000,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (1),
createObject(2368,1476.1000000,-949.2000100,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (2),
createObject(2368,1476.1000000,-946.4000200,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (3),
createObject(2368,1476.1000000,-943.5999800,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (4),
createObject(2368,1476.1000000,-940.7999900,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (5),
createObject(2368,1476.1000000,-938.0000000,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (6),
createObject(2368,1476.1000000,-935.2000100,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (7),
createObject(2368,1476.1000000,-932.4000200,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (8),
createObject(2368,1476.1000000,-929.5999800,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (9),
createObject(2368,1476.1000000,-926.7999900,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (10),
createObject(2368,1476.0996000,-924.0000000,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (11),
createObject(2808,1463.1000000,-944.2999900,1001.9000000,0.0000000,0.0000000,90.0000000), --object(cj_pizza_chair4), (1),
createObject(2808,1463.1000000,-942.2000100,1001.9000000,0.0000000,0.0000000,90.0000000), --object(cj_pizza_chair4), (2),
createObject(2808,1463.9900000,-942.1740100,1001.9000000,0.0000000,0.0000000,270.0000000), --object(cj_pizza_chair4), (3),
createObject(2808,1463.9900000,-944.2730100,1001.9000000,0.0000000,0.0000000,270.0000000), --object(cj_pizza_chair4), (4),
createObject(2808,1463.1000000,-936.7000100,1001.9000000,0.0000000,0.0000000,90.0000000), --object(cj_pizza_chair4), (5),
createObject(2808,1463.1000000,-934.5999800,1001.9000000,0.0000000,0.0000000,90.0000000), --object(cj_pizza_chair4), (6),
createObject(2808,1463.9900000,-936.6729700,1001.9000000,0.0000000,0.0000000,270.0000000), --object(cj_pizza_chair4), (7),
createObject(2808,1463.9900000,-934.5739700,1001.9000000,0.0000000,0.0000000,270.0000000), --object(cj_pizza_chair4), (8),
createObject(994,1456.2000000,-953.0600000,1005.4000000,0.0000000,0.0000000,0.0000000), --object(lhouse_barrier2), (1),
createObject(8673,1456.0000000,-942.5000000,1006.8000000,0.0000000,0.0000000,90.0000000), --object(csrsfence03_lvs), (1),
createObject(8673,1456.0000000,-931.4000200,1006.7999900,0.0000000,0.0000000,90.0000000), --object(csrsfence03_lvs), (2),
createObject(8673,1470.9000000,-946.7999900,1006.8000000,0.0000000,0.0000000,90.0000000), --object(csrsfence03_lvs), (4),
createObject(8673,1470.9000000,-931.4000200,1006.8000000,0.0000000,0.0000000,90.0000000), --object(csrsfence03_lvs), (5),
createObject(8674,1461.2000000,-921.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(csrsfence02_lvs), (1),
createObject(8674,1465.7000000,-921.4000200,1006.8000000,0.0000000,0.0000000,0.0000000), --object(csrsfence02_lvs), (2),
createObject(1314,1462.2000000,-952.7000100,1004.9000000,0.0000000,0.0000000,0.0000000), --object(twoplayer), (1),
createObject(632,1464.4000000,-933.0000000,1001.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb7), (1),
createObject(632,1464.4000000,-945.7999900,1001.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb7), (2),
createObject(628,1468.5000000,-928.5000000,1003.3000000,0.0000000,0.0000000,45.2490000), --object(veg_palmkb4), (1),
createObject(628,1468.5996000,-944.5996100,1003.3000000,0.0000000,0.0000000,52.4980000), --object(veg_palmkb4), (2),
createObject(628,1458.2998000,-944.5000000,1003.3000000,0.0000000,0.0000000,321.4960000), --object(veg_palmkb4), (3),
createObject(628,1458.5000000,-928.5996100,1003.3000000,0.0000000,0.0000000,39.4960000), --object(veg_palmkb4), (4),
createObject(627,1457.1000000,-951.7000100,1003.1000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb3), (1),
createObject(627,1470.2000000,-956.5000000,1003.1000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb3), (2),
createObject(627,1470.2000000,-917.9000200,1003.1000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb3), (3),
createObject(627,1456.8000000,-918.0999800,1003.1000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb3), (4),
createObject(2208,1464.0000000,-940.7600100,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office7_unit_1), (1),
createObject(2208,1463.1000000,-940.7600100,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office7_unit_1), (2),
createObject(16378,1474.6000000,-919.5000000,1002.0000000,0.0000000,0.0000000,90.0000000), --object(des_byofficeint), (1),
createObject(2165,1471.7000000,-923.0999800,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_desk_1), (1),
createObject(2165,1471.7000000,-934.0000000,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_desk_1), (2),
createObject(2165,1471.7000000,-940.2999900,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_desk_1), (3),
createObject(2165,1471.7000000,-955.7999900,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_desk_1), (4),
createObject(2165,1471.7000000,-949.7999900,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_desk_1), (5),
createObject(2368,1476.1000000,-923.0000000,1001.3000000,0.0000000,0.0000000,270.0000000), --object(shop_counter_1), (15),
createObject(2198,1455.2000000,-922.0000000,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office2_desk_3), (1),
createObject(2198,1455.2000000,-933.0000000,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office2_desk_3), (2),
createObject(2198,1455.2000000,-939.0999800,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office2_desk_3), (3),
createObject(2198,1455.2000000,-948.5999800,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office2_desk_3), (4),
createObject(2308,1449.6000000,-918.7999900,1001.3000000,0.0000000,0.0000000,0.0000000), --object(med_office4_desk_4), (1),
createObject(2309,1454.1000000,-922.7000100,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office_chair2), (1),
createObject(2309,1454.1000000,-933.7999900,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office_chair2), (2),
createObject(2309,1454.1000000,-939.7999900,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office_chair2), (3),
createObject(2309,1454.0000000,-949.2999900,1001.3000000,0.0000000,0.0000000,270.0000000), --object(med_office_chair2), (4),
createObject(2164,1449.1000000,-926.4000200,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_unit_5), (1),
createObject(2164,1449.1000000,-924.5999800,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_unit_5), (2),
createObject(2164,1449.1000000,-922.7999900,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_unit_5), (3),
createObject(2164,1452.5000000,-952.7000100,1001.3000000,0.0000000,0.0000000,180.0000000), --object(med_office_unit_5), (4),
createObject(1569,1453.9000000,-917.2999900,1001.2000000,0.0000000,0.0000000,0.0000000), --object(adam_v_door), (1),
createObject(1569,1471.5000000,-917.2999900,1001.2000000,0.0000000,0.0000000,0.0000000), --object(adam_v_door), (2),
createObject(1569,1465.2000000,-917.2999900,1001.2000000,0.0000000,0.0000000,180.0000000), --object(adam_v_door), (3),
createObject(1569,1462.2002000,-917.2998000,1001.2000000,0.0000000,0.0000000,0.0000000), --object(adam_v_door), (4),
createObject(646,1452.9000000,-918.0000000,1002.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb14), (1),
createObject(646,1455.2000000,-928.2000100,1002.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb14), (2),
createObject(646,1454.9000000,-944.5000000,1002.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb14), (3),
createObject(646,1449.9000000,-951.2000100,1002.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb14), (4),
createObject(646,1472.0000000,-944.7000100,1002.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb14), (5),
createObject(646,1471.8000000,-936.5999800,1002.7000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb14), (6),
createObject(646,1471.8000000,-928.2999900,1002.7000000,0.0000000,0.0000000,30.0000000), --object(veg_palmkb14), (7),
createObject(646,1474.5000000,-918.0999800,1002.7000000,0.0000000,0.0000000,29.9980000), --object(veg_palmkb14), (8),
createObject(2309,1472.5000000,-933.4000200,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_chair2), (5),
createObject(2309,1472.6000000,-922.5000000,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_chair2), (6),
createObject(2309,1472.4000000,-939.7999900,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_chair2), (7),
createObject(2309,1472.4000000,-949.2000100,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_chair2), (8),
createObject(2309,1472.4000000,-955.2999900,1001.3000000,0.0000000,0.0000000,90.0000000), --object(med_office_chair2), (9),
createObject(8661,1445.8000000,-933.0000000,1005.2000000,0.0000000,0.0000000,90.0000000), --object(gnhtelgrnd_lvs), (5),
createObject(8661,1481.2000000,-937.4000200,1005.3000000,0.0000000,0.0000000,90.0000000), --object(gnhtelgrnd_lvs), (6),
createObject(3440,1469.6000000,-965.7000100,1007.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs), (1),
createObject(3440,1471.0000000,-966.0999800,1007.9000000,90.0000000,0.0000000,90.0000000), --object(arptpillar01_lvs), (2),
createObject(3440,1472.7000000,-966.2000100,1007.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs), (3),
createObject(3440,1472.7000000,-966.7000100,1007.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs), (4),
createObject(3440,1469.6000000,-966.2000100,1007.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs), (5),
createObject(3440,1469.6000000,-966.7000100,1007.7000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs), (6),
createObject(3440,1471.0000000,-966.5000000,1007.9000000,90.0000000,0.0000000,90.0000000), --object(arptpillar01_lvs), (7),
createObject(970,1467.4000000,-959.9000200,1006.0000000,0.0000000,0.0000000,90.0000000), --object(fencesmallb), (1),
createObject(970,1467.3000000,-965.7999900,1006.0000000,0.0000000,0.0000000,90.0000000), --object(fencesmallb), (2),
createObject(970,1452.6000000,-959.9000200,1006.0000000,0.0000000,0.0000000,90.0000000), --object(fencesmallb), (3),
createObject(970,1452.6000000,-965.7999900,1006.0000000,0.0000000,0.0000000,90.0000000), --object(fencesmallb), (4),
createObject(626,1467.0000000,-958.7000100,1007.5000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb2), (1),
createObject(626,1467.0000000,-964.9000200,1007.5000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb2), (2),
createObject(626,1453.3000000,-965.0000000,1007.5000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb2), (3),
createObject(626,1453.7000000,-958.5999800,1007.5000000,0.0000000,0.0000000,0.0000000), --object(veg_palmkb2), (4),
createObject(2606,1461.7000000,-965.7999900,1008.5000000,0.0000000,0.0000000,180.0000000), --object(cj_police_counter2), (1),
createObject(2606,1457.9000000,-965.7999900,1008.5000000,0.0000000,0.0000000,179.9950000), --object(cj_police_counter2), (2),
createObject(2737,1459.6000000,-965.7000100,1007.2000000,0.0000000,0.0000000,179.7500000), --object(police_nb_car), (1),
createObject(3851,1543.5000000,-978.5000000,1007.0000000,90.0000000,0.0000000,90.0000000), --object(carshowwin_sfsx), (3),
createObject(8661,1560.1000000,-983.2999900,1005.6000000,0.0000000,0.0000000,0.0000000), --object(gnhtelgrnd_lvs), (7),
createObject(2395,1494.1000000,-977.7000100,1005.6000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall), (1),
createObject(2395,1488.6000000,-976.4000200,1005.6000000,0.0000000,0.0000000,0.0000000), --object(cj_sports_wall), (4),
createObject(2395,1492.2000000,-975.4000200,1005.6000000,0.0000000,0.0000000,90.0000000), --object(cj_sports_wall), (5),
createObject(3440,1492.0000000,-976.0999800,1008.0000000,0.0000000,0.0000000,0.0000000), --object(arptpillar01_lvs), (8),
createObject(2395,1491.4000000,-972.0000000,1005.6000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall), (6),
createObject(2395,1491.4000000,-972.0000000,1008.3000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall), (7),
createObject(2395,1491.4000000,-972.0000000,1011.0000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall), (8),
createObject(2395,1495.3000000,-972.0000000,1007.7000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall), (9),
createObject(2395,1495.3000000,-972.0000000,1010.4000000,0.0000000,0.0000000,179.9950000), --object(cj_sports_wall), (10),
createObject(2395,1488.2000000,-975.7999900,1007.7000000,90.0000000,0.0000000,0.0000000), --object(cj_sports_wall), (11),
createObject(2395,1491.4000000,-975.2999900,1007.7000000,90.0000000,0.0000000,90.0000000), --object(cj_sports_wall), (12),
createObject(2395,1491.4000000,-979.0999800,1007.7000000,90.0000000,0.0000000,90.0000000), --object(cj_sports_wall), (13),
---createObject(3037,1450.9000000,-953.0000000,1007.6000000,0.0000000,0.0000000,90.0000000), --object(warehouse_door2b), (1),
}

for k,v in ipairs(map) do
	setElementDimension(v,1)
	setElementDoubleSided(v,true)
	setElementData(v,"objectHealth",true)
end

