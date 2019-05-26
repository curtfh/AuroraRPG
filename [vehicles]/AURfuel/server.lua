-- Event that let the drive pay for the refueling
addEvent ( "payFuelVehicle", true )
addEventHandler ( "payFuelVehicle", root,
	function ( thePrice )
		--if ( exports.CSGgift:getChristmasDay() ~= "Day24" ) then thePrice = 0 end
		exports.AURpayments:takeMoney( source, thePrice,"AURFuel" )
	end
)

-- Exports to set vehicle fuel
function setVehicleFuel ( theVehicle, theFuel )
	if ( theVehicle ) and ( isElement( theVehicle ) ) and ( theFuel ) then
		setElementData ( theVehicle, "vehicleFuel", theFuel )
		return true
	else
		return false
	end
end

-- Exports to get vehicle fuel
function getVehicleFuel ( theVehicle )
	if ( theVehicle ) and ( isElement( theVehicle ) ) then
		return getElementData ( theVehicle, "vehicleFuel" )
	else
		return false
	end
end


addEvent("onPlayerEffectRefuel",true)
addEventHandler("onPlayerEffectRefuel",root,function ()
    if isPedInVehicle(source) == false then
		local x,y,z = getElementPosition(source)
		for k,v in ipairs(getElementsByType("vehicle")) do
			local vX,vY,vZ = getElementPosition(v)
			if (getDistanceBetweenPoints3D(x,y,z,vX,vY,vZ) <= 20) then
				local oldFuel = getElementData(v,'vehicleFuel')
				if (getElementModel(v) == 510) or (getElementModel(v) == 481) or (getElementModel(v) == 509) or (getElementModel(v) == 571) or (getElementModel(v) == 462) then exports.NGCdxmsg:createNewDxMessage("You can't refuel a bike",source,255,0,0) return false end
				if oldFuel < 100 then
                    setElementData(v,'vehicleFuel',math.min(100,oldFuel+50))
					toggleAllControls(source,false,true,false)
					exports.NGCdxmsg:createNewDxMessage(source,"Refueling...",255,255,0)
					setTimer(function(plr)
						toggleAllControls(plr,true,true,true)
						exports.NGCdxmsg:createNewDxMessage(plr,"You have successfully re-fueled your vehicle!",255,255,0)
					end,5000,1,source)
				else
					exports.NGCdxmsg:createNewDxMessage(source,"Your vehicle doesn't need fuel, fuel can wasted",255,255,0)
				end
			end
		end
	end
end)

--Engine
local timerSpam = {}

function engine ( playerSource, commandName )
	if (isTimer(timerSpam[playerSource])) then return false end
	timerSpam[playerSource] = setTimer(function() killTimer(timerSpam[playerSource]) end, 5000, 1)
    triggerClientEvent ( playerSource, "onEngine", playerSource )
end
addCommandHandler ( "engine", engine )

addEvent("buyFuelCan",true)
addEventHandler("buyFuelCan",root,
    function ()
	local kitmoney = getPlayerMoney (source)
	if (kitmoney >= 550*exports.AURtax:getCurrentTax()) then
		if exports.DENstats:getPlayerAccountData(source,"gsc") < 0 then
			exports.DENstats:setPlayerAccountData(source,"gsc",0)
		end
		exports.DENstats:setPlayerAccountData(source,"gsc",exports.DENstats:getPlayerAccountData(source,"gsc")+1)
		exports.NGCmanagement:RPM(source,550*exports.AURtax:getCurrentTax())
		fadeCamera ( source, false, 1 )
        setTimer( fadeCamera, 500, 1, source, true, 1 )
		exports.NGCdxmsg:createNewDxMessage(source,"You have bought fuel conister for $"..(550*exports.AURtax:getCurrentTax()),0,255,0)
		exports.NGCdxmsg:createNewDxMessage(source,"Stand near the vehicle and type /refuel",255,255,0)
	end
end )

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	triggerClientEvent(source,"recgsc",source,exports.DENstats:getPlayerAccountData(source,"gsc"))
end)

addEvent("onPlayerUsedRefuel",true)
addEventHandler("onPlayerUsedRefuel",root,function()
	exports.DENstats:setPlayerAccountData(source,"gsc",exports.DENstats:getPlayerAccountData(source,"gsc")-1)
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		triggerClientEvent(source,"recgsc",source,exports.DENstats:getPlayerAccountData(source,"gsc"))
	end
end,10000,1)
