local peds = {}
function close (skin,x,y,z)
	peds[source] = createPed(skin,x,y,z)
    warpPedIntoVehicle(peds[source],getPedOccupiedVehicle(source),1)
end
addEvent("warpPed", true)
addEventHandler("warpPed", getRootElement(), close)


function cleanPedsFromServer()
	if peds[source] then
		if isElement(peds[source]) then destroyElement(peds[source]) end
	end
end
addEvent("cleanPedsFromServer", true)
addEventHandler("cleanPedsFromServer", getRootElement(), cleanPedsFromServer)

function giveTaxiMoney(money)
	totalMoney = math.floor(money)
	---givePlayerMoney(source,totalMoney)
	exports.AURpayments:addMoney(source,totalMoney,"Custom","Taxi Driver",0,"AURtaxi by bot")
	exports.CSGranks:addStat(source,1)
	exports.CSGscore:givePlayerScore(source,1)
	exports.NGCdxmsg:createNewDxMessage(source,"You have earned $"..totalMoney.." and 1 score point",0,255,0)
end
addEvent("giveTaxiMoney", true)
addEventHandler("giveTaxiMoney", getRootElement(), giveTaxiMoney)



function cleanPedsFromServer2()
	if peds[source] then
		if isElement(peds[source]) then destroyElement(peds[source]) end
	end
end
addEventHandler("onPlayerQuit", getRootElement(), cleanPedsFromServer2)

taxiIDs = { [420]=true, [438]=true }

local blips = {}
local timers = {}
addEvent( "onPhoneCallService", true )
function onPhoneCallService ( theOccupation, theTeam )
	if theOccupation == "Taxi Driver" then
		for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v,"Occupation") == theOccupation then
				if v ~= source then
					exports.killMessages:outputMessage(getPlayerName(source).." has requested a taxi ( "..getZoneName(getElementPosition(source)).." Street )",v,255,255,0,"default-bold")
					exports.NGCdxmsg:createNewDxMessage(v,"Taxi passenger blip will be disappear within 1 minute.",0,255,0)
				if isElement(blips[source]) then destroyElement(blips[source]) end
				blips[source] = createBlipAttachedTo(source,58)
				setElementVisibleTo ( blips[source], root, false )
				setElementVisibleTo ( blips[source], v, true )
				if isTimer(timers[source]) then killTimer(timers[source]) end
				timers[source] = setTimer(function(plr)
					if isElement(blips[plr]) then destroyElement(blips[plr]) end
					blips[plr] = nil
					end,60000,1,source)
				end
			end
		end
	end
end
addEventHandler( "onPhoneCallService", root, onPhoneCallService )


addEventHandler("onPlayerQuit",root,function()
	if blips[source] then
		if isElement(blips[source]) then destroyElement(blips[source]) end
		blips[source] = nil
	end
	if timers[source] then
		if isTimer(timers[source]) then killTimer(timers[source]) end
		timers[source] = nil
	end
end)


function taxiLightFunc ( thePlayer )
	if ( isPedInVehicle ( thePlayer ) ) then
		if ( taxiIDs[getElementModel(getPedOccupiedVehicle(thePlayer))] ) and ( getPedOccupiedVehicleSeat ( thePlayer ) == 0 ) then
			setVehicleTaxiLightOn ( getPedOccupiedVehicle ( thePlayer ), not isVehicleTaxiLightOn ( getPedOccupiedVehicle ( thePlayer ) ) )
			if isVehicleTaxiLightOn(getPedOccupiedVehicle(thePlayer)) then
				triggerClientEvent(thePlayer,"NGCtaxi.togLight",thePlayer,true)
			else
				triggerClientEvent(thePlayer,"NGCtaxi.togLight",thePlayer,false)
			end
		end
	end
end


function checkTaxiDriver ( thePlayer, seat, jacked )
	if ( taxiIDs[getElementModel(source)] ) and ( seat == 0 ) then
		if ( getElementData ( thePlayer, "Occupation" ) ~= 6 and getElementData ( thePlayer, "Occupation" ) == "Taxi Driver" ) then
			bindKey ( thePlayer, "2", "down", taxiLightFunc )
			exports.NGCdxmsg:createNewDxMessage (thePlayer,"Press the 2 button to start or stop your service for players",0,255,0 )
			setVehicleTaxiLightOn (source,true)
			triggerClientEvent(thePlayer,"NGCtaxi.togLight",thePlayer,true)
		end
	elseif ( taxiIDs[getElementModel(source)] ) and ( seat >= 1 ) then
		if ( isVehicleTaxiLightOn ( source ) ) then
			local taxidriver = getVehicleOccupant ( source, 0 )
			if isElement(taxidriver) and getElementData ( taxidriver, "Occupation" ) == "Taxi Driver" then
				       setTimer ( payTaxiFunc, 10000, 1, taxidriver, thePlayer )
			end
		end
	end
end

addEventHandler ( "onVehicleEnter", getRootElement(), checkTaxiDriver )

function payTaxiFunc ( taxidriver, customer )
if getElementType(customer) == "player" and getElementType(taxidriver) == "player" then
	if ( isPedInVehicle ( customer ) ) then
		if ( taxiIDs[getElementModel(getPedOccupiedVehicle(customer))] ) then
			if ( getPlayerName ( taxidriver ) == getPlayerName ( getVehicleOccupant ( getPedOccupiedVehicle ( customer ), 0 ) ) ) then
				if ( isVehicleTaxiLightOn ( getPedOccupiedVehicle ( customer ) ) ) then
					if ( getPlayerMoney ( customer ) >= 20 ) then
		            sx, sy, sz = getElementVelocity ((getVehicleOccupant ( getPedOccupiedVehicle (taxidriver),0)))
					speed = math.floor(((sx^2 + sy^2 + sz^2)^(0.5))*180)
                        if speed >= 50 then
						if getTeamName(getPlayerTeam(customer)) == "Staff" then return false end
						local money = math.random(20,40)
						----takePlayerMoney ( customer, money )
						---givePlayerMoney ( taxidriver, money )
						exports.AURpayments:takeMoney(customer,money,"AURtaxi")
						exports.AURpayments:addMoney(taxidriver,money,"Custom","Taxi Driver",0,"AURtaxi")
						exports.NGCdxmsg:createNewDxMessage(customer,"You have paid $"..money.." for taxi service",0,255,0)
						if not getElementData(taxidriver,"taxi2") then setElementData(taxidriver,"taxi2",0) end
						if not getElementData(taxidriver,"taxi") then setElementData(taxidriver,"taxi",0) end
						setElementData(taxidriver,"taxi2",getElementData(taxidriver,"taxi2")+money)
						setElementData(taxidriver,"taxi",money)
						setTimer ( payTaxiFunc, 10000, 1, taxidriver, customer )
						else
					   exports.NGCdxmsg:createNewDxMessage(taxidriver,"You are driving under the required speed, speed up!",255,0,0)
					   setTimer ( payTaxiFunc, 10000, 1, taxidriver, customer )
					   return  end
					else
						removePedFromVehicle ( customer )
						local x,y,z = getElementPosition((getVehicleOccupant ( getPedOccupiedVehicle (taxidriver),0)))
						setElementPosition(customer,x+5,y+10,z)
						exports.NGCdxmsg:createNewDxMessage(customer, "You do not have enough money!",255,0,0)
					end
				end
			end
		end
	end
end
end

