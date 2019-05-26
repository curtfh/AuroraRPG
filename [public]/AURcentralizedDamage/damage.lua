lawTeams = {
	['GIGN']=true,
	['SSG']=true,
	["Military Forces"]=true,
	["Government"]=true,
}

crimTeams = {
	['Criminals'] = true,
	['HolyCrap']=true,
}

damageDisabledDimensions = {
	[5001] = true,
	[5002] = true,
	[5004] = true,
	[5006] = true,
}

setElementData(localPlayer, "ldt", 0)

local _cancelEvent = cancelEvent
damageDebugger = false

local function cancelEvent(cancel, reason, source, attacker, loss, weapon)
	_cancelEvent(cancel, reason)
	if (damageDebugger) then
		if (attacker and getElementType(attacker) ~= "player") then
			attacker = false
		end
		outputChatBox("DMG-CANCEL A: "..(attacker and getPlayerName(attacker) or "Unknown Attacker").." S: "..(source and getPlayerName(source) or "Unknown Source").. ": "..reason.." ("..math.floor(loss)..") ".."("..tostring(weapon)..")")
	end
end

function damageDebug()
	damageDebugger = not damageDebugger
	outputChatBox("damageDebugger: ".. tostring(damageDebugger))
end
addCommandHandler("damagedebug", damageDebug)

function handlePlayerDamage(attacker, weapon, bodypart, loss)
	local dimension = getElementDimension(source)
	local sourceTeam = getTeamName(getPlayerTeam(source))
	local sourceOccupation = getElementData(source, "Occupation")
	local chatzone = getElementData(source, "City")
	local sourceAccountID = getElementData(source, "accountUserID")
	if (not sourceAccountID) then
		cancelEvent(true, "Player has not logged in yet", source, attacker, loss, weapon)
		return false
	end
	local attackerType = (attacker and getElementType(attacker) or "")
	local interior = getElementInterior(source)
	local safezone = exports.NGCsafeZone:isElementWithinSafeZone(source)
	local sourceWanted = getElementData(source, "wantedPoints") or 0
	local plrRank = getElementData(source, "Rank")
	local attackerTeam = (attackerType == "player" and getTeamName(getPlayerTeam(attacker)) or "")
	local newLoss = loss
	if (damageDisabledDimensions[dimension]) then
		cancelEvent(true, "Damage is disabled in this dimension", source, attacker, loss, weapon)
		return false
	end
	if (dimension >= sourceAccountID) then
		cancelEvent(true, "Player is in AFK dimension", source, attacker, loss, weapon)
		return false
	end
	if (dimension == 10 and interior == 2) then
		cancelEvent(true, "Drug interior?", source, attacker, loss, weapon)
		return false
	end
	if (attackerType ~= "") then
		if (dimension ~= getElementDimension(attacker)) then
			cancelEvent(true, "Different dimensions - ghost dimensions", source, attacker, loss, weapon)
			return false
		end
	end
	if (attackerType == "player" and source ~= attacker) then
		local attackerWanted = getElementData(attacker, "wantedPoints") or 0
		local attackerOccupation = getElementData(attacker, "Occupation")
		if (dimension == 5006) then
			if (getElementData(attacker, "Team") == getElementData(source, "Team")) then
				cancelEvent(true, "CSGO event", source, attacker, loss, weapon)
				return false
			end
		end
		if (attackerTeam == "Criminals" and sourceTeam == "Criminals" and chatzone == "LV" and getElementData(attacker, "isPlayerProtectedTeamRTCriminal")) then
			cancelEvent(true, "RT Protection: Criminals", source, attacker, loss, weapon)
			return false
		end
		if (chatzone ~= "LV" and sourceTeam == attackerTeam and dimension == 0) then
			cancelEvent(true, "Team damage protection", source, attacker, loss, weapon)
			return false
		end
		if (weapon == 41) then
			triggerEvent("onClientSpraycan", source, attacker, weapon, bodypart, 0)
			cancelEvent(true, "Spraycan no dmg", source, attacker, loss, weapon)
			return false
		end
		if (chatzone ~= "LV" and (attackerTeam == "Unoccupied" or attackerTeam == "Civilian Workers" or attackerTeam == "Unemployed" or attackerTeam == "Paramedics")) then
			cancelEvent(true, "Civilians cannot damage", source, attacker, loss, weapon)
			return false
		end
		if (chatzone ~= "LV" and (sourceTeam == "Unoccupied" or sourceTeam == "Paramedics" or sourceTeam == "Civilian Workers" or sourceTeam == "Unemployed")) then
			cancelEvent(true, "Civilians cannot take damage", source, attacker, loss, weapon)
			return false
		end
		if ((attackerTeam == "Government" and getElementData(attacker, "StopDeathmatching")) or (getElementData(attacker, "StopDeathmatching") and getElementData(source, "StopDeathmatching") and attacker ~= source)) then
			cancelEvent(true, "Cops end shift fix", source, attacker, loss, weapon)
			return false
		end
		if ((weapon >= 22 and weapon <= 34 or weapon == 38)) then
		    local haX, haY, haZ = getPedBonePosition(attacker, 6)
		    local hsX, hsY, hsZ = getPedBonePosition(source, 6)
		    if (not isLineOfSightClear(haX, haY, haZ, hsX, hsY, hsZ, true, false, false, true, false, false, false, attacker)) then
		        local bsX, bsY, bsZ = getPedBonePosition(source, 3)
		        if (not isLineOfSightClear(haX, haY, haZ, bsX, bsY, bsZ, true, false, false, true, false, false, false, attacker)) then
		            cancelEvent(true, "Shot through wall", source, attacker, loss, weapon)
		            return false
		        end
		    end
		end
		if (attackerTeam == "Government" and (weapon == 3 or weapon == 23)) then
			if (weapon == 3 and localPlayer == source) then
				triggerServerEvent("NoticeCop", getResourceRootElement(getResourceFromName("DENlaw")), attacker, weapon, bodypart, loss)
			elseif (weapon == 23 and localPlayer == source) then
				triggerEvent("onClientPlayerTaze", source, attacker, weapon, bodypart, loss)
			end
			cancelEvent(true, "Cops cannot damage with nightstick/tazer", source, attacker, loss, weapon)
			return false
		end
		if (getElementData(source, "isPlayerRobbing") or getElementData(source, "isPlayerAttemptToRob")) then
			if (sourceTeam == "Paramedics" or attackerType == "Paramedics" or (sourceTeam == "Criminals" and attackerTeam == "Criminals") or (sourceTeam == "Government" or attackerTeam == "Government")) then
				cancelEvent(true, "BR event", source, attacker, loss, weapon)
				return false
			end
		end
		if (safezone) then
			if (attackerTeam ~= "Staff" and sourceWanted < 10) then
				cancelEvent(true, "Player is in protected zone", source, attacker, loss, weapon)
				return false
			end
			if (attackerTeam ~= "Staff" and sourceWanted > 10 and weapon ~= 3) then
				cancelEvent(true, "Player is in protected zone", source, attacker, loss, weapon)
				return false
			end
		end
		if (chatzone ~= "LV" and (attackerTeam == "Government" and sourceTeam == "Criminals" and sourceWanted < 10)) then
			cancelEvent(true, "Gov attacking unwanted crim", source, attacker, loss, weapon)
			return false
		end
		if (chatzone ~= "LV" and (attackerTeam == "Criminals" and sourceTeam == "Government" and attackerWanted < 10)) then
			cancelEvent(true, "Unwanted crim attacking cop", source, attacker, loss, weapon)
			return false
		end
		if (plrRank == "Gas Mask" and (weapon == 17 or weapon == 42)) then
			cancelEvent(true, "Gas mask", source, attacker, loss, weapon)
			return false
		end
		if (plrRank == "Butcher" and weapon < 0 and weapon > 10) then
			newLoss = newLoss + 0.25
		end
		if (plrRank == "Assassin" and bodypart == 9 and (wep == 33 or wep == 34)) then
			newLoss = 200
		end
		if (attackerTeam == "Government" and sourceTeam ~= "Government") then
			if (weapon >= 35 and weapon <= 39) or (weapon >= 16 and weapon <= 18) then
				if (plrRank == "Bomb Squad") then
					newLoss = newLoss * 0.75
				elseif (plrRank == "Explosives Unit") then
					newLoss = newLoss * 1.25
				end
			end
		end
		if (dimension == 1001) then
			if (getElementData(source, "CS:GO") or getElementData(source, "isPlayerInLobby")) then
				if (getElementData(source, "CS:GO Team") == getElementData(attacker, "CS:GO Team")) then
					cancelEvent(true, "Same CSGO team", source, attacker, loss, weapon)
					return true
				end
			end
		end
	end
	if (attackerType == "vehicle" and chatzone ~= "LV" and sourceWanted < 10) then
		attacker = getVehicleController(attacker)
		cancelEvent(true, "Vehicle dmg", source, attacker, loss, weapon)
		return true
	end
	if (getElementData(source, "isPlayerArrested")) then
		cancelEvent(true, "Source is arrested", source, attacker, loss, weapon)
		return true
	end
	if (getElementData(source, "isPlayerJailed")) then
		cancelEvent(true, "Source is jailed", source, attacker, loss, weapon)
		return true
	end
	if (getElementData(source, "abseiling") ~= "") then
		cancelEvent(true, "Player is heli-dropping", source, attacker, loss, weapon)
		return true
	end
	if (getElementData(root, "eventDamageToggle") and getElementData(source, "isPlayerInEvent") and (attackerTeam and attackerTeam ~= "Staff" or true)) then
		cancelEvent(true, "Player is in event", source, attacker, loss, weapon)
		return true
	end
	if (getElementData(source, "superman:flying")) then
		cancelEvent(true, "Supermannnnn", source, attacker, loss, weapon)
		return true
	end
	if (getElementAlpha(source) <= 200 and not exports.AURaghost:isPlayerInGhostMode(source)) then
		cancelEvent(true, "Ghost mode", source, attacker, loss, weapon)
		return true
	end
	if (sourceTeam == "Staff") then
		if (attacker and attacker ~= source and attackerTeam ~= "Staff") then
			setElementHealth(attacker, getElementHealth(attacker) - loss)
		end
		cancelEvent(true, "Staff member", source, attacker, loss, weapon)
		return true
	end
	if (weapon == 54 and getElementData(localPlayer, "onrope")) then
		cancelEvent(true, "Dropping from heli", source, attacker, loss, weapon)
		return true
	end
	setElementData(source, "ldt", getTickCount())
	triggerEvent("onClientLocalPlayerDamage", source, attacker, weapon, bodypart, newLoss)
	if (damageDebugger and (localPlayer == source or localPlayer == attacker)) then
		outputChatBox("DMG-DBG A: "..(attackerType == "player" and getPlayerName(attacker) or attacker).." S: "..getPlayerName(source).. ": ("..math.floor(newLoss)..") ".."("..tostring(weapon)..")")
	end
	if (loss ~= newLoss) then
		setElementHealth(source, getElementHealth(source) + (loss - newLoss))
	end
end
addEventHandler("onClientPlayerDamage", root, handlePlayerDamage)