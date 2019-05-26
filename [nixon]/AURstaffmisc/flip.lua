addCommandHandler( "flip",
	function ()
		if ( getTeamName( getPlayerTeam( localPlayer ) ) ~= "Staff" ) then return false end	
		local vehicle = getPedOccupiedVehicle( localPlayer )
		if vehicle then
			local rX, rY, rZ = getElementRotation( vehicle )
			setElementRotation( vehicle, 0, 0, ( rX > 90 and rX < 270 ) and ( rZ + 180 ) or rZ )
		end
	end
)
