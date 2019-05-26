local robbers = {}
local cops = {}
local entered = {}
local RobberShipment = {}
local LawShipment = {}
local DSmarkers = {}
local delayer = {}
local isEventStarted = false
local eventStopped = false
local isEventAvailable = false
local MinRobbers = 7
local Positions = {
	{2716.25,-2410.97,13.63,"Entrance"},
	{2797.66,-2417.76,13.63,"Warehouse1"},
	{2797.66,-2495.02,13.63,"Warehouse2"},
	{2798.1,-2458.46,13.63,"Warehouse3"},
	{2837.81,-2530.95,17.95,"Ship front deck"},
	{2837.88,-2333.41,12.04,"Ship behind deck"},
	}


local shipCol = createColCircle(2804.58,-2450.42,200)
local leaveCol = createColCircle(2747.71,-2432.82,500)

createObject ( 14407, 2825.8999, -2517.8, 13.4, 0, 0, 358 )
createObject ( 3114, 2817.3999, -2438.3999, 10.4 )
createObject ( 3095, 2814.6001, -2438.2, 11, 0, 14, 0 )

addEventHandler("onResourceStart",resourceRoot,function()
	startingTimer = setTimer(buildTheMission,6400000,1)
	for k,v in ipairs(getElementsByType("player")) do
		setElementData(v,"isPlayerRobbingDrugs",false)
		setElementData(v,"isPlayerGotDrugs",false)
		setElementData(v,"isPlayerInDS",false)
		setElementData(v,"stopDM",false)
	end
end)

addCommandHandler("drugset",function(plr,cmd,va,l)
	if getElementData(plr,"isPlayerPrime") then
		if va == "count" then
			MinRobbers = tonumber(l)
		elseif va == "time" then
			if isTimer(startingTimer) then killTimer(startingTimer) end
			startingTimer = setTimer(buildTheMission,l,1)
		elseif va == "prog" then
			if isTimer(progressTimer) then killTimer(progressTimer) end
			progressTimer = setTimer(ControlShipment,60000,1)
		end
	end
end)

function buildTheMission()
	isEventAvailable = true
	robbers = {}
	cops = {}
	local t = getElementsWithinColShape(shipCol)
	for k,v in pairs(t) do
		if getElementType(v) == "player" then
			if getTeamName(getPlayerTeam(v)) == "Criminals" then
				table.insert(robbers,v)
			end
		end
	end
	local t = getElementsWithinColShape(shipCol)
	for k,v in pairs(t) do
		if getElementType(v) == "player" then
			if exports.DENlaw:isLaw(v) then
				table.insert(cops,v)
			end
		end
	end
	triggerClientEvent("countDrugShipment",root,#robbers,#cops)
	getStartingCount()
	--exports.NGCdxmsg:createNewDxMessage(root,"Drug shipment arrived to Los Santos docks",0,255,0)
end

function EventCount(typechecker)

	if typechecker ~= "law" and isEventAvailable == false then return false end
	robbers = {}
	cops = {}
	local t = getElementsWithinColShape(shipCol)
	for k,v in pairs(t) do
		if getElementType(v) == "player" then
			if getTeamName(getPlayerTeam(v)) == "Criminals" and not getElementData(v,"stopDM") then
				table.insert(robbers,v)
				setElementData(v,"isPlayerRobbingDrugs",true)
			end
		end
	end
	local t2 = getElementsWithinColShape(shipCol)
	for k,v in pairs(t2) do
		if getElementType(v) == "player" then
			if exports.DENlaw:isLaw(v) and not getElementData(v,"stopDM") then
				table.insert(cops,v)
				setElementData(v,"isPlayerInDS",true)
			end
		end
	end
	triggerClientEvent("countDrugShipment",root,#robbers,#cops)
end

drugsTable = {"Ritalin","Weed","Ecstasy","Heroine","Cocaine","LSD"}
local justHit = {}
local proTimer = {}
function hitDSMarker(hitElement,dim)
	if hitElement and getElementType(hitElement) == "player" then
		if dim then
			if not isPedInVehicle(hitElement) then
				if eventStopped == true then return false end
				if getElementAlpha(source) < 50 then return false end
				if getElementData(hitElement,"stopDM") then return false end
				if exports.DENlaw:isLaw(hitElement) then
					if getElementData(hitElement,"isPlayerInDS") == true then
						if getElementData(source,"captured") ~= "law" then
							local zone = getElementData(source,"name")
							setElementData(source,"captured","law")
							setMarkerColor(source,0,100,250,125)
							getVaildShipment()
						end
					end
				elseif getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
					if getElementData(hitElement,"isPlayerRobbingDrugs") == true then
						if getElementData(source,"captured") ~= "criminals" then
							local zone = getElementData(source,"name")
							setElementData(source,"captured","criminals")
							setMarkerColor(source,255,0,0,125)
							getVaildShipment()
						end
					end
				end
			end
		end
	end
end


blips = {}
function createMission()
	if isEventStarted == true then return false end
	if #robbers < tonumber(MinRobbers) then
		for k,v in ipairs(robbers) do
			exports.NGCdxmsg:createNewDxMessage(v,"The Robbers aren't enough to start the event, next check in 30 seconds ("..#robbers.."/"..MinRobbers..")",255,255,0)
		end
		getStartingCount()
		return
	end
	for i=1,6 do
		local x, y, z, pos = Positions[i][1], Positions[i][2], Positions[i][3],Positions[i][4]
		local marker = createMarker(x,y,z-1,"cylinder",2,255,255,255)
		table.insert(DSmarkers,marker)
		local blip = createBlip(x,y,z,56)
		setBlipSize(blip,1.1)
		table.insert(blips,blip)
		setElementData(marker,"id",i)
		setElementData(marker,"captured","none")
		setElementData(marker,"name",pos)
		addEventHandler("onMarkerHit",marker,hitDSMarker)
	end
	isEventStarted = true
	isEventAvailable = false
	if isTimer(progressTimer) then return false end
	progressTimer = setTimer(ControlShipment,60000*6,1)
	triggerClientEvent("drawTime",root,60000*6)
	setTimer(function()
		if (isTimer(progressTimer)) then
			local timeLeft, timeExLeft, timeExMax = getTimerDetails(progressTimer)
			triggerClientEvent("drawTime",root,timeLeft)
		end
	end,60000,0)
	for k,v in ipairs(robbers) do
		entered[v] = exports.server:getPlayerAccountName(v)
		triggerClientEvent(v,"drawMoney",v,"Beginning the robbery","Capture the zone","Kill the cops")
		setElementData(v,"wantedPoints",getElementData(v,"wantedPoints")+100)
		setElementData(v,"isPlayerRobbingDrugs",true)
		setElementData(v,"isPlayerGotDrugs",false)
	end
	for k,v in ipairs(cops) do
		entered[v] = exports.server:getPlayerAccountName(v)
		triggerClientEvent(v,"drawMoney",v,"Stop the robbery","Capture the zone","Kill the robbers")
		setElementData(v,"isPlayerInDS",true)
	end
	for k,v in ipairs(getElementsByType("player")) do
		if exports.DENlaw:isLaw(v) then
			exports.NGCdxmsg:createNewDxMessage(v,"Stop drugshipment robbery, criminals just started it",255,0,0)
		end
	end
end

function getVaildShipment()
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

function ControlShipment()
	local law,crim = getVaildShipment()
	for k,v in ipairs(robbers) do
		triggerClientEvent(v,"drawMoney",v,crim.." captured by the Criminals","Exit the whole zone","",255,0,0)
	end
	for k,v in ipairs(cops) do
		triggerClientEvent(v,"drawMoney",v,law.." captured by the Law","Arrest the robbers once they leave the zone","",0,150,250)
	end
	if law == 3 then
		handlePayment(cops,50)
	elseif law == 4 then
		handlePayment(cops,100)
	elseif law == 5 then
		handlePayment(cops,150)
	elseif law == 6 then
		handlePayment(cops,200)
	end
	for k,v in ipairs(robbers) do
		setElementData(v,"isPlayerRobbingDrugs",true)
		setElementData(v,"isPlayerGotDrugs",true)
	end
	for k,v in ipairs(DSmarkers) do
		if isElement(v) then setElementAlpha(v,0) end
	end
	for k,v in ipairs(blips) do
		if isElement(v) then setElementAlpha(v,0) end
	end
	eventStopped = true
	isEventAvailable = false
end


function handlePayment(tableName,amount)
	for k,v in ipairs(tableName) do
		for d,a in ipairs(drugsTable) do
			exports.CSGdrugs:giveDrug(v,a,amount)
			exports.NGCdxmsg:createNewDxMessage(v,"You have earned "..amount.." of "..a,0,250,0)
		end
		exports.CSGgroups:addXP(v,6)
	end
end


function forceStop()
	for k,v in ipairs(DSmarkers) do
		if isElement(v) then setElementAlpha(v,0) end
	end
	outputDebugString("restarting event")
	eventStopped = true
	isEventAvailable = false
	if isTimer(stoppingTimer) then return false end
	if isTimer(progressTimer) then killTimer(progressTimer) end
	triggerClientEvent("stopDS",root)
	local law,crim = getVaildShipment()
	if law == 3 then
		handlePayment(cops,50)
	elseif law == 4 then
		handlePayment(cops,100)
	elseif law == 5 then
		handlePayment(cops,150)
	elseif law == 6 then
		handlePayment(cops,200)
	end
	robbers = {}
	cops = {}
	RobberShipment = {}
	LawShipment = {}
	for k,v in ipairs(blips) do
		if isElement(v) then setElementAlpha(v,0) end
	end
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerInDS") then
			setElementData(v,"isPlayerInDS",false)
		end
	end
	stoppingTimer = setTimer(function()
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerRobbingDrugs") or getElementData(v,"isPlayerGotDrugs") then
			triggerClientEvent(v,"drawMoney",v,"Drugshipment is no longer available","You failed in the robbery","You didn't escape")
			setElementData(v,"isPlayerRobbingDrugs",false)
			setElementData(v,"isPlayerGotDrugs",false)
		end
		if getElementData(v,"isPlayerInDS") then
			setElementData(v,"isPlayerInDS",false)
		end
	end
	local resx = getResourceFromName("NGCdrugEvent")
	restartResource(resx)
	end,60000*2,1)
end

function destroyTheEvent()
	for k,v in ipairs(DSmarkers) do
		if isElement(v) then setElementAlpha(v,0) end
	end
	triggerClientEvent("stopDS",root)
	local law,crim = getVaildShipment()
	if law == 3 then
		handlePayment(cops,50)
	elseif law == 4 then
		handlePayment(cops,100)
	elseif law == 5 then
		handlePayment(cops,150)
	elseif law == 6 then
		handlePayment(cops,200)
	end
	for k,v in ipairs(blips) do
		if isElement(v) then setElementAlpha(v,0) end
	end
	cops = {}
	LawShipment = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerInDS") then
			setElementData(v,"isPlayerInDS",false)
		end
	end
	eventStopped = true
	isEventAvailable = false
	if isTimer(stoppingTimer) then return false end
	stoppingTimer = setTimer(function()
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"isPlayerRobbingDrugs") or getElementData(v,"isPlayerGotDrugs") then
			triggerClientEvent(v,"drawMoney",v,"Drugshipment is no longer available","You failed in the robbery","You didn't escape")
			setElementData(v,"isPlayerRobbingDrugs",false)
			setElementData(v,"isPlayerGotDrugs",false)
		end
		if getElementData(v,"isPlayerInDS") then
			setElementData(v,"isPlayerInDS",false)
		end
	end
	robbers = {}
	cops = {}
	RobberShipment = {}
	LawShipment = {}
	local resx = getResourceFromName("NGCdrugEvent")
	restartResource(resx)
	end,60000*2,1)
end
--aclGroupAddObject (aclGetGroup("Admin"), "resource.NGCdrugEvent")

function gimmeOutput(msg,r,g,b)
	for k,v in ipairs(getElementsByType("player")) do
		if isElementWithinColShape(v,shipCol) then
			exports.NGCdxmsg:createNewDxMessage(v,msg,r,g,b)
		end
	end
end

addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"isPlayerRobbingDrugs") or getElementData(source,"isPlayerGotDrugs") or getElementData(source,"isPlayerInDS") then
		for k,v in ipairs(robbers) do
			if source == v then
				table.remove(robbers,k)
				setElementPosition(source,2327.74,-2352.75,13.54)
				break
			end
		end
		for k,v in ipairs(cops) do
			if source == v then
				table.remove(cops,k)
				setElementPosition(source,2327.74,-2352.75,13.54)
				break
			end
		end
		if #robbers == 0 then
			destroyTheEvent()
		end
	end
end)

addEventHandler("onColShapeLeave",root,function(hitElement,dm)
	if source == shipCol then
		if getElementType(hitElement) == "player" then
			if isPedInVehicle(hitElement) then return false end
			if getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
				for k,v in ipairs(robbers) do
					if hitElement == v then
						table.remove(robbers,k)
						setElementData(hitElement,"isPlayerRobbingDrugs",false)
						exports.NGCdxmsg:createNewDxMessage("You have left the ship zone",255,0,0)
						break
					end
				end
				if isEventStarted == true and #robbers == 0 then
					destroyTheEvent()
				end
				setElementData(hitElement,"stopDM",false)
				triggerClientEvent("countDrugShipment",root,#robbers,#cops)
			elseif exports.DENlaw:isLaw(hitElement) then
				for k,v in ipairs(cops) do
					if hitElement == v then
						table.remove(cops,k)
						setElementData(hitElement,"isPlayerInDS",false)
						exports.NGCdxmsg:createNewDxMessage("You have left the ship zone",255,0,0)
						break
					end
				end
				setElementData(hitElement,"stopDM",false)
				triggerClientEvent("countDrugShipment",root,#robbers,#cops)
			end
		elseif getElementType(hitElement) == "vehicle" then
			local occupants = getVehicleOccupants(hitElement)
			local seats = getVehicleMaxPassengers(hitElement)
			if (type(occupants) == "boolean") then return false end
			--for seat=0,3 do
			for seat, zx in pairs(occupants) do
				local occupant = occupants[seat]
				if ((occupant) and (getElementType(occupant)=="player")) then
					if getTeamName(getPlayerTeam(occupant)) == "Criminals" then
						for k,v in ipairs(robbers) do
							if occupant == v then
								table.remove(robbers,k)
								setElementData(occupant,"isPlayerRobbingDrugs",false)
								exports.NGCdxmsg:createNewDxMessage(occupant,"You have left the ship zone",255,0,0)
								break
							end
						end
						if isEventStarted == true and #robbers == 0 then
							destroyTheEvent()
						end
						setElementData(occupant,"stopDM",false)
						triggerClientEvent("countDrugShipment",root,#robbers,#cops)
					elseif exports.DENlaw:isLaw(occupant) then
						for k,v in ipairs(cops) do
							if occupant == v then
								table.remove(cops,k)
								setElementData(occupant,"isPlayerInDS",false)
								exports.NGCdxmsg:createNewDxMessage(occupant,"You have left the ship zone",255,0,0)
								break
							end
						end
						setElementData(occupant,"stopDM",false)
						triggerClientEvent("countDrugShipment",root,#robbers,#cops)
					end
				end
			end
		end
	elseif source == leaveCol then
		if getElementType(hitElement) == "player" then
			if isPedInVehicle(hitElement) then return false end
			if getElementData(hitElement,"isPlayerGotDrugs") then
				if getElementData ( hitElement, "isPlayerArrested" ) ~= true then
					local law,crim = getVaildShipment()
					if crim == 3 then
						for k,v in ipairs(drugsTable) do
							exports.CSGdrugs:giveDrug(hitElement,v,50)
							exports.NGCdxmsg:createNewDxMessage(hitElement,"You earned 50 hits of all drugs kinds",0,255,0)
						end
						exports.CSGgroups:addXP(hitElement,6)
					elseif	crim == 4 then
						for k,v in ipairs(drugsTable) do
							exports.CSGdrugs:giveDrug(hitElement,v,100)
							exports.NGCdxmsg:createNewDxMessage(hitElement,"You earned 100 hits of all drugs kinds",0,255,0)
						end
						exports.CSGgroups:addXP(hitElement,6)
					elseif	crim == 5 then
						for k,v in ipairs(drugsTable) do
							exports.CSGdrugs:giveDrug(hitElement,v,150)
							exports.NGCdxmsg:createNewDxMessage(hitElement,"You earned 150 hits of all drugs kinds",0,255,0)
						end
						exports.CSGgroups:addXP(hitElement,6)
					elseif	crim == 6 then
						for k,v in ipairs(drugsTable) do
							exports.CSGdrugs:giveDrug(hitElement,v,200)
							exports.NGCdxmsg:createNewDxMessage(hitElement,"You earned 200 hits of all drugs kinds",0,255,0)
						end
						exports.CSGgroups:addXP(hitElement,6)
						exports.AURcriminalp:giveCriminalPoints(hitElement, "drugEvent", 10)
					end
					setElementData(hitElement,"isPlayerGotDrugs",false)
					setElementData(hitElement,"isPlayerRobbingDrugs",false)
					entered[hitElement] = false

				end
			end
		elseif getElementType(hitElement) == "vehicle" then
			local occupants = getVehicleOccupants(hitElement)
			local seats = getVehicleMaxPassengers(hitElement)
			if (type(occupants) == "boolean") then return false end
			--for seat=0,3 do
			for seat, zx in pairs(occupants) do
				local occupant = occupants[seat]
				if ((occupant) and (getElementType(occupant)=="player")) then
					if getElementData(occupant,"isPlayerGotDrugs") then
						if getElementData ( occupant, "isPlayerArrested" ) ~= true then
							local law,crim = getVaildShipment()
							if crim == 3 then
								for k,v in ipairs(drugsTable) do
									exports.CSGdrugs:giveDrug(occupant,v,50)
									exports.NGCdxmsg:createNewDxMessage(occupant,"You earned 50 hits of all drugs kinds",0,255,0)
								end
								exports.CSGgroups:addXP(occupant,6)
							elseif	crim == 4 then
								for k,v in ipairs(drugsTable) do
									exports.CSGdrugs:giveDrug(occupant,v,100)
									exports.NGCdxmsg:createNewDxMessage(occupant,"You earned 100 hits of all drugs kinds",0,255,0)
								end
								exports.CSGgroups:addXP(occupant,6)
							elseif	crim == 5 then
								for k,v in ipairs(drugsTable) do
									exports.CSGdrugs:giveDrug(occupant,v,150)
									exports.NGCdxmsg:createNewDxMessage(occupant,"You earned 150 hits of all drugs kinds",0,255,0)
								end
								exports.CSGgroups:addXP(occupant,6)
							elseif	crim == 6 then
								for k,v in ipairs(drugsTable) do
									exports.CSGdrugs:giveDrug(occupant,v,200)
									exports.NGCdxmsg:createNewDxMessage(occupant,"You earned 200 hits of all drugs kinds",0,255,0)
								end
								exports.CSGgroups:addXP(occupant,6)
							end
							setElementData(occupant,"isPlayerGotDrugs",false)
							setElementData(occupant,"isPlayerRobbingDrugs",false)
							entered[occupant] = false
						end
					end
				end
			end
		end
	end
end)

function givePts(plr,ty)
	if ty == "crim" then
		exports.DENstats:setPlayerAccountData(plr,"drugshipmentcrim",exports.denstats:getPlayerAccountData(plr,"drugshipmentcrim")+1)
	else
		exports.DENstats:setPlayerAccountData(plr,"drugshipmentlaw",exports.denstats:getPlayerAccountData(plr,"drugshipmentlaw")+1)
	end
end


addEventHandler("onColShapeHit",root,function(hitElement,dm)
	if source == shipCol then
		if getElementType(hitElement) == "player" then
			if not dm then return false end
			if isPedInVehicle(hitElement) then return false end
			if getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
				if isEventStarted == true or eventStopped == true then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You are not allowed participate at this time",255,0,0)
					setElementData(hitElement,"stopDM",true)
					triggerClientEvent(hitElement,"stopDM",hitElement)
					return false
				end
				if entered[hitElement] == exports.server:getPlayerAccountName(hitElement) then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You are not allowed participate at this time",255,0,0)
					setElementData(hitElement,"stopDM",true)
					triggerClientEvent(hitElement,"stopDM",hitElement)
					return false
				end
				EventCount("crim")
				givePts(hitElement,"crim")
			elseif exports.DENlaw:isLaw(hitElement) then
				EventCount("law")
				givePts(hitElement,"law")
			elseif getTeamName(getPlayerTeam(hitElement)) == "Staff" then
				return
			else
				setElementData(hitElement,"stopDM",true)
				triggerClientEvent(hitElement,"stopDM",hitElement)
			end
		elseif getElementType(hitElement) == "vehicle" then
			if not dm then return false end
			local occupants = getVehicleOccupants(hitElement)
			local seats = getVehicleMaxPassengers(hitElement)
			if (type(occupants) == "boolean") then return false end
			--for seat=0,3 do
			for seat, zx in pairs(occupants) do
				local plr = occupants[seat]
				if ((plr) and (getElementType(plr)=="player")) then
					if getTeamName(getPlayerTeam(plr)) == "Criminals" then
						if isEventStarted == true or eventStopped == true then
							exports.NGCdxmsg:createNewDxMessage(plr,"You are not allowed participate at this time",255,0,0)
							setElementData(plr,"stopDM",true)
							triggerClientEvent(plr,"stopDM",plr)
							return false
						end
						if entered[plr] == exports.server:getPlayerAccountName(plr) then
							exports.NGCdxmsg:createNewDxMessage(plr,"You are not allowed participate at this time",255,0,0)
							setElementData(plr,"stopDM",true)
							triggerClientEvent(plr,"stopDM",plr)
							return false
						end
						EventCount("crim")
						givePts(plr,"crim")
					elseif exports.DENlaw:isLaw(plr) then
						EventCount("law")
						givePts(plr,"law")
					elseif getTeamName(getPlayerTeam(plr)) == "Staff" then
						return
					else
						setElementData(plr,"stopDM",true)
						triggerClientEvent(plr,"stopDM",plr)
					end
				end
			end
		end
	end
	--[[if source == shipCol then
		if getElementType(hitElement) == "player" then
			if not dm then return false end
			if isPedInVehicle(hitElement) then return false end
				if isEventStarted == true or eventStopped == true then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You are not allowed participate at this time",255,0,0)
					setElementData(hitElement,"stopDM",true)
					triggerClientEvent(hitElement,"stopDM",hitElement)
				return false end
			if getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
				if isEventAvailable == false then return false end
				if entered[hitElement] == exports.server:getPlayerAccountName(hitElement) then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You are not allowed participate at this time",255,0,0)

				setElementData(hitElement,"stopDM",true)
				triggerClientEvent(hitElement,"stopDM",hitElement)
				return false end
				--table.insert(robbers,hitElement)
				EventCount()
				givePts(hitElement,"crim")
				setElementData(hitElement,"isPlayerRobbingDrugs",true)
				exports.NGCdxmsg:createNewDxMessage(hitElement,"You have joined drug shipment robbery",0,255,0)
				getStartingCount()
				triggerClientEvent("countDrugShipment",root,#robbers,#cops)
			elseif exports.DENlaw:isLaw(hitElement) then
				if entered[hitElement] == exports.server:getPlayerAccountName(hitElement) then
					exports.NGCdxmsg:createNewDxMessage(hitElement,"You are not allowed participate at this time",255,0,0)
					setElementData(hitElement,"stopDM",true)
					triggerClientEvent(hitElement,"stopDM",hitElement)
				return false end
				--table.insert(cops,hitElement)
				EventCount()

				givePts(hitElement,"law")
				setElementData(hitElement,"isPlayerInDS",true)
				exports.NGCdxmsg:createNewDxMessage(hitElement,"You have joined drug shipment zone",0,255,0)
				triggerClientEvent("countDrugShipment",root,#robbers,#cops)
			elseif getTeamName(getPlayerTeam(hitElement)) == "Staff" then
				return
			else
				setElementData(hitElement,"stopDM",true)
				triggerClientEvent(hitElement,"stopDM",hitElement)
			end
		elseif getElementType(hitElement) == "vehicle" then
			if isEventAvailable == false then return false end
			local occupants = getVehicleOccupants(hitElement)
			local seats = getVehicleMaxPassengers(hitElement)
			for seat=0,3 do
				local occupant = occupants[seat]
				if ((occupant) and (getElementType(occupant)=="player")) then
					if entered[occupant] == exports.server:getPlayerAccountName(occupant) then
						exports.NGCdxmsg:createNewDxMessage(occupant,"You are not allowed participate at this time",255,0,0)
						setElementData(occupant,"stopDM",true)
						triggerClientEvent(occupant,"stopDM",occupant)
						return
					else
						if isEventStarted == true or eventStopped == true then
							exports.NGCdxmsg:createNewDxMessage(occupant,"You are not allowed participate at this time",255,0,0)
							setElementData(occupant,"stopDM",true)
							triggerClientEvent(occupant,"stopDM",occupant)
						return false end
						if getTeamName(getPlayerTeam(occupant)) == "Criminals" then
							if entered[occupant] == exports.server:getPlayerAccountName(occupant) then
								exports.NGCdxmsg:createNewDxMessage(occupant,"You are not allowed participate at this time",255,0,0)


								setElementData(occupant,"stopDM",true)
								triggerClientEvent(occupant,"stopDM",occupant)
								return
							end
							--table.insert(robbers,occupant)
							EventCount()

							givePts(occupant,"crim")
							setElementData(occupant,"isPlayerRobbingDrugs",true)
							exports.NGCdxmsg:createNewDxMessage(occupant,"You have joined drug shipment robbery",0,255,0)
							getStartingCount()
							triggerClientEvent("countDrugShipment",root,#robbers,#cops)
						elseif exports.DENlaw:isLaw(occupant) then
							if entered[occupant] == exports.server:getPlayerAccountName(occupant) then
								exports.NGCdxmsg:createNewDxMessage(occupant,"You are not allowed participate at this time",255,0,0)
								setElementData(occupant,"stopDM",true)
								triggerClientEvent(occupant,"stopDM",occupant)
								return
							end
							--table.insert(cops,occupant)
							EventCount()

							givePts(occupant,"law")
							setElementData(occupant,"isPlayerInDS",true)
							exports.NGCdxmsg:createNewDxMessage(occupant,"You have joined drug shipment zone",0,255,0)
							exports.NGCdxmsg:createNewDxMessage(occupant,"Kill the robbers and capture the points",255,255,0)
							triggerClientEvent("countDrugShipment",root,#robbers,#cops)
						elseif getTeamName(getPlayerTeam(occupant)) == "Staff" then
							return
						else
							setElementData(occupant,"stopDM",true)
							triggerClientEvent(occupant,"stopDM",occupant)
						end
					end
				end
			end
		end
	end]]
end)

function getStartingCount()
	EventCount("idk")
	if #robbers >= tonumber(MinRobbers) then
		if isTimer(Counter) then return false end
		Counter = setTimer(createMission,10000,1)
		gimmeOutput("Drug shipment event will be started within 10 seconds get ready!",255,0,0)
	else
		if isTimer(delayer) then killTimer(delayer) end
		gimmeOutput("The Robbers aren't enough to start the event, next check in 20 seconds ("..#robbers.."/"..MinRobbers..")",255,255,0)
		delayer = setTimer(getStartingCount,20000,1)
	end
	triggerClientEvent("countDrugShipment",root,#robbers,#cops)
end



addEvent ( "onPlayerNightstickHit" )
addEventHandler ( "onPlayerNightstickHit", root,
function ( theCop )
	if ( getPlayerTeam( source ) ) then
		if ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) then
			if ( getElementData ( source, "isPlayerRobbingDrugs" ) ) then
				if getPedWeapon(theCop) == 3 then
					if isElementWithinColShape(source,shipCol) then
						exports.NGCdxmsg:createNewDxMessage( theCop, "Don't arrest robbers but kill them!", 225, 0, 0 )
						cancelEvent()
					end
				end
			end
		end
	end
end
)


addEventHandler( "onPlayerWasted", root,
function ( ammo, attacker, weapon, bodypart )
	if ( attacker ) and ( isElement( attacker ) ) and ( getElementType ( attacker ) == "player" ) then
		if not ( source == attacker ) and ( getPlayerTeam( attacker ) )then
			if (getTeamName(getPlayerTeam(attacker)) == "Criminals") and ( exports.DENlaw:isLaw(source) ) then
				if ( getElementData(attacker, "isPlayerRobbingDrugs") ) or (getElementData(attacker, "isPlayerGotDrugs")) and (getElementData(source, "isPlayerInDS") == true) then
					exports.NGCdxmsg:createNewDxMessage( attacker, "You killed a cop, You earned 20 hits of all drugs kinds!", 0, 230, 0)
					--if getElementData(attacker,"isPlayerVIP") then
						exports.AURpayments:addMoney(attacker,5000,"Custom","Event",0,"CnR DrugShip")
						exports.CSGgroups:addXP(attacker,3)
						exports.NGCdxmsg:createNewDxMessage(attacker,"You killed a cop, You earned $5,000",0,255,0)
					--end
					for k,v in ipairs(drugsTable) do
						exports.CSGdrugs:giveDrug(attacker,v,20)
					end
					setElementData(source, "isPlayerInDS", false)
					setElementData(source, "isPlayerRobbingDrugs", false)
					setElementData(source, "isPlayerGotDrugs", false )
					for k, thePlayer in ipairs(cops) do
						if (thePlayer == source) then
							table.remove(cops, k)
							break
						end
					end
					triggerClientEvent("countDrugShipment",root,#robbers,#cops)
				end
			elseif ( exports.DENlaw:isLaw(attacker) ) and (getTeamName(getPlayerTeam(source)) == "Criminals") then
				if ( getElementData(source, "isPlayerRobbingDrugs") ) or (getElementData(source, "isPlayerGotDrugs")) and (getElementData(attacker, "isPlayerInDS") == true) then
					exports.NGCdxmsg:createNewDxMessage( attacker, "You killed a robber, You earned 20 hits of all drugs kinds!", 0, 230, 0)
					--if getElementData(attacker,"isPlayerVIP") then
					exports.CSGgroups:addXP(attacker,3)
					exports.AURpayments:addMoney(attacker,5000,"Custom","Event",0,"CnR DrugShip")
					exports.NGCdxmsg:createNewDxMessage(attacker,"You killed a robber, You earned $5,000",0,255,0)
					---end
					for k,v in ipairs(drugsTable) do
						exports.CSGdrugs:giveDrug(attacker,v,20)
					end
					setElementData(source, "isPlayerRobbingDrugs", false)
					setElementData(source, "isPlayerGotDrugs", false )
					for k, thePlayer in ipairs(robbers) do
						if (thePlayer == source) then
							table.remove(robbers, k)
							break
						end
					end
					if #robbers == 0 then
						forceStop()
					end
					triggerClientEvent("countDrugShipment",root,#robbers,#cops)
				end
			end
		end
	end
end)


addEvent("removeJetpack",true)
addEventHandler("removeJetpack",root,function()
	removePedJetPack(source)
end)



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


addCommandHandler("drugtime",
function (thePlayer)
	local robType = "(Los Santos Drugs shipment)"
	if (isTimer(startingTimer)) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(startingTimer)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, onCalculateBanktime(math.floor(timeLeft)).." until event get started "..robType, 230, 230, 0)
	elseif (isTimer(progressTimer)) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(progressTimer)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, onCalculateBanktime(math.floor(timeLeft)).." until mission get stopped!", 230, 230, 0)
	elseif (isTimer(delayer)) then
		local timeLeft, timeExLeft, timeExMax = getTimerDetails(delayer)
		exports.NGCdxmsg:createNewDxMessage(thePlayer, onCalculateBanktime(math.floor(timeLeft)).." until event get started ", 230, 230, 0)
	elseif isEventAvailable == true then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, robType.." is able to be robbed go to LS Docks!", 0, 230, 0)
	elseif eventStopped == true then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, robType.." no robbery anytime soon!", 0, 230, 0)
	end
end)



