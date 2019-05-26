local eventMarkers = {}
local blips = {}
local markers = {
    {3649.01, -1934.18, 19.76},
    {4001.79, -1660.19, 20.27 },
    {4071.88, -1548.56, 20.56},
    {3811.99, -2538.42, 19.6},
    {4204.76, -1785, 20.24},
}
local timers = {}
local crimProgress = 0
local copProgress = 0
local ownedByCrims = false
local ownedByCops = false
local capturedByCrims = false
local capturedByCops = false
local playersInMarker = 0
local cityCol = createColCuboid(3022.98, -2698.86, 19, 1200, 1200, 12.25)
local cityArea = createRadarArea(3022.98, -2698.86, 1200,1200, 255,255,255,180)

function isOwnedByCrims()
    return ownedByCrims
end
function onResourceStart ()

	executeSQLQuery("CREATE TABLE IF NOT EXISTS eventMarkers (id INT, owner TEXT)")
	for k,v in ipairs (markers) do
		marker = createMarker(v[1], v[2], v[3], "checkpoint", 2, 255,255,255,150)
		blips[marker] = createBlip(v[1], v[2], v[3], 0, 3.5, 255,255,255,255)
		eventMarkers[marker] = k
		setElementData(marker, "AURcityevent.eventMarker", true)
		local query = executeSQLQuery("SELECT * FROM eventMarkers")
		if (#query == 0) then
			executeSQLQuery("INSERT INTO eventMarkers (id, owner) VALUES (?,?)", 1, "None")
			executeSQLQuery("INSERT INTO eventMarkers (id, owner) VALUES (?,?)", 2, "None")
			executeSQLQuery("INSERT INTO eventMarkers (id, owner) VALUES (?,?)", 3, "None")
			executeSQLQuery("INSERT INTO eventMarkers (id, owner) VALUES (?,?)", 4, "None")
			executeSQLQuery("INSERT INTO eventMarkers (id, owner) VALUES (?,?)", 5, "None")
		else
			executeSQLQuery("UPDATE eventMarkers SET owner=?", "none")
		end
		setElementData(marker, "id", k)
	end
end
addEventHandler("onResourceStart", resourceRoot, onResourceStart)


 local timerAntiEco = {}
function provokeMarker (p, team, marker)
		if (type(team) ~= "string") then return false end
		if (isTimer(timerAntiEco[p])) then return exports.NGCdxmsg:createNewDxMessage("You need to wait some more time to take another marker!",p,255,255,0) end
		timerAntiEco[p] = setTimer(function() killTimer(timerAntiEco[p]) end, 1000*40, 1)
		if (team == "Criminals") then
			local mr, mg, mb, ma = getMarkerColor(marker)
			if (mr == 255) and (mg == 0) and (mb == 0) and (ma == 255) then return false end
			executeSQLQuery("UPDATE eventMarkers SET owner=? WHERE id=?", "crim",getElementData(marker, "id"))
			setMarkerColor(marker, 255, 0, 0, 255)
			setBlipColor(blips[marker], 255, 0, 0, 255)
			setBlipVisibleDistance(blips[marker], 1200)
			--setElementData(marker, "AURcityevent.team", "Criminals")
			exports.NGCdxmsg:createNewDxMessage("Criminals have captured a marker in the city!",root,255,0,0)
			--if (getElementData(marker, "AURcityevent.team") ~= "Criminals") then
				for k,v in ipairs (getPlayersInTeam(getTeamFromName("Criminals"))) do
					if (isElementWithinColShape(v, cityCol)) then
						exports.csgdrugs:giveDrug(v, "LSD",50)
						exports.csgdrugs:giveDrug(v, "Cocaine",50)
						exports.csgdrugs:giveDrug(v, "Heroine",50)
						exports.csgdrugs:giveDrug(v, "Ritalin",50)
						exports.csgdrugs:giveDrug(v, "Ecstasy",50)
						exports.csgdrugs:giveDrug(v, "Weed",50)
						exports.AURpayments:addMoney(v, 4000,"Custom","CTC",0,"AURcityevent")
						exports.server:givePlayerWantedPoints(v,10)
						exports.NGCdxmsg:createNewDxMessage("You captured a marker, and recieved $4,000!",v,255,255,0)
						exports.NGCdxmsg:createNewDxMessage("You captured a marker, and got 50 hit each drug!",v,255,255,0)
					end
				--end
			end
		elseif (team == "Government") or (team == "Military Forces") or (team == "SWAT Team") then
			local mr, mg, mb, ma = getMarkerColor(marker)
			if (mr == 0) and (mg == 0) and (mb == 255) and (ma == 150) then return false end
			executeSQLQuery("UPDATE eventMarkers SET owner=? WHERE id=?", "law", getElementData(marker, "id"))
			setMarkerColor(marker, 0, 0, 255, 150)
			setBlipColor(blips[marker], 0, 0, 255, 255)
			exports.NGCdxmsg:createNewDxMessage("Law forces have captured a marker in the city!",root,255,0,0)
			setElementData(marker, "AURcityevent.team", "Law")
			--if (getElementData(marker, "AURcityevent.team") ~= "Law") then
				for k,v in ipairs (getElementsByType("player")) do
					if not (v) then return erro("the bug is from player") end
					if getPlayerTeam(v) then
					local team = getTeamName(getPlayerTeam(v))
					if (team == "Government") or (team == "Military Forces") or (team == "SWAT Team") then
						if (isElementWithinColShape(v, cityCol)) then
							exports.AURpayments:addMoney(v, 6000,"Custom","CTC",0,"AURcityevent")
							setPedArmor(v, tonumber(getPedArmor(v)+10))
							exports.NGCdxmsg:createNewDxMessage("You have captured a marker, and recieved $6,000!",v,255,255,0)
							exports.NGCdxmsg:createNewDxMessage("You have captured a marker, and got 10% Armor!",v,255,255,0)
						end
					end
					end
				--end
			end
		end
end

function checkerForStates ()

	--Updates the color.
	local copMarkers = executeSQLQuery("SELECT * FROM eventMarkers WHERE owner=?", "law")
	local crimMarkers = executeSQLQuery("SELECT * FROM eventMarkers WHERE owner=?", "crim")
	if (#copMarkers > #crimMarkers) and (#crimMarkers ~= 0) or (#copMarkers == 3) or (#copMarkers == 4) then
		setRadarAreaColor(cityArea, 0,0,255,180)
		setRadarAreaFlashing(cityArea, true)
		ownedByCops = false
		ownedByCrims = false
	elseif (#crimMarkers > #copMarkers) and (#copMarkers ~= 0) or (#crimMarkers == 3) or (#crimMarkers == 4) then
		setRadarAreaColor(cityArea, 255,0,0,180)
		setRadarAreaFlashing(cityArea, true)
		ownedByCops = false
		ownedByCrims = false
	elseif (#copMarkers == 5) then
		setRadarAreaColor(cityArea, 0,0,255,180)
		setRadarAreaFlashing(cityArea, false)
		ownedByCops = true
		ownedByCrims = false
	elseif (#crimMarkers == 5) then
		setRadarAreaColor(cityArea, 255,0,0,180)
		setRadarAreaFlashing(cityArea, false)
		ownedByCrims = true
		ownedByCops = false
	elseif (#crimMarkers == 0) and (#copMarkers == 0) then
		setRadarAreaColor(cityArea,255,255,255,180)
		setRadarAreaFlashing(cityArea, false)
		ownedByCops = false
		ownedByCrims = false
	end

	for k,v in ipairs (getElementsByType"player") do
		if (doesPedHaveJetPack(v)) and (isElementWithinColShape(v, cityCol)) then
			removePedJetPack(v)
			exports.NGCdxmsg:createNewDxMessage("Not allowed to use jetpack in the city!",v,255,255,0)
		end
	end
end
setTimer(checkerForStates, 500,0)

function isPlayerLaw (player)
	if getPlayerTeam(player) then
	local team = getTeamName(getPlayerTeam(player))
	if (type(team) ~= "string") then return false end
	if not (team) then return error("Team error") end
	if (team == "Government") or (team == "Military Forces") or (team == "SWAT Team") then
		return true
	else
		return false
	end
	else
		return false
	end
end


function onMarkerHit(hitElement, dim)
	if hitElement then
	if getElementType(hitElement) == "player" then
		if (not getPlayerTeam(hitElement)) then return end
		if not (dim) then return false end
		if not (eventMarkers[source]) then return false end
		if getPlayerTeam(hitElement) then
		local team = getTeamName(getPlayerTeam(hitElement))
		if (type(team) ~= "string") then return false end
		if (getElementData(source, "owner") == team) then return false end
		playersInMarker = playersInMarker + 1
		--if (playersInMarker > 1) then return exports.NGCdxmsg:createNewDxMessage("Only 1 player can capture the marker!", hitElement, 255,0,0) end
		timers[hitElement] = setTimer(provokeMarker, 1000*6, 1, hitElement, getTeamName(getPlayerTeam(hitElement)), source)
		setElementData(hitElement, "isPlayerCTC", true)
		end
	end
	end
end
addEventHandler("onMarkerHit", root, onMarkerHit)

function checkAFKPlayers()
    for index, thePlayer in ipairs(getElementsByType("player"))do
        if (getPlayerIdleTime(thePlayer) > 180000) then
            if (getElementData(thePlayer, "isPlayerCTC") == true) then 
				exports.NGCdxmsg:createNewDxMessage(thePlayer, exports.AURlanguage:getTranslate("You have been killed for being Away From Keyboard while capturing the city.", true, thePlayer),255,0,0)
				killPed(thePlayer)
			end 
        end
    end
end
setTimer(checkAFKPlayers, 10000, 0)

function onMarkerLeave (leftElement, dim)
	if hitElement then
	if getElementType(hitElement) == "player" then
	setElementData(leftElement, "isPlayerCTC", false)
    if not (dim) then return false end
    if not (eventMarkers[source]) then return false end
    playersInMarker = playersInMarker - 1
    if (isTimer(timers[leftElement])) then
        killTimer(timers[leftElement])
    end
    end
    end
end
addEventHandler("onMarkerLeave", root, onMarkerLeave)


function killAddOns ( ammo, attacker, weapon, bodypart )

	if (isElementWithinColShape ( source, cityCol )) and (isElementWithinColShape ( attacker, cityCol )) then
		if getPlayerTeam(source) then
		if (getTeamName(getPlayerTeam(source)) == "Criminals") and (isPlayerLaw(attacker)) then
			exports.AURpayments:addMoney(attacker, 2000,"Custom","CTC",0,"AURcityevent")
			exports.NGCdxmsg:createNewDxMessage("You have recieved $1,000 for defending the city!",attacker, 255,255,0)
			if (capturedByCrims) then
				setTimer(setElementPosition,1000*6,1,source,3531.14, -1944.29, 19.7)
			end
		elseif 	(getTeamName(getPlayerTeam(attacker)) == "Criminals") and (isPlayerLaw(source)) then
			exports.AURpayments:addMoney(attacker, 2000,"Custom","CTC",0,"AURcityevent")
			exports.NGCdxmsg:createNewDxMessage("You have recieved $1,000 for attacking the city!",attacker, 255,255,0)
			if (capturedByCops) then
				setTimer(setElementPosition,1000*6,1,source,3531.14, -1944.29, 19.7)
			end
		end
		end
	end
end
addEventHandler("onPlayerWasted", root, killAddOns)

function payout ()

	local playersIngame = getElementsByType"player"
	if (#playersIngame > 10) then
		if (ownedByCops == true) then
			for k,v in ipairs (getPlayersInTeam(getTeamFromName"Government")) do
				exports.AURpayments:addMoney(v, 50000,"Custom","CTC",0,"AURcityevent")
				exports.NGCdxmsg:createNewDxMessage("You have recieved $50,000 for keeping the city out of threat!",v,255,255,0)
			end
			for k,v in ipairs (getPlayersInTeam(getTeamFromName"SWAT Team")) do
				exports.AURpayments:addMoney(v, 50000,"Custom","CTC",0,"AURcityevent")
				exports.NGCdxmsg:createNewDxMessage("You have recieved $50,000 for keeping the city out of threat!",v,255,255,0)
			end
			for k,v in ipairs (getPlayersInTeam(getTeamFromName"Military Forces")) do
				exports.AURpayments:addMoney(v, 50000,"Custom","CTC",0,"AURcityevent")
				exports.NGCdxmsg:createNewDxMessage("You have recieved $50,000 for keeping the city out of threat!",v,255,255,0)
			end
		elseif (ownedByCrims == true) then
			for k,v in ipairs (getPlayersInTeam(getTeamFromName"Criminals")) do
				exports.AURpayments:addMoney(v, 50000,"Custom","CTC",0,"AURcityevent")
				exports.NGCdxmsg:createNewDxMessage("You have recieved $50,000 for keeping the city in threat!",v,255,255,0)
			end
		end
	end
end
setTimer(payout, 1000*60*10,0)


function weaponsRestriction ()

	if (getElementType(source) ~= "player") then return false end
	local notAllowed = {

		[3] = true,
		[23] = true,

	}
	if (isElementWithinColShape(source, cityCol)) then
		local currentID = getPedWeapon(source)
		if (notAllowed[currentID]) then
			cancelEvent()
			toggleControl ( source, 'fire', false )
		else
			toggleControl ( source, 'fire', true )
		end
	end
end
addEventHandler("onWeaponFire", root, weaponsRestriction)

function setCityForCrims (p, cmd)

	if (getPlayerName(p) ~= "[AUR]Nixon-") then return false end
	executeSQLQuery("UPDATE eventMarkers SET owner=?", "crim")
	ownedByCrims = true
	ownedByCops = false
	for k,v in ipairs (getElementsByType"marker") do
		if (getElementData(v, "AURcityevent.eventMarker") == true) then
			setMarkerColor(v, 255,0,0,255)
			setBlipColor(blips[v], 255,0,0,255)
		end
	end

end
addCommandHandler("setforcrims", setCityForCrims)

function setCityForCops (p, cmd)

	if (getPlayerName(p) ~= "[AUR]Nixon-") then return false end
	executeSQLQuery("UPDATE eventMarkers SET owner=?", "law")
	ownedByCrims = false
	ownedByCops = true
	for k,v in ipairs (getElementsByType"marker") do
		if (getElementData(v, "AURcityevent.eventMarker") == true) then
			setMarkerColor(v, 0,0,255,255)
			setBlipColor(blips[v], 0,0,255,255)
		end
	end

end
addCommandHandler("setforcops", setCityForCops)
