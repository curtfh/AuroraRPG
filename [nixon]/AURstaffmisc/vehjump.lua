function jump()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local team = getPlayerTeam(localPlayer)
	if ( isElement(vehicle) ) and (isVehicleOnGround( vehicle )) and ( getTeamName(team) ) and ( getTeamName(team) == "Staff" ) then
		local sx,sy,sz = getElementVelocity ( vehicle )
		setElementVelocity( vehicle ,sx, sy, sz+1.0)
	end
end
bindKey ( "lshift","down", jump)
