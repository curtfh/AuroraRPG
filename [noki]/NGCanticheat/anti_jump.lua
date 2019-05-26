function setJumpState( state )
	toggleControl( "jump", state )
end

------------------------------------------------

function disableJump()
	if ( getElementInterior( localPlayer ) == 7 ) or ( getElementInterior( localPlayer ) == 4 ) or ( getElementInterior( localPlayer ) == 0 ) then
		if ( getElementDimension( localPlayer ) == 0 ) and ( getElementInterior( localPlayer ) == 0 ) then -- if they are in the main part
			setJumpState( true )
		elseif ( getElementDimension( localPlayer ) == 2 ) and ( getElementInterior( localPlayer ) == 0 ) then  -- if they are in jail
			setJumpState( false )
		elseif ( getElementDimension( localPlayer) == 1 ) or ( getElementDimension( localPlayer ) == 5 ) then
			setJumpState( false )
		end
	end
end
setTimer( disableJump, 2500, 0 )