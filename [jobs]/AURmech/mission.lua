local missionLocations = {
--Vehicle name, x,y,z
{"Infernus", 1078.67,-1276.49,13.38,269},
{"Infernus", 1051.09,-1368.46,12.9,178},
{"Infernus", 913.34,-1460.44,12.93,178},
{"Infernus", 1323.71,-1410.38,12.86,267},
{"Infernus", 1371.73,-1068.55,25.66,353},
{"Infernus", 1339.22,-910.4,35.44,178},
{"Infernus", 1081.48,-943.82,42.18,96},
{"Infernus", 891.05,-926.97,41.45,125},
{"Infernus", 1780.29,-1164.6,23.32,235},
{"Infernus", 2223.04,-1150.06,25.31,14},
}

local LSHQ = {1053.39, -1030.39, 32.28}

local theVehicle
local bip
local marker
local markerblip

function startMission()
	if (getElementData(localPlayer, "Occupation") == "Mechanic") then 
		local getRandomMission = math.random(#missionLocations)
		if (type(missionLocations[getRandomMission][1]) == "string") then 
			if (isElement(theVehicle)) then 
				destroyElement(theVehicle)
				destroyElement(blip)
			end 
			exports.NGCdxmsg:createNewDxMessage("Mechanic Radio: Someone called to tow the vehicle. Go to Bulldozer blip to tow the vehicle.",0,255,0)
			theVehicle = createVehicle(getVehicleModelFromName(missionLocations[getRandomMission][1]), missionLocations[getRandomMission][2], missionLocations[getRandomMission][3], missionLocations[getRandomMission][4])
			blip = createBlipAttachedTo(theVehicle, 11, 3)
			setElementData(localPlayer, "AURmech.towVehicle", theVehicle)
			towDeliverToBase()
			local rotX, rotY, rotZ = getElementRotation(theVehicle)
			setElementRotation(theVehicle, rotX, rotY, missionLocations[getRandomMission][5])
			setVehicleDamageProof (theVehicle, true)
		end 
	end 
end 
addEvent("AURmech.startMission", true)
addEventHandler("AURmech.startMission", localPlayer, startMission)

function desMission()
	exports.NGCdxmsg:createNewDxMessage("Mechanic Radio: The other mechanics has taken that job.",0,255,0)
	if (isElement(theVehicle)) then 
		destroyElement(theVehicle)
		destroyElement(blip)
		setElementData(localPlayer, "AURmech.towVehicle", nil)
		if (isElement(marker)) then 
			removeEventHandler ("onClientMarkerHit", marker, deliverSuccessful)
			destroyElement(markerblip)
			destroyElement(marker)
		end 
	end 
end  
addEvent("AURmech.desMission", true)
addEventHandler("AURmech.desMission", localPlayer, desMission)

function towDeliverToBase ()
	if (getElementData(localPlayer, "Occupation") == "Mechanic") then 
		exports.NGCdxmsg:createNewDxMessage("Mechanic Radio: If you towed the vehicle just go to our head quarters. House blip.",0,255,0)
		desMarker()
		setElementData(localPlayer, "AURmech.towVehicle", theVehicle)
		marker = createMarker(LSHQ[1], LSHQ[2], LSHQ[3]-1, "cylinder", 4)
		markerblip = createBlipAttachedTo(marker, 31, 3)
		addEventHandler ("onClientMarkerHit", marker, deliverSuccessful)
	end 
end 
addEvent("AURmech.towDeliverToBase", true)
addEventHandler("AURmech.towDeliverToBase", localPlayer, towDeliverToBase)

function desMarker ()
	if (isElement(marker)) then 
		removeEventHandler ("onClientMarkerHit", marker, deliverSuccessful)
		destroyElement(markerblip)
		destroyElement(marker)
	end 
end 
addEvent("AURmech.desMarker", true)
addEventHandler("AURmech.desMarker", localPlayer, desMarker)

local antiCheat
function deliverSuccessful (hitPlayer)
	if (antiCheat == true) then return false end
	if (getElementData(localPlayer, "Occupation") == "Mechanic") then 
		if (localPlayer ~= hitPlayer) then return false end
		if (getVehicleTowedByVehicle (getPedOccupiedVehicle(localPlayer)) == theVehicle) then
			if (isElement(theVehicle)) then 
				triggerServerEvent("AURmech.sendMoney", resourceRoot)
				destroyElement(theVehicle)
				destroyElement(blip)
				setElementData(localPlayer, "AURmech.towVehicle", nil)
				exports.NGCdxmsg:createNewDxMessage("Mechanic Radio: You successfully delivered the vehicle to our headquarters.",0,255,0)
				if (isElement(marker)) then 
					removeEventHandler ("onClientMarkerHit", marker, deliverSuccessful)
					destroyElement(markerblip)
					destroyElement(marker)
				end 
				setTimer(function() antiCheat = false end, 30000, 1)
				antiCheat = true
				startMission()
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Mechanic Radio: You must tow the vehicle. Go to Bulldozer blip.",0,255,0)
		end 
	end
end 
