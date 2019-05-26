--[[function attachRa(theVehicle)
    local driver = getVehicleOccupant (theVehicle)
	if (getElemenType(driver) == "player") then
		if (getElementData(driver, "Occupation") == "Mechanic") then 
			if (isElement(getElementData(driver, "AURmech.towVehicle"))) then 
				triggerClientEvent(driver, "AURmech.towDeliverToBase", driver)
			end 
		end 
	end 
 end
addEventHandler("onTrailerAttach", getRootElement(), attachRa)

function deattachRa(theVehicle)
    local driver = getVehicleOccupant (theVehicle)
	if (getElemenType(driver) == "player") then
		if (getElementData(driver, "Occupation") == "Mechanic") then 
			if (isElement(getElementData(driver, "AURmech.desMarker"))) then 
				triggerClientEvent(driver, "AURmech.desMarker", driver)
				exports.NGCdxmsg:createNewDxMessage(driver, "Mechanic Radio: You left the vehicle untowed!",0,255,0)
			end 
		end 
	end 
 end
addEventHandler("onTrailerDetach", getRootElement(), deattachRa)]]--

function onPlayerChangedJob (jobName)
	if (jobName ~= "Mechanic") then 
		triggerClientEvent(source, "AURmech.desMission", source)
	end 
end 
addEvent ("onPlayerJobChange", true)
addEventHandler ("onPlayerJobChange", root, onPlayerChangedJob)

function missionOn ( thePlayer, seat, jacked )
    if ( getElementModel ( source ) == getVehicleModelFromName("Towtruck") ) then 
		if (getElementData(thePlayer, "Occupation") == "Mechanic") then 
			triggerClientEvent(thePlayer, "AURmech.startMission", thePlayer)
		end
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), missionOn)

local antiCheatTable = {}
function sendMoney ()
	--if ( getElementModel (client) == getVehicleModelFromName("Towtruck") ) then 
		--if (getElementData(client, "Occupation") == "Mechanic") then 
			if (isTimer(antiCheatTable[client])) then return false end 
			antiCheatTable[client] = setTimer(function() killTimer(antiCheatTable[client]) end, 30000, 1)
			exports.AURpayments:addMoney(client, 5000,"Custom","Mechanic",0,"AURmech Mission")
			exports.CSGscore:givePlayerScore(client, 1.5)
			exports.NGCdxmsg:createNewDxMessage(client, "You received $5,000 and 1.5 score from Mechanic Mission.",0,255,0)
		--end 
	--end
end 
addEvent ("AURmech.sendMoney", true)
addEventHandler ("AURmech.sendMoney", resourceRoot, sendMoney)