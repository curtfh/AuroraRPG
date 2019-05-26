local lastID = 0
local letters = 0
local deliveryMarkers = {}
local deliveryPositions = {
-- x, y, z, rotation, interior, name = "any name"

	{-2639.18,730.57,30.07,268.90, 0, name = "Addison Adam"},
	{-2982.17,475.93,4.9,270.58, 0, name = "Clarence Mark"},
	{-2866.91,956.62,44.05,114.51, 0, name = "Waylon Dalton"},
	{-2420.69,1137.69,55.72,168.26, 0, name = "Justine Henderson"},
	{-2129.54,618.94,51.68,91.06, 0, name = "Abdullah Lang"},
	{-2180.1,603.07,35.16,359.92, 0, name = "Marcus Cruz"},
	{-2624.28,1411.29,7.09,193.94, 0, name = "Jessica Stone"},
	{-2090.89,1433.77,7.32,263.61, 0, name = "Lia Shelton"},
	{-1652.74,1413.37,7.18,225.54, 0, name = "Joanna Shaffer"},
	{-1770.13,960.31,24.64,269.46, 0, name = "Hartman the Taxi Driver"},
	{-1813.91,1078.58,46.08,268.08, 0, name = "Angela Walker"},
	{-2533.64,1151.41,55.56,353.42, 0, name = "Mathias Little"},
	{-1606.26,673.22,-5.25,358.79, 0, name = "Officer Arwa"},
	{-2427.84,332.09,36.99,241.44, 0, name = "Barack Obama"},
	{-1862.09,-145.14,11.89,357.96, 0, name = "Jonathon Sheppard"},
	{-2535.15,-689.34,139.32,180.72, 0, name = "Alex Wright"},
	{-2718.47,-316.91,7.84,42.94, 0, name = "Eric Norton"},
	{-2575.2,241.96,9.56,206.85, 0, name = "Yvonne Watkins"},
	{-2762.01,375.47,5.45,270.06, 0, name = "Margaret Welch"},
	{-2501.34,947.31,63.44,269.87, 0, name = "Carmen Malone"},
	
	{-2477.07, 1338.11, 8.5, 270, 23, name = "Bill Gates"},

}

function createDeliveryMarker ()
	if (letters > 0) then
		local randomid = lastID + 1
		lastID = lastID + 1
			if (randomid >= #deliveryPositions) then
				lastID = 1
				randomid = 1
			end
		deliveryMarker = createMarker(deliveryPositions[randomid][1], deliveryPositions[randomid][2], deliveryPositions[randomid][3], "cylinder", 2, 255,255,0,255)
		deliveryPed = createPed (math.random(1,216), deliveryPositions[randomid][1], deliveryPositions[randomid][2], deliveryPositions[randomid][3], deliveryPositions[randomid][4])
		deliveryBlip = createBlipAttachedTo(deliveryMarker, 41)
		setElementFrozen(deliveryPed)
		deliveryMarkers[deliveryMarker] = randomid
		exports.NGCdxmsg:createNewDxMessage(""..deliveryPositions[randomid]["name"].." has a letter to be sent, head to they waypoint blip to deliver it!",255,255,0)
	else
		exports.NGCdxmsg:createNewDxMessage("Head to Disk icon to get some letters to deliver!",255,255,0)
		post = createMarker (-1917.59, 671.52, 46.56, "cylinder", 1.5,255,255,0,255)
		postBlip = createBlipAttachedTo(post, 35)
		postPed = createPed (255, -1917.59, 671.52, 46.56, 90)
		setElementFrozen(postPed, true)
	end
end
addEvent("AURpostman.startJob", true)
addEventHandler("AURpostman.startJob", root, createDeliveryMarker)

function endJob ()

	if (isElement(deliveryMarker)) then
		destroyElement(deliveryBlip)
		destroyElement(deliveryMarker)
		destroyElement(deliveryPed)
		deliveryMarker = nil
		deliveryBlip = nil
		deliveryPed = nil
	elseif (isElement(post)) then
		destroyElement(postBlip)
		destroyElement(post)
		destroyElement(postPed)
		postPed = nil
		postBlip = nil
		post = nil
	end
end
addEvent("AURpostman.endJob", true)
addEventHandler("AURpostman.endJob", root, endJob)

function onDataChange (dataName, oldValue)

	if (dataName == "Occupation") and (oldValue == "Postman") and (getElementData(localPlayer, "Occupation") ~= "Postman") then
		endJob ()
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onDataChange)


function refillOnHit (hitElement, dim)

	if not (dim) then return false end
	if not (source == post) then return false end
	if (hitElement ~= localPlayer) then return false end
	if (isPedInVehicle(hitElement)) then return exports.NGCdxmsg:createNewDxMessage("You have to leave your vehicle first!",255,0,0) end
	exports.NGCdxmsg:createNewDxMessage("Refilling letters...",255,255,0)
	letters = 7
	setElementFrozen (hitElement, true)
	setPedAnimation(hitElement, "gangs", "dealer_deal")
	setTimer(setPedAnimation, 1000*2,1,hitElement, false)
	setTimer(setElementFrozen, 1000*2,1,hitElement, false)
	setTimer(endJob,1000*2,1)
	setTimer(createDeliveryMarker, 1000*2,1)
end
addEventHandler("onClientMarkerHit", root, refillOnHit)

function deliverHit (hitElement, dim)

	if not (dim) then return false end
	if not (source == deliveryMarker) then return false end
	if (hitElement ~= localPlayer) then return false end
	if (isPedInVehicle(hitElement)) then return exports.NGCdxmsg:createNewDxMessage("You have to leave your vehicle first!",255,0,0) end
		letters = letters-1
		if (letters == 0) then
			endJob()
			createDeliveryMarker()
			exports.NGCdxmsg:createNewDxMessage("You run out of letters, go get some more to deliver from disk icon !",255,255,0)
		else
			setPedAnimation(hitElement, "gangs", "dealer_deal")
			setTimer(setPedAnimation, 1000*2,1,hitElement, false)
			setElementFrozen (hitElement, true)
			setTimer(setElementFrozen, 1000*2,1,hitElement, false)
			setTimer(endJob,1000*2,1)
			setTimer(createDeliveryMarker,1000*2,1)
			triggerServerEvent("AURpostman.payment", resourceRoot, hitElement, deliveryPositions[deliveryMarkers[deliveryMarker]]["name"])
		end
end
addEventHandler("onClientMarkerHit", root, deliverHit)

function togglePostman()
	if (getElementData(localPlayer, "Occupation") == "Postman" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5", "down", togglePostman)