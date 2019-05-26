local turf = {}
local timer = {}
local turfName = {}
local isSomebodyInTurf = {}
local capture = {}
local radar = {}
local turfOwner = {}

local theTurfs = {
	{-2136.6923828125, 124.04737854004, 120, 190, "Abandoned Doherty Property"},
	{-2158.4782714844, 39.465198516846, 45, 60, "Doherty 2 Property"},
	{-2159.1694335938, -59.934680938721, 65, 80, "Doherty 3 Property"},
	{-2078.9118652344, -61.692092895508, 65, 80, "Doherty 4 Property"},
	{-1980.1123046875, 103.94956970215, 65, 80, "Cranberry Station"},
	{-2368.6315917969, 516.88073730469, 130, 40, "Queens Property"},
	{-2243.6130371094, 575.57543945313, 90, 140, "Chinatown"},
	{-1838.4229736328, 509.17230224609, 90, 90, "One Tower"},
}

function createTurfs()
	for index, ent in pairs(theTurfs) do
		local area = createColRectangle(ent[1], ent[2], ent[3], ent[4])
		local r = createRadarArea(ent[1], ent[2], ent[3], ent[4], 255, 255, 255, 170)
		radar[area] = r
		turf[area] = ent[5]
		turfName[area] = ent[5]
	end
end
addEventHandler("onResourceStart", resourceRoot, createTurfs)

function enterTurf(player, matchingDimension)
	if (player and isElement(player) and getElementType(player) == "player" and matchingDimension) then
		local group = getElementData(player, "Group")
		if (turf[source]) then
			if (not group) then
				exports.NGCdxmsg:createNewDxMessage("To take over this property. You must have a Civilian Group.", player, 200, 0, 0)
				return
			end
			if (getTeamName(getPlayerTeam(player)) ~= "Civilian Workers") then 
				exports.NGCdxmsg:createNewDxMessage("You must be a civilian to take over this property.", player, 200, 0, 0)
				return 
			end
			if (isRadarAreaFlashing(radar[source])) then return end
			if (turfOwner[source]) then
				if (turfOwner[source] == group) then
					exports.NGCdxmsg:createNewDxMessage("This property is already owned by "..group, player, 0, 200, 0)
					return
				end
				for i, ent in pairs(getElementsByType("player")) do
					local g2 = getElementData(ent, "Group")
					if (g2 and g2 ~= group) then
						exports.NGCdxmsg:createNewDxMessage(group.." is trying to take over your property "..turfName[source]..".", ent, 200, 0, 0)
					end
				end
				capture[group] = setTimer(captureTurf, 240000, 1, group, source)
				triggerClientEvent(player, "AURpropertytakeover.drawCounter", player, 240)
				timer[group] = setTimer(nobodyInTurf, 240000, 0, group, source)
				setRadarAreaFlashing(radar[source], true)
			else
				setRadarAreaFlashing(radar[source], true)
				capture[group] = setTimer(captureTurf, 120000, 1, group, source)
				triggerClientEvent(player, "AURpropertytakeover.drawCounter", player, 120)
				timer[group] = setTimer(nobodyInTurf, 120000, 0, group, source)
			end
			exports.NGCdxmsg:createNewDxMessage("You have entered a property named "..turfName[source]..". Claim the property and you'll earn money.", player, 200, 200, 0)
		end
	end
end
addEventHandler("onColShapeHit", root, enterTurf)

function nobodyInTurf(group, turfElement)	
	if (group and turfElement) then
		for index, ent in pairs(getElementsByType("player")) do
			local g2 = getElementData(ent, "Group")
			if (isElementWithinColShape(ent, turfElement) and g2 == group) then
				isSomebodyInTurf[group] = true
			elseif (not isElementWithinColShape(ent, turfElement) and g2 == group) then
				isSomebodyInTurf[group] = false
			end
		end
		if (not isSomebodyInTurf[group]) then
			if (capture[group] and isTimer(capture[group])) then
				killTimer(capture[group])
				if (isTimer(timer[group])) then
					killTimer(timer[group])
				end
				for index, ent in pairs(getElementsByType("player")) do
					local g2 = getElementData(ent, "Group")
					if (g2 and g2 == group) then
						capture[group] = false
						timer[group] = false
						setRadarAreaFlashing(radar[turfElement], false)
						triggerClientEvent(ent, "AURpropertytakeover.removeCounter", ent)
						exports.NGCdxmsg:createNewDxMessage("Your civilian group failed to take over the property named "..turfName[turfElement], ent, 200, 0, 0)
					end
				end
			end
		end
	end
end

function captureTurf(group, element)
	if (group and element) then
		setRadarAreaFlashing(radar[element], false)
		if (capture[group] and isTimer(capture[group])) then
			killTimer(capture[group])
		end
		if (isTimer(timer[group])) then
			killTimer(timer[group])
		end
		local count = 0
		for index, ent in pairs(getElementsByType("player")) do
			local g2 = getElementData(ent, "Group")
			if (g2 and g2 == group) then
				if (isElementWithinColShape(ent, element)) then
					if (isPedInVehicle(ent)) then return end
					local count = count + 1
					local countMoney = 300 * count
					local final = 3500 + countMoney
					local final = math.floor(final)
					exports.NGCdxmsg:createNewDxMessage("Congratulations you take over this property and made $"..final, ent, 200, 0, 0)
					exports.AURsamgroups:addXP(ent,2)
					exports.CSGscore:givePlayerScore(ent,1)
					exports.AURpayments:addMoney(ent,final,"Custom","Groups Turfing",0,"AURpropertytakeover")
				end
				local r, g, b = exports.AURsamgroups:getGroupColor(group)
				setRadarAreaColor(radar[element], r or 0, g or 255, b or 0, 150)
				exports.NGCdxmsg:createNewDxMessage("Your civilian group succesfully take over the property name "..turfName[element], ent, 200, 0, 0)
				turfOwner[element] = group
				triggerClientEvent(ent, "AURpropertytakeover.removeCounter", ent)
			end
		end
	end
end