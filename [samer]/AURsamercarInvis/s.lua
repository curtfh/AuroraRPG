function goInvis(p, cmd)
	local veh = getPedOccupiedVehicle(p)
	if (getTeamName(getPlayerTeam(p)) == "Staff") and p then
		local alp = getElementAlpha(veh)
		if (alp == 0) then
			setElementAlpha(veh, 255)
		else
			setElementAlpha(veh, 0)
		end
	end
end
addCommandHandler("vehinvis", goInvis)
