function isLaw (plr)

	if (getTeamName(getPlayerTeam(plr)) == "Government") or (getTeamName(getPlayerTeam(plr)) == "Advanced Assault Forces") then
		return true
	else
		return false
	end
end

function cancelDamageForCops (attacker)

	if (isElement(attacker)) and (isElement(source)) then
		if (getElementType(attacker) == "player") and (getElementType(source) == "player") then
			if (isLaw(source)) and (isLaw(attacker)) then
				cancelEvent()
			end
		end
	end
end
addEventHandler("onClientPlayerDamage", getLocalPlayer(), cancelDamageForCops)