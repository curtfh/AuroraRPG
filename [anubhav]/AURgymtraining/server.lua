local trainingStartMarker  = createMarker(2237.94, -1720.32, 12.61, "cylinder", 2, 255, 255, 0)

function trainingMarkerHit(hitElement, dimensions)
	if (getElementType(hitElement) ~= "player") then
		return false 
	end
	if (not dimensions) then
		return false 
	end
	if (not isPedOnGround(hitElement)) then
		exports.NGCdxmsg:createNewDxMessage("You must be on ground to open the GUI!", hitElement, 255, 25, 25)
		return false 
	end
	if (getElementModel(hitElement) ~= 0) then
		exports.NGCdxmsg:createNewDxMessage("You must have the CJ skin!", hitElement, 255, 25, 25)
		return false 
	end
	triggerClientEvent(hitElement, "AURgymtraining.open", resourceRoot)
end
addEventHandler("onMarkerHit", trainingStartMarker, trainingMarkerHit)

function resetMuscle()
	setPedStat(client, 23, 0)
	exports.NGCdxmsg:createNewDxMessage("Your muscle was reset!", source, 25, 255, 25)
	exports.CSGlogging:createLogRow(client, "muscle", getPlayerName(client).." reset his muscles")
end
addEvent("AURgymtraining.reset", true)
addEventHandler("AURgymtraining.reset", resourceRoot, resetMuscle)

function trainMuscle()
	local stat = getPedStat(client, 23)
	if (stat == 1000) then
		exports.NGCdxmsg:createNewDxMessage("Your muscles are already fully trained!", client, 25, 255, 25)
		return false
	end
	fadeCamera(client, false)
	setElementFrozen(client, true)
	setTimer(function(client) 
		fadeCamera(client, true)
		setElementFrozen(client, false)
	end, 2000, 1, client)
	setPedStat(client, 23, stat+100)
	takePlayerMoney(client, 2000)
	exports.CSGlogging:createLogRow(client, "muscle", getPlayerName(client).." trained his muscles (value (after training): "..tostring(stat+100))
	exports.NGCdxmsg:createNewDxMessage("Your musles were increased by 10%!", client, 25, 255, 25)
end
addEvent("AURgymtraining.train", true)
addEventHandler("AURgymtraining.train", resourceRoot, trainMuscle)