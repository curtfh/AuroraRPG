

local timing = {}
function aimwanted (player)
	local target = getPedTarget(localPlayer)
	if (exports.server:getPlayChatZone(target) ~= "LV") then
	if ((source.team.name == "Criminals")) or ((source.team.name == "HolyCrap")) then
	if (getControlState("aim_weapon")) then
	if (exports.server:getPlayerWantedPoints( localPlayer ) >= 10) then return end
	if (target and isElement(target) and target.type == "player") then
	if (target.team.name == "Government" or target.team.name == getFirstLaw() or target.team.name == "GIGN") then
	exports.server:givePlayerWantedPoints(localPlayer,10)
	exports.NGCdxmsg:createNewDxMessage("You've gained wanted points for trying to kill cops",255,0,0)
	end
	   end
	end
     end
  end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), aimwanted )
--[[
setTimer(function()
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) ~= "Staff" then
		if isElementInWater(localPlayer) and not isPedInVehicle(localPlayer) and getPedOxygenLevel ( localPlayer ) <= 1 then
			setElementHealth(localPlayer,getElementHealth(localPlayer)-5)
		end
	end
end,5000,0)]]
