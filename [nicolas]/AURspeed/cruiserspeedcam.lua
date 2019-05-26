

ticketTax = get("ticketTax")
allowExit = get("allowExit")
rangeOfRadar = get("rangeOfRadar")


function activateSpeedCamera(source, commandName, allowedspeed)
	local ok = 0	
	local radiuses = getElementsByType("colshape")
	for theKey, theRadius in ipairs(radiuses) do
		if getElementData(theRadius, "Creator") == tostring(getPlayerName(source)) then
			ok = 1
		end
	end
		
	if ok == 0 then	
	local theVehicle = getPedOccupiedVehicle ( source )
	if theVehicle then 
		local id = getElementModel ( theVehicle )
		integerspeed = tonumber(allowedspeed)
		if integerspeed then
			if id == 523 or id == 598 or id == 596 or id == 597 or id == 599 then
				if integerspeed > 80 and integerspeed <500 then
					setElementFrozen(theVehicle, true)
					setElementData(theVehicle, "Speedcamera", 1)
					local x, y, z = getElementPosition(theVehicle)
					radius = createColSphere(x, y, z, rangeOfRadar)
					local creator = getPlayerName(source)
					setElementData(theVehicle, "Creator", creator)
					setElementData(radius, "Creator", creator)
					setElementData(radius, "Allowedspeed", integerspeed)
					exports.NGCdxmsg:createNewDxMessage(source,"Speedcam has been activated on the cruiser.",  255,0, 0, true)	
					playSoundFrontEnd ( source, 101 )
				end
			end
		else
		exports.NGCdxmsg:createNewDxMessage(source,"SYNTAX: /camspeedon <speed allowed in km/h but bigger than 90>",255,0,0)
		exports.NGCdxmsg:createNewDxMessage(source,"EXAMPLE: /camspeedon 90",255,0,0)
		end
	end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You can activate only one speedcam (Don't abuse. Nice try!)",  255, 0, 0, true)
	end
end
addCommandHandler("camspeedon", activateSpeedCamera)

function deactivateSpeedCamera(source, commandName)
	if isPedInVehicle(source) then
	local theVehicle = getPedOccupiedVehicle ( source )
	local id = getElementModel ( theVehicle )
	if id == 523 or id == 598 or id == 596 or id == 597 or id == 599   then
		setElementFrozen(theVehicle, false)
		setElementData(theVehicle, "Speedcamera", 0)
		local radiuses = getElementsByType("colshape")
		for theKey, theRadius in ipairs(radiuses) do
			if getElementData(theRadius, "Creator") == tostring(getPlayerName(source)) then
				destroyElement(theRadius)
			end
		end
		exports.NGCdxmsg:createNewDxMessage(source,"Speedcam has been deactivated on the cruiser.",  255,0, 0, true)	
		playSoundFrontEnd ( source, 101 )
	end
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You are not in a vehicle to use this command.", 255, 0, 0, true)
	end
end
addCommandHandler("camspeedoff", deactivateSpeedCamera)

function ifPlayerDisconnects()
	local vehicles = getElementsByType("vehicle")
	for theKey, theVehicle in ipairs(vehicles) do
		if getElementData(theVehicle, "Creator") == tostring(getPlayerName(source)) then
			setElementFrozen(theVehicle, false)
			setElementData(theVehicle, "Speedcamera", 0)
		end
	end
	local radiuses = getElementsByType("colshape")
	for theKey, theRadius in ipairs(radiuses) do
		if getElementData(theRadius, "Creator") == tostring(getPlayerName(source)) then
			destroyElement(theRadius)
		end
	end
	exports.NGCdxmsg:createNewDxMessage(source,"Speedcam has been deactivated on the cruiser.", 255, 0, 0, true)	
end
addEventHandler("onPlayerQuit", getRootElement(), ifPlayerDisconnects)

function ifPlayerDies()
	local vehicles = getElementsByType("vehicle")
	for theKey, theVehicle in ipairs(vehicles) do
		if getElementData(theVehicle, "Creator") == tostring(getPlayerName(source)) then
			setElementFrozen(theVehicle, false)
			setElementData(theVehicle, "Speedcamera", 0)
		end
	end
	local radiuses = getElementsByType("colshape")
	for theKey, theRadius in ipairs(radiuses) do
		if getElementData(theRadius, "Creator") == tostring(getPlayerName(source)) then
			destroyElement(theRadius)
		end
	end
	exports.NGCdxmsg:createNewDxMessage(source,"Speedcam has been deactivated on the cruiser.", 255, 0, 0, true)	
end
addEventHandler("onPlayerWasted", getRootElement(), ifPlayerDies)

function ticketTheSpeedoman(theVehicle)
	if getElementType(theVehicle) == "vehicle" then
	local id = getElementModel(theVehicle)
		if id ~= 523 and id ~= 598 and id ~= 596 and id ~= 597 and id ~= 599 and id ~= 416 and id ~= 490 and id ~= 427 and id ~= 407 and id ~= 544 then  -- check if vehicles are not for government or emergency
		if getElementData(source, "Creator") then	
			speedx, speedy, speedz = getElementVelocity ( theVehicle )
			actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
			kmh = math.ceil(actualspeed * 180)
			if getElementData(source, "Allowedspeed") < kmh then
				local driver = getVehicleOccupant(theVehicle)
				local moneydriver = getPlayerMoney(driver)
				if getPlayerMoney(driver) > ticketTax and getPlayerMoney(driver) > 0 then
					takePlayerMoney(driver, ticketTax)
					exports.NGCdxmsg:createNewDxMessage(driver,"You have been ticketed for speeding ("..kmh.."km/h). You paid "..tostring(ticketTax)..".", 255, 0, 0, true)	
					fadeCamera ( driver, false, 0.2, 255, 255, 255)
					setTimer ( fadeCamera, 500, 1, driver, true, 2 )
				else
					takePlayerMoney(driver, getPlayerMoney(driver))
					exports.NGCdxmsg:createNewDxMessage(driver,"You have been ticketed for speeding ("..kmh.."km/h). You paid "..tostring(moneydriver)..".",  255,0, 0, true)	
					fadeCamera ( driver, false, 0.2, 255, 255, 255)
					 setTimer ( fadeCamera, 500, 1, driver, true, 2 )
				end
				
				local ticketer = getElementData(source, "Creator")
				local ticketername = getPlayerFromName(ticketer)
				if getPlayerMoney(driver) > ticketTax and getPlayerMoney(driver) > 0 then
					givePlayerMoney( ticketername, ticketTax)
					exports.NGCdxmsg:createNewDxMessage(ticketername,"You ticketed " ..getPlayerName(driver).. " for speeding ("..kmh.."km/h) with $"..tostring(ticketTax)..".", 255, 255, 255, true)	
					playSoundFrontEnd ( ticketername, 101 )
				else
					givePlayerMoney( ticketername, moneydriver)
					exports.NGCdxmsg:createNewDxMessage(ticketername,"You ticketed " ..getPlayerName(driver).. " for speeding ("..kmh.."km/h) with $"..tostring(moneydriver)..".",   255, 255, 255, true)	
					playSoundFrontEnd ( ticketername, 101 )
				end
			end
		end
		end
	end
end
addEventHandler("onColShapeHit", getRootElement(), ticketTheSpeedoman)

function stopFromExit(thePlayer)
	if allowExit == false and getElementData(source, "Speedcamera") == 1 then
		cancelEvent()
		exports.NGCdxmsg:createNewDxMessage(thePlayer,"You cannot leave the vehicle when speed camera is activated.",  255, 0, 0, true)
	end
end
addEventHandler ( "onVehicleStartExit", getRootElement(), stopFromExit ) 

		