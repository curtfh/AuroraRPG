local options = {[1] = { regularPrice = 1000, mechPrice = 600, upgradeID = 1008 }}

function notifyMechanic( message)
	exports.NGCdxmsg:createNewDxMessage(source, message, 200, 0, 0)
end
addEvent("notifyMechanic", true)
addEventHandler("notifyMechanic", root, notifyMechanic)

function doVehicleRepair(option,mechanic,vehicle,price)

	local messageToBuyer
	local messageToMechanic

	if getPlayerMoney(source) >= price then
		if option == 1 then
			messageToBuyer = "You have bought 5 NOS ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have sold 5 NOS to "..getPlayerName(source)..', earning you: $'..price.."."
			addVehicleUpgrade(vehicle,1008)
			nitro = 500
			local mynos = getElementData(source,"nos") or 0
			local theNos = nitro+mynos
			setElementData(source,"nos",math.floor(theNos))
			exports.DENstats:setPlayerAccountData(source,"nos",math.floor(theNos))
			if getElementData(source,"nos") > 5000 then
				setElementData(source,"nos",5000)
				theNos = 5000
			end
			exports.NGCdxmsg:createNewDxMessage(source,"You have refilled your NOS Tank by 50% (total NOS: "..math.floor(theNos).."%)",0,255,0)
			if source ~= mechanic then
				----exports.NGCmanagement:GPM(mechanic,price,"DENmech","Selling NOS")
				exports.AURpayments:addMoney(mechanic,price,"Custom","Mechanic",0,"AURmech NOS")
			end
		elseif option == 2 then
			messageToBuyer = "You have bought hydraulics ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have sold hydraulics to "..getPlayerName(source)..", earning you: $"..price.."."
			addVehicleUpgrade(vehicle,1087)
			if source ~= mechanic then
				---exports.NGCmanagement:GPM(mechanic,price,"DENmech","Selling hydraulics")
				exports.AURpayments:addMoney(mechanic,price,"Custom","Mechanic",0,"AURmech hydraulics")
			end
		elseif option == 3 then
			setVehicleWheelStates(vehicle,0,0,0,0)
			messageToBuyer = "You have bought new wheels ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have sold new wheels to "..getPlayerName(source)..", earning you: $"..price.."."
			setVehicleDamageProof(vehicle,false)
			if source ~= mechanic then
				---exports.NGCmanagement:GPM(mechanic,price,"DENmech","fixing wheels")
				exports.AURpayments:addMoney(mechanic,price,"Custom","Mechanic",0,"AURmech wheel")
			end
		elseif option == 4 then
			setVehicleDamageProof(vehicle,false)
			local vx,vy,vz = getElementRotation(vehicle)
			if vx > 90 or vy > 90 then
				setElementRotation(vehicle,0,0,vz)
			end
			setElementFrozen(mechanic,false)
			triggerEvent("onVehicleGetFixed",vehicle,vehicle)
			messageToBuyer = "You have bought a complete repair ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have repaired "..getPlayerName(source).."'s vehicle, earning you: $"..price.."."
			if source ~= mechanic then
				if getElementHealth(vehicle) <= 251 then setMechanicPoints(mechanic) end
				local theRank,number = exports.CSGranks:getRank(mechanic,"Mechanic")
				---exports.NGCmanagement:GPM(mechanic,price,"DENmech","Fixing vehicle")
				exports.AURpayments:addMoney(mechanic,price,"Custom","Mechanic",0,"AURmech fixing vehicle")
				setVehicleDamageProof(vehicle,false)
			end
			setPedAnimation(mechanic, false)
			fixVehicle(vehicle)
		elseif option == 5 then
			setElementData(vehicle,"vehicleFuel",100)
			triggerEvent("onVehicleGetFixed",vehicle,vehicle)
			messageToBuyer = "You have bought a complete refill ( $"..price.." ) for your vehicle."
			messageToMechanic = "You have filled "..getPlayerName(source).."'s vehicle, earning you: $"..price.."."
			if source ~= mechanic then
			---	exports.NGCmanagement:GPM(mechanic,price,"DENmech","refuel vehicle")
				exports.AURpayments:addMoney(mechanic,price,"Custom","Mechanic",0,"AURmech refuel")
			end
		end
		exports.NGCdxmsg:createNewDxMessage(source, messageToBuyer, 0, 255, 0)
		--exports.NGCmanagement:RPM(source,price)
		exports.AURpayments:takeMoney(source,price,"AURmech")
		if source ~= mechanic then
			exports.NGCdxmsg:createNewDxMessage(mechanic, messageToMechanic, 0, 255, 0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source, "You don't have enough money!", 255, 0, 0)
	end
end
addEvent("doVehicleRepair", true)
addEventHandler("doVehicleRepair", root, doVehicleRepair)

addEvent("doVehicleLoading",true)
addEventHandler("doVehicleLoading",root,function(veh,t)
	if source and isElement(source) then
		setElementData(source,"mechanicData",t)
		triggerClientEvent(source,"barAmount",source,veh)
		setElementFrozen(source,true)
		setPedAnimation(source, "RYDER", "RYD_Beckon_03")
	end
end)

addEvent("doVehicleEndEffect",true)
addEventHandler("doVehicleEndEffect",root,function()
	if source and isElement(source) then
		setElementFrozen(source,false)
	end
end)

function getBonusMultiplier(player,rankNumber)
	local rankNumber = rankNumber -1 -- first rank has no bonus
	return 1+(math.floor(rankNumber*2)/40)
end


function setMechanicPoints(player)
	local pts = exports.DENstats:getPlayerAccountData(player,"MechanicPoints")
	if pts then
		exports.DENstats:setPlayerAccountData ( player, "MechanicPoints", pts+0.5 )
	else
		exports.DENstats:setPlayerAccountData ( player, "MechanicPoints", 0.5 )
	end
end

-- rewrite
addEvent("onMechanicPickVehicle",true)
function onMechanicPickVehicle(vehicleOwner,vehicle)
	triggerClientEvent(vehicleOwner, "onMechanicShowGUI", vehicleOwner, source, vehicle)
end

addEventHandler("onMechanicPickVehicle", root, onMechanicPickVehicle )

function rejectMechanicRequest (theMechanic)
	exports.NGCdxmsg:createNewDxMessage(theMechanic, getPlayerName(source) .. " doesn't need your services now.", 200, 0, 0)
end
addEvent("rejectMechanicRequest", true)
addEventHandler("rejectMechanicRequest", root, rejectMechanicRequest)
