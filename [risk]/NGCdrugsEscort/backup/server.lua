
_resroot = getResourceRootElement ( getThisResource ( ) )


-----------------------------------
-------------- SETINGS ------------
local DeliveryTruckStatus = false
local TimeBetweenTwoEvents = 60  -- mins
local TimeWhenEventShouldGetCanceled = 20  -- mins
local TimeWenEventTriggered = 15 -- mins
local TimeForReward = 1 -- min
local MaxTruckSpeed = 55 -- KPH
local FromWhere = "" --Don't touch it!
local ToWhere = "" --Don't touch it!
local RewardMAX = 200 --Max reward
local RewardMIN = 100 --Min reward
local crimNeeded = 2
local crimsInFromMarker = {}
VanStartLocations = {
{2785.6, -2417.72, 13.63, 91, "LS Ware house"},
{-1823.11, 2.86, 15.11, 266, "SF Drug factory"},
{1916.89, 960.17, 10.82 ,180, "LV Four Dragons casino"},
}


VanDropLocations = {

{430, -1797.14, 5.54, 176, "LS Santa Maria beach"},
{-2101.92, -2243.66, 30.62, 176, "SF Angel pine factory"},
{692.83, 1944.87, 5.53, 176, "LV Whore house (Dwayne's bitches house)"},
}
----------------------------------------------------



addEventHandler ( "onResourceStart" , _resroot ,
	function ( )
		DrugDeliveryVan()
		eventTimeRoot = setTimer(DrugDeliveryVan,TimeBetweenTwoEvents*60000,0)
	end
)

addEventHandler("onServerPlayerLogin", getRootElement(),
function ()
	setElementData(source,"ArmoredTruck",false)
end)





function DrugDeliveryVan()

	DeliveryTruckStatus = true

	local x1, y1, z1, r1, txt1 = unpack ( VanStartLocations [ math.random ( #VanStartLocations ) ] )
	local x2, y2, z2, r2, txt2 = unpack ( VanDropLocations [ math.random ( #VanDropLocations ) ] )
	theVan = createVehicle ( 428, x1, y1, z1 - 0.03 )
	startMarker = createMarker(x1,y1,z1-1,"cylinder",8,255,0,0,150)
	addEventHandler("onMarkerHit",startMarker,hitManage)
	addEventHandler("onMarkerLeave",startMarker,LeaveManage)
	setElementRotation(theVan,0,0,r1)
	setElementHealth(theVan, 2000)
	setVehicleColor(theVan, 255, 255, 255)
	theVanBlip = createBlipAttachedTo ( theVan, 51 )
	setElementVisibleTo ( theVanBlip, getRootElement(), false )
	setElementFrozen ( theVan, true )
	setVehicleEngineState(theVan,false)
	setVehicleDamageProof(theVan,true)
	monitorTruckTimer = setTimer(monitorTruck,500,0)
	FromWhere = txt1
	if txt1 == txt2 then
		local x2, y2, z2, r2, txt2 = unpack ( VanDropLocations [ math.random ( #VanDropLocations ) ] )
			ToWhere = txt2
			theFinishMarker = createMarker(x2, y2, z2-4, "cylinder" , 8 ,255,0,0,150)
			theFinishBlip = createBlipAttachedTo ( theFinishMarker, 43 )
			local bx2,by2,bz2 = x1,y1,z1
			local bx,by,bz = x2, y2, z2
			setElementVisibleTo ( theFinishBlip, getRootElement(), false )
			for k,v in ipairs(getElementsByType("player")) do
				if isCrim(v) then
					exports.dendxmsg:createNewDxMessage(v,"[Drugs delivery Mission] : "..txt1.." is requesting to deliver drugs package to "..txt2.."!",0,255,0)
					exports.dendxmsg:createNewDxMessage(v,"[Drugs delivery Mission] : You can search for 'Truck' blip in map (F11)!",0,255,0)
					setElementVisibleTo ( theVanBlip, v, true )
					setElementData(v,"ArmoredTruck",true)
				end
			end
			TimeLeftUntilCanceled = setTimer(function ()
				destroyDeliveryVan ()
			end,TimeWhenEventShouldGetCanceled*60000,1)
			TimeBlipMonitoring = setTimer(function ()
				AtEventBlipCheck ()
			end,3000,0)
			addEventHandler("onMarkerHit",theFinishMarker,onHitMarker)
	else
		theFinishMarker = createMarker(x2, y2, z2-4, "cylinder" , 8 ,255,0,0,25)
		theFinishBlip = createBlipAttachedTo ( theFinishMarker, 43 )
		setElementVisibleTo ( theFinishBlip, getRootElement(), false )
		ToWhere = txt2
		for k,v in ipairs(getElementsByType("player")) do
			if isCrim(v) then
				exports.dendxmsg:createNewDxMessage(v,"[Drugs delivery Mission] : "..txt1.." is requesting to deliver drugs package to "..txt2.."!",0,255,0)
				exports.dendxmsg:createNewDxMessage(v,"[Drugs delivery Mission] : You can search for 'Truck' blip in map (F11)!",0,255,0)
				setElementVisibleTo ( theVanBlip, v, true )
				setElementData(v,"ArmoredTruck",true)
			end
		end
		TimeLeftUntilCanceled = setTimer(function ()
			destroyDeliveryVan ()
		end,TimeWhenEventShouldGetCanceled*60000,1)
		TimeBlipMonitoring = setTimer(function ()
			AtEventBlipCheck ()
		end,3000,0)
		addEventHandler("onMarkerHit",theFinishMarker,onHitMarker)
	end
end

function hitManage(hitElement)
	if hitElement and getElementType(hitElement) == "player" then
		if isCrim(hitElement) then
			if isTimer ( TimeEventLeft) then return end
			table.insert(crimsInFromMarker,hitElement)
		end
	end
end

function LeaveManage(hitElement)
	if hitElement and getElementType(hitElement) == "player" then
		if isCrim(hitElement) then
			for k,v in pairs(crimsInFromMarker) do if v == hitElement then table.remove(crimsInFromMarker,k) break end end
		end
	end
end

function monitorTruck()
	if isElement(theVan) then
		local limit = MaxTruckSpeed
		local speedx, speedy, speedz = getElementVelocity ( theVan )
		local kmh = ((speedx^2 + speedy^2 + speedz^2)^(0.5))*180
		if tonumber(kmh) > tonumber(limit) then
			local diff = limit/kmh
			setElementVelocity(theVan,speedx*diff,speedy*diff,speedz)
		else
			-- nothing
		end
		if isElementInWater(theVan) then destroyDeliveryVan() end
	end
end

function DeliveryStatus(thePlayer)
	if isCrim(thePlayer) then
		if DeliveryTruckStatus == true then
			if isTimer(TimeEventLeft) then
				remaining, executesRemaining, totalExecutes = getTimerDetails(TimeEventLeft)
				exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] :  Event is already in proggress!",255,0,0)
				exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] : Truck has left "..FromWhere.." and is heading to "..ToWhere.."!",255,0,0)
				exports.dendxmsg:createNewDxMessage(thePlayer,""..math.ceil(remaining/60000).." mins left untill event will be finished!",255,0,0)
			elseif isTimer(TimeToCollectReward) then
				remaining, executesRemaining, totalExecutes = getTimerDetails(TimeToCollectReward)
				exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] :  Truck Event has successfully finished!",255,0,0)
				exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] : Pick up reward fast!",255,0,0)
				exports.dendxmsg:createNewDxMessage(thePlayer,""..math.ceil(remaining/1000).." second(s) left untill you're able to pick up reward!",255,0,0)
			elseif isTimer(TimeLeftUntilCanceled) then
				remaining, executesRemaining, totalExecutes = getTimerDetails(TimeLeftUntilCanceled)
				exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] : Drugs Truck is waiting for delivery",255,0,0)
				exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] : "..FromWhere.." is requesting to transport drugs package to "..ToWhere.."!",255,0,0)
				exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] : "..math.ceil(remaining/60000).." minute(s) left untill event will get canceled!",255,0,0)
			end
		else
			remaining, executesRemaining, totalExecutes = getTimerDetails(eventTimeRoot)
			exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] :  Event has finished or canceled!",255,0,0)
			exports.dendxmsg:createNewDxMessage(thePlayer,"[Drugs delivery Mission] : Next event will be ready in next "..math.ceil(remaining/60000).." minute(s)!",255,0,0)
		end
	end
end
addCommandHandler("dtstatus", DeliveryStatus)
addCommandHandler("dt", DeliveryStatus)


function enterVehicle ( thePlayer, seat, jacked )
    if ( source == theVan) and (not isCrim(thePlayer)) and (seat == 0) then
		cancelEvent()
        exports.dendxmsg:createNewDxMessage(thePlayer,"Only criminals are allowed to drive this vehicle!",255,0,0)
    end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )



function enterVehicle ( vehicle, seat, jacked )
    if ( vehicle == theVan ) then
		if isCrim(source) then
			if seat == 0 then
				if isCrim(source) then
					if isTimer ( TimeEventLeft) then return end
					if (#crimsInFromMarker < crimNeeded) then
						exports.DENdxmsg:createNewDxMessage(source,"[Drugs delivery Mission] : You need "..crimNeeded.." criminals in the marker to begin!",255,0,0)
					else
						for k, v in ipairs(getElementsByType("player")) do
							if isCrim(v) then
								exports.dendxmsg:createNewDxMessage(v,"[Drugs delivery Mission] : Truck just left "..FromWhere.." and is heading to "..ToWhere.." (Red dragon blip)!",0,255,0)
								setElementVisibleTo ( theFinishBlip, v, true )
							end
						end

						if isElement(startMarker) then destroyElement(startMarker) end
						TimeEventLeft = setTimer(function ()
							destroyDeliveryVan ()
						end,TimeWenEventTriggered*60000,1)
						setElementFrozen ( theVan, false )
						setVehicleEngineState(theVan,true)
						setVehicleDamageProof(theVan,false)
						if isTimer ( TimeLeftUntilCanceled ) then killTimer ( TimeLeftUntilCanceled ) end
					end
				end
			end
		else
			exports.dendxmsg:createNewDxMessage(source,"[Drugs delivery Mission] : You are not allowed to enter in this vehicle!",255,0,0)
			removePedFromVehicle ( source )
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle )

function enterVehicle2(player)
	if source == theVan then
		if not isCrim(player) then
			removePedFromVehicle(player)
		end
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle2 )



function AtEventBlipCheck()
  if DeliveryTruckStatus == true then
	for k,v in ipairs(getElementsByType("player")) do
		if isCrim(v) then
			setElementVisibleTo ( theVanBlip, v, true )
			if isElementFrozen(theVan) then
				return
			else
				setElementVisibleTo ( theFinishBlip, v, true )
			end
			setElementData(v,"ArmoredTruck",true)

		else
			setElementVisibleTo ( theVanBlip, v, false )
			setElementVisibleTo ( theFinishBlip, v, false )
			setElementData(v,"ArmoredTruck",false)
		end
	end
  end
end

addEventHandler("onVehicleExplode",getRootElement(),
function ()
	if source == theVan then
		destroyDeliveryVan()
	end
end)

function onHitMarker(element)
	if element == theVan then
		setVehicleDamageProof(theVan,true)

		for k, v in ipairs(getElementsByType("player")) do
			if isCrim(v) then
				exports.dendxmsg:createNewDxMessage(v,"[Drugs delivery Mission] : Get the drugs within 1 min!",255,0,0)
			end
		end
		if isTimer ( TimeEventLeft ) then killTimer ( TimeEventLeft ) end

		TimeToCollectReward = setTimer(function ()
			destroyDeliveryVan()
		end,TimeForReward*60000,1)

							setVehicleDoorState(theVan,4,4)
							setVehicleDoorState(theVan,5,4)


		setTimer(function ()
							setElementAlpha(theFinishMarker,0)
							setVehicleEngineState(theVan,false)
							setElementFrozen(theVan,true)
							DeliveryTruckStatus = false
							local vx, vy, vz = getElementPosition(theVan)
							theVanMarker = createMarker(vx, vy, vz, "cylinder" , 1.8 ,55,255,0,10)
							attachElements( theVanMarker, theVan, 0, -3.50, -1)
							addEventHandler("onMarkerHit",theVanMarker,onRewardHit)
							bag = createObject(1580,vx, vy, vz)
							bag1 = createObject(1575,vx, vy, vz)
							setObjectScale(bag,1.2)
							setObjectScale(bag1,1.2)
							attachElements( bag, theVan, -0.3, -3.50, -0.8)
							attachElements( bag1, theVan, 0.3, -3.50, -0.8)
							end, 2000,1)
	end
end


function onRewardHit(hitElement)
if( getElementType( hitElement ) ~= "player" ) then return end
	if getElementData(hitElement,"ArmoredTruck") ~= true then return end
		if isCrim(hitElement) then
		local reward1 = math.random(RewardMIN, RewardMAX)
		local reward2 = math.random(RewardMIN, RewardMAX)
		exports.CSGdrugs:giveDrug(hitElement,"Ritalin",reward1)
		exports.CSGdrugs:giveDrug(hitElement,"Weed",reward2)
		exports.server:givePlayerWantedPoints(hitElement,30)
		exports.dendxmsg:createNewDxMessage(hitElement,"[Drugs delivery Mission] : "..ToWhere.." has gave you "..reward1.." hits of Ritalin for escorting the truck.",50,250,80)
		exports.dendxmsg:createNewDxMessage(hitElement,"[Drugs delivery Mission] : "..ToWhere.." has gave you "..reward2.." hits of Weed for escorting the truck.",50,250,80)
		setElementData(hitElement,"ArmoredTruck",false)
		end
end




function destroyDeliveryVan()
	if (isElement(theVan) and isElement(theVanBlip) and isElement(theFinishBlip) and isElement(theFinishMarker)) then
		for k,v in ipairs(getElementsByType("player")) do
			if isCrim(v) then
				exports.dendxmsg:createNewDxMessage(v,"[Drugs delivery Mission] : Event has been finished/destroyed! *",0,255,0)
				setElementData(v,"ArmoredTruck",false)
			end
		end
		if isTimer ( TimeBlipMonitoring ) then killTimer ( TimeBlipMonitoring ) end
		removeEventHandler("onMarkerHit",theFinishMarker,onHitMarker)
		--removeEventHandler("onVehicleDamage", theVan, displayVehicleLoss)
		DeliveryTruckStatus = false
		crimsInFromMarker = {}

		if isElement(startMarker) then
			destroyElement(startMarker)
		end

		if isElement(theVan) then
			destroyElement(theVan)
		end
		if isElement(theVanBlip) then
			destroyElement(theVanBlip)
		end
		if isElement(theFinishBlip) then
			destroyElement(theFinishBlip)
		end
		if isElement(theFinishMarker) then
			destroyElement(theFinishMarker)
		end
		if isElement(theVanMarker) then
			removeEventHandler("onMarkerHit",theVanMarker,onRewardHit)
			destroyElement(theVanMarker)
		end
		if isElement(bag) then
			destroyElement(bag)
		end
		if isElement(bag1) then
			destroyElement(bag1)
		end
	end
end

local CrimsTeams = {
	"Criminals",
}


function isCrim( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#CrimsTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == CrimsTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end


