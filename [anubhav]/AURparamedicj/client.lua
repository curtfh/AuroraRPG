local medicTeam = getTeamFromName("Paramedics")
local isHealing = nil
local attacker = nil
local newHealing = nil

function medicSprayCan(a, weapon)
	if (not isElement(a)) then
		return false 
	end
	if (getElementType(a) ~= "player") then
		return false 
	end
	if (getPlayerTeam(a) ~= medicTeam) then
		return false 
	end
	if (a == localPlayer) then
		return false 
	end
	if (weapon ~= 41) then
		return false
	end
	if (attacker) then
		if (attacker ~= a) then
			return false 
		end
	end
	if (not isHealing) then
		addEventHandler("onClientRender", root, sendTriggers)
		isHealing = getTickCount()
	end
	newHealing = getTickCount()
	attacker = a
end
addEvent("onClientSpraycan", true)
addEventHandler("onClientSpraycan", localPlayer, medicSprayCan)

function sendTriggers()
	if (isHealing) then
		if (getTickCount() - newHealing > 2000) then
			triggerServerEvent("AURparamedicj.healP", resourceRoot, attacker, localPlayer, getTickCount() - isHealing)
			isHealing = nil 
			removeEventHandler("onClientRender", root, sendTriggers)
			return true 
		end
	end
end
